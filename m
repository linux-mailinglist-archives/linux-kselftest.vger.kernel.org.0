Return-Path: <linux-kselftest+bounces-20951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E539B49C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 13:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E9F283BDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC489450;
	Tue, 29 Oct 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1Jtlj2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE0539A;
	Tue, 29 Oct 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205293; cv=none; b=BgcaZ/8POGY2+s4AWDkw7KILD0kLuZ9uwYmUNpKCKtrVKlxnduiZZmaUbAaKReayGyxDA61+Ke6n8BrqOQgy9bB+PjFOMHvjCXKjedMQ4k39yf2JV3PQD3Ghq177uqedgVOQ8huKYB99fo7krcs+Ppfkgeh7EaiONDKL8Z73yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205293; c=relaxed/simple;
	bh=NKB+ZlfQbziBfBlBBE+pn9QCIwaJEp2jfmcr+pSmHHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s0TBJ0RiaIWl5Bg+5ppG3TGSepl0GE78IGMvmhj8gDZ2mwcxhcoki1WqH5hkk7hUnEQWMIw2qkWxY7fC9et0Nz2K7fVSOKbp9wtYtdWaBbFPDJ+yUtYszbxmted8x8GvSV4Lhq7TmDVbrDw5GuRPA3XFxXPfbQpvTOk7AFgbngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1Jtlj2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1B4C4CEE5;
	Tue, 29 Oct 2024 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730205293;
	bh=NKB+ZlfQbziBfBlBBE+pn9QCIwaJEp2jfmcr+pSmHHU=;
	h=From:Date:Subject:To:Cc:From;
	b=G1Jtlj2+iEWXgFhBGPfX/lZkjwFEOgefkDVxSasALFxpq0w7oqt+hds0bC9j9jcsx
	 giOZnmlQyG4OU1rOIPLvvgvviBBdlj1oiw7Bkg3uA4Fu4LyuxWkFyhginYCKA0Xa8V
	 KEW3ppILHI58LyZWFdQhgk+UPbUjcG+COD+g0zDofP5el3N2bOEYbbAHob8z/r61Jk
	 U8rTmedmJVuDOElbKN2epYacYIf41FGejXJQwGyq3DSgIOx4EVELqx4blotDW/ptIi
	 eSoxfudlFsxmek9wr7NDv9TDIOKRM7EHEM7xn2O/iDnZ7Ts7E8cTrvgvTLJ0B0AeyA
	 mKC1Hpm+F1TJQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 29 Oct 2024 12:34:21 +0000
Subject: [PATCH] kselftest/arm64: Use ksft_perror() to log MTE failures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm64-mte-test-logging-v1-1-a128e732e36e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEzWIGcC/x3MQQqAIBBA0avErBtQC42uEi3MJhsoC5UIorsnL
 d/i/wcSRaYEffVApIsTH6FA1hW41QZPyHMxKKFaKVSHNu66xT0TZkoZt8N7Dh6102QaM0mnFZT
 4jLTw/Y+H8X0/O5kx4GgAAAA=
X-Change-ID: 20241028-arm64-mte-test-logging-6c6e737b1c62
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=3172; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NKB+ZlfQbziBfBlBBE+pn9QCIwaJEp2jfmcr+pSmHHU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnINZqe5cVqcCpYPiyBK8ItAMmvUBl5Iw5X8JLachm
 pABLYb2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyDWagAKCRAk1otyXVSH0D4hB/
 9SchFIzWN+pwAmX2R7lHgOrGmnmXGeAShMsi+Hr1lqx75nOab+CMZByKfL3iOU9k40/YeQrLUekB+k
 3KincABA0I/WKqTDckghBVrRVPJgC++SE48S8Ian8d5Ke0lbtokDyV6m4xYCVYw0HZis84r6fp4D4R
 G/qoOk7BLHTGW6S6b3wCXsgFbiPFuTt/K7FIDjRzP0evqhMO/aNe63vAX/g5MSNkwE1gpj6muJfY28
 lm14hCSaW+RNx8YKJR63IyV85MuQvL9vcCxB7aV2twKi6OMS7srzpAEjCsQaTrhKYlh2EXUkbgAYkM
 6iMCZVlbdQ0WDPeg+DQHDmYUy2tolX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The logging in the allocation helpers variously uses ksft_print_msg() with
very intermittent logging of errno and perror() (which won't produce KTAP
conformant output) when logging the result of API calls that set errno.
Standardise on using the ksft_perror() helper in these cases so that more
information is available should the tests fail.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 00ffd34c66d301ee7d5c99e6b8d9d5d944520b7f..46958b58801e90ceb79be76f57c7f72b50d43b3c 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -150,13 +150,13 @@ static void *__mte_allocate_memory_range(size_t size, int mem_type, int mapping,
 		map_flag |= MAP_PRIVATE;
 	ptr = mmap(NULL, entire_size, prot_flag, map_flag, fd, 0);
 	if (ptr == MAP_FAILED) {
-		ksft_print_msg("FAIL: mmap allocation\n");
+		ksft_perror("mmap()");
 		return NULL;
 	}
 	if (mem_type == USE_MPROTECT) {
 		if (mprotect(ptr, entire_size, prot_flag | PROT_MTE)) {
+			ksft_perror("mprotect(PROT_MTE)");
 			munmap(ptr, size);
-			ksft_print_msg("FAIL: mprotect PROT_MTE property\n");
 			return NULL;
 		}
 	}
@@ -190,13 +190,13 @@ void *mte_allocate_file_memory(size_t size, int mem_type, int mapping, bool tags
 	lseek(fd, 0, SEEK_SET);
 	for (index = INIT_BUFFER_SIZE; index < size; index += INIT_BUFFER_SIZE) {
 		if (write(fd, buffer, INIT_BUFFER_SIZE) != INIT_BUFFER_SIZE) {
-			perror("initialising buffer");
+			ksft_perror("initialising buffer");
 			return NULL;
 		}
 	}
 	index -= INIT_BUFFER_SIZE;
 	if (write(fd, buffer, size - index) != size - index) {
-		perror("initialising buffer");
+		ksft_perror("initialising buffer");
 		return NULL;
 	}
 	return __mte_allocate_memory_range(size, mem_type, mapping, 0, 0, tags, fd);
@@ -217,12 +217,12 @@ void *mte_allocate_file_memory_tag_range(size_t size, int mem_type, int mapping,
 	lseek(fd, 0, SEEK_SET);
 	for (index = INIT_BUFFER_SIZE; index < map_size; index += INIT_BUFFER_SIZE)
 		if (write(fd, buffer, INIT_BUFFER_SIZE) != INIT_BUFFER_SIZE) {
-			perror("initialising buffer");
+			ksft_perror("initialising buffer");
 			return NULL;
 		}
 	index -= INIT_BUFFER_SIZE;
 	if (write(fd, buffer, map_size - index) != map_size - index) {
-		perror("initialising buffer");
+		ksft_perror("initialising buffer");
 		return NULL;
 	}
 	return __mte_allocate_memory_range(size, mem_type, mapping, range_before,
@@ -359,7 +359,7 @@ int create_temp_file(void)
 	/* Create a file in the tmpfs filesystem */
 	fd = mkstemp(&filename[0]);
 	if (fd == -1) {
-		perror(filename);
+		ksft_perror(filename);
 		ksft_print_msg("FAIL: Unable to open temporary file\n");
 		return 0;
 	}

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241028-arm64-mte-test-logging-6c6e737b1c62

Best regards,
-- 
Mark Brown <broonie@kernel.org>


