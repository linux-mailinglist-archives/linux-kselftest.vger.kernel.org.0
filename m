Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6EF38FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 20:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfKGTyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 14:54:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43170 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfKGTyF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 14:54:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so2654356pgh.10
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yt65JEzI8B4ThC22+VCw7CM+LK+ArEMO8/zLSXCHvk0=;
        b=xJlo1DuPB3YVBQAgFBR+GjVfwFtDBuQ75nv+sOnYtZPQ9qSXZxB8HraZUGDFxy1Drz
         f71wLXCjXxGHlCCs4z60NYnl14ny5cszdYwgmbJgZFxncgjtZ1MXyr1R/0NkJ+bOhIbG
         3pRidFtRgR2sgu8rJHSs23dG8WMz3UGcczVaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yt65JEzI8B4ThC22+VCw7CM+LK+ArEMO8/zLSXCHvk0=;
        b=f2ZV3VRm9moH6dMoSVr+KmPzr56AbAuc++MsOJx0vD9V2D1NZ1HZ7P7vav17LAegnL
         new7wwx/0J6iFdMzbZMoaUyB8ZIS2kKj4eOnvNHooNEzCe9gbj7y3LLHnStTkSUTAGdZ
         ibcqOuzzQWEmt+y3uXhoJNyPeI+CIXtxt5dg2tQwJJaS7wLoXy3Kx0+nr0NEIYg1u1P0
         tp+AyGWz5QhtHbovPgolasqOye9QrQ+soj5kKq/or6oV6h0rZNgPoxdFyyJ9hicPIBdP
         rp9lFhDXMlfpJzokwYLtQSDgGHS9l3SIZfp0hFrKt67jYyjrG6m3TAIHPQQEnjQbue+R
         hnMA==
X-Gm-Message-State: APjAAAU42H86ZP42ZslV1ZYcUUyLNilY3YB9y7EbqN0gXKmV9MhhhmM0
        1+OvnNLjKZZ+0QL+QUUmlVi6VA==
X-Google-Smtp-Source: APXvYqyoeYqV+vMTE2cL67Ov6JWJRzPg3lrGLBosK857p3VGFNE53iEGD9JcdWLwOQIALLrrUutrDg==
X-Received: by 2002:a63:d70f:: with SMTP id d15mr6903311pgg.424.1573156444237;
        Thu, 07 Nov 2019 11:54:04 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y2sm3365870pfe.126.2019.11.07.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:54:03 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 2/2] memfd: Add test for COW on MAP_PRIVATE and F_SEAL_FUTURE_WRITE mappings
Date:   Thu,  7 Nov 2019 14:53:55 -0500
Message-Id: <20191107195355.80608-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191107195355.80608-1-joel@joelfernandes.org>
References: <20191107195355.80608-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In this test, the parent and child both have writable private mappings.
The test shows that without the patch in this series, the parent and
child shared the same memory which is incorrect. In other words, COW
needs to be triggered so any writes to child's copy stays local to the
child.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index c67d32eeb668..334a7eea2004 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -290,6 +290,40 @@ static void mfd_assert_read_shared(int fd)
 	munmap(p, mfd_def_size);
 }
 
+static void mfd_assert_fork_private_write(int fd)
+{
+	int *p;
+	pid_t pid;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE,
+		 fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		abort();
+	}
+
+	p[0] = 22;
+
+	pid = fork();
+	if (pid == 0) {
+		p[0] = 33;
+		exit(0);
+	} else {
+		waitpid(pid, NULL, 0);
+
+		if (p[0] != 22) {
+			printf("MAP_PRIVATE copy-on-write failed: %m\n");
+			abort();
+		}
+	}
+
+	munmap(p, mfd_def_size);
+}
+
 static void mfd_assert_write(int fd)
 {
 	ssize_t l;
@@ -760,6 +794,8 @@ static void test_seal_future_write(void)
 	mfd_assert_read_shared(fd2);
 	mfd_fail_write(fd2);
 
+	mfd_assert_fork_private_write(fd);
+
 	munmap(p, mfd_def_size);
 	close(fd2);
 	close(fd);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

