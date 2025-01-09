Return-Path: <linux-kselftest+bounces-24141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E88A07EEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824203A5F9F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F3D199EBB;
	Thu,  9 Jan 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="RxGbR76O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61743191F83;
	Thu,  9 Jan 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444363; cv=pass; b=YUMpIHnnMqxDroky/iwz55MMX0nOetqm4CmtOypeiejVPY73TcWOmu8Pz1xrX4fSM9+ajds22inSzlGDn6uBM1EtBmIBBprOwygv65/D1ngE7daIWGU1DlxfjGJVXpNzBoJItMVfksZLPajnV5NjYUz2oAbpWzxSlWfhyltm1YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444363; c=relaxed/simple;
	bh=IypNeO5jz4FyVUQhVIzrEuryUjrGTW9c8zTbvlxDswo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u/EfO5uSSG2uSwRb98K078KW7/3OD01JNVIvE9yF2bUa9DcxWxmryXZFaXpf0ZkWJJNb/T6TcD2h8gSYN+0xXXMgSpDlHNpWxmSltT5Xp4AYDcW5PgAqxaFIH412NSIJtrV+tuZVHXtezucG1XMdUrUFuYwIpKpJ0fwyIpHyA9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=RxGbR76O; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444343; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YklJUeOzj8JLFJvKWPF881sglOIFJXR/Q94B968H/0eeoGYOud4eIIN43wmKOd9xvXbOYLxDSsf1kDv0Od7q6rida9iSBfoi5pg9j8p7qYmJIED4xDz9D6PhWP62wenRv+iKnv6/W7eN+uS/AG8E6Qj/FQ18GaVR0sEel6TvYPY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444343; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wQRYp4NaHn6qZOxrq/QHoWxtMXxEn9kcEYhJcS6nYa8=; 
	b=lfOS/OsurKC7ZWxEKVxVBdOLaFCA/fAFKIC/MgdmBrsmd9CSD9axohcszYu2ZLCYNZrdT55CkuYrtMzZNa9bXhZ/aSPfaC+yOCxZOPn7MyZzkTx1mzXJapx48JiscJgGxhp6p/VD39HRthQAkx0SiH/SHe0bE+ErD1xDWP2H5yk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444343;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=wQRYp4NaHn6qZOxrq/QHoWxtMXxEn9kcEYhJcS6nYa8=;
	b=RxGbR76OTIUSMV5K6a1KOXlhEkaEYHu+EO7eJCjD4eZaFD+kti0SnJ9nfBh/X/fO
	vgyqep6C/rnHMyohN+Byz2GqbckBRV6dsgG3Cqxk3AzTxECG847KiAswzj+nfUCuR4/
	HGeeGDzUTX4gMEQk5D5hHzETlANo1wrKfD5PytQQ=
Received: by mx.zohomail.com with SMTPS id 1736444341790884.6842476868715;
	Thu, 9 Jan 2025 09:39:01 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 03/16] selftests/mm: Fix unused parameter warnings
Date: Thu,  9 Jan 2025 22:38:29 +0500
Message-Id: <20250109173842.1142376-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix unused parameter warnings.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/pkey-x86.h          |  4 +++-
 .../selftests/mm/pkey_sighandler_tests.c       | 17 +++++++++++------
 tools/testing/selftests/mm/protection_keys.c   | 18 ++++++++++--------
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index f7ecd335df1e6..75cef8ee00702 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -157,7 +157,9 @@ static inline void expect_fault_on_read_execonly_key(void *p1, int pkey)
 	expected_pkey_fault(pkey);
 }
 
-static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+static inline void *malloc_pkey_with_mprotect_subpage(long __attribute__((unused)) size,
+						      int __attribute__((unused)) prot,
+						      u16 __attribute__((unused)) pkey)
 {
 	return PTR_ERR_ENOTSUP;
 }
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index 249989f8b7a2a..cd46528d6c215 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -42,7 +42,8 @@ static siginfo_t siginfo = {0};
  * which is protected by MPK 0 which we don't have access to.
  */
 static inline __always_inline
-long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
+long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5,
+		 long __attribute__((unused)) a6)
 {
 	unsigned long ret;
 #ifdef __x86_64__
@@ -110,7 +111,8 @@ static inline u64 pkey_reg_restrictive_default(void)
 	return set_pkey_bits(PKEY_REG_ALLOW_NONE, 0, PKEY_DISABLE_ACCESS);
 }
 
