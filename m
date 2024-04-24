Return-Path: <linux-kselftest+bounces-8794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A68B10E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B04D28B273
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA816D4DD;
	Wed, 24 Apr 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR1ZQjoi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D516D4D3;
	Wed, 24 Apr 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979488; cv=none; b=Ip8A1DmCaE1LQ/isK4zXDzNjWsVT5pVsUDNs3FI5+VhBXTVya21KWbP4cWUI0/RXJ8ANLvrjmkgLB2iWwi4OdtIjDiB+SJJlCwr6Y0Q10+DherS4x4wUTcQHF2IwlrZQKlq8067CHPg0aMJQF/p7kNUiqfehYJA8+FoWnaZZ448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979488; c=relaxed/simple;
	bh=PR3dXKncRxSGgqWjw2pWaxvlcjI/h7WoRJup2DkHofg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhkUY/GuGH9gbyZI+s6Sc0/XacEstCHIOZ19opCLoPUQGjut8irimHCXw5gKLB0RvH74puXH2eZJJzmQ1zI7lP3vvz94TG7NP6jdme8Lz1hYX5dl71ItiPN1x4KTkSGl+fC1NSFMDQPg9mVQj7dHz2M0Nm3a5nv5uCz2DWw305c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR1ZQjoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE03C3277B;
	Wed, 24 Apr 2024 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979488;
	bh=PR3dXKncRxSGgqWjw2pWaxvlcjI/h7WoRJup2DkHofg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XR1ZQjoiqh/sHcf+Xk1GKpSbPeoaoDW7wI5XVnpOdx9f+z+zjuODRPHlwu6Q1CEED
	 HSngUM0MNHOnID7XIL3Lqjewemvv1SVd9OStX1UlBuFBQ/4gaIyJ8EHyiv/+846KhM
	 +qjFoSXzG+e8LY8lvgryCdmgJ7zKyLEeh1GlPxrTvq7YaHOhfaa94mHANk5b+HN1rx
	 nBErRGm7TbRKmDI6/lUP3R3hQydpQof77N51vxieqKyD49gAz/dUw4s8hPHfrWL9xQ
	 hZNLpHkNyUr95c3fEK46gh6LIwayfJMj3b5JmA0JmVc7R/8mbfaEzRBvuByl4pu+A4
	 CuMspbOiT4x/g==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:05 -0700
Subject: [PATCH v2 02/10] selftests/ipc: ksft_exit functions do not return
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-2-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=nathan@kernel.org;
 h=from:subject:message-id; bh=PR3dXKncRxSGgqWjw2pWaxvlcjI/h7WoRJup2DkHofg=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDrGT9JWUYtlUv17ZdL3GfdqlPOtN1z44JH/JCf4m1
 de+rkK7o5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEzkQT8jw57kGGFf1XvshSyT
 xO3KPR8Y2H6ba9+3/1ZZdMov3fScRIb/3lZp7Ps/uxzbaNf8VnfL/O+72AWuSPifzqjTn/xj48V
 cRgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn"), ksft_exit_...() functions
are marked as __noreturn, which means the return type should not be
'int' but 'void' because they are not returning anything (and never were
since exit() has always been called).

To facilitate updating the return type of these functions, remove
'return' before the calls to ksft_exit_...(), as __noreturn prevents the
compiler from warning that a caller of the ksft_exit functions does not
return a value because the program will terminate upon calling these
functions.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 tools/testing/selftests/ipc/msgque.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index 656c43c24044..c75ea4094870 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -198,13 +198,12 @@ int main(int argc, char **argv)
 	struct msgque_data msgque;
 
 	if (getuid() != 0)
-		return ksft_exit_skip(
-				"Please run the test as root - Exiting.\n");
+		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
 	msgque.key = ftok(argv[0], 822155650);
 	if (msgque.key == -1) {
 		printf("Can't make key: %d\n", -errno);
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 
 	msgque.msq_id = msgget(msgque.key, IPC_CREAT | IPC_EXCL | 0666);
@@ -243,13 +242,13 @@ int main(int argc, char **argv)
 		printf("Failed to test queue: %d\n", err);
 		goto err_out;
 	}
-	return ksft_exit_pass();
+	ksft_exit_pass();
 
 err_destroy:
 	if (msgctl(msgque.msq_id, IPC_RMID, NULL)) {
 		printf("Failed to destroy queue: %d\n", -errno);
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 err_out:
-	return ksft_exit_fail();
+	ksft_exit_fail();
 }

-- 
2.44.0


