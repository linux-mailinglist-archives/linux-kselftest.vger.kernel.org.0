Return-Path: <linux-kselftest+bounces-8798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A280B8B10EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590191F275E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3916D338;
	Wed, 24 Apr 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV21QbgY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712016DEAF;
	Wed, 24 Apr 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979491; cv=none; b=IhXXExXz0RYKppLErJWkCgXvAmTQPFuFgh7RO+3+XcITI7B+UHCX+5X6z1d7fHbazvOINQ37ND3bWuqa6XKXZlKLltb5xEuv2lzcIMTVsgaXwnsfEgW0efaX5gTQHsTjnrCcJjZV/jqpEyK3aFjPzCq4KFOXYRUB9mTLoBofxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979491; c=relaxed/simple;
	bh=cbwXLUzf5rGrGLbVqXwjzoKstLI0lqOQorsdMr4ifh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcVv9Q20QHW6ls3p1m2JOvNFjEs956xlRTQyWG6d4MwixULWSW8pyAkWFzpiM1p6iN/WoywZVGt2IAc1fxN4drRfDHAmq3Snmf7idCIhJLsNukIBQIrRFSMpShVMtgl8jnwY/VXIcTc5jaR85jdowg0A5W0hsuULECJFiHTFKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV21QbgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3EDC3277B;
	Wed, 24 Apr 2024 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979490;
	bh=cbwXLUzf5rGrGLbVqXwjzoKstLI0lqOQorsdMr4ifh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MV21QbgY7CCa9neeHsfXBmUaU96U5y2cNR4uGaqN+fAQTrZth8CH0yiIy3tHlqbn5
	 EpdoPcmpjff/tRFt+QfUn2/OzmqKPmXpRjqwxUXKZV2fX479Nvl3WmckRGoscSZK+/
	 PT8Oww/7rSt3UcIO4lT9BNtAdedZa4UIEjRyja3XH4gODxMg5uBvnFk3U2gp1GOJ4B
	 P8a33GWOHsiTsPRPGnDx1YI7v3iRrNozRrB3YN1b68Wl/yCeRrZwQ+rS2Wx2kdUQqA
	 4xu6kvLVCJc5JSf7Nm1UB61aGTSRJmTcc77QAR1qvHPaoVeW6OVRNyc+Gk+8A9ZHGk
	 kBVITrG4eP/qw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:09 -0700
Subject: [PATCH v2 06/10] selftests/resctrl: ksft_exit_skip() does not
 return
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-6-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>, 
 fenghua.yu@intel.com, reinette.chatre@intel.com
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=nathan@kernel.org;
 h=from:subject:message-id; bh=cbwXLUzf5rGrGLbVqXwjzoKstLI0lqOQorsdMr4ifh8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDnHfcs7mOxotzC2KjWT6KNSt9GjeEyGbh09eeWx6s
 07jh2FERykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjIbymG/1XCzxwY9meeb+v9
 9FpuwuzrOcliy8zkGTbuuyq567pZxRpGht/JNtv2f2BStYq0ve5YdrdpF5vBvMS56zib9S/MezT
 pKTMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn"), ksft_exit_...() functions
are marked as __noreturn, which means the return type should not be
'int' but 'void' because they are not returning anything (and never were
since exit() has always been called).

To facilitate updating the return type of these functions, remove
'return' before the calls to ksft_exit_skip(), as __noreturn prevents
the compiler from warning that a caller of ksft_exit_skip() does not
return a value because the program will terminate upon calling these
functions.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: fenghua.yu@intel.com
Cc: reinette.chatre@intel.com
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 348d17cb2a84..ecbb7605a981 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -247,13 +247,13 @@ int main(int argc, char **argv)
 	 * 2. We execute perf commands
 	 */
 	if (geteuid() != 0)
-		return ksft_exit_skip("Not running as root. Skipping...\n");
+		ksft_exit_skip("Not running as root. Skipping...\n");
 
 	if (!check_resctrlfs_support())
-		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
+		ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
 
 	if (umount_resctrlfs())
-		return ksft_exit_skip("resctrl FS unmount failed.\n");
+		ksft_exit_skip("resctrl FS unmount failed.\n");
 
 	filter_dmesg();
 

-- 
2.44.0


