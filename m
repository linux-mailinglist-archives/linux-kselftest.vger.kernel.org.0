Return-Path: <linux-kselftest+bounces-43840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50BBFED84
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9DAA5031D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB585232369;
	Thu, 23 Oct 2025 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OntKqQFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A049C1448D5;
	Thu, 23 Oct 2025 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182745; cv=none; b=FT23vGQEHh1zZWz7czzgMj7Tac8oiaw3f7IMlolzUfCDwD8TWah5kMWiZ020RhZ8BrBSQjC2wfrFHtONw9u0vVK4GD43DWOmSbEl6lm9HWEzPjNit/BR/nZai8R/VKjD2ZAqoZnEd04YRnh1tIw4NAhvLVJ7IrkCPtbcZ1MQoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182745; c=relaxed/simple;
	bh=P5iwpdgt+gTVzJnYLVnDYTD/06YxCQbWf1lq1vcjQO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY5a4CD/oWn24fxoSaAjyjWHWYZCjBkYoLVniZLDJwYqqYdFH31qlbSaSqiSIh+sIe+C+7Xcb9anow5+Mk7Od3UVzMuBZuqRiqbDikwBS8nBYkphbk7fD0h8fOYyWnRnj4JhvYFnqCa43XNa1gjjcPZu9V87NWfcPcMwnSEgDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OntKqQFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9905AC116C6;
	Thu, 23 Oct 2025 01:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182745;
	bh=P5iwpdgt+gTVzJnYLVnDYTD/06YxCQbWf1lq1vcjQO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OntKqQFKQ90pkuMEJ/uMDhG0j6Z4ILHt3/h9jCwhJn2XcLvEVzlucWwTQpii3YZa8
	 5OfOQMYEDdnpuEP4tcfbtcnasRYknDfI+5i6KPvinOCIHztJQHZmJJCLZYjDFh7PgD
	 S6AkvF6lUdeJnjfMSm7ou4zLMZ406faHMxVfXLGrGwkY68iVu+8RQK0m0gAndhZvXQ
	 1iWvSs0961w0nv43EfNMFsQWSY/gF/6yOUR33+Xs7daJcDK5EdK5xPzEarQI7Schyn
	 HGrgGHA9Beb8bSqZkRsUHbYL73Oe2C8h2jj7E8H5DYBGKVZC9Lf9Kv1W/l2kI3UBx1
	 WzP6VWC66XNIg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/9] drgn_dump_damon_status: dump damon_target->obsolete
Date: Wed, 22 Oct 2025 18:25:31 -0700
Message-ID: <20251023012535.69625-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023012535.69625-1-sj@kernel.org>
References: <20251023012535.69625-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new field of damon_target for pin-point target removal, namely
obsolete, has newly been added.  Extend drgn_dump_damon_status.py to
dump it, for easily writing a future DAMON selftests of it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 7233369a3a44..cb4fdbe68acb 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -73,6 +73,7 @@ def target_to_dict(target):
         ['pid', int],
         ['nr_regions', int],
         ['regions_list', regions_to_list],
+        ['obsolete', bool],
         ])
 
 def targets_to_list(targets):
-- 
2.47.3

