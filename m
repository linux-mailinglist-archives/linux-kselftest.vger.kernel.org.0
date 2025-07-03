Return-Path: <linux-kselftest+bounces-36427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C12AF7614
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 15:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8201C1C2726B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEE62E7198;
	Thu,  3 Jul 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zt8l/3BZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844112E764E
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550448; cv=none; b=cEWooarH0cvTaAAjRmOLsRAerK6XCzbDu1yQtZeqfnd02uo8mQuXN4u6vz14XPlHKaPYTLgOWe5AY91smxBedi+A71VM3Z9ll8H2T6OHIsT2hLPuf4MNVJ8/+DltJXbihb5VZJcrf5jC8tCM8vbTaqKxaMNpzzO16frt15E4COI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550448; c=relaxed/simple;
	bh=zNAwAKUUSnq/fgn37krSKF6pKcKmiBzRI7BF+xw0WaE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P4strD3dTA//UgriWNkIgZfUpKgLBmbIVNEzES5Bfr7munn6KNzpLER1Kv8l5OsjaPfE6o6Af82nHWIUOWIh/o986OvUn6nlKVWhYVeK6fF9eDoBAf15j6TDVeYJzgHhSjPAKrIpEKefbSXsT/nd91xLlxG06Vpe/NMn88ZQ1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zt8l/3BZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167afeso53731085ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751550446; x=1752155246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zNAwAKUUSnq/fgn37krSKF6pKcKmiBzRI7BF+xw0WaE=;
        b=Zt8l/3BZXfsKF9tG530+WCUjvHyiwOjZIuKYLdjQENcsOzBZexR909d7qa2DFi8E6l
         G7oZ5pQSufGpRcezN+X4GtDF40q8bFBQ1Z6zJFXCumRdHKjNA/9GKKdU7gUXRxzNHkN9
         c/B8zLOuti61UMjOUlMPUWlsfRiYbxBqOQInorwPOPvIOdLCrCxgPXrCH3vyUa+Gxopf
         3cw/F7AYKo8/KM4BvOwKTifbrk5uo7GxdCwuCCDbL6YA67ZI9fx5Fhcvk4Wk5VirONPG
         EcFRj3t0KBS46I9tk/rADwtS26eMJnoReEKxneqTk5E9/CYGY4F73fEvMLEmQbMvP71u
         joqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751550446; x=1752155246;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNAwAKUUSnq/fgn37krSKF6pKcKmiBzRI7BF+xw0WaE=;
        b=nu0AdJdRgScih0eNEM4J4bFEvLVHiVGwHh7AWEZaUMJbDk49zx/7KFmFVE5Rz3gz9b
         WcTF3+zq66ou5PiJKkdyuoQs43bz0zt7q73nxs8T+/cQ2fGapjRszZULQ6uoeLuCexv/
         6Jta91aePxK0XjTXMZW/dqWO1aw4tvRHLQ5ePGJjywSerwmmeYc10ykh3Bfjh+gUOw3V
         7o1J4Tdc9QE8BRII83v4mEIrpVtBRxTtYFHgUXKvp8oAEceOxpLR9l2FKD+SRG47lxJ3
         LcXCfoAKY6+uQUfR85HSRYsSUOtOLViN2XrhP+WE5eUPStgX+JoTdkGyTjwk9K0eutbE
         Wl+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnYUz6lPiKB8J9u3UeuzZbh93TEN4DsE9oZVNEhdgexA4/4bBmILtO3uRw5yD274ZPYGPgXDXZ7rZZW0C+Fno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0giF33nIAlHAj83u6wkoypeKvfkxuqK2pQ2oGj8AYGbcIb5c
	17bk3dRWx3qexPzJbk3m0/ThNh0Cvk2kXUdoXS7ky9LSHxh01ojjb9U/GHIpN0ZR5cdPXsh0cFc
	wpMhrq5LRJizPfKpeQMA255y/CxAoli6t8DbIfgXCLg==
X-Gm-Gg: ASbGncv8ySGeNewkqNyYzzPYMnLYM9QH8h0lEmCYQJsPBFagl2YM3uH0dBMnWHmmTEE
	SdfpptM+pus4tOwqFbmQIsacGTHJUIwTubqllcxVpY+TQLNS4udOWMU6SOIfmDBNTONKQm1Qdq4
	74fex5h8txnNcKjEJNkv+bkTIDjnhWDApsHLKUcdjMPoyDp+1vt82sINyPv8z4X7IyQ2eEslmhD
	fJQ
