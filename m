Return-Path: <linux-kselftest+bounces-49280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF3ED3962E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF643008F83
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8033BBB4;
	Sun, 18 Jan 2026 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lnpIaeiu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021125.outbound.protection.outlook.com [52.101.125.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B733A9CC;
	Sun, 18 Jan 2026 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744529; cv=fail; b=ja+J9MuKm1Am2seY0iB+QLecEi0QNec3JibZOSvaZoGNcY/yavdygpBtyteGiOBEc7r8D3uKWhFWQkR0IOPSv2KowePHBVThbusk9h7pCZ2c6xH6dqGMF97horFbynOhrwtM4ur13XEk64ddDxTxmkkmjMv/At5pdEN1knAeAgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744529; c=relaxed/simple;
	bh=cZC/Nw8fk8T0/NaVPVEHelyhMQr5Nmg41tT8nA3096c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZY6g46OwfdleW/a0/g0YePf9vGegyxU8oDSJSCfvUPHwz5lldlraO5o2/+lLmCa0xGSFEGiB+uctInO6AvrbSRln1jQ5T37CNroj4rvjkIdyF0WMWIwo09ovyusN1J+8soo0Xiu2zd9hfYzENmGuSc9JYPRMNFcOggtCy7ewwNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lnpIaeiu; arc=fail smtp.client-ip=52.101.125.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdiPGLACaG+QuXJAN8JUJQ7qtTjQc57rk5VeqVee2u1jBm8dvKvxIumsuUrkzkdQKwRsV1OdVpp9+gIFGfQQX53dYT1eNneBTfYYwI+L7d24ZARiM9lh4hAyjmhU9rk/rd1KfONPfiGDEl3XrT3fF+pZ73y7Ps3rwIEkrcL+rDa5VD+qmiuBhw4KIku8yWsHiiNoecCMx+Xr7MsE6+ro6E5F16ygqGstrM7ifRoMI+sYt2hV9N9cTmXG7nh36PeaTkg4aiHhba0qxPDUL1bXKdQ4MP9WIzGST9Z14e9aveZHNxhjJiGxJUWBWcddr/5knIQWr659qPL8HXWMuRoWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U33aehvTJOVrtOSkpfnhADG7GhQcHFK+N25Bxl1DX5o=;
 b=St0PSstAN0H1ljPDr0cOZ4C++bkbUhbj0aDgdc7Z99eB1ZKlStkLfN2B6pz9IQqsuBSe39s+atIS4XEABdPWDXIqWJHlhyWqDC2LN50G+AIZn76R9e7hS7qc9dJIOVKRkp6eM4ClLtRACYl46q7i9F0ScS6V473zHg/AMFjkOi4J2X+J8D8IBUyiOpwRbcyTedCIImecYksBw90dg743gKfAQadtKRMQ2rhMO3bpGhoNwMw0fgyyPOf1E5UeZmAEsy2zNk7qcWtyWtuFBEXT1Ow4FCEm136y+MOZK5qZgTthU73n+TbnBQRprKd+WIjD9FMYOXf4e1QENmbVbZorUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U33aehvTJOVrtOSkpfnhADG7GhQcHFK+N25Bxl1DX5o=;
 b=lnpIaeiueE0SmX0mFA+psU6olItJEcAwPkkddtfAU2858FDwe4zkor2SYwnQ8hVOX3nyViyv1Gcxaasi06SWO1r84DtfaSWNcnYgpdVlPQfu9Wa1cMhucsKYGwyl2W2W5UMa3KxivttDofWS1GRqqg7qEveslEO7OnzVHSqbFOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:55:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	cassel@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	robh@kernel.org,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	iommu@lists.linux.dev,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	magnus.damm@gmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: [RFC PATCH v4 15/38] PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
Date: Sun, 18 Jan 2026 22:54:17 +0900
Message-ID: <20260118135440.1958279-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0204.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e6e044-fac9-4855-50ed-08de56992e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ETU2+CRFm5i1Ryjjc+DxZmpbKJNIcMfaiOdntj7s5cONkKWzSE4vZ+M/5ZlQ?=
 =?us-ascii?Q?03djsYPfzazc1tFZdI7ED2pQshkXiiRBLfZ2CRjiTnt9L6DYcQmWAXU7ZDUA?=
 =?us-ascii?Q?y40pObsh6aRUY75l4FSaVBF6On+UYXmUjW3eCAtWA0uulGYJvkZeuwsFv8QZ?=
 =?us-ascii?Q?UpDSV8wZ6xybaPW0Bs0Pz5eAqJFh+VpYkWofaTjldd/ZRsS/6Vx2+3ofMB32?=
 =?us-ascii?Q?EVq1Cm6W+muMxGRJ+kXDtJhfLxINz1P/pBkYuxlhSgERT04u7PlI8AaNMOu9?=
 =?us-ascii?Q?crM+aNjynEG4EXvskLdfR2/VScHt+x+6urUA4z5FTIV6KXA2pT97xidgFh1E?=
 =?us-ascii?Q?uw+PUWVZJ4pngT0nr8+yt63zT5V1260yeKTKVAtluD0aTzDrq3jJ2uXVqaVT?=
 =?us-ascii?Q?sDhdwZJt0SLejAc0MtgRNRRdztECh3dP0QY2PTfxK7Jb91PsBFdOY0X0dus7?=
 =?us-ascii?Q?UfO5KC48H2jp/x4oEIpDqUGh7mpaW/zerchT8qyTlvdzlIkhADyopXLjNG7l?=
 =?us-ascii?Q?y7ys9ouSOPK358qKwN2F5lr+STDMqZKhmGqUgnWTMHej2R0N8/QFyAlKqvUQ?=
 =?us-ascii?Q?qudbtCVfwnVVDU5gHJEiDY7FIzu3hcV58OXiK1I1uXWQID9rtVgviUAIJpSE?=
 =?us-ascii?Q?jRDhMlhrw74LQkHc0hb0zmhgYUY/a9eJyuL7hPJm+7Pf8BuEokAJR5XIWGmT?=
 =?us-ascii?Q?72aTnDiru75Uj5rjmiQMb265BKWB3lWmEvs0HQz8w5lE/Vcg7l3FYtoCguxt?=
 =?us-ascii?Q?8lEm4LRzQ9092pz2fvZKiqWky8wyxn9Vc5oUQAbBo0cAW4QpbqbjXqaR/iKI?=
 =?us-ascii?Q?9nW2hMj1j2KrPtJPbl8qyxvsRWvPJ7ffw3QwCdMMAFTryV6kmNuHmHRKOHVZ?=
 =?us-ascii?Q?JGVBXQH21gR43L93t+lI8w1nkm5ETmGPtq+STNgVEaYmakKXovPwOmd/AUg9?=
 =?us-ascii?Q?vmiUX6CwscJFSREBbOUtpiqSdp11krBDyDaBCc9lG0GJ0DuXKDDpO4QCLqjx?=
 =?us-ascii?Q?orsY/FnhRsXtNPvFKgd5bePdnOaEFBMhMETX7p5PCTSb2Dc0Y0zWS7i2bPeq?=
 =?us-ascii?Q?znYXN9Mmmlc/NH9niyhRe/YmlW/sQTjOpe8L/gJVDDAbevf9nxpb9mOft/lE?=
 =?us-ascii?Q?1qiQnK5KrvGt10xiR6Sgzi25/eiaDWbLKuhYVl/zY3qDaEMQ4pohAMDh0Klx?=
 =?us-ascii?Q?AEjh+igEAs9UdyGYD0TPmBbg3qNHfTEM7ezVBxGz7K0B+DRz0+VgPbZ5/gCn?=
 =?us-ascii?Q?zGKzXK8ibJ/KAyAzMKisYbtXZtDrJrOh4MObGBvvmXC/GuijWf/3PL0M25EV?=
 =?us-ascii?Q?KKKBDk2gIvU/RFLM/PgaYjCeppUIgo0l+Qed5xDnhgLHQkCETvSV/XK7BVQR?=
 =?us-ascii?Q?Ljm7hHispunfthZYXvckjvc/Z8mCjC27nf5won7OCwYmGtUG20M61TrhHR8x?=
 =?us-ascii?Q?cy8xu8vh9YEcJqDRirTPU2TuIOYKMJaXCXzyambjIAhv794+PQymjcymeiPT?=
 =?us-ascii?Q?yIjkrNqEHfSD3xaV0JtuxuSjLqcEbeuxDCX+hwFwplvg8YzTpwZWklF7+nA9?=
 =?us-ascii?Q?wSkjTJctsQRRzmDndb+givtB06hUmoOB6Sgv+iVVMhjvWYNdlTeLNbqMh00D?=
 =?us-ascii?Q?VA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+KrN9XRP+ucVIa8b3B7MTlpkdsjjaq7JW9TrgVHwVHra+RHg1tHc8gnIWpv1?=
 =?us-ascii?Q?UK4+zRYOCd8VWDtnhxoT7pjaGwwXDw6B4W71CAk7zCvuBVtexalF+aK7boex?=
 =?us-ascii?Q?nCEiYClCchLpFaN416aI8oPNEtkvd+kzJrXQRlxzQNar7lkTPFGv8NyR7B3H?=
 =?us-ascii?Q?tvy/lAy/tgksdn29Wf3ef4Eg95Q/Lofl9fXzB7f08oNKAihwn5PG+04MXckj?=
 =?us-ascii?Q?5fLoVX+ySUeQcEf5AhwH6+1sOF76Qz8QVKocnY26qQdPUocMLS11D3o9YVlz?=
 =?us-ascii?Q?ODSj4qoNOVulkLogVp0un4nUZIBxm4ugaOMkT0NiWjOEBi/33HRR33HjwJgE?=
 =?us-ascii?Q?nN0TxJSR1e/GL6xLEx1+yaL8tJ5QUTmdIsoFs37zoS/tMqwOYsrWzPFJMQRf?=
 =?us-ascii?Q?k9Ek9Ae3HYBF4p4wwIiFs3nbVjap4xtXkQinH3CGZx4byQH8E7e7UA6UC2gM?=
 =?us-ascii?Q?J5ZNBXh2H8RG5fc1ENjoV3iHV0XsWthwRqa7LoUCoQuihEQRYYUnMrBKer5M?=
 =?us-ascii?Q?HnsIetyClXpwG+CLpxVMyLOhK6iaL/iukcP3nbRG5rXA6Uu4DNQMYFjvznX1?=
 =?us-ascii?Q?Blh3LyRwoNXPKmKvoF0WETqYxA2lnQqphTSoi6seNS9N3TNQfWH8+wpDOf0o?=
 =?us-ascii?Q?R8kESkZIXc3Aj+P9neozs9mdOCAc8ezAEZx4nZTkh0kJeFK19JX5pJDkDPEp?=
 =?us-ascii?Q?KU6FEh4PcDPv5rtZmjGe61KJBkotCeuhw8r3sEWhB8a1sezjarj62DV8rq7x?=
 =?us-ascii?Q?7JOVoEjcmiJr74BHOE7hG+WgJ0aS4Pbz7bbBfNWdLOBn8vXvUCmqfqHAOK2s?=
 =?us-ascii?Q?dNLHF67LbAdHzv8NeTLmXdZxcO0FDYVg2h/XgOHV2/asxhv29CLdcDOdH2SH?=
 =?us-ascii?Q?fr+9jbYYI5EMoFPcKVRIiKuuqbdB2moDtHUF1iLPDpuz5ZG/xfuBEuLmZK7U?=
 =?us-ascii?Q?PiPXPUqeMNWDcJOmEUyJg5NdsqoTFmWsKVSqa3IU3KCkT/2n1w7LHA/75jDp?=
 =?us-ascii?Q?DredyjKrqKp22hNK2GWzEUxkEwUxmSALLs9vijG28stFHyYe7YxsIOQmizzo?=
 =?us-ascii?Q?ChDoEKryBFWN+mNZlbD6+slo3UI5IFv/UhpZ/nJvYZEUvxYUigNC8nf35Qx3?=
 =?us-ascii?Q?myUMAi400IXX6rMpfaPTwT4EZP2GbNznaRTsahdcHvTVap7+wmAMaHijQFLj?=
 =?us-ascii?Q?jgHu4Xc8E/6Cr/IxZruFFshd79XP6FojUPkOvR9bqpI12GDCvEtJgRuQbi0P?=
 =?us-ascii?Q?W6pmv9Kkkq2nWVPflaRZM3K6vIemx19UVZEMg1CQM0M0GrAmLz+Dk34P1LjI?=
 =?us-ascii?Q?YpT+PDRZtZzFbQ89IYnShFJYrsc/KMsEWc5oAjl5q/JCdYG6I0v+gFRxc63a?=
 =?us-ascii?Q?9v7kZcUAA5ca5XxrK6tlW0bOmRAphgwPmvp3lFzpSwgjtOQzYkVEdgAmUOlg?=
 =?us-ascii?Q?TwDzV71Nr64hc9reftLKDhjs+xU2S4qKgMrqgsMt/cviMyusXNISVFGs0dhG?=
 =?us-ascii?Q?LmTa5gvmO+3GXDaidANezZg0/ZHrpTS+wL1dUeTCj+oelu8Sa0C3Nkq9SK7d?=
 =?us-ascii?Q?owuccPWZIOI2TyzId1YjB5hedgKSnpN69VaIiOvbOkwDAFCuhhZRabDyfwZB?=
 =?us-ascii?Q?X2aZWsHSIGz4GCO8Tqy3HXd1oPNdx6xfHudNmUdvNLGkAjYXBY/IXYOTNuxy?=
 =?us-ascii?Q?OWkiAd3Qf+sK3n/GxQGHYgd13KOUsKlPgtzFBK+LdzImDouREUqcHdIKJVGK?=
 =?us-ascii?Q?N/zx8tVqZMUru58X+EWNpuqvI1eX7RW/GbngGskNwGy4ERU3D2sV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e6e044-fac9-4855-50ed-08de56992e97
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:04.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yS/C6DoC7ivV6iyQWDcEwiBxPM6OQccgUeT8J4ZWHkJTlC93bXhAcUI2/1rMXZK6LjKVA8Ziw7V4ArxvcJV8Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

For DMA API allocations and mappings, pci-epf-vntb should provide an
appropriate struct device for the NTB core/clients.

Implement .get_dma_dev() and return the EPC parent device.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 9fbc27000f77..7cd976757d15 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1747,6 +1747,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
 	return 0;
 }
 
+static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	if (!ntb || !ntb->epf)
+		return NULL;
+	return ntb->epf->epc->dev.parent;
+}
+
 static void *vntb_epf_get_private_data(struct ntb_dev *ndev)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
@@ -1780,6 +1789,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.db_clear_mask		= vntb_epf_db_clear_mask,
 	.db_clear		= vntb_epf_db_clear,
 	.link_disable		= vntb_epf_link_disable,
+	.get_dma_dev		= vntb_epf_get_dma_dev,
 	.get_private_data	= vntb_epf_get_private_data,
 };
 
-- 
2.51.0


