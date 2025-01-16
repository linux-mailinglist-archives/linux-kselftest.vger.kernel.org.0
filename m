Return-Path: <linux-kselftest+bounces-24651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44278A13C21
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 15:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBE61650A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6F22ACCF;
	Thu, 16 Jan 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qy224gVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28822A7F7
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037589; cv=none; b=nxjAm25qrN4jzUHrdQkJpVw1ja34W4D7ULnA2rpTKJ4rInyib9uRkm0zUDKCfxhVLDxZFQXh9/KOKyB6avBV9A7fFtnXKO5wc8bImVY62qfonX3qDyrPA26orpL7VJFvA89GYfnOWrG9czQWMmTnmg2fGRigME7aaF9nG12Gj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037589; c=relaxed/simple;
	bh=CMxaCTGHWJWXLDdla/HnutcDXfkNPfmpwzhMakS4J0M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jBWuw7bXhusUbfRY6QEKGkkYLEiOfD71jTPcT+WXBP/Ds7dPEfMA0J3gOxFGUWj+CeQKshIkZXeXQ2vpdFJxz0d47vCVqJBX2Rhn/cVNNoOkey/k74IsHfPz556NrPmJUGo4T+TkTb0zxUjxE7k/5xqIfUNZXpi54hO9GBOHsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qy224gVd; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-518c46cc6e4so228783e0c.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 06:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737037586; x=1737642386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h+Rw7Ob6/WiarGSVrCx4SH8clkSJIqyYfGq/YoKTi+I=;
        b=Qy224gVdeFFK7jTn50F/VaMBYjCeSYejwH7QlRZV85rMIshwbxy9W6LPCLBKF0lyQa
         Bc/Yb0lIQYcp7ZzpZZHVhhT8QQws8XUsQ73jMjSQB6Hh8D1pMkZ3WUniExcugNGq0hBg
         G2XlSD/UAPgug2IDbONWindMu9FhOa8xkF8rKxRQTn/hFYhk7JS9VwX879hS+zFJCHqC
         mfZzu3Y4hgN299rHlMBlzlJtZ6bhCfaHgAb1X3uK8vAPCIdg0v01kgntfvzL432Cn12Y
         7PcpHDOqCqnYgP+MFrFDj+cPGgEs6QW1Yee/R/2jQxm06s0eQzaBLM4idI7KhSkvl6YJ
         IedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737037586; x=1737642386;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+Rw7Ob6/WiarGSVrCx4SH8clkSJIqyYfGq/YoKTi+I=;
        b=wEElqCKLN81D2+cvOkZVIrTOWjOcD53gFT8C14wD6yn3Ls0E7VTlSktoosjsP2BP01
         tG0eR5OI27kOaGI8y3XdbST3LK/ShSOOVLs9eUcx+MmkIYYYVtV1QqePkopCuTs3/vg9
         v/gVtmfqT0LIwA5oKw6EBmKb0TgYK/nAf/sTA1wtJUmkuCZz28nzq8yxwDRCXwRn7WAt
         20bjO2Z6gng/ywiA3UhVdWBA+RBubKM+4mzMLnMPlqEeIMOHJguBT1SmbtDxN7cAPJC0
         Dpq53KjJixw0RaIi5aKkai9z8DRYOyjlVsn1cxXsGevaUIc2qLnQqruQNczIZ2r5XS3D
         LA6Q==
X-Gm-Message-State: AOJu0YzVAkOpPrUwBBBSXp+eNT+BI6kOc8QHvZTNE2c4ei+jeqFOzk+G
	iu8ErX5r5Zb3pJL4TZnTvf8xpFbFeFa4vPVv6EBEdkxeMU29fL9X2ljGWFFd4REjebyHYi2Y2KO
	Plb6kqbfK8dFcsjDTCZllnOXVaRGvd32gRT4RkskZUDXmcI6zZ3I=
