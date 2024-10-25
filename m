Return-Path: <linux-kselftest+bounces-20595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D89AF6F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54ED61F22C24
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA0D83CDA;
	Fri, 25 Oct 2024 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ZYTIaxIg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA6126F1E;
	Fri, 25 Oct 2024 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820387; cv=none; b=np8WyGUqr+7e9Dz4uC3Zt/yD2Cp3IltYzoj5UJI/uy8oqDbXFdejYDvjN07ZjdD4lRRBtT6WYKNmm4YI8sXSTqeCV6YQULhO8QR+eXuirHLlrv3ySRHEn90YBHH/iSAnjfFWsVJNtoJ/pWa8oOB72TeO/ZTMyACsA2iIp0qIfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820387; c=relaxed/simple;
	bh=clBOSjedp2N1ph2FzLIRMDS9aed5xZ5ns0BqIhi+dhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQfDYozNhQjAy9GRjwXU45cT1VnANKiXGzuWhtoPk1JbRRPJcFZgt4g/CZgrcpmva+jLgE20c0O8M+ebTBXv3jfnzzVFuJLR2T7Sp/Svx/N9n6ZI7+dClb5dhINqfCckKkdaKCIJkrWa3uzkFeYRIOF2IHskukNlbBSyDK0SSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ZYTIaxIg; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820386; x=1761356386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=clBOSjedp2N1ph2FzLIRMDS9aed5xZ5ns0BqIhi+dhk=;
  b=ZYTIaxIgtW+3p9IjQlpNmK/n6RBAHomg/j+uUC7iqdAbLxBjTr80y2nE
   ebcyJ943vufKEgcB4pJmmbMcuBGKxRcWsUc6yxNfE7xVJeyRQ6/cJK8VT
   AYIEb67bKz+aYA3JKBP0SjB/YJ4MrjEesQbDV9XuKoewAagJoj9Uex2cn
   ANIB08aDGifTTVNWo1SU5gK5Oi30Yf0umu0yypcjR0dU8+cXi0NfP/w4y
   ytpNYXzGqozLpwc1ILv5JqrrbCP6fYvBJuPAjA+9IOztvso7GoU8PzBqy
   ADskf+7RHeDKSoTKgp61G3uqtBX6EQj5ImGMGWksx+MMPJcN7vk5tpYu8
   g==;
X-CSE-ConnectionGUID: 4HMJosXCTX623enSUGqaag==
X-CSE-MsgGUID: VPy8KG02STSzXq8jhSveAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="177903124"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="177903124"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:39:37 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id B7C8DD9231;
	Fri, 25 Oct 2024 10:39:34 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 04893D4BCF;
	Fri, 25 Oct 2024 10:39:34 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8BF822007955B;
	Fri, 25 Oct 2024 10:39:33 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B3AF11A01E9;
	Fri, 25 Oct 2024 09:39:32 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH for-next 3/7] selftests/mm: Add a few missing gitignore files
Date: Fri, 25 Oct 2024 09:40:06 +0800
Message-ID: <20241025014010.6533-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241025014010.6533-1-lizhijian@fujitsu.com>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28752.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28752.003
X-TMASE-Result: 10--3.030200-10.000000
X-TMASE-MatchedRID: 4r2MyAYFTnchiKpapiFQUqoXHZz/dXlxTJDl9FKHbrk/gf7afIrQU36y
	x7OFE28QV89FgO/U4vBeAZpJlX3ct6Mqw1MrQ3Xs0e7jfBjhB8cZiTLIQu4YpBHfiujuTbedvwU
	evDt+uW5fZPFUbFYJwYfC35p6xeSXkfRhdidsajMURSScn+QSXpjDMT0TyDk5+gtHj7OwNO2i5u
	/VvsFaHSd2vyUnDz4JkO2UjekG25xI53UIApNFK5GQ2iAz3Ucg4Zhpm6HhbMcR6GmhRmVDqk8Cx
	IyKDhMjukwxcQ4oWwYB7pNEs+ty6oaT7FRqp0wPAcQrAfBh69vBRLFeH6OJSCTDD+DBjuEw
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Compiled binary files should be added to .gitignore
'git status' complains:
   Untracked files:
   (use "git add <file>..." to include in what will be committed)
         mm/hugetlb_dio
         mm/pkey_sighandler_tests_32
         mm/pkey_sighandler_tests_64

Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: linux-mm@kvack.org
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V2:
  split as seperate patch from a small one [0]
  [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/mm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index da030b43e43b..2ac11b7fcb26 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -51,3 +51,5 @@ hugetlb_madv_vs_map
 mseal_test
 seal_elf
 droppable
+hugetlb_dio
+pkey_sighandler_tests*
-- 
2.44.0


