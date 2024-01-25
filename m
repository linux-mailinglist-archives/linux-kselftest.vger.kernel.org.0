Return-Path: <linux-kselftest+bounces-3577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F583C727
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFE128F5BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22499745F0;
	Thu, 25 Jan 2024 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cvs8XYav"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2387319E;
	Thu, 25 Jan 2024 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197622; cv=none; b=ZeGPZ8Ad8tgvmFh4CqE0cK5dWtfsQvN1S+klxyM9w+i91wna1M36hZDMf6xDO3VgRA6goDEEXIgxUl/aFZFDW6GllvIiCvDXdK+cY02eAqc1JhImtSDrbc7Njsxwzn/NCBBa7aaeXhde0O8zw1gkaQJeYT2Qo/aoZ1Zao6kiyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197622; c=relaxed/simple;
	bh=0g3nVHgPakWyFnqmE2VOcV8rmzcy5ewq0uXokzf81Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=entKQboRcYHYPSvAd8kFDD3HFoC8lHypBhTRK/ELw/C0dGhR9NKBw5naGSmSHWhjGtePMarPJ1f2sOrQHTYMNyLUUB8Ul9Saj6uVj86GlEigOCgYqbjV6ukoySNkp9yOSWbHGuJeIzcAPxr0YHzXEbF3tDJb11F7ebDvptwvOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cvs8XYav; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706197619;
	bh=0g3nVHgPakWyFnqmE2VOcV8rmzcy5ewq0uXokzf81Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cvs8XYavKfSBYNupi+Y+jbticrVBzIq3/yAmyVcSx3LYyVZcGy96fS24P7TGVvBgy
	 Jry7K08jTUcOxf0EOeYzhp4qxuN0y+mD1rcLe7W5Xl3VnFgzBS/qSlHPAonYzQNNt+
	 1KbyHIFFP5BLTrGjyPMEgMggflI5GVzYkfIMofCLTcwIKGi4jceA0K595IfzN74IBz
	 R2ORQGztFyx9++HTA9voZZnYjutxu1Rh00Yvf/okggzIV+FDKSmTPodtTXiIMW01Ns
	 DJ9BHbBV254X7VWqFvTHbqGaNfZy1Dx9Xl14KpSYc+8KgdwP7pvwE/TtQKMenhNjk0
	 IDLS2029Ueu1w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6475837820C3;
	Thu, 25 Jan 2024 15:46:56 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] selftests/mm: hugetlb_reparenting_test: do not unmount
Date: Thu, 25 Jan 2024 20:46:04 +0500
Message-ID: <20240125154608.720072-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125154608.720072-1-usama.anjum@collabora.com>
References: <20240125154608.720072-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not unmount the cgroup if it wasn't mounted by the test. The earlier
patch had fixed this for charge_reserved_hugetlb, but not for this test.
I'm adding fixes tag to that earlier patch.

Fixes: 209376ed2a84 ("selftests/vm: make charge_reserved_hugetlb.sh work with existing cgroup setting")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 14d26075c8635..615c4d766c909 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -248,5 +248,7 @@ cleanup
 
 echo ALL PASS
 
-umount $CGROUP_ROOT
-rm -rf $CGROUP_ROOT
+if [[ $do_umount ]]; then
+  umount $CGROUP_ROOT
+  rm -rf $CGROUP_ROOT
+fi
-- 
2.42.0


