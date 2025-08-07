Return-Path: <linux-kselftest+bounces-38480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047BB1DA87
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DF01891BB8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80926CE1E;
	Thu,  7 Aug 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfHOKF/D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390A25DAF0;
	Thu,  7 Aug 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578806; cv=none; b=OFDJHWYMQMKmdpbr0QQmcWSFnJroa5wUKsrjtquzM+SJY7tQHC1NurumkCIRF3Bof7dDyItj1hFHbDZ3iad1p3TMbwS93fsSKwq47dexGiTN6zfj/XPrkX5Vl+IPX+vKyAOkFt0Hga/yEgFTHcmdLQyb6Cm8CzqSEWIGewGP4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578806; c=relaxed/simple;
	bh=5r1YbWx4Z/uGTuvOR+HsI4qgFw9dT2BqAevv0/W3OrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sdVUzhgn1C2YefCI+zcuumt6vtY1VZc6KlwDYTlWHk/mESmAUS0jlcfBvBE15K3gYcDmu6ydIHvkVy8R0YdhVIHPMRdDtiu0n6ucABeCtsz7VGq7SG3o78AFrOm4IjUuwhuB6G0B7uXEHODds5CXJ9f70K4azDahPHCdf6l6jhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfHOKF/D; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so1198804b3a.0;
        Thu, 07 Aug 2025 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754578804; x=1755183604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4z4lkaExJGQa6xUhK0oOrFgc9NGD8YfgbAanQQBaAR4=;
        b=hfHOKF/DenruaxSC07Yo2GDbkdvzgHS3QSlU7paXMEAIB1s3LIPN0zqLyj4YeIX+3Z
         V8VM2CfyjxUkhUXjnqWFSE/Gt8iccfCN8u8Uy/KimUrPJiwZKoZW9XZ4u3sF7h5TKVBh
         lsuPP4BRZ2ODDD0cg8N4LMeSmEmefOP2otqKFsBMKkfFS8z5QHQiHIV8WOry43Q+mv/F
         s2hOvy3ysRHYAZeRXnO3xEBV6B+KuTcZ98v1O9MwPSrjLcxmqGek3Sxv1cJrIidWQHD/
         /tBWx05p/xUyAD8JzidILL5rQyT+ZeVQKLenn/aL1OS0xXY2NtYjQC3htxwGQJywjycN
         fTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754578804; x=1755183604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4z4lkaExJGQa6xUhK0oOrFgc9NGD8YfgbAanQQBaAR4=;
        b=TaPeJQ8tLDEl5grp22r6e+vcbjy4j65ZqaP5OpnbLHTDczSJiLFWQ1CzctVWDasuQb
         gev904HO5du3FQFYf+QVdvYktTp8+ovmeMDhfGOO0BtGnzSQ/ueT3oXFk2g697uU9eSb
         7tz6kHE+ehBqKJXAy1yne56zOAeaxNA0exLc3iEGHok6VYyfUa+r9YPspYoWP/TEAW/u
         KRxnjbWMVkG2SUzqTqsxq37luhyLTozGuYzzAXqOgpu+Q3H332iT45lxO7dFeHOGD/KD
         ZeLyG8/J7crLp+Vk6379Q8xkdrDBOl6uEppiwQNO4wnSHkOSVO/FUJ1UuVm3S08AwKRf
         80OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDcw1Zfruir3KkXhxAhxbJy0l8su4wzCzjjPnNPn2L2f/7S19RYoRRGx7s9SGLSwX8egoCdXUNJ8XA3ZY=@vger.kernel.org, AJvYcCXY6gdWLhEJQAqJPh+HwFgupONh7UliAFRZV76E+ml14ho+WIALRbmDxbKwIrQyuNyxX9JBRj8C9QjhlEfvgtqk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pIDGnD+q+i0Pbad94LPBVXBfq2X/uftIQKpr448KW9qWtBF3
	BT3c/CW3i+8POH+Gwd/SPZrsR1i6GugnZC6xn9tndx16ioIUQ5nBHLxxU/tNg2Rlvwmte+MD
X-Gm-Gg: ASbGncsFxLKMxDeMmvpBPMj5vJeliO1NdIbhb8hmUsDBHKosYi+QOwM3Ry6P+7sTcjw
	ZA+A8XnIQYBE7VrV/e5BjnMUjSlGmclGvpMXsoPuNiMUTz7fgdtAKsXwjyAGHjKWZy942hGh+xk
	LEtC6IE19bGpO325P5oSMGyphgXK29nac46Q8OpAaJRlizcq/GwrbwgEOgM/NA8c79E/5icNCSd
	Ys5lntrxuJIQnfKQ7RrXx2Ls1zHVHvXXSOwHDy4Kl3iPLnF0gm1lzWcRQW5P4tkO7rSSw8ZeL8+
	flkxdHZ8KUm12agJ9Q4/iv/MXO1kXgeTYuY7x84QXiGizuP+pSak5XqQabJtmgu376j4Pt952Pg
	7teTWlS/BQcntsxB2t4mJybwVuLbRJG/sMw==
X-Google-Smtp-Source: AGHT+IHYKZPCa1POt5mQeBQy7unYv4f+f4aAU182ddbCIgcADG5cdt3Op31qO/JMqsF9OMB9zbtIXA==
X-Received: by 2002:a17:903:120b:b0:240:2efe:c384 with SMTP id d9443c01a7336-2429f2fe7d1mr97453305ad.19.1754578803600;
        Thu, 07 Aug 2025 08:00:03 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([213.130.142.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm188254875ad.79.2025.08.07.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:00:03 -0700 (PDT)
From: dayss1224@gmail.com
To: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Dong Yang <dayss1224@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v2 3/3] KVM: riscv: selftests: Add missing headers for new testcases
Date: Thu,  7 Aug 2025 22:59:30 +0800
Message-Id: <cafaa0b547d4a1fc45a38753038c011ea7201d04.1754308799.git.dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754308799.git.dayss1224@gmail.com>
References: <cover.1754308799.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dong Yang <dayss1224@gmail.com>

Add missing headers to fix the build for new RISC-V KVM selftests.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dong Yang <dayss1224@gmail.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 162f303d9..4cf5ae117 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -9,7 +9,9 @@
 
 #include <linux/stringify.h>
 #include <asm/csr.h>
+#include <asm/vdso/processor.h>
 #include "kvm_util.h"
+#include "ucall_common.h"
 
 #define INSN_OPCODE_MASK	0x007c
 #define INSN_OPCODE_SHIFT	2
-- 
2.34.1


