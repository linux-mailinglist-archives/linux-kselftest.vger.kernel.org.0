Return-Path: <linux-kselftest+bounces-49266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E4D395A4
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65ABF300A356
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742F9332EBD;
	Sun, 18 Jan 2026 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="karGdPNS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021125.outbound.protection.outlook.com [52.101.125.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1523314DE;
	Sun, 18 Jan 2026 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744504; cv=fail; b=S8C/of66xe/Ps82KgNnAg+7e2yyotfcmDgeLeM9wZY3gtj5UbMyZXFflb4rDy0mCS1xUbqNpoTkTNFkr3xQE/A22v5yknNXyZ438PKIVrBImwP+F4IlWWbNcKr277GL6BZ4jd5Y/mNR3YVEONxOtLqUqg+Ji3WDQ+CaEJkbdwDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744504; c=relaxed/simple;
	bh=7Uv+GcvL0je3yWvBCeI1aZO95RKxL58xTcLK5kBn60Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bj0Wi80dFfoAQ1KP/8DBRS30LNyamucXTAueMEorpmyFKN2J3TiSjuuz2GJXQ1fCZoePqy5I8pDeCF4xQGGSaLkmr4FmV+mmqV7beEWVi+v4Wk+nJzMFOALp2OZjet2eDsrj4LAPVzaU+VJ9/xzobeuyjx902EKipJvPOKIT5kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=karGdPNS; arc=fail smtp.client-ip=52.101.125.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXWhiqA6w8wqLtzhXcgM9y3q7nUye35hX5b0fMGdR3EyzIksg/e98zgm59w7f8CYNEcaBqGZuZTkmpfzJxfdMlOvHIODHivSnO99iYdBfGbgLMHmVI7+vdoqQJiyy0PppdPLDbktSoZKfrEBAtFLMasvivy/71saffkuGcdwe3d59OoNP5dtrv/r6XVq/yKYzyR4c3Ge9LpeSOme0Yv/VJbtUVPdCDNQMsbitbXZvLlbuyONdh4NPtCJE3E1W1KW4psf6XVF241k+++vd2oQxEORiBfWnxDKZJxfusnxC8ylvWrms9aOeUvGE6XeZN9wPhJvObuUxvMsK6kydjJyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y46Glu+SnqRJE8SQm0RjDy1uu6n0YABOfLNTNLkw0jI=;
 b=ppuZ40vc63R5LiFng5gkICa229VF4dHMrj0lfO59rHvcsMXOeFtsAU/Fh4K8uHkLbu3cHBlUTe8nEDWtUu/xfRztRp1o78nEGnZJrzHj23arEwbZMAQQGzgb7CXeKbfkevO1H7V2zSQqJ3KR6K0XE9p51iL4P6Rf/lnFKJ94sG30RSlp1NyDcVqMYffLBD8ej9q8fRjHMRORIC/kEjoyKYDQspr/CRKnci9fQGgzyDckKgQ+/8SFBasDj9VoxUhVyakYnpInrKoC7JFyidqpzIX3TI8wQ54gjELIFTSsD/7+yvCR+Lop8XKkEyCT7xCBrUhkQ8xz5pSluyqQM65pPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y46Glu+SnqRJE8SQm0RjDy1uu6n0YABOfLNTNLkw0jI=;
 b=karGdPNSRVIcLqSIT43pyuj3kVbf7bzlC2f8K8eLAii3upjF8LHxWD8Vtl6kW/4xRpux7Cw/3z3btC79nuNOw1qKo3xrwSY6+2/vcvCNvZdel/RrHRkpVNQoN/+Vp0ui9WORBk3ecitY4lXeb9ddzApdEH6sozCyJkAsd+qv8xU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:54:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:54:53 +0000
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
Subject: [RFC PATCH v4 01/38] dmaengine: dw-edma: Export helper to get integrated register window
Date: Sun, 18 Jan 2026 22:54:03 +0900
Message-ID: <20260118135440.1958279-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::21) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: b8032315-9b1a-4514-2360-08de5699278b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jPV8fLMGL4NrELE0Q2L3NAbRLFP/X0rAay4U4wvVA/uI2OWl2t+gDX4JLSnc?=
 =?us-ascii?Q?3jTORnCfts1ewndmfbs03S7y2ovUsqJpjdEArpyQJl+imXHvRDWHReyTSfDB?=
 =?us-ascii?Q?Bi7wnA+b2+Ee1r3p69QVuSWj7OlvwJZinjVnCrZ9udL3PxpnIhwHloAdajc3?=
 =?us-ascii?Q?+W3wM2qoAnVg5oBhG6xFqg3oXLI53L9Pj/AtEk7uOVYCnxsNK70eIe7+3woY?=
 =?us-ascii?Q?nKXqJI6YLMUoyRI2ticise1zXhW758y7ES/r6VVwIDTHC22YMDE1PniG1hPc?=
 =?us-ascii?Q?BMMdp1XiTlnJT3FxvptEqbe88PM9y5nQR/KHlqPInxOQyFrBUdGrr1vmCDHi?=
 =?us-ascii?Q?flU/2XGtLXLYAs+2tl8p06PdPTvXP2uu/+en23EOz3JwRqbSdiynyjhiIgq+?=
 =?us-ascii?Q?gEQ+H0M7R7SJWAQ71ibW3AhxvjNTAtjM3PgmRIMJN0zufa+MmGGd9lKG/Ql3?=
 =?us-ascii?Q?JdoKLD1NuhlrD9QlHloiEiEIPReV9xAxuYiQRtlLOAH7LeQflxGQINczpNpP?=
 =?us-ascii?Q?QaovOt9mB2v/ljJoHUMoGPgGS6uU8NKVjWmr5pHoydqUVzefEL80sySK7q6W?=
 =?us-ascii?Q?Yf2Dy7dejblf26/IjcQTCZkmFyFfhq8Z7zJgqWfTC++CLH7uijo1hIIVB2ZG?=
 =?us-ascii?Q?9OHiS9gm1WijiaawteESKbkTFGL8ntHGEXb4YksxDAJzEUlUeE9bFALKccX8?=
 =?us-ascii?Q?T86WBWN+JRraQ4jw2XZdsK0B4KPL0iSQ1+c++VgXjR2Pq1gnYNNcykhD41M0?=
 =?us-ascii?Q?RYRii//iHyFvnUrlnLWHVk0i0s1d8zcViJusFclhFTE6WeCv1YD0SqbXwCtT?=
 =?us-ascii?Q?dGSRw7RKgULwr3iNIvU8/eNAOtVfLjkzC62tiT/rKz3IIlFzWPl7ifC+ULxM?=
 =?us-ascii?Q?PMFHQBZP6yuWFQYUvT51I6omPlRFbnVtFP1GsyAU499pXVZsJorn8VfQTQGH?=
 =?us-ascii?Q?JznYWnJz63X1Z/BVhYH//6yncFN/mNmQS4pa+4dpzryyOAoiubf4xLjKIfis?=
 =?us-ascii?Q?mieBU3JQHriiFbwQ7WNkfv3XpAnPKcpPeadY8tNR00cwC04D2G29fxLHZwkJ?=
 =?us-ascii?Q?JpWvz8IQBPgs4aq31JmAWpT84mZg81JqJdDbenB9AdL01Zw33QeQMWj80lpZ?=
 =?us-ascii?Q?kTQY2ZazY4dryt42Iogz80JXUUiPSrxEcdoppy0CQnsNL0wrxFA+RYlHeRU2?=
 =?us-ascii?Q?+356eEjWVMIWjVSL/E/42JZqept8S4QiSqXBeeYGtZePHzLuiM+EE3hFdlYY?=
 =?us-ascii?Q?E/2owMMufmzSnVRHw8+doahM/LcG5E/0v0j3fKhZzTW3B0fESAg1oexeOndP?=
 =?us-ascii?Q?uUXfd1B1rON4k0M9jUB68jmu2kajVobDYeSZvTUqqXpPN3QPri2B7HsSnTKM?=
 =?us-ascii?Q?d7hcdBRFH1deUkqDH/98MEZxlLQKmVeA6l4x6tGAcghmyqaugc7dA4jE2kDa?=
 =?us-ascii?Q?TH/N5kwgTc81guuOXEE2rM0uHhgpAzUGtxw8IBBcw8B1AdvfJnp3f3eFXd3i?=
 =?us-ascii?Q?9iQ7DjgYRJxLfpSEfwA4KgUcJcDcF2hKdxJOk591/n2WDB2/652RuacDV8ne?=
 =?us-ascii?Q?wV/uzyyVrNKPnemN4HKMWd6vmdplBP9+grQmfXnQD8J04OeI6VeMBlqzES1x?=
 =?us-ascii?Q?iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3KxzwdVmUI6aID+tHXiL5SGpt01cayuoQ6ASYnYSz3m4U2oIBnkg71j77Te?=
 =?us-ascii?Q?D388uVSsibzsWgcAVzvqGVT9+mLcKJST1xRDkoQzrLjXglzuzUlwgE1Z+tZy?=
 =?us-ascii?Q?2TKVccQhIdA57EeWa+4XfflI3zLMAHeoY9C727xLQ7VVipmDR2nDxIOInwGc?=
 =?us-ascii?Q?g9p2AIabai3UGQ1k1GoKnY3mE5/xL72II0EJ9ykfOePDlF7xnw3h7v05J5B/?=
 =?us-ascii?Q?O4fphWzUpfwuHsWFZX3A+1RS31ljEJrj80ftuO+IBzdFh+cF9XpOpVJRUFQI?=
 =?us-ascii?Q?uCv6jLyVjM5In4+Uv3CDJlSWQeInWqtEH+tkhhV9NAcyb5CtXpFgP980bGXQ?=
 =?us-ascii?Q?O/c+XaKt01tMywyHORWz4U8wvd+hBxp/nkONxYZWpugV4B8gLmqsuDVCy+fJ?=
 =?us-ascii?Q?7I3XdVRdt01IBLnNbiy9bvBdtSe2dhKMG1PHjD6VgounZ9gs+WoDvYaASrVo?=
 =?us-ascii?Q?mRynn5Em/ivFkiZc4RLNLzBkN1JSK3iZqxVDzWx15aoUyIQmmerlxTmRyzLr?=
 =?us-ascii?Q?GwQim4t71QlxY5SkvvfhvnrCUGXB5B10b1IKhAN2jsXSAILMbrKA+/ZtopKv?=
 =?us-ascii?Q?gg/BROpdcsEb7JnjkWwucHvRWJUTkBuRuLId4OcGfbwI3Ihb7Cv34ELDXlza?=
 =?us-ascii?Q?nBTh769+VVTiHB+thU76L1cXHpTFZKyOk5Hsj+ViNnm/qGttUWkPU2dveIJD?=
 =?us-ascii?Q?c9uzBJ6C+27NHOGIJdApXtaFtahAbW4KWBD27qVvwk6nWX2iE/W1I5Cr3lK4?=
 =?us-ascii?Q?VuDogBBcCdEP+bzd9jNOclTyw2ATymZ/pdDFsQIoO5yrgQU57W6yyotWcoBZ?=
 =?us-ascii?Q?EzPQ4AVtKmQpRs/OPAMVcwiENt7YxFK1EFszCTymO4a+o9nhMzGXAIyaaJcg?=
 =?us-ascii?Q?c7UvoQdJwyc1zUdZJSFfYv2PpEwX9H/JFM0Xvk1gSbQjHJTEl0jBvlteHkKj?=
 =?us-ascii?Q?+yfJFmePowP0wo+562ap7UFCAthYOMKJynGJG3zVYRjicNEq7jVLGEWwozUG?=
 =?us-ascii?Q?4JJFMrFQi51UTHYYXYoTZQod2ca7bHcAfbOP3jHslSG5KPzscLh/rJ25Fpy/?=
 =?us-ascii?Q?+sLM7IGPvLGc5zlRHpdUgQmysR2/tBJ52xEUB6LsDHj2j/3dX/MofEYiCd7W?=
 =?us-ascii?Q?lSiGFHvKekb6W6GW3ARWjHEYkUcWn3GkmMP3C8k3tZoy8YO6xY47Z2OGtAq6?=
 =?us-ascii?Q?QgmPF/rQ+bI3/XRxrVvni0eLVyYJ69a/TPk3INJ4MPudX6jmzQrqBwuv6HY2?=
 =?us-ascii?Q?0EVJEKvmBD73Cp8p1pG5p+4j4XSPQiUYsEaIQ9MM+Mm+Mdg5qrtzHm5QDWux?=
 =?us-ascii?Q?tSLvziJPSWviijTP2QmHgR12zn0gY0k7aOchGKrAdwtZpzsqc2OBIMwxTcay?=
 =?us-ascii?Q?sVoWKhSSBCxUbMP3v9khwzT5DwP/kFnQ4Lp6Exi2b91IK+vJbF3aAzvvof6z?=
 =?us-ascii?Q?2BGggYRqhLa1lypZCd4hh3FqYe/mcfpf2qGXr9559Klgzh7YSA5+5jOVByij?=
 =?us-ascii?Q?UF3TSipg+6AfYy0PTEerclpjhxizbIIX9lZEAogZruZFbfojus6VFUXNfPlb?=
 =?us-ascii?Q?XPEO4UkoQVQ/7Kb4QBWAaitQQfT2CWie5Yj1+PYrQiXN73c22/XpFRX4jxL7?=
 =?us-ascii?Q?kv5/kMz2u+TSFmUImd/FlP1JW1MzJXWpxXg552vfGyK2mYR1ESyX+6J1ytZ6?=
 =?us-ascii?Q?FoCLpGf1BGtsVTiZgFpyftoNCRPpIAmvDLujrFkw0UhOphYbCBcqX4iowJna?=
 =?us-ascii?Q?jri5RxlaLa/h6DXp0oqbWKArgHuOSyXrdaNay0bdXc5S78emc1M3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b8032315-9b1a-4514-2360-08de5699278b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:52.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqqUljHProuaA2UJzw1E3mdJFQCIzP4Fqmacu4p2LjN6T0n9gBmpF2eA0FszIJ554z8tFGzOI+IX3PJqd/MWBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
