Return-Path: <linux-kselftest+bounces-39334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176B7B2CEAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 23:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE0E7B1E8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 21:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E753101BD;
	Tue, 19 Aug 2025 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW0+7yIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BD24C68B;
	Tue, 19 Aug 2025 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639768; cv=none; b=R8ud/An3BLIwUxMbqAH+gm8ERl711mgxUBPMWY7oUBTGiRlYwZOiZ/X59VUdWYjruFAdq49r48xtl9LF2FAoz0GSF5ZP0gF6j2QujVKlxzGEkfAZZIp5EmKW5bOSdptPX4ecTXRJSlkNziQoShFqJeOF6y8BuqzU5njWkL4wT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639768; c=relaxed/simple;
	bh=HaC2GMXg8TCT8SsM2x6lc4Qo6koTUzkaO+mYZ1UMJ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3+izW69gkXUBjpKykXD79KRkmfUAbKp0LQhoJye2AV15HavuCIqy+zIHObHHBOoWfUk8PHziEev+k+iEm4hPkZnsuAnvry78AeXpCMTTPXxWe5ow89Xkv5KvsDHXnSA2dIZP2mQk4wPiD6GsvUZNJeHZM51fDM0bkfhP7YKoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW0+7yIU; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70a928c3686so3071146d6.1;
        Tue, 19 Aug 2025 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755639766; x=1756244566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ves8rm5p4JdLczWmm2YLAstt4OmqCQiHNYiBWXA/b9E=;
        b=QW0+7yIUDYDDKQhoTegJHmdKR4r8wQ7MBpBdCJEIBAbiKUG4nVAAQn7Gvo8j62NKWf
         FlMhCqniM7cu0s0ty3qFdfiPe2cU5eA1DX+l4ZJC3IH0uErHt5+QmCZY13Meb0ELOfOY
         JXc3bepsROErdPQjkW+gkJBT9TTf8okvNLQtao+uAoGlI+9wguyaLR0scgJwUCVIaSa9
         MIeQKMxD0RV5ys9Fixu6yk+LxxdKClqBewe2vT/OJ1/wxps99VK49Mh3W54c7xJukH/n
         Te0pib1Frg4o3LjRi1cEVrWJC+qKustnVbp8L9vLl4HHEA6FIRhaEDvhU+hRC4rlwv3N
         4YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755639766; x=1756244566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ves8rm5p4JdLczWmm2YLAstt4OmqCQiHNYiBWXA/b9E=;
        b=jzgu3yatVNQBy4L0mSshcIP4C6S9EzvJEKcugdZ9Ax74t39eBtabbbcK7Y07/oeqqJ
         7JQnKqdVjqmZpWQuwuIeglswKOLvmFxkp0HeofaEK0mLEbTZnea5MBKsehPdAehov3Lm
         DShfTUebfbrRtJuQusJxQhyzqzoujGNdE7UpSwjMgmbNxdPcjY45P2tTlyyu1uFochuY
         kfAxckJQFUTNgaQib1qasPCBE9Jele/PzsbjhsowhSQsFj/mP5c17+/Pp83+ID39Yxqx
         5C3m+/bDPa8LLgT7k9YlLE9M6gKDicPSoCFw+tcA0Ahaz8DTIKWwTkIYsqOHOdEt/CxA
         rF2g==
X-Forwarded-Encrypted: i=1; AJvYcCVCttooVdytTPn4/9Geq7SgpDlU+HdhzBZTToUjhTKo1NNpWb7mhfR6AsYaS64RMc6DVKmUp66EruZq128=@vger.kernel.org, AJvYcCVUYQmbcQN7Sdm59c57akkSoToIWT+vixy9U5KmS/xKwEO9WdlCepv6PdwtrCS65R2Nv+wsEElifpDsaC21Oa3y@vger.kernel.org
X-Gm-Message-State: AOJu0YyXG+/qN8G69kg2T36qmi361wlcpaVSwE0iaR9vp9CXndDk5R81
	LWhIm2w41FeASIOo4J+1NMOWzLWAyYlJPIP6dfPoxLqi9zxRfOtvt/gr
