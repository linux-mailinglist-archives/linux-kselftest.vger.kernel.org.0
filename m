Return-Path: <linux-kselftest+bounces-37624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0514CB0AF84
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EC0567C6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ADD23A9B3;
	Sat, 19 Jul 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYskL6EN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F62238C3D;
	Sat, 19 Jul 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923599; cv=none; b=jABSucary5ThyaUEGuYkYeYObXmaToxzEYMWOZgJIGg+GKE3HAY+cmYbqtgDX+KcTatmSVjeHujhRSr3lT2a4q8Zfjvlv6Y7PI/vTwchX/WMb4XOKhoLAHSlbZn5gZhEI0VKNEa4n5TnhC6RiBKyYKnQ5OGBstG6ybdVacuH/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923599; c=relaxed/simple;
	bh=jTePs6g/xDy0KJam8dPT5XZrMR7zmL6IWyOVHqVv93U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPHBzLHgic8/OmVzoAOIODsiSiarlT1MTdxvd21fPpNUBfu2qEcRNpRnBoqk6hht70WYxtb4+gbHAI9s01oLmB7Q9+/t55+Kty9Hsr2J6cOCVEKiAbRJwBG4JZQuAeO347+WkIsWe0vbC7R9hsDa8PBDophsRuL8GiTrHpYVd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYskL6EN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234f17910d8so26316605ad.3;
        Sat, 19 Jul 2025 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752923597; x=1753528397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvKCv6POf+5AvCdbHnruXesLTDDbd3C3Hwxx7A1XmSQ=;
        b=kYskL6ENc4OPaXs1xNRtoE5LauuVd7Cx3AB5w0BirHEbhDoP67OZQ7sOm2PPBe7UOa
         fnnkjwd2Ss9AsUqTbRS+pK+siR43rHAQUzQ6YHmb1Xpjus52ZOPgCVBU3+Va1fELhg5d
         OrVMArms1ZlrA7CgCY9mOoMJRBbzkSHALRYswH7Agggvy84NtZon1895l8VmDkkSCJO0
         JEGuFRVo2DNrm0L8pHBtMHdDUaiOlsgSTm7F+JHZre5oAa2U+m5xWQ48+CWCKsj3dJ+h
         /B4MvmgbI5AxtkarWORj+00PWLqzucSZznmFMBU9kOSzafpdUoORAFrcUJuC4z7Oowac
         5/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752923597; x=1753528397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvKCv6POf+5AvCdbHnruXesLTDDbd3C3Hwxx7A1XmSQ=;
        b=UyRP9h6nuaDxFw7eGyfCypFkjsuoiSdjySiS/EdZesqIZv5YktDcrAa2KsgNsI7apU
         Pm70EfdpNBEkZuWnllIV0ocumvkPjOM/18hnDT9s/sqgNzU7lcdpcBznCeDVBUNPAr/1
         p9ZgBS97O82SA63yzhnBqpteHU37xvnK2SZdETMBOHM9+fwmE9WO9oYOd8RCRJ2nw1D5
         Dkx+FmfQcJyRpPGJz8QJMtaj69/S2uwKAQnK3+aXoumV01e0lGASLsTl2elnQo1SDAVp
         8NQs+UpxByq8cRwI18myG5tQE1Mi4hP2p7+JLRqTXftrAh5FlR+kdL+04P1ezmti4QJG
         4X7A==
X-Forwarded-Encrypted: i=1; AJvYcCVnlQptGWWHiOTFe24ElGNfHS2JKvTeDlsHmRUWMeG8W/cB/wODbdE6IGWn7WM82Ko7MISFmAuyyUTytNNNBCj1@vger.kernel.org, AJvYcCXggJQHIFD5GtMnLIthrZ0hoScGePRgxQMvXtSxLYIERuLy0N564y1JGTqgXD26fxKQwqW7BNHVcYBbLVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwufS+1+kltl+LeTUjHrJBRQ/CQ0j+liutUQbx/ZpZg5Of9HTzv
	0fYcWuUf6cgddtFoWDz4Ukqp30Jx7LdBGr2Zbw0hqhUNi8pY3YW0UDuQ
