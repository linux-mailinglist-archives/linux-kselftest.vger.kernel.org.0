Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D494B0FD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 15:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242663AbiBJOKs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 09:10:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiBJOKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 09:10:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842E6C1;
        Thu, 10 Feb 2022 06:10:49 -0800 (PST)
Date:   Thu, 10 Feb 2022 15:10:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644502245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArpvzwkGnDQKxtTFeON+tFkMUEdTNt7GTidDmksvVqk=;
        b=dTZON6iYkIuWwRl1lbQLFWgEZpP+relHqzrQaqVXmgaAAnlz6fCpdlUNoGQQqBQBKhZGhC
        gdm6x1n3GF9RvcjVHsB9CLZv1cT8B5PRT2JcmDFdCTA3CVzbC7i9j/bvSRFr5m0C1sUyk0
        /trehc+zEt5N0/wMz8ipE0e3MFiwTIioNxavfurJyIreA9yNxnfKfFobVkd5K7iJ0FEYfw
        +m9tTogAu0WOylNM6HtwOjkDF+Ujuv6aNEeukXbOM99Qoae/cpW4Nk9x8OHXx/H9C3eKwv
        w6d7m9CIF8YVvTkBpn5GqPvwzMkywTEmCTDkJ437CjYjnnm8T+n1bYniOtaT9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644502245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArpvzwkGnDQKxtTFeON+tFkMUEdTNt7GTidDmksvVqk=;
        b=Yg3c7xjjfSPf0kXW6h7g7uvpmSsjjtBx2PjnJpVlT3lEEeuaiBR7LyM05efVJu2PNN5gjG
        GjG26g5xsoLSkbAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Message-ID: <YgUc5HxfIdJ0Z5AN@linutronix.de>
References: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
 <YgUXcGC1mH7VX1d9@linutronix.de>
 <546f147d-1682-fb92-42e5-7247dc19dcf1@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <546f147d-1682-fb92-42e5-7247dc19dcf1@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-02-10 15:05:24 [+0100], Krzysztof Kozlowski wrote:
> On 10/02/2022 14:47, Sebastian Andrzej Siewior wrote:
> > On 2022-02-10 09:33:56 [+0100], Krzysztof Kozlowski wrote:
> >> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
> >> do_softirq fails for such kernel:
> > 
> > PREEMPT_RT does use soft IRQs.
> 
> Correct. It does not use do_softirq() code, but follows different path
> with ksoftirqd.
> Shall I rephrase it towards something like this? Or maybe you have some
> more accurate description?

It would be good to describe what the purpose of the change in terms of
the actual problem and the aimed solution.

> The implementation detail is that do_softirq() is in ifndef.

So let me ask again.  We have
   FUNC1="schedule"
   FUNC2="do_softirq"

What is the purpose of this? Do you need FUNC2 when ksoftirqd is run or
when softirqs are served? Not sure how scheduler_tick fits in all this.

> Best regards,
> Krzysztof

Sebastian
