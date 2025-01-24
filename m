Return-Path: <linux-kselftest+bounces-25061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A0A1AE5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 02:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8703A99CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 01:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586961D63FF;
	Fri, 24 Jan 2025 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QM5Znsjg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EBD1D5172
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683933; cv=none; b=ZtIHeRE1fDU1oqzHUF4/t3QLbWGxt878Q2eQdVC90wxH+nFGMXP2+F/titNBHgDHTRl7V331YzpdP7gzdLE5sfJD1g5uFGkgdGnwYPFfT6256O+DzuwHTSh696pHFrLhb6tLd3An1VTVE58Vj6HLH13BDV00EpZ0+xhG1YS53Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683933; c=relaxed/simple;
	bh=sh2unf8Xeoi6Q+VSDQ1CR6UU8KtcNX5rCfAveB7F7g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjzmTAaFPA1tjuC4rIQ+JD/9VZA3MR686sbpxMyw2AyZNVkE7FlygHVgECQl5+Wnd0/6sb6TlOAT9AEgYTtE5CIi9iTPDyxtHSGVt/bfsCwsTZOfSiV7Q8OhIdzvwVgrc+Hf1PkgvOECkDOjJRSolDlLi2xaoLMVFYG6bExRpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=QM5Znsjg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so231652085a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 17:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737683930; x=1738288730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRHySpG58abjuaHF+3dQ690cqYR/gs8q/AgyFnz04uw=;
        b=QM5ZnsjgRpfmjA2wejPdBLDlwknbe41yevnkg0RAp6+D9/52YSs3VwhNdspOHW5dMs
         sYD7zYueoMdANFOKNaDTCz96Ml9TCsImM7mbwnJ6CT7q6Pti220YKutJDQvKp8RaDO/Y
         wAjLHPk40ApzSeJw8UQqTxr9ej27gYBfUoWAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683930; x=1738288730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRHySpG58abjuaHF+3dQ690cqYR/gs8q/AgyFnz04uw=;
        b=u/EXYcPYP/R2VZdUknSx7xqyLkJXXYpa/jFXlsnn21oeCjJ9oyPBZE74KNtVqwz3kM
         s2o8ZQ6e4Klaa4wMMUH4QY+lJy4WM1k6m1oHbLNfQIEh+o9BhQ7fgXHYr0qxgXtmRbo6
         4RJ3dwv4NbSHEn/we+5DDx+iKjm4ec7QEG+fdH/CB1drWw+rAc47OCsQWxBh/jvswVFr
         NQeOweEPqhvi/vKRNDWR5m/plH15ujx/3HHaLZfc1C8iQcWav2Isivb5xKB6TGrve8PQ
         gUJXCO/ieujXyfUU9uv+DC3kn6Y1bAf3Zgap/9Fb/di6rHH2k5JALfoCyh+IVGerrGVt
         lj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKVvFJtglyvkeyLFG6baBBwhiim6tICcmj6PswUb1eeRVbvfat4qmSOB+4jktm26VCi1DoBMYNaFx5u4NG01s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Z0TC+Az6w+9BT7ByuZXyXmR4Zm/9VM86L1aacq6L1rCXEYbk
	NzvtH7JEVRO4N3Cdzhi49SIpaaQBmU8QW/Hp3tTk5w6B4i5uYPUNwT1Wi2u94lI=
X-Gm-Gg: ASbGncvnvrCoKpvGRjbP275E8xS3SRiJ1Pu/A9+fSa+ukkK4g6xkfR39by03/S34Ste
	1iFRXWe15VQgOBkR/sSjm9pEbHqCXzy4UN3/z6zvjPvlK4UL9g1eKaQPATjD3NjqsQicD6r6JVo
	KmMGf6IFxAoNDq79iYQ5wPejHZxfr+bZ/QRxsauO7loPkJrUrNB/t+yVPt+/RIxRgS62ZkvkqLs
	Faajdb7RRRJ/VCLOU5B+t8owPh1QmE05dZRbATKgruyOilHVPpogIDKN8V/+1j92uJmKgGGL9Yo
	/9AF63lSPTTzDJZ3Lc1r6yNUzWfYjJGLDtilA+KDQZmt/SQ=
X-Google-Smtp-Source: AGHT+IHaXKdjk1Buyn6a6Xv4FIqoSmZ7YVk5544zLuI+aKxxiCP2bXeVGPwOfxrj/Gksc+jk8pGH9w==
X-Received: by 2002:a05:620a:440f:b0:7b6:7a87:744a with SMTP id af79cd13be357-7be631e712amr4443518985a.5.1737683930638;
        Thu, 23 Jan 2025 17:58:50 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a5fbsm44741985a.31.2025.01.23.17.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:58:49 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 3/5] rcutorture: mkinitrd: Allow to run optional commands passed to it
Date: Thu, 23 Jan 2025 20:58:34 -0500
Message-Id: <20250124015836.732086-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124015836.732086-1-joel@joelfernandes.org>
References: <20250124015836.732086-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embed commands to invoke into init.c via mkinitrd.sh args. This
allows init to spawn a child process running the command with the
required arguments.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../selftests/rcutorture/bin/mkinitrd.sh      | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index f3f867129560..4ba5e962e3cf 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Create an initrd directory if one does not already exist.
+# Usage: mkinitrd.sh [command [args...]]
+# Example: mkinitrd.sh stress-ng --cpu 1 --cpu-method matrixprod --cpu-ops 1000000 --perf -t 5
+# Note that command/args are optional.
 #
 # Copyright (C) IBM Corporation, 2013
 #
@@ -25,7 +28,9 @@ echo "Creating a statically linked C-language initrd"
 cd $D
 mkdir -p initrd
 cd initrd
-cat > init.c << '___EOF___'
+
+# Generate the init.c with optional command
+cat > init.c << 'EOF_HEAD'
 #ifndef NOLIBC
 #include <unistd.h>
 #include <sys/time.h>
@@ -33,6 +38,29 @@ cat > init.c << '___EOF___'
 
 volatile unsigned long delaycount;
 
+void run_optional_command() {
+EOF_HEAD
+
+if [ $# -gt 0 ]; then
+    # If command provided, generate run_optional_command() with the specified command.
+    # We use printf to generate the command and args.
+    # Example: echo $(printf '"%s", ' cmd a1 a2) gives: "cmd", "a1", "a2",
+    cat >> init.c << EOF
+    pid_t pid = fork();
+    if (pid == 0) {
+        char *args[] = {$(printf '"%s", ' "$@")NULL};
+        execve(args[0], args, NULL);
+    }
+EOF
+else
+    # If no command provided, function will be empty
+    echo "    /* No command specified */" >> init.c
+fi
+
+# Add the rest of the program
+cat >> init.c << 'EOF_TAIL'
+}
+
 int main(int argc, char *argv[])
 {
 	int i;
@@ -43,6 +71,9 @@ int main(int argc, char *argv[])
 	for (i = 0; i < argc; i++)
 		printf(" %s", argv[i]);
 	printf("\n");
+
+	run_optional_command();
+
 	for (;;) {
 		sleep(1);
 		/* Need some userspace time. */
@@ -62,7 +93,7 @@ int main(int argc, char *argv[])
 	}
 	return 0;
 }
-___EOF___
+EOF_TAIL
 
 # build using nolibc on supported archs (smaller executable) and fall
 # back to regular glibc on other ones.
-- 
2.34.1


