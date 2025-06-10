Return-Path: <linux-kselftest+bounces-34595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921DAD3B01
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8693A63DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E9E2BFC88;
	Tue, 10 Jun 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnkNCRbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D892BFC7C;
	Tue, 10 Jun 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565115; cv=none; b=JI6dlC5sO7pCYWqpIgHnUzgECruSQ6kypodkOVDGdNQP8uhkLVjF3VWS3UzerMYUzJaJ+HbXCpVORHmi/JFDfH3mmu275Raa8TlOIUjRdnb/92dPYC6+Xew2Gbqc+5AQjMxRMmjvU2wxXOWKvxNw+ZHan4ZzFPa+6Cwnvo0pz18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565115; c=relaxed/simple;
	bh=7dkbBW+srIa9CP5zJ4/JMoZP4cQbiZRPdB3hd+GHPkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnSJJsSeUbZZ1Shn9TOsqS/zO9jgsCXTwhUfTF2fOWbl20+Q0tHRxpg7HIZJqZL/ktCyj2idew/Cr6mr+Zke1Jn2G4K4o1Rf3FjMiFrPKvkkUB2SjxyTOmHumRWa9eGBH3iBZZxoQ3K1UNaYtCaAdeydpWl6CkDARomHcaBQqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnkNCRbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA3CC4CEED;
	Tue, 10 Jun 2025 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749565115;
	bh=7dkbBW+srIa9CP5zJ4/JMoZP4cQbiZRPdB3hd+GHPkU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gnkNCRbJUuKZuZXJFnugSYIwcQwp81d5BJaWdworVxld21iSQFK+zCh63Qt6Dkg7u
	 tVHy750rboTE1MzP2qVwb1VoyibWuesRgcSnLyDWQqZEXqGxe7f0gbg17WVtVdWUKL
	 JKTJ3x8AJivJh6DvMBCZPxRXxUzkgG9ZgtIwNoz4xA6c0tTuMNeTNvjeufTfH+FnlG
	 UTt0UInuLdU3b5gBReTqHth9IA4CNvGzKqwOM7/CCqdPgLRCciJKVVn26PjbBYMHe9
	 tAh9wcLIcM7QRt9i0FD17g+0DqA1qdj+oEtM5r2h/yXjI8T6a2tevwZFReld4g5IIw
	 7QcAwqUcFlzHg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Jun 2025 15:13:56 +0100
Subject: [PATCH 3/4] selftests/mm: Don't compare return values to in cow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-selftest-mm-cow-tweaks-v1-3-43cd7457500f@kernel.org>
References: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
In-Reply-To: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7dkbBW+srIa9CP5zJ4/JMoZP4cQbiZRPdB3hd+GHPkU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoSD6ze+vnhBcNS9iDQaq2sxtbsC/5EymYJENC6vV0
 8/u/FSSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEg+swAKCRAk1otyXVSH0Do1B/
 9tYlYfTdop02ZdScX7Wk4Y2dnQT/W90nkm5eMhPgmQWxTukF+qZAIIIP6KmA5uD9D2fVDLEGqhudmz
 o5z45q0aW3mj5+g7QrBWTVr9kwLoAjF24OicMjwUnoZhPA2e5V0a6aBxSxcPaCPrlW92q9BGlYHSkO
 Dl4mzIyqfhdEFkUIFG1WHmeDTrzRbdZ6v1pRfAOS01rCP/xFMDi7fluEVL67pRDaV3Ja2u4WbYMMwO
 j7p/uGfuXfzb1xwRn4CcyVvIEYM4xLROeuiPqWBB3uyq22H+nGQ3UG16e1ozfV87FVaOhGXeSZLbj5
 rrOGIyeIeyoZ3T0z+v9xIyYb7yQYfE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Tweak the coding style for checking for non-zero return values.
While we're at it also remove a now redundant oring of the madvise()
return code.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/cow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index ff80329313e4..48fcf03aa4cd 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1613,13 +1613,13 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 	smem = (char *)(((uintptr_t)mmap_smem + pmdsize) & ~(pmdsize - 1));
 
 	ret = madvise(mem, pmdsize, MADV_HUGEPAGE);
-	if (ret != 0) {
+	if (ret) {
 		ksft_perror("madvise()");
 		log_test_result(KSFT_FAIL);
 		goto munmap;
 	}
-	ret |= madvise(smem, pmdsize, MADV_HUGEPAGE);
-	if (ret != 0) {
+	ret = madvise(smem, pmdsize, MADV_HUGEPAGE);
+	if (ret) {
 		ksft_perror("madvise()");
 		log_test_result(KSFT_FAIL);
 		goto munmap;

-- 
2.39.5


