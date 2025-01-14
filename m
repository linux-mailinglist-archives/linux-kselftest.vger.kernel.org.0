Return-Path: <linux-kselftest+bounces-24529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 071A4A1141D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3E0164413
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B75E212B13;
	Tue, 14 Jan 2025 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cOcABCP5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039723245F;
	Tue, 14 Jan 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893930; cv=none; b=K9haW1sJQva7XsDaEGml5g9PGr25Lmk0nmszBF253aDRRDyOGZrbeefIzb8g8+S/WJ1p08UAkLrBvYPaCXnmn/Yo1J6XptULKuyrGmgYfPnkYbI802rZCbY+zckSt9BxHGoqCEMOmJZ0rqt9yl1dgeHLVY0crOZ192DHJKi9+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893930; c=relaxed/simple;
	bh=xiZTuScPICSHxiPZw6TpcBCR4iAOHgY5jeibxe1G/us=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EoxmPM0IeZy0KSmBDP5vL5DC6mJj7fmGKEi6b264GuM+mJA7OLBj4MnfAaqgRzFp3GBbLwlK9zVBOPAA4XzkBkSqtrfOZZ8M/tvJdzUNwfo/154o2fUExKzTnJpQe2m9hxdbFOGGiyRPFYQ0rnhG8zBOrnkNdN96vj9ZoSWLXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=cOcABCP5; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=657; q=dns/txt; s=iport;
  t=1736893928; x=1738103528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9yPlq0paGW1t21A5XZQoIo8EZ1mLH+6G71g63v/l46o=;
  b=cOcABCP5I+Mr885Gzd9BmaSA/9id6hwaPlkeFcSnFw+7gKbajLqNt1wU
   ZtVmIdpmbYIxCw83XZ2JcDd2XXXoMVGy1AntEHMOWCBT+Jb+BClW2h9Mq
   6UmoW8JXo+lcTGYEg1tIUGRQES65NS/YYBGF4ksjJvxIMnBVy/Peec5J6
   I=;
X-CSE-ConnectionGUID: FvHrCofxTauZMd91Xnkk6A==
X-CSE-MsgGUID: ZuAX36gqSza1rx1Idb5fUQ==
X-IPAS-Result: =?us-ascii?q?A0AEAADq5IZnj5L/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBhBlDSIxyX6cNgSUDVg8BAQEPRAQBAYUHinYCJjQJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFSYYIhl02A?=
 =?us-ascii?q?UaBDDISgwGCZQOzMoIsgQHeM4FtgUgBhWqHX3CEdycbgUlEhH2BD4QBhXcEg?=
 =?us-ascii?q?jSBRYNunnlIgSEDWSwBVRMNCgsHBYE6OgMiCwsMCxQcFQIVHhAGEARtRDeCR?=
 =?us-ascii?q?mlJNwINAjWCHiRYgiuEXIRHhFWCR1SCR4IUeoEXhDdAAwsYDUgRLDcGDhsGP?=
 =?us-ascii?q?m4Hmzs8g3J7FKgvoQOEJYFjn2MaM6pTLodkkGoipCWEZoFnOoFbMxoIGxWDI?=
 =?us-ascii?q?lIZD446w0olMjwCBwsBAQMJkVMBAQ?=
IronPort-Data: A9a23:IpqR3alVTK3UUDY3qYe0Ph/o5gxvJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIeWWDXOfnfMTb8eY1/a97n8UkCvMCEn941TAc6pSFjRltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pe31GONgWYubzpNsv7b83uDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FaMG2vxcBm9ey
 fUFGhUBP0mzgeG1npvuH4GAhux7RCXqFJkUtnclyXTSCuwrBMiSBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZD/7C7pm9Ausrnv4cztUoVaYjaE2+GPUigd21dABNfKJI4baGpUKxBnwS
 mTuzXnQMkpEO8Wk2zPc6GL1p+PFwC3GYddHfFG/3qU32ALInDN75ActfUC3r9G3jUu/UNJSN
 QoR90IGsqk28EGuRPHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZiVBddUmnMw7Xzon0
 hmOhdyBLThutqCFDHGQ7LGZqRusNiUPa2wPfykJSU0C+daLiIUyiA/fC9V4Haq7ktDuBRnuz
 D2Q6isznbMeiYgMzarTwLzcqyinqp6MSks+4R/aGzr0qAh4f4WiIYev7DA38MqsMq63UHmbl
 38Ki/SX8dIrAcDUpCqOQ7skSeTBC+m+DBXQhltmHp8E/jur+mK+cY043N2YDBkyWirjUWGyC
 HI/qT9sCIlv0GxGhJKbgr5d6ex3kcAM9vy8Cpg4i+aihLAqKmdrGwk1OiatM5jFyhRErE3GE
 c7znTyQJXgbE7976zG9Wv0Q17QmrghnmjiNFc6mkU35juvHDJJwdVvjGAXWBgzexP7VyDg5D
 /4FbqNmNj0GCrSnPHWHmWLtBQ9RcyVkbXwJlyCnXrXeelU9Qj5J5w75yrI6cIsthLVOiurN5
 Tm8XEQeoGcTdlWZQThmnktLMeu1Nb4m9CpTFXV1bT6AhSN5Ca7xt/h3SnfCVeV8nACV5aIvF
 6FdEyhBa9wTIgn6F8M1McOg89E6Lkjz1Wpj/UONOVACQnKpfCSRkveMQ+cl3HBm4vaf3Sfmn
 4Cd6w==
IronPort-HdrOrdr: A9a23:MlMdiqEY8v93IWVDpLqE48eALOsnbusQ8zAXPo5KJiC9Ffbo8v
 xG88576faZslsssRIb6LK90de7IU80nKQdieJ6AV7IZmfbUQWTQL2KlbGSoAEJ30bFh4lgPW
 AKSdkbNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3Aq0nqhWo8bawuG97V14FSeQbmUe47Umf2y3nAH0a?=
 =?us-ascii?q?lO0NlGeSlT1yTpooxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AH/MmKQ3ud5j6tfBDpuq5B5sYmzUj0bmHOBtTnow?=
 =?us-ascii?q?9qcDdLzwpGjuX0TqKe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,315,1728950400"; 
   d="scan'208";a="412878727"
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Jan 2025 22:32:02 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTP id 4739718000233;
	Tue, 14 Jan 2025 22:32:02 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 1DB5420F2003; Tue, 14 Jan 2025 14:32:02 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: shuah@kernel.org,
	kuba@kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: John Daley <johndale@cisco.com>
Subject: [PATCH net-next 0/1] selftests: drv-net-hw: fix pp_alloc_fail test error
Date: Tue, 14 Jan 2025 14:31:58 -0800
Message-Id: <20250114223159.29677-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com

The tool pp_alloc_fail.py tested error recovery by injecting errors
into page_pool_alloc_pages(). Perhaps due to the netmems conversion,
page_pool_put_full_page() does not end up calling that function.

page_pool_alloc_netmems() seems to be the base function for all the
the allocation functions in the API call, so put the error injection
there instead.

Signed-off-by: John Daley <johndale@cisco.com>

John Daley (1):
  page_pool: inject pp_alloc_fail errors in the right place

 net/core/page_pool.c                                    | 2 +-
 tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.44.0