X-Gm-Gg: ASbGncsQv+ufPCPfR4/KxgB/1YbAkG8JtUjRw/Z3QUh3MX0sEH3kTN3X/MBWH5StP40
	n89J51US4VYsLhr2bO2zGh6ZcJviTvctFGV3/t+A=
X-Google-Smtp-Source: AGHT+IG69Iug3RNWcBE6hDwoY/YsKCsj+bS5178NB4qQne/ZEPAsv5eYVsqQLqTWxWFut0+AH4mpZulQYoQ0nJD8hGI=
X-Received: by 2002:a05:6122:180d:b0:518:a2af:d666 with SMTP id
 71dfb90a1353d-51c6c439cf2mr24828443e0c.1.1737037586483; Thu, 16 Jan 2025
 06:26:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 Jan 2025 19:56:15 +0530
X-Gm-Features: AbW1kva_0SASVoeU-f4wfBuEU8gIi8Dp0CUTXbRkmEMORnWfqOPRcAxWeuN9mRw
Message-ID: <CA+G9fYtDLPwpiH++b_RVnMrHX3trFt-fY06UnV1Q5oSE6Nrsrg@mail.gmail.com>
Subject: selftests: arm64: pac.c:237:pac_instructions_not_nop:Expected 0 (0)
 != keyia (35747322042253312)
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>, Boyan Karatotev <boyan.karatotev@arm.com>
Content-Type: text/plain; charset="UTF-8"

The selftests: arm64: pac getting failed on FVP, Graviton-vm and Qemu-arm64
running Linux next-20250113..next-20250116.

Started noticing from next-20250113.
Bad: next-20250110
Bad: next-20250113

Test failed:
 pac
 global.pac_instructions_not_nop
 global.pac_instructions_not_nop_generic

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Test regression: kselftest-arm64/arm64_pac

Test output log:
--------------
# selftests: arm64: pac
# TAP version 13
# 1..7
# # Starting 7 tests from 1 test cases.
# #  RUN           global.corrupt_pac ...
# #            OK  global.corrupt_pac
# ok 1 global.corrupt_pac
# #  RUN           global.pac_instructions_not_nop ...
# # pac.c:237:pac_instructions_not_nop:Expected 0 (0) != keyia
(35747322042253312)
# # pac.c:237:pac_instructions_not_nop:keyia instructions did nothing
# # pac_instructions_not_nop: Test terminated by assertion
# #          FAIL  global.pac_instructions_not_nop
# not ok 2 global.pac_instructions_not_nop
# #  RUN           global.pac_instructions_not_nop_generic ...
# # pac.c:252:pac_instructions_not_nop_generic:Expected 0 (0) != keyg
(35747322042253312)
# # pac.c:252:pac_instructions_not_nop_generic:keyg instructions did nothing
# # pac_instructions_not_nop_generic: Test terminated by assertion
# #          FAIL  global.pac_instructions_not_nop_generic
# not ok 3 global.pac_instructions_not_nop_generic
# #  RUN           global.single_thread_different_keys ...
# #            OK  global.single_thread_different_keys
# ok 4 global.single_thread_different_keys
# #  RUN           global.exec_changed_keys ...
# #            OK  global.exec_changed_keys
# ok 5 global.exec_changed_keys
# #  RUN           global.context_switch_keep_keys ...
# #            OK  global.context_switch_keep_keys
# ok 6 global.context_switch_keep_keys
# #  RUN           global.context_switch_keep_keys_generic ...
# #            OK  global.context_switch_keep_keys_generic
# ok 7 global.context_switch_keep_keys_generic
# # FAILED: 5 / 7 tests passed.
# # Totals: pass:5 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 37 selftests: arm64: pac # exit=1

Links:
- https://qa-reports.linaro.org/lkft/linux-next-master/tests/kselftest-arm64/arm64_pac
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250116/testrun/26774718/suite/kselftest-arm64/test/arm64_pac/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250116/testrun/26774718/suite/kselftest-arm64/test/arm64_pac/details/

--
Linaro LKFT
https://lkft.linaro.org

