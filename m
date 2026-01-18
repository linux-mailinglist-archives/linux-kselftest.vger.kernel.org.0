Return-Path: <linux-kselftest+bounces-49275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C47D39607
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7CC3305577A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD9339864;
	Sun, 18 Jan 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tV5K3wFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADDC337694;
	Sun, 18 Jan 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744522; cv=fail; b=RwRP+gKOiMIzMR3fOjHbjsL/tF4GKV+e4e+X/zufETdDy0qAI90eF9BhXfinALshQ7nr3cPEtjPzGdndtDVam+us/n/047LxwS+DcJWgp/2q2CwYSFwqp+xG0Mma6KWGiB2yFl2hDxNNzaShJb013tyLB2NN6GgXd2KeKbodGiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744522; c=relaxed/simple;
	bh=IqHFWJSuGvj6r22CuJXevKZnus95/9vGeu4ZTRtzxKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owxS67DOOFBLsJNrY06BTzIFAfCTx0B1fCfqzzA25e19D2FD1/mApaHf4oGM0SxCoxGHlXhxhjIDacIJA3VKf3+wFqpRY7UhoFaGE+1ZGPFYWWG8SomOZZ40OYSFz+18U0pLk9xRHNGLtOVYkSBdcEX0NHe2GB07vmlnv1LFwXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tV5K3wFj; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gjby+5pggSMDh69dKa3rIxfTu2zyMiHXWKeOVUNC+XLGKgPusReblOv6iDk0Rp0OjjTB4Sa/8KaVlnmhchgWoDvkodXxTXSxlWB+9ZAuyA4yOBEzdM/Uk/MHKMvA4P1/hKrRcarSMTP9rgD+cmFM8O3eLUBw4jzCEZ8nd04pqYO/IcEjPXb77K8uUWnVjNNpKSnZKTyzaCn9GTwZnsdkR5U738+RkCGqgryDGzrCtvV7ssecxcfVpecJv13ndJxgVDWwVWELOQSqnDXoPB6WVQwR3XQFEzd7eDnA1wdwraTLtc9UqtzUl8Gopc5lEMr9o0PObVPFipLuN/VoNikWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFYiyTPMquoLyl/d26zlE8HHBOkav4JJ0IvYZIGL8Iw=;
 b=E8teBkrw7acEq0CEHVc3V1m8+9ijambr2busm50F0Muw7/fCZsq4lgymDYtkF/PyRpRlSyIWlaitWMbFG3NtS2mGK1yG3pLUL0SnAJW34UpxZOTnInSL+pPXn3cw92dd023U3czgbKI/jwR7+UBd8wsBiOVCQsLmbyFwS4OydBp8bPrGTYTACWslRqi0g+AG/vXTLcQF9cTENo3nGergzoMfoBmRPrAlDOikzwLKR0IXHv0vZub+lYGyKF0wIQs1KyDDjho59DlgXyJ473YxihjRY9elKnwzW2Xcs9h0462D4ywGtG+72QH8NXxsFAE1dKFkU5A42vHmBYqG5Fo61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFYiyTPMquoLyl/d26zlE8HHBOkav4JJ0IvYZIGL8Iw=;
 b=tV5K3wFjMnUKJrOhEJfSnYnEwBMRd9hlJIVKxGKBn6REva5pJyz6PyqBecMATkzBH2qLEeRXYmnnQi/6bOqIv2+QR7rD4BRqv6+1j1XQpCqhVPcyqNbjWU36h+H2cYD0Z1ZnZIFYbh2wiA27Ik1HBtyJHbDK8WRa7UGUtT98Lio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:09 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:09 +0000
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
Subject: [RFC PATCH v4 21/38] NTB: ntb_transport: Export common helpers for modularization
Date: Sun, 18 Jan 2026 22:54:23 +0900
Message-ID: <20260118135440.1958279-22-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dab20e7-a727-4cd9-cc97-08de56993156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WCUt8o2P3J0wefh+3MbVqWW3Yw6EO1UhrXyurcprWX4qXJ4u9F0ghc+aHkgQ?=
 =?us-ascii?Q?Qji9srdKiHVImUOrMeL80sImLef9kE+3yL1Ss1rRguDoWrizHzJVlkh5qNpJ?=
 =?us-ascii?Q?k9HcBLMQy0G9SMH0P6cItk5+DvBTXFJ/sEdUt8NZyVLUM5VnSPh/xc1y7UjR?=
 =?us-ascii?Q?BhLSvk1njHtMNVnH1KQUoWMxlDyjB2CRGTuqIp77NlWV8ls9OSeyXJOaBW/y?=
 =?us-ascii?Q?5kBsslfOEZSmnr86jcZwcbN97ePYGHGuFObnbmwEB7XVF42ZVms4/5kMgcWn?=
 =?us-ascii?Q?Y7SsKOZdrdsm3ljD52z9ByGYf0dalddWNuG8NkZEqcegPxLYWMfm268kh/Qt?=
 =?us-ascii?Q?+MFU2+5PDHxkbZt9Hu6uhJeXB+cGmCv9WimyNEA7V7TrlAU6Iwx3Wj3P8MEl?=
 =?us-ascii?Q?OV1YJ+Yj+wapBUWSQI2fuEmuueMZU6uxe+WzIKB+0v5wK9tWjexO/VljSTJn?=
 =?us-ascii?Q?W2kxI2akXwyi3LR2ABpfrDb3tPWkYtyTqKnRbpXpv8l7Imaz/zbtdMwBzIN8?=
 =?us-ascii?Q?6exJOVTZu/dDzJsVl4pCu6FAK8+K0DRnuG+XUGHp1GVNnbTOcT2PhEKWfH2p?=
 =?us-ascii?Q?5ZLW+A/74FusbrxU2h9TDp1Fcc0Gtv292ZFYpQDJvIvcSpV1K+9Choq/5mhf?=
 =?us-ascii?Q?IaxMhXp06Q1Eezrq+a8ubdhdWp8NZ+dp0OQDkHhqU7G5zwSmMk/oyM5ArJbW?=
 =?us-ascii?Q?RSvB0O4KAZoMoszrvIxrXmbEWgcnvoqul9pes2o9IsI2HYDbdac0pCKN3oGS?=
 =?us-ascii?Q?qlaeZq/I7vWzuCS0uZjDBLTS0KuurYyfqeJNvp+XtVcmyDicvSOFDIxTco5/?=
 =?us-ascii?Q?ft8DEeZW1WX5ZlweWCb1rFQMJO4SD2pRU2LDbNCtPg794Xj7Vznf5ojrlnIW?=
 =?us-ascii?Q?zpfbljLUNJda4hrOIrdn8mK4aKkg6MEHYu4LvDYFWrNZOBYV4XkK+LOk2vqo?=
 =?us-ascii?Q?fzYHprUwN0ZP+hRdGnRHPaZIMhYHsi3UTPrD0GCsnmRgnuKPpi3o7HKnm7Ta?=
 =?us-ascii?Q?wIYcLVz4AvBZANUL+0eUrXveuXnlb8u3Fjq95Aaei4x3mQn+YIXJ0Oz/WY8W?=
 =?us-ascii?Q?BjgbR4ObIcXel0bCDRArPaBLUZssZYdtLZqac23XwWtJE+FYYQynxq8TFKkm?=
 =?us-ascii?Q?R/bBXDW9ZQ3CibfCmzH5Cc7Rh4GtlRNmlBtglfh3CfHX2Kte88bkX3z5OQTI?=
 =?us-ascii?Q?84oKf0pkXdVQDO+wm1YdWZkCMwI0o5EtolPDF8VZgswvG+grukDzkUOh9h8v?=
 =?us-ascii?Q?AYXeauocUZHm6imKrkRE5gbPPZIoPnvKciRUd3CK8RXF3ahMGcAoz1xuHkU3?=
 =?us-ascii?Q?gC4o9+yy96NCHOvozfk594hHigKZVQPRtMHPix3CzKV5N1jc0PymgOBi1x/l?=
 =?us-ascii?Q?cp2nU7XarfKOEGltJlcV5CT/cd0R7Zeu90qW8CKVlYR1sW8oWm5BvqakLief?=
 =?us-ascii?Q?GJ53SbrWCmNPgv5yh106ku8+u8+UGJAyTK2tVrB5OfGw0pEHVMNh10vcL9ce?=
 =?us-ascii?Q?YzsnavLlWPMCp8L2hoAfelQfDvzLzkTdz+Mc4fX4VF/eOKJ1OsjoHmTlknrE?=
 =?us-ascii?Q?ct92sruojjQYlFi5lNnSSgZrLe7gQWY7Xdszsuf7EsmUP9U/Z3gAKeVGniFr?=
 =?us-ascii?Q?eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SNYXYj9PaUAfZtZD/AdqzZJ6F3BFjwCKZHVC7Fkqt9MRv0AKM4hTHOpD+GFb?=
 =?us-ascii?Q?rD1TQe+4nHfcj4WzW9SvyfZ/Veyu/6xMfuZaTTfuRl78i8Ew7kVRfkSWwJ6l?=
 =?us-ascii?Q?smwOVqkVeNvM8M5ku3lofMjkN7Hqz/tHpYPtA7u5bGSbEcX9QIJgE/a5TOo/?=
 =?us-ascii?Q?pWvw1tCSylDA8TyLCYDkcVR30y63nlGaAzHqeKchU1jP0TNno6pSMIDPKXs3?=
 =?us-ascii?Q?/ZRI854WQe1t79TtoDeFZx6fcxbPV8GajL2HRQ541D18PzBicg8vlSpxksD6?=
 =?us-ascii?Q?r85wzWUN3DabN5/b7RxL6e/sEIGHCYX4qw4QQs4nR7HhWFd1G10Hr+WR7lI1?=
 =?us-ascii?Q?CWA6Bzpe6XmwsWBNw4qJbZT9SWDkLdx5tqTAmBY1fUx56ZX8VPa84MiUpvQe?=
 =?us-ascii?Q?829zKR2KpBnc5il2xdaK0TRjmyusMAAFoUXNHVcLX5zR62OBGFv5zkfgwy8o?=
 =?us-ascii?Q?+9SHs5lzGH6KarbfTxbZRfkIv0IJCuyplaKjCAbeU8ep9Fa4n1NPC5jgS7lW?=
 =?us-ascii?Q?bbxaZoF8h2i9RoEJny+Vrg3yqKECmTu1BKgiHoNFglFUquqvdE0VMUu7sfZm?=
 =?us-ascii?Q?FEunOivvD0+BpnK4yPsnaV3XWVTGnI7raVzORJEwTm/+nyPtEhOw1Mq3hBEX?=
 =?us-ascii?Q?SCWB2bLUi4OG45uILUbAR+6Ca9knb+A5t7hcEvfx6w4qROrgBG7JCKK9cbLO?=
 =?us-ascii?Q?YCZu3jk4k0DMzBJfkwfFHZqiNWK+9ZgDK7+0okZJ4H6mSygoURVLLyoCBMfk?=
 =?us-ascii?Q?ID/fJE4fVWhDdZmytZopy0hlCAKC65oJp8B1DLwC7FeOYxzDaEyInpYxBMqa?=
 =?us-ascii?Q?QwB4UsRaLFllKEmKCYEsJrnIXab0pFmf5Z339G7iBdnsY3kBPo2BYON8OUVi?=
 =?us-ascii?Q?Hpo5BLAXYpMbJC23i3fEHFYYF9/Tz06MYxa9w6MYoC74r1saY2ElDJUZr9xW?=
 =?us-ascii?Q?yQPWMkuVy8ckuojV1kxBDDzMTGZ/B46RXOFjVpWl3wZzEvy8TDasL5CNg6aW?=
 =?us-ascii?Q?I/u5x8v9sTlZc0XOjEEdXkxWM6azrF53i/MuWIWzb7EiKcqvRFYGHpkcv6kc?=
 =?us-ascii?Q?jliUL3ik+fwHkcu+n8S1/nTh2SCrTlET3jPF4tlijYNpOywA44cgVQTKBt0z?=
 =?us-ascii?Q?GrTcjvsz33HwZbR3HF46Vy3dXwTp1v9viJvDz4h81TQ76XuyAzhqrtJLMtdp?=
 =?us-ascii?Q?dtXK26gmTkO8qdSj+6EcK+t3jkIrvYnNmg0uuN5WfP8uzOZBq/KmC9j1MaNj?=
 =?us-ascii?Q?hINqTvSNgVThc9eMYCzkkNOXLPhj6eKAUhaQz2ROVAyvHzKcOVroUgbdD56P?=
 =?us-ascii?Q?LSJ20m3BixZmUDvS9TvsMDK0GFY1fZ++hgQmossJdvq8/sfNbsmyxSV8z9vz?=
 =?us-ascii?Q?cY60eW0sXtMHvKDK8PlFguECgGEfnGnqkH/PH6yijzKpfcProuUDyKORQvHz?=
 =?us-ascii?Q?upB2ZtruLN24ee73oOua1ZiFoXcfHT8sVOcUhP+aeQYS5+fx0ibzy9V5Q1QV?=
 =?us-ascii?Q?lWcW99FexQz5xouSHHGTeRxWX8vA4+Jnl3ztbn6ZJfsN/aVuO/QyW+MsoXVy?=
 =?us-ascii?Q?2jLSiYfJUZ8GvP0fcNNl8cRxcvlj1scMGWQNKOma7PLJlhnIyFQzCFvL2aYP?=
 =?us-ascii?Q?MPB5p1SXftO/WTJW9SF7nNLxDHPNvylcz+b6apmpw5OMqU9cQinF/qZd7Y3w?=
 =?us-ascii?Q?Kng/Bt2HoSjq+p6rh4fy9hmHfEDW2zcT6EDyRWlfV9csqD6UL4X5AUPE9WZV?=
 =?us-ascii?Q?WO9kpFAiV0HB466yNMLCVTi11zl0cduhY+kx0CbK6YGGdMcri3CN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dab20e7-a727-4cd9-cc97-08de56993156
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:09.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2a3wH9P2pnrW1wMHB1n7xtVnuC3qns3dLly2DzMDqtqJRBRcSZcM+wkP+C6biIY12DrGgqtvfOGdCyuNC+JOkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Upcoming changes introduce multiple ntb_client drivers and transport
backends that share common list/queue helpers.

