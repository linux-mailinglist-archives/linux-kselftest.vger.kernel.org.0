Return-Path: <linux-kselftest+bounces-11268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BD68FD9F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56161F24A9E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D571415FD1E;
	Wed,  5 Jun 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFNBiP+0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE015ECC6;
	Wed,  5 Jun 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627031; cv=none; b=cNGkWxfvHLxDWUMt9FsRjDJ1MVYXpKfyjIwLCfR7wJrpN3jm3Dp1z6AlmkDFYOUPsjxUubvbont2Me7XaxFuZ9dnyO1YzdNm2rmJstLymaOH5qDZECeyAuIr+/T0F0wUG5hUmKtp6d0lbTKZMYXQgOUxfdor/uvZk0lZQIe9RLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627031; c=relaxed/simple;
	bh=dVVjuhrnk9rcVfTcckSF8nLr2PRkHx3HB+XsjZZpYsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n6022leXRx+Y6o1pZg9tW8/4QNl4WaFqgScRiGnepFfwbNSG17mHWvI6Nsyi2uUkO32oGswqz0ol53Z3OC1Hshwd82wVAVuym8S+k5pX7rZKCEK29C6UPDNOpRrclPIg8DB8gqMPDV/aFWurg0G84Zl2t8AfNF7TQVVP8OZmzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFNBiP+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B20C2BD11;
	Wed,  5 Jun 2024 22:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717627031;
	bh=dVVjuhrnk9rcVfTcckSF8nLr2PRkHx3HB+XsjZZpYsM=;
	h=From:Date:Subject:To:Cc:From;
	b=jFNBiP+0gNWI3mAtVSdDqJoB/4RQB/VGMHi6gTI7OPrtjkTcttXv9KwJ5PMZ9RVTJ
	 XG6qNJ4pu1qHMIz1TefEqYX1CgK5NE4jIfzOPcR71DSLWVMNNr1IxSzU0zPYH/z0BP
	 gIONW7IaVGoU1Cv/5vpWo8bYVkQ1A8SeU9g5Dwh21+TqFRmp2e4HDiqBQCPDXH9o0o
	 xu5DDBZktkrkagHNTtH/PGPP0CxigN0hRcxQyFATU2kbh7zXassKbOnUFRB4Vnr6Jy
	 zksN1gVNaDfMzFzb0nmV0ANhEOcKDYQ5X7/N8DFjpV74lBTwPm5GXWhYk6ahfxpayA
	 8nHMkz6Ph1Dxg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 05 Jun 2024 23:36:12 +0100
Subject: [PATCH] selftests: mm: Make map_fixed_noreplace test names stable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-kselftest-mm-fixed-noreplace-v1-1-a235db8b9be9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFvoYGYC/xXMQQqDMBBG4avIrB2IkqTFq4iLEP+0QzVKRkpBv
 Hvj8oPHO0lRBEpDc1LBV1S2XNG1DcV3yC+wzNXUm94abxx/FEs6oAevKyf5Yea8FexLiGBr8YB
 z8em7QHWxF9zJvR+n6/oDN+K3yG4AAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=4850; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dVVjuhrnk9rcVfTcckSF8nLr2PRkHx3HB+XsjZZpYsM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmYOiUCt0+i/NP4Ix1ci7NExxF8e79RLps0+Fa+d71
 5yBnE46JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZmDolAAKCRAk1otyXVSH0F56B/
 9+XCV+81OEz6Gnn6s5XC8fRlmAChtPCuWw2nbJKMi6EU2jycWSs+/C5eUzRrFLWZ2F+8x4ub6CGsrY
 j2hSaL0z78nnEkf0dN/BT+Seggg5aJyY1IUjlScKrUTdY0TuZ3l4eUcnJlv7OQcjJmQKDaTOP0uuMw
 2qHCOTwF1BagPNuAckJYgZ4c6V9JNNgdq6fN2Rb0d/4RlTuniG7zzafhn4K6KXhJvwuxmdsaxG37E0
 H4FxxJ3Eap2IClToMNoclf5DizIBQg4eTVPrSmTGS5Xp88b7i2OvxWDerUaxXuDJ3VUUcgxN/v3osU
 W//sDueyMuBF/tw+G+m8W91t3UOcl8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

