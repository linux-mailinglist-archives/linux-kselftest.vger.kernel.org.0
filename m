Return-Path: <linux-kselftest+bounces-33512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76F0AC123F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 19:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CF716F0E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96136199FD0;
	Thu, 22 May 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5+zTnLo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58317C21B;
	Thu, 22 May 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935556; cv=none; b=jrLgfnnMzRK/mffelMxr6B8FcQdgdBtMrIZ6ICS0gRg6GSDsM5GGp6DqBuwKf0kTbdzeyhUIvjI8npLS5SuGVjxPbPk+4mK1k/BSWhG5ktJRsqvdwU8aSghtB1Hv6npgeanz0shoXxMw+rKp+c8iv96gQXTOpeS6uecylBa6NT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935556; c=relaxed/simple;
	bh=RyDX1NjAj8sNT7Gl32eMqjY+qWQ421SIQLf7ufug8xU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sw0fJsWUnnp8jrPX9pZtC1ulW3uZQFAuc9oFu7QfgzMyxHFPNCrbWz7idCaFWyD6goDNBt+WAVhLQgFxvld1tOUWJbU2Vl1WXpa3EvxY0OhL8VSUh+6rEvttp0rVhjG909nOXTFTQwFSf2Sc+GdviUcjAco3J3yqXEQxYwkGnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5+zTnLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1CDC4CEEA;
	Thu, 22 May 2025 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747935554;
	bh=RyDX1NjAj8sNT7Gl32eMqjY+qWQ421SIQLf7ufug8xU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S5+zTnLo89kGHvK7ZA60afinbUNhowNjLA+02ClMEHQnWB6GGnkC4zGDOBvZ3c0gP
	 sFW0O9uG6JMVu4Xa4iGoVl2jPbsTfRUtNIaDupg+1vxi/25qG8/mAUpuiGaQLTnshv
	 NbQlav8XcRe342kA/pwxU/uxGjg7Gn+doJX7Ppuqlkk47lkOWqxOSKhdN6OShZgTC9
	 Ajlp20G9oG7Muv0LOENCpjONIUB2S6mmUIGJv8f81WR4ypiZyhj2AjrO9CLC+wKqZF
	 7zOE5WiBQwGIdZT/f6roLkTyoMwx+b4T/Y0ISlE+w/TYp0f3dGAUDjvOg0yn4f/q7o
	 nvdz365smhrwA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 May 2025 18:38:50 +0100
Subject: [PATCH 1/4] selftests/mm: Use standard ksft_finished() in cow and
 gup_longterm
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-selftests-mm-cow-dedupe-v1-1-713cee2fdd6d@kernel.org>
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
In-Reply-To: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RyDX1NjAj8sNT7Gl32eMqjY+qWQ421SIQLf7ufug8xU=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhgz9RKtiP+5fOl9Uy7d8YO/gnahdG3MpvC+w91X69nzNVcXl
 ju6djMYsDIxcDLJiiixrn2WsSg+X2Dr/0fxXMINYmUCmMHBxCsBEPk5i/83KEWOc+4PNqTs9kT3rwp
 ky380zfZ7x9s/P8tixQNOEMbmc10i3NyV99x4NqfTPX81eaTr8Vcu/msNYGP5vsc6cvIxTnKYf/gSl
 75MzUPjktqC7LPr5ytfsvAkGLUWbnl9VCbkflbrt7YRGrhPXZ2z9JsG3zE1Oqar0Rma2oI+Z+7lPmT
 5NV566rL7DOis5dmNDyf9V00PXdarwMzFyFZuXz7Nml7beZHVddeOF+H13Y0w6jmzfc+KtufDygo1V
 69qY/vtNPregctdDW7m0TcL7rJiMT3f+DF/PqbU61cvw4C/FlWsr8nqXcPwxsU4Xlj4bt/Rh1WyJs9
 8l7688uqrbQ1Ol6/FUZpvozgZWAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The cow and gup_longterm test programs open code something that looks a
lot like the standard ksft_finished() helper to summarise the test
results and provide an exit code, convert to use ksft_finished().

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


