Return-Path: <linux-kselftest+bounces-44587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407E9C2849A
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DE73BA50A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6A2FB988;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+gwKDO0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30422FB620;
	Sat,  1 Nov 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021237; cv=none; b=Pfm0tWoRbJF54vzqrcHMOzL2lgWq7jSK8j+Nrj75R3igpkn1ULNoB8gozUUujZzjUrBwx0J9fVaf2FvyT2FAKR/YoNwGpHaH+JbW846OPP2Eap9m5n7CTFbmpwVUL+5pOTmU305Sm2HpLwy0j0XmBf3LAjKVnNBv9QUklMQxwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021237; c=relaxed/simple;
	bh=LcoET9NixI9B2TvJ7D7SHN7zAnAoJR3IY93L52/J7TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeAvycqtA/3K9DIPxyCt8cS80tCbNRJgzNThUWeSkYjWWqCYqvOQm5DIxbGodesheT/BXTA28JpWoo0d+CsgXnlr2MB7jE4heS7I2ITnIgc4Gou49B4vOS4ZXVGUzxtEvd05Hu5qL6raJ1E7QD/zAOGZ8kaJ7vEaWUPlWR7I6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+gwKDO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D3DC113D0;
	Sat,  1 Nov 2025 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021236;
	bh=LcoET9NixI9B2TvJ7D7SHN7zAnAoJR3IY93L52/J7TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+gwKDO0ijHRuQy1R1itqxNm+fWJPJkcg/5tdoBhu/LO8YyfDY0i2qgW+/hhIxj69
	 9Rg3qKTNE4us2cqc+1a+DFYugOQhB7N2SRM7IdhqFTRs34R3g6qdn5WsG1g6xVImok
	 5iurUisrwIKPqPY65gaPTpPIasKBBnU+zO6jCcSZkDaG1bya6LYwX4QggkeFXYKNex
	 aAgedJwYp5rbPFRxmt5Gg4UjK8i5ESF+JfDxIXKN+QV4LBfCUas5uxQqNsaImzNx4L
	 LS7sW0uQ7/68s33NPWGKPlQl1IpS8C3pp2nuSJHEZ96inJdk45k4hbR5iZp5sQigHx
	 fkluiQe984sww==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/22] mm/damon/tests/core-kunit: fix memory leak in damon_test_set_filters_default_reject()
Date: Sat,  1 Nov 2025 11:19:55 -0700
Message-ID: <20251101182021.74868-2-sj@kernel.org>
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

Kunit test function for damos_set_filters_default_reject() allocates two
'struct damos_filter' objects and not deallocates those, so that the
memory for the two objects are leaked for every time the test runs.  Fix
this by deallocating those objects at the end of the test code.

Fixes: 094fb14913c7 ("mm/damon/tests/core-kunit: add a test for damos_set_filters_default_reject()")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 51369e35298b..69ca44f9270b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -598,6 +598,9 @@ static void damon_test_set_filters_default_reject(struct kunit *test)
 	 */
 	KUNIT_EXPECT_EQ(test, scheme.core_filters_default_reject, false);
 	KUNIT_EXPECT_EQ(test, scheme.ops_filters_default_reject, true);
+
+	damos_free_filter(anon_filter);
+	damos_free_filter(target_filter);
 }
 
 static struct kunit_case damon_test_cases[] = {
-- 
2.47.3

