Return-Path: <linux-kselftest+bounces-22481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386E9D6E7B
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192CA28155D
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428061CEADF;
	Sun, 24 Nov 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzMRMdM8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A491CEAD6;
	Sun, 24 Nov 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452063; cv=none; b=t9YQRH4kJtXPnntl2mIXVkGfynA0baug0SraV92HgS8fdf8N+lzPKNvtiZWsGvS12j5vrE01syyo35ts8g2dNsvd7qunWl6wrPqcRvVULBouc33xSwB5GSOaV5pPhuPodJkPswSENDBPrhz7sNf1Xuoh/HVWXlS9fIqEL4iyoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452063; c=relaxed/simple;
	bh=4WZVq7eVWn7R4ZLmSXpOeG5QaJgZKURXFUqKKXPdDJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4M1zWKhQKRrJ9msThKcgyX+DK/x+qwBp0JMjp46IPQP0A+e3NUTbNXdO6QpNXJ+b7163UTNn+RlDwJBHEFsYFHwFIMBiWGsAs0SJX+14fml9qfWj3kP4EyLZkOGzlHvz6ePV5NyICQvV0yBBlT5D4zVF8rHt54g2pADzktX+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzMRMdM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2C5C4CECC;
	Sun, 24 Nov 2024 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452063;
	bh=4WZVq7eVWn7R4ZLmSXpOeG5QaJgZKURXFUqKKXPdDJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzMRMdM8wiIInPTpX9DUKk1DvDrfMb2I5Q4YS0P95U4CWsoONXsrYLZJ5oxE7wq3U
	 7qdgOwHWT7moiduUe5bGgzaJMf0tD0XqAHj27Ox/U/itDR81AqBzVeuMXT084LJzLV
	 u6X1yVwqXdOftKjpWthQ8YY/LAEceG8kP3Pg2/wNEZ35vaFjGLBe/Ik3eKJBsw/3+N
	 NL6W8YAxqol5dni6uoZilm7JZcSbmKIQ5hN3Hk0rfb5+JvLXXBO6nAvUPQHKr6OdlG
	 bhBo9TrgcspyekQX0+38ABSBcHutMAXGABab1GNDhWR5xSChtF4sguKnTAFbZ1Ub63
	 m9oxfIc38nXLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	shuah@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 2/9] kselftest/arm64: Log fp-stress child startup errors to stdout
Date: Sun, 24 Nov 2024 07:40:40 -0500
Message-ID: <20241124124057.3336453-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124057.3336453-1-sashal@kernel.org>
References: <20241124124057.3336453-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit dca93d29845dfed60910ba13dbfb6ae6a0e19f6d ]

Currently if we encounter an error between fork() and exec() of a child
process we log the error to stderr. This means that the errors don't get
annotated with the child information which makes diagnostics harder and
means that if we miss the exit signal from the child we can deadlock
waiting for output from the child. Improve robustness and output quality
by logging to stdout instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20241023-arm64-fp-stress-exec-fail-v1-1-ee3c62932c15@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index dd31647b00a22..cf9d7b2e4630c 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -79,7 +79,7 @@ static void child_start(struct child_data *child, const char *program)
 		 */
 		ret = dup2(pipefd[1], 1);
 		if (ret == -1) {
-			fprintf(stderr, "dup2() %d\n", errno);
+			printf("dup2() %d\n", errno);
 			exit(EXIT_FAILURE);
 		}
 
@@ -89,7 +89,7 @@ static void child_start(struct child_data *child, const char *program)
 		 */
 		ret = dup2(startup_pipe[0], 3);
 		if (ret == -1) {
-			fprintf(stderr, "dup2() %d\n", errno);
+			printf("dup2() %d\n", errno);
 			exit(EXIT_FAILURE);
 		}
 
@@ -107,16 +107,15 @@ static void child_start(struct child_data *child, const char *program)
 		 */
 		ret = read(3, &i, sizeof(i));
 		if (ret < 0)
-			fprintf(stderr, "read(startp pipe) failed: %s (%d)\n",
-				strerror(errno), errno);
+			printf("read(startp pipe) failed: %s (%d)\n",
+			       strerror(errno), errno);
 		if (ret > 0)
-			fprintf(stderr, "%d bytes of data on startup pipe\n",
-				ret);
+			printf("%d bytes of data on startup pipe\n", ret);
 		close(3);
 
 		ret = execl(program, program, NULL);
-		fprintf(stderr, "execl(%s) failed: %d (%s)\n",
-			program, errno, strerror(errno));
+		printf("execl(%s) failed: %d (%s)\n",
+		       program, errno, strerror(errno));
 
 		exit(EXIT_FAILURE);
 	} else {
-- 
2.43.0


