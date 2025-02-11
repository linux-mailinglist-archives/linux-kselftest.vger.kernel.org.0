Return-Path: <linux-kselftest+bounces-26316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA2A30056
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 02:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201DD3A4F59
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124001EE7D8;
	Tue, 11 Feb 2025 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9fWqzHy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82C1EE7D3;
	Tue, 11 Feb 2025 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237447; cv=none; b=Pla9rgAxeK81oPLZrSuiw+rHOgG4rkcjcTZeRXQJhIf1j3JB5X6u5Pst+AZYPC0LZOhxsSWgmzo0BSrZGGAKxw1lUHC3T+aI6wKz0jEVBmhzIXwPMr0pMF0ZKuOCIAXVG7wYwbKdq3+KhjAehS0pL2HL7EFwSryU3pnQsr3lok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237447; c=relaxed/simple;
	bh=b9Anin/GarFmjd5w007dBJP7jyImFDoapa//UMR4ZUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sV6lytX3KtoKmtQrQL82MX+CSlCiNHDaWMr2Y7jKs5fE5Rt33nPGwAOaTjIys8C8DLevq5dFx/21heWhyfWRCjF1yQtCX3cwkWfl0i6SbJ9PxKQ5TTiYed5PvzyhtdO8jlufLGPetGxX0pRofUq67IEzdgERdtAkew++CTvAQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9fWqzHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93556C4CED1;
	Tue, 11 Feb 2025 01:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237446;
	bh=b9Anin/GarFmjd5w007dBJP7jyImFDoapa//UMR4ZUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9fWqzHyai3V3cW9HZ5qWNY230QGvAqoHrzKi0ERsiFnUvkSJrXB/wEoqwBpOXCX9
	 4+zY1l1KLB4KHDRH87pl/JEXfYiuCzYIKRhVXXK2/JtJO3eDWjjSk6ckXAF0WGZvfu
	 j9EB/ns9C6hhcUUCcXPbacvOrW8MlUw7GtkX6x90MJ3RbPcdamgyN1LQ8vqjP72lgK
	 A4DBbEkH4pYDY6Op5Avgz4GCVopBc5cvW24AI3DPvGmmSzpbBFFlrJQGAOREv6ReNU
	 0gvAADYxBR3e376JeZdurMtiBFE+mqPQH+QWvFZU0+U+tJN8RhR6sRXXU5Auy6liFZ
	 Dh4DCDC4MkvdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	amer.shanawany@gmail.com,
	josef@toxicpanda.com,
	usama.anjum@collabora.com,
	jack@suse.cz,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 21/21] selftests: always check mask returned by statmount(2)
Date: Mon, 10 Feb 2025 20:29:54 -0500
Message-Id: <20250211012954.4096433-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
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
index 8eb6aa606a0d5..46d289611ce86 100644
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


