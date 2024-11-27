Return-Path: <linux-kselftest+bounces-22574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465A9DABA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17F9164FF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B59200B95;
	Wed, 27 Nov 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZODDARKZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3661FA164;
	Wed, 27 Nov 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724361; cv=none; b=cFNK40pTKMis/JfG3bkFuOqfC9p8Mu1DOFesStRT+yRbuKP9i3unjLHyuqRb49ZYhvzC7d5g/r/Ww1+OfQopKHB7pxN9pdTTI0oHCf/Oyj1grQ4bhoTi7QlOLVsyrwx0oZGud0SXI2lEAFLwnRM4qwwEQ48lx77i88+plzTFDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724361; c=relaxed/simple;
	bh=VGj1urPXgirpBpZCxUml45/Ecma/LMtwQIvuA1d+HWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VbMFkZ0x/ghH1iNdjb8n2hrURTKbAwGYk4Dk3S2SkbvcvgVotBLWYc9y1mhCd4mUgfZYuz710c1Ef2aEzbNL7b2hAxnvIGm9L9weaoBkG/3C4CRBGxqLUTf+uJvQF7jfi/TLKcuXFVooH/BR8FZWHfHpG8hF/i7uLAeKjZBkiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZODDARKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B566EC4CECC;
	Wed, 27 Nov 2024 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724361;
	bh=VGj1urPXgirpBpZCxUml45/Ecma/LMtwQIvuA1d+HWU=;
	h=From:Date:Subject:To:Cc:From;
	b=ZODDARKZqOaZ1pX5mdF+8lESiPPu26IFoeJJ+jUXkoS6wgmmf6cFMVMwjTgrom1Dq
	 CP2nImVWHee4L9XcNysL6T0f0LGmkXAmk79bUnRRf0b72fWWPLthGn+f8SjdyLNLcB
	 Muj+ww/dy9Yb1mCCATRzr+Gw8q9ja+OMRl/gBwBSMxuIo0tFju0oCKqmKJtPMc4QJC
	 DaCgOTsJsf0dUQg8HCLsQZHPMxwnObb71zSnvuR7GNuA2dQ8iBCEvgaMTG9Qofu5K8
	 ahiZEJFzedhA9MWMUW37jijXDAfFmbDdxquA2WtxK4d/lzsw9Yd46hAWO0xRDhn1IA
	 ZM59faMXJ4M7w==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 27 Nov 2024 16:14:22 +0000
Subject: [PATCH] selftest: hugetlb_dio: Fix test naming
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-kselftest-mm-hugetlb-dio-names-v1-1-22aab01bf550@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF1FR2cC/x3NQQrCMBBG4auUWTvgRMHiVcRFk/xtB5tUMqkIp
 Xc3uPw27+1kKAqje7dTwUdN19wgp47CPOQJrLGZ3NldRdyNX4ZlrLDKKfG8TaiL56gr5yHBWOB
 D8Oilv0RqkXfBqN//4PE8jh8E4SxGcAAAAA==
X-Change-ID: 20241127-kselftest-mm-hugetlb-dio-names-1ebccbe8183d
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Donet Tom <donettom@linux.ibm.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VGj1urPXgirpBpZCxUml45/Ecma/LMtwQIvuA1d+HWU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnR0aGmTf7TspLsdIwd/JO0KQoZMrjSCzXVD3QifL/
 FxQZOs+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ0dGhgAKCRAk1otyXVSH0A80B/
 9gzQZWA4bpLSHy9xmV1ACmwxzXU0aUm/3V6gLW3quSihlXjcvvGorD7iPK0HrSFI0vQX4i714pryKC
 GqXkjOkf9Za6BktApVHHinWYlMgq3b8C0Hkdtze81kH+RVbXHeCEf/3jW3qDROO30c0IW/eVj7ro2B
 KXSEF4ihnWNgHKY/0oJwaKTj5BuuCLSjYdTRFRSFDnES6ZqwxywS6M+khXpfRbTJSOA1EkHYnz5j/0
 42goxcDxwH+dw715SRmJuOfGGYsFvKL6f9XnBODMSEtqXwc4uL8Qr0wHIelQTUiybH4+Rz/91LpP4L
 l8md8cT6uZygXnoD1VCEeVzGZAc0t3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The string logged when a test passes or fails is used by the selftest
framework to identify which test is being reported. The hugetlb_dio test
not only uses the same strings for every test that is run but it also uses
different strings for test passes and failures which means that test
automation is unable to follow what the test is doing at all.

Pull the existing duplicated logging of the number of free huge pages
before and after the test out of the conditional and replace that and the
logging of the result with a single ksft_print_result() which incorporates
the parameters passed into the test into the output.

Fixes: fae1980347bf ("selftests: hugetlb_dio: fixup check for initial conditions to skip in the start")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/hugetlb_dio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
index 432d5af15e66b7d6cac0273fb244d6696d7c9ddc..db63abe5ee5e85ff7795d3ea176c3ac47184bf4f 100644
--- a/tools/testing/selftests/mm/hugetlb_dio.c
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -76,19 +76,15 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 	/* Get the free huge pages after unmap*/
 	free_hpage_a = get_free_hugepages();
 
+	ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
+	ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
+
 	/*
 	 * If the no. of free hugepages before allocation and after unmap does
 	 * not match - that means there could still be a page which is pinned.
 	 */
-	if (free_hpage_a != free_hpage_b) {
-		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
-		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
-		ksft_test_result_fail(": Huge pages not freed!\n");
-	} else {
-		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
-		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
-		ksft_test_result_pass(": Huge pages freed successfully !\n");
-	}
+	ksft_test_result(free_hpage_a == free_hpage_b,
+			 "free huge pages from %u-%u\n", start_off, end_off);
 }
 
 int main(void)

---
base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
change-id: 20241127-kselftest-mm-hugetlb-dio-names-1ebccbe8183d

Best regards,
-- 
Mark Brown <broonie@kernel.org>


