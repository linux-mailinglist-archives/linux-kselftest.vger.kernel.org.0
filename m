Return-Path: <linux-kselftest+bounces-49292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A8D396DE
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB56F30D44E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F8C34F250;
	Sun, 18 Jan 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JIV1surE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F733CE83;
	Sun, 18 Jan 2026 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744552; cv=fail; b=SmoeGFwHVnUS67jRnnkZO+CuUimlUgvtqgOEpi4alNWYAvP+UgfATU9Kq+0gyb20L+7GYSf1We31gmXFpvNVVVGBV7/rCaJCA5LzIvHsqzjyPMwECm0sS/WGBPBQdYrvfQNWlNtCJmhQ/lDYePgI8pKriDph+0iMoCEPKMN9p3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744552; c=relaxed/simple;
	bh=0A3xkqVWiRQ/04TfgJdKO+PKB+im5i+bWqzGfyELq3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFcsosfSHG8MLxP5j5inDvld6WHCQfZrzil1Hj1IWVhVZ4e31A5okmj+Kg+206RLmiYdemZ5njLPO+VXDQLWLNFzeAVs50Z8g0Cae/nN39UlQ+Tq+giyxW/HPNo/u9CBo+JWkdA25gfHgdROhpjZUDRM8qn7QyizPxt8RmoIys8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JIV1surE; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzHf8CPb45nBUhw++M/o9fnDQeWYOjHqb1aImSsVAm11u20GNjfjT+opylGyUBrLr2nI5f0X0+ZYnHNDO1ph9gQ4eORBsPzeFoCW+nokhzkSXdMP5G7cf/5iDDmDONnGrtVAfl2k1mNqP+2z2+H5x1vYWYT1I7wMZvKNaOjakywW40fUG+BhyGXisnVjwBBZb3JoKZSFNfWhwEDHYaosAYuGYUoPW5zXOV3WOCt2hzg1u9v11bNY3BQMYcu3WJBHXU5fwl62DPFsVWCavxaHSg9C8KrBQrUnSnRTVmbCah/4gxGD9VVbYs/Fmd38vn/fvbaME6Jxk81h57I/mVB91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UDTuV4vVEOzVHwmwk1GDcwOpMfmBdbAREqdadxzsRs=;
 b=RFBoWST6s9xKx28PqKQrrvySH1dWIjzo38qoP2Wy/VOiLyxZMprJ0aCyu7PtgutfziR374DeltL84fs0JTBFJkmfbUU7mRdrayiEzujsrbs6HhU283+dRyuaI/ZGgOFC5BzMGjaSo7E1ZqDHiq8RfzPvzT0JVOHuwtcNzVtK/av7DfnavMl9SbH4AL8fVVYvt1pMxPxXycBdw1Fi2v5oKsto9qQuyAt7F+uz0hY2gxCCF5g7e/K+eMUM0Rn0rmHuQ9csgg2ce9Z3I/rmjhVMst4dAYLiUxrwtgfzdpXJaVq1Bru/E1FKi6eJ14qQ5NkXZ+ZGjmVbz5tI8rHA7APbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UDTuV4vVEOzVHwmwk1GDcwOpMfmBdbAREqdadxzsRs=;
 b=JIV1surErcrmzqS9nQ/MBugoa2psyC03YsKeIkWyCQbQrejXZdLToj+OGF0bQXo+ZpyTjn49BoHdqagfG2SQ3U1uaAD50C1S+9W3wwqF42PSGkNYykRup2OkErC/lR65Jums0miyKDCKzQ9bH591wL2p2CJ1O3BbtLUSbCGc+JE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:15 +0000
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
Subject: [RFC PATCH v4 28/38] iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
Date: Sun, 18 Jan 2026 22:54:30 +0900
Message-ID: <20260118135440.1958279-29-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0113.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: a3891caf-f38a-4963-e6ab-08de56993500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rikIWMzDnoPEL4dp+ZIN4aVVjcZFjUioqij4+ReNoQtOJnhEwYlvWZKeCzF8?=
 =?us-ascii?Q?M4LpEmixuc2XqAFFYm+Xtsy7GrOO7IkCCwWDqX01vETN1a7TlyCf5cdzor55?=
 =?us-ascii?Q?/gvy49TzUF54y9mClCThhFvdSnnKUu0niEHIHCdb9fXZuQBCuFU42rlmjMY5?=
 =?us-ascii?Q?5h1WqBgeiCfAsdriTtSOku5a59z2XN/lg6MPECnkXTKDHNU5h9eALa90maMX?=
 =?us-ascii?Q?rKAyEZStQxp9XVU3yWELcKLMLC0rNE3bxpU+7Xc0HY1Apa9IVBZhEco0zfFu?=
 =?us-ascii?Q?pTt/acyrbZz4+urWswjFtzfxwAmuVTxq9T8YMmMEaiXBMiU3eNqSIWqOzep7?=
 =?us-ascii?Q?ZrZbKJGW6uGW7cvU3vygJFAr+h2GgEaMGHuG5wSYFMoWcd+wmfQM0IYn76r2?=
 =?us-ascii?Q?jSsiJvhzhL3eedIIJjUFRWbfADsg1oMCJ+R2CThz5YYJPUNQcVQDsO+sZFjM?=
 =?us-ascii?Q?CZIn3x30lHl+MN2CO5Y2KvGPbdD0i/ZCtt5aF+dToGk/Wo1SEFhbCzW8PmEf?=
 =?us-ascii?Q?R0iAxztOH69PoPdde72p8i4t7H0XNq3ma6WaKI2Z3Rf8Z55BdEvAuXYnpVg2?=
 =?us-ascii?Q?YqZ4XIwlsj44TxlTHGsfjQ4IEXNHsaOKucLX30ZPuO4sgMy1SkQg9LE1QwRy?=
 =?us-ascii?Q?91U/4rIXQfqBZrrvCCtnCQq/KxLiaREczaln/xl7D/HCD4Nh402ZE5aLlnj3?=
 =?us-ascii?Q?0AEkiXml1Jhztd2gFRVwDBzFsAyJTAxzil2Q3Sy6eRQHt8V0Pd9FDBwhGsj0?=
 =?us-ascii?Q?4xJ4fE1PaRPRlhpkazqrwMwEfK42YgoRF8tb7pJNzmm79l7eM3KFlXKKe88B?=
 =?us-ascii?Q?daBSJMXgW2cvm5YK4YnIK23hALbTG8TBCA/KArHyxlowq1qE/PqReGi00qhq?=
 =?us-ascii?Q?3pDRse78wMzGX92+6+YCMftXG9ZAM9HgB3xX4I8FtsFLCHvCtHp9G2yVBXt5?=
 =?us-ascii?Q?FIm3dEM7eHuVyF2gPIX80f7qOC5S8/2yzUw9KjrhLzObyZYJkd/5ZgL9UHzP?=
 =?us-ascii?Q?8/wIqX1wasgyP/Il6SK/y83XhuhOZD2r04VHuntD37v9T4x9d0SOwOQUOFNP?=
 =?us-ascii?Q?x6En+mfIt39z3tf+NQ1yyWnyrVrpee7sAmTNPn6SOUXBtSq1CtaEq7F0lo7c?=
 =?us-ascii?Q?XxNeywMMRe8Rokk1E88gZqh5kRSCAXD3N4k4iISJlH1ohz6elhs3V8tnXrJK?=
 =?us-ascii?Q?i5TDg6WyAGdaDlx5L9wwf7JRUPvy3ikZpPdJab7CH5kYQotdGw5JD/9WEnDb?=
 =?us-ascii?Q?Ldete4xPFprI/QSPDlJQuwrbGvqdulamYtIoufzPNVdwcCh5ttlOEYxnzlSA?=
 =?us-ascii?Q?BJxkfe3PEVwRg21R3WOgwUjsgJz/7tHT0LyJ3cAKA9IcTjPrG3Sf+Vw6WYJh?=
 =?us-ascii?Q?3d6Ez/6WTyHGlx1X27OCiI8Pe1EcxanF2hqzpdpF5WWW75/Ib4g3lwNQx9hI?=
 =?us-ascii?Q?KNW8GzGUjQpqZ52EvXoLbX3MZPLmmtuAnDQ+ARSKRJ4WeP/wde3HJLMm2sbx?=
 =?us-ascii?Q?cNGdr/G9uzgw2NJGuBLTpdYdVqysU8Uu4GnMtyRAFBmRzDfdWJG/CVtQIlQ8?=
 =?us-ascii?Q?QgilSymt0GdTHgC9h6IKbXxM7gxDODZszVAggUL2VfDtl7Tj0nHYG/l+pb6b?=
 =?us-ascii?Q?rQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rf5WTurTTHy1STy7MdsY9fV9koIaMQ4cjk8dFr/dPWsqmAqdFT5a5f8GyeBW?=
 =?us-ascii?Q?MMFCGK6EAUclLj6bSy2r8bzZL9PAtENmzbfb5dvzPx9KfwTNIu45eIkp6jKW?=
 =?us-ascii?Q?Ys/li1J4mZiaPMIMMW5nyQfYfN79a/nbxY76zHjvDW8u3HEZdF1hViLN1OGH?=
 =?us-ascii?Q?xIW+iVc6q0n8wyvFvi6mFGt8mK/m0pNcQAZ9FKBBZOZBHX6GmJh8lVZbiva2?=
 =?us-ascii?Q?tTTvrkWiDNb/o2irGq/reqxet44DD1uIPKXuIpd8xx1T/TZ4cKHSZSSo+Slt?=
 =?us-ascii?Q?jQk4sNa8B3nFUlWwLh5G5wi9GQ4aT4tk1vnudWBbz+pnHXXfll6uczpelY9+?=
 =?us-ascii?Q?SZyBOKD9FcBpGyewDODp3ucmYh93/9seI4FCXWjAYL1pwYJC/9kc42258TL6?=
 =?us-ascii?Q?hoX9HiFAj/E0hU79FirP3XMipVY0EQ6TuouDMJSlBzZq65+lOfp0fC2ce0VJ?=
 =?us-ascii?Q?8ztwzP4+bbNgjI38TADWhyES95QGmKd0c8m6yrAjarfL7+hWkeNH8wNfHEOG?=
 =?us-ascii?Q?3l8iLxZznF/yGtxqy0Y8rRJCNoDQlSTYKoNH+XTHMx0s6kMENj/Zv3qmVgLH?=
 =?us-ascii?Q?s71qYs4kcg9buOufl+jRrJRVZlanHhzX31JHWL1Sv0QPb5+3rjni1fQSg5Xb?=
 =?us-ascii?Q?ps+Per/k6eRdA238uifqmkYJSXfHifhUkNEVgJk8BfIupL02D3XHkTRpxyvi?=
 =?us-ascii?Q?Ow6CLfY/SdpFYwtIpA2aZGokAlmoymYTuxHHJ2pHliUVunrF4/tZ30Ifo4gU?=
 =?us-ascii?Q?nmCJqgwoRdwc+cr6vpA01i2WScPqUveBihNzgM8kYEXkNVJ9empJsG9toEN3?=
 =?us-ascii?Q?285RYsPYBCXjuVax6c/7R1DWmczRaOn2MEXAmTMS3FyYmWDeRsvfZNRJRakf?=
 =?us-ascii?Q?sOH4i+hwQdOBdPScpm3QZ8LOJKC1tk4sAmKP0iCzyWvXK9w6ZlRk6fhpY8P1?=
 =?us-ascii?Q?+QwUHXzR/H5YZPA3zOnd+BqhHK0XeHHT45oQU9qB8r7SyWT8gD2P7Ktpiq6a?=
 =?us-ascii?Q?zZoU/IjeTY/1iOrofDsxYcDLVEZt3u9DlIJ3q4Zb7IJ1x3JsfAhIGUWavuwt?=
 =?us-ascii?Q?FvrqcGud0bREziPPVxcC3/C2rn52XCL0nCOyytNXI7rNIklddHPnqPBzrG2p?=
 =?us-ascii?Q?TsG2KEw+K5y2jDuMFo6Kwl3oY0e6k+0FN5oqqpJFIqWPX0oCAVYcVDVBn5bn?=
 =?us-ascii?Q?gwP2A5llvFxG+xB9BXah39HniSp0BAWz45LWqUoBtZLrPOyIhAVN0JvWH5CG?=
 =?us-ascii?Q?j1DC7Ik7MQj2cY0HO6iSBP9WIKfEdM44jzfgZXFnGFXyn28Vqk359Mbvg7h1?=
 =?us-ascii?Q?b5iQoM6dhNd9d+uYk5mgrujamI7aiov4/8uA5/sdo2Ypp/5VroKFmOpPTJCQ?=
 =?us-ascii?Q?8EpgCImNJkQhVuQO8TmO0zPKf/k1NMcsNrGoo7a1B8iWDhKSPIqieqVTXUmA?=
 =?us-ascii?Q?e8919OAEOkPPJQ6ASv54SkFyzkH/1UtgIh71YE9Zz8oypviVMiFilIc19EDA?=
 =?us-ascii?Q?ptEGp9tU9F6FmaKqgixp7OVvqro/zcPpwcIC5S1hb7zEMwev8ZRSDmFW2In8?=
 =?us-ascii?Q?aErbVDx7whkqvcRLsmWNQXn7UhN2EL4g7Xg2mJXAHPMmBPv3TaCfxQk7ra2P?=
 =?us-ascii?Q?lzZX2lnWaoE76k+fDgvJg2cY6w3jMk2izSUph7bgGcE1Uz/fcfFob+JDDUC4?=
 =?us-ascii?Q?i4CjfDJ6XoufMQQbHVDkanWLURjLmtfXE5KBnH8rv8bw4JAMp7w7kZmr1VvD?=
 =?us-ascii?Q?QqvlXfusGflvcWFFtBfrv0aqIm1RnNoYz47qVpxnxpq9r81Rx9so?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a3891caf-f38a-4963-e6ab-08de56993500
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:15.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XedNUuKvV8yTF4wjohP7TOg3UcFGcINRl+vdkl3HODoKG/TN2n46gdFMX952oUvfAb0BkCt/qW1G7Mv2SDIs+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Add the PCIe ch0 to the ipmmu-vmsa devices_allowlist so that traffic
routed through this PCIe instance can be translated by the IOMMU.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ca848288dbf2..724d67ad5ef2 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -743,7 +743,9 @@ static const char * const devices_allowlist[] = {
 	"ee100000.mmc",
 	"ee120000.mmc",
 	"ee140000.mmc",
-	"ee160000.mmc"
+	"ee160000.mmc",
+	"e65d0000.pcie",
+	"e65d0000.pcie-ep",
 };
 
 static bool ipmmu_device_is_allowed(struct device *dev)
-- 
2.51.0


