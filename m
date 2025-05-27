Return-Path: <linux-kselftest+bounces-33881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B40AC52C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4901F3AF9E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BE727F72E;
	Tue, 27 May 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMQZuEeJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D627E7F2;
	Tue, 27 May 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362402; cv=none; b=V9WmkB15L34/LJLb0MAupzt5X3dgssivdSeRLmEsbwGqDue8CKCkdIK499l6iI7ZZl206lRRZ0GXN3BxCsWmMLOqp0PkMw8b1Y4rpA8ELTjUWsyoVY7fkGI7eFCkn9mbEaooLqXs1TWsfu+q9ApFW2cGmtW1++HEzUzm219Sg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362402; c=relaxed/simple;
	bh=v/oPFk1dyTbzpfcvrlvMXI0bF3ZpSzCMgfGfjmjv0ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Syo0L8dHNi4D+1+xrFFCWiSwP16l2m+/MAaj+BlwTM+kndv4HH55KMsLam9D+9MfiZYk62pGA+vJ7QwMxgJSPHK8P15GP/jd0ytK9nNBMZBxyglZ77bcSyEF13+hCZSo+SAEZqhMDh5XTpmW9rewdeDnAPrVp6LvGzCEPtXY7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMQZuEeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F65BC4CEED;
	Tue, 27 May 2025 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748362399;
	bh=v/oPFk1dyTbzpfcvrlvMXI0bF3ZpSzCMgfGfjmjv0ZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TMQZuEeJkCbgVOhEM/BAdld/vzqUIrf5Lbg5dOsGZrul5Wk5EHfzQlWWPD2ArcIgL
	 nZ0Y4TNGNl/TDLmvNTHcMC1M4Fqe3gfNU2PaLrTG6yLgxSynXPJmmO4n5OeZLne02h
	 7U9SWvo/5W9FuXR23AQ2cyfH4ubrgfdISZQF1Cu5aHcQmdHjzu96yqrF90N5uRUuV5
	 2XgY2+nw3+ZwPYXaKjI/0dSh3GA1wjdM2gshyU/sNUDqAVWU7XziGAidifYooobZDp
	 g/EUVeON1bx9xzRJosxy6o0GIfoD78itRpUMyUOGCYwv9OmMYJvLJaeMzEP9sOnrP0
	 dE85bd6nBwhKg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 27 May 2025 17:04:45 +0100
Subject: [PATCH v2 1/4] selftests/mm: Use standard ksft_finished() in cow
 and gup_longterm
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-selftests-mm-cow-dedupe-v2-1-ff198df8e38e@kernel.org>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
In-Reply-To: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=broonie@kernel.org;
 h=from:subject:message-id; bh=v/oPFk1dyTbzpfcvrlvMXI0bF3ZpSzCMgfGfjmjv0ZM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoNeSZVg0YkgpkVOxp6tsp5pmSU0NyfWUrXK7rHzck
 bp/65DiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaDXkmQAKCRAk1otyXVSH0PqqB/
 97+0T5fiKbsla9HXKhIiRC46f09gl3MG4DMJg//aTPraJ8gsaGw0sB++mt19JtBgKULnutO0rNxEL0
 hHtQnVUK7M+ME1V8cbNocd1Xw8D6gzzvkXhom/E/o5Xe/GQQ5jH9JhgF0Rje9wftj1WFL6oZWT2pT7
 zF9a66Xxpv9SwrGzsgM4RyZBYVP//nbSvXsLXvdQzUxDQziY1XOwYUTRxA5JuwYYyUfaVKL2834W74
 9zQ95lvhYfeC8ZV9s/YTxv5KYMdiJqwlOgW7qJ977xDkw9O54Qk9IuLw+cLmLChav0KCnj1oAvO+O0
 u9CPJbdKWrTF+Mzw3hx+xQgo6/HIhp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The cow and gup_longterm test programs open code something that looks a
lot like the standard ksft_finished() helper to summarise the test
results and provide an exit code, convert to use ksft_finished().

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/cow.c          | 7 +------
 tools/testing/selftests/mm/gup_longterm.c | 8 ++------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index b6cfe0a4b7df..e70cd3d900cc 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1771,7 +1771,6 @@ static int tests_per_non_anon_test_case(void)
 
 int main(int argc, char **argv)
 {
-	int err;
 	struct thp_settings default_settings;
 
 	ksft_print_header();
@@ -1811,9 +1810,5 @@ int main(int argc, char **argv)
 		thp_restore_settings();
 	}
 
-	err = ksft_get_fail_cnt();
-	if (err)
-		ksft_exit_fail_msg("%d out of %d tests failed\n",
-				   err, ksft_test_num());
-	ksft_exit_pass();
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 21595b20bbc3..e60e62809186 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -455,7 +455,7 @@ static int tests_per_test_case(void)
 
 int main(int argc, char **argv)
 {
-	int i, err;
+	int i;
 
 	pagesize = getpagesize();
 	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
@@ -469,9 +469,5 @@ int main(int argc, char **argv)
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
 		run_test_case(&test_cases[i]);
 
-	err = ksft_get_fail_cnt();
-	if (err)
-		ksft_exit_fail_msg("%d out of %d tests failed\n",
-				   err, ksft_test_num());
-	ksft_exit_pass();
+	ksft_finished();
 }

-- 
2.39.5