instance. Remote-eDMA providers (e.g. vNTB) need to expose the eDMA
register block to the host through a memory window so the host can
ioremap it and run dw_edma_probe() against the remote view.

Record the physical base and size of the eDMA register aperture and
export dw_edma_get_reg_window() so higher-level code can query the
register window associated with a given PCI EPC device.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 26 ++++++++++++++++++++
 include/linux/dma/edma.h                     | 25 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 345365ea97c7..ad18b84c9f71 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma.reg_phys = res->start;
+			pci->edma.reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma.reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma.reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
@@ -1257,3 +1261,25 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
 
 	return cpu_phys_addr - reg_addr;
 }
+
+int dw_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+			   resource_size_t *sz)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci;
+
+	if (!ep)
+		return -ENODEV;
+
+	pci = to_dw_pcie_from_ep(ep);
+	if (!pci->edma.reg_size)
+		return -ENODEV;
+
+	if (phys)
+		*phys = pci->edma.reg_phys;
+	if (sz)
+		*sz = pci->edma.reg_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_get_reg_window);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 270b5458aecf..ffad10ff2cd6 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -83,6 +83,8 @@ struct dw_edma_chip {
 	u32			flags;
 
 	void __iomem		*reg_base;
+	phys_addr_t		reg_phys;
+	resource_size_t		reg_size;
 
 	u16			ll_wr_cnt;
 	u16			ll_rd_cnt;
@@ -115,4 +117,27 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 }
 #endif /* CONFIG_DW_EDMA */
 
+struct pci_epc;
+
+#if IS_REACHABLE(CONFIG_PCIE_DW)
+/**
+ * dw_edma_get_reg_window - get eDMA register base and size
+ * @epc:  the EPC device with which the eDMA instance is integrated
+ * @phys: the output parameter that returns the register base address
+ * @sz:   the output parameter that returns the register space size
+ *
+ * Remote eDMA users (e.g. NTB) may need to expose the integrated DW eDMA
+ * register block through a memory window. This helper returns the physical
+ * base and size for a given DesignWare EP controller.
+ */
+int dw_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+			   resource_size_t *sz);
+#else
+static inline int dw_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+					 resource_size_t *sz)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_PCIE_DW */
+
 #endif /* _DW_EDMA_H */
-- 
2.51.0


