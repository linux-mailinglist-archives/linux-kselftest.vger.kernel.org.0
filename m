Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC04B1149
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 16:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiBJPH5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 10:07:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243315AbiBJPH4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 10:07:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF51DBF;
        Thu, 10 Feb 2022 07:07:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B07961B66;
        Thu, 10 Feb 2022 15:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04E4C004E1;
        Thu, 10 Feb 2022 15:07:54 +0000 (UTC)
Date:   Thu, 10 Feb 2022 10:07:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Message-ID: <20220210100753.27248bf6@gandalf.local.home>
In-Reply-To: <YgUlybNMlpheddiD@linutronix.de>
References: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
        <YgUXcGC1mH7VX1d9@linutronix.de>
        <546f147d-1682-fb92-42e5-7247dc19dcf1@canonical.com>
        <YgUc5HxfIdJ0Z5AN@linutronix.de>
        <429dd2fd-3ceb-6780-f970-4ea9b115388c@canonical.com>
        <YgUlybNMlpheddiD@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 10 Feb 2022 15:48:41 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> After looking into the test it appears that two random functions are
> enough to be specified because the actual purpose is it to figure out if
> the function is recorded and not the actual functionality behind the
> function.

Correct. And if I ever do get a chance to revisit this test, I plan on
adding a bunch of comments to it. It's hard enough to add tests for one's
code, but even harder to document what those tests actually do ;-)

-- Steve
