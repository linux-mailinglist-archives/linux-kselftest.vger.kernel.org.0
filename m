Return-Path: <linux-kselftest+bounces-30374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42469A81508
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 20:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD534C5BA6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4824887D;
	Tue,  8 Apr 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s15mol1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8489230BF9;
	Tue,  8 Apr 2025 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138258; cv=none; b=bcqV8VQIX8WSzCzN8zcIFKnuZyLZxqJ6GPuvv2Qq9TA5cwEO98eISgx0QWHcpECc5HZqg1MW0GJ8vpQLLSTak/6LG5oGmt0G0RwA/5X3vPHdVu5tNkg9MHxZKlZNxc+m9WMXsDO4k1+zWkjAy7mf+2kbsZ+KQIymi1wVucgh2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138258; c=relaxed/simple;
	bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iclx7Xd50VQOonM/wMPto6RWk74HFZWSGPkOXFDDdeZ+3DDzOqToFB2lW7egQ4vc5AsE5ucC/MSRD9r02G9Zq0Nh8QdmPvFm2PV/JjzwI4WxBH3kUrovsINJ6mPDhssVT0Jr22sI6SeNPIf8CjMbAaFZb97Z4y9XYT93PBDpzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s15mol1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7DAC4CEEA;
	Tue,  8 Apr 2025 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744138257;
	bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s15mol1uA7Z25zXM/8ODeDCI13jtMbNRECDqmJyNXlm0ycRByCdwckfRL3/63Ofrb
	 oEJjTJUeQM+Z7v9X0ey5HIozf59f0zqOFhHtBB+MQkvkylsS/Gn0y3aJVDDUqEa1CC
	 PGNPqv7VXHel4Wjdf4FfCTpaj1bI3mTX3wPD+qa5+svTEg0WsNUvFbZQBBvDk4XSyX
	 4s2qybllDEbn22LZdtNoyfEkS53s9rgjio3PG8TCT1Bns8cf7iJDZVCv+E7uOOuDWV
	 EWSWKIcM6gwYmI0efdhoPx34g7CXi+UA5nHxizR2wrATpQJ+7jejDqJ9LTwHh/TZws
	 o9QI8stLfncGw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 08 Apr 2025 19:49:45 +0100
Subject: [PATCH RFT v15 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-clone3-shadow-stack-v15-5-3fa245c6e3be@kernel.org>
References: <20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org>
In-Reply-To: <20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn9W/qsXFcBmtSU2fNjqhpFuycLbaqHNAvW1e/ZFtL
 YsmbfIGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/Vv6gAKCRAk1otyXVSH0NE1B/
 9tlQB01aHygXB73eQ3RbIBxf74OCyit3DJw7CGC215xTJSlbRlFbG5hYR2CcQchUQoq5L8ObDN+LmY
 dJ7uBnlqstpslYhN6gUbs24WQrpDYjDm1IRqPenlPLWt1+WaSenGwbHDHB1vNW8bz31cmw+WiPaoIh
 +C5CXEBIgrHf3o6dTpdyP8aB4+E+vrE8dtwWZuV4JQgy3LXBDETtfPCL2lLx1CFPWkZF86GjnjaEf0
 KaObT0c270s2pqyt8dnrAFs9ybHYg5HNdXkWTWYyCejn+ouvsrAAK3FY3shWSmnmY02vbWG4BZWfBa
 34rQoJ9zBYts605lxt4Ym4Yh2jPd+G
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since there were widespread issues with output not being flushed the
kselftest framework was modified to explicitly set the output streams
unbuffered in commit 58e2847ad2e6 ("selftests: line buffer test
program's stdout") so there is no need to explicitly flush in the clone3
tests.

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_selftests.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index eeca8005723f..939b26c86d42 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -35,8 +35,6 @@ struct __clone_args {
 
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
 {
-	fflush(stdout);
-	fflush(stderr);
 	return syscall(__NR_clone3, args, size);
 }
 

-- 
2.39.5


