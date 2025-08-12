Return-Path: <linux-kselftest+bounces-38772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07246B226DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594706264FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656DE1A9F98;
	Tue, 12 Aug 2025 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUYFjs+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0AC1A5B9E;
	Tue, 12 Aug 2025 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001827; cv=none; b=oUC01uDCI63b5SCJ69sBvqBjc212HNrq5rFnGO0Vo5akH7BkbrcpcV1F+RrOmFw4Iip5oFdhsSiZDBIzmrQi1pzlGuc7TmUO7rr6XCcqjp0lIaLlGvrFICNIjsWG3ugNPlqbNZl8c8fgPiPTfqZTMOo+MQLOAbfLINZgcm/buKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001827; c=relaxed/simple;
	bh=4YMzC/UP5j9ONXIT+pgGQsuo5xL6W9saqp3GH+DFxd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZxZJWXPdc/JdLvR2XY3yWtjbm2dIeVmPd0+aEnY0tYTOJEFXNeG005kaFw1fydR2J7PQVKL3VnnXaGEbsDuwWTrpx9ijgFeKWjPJUBptfY8h+t8gB+TNFLLIqfM/Uw2p3ZPjdJsBCtPfQmL701Sjm5VGGOn/owiCa0oiZU/YDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUYFjs+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867D6C4CEF4;
	Tue, 12 Aug 2025 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755001827;
	bh=4YMzC/UP5j9ONXIT+pgGQsuo5xL6W9saqp3GH+DFxd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CUYFjs+D6E3+Yni0iSLEB84+ZuTPl/vsb6N5TfKmrRbGzCSvskVjl+VQICNhiDHTJ
	 urf+cD4LAeaCNrFC/nX3yYnP3Mt/AbSnmk8/dW7Sb+wPkDPA+n/NrlGX60YX/42Z7u
	 0KDazsFHXRwRyduWV2R+ayJf3Pzk+VCqfxRM/bfunCJQDITawoY1GbHCuFgb06EeJV
	 Yud+VVLr/jO7q9RqGczSuq/4x9UrShk+3Z+WoE2quXZe2uEeqca3vdPH7jLByzMylA
	 BWcRksDHPbJ03qpzbQnQKySnb3BOHsO3iKK98upWulMpIk7LyKXUPzQ1Q1k4wSBJDj
	 yD4MXEFd/lO4A==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Aug 2025 13:00:50 +0100
Subject: [PATCH v2 2/2] selftests/fchmodat2: Use ksft_finished()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-selftests-fchmodat2-v2-2-f2d5380e94c3@kernel.org>
References: <20250812-selftests-fchmodat2-v2-0-f2d5380e94c3@kernel.org>
In-Reply-To: <20250812-selftests-fchmodat2-v2-0-f2d5380e94c3@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4YMzC/UP5j9ONXIT+pgGQsuo5xL6W9saqp3GH+DFxd8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBomzPbFkSX+R3HJelxpxC55p4KmMS6+nEBfEoKG
 L6NwRhzKJiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaJsz2wAKCRAk1otyXVSH
 0CZbB/9yVcGHj7af+sjVBNkKq+XYGrfxxze2GW2gqTwztgXqb/eNY9qnCybVTdmx2Oy5S81R1dv
 MfeC5vUGNERW8vMaSZjO7S0Q1QdskkIvPGxLcivn7zGe4rasOOa5Dvdp1XQZrUg5VlYzLNamEAN
 dwxPLj043vplcxlGHS4SOGeEjtDx5q75u/BGa1Hfmn/5aaNk+mL6IcYrkP3/xxyz3rR3AP44Z6Q
 6JqPqKJo6gMseIyDAB4S5RKVBm9vKiQB84baXuoTmaVSsjTdiFI6CTwNfsH3VOKJ82RB5ImGopl
 /I7cNyMntunA4m1Oe9OrN5uqHltRwMiXu3p0A8eqyazBn8qA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fchmodat2 test program open codes a version of ksft_finished(), use the
standard version.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e977d942c00b..d3682ccd7cb8 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -196,8 +196,5 @@ int main(int argc, char **argv)
 	test_regfile();
 	test_symlink();
 
-	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
-		ksft_exit_fail();
-	else
-		ksft_exit_pass();
+	ksft_finished();
 }

-- 
2.39.5


