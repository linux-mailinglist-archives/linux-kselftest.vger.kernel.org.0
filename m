Return-Path: <linux-kselftest+bounces-3070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E682EB44
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 10:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC28D2865E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C12125BF;
	Tue, 16 Jan 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MU4sRVCR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85F125B4;
	Tue, 16 Jan 2024 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705396002;
	bh=Zj/SXZG46k5uZDglokWIJfeqxlGt/89S7y+UnE+6VC8=;
	h=From:To:Cc:Subject:Date:From;
	b=MU4sRVCRFGtDob+mb1F2AivlOQO6ine81fDluyAGOB1fudFZZejybpxvosauvcX9t
	 Cubtyk/43nL/XcS9q1v3oV5iU/kC7exHyT+bK4qSyZhtUx/MjjIsEwzcDepdGfUeko
	 QJCNKWTCp00wjuiiV/vfHUnACHRLJ9exTFckQG47/i7XgcvtasT7h8d2HnwsC5k14f
	 moTSAQXBOdYK2FAYz3GFDeIbcGMMzIrTG8fkThp8KKj5fTj2a09/gktOuqzChguF2h
	 60KXqdARDvoDKqOOjRZkP6guNo3M0Rzv0JxtywMUQw77TgsDIP5weCNqy6cm82d9uZ
	 PcbiRC60bdoWw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 52266378200E;
	Tue, 16 Jan 2024 09:06:40 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mm: run_vmtests.sh: add missing tests
Date: Tue, 16 Jan 2024 14:06:40 +0500
Message-ID: <20240116090641.3411660-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing tests to run_vmtests.sh. The mm kselftests are run through
run_vmtests.sh. If a test isn't present in this script, it'll not run
with run_tests or `make -C tools/testing/selftests/mm run_tests`.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 246d53a5d7f2..a5e6ba8d3579 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -248,6 +248,9 @@ CATEGORY="hugetlb" run_test ./map_hugetlb
 CATEGORY="hugetlb" run_test ./hugepage-mremap
 CATEGORY="hugetlb" run_test ./hugepage-vmemmap
 CATEGORY="hugetlb" run_test ./hugetlb-madvise
+CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh
+CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh
+CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
 
 nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
 # For this test, we need one and just one huge page
-- 
2.42.0


