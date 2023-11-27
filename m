Return-Path: <linux-kselftest+bounces-641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E97F9DDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 11:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B62E1C20C94
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653516426;
	Mon, 27 Nov 2023 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnbNT5w/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C12D113
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 02:43:27 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-45f3b583ce9so2919447137.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 02:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701081805; x=1701686605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6TSIoz+H8JLiNUcGCIq1Csd5pwnS8su62/9RaC91nk=;
        b=QnbNT5w/x/n6y8y6/4c6UoHMeQctlFvR0X5JJKvPmtk0/M6tgmjkymPdzZS4RHyYpv
         1KKaTlRZXRvIfPG4udxvhbE+s762oyLxh7AJhzRNcfinAJ5rq9E+iA5cEBzIUVRXbHl9
         KDVbEEl7cHNRSRP3rR/IBP45UQs40P2hlW1ILeXZGtHU+bLleF2qJ7iNrNwA7txE5klo
         u8eM4AArfzx6TdfHWY7Og4qFzA2Yuqs2gBANOhogudfnjS5hhxewMc28QxAcyArQA0xq
         nEwFFuNrIbv3mb+fSyVyK4yxnFPfYYGxDChg/GlnUfsATzyenSO/0Qr/PeO4Wlg+kys5
         jh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081805; x=1701686605;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6TSIoz+H8JLiNUcGCIq1Csd5pwnS8su62/9RaC91nk=;
        b=XwZzbPFQOsb5BNFpQ2M0Wp1r22M0eMqi5r8aVQJ9WZS1Cm4NFMcTDLv1J5FdZZOkf0
         q17E6d1NxHlMoU5Xorlt/oOP7WjIiyNuOuhOczhRPMep2THWYKRzVNsb6vAxVt4GVxaQ
         PYcgEib5R9E6+xYPREp+kixjMVQjluCMQNT14ZiBgoSoFhcgLbEZJXHFoqflDoKyLDKr
         fNTsiXuN1cooKMFRCpJxCgWrxKhvfn4Be+whFBKUCHJ1c6S7Yt3G/CkHyt6HrUZAJAt2
         Gw+WYXsnXAUkNnC8KkkdBbMqsSX92Vo8xj5FF1UteF5jtbNaZCaUhwvLgBGzMG662kgZ
         Z8sQ==
X-Gm-Message-State: AOJu0YwYdoBF9AAJaJdX1qBN5pl+zfgSzgQZmKYMwUjf+LADoE44uV7R
	5zMt8+gNRn9MaSE9f7KiXq+w2PBofhYLoljFcUc2MoSpqbVDuKMI/Tk=
X-Google-Smtp-Source: AGHT+IGMKNRQ2wePxRC4PpDnj4YoN1p1HWwhKXLnzyZPaFNOeCXmqVoolj5+388JcmcpA13+Hkz5NYjQyYeR/zR/n8Y=
X-Received: by 2002:a67:cd16:0:b0:462:f13a:286a with SMTP id
 u22-20020a67cd16000000b00462f13a286amr2897810vsl.4.1701081805658; Mon, 27 Nov
 2023 02:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 27 Nov 2023 16:13:14 +0530
Message-ID: <CA+G9fYs6WafDBtSbcLpoyWehQyBPNeX37PvsP6HzSotXr3dYLg@mail.gmail.com>
Subject: lsm_list_modules_test.c:104:22: error: 'LSM_ID_IMA' undeclared (first
 use in this function); did you mean 'LSM_ID_YAMA'?
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev
Cc: Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Following build errors noticed while building selftests lsm tests for x86
with gcc-13 toolchain on Linux next-20231127 tag.

Build log:
------
selftest/lsm/lsm_list_modules_test
lsm_list_modules_test.c: In function 'correct_lsm_list_modules':
lsm_list_modules_test.c:104:22: error: 'LSM_ID_IMA' undeclared (first
use in this function); did you mean 'LSM_ID_YAMA'?
  104 |                 case LSM_ID_IMA:
      |                      ^~~~~~~~~~
      |                      LSM_ID_YAMA
lsm_list_modules_test.c:104:22: note: each undeclared identifier is
reported only once for each function it appears in

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
-----

tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-13  \
 --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2Yk9XptRIQra77bvzZHcgyzkH7w/config
\
       debugkernel cpupower headers kernel kselftest modules

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231127/testrun/21324802/suite/build/test/gcc-13-lkftconfig-kselftest/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231127/testrun/21327065/suite/build/test/gcc-13-lkftconfig-kselftest/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231127/testrun/21324802/suite/build/test/gcc-13-lkftconfig-kselftest/details/


--
Linaro LKFT
https://lkft.linaro.org