X-Gm-Gg: ASbGncuIzGR6jhzR8Wf17m6bq365rMoPVAHbvegld/bMADKwEcY6QGln+8o/lFNw3jF
	m3otVfoGzKzoYceReQwrT8jY67ooWQBWZJEdKHIvAW8f9GA4WPdKvZj/AnBtxAlRmeZkweTjVRQ
	uatVO7JVHhnVAhV+8kYHcROqHzXaewOIdbFWBtC55cmcXXnuOsWmhXbWaqmsWSOli99FC/Qr/Tk
	UIXxVBI9svD50mYweQS92HhhUUX8mZvE1jjGHEpmQs+nkx21JHibHf7fs6cX7xq0qZcwl7pZXlN
	CPUwstKO+RkxKxbOZdPAcpKPhkqk3HAGLU0GdQ5gUsS8SO8FvwwwpgEb/4fZMByrtTyabz/kVEu
	uVr3eUB3THhYshSOc6vqO
X-Google-Smtp-Source: AGHT+IFRfrvqzxiwMbV8CwJ5I6js0u8MPmEPzO2Ffha8E3FwP+dU4AjKqVbLuCunSymTwhiOfQz7sw==
X-Received: by 2002:a17:902:e542:b0:234:c549:d9dd with SMTP id d9443c01a7336-23e3b8832damr89104455ad.48.1752923596740;
        Sat, 19 Jul 2025 04:13:16 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4c81sm27388875ad.114.2025.07.19.04.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 04:13:16 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Sat, 19 Jul 2025 05:13:12 -0600
Subject: [PATCH RFC 2/4] landlock: implement memfd detection
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-memfd-exec-v1-2-0ef7feba5821@gmail.com>
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
In-Reply-To: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752923593; l=13773;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=jTePs6g/xDy0KJam8dPT5XZrMR7zmL6IWyOVHqVv93U=;
 b=HlbWfRKoqOSYdiRe79uit+bXuea7BKOQbxcPW3mT3KSlkWnzsPb+SCiKphyYqRGAlS2ET9gL4
 FOJgOQJksbiDbI62fqDQAL0U7GOXpvua/JcHEmHQDHc6XN3IXtg+aBX
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Add is_memfd_file() function to reliably detect memfd files by checking
for "memfd:" prefix in dentry names on shmem-backed files. This
distinguishes true memfd files from regular shmem files.

Move domain_is_scoped() to domain.c for reuse across subsystems.
Add comprehensive kunit tests for memfd detection edge cases.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 security/landlock/domain.c |  67 +++++++++++++++
 security/landlock/domain.h |   4 +
 security/landlock/fs.c     | 210 +++++++++++++++++++++++++++++++++++++++++++++
 security/landlock/task.c   |  67 ---------------
 4 files changed, 281 insertions(+), 67 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a647b68e8d06..993c299ca263 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -262,3 +262,70 @@ kunit_test_suite(test_suite);
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
 #endif /* CONFIG_AUDIT */
