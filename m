Return-Path: <linux-kselftest+bounces-20598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A49AF703
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B141F22CB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07CC60B8A;
	Fri, 25 Oct 2024 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IkdWrafR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95154879B;
	Fri, 25 Oct 2024 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820450; cv=none; b=M96x5+28/onGGCy33A2eBI2ahPug9ce+A0lo2wxwTHrWYk4MwI6J6QsOV/M6oJYIa2yeqKysZ56B5HIPoPzc2xRYkK65R//gL2JMNEO/P0mdSctx0QNAR6CNvFmXgkEI5AeR9amDTHxXVZHO6b/SdhCt+1mmlWTzmlPMrojM6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820450; c=relaxed/simple;
	bh=s8VhV7YOekzg0qBmxC5N32OUoYZeoSaXeWcxaVdUzU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=es07vXm92qY75sfNffhJb7G+Q+671efsIZvKSa4PgSVfdx4JtJZqyBPFwno9YLcqheUhnh0ZN80Fi1JMurR41kmNbCycm+/ALf6vd+Ucn/Yx13vd5v934wF39BGlA5QAWwRrU9xqoKWoXOwrV5ll4KeXcpurh7eeJ0RSG2FAAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IkdWrafR; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820448; x=1761356448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s8VhV7YOekzg0qBmxC5N32OUoYZeoSaXeWcxaVdUzU4=;
  b=IkdWrafRftwK3gA39aZiMh20YqFiS1rp7B+H+Xht9PtSckEFtCavsSZ4
   zaz6wVQ8GG5QMEabXUaliV6pEMXIlumAKBOt/rbZVwFXOpcfRM9ginLII
   hzQvSj8TnBLrO3g78E8lRCKshfqOw+Fgo5ETX9z5hUBwWnXMg6WX/5SMZ
   RtLztncIAT2hnqtVKjczQzC8zqRxI07ke0HSAT1F9Ad6zH1KgDk4eBTYi
   +3gnkdlU22A7itBHDGseZT4CQqDq9JUvOJTCR5wOQs8xhUR1nwa/gAalA
   Z8ufNfyvV1bIOKg0i+sq6EbbX99Os2PNy02rfCa9gLOoPtaI4Z+t/fmRN
   g==;
X-CSE-ConnectionGUID: 9PYzxuvnS02zEur0U08f6A==
X-CSE-MsgGUID: SrApEPCjTGyGSMST7X6mMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="156807491"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="156807491"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:39:35 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C0286C9CB;
	Fri, 25 Oct 2024 10:39:33 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id AD930103E2;
	Fri, 25 Oct 2024 10:39:32 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2E79170BC6;
	Fri, 25 Oct 2024 10:39:32 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5F98E1A01E9;
	Fri, 25 Oct 2024 09:39:31 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH for-next 1/7] selftests/alsa: Add a few missing gitignore files
Date: Fri, 25 Oct 2024 09:40:04 +0800
Message-ID: <20241025014010.6533-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
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
X-TMASE-Result: 10--3.123200-10.000000
X-TMASE-MatchedRID: 54gb2yeIOXQhiKpapiFQUqoXHZz/dXlxTJDl9FKHbrnBsf5qt44jZ0/m
	RGqrA8qmt51G676eQJPtDFjbdjEntA8rYO92b9Nm4aN9Pi1E3hczNsXWBvGVBswHSQ+yXjTDr7f
	LNf2RfSt3yadK9iyoPuaffHI8kAminajGxrJsU4OeAiCmPx4NwGmRqNBHmBveafSbrzwSjfwqtq
	5d3cxkNZdacNh8njm7zp+PP9TR1iEPsxq987sSn0i++CMiQi/k9qPpshOt6bu5Li8SIkl1u73HO
	iflqur/Dn6CZ0LqGmt/1G6b11sj9O4zq2MCCj3QFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
	HkAZ8Is=
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
V2:
   split as a separate patch from a small one [0]
   [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/alsa/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/alsa/.gitignore b/tools/testing/selftests/alsa/.gitignore
index 12dc3fcd3456..1407fd24a97b 100644
--- a/tools/testing/selftests/alsa/.gitignore
+++ b/tools/testing/selftests/alsa/.gitignore
@@ -1,3 +1,5 @@
 mixer-test
 pcm-test
 test-pcmtest-driver
+global-timer
+utimer-test
-- 
2.44.0


