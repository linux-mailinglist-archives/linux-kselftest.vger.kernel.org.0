Return-Path: <linux-kselftest+bounces-13611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF392ED1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A02EB21787
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9169216D4EE;
	Thu, 11 Jul 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQjXmNL+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A716CD39;
	Thu, 11 Jul 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716878; cv=none; b=NU37QwA+3VG43Q7pMG59AHif9F+tsG4dQA5v9VmvG3HFboXgYb3OKZOZ4XCx5XDgXQgoc1rdeFHWaGuHL1dc1JIoUzLsERgiis4pbv63LYpkeMVtnAC+R3vGd02JDSlDzQ/O+mE/AcqSPVXIe2BkyL1wZKX6AB0dOd+gQy7tQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716878; c=relaxed/simple;
	bh=YhiyGaiuRRSfHnjOqc3BEsL5YLjUMQ8IUktkjyA/ApU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IHt70+VoO3/M+p6r10siu37XSYLEtqN2LOE5m4mvmGA0g8FQvFbBBC3IfSqJ+k7CpUA/UNwz4XiFN1Mwdk9RH3DNFtAFt56gueCTtNyL5yTqnOWKWN/cZGaa/lHfXIstrN2dxbJRWTOuFx5eq/eTKJThbrNdva2iSugaRcqaD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQjXmNL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3033C32786;
	Thu, 11 Jul 2024 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720716877;
	bh=YhiyGaiuRRSfHnjOqc3BEsL5YLjUMQ8IUktkjyA/ApU=;
	h=From:To:Cc:Subject:Date:From;
	b=MQjXmNL+3yXKgd+NtY095FUXMn8NiTd7S8AQkjb/t29nn2AVOmtFiyRiqb0Y4gJiH
	 3ogQIC0RG96++F8RFVAwxFO7JVj05EGZcB46TNm5nOEnEjmj3JIqJ7Wey9naLG3s9v
	 QMFXgGXjnImvUSxG2I7/38VwLp/gScCUQFppOLV6rwS3lvdygnxoFbBhCC1mo/4NDd
	 12oE9OMp0Wn17xJgUmbQUeP26gsjvw25q0hkNxJaYHU3Ti71djA8ENZigyDYyN7zpm
	 DaUcNPh7DZ3kUQEQgrbK4pjCIFCwPZddN/QLGcJWQxXYUZDduZpby//0AZOe1qqGf4
	 ny4k282B+diuw==
From: Kees Cook <kees@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] kunit: executor: Simplify string allocation handling
Date: Thu, 11 Jul 2024 09:54:32 -0700
Message-Id: <20240711165428.it.345-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584; i=kees@kernel.org; h=from:subject:message-id; bh=YhiyGaiuRRSfHnjOqc3BEsL5YLjUMQ8IUktkjyA/ApU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmkA5IYYbjf2+UDJNgaLFC2B6iPUrmI21ygPUrL YH9kE40FwCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpAOSAAKCRCJcvTf3G3A JpNwEACFEm4kfWxNFsNucbzTW5bNVxWSDSwx6Jg5wqG8ATXHyXz/WfyZQ2EhJYFd1nY0Zdvpbbg FTKAD/8hYHpy5Ci73htvaRe9QTl8LhTrR4QOs660Bd3wPh1ebm11IoDCadR6RF4nHzg1linuIw2 ZkrdfLOvq9AAu/9c+Xtl2zAprzYvLVRmxEZ+pNuVsAcLGBCZ6BIONR4F5fF7W2HVOtP4iuuxe5i qN9E6/okxDIN6Z29J0/1Ya8uR0jRI98376WOFYmvmV0/PYiwMrxIiaxbsoiO+nhqyjynW1DJoCh Ns6E/qJnGMs41e1FiI/m5sTgHlYX2Eqez+/Ge4VsQwz+vM+dT37R1h7wCgor8/+x+FV7c2vZgEz 3JzAP+2slipGc1wrCfUZ+H0eTjyizNv0POu8GZGQkrFB8+bCQGGceZ3SxbV8MWcWaKOz00hjV/e JOE3rCzsZkcAeBeRuQD2uVZkFPOK8hn9x4cwaPjx5CFq7cJTvA5w6ffYXKNhTTATEwsyhNM5ZEu PBicdrEvumhwSyCc80owOOJ2rB8DH19TKQufibxV7erwxrHKV0ilEwwsYeK7EdzjXqK0mLSCIMu /gPPWXnQTm6p1FVf3PkPpMihUkkJnp4C51hkZBp+LUIsVyjOw1oAbLJovTBuu9TfkWWJ0+BYibh t4/KHuUJzAWEJ
 0g==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The alloc/copy code pattern is better consolidated to single kstrdup (and
kstrndup) calls instead. This gets rid of deprecated[1] strncpy() uses as
well. Replace one other strncpy() use with the more idiomatic strscpy().

Link: https://github.com/KSPP/linux/issues/90 [1]
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
---
 lib/kunit/executor.c      | 12 +++---------
 lib/kunit/executor_test.c |  2 +-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 70b9a43cd257..34b7b6833df3 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -70,32 +70,26 @@ struct kunit_glob_filter {
 static int kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
 				    const char *filter_glob)
 {
-	const int len = strlen(filter_glob);
 	const char *period = strchr(filter_glob, '.');
 
 	if (!period) {
-		parsed->suite_glob = kzalloc(len + 1, GFP_KERNEL);
+		parsed->suite_glob = kstrdup(filter_glob, GFP_KERNEL);
 		if (!parsed->suite_glob)
 			return -ENOMEM;
-
 		parsed->test_glob = NULL;
-		strcpy(parsed->suite_glob, filter_glob);
 		return 0;
 	}
 
-	parsed->suite_glob = kzalloc(period - filter_glob + 1, GFP_KERNEL);
+	parsed->suite_glob = kstrndup(filter_glob, period - filter_glob, GFP_KERNEL);
 	if (!parsed->suite_glob)
 		return -ENOMEM;
 
-	parsed->test_glob = kzalloc(len - (period - filter_glob) + 1, GFP_KERNEL);
+	parsed->test_glob = kstrdup(period + 1, GFP_KERNEL);
 	if (!parsed->test_glob) {
 		kfree(parsed->suite_glob);
 		return -ENOMEM;
 	}
 
-	strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
-	strncpy(parsed->test_glob, period + 1, len - (period - filter_glob));
-
 	return 0;
 }
 
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 3f7f967e3688..f0090c2729cd 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -286,7 +286,7 @@ static struct kunit_suite *alloc_fake_suite(struct kunit *test,
 
 	/* We normally never expect to allocate suites, hence the non-const cast. */
 	suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
-	strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
+	strscpy((char *)suite->name, suite_name, sizeof(suite->name));
 	suite->test_cases = test_cases;
 
 	return suite;
-- 
2.34.1


