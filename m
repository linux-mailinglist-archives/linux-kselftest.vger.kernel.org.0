Return-Path: <linux-kselftest+bounces-34593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE5AD3AFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F3A3A434A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4A92BD027;
	Tue, 10 Jun 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5ZSBf+I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419A2BCF54;
	Tue, 10 Jun 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565112; cv=none; b=BxDsgmh3wxSFSyH+J+fRNf2+aQ+T8u2HEZnUlZ1ZvQUDaUr/quwKsQSEJ/bY8eKwO6388nZ6htwUtlGC309pt4EswuPeM63UAhSsSNJFnNcDRhvbWA5O9YtYNLQXWx0cX5loXk3gLRZHMGRfvvYBWBEk3G9KhmzShrxUuyqKI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565112; c=relaxed/simple;
	bh=LlxLG4ZmmZ05HdJBKIcojJYmWyB7mryqIF9FNdb8jNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIHoaZQ3aXCQPpPifC70ESqJLC3TSa75L8KVls09NdzzMFaorsS3Sm+SbFbGqyuuPAPaldZ4YOY/yhw9kWRcydehoktqfgKb1QqD+tz7U1FOdKAIdpEzHNfgPW9owfredK0ksY0c0VUqXXI71pgraP1/zkatJxL5xrl0TFUeBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5ZSBf+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9719EC4CEF1;
	Tue, 10 Jun 2025 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749565111;
	bh=LlxLG4ZmmZ05HdJBKIcojJYmWyB7mryqIF9FNdb8jNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H5ZSBf+IHIiba142GJw/+yoyKqx4hrCFhGipnZ8suNhcn8mlbu53XL9b2MPeBzD3V
	 UJ+qIPb6ZobgSaE57ezAciyy2bYcwpDF2uU09buGRbuXXTvkfB4mijYDOi5HGK6Dmc
	 ilPEjdiF2pCSqBEscgJKFE5OSXFuu2C7pEuQzjFa+l9dNPVcsIG4jzw2/rZyG/qX3Y
	 K78Ij/zSTdyjnKMwKa8tK2NqMhyubYzhbsMbQJKS5vplo8aqBfpJKw80jM6qd2O5kW
	 TPfq2kBSV1LbceWX9XH5XkNaQiDbEuyegscFt8fbaS5GGnH62JsYh3aDyDtCSN6j37
	 n4qucaNonj8Mg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Jun 2025 15:13:54 +0100
Subject: [PATCH 1/4] kselftest/mm: Clarify errors for pipe()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-selftest-mm-cow-tweaks-v1-1-43cd7457500f@kernel.org>
References: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
In-Reply-To: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LlxLG4ZmmZ05HdJBKIcojJYmWyB7mryqIF9FNdb8jNw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoSD6x1SHgu0Mj8blcBIhqQTzo7nMRr5o1bjePcJ5J
 z8Lr5SaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEg+sQAKCRAk1otyXVSH0EzUB/
 9s7iTIMDN3f4KsC67LoFg7m1MlUCCN6vtcljxtnkG3oEB4ElCHW6rYrPy+BNaQ+A2r33rauIciusf0
 8hDAw1Dc7s26BaKqakVRB4yQzdykb5FDUcwNFO2NbL0jAQO2HQdhpIdYNIcGiIlg81LIvH32pnbnnk
 eI784P1B2DqQJVoaynWIGy6Lgdb8CakHy0iTfHV4x6NA2Zjv85i979hku0oR1uMD9oxnwAlCdtXH/t
 W5bYOhpYkbffWOYX6nFdQr9VPVf1Sz/Qv6BG+hRvUTbCmO2WWPPnaZd5Cv7fRd8AMkTXgRAgfAxmxo
 DCjDhcBfuX0LXwi8ePXqSbUnOCHDha
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Specify that errors reported from pipe() failures are the result of
failures.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/cow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index dbbcc5eb3dce..0adc0ab142c1 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -113,11 +113,11 @@ struct comm_pipes {
 static int setup_comm_pipes(struct comm_pipes *comm_pipes)
 {
 	if (pipe(comm_pipes->child_ready) < 0) {
-		ksft_perror("pipe()");
+		ksft_perror("pipe() failed");
 		return -errno;
 	}
 	if (pipe(comm_pipes->parent_ready) < 0) {
-		ksft_perror("pipe()");
+		ksft_perror("pipe() failed");
 		close(comm_pipes->child_ready[0]);
 		close(comm_pipes->child_ready[1]);
 		return -errno;

-- 
2.39.5


