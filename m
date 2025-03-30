Return-Path: <linux-kselftest+bounces-29936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B189A75CEE
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 23:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FFC3A920C
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9A31E32D6;
	Sun, 30 Mar 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OK2xXyg/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471DF1E412A
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Mar 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371649; cv=none; b=O9ar8EuEeL9B82W8Eu+q6xm962tGfkvoG/TkYq0YVj2R3GZ7q0ckQe6gDpBE8CJfgFys7g3Ab0iJQ1xKISvFk31CrisB02h71eqdKKaFurrN73n7q+LCtQC3ApKBBC/7eQpnBmV7FI1dCZNyE1reSh6sSsMO5g0JdS61cqr2wUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371649; c=relaxed/simple;
	bh=cXWhXrKWtPC2Wm2Id5Zu0xImkRbDgiE7TBA6sWW411c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAX7Z1aC83TxKky78k/fPOMz4yRr3qlMn3dXZFPD119DH8jmHWuIwCl6UAl6Sl6QyE9Zpsa5EvhNREwVjH3L5zUBfkcJrj5QmaXBG8C50bTxx2KEPQOeVlqbp4Bc5dRqELJF1fwYRp+g4paZxQ0wHaVnwhTktBXXaSzNk6biSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OK2xXyg/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qD2xJfM2aj8zat6RewjByPqBGmEjKZkp/PoWWA3hS6w=;
	b=OK2xXyg/zAoMEqmnp6fuzZK11fJjaYn+/aozIAT/KrTSFMtrwyb8qW7pfJBawY6cmn202M
	FlJaZIXgnEEICHXUzAHU1pfyNLT3waCmDRgy7fEUsKDrQvk6eGdIqXVNpmIv2ZIYORjQzT
	ftfZtyRodwggIm8zK97VUD3Q+XP42DY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-_6i73suiOv-HJ3NuXkzANg-1; Sun,
 30 Mar 2025 17:53:58 -0400
X-MC-Unique: _6i73suiOv-HJ3NuXkzANg-1
X-Mimecast-MFC-AGG-ID: _6i73suiOv-HJ3NuXkzANg_1743371637
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DF911956070;
	Sun, 30 Mar 2025 21:53:57 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 573881801750;
	Sun, 30 Mar 2025 21:53:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 08/10] selftest/cgroup: Update test_cpuset_prs.sh to use | as effective CPUs and state separator
