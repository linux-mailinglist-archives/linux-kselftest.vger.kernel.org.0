Return-Path: <linux-kselftest+bounces-29858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120B0A72C6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 10:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E60179E47
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175420D4EF;
	Thu, 27 Mar 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UrpvigLh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013003.outbound.protection.outlook.com [40.107.44.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AA20D513;
	Thu, 27 Mar 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067812; cv=fail; b=B9Z55Flqja/W9NvglNKmqGMGQsArTJCaDtn0m7pzFX9RcjWWAEgHQseAK6a9zikMA3aa7fOZy3/N73kzgPCFV+V/ehgoxJx4hzcQAFg9eHeqQMv8MMJfz40eaKTJ/XRLbEckLLZ/5EbB0ObIE8nGM9Afndpj1S+luUN4mzXSpVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067812; c=relaxed/simple;
	bh=/1zxbQI0kw6O3FP5f7KE50rZwXkijnZ7y9MpHl7Beak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcyY+IOdHFMG65GvyUQvVZAgIsW5/wALAHYm1fvvLLEJQ2PuEE3YB43Vf9qMd0ysH1ZyYFVscRLpPVy5H4e86bGr0gluy/bgiUgnr07LCLSbXeJlekF/kfIHtTsBEOz7R29xj0DF1bgRYjAe+7Gwl/8uUm8Wg9X4OXMK5iKRldw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UrpvigLh; arc=fail smtp.client-ip=40.107.44.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIior6L+wAVDMQzmojRkGmmgg5mRSMM/tpZ6mkT/NmGA7/fGILK80PDcKQCGYWv26A2TcOZI2CkuYaTNkUm6HfNs2Tf1eIOgCeJVp5+Ca/sS3iR3Mb5deiqsm3eamdYX0RdR7xKqANawiC2Ht1uSADwbNsu16pcMb2NJvyCLa5rHQiiGAL5evlTeb35rjhEH8GeFUnMJ738YHbWoDOJdujbtLmKxr8+xYGP32tG2T+hPoGJYlaTCPPltwzO5SWnvHWlboEXfBW/ayFEqJ9g5hoYljMUhmSCdNj6cWAGZcUdY2a9ahYnzpAU6VI7o7fbDeGGFRgnpAVDy68M7ULkDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOOnb9+cfRDqAWJwz7ieRVU48ffQ9jXJPy1HhLdXnDA=;
 b=hXY5cO4kLJt4M7MsCM0qt/MjWhH4w/NvQwknG93n92lLHOZNC6sf3IqU9i0WzW/QmOclSAdt3vOUeqCvembBZItcFkf9NgOmmHflILfB8yS++H42iKR+hoLZ2FS61ATfvJoU+HHku0RfvN87dE8TWFLyTcXkxiSzCnTOj/u6p/ptO/Bqn/p5r6JjkgEBCF42n40BVQW7/U+jkLX3KPwU00EPznFER8TrmDIkx422C4mGeM1iI8x+GYTz/dC7KhEzLH9tnsxzDU4wEa9nvsFQJyNSSYxkTmDFZv5NUQDw+1uTOc2v15n6HjPskR7zo63GfifEOFRRoSC8Ow0pyZ6iJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOOnb9+cfRDqAWJwz7ieRVU48ffQ9jXJPy1HhLdXnDA=;
 b=UrpvigLhqzOlQ62pwM3JlsUWYW+PFyQawKmArcmpFQ31+lZh64vuNvHObd2KSmQwtBHMwR+JacbmOOSnZ1CyYF9KHZ0h//xFGy3dBAmS96uouBY5gj1Q0norn1vamGGwc0dZB8L14SS1i89ofLNxNZe/UXpPi5MohLavA3Jaub7l0bxCiUmZzLeLen62B95C/Da6b1YuTT+LbC3fLICPoW6lxC8jdNutblabG9u4xMwR8ieNICxEOxjrDr1C9XSfbb1Cx7TI5RmC7g6pg6NGea1tlvfc09U88nASWwg76Ct0wJ4aUQqg3gUrqV5Zed1Lc+7P8HfqXpPip65n+NexBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB7238.apcprd06.prod.outlook.com (2603:1096:101:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:30:07 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:30:07 +0000
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
Subject: [RFC PATCH 2/6] udmabuf: try udmabuf vmap test
Date: Thu, 27 Mar 2025 17:28:29 +0800
Message-ID: <20250327092922.536-3-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0ecb72e-7c0c-41ce-dfed-08dd6d11f63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Co+QWTzzwfKg2zYA4uptF4A7R7XbC/mMb5CkrSPlpeagVFtLLT+J8HhuTXhJ?=
 =?us-ascii?Q?a6OC/R5SG3m3w9FJAByLYKoBBGYD4ewyAgTpLIj7MTJlR6RkMGskn4NhkK+j?=
 =?us-ascii?Q?GE0iYj16Cp+zIGnZJ8qrFneglfkfyr9bvXE947JOUj1MbnP3FKYwk4t+Nk++?=
 =?us-ascii?Q?gORg0FKafNkGhdivt1Be7br+INeGZvjIlRW4rgquy4NiY2hBr5476S9kqBd4?=
 =?us-ascii?Q?0TF5L3rQl36xpDdf4L9VY32Gp7j/1HDtpI4NzBoaZ2S8TAjKOEwwyWKsAqsw?=
 =?us-ascii?Q?xDb35CPRiPUpnE1lxneVU3rDBmNz8jktsfk6E1Jhy+JqiqTkMw8iBYjc0Lxf?=
 =?us-ascii?Q?7/iri+XQC674eCumL/JhbGLzM7Of+Hhk/nn0q/vclfDv5SGMjzjiSZoBYFgD?=
 =?us-ascii?Q?4V1pngEBn2T5Eq7dZ0WCyUc+Hj6aJ4nxRzOVd+ajk+J+VlAb43yBX4FSdKqc?=
 =?us-ascii?Q?gHmrYgzkUsjyZGuqbNhtB2q7CZLnyHnhrWQtVosiakoL7Qq2o5a/j9QVUCGO?=
 =?us-ascii?Q?98HMC4U86JFNQGmVH+6agDaJxHuRE/8voPpe4VQq4IJe2yxiBOIz+0ODt0cc?=
 =?us-ascii?Q?ADLQVE3FEoTOZfLZbHFcJIzzDBfFTM/6tiNppy/pGtTjgHnW4pmX4rSEhVwV?=
 =?us-ascii?Q?4xJ04ub2IxgJLokgNJBXpGaIN8gMdqx8prbKpBL7iz6ij7096Gq4+KQ25D1i?=
 =?us-ascii?Q?mFENKPH/LRsc1qEsD/SCcUXrSOeu3rPpNfh8wdhKVYxfEUzD1YocZIrFB+08?=
 =?us-ascii?Q?+eCTPQyfq9LcoAgkQU6krmOa6Pn3YCbqZjwpIEkvLUFe+EZxyopHOxfhLFEi?=
 =?us-ascii?Q?8KMlIQNPZOdLDKFffRV0P+5K1D2UgblJ7+KAnLUzqJ7ScJmo9cavvOSb2BaB?=
 =?us-ascii?Q?EhRDeD0PR7fdG2jdfZl6kf92lZcuESHjyVP7qTXH7A8lzqiJnuMkC4Q2k+Gi?=
 =?us-ascii?Q?bUHcH+MsY16w/2tBUeQSA409zZUdHCtW53ETRDRCKOE6mtrXGGoaZvQnljy+?=
 =?us-ascii?Q?pqCAt8Y9kf0dPiLgQZNJEsq4Ajs+cv8h0/aCu0GaeKbmK2wKAnwjW6RLMVud?=
 =?us-ascii?Q?FWGl3X3n0/p7SZbIYWsAbTBA8nhr+www6sn56sR1+2kIlKD8H4j24I+jkOFR?=
 =?us-ascii?Q?nJ0dgRSg1mV/z5djpe0H5hTBVh+xt+yUiYy7jQYANdJEHzpkQSqGYKdQ+JTW?=
 =?us-ascii?Q?JSWVHIV7SaudImmK9ew/1QcmEcdTff9SpMRdKFJ7cRUg/Gt6GU/gYE4imMpQ?=
 =?us-ascii?Q?c2nLRtha/bwafceze4uhxkkYIszPyzD0qsONfhQjeK7PGOAdM9v3ivVua4FQ?=
 =?us-ascii?Q?HLM4in8HtOYbdttmSzAotpQRX+RDGttToJyVbKDAAI8lYpUljoXHgo9hNtiD?=
 =?us-ascii?Q?6LWSSUPXQoLjooqdZD6dAsqJ13Wf9lWZi+d1rXzslgQjiLBQf0FzO6uvnPK6?=
 =?us-ascii?Q?E8OZ53kgZyJFDRhuv3UrbeugfoChas33ABTi71pGPDFRLN+mfIh45g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yj3wbmj8a7axBoU6jt6StdXq3ohbSyIhEOsBU7YoFPL3z07K0PnZlGD3vdpA?=
 =?us-ascii?Q?05lxJ9pA0vyFkMb/xkFMKF2YPEGBdqnqjf8gafpY8oQdMHOq6aFemuxk4o6t?=
 =?us-ascii?Q?qX28KAPcvpiwOjJ5vlcPA9rGax1WgBBSRSelBuBghttyi/kDojh8REgqyCfC?=
 =?us-ascii?Q?pjMpGnADhVxX3lWvsVmnOquWLFBnXMfjvGJn09JOpDUribOAMWsEkjCnYrY6?=
 =?us-ascii?Q?YFOiohj2AUxxJUyS3Cz36WlgF3cVB99Q+dNu/YsSHjyojxrzktdQH7LUTRgs?=
 =?us-ascii?Q?tP114Gj8tSVMHrnNxqX6VHxTCnoDDAP0EACclrIlt90sZvWouroHD17FKmUZ?=
 =?us-ascii?Q?Jdv8miPA0qIE8BMtbuLK0oT/UH9EdTeHqSvXg5iDgozx3ILTUPnrsqqA8628?=
 =?us-ascii?Q?ZVPig/vvEXeduO/E1+J8k8xm6hTlHTB/nfywcjDAMINQKT5XP+xG+IBEFJwM?=
 =?us-ascii?Q?graS/2VXUHqnZnat3yeFHkqF88vjqzJ5hwm1YSii60+xiZTAKZ2bowBa0ZkH?=
 =?us-ascii?Q?fajP9DCfxwNcZ05AF98M5dHC3+8PkCxWYV9yd3CSxzjaHOWjLpYZuaUTM1pG?=
 =?us-ascii?Q?64NKMTyA9UcF59oAmQSJ4FXI523Z+ZzFXhfKRG1G8CWF1zXK8paXMxeZSrr3?=
 =?us-ascii?Q?RhvII51SbDDRfaW1xom6xFEFueM0eZa0O/3l5PrNKA9dfZX5wXweXQp3ra9/?=
 =?us-ascii?Q?YSjtUBIzuLEX5Yierx4GmfK5DraWEimVBdggX33M76QyKv9Jp/b6pTNx5sUy?=
 =?us-ascii?Q?kEC7daDWXwcaMEfEEHorIRCJsEurDw1bsRI5WdmBf7+M4nm9gD2X8vSvUHDh?=
 =?us-ascii?Q?FAOx2ZcHIbPTahgFsZhXGQ32vHSw8mdtDLOsaVT5HfTqHOKiFev5vt4Tkp8w?=
 =?us-ascii?Q?sCOjgPJpMYWTwyNnT+ol8VGJx6ncV2C+vuogKWrwzamazjiK3G49kp+0lpHM?=
 =?us-ascii?Q?ZR/9eA7Ky3o4bcWL9QCGxwftftDA7XBEGrvoVyzG4Xh9Mt0kDDt1K3Uk5K0n?=
 =?us-ascii?Q?h7XKNVtCfObeKhavQ28XI3KJlDshJbakA/w4Awlem5i4zOfWNWqCdC+pSDik?=
 =?us-ascii?Q?xMIF0mb4efNrJpCm3Kz0D0wri82lp6XBpF74URjY1tv3c9oqO8bByD+8lDSO?=
 =?us-ascii?Q?wdVjtvzMT73PuTR8soPAEiugZGQo1k2oOZ5weLX+ZtjTNRx83jPaDBzYnkhX?=
 =?us-ascii?Q?qA0a0yNNH+ISRGAI8HnUowWhRlpPDTdOWZ0eUTiVhtPte8ULVmEJwYPDOd1R?=
 =?us-ascii?Q?HcafXOdiH9iIJ6E+PM+fqlZjC0Gigk0P2UE/dkmrEaPUjsSFptD6oeBRBfsH?=
 =?us-ascii?Q?LdH0OmVfH20D69Ig1se19BlBOiXhFx7Pi7aZAn2rxs5DPm3ZEO+ZLH+ufwqB?=
 =?us-ascii?Q?ZeOhhdmQYs0ltZquLlaoO+4F40J+6qifXXt9n04cRQkY9mQhy4KingVapBsa?=
 =?us-ascii?Q?mRO3Fqn1pYio6cnWXW8G8D6lSiPRAkZZ1zC07jwFc1dpPCxZpnb/EmQR4Lml?=
 =?us-ascii?Q?EszFr3aaf790HU1rANbZ1tKHmMQnMta/2Sj5w9bEc4Bz84AhZ2XeXj6v60UM?=
 =?us-ascii?Q?s/G/IcquIlf75HxcIiVvjMqsk12VkxuHCMGUx904?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ecb72e-7c0c-41ce-dfed-08dd6d11f63f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:30:07.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I5hybCGsaJoB2o72MFFiW8TytJE+8kzwT5gaYEA0XbGMQGR3ipZfJK5bNxcKeL1xChI7sfkZX+yXJ8PjbQIiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7238

This patch add a test ioctl in udmabuf to show vmap can work.
by compare pfn vmap and pages vmap.

But this skip HVO folio compare due to can't use pages vmap.

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/dma-buf/udmabuf.c                     |  71 ++++++++
 include/uapi/linux/udmabuf.h                  |   5 +
 .../selftests/drivers/dma-buf/Makefile        |   1 +
 .../selftests/drivers/dma-buf/udmabuf_vmap.c  | 166 ++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/dma-buf/udmabuf_vmap.c

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 2dfe639230dc..fbe4b59b4c97 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -557,6 +557,74 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static long udmabuf_vmap_test(struct file *filp, unsigned long arg)
+{
+	struct udmabuf_vmap uv;
+	struct dma_buf *dmabuf;
+	bool can_page = true;
+	struct iosys_map map;
+	struct udmabuf *ubuf;
+	struct page **pages;
+	void *vaddr, *pvaddr;
+	struct file *file;
+	int ret = 0, i;
+
+	if (copy_from_user(&uv, (void __user *)arg, sizeof(uv)))
+		return -EFAULT;
+	file = fget(uv.dma_buf_fd);
+	if (!file)
+		return -EINVAL;
+
+	dmabuf = file->private_data;
+	ret = dma_buf_vmap(dmabuf, &map);
+	if (ret)
+		goto out;
+	vaddr = map.vaddr;
+
+	ubuf = dmabuf->priv;
+	for (i = 0; i < ubuf->pagecount; ++i) {
+		struct folio *folio = ubuf->folios[i];
+
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			can_page = false;
+			break;
+		}
+	}
+
+	if (!can_page)
+		goto out_vaddr;
+
+	pages = kvmalloc_array(ubuf->pagecount, sizeof(*pages), GFP_KERNEL);
+	if (WARN_ON(!pages)) {
+		ret = -ENOMEM;
+		goto out_vaddr;
+	}
+
+	for (i = 0; i < ubuf->pagecount; ++i)
+		pages[i] = folio_page(ubuf->folios[i],
+				      ubuf->offsets[i] >> PAGE_SHIFT);
+
+	pvaddr = vmap(pages, ubuf->pagecount, 0, PAGE_KERNEL);
+	if (WARN_ON(!pvaddr)) {
+		ret = -ENOMEM;
+		goto out_pages;
+	}
+
+	// compare if pages and pfns is same?
+	if (WARN_ON(memcmp(vaddr, pvaddr, ubuf->pagecount * PAGE_SIZE) != 0))
+		ret = -EINVAL;
+
+	vunmap(pvaddr);
+out_pages:
+	kvfree(pages);
+out_vaddr:
+	dma_buf_vunmap(dmabuf, &map);
+out:
+	fput(file);
+
+	return ret;
+}
+
 static long udmabuf_ioctl(struct file *filp, unsigned int ioctl,
 			  unsigned long arg)
 {
@@ -569,6 +637,9 @@ static long udmabuf_ioctl(struct file *filp, unsigned int ioctl,
 	case UDMABUF_CREATE_LIST:
 		ret = udmabuf_ioctl_create_list(filp, arg);
 		break;
+	case UDMABUF_VMAP:
+		ret = udmabuf_vmap_test(filp, arg);
+		break;
 	default:
 		ret = -ENOTTY;
 		break;
diff --git a/include/uapi/linux/udmabuf.h b/include/uapi/linux/udmabuf.h
index 46b6532ed855..88f5e5516286 100644
--- a/include/uapi/linux/udmabuf.h
+++ b/include/uapi/linux/udmabuf.h
@@ -27,7 +27,12 @@ struct udmabuf_create_list {
 	struct udmabuf_create_item list[];
 };
 
+struct udmabuf_vmap {
+	int dma_buf_fd;
+};
+
 #define UDMABUF_CREATE       _IOW('u', 0x42, struct udmabuf_create)
 #define UDMABUF_CREATE_LIST  _IOW('u', 0x43, struct udmabuf_create_list)
+#define UDMABUF_VMAP  _IOW('u', 0x44, struct udmabuf_vmap)
 
 #endif /* _UAPI_LINUX_UDMABUF_H */
diff --git a/tools/testing/selftests/drivers/dma-buf/Makefile b/tools/testing/selftests/drivers/dma-buf/Makefile
index 441407bb0e80..e5b131dcc2c3 100644
--- a/tools/testing/selftests/drivers/dma-buf/Makefile
+++ b/tools/testing/selftests/drivers/dma-buf/Makefile
@@ -2,6 +2,7 @@
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := udmabuf
+TEST_GEN_PROGS := udmabuf_vmap
 
 top_srcdir ?=../../../../..
 
diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf_vmap.c b/tools/testing/selftests/drivers/dma-buf/udmabuf_vmap.c
new file mode 100644
index 000000000000..7bd46c909bdf
--- /dev/null
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf_vmap.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#define __EXPORTED_HEADERS__
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <malloc.h>
+#include <stdbool.h>
+
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <linux/memfd.h>
+#include <linux/udmabuf.h>
+#include "../../kselftest.h"
+
+#define TEST_PREFIX "drivers/dma-buf/udmabuf"
+#define NUM_PAGES 4
+#define NUM_ENTRIES 4
+#define MEMFD_SIZE 1024 /* in pages */
+
+static unsigned int page_size;
+
+static int create_memfd_with_seals(off64_t size, bool hpage)
+{
+	int memfd, ret;
+	unsigned int flags = MFD_ALLOW_SEALING;
+
+	if (hpage)
+		flags |= MFD_HUGETLB;
+
+	memfd = memfd_create("udmabuf-test", flags);
+	if (memfd < 0) {
+		ksft_print_msg("%s: [skip,no-memfd]\n", TEST_PREFIX);
+		exit(KSFT_SKIP);
+	}
+
+	ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0) {
+		ksft_print_msg("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+		exit(KSFT_SKIP);
+	}
+
+	ret = ftruncate(memfd, size);
+	if (ret == -1) {
+		ksft_print_msg("%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+		exit(KSFT_FAIL);
+	}
+
+	return memfd;
+}
+
+static int create_udmabuf_list(int devfd, int memfd, off64_t memfd_size)
+{
+	struct udmabuf_create_list *list;
+	int ubuf_fd, i;
+
+	list = malloc(sizeof(struct udmabuf_create_list) +
+		      sizeof(struct udmabuf_create_item) * NUM_ENTRIES);
+	if (!list) {
+		ksft_print_msg("%s: [FAIL, udmabuf-malloc]\n", TEST_PREFIX);
+		exit(KSFT_FAIL);
+	}
+
+	for (i = 0; i < NUM_ENTRIES; i++) {
+		list->list[i].memfd = memfd;
+		list->list[i].offset = i * (memfd_size / NUM_ENTRIES);
+		list->list[i].size = memfd_size / NUM_ENTRIES;
+	}
+
+	list->count = NUM_ENTRIES;
+	list->flags = UDMABUF_FLAGS_CLOEXEC;
+	ubuf_fd = ioctl(devfd, UDMABUF_CREATE_LIST, list);
+	free(list);
+	if (ubuf_fd < 0) {
+		ksft_print_msg("%s: [FAIL, udmabuf-create]\n", TEST_PREFIX);
+		exit(KSFT_FAIL);
+	}
+
+	return ubuf_fd;
+}
+
+static void *mmap_fd(int fd, off64_t size)
+{
+	void *addr;
+
+	addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		ksft_print_msg("%s: ubuf_fd mmap fail\n", TEST_PREFIX);
+		exit(KSFT_FAIL);
+	}
+
+	return addr;
+}
+
+int main(int argc, char *argv[])
+{
+	struct udmabuf_create create;
+	int devfd, memfd, buf, ret;
+	struct udmabuf_vmap vm;
+	unsigned long *vaddr;
+	off64_t size;
+	int i;
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	devfd = open("/dev/udmabuf", O_RDWR);
+	if (devfd < 0) {
+		ksft_print_msg(
+			"%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
+			TEST_PREFIX);
+		exit(KSFT_SKIP);
+	}
+
+	/**
+	 * Normal test
+	 */
+	size = getpagesize() * 512 + getpagesize() * 256;
+	memfd = create_memfd_with_seals(size, false);
+	buf = create_udmabuf_list(devfd, memfd, size);
+	vaddr = (unsigned long *)mmap_fd(buf, size);
+	for (i = 0; i < size / sizeof(unsigned long); i++)
+		vaddr[i] = random();
+
+	vm.dma_buf_fd = buf;
+
+	ret = ioctl(devfd, UDMABUF_VMAP, &vm);
+	if (ret < 0)
+		ksft_test_result_fail("%s: [FAIL, normal test]\n", TEST_PREFIX);
+	else
+		ksft_test_result_pass("%s: [PASS, normal test]\n", TEST_PREFIX);
+	munmap(vaddr, size);
+	close(buf);
+	close(memfd);
+
+	/**
+	 * Hugetlb test, 2MB
+	 */
+	size = getpagesize() * 512;
+	memfd = create_memfd_with_seals(size, true);
+	buf = create_udmabuf_list(devfd, memfd, size);
+	vaddr = (unsigned long *)mmap_fd(buf, size);
+	for (i = 0; i < size / sizeof(unsigned long); i++)
+		vaddr[i] = random();
+
+	vm.dma_buf_fd = buf;
+
+	ret = ioctl(devfd, UDMABUF_VMAP, &vm);
+	if (ret < 0)
+		ksft_test_result_fail("%s: [FAIL, huge test]\n", TEST_PREFIX);
+	else
+		ksft_test_result_pass("%s: [PASS, huge test]\n", TEST_PREFIX);
+	munmap(vaddr, size);
+	close(buf);
+	close(memfd);
+
+	ksft_print_msg("%s: ok\n", TEST_PREFIX);
+	ksft_print_cnts();
+
+	return 0;
+}
-- 
2.48.1


