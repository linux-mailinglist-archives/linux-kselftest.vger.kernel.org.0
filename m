Return-Path: <linux-kselftest+bounces-26317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E74A30088
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 02:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E34918827E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FB51F37CD;
	Tue, 11 Feb 2025 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9DsXNI3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9931F30A0;
	Tue, 11 Feb 2025 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237495; cv=none; b=XEygXJVqexUUuKexWERvTE6zTKbR+I9/amd59U5amNyNbE4Y3lvChp9ZmmASNb9tC45SXt6I3VqaoLsjotxNBthP+CcDoJq+zP6zK8kwYUi0eQafvdbQtdlzCCV3i7/VH5PDjfr3mg79PIVSh6jno6VI2q3b1dUcDbymkOWLRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237495; c=relaxed/simple;
	bh=TiLj7HwEVKOBAnkvBspSiz6TPGHyAeGqz+2v8yYPd1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfXZ0jYBdbuKE1Dp9Qvsyo8fir6RL+yxmhjWE1m+I8qCHe7+lHUAqxp9Zt1+GtL4CXxk4YrnuVJ9dD+vTXwW3RanFpuGVHm1iHeDH/IlWGWxBs9rN/YB/Y9xL/GktEhbec9344bfey13I+ZKtd5Z/QhQXQy0eDkm7YxIbY4UgC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9DsXNI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D3BC4CEE5;
	Tue, 11 Feb 2025 01:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237495;
	bh=TiLj7HwEVKOBAnkvBspSiz6TPGHyAeGqz+2v8yYPd1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9DsXNI3wjZyxR1NnAyJDZtFi7EsIKD0JJKc4gm7EpCr3Nph0Sc9yBf+FKVD/n2+t
	 FlHI4Fqd0BfqUQHPyHSM9d2XDOzyA6j8cFQOYx5Rhp3cCLR8Cz+xeBYNbCCFQAKkVZ
	 H1bDB22U6rI55JhFENTldpT1UUx965vGAThMb5aHO27LSg5pntbv6ziWBFl42iqEXS
	 5Pj+084PfOKicMxCoLkB3RU5Zh9p5RfFc4ov83svUqyXHB76VfwlxofPTTpzx2zveM
	 r/+/UQ6sFStselhZa8nF0jXQyrbn57WjT9ONoBNahx7i3r6mjwBRPwotLbVx7R63R4
	 pP2pB85mZDa2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	usama.anjum@collabora.com,
	josef@toxicpanda.com,
	amer.shanawany@gmail.com,
	jack@suse.cz,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 19/19] selftests: always check mask returned by statmount(2)
Date: Mon, 10 Feb 2025 20:30:47 -0500
Message-Id: <20250211013047.4096767-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 2cc02059fbc79306b53a44b1f1a4444aa3c76598 ]

STATMOUNT_MNT_OPTS can actually be missing if there are no options.  This
is a change of behavior since 75ead69a7173 ("fs: don't let statmount return
empty strings").

The other checks shouldn't actually trigger, but add them for correctness
and for easier debugging if the test fails.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Link: https://lore.kernel.org/r/20250129160641.35485-1-mszeredi@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../filesystems/statmount/statmount_test.c    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index c773334bbcc95..550e5d762c23f 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -383,6 +383,10 @@ static void test_statmount_mnt_point(void)
 		return;
 	}
 
+	if (!(sm->mask & STATMOUNT_MNT_POINT)) {
+		ksft_test_result_fail("missing STATMOUNT_MNT_POINT in mask\n");
+		return;
+	}
 	if (strcmp(sm->str + sm->mnt_point, "/") != 0) {
 		ksft_test_result_fail("unexpected mount point: '%s' != '/'\n",
 				      sm->str + sm->mnt_point);
@@ -408,6 +412,10 @@ static void test_statmount_mnt_root(void)
 				      strerror(errno));
 		return;
 	}
+	if (!(sm->mask & STATMOUNT_MNT_ROOT)) {
+		ksft_test_result_fail("missing STATMOUNT_MNT_ROOT in mask\n");
+		return;
+	}
 	mnt_root = sm->str + sm->mnt_root;
 	last_root = strrchr(mnt_root, '/');
 	if (last_root)
@@ -437,6 +445,10 @@ static void test_statmount_fs_type(void)
 				      strerror(errno));
 		return;
 	}
+	if (!(sm->mask & STATMOUNT_FS_TYPE)) {
+		ksft_test_result_fail("missing STATMOUNT_FS_TYPE in mask\n");
+		return;
+	}
 	fs_type = sm->str + sm->fs_type;
 	for (s = known_fs; s != NULL; s++) {
 		if (strcmp(fs_type, *s) == 0)
@@ -464,6 +476,11 @@ static void test_statmount_mnt_opts(void)
 		return;
 	}
 
+	if (!(sm->mask & STATMOUNT_MNT_BASIC)) {
+		ksft_test_result_fail("missing STATMOUNT_MNT_BASIC in mask\n");
+		return;
+	}
+
 	while (getline(&line, &len, f_mountinfo) != -1) {
 		int i;
 		char *p, *p2;
@@ -514,7 +531,10 @@ static void test_statmount_mnt_opts(void)
 		if (p2)
 			*p2 = '\0';
 
-		statmount_opts = sm->str + sm->mnt_opts;
+		if (sm->mask & STATMOUNT_MNT_OPTS)
+			statmount_opts = sm->str + sm->mnt_opts;
+		else
+			statmount_opts = "";
 		if (strcmp(statmount_opts, p) != 0)
 			ksft_test_result_fail(
 				"unexpected mount options: '%s' != '%s'\n",
-- 
2.39.5