Date: Sun, 30 Mar 2025 17:52:46 -0400
Message-ID: <20250330215248.3620801-9-longman@redhat.com>
In-Reply-To: <20250330215248.3620801-1-longman@redhat.com>
References: <20250330215248.3620801-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, ',' is used as the cgroup separator of the expected effective
CPUs and partition root states in the test matrix. However, ',' can be
part of the output of the cpuset.cpus*.effective and cpuset.cpus.isolated
files. Change the separator to '|' so that ',' can appear as part of
the expected values.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 236 +++++++++---------
 1 file changed, 118 insertions(+), 118 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 4e3fabed52da..f11f347129d8 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -207,130 +207,130 @@ TEST_MATRIX=(
 	"  C0-1:P1   .      .    C2-3  S+:C4-5   .      .      .     0 A1:4-5"
 	"   C0-1     .      .   C2-3:P1   .      .      .     C2     0 "
 	"   C0-1     .      .   C2-3:P1   .      .      .    C4-5    0 B1:4-5"
-	"C0-3:P1:S+ C2-3:P1 .      .      .      .      .      .     0 A1:0-1,A2:2-3"
-	"C0-3:P1:S+ C2-3:P1 .      .     C1-3    .      .      .     0 A1:1,A2:2-3"
-	"C2-3:P1:S+  C3:P1  .      .     C3      .      .      .     0 A1:,A2:3 A1:P1,A2:P1"
-	"C2-3:P1:S+  C3:P1  .      .     C3      P0     .      .     0 A1:3,A2:3 A1:P1,A2:P0"
-	"C2-3:P1:S+  C2:P1  .      .     C2-4    .      .      .     0 A1:3-4,A2:2"
-	"C2-3:P1:S+  C3:P1  .      .     C3      .      .     C0-2   0 A1:,B1:0-2 A1:P1,A2:P1"
-	"$SETUP_A123_PARTITIONS    .     C2-3    .      .      .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"C0-3:P1:S+ C2-3:P1 .      .      .      .      .      .     0 A1:0-1|A2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     C1-3    .      .      .     0 A1:1|A2:2-3"
+	"C2-3:P1:S+  C3:P1  .      .     C3      .      .      .     0 A1:|A2:3 A1:P1|A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .     C3      P0     .      .     0 A1:3|A2:3 A1:P1|A2:P0"
+	"C2-3:P1:S+  C2:P1  .      .     C2-4    .      .      .     0 A1:3-4|A2:2"
+	"C2-3:P1:S+  C3:P1  .      .     C3      .      .     C0-2   0 A1:|B1:0-2 A1:P1|A2:P1"
+	"$SETUP_A123_PARTITIONS    .     C2-3    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
 
 	# CPU offlining cases:
-	"   C0-1     .      .    C2-3    S+    C4-5     .     O2=0   0 A1:0-1,B1:3"
-	"C0-3:P1:S+ C2-3:P1 .      .     O2=0    .      .      .     0 A1:0-1,A2:3"
-	"C0-3:P1:S+ C2-3:P1 .      .     O2=0   O2=1    .      .     0 A1:0-1,A2:2-3"
-	"C0-3:P1:S+ C2-3:P1 .      .     O1=0    .      .      .     0 A1:0,A2:2-3"
-	"C0-3:P1:S+ C2-3:P1 .      .     O1=0   O1=1    .      .     0 A1:0-1,A2:2-3"
-	"C2-3:P1:S+  C3:P1  .      .     O3=0   O3=1    .      .     0 A1:2,A2:3 A1:P1,A2:P1"
-	"C2-3:P1:S+  C3:P2  .      .     O3=0   O3=1    .      .     0 A1:2,A2:3 A1:P1,A2:P2"
-	"C2-3:P1:S+  C3:P1  .      .     O2=0   O2=1    .      .     0 A1:2,A2:3 A1:P1,A2:P1"
-	"C2-3:P1:S+  C3:P2  .      .     O2=0   O2=1    .      .     0 A1:2,A2:3 A1:P1,A2:P2"
-	"C2-3:P1:S+  C3:P1  .      .     O2=0    .      .      .     0 A1:,A2:3 A1:P1,A2:P1"
-	"C2-3:P1:S+  C3:P1  .      .     O3=0    .      .      .     0 A1:2,A2: A1:P1,A2:P1"
-	"C2-3:P1:S+  C3:P1  .      .    T:O2=0   .      .      .     0 A1:3,A2:3 A1:P1,A2:P-1"
-	"C2-3:P1:S+  C3:P1  .      .      .    T:O3=0   .      .     0 A1:2,A2:2 A1:P1,A2:P-1"
-	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
-	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
-	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1,A2:2,A3: A1:P1,A2:P1,A3:P1"
-	"$SETUP_A123_PARTITIONS    .    T:O1=0   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
-	"$SETUP_A123_PARTITIONS    .      .    T:O2=0   .      .     0 A1:1,A2:3,A3:3 A1:P1,A2:P1,A3:P-1"
-	"$SETUP_A123_PARTITIONS    .      .      .    T:O3=0   .     0 A1:1,A2:2,A3:2 A1:P1,A2:P1,A3:P-1"
-	"$SETUP_A123_PARTITIONS    .    T:O1=0  O1=1    .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
-	"$SETUP_A123_PARTITIONS    .      .    T:O2=0  O2=1    .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
-	"$SETUP_A123_PARTITIONS    .      .      .    T:O3=0  O3=1   0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
-	"$SETUP_A123_PARTITIONS    .    T:O1=0  O2=0   O1=1    .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
-	"$SETUP_A123_PARTITIONS    .    T:O1=0  O2=0   O2=1    .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+	"   C0-1     .      .    C2-3    S+    C4-5     .     O2=0   0 A1:0-1|B1:3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O2=0    .      .      .     0 A1:0-1|A2:3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O2=0   O2=1    .      .     0 A1:0-1|A2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O1=0    .      .      .     0 A1:0|A2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O1=0   O1=1    .      .     0 A1:0-1|A2:2-3"
+	"C2-3:P1:S+  C3:P1  .      .     O3=0   O3=1    .      .     0 A1:2|A2:3 A1:P1|A2:P1"
+	"C2-3:P1:S+  C3:P2  .      .     O3=0   O3=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
+	"C2-3:P1:S+  C3:P1  .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P1"
+	"C2-3:P1:S+  C3:P2  .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
+	"C2-3:P1:S+  C3:P1  .      .     O2=0    .      .      .     0 A1:|A2:3 A1:P1|A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .     O3=0    .      .      .     0 A1:2|A2: A1:P1|A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
+	"C2-3:P1:S+  C3:P1  .      .      .    T:O3=0   .      .     0 A1:2|A2:2 A1:P1|A2:P-1"
+	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
+	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
+	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1|A2:2|A3: A1:P1|A2:P1|A3:P1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0   .      .      .     0 A1:2-3|A2:2-3|A3:3 A1:P1|A2:P-1|A3:P-1"
+	"$SETUP_A123_PARTITIONS    .      .    T:O2=0   .      .     0 A1:1|A2:3|A3:3 A1:P1|A2:P1|A3:P-1"
+	"$SETUP_A123_PARTITIONS    .      .      .    T:O3=0   .     0 A1:1|A2:2|A3:2 A1:P1|A2:P1|A3:P-1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0  O1=1    .      .     0 A1:1|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
+	"$SETUP_A123_PARTITIONS    .      .    T:O2=0  O2=1    .     0 A1:1|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
+	"$SETUP_A123_PARTITIONS    .      .      .    T:O3=0  O3=1   0 A1:1|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0  O2=0   O1=1    .     0 A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0  O2=0   O2=1    .     0 A1:2-3|A2:2-3|A3:3 A1:P1|A2:P-1|A3:P-1"
 
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	#
 	# Remote partition and cpuset.cpus.exclusive tests
 	#
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3     .      .      .     0 A1:0-3,A2:1-3,A3:2-3,XA1:2-3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3  X2-3:P2   .      .     0 A1:0-1,A2:2-3,A3:2-3 A1:P0,A2:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2,A2:3,A3:3 A1:P0,A2:P2 3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1,A2:1,A3:2-3 A1:P0,A3:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1,A2:1,A3:2-3 A1:P0,A3:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-3,A2:1-3,A3:2-3,B1:2-3 A1:P0,A3:P0,B1:P-2"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3     .      .      .     0 A1:0-3|A2:1-3|A3:2-3|XA1:2-3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3  X2-3:P2   .      .     0 A1:0-1|A2:2-3|A3:2-3 A1:P0|A2:P2 2-3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2|A2:3|A3:3 A1:P0|A2:P2 3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
+	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-3|A2:1-3|A3:2-3|B1:2-3 A1:P0|A3:P0|B1:P-2"
 	" C0-3:S+ C1-3:S+ C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3,B1:4 A3:P2,B1:P2 2-4"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3,B1:4 A3:P2,B1:P2 2-4"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X1-3  X1-3:P2   P2     .     0 A2:1,A3:2-3 A2:P2,A3:P2 1-3"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2 P2:C4-5 0 A3:2-3,B1:4-5 A3:P2,B1:P2 2-5"
-	" C4:X0-3:S+ X1-3:S+ X2-3  .      .      P2     .      .     0 A1:4,A2:1-3,A3:1-3 A2:P2 1-3"
-	" C4:X0-3:S+ X1-3:S+ X2-3  .      .      .      P2     .     0 A1:4,A2:4,A3:2-3 A3:P2 2-3"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X1-3  X1-3:P2   P2     .     0 A2:1|A3:2-3 A2:P2|A3:P2 1-3"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2 P2:C4-5 0 A3:2-3|B1:4-5 A3:P2|B1:P2 2-5"
+	" C4:X0-3:S+ X1-3:S+ X2-3  .      .      P2     .      .     0 A1:4|A2:1-3|A3:1-3 A2:P2 1-3"
+	" C4:X0-3:S+ X1-3:S+ X2-3  .      .      .      P2     .     0 A1:4|A2:4|A3:2-3 A3:P2 2-3"
 
 	# Nested remote/local partition tests
-	" C0-3:S+ C1-3:S+ C2-3   C4-5   X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:,A3:2-3,B1:4-5 \
-								       A1:P0,A2:P1,A3:P2,B1:P1 2-3"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:,A3:2-3,B1:4 \
-								       A1:P0,A2:P1,A3:P2,B1:P1 2-4,2-3"
-	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1    .     P1    0 A1:0-1,A2:2-3,A3:2-3,B1:4 \
-								       A1:P0,A2:P1,A3:P0,B1:P1"
-	" C0-3:S+ C1-3:S+  C3     C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:2,A3:3,B1:4 \
-								       A1:P0,A2:P1,A3:P2,B1:P1 2-4,3"
-	" C0-4:S+ C1-4:S+ C2-4     .    X2-4  X2-4:P2  X4:P1    .    0 A1:0-1,A2:2-3,A3:4 \
-								       A1:P0,A2:P2,A3:P1 2-4,2-3"
-	" C0-4:S+ C1-4:S+ C2-4     .    X2-4  X2-4:P2 X3-4:P1   .    0 A1:0-1,A2:2,A3:3-4 \
-								       A1:P0,A2:P2,A3:P1 2"
+	" C0-3:S+ C1-3:S+ C2-3   C4-5   X2-3  X2-3:P1   P2     P1    0 A1:0-1|A2:|A3:2-3|B1:4-5 \
+								       A1:P0|A2:P1|A3:P2|B1:P1 2-3"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1|A2:|A3:2-3|B1:4 \
+								       A1:P0|A2:P1|A3:P2|B1:P1 2-4|2-3"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1    .     P1    0 A1:0-1|A2:2-3|A3:2-3|B1:4 \
+								       A1:P0|A2:P1|A3:P0|B1:P1"
+	" C0-3:S+ C1-3:S+  C3     C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1|A2:2|A3:3|B1:4 \
+								       A1:P0|A2:P1|A3:P2|B1:P1 2-4|3"
+	" C0-4:S+ C1-4:S+ C2-4     .    X2-4  X2-4:P2  X4:P1    .    0 A1:0-1|A2:2-3|A3:4 \
+								       A1:P0|A2:P2|A3:P1 2-4|2-3"
+	" C0-4:S+ C1-4:S+ C2-4     .    X2-4  X2-4:P2 X3-4:P1   .    0 A1:0-1|A2:2|A3:3-4 \
+								       A1:P0|A2:P2|A3:P1 2"
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
-				   .      .      X5      .      .    0 A1:0-4,A2:1-4,A3:2-4 \
-								       A1:P0,A2:P-2,A3:P-1"
+				   .      .      X5      .      .    0 A1:0-4|A2:1-4|A3:2-4 \
+								       A1:P0|A2:P-2|A3:P-1"
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
-				   .      .      .      X1      .    0 A1:0-1,A2:2-4,A3:2-4 \
-								       A1:P0,A2:P2,A3:P-1 2-4"
+				   .      .      .      X1      .    0 A1:0-1|A2:2-4|A3:2-4 \
+								       A1:P0|A2:P2|A3:P-1 2-4"
 
 	# Remote partition offline tests
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1,A2:1,A3:3 A1:P0,A3:P2 2-3"
-	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 O2=1 0 A1:0-1,A2:1,A3:2-3 A1:P0,A3:P2 2-3"
-	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2,A2:1-2,A3: A1:P0,A3:P2 3"
-	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2,A2:1-2,A3:1-2 A1:P0,A3:P-2 3,"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1|A2:1|A3:3 A1:P0|A3:P2 2-3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 O2=1 0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
+	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2|A2:1-2|A3: A1:P0|A3:P2 3"
+	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2|A2:1-2|A3:1-2 A1:P0|A3:P-2 3|"
 
 	# An invalidated remote partition cannot self-recover from hotplug
-	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3,A2:1-3,A3:2 A1:P0,A3:P-2"
+	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3|A2:1-3|A3:2 A1:P0|A3:P-2"
 
 	# cpus.exclusive.effective clearing test
-	" C0-3:S+ C1-3:S+  C2      .   X2-3:X    .      .      .     0 A1:0-3,A2:1-3,A3:2,XA1:"
+	" C0-3:S+ C1-3:S+  C2      .   X2-3:X    .      .      .     0 A1:0-3|A2:1-3|A3:2|XA1:"
 
 	# Invalid to valid remote partition transition test
-	" C0-3:S+   C1-3    .      .      .    X3:P2    .      .     0 A1:0-3,A2:1-3,XA2: A2:P-2"
+	" C0-3:S+   C1-3    .      .      .    X3:P2    .      .     0 A1:0-3|A2:1-3|XA2: A2:P-2"
 	" C0-3:S+ C1-3:X3:P2
-			    .      .    X2-3    P2      .      .     0 A1:0-2,A2:3,XA2:3 A2:P2 3"
+			    .      .    X2-3    P2      .      .     0 A1:0-2|A2:3|XA2:3 A2:P2 3"
 
 	# Invalid to valid local partition direct transition tests
-	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3,XA1:1-3,A2:1-3:XA2: A1:P2,A2:P-2 1-3"
-	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2,XA1:1-3,A2:3:XA2:3 A1:P2,A2:P2 1-3"
-	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4,B1:4-6 A1:P-2,B1:P0"
-	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3,B1:4-6 A1:P2,B1:P0 0-3"
-	"  C0-3:P2   .      .  C3-5:C4-5  .      .      .      .     0 A1:0-3,B1:4-5 A1:P2,B1:P0 0-3"
+	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
+	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
+	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:4-6 A1:P-2|B1:P0"
+	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
+	"  C0-3:P2   .      .  C3-5:C4-5  .      .      .      .     0 A1:0-3|B1:4-5 A1:P2|B1:P0 0-3"
 
 	# Local partition invalidation tests
 	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
-				   .      .      .      .      .     0 A1:1,A2:2,A3:3 A1:P2,A2:P2,A3:P2 1-3"
+				   .      .      .      .      .     0 A1:1|A2:2|A3:3 A1:P2|A2:P2|A3:P2 1-3"
 	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
-				   .      .     X4      .      .     0 A1:1-3,A2:1-3,A3:2-3,XA2:,XA3: A1:P2,A2:P-2,A3:P-2 1-3"
+				   .      .     X4      .      .     0 A1:1-3|A2:1-3|A3:2-3|XA2:|XA3: A1:P2|A2:P-2|A3:P-2 1-3"
 	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
-				   .      .    C4:X     .      .     0 A1:1-3,A2:1-3,A3:2-3,XA2:,XA3: A1:P2,A2:P-2,A3:P-2 1-3"
+				   .      .    C4:X     .      .     0 A1:1-3|A2:1-3|A3:2-3|XA2:|XA3: A1:P2|A2:P-2|A3:P-2 1-3"
 	# Local partition CPU change tests
-	" C0-5:S+:P2 C4-5:S+:P1 .  .      .    C3-5     .      .     0 A1:0-2,A2:3-5 A1:P2,A2:P1 0-2"
-	" C0-5:S+:P2 C4-5:S+:P1 .  .    C1-5     .      .      .     0 A1:1-3,A2:4-5 A1:P2,A2:P1 1-3"
+	" C0-5:S+:P2 C4-5:S+:P1 .  .      .    C3-5     .      .     0 A1:0-2|A2:3-5 A1:P2|A2:P1 0-2"
+	" C0-5:S+:P2 C4-5:S+:P1 .  .    C1-5     .      .      .     0 A1:1-3|A2:4-5 A1:P2|A2:P1 1-3"
 
 	# cpus_allowed/exclusive_cpus update tests
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
-				   .    X:C4     .      P2     .     0 A1:4,A2:4,XA2:,XA3:,A3:4 \
-								       A1:P0,A3:P-2"
+				   .    X:C4     .      P2     .     0 A1:4|A2:4|XA2:|XA3:|A3:4 \
+								       A1:P0|A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
-				   .     X1      .      P2     .     0 A1:0-3,A2:1-3,XA1:1,XA2:,XA3:,A3:2-3 \
-								       A1:P0,A3:P-2"
+				   .     X1      .      P2     .     0 A1:0-3|A2:1-3|XA1:1|XA2:|XA3:|A3:2-3 \
+								       A1:P0|A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
-				   .      .     X3      P2     .     0 A1:0-2,A2:1-2,XA2:3,XA3:3,A3:3 \
-								       A1:P0,A3:P2 3"
+				   .      .     X3      P2     .     0 A1:0-2|A2:1-2|XA2:3|XA3:3|A3:3 \
+								       A1:P0|A3:P2 3"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
-				   .      .     X3      .      .     0 A1:0-2,A2:1-2,XA2:3,XA3:3,A3:3,XA3:3 \
-								       A1:P0,A3:P2 3"
+				   .      .     X3      .      .     0 A1:0-2|A2:1-2|XA2:3|XA3:3|A3:3|XA3:3 \
+								       A1:P0|A3:P2 3"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
-				   .     X4      .      .      .     0 A1:0-3,A2:1-3,A3:2-3,XA1:4,XA2:,XA3 \
-								       A1:P0,A3:P-2"
+				   .     X4      .      .      .     0 A1:0-3|A2:1-3|A3:2-3|XA1:4|XA2:|XA3 \
+								       A1:P0|A3:P-2"
 
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
@@ -339,68 +339,68 @@ TEST_MATRIX=(
 	#
 	# Adding CPUs to partition root that are not in parent's
 	# cpuset.cpus is allowed, but those extra CPUs are ignored.
-	"C2-3:P1:S+ C3:P1   .      .      .     C2-4    .      .     0 A1:,A2:2-3 A1:P1,A2:P1"
+	"C2-3:P1:S+ C3:P1   .      .      .     C2-4    .      .     0 A1:|A2:2-3 A1:P1|A2:P1"
 
 	# Taking away all CPUs from parent or itself if there are tasks
 	# will make the partition invalid.
-	"C2-3:P1:S+  C3:P1  .      .      T     C2-3    .      .     0 A1:2-3,A2:2-3 A1:P1,A2:P-1"
-	" C3:P1:S+    C3    .      .      T      P1     .      .     0 A1:3,A2:3 A1:P1,A2:P-1"
-	"$SETUP_A123_PARTITIONS    .    T:C2-3   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
-	"$SETUP_A123_PARTITIONS    . T:C2-3:C1-3 .      .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"C2-3:P1:S+  C3:P1  .      .      T     C2-3    .      .     0 A1:2-3|A2:2-3 A1:P1|A2:P-1"
+	" C3:P1:S+    C3    .      .      T      P1     .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
+	"$SETUP_A123_PARTITIONS    .    T:C2-3   .      .      .     0 A1:2-3|A2:2-3|A3:3 A1:P1|A2:P-1|A3:P-1"
+	"$SETUP_A123_PARTITIONS    . T:C2-3:C1-3 .      .      .     0 A1:1|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
 
 	# Changing a partition root to member makes child partitions invalid
-	"C2-3:P1:S+  C3:P1  .      .      P0     .      .      .     0 A1:2-3,A2:3 A1:P0,A2:P-1"
-	"$SETUP_A123_PARTITIONS    .     C2-3    P0     .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P0,A3:P-1"
+	"C2-3:P1:S+  C3:P1  .      .      P0     .      .      .     0 A1:2-3|A2:3 A1:P0|A2:P-1"
+	"$SETUP_A123_PARTITIONS    .     C2-3    P0     .      .     0 A1:2-3|A2:2-3|A3:3 A1:P1|A2:P0|A3:P-1"
 
 	# cpuset.cpus can contains cpus not in parent's cpuset.cpus as long
 	# as they overlap.
-	"C2-3:P1:S+  .      .      .      .   C3-4:P1   .      .     0 A1:2,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  .      .      .      .   C3-4:P1   .      .     0 A1:2|A2:3 A1:P1|A2:P1"
 
 	# Deletion of CPUs distributed to child cgroup is allowed.
-	"C0-1:P1:S+ C1      .    C2-3   C4-5     .      .      .     0 A1:4-5,A2:4-5"
+	"C0-1:P1:S+ C1      .    C2-3   C4-5     .      .      .     0 A1:4-5|A2:4-5"
 
 	# To become a valid partition root, cpuset.cpus must overlap parent's
 	# cpuset.cpus.
-	"  C0-1:P1   .      .    C2-3    S+   C4-5:P1   .      .     0 A1:0-1,A2:0-1 A1:P1,A2:P-1"
+	"  C0-1:P1   .      .    C2-3    S+   C4-5:P1   .      .     0 A1:0-1|A2:0-1 A1:P1|A2:P-1"
 
 	# Enabling partition with child cpusets is allowed
-	"  C0-1:S+  C1      .    C2-3    P1      .      .      .     0 A1:0-1,A2:1 A1:P1"
+	"  C0-1:S+  C1      .    C2-3    P1      .      .      .     0 A1:0-1|A2:1 A1:P1"
 
-	# A partition root with non-partition root parent is invalid, but it
+	# A partition root with non-partition root parent is invalid| but it
 	# can be made valid if its parent becomes a partition root too.
-	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1,A2:1 A1:P0,A2:P-2"
-	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0,A2:1 A1:P1,A2:P2"
+	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
+	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2"
 
 	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
-	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2,B1:2-3 A1:P-1,B1:P0"
-	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2,B1:2-3 A1:P-1,B1:P-1"
-	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2,B1:2-3 A1:P0,B1:P-1"
+	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
+	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
+	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
 
 	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
-	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3,B1:4-5"
+	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"
 
 	# Child partition root that try to take all CPUs from parent partition
 	# with tasks will remain invalid.
-	" C1-4:P1:S+ P1     .      .       .     .      .      .     0 A1:1-4,A2:1-4 A1:P1,A2:P-1"
-	" C1-4:P1:S+ P1     .      .       .   C1-4     .      .     0 A1,A2:1-4 A1:P1,A2:P1"
-	" C1-4:P1:S+ P1     .      .       T   C1-4     .      .     0 A1:1-4,A2:1-4 A1:P1,A2:P-1"
+	" C1-4:P1:S+ P1     .      .       .     .      .      .     0 A1:1-4|A2:1-4 A1:P1|A2:P-1"
+	" C1-4:P1:S+ P1     .      .       .   C1-4     .      .     0 A1|A2:1-4 A1:P1|A2:P1"
+	" C1-4:P1:S+ P1     .      .       T   C1-4     .      .     0 A1:1-4|A2:1-4 A1:P1|A2:P-1"
 
 	# Clearing of cpuset.cpus with a preset cpuset.cpus.exclusive shouldn't
 	# affect cpuset.cpus.exclusive.effective.
-	" C1-4:X3:S+ C1:X3  .      .       .     C      .      .     0 A2:1-4,XA2:3"
+	" C1-4:X3:S+ C1:X3  .      .       .     C      .      .     0 A2:1-4|XA2:3"
 
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	# Failure cases:
 
 	# A task cannot be added to a partition with no cpu
-	"C2-3:P1:S+  C3:P1  .      .    O2=0:T   .      .      .     1 A1:,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .    O2=0:T   .      .      .     1 A1:|A2:3 A1:P1|A2:P1"
 
 	# Changes to cpuset.cpus.exclusive that violate exclusivity rule is rejected
-	"   C0-3     .      .    C4-5   X0-3     .      .     X3-5   1 A1:0-3,B1:4-5"
+	"   C0-3     .      .    C4-5   X0-3     .      .     X3-5   1 A1:0-3|B1:4-5"
 
 	# cpuset.cpus cannot be a subset of sibling cpuset.cpus.exclusive
-	"   C0-3     .      .    C4-5   X3-5     .      .      .     1 A1:0-3,B1:4-5"
+	"   C0-3     .      .    C4-5   X3-5     .      .      .     1 A1:0-3|B1:4-5"
 )
 
 #
@@ -567,12 +567,12 @@ dump_states()
 
 #
 # Check effective cpus
-# $1 - check string, format: <cgroup>:<cpu-list>[,<cgroup>:<cpu-list>]*
+# $1 - check string, format: <cgroup>:<cpu-list>[|<cgroup>:<cpu-list>]*
 #
 check_effective_cpus()
 {
 	CHK_STR=$1
-	for CHK in $(echo $CHK_STR | sed -e "s/,/ /g")
+	for CHK in $(echo $CHK_STR | sed -e "s/|/ /g")
 	do
 		set -- $(echo $CHK | sed -e "s/:/ /g")
 		CGRP=$1
@@ -593,12 +593,12 @@ check_effective_cpus()
 
 #
 # Check cgroup states
-#  $1 - check string, format: <cgroup>:<state>[,<cgroup>:<state>]*
+#  $1 - check string, format: <cgroup>:<state>[|<cgroup>:<state>]*
 #
 check_cgroup_states()
 {
 	CHK_STR=$1
-	for CHK in $(echo $CHK_STR | sed -e "s/,/ /g")
+	for CHK in $(echo $CHK_STR | sed -e "s/|/ /g")
 	do
 		set -- $(echo $CHK | sed -e "s/:/ /g")
 		CGRP=$1
@@ -674,9 +674,9 @@ check_isolcpus()
 	then
 		EXPECT_VAL=
 		EXPECT_VAL2=
-	elif [[ $(expr $EXPECT_VAL : ".*,.*") > 0 ]]
+	elif [[ $(expr $EXPECT_VAL : ".*|.*") > 0 ]]
 	then
-		set -- $(echo $EXPECT_VAL | sed -e "s/,/ /g")
+		set -- $(echo $EXPECT_VAL | sed -e "s/|/ /g")
 		EXPECT_VAL=$1
 		EXPECT_VAL2=$2
 	else
-- 
2.48.1


