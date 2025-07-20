Return-Path: <linux-kselftest+bounces-37705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97206B0B737
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E991763D8
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413723B636;
	Sun, 20 Jul 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5aCdeWp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76C23B625;
	Sun, 20 Jul 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031836; cv=none; b=e+R6pGFHrHW2Rhv+W6O8X2cXWHfVNjb3nJR9NsO7fVhsEvaoBuI74ai9JIa9rBRGHkWzf1zcPLnexnlL4GW4nmpAUy2NnG2wdIAKc8lRhM23IOYb5ki+4Imw6bl9RykyOez5YU638PTLZHkyEE/QJVtCnRkzXZPpTwmmak3RWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031836; c=relaxed/simple;
	bh=U0CEnqMMj5kXnKHmB7UhROQ2roqc2bfcpe4lzup4E34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PuHtwUNG52JOPIdfNjV2/oAO3FWhiAflaiWcOefvTR9peeL5bOwl1dHtprYRLbCRFNUvz9cf7GGa2kjI8IAoW2uIC/7Ab6X8NxM/LOIEUp4kLGVKx2sqG7+XQbbqQIekfXgG/h+UGsX/TPeR4TIRE2ryTy4d85Vuz9JykU9Ner8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5aCdeWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9E0C4CEE7;
	Sun, 20 Jul 2025 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031836;
	bh=U0CEnqMMj5kXnKHmB7UhROQ2roqc2bfcpe4lzup4E34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5aCdeWpswsvzmd4L631j0YCcNw6l0h8LIex3LUKLpOPD5QyMZo5nz4lvqQy54y0S
	 wsJQubeYVe2u6tgsLyA7HIn+Uub2+rJjdruSu5iNuuMmyKK/bo5RYlAuhJdJs658PU
	 l20rNNjvydC2mPa3Lfecu7lYOvLVoGg5oKxBKBfe9bTj8aLg9P6FX7QMKBK7fuC+gn
	 hPMTGEC1A57dgv83EFl7SAnmjkd+Z7ZFXUCKenMfjpJL9nzRCeIDUj/HJUa9Rcn3Ax
	 iP70ImUwsqcymJ8iLTdCtL57CtImRWVpdQu+jeCj1CWkm2XGfpCQGesVsbz6qA1cnZ
	 Fizo7FvuQM9FQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 18/22] selftests/damon/sysfs.py: generalize DAMOS schemes commit assertion
Date: Sun, 20 Jul 2025 10:16:48 -0700
Message-Id: <20250720171652.92309-19-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720171652.92309-1-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS schemes commitment assertion is hard-coded for a specific test
case.  Split it out into a general version that can be reused for
different test cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index a32871b9b0f2..9e5c72804edf 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -132,6 +132,11 @@ def assert_scheme_committed(scheme, dump):
     for idx, f in enumerate(scheme.ops_filters.filters):
         assert_filter_committed(f, dump['ops_filters'][idx])
 
+def assert_schemes_committed(schemes, dump):
+    assert_true(len(schemes) == len(dump), 'len_schemes', dump)
+    for idx, scheme in enumerate(schemes):
+        assert_scheme_committed(scheme, dump[idx])
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -175,10 +180,7 @@ def main():
             { 'pid': 0, 'nr_regions': 0, 'regions_list': []}]:
         fail('adaptive targets', status)
 
-    if len(ctx['schemes']) != 1:
-        fail('number of schemes', status)
-
-    assert_scheme_committed(_damon_sysfs.Damos(), ctx['schemes'][0])
+    assert_schemes_committed([_damon_sysfs.Damos()], ctx['schemes'])
 
     kdamonds.stop()
 
-- 
2.39.5

