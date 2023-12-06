Return-Path: <linux-kselftest+bounces-1289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80132807117
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 14:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BCFB20E21
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FCF3A8D8;
	Wed,  6 Dec 2023 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TkBq9SVl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69D3C3
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 05:45:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c1e8458b9so909815e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 05:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701870299; x=1702475099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyzTJBorqo0srDT9PjO1S/0u5d8jIirct/7xXW8mDxs=;
        b=TkBq9SVlHgOyTYNulhEvBJfN2a0ilMQbVFJO4AfXftWZgACwvz64beNgOOf+tPP16+
         CdQIiVPkTUUqaCOb9MX6TARKKH97ax3uG8A5NK5SE2PKOInfiRJfxsL8RNTZbBQ0Wu2g
         BFdi2cq5wz3rL6kBzFMdOnnEJiWWir+R++gk2wwZqZUSIZGPANDy7A+Y5MQz/E/NeMJF
         3cKPMPPY9dRmoLDl/tO4RTNVcnkWGcWCj7UXxd6Q7GC94vf8tj1gcZp8utkJriu2vURm
         ec3rkjBITQUeJmdYScZUfKZsxxRQ1VoRABRyywPBln0/rqtPMuSc+3c6b/O4+dKPQ7LL
         U3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870299; x=1702475099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyzTJBorqo0srDT9PjO1S/0u5d8jIirct/7xXW8mDxs=;
        b=XjBU8+owyBU6B8OFbkAJxo/1WA2bUWV2iGmwgRAkMGLaKVfDOAZdPOsDKFv7iPeogW
         metUp98DXYd+YQX9mmfYC7Tf7st4xrB6GcRsh8S2aqv7d5MtCk/DBLnJ1rZTBIkWYc7y
         m+1Y2V9JDW55lYZkGcUGU3Fb8kGlw5yYS/rwRZIU3SrHfp5GS/9KlKKJZbbRBpTfyNET
         1UhnpYAath7tMv6QHl9gDEkxJNFI3JgywNj2XRsfajhuklXS93ZVeGx75GrONtGgKSMP
         DjAzA/IuIjDlFUr1tiuVniyvf/KO6FJbo6b2RXYIXUH+YefF+DPiSMKTkCdHVZOSwCfB
         wVlA==
X-Gm-Message-State: AOJu0Ywu4dij41fEGHHBOfuJnmQfgWV46itUAX9bfGsmo0Nn5i/Ygo4A
	wBckObxagfiUTNU5Zqgw83ccNg==
X-Google-Smtp-Source: AGHT+IF1KsY78QMc/kA7AJTCm+aEKTPTbbi49+F+g/SfZbZDdgaSvKaIMpIVWDt3w2IDJ8fli+6xJA==
X-Received: by 2002:a05:600c:1387:b0:40c:b81:c640 with SMTP id u7-20020a05600c138700b0040c0b81c640mr1410826wmf.0.1701870299133;
        Wed, 06 Dec 2023 05:44:59 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:68da:101e:d3e4:630b])
        by smtp.gmail.com with ESMTPSA id hg10-20020a05600c538a00b0040b398f0585sm22258222wmb.9.2023.12.06.05.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:44:58 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v2] selftests: sud_test: return correct emulated syscall value on RISC-V
Date: Wed,  6 Dec 2023 14:44:37 +0100
Message-ID: <20231206134438.473166-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the sud_test expects the emulated syscall to return the
emulated syscall number. This assumption only works on architectures
were the syscall calling convention use the same register for syscall
number/syscall return value. This is not the case for RISC-V and thus
the return value must be also emulated using the provided ucontext.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

---

Changes in V2:
 - Changes comment to be more explicit
 - Use A7 syscall arg rather than hardcoding MAGIC_SYSCALL_1

---
 .../selftests/syscall_user_dispatch/sud_test.c     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b5d592d4099e..d975a6767329 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -158,6 +158,20 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 
 	/* In preparation for sigreturn. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	/*
+	 * The tests for argument handling assume that `syscall(x) == x`. This
+	 * is a NOP on x86 because the syscall number is passed in %rax, which
+	 * happens to also be the function ABI return register.  Other
+	 * architectures may need to swizzle the arguments around.
+	 */
+#if defined(__riscv)
+/* REG_A7 is not defined in libc headers */
+# define REG_A7 (REG_A0 + 7)
+
+	((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A0] =
+			((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A7];
+#endif
 }
 
 TEST(dispatch_and_return)
-- 
2.43.0


