Return-Path: <linux-kselftest+bounces-22478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F049D6E61
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6E6161C90
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89D1B3922;
	Sun, 24 Nov 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNOVI10H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E91B3953;
	Sun, 24 Nov 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452026; cv=none; b=UU3zVDWwfHIbxRQ7r9BreL2rW5YkwiHA6UXxQI3fMV4kRwKPZzBlMk3HXDnJ2u0mWUdOByqz5AKT9BZaVPZqrJEfZgS5qaZleT8YeHl85yhAcNLpgrZBepAqnE9zJlkHRWIwI+bx8eztvoE2NeaNKheyRk/51RTKFY8iAc80Jg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452026; c=relaxed/simple;
	bh=isrIzBVpqEHXAWK+7dtrVVpLZiim/bjAv0AHGXA4NBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKMpQU28nzC8ppigJHELbZwH013eRcJ/1wy5KY1b+lGd5BN7nsbvpAtgILOBZly+t42FCtdmHajnQOvMq/ceRv7h7qhD/VYWAnRP0I8/jmdh5+47f3GNlpTkYHXx7GkONqSww4+5nmyt837WkunWTzXVTt6Sz2VQ5PrsvkZIvys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNOVI10H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8160FC4CED1;
	Sun, 24 Nov 2024 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452025;
	bh=isrIzBVpqEHXAWK+7dtrVVpLZiim/bjAv0AHGXA4NBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNOVI10H3ZWEmHlLfULf5QlfRjVXAeZw4G+KII4eSiuReRFk/o68pEHTILeV+oPzO
	 dqntUldKXx+oIku5PQhAeV9mNKQioB0lYbRlwVYu2dkVkiqnFDSyvgB8SxzsiIKpRx
	 5liFwAky15EJfT/9ysBA9qE6I4KYnUST8U29QUomO1wsAeG5m7jsdrwJycOqvnvUTO
	 HjgHT1CCF1KiD2bKTsRelsBeawPwZUP7A7JD6HTiFylYYeQwXI2IuEjY3RWAAZweFc
	 pY7z2ZuwMmu883sikCpd/GpRFjsx0goSJW6sK9wKd348Q8+4geIwZ5zC4Qz0Ybd8La
	 /uZikzwHVLIzA==
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
Subject: [PATCH AUTOSEL 6.11 05/16] kselftest/arm64: Log fp-stress child startup errors to stdout
Date: Sun, 24 Nov 2024 07:39:42 -0500
Message-ID: <20241124124009.3336072-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index faac24bdefeb9..80f22789504d6 100644
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


