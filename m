Return-Path: <linux-kselftest+bounces-34471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E74AD1E5E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C053A7CA9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA193258CE8;
	Mon,  9 Jun 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaIZrzQZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DC2459FF;
	Mon,  9 Jun 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474107; cv=none; b=WxroWxeo1l7ILjbnqC7efPGGLSpBUniIUBdNAzZoOkP06JZnIzaylisTlxJImEoKxC3vcIOSAns1VYEHI53hKxNHZGDRPEqo15KS6qOFo3fxZn6nA/rDPNrU7N2OqxF0qqNgAP5xWGcot6JFckvECAImiVEl1dThLECgPuBakoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474107; c=relaxed/simple;
	bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssBIsvFibPnZZtN2qt07M7He7+9EAbput5vLdBYgQ98kXx3NiDZ6v61RXyquOARvNr+ZF5Qh7xeDxME+gwQE1g8TaMqhQMveVKdNhXpep+GRnqgCVa2Np571MMvBvQ3yWcpVwRI4nG8fL5w0CAGxCB/B01d5pjo2MFZshWWgqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaIZrzQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B856C4CEF0;
	Mon,  9 Jun 2025 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749474106;
	bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IaIZrzQZ+uv1kKDldsV/EvuATu9K0vsuv+7o0wgjGCihOxzLzaxF50T8P5acDCXt9
	 IyLgZIMB4aAP9c3psnXpFHr6jgs0nDZruT2qXpk7FIMSEKlwDACd5s7xshrIXK9dtC
	 eAMD91M3/JqYmjiBiLWea2DBUzlecYO9cJbevl9XW4QTvMI2YmUZcOxwDyhMi8wFfU
	 KtB6rcAPCCk+InQbnSsF26+d1xINEemGGnczidSU7cy6B+YfsoQxsnAM0bipOoj+IC
	 vUuCBR58EBCX1BmnGYUIWHvqGfPd2a5rzVF8/AOPpZMX3y0S7cbIq4Jlkdtm7LDUC2
	 dYHeXTNQqmOBg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 13:54:06 +0100
Subject: [PATCH RFT v17 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-clone3-shadow-stack-v17-5-8840ed97ff6f@kernel.org>
References: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
In-Reply-To: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRtsS1oPeDocMgm73asbkgrJDqf/dmIf1MoyVCP7l
 VlqN7wmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEbbEgAKCRAk1otyXVSH0H38B/
 9+FjvMlTH0jTGI3KZdTd8CvLC+lW4KPtL6YHiZaQ94w5KM+M1BgJXCP4JNn5dCxIo04Zz+hxiTnJrs
 YLGFZdbPhP2FpRu7udvb8mGzVTrQKSUpHptHWRdTkrF5zbsGV/AiEwuYUOOPUP69JoLUsvJ/f1/kmA
 pb74UanyIqwuZXsso50Rdlz4OcIJHcAbqklNxFSkFBUePUd/dNX96IRSAR6jAmAkz0I0pXI4/7ntYH
 zFMMaZIQ4BHBexS9M2ArJjmcsZ28jO+0JeZztPqApTyox9QZ6HSALFbkcR9gGoZKVBFgU2QIH8o+D1
 YutT4Wxxubo1mfvGa6WBW36wz+FPAg
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