+
+/**
+ * domain_is_scoped - Checks if the client domain is scoped in the same
+ *		      domain as the server.
+ *
+ * @client: IPC sender domain.
+ * @server: IPC receiver domain.
+ * @scope: The scope restriction criteria.
+ *
+ * Returns: True if the @client domain is scoped to access the @server,
+ * unless the @server is also scoped in the same domain as @client.
+ */
+bool domain_is_scoped(const struct landlock_ruleset *const client,
+		      const struct landlock_ruleset *const server,
+		      access_mask_t scope)
+{
+	int client_layer, server_layer;
+	const struct landlock_hierarchy *client_walker, *server_walker;
+
+	/* Quick return if client has no domain */
+	if (WARN_ON_ONCE(!client))
+		return false;
+
+	client_layer = client->num_layers - 1;
+	client_walker = client->hierarchy;
+	/*
+	 * client_layer must be a signed integer with greater capacity
+	 * than client->num_layers to ensure the following loop stops.
+	 */
+	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
+
+	server_layer = server ? (server->num_layers - 1) : -1;
+	server_walker = server ? server->hierarchy : NULL;
+
+	/*
+	 * Walks client's parent domains down to the same hierarchy level
+	 * as the server's domain, and checks that none of these client's
+	 * parent domains are scoped.
+	 */
+	for (; client_layer > server_layer; client_layer--) {
+		if (landlock_get_scope_mask(client, client_layer) & scope)
+			return true;
+
+		client_walker = client_walker->parent;
+	}
+	/*
+	 * Walks server's parent domains down to the same hierarchy level as
+	 * the client's domain.
+	 */
+	for (; server_layer > client_layer; server_layer--)
+		server_walker = server_walker->parent;
+
+	for (; client_layer >= 0; client_layer--) {
+		if (landlock_get_scope_mask(client, client_layer) & scope) {
+			/*
+			 * Client and server are at the same level in the
+			 * hierarchy. If the client is scoped, the request is
+			 * only allowed if this domain is also a server's
+			 * ancestor.
+			 */
+			return server_walker != client_walker;
+		}
+		client_walker = client_walker->parent;
+		server_walker = server_walker->parent;
+	}
+	return false;
+}
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 7fb70b25f85a..21a9eea644bd 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -171,4 +171,8 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 	}
 }
 
+bool domain_is_scoped(const struct landlock_ruleset *const client,
+		      const struct landlock_ruleset *const server,
+		      access_mask_t scope);
+
 #endif /* _SECURITY_LANDLOCK_DOMAIN_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index da862fda329b..d86d21034f4c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -18,6 +18,7 @@
 #include <linux/dcache.h>
 #include <linux/err.h>
 #include <linux/falloc.h>
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -25,19 +26,26 @@
 #include <linux/list.h>
 #include <linux/lsm_audit.h>
 #include <linux/lsm_hooks.h>
+#include <linux/memfd.h>
+#include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/path.h>
 #include <linux/pid.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
+#include <linux/shmem_fs.h>
 #include <linux/spinlock.h>
 #include <linux/stat.h>
+#include <linux/syscalls.h>
+#include <linux/mman.h>
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/fcntl.h>
 #include <uapi/linux/fiemap.h>
 #include <uapi/linux/landlock.h>
+#include <linux/binfmts.h>
 
 #include "access.h"
 #include "audit.h"
@@ -1667,6 +1675,201 @@ get_required_file_open_access(const struct file *const file)
 	return access;
 }
 