X-Gm-Gg: ASbGncvEkDIW0VD0QNrlAkvPllRC+wtaahKYupInkpDrCn/09MNxMQC2fZKTwO/vXD5
	jXXdfWUzjk4ZzD0sCYLa/J/eTdvQLOouxie3Jg3fbOHmSb4srk5D539DrTOZ3g/uRCMQTlGwOKb
	paCwWMFDQek49Cx+IPYc+IeF09WtQbVRP6bO+H4dpKsKo2nbLgCSsvdyirZxt1t3ATpSbAuKoOy
	ojafhCiTRjvPcpyYYQ8V/U1ad5bzhoXzvLJTTXlEPzZN5ydbtsPMsXFA3c+JrZf5Bkqtiml0qQi
	dsibBxNrAn/9s/q9gDQpta1QHPk+DN/sGyP2P1K2Fs1F9x9N6cJy1Rib6YwWRlgrKmahtV8f3Qi
	VReaYi21ptMVsGMQBtcyyZ/nZgci7pWFl97DPsLXITH4=
X-Google-Smtp-Source: AGHT+IGukX69pdgdIaCow8FyAR1dkPWBNGHo1bDEaikElvOMMvGz5VVwFJxZVoZZIBe562vlkrz7eA==
X-Received: by 2002:ad4:5dc6:0:b0:70d:6de2:51a2 with SMTP id 6a1803df08f44-70d75f9b4c1mr14140156d6.28.1755639765998;
        Tue, 19 Aug 2025 14:42:45 -0700 (PDT)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba93738d0sm77075476d6.55.2025.08.19.14.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:42:45 -0700 (PDT)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/x86: fix coding style errors in test_syscall_vdso.c
Date: Tue, 19 Aug 2025 17:39:10 -0400
Message-ID: <20250819213911.174167-3-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix 68 checkpatch errors in
tools/testing/selftests/x86/test_syscall_vdso.c:
add void to function definitions without parameters
fix whitespace in charp array definitions
fix whitespace in printf statements

Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---

for the whitespace errors, attempted to maintain the “prettiness” 
of the charp definition and the printf statements

 .../testing/selftests/x86/test_syscall_vdso.c | 59 ++++++++++---------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/x86/test_syscall_vdso.c b/tools/testing/selftests/x86/test_syscall_vdso.c
index 8965c311bd65..ee98c3cf4f56 100644
--- a/tools/testing/selftests/x86/test_syscall_vdso.c
+++ b/tools/testing/selftests/x86/test_syscall_vdso.c
@@ -116,10 +116,10 @@ void print_regs64(void)
 {
 	if (!kernel_is_64bit)
 		return;
-	printf("ax:%016llx bx:%016llx cx:%016llx dx:%016llx\n", regs64.rax,  regs64.rbx,  regs64.rcx,  regs64.rdx);
-	printf("si:%016llx di:%016llx bp:%016llx sp:%016llx\n", regs64.rsi,  regs64.rdi,  regs64.rbp,  regs64.rsp);
-	printf(" 8:%016llx  9:%016llx 10:%016llx 11:%016llx\n", regs64.r8 ,  regs64.r9 ,  regs64.r10,  regs64.r11);
-	printf("12:%016llx 13:%016llx 14:%016llx 15:%016llx\n", regs64.r12,  regs64.r13,  regs64.r14,  regs64.r15);
+	printf("ax:%016llx bx:%016llx cx:%016llx dx:%016llx\n",	regs64.rax,	regs64.rbx,	regs64.rcx,	regs64.rdx);
+	printf("si:%016llx di:%016llx bp:%016llx sp:%016llx\n",	regs64.rsi,	regs64.rdi,	regs64.rbp,	regs64.rsp);
+	printf(" 8:%016llx  9:%016llx 10:%016llx 11:%016llx\n",	regs64.r8,	regs64.r9,	regs64.r10,	regs64.r11);
+	printf("12:%016llx 13:%016llx 14:%016llx 15:%016llx\n",	regs64.r12,	regs64.r13,	regs64.r14,	regs64.r15);
 }
 
 int check_regs64(void)
