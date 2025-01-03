Return-Path: <linux-kselftest+bounces-23838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C810A001CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 00:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9707A1A37
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7F1BEF9E;
	Thu,  2 Jan 2025 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpiA8Osc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB81BEF94
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Jan 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860789; cv=none; b=G3KkCBf0zJXJYYZmMht6TXMWjfvQJILYWz0BVFoQY1ResXoc54Z/6Xa8remKihvjYcX00BgudNrKdtVlTWcvlpHwSOkfaYwjypzBsqE2GTUvsmvbL5WjOtZoth+uBtzHVo0CgRwEkDArkaAJRW/mUoyUWwzc+3xfFqMSwPG5fbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860789; c=relaxed/simple;
	bh=4DBEFnoWxm6wOsHhIgJEisd7g7YgHjqynQfwaJjdS5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZZRyMVrpdPzIK1CzHvNm5ZG4GH8d5RNRHRR9+ELcQFUZejutqaWqDZkTjm5sjSTSFtbDJQ/5VpcyW5MpNJHhvd2022Zs2GdPnEvB8pb55jyPwOBqZty5LxDlDf8rCxiFzfMZ0qTsxJDI9QObo33VpAHew8bI6gX1lyO+j4ojHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpiA8Osc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9b9981f1so26022823a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jan 2025 15:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735860787; x=1736465587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DO6BLM5CMOo/wBOU4R18TkGC6gkh5CUUEjeVIIwslA=;
        b=jpiA8Osco+BhjV6lgxDW7yMmP5qo7rbNCYJnqb/hNYh/t0z+x9mnq/FyznpgZCrFrk
         Lj6s8Fq8bBDEq4GALY+mUYC7WviJol2+E7lvgrFctJlmE5Z6h3asNkdBVwHlMT3STLEy
         0Uq2et+PmM8cql1NQz5Oq+Om7QgDwRUsqAOJi5qkjsu0sNVJOgjzCaWtHIfjTMsCuKjn
         PwPFik3blaioSXouHSCuUmmGxVH1yE7/Pat2SQLwHDS/Vjgl3a2HOyPqVqNkwS7J2vRj
         OpmyVT8mlmLDsM2i1KcxhD+ZRiyICQt4JTscvA+mCfWdQlQ8z7FLWByu6jBNWn9Op1kw
         emWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735860787; x=1736465587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DO6BLM5CMOo/wBOU4R18TkGC6gkh5CUUEjeVIIwslA=;
        b=IGhKymYmypTVLAVXWickKaPMIBw4xMvO+qjki8lEHwVQ0ZwulwZfD1FrJqQ8KCeIb0
         dgewaaeZg6tWq+lkBZpJpMj+kka8QJcxHFrgIU4lEmMFIlMVjqk+u+IhknQY5X/fvtZx
         uu8iCLPJYA9JfXObc/ZKZX1rF8J3Iq50TaBYCAej6WTBoTkIo/93miqTbIWBc4zGXAVT
         0NoNk7FhMVn87v6dz7SwFztGAfdggOU5AiRJeUeJLWKFIs4XaaH9clmkboGITigqAPGc
         oH96ha4gzNf+Dabco54PUXopygcHoQl5r3KfPxUc5g0zT9Z+NvRhqrxP3PPoCBh0961C
         6mow==
X-Forwarded-Encrypted: i=1; AJvYcCXbuammQMPUusd4RQucGn6Yr8wJq7eqDfiIwEQm0l4wNcQsLNqQzagSxSbe235UcolAhkJSUvHeoFEhKne/AEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+/53svQICAwIRih26VOqcMtf3Xy00LlRB34t3P8fgpmtZRbV
	/ZlirmDCKC3P3zvlS1C4Vj78FNTpNCiWIoUK8vi8vzHZ3txMPMHGYQZjdIRwj3JccK/e4DAakmX
	guRxaW2YeyAcQORC++hs9p+WekZNyxfafHg==
