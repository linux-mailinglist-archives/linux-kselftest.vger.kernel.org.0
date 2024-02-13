Return-Path: <linux-kselftest+bounces-4577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49484853A84
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 20:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5BCB21E1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7CA1CAA3;
	Tue, 13 Feb 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7jFgM4X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191510A1F;
	Tue, 13 Feb 2024 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851200; cv=none; b=ieMHEKwQ0OQVTN9hmFqnPwtYJNYaaBLTeEg3E/MWrh/315dbZ3KBZO7DIpt65rQ9CQ7lB5wEWRGB4yCE3IaOIuBfvSR5sxoI0SnU42+SjiN+vcBQfOmfuqTZXAIYyi/U4lg2yUxmpL0Tjqpl18OjUFGCceE5rCIMhx9aMTvAjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851200; c=relaxed/simple;
	bh=Gw1CLABHdLSREPjmsGpSQgxQ33jFrHLiGLWyntbYGi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TW1XgblMfGFNQHy419Es0LPb362JNx75lqYfXEa3JhchHY3PqzlzTTIGGCBdJYSsSXlBmAONGaqhlxSf3Jbm5/EveUNOkYj7I5ZFH3/SLMcL0G8jPqFZpvI2YF1NXXiRvW19Mx/6w3dVChIo+e4tH2qSxQx19zpJdRbk7svP6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7jFgM4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837ABC433F1;
	Tue, 13 Feb 2024 19:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707851199;
	bh=Gw1CLABHdLSREPjmsGpSQgxQ33jFrHLiGLWyntbYGi0=;
	h=From:Date:Subject:To:Cc:From;
	b=a7jFgM4XnoeYLMbIPH4dAgz9wqsxVhQLSq71J9dKwBX24pVefaP3OEibgi/5+ju6s
	 OMHKa1YNoqYKjjfmMgYtnJkwhaTmSKbA+vwruPwmQdXmMZq8uifPEHptUDWFsOm3f6
	 tVOFLYUzEaGH+Yfr9hZCZpBYUnQJDTpc/BZ72VxWlg8fE7vcBJP01oAHIcFfaZjT3p
	 +NCvEtIow59l9Yo6k618+cTAPu3S3Og8jrKLP9/29Wckfiq277piMo7+mhglpDMkVf
	 tIX/4SfJ0sEJeYauiatpJSgNnYV924oUAOBvKnZxgGQ6xOrl3MurG78hqb4Y5N7jEK
	 ZtRMMccRxiXjA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 13 Feb 2024 19:06:02 +0000
Subject: [PATCH] selftests: fuxex: Report a unique test name per run of
 futex_requeue_pi
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-kselftest-futex-requeue-pi-unique-v1-1-fa160a4a7ade@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJm9y2UC/x2NzQqDMBAGX0X23IWYWA++SunBny92aYk2m4ggv
 rvB28xl5iBFFCh11UERm6gsoUj9qGj89GEGy1ScrLGNsbXjr+LnEzSxzwk7R/wzMngVzkEK87N
 vWuuM8+0wUumsEV72+/F6n+cFU419zXMAAAA=
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Gw1CLABHdLSREPjmsGpSQgxQ33jFrHLiGLWyntbYGi0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBly728JE9/sjpLA+molsY4IjLnMKEYeBb56mcXOoZg
 43+xunCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcu9vAAKCRAk1otyXVSH0KU5B/
 kBnOH3XDHuaEfjvWSGla+lUJwLaB4ISoxk8/P3UFtpjh8t+MI2uV+b+Fia6XOf3TSMBgEXPaBO8kgp
 zPmhDiI/tCqy6nD4I8SlaOfWkZPwgpp+pD2Zlaoe4uOxD/Id6Mvgih1LWSq/VyyqkmdAKgDoBGgpQw
 7YKNhCGmdZytZ9nErrgaUF3lrs/g9d/9yx0yHCscIzcgx9tNS9xzCiKQ/CPYes9JSXYQ4I68Xpkda4
 w+D2OPPsaSdMet7zmQomdF73SV1S6C3JK4JWrH9dq8pzThNU2ShLvrVNbKVBzCoeIS3hi7P9z62/9H
 p92U7NYdmDc9RtwoxyxefCnKYfj6RK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The futex_requeue_pi test program is run a number of times with different
options to provide multiple test cases. Currently every time it runs it
reports the result with a consistent string, meaning that automated systems
parsing the TAP output from a test run have difficulty in distinguishing
which test is which.

The parameters used for the test are already logged as part of the test
output, let's use the same format to roll them into the test name that we
use with KTAP so that automated systems can follow the results of the
individual cases that get run.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 1ee5518ee6b7..7f3ca5c78df1 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -17,6 +17,8 @@
  *
  *****************************************************************************/
 
+#define _GNU_SOURCE
+
 #include <errno.h>
 #include <limits.h>
 #include <pthread.h>
@@ -358,6 +360,7 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
 
 int main(int argc, char *argv[])
 {
+	const char *test_name;
 	int c, ret;
 
 	while ((c = getopt(argc, argv, "bchlot:v:")) != -1) {
@@ -397,6 +400,14 @@ int main(int argc, char *argv[])
 		"\tArguments: broadcast=%d locked=%d owner=%d timeout=%ldns\n",
 		broadcast, locked, owner, timeout_ns);
 
+	ret = asprintf(&test_name,
+		       "%s broadcast=%d locked=%d owner=%d timeout=%ldns",
+		       TEST_NAME, broadcast, locked, owner, timeout_ns);
+	if (ret < 0) {
+		ksft_print_msg("Failed to generate test name\n");
+		test_name = TEST_NAME;
+	}
+
 	/*
 	 * FIXME: unit_test is obsolete now that we parse options and the
 	 * various style of runs are done by run.sh - simplify the code and move
@@ -404,6 +415,6 @@ int main(int argc, char *argv[])
 	 */
 	ret = unit_test(broadcast, locked, owner, timeout_ns);
 
-	print_result(TEST_NAME, ret);
+	print_result(test_name, ret);
 	return ret;
 }

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240213-kselftest-futex-requeue-pi-unique-5a462303f6bc

Best regards,
-- 
Mark Brown <broonie@kernel.org>