@@ -179,7 +179,7 @@ struct {
 	int sz;
 } sigmask_desc;
 
-void prep_args()
+void prep_args(void)
 {
 	nfds = 42;
 	FD_ZERO(&rfds);
@@ -201,28 +201,28 @@ void prep_args()
 static void print_flags(const char *name, unsigned long r)
 {
 	static const char *bitarray[] = {
-	"\n" ,"c\n" ,/* Carry Flag */
-	"0 " ,"1 "  ,/* Bit 1 - always on */
-	""   ,"p "  ,/* Parity Flag */
-	"0 " ,"3? " ,
-	""   ,"a "  ,/* Auxiliary carry Flag */
-	"0 " ,"5? " ,
-	""   ,"z "  ,/* Zero Flag */
-	""   ,"s "  ,/* Sign Flag */
-	""   ,"t "  ,/* Trap Flag */
-	""   ,"i "  ,/* Interrupt Flag */
-	""   ,"d "  ,/* Direction Flag */
-	""   ,"o "  ,/* Overflow Flag */
-	"0 " ,"1 "  ,/* I/O Privilege Level (2 bits) */
-	"0"  ,"1"   ,/* I/O Privilege Level (2 bits) */
-	""   ,"n "  ,/* Nested Task */
-	"0 " ,"15? ",
-	""   ,"r "  ,/* Resume Flag */
-	""   ,"v "  ,/* Virtual Mode */
-	""   ,"ac " ,/* Alignment Check/Access Control */
-	""   ,"vif ",/* Virtual Interrupt Flag */
-	""   ,"vip ",/* Virtual Interrupt Pending */
-	""   ,"id " ,/* CPUID detection */
+	"\n",	"c\n",	/* Carry Flag */
+	"0 ",	"1 ",	/* Bit 1 - always on */
+	"",		"p ",	/* Parity Flag */
+	"0 ",	"3? ",
+	"",		"a ",	/* Auxiliary carry Flag */
+	"0 ",	"5? ",
+	"",		"z ",	/* Zero Flag */
+	"",		"s ",	/* Sign Flag */
+	"",		"t ",	/* Trap Flag */
+	"",		"i ",	/* Interrupt Flag */
+	"",		"d ",	/* Direction Flag */
+	"",		"o ",	/* Overflow Flag */
+	"0 ",	"1 ",	/* I/O Privilege Level (2 bits) */
+	"0",	"1",	/* I/O Privilege Level (2 bits) */
+	"",		"n ",	/* Nested Task */
+	"0 ",	"15? ",
+	"",		"r ",	/* Resume Flag */
+	"",		"v ",	/* Virtual Mode */
+	"",		"ac ",	/* Alignment Check/Access Control */
+	"",		"vif ",	/* Virtual Interrupt Flag */
+	"",		"vip ",	/* Virtual Interrupt Pending */
+	"",		"id ",	/* CPUID detection */
 	NULL
 	};
 	const char **bitstr;
@@ -320,7 +320,7 @@ int run_syscall(void)
 	return check_regs64();
 }
 
-int run_syscall_twice()
+int run_syscall_twice(void)
 {
 	int exitcode = 0;
 	long sv;
@@ -337,7 +337,7 @@ int run_syscall_twice()
 	return exitcode;
 }
 
-void ptrace_me()
+void ptrace_me(void)
 {
 	pid_t pid;
 
@@ -356,6 +356,7 @@ void ptrace_me()
 	printf("[RUN]\tRunning tests under ptrace\n");
 	while (1) {
 		int status;
+
 		pid = waitpid(-1, &status, __WALL);
 		if (WIFEXITED(status))
 			exit(WEXITSTATUS(status));
-- 
2.43.0


