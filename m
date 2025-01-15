Return-Path: <linux-kselftest+bounces-24593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0A7A12A98
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 19:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5076165451
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1063E1D5AB8;
	Wed, 15 Jan 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="T+ifXIDj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026141D5AD3;
	Wed, 15 Jan 2025 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736964804; cv=none; b=hh9HgdrgWJCSy5eeGvP0TuOMgBSMa8Nk7E3xo5bJ8KmqVQS7wHfag5P8UViYakoWAxcOp3F4UrR/Dm1aa+5i4Cyzr6vr/ZL+MteBVYleFqUMju0kx8cPBqcd2KTc5PKWlOnSSsq+YbksIEX/WoP2FLT2q0Ox1PYG7AaMDBy5ozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736964804; c=relaxed/simple;
	bh=xiZTuScPICSHxiPZw6TpcBCR4iAOHgY5jeibxe1G/us=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=meARGq26Z/2A/C1ab5Nvm9Xu3sCkdNjSr6TjFT4cp2Mkc4PvIBcLbI5DMklqyKnOvZgL++Kx9CebvwOEZIGujuk1+GtSY0Lur1qq3+4e4IkPK+qL46GhZAzFt+DTrjwifsNIXqkfNXCK5svB/g7IKwWGzy4U9qn25zhnk4Aa+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=T+ifXIDj; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=657; q=dns/txt; s=iport;
  t=1736964802; x=1738174402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9yPlq0paGW1t21A5XZQoIo8EZ1mLH+6G71g63v/l46o=;
  b=T+ifXIDjY6Nd/5Kf6D149O2fAYzLcJ1caTrSrOxicqtif/T7zBScgRJh
   3kiW6L1jOfFhm3SzJovPDPO+5sajXfsHsuBH5TD+TiV/fjvUhhJhKEZXX
   mDx8nihqHnFp3UizuTB/UoV9JFqhqhl1AwRyai2W7xT+qACwuV3Hc8OGx
   A=;
X-CSE-ConnectionGUID: HswO6xuaQGChputcmr+9Dg==
X-CSE-MsgGUID: jesyjq9ZQqusJFRY37khQg==
X-IPAS-Result: =?us-ascii?q?A0AEAABs+Ydnj47/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBhBlDSIxyX6cOgSUDVg8BAQEPRAQBAYUHinUCJjQJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFSYYIhl02A?=
 =?us-ascii?q?UaBDDISgwGCZQOzeoIsgQHeM4FtgUgBhWqHX3CEdycbgUlEhH2BD4QBhXcEg?=
 =?us-ascii?q?jKBRYNunwRIgSEDWSwBVRMNCgsHBYE5OAMiCwsMCxQcFQIVHg8GEARtRDeCR?=
 =?us-ascii?q?mlJNwINAjWCHiRYgiuEXIRHhFOCR1SCR4IUeoEXhD1AAwsYDUgRLDcGDhsGP?=
 =?us-ascii?q?m4Hmzc8g3F7FKgvoQOEJYFjn2MaM6pTLodkkGoipCWEZoFnOoFbMxoIGxWDI?=
 =?us-ascii?q?lIZD446xDMlMjwCBwsBAQMJkXEBAQ?=
IronPort-Data: A9a23:raGLoqjRN2HiE/pNXipTk1UqX1615hAKZh0ujC45NGQN5FlHY01je
 htvCD2Oa/eNZ2PxKtwjbN+2pB8Hup+DyYcyQAtpqHhhESxjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSEULOZ82QsaD9Msvve8E8HUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqU44flQX3FT/
 MU3AzAVcwyIgvj1kZ60H7wEasQLdKEHPasFsX1miDWcBvE8TNWbHuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZg1/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9JoXWHZwKwRbIz
 o7A12b0GQAYLY2t8COY6VCCvN6UwiD7YY1HQdVU8dYx3QXMnTZMYPEMbnOgrfeRhEm7WtlfJ
 lJS/ydGhbcz8EimS9PVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZaaMEvtOc1SCYs2
 1vPmMnmbRRrsbuIWTee+62SoDeaJycYNykBaDUCQA9D5MPsyKk3jxTSXpNgC6OxgMH4Ai3Y3
 T+Htm49iq8VgMpN0L+0lXjBji6gq4bhUAE4/EPUU3ij4wc/Y5SqD7FE8nDB5vpGaYLcRV6bs
 T1cxo6V7fsFCteGkynlrPgx8K+Bx+2aF2PMnFdWMLIh7ymx8Hu5PtF872QrTKt2CfosdTjsa
 U7VnApe4p5PIXenBZObharvUKzGKoC+TrzYuuDoUzZYXnRmmOa6EMBSiay4gjyFfKsEyP1X1
 XKnnSCEVipy5UNPl2Xeegvl+eV3rh3SPEuKLXwB8zyp0KCFeFmeQqofPV2FY4gRtfzf/lWFr
 I8HbJHWln2ztdEShAGJqeb/ynhXfBAG6Wze8ZU/mhOre1A/QT99W5c9P5t+INI4wMy5adskD
 lnmBxcHkwCg7ZE2AQ6LcXtkIKj+RopyqGlzPConez6VN4sLP+6SAFMkX8JvJ9EPrbU7pdYtF
 qltU5vbWJxnFG+YkwnxmLGh9+SOgjz33lrWZ0JIoVEXI/ZdeuA+0oW+JFOzrXNfXnbfWAlXi
 +TI6z43iKErH2xKZPs6otr1p79tlRDxQN5PYnY=
IronPort-HdrOrdr: A9a23:nqvDp654H0d6fS9SJgPXwMPXdLJyesId70hD6qm+c3Nom6uj5q
 WTdZsgtCMc5Ax9ZJhCo6HjBED/exPhHPdOiOF7V4tKNzOJhILHFu1fBPPZsl7d8+mUzJ876U
 +mGJIObOHNMQ==
X-Talos-CUID: 9a23:lQpwrW6dkbjzjvk3uNss1FULPZ41b3Tk41zQO1KkAmNzC+y5RgrF
X-Talos-MUID: =?us-ascii?q?9a23=3Aw1C1JQ54CnCOAQGx6meCG41Kxoxq7r+/Cllco6w?=
 =?us-ascii?q?fptKmGxZBYGiejA24F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,207,1732579200"; 
   d="scan'208";a="414017788"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Jan 2025 18:13:14 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTP id C6A141800022E;
	Wed, 15 Jan 2025 18:13:14 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 9D8C320F2003; Wed, 15 Jan 2025 10:13:14 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: shuah@kernel.org,
	kuba@kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	John Daley <johndale@cisco.com>
Subject: [PATCH net-next 0/1] selftests: drv-net-hw: fix pp_alloc_fail test error
Date: Wed, 15 Jan 2025 10:13:11 -0800
Message-Id: <20250115181312.3544-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

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


