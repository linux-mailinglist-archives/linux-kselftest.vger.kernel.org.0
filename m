Return-Path: <linux-kselftest+bounces-29857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71010A72C65
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 10:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DDB3B929A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66E920D4E1;
	Thu, 27 Mar 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hCHq2mCr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011015.outbound.protection.outlook.com [52.101.129.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DA20D4E3;
	Thu, 27 Mar 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067803; cv=fail; b=kzHak3ZPdQvA/aWZPfQF8801qTMtMQHac30i3rTVG68LLuFmCnRg+zYQNfOcOaiOCujqwksilGq6LdXG9Rt979p/YInlJhXUwT4CP+J6INUZXPczhc7pwq3Psh+fI6ycuLtDJZqp433Ms45Oo/axFvdKRjeTpLITJ6KWlD/6Gxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067803; c=relaxed/simple;
	bh=ys+xteQV3Naj2P+OufJfKvELyTzJWe0Rlc//ydd1lVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOlI7kayfSOKItEG98ebMzE9K+7+Q5lHyXhwyqH6XcJDzVoh0KFHJ0omQNDz62dFzlmMbOHPQ9f0UDbjYT4iiV0acUONHTP4AOJgVTm4bFB7nPQDNPaaaCc0HyiNLb6DV6VWwPna+MbGKjvPg65nzoOBTozIIGKd7LwQnI3Bf/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hCHq2mCr; arc=fail smtp.client-ip=52.101.129.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tfo35pDeEKGnZkHdM+D11T3KUNUDzr5IThu9OWNYrNbr+ujQz4ENnche16XNnZMyCG4DLgdnycsTWfgn3L9pUMUIMzkiCoegAwywuwxR1JFabFY4bNfsGbTPaaaQtAbQTAAFJEdvl7Hs+vYaO3SlTEF3zTuCT8zyYS5H4ui0Q88KAyaomMFwEJJP2RZ2xrhqmiExfzgEDqN4TQN507oAsQnb9MaCzfqVV+Gtqzt6J2mF81ta3BdXuU/GV3umE4iW/tfcKhy1f/FoQOjnnMBtudjIhX+l8hnU7wf60ufNuuZdVtdIDpHTIqjl5NZj0ppLMYKKeuDJJCNjFl+/8lv4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UKPkJkXQcpTYFRYJI8oQc3rq8StnSPcEHSqw78HvWw=;
 b=q0ZQyl+KrxfZH8f5FmMxzsGNEhMSP/t+TWP/tgfOZJJrUNFmkpFjTvcTGZah4zq08NPv6GOGkWj0DU9Ql4G1Wfc/o8AUWesd6MWIri9pbIag+mVDhC9HIf3Mm6CahDSgWNiLWXRXV2E7w0Qd48Ra2bsU2YCSgEJsvu/3J/gmAbEUuA3DWDQuxHMSZ3d0jsg/8gq6kGyZppMh1WU44HjVgeKbpsZPETzPIPnXqeZLPfMgUNrco71+bdxEf7a1ROFiw+7O9gVnKoowZdLGl3iNZ34gDsEPJqIuCfe/6+vI4++hpI926ZWGo8xNdZP4+e6VlSJBRi7LMmnyfH2GdThECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UKPkJkXQcpTYFRYJI8oQc3rq8StnSPcEHSqw78HvWw=;
 b=hCHq2mCr7QKrrJYH1wN3kgeH6M1JN+wqFzPahFy/kZukdFJdRwLDSd7pr3YMLQhYhMFHhFaiEsN3KsN0UK30GIpk1hWL2ZgWyG1KV438BJjnfD3sgPWA+OywTOaKDXsU9iWKyerIT+TUBdv07K4urqHg4BEAUTcszFW6Gb4WpjzcsYw4CFe2Yd1Nfe+N6FgrzWCbBTIAKbVCNYy7xMfbgjqCRQUuPK/c71eixQVteVtpM3s+yCwsU4adH2rJzDQ0BQ2cU+Siry0/CnJyu95oe18A2peTjfBSxdWkepz37hqkusVqnwv9ar7riPxYBN9EBrhOO2zZka7LxF/OImAhiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB7238.apcprd06.prod.outlook.com (2603:1096:101:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:29:58 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:29:58 +0000
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
Subject: [RFC PATCH 1/6] udmabuf: try fix udmabuf vmap
Date: Thu, 27 Mar 2025 17:28:28 +0800
Message-ID: <20250327092922.536-2-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03ab361d-f090-4e61-fc2f-08dd6d11f12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uICxjpcRpGGmBCQyl4t3TIAEH4EwqwE+luzLAg9hJn+ArXhvnKrLCmBujgAf?=
 =?us-ascii?Q?7m1AwF5pv+QTel/eLVp/ZekMvkFJgPfF6OV/rswByj+M9PuBDOmLEnEnS/FW?=
 =?us-ascii?Q?B4nppNNS4gww1640SBRf/7ulXPYbuprbli4CAcrC1Wv5hq8PZkwCidKd7WzK?=
 =?us-ascii?Q?KNLrr88N21xYgkVt1Xc9ZOof/gFONcMYqLL7cgrOWoHMIA/EmODt+QkeJiuh?=
 =?us-ascii?Q?Yosxg6r7BtO6ILw+FVuJXiMr/zCHABOSf+IO9Vvgb2bXpy+wki2PT9eh/CNk?=
 =?us-ascii?Q?EHNie8ZlVzWT8j+Q2nJ4YjZyZuN4T7KZqvLN0Ib5oaBgXr7O4gEFDTuzJzTE?=
 =?us-ascii?Q?WmMCWD2NrwYErNi7d8Dz2S6bBYocqqDLR34pGUX8N1WlZDM0I086dw58+S4t?=
 =?us-ascii?Q?bicZXHR08ndkY7tOxpCr3X1TfOlslxMUedMM9v+oJ1xh1Q5ACS6uSjFIK4F1?=
 =?us-ascii?Q?GHn94DgQtwShy5+4cpXGVJoCWUEsOhttttomJownt2ITNq/SLnS1zqsT/bdq?=
 =?us-ascii?Q?n+LjUT1+7Hux6PHshn0g1cF6PFAmDkrbwIiyqoPnhDQGOGdQdjmIIOf+4ZfM?=
 =?us-ascii?Q?hIwSXU5gKGVE79VjuTZRIMkKW5wbQe3pqQaW9wcwSjf4YuCkLr8D76gsw3zw?=
 =?us-ascii?Q?rPG9uNBXXbAzkHoI6LOH3dueeTbPhXc0sxweo5ZaCElxn1gFLslg/FArNasA?=
 =?us-ascii?Q?y78DOSxWEIsA0L1rFd5rSw28Ur8H8RoZpGEtnTcv9HZtrR8PIxS3L3FwJ6UK?=
 =?us-ascii?Q?lqff8HolaNSjW/FtImBJ9OvOP3cbAM+Zq0XDTltA+iySepWHYcgjY3g1thaR?=
 =?us-ascii?Q?LsIcvc3rbCSMkNvtMx2UxJkDYT2L2HQNrlbw4JeTn2mN8R6yOu688DEA2YzP?=
 =?us-ascii?Q?d+pltpgJNsvh6WvGPeYUYMd49knawoxWHMaNySqOZ+GXEMfToznOxRtHbKbw?=
 =?us-ascii?Q?kalMfXZs5oHAaJHRttKiQOP85DLSuwdb0SDSVNjroLyFuyV976ZBRKJrvqXa?=
 =?us-ascii?Q?L06253Ikl6QvF6oi5tzUKRznJfDPZCvQhkTtB0eAx0X1zzHQFndyX7lrw9Mm?=
 =?us-ascii?Q?5VX2ybh2lbF+e6sJ5Uk4vCtuj12583VHclMQmhVrT+demCU3EDu7rdbHpOyf?=
 =?us-ascii?Q?RYK2iZzhaX04D8baP/82WarPq8dLPnM1QdhVtSNMmkrFKPI+PpFh2ExlTp0P?=
 =?us-ascii?Q?1bz8BTE9z9qUfGPuGhkoAMXFQIK3buQhUAp/SNcG+rjvLI0pg1ee8Ibce5jI?=
 =?us-ascii?Q?WnRNsWCLYYOD4vgyPYYRaVT9FSVSZVCF2L3GVAi9uldyF3i5W33qXOAvNPiy?=
 =?us-ascii?Q?hfHJJbPx8Z1fzn6lzkn6iqS1bLdmiWkFGMgxiBHBDVvj5W8dY1zxF+DaStKL?=
 =?us-ascii?Q?4Og2DCzt65ldOL5dfsZ3yui1ax8AnTqYQdEJGXiA5cl/fL6bO7QflM/Wv6mH?=
 =?us-ascii?Q?0Y6OGL+HYd4N0Zh20qiW82ISBjDvqklm6usrpK48X/OtUUOrC39UWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2kXJHhKbG/nL+hPM9quvjchCwbBQS/llE5B2oAZTthwFLnAKlE7y+Fh7Bt7X?=
 =?us-ascii?Q?tCqwG+UApkWHWbEys1etXgjlvB2L7VWqq6Srg1kT53YHOojE26Jy0SipcYus?=
 =?us-ascii?Q?I5rWdwgdqqX0AgRqk9aUia7fv62gOqoFwE4l/IXiUzr9vseFbadfrmMeCQ3u?=
 =?us-ascii?Q?0Y1hD8YGFDw+k81cgdlKJ+nvU3btdP763+ywGurXin2mxzWTqbxzCu7FbdgR?=
 =?us-ascii?Q?7kkoxmWa1rgr47dV7qyCG7AlH2LoLZbIgZH20vPtITDd/WxClECSDo52Ie27?=
 =?us-ascii?Q?X76tTs2IYVQDM4p9/BY5BhxWlX6Uf+QcOobGZSJszm7Ts65E/BTw9TV9DACT?=
 =?us-ascii?Q?ShcZRqf+aXEA71BcMsWIKqT42RIzhtRZrWNDDF5g6VzDYhbtSBDq2sdzasTq?=
 =?us-ascii?Q?fty0z9DI1+a5Y4knHpObY/FMyj0M0mp3y0LsMkzudy5E8QVKpP32rI/GEq+f?=
 =?us-ascii?Q?SJ+2pYh5bHwg7B80FIg8Q7vjnQg5Gi1liR6dsLw3HEbolGvG5GVhaxJw93GB?=
 =?us-ascii?Q?emuDeCoBCH70kwBJKCTkJ+rN8Bm350lpT0PW7ndDFLsPK7caSl51InPnEba6?=
 =?us-ascii?Q?4gPSAQUxqo8udUGe0meubbeLSDUoFzRq29yGKDiwS8scK8HdfMQq1sopUKED?=
 =?us-ascii?Q?yUSvURb2i/a6W551nO/f+IECKJbnRQ+SoNVG/mMLcMY1KVGmwebx6UArCaN9?=
 =?us-ascii?Q?PbXWmYLZxzX2HBSgl1OFA+OOtdutxf7Y4964T6VS2VptwZR4HzKBzgXZi2cn?=
 =?us-ascii?Q?vof0Feeh/VJcALp+9xLLAtC18XTLqzpcsjyvw+5dwFbtB2qBJzWfKPfE+Qhj?=
 =?us-ascii?Q?2siYmcoprk5uUgV9SgPTKvFf9DX8atkVXo+BBb3MPTmkYedZzexv/ilq/Ob6?=
 =?us-ascii?Q?B70vLU/yNKfJDdO1R5D92QRTdaaV7HjZFYah1JWwMIpXr3UqdZmW1QY0FeiJ?=
 =?us-ascii?Q?xgLl2ZvAjY/Y+b2QHOVgTNXLEib8a2jVTPxWthmpqwGdB4ZDbyZZLV1PZv+w?=
 =?us-ascii?Q?e4jLtq/D5CdFT7Z0l+yVLDX0o4oqkbbJbdvZI0UGzWwoeSKP/f+tGz4PSFKm?=
 =?us-ascii?Q?1XwXBDER9PtrM2yNdS2ozS2DlshUrMP7Gfip8sp6ncOnceC/Bkngy6Zyx5cA?=
 =?us-ascii?Q?YnOnm6bHfgcs/H46TDiiTCX6MvpJ6FMR845wOyyF82LwOkydD1QoOjshCIhg?=
 =?us-ascii?Q?IPTbz+ir0Wmung07r8mGdOj20IGURmeU4idcxe1JjFLAKl85I3gqA4RS36wx?=
 =?us-ascii?Q?p2FIydxx/gH8I9aOH/wgQg6l6OE68wh182foo5X9N9HK46MTfEtsoyt6VFud?=
 =?us-ascii?Q?klJxtkK9x1/BdvqYyxWbwIsuFpfmHb8F33w1v8ajZRyoWRboTFqj6FaucDEV?=
 =?us-ascii?Q?k972dZZL5aKHN7Il0Bj1zJZTJZWbXB12x3uJJ1dPWQj3E28BoRVaQayCipr+?=
 =?us-ascii?Q?egzDxU6w/Xab899r99/r7KSkFQirTN7bWGbiJp0Rao/w75Stb7ynCS4xhAXi?=
 =?us-ascii?Q?HDRJJ8EJOK5xAAhpTaY6seIzgi2f8n75owboaPF639scUhcCZBZi/y3qiTzr?=
 =?us-ascii?Q?W9eS+wwM5guY+3xBfJhbw2Pl8/VZRy+F+CdRVCyd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ab361d-f090-4e61-fc2f-08dd6d11f12e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:29:58.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKmYFyDrV+V4sLIocOHpikwZQaZ6p//m1+wbrnIBK1MKEmC+iqUUDUth6FGMaPJb7tCkt9hsfG58XfGn0J9hDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7238

vmap_pfn design to only allow none page based pfn map.

This patch try simple copy pfn vmap code to fix it.

Fix vunmap_udmabuf fix match with vmap_udmabuf, use vunmap.

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/dma-buf/udmabuf.c | 49 +++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index cc7398cc17d6..2dfe639230dc 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -106,6 +106,49 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
 	return 0;
 }
 
+struct udmabuf_pfn_data {
+	unsigned long *pfns;
+	pgprot_t prot;
+	unsigned int idx;
+};
+
+static int udmabuf_vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
+{
+	struct udmabuf_pfn_data *data = private;
+	pte_t ptent;
+
+	ptent = pte_mkspecial(pfn_pte(data->pfns[data->idx], data->prot));
+	set_pte_at(&init_mm, addr, pte, ptent);
+
+	data->idx++;
+	return 0;
+}
+
+static void *udmabuf_vmap_pfn(unsigned long *pfns, unsigned int count,
+			      pgprot_t prot)
+{
+	struct udmabuf_pfn_data data = { .pfns = pfns,
+					 .prot = pgprot_nx(prot) };
+	struct vm_struct *area;
+
+	area = get_vm_area_caller(count * PAGE_SIZE, 0,
+				  __builtin_return_address(0));
+	if (!area)
+		return NULL;
+
+	if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
+				count * PAGE_SIZE, udmabuf_vmap_pfn_apply,
+				&data)) {
+		free_vm_area(area);
+		return NULL;
+	}
+
+	flush_cache_vmap((unsigned long)area->addr,
+			 (unsigned long)area->addr + count * PAGE_SIZE);
+
+	return area->addr;
+}
+
 static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
 {
 	struct udmabuf *ubuf = buf->priv;
@@ -130,7 +173,7 @@ static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
 		pfns[pg] = pfn;
 	}
 
-	vaddr = vmap_pfn(pfns, ubuf->pagecount, PAGE_KERNEL);
+	vaddr = udmabuf_vmap_pfn(pfns, ubuf->pagecount, PAGE_KERNEL);
 	kvfree(pfns);
 	if (!vaddr)
 		return -EINVAL;
@@ -141,11 +184,9 @@ static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
 
 static void vunmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
 {
-	struct udmabuf *ubuf = buf->priv;
-
 	dma_resv_assert_held(buf->resv);
 
-	vm_unmap_ram(map->vaddr, ubuf->pagecount);
+	vunmap(map->vaddr);
 }
 
 static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
-- 
2.48.1