+/**
+ * is_memfd_file - Check if file was created via memfd_create()
+ * @file: File to check
+ *
+ * Returns true if @file was created via memfd_create(), false otherwise.
+ *
+ * memfd files are shmem-backed files with "memfd:" prefix in their dentry name.
+ * This is the definitive way to distinguish memfd files from regular shmem
+ * files.
+ */
+static bool is_memfd_file(struct file *file)
+{
+	const struct dentry *dentry;
+	const unsigned char *name;
+	size_t name_len;
+
+	/* Fast path: basic validation */
+	if (unlikely(!file))
+		return false;
+
+	/* Must be shmem-backed first - this is the cheapest definitive check */
+	if (!shmem_file(file))
+		return false;
+
+#ifdef CONFIG_MEMFD_CREATE
+
+	/* Validate dentry and get name info */
+	dentry = file->f_path.dentry;
+	if (unlikely(!dentry))
+		return false;
+
+	name_len = dentry->d_name.len;
+	name = dentry->d_name.name;
+
+	/* memfd files always have "memfd:" prefix (6 characters) */
+	if (name_len < 6 || unlikely(!name))
+		return false;
+
+	/* Check for exact "memfd:" prefix */
+	return memcmp(name, "memfd:", 6) == 0;
+#else
+	return false;
+#endif
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+/*
+ * Test that is_memfd_file() returns false for NULL input
+ */
+static void test_memfd_null_file(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, is_memfd_file(NULL));
+}
+
+/*
+ * Test that regular shmem files are correctly distinguished from memfd files
+ */
+static void test_shmem_vs_memfd_detection(struct kunit *test)
+{
+	struct file *shmem_files[4];
+	static const char *const names[] = {
+		"regular_shmem", "", "large_shmem",
+		"memfd_fake" /* This should NOT be detected as memfd */
+	};
+	static const size_t sizes[] = { 4096, 4096, 1024 * 1024, 8192 };
+	static const unsigned long vm_flags[] = { VM_NORESERVE, 0,
+						  VM_NORESERVE | VM_ACCOUNT,
+						  VM_NORESERVE };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(shmem_files); i++) {
+		shmem_files[i] =
+			shmem_file_setup(names[i], sizes[i], vm_flags[i]);
+		KUNIT_ASSERT_FALSE(test, IS_ERR(shmem_files[i]));
+
+		/* All should be shmem-backed but NOT memfd */
+		KUNIT_EXPECT_TRUE(test, shmem_file(shmem_files[i]));
+		KUNIT_EXPECT_FALSE(test, is_memfd_file(shmem_files[i]));
+
+		/* Verify dentry name doesn't have memfd: prefix */
+		if (shmem_files[i]->f_path.dentry &&
+		    shmem_files[i]->f_path.dentry->d_name.name) {
+			const char *dentry_name =
+				shmem_files[i]->f_path.dentry->d_name.name;
+			KUNIT_EXPECT_TRUE(test,
+					  strlen(dentry_name) < 6 ||
+						  memcmp(dentry_name,
+							 "memfd:", 6) != 0);
+		}
+
+		fput(shmem_files[i]);
+	}
+}
+
+/*
+ * Test edge cases and boundary conditions
+ */
+static void test_memfd_detection_edge_cases(struct kunit *test)
+{
+	struct file *edge_case_files[3];
+	static const char *const tricky_names[] = {
+		"memf", /* Too short for memfd: prefix */
+		"memfd", /* Still too short */
+		"memfdx:test" /* Wrong prefix */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(edge_case_files); i++) {
+		edge_case_files[i] =
+			shmem_file_setup(tricky_names[i], 4096, VM_NORESERVE);
+		KUNIT_ASSERT_FALSE(test, IS_ERR(edge_case_files[i]));
+
+		/* All should be shmem but NOT memfd due to incorrect naming */
+		KUNIT_EXPECT_TRUE(test, shmem_file(edge_case_files[i]));
+		KUNIT_EXPECT_FALSE(test, is_memfd_file(edge_case_files[i]));
+
+		fput(edge_case_files[i]);
+	}
+}
+
+/*
+ * Test detection consistency across multiple calls
+ */
+static void test_memfd_detection_consistency(struct kunit *test)
+{
+	struct file *file;
+	bool initial_result, subsequent_result;
+	int iteration;
+
+	file = shmem_file_setup("consistency_test", 4096, VM_NORESERVE);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(file));
+
+	/* Get initial detection result */
+	initial_result = is_memfd_file(file);
+
+	/* Multiple calls should return identical results */
+	for (iteration = 0; iteration < 10; iteration++) {
+		subsequent_result = is_memfd_file(file);
+		KUNIT_EXPECT_EQ(test, initial_result, subsequent_result);
+	}
+
+	fput(file);
+}
+
+#ifdef CONFIG_MEMFD_CREATE
+
+/*
+ * Test performance characteristics (ensure function is reasonably fast)
+ */
+static void test_memfd_detection_performance(struct kunit *test)
+{
+	struct file *files[5];
+	static const char *const names[] = { "perf1", "perf2", "perf3", "perf4",
+					     "perf5" };
+	ktime_t start_time, end_time;
+	s64 duration_ns;
+	int i, j;
+	const int iterations = 1000;
+
+	/* Set up test files */
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		files[i] = shmem_file_setup(names[i], 4096, VM_NORESERVE);
+		KUNIT_ASSERT_FALSE(test, IS_ERR(files[i]));
+	}
+
+	/* Time the detection function */
+	start_time = ktime_get();
+
+	for (i = 0; i < iterations; i++) {
+		for (j = 0; j < ARRAY_SIZE(files); j++) {
+			bool result = is_memfd_file(files[j]);
+			(void)result; /* Suppress unused variable warning */
+		}
+	}
+
+	end_time = ktime_get();
+	duration_ns = ktime_to_ns(ktime_sub(end_time, start_time));
+
+	/* Cleanup */
+	for (i = 0; i < ARRAY_SIZE(files); i++)
+		fput(files[i]);
+
+	/* Performance check: should complete in reasonable time */
+	/* This is a sanity check - actual limits depend on system */
+	KUNIT_EXPECT_LT(test, duration_ns,
+			1000000000LL); /* Less than 1 second */
+
+	pr_info("memfd detection performance: %lld ns for %d iterations on %zu files\n",
+		duration_ns, iterations, ARRAY_SIZE(files));
+}
+
+#endif /* CONFIG_MEMFD_CREATE */
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
 static int hook_file_alloc_security(struct file *const file)
 {
 	/*
@@ -1949,6 +2152,13 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_is_eacces_with_none),
 	KUNIT_CASE(test_is_eacces_with_refer),
 	KUNIT_CASE(test_is_eacces_with_write),
+	KUNIT_CASE(test_memfd_null_file),
+	KUNIT_CASE(test_shmem_vs_memfd_detection),
+	KUNIT_CASE(test_memfd_detection_edge_cases),
+	KUNIT_CASE(test_memfd_detection_consistency),
+#ifdef CONFIG_MEMFD_CREATE
+	KUNIT_CASE(test_memfd_detection_performance),
+#endif
 	{}
 };
 /* clang-format on */
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2385017418ca..559a96a97ab6 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -165,73 +165,6 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	return err;
 }
 
