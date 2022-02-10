Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257DA4B10D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 15:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbiBJOso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 09:48:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243170AbiBJOso (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 09:48:44 -0500
X-Greylist: delayed 2277 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 06:48:45 PST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6560DD1;
        Thu, 10 Feb 2022 06:48:44 -0800 (PST)
Date:   Thu, 10 Feb 2022 15:48:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644504522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcHPrvVcYs9Ty2UbZsiMplAbbgNBGYaXgB9nXMXhgG8=;
        b=ELuL39o9z+q10tH05N3Zn2zqcjfWA27lYq3JXFAdSJULZ5T7WIAKW1Pbpl+hPhRIrUdSm3
        /tBFmNcHNdCDRc+F7YpTsQgb5G2yJHfrP1XMnW38zCbZkgcDk2qLWiBfzLf6T+eVZTQVNC
        np2ysHyUzAEUSnMTvUG3dGIV8fvXR/IpTTWaADpHpJy71aalyOwUhXO00VUWbSX9YSj+cJ
        MYF55sHFwEz1SiG2dQ98daLCnTsrnN8ZXrTY3h5/rPgk0S9vNNwyJagN2NjKDZCu0fWp11
        tN9qSNtGOLQxMr1Uxzh3G0p+zo3fKWB+3A5iPrOyrs+5ZlmOb7uIO8/q+GSYhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644504522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcHPrvVcYs9Ty2UbZsiMplAbbgNBGYaXgB9nXMXhgG8=;
        b=p+EDRGCV5/DzCUgeCAcIDMB0ElrLopWC//KGnO7b7PH5ersArOSmfhNGKGNWy/78RiIgrt
        Deg7BmK5HdwPXqCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Message-ID: <YgUlybNMlpheddiD@linutronix.de>
References: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
 <YgUXcGC1mH7VX1d9@linutronix.de>
 <546f147d-1682-fb92-42e5-7247dc19dcf1@canonical.com>
 <YgUc5HxfIdJ0Z5AN@linutronix.de>
 <429dd2fd-3ceb-6780-f970-4ea9b115388c@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <429dd2fd-3ceb-6780-f970-4ea9b115388c@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-02-10 15:13:15 [+0100], Krzysztof Kozlowski wrote:
> On 10/02/2022 15:10, Sebastian Andrzej Siewior wrote:
> 
> The purpose was explain - fix a failing test with PREEMPT_RT. I am not
> planning to rework entire test, it is merely a fix.

What I got confused by is the fact that you do
s/do_softirq/scheduler_tick/ without any explanation why that is correct.

After looking into the test it appears that two random functions are
enough to be specified because the actual purpose is it to figure out if
the function is recorded and not the actual functionality behind the
function.

> >> The implementation detail is that do_softirq() is in ifndef.
> > 
> > So let me ask again.  We have
> >    FUNC1="schedule"
> >    FUNC2="do_softirq"
> > 
> > What is the purpose of this? Do you need FUNC2 when ksoftirqd is run or
> > when softirqs are served? Not sure how scheduler_tick fits in all this.
> 
> I guess this is more a question to the author of the test. Unless you
> are now questioning the entire purpose of this test?

I questioned the purpose of FUNC2 in this context so I don't have to
look into the actual test. But I did, see above ;)

> Best regards,
> Krzysztof

Sebastian
