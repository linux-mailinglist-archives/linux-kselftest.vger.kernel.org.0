Return-Path: <linux-kselftest+bounces-29860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A0A72C6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 10:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22D43B92DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BC20DD50;
	Thu, 27 Mar 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ari6cC7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010046.outbound.protection.outlook.com [52.101.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900420DD54;
	Thu, 27 Mar 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067828; cv=fail; b=BfbMjYr8aNGyiwH15AmIuix2331A0NTFx2FbPkRKUAXBzaWyLxtYOB04kBPvhSSTQ48J9HIgPHLmluypfoz6XJ3Qb+gFLVOFe+uBLkuBfWljey3+tBROmpAIdcU+vaqwhKQWxAaH1WfXdyQEr/vKzV82VOlSdNf0+7QYg+3Wy4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067828; c=relaxed/simple;
	bh=ClwdiLXa6uQoyI03ZfqxSzNMu5BmcYM7BX5xx6WT2WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePC8AO7koMzUys2vdiIPChAGg6EjfE9XjFgVHEsuvhN2H7obMz5d0VKws4PPAN9B6zkj8Iqh7oANvK5I+UfdNz5Kntizhlri4OhrpXYpnsPi2wV1yn4FYrdW3BM+GMSqWwJ6ctICBTMZKKJU83sXx1+T/BNO3lB020L/xu8j/lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ari6cC7j; arc=fail smtp.client-ip=52.101.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syhR6ZHqxJIZ0QX9jrfbWBit4HR9rJfT3y1cDQ1F9FveElaQGIVgdqizWqb1xUurJX3Ml7pTurjQSTrhxLdl4YdQP+72KYJru6yVFtHPbRBu8cLLOEOLDI/VNTvpU3aIGvfdZFQpvv1GGFDVUqJUclE9be7toTEUsv3VjWAjHMaUFnybdRqcgUoXenvg9jYH60SH64r8HAPlysK1W1/oDr4NdqJkSCEl5OoxX3vaOHG53w3VNohNum3vDN2QGOj5w7ZYt1P+HjSFw1Rz2T5Y+NWRnY9U4W/vZWfo/m7bn4lNFgMw5BSH+/k3/tiSHgZorhGN8u8FNnW5AGPB5LTU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWK3dj+fpZ5P2lvnEIC8wa18G9b/LZGOyrIDO6TJcUM=;
 b=bWnU0VioOQglp+wqX4bi5loymkJjwMEOAxlpjtNSMuvBUQodk/45YC9nvPaBuNl2TeYUlDCu/tCRMnT/cLFVfoCHXud2YqkMc0nAF4hXKrexxf6dPR7voM+T722qOq0B9hI5obR5y5V0oCXXSVTCg4h/70KIQIUDnd9jfm/1APIKWB9KG+Jjd6HoNVwJxp4iRAhWB1OHVj9Jof1+CikBVTfLRtLOORXu7Li4es+adDv7L2MX11IGH5CusqKDjymmIPAMDjU9raqg3wjFe+EsESHfPDyQVxjRRLkmA+VLN0XtlHFOfVNLCL+1yyaIGY2SSkKhYhBHh8suvwtr1KT/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWK3dj+fpZ5P2lvnEIC8wa18G9b/LZGOyrIDO6TJcUM=;
 b=Ari6cC7jtad3J1hRpG1CsZjnB19EVJu9ggpEGRtrbmBoQ13oyv2PKwQEzPOKdHbKV0pRkcwMFvfLurBqnfTiS7nMTjxkra5mIFaRSGBhH4kryQNiOE5l3lbU7USI0JbVBF0VhLLUoKORjA8/HmzVbx0Ne6hfwWF8Fz/G3EvwWNHXLLzRd/in8LCBzmteaNCGAid6JV/1LxtrnT2QcACGkyfWaNtptY4nAaxMjDuBhB+rUOuGYMX0seSVnfJ8Kde5n3G32eMm0e7I7ZgqRxIv3ylHV0ZTJAmg+x9aVRhfq18Bge2yc0/3QwLxf0SCoxFd6noROdqSiaT2Ja/DdW7Uxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB7238.apcprd06.prod.outlook.com (2603:1096:101:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:30:23 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:30:23 +0000
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
Subject: [RFC PATCH 4/6] udmabuf: use vmap_range_folios
Date: Thu, 27 Mar 2025 17:28:31 +0800
Message-ID: <20250327092922.536-5-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1e7da61b-f8b3-4191-ffa3-08dd6d12000b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Z+S4+XvXfx4oa5c/tSQyWOHQMTGXSoHCVRwQ4HM1BDncMYyZ6Ex7F+qtlhv?=
 =?us-ascii?Q?AlEx34/NMkZDMxTOzKvT5Ag+AFuqWTcPfF8XGgor2WVxqJVrudHcA/93G6Rh?=
 =?us-ascii?Q?sSbQ1t2Wt9viPqdlYmhXDWwy55/UrKJ/rNiYe1V8Moq7pilQ3YgrhI4o1lJL?=
 =?us-ascii?Q?TMbG0MBkWdPo57XTTm5Khj1BnQiQGdCOqKGplhN8YW/K7ZQdWRV/OvOY0zFf?=
 =?us-ascii?Q?KJp65rBts9cUPcaEt82r2GBOnfgk7MbJWn32l/CytRMokrGY8qoR2zsVr3qG?=
 =?us-ascii?Q?UKgxQlDVSF9BMrmD5f5J2brtBT1ubNoE4qqJR7Qkv1ZyO/H0xylCUxf6BYvS?=
 =?us-ascii?Q?d08wBGNJOetPgcnUsFHxGe7Die/i1QFybz5ZGcr218+wTT8XCB1M34TrsMhu?=
 =?us-ascii?Q?wng5FWoMF8zHYofJ2dCTZ1r8KMhRAgxJo+9IvZuVSF4NwBmtQMvwK46Kqo19?=
 =?us-ascii?Q?Gw0Nnj6qvlEDuyjY5yruXk+3cscLWwLih3aMO4Zf26VVvGnKPRh5FUPW3imj?=
 =?us-ascii?Q?ha5Pqxo+o/RqWJuqj/AfVBZ5WxXy0PD5VZICELwzqSDo0J8dwiarbZlJnBik?=
 =?us-ascii?Q?zREdxLuhtkQvSkNksibrXEFSDo77akByEf0ipTvnFLN0C3u6HtnHi3pWocEc?=
 =?us-ascii?Q?iBpaOYQxFV8PGOr4hH/HSHWWH34yanW8AaJhS2aMYSQMCFAB9h4JVyxViwPv?=
 =?us-ascii?Q?/2BclBhq0KxaVcJ9akBweCu0JnjpcQl+IGJRDu3wpLLXJTT424LBM98GcVx5?=
 =?us-ascii?Q?/r0vZ5nMp3rcef5uklYOL/RQoEIfv4vxqwBD5IYkI3JJvLUrljZStVqteEa+?=
 =?us-ascii?Q?wsUatvKoQbFGVEh4SpZ5HVUo0vYpJpIQ+zXFGBcfZ426cJgVhYutw61+LZCQ?=
 =?us-ascii?Q?Iexg7nMa8BQpIfqZfLhLu4Liu0l6FCsxGqaiQUFdQmUKp6HczMj7WL59wLqI?=
 =?us-ascii?Q?KhD0KEA6yI2VXTZjT28lxWUWTGzca/c9eFoOBaEBVt/3UIffypvmASPwZWbb?=
 =?us-ascii?Q?0geJUTIVZUt82XWWcXyiUQV/eXeOe3corhXAKkKh2E1iHe/0/tjH6j0HJUYA?=
 =?us-ascii?Q?ghSHz4hITRoWTmA+gBd7cF7Tgw0oisMuWIuvIf+vOEirPIAT3NMHT3Iz/p05?=
 =?us-ascii?Q?vs5faonXy+moyzsCi7WCdi1UZLGRayI8UJb8ykswvlzfDOVhK7MTlA+l+T7n?=
 =?us-ascii?Q?kF5nLBnJMy9yauj0x4MRLB0WJI+gB9erPPCfSi+N11JPh0OZUq0MWUTr1Igb?=
 =?us-ascii?Q?YsEXzDJKLzGrb5bZjNE8M0ik0weetly6abwMCPhe9pDAsO4ze+dz4kysf2IB?=
 =?us-ascii?Q?FPw6FRl4sp6D3KbTxCRzOldtov9LG117M0OkyIpD+Kgaj+RMVambHg9+fqs0?=
 =?us-ascii?Q?m9qWKpcNtwWnd829gBiYiPj4SXGo+uz1oClg9JZJWDrvUGb1ACzXhIHWvTqd?=
 =?us-ascii?Q?YArGdvnFTayqH9id+OPrFpeNvX3cKgKDoug3bHdnrV0tucTGsiV3BA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZjxsuCWlbefpxzVq54esX3NK7BGLAua3Q0ab9RHVBX01BMY1/Bv5a/ZM8D53?=
 =?us-ascii?Q?QFRCQ1mYDE3dm1n2S5iDmmQI/9NV8kHDSa5YS7FSb7518fpHYKYCo14saMBF?=
 =?us-ascii?Q?IXqmAwCD5pkaRVKYrSp6Oa1AvyFisnoAn9kif62LG2CKvzmLkyv73DbveaBi?=
 =?us-ascii?Q?qZCCSs+6GrlAEp7EX8fvlS5DQLCSveqOInaMDkFnAC9muzEnBzCGfB09qWn5?=
 =?us-ascii?Q?+90TPlj0nqAP3fB6oE49NtgewlMeF/bJDIuKrEssLzF8brsT56ogP/W+dqqt?=
 =?us-ascii?Q?uTwYtRNY6tgjb5u2+5XpM860cEvBW2aFEOmXhSg8n7oxYsytAHjXQB9LPVIf?=
 =?us-ascii?Q?gkK4sp59j+gE6bF/3K8895rpPotYk3N1fHlmrxqjlERfgMI32SWnsAcabX1n?=
 =?us-ascii?Q?jypBz8YSKbhhFVEMkfWkIdeeAMJgukunkf+slDz11FzXseTNJzxepcPKF6GE?=
 =?us-ascii?Q?aXoScK5W/Yn1zAiTu6ZpgQOB2lwYJYATk6Pg+VNxxWO1rRBMrATmgB/f87+K?=
 =?us-ascii?Q?XgDAo3i9eOFJFJYH8QneAoDJJPzED8jPWY1wQ6r9Sif1s0dICnVC6swqxMex?=
 =?us-ascii?Q?AZPpXcCmu6Ak9Om0A1uEKDaauFlqnOtQkQqfFJDred+j8tGq4qrIgtbqf9gp?=
 =?us-ascii?Q?DpAjc1jEIV93YUKYVgI2QBTsQf8Q3QHe2enuIfwtd9XcAII4Lrgj0j2duS8v?=
 =?us-ascii?Q?M3lAOp8aK+/h7NrauMpgj9tZ2r3cje8u1mmbhL0DR1ZVZI5PEKMtat0M8nr7?=
 =?us-ascii?Q?y10epn/nQMq1lMe26bJ+0AZiurR7lFxGyrFGdekWKUq49JTbEQLAedd+DaV+?=
 =?us-ascii?Q?d4+GZL1NiFBYSKWNAmcHjyn8Ljg+0Fk3EQniaxVa5KiZIQBxV4x2hlxlnQLC?=
 =?us-ascii?Q?mk6QEc+GuMjEmTU+DY8xY/s21vojggBq1H1+yEC5EgBVu/fALDCKTOQ6gtLr?=
 =?us-ascii?Q?tyZ5nT4nMbrVcb3QB92r47rCY8TaO2hncKsW7RhrpBtOz8HoAo+TPQ1LxIF9?=
 =?us-ascii?Q?kJHetsl/onGPDzUtVHyFr8xXaqLN7/UlQsfh/lh3FVOwSvcvCWuBWKbMoVPg?=
 =?us-ascii?Q?1ht6iqXATpizh5lr3Mcx/BjX5L/bnRHH3nIUbqCNOyAlC58AIK6i7rMGS2MX?=
 =?us-ascii?Q?CF52VL0FM/jbLy1Fa+I4fES1YMCuAyus1YqP/vsvaMho2DbBRpaAvOhpbOGU?=
 =?us-ascii?Q?R9KfmzQ9Vn1lFswZ5YtbzKtTRn0GNOG9TNtdyXXDAJ8uSr7SpILrfj96eEU4?=
 =?us-ascii?Q?O2/VO+XPX304wOMJFeqXez2yN3Dd3yKzoCKh7F/Ym+6QQzaqxP2YXjj4mVRB?=
 =?us-ascii?Q?StMysHjpq+gHTRC4CuMHfaKd5xwfnvtLSolW5CedrK4PQ8/I04QSfl3fSYET?=
 =?us-ascii?Q?BxBrPoMQdj33oTpcM2zg5NrVYe6mRuWv8USNhzzjxhm1pSLWrjkQSYr4nnzl?=
 =?us-ascii?Q?Li3WjV8mPKoAmGfU8cqduW63UrJmT6R8bsaxKB9YUgfdAZN3blRsdIxjfYWH?=
 =?us-ascii?Q?aVLK+0fLX/MH/QUqnP32+8LYbSnQUAaMXkJlX2N8CsZrI0r4va9N5hn7hYA2?=
 =?us-ascii?Q?UBL+ioOXn86o53xUCFVxhslVF0yVzRkuOXxyH0H4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7da61b-f8b3-4191-ffa3-08dd6d12000b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:30:23.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3rKMBAR9otNKm4SxQlzVn9i1sTwAuKpsJhT91AxI2xn2Typr+xvXH7LAVMbJMM3/kwSYl6MCl8tgD5gwT1D8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7238

This patch change udmabuf from use pfn based into folio based vmap.

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/dma-buf/udmabuf.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index fbe4b59b4c97..f50e11f0f034 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -152,29 +152,28 @@ static void *udmabuf_vmap_pfn(unsigned long *pfns, unsigned int count,
 static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
 {
 	struct udmabuf *ubuf = buf->priv;
-	unsigned long *pfns;
+	struct vmap_folios_struct folios;
+	struct vmap_folios_range *ranges;
 	void *vaddr;
 	pgoff_t pg;
 
 	dma_resv_assert_held(buf->resv);
 
-	/**
-	 * HVO may free tail pages, so just use pfn to map each folio
-	 * into vmalloc area.
-	 */
-	pfns = kvmalloc_array(ubuf->pagecount, sizeof(*pfns), GFP_KERNEL);
-	if (!pfns)
+	ranges = kvmalloc_array(ubuf->pagecount, sizeof(*ranges), GFP_KERNEL);
+	if (!ranges)
 		return -ENOMEM;
 
 	for (pg = 0; pg < ubuf->pagecount; pg++) {
-		unsigned long pfn = folio_pfn(ubuf->folios[pg]);
-
-		pfn += ubuf->offsets[pg] >> PAGE_SHIFT;
-		pfns[pg] = pfn;
+		ranges[pg].folio = ubuf->folios[pg];
+		ranges[pg].pgoff = ubuf->offsets[pg] >> PAGE_SHIFT;
+		ranges[pg].nr_pages = 1;
 	}
 
-	vaddr = udmabuf_vmap_pfn(pfns, ubuf->pagecount, PAGE_KERNEL);
-	kvfree(pfns);
+	folios._range_folios = ranges;
+	folios.range = true;
+
+	vaddr = vmap_range_folios(&folios, ubuf->pagecount, 0, PAGE_KERNEL);
+	kvfree(ranges);
 	if (!vaddr)
 		return -EINVAL;
 
-- 
2.48.1


