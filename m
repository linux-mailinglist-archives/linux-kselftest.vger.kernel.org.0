Return-Path: <linux-kselftest+bounces-24417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6292FA0FEA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 03:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289593A1043
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 02:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E49230988;
	Tue, 14 Jan 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JhaqVPZz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723E230263
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821214; cv=none; b=l9tCabVEbvmduGK2XYwwJ7Kk3diP/i1E7E8xixdeGqbwrV2yC6ZQYNRJmKEe3Fb3iB7i3o1UAiTBL9Mojx8xHFQ8O3ZOSbZ62qUcPIopF42BvNimCOYeFbPa5TFU2+VszYqJsj/RkJkABKeBc+qSiCRqWNR61qSsZZ6iMAI7uJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821214; c=relaxed/simple;
	bh=fPMZCMLP+pvuLWbFgCmRQhAUcqXegUv7Ue3whmjtY4I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qOjpucSgNjt4vyoNRh3iNv5hKjIl3lsXHIW2f99rqxHZnXvjm7MSKH4YSwJvGLKIy3HgYJwVRkbiSjCtzt+kRjlUk4MRgXws2mvXI2HWVRHzq2pchhQZnUE9LBleicMKkthlkk4msOC3Z1vviZ2uH21q0UX/SfbkKbXommOJ9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JhaqVPZz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216401de828so81768325ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 18:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736821210; x=1737426010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q09J7qEcp3rrZoNB/+VeCmI2iCaPt+jfy+7tftGYhzw=;
        b=JhaqVPZzwsfMtZlP2fBuIxcdoQc4Lw1huXgg7TmrXvMbz20x8POBy1KW012rRWmkOP
         +1U176ejuu/DhjOWycxnDsA47DaPChb3o8SkqixQpK0+bV5Q+77UPyIsmaNUz8H1UhNv
         BTZS7MQh+spsOhflaOdYeRv9h6TZ+XyPm9VmywXwpfY0/VSB65pbvyrWMjRW4rYIuAhF
         Rr80FMG8ARIKhlx5k28s+Lah3R0MeUnZTNJ6j7gSv6KPbTmf/V0KijRn/7WBMTImFNAC
         xxHJYPnYQTRw63EouFypRt07of9SjdpFQ14H/ujbs2BoU/XbRFlfnkMUzOwkgRFdXbtI
         6WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821210; x=1737426010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q09J7qEcp3rrZoNB/+VeCmI2iCaPt+jfy+7tftGYhzw=;
        b=SWp2MeN/uwq/ZO0SM6D7Jq4i1zN/xaYquSI9VaDQuDaMSGAIjIia5fclPd3N6aefLv
         6FjmHtNJhttDeOF/Syftja+AyIpd9XPNrdHQzTW8QrQU/KxT63T3IrNVPM6VW2aR1phc
         cBraixsyALCyN1PsWIARfNqazd0sQon3uonO4pvciY91R8h2qSJRExVN5oP2Z2alp380
         Gz0r5TsLrHxDVFHTkOmc2iF5jGKaYUFQESKw86OICTxTKVnpFVPcrdys8k4hDFM8FEV/
         oGE/eA1wWOlvZIf3RekGLlQ1YHpMjnj01BVnfrmDRykNhHOUsejx2j8fKuE21q4YdS9e
         W9ag==
X-Forwarded-Encrypted: i=1; AJvYcCVlwrHD5/Drt4xKsvH653/IsFxh+GkwKrLwqA1OokQmGhpEpkvLczYd2yeiM+9brmXDk35RtP+DJl9H41aRsWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3uLmGEgoKngAjuKbCDCFALfl5AvFE7u4jBgW9dnUDPUKD1yOf
	2wxqDiBIOz6ewd9NjSLzoIa/SmgfB1Iq2TH6PzoQrcHYSeTdX+pitG5DAGLZHjE=
X-Gm-Gg: ASbGnctDd9Tb2gTI+fu6gaRLY9tXjjTblgXWTd0y9Q17fl8yvPNq0fr/v85L6ATKc/U
	H+c3KI7ukhj0hMmGxTjLNXBvDhb3HObYWV1YH29TBA3HmyNBCLm4r/kZQ8cJhQdFXrPW9E7kqur
	PuYRNtZZK6c/J0rNtF9j724ee24Q9iO0sy9H6UorY+L89f4r8sul1jJhQfCrV4ASTGuw+hrv/Nk
	SQecIT7YOF72ggtmptrUpd2cDFEKYllLEl2+JevE8PlMBPd1xbCKQik8Awc+kmDWAvtfznskDnZ
	bEHyt/IARfdHuM8=
X-Google-Smtp-Source: AGHT+IGVvtg7HHpVAFKIVBm03FD1c07xkEL1bUokr4zs3LVVlfXFzTjyIZLaAOZOhim/RI2TecAjXA==
X-Received: by 2002:a17:902:e545:b0:215:4a31:47d8 with SMTP id d9443c01a7336-21a83f36d79mr330978925ad.9.1736821210574;
        Mon, 13 Jan 2025 18:20:10 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217b38sm58948065ad.145.2025.01.13.18.20.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:20:10 -0800 (PST)
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
Subject: [PATCH v4 0/3] Enable Zicbom in usermode
Date: Tue, 14 Jan 2025 10:19:33 +0800
Message-Id: <20250114021936.17234-1-cuiyunhui@bytedance.com>
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

Yunhui Cui (3):
  RISC-V: Enable cbo.clean/flush in usermode
  RISC-V: hwprobe: Expose Zicbom extension and its block size
  RISC-V: selftests: Add TEST_ZICBOM into CBO tests

 Documentation/arch/riscv/hwprobe.rst        |  6 ++
 arch/riscv/include/asm/hwprobe.h            |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h       |  2 +
 arch/riscv/kernel/cpufeature.c              |  8 +++
 arch/riscv/kernel/sys_hwprobe.c             |  6 ++
 tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++----
 6 files changed, 78 insertions(+), 12 deletions(-)

-- 
2.39.2


