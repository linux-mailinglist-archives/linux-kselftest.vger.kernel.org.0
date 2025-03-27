Return-Path: <linux-kselftest+bounces-29859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D29A72C69
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 10:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5187A35C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B320CCCD;
	Thu, 27 Mar 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H7GRTfAh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010002.outbound.protection.outlook.com [52.101.128.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144651F4E2F;
	Thu, 27 Mar 2025 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067821; cv=fail; b=PdLlx15Nns5kv1BCkBPajq5tgdkm18A8di2fSui8fRLjpjHt78nbZP0mlWK3O9w880gQYl+xiMCs/LubMAQ/s5eoKZ1n4d8iEadXqBC7ZuLxFrwf8uQaGwskB/zh7wiX5NonytG3zBKsfUQXjcK5WoogI6Oaa7a4xtXgpdy5sBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067821; c=relaxed/simple;
	bh=347JoBd/7VxCzFiUbzfV+4cwiG8MH8gI2dWPsB0CwU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jar/4WPc0GuTv6hMDgMVdfDQ7EXysQ3/6fmGgALsTxI0B5N/2TJtmxHzS2OuiaesSTh2rGOtv0N3MoW1l2uZdRf0JJ7gjDdMxvZRFLTUcHrI2Ah/UuYJfrjccf3oCGqS2/nxYb4no5cvXqXwdTjde7r/BvyIyqOIfL3HRXqzEwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H7GRTfAh; arc=fail smtp.client-ip=52.101.128.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G68/51E/vaHGFp/wbqaBgTWX0w6UEi3mjFogDuPXkueaTFFcvDTKMniMtelKt+XohGbUj36R9uwhcXNHavsiTUj6i+O4j708vNkyCP0L17SnKtUyPkhN2+Vv8aP7OXHUH87xW1W7RqwCQAilIGqGwVgurI0rJmIS7RE+W0mwC9+5JOeSz3K3xKAInbx5ESgLP95siQPmLOhujJ6T1IDRlea8R4dNm/igNNi+q7bw5yrKm4CnTLawfeP7NkL1EfRVMyWQZ8JqQQaavknL4bTvvdYM/tgBixrdY+eFdbeJk17/iEiCPhWW/1ZxfRfGUfCkLF5Ur1FndRaEd7EP54WQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT71xohYSOfDbaretzmMt14K4aabUdBqwW0eBh5Wctc=;
 b=LclFsfhkF2erylDf5kvys1zvhVVBv2GrUoyHfibADFU1Mt2i2wMEr+R/MQTK3Bmz4kAYhLyDh2l8cySkgeKq25Gzen98OoyXLRbLAazKLCyTXZE7sx1iEwLAAr3hOJqdkz0/idE2v0yArOM2HnzuJaEYE7SPq0oLKSKpT3fB1++Pshpoi15JWMynjXR45NIV9qnXnKQ1nJoLBTa4IhPvdCleNABx7DpnB1iJ19TgzvRTjY+hUoZwqktwJ6hLleZMVKXlnGjpIPewIUmWHHNXqPE+qKxO1ZtbervY975MtTITg7vZ4IZ/idXNKjNyBk87eKbIcq5UO5HdOC1jcnqEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT71xohYSOfDbaretzmMt14K4aabUdBqwW0eBh5Wctc=;
 b=H7GRTfAhkD2KcVheHzz8K3Coh9ANsZGjJtxRfwo8wSpDofoMcruwQcp7Kfncl67UqzJ3DmN3KNdjp2QM/5tLUWDbM+Lb6VytB2CJ1MU8HAzpqtUPXhTI7YA6vuQmKcJ6JauT7ED10wdBbf3FDhHFowlazN3iOoVxX3yh5lT865Q4OGjg+rysOUrSEddmIouWtc3f/lmP4moUoOcAGZ1k/ybMPqy95fFUA3gQ+vVR7fRc0FJl1k3zWjDEwEO8Eas30CenCyiTdJaxRIGol9jrnnXtawbZLt70G+/TbAYNAhpp9hkTxg5KLmVg65YtVSLWs6y4GldxKvDXDGYZs4vflw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB7238.apcprd06.prod.outlook.com (2603:1096:101:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:30:15 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:30:15 +0000
From: Huan Yang <link@vivo.com>
To: bingbu.cao@linux.intel.com,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [RFC PATCH 3/6] mm/vmalloc: try add vmap folios range
Date: Thu, 27 Mar 2025 17:28:30 +0800
Message-ID: <20250327092922.536-4-link@vivo.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327092922.536-1-link@vivo.com>
References: <20250327092922.536-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:404:a6::29) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb4f76d-92eb-4778-182f-08dd6d11fb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LfzcX+Di7nOz0LQXXh9hW4lC4Sfb/U5lBcyKq1O0dvejMsrEzyvBPfkl4Ygl?=
 =?us-ascii?Q?13lQweWtsbjhnCLrb2KpImTF+DgvqugdvTuE2JF68SltMkFXJ/jFb1QuP8Fc?=
 =?us-ascii?Q?yw6Or6B0J7WgYOi8S/s6haC+YaF5ZFj3XR+sXctVIVehMotEnS4KdlDNptow?=
 =?us-ascii?Q?aYj4EcurlzR1e8FD8PgnyfWofOGnohg5JfzrZhFl7YSzO1Qnl7By72T8E3hy?=
 =?us-ascii?Q?iVD71T8GL3RrjWgC9MAD/OeMcu4QzJ55IA66G9nKRBiM7H/50YQcXvBKeOmL?=
 =?us-ascii?Q?3NLz2Wg2hQXIeASgMLCCuNMrc5bi1bSKAF38QmXu1hfU+pOa/mcqt6FDYC8e?=
 =?us-ascii?Q?o/rvIWeGvHwjXNuRHDQ91K637VxtWwrrv4qM82aqPwjiilwHPPM+M2vy/mg0?=
 =?us-ascii?Q?Q9ph6MKYHIyzQFp+ofsnq69KUUz/a9OPDmBUaUL8XAx1yqmqbwkjUURic2ZO?=
 =?us-ascii?Q?/q41EPILmF9n1W7KuauQd0+T7Qegf3ObmTmkVAK6+7mxP1v7wiITjFI8KVzS?=
 =?us-ascii?Q?PDCjoQcFUaghksUigKvUiPgmHimXnZGTmdbPeCD8KdFBCyIpdCRLMCTSb5D6?=
 =?us-ascii?Q?XmkPsFG1EadWxORBw9rOy7f8RahR8DEJB1g7prTJq6nQ2O2y0Ns+Cn6RkBkT?=
 =?us-ascii?Q?r88v759hwcA+px9qWXkSZGBietQ2ewaMswdohvBLmik+9FHs9+91bL4DEuZE?=
 =?us-ascii?Q?jpmvDvFsLpIYWTsUMYiWVf/KUM3bwOPp5zMsfbeygmvG+vmS69LMNdf2hnXT?=
 =?us-ascii?Q?MPUof7RSoQP2q90/dDr3qzmGteqXMSwYOCx6PtlEbf4nvaBK1n/hrwZCOL4i?=
 =?us-ascii?Q?+O6qR4lYqxdTvR2IrLxYGcpJvRmG7nmsHUubHFGV2nZXIBfh8Um7eVHFYHKu?=
 =?us-ascii?Q?tMWDaDyVkpEHW0PB81Rw5KQGvLBiyYR3EOfPRzrmIu0EXii7Q/E2nNFjNLIo?=
 =?us-ascii?Q?B5D44IMaPVEd/Ss1T0D3nYvdzM6FrS8c3Xh+ZeRgbeVbv/eSRwQ9uofcGSJy?=
 =?us-ascii?Q?bKH4KtGE7BcncofDuT+/AwvlcQzzFE8Jk07v42IkwVraz+elG6qpc2ZN0Bx0?=
 =?us-ascii?Q?HVUx4icGTsrn8KRgKH7Gmu7u9RS1eQrB65kuXZhZGXuwDkk0qBQ4Tl4X15FD?=
 =?us-ascii?Q?MZ71VHLEm7JQUXN/PWJEbWuQ30YmU4oz7ag+c7T1W7gyfgUnCAh+jnUK5DNs?=
 =?us-ascii?Q?EYOLqUchh6VKrA3Ael7tNs8CPCWpkI3YNVmH430WBwuNdbkI0efA9TI59/0l?=
 =?us-ascii?Q?k7ROll6QonBQEcr5ENguFl5lx3ggke9cNtFUG5cnA4VNeYRDWM6TTFwCoCTi?=
 =?us-ascii?Q?gGuPxQgecE3BjbPQ/f7CFhupykU7BhBvs9PREF6zb8ROLfM2WHaSifc54kR4?=
 =?us-ascii?Q?1I5f8XmF3xhrXocZg5oRGlW0xwHbcOQCOSxsvgSQkuGjfA/3etO249aH84QQ?=
 =?us-ascii?Q?VcbitlfHB/OtGkjb1PDarPv6ynPt53M8oRnZIUOdAZYh7qj60N2KTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ORpY3z0dhgDA1kXtEMNGjJ1QOEhh6TRqmoNtz4Lx7RRIjN4x0dpnl6S3iOuK?=
 =?us-ascii?Q?+AFhZVlLPzvIQLs8v0fMmATpXhnS+eGrXCgchbnhWsThq3q6jTeXthwrDBW4?=
 =?us-ascii?Q?EZ4HLuU7SeGetzcW+0d5DRqjBmdwt+072agY+gW2bYuZ3+ISEJCSgoFKB7k9?=
 =?us-ascii?Q?hYrv93CLNyBRq0rJyVmsEa/XvTGe5A6xOAqPv+UayRyj7JiPfVrt6MmWX1kZ?=
 =?us-ascii?Q?10s9CkVeTgxxwfZGV8vuO+ivAjww8dtEdUfOLaXuPAb2a+EbJ8FlYCa+p6hb?=
 =?us-ascii?Q?fONfFXc87UIrMU2Qz2V2EDql6ZfAD3nvCYa8bZfSliTdCcwTBRQ4ibs9qAIJ?=
 =?us-ascii?Q?jo6cPtyCB5l0BoGeL0GTpufpO2WxBUqGPepYfpEvO9e7wG16UlJoNv2FRgvc?=
 =?us-ascii?Q?Jq0/ZC9xkhwky8h0kNTdMIO/0AX9ruktp7MJ7SvZ7o+fW4kXb/615gvknbcv?=
 =?us-ascii?Q?E7T3iNMBSS80lab3TIisFsHcKyLVah7V8v8F0/o71jxJ2Uu6blHZKiqVs2k2?=
 =?us-ascii?Q?0N3UNgTHOoEZhFCroe/K/sZ1E7MZsN41E4L/y7BjhSuUz/BzNbxZMSX05sH7?=
 =?us-ascii?Q?JYyghCXy3rqBbcJLEimw9VMNTfuZjwtE95JIgj21GXzyMSlCnHCNZW0RDXxA?=
 =?us-ascii?Q?d2ygzOdOc5KfShb7NOVK3OphpydOm+MKU2FeVoGrrw09cual5ZkeeLCJd84/?=
 =?us-ascii?Q?W5aJUSOpYLR70YK3j6yJtRKOtu4+idY5nJ5f5UxuO9lz73ensjuPksQGlBYy?=
 =?us-ascii?Q?QSAW4clqlNlRoTWNKsbnuHQqvHvssWpmST6sSuJ40RA4q+EKpHDiYHoJW6jC?=
 =?us-ascii?Q?5RIWzYjJNb12R5aGNy0y8DTzBJ+F7Uuadqizjeo75G2wB4Bt75VqoTWat5d5?=
 =?us-ascii?Q?fei57mcp+2T2xwU0bzfcyAr6p9w7ZOlFFIIZ2FX0w2UGHC6kCd4DNDwOp6E0?=
 =?us-ascii?Q?EhTD53L/3+784ru0x0JcJy1CgtZKyUlllaTP/l6VqzxW50nUJS6xaxIjAUlw?=
 =?us-ascii?Q?7xu0HCMl9TRWBVzPN19DEV5yxwPeTPu93DNgtqhknpcEAX0ZjjpqtF3Za4gl?=
 =?us-ascii?Q?Wn5vyt0v8fYWIGyyX0eN2/ZFs+UM4HrtcFgD36N81w2vC2tOx1aE/hkiSpdY?=
 =?us-ascii?Q?4HfhsX31jcxnK9oVpqSseGvvImdodqRK8XZip6VrulAVzyLGo1Yu5D4XfWCL?=
 =?us-ascii?Q?rG+9DSjBUX9vpJmBqgL9ZNPdpFw3X1X65gjFcfpnjHg6ItmssR8hhbus1nPp?=
 =?us-ascii?Q?RtxQ9ZMfV4/6QNAQpNAAhGBq+F4lQvTX0N7kOcOOOvoIsM65Ax1Znep6CoYL?=
 =?us-ascii?Q?qHqF5oeJ0d/bZdieSPG/YJpUVSNm9C3TyTN88Lv2URGyefiu34WIKYYORdiI?=
 =?us-ascii?Q?NT9GUtPpFtgdSRHH6iKl0LVzCRcZvXGANHaHq351j2HTtDIyB9la4eU2x0Hw?=
 =?us-ascii?Q?OOGj+ivEjuhhQ9nPWrjTKiZQv4R3eLi8aJ+Q5rZL2tZElJS7fXmuI7o6Id5q?=
 =?us-ascii?Q?3/mRufqFjbA6PATTaN/ldztTO8U6Xgv39WWvF0KSFjLmC3CtGjtlCbI92+En?=
 =?us-ascii?Q?h6+0PElmVw586tR/muKdqupsN8M8Dofyb7r+nZZl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb4f76d-92eb-4778-182f-08dd6d11fb2f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:30:15.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiAh7VJGkHN/rpKIFmHy2sEVCBBpdgh1t/HQLPmnrI2cX41GmOMpA6Dat9Q+srYTOHzwjiFFnJnIOAmwkWDdiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7238

This patch add a new api vmap_range_folios.

It support both entire folio array and range based
folio array.

By this, some situation can support, like HVO folio range vmap.
Also can reduce array size, compare to 4k based page array, only need to
record each folio and it's range(offset, nr_pages).

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/vmalloc.h | 57 +++++++++++++++++++++++++++++++++++++++++
 mm/vmalloc.c            | 47 +++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd936e3..007a398152af 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -11,6 +11,7 @@
 #include <asm/page.h>		/* pgprot_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
+#include <linux/mm.h>
 
 #include <asm/vmalloc.h>
 
@@ -83,6 +84,24 @@ struct vmap_area {
 	unsigned long flags; /* mark type of vm_map_ram area */
 };
 
+/**
+ * folio range [pgoff, pgoff + nr_pages) in [0, folio_nr_pages)
+ */
+struct vmap_folios_range {
+	struct folio *folio;
+
+	pgoff_t pgoff;
+	unsigned int nr_pages;
+};
+
+struct vmap_folios_struct {
+	union {
+		struct folio **_folios;
+		struct vmap_folios_range *_range_folios;
+	};
+	bool range;
+};
+
 /* archs that select HAVE_ARCH_HUGE_VMAP should override one or more of these */
 #ifndef arch_vmap_p4d_supported
 static inline bool arch_vmap_p4d_supported(pgprot_t prot)
@@ -195,6 +214,44 @@ extern void *vmap(struct page **pages, unsigned int count,
 void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot);
 extern void vunmap(const void *addr);
 
+extern void *__vmap_range_folios(struct vmap_folios_struct *folios,
+				 unsigned int count, unsigned int size,
+				 unsigned long flags, pgprot_t prot);
+
+static inline void *vmap_range_folios(struct vmap_folios_struct *folios,
+				      unsigned int count, unsigned long flags,
+				      pgprot_t prot)
+{
+	unsigned int size, i;
+
+	for (i = 0, size = 0; i < count; ++i) {
+		struct vmap_folios_range *range = &folios->_range_folios[i];
+
+		if (WARN_ON(!range || !range->folio))
+			return NULL;
+
+		if (WARN_ON(range->pgoff + range->nr_pages >
+			    folio_nr_pages(range->folio)))
+			return NULL;
+
+		size += PAGE_SIZE * range->nr_pages;
+	}
+
+	return __vmap_range_folios(folios, count, size, flags, prot);
+}
+
+static inline void *vmap_folios(struct vmap_folios_struct *folios,
+				unsigned int count, unsigned long flags,
+				pgprot_t prot)
+{
+	unsigned int size, i;
+
+	for (i = 0, size = 0; i < count; ++i)
+		size += folio_size(folios->_folios[i]);
+
+	return __vmap_range_folios(folios, count, size, flags, prot);
+}
+
 extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
 				       unsigned long uaddr, void *kaddr,
 				       unsigned long pgoff, unsigned long size);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 044af7088359..247a4b940be1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3530,6 +3530,53 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