X-Google-Smtp-Source: AGHT+IHUEXhlNkosB+s9dB8bgXeBCMiI6ZnZi91LzN17D+0f+rv731hdTBQXDcnHdjF6QrxZZv/F/SrS2k49x9IlVAI=
X-Received: by 2002:a17:90b:4a4f:b0:311:d670:a10d with SMTP id
 98e67ed59e1d1-31a90becdf9mr8541210a91.26.1751550445538; Thu, 03 Jul 2025
 06:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Jul 2025 19:17:13 +0530
X-Gm-Features: Ac12FXzo7Nc3aeY_LPk6VLx0lxdm_2o_RgOHnb7cSWld-ykvIKkT80YLPulKSrw
Message-ID: <CA+G9fYvD1A12WE36NjELe5cD-LbPsmwJnH5aUAcufBZ7ndt2Hw@mail.gmail.com>
Subject: LTP syscalls mseal02 and shmctl03 fails on compat mode 64-bit kernel
 on 32-bit rootfs
To: LTP List <ltp@lists.linux.it>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, chrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>, 
	Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"

The LTP syscalls mseal02 and shmctl03 failed only with compat mode testing
with 64-bit kernel with 32-bit rootfs combination.

Would it be possible to detect compat mode test environment and handle the test
expectation in LTP test development ?

Test case:
 - ltp-syscalls/mseal02
 - ltp-syscalls/shmctl03

Test environments:
 - qemu-arm64-compat
 - qemu-x86_64-compat
 - x86-compat

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Test regression: LTP mseal02.c:45: TFAIL: mseal(0xf7a8e000,
4294963201, 0) expected EINVAL: ENOMEM (12)

Test regression: LTP shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax !=
2147483647 got 4294967295

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.16.0-rc4-next-20250701 #1 SMP
PREEMPT @1751364932 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
mseal02.c:45: TPASS: mseal(0xf7a8e000, 4096, 4294967295) : EINVAL (22)
mseal02.c:45: TPASS: mseal(0xf7a8e001, 4096, 0) : EINVAL (22)
mseal02.c:45: TFAIL: mseal(0xf7a8e000, 4294963201, 0) expected EINVAL:
ENOMEM (12)
mseal02.c:45: TPASS: mseal(0xf7a90000, 8192, 0) : ENOMEM (12)
mseal02.c:45: TPASS: mseal(0xf7a8f000, 8192, 0) : ENOMEM (12)
mseal02.c:45: TPASS: mseal(0xf7a8e000, 16384, 0) : ENOMEM (12)

tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.16.0-rc3-next-20250627 #1 SMP
PREEMPT @1751015729 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
shmctl03.c:31: TPASS: shmmin = 1
shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax != 2147483647 got 4294967295
shmctl03.c:34: TPASS: /proc/sys/kernel/shmmni = 4096
shmctl03.c:35: TFAIL: /proc/sys/kernel/shmall != 4278190079 got 4294967295


## Source
* Kernel version: 6.16.0-rc4-next-20250701
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 3f804361f3b9af33e00b90ec9cb5afcc96831e60
* Git describe: 6.16.0-rc4-next-20250701
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250701/
* Architectures: arm64
* Toolchains: gcc-13
* Build name: gcc-13-lkftconfig-compat

## Build arm64
* Test log: https://qa-reports.linaro.org/api/testruns/28971382/log_file/
* Test details 1:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250701/testrun/28971327/suite/ltp-syscalls/test/mseal02/log
* Test details 2:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250627/testrun/28914507/suite/ltp-syscalls/test/shmctl03/log
* Test results compare 1:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250701/testrun/28971324/suite/ltp-syscalls/test/mseal02/history/
* Test results compare 2:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250627/testrun/28914507/suite/ltp-syscalls/test/shmctl03/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zGk12rggXwQHzqasQsWpTN3qyv/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2zGk12rggXwQHzqasQsWpTN3qyv/config

--
Linaro LKFT
https://lkft.linaro.org

