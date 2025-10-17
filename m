Return-Path: <linux-kselftest+bounces-43438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8723BEB98F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAAE189F77B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F83370FC;
	Fri, 17 Oct 2025 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qo503kgB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE35336EE6
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732017; cv=none; b=aWbgOpVjDlRfY83OUqTsKh6mP1znpdfe5fHKnc9qZTHWqHdpvZLtq9cfKBBGQdyLitsiyV3xavuwGApHeJZkWhyFZFWx8u0f92BUkXIu62x2owtHOTM9g/T6077oIPg3hR2EsnNzLasTcQ05gKrKbUW/prG95WYQ8YCm0JHEX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732017; c=relaxed/simple;
	bh=6/2VXsM8HSIuSJFccqFrSd/ne7HNhu1uoyXDR2RlNPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+bPlQYhSguS3uPzKFPgSjpODXSm52jpgTdGR8EpKYDkEZRmtTPcxL0YmoLwTtF8akmTgkevy9RbuVwc4Flargwhqply4JWqC7hk3Qsxf0omvuxbevrabHBINN7SqgcDyjBhhGIWLwwA673OF5pqDvYEclgwEe46OUE9bgnVSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qo503kgB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso3871912a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732004; x=1761336804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRpCljJtVrls/6hWQfsPORVstHyDe7m4NRLHPP8M32I=;
        b=qo503kgBJm6sJfnXiFyCMOnM6xFtT8oEBiEKqifvioTuJmK4NHCufoWbO5/Cp3BI3P
         ONGQIaAz0avYT83L8A8lbzm54Ya+BLzSafJk9bJPk+kK018ddzUI/tCNz72idWeKsVHk
         wzmsxPv/RU5DSN9UJB9rC+OUg9YuzgDD6BvzBw2zfOCxJ0t1d/GOXynrqNU72fggGXmj
         b5bJRmlS4rfwVau07w8n4Pff2wimrQ0mjeaDej1gnV8GmxGmIMcFSWX3KiieZeWobKr5
         HEVPNUeukR20g2qbv87FdacMSD+NnRVy9sKxnoCYkn63pSLbAK7HCszBtKGiP4tSGOpu
         0Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732004; x=1761336804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRpCljJtVrls/6hWQfsPORVstHyDe7m4NRLHPP8M32I=;
        b=qm7tFMGmT+g6JEi+NJzjv1TzWz1Wo3NuASRi7Iv3mczbTTwd6iek6Tu7gOm07SyqSV
         P443Ph9krSIP7Glp+YcE+JOJH0auaFGKmw2VITCZ2Rc++QeNK8RiYEZvbGq+jsHoA/pk
         cUXfyVjzhQxnZzjLy8FzHTy0bmr7KN5TC2MI0zW12816fJP008Fr+cDRf35kO9CEsFJ7
         I4DYKQ0v0bTVpUnbfBR0rV2QUXjsu3frvXrkM8UQ4Ys5c/qHzAZJGmfMJVXRhnLR22Ba
         mXeBNXJtigAFzmNGyo96BOi7+wa6qid8DTv5MJspDeunk6yKUf9umbGFUeJmLAKos4h+
         UxTw==
X-Forwarded-Encrypted: i=1; AJvYcCXgLzdghJaBbCzSXkY3gCHt/VbdXIlkismE444nu1jas05xtZDxNe13AqGVKsJ5uzp3IYUHv/WLeKMqmJnyGdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkm9lznGL5edfOFkzoQpYBgTosnmsrvfEZGfWkJBd17ycZuSzG
	LfxoapWYzVBTehQA4okJFzxrnUwt8pH6kBnNErPVI4x+V2D1GqwvI7uazcXW1wio9+UB5cDtVgo
	MsP6NF/EHwJYdvixLvvnlL2niWA==
