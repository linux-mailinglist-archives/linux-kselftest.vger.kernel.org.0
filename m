Return-Path: <linux-kselftest+bounces-34594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5984AD3B0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9667AAEFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC42BEC59;
	Tue, 10 Jun 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCdqnfFA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB329B214;
	Tue, 10 Jun 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565114; cv=none; b=EJsDqKn+YFmVR2K0F4EJoix1s+EVLqv/MSsajA5Sa43IEUh6hyJfHvosLO2JN3dqPH/RaDIj0KWa8cvjXWegiwx1R3MPs/coG47R7OkW0K7LCmWs3HTsRIJLrJWJkGJ7zVsW991ymtfVZkUkOWEzWIRkrCtY9k/s00zPIxuEUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565114; c=relaxed/simple;
	bh=+8K7IHPM2fvcDtNu46rok2dhi80R6Thr3mEpDEugxAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0AKtJeCxQ2NFLM+U3leYdbBblOOxQ64RhYwntKyXeQ1buAD1LWzV36I2E12/aG7ITkYBBcsWeMRFbFeOGVBVPbgDDFJJqR9na/+TK39sXFQFQnCsCBY67ltBE3ThcltiTC5djrQ8qsy7vaoHh95RTVQvSilOmTNUuO7nKWT+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCdqnfFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B831C4CEF1;
	Tue, 10 Jun 2025 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749565113;
	bh=+8K7IHPM2fvcDtNu46rok2dhi80R6Thr3mEpDEugxAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FCdqnfFAUl4A99tXQMEDoFQqQcOvFS37YTuPwHgEMxcSPHDMdFUmZF72YGIUA21x/
	 zxdBiV+15DDZPb6Xvoy6Bj5Sx2q/S084Ua10cC3xsGe+HznmB390bUh7sZpzDgcxOY
	 Iu6DK3hWSgrEySXM/HpeEWVEdWDr5MOx0j5BNRWf4xcIwk7kSnP+CzbWArdCBJ2LKq
	 kJBJn0zqYsXmBc+ZvM20kxdlAseOtSGWyXvnwssG4+c/WkJkKt2igKJVS820XrhZUX
	 L2vhZuMTIJkSl96eMNQnXaBf82co4h54CohNs4SB4U1V7U+CpsOqa2z8FhUDI0Q1pT
	 4jFclgj/TQpng==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Jun 2025 15:13:55 +0100
Subject: [PATCH 2/4] selftests/mm: Convert some cow error reports to
 ksft_perror()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-selftest-mm-cow-tweaks-v1-2-43cd7457500f@kernel.org>
References: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
In-Reply-To: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+8K7IHPM2fvcDtNu46rok2dhi80R6Thr3mEpDEugxAg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoSD6yARNVcgIIAyMWNkKfVEgWVOv+rHJU+IwHQGaA
 c236rxGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEg+sgAKCRAk1otyXVSH0EO8B/
 4tIObYcoHExr8QY9lLg8h65TZOO5K4KTzeF5m1iMQdEH7OtmBkOlYTQtEeZ8Gx88pOR8uzSFC2uxUm
 HrOqjH9RZv7R4WNKP3wKmAG7ojauFv8vuuWDyv9i3UtwFQNWiRK9l/2WFGjuCT46bU0UKzyCddTcjo
 FImOnCwUgbo9jiwXCKeeqvR+NERpp1w8PH6EeyemJy4O7jopdebKr+02h5rDyMZKUraWsZd/8Iri/L
 kWaLx/Pu66Z2jt1Brruzcb4ok0YvvtWRLv1wAjZYayOA0eP7xaX3PK0wUw5wJ7ZscC8OtdHfMc/T1D
 zpAf2lurm+6njmmJjuXrrB6FybfoWC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This prints the errno and a string decode of it.

Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/cow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 0adc0ab142c1..ff80329313e4 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -332,7 +332,7 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 	if (before_fork) {
 		transferred = vmsplice(fds[1], &iov, 1, 0);
 		if (transferred <= 0) {
-			ksft_print_msg("vmsplice() failed\n");
+			ksft_perror("vmsplice() failed\n");
 			log_test_result(KSFT_FAIL);
 			goto close_pipe;
 		}
@@ -562,7 +562,7 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 	while (total < size) {
 		cur = pread(fd, tmp + total, size - total, total);
 		if (cur < 0) {
-			ksft_print_msg("pread() failed\n");
+			ksft_perror("pread() failed\n");
 			log_test_result(KSFT_FAIL);
 			goto quit_child;
 		}
@@ -628,7 +628,7 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 
 	tmp = malloc(size);
 	if (!tmp) {
-		ksft_print_msg("malloc() failed\n");
+		ksft_perror("malloc() failed\n");
 		log_test_result(KSFT_FAIL);
 		return;
 	}

-- 
2.39.5


