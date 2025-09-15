Return-Path: <linux-kselftest+bounces-41539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2BB58841
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F031B2436D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 23:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB8A2DEA73;
	Mon, 15 Sep 2025 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRo1X4Ar"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC42DC337;
	Mon, 15 Sep 2025 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978769; cv=none; b=TMhHQsc4IvZEIkavvZU7GWa6U1l0B3LHKYyKXGdoMypmKm+U7ZYbtZ435It/gRVpkYjk0M/A8w6y77ppU+UPjD1ELoZfbuy5/DYp6awHWqXchroRQO3pnxcyg6gmBod2cwNVmti85kieexOhfJ98RA132xD7kUpAjYXGbn+iaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978769; c=relaxed/simple;
	bh=G2v3D4/5iR/LZHZvCBfhlozkUaTX+ywQSj46YnqYN9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CcMmdH6vfr71Bt9MZqzsdgjodL0y5HEQAbuy0p64mZS7WFMsgaHYedim4GHDzHgo1l2YpSJKj/16zw2GxAPYYEAQi9UZuXjIhXkLNw6NrunLDyi0HUsNPq1nswP1+6SvQtY+YVMyJTlxNbzdAz7G6ZL/BS/n6LzHnaQZryHMTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRo1X4Ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72F5C4CEFB;
	Mon, 15 Sep 2025 23:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757978769;
	bh=G2v3D4/5iR/LZHZvCBfhlozkUaTX+ywQSj46YnqYN9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sRo1X4Ar/g6xEfrYX3XtX3feuiLY+MCE9IdiL1Ak5X2twUfnUxckzq+7M5Sx8Aa+c
	 0dnD5dVG+rwl3Xmz1zRrCMLNOfGHG12OApcd7svJUbUyNtz1fAIUU4yKn9Lt4UhU/R
	 XEUK0xO8qMqg/p7PwHbtqtaSqqgUcfa1V2I7Kn8OKxrKFK7JMdK++6D743Qz4mkodK
	 UVdUVizVzaNg9U+csyygptdhqgV2lPkq6X+4zAdqIYvr6OOshuUQlVNRLCK6W7iE6o
	 LXwYI8q3tRnaZBBWcwW6jZriOfXftWpp24LlVc9U40N6L9xECUmop1FxdtGUvD6Mvf
	 3zPTcIV91HKMA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 16 Sep 2025 00:12:10 +0100
Subject: [PATCH v21 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-clone3-shadow-stack-v21-5-910493527013@kernel.org>
References: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
In-Reply-To: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
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
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G2v3D4/5iR/LZHZvCBfhlozkUaTX+ywQSj46YnqYN9U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoyKBp6SXuGAKv9GbsdG9OfcnquiffsOm9H/EqP
 Tgz+i0p4JSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMigaQAKCRAk1otyXVSH
 0Hk8B/9foc+l3TYGHwtcAqj72fQDiDDQ7IjXzhM2O73AjVy5ScIpQ08szxfCGkDFxfMoA/zbyTI
 H7aaCFUbxmYvRFC8azi5dxN6V47NMCbzfbMrSHBjdqEcDpQMJuEyo6DbGf6RJn4PEA+fLESj7OJ
 u1z2RPIiFyU6LT1nOdioME0Qmp1idVMUi1YXcCxCiGYziG9pOi2yi2vWur/2RV/zZPYWM3eqQb8
 QmR6OQrcUa2lEZu4v3d4OFgbKmfAiXbhHfEG/4wdBOTCinGXB3ZOJA9RIUoejo8ZudCEr0OEJUZ
 jtGskLGG2jw2kJKDzLJACfK7CsJvPOSMYCRBi3rT42fIvgzQ
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
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
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
2.47.2


