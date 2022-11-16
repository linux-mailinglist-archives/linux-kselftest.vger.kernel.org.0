Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4A162BD64
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 13:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiKPMTK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 07:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiKPMSe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 07:18:34 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430A186C9
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 04:16:45 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-381662c78a9so84678227b3.7
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 04:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rBIIPAxEMDmWChtWJvfnNUpO+ivoCFncrKiKxYRGVW4=;
        b=t8KpbpC9U6ngJ5hW9MWblzaYLatmkTSgM14ROwi8OIWiMWl/QZ6H3hvFG9U1uFOGrW
         FGVb57z9ID6xCB8HjftKpmVyDnWG6dZMJJ8viGmY1C9/V4RZP3CQMB6un8s1MSmma/0T
         b5wrRrn8tqWgEDE0gDlpKMx8QQLT8Ec+mfkOg/4+l1Ba6GioWh7wbJGe6FZdPp2mvyK/
         mt3Je8PyWyIbBjS4IGLb2NJ1pAH/8znidII1/+Cl4E4D0J9HKGqdAYZYEtMkUssFG4eU
         kwE1m7m4KilYtp8LttC1bQONX14IuzsFYrB0sv0wmCHVBM2pSJMDsgWJca3hTKPt1DYr
         smGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBIIPAxEMDmWChtWJvfnNUpO+ivoCFncrKiKxYRGVW4=;
        b=GEhGmbw8PN4YTi6r3nG65UapqNLzJSi/5bgzl6PHXC3Nyrld8/8gOL2Nr663QE16KY
         lDlRWJIuiCuQ/4dxAKksOWRn1wRnuPz0FDf2j8EiggZ9MGOVdsBvXqnrQin9Fk5daCf1
         FZFNmoXdaPF95GNIB4LJB0fmRy6iBBUyujvOjZZP9oW6MRKgAeP+uh1hoBIL1Gil9PRZ
         Nc/Nkd83dCy62opfzpL8yhvFXIapW4Wpt4ByAbA8CTSal5xbyiW5xxFIYFhUE7zIC15U
         glGxGDscjTGgCIyfcxMFpTmb7SDpauVm6ifCBehZJbttXXqmhR9zs1TCO7zzDjCvCTf+
         tI0A==
X-Gm-Message-State: ANoB5pmiexqdUmFLgZG+3MJFdEmI2N1ejqlMD9mCaSdLapV+fyZ5DalD
        0Uqbr20YEHSN3+81W4mlxLLex/epX7GmjNlfA3ZOyw==
X-Google-Smtp-Source: AA0mqf6040AtJHvH8e6BidX2XV6aiIQjvB0qQXbeXoDkgyQOp+G3I9bJFM7OfOtUmvzF5iJn0vaLanIHI0rF8bLhUpk=
X-Received: by 2002:a0d:db44:0:b0:367:bab2:d50c with SMTP id
 d65-20020a0ddb44000000b00367bab2d50cmr22786012ywe.459.1668601004632; Wed, 16
 Nov 2022 04:16:44 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Nov 2022 17:46:33 +0530
Message-ID: <CA+G9fYu0p4cFdkrkQyV4OC-iPpY18asV0VTP=O_sysLNaJJAQw@mail.gmail.com>
Subject: kselftest: Bad test result: from results parsing in LAVA
To:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Remi Duraffort <remi.duraffort@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest running on LAVA infrastures provides test results parser
from test-definitions repository.
which is getting  "Bad test result:".

I have noticed this on kernelci [1] and LKFT LAVA instances [2].
We need to investigate and change parse_output [3] inside test-definitions.

Report-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test results parser showing =E2=80=9CBad test results: =E2=80=9C,

Received signal: <TESTCASE> TEST_CASE_ID=3Darm64.sve-ptrace.SVE RESULT=3DFP=
SIMD
Bad test result: FPSIMD
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Darm64.sve-ptrace.SVE RESULT=3DFPSIMD>
Received signal: <TESTCASE> TEST_CASE_ID=3Darm64.sve-ptrace.SVE
RESULT=3Dget_fpsimd()
Bad test result: get_fpsimd()
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Darm64.sve-ptrace.SVE RESULT=3Dget_fpsi=
md()>
Received signal: <TESTCASE> TEST_CASE_ID=3Darm64.sve-ptrace.SVE
RESULT=3DSVE_PT_VL_INHERIT
Bad test result: SVE_PT_VL_INHERIT
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Darm64.sve-ptrace.SVE
RESULT=3DSVE_PT_VL_INHERIT>
Received signal: <TESTCASE> TEST_CASE_ID=3Darm64.sve-ptrace.SVE
RESULT=3DSVE_PT_VL_INHERIT
Bad test result: SVE_PT_VL_INHERIT
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Darm64.sve-ptrace.SVE
RESULT=3DSVE_PT_VL_INHERIT>
Received signal: <TESTCASE> TEST_CASE_ID=3Darm64.sve-ptrace.Set RESULT=3DSV=
E
Bad test result: SVE
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Darm64.sve-ptrace.Set RESULT=3DSVE>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Darm64.sve-ptrace.Set RESULT=3Dand>
Received signal: <TESTCASE> TEST_CASE_ID=3Darm64.sve-ptrace.Set RESULT=3Dan=
d
Bad test result: and
Received signal: <TESTCASE> TEST_CASE_ID=3Darm64.sve-ptrace.Set RESULT=3Dan=
d
Bad test result: and
..
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dclone3.clone3_set_tid.[1710] RESULT=3D=
Result>
Received signal: <TESTCASE> TEST_CASE_ID=3Dclone3.clone3_set_tid.[1710]
RESULT=3DResult
Bad test result: Result

[1] https://storage.kernelci.org/next/master/next-20221116/arm64/defconfig+=
arm64-chromebook/gcc-10/lab-collabora/kselftest-arm64-mt8173-elm-hana.html#=
L3105
[2] https://linaro.atlassian.net/browse/LKQ-934
[3] https://github.com/Linaro/test-definitions/blob/master/automated/linux/=
kselftest/kselftest.sh#L124
[4] https://lkft.validation.linaro.org/scheduler/job/5729151#L2511

--
Linaro LKFT
https://lkft.linaro.org
