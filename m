Return-Path: <linux-kselftest+bounces-17900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1914977575
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 01:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CB21C2401D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 23:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844591D54CD;
	Thu, 12 Sep 2024 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="020ITdSn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB71D54DA
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183151; cv=none; b=Ru+QujJl8ne8ED1MAQs5qzX3k1uSXyzH1FyZnhkbksT4C5qGH9ReuLH8gacxQUllFay1ajevgDv2jLKPOZZH65qF+B6xxNzNW+5LAc1wbncpHY96K6s8QV+m9io2v2XBWK+3O6fmYdWnApwiT/fgNgz64fZurL1OEtmxALLawM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183151; c=relaxed/simple;
	bh=P43D1caEJmaZtlsnwossu8IhPK41eS+mTAY7SmhqKsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYwW9hss1Sj5oNe8AeNehYtwdt1PGhiiaYbJzn7X9i9wZV0i7cZWW9K0nWQ9DIKrNlfm9TIqxCGMu+ZtVHqQ3DovsWohRshVgAexS+HCI44nLJAnTMUFYQJKqjPoqpJeUjXjwqCQ7gQEPSH5F6EVXInfYLk1J2Mw+Q/Twqivikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=020ITdSn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20536dcc6e9so2256585ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183149; x=1726787949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iyonew7njYYUDgOFlccFcLDkYmWknDQSdFdIbsgjEzE=;
        b=020ITdSnaTdVEdf9cwfgw/dDNEHKyUXBSbiE9gGY7IJr7XG9TY1Sc3hjeWcgFMrfmS
         6n71gVtQlpuajn0Q1dufD61WoQ0TxEvvLGtL0fPFvb/Xfva0JQgbM8MbCwUI/wXNZYLO
         vnNZNgsyh4lu1sPN0pNr5AJIfTIpwOXpgVbnSyJRG1nW+PCf5E9bayv4EjXW3Z2mAXhq
         J795VQIWAoydg2jY9hxNydGJd7NM/3LXeaBkxrDAbS0gUGyNw7EKt9TuvhkL4JH6+PAl
         K2B1Xy6M/xnOccZ1I4IzkFy6F/tGg565VfBxgItH36b0JOcmNJttpfnwEMhyC/x5vVib
         FgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183149; x=1726787949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iyonew7njYYUDgOFlccFcLDkYmWknDQSdFdIbsgjEzE=;
        b=Ghlw69dT+5qMbQQESUu81YdnJgQlYLNzJ9bzXLe660V6AP+8ajAw4sPYjwiq3BpQIM
         3Ws/NY8zrnctevVREjwiPdA+Csf48qX2ywFaPIPQY87DglqpffvXGt1xB0L4c7Ypq8Fh
         +y8nqNxcSP8ydolQN2EkyH+e84Hpv9ZSrblNfpt7YjgT0a6z7qeHC0nUIrCslQAQH29G
         IoI9BBthpNYkUTRwru6I8SjsiyvJxT6lOsEs6PLR6JKK+RQpNtEb7kUDcPVdbeIuC6wR
         hxhP9ZL+CrqUV9FYolkpBEHcJSyZI2011P/5+RiW9N+ERWO2VNN3psiPlrZ+AhCiBJ6u
         rt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOzLLdNtgeApfiFr/vuLxPKb73kMURZEJpS1h4R9V96TXcxP81XeptaHJ+bhX1sXpV2sb4VBOKYEs6RXptR0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2X2yrgt9livUWt+/SgV6ngFTASrKWtQqBRwITJrQtGFspMcv0
	2olmofa95DA5BFXBumEHzITX3BKJqzFgcoT4wIEwqUs6LbtnKFGGMNLx/RgVrpY=
X-Google-Smtp-Source: AGHT+IFQFXeegIq20jMre9WaWvSrfHhLDrwK4rARP/3T0r/5M87gFpvdLVA9mkxvLCR99S6cpVQrqw==
X-Received: by 2002:a17:90a:4b87:b0:2d8:f0b4:9acb with SMTP id 98e67ed59e1d1-2dbb9f08179mr1017556a91.34.1726183148685;
        Thu, 12 Sep 2024 16:19:08 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:19:08 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 28/30] riscv: Documentation for landing pad / indirect branch tracking
Date: Thu, 12 Sep 2024 16:16:47 -0700
Message-ID: <20240912231650.3740732-29-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding documentation on landing pad aka indirect branch tracking on riscv
and kernel interfaces exposed so that user tasks can enable it.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/arch/riscv/zicfilp.rst | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/arch/riscv/zicfilp.rst

diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/riscv/zicfilp.rst
new file mode 100644
index 000000000000..23013ee711ac
--- /dev/null
+++ b/Documentation/arch/riscv/zicfilp.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Deepak Gupta <debug@rivosinc.com>
+:Date:   12 January 2024
+
+====================================================
+Tracking indirect control transfers on RISC-V Linux
+====================================================
+
+This document briefly describes the interface provided to userspace by Linux
+to enable indirect branch tracking for user mode applications on RISV-V
+
+1. Feature Overview
+--------------------
+
+Memory corruption issues usually result in to crashes, however when in hands of
+an adversary and if used creatively can result into variety security issues.
+
+One of those security issues can be code re-use attacks on program where adversary
+can use corrupt function pointers and chain them together to perform jump oriented
+programming (JOP) or call oriented programming (COP) and thus compromising control
+flow integrity (CFI) of the program.
+
+Function pointers live in read-write memory and thus are susceptible to corruption
+and allows an adversary to reach any program counter (PC) in address space. On
+RISC-V zicfilp extension enforces a restriction on such indirect control transfers
+
+	- indirect control transfers must land on a landing pad instruction `lpad`.
+	  There are two exception to this rule
+		- rs1 = x1 or rs1 = x5, i.e. a return from a function and returns are
+		  protected using shadow stack (see zicfiss.rst)
+
+		- rs1 = x7. On RISC-V compiler usually does below to reach function
+		  which is beyond the offset possible J-type instruction.
+
+			"auipc x7, <imm>"
+			"jalr (x7)"
+
+		  Such form of indirect control transfer are still immutable and don't rely
+		  on memory and thus rs1=x7 is exempted from tracking and considered software
+		  guarded jumps.
+
+`lpad` instruction is pseudo of `auipc rd, <imm_20bit>` with `rd=x0`` and is a HINT
+nop. `lpad` instruction must be aligned on 4 byte boundary and compares 20 bit
+immediate withx7. If `imm_20bit` == 0, CPU don't perform any comparision with x7. If
+`imm_20bit` != 0, then `imm_20bit` must match x7 else CPU will raise
+`software check exception` (cause=18)with `*tval = 2`.
+
+Compiler can generate a hash over function signatures and setup them (truncated
+to 20bit) in x7 at callsites and function prologues can have `lpad` with same
+function hash. This further reduces number of program counters a call site can
+reach.
+
+2. ELF and psABI
+-----------------
+
+Toolchain sets up `GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
+`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+
+3. Linux enabling
+------------------
+
+User space programs can have multiple shared objects loaded in its address space
+and it's a difficult task to make sure all the dependencies have been compiled
+with support of indirect branch. Thus it's left to dynamic loader to enable
+indirect branch tracking for the program.
+
+4. prctl() enabling
+--------------------
+
+`PR_SET_INDIR_BR_LP_STATUS` / `PR_GET_INDIR_BR_LP_STATUS` /
+`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect branch
+tracking. prctls are arch agnostic and returns -EINVAL on other arches.
+
+`PR_SET_INDIR_BR_LP_STATUS`: If arg1 `PR_INDIR_BR_LP_ENABLE` and if CPU supports
+`zicfilp` then kernel will enabled indirect branch tracking for the task.
+Dynamic loader can issue this `prctl` once it has determined that all the objects
+loaded in address space support indirect branch tracking. Additionally if there is
+a `dlopen` to an object which wasn't compiled with `zicfilp`, dynamic loader can
+issue this prctl with arg1 set to 0 (i.e. `PR_INDIR_BR_LP_ENABLE` being clear)
+
+`PR_GET_INDIR_BR_LP_STATUS`: Returns current status of indirect branch tracking.
+If enabled it'll return `PR_INDIR_BR_LP_ENABLE`
+
+`PR_LOCK_INDIR_BR_LP_STATUS`: Locks current status of indirect branch tracking on
+the task. User space may want to run with strict security posture and wouldn't want
+loading of objects without `zicfilp` support in it and thus would want to disallow
+disabling of indirect branch tracking. In that case user space can use this prctl
+to lock current settings.
+
+5. violations related to indirect branch tracking
+--------------------------------------------------
+
+Pertaining to indirect branch tracking, CPU raises software check exception in
+following conditions
+	- missing `lpad` after indirect call / jmp
+	- `lpad` not on 4 byte boundary
+	- `imm_20bit` embedded in `lpad` instruction doesn't match with `x7`
+
+In all 3 cases, `*tval = 2` is captured and software check exception is raised
+(cause=18)
+
+Linux kernel will treat this as `SIGSEV`` with code = `SEGV_CPERR` and follow
+normal course of signal delivery.
-- 
2.45.0