+void *__vmap_range_folios(struct vmap_folios_struct *folios, unsigned int count,
+			  unsigned int size, unsigned long flags, pgprot_t prot)
+{
+	struct vm_struct *area;
+	unsigned long addr;
+	unsigned int i;
+
+	area = get_vm_area_caller(size, flags, __builtin_return_address(0));
+	if (!area)
+		return NULL;
+
+	addr = (unsigned long)area->addr;
+	for (i = 0; i < count; ++i) {
+		unsigned int nr_pages;
+		unsigned long pfn;
+		int err;
+
+		if (folios->range) {
+			struct vmap_folios_range *folio_range =
+				&folios->_range_folios[i];
+
+			pfn = folio_pfn(folio_range->folio) +
+			      folio_range->pgoff;
+			nr_pages = folio_range->nr_pages;
+		} else {
+			struct folio *folio = folios->_folios[i];
+
+			pfn = folio_pfn(folio);
+			nr_pages = folio_nr_pages(folio);
+		}
+
+		err = vmap_range_noflush(addr, addr + (nr_pages << PAGE_SHIFT),
+					 PFN_PHYS(pfn), prot, PAGE_SHIFT);
+		if (err) {
+			free_vm_area(area);
+			return NULL;
+		}
+
+		addr += (nr_pages << PAGE_SHIFT);
+	}
+
+	flush_cache_vmap((unsigned long)area->addr,
+			 (unsigned long)area->addr + size);
+	return area->addr;
+}
+EXPORT_SYMBOL_GPL(__vmap_range_folios);
+
 static inline unsigned int
 vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
-- 
2.48.1


