Return-Path: <linux-kselftest+bounces-20428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3709AB9EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 01:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F8C2828C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C981CDFD6;
	Tue, 22 Oct 2024 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQqhPZnY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5F130AF6;
	Tue, 22 Oct 2024 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639260; cv=none; b=EXL6kP4v6cGiNshRnubEv+8claGnfXZwQJvr2ERRgbr+mcQU2Pw6S3JsLhpgMapT8tTqRc+F8sCzSGOicIAaHTLmK5ytT3LlxNfCgERUQO5eqTrFiRvUkTB/ee+iTU8nVp0+ebUpvdKl4tIP1JIsRk65gRPOb5oY9gFZ4EkAvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639260; c=relaxed/simple;
	bh=mYR/ssdjgfhPcrNhC0KC0PPm1VnAe2ZOjmzl7QmBqbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZOPOKFQ0K+M8PYJOGLhqZwrOfmVCc0dwWAWpEkPcxMcqop+ZkwCbvFn8PMFWUTji9MtbXEMes9JZUQsjqraD9daRHU/4KISN153qk23PIeCeAOqxp7lt8XS6/d3Gh9EDgiXQLBG3pn8aqVW4z4GdhqgNOcRvtTwiRay725hgzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQqhPZnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A524C4CEC3;
	Tue, 22 Oct 2024 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729639258;
	bh=mYR/ssdjgfhPcrNhC0KC0PPm1VnAe2ZOjmzl7QmBqbs=;
	h=From:Date:Subject:To:Cc:From;
	b=RQqhPZnYi+hu1W9+0Gb1JegoQyjren/wSbeN62tNOBVVyJwZSA+zeOQQm/RuWvcFf
	 qwaU3640jRT8+Oh2TqAEfkBZYlXdpc6idHMvOQQvrAOhsG54sp/kc+/WNWolwXiZvm
	 JXVXJ4WTowaRAYmqA23wexFUeeP5kjUGn5X09eyvUB93Z4rujRAxH+eIiXcRbVrmBE
	 9dLXZsQyVie+VHbvzpCVnhk6pdNSp0A9LqFlRt2MvKZWfZUz+XJPWOOU8siAbXaNZ1
	 CM2fh0NsANoOECxKZilHRJt5isJMFWbQ9xGBoUJAxjsl5nYA61mo2JYPHazBGgxImf
	 abJxA6sW2iEWw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 23 Oct 2024 00:20:45 +0100
Subject: [PATCH] kselftest/arm64: Log fp-stress child startup errors to
 stdout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-arm64-fp-stress-exec-fail-v1-1-ee3c62932c15@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEwzGGcC/x3MQQqDMBBG4avIrB1IYqilVxEXIf6pA9bKjIgg3
 r2hy2/x3kUGFRi9mosUh5h81wrfNpTntL7BMlVTcCF653tO+nlELhvbrjBjnMhckiw8uT4iP0M
 usaPab4oi5/89jPf9A6VbXN5rAAAA
X-Change-ID: 20241017-arm64-fp-stress-exec-fail-d074ec82cf43
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mYR/ssdjgfhPcrNhC0KC0PPm1VnAe2ZOjmzl7QmBqbs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGDNXQVJDieT+Ucl7taR/RCE7oQToa7f5rzjnl7vR
 Bx07CM6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxgzVwAKCRAk1otyXVSH0KP/B/
 0f7yI4J1eqPI/60TFfWUCAy/B74dWLr3AI0oXXkTBeC8Iw5PbSnnSYTmYE8GYLZ1hLdWzGUmXLvZhz
 QT52ebR/rVoO+6mo4xMYB1gGhubU9rSnWxO6VHO7THtMbkQ2jf0KfYfBmKrFIeWdTb6ur6zMThmMsT
 T1QnVt+cd73XvT9DtzmdiISNdZ8O7hut/3iZOqeDK2C2JxS/b5TL4aXmfqytnukeFUjsJs8enw4f+D
 AdfGjDS5a53HRT2Ny7MkI8cbf/6ZnQGTlLkLmSrfWIT26FEM7lOOZvCyqTRb8L9oih1aKBpxxId7jV
 Tmu/lXqMXR+gTai1JVaeEPx44zIyyH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently if we encounter an error between fork() and exec() of a child
process we log the error to stderr. This means that the errors don't get
annotated with the child information which makes diagnostics harder and
means that if we miss the exit signal from the child we can deadlock
waiting for output from the child. Improve robustness and output quality
by logging to stdout instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index faac24bdefeb9436e2daf20b7250d0ae25ca23a7..80f22789504d661efc52a90d4b0893fbebec42f8 100644
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

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241017-arm64-fp-stress-exec-fail-d074ec82cf43

Best regards,
-- 
Mark Brown <broonie@kernel.org>


