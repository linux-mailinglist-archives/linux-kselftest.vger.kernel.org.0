Return-Path: <linux-kselftest+bounces-29861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB83A72C76
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 10:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1988179530
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2CF20CCD2;
	Thu, 27 Mar 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hvYm7c9J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010023.outbound.protection.outlook.com [52.101.128.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099B13DDAA;
	Thu, 27 Mar 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067840; cv=fail; b=NzayxV6owpFj91t311u35jdPGzRXaG39pj2E/ws/EZBcvOVaGEB2kcZW6Y/N4SSgNBvSNBvAyTSlwAIqnRDiAITpRsHMN7xr0GuB3lcEf5/2bztWUsVJTL5671SFnNY6M+XY8K7vxC0/qNdhmqFF8XxvKrKYn807zKDZgnnLUkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067840; c=relaxed/simple;
	bh=mKlTODbkyFy7IeRuN+O785X9JRGeyISLATsqBJz3TjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HloVqec4Ba1XVnFWpLyZm5rszZ4UvwM7RfO8pTsuYfys8acA4gbruVSq9wMXrIdb70gvcdKrTawJ4PGeBQqTgowOEtqYMTLLX5UfvNT4nYI+yqwKXQIHLiMuRdmz7CTiNQk8Vac8fwx7f/SEK6xT6LAPDc9z4RDuAes2V2iSdGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hvYm7c9J; arc=fail smtp.client-ip=52.101.128.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfdERzLAHE89h3ABeumjm48B20pyc7rFxGYKmToqGE/7OvGld1kLJT04o0DSM5DPsEKOI4JqKQ5sSsQ3vG0IT9GM2xwDzFJ8825Wj4eTtutB4fucDH3nSJebjRQpvz8g4wkh116elRBofcxHUhisNengkck7GD3gImbAdXyDLLFhbNnhTELEE29/TCQ6g/gEdAYUHhMDHrxpCXPVi2aYp+/eeyvPMMaecxq3Y0Wdi9TTKhywcnMFOYU+wQ4lFwLpmILdz7Sqnhn06M5jzdOGGHwqqKnsFuV1c2ExJ7kmasSfAhF208/waZGEWHUlFzCYWd2AVBA6PJWRI7CoIhd8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uetvUSOX0tv7G9s4b/OGOWefafF5rbO183JMhdew8Go=;
 b=SD4As6ls2FUo364PygJYWsaNDS2MxsOEYAJqTUdD5selOJCQsgUHS46YjuMV+CSVADU1wRLVHmfdg1tsKwC07icnOQAar9uq7GqnYAFpy9A2y0gYQdWo23YQ8AqFsocQhrAW3UophJbxlGhtTSkO0j7wQDoqOwyXf448pJScvHOlqWkCkLkNAbPc6tIupKFaiNkJYYO1QvNSW5IY9pLP5GaNHoEex5KI8+mHnEkusrK9y2T1mLZegniJCLr6z9hgiVlMLXGCJzTqBt2wtTp3u2kvqhr11tYaTw7p9TDOdjdKa9suZDaXhfFEozhVYE9BmEaoUfhsPc9Scvnfiy5rtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uetvUSOX0tv7G9s4b/OGOWefafF5rbO183JMhdew8Go=;
 b=hvYm7c9JlC/Xl/dz2Ns9MD8F7teN1+gPVXtRQ9A4BJeNEEXxujM+fn49Z1nDnh25o+oHCaFjGrS9wAUbElIGdkYAAyUD8p6JValM1z/iTZHoiLVxkY5vP4NluunAmTQm8p7k3s2C7OsxQc7uEBuBOj4/kGorfRxTkQ1TQOufjixHrw/jBsjrgNoXC+E0lFcm2jU4m+OkmX/tJN+dync33v1bXzB0e0kQHM+DvVsy1Kj3m/UkE1DUhASQsyqpToKLIxi5/ErQ6SnLnlFf/kWJjYbNxzHSJRBLebYjg5SUtJuUSPyTMUE5PmudPF6CrQw7C7UsGfXWYQaJ4B2zZIdY5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6906.apcprd06.prod.outlook.com (2603:1096:820:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:30:32 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:30:32 +0000
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
Subject: [RFC PATCH 5/6] udmabuf: vmap test suit for pages and pfns compare
Date: Thu, 27 Mar 2025 17:28:32 +0800
Message-ID: <20250327092922.536-6-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae5af47a-cbad-46cb-151b-08dd6d120503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CdiRoi2tU2M0aHLDC5IenBH7Wg3YZ1LjohvPKuoaxGOUFFoemXKOgnY7rsJd?=
 =?us-ascii?Q?4U1maNO8XEWCOdpjKmChF5x1ciKbEMOlPjVD8RYJrlxriUIidzloS03CnXYs?=
 =?us-ascii?Q?DvFxW0icw2Kc8TEn77En5TrrpKV84rYiyfRXhAkUTBjAooQDNV+nYhJg0CcE?=
 =?us-ascii?Q?DrQyVZYVyQ54iqUhe1TCBn+U+Eovcht0KsrkcA5CBHn6zQxwoCkqqvMEDJRr?=
 =?us-ascii?Q?3FgPn8K67pX53sfGoDn4QNoZk5VbhTLGJ2EZzN0SBlN4n/8dH9l3hzwhc/yf?=
 =?us-ascii?Q?NZW5LgNR6EBqG3qXvtzJYs0ySD+rPfRvtFLZlXT/uHhABOiArLYOV/9M4HRf?=
 =?us-ascii?Q?glAL8IyrSASMjwHSCKCIKO3PQuhuT1wHM/IZng7QD+LlO6kbnriyDEabMghD?=
 =?us-ascii?Q?s/1cJEMloAgcbkgbk5s5B0SAsoyEHoPekLEFRYOzxn+ogXyMf/J13tEOW1Mg?=
 =?us-ascii?Q?jZsnvwntXRxuzlwLsvx0faPftU0fj+cX1HoaDp6byF5tFivuszaVoVrEO9j3?=
 =?us-ascii?Q?F8qltPeyNM/btS5jOhJVyOvI05++pqhOiZc4bGnds60y26hiQXlrXy/e9GiS?=
 =?us-ascii?Q?sURFdGO4Vux8MGyvAr0SDHzNvm58PpfjSCcc22VxH3czX9j/PrhjW/kVSR2M?=
 =?us-ascii?Q?NlnGvk4IF5EQGj0rfYxczfZ8AYQan8LIMWrpaAE9Aor4fJNVr+Lje/F+cn9d?=
 =?us-ascii?Q?JYXLzo4IuKDbhO3l7q+sxtgukp79c02NeHM1638FfQvADNMibJVq4N9fM5rG?=
 =?us-ascii?Q?za32h6L+LFDl+7aet2LxWGm2Sj9Yx8L8Yxp/o5nwolvGkPclJGW07cbgUvTf?=
 =?us-ascii?Q?ajoZnZ26I+VyFDQxL0WDBMuZ6HjLxUWWXkUg4St9qzQeUqbTGDGhISmBiBZH?=
 =?us-ascii?Q?DyR2//rEGtF5Xv+BA3stSBfbWCmCDujL7u7otQuJvbkRRGrS+8EpVgByvSBQ?=
 =?us-ascii?Q?bXJBeuH+RiDofA9clhbswoUy4WaTZMDo/EzlhxMKbO3ExcnDBYrUaRH9gQE6?=
 =?us-ascii?Q?48o6t59MEgyAUHFIVqu+QRlxNR+gg6rK5IjCVC+asmRsemR16mkbOs0x5PhJ?=
 =?us-ascii?Q?Nk2m1anhlrODHglcSrSutlEBZqzi3iseJ2lX1Q7q6buvOv/K7dtHxakyTu70?=
 =?us-ascii?Q?f0cwiV1J9ZVEKGVkz5riSucCFUiH+Gkvnnovv9e9D18Eu+7rNXrUJSuzcEuO?=
 =?us-ascii?Q?Xtjvr8v8bFHsoIVCa4hqLwud2Z0NXUUo49v/7CnXPXzfZK4J9hu3W4xlLSLe?=
 =?us-ascii?Q?VZhjk8RaIBzYjjMCjrpMn1hGYBB1MkmNMzv4mUalF8wE3bG900lpQ/VrzR5J?=
 =?us-ascii?Q?4bW+Fm63m73H3zapMxqzDlAX3Fhso2/+aytz+S87JvHbH/UYw5B0kgcSaEvJ?=
 =?us-ascii?Q?xdOW9sj5kqtYDTwG6eNYyPYk/MXC1kHI4RPnzkw6THbsticJMootHJizrIyc?=
 =?us-ascii?Q?+MrouJHXmdXLYTeAT/siOBsKWMwfo83pjuG5+ubF0nIPJHMuH0p3Vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55lSqhd0+rKDjZzFKOoqjMiyOfY/KAudkL//RrZScSq4aYbaBZwQ0PL3Misc?=
 =?us-ascii?Q?952DMjUz7pTerQB+1UCe6dchoCP/K+bfobiqqMFTBFy5p/n7cwxJkuSjCCiL?=
 =?us-ascii?Q?0JW5vDBv6FzlwEv3q0z/SaYvaqeiXTP7dv7Tg8q2cX4Xwz2MfXguydvclzfT?=
 =?us-ascii?Q?Geo5avNqUw4+7nzIfwHXPWZRhuQuaUkZ+CqTty/iHiWettkRt1crHuN15OVe?=
 =?us-ascii?Q?sxBOnNHFPMsjjE0T96SqK70tgfhOpE8/1XwMa7ICxVNZ4lqNRtNZvt+MzbV/?=
 =?us-ascii?Q?M7uSIJLLmYd+LumLy0GngfF+C+bycNGwCSotkGuqPrMF3fR5XqdWe8BaW/LE?=
 =?us-ascii?Q?K2PNNenyixm9HnTu4aoMXjgSwHK9PWZcABr/4715lAUoCy/Uzgtx30r69MvE?=
 =?us-ascii?Q?5iZtyw/62KZhc9qSjzzwGzuQ53/5OmzyAMv1DsZDJITfhdvvEyM77w1xWIh8?=
 =?us-ascii?Q?+gJdIRkaxEqYGCnV19Sqk0LMslwyCjzLc0o/kDF+qsRgBU+fMsTxSki/9/th?=
 =?us-ascii?Q?j84B29esljHKtvDkeYvEbQ22/9InIowmYc9nqMq2Bo3gthZd6iDjxw8nHkgF?=
 =?us-ascii?Q?FycmlHxmXrIiEmAQ4g+lDmZNTjMbVE/lvpd0gCLvhOXy+kI8Oi6o8kQJmzvX?=
 =?us-ascii?Q?uJIKE6HhQaERkU0zCjiwBwsJcpMgCqgLqPpAPJf5TCqDuFmgkFlhV4tIqOgn?=
 =?us-ascii?Q?RXEgpEh2fumWCMRaVYNlm1bcvMvZtGtHyCSeTwwblfWjDJiYtUS0eTswtrQ1?=
 =?us-ascii?Q?MgHyn7uPXGnrPeDaTaDjS47/W23k3sYtKVnHIB+QnOShrC2m1c9mFokSHned?=
 =?us-ascii?Q?rZYikHQldcNroPIGicTfvcQ5kRdbV+2gzScpmYSXaJN3NfCLP4ddBOWoKk7w?=
 =?us-ascii?Q?qTH0bzBxGQPLvXFKSh0398lj7t6Lem9HD4MyWXeKoUQ9vx4OOEb4SJzjlHlQ?=
 =?us-ascii?Q?aGRkFn19Ngnr9ITnZlgaESW21S7pVP97OJntO36kxDUwQV9sZdXAS+XedN+k?=
 =?us-ascii?Q?NhfHP2+bqlZq3XsTIX7MdSXegH7SqWboCvgxgWYaziQrTDuijwh7wOongZc5?=
 =?us-ascii?Q?Rr6JFJQOWCeOrQ0r9B2ah/ieMuCOUToRlA3kObmn/rxp7lRVVJkDtKk/DuNq?=
 =?us-ascii?Q?3bIrosyqSteC+Tc377oWZI8cUK187BwxvrIJ4bcBr8kcKSsr0lH1P4BYZVLv?=
 =?us-ascii?Q?zaONcdHPapF5XywjC2ZznVtdv0+1w4f5cKlAWf1dniq8RNoLpXG2OmikRpKH?=
 =?us-ascii?Q?FsJbd68QmlcBkMlTpDEtGVJQIU9JRh84yBMHIsnFiQ5uzqD8HEpxZ+217nD5?=
 =?us-ascii?Q?RwZFyTmqx8Xq8pTg7uZGuXWmaCiw+C93Fns9zP7ViX99H3EE3TvF7wGzwf61?=
 =?us-ascii?Q?R1QJ5CtIlEvAMA6oqu1jnTYmpJaYKFEmhL1P8XM0l7jM4mCvrsVF/iU4vLDV?=
 =?us-ascii?Q?QeK1pQDm74ha6m56XrUAiuu1hlsqYpKgZKfi/Urax2cgY8H6jjc548y9EDLz?=
 =?us-ascii?Q?4LxrvKMEblwX9okRgmAOzD0XggDuivasPpczWB/l200GH0kXdVQMUX5pWPU5?=
 =?us-ascii?Q?n0otdiJFAZl90Tu9Mhr02AbFWVItNEEF4AoGXYuH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5af47a-cbad-46cb-151b-08dd6d120503
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:30:31.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfroJ6Lq+FWuDkrE3CdB+8bCs472gkEB7dZXKHsLgYm+QAlUrFsCfAnNdTdP4QySwiDvukvqnyXJwEj9pU82Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6906

This patch both compare pages and pfns based vmap, to show folios
range vmap and pfn range vmap can work.

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/dma-buf/udmabuf.c | 64 ++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index f50e11f0f034..78549a9f24ca 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -556,6 +556,48 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static void *udmabuf_vmap_by_pfns(struct udmabuf *udmabuf)
+{
+	unsigned long *pfns;
+	void *vaddr = NULL;
+	unsigned int i;
+
+	pfns = kvmalloc_array(udmabuf->pagecount, sizeof(*pfns), GFP_KERNEL);
+	if (WARN_ON(!pfns))
+		return NULL;
+
+	for (i = 0; i < udmabuf->pagecount; ++i)
+		pfns[i] = folio_pfn(udmabuf->folios[i]) +
+			  (udmabuf->offsets[i] >> PAGE_SHIFT);
+
+	vaddr = udmabuf_vmap_pfn(pfns, udmabuf->pagecount, PAGE_KERNEL);
+	WARN_ON(!vaddr);
+
+	kvfree(pfns);
+	return vaddr;
+}
+
+static void *udmabuf_vmap_by_pages(struct udmabuf *udmabuf)
+{
+	struct page **pages;
+	void *vaddr = NULL;
+	unsigned int i;
+
+	pages = kvmalloc_array(udmabuf->pagecount, sizeof(*pages), GFP_KERNEL);
+	if (WARN_ON(!pages))
+		return NULL;
+
+	for (i = 0; i < udmabuf->pagecount; ++i)
+		pages[i] = folio_page(udmabuf->folios[i],
+				      udmabuf->offsets[i] >> PAGE_SHIFT);
+
+	vaddr = vmap(pages, udmabuf->pagecount, 0, PAGE_KERNEL);
+	WARN_ON(!vaddr);
+
+	kvfree(pages);
+	return vaddr;
+}
+
 static long udmabuf_vmap_test(struct file *filp, unsigned long arg)
 {
 	struct udmabuf_vmap uv;
@@ -563,7 +605,6 @@ static long udmabuf_vmap_test(struct file *filp, unsigned long arg)
 	bool can_page = true;
 	struct iosys_map map;
 	struct udmabuf *ubuf;
-	struct page **pages;
 	void *vaddr, *pvaddr;
 	struct file *file;
 	int ret = 0, i;
@@ -591,31 +632,18 @@ static long udmabuf_vmap_test(struct file *filp, unsigned long arg)
 	}
 
 	if (!can_page)
-		goto out_vaddr;
+		pvaddr = udmabuf_vmap_by_pfns(ubuf);
+	else
+		pvaddr = udmabuf_vmap_by_pages(ubuf);
 
-	pages = kvmalloc_array(ubuf->pagecount, sizeof(*pages), GFP_KERNEL);
-	if (WARN_ON(!pages)) {
-		ret = -ENOMEM;
+	if (!pvaddr)
 		goto out_vaddr;
-	}
-
-	for (i = 0; i < ubuf->pagecount; ++i)
-		pages[i] = folio_page(ubuf->folios[i],
-				      ubuf->offsets[i] >> PAGE_SHIFT);
-
-	pvaddr = vmap(pages, ubuf->pagecount, 0, PAGE_KERNEL);
-	if (WARN_ON(!pvaddr)) {
-		ret = -ENOMEM;
-		goto out_pages;
-	}
 
 	// compare if pages and pfns is same?
 	if (WARN_ON(memcmp(vaddr, pvaddr, ubuf->pagecount * PAGE_SIZE) != 0))
 		ret = -EINVAL;
 
 	vunmap(pvaddr);
-out_pages:
-	kvfree(pages);
 out_vaddr:
 	dma_buf_vunmap(dmabuf, &map);
 out:
-- 
2.48.1