-static void sigsegv_handler(int signo, siginfo_t *info, void *ucontext)
+static void sigsegv_handler(int __attribute__((unused)) signo, siginfo_t *info,
+			    void __attribute__((unused)) *ucontext)
 {
 	pthread_mutex_lock(&mutex);
 
@@ -122,7 +124,8 @@ static void sigsegv_handler(int signo, siginfo_t *info, void *ucontext)
 	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
 }
 
-static void sigusr1_handler(int signo, siginfo_t *info, void *ucontext)
+static void sigusr1_handler(int __attribute__((unused)) signo, siginfo_t *info,
+			    void __attribute__((unused)) *ucontext)
 {
 	pthread_mutex_lock(&mutex);
 
@@ -132,7 +135,9 @@ static void sigusr1_handler(int signo, siginfo_t *info, void *ucontext)
 	pthread_mutex_unlock(&mutex);
 }
 
-static void sigusr2_handler(int signo, siginfo_t *info, void *ucontext)
+static void sigusr2_handler(int __attribute__((unused)) signo,
+			    siginfo_t __attribute__((unused)) *info,
+			    void __attribute__((unused)) *ucontext)
 {
 	/*
 	 * pkru should be the init_pkru value which enabled MPK 0 so
@@ -155,7 +160,7 @@ static void raise_sigusr2(void)
 	 */
 }
 
-static void *thread_segv_with_pkey0_disabled(void *ptr)
+static void *thread_segv_with_pkey0_disabled(void __attribute__((unused)) *ptr)
 {
 	/* Disable MPK 0 (and all others too) */
 	__write_pkey_reg(pkey_reg_restrictive_default());
@@ -165,7 +170,7 @@ static void *thread_segv_with_pkey0_disabled(void *ptr)
 	return NULL;
 }
 
-static void *thread_segv_pkuerr_stack(void *ptr)
+static void *thread_segv_pkuerr_stack(void __attribute__((unused)) *ptr)
 {
 	/* Disable MPK 0 (and all others too) */
 	__write_pkey_reg(pkey_reg_restrictive_default());
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index a4683f2476f27..3a66798a8e8d6 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -309,7 +309,7 @@ static char *si_code_str(int si_code)
 
 static int pkey_faults;
 static int last_si_pkey = -1;
-static void signal_handler(int signum, siginfo_t *si, void *vucontext)
+static void signal_handler(int __attribute__((unused)) signum, siginfo_t *si, void *vucontext)
 {
 	ucontext_t *uctxt = vucontext;
 	int trapno;
@@ -891,7 +891,7 @@ static void close_test_fds(void)
 	nr_test_fds = 0;
 }
 
-static void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
+static void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 __attribute__((unused)) pkey)
 {
 	int i, err;
 	int max_nr_pkey_allocs;
@@ -1108,7 +1108,7 @@ static void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-static void test_pkey_syscalls_bad_args(int *ptr, u16 pkey)
+static void test_pkey_syscalls_bad_args(int *ptr, u16 __attribute__((unused)) pkey)
 {
 	int err;
 	int bad_pkey = NR_PKEYS+99;
@@ -1134,7 +1134,7 @@ static void become_child(void)
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-static void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
+static void test_pkey_alloc_exhaust(int __attribute__((unused)) *ptr, u16 __attribute__((unused)) pkey)
 {
 	int err;
 	int allocated_pkeys[NR_PKEYS] = {0};
@@ -1240,7 +1240,7 @@ static void arch_force_pkey_reg_init(void)
  * a long-running test that continually checks the pkey
  * register.
  */
-static void test_pkey_init_state(int *ptr, u16 pkey)
+static void test_pkey_init_state(int __attribute__((unused)) *ptr, u16 __attribute__((unused)) pkey)
 {
 	int err;
 	int allocated_pkeys[NR_PKEYS] = {0};
@@ -1399,7 +1399,7 @@ static void *get_pointer_to_instructions(void)
 	return p1;
 }
 
-static void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
+static void test_executing_on_unreadable_memory(int __attribute__((unused)) *ptr, u16 pkey)
 {
 	void *p1;
 	int scratch;
@@ -1431,7 +1431,8 @@ static void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	pkey_assert(!ret);
 }
 
-static void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
+static void test_implicit_mprotect_exec_only_memory(int __attribute__((unused)) *ptr,
+						    u16 __attribute__((unused)) pkey)
 {
 	void *p1;
 	int scratch;
@@ -1480,7 +1481,8 @@ static void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 }
 
 #if defined(__i386__) || defined(__x86_64__)
-static void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
+static void test_ptrace_modifies_pkru(int __attribute__((unused)) *ptr,
+				      u16 __attribute__((unused)) pkey)
 {
 	u32 new_pkru;
 	pid_t child;
-- 
2.39.5


