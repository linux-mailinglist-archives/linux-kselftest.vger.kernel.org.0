Return-Path: <linux-kselftest+bounces-22432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE49D5A13
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F0E1F23629
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 07:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A016F8EB;
	Fri, 22 Nov 2024 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ahsCNbN9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3841465A0;
	Fri, 22 Nov 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260989; cv=none; b=qGRAFe6esh17UMa/3rJAFeVC6LwZzc2AuNtlq4EFPPlacvutsjZzgnWvnQf+4kKIfbl/w67R9jfyG2m5FnZmcjORK0FB5DbE6OAVLHTt7z3lg3gLEKod/w4kXG25ZzW9m3PJBIN9zTYTghA1KZrpRROY0VFOprRwMXlrfypbxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260989; c=relaxed/simple;
	bh=afEEONp3WUMXgx5tCS+iTInKTEV3C339Fvgnza8HBtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrYWyvz2w0hrtK3XgWUR2k6g9BVLxJScYlZOn8HGcyoKnPhgaWkXiMeVeggu3d2ys5PmG7u13tYnubjQzMfKIxx7rxKOA+kvYrTmqYwf0yxAoXj07NHXMhoa8EUdv7qUnRmdiISVjcZF0Y+TG2/sykI61Bfrb+qwMhSkfbeZ8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ahsCNbN9; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732260987; x=1763796987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=afEEONp3WUMXgx5tCS+iTInKTEV3C339Fvgnza8HBtM=;
  b=ahsCNbN9YQX+XUcyX3m1+Ur2xAMArUBjgVLsr7TYmqE0+K844TddWSSm
   anwfrYN7oivQtL8TAWoWN3t8fBgZgv9ConpkfTl17NGHIAzfC2is0YTsF
   7PcCplCCFD1y7HgI2idUck5c16gIVYVkBspMlUeBCRHDCvmKH1rEkf6CZ
   BbK5Qs2oUxkqjiUADxxSCvDXtixdBaoTnproaEmBmbp9CTYwRQcjqgd5U
   eIz1TJDN1Zz71g0YuMfx/7HTt/0FKRdG3nf0dJF+Z6HFelIcHtv2YN1kq
   iyWO1L94Byy55ajoCFuiu6u9Y/z/SiX4f2Jjm8UG7sLg7Utg9CBwqunXM
   g==;
X-CSE-ConnectionGUID: /u7FMuAhQC+9fznjTiWJ8g==
X-CSE-MsgGUID: anH2+uNkRm2Od/tPChsOIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="160180652"
X-IronPort-AV: E=Sophos;i="6.12,175,1728918000"; 
   d="scan'208";a="160180652"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 16:35:15 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8EE23E428A;
	Fri, 22 Nov 2024 16:35:13 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 239C8370C6;
	Fri, 22 Nov 2024 16:35:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9C7152007C3F7;
	Fri, 22 Nov 2024 16:35:12 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id AA61C1A006C;
	Fri, 22 Nov 2024 15:35:11 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH for-next v3] selftests/alsa: Add a few missing gitignore files
Date: Fri, 22 Nov 2024 15:36:00 +0800
Message-ID: <20241122073600.1530791-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28812.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28812.003
X-TMASE-Result: 10--1.651200-10.000000
X-TMASE-MatchedRID: /+von0vPuFEhiKpapiFQUqoXHZz/dXlxTJDl9FKHbrnBsf5qt44jZ0/m
	RGqrA8qmt51G676eQJPtDFjbdjEntA8rYO92b9Nm4aN9Pi1E3hczNsXWBvGVBswHSQ+yXjTDfrL
	Hs4UTbxBQ2Im6/SeK+BFBD6+ejtliL/tBTZzO5Q12jSf4k8Vwmn0tCKdnhB58I/9UW5M5dRNp7q
	EhmmPgy46HM5rqDwqtwY6RPb/G8ENQfGCSa8nJAT5G2ItfuwCdDTuad3CT3vE5UQkLD/tqk6jTV
	fEW1WMaazCZYocv8d3ZJNuEPMGhCmDD1rcdOe5eFcG3+ZRETICP9kUX1Z+buE3LumkbQiNwVCqT
	SPu8tVR7AxIEOt4h2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Compiled binary files should be added to .gitignore

'git status' complains:
Untracked files:
(use "git add <file>..." to include in what will be committed)
     alsa/global-timer
     alsa/utimer-test

Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: linux-sound@vger.kernel.org
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V3:
  sorted the ignore files
V2:
   split as a separate patch from a small one [0]
   [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/alsa/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/alsa/.gitignore b/tools/testing/selftests/alsa/.gitignore
index 12dc3fcd3456..3dd8e1176b89 100644
--- a/tools/testing/selftests/alsa/.gitignore
+++ b/tools/testing/selftests/alsa/.gitignore
@@ -1,3 +1,5 @@
+global-timer
 mixer-test
 pcm-test
 test-pcmtest-driver
+utimer-test
-- 
2.44.0


