Return-Path: <linux-kselftest+bounces-29862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE82A72C77
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 10:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B686D179F23
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426520D4EE;
	Thu, 27 Mar 2025 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ONh7rBgO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013017.outbound.protection.outlook.com [40.107.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027020D4E0;
	Thu, 27 Mar 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067846; cv=fail; b=PX2E09GG0MY6P8DiyXU/zMrcq7UrTspK7e02+2Jg3Ua7fF3KZOeEfvnml/UJCv8Sp8B3AuqwnjE5RAz3uEi/qJCW5uJQOE49oNiPTkeGDqmhw5sd5mXKuLKXRu6o+yZKyqtt1XRLJWgLjpIgn4UmyV/3cGhP1bnTERGXwyS2zSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067846; c=relaxed/simple;
	bh=5uepYVnpLsWPc5wqe8pJF3Lt6IjkIjVjFON6cNxc8/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=di1f6YkxocdDPKj7iSRiybTqjYbDSCjpdQ9RkpWbIM74eLFKAT62D+ghuBTVK9jkOTZMuuzAJMcy/hM4+XWmbR1PLLyKY+zIslcrdBGPIWxYRBq86kiCUxschSi3JGd9Yj8Wc2MjjDqb31wCh/n9UtR/9776YPHsdrAYbNHbRLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ONh7rBgO; arc=fail smtp.client-ip=40.107.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3OZ6SFBKSQKggh5vEfdYcP+5Pe14SLBYXzmZqT1oBntvDoqKfEBlHsAOqiwq+JahsHrWhZ4vjmdk4Fv8IUthG3g9E8A4LhwcI4dWMjRFTZsS1TeAd+5I4rKiC9CHR/Cma329mXho/TGuC8Yuc6yY+ZNss8uDN18Lq/eirRaIZQMHMrt6yLgTuynsTIpj6+kQyBLWS3da5nSKv5VkIG6gSRJ0efhRLJu9FkiB6KLfE6DqK9zt9tjCpj4TF6n3UNAAIMWxsRxYLtMRWBR7ENpHBMmJw5GVCr6f4RItBIbGfq6C4GWfCPv8+k2ZGCGwebs+YGXJJm7OSTyaehtcqsL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE/DnCyBrZ58hOjkDxC8Hu9PUZPaTclA1C/LEyi7Z4Q=;
 b=O/f7+/UFTiIFitxAdOt5Ya2/tnIcM43Sf0Y4K8yv3Ks9MBTsuDE+TYH2WjPn/vkXhTSRmnJvC+CFWSXJLDHN7l9uSweV5df6MyDiGr/FLs3OD3NunAm67ZQM63sxwIGLtxRrLM/m1i9yY00gRiJxBDGswRov0yuIucGEqTJPD10+6D10Zk/3ojLZqnRZD9EvJmSJDPXYo8nqjrYYGj17Y6EgCCpqa6CmXia1VPtq7eI9bjWBefPHoQTJJHVwR0AaIwpJQ1948eGYqpiHx51Q4SfF3awZfTn45TqCsV7rHb2xM1PxV2g2tMpT+We5l4SsQcDBvxykezbcKjw6jWksAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE/DnCyBrZ58hOjkDxC8Hu9PUZPaTclA1C/LEyi7Z4Q=;
 b=ONh7rBgOiQogLJ8kFsfMBSlcl5sImETmGU4ixt1jhZxorhtl79c3GCgS1s0JDMeLdIUWYdGT2sd6HBDuD0BQhJJm0fz6HwSKnjZlP0KFyaV0JEJnSphv/o2hZhr10Cr7f8selFwPT8UNqR6ppfTxQ0iHzk8l74gcjfuQqElbeseSfOaz669SA3pm2nSojSiA5/7A/Ry0p2J3MV4Tebiq1YTOTsj003MA+QORxcANmkCy+UCRvmZBvxxlfsYrAagXYLqLdaqREZWb0XyGgfz8Yvg7EsdTQ4kKp6VA9T5F2G3zIOhNZ8cOwID5MOxG4p0gHnMc97JOG1JsRXgeYkTeQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6906.apcprd06.prod.outlook.com (2603:1096:820:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:30:40 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:30:40 +0000
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
Subject: [RFC PATCH 6/6] udmabuf: remove no need code
Date: Thu, 27 Mar 2025 17:28:33 +0800
Message-ID: <20250327092922.536-7-link@vivo.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR06MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c1d6fe-b5ca-44a5-3867-08dd6d1209e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KdaPBLzFLXWw+Xfs6Oy/zJ53izb+Gv8AmRAFJ+ODEpNGhCWZLaaE5/9Bsasr?=
 =?us-ascii?Q?qmtHEBWLmcQkVyWql58VLWixbm7oJoVai4GSz2u9wP7WuFrrTRwh+Na3PSim?=
 =?us-ascii?Q?ChG0Ywn0FzFScZPyXsBZvBQhE8b9psY59ZftrOIlVugGVgsNTyNrHaWQ/ON9?=
 =?us-ascii?Q?X77kCl4rjSZSp7qW35zyrP+mric6lecC52EnchmSSSnQ0nZlZl3dZudV3u56?=
 =?us-ascii?Q?liIW4YbUDKxX08bQ2oPkbfx/UcvjzbNkhD4x7n5YHctvueQs2vKhfUZuCcDo?=
 =?us-ascii?Q?wO/I4p5aIm3ADqQDtiqseohDnlh7SdLNpTfLAHc6JsPT1uciZR2MaZDzUswk?=
 =?us-ascii?Q?lBHUOZx9xqhc5MjCn45QD303fuveLHqK6jAJezVNbf+qRK5E1mfc1ecHUzf1?=
 =?us-ascii?Q?WwFFN6r2H68kO5KCkfBzK6wKtELj4cBJJnG9B4mvzZEOuwYrmJMPfql2sVz2?=
 =?us-ascii?Q?Yc1KPrmtiPZOxGlf0QfOWBFrI+G+QMfAwZW5rOCmXtC1Owj/0fTv0VuAN1di?=
 =?us-ascii?Q?KcrxHrEBA/MjQP9pEE4EkRqk16uIVrxEMXhbl6LVIzlRQp52knlYo4yt4ZIJ?=
 =?us-ascii?Q?HH9DXZET8i1dHSCfrdjVaHO/kZns2VryuCv1dV6H5wN0mrL0SA9qTEKML1By?=
 =?us-ascii?Q?f60TLtH8rCIUlfGiBAbZ751ooPmA1gbvfn+aZeqMg1ITZ0vUFfhcFK9FdGBu?=
 =?us-ascii?Q?yi6XDesU0KJqUD6Xx4VUX2tU5W8XGdXKocuA7mQp6hZdV1w5oC8lr549scVM?=
 =?us-ascii?Q?fI8sgRK+a8jkjmyNXPfmcxX/75cnZ4HbqEfNYAK9Py/zc0rWusBHyZV0tBd4?=
 =?us-ascii?Q?Ot5MTsPim/odajKn1TQe8pGJ2c38uplDjaP1Q+CPBLIhJZaHnRPFlLATo8T1?=
 =?us-ascii?Q?isj1wMs/cOHKpjmQmuzJAJyddwsjba9vZwHW8NVKe77LyalAzGkZn8lTm4Kp?=
 =?us-ascii?Q?0dkRXDn7CrnIHQhihFlsJzNfV3Opsy/3JVjB4iqwSheZ7mSYw+EGwJRetGF8?=
 =?us-ascii?Q?LSsHSaAJpn5/sV1tA5F4NdNsxQeaJoUQ2/1pfPhBC9ufaMIDO1+7iIDYCwgs?=
 =?us-ascii?Q?5/LOkKB3lZgECrzcHvm1JVz5ChcSLELCAZ55U/TBdnj2hkDg9SxTVC4PPQx1?=
 =?us-ascii?Q?lmnQ8teHrXEFfHaNEF0BmvooG5fFQpXsi5iESmI3vGOPaTC7MZJJRAia8tEq?=
 =?us-ascii?Q?+PhbytEbCX1E5u6k340r4qba2j2/ECvto1+OXDqEINHY8HB7HHalkzj/HDfN?=
 =?us-ascii?Q?sZzU5b4UpCcBnxsHzSVmccgj+eBFLeo84lgSnkoq0GEYcT3ZrxjVRxao7jFJ?=
 =?us-ascii?Q?sJVobWlxtBPG73iP47ZO8JKY/oXvcmt039BxWrGwx3Or8+Ig+zwcbNRpztc9?=
 =?us-ascii?Q?CBPIGw31uRSakeMMSN93VICjnRhQfGGiR0aEKpQx2MPGZaV7QnVvaHTCf3VN?=
 =?us-ascii?Q?rW1JErgkvyGJ/KLTSB/0AjCXfIWTdB4zDVqlY10RIV2ViBHTkV/SGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LDCAEjmPcbTjV+/l+CF4P64YYdSpdsTOdVh+4/vnmu8qhvvDcaFsjptkBQ5q?=
 =?us-ascii?Q?65TsCFWp+siTxZPYLKQ8ElqXGzOvLax0ttwp3DD287slS8orIDE9Q6Pl18Dv?=
 =?us-ascii?Q?bvuKIFVkOMhprekl6LJaQYyZ9wrLoxXuvB0qNJp+S9wqNeffb2iuei6npN9S?=
 =?us-ascii?Q?qsHbTwX1QDBACYHuQnab1BpzWHWwp35+LEldiQHw7ntitq1EXzE1boa99Ma1?=
 =?us-ascii?Q?rvG9cVpTfDaQXAMKLenl9agcHs0PkgkTlAv8wAsrGdoOUygYqUcHBzxcRmOp?=
 =?us-ascii?Q?lEH7y3+U4FMdA92Tk1s3n5oDURelm1HEWqLPsWbIbpoo4JMrCXxn8GDrfHq1?=
 =?us-ascii?Q?eTTOZ1EFSn5CPyGLBNwmPJFry5hOmFwiiipYSTUlfgLEdEIR16HrTDSuPBUe?=
 =?us-ascii?Q?SEtZA3RDkXG4c7LpHKg8zbj51z22Lw1aOwF1YkdOegC7fCrn4ax97N78/4Mo?=
 =?us-ascii?Q?jwwhJ6CFyyFu0aXnHMHnJDwnayKlSY5RA5FIKRQTgXF4QCzoUJWTG1Vu4VBy?=
 =?us-ascii?Q?7W/N02pxDFFudjzn7Sb7FjPk+UeBYthns4R9fUjXfTu4SmB+kUubk2s+i11s?=
 =?us-ascii?Q?Y26WsvhMpPSljxBFhR3oLJH1L/LPy4pynKyoRsbBenyJOKPZdDHuqL9/6Afi?=
 =?us-ascii?Q?UiqCd8AkyIZMm6PkgpcHnODoV9u2i7KUDZQJaa3UFuMJzj9iIhSTRp8jnWkV?=
 =?us-ascii?Q?lgAnvqVPkckgNLxxfKhYMEppTGt7CZADfREB+IXGwiM7z81Evd4XRiRepN4w?=
 =?us-ascii?Q?Vza4+imT6de0BCsj4s8q7tSgkvBXTGt65LO581eqOJy6K1MZGn8Zbn/wFFlk?=
 =?us-ascii?Q?rasy8xp9GTF/94eC5g0WzvyWSzCC8zRZARYWsjl95F1oSgVP4EiJCVUYhwpq?=
 =?us-ascii?Q?bZKIS0RZlv3UUbNx1LNmPazf6MGS5jU73fn+lx3IjIp8GTlKyojAHbToh5l5?=
 =?us-ascii?Q?kgXOYJ5OaVIwHfDDFNwkz75+96OhstPX2EFtTXn/lqacfBxGOcvuy7y5movc?=
 =?us-ascii?Q?Ca8Fu7hCKAOxlJn1fjaX+9bHzpT1pdMA/tzOeA2wHVkiavu8AwpBwOfyqGJ8?=
 =?us-ascii?Q?E3YoCSOUC0oq75wuO+VaHKI8Vl3typYHoXVK3oPLjlYY19aSmuq6P97jPpn9?=
 =?us-ascii?Q?BMujUjqYzrngY6DhMaWzt1Sm2nmsvbA5gK/9vpWXnwCr6128BHM+hRDQka5b?=
 =?us-ascii?Q?b+V9tsJr3pWapQP9zOgoA8MHYihqEfN6t0tXlygjUYiF+Iu07sf69xDF//lh?=
 =?us-ascii?Q?VaAgc3rG4ZwM2Ye2K/B9L7VWJDl2B2hpcQpK4Tb3puFvdbW8DjWQbgpgRBaX?=
 =?us-ascii?Q?+eNsYsmNcoB9Eu+asVG9v4X80eja+pHh8Yy5t5hrBHZmeqgSuv6zweKNrzJs?=
 =?us-ascii?Q?2g8lLpjlZFdmG9gKsCys5Lf8Fy8FUYou6YSEjXq07baVDrb++Xfb+INQrE8y?=
 =?us-ascii?Q?vZEHBcoEuBBkEe8Mc74cjrc6Yn2z1mMMEM1wjh9n2tO19zWT9f5kNZr5TpgJ?=
 =?us-ascii?Q?O/Urpr3d/nBl8Fs5euQIrHknKOgVZCCe+VNJxNTF/PwU3N24bubLhmkFAXW0?=
 =?us-ascii?Q?PmCKYPSN3Hst28CHeJ3ircMmLkMwTSpzXNnW5Xq7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c1d6fe-b5ca-44a5-3867-08dd6d1209e6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:30:40.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Xv+/8O4ItXV5BCPElBwFNBTeO8buvSlwY74mU6a72uzyJWDFAJTnPBFZPj7gBpb9h4IP5o87b5pLk47pBbBDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6906

This patch remove each test code.

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/dma-buf/udmabuf.c                     | 142 ---------------
 include/uapi/linux/udmabuf.h                  |   5 -
 .../selftests/drivers/dma-buf/Makefile        |   1 -
 .../selftests/drivers/dma-buf/udmabuf_vmap.c  | 166 ------------------
 4 files changed, 314 deletions(-)
 delete mode 100644 tools/testing/selftests/drivers/dma-buf/udmabuf_vmap.c

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 78549a9f24ca..67ab50914a31 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -106,49 +106,6 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
 	return 0;
 }
 
-struct udmabuf_pfn_data {
-	unsigned long *pfns;
-	pgprot_t prot;
-	unsigned int idx;
-};
-
-static int udmabuf_vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
-{
-	struct udmabuf_pfn_data *data = private;
-	pte_t ptent;
-
-	ptent = pte_mkspecial(pfn_pte(data->pfns[data->idx], data->prot));
-	set_pte_at(&init_mm, addr, pte, ptent);
-
-	data->idx++;
-	return 0;
-}
-
-static void *udmabuf_vmap_pfn(unsigned long *pfns, unsigned int count,
-			      pgprot_t prot)
-{
-	struct udmabuf_pfn_data data = { .pfns = pfns,
-					 .prot = pgprot_nx(prot) };
-	struct vm_struct *area;
-
-	area = get_vm_area_caller(count * PAGE_SIZE, 0,
-				  __builtin_return_address(0));
-	if (!area)
-		return NULL;
-
-	if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
-				count * PAGE_SIZE, udmabuf_vmap_pfn_apply,
-				&data)) {
-		free_vm_area(area);
-		return NULL;
-	}
-
-	flush_cache_vmap((unsigned long)area->addr,
-			 (unsigned long)area->addr + count * PAGE_SIZE);
-
-	return area->addr;
-}
-
 static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
 {
 	struct udmabuf *ubuf = buf->priv;
@@ -556,102 +513,6 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static void *udmabuf_vmap_by_pfns(struct udmabuf *udmabuf)
-{
-	unsigned long *pfns;
-	void *vaddr = NULL;
-	unsigned int i;
-
-	pfns = kvmalloc_array(udmabuf->pagecount, sizeof(*pfns), GFP_KERNEL);
-	if (WARN_ON(!pfns))
-		return NULL;
-
-	for (i = 0; i < udmabuf->pagecount; ++i)
-		pfns[i] = folio_pfn(udmabuf->folios[i]) +
-			  (udmabuf->offsets[i] >> PAGE_SHIFT);
-
-	vaddr = udmabuf_vmap_pfn(pfns, udmabuf->pagecount, PAGE_KERNEL);
-	WARN_ON(!vaddr);
-
-	kvfree(pfns);
-	return vaddr;
-}
-
-static void *udmabuf_vmap_by_pages(struct udmabuf *udmabuf)
-{
-	struct page **pages;
-	void *vaddr = NULL;
-	unsigned int i;
-
-	pages = kvmalloc_array(udmabuf->pagecount, sizeof(*pages), GFP_KERNEL);
-	if (WARN_ON(!pages))
-		return NULL;
-
-	for (i = 0; i < udmabuf->pagecount; ++i)
-		pages[i] = folio_page(udmabuf->folios[i],
-				      udmabuf->offsets[i] >> PAGE_SHIFT);
-
-	vaddr = vmap(pages, udmabuf->pagecount, 0, PAGE_KERNEL);
-	WARN_ON(!vaddr);
-
-	kvfree(pages);
-	return vaddr;
-}
-
-static long udmabuf_vmap_test(struct file *filp, unsigned long arg)
-{
-	struct udmabuf_vmap uv;
-	struct dma_buf *dmabuf;
-	bool can_page = true;
-	struct iosys_map map;
-	struct udmabuf *ubuf;
-	void *vaddr, *pvaddr;
-	struct file *file;
-	int ret = 0, i;
-
-	if (copy_from_user(&uv, (void __user *)arg, sizeof(uv)))
-		return -EFAULT;
-	file = fget(uv.dma_buf_fd);
-	if (!file)
-		return -EINVAL;
-
-	dmabuf = file->private_data;
-	ret = dma_buf_vmap(dmabuf, &map);
-	if (ret)
-		goto out;
-	vaddr = map.vaddr;
-
-	ubuf = dmabuf->priv;
-	for (i = 0; i < ubuf->pagecount; ++i) {
-		struct folio *folio = ubuf->folios[i];
-
-		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			can_page = false;
-			break;
-		}
-	}
-
-	if (!can_page)
-		pvaddr = udmabuf_vmap_by_pfns(ubuf);
-	else
-		pvaddr = udmabuf_vmap_by_pages(ubuf);
-
-	if (!pvaddr)
-		goto out_vaddr;
-
-	// compare if pages and pfns is same?
-	if (WARN_ON(memcmp(vaddr, pvaddr, ubuf->pagecount * PAGE_SIZE) != 0))
-		ret = -EINVAL;
-
-	vunmap(pvaddr);
-out_vaddr:
-	dma_buf_vunmap(dmabuf, &map);
-out:
-	fput(file);
-
-	return ret;
-}
-
 static long udmabuf_ioctl(struct file *filp, unsigned int ioctl,
 			  unsigned long arg)
 {
@@ -664,9 +525,6 @@ static long udmabuf_ioctl(struct file *filp, unsigned int ioctl,
 	case UDMABUF_CREATE_LIST:
 		ret = udmabuf_ioctl_create_list(filp, arg);
 		break;
-	case UDMABUF_VMAP:
-		ret = udmabuf_vmap_test(filp, arg);
-		break;
 	default:
 		ret = -ENOTTY;
 		break;
diff --git a/include/uapi/linux/udmabuf.h b/include/uapi/linux/udmabuf.h
index 88f5e5516286..46b6532ed855 100644
--- a/include/uapi/linux/udmabuf.h
+++ b/include/uapi/linux/udmabuf.h
@@ -27,12 +27,7 @@ struct udmabuf_create_list {
 	struct udmabuf_create_item list[];
 };
 
-struct udmabuf_vmap {
-	int dma_buf_fd;
-};
-
 #define UDMABUF_CREATE       _IOW('u', 0x42, struct udmabuf_create)
 #define UDMABUF_CREATE_LIST  _IOW('u', 0x43, struct udmabuf_create_list)
-#define UDMABUF_VMAP  _IOW('u', 0x44, struct udmabuf_vmap)
 
 #endif /* _UAPI_LINUX_UDMABUF_H */
diff --git a/tools/testing/selftests/drivers/dma-buf/Makefile b/tools/testing/selftests/drivers/dma-buf/Makefile
index e5b131dcc2c3..441407bb0e80 100644
--- a/tools/testing/selftests/drivers/dma-buf/Makefile
+++ b/tools/testing/selftests/drivers/dma-buf/Makefile
@@ -2,7 +2,6 @@
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := udmabuf
-TEST_GEN_PROGS := udmabuf_vmap
 
 top_srcdir ?=../../../../..
 
diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf_vmap.c b/tools/testing/selftests/drivers/dma-buf/udmabuf_vmap.c
deleted file mode 100644
index 7bd46c909bdf..000000000000
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf_vmap.c
+++ /dev/null
@@ -1,166 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-#define __EXPORTED_HEADERS__
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <malloc.h>
-#include <stdbool.h>
-
-#include <sys/ioctl.h>
-#include <sys/syscall.h>
-#include <sys/mman.h>
-#include <linux/memfd.h>
-#include <linux/udmabuf.h>
-#include "../../kselftest.h"
-
-#define TEST_PREFIX "drivers/dma-buf/udmabuf"
-#define NUM_PAGES 4
-#define NUM_ENTRIES 4
-#define MEMFD_SIZE 1024 /* in pages */
-
-static unsigned int page_size;
-
-static int create_memfd_with_seals(off64_t size, bool hpage)
-{
-	int memfd, ret;
-	unsigned int flags = MFD_ALLOW_SEALING;
-
-	if (hpage)
-		flags |= MFD_HUGETLB;
-
-	memfd = memfd_create("udmabuf-test", flags);
-	if (memfd < 0) {
-		ksft_print_msg("%s: [skip,no-memfd]\n", TEST_PREFIX);
-		exit(KSFT_SKIP);
-	}
-
-	ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
-	if (ret < 0) {
-		ksft_print_msg("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
-		exit(KSFT_SKIP);
-	}
-
-	ret = ftruncate(memfd, size);
-	if (ret == -1) {
-		ksft_print_msg("%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
-		exit(KSFT_FAIL);
-	}
-
-	return memfd;
-}
-
-static int create_udmabuf_list(int devfd, int memfd, off64_t memfd_size)
-{
-	struct udmabuf_create_list *list;
-	int ubuf_fd, i;
-
-	list = malloc(sizeof(struct udmabuf_create_list) +
-		      sizeof(struct udmabuf_create_item) * NUM_ENTRIES);
-	if (!list) {
-		ksft_print_msg("%s: [FAIL, udmabuf-malloc]\n", TEST_PREFIX);
-		exit(KSFT_FAIL);
-	}
-
-	for (i = 0; i < NUM_ENTRIES; i++) {
-		list->list[i].memfd = memfd;
-		list->list[i].offset = i * (memfd_size / NUM_ENTRIES);
-		list->list[i].size = memfd_size / NUM_ENTRIES;
-	}
-
-	list->count = NUM_ENTRIES;
-	list->flags = UDMABUF_FLAGS_CLOEXEC;
-	ubuf_fd = ioctl(devfd, UDMABUF_CREATE_LIST, list);
-	free(list);
-	if (ubuf_fd < 0) {
-		ksft_print_msg("%s: [FAIL, udmabuf-create]\n", TEST_PREFIX);
-		exit(KSFT_FAIL);
-	}
-
-	return ubuf_fd;
-}
-
-static void *mmap_fd(int fd, off64_t size)
-{
-	void *addr;
-
-	addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	if (addr == MAP_FAILED) {
-		ksft_print_msg("%s: ubuf_fd mmap fail\n", TEST_PREFIX);
-		exit(KSFT_FAIL);
-	}
-
-	return addr;
-}
-
-int main(int argc, char *argv[])
-{
-	struct udmabuf_create create;
-	int devfd, memfd, buf, ret;
-	struct udmabuf_vmap vm;
-	unsigned long *vaddr;
-	off64_t size;
-	int i;
-
-	ksft_print_header();
-	ksft_set_plan(2);
-
-	devfd = open("/dev/udmabuf", O_RDWR);
-	if (devfd < 0) {
-		ksft_print_msg(
-			"%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
-			TEST_PREFIX);
-		exit(KSFT_SKIP);
-	}
-
-	/**
-	 * Normal test
-	 */
-	size = getpagesize() * 512 + getpagesize() * 256;
-	memfd = create_memfd_with_seals(size, false);
-	buf = create_udmabuf_list(devfd, memfd, size);
-	vaddr = (unsigned long *)mmap_fd(buf, size);
-	for (i = 0; i < size / sizeof(unsigned long); i++)
-		vaddr[i] = random();
-
-	vm.dma_buf_fd = buf;
-
-	ret = ioctl(devfd, UDMABUF_VMAP, &vm);
-	if (ret < 0)
-		ksft_test_result_fail("%s: [FAIL, normal test]\n", TEST_PREFIX);
-	else
-		ksft_test_result_pass("%s: [PASS, normal test]\n", TEST_PREFIX);
-	munmap(vaddr, size);
-	close(buf);
-	close(memfd);
-
-	/**
-	 * Hugetlb test, 2MB
-	 */
-	size = getpagesize() * 512;
-	memfd = create_memfd_with_seals(size, true);
-	buf = create_udmabuf_list(devfd, memfd, size);
-	vaddr = (unsigned long *)mmap_fd(buf, size);
-	for (i = 0; i < size / sizeof(unsigned long); i++)
-		vaddr[i] = random();
-
-	vm.dma_buf_fd = buf;
-
-	ret = ioctl(devfd, UDMABUF_VMAP, &vm);
-	if (ret < 0)
-		ksft_test_result_fail("%s: [FAIL, huge test]\n", TEST_PREFIX);
-	else
-		ksft_test_result_pass("%s: [PASS, huge test]\n", TEST_PREFIX);
-	munmap(vaddr, size);
-	close(buf);
-	close(memfd);
-
-	ksft_print_msg("%s: ok\n", TEST_PREFIX);
-	ksft_print_cnts();
-
-	return 0;
-}
-- 
2.48.1


