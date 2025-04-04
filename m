Return-Path: <linux-kselftest+bounces-30118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0DA7C1AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 18:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A003B8F5E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912D20E007;
	Fri,  4 Apr 2025 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh1y12kG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C1208978;
	Fri,  4 Apr 2025 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784978; cv=none; b=EnWubmWZEn1AO6236kiuJhNnf+IV/8N6iWgcIb1neQ/pMIx3ALbBf/Q30kj0nmRwUzGYoTGkKOx7ebmYO377rfH53uXsv7NFmvn4Edva83Dhe2J3RXnY5d5E8NRIJdco7mNHtj/j4TPJP8zMY9q8SfNp+pCnFe9jSso25Zk0UYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784978; c=relaxed/simple;
	bh=TNi4PEbptWpWAlp9afnYThvYme8MQTL7nzY/LKJbojI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tMHV1MmasrgVj+Z5/KbYTeRKahhMe2ZbAkgiy+2Yq6JXlywxeKI9kakLgz/g0SagXh4T928dMX4g0gA+uB3fV12L9/i0Jb/wsiG7Rg5mBgNkktv6j+1ZXt1tRjevbYhnLxLYSSFf4dIyT0XEIWMAXuOCogJ8VEis//ewwfFrYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh1y12kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE18AC4CEDD;
	Fri,  4 Apr 2025 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743784977;
	bh=TNi4PEbptWpWAlp9afnYThvYme8MQTL7nzY/LKJbojI=;
	h=From:Date:Subject:To:Cc:From;
	b=Eh1y12kGzKjDxw0EkmsgbNYFzE08H2x4rsUZnyy8S71w9uTKa/P+KY4QRolfBjrK7
	 bcqayUG+NPAWRgE5EhqkVH9so4ME2yldi2gyQodwOKfTPIZF1C96uVuSMrcyIo7q/h
	 IgCm+Ph3l4MEDTZoPC9FfEOti2DqnyS0/WVOBR/Vh/jferLLYJFM+nRYiUwGklMgud
	 V52sIpivx3bqzfFDO56QTCeUXmcBHXkpQ1ePsESZD+uo/XwihiAwNDBsKDC3USEyWn
	 eRueNckknRYgNzNckqGo8fhodTsHIY6dVQT2G2BC3aituW3xEWwu0TlocAS9MXt+px
	 7U9L1NTKv0nfA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 04 Apr 2025 17:42:32 +0100
Subject: [PATCH] selftests/mm: Generate a temporary mountpoint for cgroup
 filesystem
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-kselftest-mm-cgroup2-detection-v1-1-3dba6d32ba8c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPgL8GcC/x2NzQ6CMBAGX4Xs2U3KIhh9FcMB26+4UX7SLcaE8
 O42HucwMzsZksLoVu2U8FHTZS5Qnyryz2EewRoKkzhp3dk1/DK8Y4Zlnib2Y1q2VTggw+ei8uP
 S1TFII/EaqETWhKjf/+DeH8cPJ76eMnAAAAA=
X-Change-ID: 20250403-kselftest-mm-cgroup2-detection-b761fd232f9d
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Waiman Long <longman@redhat.com>
Cc: Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2925; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TNi4PEbptWpWAlp9afnYThvYme8MQTL7nzY/LKJbojI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn8AwOxx3xtn4/NlyZcqctIQ64Hba9efHA8DBEgtnn
 T/6cCqyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/AMDgAKCRAk1otyXVSH0J5LB/
 9A9GmrE3YSF6/3xP/0Z3gw87wadfRJCRggdPL5wF887+qubzuV6aHED/VV4NVO32LZv6DB6QsxNC+/
 0t/csSQoNgDoM+IAObBxovJSpAIXBQ0aGGoFtbuMfH2oi49ZiFv+grQg42IPIRm5JkzxbycX4fJqxs
 KrueY1X8axR9rMR1BplRj2KLrlUGDerPLqCaaiFRWJ/9VsJbtMH8XJK+7ay7PwyQziELA5xVLwKK4i
 vJ0mep9INEG0252n+hnbJX7G2RxzuZlXYqQcV/35IEF155DvZqHMMc97rQBytHewE3VgYCXo2vx6Z4
 +lWd1TsINKu0ItLq2wPwf8xp9X4/Nu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently if the filesystem for the cgroups version it wants to use is
not mounted charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh
tests will attempt to mount it on the hard coded path
/dev/cgroup/memory, deleting that directory when the test finishes. This
will fail if there is not a preexisting directory at that path, and
since the directory is deleted subsequent runs of the test will fail.
Instead of relying on this hard coded directory name use mktemp to
generate a temporary directory to use as a mountpoint, fixing both the
assumption and the disruption caused by deleting a preexisting
directory.

This means that if the relevant cgroup filesystem is not already mounted
then we rely on having coreutils (which provides mktemp) installed. I
suspect that many current users are relying on having things automounted
by default, and given that the script relies on bash it's probably not
an unreasonable requirement.

Fixes: 209376ed2a84 ("selftests/vm: make charge_reserved_hugetlb.sh work with existing cgroup setting")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh  | 4 ++--
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index 67df7b47087f..e1fe16bcbbe8 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -29,7 +29,7 @@ fi
 if [[ $cgroup2 ]]; then
   cgroup_path=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup2 none $cgroup_path
     do_umount=1
   fi
@@ -37,7 +37,7 @@ if [[ $cgroup2 ]]; then
 else
   cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup memory,hugetlb $cgroup_path
     do_umount=1
   fi
diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 11f9bbe7dc22..0b0d4ba1af27 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -23,7 +23,7 @@ fi
 if [[ $cgroup2 ]]; then
   CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
-    CGROUP_ROOT=/dev/cgroup/memory
+    CGROUP_ROOT=$(mktemp -d)
     mount -t cgroup2 none $CGROUP_ROOT
     do_umount=1
   fi

---
base-commit: a4cda136f021ad44b8b52286aafd613030a6db5f
change-id: 20250403-kselftest-mm-cgroup2-detection-b761fd232f9d

Best regards,
-- 
Mark Brown <broonie@kernel.org>


