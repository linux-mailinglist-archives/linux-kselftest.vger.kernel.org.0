Return-Path: <linux-kselftest+bounces-25066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA20A1AF3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 05:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3938116D280
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 04:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DF1D63D2;
	Fri, 24 Jan 2025 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X/zbK6mt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBF1D5AD9
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691258; cv=none; b=KQoLTdL8iV8S2jrUfHBmgQV7zsEr03xDYkJ5i3y/2T0+arLdqU9Pplk6kuWLEamfE8aa9qndDhD7KI5NBqRNlF9H8RxCJgyrOrXqJKg5j+N/uYeVsPqMiPSgOILPiQfSrFJggZAawfMJyXzgiMld82OAXJH28t3MGcrnt0AVCp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691258; c=relaxed/simple;
	bh=A4F3SeT+aF6tRKnf7dmtupnBo9KmgAZ9B973BYeZgF0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kZc/E6cLNvMofuvZulLvHqrRyKefg2iq3uyMaUnOHdSRzWehcuRhl5lc67CbtW6/1/WE+pyQgK2hbdggZAXrRoFjp4SP0bj51m5quWX+wea4fWkVDZW2YZSSqE7zw7lg6i0bxKdqbl/7GGqzrqHSpFDZQYD/kfLXAED03462ZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X/zbK6mt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2167141dfa1so30963395ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 20:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737691256; x=1738296056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lowTk9aiYfu2S+1YMHhjcUoy6Ifdfd28cH1lFEtMNxg=;
        b=X/zbK6mt7goXOfHsRHa9vmbSvR8akafAg8IldPHAutMl6ur0vLRHTskV+cvhpltPVK
         YozenBdGT2RJG3PdB9acDmnXRGo9RxvlAXoaDK45DzjoXOWG1XzKUC2e9JyQDKhR7fZe
         vaYDsud8BxHOmKHtkRI66zuf1ycxIt9q7Vo4ri3ZJSaptLvSw938FxqFXN3c62L+F0Zl
         R63kVdrwdlpnSACtwNIOhFXOWxUVnejp1B7t+m5cB7zE9KnoX6QmLFvF8OtplgKhf7CT
         yJBGgJa7mVUi8FbG/1mePXyB9DyCy5AorP6djSu1aAFaMX8hBTHNIoFp6hxYTXyUBW+p
         dVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691256; x=1738296056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lowTk9aiYfu2S+1YMHhjcUoy6Ifdfd28cH1lFEtMNxg=;
        b=X9mH1OrxMrAYkW320IXjBpjlQKFrwXPHycVn+W3zL52GLLE5zbKuio2KyN3ocZbMZC
         h5sC0nDJF5sy7cjanDhQu0C0UwAea8GDbrhiXnutyTo1CDosi5ktbhCjVmAft1eJ/N++
         6q3a1BaCBktQxVyXc/Te6kUVrFFLT5T16n2gxK0BuAe6UYrtpm1gd53VZTVvPR3nkR+F
         lwNADK6NjgIino540oz5UabVlijkYn78V4hh2JOl8+C7/xe6UXQC5ga4vR4J2aHhne2W
         +SvCFkfAClpHyPFFbMgD+LCJt0C7YMRxdrczBgNrpx/ZC3+LftJ/nrQg7TEB6lxuiWVO
         Bgzw==
X-Forwarded-Encrypted: i=1; AJvYcCV8RyvDzjGAcIYrO0cpprl6yJ65uzK7O1AlgZyNcXEN0a0uGEvDS/idfy7/8S9A5a8Rh1ljDXQEztP9mKFQz9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZ2Y4BDcC9eMambK1qfqu7iqpW5ZlA+CLOtwevMwcWlQq1TyJ
	mQG+a8r81NUkrrvuHw33i/XKMfFARyc/mi0Oop1d5QhjyXjyymkNwtPZdOhQEcQ=
X-Gm-Gg: ASbGnctHaL2Ne8E5nh4UejsJA42eHWBBDLgMJFWjrts+YtwDG+omCO7DSzOt190CCTC
	v/YQ36dZqD4vV+mmtYUa12Fn7OUcWOqTCD7RlmzHCx7zyeYJaE9Gk67fwfBxm0a95LJiSlR4+Zl
	M9ZZFdlCVERJ+uJG3zLK6LbGc8nZ1291CibSqETiYctOsLoL/w2F+UGFl1Iou5sM/cUCrIczH5f
	9xYiztD9aYTkdimEkDtenkKdoFP16xqFgysZ+tulwuK1vmZ3T1TQmo6UGf/8l0jvLdtMUNYu+PF
	uqeM4mYXDSRjjw+/jCherLjHhL2bcLKE1oFmb9c0gkbLfFb6Bg==
X-Google-Smtp-Source: AGHT+IF2S4YVOk72i+gmuMaJGfQDN5Q2NrC3RvrGrOxrDJRorKXpriRqzs16K3FSFHQ6l7Vpi8ulYw==
X-Received: by 2002:a17:903:124b:b0:215:98e7:9b1 with SMTP id d9443c01a7336-21d993177a2mr87571155ad.5.1737691256294;
        Thu, 23 Jan 2025 20:00:56 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([2408:8406:78d1:bf49:24c4:f518:9b3b:36de])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141d67sm6758915ad.153.2025.01.23.20.00.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 20:00:55 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v6 0/3] Enable Zicbom in usermode
Date: Fri, 24 Jan 2025 11:59:56 +0800
Message-Id: <20250124035959.45499-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1/v2:
There is only the first patch: RISC-V: Enable cbo.clean/flush in usermode,
which mainly removes the enabling of cbo.inval in user mode.

v3:
Add the functionality of Expose Zicbom and selftests for Zicbom.

v4:
Modify the order of macros, The test_no_cbo_inval function is added
separately.

v5:
1. Modify the order of RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE in hwprobe.rst
2. "TEST_NO_ZICBOINVAL" -> "TEST_NO_CBO_INVAL"

v6:
Change hwprobe_ext0_has's second param to u64.

Yunhui Cui (3):
  RISC-V: Enable cbo.clean/flush in usermode
  RISC-V: hwprobe: Expose Zicbom extension and its block size
  RISC-V: selftests: Add TEST_ZICBOM into CBO tests

 Documentation/arch/riscv/hwprobe.rst        |  6 ++
 arch/riscv/include/asm/hwprobe.h            |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h       |  2 +
 arch/riscv/kernel/cpufeature.c              |  8 +++
 arch/riscv/kernel/sys_hwprobe.c             |  8 ++-
 tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++----
 6 files changed, 79 insertions(+), 13 deletions(-)

-- 
2.39.2


