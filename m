Return-Path: <linux-kselftest+bounces-8799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59BB8B10ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21A528A467
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F916DEC9;
	Wed, 24 Apr 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEtFpn6D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D216DEC0;
	Wed, 24 Apr 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979491; cv=none; b=H4suWT27rq0SwhmXA51PSal1G287/Bm21u0dBxMKwyQh54VHjb8GDMyGTphIJgqYl/a8SBwhRYLW3XwM3YnP1mwOLdtcPATCvdUasJYmzaDPaN/BRp6DGObyDaxVSYhGe+HCihSAnRWV7EfiagQHs2mDiEpBwhbrYJJ5mXyOXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979491; c=relaxed/simple;
	bh=5bcOCoiv7z9bfpXac60/pYpWDL3JKCADJVEOACSTLEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VdAdGxO4aILsrX107PNV2Jmb+UpMmbKLYo1xxF2VGD3UGGdSEbS0V1Pdxz2cvkOzxM1OeoEhb2oim0/4t5KsqhwbIha8YScnRvFOFlNk69WaY0RZVSBI1adfT6nBRIfGSgUTIg4a/FCTnLCdfwyNnILwMBVYfX+Wi1CCUC4XSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEtFpn6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8BFC32783;
	Wed, 24 Apr 2024 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979491;
	bh=5bcOCoiv7z9bfpXac60/pYpWDL3JKCADJVEOACSTLEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KEtFpn6Djbjd3G8efcGjKrZ+LHJkH1roOgg0pvoRMuf6FhZhZ28z71t/YXJNIqcij
	 sabee9Gkh/XXWXgokwh/Y/iARR5EgmP52up2YrmrtrXbjO6DNv1vKTy0zpMzp/UXBH
	 fMxx5/NA4P7Ud3ObdZsLVnU79HAPFNMxBRsyUXuRbYTbOhsW+JnCh9fGoHIYu5IdYR
	 Mm1z2hzLFeVF73pLL6PA7q9CYoEqsfsuQjDt4HdzNo6sGbhWSYknaPgbr81UhqG/8z
	 LeVhcyZWW+39UmH2Bm29fvMuaUBOns5O+QfTeuPUa0ulBYX8CyEfFfPssXYgWI5lt/
	 mnDlw+rUha5XA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:10 -0700
Subject: [PATCH v2 07/10] selftests: sync: ksft_exit_pass() does not return
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-7-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=nathan@kernel.org;
 h=from:subject:message-id; bh=5bcOCoiv7z9bfpXac60/pYpWDL3JKCADJVEOACSTLEc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDnEN/026bMynTmIPjTmzklVk3zyzyo0hh1Vv2iq8V
 gjp5wvoKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABOxlmf478F3/8oL2+Dc+ULd
 XYKiHKU3ThRfXWM1X9FtkVb24fOdLAz/FJfv+C2/0GbChnc/5J2+XuIu0vzOk1T07ki/+Z2Ldsu
 n8wEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn"), ksft_exit_...() functions
are marked as __noreturn, which means the return type should not be
'int' but 'void' because they are not returning anything (and never were
since exit() has always been called).

To facilitate updating the return type of these functions, remove
'return' before the call to ksft_exit_pass(), as __noreturn prevents the
compiler from warning that a caller of ksft_exit_pass() does not return
a value because the program will terminate upon calling these functions
(which is what the comment alluded to as well).

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 tools/testing/selftests/sync/sync_test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sync/sync_test.c b/tools/testing/selftests/sync/sync_test.c
index 414a617db993..93db5aa246a3 100644
--- a/tools/testing/selftests/sync/sync_test.c
+++ b/tools/testing/selftests/sync/sync_test.c
@@ -109,6 +109,5 @@ int main(void)
 		ksft_exit_fail_msg("%d out of %d sync tests failed\n",
 					err, ksft_test_num());
 
-	/* need this return to keep gcc happy */
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }

-- 
2.44.0


