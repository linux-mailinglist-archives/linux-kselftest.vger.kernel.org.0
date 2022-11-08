Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6F1620F0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 12:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiKHL2X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 06:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiKHL2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 06:28:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F02648;
        Tue,  8 Nov 2022 03:28:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C56A1614DE;
        Tue,  8 Nov 2022 11:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A73AC433C1;
        Tue,  8 Nov 2022 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667906901;
        bh=vML2v+p9FO8o5nsIHTCyl3gLuB3uE46mkRG3fNi8ErU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xg/sHvj4JctLVmXzGVxeWQnvIitZ8y5pC4kHB/zuCQv/AOf1kZ2yQo1Py5zZREaI8
         Pym+cN1Kx8A3ipCHIGOL1uPXGwl9grTcaJV3y0wNRayC4eAD272WixnSXb9ROu8KXp
         d6gnDe64FzLWG2Ob8hTT05UxSEJHDIXUisTfUQ0IL2dtfqGRdnMIdFPyvHF1tZx24Y
         BVtlz9gIdB1Qa022ggPYXd2N19bkshTrt3qFGiTNooqygRWRsttlW0NaA8cmm5423C
         VfJ4r2dtsMFzCHiiZpi/e2mFNwIdaufspADWRLhx7dLbgZnTT2/LZEdBe7UQQ/XY1c
         QAfLJUeSxBNJA==
Date:   Tue, 8 Nov 2022 12:28:11 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: selftests: clone3: clone3_cap_checkpoint_restore fails - Could
 not set CAP_CHECKPOINT_RESTORE
Message-ID: <20221108112811.56mhfrguuscrh2ow@wittgenstein>
References: <CA+G9fYtLoBo31wRD=+Q8DfO36OGBACp2GY6xvyj8CmUk37rbuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYtLoBo31wRD=+Q8DfO36OGBACp2GY6xvyj8CmUk37rbuA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 08, 2022 at 03:59:56PM +0530, Naresh Kamboju wrote:
> selftests clone3 cap_checkpoint_restore fails on all devices.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> [   97.198602] audit: type=1701 audit(1651167820.383:12):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=1732
> comm=\"clone3_cap_chec\"
> exe=\"/opt/kselftests/default-in-kernel/clone3/clone3_cap_checkpoint_restore\"
> sig=6 res=1
> 
> # selftests: clone3: clone3_cap_checkpoint_restore
> # TAP version 13
> # 1..1
> # # Starting 1 tests from 1 test cases.
> # #  RUN           global.clone3_cap_checkpoint_restore ...
> # # clone3_cap_checkpoint_restore.c:155:clone3_cap_checkpoint_restore:Child
> has PID 1733
> # # clone3() syscall supported
> # cap_set_proc: Operation not permitted
> # # clone3_cap_checkpoint_restore.c:164:clone3_cap_checkpoint_restore:Expected
> set_capability() (-1) == 0 (0)
> # # clone3_cap_checkpoint_restore.c:165:clone3_cap_checkpoint_restore:Could
> not set CAP_CHECKPOINT_RESTORE
> # # clone3_cap_checkpoint_restore: Test terminated by assertion
> # #          FAIL  global.clone3_cap_checkpoint_restore
> # not ok 1 global.clone3_cap_checkpoint_restore
> # # FAILED: 0 / 1 tests passed.
> # # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> not ok 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1
> 
> Test details links,
> https://lkft.validation.linaro.org/scheduler/job/5812724#L2074
> 
> Test results comparison link,
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/tests/
> 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_cap_checkpoint_restore/history/
> 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_cap_checkpoint_restore/details/

Similar question to the other report. Is this something that has
happened before or are we starting to see this failures just now?
