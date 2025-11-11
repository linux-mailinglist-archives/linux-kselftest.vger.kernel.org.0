Return-Path: <linux-kselftest+bounces-45348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B150C4F795
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8F83AA883
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502872BE03C;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhvmRijH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238702BD5BB;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886668; cv=none; b=pSNeUHkdgD3PvBC2i958dUiWSmoPZSDLXGkg+DgQgR87LFzuRJSobnEPDNmOu/H4Yqwsi+R/HrAK1vRQR26Cj/FJR0Wmu/Sdl+IPvzeJ1trwKWFuuI2mqvY9VMJAfHduYs1kxvLJiSMkzQOBHbiB509wJZzhzSUXODjn+h2avo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886668; c=relaxed/simple;
	bh=RN1NkgEO23eqGRbIw3CgEAS8tb3Fp9u4BZ1voGEOa3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNDhXDSV/uGB21F4d/NBR1hpv5U0hDL1xkrX1f4BXWMsyOLLYE2gdDzpVMzcDnnd5FlxEb7OKNPqDsNjMtv6CFr22ZyIDB4L2TP4n3AnV4UAIv/12/TNemgx/V2FUf+6upXVswgOrKb0R0Y3Qh2kjz5+ppaTD9pTrTdNNPirRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhvmRijH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9117BC16AAE;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886667;
	bh=RN1NkgEO23eqGRbIw3CgEAS8tb3Fp9u4BZ1voGEOa3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhvmRijHVE7DhBMAgCDPQkJjPgAzyuoQn2gcyl020+DeeyaUT45dX9uTplTJh829R
	 Eh2tWyLnhoJaPHGZW4jpzrnYMiSrW8Wb/3UYOKQqFx6XEvXjdjS9ezViSBJzv7gZe6
	 5VJmHzP/sygGB7NSf7d87vgYAqJxWnDcev22qw7PuRrjQwRjlrItbtiPYDUJhPiIm6
	 RhTIDJ0GhH3kzG4xLHbPUA9mfQ2yeTKpJzRfbovH1QQvXO+o0lFICsPslWI6Lihtil
	 PO2QhrT9a44GqGjV2F6cf+s6oyzNuE/jKET5mHxOadx39+E1R1wsYV3yUWrlc1IlM1
	 /tovELo2fUjzg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/11] mm/damon/tests/core-kunit: extend damos_test_commit_filter_for() for union fields
Date: Tue, 11 Nov 2025 10:44:02 -0800
Message-ID: <20251111184415.141757-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111184415.141757-1-sj@kernel.org>
References: <20251111184415.141757-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_filter() also updates union fields of 'struct
damos_filter'.  Extend damos_test_commit_filter_for() to cover the
expectations of the union fields.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 31f90cfcabf3..5052d8db9657 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -504,6 +504,26 @@ static void damos_test_commit_filter_for(struct kunit *test,
 	KUNIT_EXPECT_EQ(test, dst->type, src->type);
 	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
 	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
+	switch (src->type) {
+	case DAMOS_FILTER_TYPE_MEMCG:
+		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
+		break;
+	case DAMOS_FILTER_TYPE_ADDR:
+		KUNIT_EXPECT_EQ(test, dst->addr_range.start,
+				src->addr_range.start);
+		KUNIT_EXPECT_EQ(test, dst->addr_range.end,
+				src->addr_range.end);
+		break;
+	case DAMOS_FILTER_TYPE_TARGET:
+		KUNIT_EXPECT_EQ(test, dst->target_idx, src->target_idx);
+		break;
+	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
+		KUNIT_EXPECT_EQ(test, dst->sz_range.min, src->sz_range.min);
+		KUNIT_EXPECT_EQ(test, dst->sz_range.max, src->sz_range.max);
+		break;
+	default:
+		break;
+	}
 }
 
 static void damos_test_commit_filter(struct kunit *test)
-- 
2.47.3

