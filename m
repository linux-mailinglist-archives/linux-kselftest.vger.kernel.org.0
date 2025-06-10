Return-Path: <linux-kselftest+bounces-34590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E19AD3AC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D1D179845
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB742D191F;
	Tue, 10 Jun 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H66g9FuX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4592D1907;
	Tue, 10 Jun 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564566; cv=none; b=VDaQvp5tlbvumHidbp2fVp1wmjsfLphpRC6hAkepBVv835hwAn9KiXBVtfI2bDDe1rzwX1nE/4mwDeKY0mzUNlvA2HVNXB1LVjTbskgShQcH3kiRRSS9Ev7KbkUofiZxIiGcXhG4LxS13NAVejcg9++ahQJ2Gj0RzgnRU5Eoy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564566; c=relaxed/simple;
	bh=kEJw6Yz+PbyCAGGeLMC2ZoLRfBLryhgl1OeBDrRe6KI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fSE6rcFGJBIEMP5QfajGC4UCldGmqcL7eEI6yWs1Hn0S8ibJfOJwaqTmb/W0efWhrrJ+rMcgD7aAQq03P8accGzupiQQtUVtmYL4h6ji3cs4L9pKS1ullRruJn0vF0D3WITYi+5071HuVcMIqdFEDEIcFIb3O8mRiBGIZMINgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H66g9FuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5F9C4CEF7;
	Tue, 10 Jun 2025 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749564566;
	bh=kEJw6Yz+PbyCAGGeLMC2ZoLRfBLryhgl1OeBDrRe6KI=;
	h=From:Date:Subject:To:Cc:From;
	b=H66g9FuX4it5jQvyGO6Myd9Badtm8kBoIqm//4zpV7A6Z7NhEYd6VdAPo9dtx6HwK
	 E1gPCr/vPP6741kIntPZ5UEtIz3VV6gSdIsyLH44pL0hA7dDGiQkN5OoWYj2WB9asS
	 Qn53YBw6QufbVePVnEJGK1EmcQsZikDZgi2dLpp1TtdJiZEUDgKjGkjrGBzwNO77cV
	 Fjj0KTRzlDkiVTeE911L9/IZ+C3WyBDd2FEPRN2UizGsEfJtDU6W3LmH3eoDcf5pAY
	 ueiJSyKofpVG3yc4rIh0JSyKths2AFyPbZGCt9rZBE/2e1H7oljHJCE9wYZYnhnbM0
	 siozKKuqj2Q1Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Jun 2025 15:07:44 +0100
Subject: [PATCH] selftests/mm: Check for YAMA ptrace_scope configuraiton
 before modifying it
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-selftest-mm-enable-yama-v1-1-0097b6713116@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC88SGgC/x3MQQrCMBBG4auUWTuQhMZFr1JcxMxfHWiiZIoop
 XdvcPkt3tvJ0BRG07BTw0dNX7XDXwbKz1QfYJVuCi5Ed3WRDeuywTYuhVHTfQX/Ukns4+hzkCC
 ShXr9blj0+z/Pt+M4Ab2NkNppAAAA
X-Change-ID: 20250605-selftest-mm-enable-yama-1541c2d2ddcd
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kEJw6Yz+PbyCAGGeLMC2ZoLRfBLryhgl1OeBDrRe6KI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoSDyTLbHsa8+9FhNsMO43U0pIyehvHB3d+gNzxjuf
 atPdTiyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEg8kwAKCRAk1otyXVSH0PuvB/
 4oIMm+Dp7pGcPbyUvbIy4xKEl4EwRxrOTTkBL4iGPoJQxZelSlYzE6fianUPloojhiapKAeBiabRDm
 JEfPYrN3S8i/iFzdl6+hTA43aoTtZPWu7eq6uy3WyHe4Aj3GZ/nkTSJTEqSufhxP319Yml+NLTDlMZ
 D1ByyKeM3JwJ+OpZV7n1nz47gCjDMOrUufXIa2kGjIDrFt4hhL4cO+Ig1xsoJ2V7zmYeZlPYuDbBGi
 G3X2u/hUHicG8fXj8TMWWA5i42+GfG+QMhhKnCgJtcG7/dL8O0/TOxgeGTsVwQFUWV6vLkYMb+PUH3
 BUgluAZ58AwkzHSZMDU7IvlTk3SsjW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When running the memfd_secret test run_vmtests.sh unconditionally tries
to confgiure the YAMA LSM's ptrace_scope configuration, leading to an error
if YAMA is not in the running kernel:

# ./run_vmtests.sh: line 432: /proc/sys/kernel/yama/ptrace_scope: No such file or directory
# # ----------------------
# # running ./memfd_secret
# # ----------------------

Check that this file is present before trying to write to it.

The indentation here is a bit odd, and it doesn't seem great that we
configure but don't restore ptrace_scope.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/run_vmtests.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index dddd1dd8af14..33fc7fafa8f9 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -429,7 +429,9 @@ CATEGORY="vma_merge" run_test ./merge
 
 if [ -x ./memfd_secret ]
 then
-(echo 0 > /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
+if [ -f /proc/sys/kernel/yama/ptrace_scope ]; then
+	(echo 0 > /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
+fi
 CATEGORY="memfd_secret" run_test ./memfd_secret
 fi
 

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250605-selftest-mm-enable-yama-1541c2d2ddcd

Best regards,
-- 
Mark Brown <broonie@kernel.org>


