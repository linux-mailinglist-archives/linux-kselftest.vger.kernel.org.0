Return-Path: <linux-kselftest+bounces-34901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6CAAD8B2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42851E4C25
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93E52D8769;
	Fri, 13 Jun 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5J4HV1n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776FA26B761;
	Fri, 13 Jun 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815086; cv=none; b=oh+DwdoR6JfAq8MNk1ye9CFCIhqQj9IjK9Gm4/iIZasvAChVphVkLLresTuAKsE8d6nsyNeWvBqAHoRZttI1ML2URoUf+fIsBWgOnK4xAg1k8/qpcbo9FFdDxmHM8kgbya6srWGWOcWa/FcLXFMl3nqQFNOWcP1mPs/FpGZ96Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815086; c=relaxed/simple;
	bh=67C8SauhQy4UDCcOAF3lc1WX/+uxuBUuNm519MYFsJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vAC1krfSXnEMTglCiJsXGdrlrLycPNs5Q3U/sXtsftXDStj+ag+OSNQMtPCvx8ad4MWDe2Bruu0gEg+12EZNE79zM9aZKdOoa+r1j0HGGcMPLQm8FUShmSm2v+bbCSpFnS4zE+QTToxBG3lybeHhEgxwNddS2RLjn+GL2ef6P40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5J4HV1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93389C4CEE3;
	Fri, 13 Jun 2025 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749815085;
	bh=67C8SauhQy4UDCcOAF3lc1WX/+uxuBUuNm519MYFsJc=;
	h=From:Date:Subject:To:Cc:From;
	b=U5J4HV1ngFV03Nwvqb+pAc9sD31Mp9qvuZ+EGB52Y6jF/3OC7/HfsjDzu4k8i+Soe
	 FvRsQ2iRGAN9oFXErAmU3anccqP0S7a6bGyg0Pl1fciAyaZrLdCjduIGlrMR3Grni1
	 xdUoHg5UJQSqLtaoKFyrhefka+A0FnGjaJeKFN/ssjB0I8ZePHTS9pS3wWYcBKv/hj
	 itJAjs45025+JsvzDANFT5Rue+VygzqJz0kPG7thfQH70VvyA8U3Czj6btyfFqfTuL
	 w0nDZq+GvPC6sRzi39c7ZW4JmxfF27YrpNk+8YqAOyZ3CXTGlzfrQnvAaL2nMFypxD
	 JXr0I5HxGxfGA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 13 Jun 2025 12:44:07 +0100
Subject: [PATCH] selftest/mm: Skip if fallocate() is unsupported in
 gup_longterm
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-selftest-mm-gup-longterm-fallocate-nfs-v1-1-758a104c175f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAYPTGgC/x3NywrCMBBG4Vcps3YgCbaCryIuQv0nBnIpmViE0
 nc3uPw25xykaBFK9+mghj1qrGXAXiZa374EcHwNkzNuNos1rEjSoZ1z5vDZONUSOlpm8SnV1Xd
 wEWVnIfN1cTeIoxHbGiR+/6PH8zx/0+23KngAAAA=
X-Change-ID: 20250610-selftest-mm-gup-longterm-fallocate-nfs-21ef54627ef2
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=broonie@kernel.org;
 h=from:subject:message-id; bh=67C8SauhQy4UDCcOAF3lc1WX/+uxuBUuNm519MYFsJc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoTA8refSwnoxdJb+107nNprcOEDsjz4KiGYmcVQTM
 W1F/HCmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEwPKwAKCRAk1otyXVSH0FtkB/
 4+8N5ND04NyqzZJemY5vFK3k75oeTztrRfRyyZ3JvwmcCNAyZZ/S2SYtMfxJCnFaRVBCCrLG3cS6oD
 zS7FYy6q384+Svt1Eu6qfqAFTZrRXA1Dt+fdXTTEsAcYZk5lzEYMhRn+Pkw5E29gEYcSJp/LVAw6zz
 37lA18qLoghB7nm3ndxqQdW5Ip+DPFq1ZKSo5Gtm1NntVlVFb0KvEcYEOr1n2jTO3HIvEmDkVa9d+6
 lj7pH6N8b3KQR/TaopssA/UlZovbnNeS6DH+1AaDd9szj+rW5yfQKQ83WoEQ8ozXn6/Bbs+v5aBP3+
 zcDOiUi+Df9d7jjbqpT2NDIHX+F5ew
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently gup_longterm assumes that filesystems support fallocate() and uses
that to allocate space in files, however this is an optional feature and is
in particular not implemented by NFSv3 which is commonly used in CI systems
leading to spurious failures. Check for lack of support and report a skip
instead for that case.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/gup_longterm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 8a97ac5176a4..0e99494268ed 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -114,7 +114,15 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 	}
 
 	if (fallocate(fd, 0, 0, size)) {
-		if (size == pagesize) {
+		/*
+		 * Some filesystems (eg, NFSv3) don't support
+		 * fallocate(), report this as a skip rather than a
+		 * test failure.
+		 */
+		if (errno == EOPNOTSUPP) {
+			ksft_print_msg("fallocate() not supported by filesystem\n");
+			result = KSFT_SKIP;
+		} else if (size == pagesize) {
 			ksft_print_msg("fallocate() failed (%s)\n", strerror(errno));
 			result = KSFT_FAIL;
 		} else {

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250610-selftest-mm-gup-longterm-fallocate-nfs-21ef54627ef2

Best regards,
-- 
Mark Brown <broonie@kernel.org>


