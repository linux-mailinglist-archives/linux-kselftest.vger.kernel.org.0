Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A0A6D9BE6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbjDFPOb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237840AbjDFPOa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 11:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9A319F;
        Thu,  6 Apr 2023 08:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D77EC643F1;
        Thu,  6 Apr 2023 15:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F85C433EF;
        Thu,  6 Apr 2023 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680794038;
        bh=mTtbRnkeMKTbF2q4A4f9Ak2ifsvNdnsM0H92Nh3Qxmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IshdjaxEfBw6XI54sB39NmKjwTpyvFhda4R5a9R4WhEJrRKbOcuMkJVaX6Os+K1S1
         eCX/ECIQApw4njlgkWg8ELz5eoOG0qDBOKGbBHKOUssHQGSqyTLV+onmg3gniruIEf
         A4nNzd/MB6lr0oa+WsKQTLnLfv2iosl2w8rH32uW6vvRf/Oz1Va3inJDArw2RQrd+B
         5kQ6FrfUv6pi+KGS5Y4MDqjLZ0YdqcmqrruWQ908FkxoTYEEd9HzAkJpsbxaCCoAiI
         xgkKdaGTXkD9uuYWC1nmP1kytL7y0ZW+M0fW3wG4Nd0SNLJEuS430SD6Xi6tK0jvD2
         gzG5nGQRXtixQ==
Date:   Thu, 6 Apr 2023 17:13:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <ZC7hsjyGc+0DP2D0@localhost.localdomain>
References: <20230316123028.2890338-1-elver@google.com>
 <CANpmjNOwo=4_VpUs1PYajtxb8gvt3hyhgwc-Bk9RN4VgupZCyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNOwo=4_VpUs1PYajtxb8gvt3hyhgwc-Bk9RN4VgupZCyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Le Thu, Apr 06, 2023 at 04:12:04PM +0200, Marco Elver a écrit :
> On Thu, 16 Mar 2023 at 13:31, Marco Elver <elver@google.com> wrote:
> One last semi-gentle ping. ;-)
> 
> 1. We're seeing that in some applications that use POSIX timers
> heavily, but where the main thread is mostly idle, the main thread
> receives a disproportional amount of the signals along with being
> woken up constantly. This is bad, because the main thread usually
> waits with the help of a futex or really long sleeps. Now the main
> thread will steal time (to go back to sleep) from another thread that
> could have instead just proceeded with whatever it was doing.
> 
> 2. Delivering signals to random threads is currently way too
> expensive. We need to resort to this crazy algorithm: 1) receive timer
> signal, 2) check if main thread, 3) if main thread (which is likely),
> pick a random thread and do tgkill. To find a random thread, iterate
> /proc/self/task, but that's just abysmal for various reasons. Other
> alternatives, like inherited task clock perf events are too expensive
> as soon as we need to enable/disable the timers (does IPIs), and
> maintaining O(#threads) timers is just as horrible.
> 
> This patch solves both the above issues.
> 
> We acknowledge the unfortunate situation of attributing this patch to
> one clear subsystem and owner: it straddles into signal delivery and
> POSIX timers territory, and perhaps some scheduling. The patch itself
> only touches kernel/signal.c.
> 
> If anyone has serious objections, please shout (soon'ish). Given the
> patch has been reviewed by Oleg, and scrutinized by Dmitry and myself,
> presumably we need to find a tree that currently takes kernel/signal.c
> patches?
> 
> Thanks!

Thanks for the reminder!

In the very unlikely case Thomas ignores this before the next merge window,
I'll tentatively do a pull request to Linus.

Thanks.

> 
> -- Marco
