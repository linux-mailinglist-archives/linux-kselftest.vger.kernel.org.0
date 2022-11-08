Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5110620CD6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 11:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiKHKEt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 05:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiKHKEe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 05:04:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969C81B7AB;
        Tue,  8 Nov 2022 02:04:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 469FAB81A09;
        Tue,  8 Nov 2022 10:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE344C433D7;
        Tue,  8 Nov 2022 10:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667901871;
        bh=n4E+wLKYhLKXMM/bFvxXuntHNthxT9a9Az1ywy/aFFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YiMMsnMCFeBIVzn0aSaoocx4SU+6FJYqO1UIQQ4ZPDzthNaYL2MKF/ij34YoQIBVe
         u5DC+bmfCoCz1Jfx45m92gZLg8vLzqx5bq/tfxaodJrMpvgfw1u82NSJZmnkUzKq9r
         B7/dt0kXhcODV1eiE4Kybvv0S5PvFwtDS+1l3KRAOzM4zyd2i6j0WIOPAtduRKJtgi
         PxhFXb+AIYkSJv9NbimrBVV8UNFeGTp+CZWUrFrheKCxZdf6gJUXg0g9NOaRdefN1F
         WJyBTpPeZxck9vo8CeLIakQ7Toonh5voABeiNv2YTZYK3xTfeDtdNzxGm2IL78Pt9C
         RsWeuy+jiJI7g==
Date:   Tue, 8 Nov 2022 11:04:20 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Florian Weimer <fweimer@redhat.com>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: selftests: clone3: clone3_clear_sighand failed - Bail out!
 Failed to clear signal handler for child process
Message-ID: <20221108100420.6zhmrio226vbii4e@wittgenstein>
References: <CA+G9fYs+fOTBO=aTfO57xby=QQDaqUt4umwgo6bwLB_iGoSEPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYs+fOTBO=aTfO57xby=QQDaqUt4umwgo6bwLB_iGoSEPw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 08, 2022 at 03:28:55PM +0530, Naresh Kamboju wrote:
> selftests: clone3: clone3_clear_sighand failed on arm32 and i386
> but passed on arm64 and x86_64.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> # selftests: clone3: clone3_clear_sighand
> # TAP version 13
> # 1..1
> # # clone3() syscall supported
> # Bail out! Failed to clear signal handler for child process
> # # Planned tests != run tests (1 != 0)
> # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> not ok 2 selftests: clone3: clone3_clear_sighand # exit=1
> 
> Test details links,
> https://lkft.validation.linaro.org/scheduler/job/5820146#L1795
> 
> Test results comparison link,
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_clear_sighand/history/

Seems before 27 September 2022 this test wasn't run on 32bit instances
and noone ever noticed?
