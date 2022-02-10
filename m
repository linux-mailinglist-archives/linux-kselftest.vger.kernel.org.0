Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB54B0F17
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 14:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbiBJNrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 08:47:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiBJNrc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 08:47:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C6DC2;
        Thu, 10 Feb 2022 05:47:33 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:47:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644500849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSr2ss2XeDq1uSx/52DLJxAukEh718lajFixXSZYo0Y=;
        b=XzVSm1oGXQRb9fGaQie8jawnpDq2BileH+QA9VnwZkHOtdaJscOuZag9iuGfUsX5Mmv9cz
        sKmdKhGiGANr7YXNajGqAnpNNo4TzxiUng3Ns6Y8bCvLJfdROw64vAL2OvnRlgCk7UVas1
        KYT9EwD9Yorv05neTRDuylIYm+MiFDcqLEPC7qkcczGHEIUR6XUCOUi64T/1P9UyRBTou2
        o1zwe+3ZBM0+Y66ZXT8FBZwTpkYQFrOZTMM/6v1RX1ZXo00kpymGLFQRRW8d5Ws9PxC++1
        1qhUFgK4s+Oteimvo5MVFzP8aB0yL/nZH6RjGoE2icCU8quiN4VdDLyHMXAoVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644500849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSr2ss2XeDq1uSx/52DLJxAukEh718lajFixXSZYo0Y=;
        b=sX7FCscNJWJk5dqwgIws8B0emR5gI5UgS+LF0QYJ+0lQeQ6hTuHRSxw9ZRtEAXfhAsrs97
        VIuYiR5sEFFcW5Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Message-ID: <YgUXcGC1mH7VX1d9@linutronix.de>
References: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-02-10 09:33:56 [+0100], Krzysztof Kozlowski wrote:
> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
> do_softirq fails for such kernel:

PREEMPT_RT does use soft IRQs.

>   echo do_softirq
>   ftracetest: 81: echo: echo: I/O error
>=20
> Choose some other visible function for the test.
>=20
=E2=80=A6

> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> @@ -19,7 +19,7 @@ fail() { # mesg
> =20
>  FILTER=3Dset_ftrace_filter
>  FUNC1=3D"schedule"
> -FUNC2=3D"do_softirq"
> +FUNC2=3D"scheduler_tick"

What is the purpose of this?

>  ALL_FUNCS=3D"#### all functions enabled ####"
> =20

Sebastian