X-Google-Smtp-Source: AGHT+IGn4ET5k3Rw4jazgCpM0o7s4VxY7D3G9HLPKKDi9G1NhugDfSye1BKW8ZRtwa2K9tuUnnUmyyKAttJLjZ0jGRqBSQ==
X-Received: from pfd7.prod.google.com ([2002:a05:6a00:a807:b0:727:2d74:d385])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2d05:b0:1e1:a647:8a54 with SMTP id adf61e73a8af0-1e5e05ac4cbmr72878987637.20.1735860787347;
 Thu, 02 Jan 2025 15:33:07 -0800 (PST)
Date: Thu,  2 Jan 2025 15:32:51 -0800
In-Reply-To: <20250102233255.1180524-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250102233255.1180524-3-isaacmanjarres@google.com>
Subject: [RFC PATCH RESEND v2 2/2] selftests/memfd: Add tests for F_SEAL_FUTURE_EXEC
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: surenb@google.com, kaleshsingh@google.com, jstultz@google.com, 
	aliceryhl@google.com, jeffxu@google.com, kees@kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add tests to ensure that F_SEAL_FUTURE_EXEC behaves as expected.

Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index c0c53451a16d..abc213a5ce99 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -31,6 +31,7 @@
 #define STACK_SIZE 65536
 
 #define F_SEAL_EXEC	0x0020
+#define F_SEAL_FUTURE_EXEC	0x0040
 
 #define F_WX_SEALS (F_SEAL_SHRINK | \
 		    F_SEAL_GROW | \
@@ -318,6 +319,37 @@ static void *mfd_assert_mmap_private(int fd)
 	return p;
 }
 
+static void *mfd_fail_mmap_exec(int fd)
+{
+	void *p;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_EXEC,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p != MAP_FAILED) {
+		printf("mmap() didn't fail as expected\n");
+		abort();
+	}
+
+	return p;
+}
+
+static void mfd_fail_mprotect_exec(void *p)
+{
+	int ret;
+
+	ret = mprotect(p,
+		       mfd_def_size,
+		       PROT_EXEC);
+	if (!ret) {
+		printf("mprotect didn't fail as expected\n");
+		abort();
+	}
+}
+
 static int mfd_assert_open(int fd, int flags, mode_t mode)
 {
 	char buf[512];
@@ -998,6 +1030,52 @@ static void test_seal_future_write(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_FUTURE_EXEC_MAPPING
+ * Test whether SEAL_FUTURE_EXEC_MAPPING actually prevents executable mappings.
+ */
+static void test_seal_future_exec_mapping(void)
+{
+	int fd;
+	void *p;
+
+
+	printf("%s SEAL-FUTURE-EXEC-MAPPING\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_future_exec_mapping",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	/*
+	 * PROT_READ | PROT_WRITE mappings create VMAs with VM_MAYEXEC set.
+	 * However, F_SEAL_FUTURE_EXEC applies to subsequent mappings,
+	 * so it should still succeed even if this mapping is active when the
+	 * seal is applied.
+	 */
+	p = mfd_assert_mmap_shared(fd);
+
+	mfd_assert_has_seals(fd, 0);
+
+	mfd_assert_add_seals(fd, F_SEAL_FUTURE_EXEC);
+	mfd_assert_has_seals(fd, F_SEAL_FUTURE_EXEC);
+
+	mfd_fail_mmap_exec(fd);
+
+	munmap(p, mfd_def_size);
+
+	/* Ensure that new mappings without PROT_EXEC work. */
+	p = mfd_assert_mmap_shared(fd);
+
+	/*
+	 * Ensure that mappings created after the seal was applied cannot be
+	 * made executable via mprotect().
+	 */
+	mfd_fail_mprotect_exec(p);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+}
+
 static void test_seal_write_map_read_shared(void)
 {
 	int fd;
@@ -1639,6 +1717,7 @@ int main(int argc, char **argv)
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
+	test_seal_future_exec_mapping();
 
 	if (pid_ns_supported()) {
 		test_sysctl_simple();
-- 
2.47.1.613.gc27f4b7a9f-goog


