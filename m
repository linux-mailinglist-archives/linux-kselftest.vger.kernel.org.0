Return-Path: <linux-kselftest+bounces-8796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9308B10E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD6628B85A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A216D9B3;
	Wed, 24 Apr 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjD7nKIH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90716D9A9;
	Wed, 24 Apr 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979490; cv=none; b=bSyHwtzYXs2LcVeRBbmiTzKSwIOG4Q2vQatlQSeAYYBTwjvsZ+sqY5tUbC5QE43rVcXOx+P08ecnctbu2epHvRtOCZmKmIFBZrlNWjs9N17xDZ0jPLxYm89fdBPlRBLxc2299hDwanWQgHj6VeXHhDx8DIxfWcIozpKdFZNdBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979490; c=relaxed/simple;
	bh=GWpSfOZS2K51RIY5HOOiuGLu67UwmCDp9SYGDLDiQp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jOsiE33xTIQ2eoPlTZekGHuXWSFEB/6lQFKpklZG/QfrBolNG5lODea2+LNhsU8kap7qnwB4ne0bafRQB3gewKSBK8LU1bRaAWaPLPngPGiKAONpSKonXLa5HoHpXL2M3LWCIczDzxe26D3qwi3naHax2xnBPgeR/4H1CBChzt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjD7nKIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4576BC4AF0F;
	Wed, 24 Apr 2024 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979489;
	bh=GWpSfOZS2K51RIY5HOOiuGLu67UwmCDp9SYGDLDiQp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tjD7nKIHVmBOV3N5MSCSCjPY+RbJgOA7wKENGoAnKqQ4P415hy1U2lj6EjGgRf9wa
	 KBufw4uZKfrb7T2BZ7v6RUq92GchH3l6yCVNdghNtPvBCi6WqwCbH8kkGU1MDzx1Sp
	 Pe1ZZJNxPOG262JqBhdUlh2dFwZBz20MeAVXZINXrjKH6d10/VZ0b+vcKH2pTKBvgM
	 JN/OymHrQYtqfLy/4SnFDi3f5oMQCFq91E0D13512HcAaHGHD+2nicb3KENxb4IJGL
	 IJ48HdL2rU4VFsuPJTUUIlTN5ZqP3XkZIOrwmEFM7RxY6zboVQE1mSxMYILvXmFJch
	 z+gLzmF8KfNtg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:07 -0700
Subject: [PATCH v2 04/10] selftests/mm: ksft_exit functions do not return
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-4-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>, 
 akpm@linux-foundation.org, linux-mm@kvack.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5922; i=nathan@kernel.org;
 h=from:subject:message-id; bh=GWpSfOZS2K51RIY5HOOiuGLu67UwmCDp9SYGDLDiQp4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDrHdSRfSpIslJsW+bnT3PP9x327Gw8XK0gmTll1ad
 1dt4YmyjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCR9d8YGTZKXH7y9Drf2408
 D8z3mNifCD2+pf6gbHjPdM4CC6F+Vn5Ghgd3esNbxVZ2aJ7beGLJ4Z0PQ7lWPXs7h03sb1369ea
 J3owA
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
Cc: akpm@linux-foundation.org
Cc: linux-mm@kvack.org
---
 tools/testing/selftests/mm/compaction_test.c      | 6 +++---
 tools/testing/selftests/mm/cow.c                  | 2 +-
 tools/testing/selftests/mm/gup_longterm.c         | 2 +-
 tools/testing/selftests/mm/gup_test.c             | 4 ++--
 tools/testing/selftests/mm/ksm_functional_tests.c | 2 +-
 tools/testing/selftests/mm/madv_populate.c        | 2 +-
 tools/testing/selftests/mm/mkdirty.c              | 2 +-
 tools/testing/selftests/mm/pagemap_ioctl.c        | 4 ++--
 tools/testing/selftests/mm/soft-dirty.c           | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 533999b6c284..4f42eb7d7636 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -177,7 +177,7 @@ int main(int argc, char **argv)
 	ksft_print_header();
 
 	if (prereq() || geteuid())
-		return ksft_exit_skip("Prerequisites unsatisfied\n");
+		ksft_exit_skip("Prerequisites unsatisfied\n");
 
 	ksft_set_plan(1);
 
@@ -225,7 +225,7 @@ int main(int argc, char **argv)
 	}
 
 	if (check_compaction(mem_free, hugepage_size) == 0)
-		return ksft_exit_pass();
+		ksft_exit_pass();
 
-	return ksft_exit_fail();
+	ksft_exit_fail();
 }
diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 363bf5f801be..fe078d6e1806 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1779,5 +1779,5 @@ int main(int argc, char **argv)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index ad168d35b23b..d7eaca5bbe9b 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -456,5 +456,5 @@ int main(int argc, char **argv)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index 18a49c70d4c6..bd335cf9bc0e 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -228,7 +228,7 @@ int main(int argc, char **argv)
 			break;
 		}
 		ksft_test_result_skip("Please run this test as root\n");
-		return ksft_exit_pass();
+		ksft_exit_pass();
 	}
 
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, filed, 0);
@@ -267,5 +267,5 @@ int main(int argc, char **argv)
 
 	free(tid);
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index d615767e396b..508287560c45 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -646,5 +646,5 @@ int main(int argc, char **argv)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index 17bcb07f19f3..ef7d911da13e 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -307,5 +307,5 @@ int main(int argc, char **argv)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index 301abb99e027..b8a7efe9204e 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -375,5 +375,5 @@ int main(void)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index d59517ed3d48..2d785aca72a5 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1484,7 +1484,7 @@ int main(int argc, char *argv[])
 	ksft_print_header();
 
 	if (init_uffd())
-		return ksft_exit_pass();
+		ksft_exit_pass();
 
 	ksft_set_plan(115);
 
@@ -1660,5 +1660,5 @@ int main(int argc, char *argv[])
 	userfaultfd_tests();
 
 	close(pagemap_fd);
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 7dbfa53d93a0..d9dbf879748b 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -209,5 +209,5 @@ int main(int argc, char **argv)
 
 	close(pagemap_fd);
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }

-- 
2.44.0


