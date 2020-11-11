Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94C2AFA7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 22:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgKKVe4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 16:34:56 -0500
Received: from smtp-42ad.mail.infomaniak.ch ([84.16.66.173]:55077 "EHLO
        smtp-42ad.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbgKKVe4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:56 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdL40hbMzlhGL9;
        Wed, 11 Nov 2020 22:34:52 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdL364mJzlh8T4;
        Wed, 11 Nov 2020 22:34:51 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 6/9] selftests/landlock: Extend layout1.inherit_superset
Date:   Wed, 11 Nov 2020 22:34:39 +0100
Message-Id: <20201111213442.434639-7-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
References: <20201111213442.434639-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These additional checks test that layers are handled as expected in the
superset use case, which complete the inherit_subset checks.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 1885174b2770..c2f65034e4ee 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -907,6 +907,10 @@ TEST_F(layout1, inherit_superset)
 	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, open_fd);
 	ASSERT_EQ(0, close(open_fd));
+	/* File access is allowed for file1_s1d3. */
+	open_fd = open(file1_s1d3, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	ASSERT_EQ(0, close(open_fd));
 
 	/* Now dir_s1d2, parent of dir_s1d3, gets a new rule tied to it. */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_READ_FILE |
@@ -922,6 +926,10 @@ TEST_F(layout1, inherit_superset)
 	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, open_fd);
 	ASSERT_EQ(0, close(open_fd));
+	/* File access is now denied for file1_s1d3. */
+	open_fd = open(file1_s1d3, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(-1, open_fd);
+	ASSERT_EQ(EACCES, errno);
 }
 
 TEST_F(layout1, max_layers)
-- 
2.29.2

