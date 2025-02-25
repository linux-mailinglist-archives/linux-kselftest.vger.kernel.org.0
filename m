Return-Path: <linux-kselftest+bounces-27536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0486A45003
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 23:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D287AE47A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93C2192ED;
	Tue, 25 Feb 2025 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIvuyQsG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2762192E1;
	Tue, 25 Feb 2025 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522220; cv=none; b=AtyLHAMc0C8FzFfCu7VD2UhkSUJJguIpswWVNnPoeq6+6ahBVdhq4lSLgIpKMDiyKzSAnoViFbMIUyDElSfKThAnVJr4q8/2ctubs80ahi1lpkDk5otckPmr1V3bWjDe9+vQBnMlt49DSs9USFbErb5UXRfGbTJ8T9Qfiwsz1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522220; c=relaxed/simple;
	bh=R+F4A/CbzeGBYRaqycEJB0fqs7IcWZvoisrzTTX4FCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYG4uJt98+anto3HqnWwKWeELY0tkD+x7178UMP3Dy/bPLyiwndFlaGu5CRhy8eEqEOApLJJyaOR4m4lxPBZM2NWClx7EvGRwrvYOAUxtnE9CPNNyxKk5Tis8GIumBb9pjyBg5/Y2cbybe5Ij09EyrVwqZ/uP5wtoXbFzb+jxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIvuyQsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5258C4CEE7;
	Tue, 25 Feb 2025 22:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740522219;
	bh=R+F4A/CbzeGBYRaqycEJB0fqs7IcWZvoisrzTTX4FCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIvuyQsGxF37rpHewq7AAWFKTlEi+j1hVtsngREZ0OkZyWFTBHbX+0SDkyU2I0qQ5
	 sNZMkQ3/1oZMX1ERqiWgGdBS236k1va2ee/Oy1nd9yzEdgTrg5mMrmkOOnfrFARgem
	 cB5jzHvvwvT9f2wPey/TApuPoCCO7bibHCTFxGwsBLBevIqs7DcaaNJq74PIZrkZay
	 1w7Ry/eTdCG6Ty3OKGohi8V6KC7sbUdRKz5x6nSEXzmUOTSw23IzXWlqIwARFDYRiG
	 L68jQgZFDDw4s57u4v1R8Sn1Cip00BP8mOyzKENdZUxE9XnKtzhqN31tfGNzrhXPdd
	 QKJfCvjaghjDQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] selftests/damon/damon_nr_regions: set ops update for merge results check to 100ms
Date: Tue, 25 Feb 2025 14:23:32 -0800
Message-Id: <20250225222333.505646-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225222333.505646-1-sj@kernel.org>
References: <20250225222333.505646-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_regions.py updates max_nr_regions to a number smaller than
expected number of real regions and confirms DAMON respect the harsh
limit.  To give time for DAMON to make changes for the regions, 3
aggregation intervals (300 milliseconds) are given.

The internal mechanism works with not only the max_nr_regions, but also
sz_limit, though.  It avoids merging region if that casn make region of
size larger than sz_limit.  In the test, sz_limit is set too small to
achive the new max_nr_regions, unless it is updated for the new
min_nr_regions.  But the update is done only once per operations set
update interval, which is one second by default.

Hence, the test randomly incurs false positive failures.  Fix it by
setting the ops interval same to aggregation interval, to make sure
sz_limit is updated by the time of the check.

Fixes: 8bf890c81612 ("selftests/damon/damon_nr_regions: test online-tuned max_nr_regions")
Cc: <stable@vger.kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/damon_nr_regions.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
index 2e8a74aff543..6f1c1d88e309 100755
--- a/tools/testing/selftests/damon/damon_nr_regions.py
+++ b/tools/testing/selftests/damon/damon_nr_regions.py
@@ -109,6 +109,7 @@ def main():
     attrs = kdamonds.kdamonds[0].contexts[0].monitoring_attrs
     attrs.min_nr_regions = 3
     attrs.max_nr_regions = 7
+    attrs.update_us = 100000
     err = kdamonds.kdamonds[0].commit()
     if err is not None:
         proc.terminate()
-- 
2.39.5

