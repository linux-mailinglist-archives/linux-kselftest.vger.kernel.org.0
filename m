Return-Path: <linux-kselftest+bounces-3579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335683C72B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367961C230B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52EA768FA;
	Thu, 25 Jan 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2t58O5rm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E9768EA;
	Thu, 25 Jan 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197628; cv=none; b=mCKFXVM2DZp32jzPyfob0sQQmzkgzr06/wiXlKl5hqZHTNnHmMNrMtbvYbj2+PbaoOB/G70eMDNKCA6dGKMZxJmZB4SiP5yV1IE7X05vkhqFgbQq0xpYbZ5FUhWL2nVVCDTly72H9UuOPZQpLiD+3pm9xPC+SZ4r0kqFrvroJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197628; c=relaxed/simple;
	bh=nBKP7IMGZyOm1MyLruyEwVqUb1qwqC4I6GuPQzc7lR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj3PAGaXlhq1SUnuq2t2BlAviDAzm6iXMd1lnGtu1VmhcYd6seft5NF2BxFy32YcIz+u9BWBeyvbeieEoE13WCvcgDJAxRz9ICsRp4F2JnwieG/6dKetycTSAFlU6wJmLzYPOflybFZtNIPGyA8tY/5n382RhTyP5lmXKpyp6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2t58O5rm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706197625;
	bh=nBKP7IMGZyOm1MyLruyEwVqUb1qwqC4I6GuPQzc7lR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2t58O5rmI0tgzLH867h7Hn1M6kVNfXg1lLkW5aaSJ8kOIiA7i+8eEoF3VLDSUN2YQ
	 rpGl7lW1gSYk0OZ1ETs03ckogi2nJ5ycgSeSn39pps9LUWj0OfukoVRqQb1/GfIjku
	 I01q0SqMuZuDp4+or5ccXYBmncJ+FQqJj9JlI3PZNo5nhx1E0c/BcucoeKymBz0ezx
	 A3gIX+8D0HPlvB0IYxnNE/x7ShLnKeOT+4wIZ3oToniYvO6c8v8d0qqFROpGcfXJ6u
	 HvTikaoKxhWZdkpUapnHgaU4FF+KRK1NMkZ5QOvrnxgaYCi5tPlV0hgP2NOopk93PQ
	 Yc+b6VjbTAWKw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8756D37820C5;
	Thu, 25 Jan 2024 15:47:02 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] selftests/mm: save and restore nr_hugepages value
Date: Thu, 25 Jan 2024 20:46:06 +0500
Message-ID: <20240125154608.720072-4-usama.anjum@collabora.com>
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

Save and restore nr_hugepages before changing it during the test. A test
should not change system wide settings.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh  | 4 ++++
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index e14bdd4455f2d..d680c00d2853a 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -11,6 +11,8 @@ if [[ $(id -u) -ne 0 ]]; then
   exit $ksft_skip
 fi
 
+nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
+
 fault_limit_file=limit_in_bytes
 reservation_limit_file=rsvd.limit_in_bytes
 fault_usage_file=usage_in_bytes
@@ -582,3 +584,5 @@ if [[ $do_umount ]]; then
   umount $cgroup_path
   rmdir $cgroup_path
 fi
+
+echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 615c4d766c909..11f9bbe7dc222 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -11,6 +11,7 @@ if [[ $(id -u) -ne 0 ]]; then
   exit $ksft_skip
 fi
 
+nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
 usage_file=usage_in_bytes
 
 if [[ "$1" == "-cgroup-v2" ]]; then
@@ -252,3 +253,5 @@ if [[ $do_umount ]]; then
   umount $CGROUP_ROOT
   rm -rf $CGROUP_ROOT
 fi
+
+echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
-- 
2.42.0


