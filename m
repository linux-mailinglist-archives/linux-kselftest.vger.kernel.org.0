Return-Path: <linux-kselftest+bounces-25853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F22A293E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25D1189263E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF70155A30;
	Wed,  5 Feb 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wL8YHWfN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD11519BF;
	Wed,  5 Feb 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768050; cv=none; b=JKb8LApsd2f9LGHQiVHJtu1WN2uneGh+dVuIxDPPW70bzKJIE/d7fP2JbYY5Vr27B1Js15sCngvA2M6xwQN5mEQGZpde/TPNvPH2JnO72b16HBGyx/v6F0BSsT+VjGGWG/C5+hSzy1N7h5n5ijb4eGGDJ/fKqE1Ns8LbxluJfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768050; c=relaxed/simple;
	bh=SKYl9ovbwvQOQg7dSysQRrAU4fkMD45oHcfHrlnMGQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csgBQRkj/rhwq0YJrSjpeGxDdf4k0Gmls6zkBfE+8x3WLk4oFmHwPovxuB2i/KATCykXw8F4rZjQcCrIhtlA5UoZ6G2fCB4c2YpBoOSgx8DVLdjMQsDUvniTK5KbZL0Bn9K4UZEpXUu9EyqaIa+4UDdNPyCTnu5pynecCr+sCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wL8YHWfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95369C4CED1;
	Wed,  5 Feb 2025 15:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738768050;
	bh=SKYl9ovbwvQOQg7dSysQRrAU4fkMD45oHcfHrlnMGQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wL8YHWfNJ2pfqHfBZkk7SKd0uysVK+zbY1UGCUqgLD5nJzsr7yn3NHC+nS7OrSGnk
	 GJlmg9u6w4LcDm8bmBHzo+3KXX2Lmu4EXYtCjsLjewBgI9Pd12OC7pdzDptU1mRzDl
	 x0eSsEYUOUsZ/5zIpEwBSO2BWRG2J85JWU68LgxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raghavendra Rao Ananta <rananta@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Carlos ODonell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 6.12 546/590] selftests/rseq: Fix handling of glibc without rseq support
Date: Wed,  5 Feb 2025 14:45:01 +0100
Message-ID: <20250205134516.160256480@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 336d02bc4c6bec5c3d933e5d470a94970f830957 upstream.

When porting librseq commit:

commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")

from librseq to the kernel selftests, the following line was missed
at the end of rseq_init():

  rseq_size = get_rseq_kernel_feature_size();

which effectively leaves rseq_size initialized to -1U when glibc does not
have rseq support. glibc supports rseq from version 2.35 onwards.

In a following librseq commit

commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")

to mimic the libc behavior, a new approach is taken: don't set the
feature size in 'rseq_size' until at least one thread has successfully
registered. This allows using 'rseq_size' in fast-paths to test for both
registration status and available features. The caveat is that on libc
either all threads are registered or none are, while with bare librseq
it is the responsability of the user to register all threads using rseq.

This combines the changes from the following librseq git commits:

commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")

Fixes: a0cc649353bb ("selftests/rseq: Fix mm_cid test failure")
Reported-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rseq/rseq.c |   32 +++++++++++++++++++++++++-------
 tools/testing/selftests/rseq/rseq.h |    9 ++++++++-
 2 files changed, 33 insertions(+), 8 deletions(-)

--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -61,7 +61,6 @@ unsigned int rseq_size = -1U;
 unsigned int rseq_flags;
 
 static int rseq_ownership;
-static int rseq_reg_success;	/* At least one rseq registration has succeded. */
 
 /* Allocate a large area for the TLS. */
 #define RSEQ_THREAD_AREA_ALLOC_SIZE	1024
@@ -152,14 +151,27 @@ int rseq_register_current_thread(void)
 	}
 	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
 	if (rc) {
-		if (RSEQ_READ_ONCE(rseq_reg_success)) {
+		/*
+		 * After at least one thread has registered successfully
+		 * (rseq_size > 0), the registration of other threads should
+		 * never fail.
+		 */
+		if (RSEQ_READ_ONCE(rseq_size) > 0) {
 			/* Incoherent success/failure within process. */
 			abort();
 		}
 		return -1;
 	}
 	assert(rseq_current_cpu_raw() >= 0);
-	RSEQ_WRITE_ONCE(rseq_reg_success, 1);
+
+	/*
+	 * The first thread to register sets the rseq_size to mimic the libc
+	 * behavior.
+	 */
+	if (RSEQ_READ_ONCE(rseq_size) == 0) {
+		RSEQ_WRITE_ONCE(rseq_size, get_rseq_kernel_feature_size());
+	}
+
 	return 0;
 }
 
@@ -235,12 +247,18 @@ void rseq_init(void)
 		return;
 	}
 	rseq_ownership = 1;
-	if (!rseq_available()) {
-		rseq_size = 0;
-		return;
-	}
+
+	/* Calculate the offset of the rseq area from the thread pointer. */
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
+
+	/* rseq flags are deprecated, always set to 0. */
 	rseq_flags = 0;
+
+	/*
+	 * Set the size to 0 until at least one thread registers to mimic the
+	 * libc behavior.
+	 */
+	rseq_size = 0;
 }
 
 static __attribute__((destructor))
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -60,7 +60,14 @@
 extern ptrdiff_t rseq_offset;
 
 /*
- * Size of the registered rseq area. 0 if the registration was
+ * The rseq ABI is composed of extensible feature fields. The extensions
+ * are done by appending additional fields at the end of the structure.
+ * The rseq_size defines the size of the active feature set which can be
+ * used by the application for the current rseq registration. Features
+ * starting at offset >= rseq_size are inactive and should not be used.
+ *
+ * The rseq_size is the intersection between the available allocation
+ * size for the rseq area and the feature size supported by the kernel.
  * unsuccessful.
  */
 extern unsigned int rseq_size;



