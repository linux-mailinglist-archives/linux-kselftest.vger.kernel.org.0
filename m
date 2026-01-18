Return-Path: <linux-kselftest+bounces-49289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 401D1D39676
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B61430B609F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113033AD8B;
	Sun, 18 Jan 2026 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gq2o3TEG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020105.outbound.protection.outlook.com [52.101.229.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25E33D6D7;
	Sun, 18 Jan 2026 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744544; cv=fail; b=nL2aI6BmdWsjOcMUS9jEddrX7ipPFJXYph5X9qc0yDCZ3xHuDPQcF+CRYY1VNiuCQRzho1EH9m18qkxepRN2fENN6SNjjuMC4+Yhb6l8QzclHBA+XMUEM/XkgXMIuULsHzoQjdKWBjOEeFJ6mlnGEyWC8GDUTsg18+cGbi5lJ9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744544; c=relaxed/simple;
	bh=uGnlQ2PKyYO7KnYnWbg49+UNC1+0bLtSu6mi3PzDiHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfkOvuX3z0QPHX3ktEYPS7QNq87dctGSjZCTBifvHAm9tSWSsMaErybL1QjxiLOU1cYeu5XkRATjVLFl+sPqhR80e1jwkLNXgW5hxs8d3dL6LPM1iuKrZ/ZfyIy4HOVqnvcSMUiLvQkL1OIUz62CQ0+YpcObKy7qvD5jPmyndBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gq2o3TEG; arc=fail smtp.client-ip=52.101.229.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1rORaDGkK6N1gH04yn0CbdS7bpB7zfJ6VKdtVdiYnAhybF0U5Qo6KFiefAZJpy0CRDTX/dQ+P3GexOloDSRyt8joWpovKvaYv5GMxN0GIerJZ28f5l+JOkHzmK/Wez/FWRibCvB4WHxNxoOPwt3MDQ1rEi+vMqGuPfb45gphqfcI/EE9O9OerDnK8d2C5nWchVrYRySj/EfYkppgeJmdm3PUSV/lHxGzqGiukY1Lc3DJRvU7l6nGrCHGhhbNu8RqdiB4ZK9YwcM3ZXi64BwJ+kn47X058L6H9J3rTqTzHgjN7DqeLICmavzXb7JJW82frxIekSxUfX9beJ/ckKVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxvkdWNzuAtzk0P9K+h694XSenPbDbIXDM7V7SNkv9o=;
 b=VUBpl/Og5AWPBmbuClfHsG9P5jvYD4QQ8FovCwNgrw9O/V3U2qoZwTdylMMaMWq6NUSmALBYBna/DFYEMjvxJHbfC75BJluS1ngLjuBotPwo3jxqgDptb86lBky4LtFV7fmQX6NRyTAgA5Qaq6Rjitnf7EGVvk9GIf4whj6U+lDvGX/aAOSixCdft3RtMjJtk6hpS98zS2Spt2zbgJwiSTo2QbtKXKPfIFq+5UBLdpSHb783MxeKBMemaUPCX98U3ebbeid2Wx3YY6tU5doa2TXsrlhh5Lpb1fYqv/DsucnyH7pC+73L88fTjyGxdIBKJtj6Rj1757u7+BIhmZI0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxvkdWNzuAtzk0P9K+h694XSenPbDbIXDM7V7SNkv9o=;
 b=gq2o3TEGn+UTD71VN0Y+xiMsIw92NwRIOKFFU+B3AYGS2KEhgayWMPVdFLrwaZd7H26mAN+kBTFwWRg7WJlYP2JuJ3HyfM66Y5G3s4H9Fp4ch6g9q1XlxPsq0X2TkLOQQtCDAUZUQRjJmgul9XCqu9ByI6A7mAizzyFGtkMquhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:13 +0000
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
Subject: [RFC PATCH v4 25/38] NTB: hw: Add remote eDMA backend registry and DesignWare backend
Date: Sun, 18 Jan 2026 22:54:27 +0900
Message-ID: <20260118135440.1958279-26-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: b670fb6e-319a-4a89-4c2e-08de5699339f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0AuB9T8saDahFEifdDIaNiayEC4bm3nPlqo1Lgg5AUobszHNzUncgtVQgjhh?=
 =?us-ascii?Q?2dg6TgIygbG/U55Hejpsh8lv6M2B8Blq+boNryhIyg31lW+HjP5Q6Qkf4owO?=
 =?us-ascii?Q?Aq8LkFOIYPmhMvARKk3SNAdrh3Yz+6ShEVvpqSFwx5jnGZQcJZLSQsmmNoVk?=
 =?us-ascii?Q?JIa6UxvztWBj5pxtrN+fb61n1fS/2IhBXsihg5U726Lb8RC8lijTtKYEuUUT?=
 =?us-ascii?Q?ImP/UTAyw0uBIzSsE9UcGMDPO5A6ng2e+1Pg/CcL/HCF/0dFqrxd3ZCD/o1q?=
 =?us-ascii?Q?YYKYdBhHDg9MvhZa2AftB7zVARg9U4crKIWSQqqx3XUqMP+mRSXbzPQ86jZX?=
 =?us-ascii?Q?UdhV/OR1uCJx1yaMMaWN2cmbIFiDBR1YmAqthTOHN4X9YlLGEyOIqEfMyzZH?=
 =?us-ascii?Q?2sAZhFeDW9Ehmpphr0J8RcZipBEU9rwdRTpEQkLaIJspqowOIkbJo4qOCfcP?=
 =?us-ascii?Q?oypFZ6wZkyO5iilbI3kXNxcPxJ/bpg4ropOXM11skuhjGWe8LzkafnK2lZ3r?=
 =?us-ascii?Q?oby1D0r4RH4XLF3sMvUt0TzEyZm+tDOGqfShUbLXdkZpQ73n1uPQMDN08/+H?=
 =?us-ascii?Q?ZnATglEcwNfyp1WVdMssQPEcHRABvydsuCYwZncA2LQaJ5r6Lhw7LxsSDDOa?=
 =?us-ascii?Q?yhd/p/cPfIiCbUbYkf4VrPcqAPL2WS2n1X83ZgkEbB2xcAZS0yHloo6izDFh?=
 =?us-ascii?Q?SqZHeFITVCN8qEB0eSGUUGnJ3HnagIH/6N1BmHBZXOp66P1SSZ/KdMhqh52K?=
 =?us-ascii?Q?FYCoo/UPIKPn2OnJ+MO/0GcsMJXn0JUtDMA7nXmXbBgCIypiw692cj2w3gNz?=
 =?us-ascii?Q?PDVxTAeOALylAtqSrWvWf9Oskwa4VW/nTU3BhzX/6Rrvs9qNrPtHRHapjdNM?=
 =?us-ascii?Q?KcP3clb2VJaizutEJwGGKmAaaQ2ppf+MMP+eNjDTKekmsZDwb0qFQZD3GrCD?=
 =?us-ascii?Q?ZvSPP8WzCa3ezjQyHS6SCQu02eezy9ekQSvNEi4uw1s7V0Fn8d/zAXIUo/kL?=
 =?us-ascii?Q?uBchzqmEhHUN1jf8Rei6fHAtJAAJzPzoEb475qwxBC/hRC9sjlocsVq9I96v?=
 =?us-ascii?Q?BnH7v12yI1HYosPcY9BWMeB502XXDCFIsV6c3NyvVd9Ffa6swh9tbLtdXgQv?=
 =?us-ascii?Q?OyjngTSLd8KcPxmjq07WlWKFchnFj5oZLU/h/x7+ZBQdXHvWsrRUPelqwM3F?=
 =?us-ascii?Q?TpAMOYcPXRcZ0s/IJE/Dg51h8HjlMxqUxb29shUc8ylkqhYBB8IqWXAhcTKx?=
 =?us-ascii?Q?md0zc432e3eJodYlPzKuO341WFImHhi4IOjuJG4Xy/rwZCokCSmSnjO3k3yV?=
 =?us-ascii?Q?C6daKmA3yPVrTei6lxHxaHJhkHKSAM8LkTXOOi4EVgcYgkkFX3qTAtShdW+l?=
 =?us-ascii?Q?aStXLWDIX5sNaBfkbRtVzMsPp2DzWCcUC/WTH1Oj0/7oyKliMd1AufEmQ7Em?=
 =?us-ascii?Q?NcyOZWDES6J/ou28VCd8h48LN/a0VH3odJfeOsu6sGouZbdENWq/GnkncHwT?=
 =?us-ascii?Q?TEH0Fo0frkUFfg5XT2z0S8S8YtaewGD/y7RdRO9cPYZq4/f3rHoQhj5npkNn?=
 =?us-ascii?Q?Wb4FThORE/pfGW5tNjf8E/UsBoaGvj5JeBa/9P2QYzaStjeCTwAuIReGOrWs?=
 =?us-ascii?Q?YQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?baCkaPmWTMzHnmT7Jw8owIZgCi0dIGO4aV/+kPyNTLEAcwhZJ9yShLktxtth?=
 =?us-ascii?Q?6NeHF6AkbwNKBSVhwlM+fXvp9Fr8o3fZMuZQUtrd/ChHYuI4TMJL/0dRd8O2?=
 =?us-ascii?Q?lCCqDWFa130xLeKx2UmLGVp5hXYeQFgfGDvZghddu3+msq6BLphJf+ZqTD7U?=
 =?us-ascii?Q?Tflg+zxHBmLumfBx1f5k5gx9QcaX+Aj7EKKbhB3my4A9hRxteLGZmbslot6P?=
 =?us-ascii?Q?8i+Ll3gf486UNEV6LqUQ+W1TvF56YPRudXZ1CKyu5NozzAxKP0dOnjQDcn2U?=
 =?us-ascii?Q?n0uTA2Uii/81AhLr2euflfs1EgRQAcgEAZz7fe1s0Q7l0lY9Xd4W/UQct7xA?=
 =?us-ascii?Q?8E+2P5Rsk2hXCHXibgB5lM/xTwtc7qrTqOtbhtehIvf1CwrKIg60f/beyTpS?=
 =?us-ascii?Q?G3Hp3otV4Qao7HZYAT+6rLDXW6RCB/7kHHnXgh5kvOMgg2vP9T1agCUXm+mb?=
 =?us-ascii?Q?ngEA8dlDKNAmHFIsKmZ5rkdyAZIGTZ/yLUdFlRgoBubaCIm1i5kwxotxRWF/?=
 =?us-ascii?Q?/OyQB/sUelf6ktWnWUUSD3l5PmQClWlgZ9BHP1vI85wiPh68vELSPXWUI/h3?=
 =?us-ascii?Q?PP+HuwZuY1ULQBfXRT8WfApbPKrfUQw/DjxVBHubPpQs/Kr1S/Dhrgjs5+sj?=
 =?us-ascii?Q?p8oBFtpfSXPu6/HAvJ4m61n+fq2XENrfiFR0+uO+AhRvfe8KWxBOe82FZzZt?=
 =?us-ascii?Q?UMwcBmRoIq60JDIS8sJz9w9yY/PZCDpyzrvRl6FXw71vYAP5jwSZFlFRSweL?=
 =?us-ascii?Q?qyyq3aR0iLo2xOPqRaIIbzIjwPnBZWlE6CVH3zFuko/cS3f+/JRT0+PjHn3z?=
 =?us-ascii?Q?NwU8mYrR7ywIBweD/nBOl7QomCo/1TP1irMe0Abb3C3rwFawWKdPoJqaZHvR?=
 =?us-ascii?Q?hJUD8p1as6z8EZWURElfkxUBAoXHaAKxUCtK0EnPZDgtYhgD1w7eaK+pKvLA?=
 =?us-ascii?Q?pLwcO/Cj1g5jzIwXxCDMbfA0LtPWNcifmU7hAqYomdecUm7uupLaOl+GN7JM?=
 =?us-ascii?Q?HKma3OB+moabD8M6cilTtisAQKmdHVRQUAVLFQuMPk3uOKUmOmCZvgQa+u9c?=
 =?us-ascii?Q?gXJP9uiKu//1fMZqLyWLyRQs5BgXw1Um8YES/dD7zjRR/IZRcxVzK2mGA3ki?=
 =?us-ascii?Q?xiknGxIAmSs4iygGUUxMjlVcVjYGLMdfjW/6DXHuQ2qjviTxLlpUjYMNB+2i?=
 =?us-ascii?Q?wBHFC2b1fdFYKHMkui7hRZ212KsNy8nIDTXSs5orRNXVJe17Zp9RbMA60CX9?=
 =?us-ascii?Q?aF3wpxI2vdmdBkER5SO7Bc2jmJ2VyuTG7mG/b8ZeJGcXL3oARePLZXlCVPgD?=
 =?us-ascii?Q?HvYxWuAIceXKyoFsSb5i/GGwkTxHl9zyw2Eq2oNAdkbPioJYxbkFQmaEU1DK?=
 =?us-ascii?Q?Ce9D4AqO4jEiWdQwLWLdTECeHKd9OEhgYLESHviJ/Rs9a4/b2d6E5KQOS5Ei?=
 =?us-ascii?Q?MKEhCoWifkaZHq3ZvYV/XUp3EIzk4GmDp8WUGp+QK6vHTH+D4IWEglfbAKTT?=
 =?us-ascii?Q?TkY+/ujozu58VC2N/f713CHOx7zrcQM7sCToGcfoZBa7GDm+/vB+LGvgz2Na?=
 =?us-ascii?Q?dc5BBMwPiCluOeR0ymEpna7/Dk7xkqJQm2XKWG1xPv+45WDnV+WzhL+khn9d?=
 =?us-ascii?Q?ySrn6REMRE1G+4Ndqe/AvXW8zu/Fy/DAZpa5UoEc7y+7cupnyMmZctVSU9O6?=
 =?us-ascii?Q?W3ZAfOJuYKcveCOIlaTrh/LkH5wBBbD9ccAaTI5Bv4ouwpia23ZsegkELLY1?=
 =?us-ascii?Q?p36isoGw04g5QDtWTCgcPIwuwfBVpsxb3XMiZnL4ZwFARiki0lqZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b670fb6e-319a-4a89-4c2e-08de5699339f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:12.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MXkiP64dXKhuDkBhLQwK/gINsNrE1Ol977vuVx+u02fJpZCN6g44HjofVZaoKHRAMirn/d1f1ovckWd3s5/Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Introduce a common registry for NTB remote embedded-DMA (eDMA) backends.
Vendor-specific backend drivers register here and the transport backend
selects an implementation based on match score.

Add an initial backend for Synopsys DesignWare eDMA. The backend handles
exposing the peer-visible eDMA register window and LL rings and provides
the plumbing needed by the remote-eDMA transport backend.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/Kconfig            |   1 +
 drivers/ntb/hw/Makefile           |   1 +
 drivers/ntb/hw/edma/Kconfig       |  28 +
 drivers/ntb/hw/edma/Makefile      |   5 +
 drivers/ntb/hw/edma/backend.c     |  87 +++
 drivers/ntb/hw/edma/backend.h     | 102 ++++
 drivers/ntb/hw/edma/ntb_dw_edma.c | 977 ++++++++++++++++++++++++++++++
 7 files changed, 1201 insertions(+)
 create mode 100644 drivers/ntb/hw/edma/Kconfig
 create mode 100644 drivers/ntb/hw/edma/Makefile
 create mode 100644 drivers/ntb/hw/edma/backend.c
 create mode 100644 drivers/ntb/hw/edma/backend.h
 create mode 100644 drivers/ntb/hw/edma/ntb_dw_edma.c

diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig
index c325be526b80..4d281f258643 100644
--- a/drivers/ntb/hw/Kconfig
+++ b/drivers/ntb/hw/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 source "drivers/ntb/hw/amd/Kconfig"
+source "drivers/ntb/hw/edma/Kconfig"
 source "drivers/ntb/hw/idt/Kconfig"
 source "drivers/ntb/hw/intel/Kconfig"
 source "drivers/ntb/hw/epf/Kconfig"
diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile
index 223ca592b5f9..05fcdd7d56b7 100644
--- a/drivers/ntb/hw/Makefile
+++ b/drivers/ntb/hw/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NTB_AMD)	+= amd/
+obj-$(CONFIG_NTB_EDMA)	+= edma/
 obj-$(CONFIG_NTB_IDT)	+= idt/
 obj-$(CONFIG_NTB_INTEL)	+= intel/
 obj-$(CONFIG_NTB_EPF)	+= epf/