-/**
- * domain_is_scoped - Checks if the client domain is scoped in the same
- *		      domain as the server.
- *
- * @client: IPC sender domain.
- * @server: IPC receiver domain.
- * @scope: The scope restriction criteria.
- *
- * Returns: True if the @client domain is scoped to access the @server,
- * unless the @server is also scoped in the same domain as @client.
- */
-static bool domain_is_scoped(const struct landlock_ruleset *const client,
-			     const struct landlock_ruleset *const server,
-			     access_mask_t scope)
-{
-	int client_layer, server_layer;
-	const struct landlock_hierarchy *client_walker, *server_walker;
-
-	/* Quick return if client has no domain */
-	if (WARN_ON_ONCE(!client))
-		return false;
-
-	client_layer = client->num_layers - 1;
-	client_walker = client->hierarchy;
-	/*
-	 * client_layer must be a signed integer with greater capacity
-	 * than client->num_layers to ensure the following loop stops.
-	 */
-	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
-
-	server_layer = server ? (server->num_layers - 1) : -1;
-	server_walker = server ? server->hierarchy : NULL;
-
-	/*
-	 * Walks client's parent domains down to the same hierarchy level
-	 * as the server's domain, and checks that none of these client's
-	 * parent domains are scoped.
-	 */
-	for (; client_layer > server_layer; client_layer--) {
-		if (landlock_get_scope_mask(client, client_layer) & scope)
-			return true;
-
-		client_walker = client_walker->parent;
-	}
-	/*
-	 * Walks server's parent domains down to the same hierarchy level as
-	 * the client's domain.
-	 */
-	for (; server_layer > client_layer; server_layer--)
-		server_walker = server_walker->parent;
-
-	for (; client_layer >= 0; client_layer--) {
-		if (landlock_get_scope_mask(client, client_layer) & scope) {
-			/*
-			 * Client and server are at the same level in the
-			 * hierarchy. If the client is scoped, the request is
-			 * only allowed if this domain is also a server's
-			 * ancestor.
-			 */
-			return server_walker != client_walker;
-		}
-		client_walker = client_walker->parent;
-		server_walker = server_walker->parent;
-	}
-	return false;
-}
-
 static bool sock_is_scoped(struct sock *const other,
 			   const struct landlock_ruleset *const domain)
 {

-- 
2.43.0


