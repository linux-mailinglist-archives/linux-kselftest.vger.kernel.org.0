Return-Path: <linux-kselftest+bounces-9394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071D18BB20A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FCCB22DF5
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B50158852;
	Fri,  3 May 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozf53p/Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB092158844;
	Fri,  3 May 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759404; cv=none; b=YTwwksw5Svbdx8exFcHytXV7GAVFP2SAOKJ5mpONFR1oVWg6ANpurOBk2QYk7DlKqZE4/c97RzeE4VteJlNSsa0ficx2XZEyNGWbsUq9l5fgFL6skOc2jy6aHXqRHXLv+5LRWX1vUtnQxxFRyjHwEcYEwQy4nrUuV5sMQ3Xj/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759404; c=relaxed/simple;
	bh=BxWQ3nfJ8G0tvTTltgrGE2Vi8fVZjZKQ8RTpaGZaaWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXu4t4ddHO/v1zGTnBY3yrkE+DtWAlNzQRLPjSackYKpO+NfNP75LAN4DmlRaoUI3hI7krBaSj7MgTdI0l0UaFM3MYoSO3xnBl7PsL64pIV5PgO7zKugsJQ9WUZNV2+MYuxpWpcb2bTjG6jKezBq19ekxrAe6+ob3fxVYgCspiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozf53p/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E110DC4AF1C;
	Fri,  3 May 2024 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759403;
	bh=BxWQ3nfJ8G0tvTTltgrGE2Vi8fVZjZKQ8RTpaGZaaWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozf53p/YJ8O1q9ETgyXzeTGjW/yQlxn6NO1VcwwlyB5fhh79Z/RU1DvDX94tKHXJu
	 NsxMbG/hnGuFZpLqegru2su4C38GCd4GeW5Quns/i/+qP9o6be8FGs4t0BGVZB55Mn
	 9trnxuoEJq8oeqtK7BMePrWszC+NOztLCzuHG46t7ldbbHESDRT9Dwmltq/TaZ3Y/M
	 BE5CX1uGYcY9suy8F8PdvDWsy+Fw6WJNRGelV/7dsjeVyxYEannjrjzGitWrtL5jjT
	 CRis0hFCHlOrM/BpzLuYChhdkNGITy96Kn3Z0ap8peht+EgMJDHn63ctEz1Q+oWGKr
	 U+M1NpLfXp42A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] selftests/damon/_damon_sysfs: check errors from nr_schemes file reads
Date: Fri,  3 May 2024 11:03:10 -0700
Message-Id: <20240503180318.72798-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503180318.72798-1-sj@kernel.org>
References: <20240503180318.72798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON context staging method in _damon_sysfs.py is not checking the
returned error from nr_schemes file read.  Check it.

Fixes: f5f0e5a2bef9 ("selftests/damon/_damon_sysfs: implement kdamonds start function")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index f80fdcef507c..fffa74a78bd7 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -341,6 +341,8 @@ class DamonCtx:
         nr_schemes_file = os.path.join(
                 self.sysfs_dir(), 'schemes', 'nr_schemes')
         content, err = read_file(nr_schemes_file)
+        if err is not None:
+            return err
         if int(content) != len(self.schemes):
             err = write_file(nr_schemes_file, '%d' % len(self.schemes))
             if err != None:
-- 
2.39.2