diff --git a/drivers/ntb/hw/edma/Kconfig b/drivers/ntb/hw/edma/Kconfig
new file mode 100644
index 000000000000..e1e82570c8ac
--- /dev/null
+++ b/drivers/ntb/hw/edma/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config NTB_EDMA
+	tristate "NTB PCI EP embedded DMA backend registry"
+	help
+	 Common registry for NTB remote embedded-DMA (eDMA) backends.
+	 Vendor-specific backend drivers register themselves here, and the
+	 remote-eDMA transport backend (NTB_TRANSPORT_EDMA) selects a backend
+	 based on match() score.
+
+	 To compile this as a module, choose M here: the module will be called
+	 ntb_edma.
+
+	 If unsure, say N.
+
+config NTB_DW_EDMA
+	tristate "DesignWare eDMA backend for NTB PCI EP embedded DMA"
+	depends on DW_EDMA
+	select NTB_EDMA
+	select DMA_ENGINE
+	help
+	 Backend implementation for Synopsys DesignWare PCIe embedded DMA (eDMA)
+	 used with the NTB remote-eDMA transport backend.
+
+	 To compile this driver as a module, choose M here: the module will be
+	 called ntb_dw_edma.
+
+	 If unsure, say N.
diff --git a/drivers/ntb/hw/edma/Makefile b/drivers/ntb/hw/edma/Makefile
new file mode 100644
index 000000000000..993a5efd64f8
--- /dev/null
+++ b/drivers/ntb/hw/edma/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_NTB_EDMA)		+= ntb_edma.o
+ntb_edma-y			:= backend.o
+
+obj-$(CONFIG_NTB_DW_EDMA)	+= ntb_dw_edma.o
diff --git a/drivers/ntb/hw/edma/backend.c b/drivers/ntb/hw/edma/backend.c
new file mode 100644
index 000000000000..b59100c07908
--- /dev/null
+++ b/drivers/ntb/hw/edma/backend.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Generic NTB remote PCI embedded DMA backend registry.
+ *
+ * The registry provides a vendor-agnostic rendezvous point for transport
+ * backends that want to use a peer-exposed embedded DMA engine.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/ntb.h>
+
+#include "backend.h"
+
+static LIST_HEAD(ntb_edma_backends);
+static DEFINE_MUTEX(ntb_edma_backends_lock);
+
+int ntb_edma_backend_register(struct ntb_edma_backend *be)
+{
+	struct ntb_edma_backend *tmp;
+
+	if (!be || !be->name || !be->ops)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ntb_edma_backends_lock) {
+		list_for_each_entry(tmp, &ntb_edma_backends, node) {
+			if (!strcmp(tmp->name, be->name))
+				return -EEXIST;
+		}
+		list_add_tail(&be->node, &ntb_edma_backends);
+	}
+
+	ntb_bus_reprobe();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ntb_edma_backend_register);
+
+void ntb_edma_backend_unregister(struct ntb_edma_backend *be)
+{
+	if (!be)
+		return;
+
+	guard(mutex)(&ntb_edma_backends_lock);
+	list_del_init(&be->node);
+}
+EXPORT_SYMBOL_GPL(ntb_edma_backend_unregister);
+
+const struct ntb_edma_backend *
+ntb_edma_backend_get(struct ntb_dev *ndev)
+{
+	const struct ntb_edma_backend *best = NULL, *be;
+	int best_score = INT_MIN, score;
+
+	guard(mutex)(&ntb_edma_backends_lock);
+	list_for_each_entry(be, &ntb_edma_backends, node) {
+		score = be->ops->match ? be->ops->match(ndev) : -ENODEV;
+		if (score >= 0 && score > best_score) {
+			best = be;
+			best_score = score;
+		}
+	}
+	if (best && !try_module_get(best->owner))
+		best = NULL;
+	return best;
+}
+EXPORT_SYMBOL_GPL(ntb_edma_backend_get);
+
+void ntb_edma_backend_put(const struct ntb_edma_backend *be)
+{
+	module_put(be->owner);
+}
+EXPORT_SYMBOL_GPL(ntb_edma_backend_put);
+
+static int __init ntb_edma_init(void)
+{
+	return 0;
+}
+module_init(ntb_edma_init);
+
+static void __exit ntb_edma_exit(void)
+{
+}
+module_exit(ntb_edma_exit);
+
+MODULE_DESCRIPTION("NTB remote embedded DMA backend registry");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/ntb/hw/edma/backend.h b/drivers/ntb/hw/edma/backend.h
new file mode 100644
index 000000000000..c15a78fd4063
--- /dev/null
+++ b/drivers/ntb/hw/edma/backend.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+
+#ifndef _NTB_HW_EDMA_BACKEND_H_
+#define _NTB_HW_EDMA_BACKEND_H_
+
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/ntb.h>
+
+#define NTB_EDMA_CH_NUM		4
+
+/*
+ * REMOTE_EDMA_EP:
+ *   Endpoint owns the eDMA engine and pushes descriptors into a shared MW.
+ *
+ * REMOTE_EDMA_RC:
+ *   Root Complex controls the endpoint eDMA through the shared MW and
+ *   drives reads/writes on behalf of the host.
+ */
+typedef enum {
+	REMOTE_EDMA_UNKNOWN,
+	REMOTE_EDMA_EP,
+	REMOTE_EDMA_RC,
+} remote_edma_mode_t;
+
+struct ntb_edma_chans {
+	struct device *dev;
+
+	struct dma_chan *chan[NTB_EDMA_CH_NUM];
+	struct dma_chan *intr_chan;
+
+	unsigned int num_chans;
+	atomic_t cur_chan;
+
+	struct mutex lock;
+};
+
+/**
+ * struct ntb_edma_backend_ops - operations for a remote embedded-DMA backend
+ *
+ * A backend provides the hardware-specific plumbing required by the
+ * ntb_transport remote-eDMA backend, such as exposing peer-mappable resources
+ * via an NTB MW, setting up DMA channels, and delivering peer notifications.
+ *
+ * @match:           Optional. Return a non-negative score if this backend
+ *                   supports @ndev. Higher score wins. Return a negative
+ *                   errno otherwise.
+ * @alloc:           Allocate backend-private per-device state and store
+ *                   it in *@priv. Called once during transport backend
+ *                   initialization.
+ * @free:            Free backend-private state allocated by @alloc.
+ * @ep_publish:      EP-side control plane. Publish peer-accessible resources
+ *                   via MW @mw_index for @qp_count queue pairs, and arm
+ *                   the notification path. When a peer notification is
+ *                   received, invoke @cb(@cb_data, qp_num).
+ * @ep_unpublish:    Undo @ep_publish.
+ * @rc_connect:      RC-side control plane. Connect to peer-published resources
+ *                   via MW @mw_index for @qp_count queue pairs.
+ * @rc_disconnect:   Undo @rc_connect.
+ * @tx_chans_init:   Initialize DMA channels used for data transfer into @chans.
+ * @tx_chans_deinit: Tear down DMA channels initialized by @tx_chans_init.
+ * @notify_peer:     Try to notify the peer about updated shared state for
+ *                   @qp_num. Return 0 if the peer has been notified (no
+ *                   doorbell fallback needed). Return a non-zero value to
+ *                   request a doorbell-based fallback.
+ */
+struct ntb_edma_backend_ops {
+	int (*match)(struct ntb_dev *ndev);
+	int (*alloc)(struct ntb_dev *ndev, void **priv);
+	void (*free)(struct ntb_dev *ndev, void **priv);
+
+	/* Control plane: EP publishes and RC connects */
+	int (*ep_publish)(struct ntb_dev *ndev, void *priv, int mw_index,
+			  unsigned int qp_count,
+			  void (*cb)(void *data, int qp_num), void *cb_data);
+	void (*ep_unpublish)(struct ntb_dev *ndev, void *priv);
+	int (*rc_connect)(struct ntb_dev *ndev, void *priv, int mw_index,
+			  unsigned int qp_count);
+	void (*rc_disconnect)(struct ntb_dev *ndev, void *priv);
+
+	/* Data plane: TX channels */
+	int (*tx_chans_init)(struct ntb_dev *ndev, void *priv,
+			     struct ntb_edma_chans *chans, bool remote);
+	void (*tx_chans_deinit)(struct ntb_edma_chans *chans);
+	int (*notify_peer)(struct ntb_edma_chans *chans, void *priv,
+			   int qp_num);
+};
+
+struct ntb_edma_backend {
+	const char *name;
+	const struct ntb_edma_backend_ops *ops;
+	struct module *owner;
+	struct list_head node;
+};
+
+int ntb_edma_backend_register(struct ntb_edma_backend *be);
+void ntb_edma_backend_unregister(struct ntb_edma_backend *be);
+const struct ntb_edma_backend *ntb_edma_backend_get(struct ntb_dev *ndev);
+void ntb_edma_backend_put(const struct ntb_edma_backend *be);
+
+#endif /* _NTB_HW_EDMA_BACKEND_H_ */
diff --git a/drivers/ntb/hw/edma/ntb_dw_edma.c b/drivers/ntb/hw/edma/ntb_dw_edma.c
new file mode 100644
index 000000000000..f4c8985889eb
--- /dev/null
+++ b/drivers/ntb/hw/edma/ntb_dw_edma.c
@@ -0,0 +1,977 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * NTB remote DesignWare eDMA helpers
+ *
+ * This file is a helper library used by the NTB transport remote-eDMA backend,
+ * not a standalone NTB hardware driver. It contains the DesignWare eDMA
+ * specific plumbing needed to expose/map peer-accessible resources via an NTB
+ * memory window and to manage DMA channels and peer notifications.
+ */
+
+#include <linux/dma/edma.h>
+#include <linux/dmaengine.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/ntb.h>
+#include <linux/pci.h>
+#include <linux/pci-epc.h>
+#include <linux/spinlock.h>
+#include <linux/xarray.h>
+
+#include "backend.h"
+
+/* One extra channel is reserved for notification (RC to EP interrupt kick). */
+#define NTB_DW_EDMA_TOTAL_CH_NUM	(NTB_EDMA_CH_NUM + 1)
+
+#define NTB_DW_EDMA_INFO_MAGIC		0x45444D41 /* "EDMA" */
+#define NTB_DW_EDMA_NOTIFY_MAX_QP	64
+#define NTB_DW_EDMA_NR_IRQS		4
+#define NTB_DW_EDMA_MW_IDX_INVALID	(-1)
+
+/* Default eDMA LLP memory size */
+#define DMA_LLP_MEM_SIZE		PAGE_SIZE
+
+typedef void (*ntb_edma_interrupt_cb_t)(void *data, int qp_num);
+
+struct ntb_edma_ctx {
+	bool initialized;
+
+	/* Fields for the notification handling */
+	u32 qp_count;
+	u32 *notify_src_virt;
+	dma_addr_t notify_src_phys;
+	struct scatterlist sgl;
+
+	/* Host-to-EP scratch buffer used to convey event information */
+	union {
+		struct ntb_dw_edma_db *db_virt;
+		struct ntb_dw_edma_db __iomem *db_io;
+	};
+	dma_addr_t db_phys;
+
+	/* Deterministic mapping for dw-edma .irq_vector callback */
+	unsigned int peer_irq_count;
+	int peer_irq_vec[NTB_DW_EDMA_NR_IRQS];
+
+	/* For interrupts */
+	ntb_edma_interrupt_cb_t cb;
+	void *cb_data;
+
+	/* Below are the records for teardown path */
+
+	int mw_index;
+	bool mw_trans_set;
+
+	/* For ntb_dw_edma_info to be unmapped on teardown */
+	struct ntb_dw_edma_info *info_virt;
+	dma_addr_t info_phys;
+	size_t info_bytes;
+
+	/* Scratchpad backing for the unused tail of the inbound MW */
+	void *mw_pad_virt;
+	dma_addr_t mw_pad_phys;
+	size_t mw_pad_bytes;
+
+	/* eDMA register window IOMMU mapping (EP side) */
+	bool reg_mapped;
+	struct iommu_domain *iommu_dom;
+	unsigned long reg_iova;
+	size_t reg_iova_size;
+
+	/* Read channels delegated to the host side (EP side) */
+	struct dma_chan *dchan[NTB_DW_EDMA_TOTAL_CH_NUM];
+
+	/* RC-side state */
+	bool peer_initialized;
+	bool peer_probed;
+	struct dw_edma_chip *peer_chip;
+	void __iomem *peer_virt;
+	resource_size_t peer_virt_size;
+};
+
+struct ntb_dw_edma_info {
+	u32 magic;
+	u32 reg_size;
+	u16 ch_cnt;
+	u64 db_base;
+	u64 ll_rd_phys[NTB_DW_EDMA_TOTAL_CH_NUM];
+};
+
+struct ntb_dw_edma_db {
+	u32 target;
+	u32 db[NTB_DW_EDMA_NOTIFY_MAX_QP];
+};
+
+struct ntb_edma_filter {
+	struct device *dma_dev;
+	u32 direction;
+};
+
+static DEFINE_XARRAY(ntb_dw_edma_ctx_xa);
+static DEFINE_SPINLOCK(ntb_dw_edma_notify_lock);
+
+static void ntb_dw_edma_ep_unpublish(struct ntb_dev *ndev, void *priv);
+
+static int ntb_dw_edma_ctx_register(struct device *dev, struct ntb_edma_ctx *ctx)
+{
+	return xa_insert(&ntb_dw_edma_ctx_xa, (unsigned long)dev, ctx, GFP_KERNEL);
+}
+
+static void ntb_dw_edma_ctx_unregister(struct device *dev)
+{
+	xa_erase(&ntb_dw_edma_ctx_xa, (unsigned long)dev);
+}
+
+static struct ntb_edma_ctx *ntb_dw_edma_ctx_lookup(struct device *dev)
+{
+	return xa_load(&ntb_dw_edma_ctx_xa, (unsigned long)dev);
+}
+
+static bool ntb_dw_edma_filter_fn(struct dma_chan *chan, void *arg)
+{
+	struct ntb_edma_filter *filter = arg;
+	u32 dir = filter->direction;
+	struct dma_slave_caps caps;
+	int ret;
+
+	if (chan->device->dev != filter->dma_dev)
+		return false;
+
+	ret = dma_get_slave_caps(chan, &caps);
+	if (ret < 0)
+		return false;
+
+	return !!(caps.directions & dir);
+}
+
+static void ntb_dw_edma_notify_cb(struct dma_chan *dchan, void *data)
+{
+	struct ntb_edma_ctx *ctx = data;
+	ntb_edma_interrupt_cb_t cb;
+	struct ntb_dw_edma_db *db;
+	void *cb_data;
+	u32 qp_count;
+	u32 i, val;
+
+	guard(spinlock_irqsave)(&ntb_dw_edma_notify_lock);
+
+	cb = ctx->cb;
+	cb_data = ctx->cb_data;
+	qp_count = ctx->qp_count;
+	db = ctx->db_virt;
+	if (!cb || !db)
+		return;
+
+	for (i = 0; i < qp_count; i++) {
+		val = READ_ONCE(db->db[i]);
+		if (!val)
+			continue;
+
+		WRITE_ONCE(db->db[i], 0);
+		cb(cb_data, i);
+	}
+}
+
+static void ntb_dw_edma_undelegate_chans(struct ntb_edma_ctx *ctx)
+{
+	unsigned int i;
+
+	if (!ctx)
+		return;
+
+	scoped_guard(spinlock_irqsave, &ntb_dw_edma_notify_lock) {
+		ctx->cb = NULL;
+		ctx->cb_data = NULL;
+	}
+
+	for (i = 0; i < NTB_DW_EDMA_TOTAL_CH_NUM; i++) {
+		if (!ctx->dchan[i])
+			continue;
+
+		if (i == NTB_EDMA_CH_NUM)
+			dw_edma_chan_register_notify(ctx->dchan[i], NULL, NULL);
+
+		dma_release_channel(ctx->dchan[i]);
+		ctx->dchan[i] = NULL;
+	}
+}
+
+static int ntb_dw_edma_delegate_chans(struct device *dev,
+				      struct ntb_edma_ctx *ctx,
+				      struct ntb_dw_edma_info *info,
+				      ntb_edma_interrupt_cb_t cb, void *data)
+{
+	struct ntb_edma_filter filter;
+	struct dw_edma_region region;
+	dma_cap_mask_t dma_mask;
+	struct dma_chan *chan;
+	unsigned int i;
+	int rc;
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_SLAVE, dma_mask);
+
+	filter.dma_dev = dev;
+
+	/* Configure read channels, which will be driven by the host side */
+	for (i = 0; i < NTB_DW_EDMA_TOTAL_CH_NUM; i++) {
+		filter.direction = BIT(DMA_DEV_TO_MEM);
+		chan = dma_request_channel(dma_mask, ntb_dw_edma_filter_fn,
+					   &filter);
+		if (!chan) {
+			rc = -ENODEV;
+			goto err;
+		}
+		ctx->dchan[i] = chan;
+
+		if (i == NTB_EDMA_CH_NUM) {
+			scoped_guard(spinlock_irqsave, &ntb_dw_edma_notify_lock) {
+				ctx->cb = cb;
+				ctx->cb_data = data;
+			}
+			rc = dw_edma_chan_register_notify(chan,
+							  ntb_dw_edma_notify_cb,
+							  ctx);
+			if (rc)
+				goto err;
+		} else {
+			rc = dw_edma_chan_irq_config(chan, DW_EDMA_CH_IRQ_REMOTE);
+			if (rc)
+				dev_warn(dev, "irq config failed (i=%u %d)\n",
+					 i, rc);
+		}
+
+		rc = dw_edma_chan_get_ll_region(chan, &region);
+		if (rc)
+			goto err;
+
+		info->ll_rd_phys[i] = region.paddr;
+	}
+
+	return 0;
+
+err:
+	ntb_dw_edma_undelegate_chans(ctx);
+	return rc;
+}
+
+static void ntb_dw_edma_ctx_reset(struct ntb_edma_ctx *ctx)
+{
+	ctx->initialized = false;
+	ctx->mw_index = NTB_DW_EDMA_MW_IDX_INVALID;
+	ctx->mw_trans_set = false;
+	ctx->reg_mapped = false;
+	ctx->iommu_dom = NULL;
+	ctx->reg_iova = 0;
+	ctx->reg_iova_size = 0;
+	ctx->db_phys = 0;
+	ctx->qp_count = 0;
+	ctx->info_virt = NULL;
+	ctx->info_phys = 0;
+	ctx->info_bytes = 0;
+	ctx->mw_pad_virt = NULL;
+	ctx->mw_pad_phys = 0;
+	ctx->mw_pad_bytes = 0;
+	ctx->db_virt = NULL;
+	memset(ctx->dchan, 0, sizeof(ctx->dchan));
+}
+
+static int ntb_dw_edma_match(struct ntb_dev *ndev)
+{
+	struct pci_epc *epc;
+	phys_addr_t reg_phys;
+	resource_size_t reg_size;
+
+	/* EP can verify the local DesignWare eDMA presence via epc hook. */
+	epc = ntb_get_private_data(ndev);
+	if (epc) {
+		if (dw_edma_get_reg_window(epc, &reg_phys, &reg_size))
+			return -ENODEV;
+		return 100;
+	}
+
+	/* Host cannot validate peer eDMA until link/peer mapping is done. */
+	return 50;
+}
+
+static int ntb_dw_edma_alloc(struct ntb_dev *ndev, void **priv)
+{
+	struct ntb_edma_ctx *ctx;
+
+	ctx = devm_kzalloc(&ndev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	*priv = ctx;
+	return 0;
+}
+
+static void ntb_dw_edma_free(struct ntb_dev *ndev, void **priv)
+{
+	devm_kfree(&ndev->dev, *priv);
+	*priv = NULL;
+}
+
+static int ntb_dw_edma_ep_publish(struct ntb_dev *ndev, void *priv,
+				  int mw_index, unsigned int qp_count,
+				  ntb_edma_interrupt_cb_t cb, void *data)
+{
+	struct ntb_edma_ctx *ctx = priv;
+	struct ntb_dw_edma_info *info;
+	struct ntb_dw_edma_db *db;
+	struct iommu_domain *dom;
+	struct pci_epc *epc;
+	struct device *dev;
+	unsigned int num_subrange = NTB_DW_EDMA_TOTAL_CH_NUM + 3;
+	resource_size_t reg_size, reg_size_mw;
+	const size_t info_bytes = PAGE_SIZE;
+	dma_addr_t db_phys, info_phys;
+	phys_addr_t edma_reg_phys;
+	resource_size_t size_max;
+	size_t ll_bytes, size;
+	unsigned int cur = 0;
+	u64 need;
+	int rc;
+	u32 i;
+
+	if (ctx->initialized)
+		return 0;
+
+	/* Clean up stale state from a previous failed attempt. */
+	ntb_dw_edma_ep_unpublish(ndev, ctx);
+
+	epc = (struct pci_epc *)ntb_get_private_data(ndev);
+	if (!epc)
+		return -ENODEV;
+	dev = epc->dev.parent;
+
+	ntb_dw_edma_ctx_reset(ctx);
+
+	ctx->mw_index = mw_index;
+	ctx->qp_count = qp_count;
+
+	info = dma_alloc_coherent(dev, info_bytes, &info_phys, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	memset(info, 0, info_bytes);
+
+	ctx->info_virt = info;
+	ctx->info_phys = info_phys;
+	ctx->info_bytes = info_bytes;
+
+	/* Get eDMA reg base and size, IOMMU map it if necessary */
+	rc = dw_edma_get_reg_window(epc, &edma_reg_phys, &reg_size);
+	if (rc) {
+		dev_err(&ndev->pdev->dev,
+			"failed to get eDMA register window: %d\n", rc);
+		goto err;
+	}
+	dom = iommu_get_domain_for_dev(dev);
+	if (dom) {
+		phys_addr_t phys;
+		unsigned long iova;
+
+		phys = edma_reg_phys & PAGE_MASK;
+		size = PAGE_ALIGN(reg_size + edma_reg_phys - phys);
+		iova = phys;
+
+		rc = iommu_map(dom, iova, phys, size,
+			       IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO,
+			       GFP_KERNEL);
+		if (rc) {
+			dev_err(&ndev->dev,
+				"failed to direct map eDMA reg: %d\n", rc);
+			goto err;
+		}
+
+		ctx->reg_mapped = true;
+		ctx->iommu_dom = dom;
+		ctx->reg_iova = iova;
+		ctx->reg_iova_size = size;
+	}
+
+	/* Read channels are driven by the peer (host side) */
+	rc = ntb_dw_edma_delegate_chans(dev, ctx, info, cb, data);
+	if (rc) {
+		dev_err(&ndev->pdev->dev,
+			"failed to prepare channels to delegate: %d\n", rc);
+		goto err;
+	}
+
+	/* Scratch buffer for notification */
+	db = dma_alloc_coherent(dev, sizeof(*db), &db_phys, GFP_KERNEL);
+	if (!db) {
+		rc = -ENOMEM;
+		goto err;
+	}
+	memset(db, 0, sizeof(*db));
+
+	ctx->db_virt = db;
+	ctx->db_phys = db_phys;
+
+	/* Prep works for IB iATU mappings */
+	ll_bytes = NTB_DW_EDMA_TOTAL_CH_NUM * DMA_LLP_MEM_SIZE;
+	reg_size_mw = roundup_pow_of_two(reg_size);
+	need = info_bytes + PAGE_SIZE + reg_size_mw + ll_bytes;
+
+	rc = ntb_mw_get_align(ndev, 0, mw_index, NULL, NULL, &size_max);
+	if (rc)
+		goto err;
+
+	if (size_max < need) {
+		rc = -ENOSPC;
+		goto err;
+	}
+
+	if (need < size_max)
+		num_subrange++;
+
+	struct ntb_mw_subrange *r __free(kfree) =
+				kcalloc(num_subrange, sizeof(*r), GFP_KERNEL);
+	if (!r) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	ctx->mw_trans_set = true;
+
+	/* iATU map ntb_dw_edma_info */
+	r[cur].addr = info_phys;
+	r[cur++].size = info_bytes;
+
+	/* iATU map ntb_dw_edma_db */
+	r[cur].addr = db_phys;
+	r[cur++].size = PAGE_SIZE;
+
+	/* iATU map eDMA reg */
+	r[cur].addr = edma_reg_phys;
+	r[cur++].size = reg_size_mw;
+
+	/* iATU map LL location */
+	for (i = 0; i < NTB_DW_EDMA_TOTAL_CH_NUM; i++) {
+		r[cur].addr = info->ll_rd_phys[i];
+		r[cur++].size = DMA_LLP_MEM_SIZE;
+	}
+
+	/* Padding if needed */
+	if (size_max - need > 0) {
+		resource_size_t pad_bytes = size_max - need;
+		dma_addr_t pad_phys;
+		void *pad;
+
+		pad = dma_alloc_coherent(dev, pad_bytes, &pad_phys, GFP_KERNEL);
+		if (!pad) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		memset(pad, 0, pad_bytes);
+
+		ctx->mw_pad_virt = pad;
+		ctx->mw_pad_phys = pad_phys;
+		ctx->mw_pad_bytes = pad_bytes;
+
+		r[cur].addr = pad_phys;
+		r[cur++].size = pad_bytes;
+	}
+
+	rc = ntb_mw_set_trans_ranges(ndev, 0, mw_index, num_subrange, r);
+	if (rc)
+		goto err;
+
+	/* Fill in info */
+	info->magic = NTB_DW_EDMA_INFO_MAGIC;
+	info->reg_size = reg_size_mw;
+	info->ch_cnt = NTB_DW_EDMA_TOTAL_CH_NUM;
+	info->db_base = db_phys;
+
+	ctx->initialized = true;
+	return 0;
+
+err:
+	ntb_dw_edma_ep_unpublish(ndev, ctx);
+	return rc;
+}
+
+static void ntb_dw_edma_peer_irq_reset(struct ntb_edma_ctx *ctx)
+{
+	ctx->peer_irq_count = 0;
+	memset(ctx->peer_irq_vec, 0xff, sizeof(ctx->peer_irq_vec));
+}
+
+static int ntb_dw_edma_reserve_peer_irq_vectors(struct pci_dev *pdev,
+						struct ntb_edma_ctx *ctx,
+						unsigned int nreq)
+{
+	int i, found = 0;
+	int irq;
+
+	if (nreq > NTB_DW_EDMA_NR_IRQS)
+		return -EINVAL;
+
+	ntb_dw_edma_peer_irq_reset(ctx);
+
+	/* NTB driver should have reserved sufficient number of vectors */
+	for (i = 0; found < nreq; i++) {
+		irq = pci_irq_vector(pdev, i);
+		if (irq < 0)
+			break;
+		if (!irq_has_action(irq))
+			ctx->peer_irq_vec[found++] = i;
+	}
+	if (found < nreq)
+		return -ENOSPC;
+
+	ctx->peer_irq_count = found;
+	return 0;
+}
+
+static int ntb_dw_edma_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct ntb_edma_ctx *ctx = ntb_dw_edma_ctx_lookup(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int vec;
+
+	if (!ctx)
+		return -EINVAL;
+
+	if (nr >= ctx->peer_irq_count)
+		return -EINVAL;
+
+	vec = ctx->peer_irq_vec[nr];
+	if (vec < 0)
+		return -EINVAL;
+
+	return pci_irq_vector(pdev, vec);
+}
+
+static const struct dw_edma_plat_ops ntb_dw_edma_ops = {
+	.irq_vector     = ntb_dw_edma_irq_vector,
+};
+
+static void ntb_dw_edma_rc_disconnect(struct ntb_dev *ndev, void *priv)
+{
+	struct ntb_edma_ctx *ctx = priv;
+	void __iomem *peer_virt = ctx->peer_virt;
+	struct dw_edma_chip *chip = ctx->peer_chip;
+	u32 *notify_src = ctx->notify_src_virt;
+	dma_addr_t notify_src_phys = ctx->notify_src_phys;
+
+	/* Stop using peer MMIO early. */
+	ctx->db_io = NULL;
+	ctx->db_phys = 0;
+	ctx->qp_count = 0;
+
+	if (ctx->peer_probed && chip)
+		dw_edma_remove(chip);
+
+	ntb_dw_edma_ctx_unregister(&ndev->pdev->dev);
+
+	ntb_dw_edma_peer_irq_reset(ctx);
+
+	ctx->peer_initialized = false;
+	ctx->peer_probed = false;
+	ctx->peer_chip = NULL;
+
+	if (notify_src)
+		dma_free_coherent(&ndev->pdev->dev, sizeof(*notify_src),
+				  notify_src, notify_src_phys);
+
+	ctx->notify_src_virt = NULL;
+	ctx->notify_src_phys = 0;
+	memset(&ctx->sgl, 0, sizeof(ctx->sgl));
+
+	if (peer_virt)
+		iounmap(peer_virt);
+
+	ctx->peer_virt = NULL;
+	ctx->peer_virt_size = 0;
+}
+
+static int ntb_dw_edma_rc_connect(struct ntb_dev *ndev, void *priv, int mw_index,
+				  unsigned int qp_count)
+{
+	struct ntb_edma_ctx *ctx = priv;
+	struct ntb_dw_edma_info __iomem *info;
+	struct dw_edma_chip *chip;
+	void __iomem *edma_virt;
+	resource_size_t mw_size;
+	phys_addr_t edma_phys;
+	unsigned int ch_cnt;
+	unsigned int i;
+	int ret;
+	u64 off;
+
+	if (ctx->peer_initialized)
+		return 0;
+
+	/* Clean up stale state from a previous failed attempt. */
+	ntb_dw_edma_rc_disconnect(ndev, priv);
+
+	ret = ntb_peer_mw_get_addr(ndev, mw_index, &edma_phys, &mw_size);
+	if (ret)
+		return ret;
+
+	edma_virt = ioremap(edma_phys, mw_size);
+	if (!edma_virt)
+		return -ENOMEM;
+
+	ctx->peer_virt = edma_virt;
+	ctx->peer_virt_size = mw_size;
+
+	info = edma_virt;
+	if (readl(&info->magic) != NTB_DW_EDMA_INFO_MAGIC) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ch_cnt = readw(&info->ch_cnt);
+	if (ch_cnt != NTB_DW_EDMA_TOTAL_CH_NUM) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	chip = devm_kzalloc(&ndev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = ntb_dw_edma_ctx_register(&ndev->pdev->dev, ctx);
+	if (ret)
+		return ret;
+
+	off = 2 * PAGE_SIZE;
+	chip->dev = &ndev->pdev->dev;
+	chip->nr_irqs = NTB_DW_EDMA_NR_IRQS;
+	chip->ops = &ntb_dw_edma_ops;
+	chip->flags = 0;
+	chip->reg_base = edma_virt + off;
+	chip->mf = EDMA_MF_EDMA_UNROLL;
+	chip->ll_wr_cnt = 0;
+	chip->ll_rd_cnt = ch_cnt;
+
+	ctx->db_io = (void __iomem *)edma_virt + PAGE_SIZE;
+	ctx->qp_count = qp_count;
+	ctx->db_phys = readq(&info->db_base);
+
+	ctx->notify_src_virt = dma_alloc_coherent(&ndev->pdev->dev,
+						  sizeof(*ctx->notify_src_virt),
+						  &ctx->notify_src_phys,
+						  GFP_KERNEL);
+	if (!ctx->notify_src_virt) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	off += readl(&info->reg_size);
+
+	for (i = 0; i < ch_cnt; i++) {
+		chip->ll_region_rd[i].vaddr.io = edma_virt + off;
+		chip->ll_region_rd[i].paddr = readq(&info->ll_rd_phys[i]);
+		chip->ll_region_rd[i].sz = DMA_LLP_MEM_SIZE;
+		off += DMA_LLP_MEM_SIZE;
+	}
+
+	if (!pci_dev_msi_enabled(ndev->pdev)) {
+		ret = -ENXIO;
+		goto err;
+	}
+	ret = ntb_dw_edma_reserve_peer_irq_vectors(ndev->pdev, ctx, chip->nr_irqs);
+	if (ret) {
+		dev_err(&ndev->dev, "no free MSI vectors for remote eDMA: %d\n",
+			ret);
+		goto err;
+	}
+
+	ret = dw_edma_probe(chip);
+	if (ret) {
+		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
+		ntb_dw_edma_ctx_unregister(&ndev->pdev->dev);
+		goto err;
+	}
+
+	ctx->peer_chip = chip;
+	ctx->peer_probed = true;
+	ctx->peer_initialized = true;
+	return 0;
+
+err:
+	ntb_dw_edma_rc_disconnect(ndev, ctx);
+	return ret;
+}
+
+static void ntb_dw_edma_ep_unpublish(struct ntb_dev *ndev, void *priv)
+{
+	struct ntb_edma_ctx *ctx = priv;
+	struct ntb_dw_edma_info *info;
+	struct ntb_dw_edma_db *db;
+	struct device *dev = NULL;
+	struct pci_epc *epc;
+	dma_addr_t db_phys, info_phys, mw_pad_phys;
+	size_t info_bytes, mw_pad_bytes;
+	void *mw_pad;
+
+	epc = (struct pci_epc *)ntb_get_private_data(ndev);
+	WARN_ON(!epc);
+	if (epc)
+		dev = epc->dev.parent;
+
+	scoped_guard(spinlock_irqsave, &ntb_dw_edma_notify_lock) {
+		db = ctx->db_virt;
+		db_phys = ctx->db_phys;
+
+		/* Make callbacks no-op first. */
+		ctx->cb = NULL;
+		ctx->cb_data = NULL;
+		ctx->db_virt = NULL;
+		ctx->qp_count = 0;
+	}
+
+	info = ctx->info_virt;
+	info_phys = ctx->info_phys;
+	info_bytes = ctx->info_bytes;
+
+	mw_pad = ctx->mw_pad_virt;
+	mw_pad_phys = ctx->mw_pad_phys;
+	mw_pad_bytes = ctx->mw_pad_bytes;
+	ctx->mw_pad_virt = NULL;
+	ctx->mw_pad_phys = 0;
+	ctx->mw_pad_bytes = 0;
+
+	/* Disconnect the MW before freeing its backing memory */
+	if (ctx->mw_trans_set && ctx->mw_index != NTB_DW_EDMA_MW_IDX_INVALID)
+		ntb_mw_clear_trans(ndev, 0, ctx->mw_index);
+
+	ntb_dw_edma_undelegate_chans(ctx);
+
+	if (ctx->reg_mapped)
+		iommu_unmap(ctx->iommu_dom, ctx->reg_iova, ctx->reg_iova_size);
+
+	if (db && dev)
+		dma_free_coherent(dev, sizeof(*db), db, db_phys);
+
+	if (info && dev && info_bytes)
+		dma_free_coherent(dev, info_bytes, info, info_phys);
+
+	if (mw_pad && dev && mw_pad_bytes)
+		dma_free_coherent(dev, mw_pad_bytes, mw_pad, mw_pad_phys);
+
+	ntb_dw_edma_ctx_reset(ctx);
+}
+
+static void ntb_dw_edma_tx_chans_deinit(struct ntb_edma_chans *edma)
+{
+	unsigned int i;
+
+	if (!edma)
+		return;
+
+	for (i = 0; i < NTB_EDMA_CH_NUM; i++) {
+		if (!edma->chan[i])
+			continue;
+		dmaengine_terminate_sync(edma->chan[i]);
+		dma_release_channel(edma->chan[i]);
+		edma->chan[i] = NULL;
+	}
+	edma->num_chans = 0;
+
+	if (edma->intr_chan) {
+		dmaengine_terminate_sync(edma->intr_chan);
+		dma_release_channel(edma->intr_chan);
+		edma->intr_chan = NULL;
+	}
+
+	atomic_set(&edma->cur_chan, 0);
+}
+
+static int ntb_dw_edma_setup_intr_chan(struct device *dev,
+				       struct ntb_edma_chans *edma, void *priv)
+{
+	struct ntb_edma_ctx *ctx = priv;
+	struct ntb_edma_filter filter;
+	dma_cap_mask_t dma_mask;
+	struct dma_slave_config cfg;
+	struct scatterlist *sgl = &ctx->sgl;
+	int rc;
+
+	if (edma->intr_chan)
+		return 0;
+
+	if (!ctx->notify_src_virt || !ctx->db_phys)
+		return -EINVAL;
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_SLAVE, dma_mask);
+
+	filter.dma_dev = dev;
+	filter.direction = BIT(DMA_MEM_TO_DEV);
+
+	edma->intr_chan = dma_request_channel(dma_mask, ntb_dw_edma_filter_fn,
+					      &filter);
+	if (!edma->intr_chan) {
+		dev_warn(dev,
+			 "Remote eDMA notify channel could not be allocated\n");
+		return -ENODEV;
+	}
+
+	rc = dw_edma_chan_irq_config(edma->intr_chan, DW_EDMA_CH_IRQ_LOCAL);
+	if (rc)
+		goto err_release;
+
+	/* Ensure store is visible before kicking DMA transfer */
+	wmb();
+
+	sg_init_table(sgl, 1);
+	sg_dma_address(sgl) = ctx->notify_src_phys;
+	sg_dma_len(sgl) = sizeof(u32);
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.dst_addr = ctx->db_phys; /* The first 32bit is 'target' */
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.direction = DMA_MEM_TO_DEV;
+
+	rc = dmaengine_slave_config(edma->intr_chan, &cfg);
+	if (rc)
+		goto err_release;
+
+	return 0;
+
+err_release:
+	dma_release_channel(edma->intr_chan);
+	edma->intr_chan = NULL;
+	return rc;
+}
+
+static int ntb_dw_edma_tx_chans_init(struct ntb_dev *ndev, void *priv,
+				     struct ntb_edma_chans *edma, bool remote)
+{
+	struct device *dev = ntb_get_dma_dev(ndev);
+	struct ntb_edma_filter filter;
+	dma_cap_mask_t dma_mask;
+	unsigned int i;
+	int rc;
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_SLAVE, dma_mask);
+
+	memset(edma, 0, sizeof(*edma));
+	edma->dev = dev;
+
+	mutex_init(&edma->lock);
+
+	filter.dma_dev = dev;
+	filter.direction = BIT(DMA_MEM_TO_DEV);
+	for (i = 0; i < NTB_EDMA_CH_NUM; i++) {
+		edma->chan[i] = dma_request_channel(dma_mask,
+						    ntb_dw_edma_filter_fn,
+						    &filter);
+		if (!edma->chan[i])
+			break;
+		edma->num_chans++;
+
+		if (remote)
+			rc = dw_edma_chan_irq_config(edma->chan[i],
+						     DW_EDMA_CH_IRQ_REMOTE);
+		else
+			rc = dw_edma_chan_irq_config(edma->chan[i],
+						     DW_EDMA_CH_IRQ_LOCAL);
+
+		if (rc) {
+			dev_err(dev, "irq config failed on ch%u: %d\n", i, rc);
+			goto err;
+		}
+	}
+
+	if (!edma->num_chans) {
+		dev_warn(dev, "Remote eDMA channels failed to initialize\n");
+		ntb_dw_edma_tx_chans_deinit(edma);
+		return -ENODEV;
+	}
+
+	if (remote) {
+		rc = ntb_dw_edma_setup_intr_chan(dev, edma, priv);
+		if (rc)
+			goto err;
+	}
+	return 0;
+err:
+	ntb_dw_edma_tx_chans_deinit(edma);
+	return rc;
+}
+
+static int ntb_dw_edma_notify_peer(struct ntb_edma_chans *edma, void *priv,
+				   int qp_num)
+{
+	struct ntb_edma_ctx *ctx = priv;
+	struct dma_async_tx_descriptor *txd;
+	dma_cookie_t cookie;
+
+	if (!edma || !edma->intr_chan)
+		return -ENXIO;
+
+	if (qp_num < 0 || qp_num >= ctx->qp_count)
+		return -EINVAL;
+
+	if (!ctx->db_io)
+		return -EINVAL;
+
+	guard(mutex)(&edma->lock);
+
+	writel(1, &ctx->db_io->db[qp_num]);
+
+	/* Ensure store is visible before kicking the DMA transfer */
+	wmb();
+
+	txd = dmaengine_prep_slave_sg(edma->intr_chan, &ctx->sgl, 1,
+				      DMA_MEM_TO_DEV,
+				      DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!txd)
+		return -ENOSPC;
+
+	cookie = dmaengine_submit(txd);
+	if (dma_submit_error(cookie))
+		return -ENOSPC;
+
+	dma_async_issue_pending(edma->intr_chan);
+	return 0;
+}
+
+static const struct ntb_edma_backend_ops ntb_dw_edma_backend_ops = {
+	.match = ntb_dw_edma_match,
+	.alloc = ntb_dw_edma_alloc,
+	.free = ntb_dw_edma_free,
+
+	.ep_publish = ntb_dw_edma_ep_publish,
+	.ep_unpublish = ntb_dw_edma_ep_unpublish,
+	.rc_connect = ntb_dw_edma_rc_connect,
+	.rc_disconnect = ntb_dw_edma_rc_disconnect,
+
+	.tx_chans_init = ntb_dw_edma_tx_chans_init,
+	.tx_chans_deinit = ntb_dw_edma_tx_chans_deinit,
+	.notify_peer = ntb_dw_edma_notify_peer,
+};
+
+static struct ntb_edma_backend ntb_dw_edma_backend = {
+	.name = "dw-edma",
+	.ops  = &ntb_dw_edma_backend_ops,
+	.owner = THIS_MODULE,
+};
+
+static int __init ntb_dw_edma_init(void)
+{
+	return ntb_edma_backend_register(&ntb_dw_edma_backend);
+}
+module_init(ntb_dw_edma_init);
+
+static void __exit ntb_dw_edma_exit(void)
+{
+	ntb_edma_backend_unregister(&ntb_dw_edma_backend);
+}
+module_exit(ntb_dw_edma_exit);
+
+MODULE_DESCRIPTION("NTB DW EPC eDMA backend");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.51.0


