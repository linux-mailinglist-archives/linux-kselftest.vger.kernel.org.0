Return-Path: <linux-kselftest+bounces-47661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B28DBCC7A4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 13:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1162E304EB64
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9694341678;
	Wed, 17 Dec 2025 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oqWW01Bs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5D33A024;
	Wed, 17 Dec 2025 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765974779; cv=none; b=ueYm8TgCvidM5ZIDzUeERt3o8aeDkzwW/pNa8vhB9vjxseJLLhxEYYKyCQmJD5T6eQjgP2BwWKaJ/rlkRBt/1FpmHefkptSY0beMttlfGH/w2FsUsyQtyd9ttlaWwEtLzDwFqNMIB5z9h/bVbdHAWe8GfOCAz3RkV85VmAv4L/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765974779; c=relaxed/simple;
	bh=F3aGY/l+aPlQDl6uuo1M6/psy7KF4msQt5nicN3re/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLMImDDiC+e8keC0J5s12SQXdDWpU77SSpCH6oAKHzD0T/b33aViJ8UPZ6IWyq60+Vv2IsWsxywG44XCXoA1s8ygr+L92zY+tOy98Rx/Ueh2IP8WWAbtSILkFi6VKcjJrbc4sF+ERXdnuuLiPqVUoDt0r2CAxPlStIP2bHE58SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oqWW01Bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9BCC4CEF5;
	Wed, 17 Dec 2025 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765974779;
	bh=F3aGY/l+aPlQDl6uuo1M6/psy7KF4msQt5nicN3re/M=;
	h=From:To:Cc:Subject:Date:From;
	b=oqWW01BstCNczuzqpK7H2q3z5aXxuFM2w8MsjCzmS4Nyr4sqkjGZwW5wgq70U5CO0
	 oytAzZExDRE++V/LJQNxO8y4WIH/aTquyWRQy7PrKkjS1ZaqYv4RlSwmfhAzRP8Jsb
	 wvuVM+1UwcqipJ+zM21THiel2TYYtoIzb5dc2COU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: brendan.higgins@linux.dev,
	davidgow@google.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH] kunit: fix up const mis-match in many assert functions
Date: Wed, 17 Dec 2025 13:32:47 +0100
Message-ID: <2025121746-result-staleness-5a68@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 75
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=F3aGY/l+aPlQDl6uuo1M6/psy7KF4msQt5nicN3re/M=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlOi96lar1f9m1X/QIrNuv0N+nJIn0394g7uJfs/trx7 eUR//KNHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRb7cZFszi3PPtnelaUY9J fVrNV/Zvfbs/15phnu7NgqDTYT06ZXFtTx46LbnOZ9ksAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In many kunit assert functions a const pointer is passed to
container_of() and out pops a non-const pointer, which really isn't the
correct thing to do at all.  Fix this up by correctly marking the
casted-to pointer as const to preserve the marking.

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/kunit/assert.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 867aa5c4bccf..4c751ad8506a 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -51,7 +51,7 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 			       const struct va_format *message,
 			       struct string_stream *stream)
 {
-	struct kunit_unary_assert *unary_assert;
+	const struct kunit_unary_assert *unary_assert;
 
 	unary_assert = container_of(assert, struct kunit_unary_assert, assert);
 
@@ -71,7 +71,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				     const struct va_format *message,
 				     struct string_stream *stream)
 {
-	struct kunit_ptr_not_err_assert *ptr_assert;
+	const struct kunit_ptr_not_err_assert *ptr_assert;
 
 	ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
 				  assert);
@@ -117,7 +117,7 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 				const struct va_format *message,
 				struct string_stream *stream)
 {
-	struct kunit_binary_assert *binary_assert;
+	const struct kunit_binary_assert *binary_assert;
 
 	binary_assert = container_of(assert, struct kunit_binary_assert,
 				     assert);
@@ -145,7 +145,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
 				    struct string_stream *stream)
 {
-	struct kunit_binary_ptr_assert *binary_assert;
+	const struct kunit_binary_ptr_assert *binary_assert;
 
 	binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
 				     assert);
@@ -185,7 +185,7 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
 				    struct string_stream *stream)
 {
-	struct kunit_binary_str_assert *binary_assert;
+	const struct kunit_binary_str_assert *binary_assert;
 
 	binary_assert = container_of(assert, struct kunit_binary_str_assert,
 				     assert);
@@ -237,7 +237,7 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
 			     const struct va_format *message,
 			     struct string_stream *stream)
 {
-	struct kunit_mem_assert *mem_assert;
+	const struct kunit_mem_assert *mem_assert;
 
 	mem_assert = container_of(assert, struct kunit_mem_assert,
 				  assert);
-- 
2.52.0