X-Google-Smtp-Source: AGHT+IFGdBmr577G2D3wCPa71CmRW8ibsEq1jMkd//hmxTuN/1icQQzMZDjhyZdDN1r6wBAmdBu0Iyftggdo2S8VYQ==
X-Received: from pjsc19.prod.google.com ([2002:a17:90a:bf13:b0:33b:ab21:aff7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2781:b0:335:2a21:69db with SMTP id 98e67ed59e1d1-33bcf88837fmr6418681a91.10.1760732003972;
 Fri, 17 Oct 2025 13:13:23 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:14 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <5f66d5b024efcc1028bc6ba4c15fc2eb73593d0e.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 33/37] KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

The TEST_EXPECT_SIGBUS macro is not thread-safe as it uses a global
sigjmp_buf and installs a global SIGBUS signal handler. If multiple threads
execute the macro concurrently, they will race on installing the signal
handler and stomp on other threads' jump buffers, leading to incorrect test
behavior.

Make TEST_EXPECT_SIGBUS thread-safe with the following changes:

Share the KVM tests' global signal handler. sigaction() applies to all
threads; without sharing a global signal handler, one thread may have
removed the signal handler that another thread added, hence leading to
unexpected signals.

The alternative of layering signal handlers was considered, but calling
sigaction() within TEST_EXPECT_SIGBUS() necessarily creates a race. To
avoid adding new setup and teardown routines to do sigaction() and keep
usage of TEST_EXPECT_SIGBUS() simple, share the KVM tests' global signal
handler.

Opportunistically rename report_unexpected_signal to
catchall_signal_handler.

To continue to only expect SIGBUS within specific regions of code, use a
thread-specific variable, expecting_sigbus, to replace installing and
removing signal handlers.

Make the execution environment for the thread, sigjmp_buf, a
thread-specific variable.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/include/test_util.h | 27 +++++++++----------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 18 +++++++++----
 tools/testing/selftests/kvm/lib/test_util.c   |  7 -----
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 2871a42928471..0e4e6f7dab8fb 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -80,22 +80,19 @@ do {									\
 	__builtin_unreachable(); \
 } while (0)
 
-extern sigjmp_buf expect_sigbus_jmpbuf;
-void expect_sigbus_handler(int signum);
+extern __thread sigjmp_buf expect_sigbus_jmpbuf;
+extern __thread bool expecting_sigbus;
 
-#define TEST_EXPECT_SIGBUS(action)						\
-do {										\
-	struct sigaction sa_old, sa_new = {					\
-		.sa_handler = expect_sigbus_handler,				\
-	};									\
-										\
-	sigaction(SIGBUS, &sa_new, &sa_old);					\
-	if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {				\
-		action;								\
-		TEST_FAIL("'%s' should have triggered SIGBUS", #action);	\
-	}									\
-	sigaction(SIGBUS, &sa_old, NULL);					\
-} while (0)
+#define TEST_EXPECT_SIGBUS(action)                                     \
+	do {                                                           \
+		expecting_sigbus = true;			       \
+		if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {         \
+			action;                                        \
+			TEST_FAIL("'%s' should have triggered SIGBUS", \
+				  #action);                            \
+		}                                                      \
+		expecting_sigbus = false;			       \
+	} while (0)
 
 size_t parse_size(const char *size);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 8603bd5c705ed..41169e8cbf8af 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2302,13 +2302,20 @@ __weak void kvm_selftest_arch_init(void)
 {
 }
 
-static void report_unexpected_signal(int signum)
+__thread sigjmp_buf expect_sigbus_jmpbuf;
+__thread bool expecting_sigbus;
+
+static void catchall_signal_handler(int signum)
 {
+	switch (signum) {
+	case SIGBUS: {
+		if (expecting_sigbus)
+			siglongjmp(expect_sigbus_jmpbuf, 1);
+
+		TEST_FAIL("Unexpected SIGBUS (%d)\n", signum);
+	}
 #define KVM_CASE_SIGNUM(sig)					\
 	case sig: TEST_FAIL("Unexpected " #sig " (%d)\n", signum)
-
-	switch (signum) {
-	KVM_CASE_SIGNUM(SIGBUS);
 	KVM_CASE_SIGNUM(SIGSEGV);
 	KVM_CASE_SIGNUM(SIGILL);
 	KVM_CASE_SIGNUM(SIGFPE);
@@ -2320,12 +2327,13 @@ static void report_unexpected_signal(int signum)
 void __attribute((constructor)) kvm_selftest_init(void)
 {
 	struct sigaction sig_sa = {
-		.sa_handler = report_unexpected_signal,
+		.sa_handler = catchall_signal_handler,
 	};
 
 	/* Tell stdout not to buffer its content. */
 	setbuf(stdout, NULL);
 
+	expecting_sigbus = false;
 	sigaction(SIGBUS, &sig_sa, NULL);
 	sigaction(SIGSEGV, &sig_sa, NULL);
 	sigaction(SIGILL, &sig_sa, NULL);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8a1848586a857..03eb99af9b8de 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -18,13 +18,6 @@
 
 #include "test_util.h"
 
-sigjmp_buf expect_sigbus_jmpbuf;
-
-void __attribute__((used)) expect_sigbus_handler(int signum)
-{
-	siglongjmp(expect_sigbus_jmpbuf, 1);
-}
-
 /*
  * Random number generator that is usable from guest code. This is the
  * Park-Miller LCG using standard constants.
-- 
2.51.0.858.gf9c4a03a3a-goog


