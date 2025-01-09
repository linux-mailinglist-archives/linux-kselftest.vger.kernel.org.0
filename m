Return-Path: <linux-kselftest+bounces-24143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649A0A07EF5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272AB3A7DA7
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088091A238E;
	Thu,  9 Jan 2025 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="IoEfXM2z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57507190662;
	Thu,  9 Jan 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444370; cv=pass; b=sh0LKeAWap79tV9e7QPR1FkzEPhUvQRdT3/AY+IBHHNLdrWdf4hT2eE+nljwrvC01JVmTXNSQ5SilNcOmlonqK4xQB1jLzL+MikzJIw10NQnEn7WZ1VCfYZcREiuPPXDMRtbJrBbfzrSGWTlur10eEVvdbdsE23LWmSfAF1JYJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444370; c=relaxed/simple;
	bh=I/HPO0FETKLELTJ02oEm2rWJlXiUjzXWKzfoKZWpxg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNJ6tsA4kb6al7JoAet/yCAf11wMgUkGnZ4eOcQue3j+HBfBtkCh2JRqRDvL5W+B/gxbVRPq53Z6xjNSQu5DYFdiXwwlHWU97yVM3nk+pG+5+G2o7F/2Bh2Wae0Bo+3bLCLehE4h+A1QFwLmuXezIAZshxaXELGQ2r7imstUeUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=IoEfXM2z; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444353; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L3XyLRs0/trsxb9q5kJQLxsWkrZgP4LKcSTY9MpD+TWdxL3bVef3hn1GeNer/FNAPcWug+2y9E2FUbiyd7XM2yaey7hVrg4VuiHM2xcfr1iPO2Bgdbu32D5rAdbbFupngXZt2REyMRDKk8XaxBIDonxRNahZSIMY3EFWU4mfDeQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444353; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1BDwyNsRViNjuXlosD/y7qBAy6y9oVjeJbNXHd6mzLM=; 
	b=Ej8pZXtD0YiNC16sxLhqORerDh5GbRffB/N2oicvJ7Sa5HaRRrRfdSHDmjl4SpvxZ+6qpIOhO/f/uKSyDlEjp0I4jYyt/2bYANYp3bINuiMgJmFqnmRTp5VO2zxS90JB9uO/5C38EosKaWTAeLv2Lp5pzKGeKfWkg7ngEjy6gzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444353;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=1BDwyNsRViNjuXlosD/y7qBAy6y9oVjeJbNXHd6mzLM=;
	b=IoEfXM2z6Y0Gt5j9jm1HV1EL/AHRZJTGgqvgphvkAE2zkV/mWHBZP/KiSGM4qyrg
	dxIo9nl7hsc+vRkFFA1R+eo1y0jn5uqf80ncEIaqmVMbWMd3BP2MbGT9MTzg5V2+/mO
	uGLS8n4/Nt3yXvwUPX2SZvJdHjqcUrNQDuvKBtts=
Received: by mx.zohomail.com with SMTPS id 1736444351927807.2354560001573;
	Thu, 9 Jan 2025 09:39:11 -0800 (PST)
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
Subject: [PATCH 05/16] selftests/mm: kselftest_harness: Fix warnings
Date: Thu,  9 Jan 2025 22:38:31 +0500
Message-Id: <20250109173842.1142376-6-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Found warnings through hmm-tests and mdwe_test.

Fix following warnings:
- Mark unused variable with unused attribute
- __EXPECT is causing types mismatch warnings when __exp is unsigned and
  _seen is equal to a constant number, __typeof__(_seen) returns signed
  type.

  hmm-tests.c: In function ‘hmm_anon_read’:
  ../kselftest_harness.h:523:52: warning: comparison of integer expressions of different signedness: ‘long unsigned int’ and ‘int’ [-Wsign-compare]
    523 |         __EXPECT(expected, #expected, seen, #seen, !=, 1)
        |                                                    ^~
  ../kselftest_harness.h:759:21: note: in definition of macro ‘__EXPECT’
    759 |         if (!(__exp _t __seen)) { \
        |                     ^~
  hmm-tests.c:303:9: note: in expansion of macro ‘ASSERT_NE’
    303 |         ASSERT_NE(npages, 0);
        |         ^~~~~~~~~
- Mark variant as unused:
mdwe_test.c: In function ‘wrapper_prctl_flags’:
../kselftest_harness.h:177:52: warning: unused parameter ‘variant’ [-Wunused-parameter]
  177 |                 struct __fixture_variant_metadata *variant) \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
../kselftest_harness.h:152:25: note: in expansion of macro ‘__TEST_IMPL’
  152 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
      |                         ^~~~~~~~~~~
mdwe_test.c:23:1: note: in expansion of macro ‘TEST’
   23 | TEST(prctl_flags)
      | ^~~~

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kselftest_harness.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 666c9fde76da9..76e6b3be0e9d6 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -174,7 +174,7 @@
 	static void test_name(struct __test_metadata *_metadata); \
 	static inline void wrapper_##test_name( \
 		struct __test_metadata *_metadata, \
-		struct __fixture_variant_metadata *variant) \
+		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
 		_metadata->setup_completed = true; \
 		if (setjmp(_metadata->env) == 0) \
@@ -756,7 +756,7 @@
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
 	__typeof__(_seen) __seen = (_seen); \
-	if (!(__exp _t __seen)) { \
+	if (!(__exp _t (__typeof__(_expected)) __seen)) { \
 		/* Report with actual signedness to avoid weird output. */ \
 		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
 		case 0: { \
@@ -965,7 +965,7 @@ static inline void __test_check_assert(struct __test_metadata *t)
 }
 
 struct __test_metadata *__active_test;
-static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
+static void __timeout_handler(int sig, siginfo_t *info, void __attribute__((unused)) *ucontext)
 {
 	struct __test_metadata *t = __active_test;
 
-- 
2.39.5