KTAP parsers interpret the output of ksft_test_result_*() as being the
name of the test.  The map_fixed_noreplace test uses a dynamically
allocated base address for the mmap()s that it tests and currently
includes this in the test names that it logs so the test names that are
logged are not stable between runs.  It also uses multiples of PAGE_SIZE
which mean that runs for kernels with different PAGE_SIZE configurations
can't be directly compared.  Both these factors cause issues for CI
systems when interpreting and displaying results.

Fix this by replacing the current test names with fixed strings
describing the intent of the mappings that are logged, the existing
messages with the actual addresses and sizes are retained as diagnostic
prints to aid in debugging.

Fixes: 4838cf70e539 ("selftests/mm: map_fixed_noreplace: conform test to TAP format output")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/map_fixed_noreplace.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/map_fixed_noreplace.c b/tools/testing/selftests/mm/map_fixed_noreplace.c
index b74813fdc951..d53de2486080 100644
--- a/tools/testing/selftests/mm/map_fixed_noreplace.c
+++ b/tools/testing/selftests/mm/map_fixed_noreplace.c
@@ -67,7 +67,8 @@ int main(void)
 		dump_maps();
 		ksft_exit_fail_msg("Error: munmap failed!?\n");
 	}
-	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_test_result_pass("mmap() 5*PAGE_SIZE at base\n");
 
 	addr = base_addr + page_size;
 	size = 3 * page_size;
@@ -76,7 +77,8 @@ int main(void)
 		dump_maps();
 		ksft_exit_fail_msg("Error: first mmap() failed unexpectedly\n");
 	}
-	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_test_result_pass("mmap() 3*PAGE_SIZE at base+PAGE_SIZE\n");
 
 	/*
 	 * Exact same mapping again:
@@ -93,7 +95,8 @@ int main(void)
 		dump_maps();
 		ksft_exit_fail_msg("Error:1: mmap() succeeded when it shouldn't have\n");
 	}
-	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_test_result_pass("mmap() 5*PAGE_SIZE at base\n");
 
 	/*
 	 * Second mapping contained within first:
@@ -111,7 +114,8 @@ int main(void)
 		dump_maps();
 		ksft_exit_fail_msg("Error:2: mmap() succeeded when it shouldn't have\n");
 	}
-	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_test_result_pass("mmap() 2*PAGE_SIZE at base+PAGE_SIZE\n");
 
 	/*
 	 * Overlap end of existing mapping:
@@ -128,7 +132,8 @@ int main(void)
 		dump_maps();
 		ksft_exit_fail_msg("Error:3: mmap() succeeded when it shouldn't have\n");
 	}
-	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_test_result_pass("mmap() 2*PAGE_SIZE  at base+(3*PAGE_SIZE)\n");
 
 	/*
 	 * Overlap start of existing mapping:
@@ -145,7 +150,8 @@ int main(void)
 		dump_maps();
 		ksft_exit_fail_msg("Error:4: mmap() succeeded when it shouldn't have\n");
 	}
-	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_test_result_pass("mmap() 2*PAGE_SIZE bytes at base\n");
 
 	/*
 	 * Adjacent to start of existing mapping:
@@ -162,7 +168,8 @@ int main(void)
 		dump_maps();
 		ksft_exit_fail_msg("Error:5: mmap() failed when it shouldn't have\n");
 	}
-	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_test_result_pass("mmap() PAGE_SIZE at base\n");
 
 	/*
 	 * Adjacent to end of existing mapping:
@@ -179,7 +186,8 @@ int main(void)
 		dump_maps();
 		ksft_exit_fail_msg("Error:6: mmap() failed when it shouldn't have\n");
 	}
-	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
+	ksft_test_result_pass("mmap() PAGE_SIZE at base+(4*PAGE_SIZE)\n");
 
 	addr = base_addr;
 	size = 5 * page_size;

---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240605-kselftest-mm-fixed-noreplace-44e7e55c861a

Best regards,
-- 
Mark Brown <broonie@kernel.org>


