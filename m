Return-Path: <linux-kselftest+bounces-23128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9643B9EC113
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF141684C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 00:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF852C859;
	Wed, 11 Dec 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="g+JHbUfV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4213B298;
	Wed, 11 Dec 2024 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878211; cv=none; b=W3HtNgq83i+DSI7hj2YgIH3mCa0yNixIUFAH8zYUPlitrTqg0aCcXmEKeekQrIn9O1kr/b1UlfACtTnVPLBIK1dBI+xUqBkZScbU5zJfIrwCgiqsm2aAU0ws8KY7A0IjDhdNc6JraDGCc+lM83cNRTd3lb8JoVIawCeEAgc4DGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878211; c=relaxed/simple;
	bh=ghhs5xA1Fa3pPHDXNNtTlp/dBKjJMwQjvIL9hdQ1ffI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0Jk9vTx2HopWumZE3vApGr7XL9Psqa2Px2F4ZKPiMlU6rXa+UP/NUiApZ5YAta+IpFDxGN9LVD2i8M6MWlfceDc8miws88tAVYoyMaHDrG0lmw+1Y1BbgwW23WtVMLtHCr6BS9J+gnbb2EcuKNmoSkaMsVEuKf1KF08/5hZ0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=g+JHbUfV; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1733878209; x=1765414209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ghhs5xA1Fa3pPHDXNNtTlp/dBKjJMwQjvIL9hdQ1ffI=;
  b=g+JHbUfVB29hr7SIL3+9T41tTo+nLryWErHX0ue6lSJI5sOsNcNQASN3
   WAaXX5Mxp8GmoYf1P21rIRntd9ffDE0Xa520T5xlWu+orjnfpe1eJfslN
   ASM9AetzEXMpEF8Cls+A6wflJ+rjCcglsCFysxClCb/taESzboahJvAb7
   IgKYZij1IjcGt4F0B6b8tlNECrvt8ivH+yyPuhWnCREnCmKk3yq+cKdbL
   d1wIdCX6eiG7cBC/g6t3EtapxYHvBA2uVx5xq4cMumOiJ8xflyYwieWiT
   EMtnw6f5i5W+SebdiXMXR7EJLmKF3ziIePCujj8rU5tgSAyziMy7GB3MZ
   Q==;
X-CSE-ConnectionGUID: 9nsedIbASUOtNxTGGM2ibQ==
X-CSE-MsgGUID: ozwZ0GneQpyBCPNmoSgLzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="171641779"
X-IronPort-AV: E=Sophos;i="6.12,224,1728918000"; 
   d="scan'208";a="171641779"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:48:57 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id BBDCBD4807;
	Wed, 11 Dec 2024 09:48:55 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 92056D8C1A;
	Wed, 11 Dec 2024 09:48:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 17DAF20076D12;
	Wed, 11 Dec 2024 09:48:55 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 224781A000B;
	Wed, 11 Dec 2024 08:48:54 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4] selftests/filesystems: Add missing gitignore file
Date: Wed, 11 Dec 2024 08:49:47 +0800
Message-ID: <20241211004947.5806-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28852.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28852.000
X-TMASE-Result: 10--3.571200-10.000000
X-TMASE-MatchedRID: 4RK2gbhxGJMhiKpapiFQUqoXHZz/dXlxTJDl9FKHbrmwcSh5kytY+TxT
	JjE+nPo2V89FgO/U4vBeAZpJlX3ct6Mqw1MrQ3Xs0e7jfBjhB8eBs03RHrzjM4wnGKAoIKJLW1R
	FmDf+CHZm/TV+xMiFvnyS9/LtVbTu0ekSi+00U24ReM8i8p3vgJZBsmDtT9d+Blnw3dG9MzGjxY
	yRBa/qJXcsDK2xBHh7jaPj0W1qn0TGVuWouVipcm1koHiLZxDUhTo2ItDi31L4xTfXImSJmvAwL
	cI/WvZ4EsX05tfjwUkvdVnosF2yzdaqR5eN97rjaAOZJaaxgYf2p5/VvLxEtxFltGxCTkwFQHVA
	+r1vGdZmQDEDCMiuswfP8fSSIvISoYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Compiled binary files should be added to .gitignore

'git status' complains:
Untracked files:
(use "git add <file>..." to include in what will be committed)
     filesystems/statmount/statmount_test_ns

Cc: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V4:
  Collect Reviewed-by and Tested-by from Charlie, many thanks
  Remove the duplicate Signed-off-by # Shuah

V3:
  sorted the ignored files
V2:
   split as a separate patch from a small one [0]
   [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/filesystems/statmount/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
index 82a4846cbc4b..973363ad66a2 100644
--- a/tools/testing/selftests/filesystems/statmount/.gitignore
+++ b/tools/testing/selftests/filesystems/statmount/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+statmount_test_ns
 /*_test
-- 
2.44.0