Export the shared helper functions and declare them in the internal
header so they can be reused by split-out code.

No functional change.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport_core.c     | 17 +++++++++--------
 drivers/ntb/ntb_transport_internal.h |  7 +++++++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
index 71f01fa0ff05..04a13fdce71c 100644
--- a/drivers/ntb/ntb_transport_core.c
+++ b/drivers/ntb/ntb_transport_core.c
@@ -371,8 +371,7 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(ntb_qp_debugfs_stats);
 
-static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
-			 struct list_head *list)
+void ntb_list_add(spinlock_t *lock, struct list_head *entry, struct list_head *list)
 {
 	unsigned long flags;
 
@@ -380,9 +379,9 @@ static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
 	list_add_tail(entry, list);
 	spin_unlock_irqrestore(lock, flags);
 }
+EXPORT_SYMBOL_GPL(ntb_list_add);
 
-static struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock,
-					   struct list_head *list)
+struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock, struct list_head *list)
 {
 	struct ntb_queue_entry *entry;
 	unsigned long flags;
@@ -400,10 +399,10 @@ static struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock,
 
 	return entry;
 }
+EXPORT_SYMBOL_GPL(ntb_list_rm);
 
-static struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock,
-					   struct list_head *list,
-					   struct list_head *to_list)
+struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock, struct list_head *list,
+				    struct list_head *to_list)
 {
 	struct ntb_queue_entry *entry;
 	unsigned long flags;
@@ -421,6 +420,7 @@ static struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock,
 
 	return entry;
 }
+EXPORT_SYMBOL_GPL(ntb_list_mv);
 
 static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 				     unsigned int qp_num)
@@ -820,10 +820,11 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
-static void ntb_qp_link_down(struct ntb_transport_qp *qp)
+void ntb_qp_link_down(struct ntb_transport_qp *qp)
 {
 	schedule_work(&qp->link_cleanup);
 }
+EXPORT_SYMBOL_GPL(ntb_qp_link_down);
 
 static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 {
diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
index aff9b70671c6..6b45790cc88e 100644
--- a/drivers/ntb/ntb_transport_internal.h
+++ b/drivers/ntb/ntb_transport_internal.h
@@ -156,4 +156,11 @@ enum {
 	LINK_DOWN_FLAG = BIT(1),
 };
 
+void ntb_list_add(spinlock_t *lock, struct list_head *entry,
+		  struct list_head *list);
+struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock, struct list_head *list);
+struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock, struct list_head *list,
+				    struct list_head *to_list);
+void ntb_qp_link_down(struct ntb_transport_qp *qp);
+
 #endif /* _NTB_TRANSPORT_INTERNAL_H_ */
-- 
2.51.0


