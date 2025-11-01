Return-Path: <linux-kselftest+bounces-44598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B8C28500
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6056C4EC819
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C16301032;
	Sat,  1 Nov 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LODRtFEU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571583009ED;
	Sat,  1 Nov 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021240; cv=none; b=ucdgLPi9fYy/TdU0Fkvy0qTZHs9VyCGqFVCfruDF+xTgCnnNqc/+G30+Hu3TxfAwb+Ne4RWJe7MEUTg2dzV+GDURt9hDdalEJIQucAm8Ye6fZZeoh9WmBE9xCGoKWJmHxu15Pv6G6mlIFm3GPxi+MxAzpeg7jJKyK7hOgZwMEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021240; c=relaxed/simple;
	bh=dtnr1Fqk2FrpK5TYhb0W5JzpIRDJYhJ9Lxh+9EtnNZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxCXZYgMojzFL2O8/x4y7Qo80m6usOjcCXfmGjmo8K9uJLp/S+avZ0AqXq8pWP7yI6o5njp542QnVALEn95e7IV51aMfn64Urf0ZOJTVxkYSlv4kqP6ddRp+EgKlgMvlbu77u07GSmJlQUSY/0CpHbQvlmZGKR4KlCt0Rz9+jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LODRtFEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEC2C4CEF1;
	Sat,  1 Nov 2025 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021239;
	bh=dtnr1Fqk2FrpK5TYhb0W5JzpIRDJYhJ9Lxh+9EtnNZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LODRtFEU84yycbBjTVcs78D6I+NelipVPJ4hhUP33InVXZ6/uAU0nQ/Q0e5tCEB9c
	 k52lYLaQ5R/WxIefPw1cyESyibMiqPAm+gCsrnPejUKnsVcvA3PyNC8dQC7a7P8BNs
	 I0capoajcgS+ARJN2vZE0ycBCidUElL7NcVZnjOwEKsxi4KIyTl7pNBoTLk17WMVTT
	 CtSFlKdgOHKfAoJmNsb/m+ijl0/KmyxTvn/YVgQaPDPdxt2HPH+m9UXxpVng28frPX
	 UdhLUrzoTHjz0azZU87aVvssUSjOlT7/6GRDN4aL7ztWCCo0EXHS/4eQDVpMVnIaYE
	 DPdy5Wx86MtUQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 5 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 12/22] mm/damon/tests/core-kunit: handle alloc failure on damon_test_set_attrs()
Date: Sat,  1 Nov 2025 11:20:06 -0700
Message-ID: <20251101182021.74868-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101182021.74868-1-sj@kernel.org>
References: <20251101182021.74868-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_set_attrs() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.
In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: aa13779be6b7 ("mm/damon/core-test: add a test for damon_set_attrs()")
Cc: <stable@vger.kernel.org> # 6.5.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 10c9953581ee..b9bd69a57e62 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -465,6 +465,9 @@ static void damon_test_set_attrs(struct kunit *test)
 		.sample_interval = 5000, .aggr_interval = 100000,};
 	struct damon_attrs invalid_attrs;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &valid_attrs), 0);
 
 	invalid_attrs = valid_attrs;
-- 
2.47.3

