Return-Path: <linux-kselftest+bounces-30134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D3A7C381
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07523BCA30
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDB922157B;
	Fri,  4 Apr 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YCmX7qDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B9221573;
	Fri,  4 Apr 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793336; cv=fail; b=niQ9a1nyj+5uzS5rKmrZ859gTe53Q4speIfWaeszO61hdfUL4TxeOrQgAo650axH7TbT+AjSmVsEJpqA1Eaoc57pPuWl13TAwVAUpZbMun/7dMDJ0PIF0pw55k6RnzBgTUkUCytiV0UOyYuWRuEJ4GZk7J2Gb5OJLPsY0wonvhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793336; c=relaxed/simple;
	bh=1rniyVcGag0eNeLrwWvT+jPUnbYZckhT5xHhMRAAH+k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ndZCzq6QHivMjKvzu1W5djSkRRNKcqzlXppYQ0Vnz6trv3GfgFGrsCmw53V8Yl8+aaNUzud1KjBivSJRz05XRJnAXusYnMgakjf2njSBMGOQO+FPJWCxhgRJVIhGpGofSXWDvXUJ5RPG+X3VNYoRCuLuA5DFzSG6eFszdszHbHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YCmX7qDQ; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx+f7gnnVxcv8hlPZbpBxKM4G7s2FoL27WtYJj1UXomtc3CK907GM5Xt1b/bmx/2luxRqE8yCgCV0dBjyQ+JQBBahEmSx6b5f4YAFolzRHD4akD3TvyxecU3Mkx43n9/uJdyhRHEnN1uwF6MskUR8xyHxEI/S54ijpV3i+EPVnK2Uf0aeuLleMk4ufP4r62YodlcRTeQHpcw+261ttGdoMSg7k3aGN2Jh28W117dSwClwDn4t3Yp9udJ8SeFncJJldhPLsZNmSlBHDFfrKgvPBQu0RPUBVDhApEDz4OcB2Q/iYrUEtvai2i2JVWd4+wRwkOQaoop+n5ZsHNjwNZvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV43Lv9xcy4k1Ss3c5nbEs7m6Hdf2yF4V9lxFdIqHso=;
 b=Ltjz1OnvnJKN2rEFcrxMx/Z/zCzmPHzyIROLzhlaIdiVCnfLk5XL/id0p9I00B3087y06qjXighoAoyDNod7C8ASBlq69cDd8z2fr22UIoGaiob91XTTb4z45Lv30+VX3Jdpgw78ltkT1Q+cGVDVcz+3nvAlagFDnOW9WOIDNet4DnR9VfEjPc28fwzYFhFsS86nv4MEbcbOBAnqGFqoXQhxXLHf4xbzy0DIRUDSIxnvfm7Qk5YDpdJ93w1kKlCgUjVBAJCIuRQ8PokmDjcQJ/m3oDn81fpWzpeJ9OPmOdRmlxqum/jGPi+cXe8HgA714XC6t03TGBShHAPgFh02HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV43Lv9xcy4k1Ss3c5nbEs7m6Hdf2yF4V9lxFdIqHso=;
 b=YCmX7qDQ1O1X7cs0/6LY0g1HGvAVvcRIb+ktUmCs3cSFbiTeZm1Z/Ge8zx0ie/D0NLZ9zoaTDCzdSpNFnRuKKLI3lkzclAFcvUk2Mq5Gr2cjWISRB5aA/7xw16L/zReRF6gpsrmePc2FXe7QFqzw3BHYtL3mqGlw/ZS/LvpuiDoHY6t8luPpt/WWlLUP8oyLVlIL5OH/7cxvD0a/B47iK7NUsT2GfSNrTJWdszkuvFD5b2YVXjIn2ZNSRXOZ3qgBEmqCOR2AaKpUeyOSXv2mOsrsYNEnoYZDYYeZvEikLUNh0Y3kG88YS61nqVZFp1xdTA0jANb42mhGLq1yw/v80A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:02:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:02:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:07 -0400
Subject: [PATCH v16 06/15] PCI: endpoint: Set ID and of_node for function
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-6-d4919d68c0d0@nxp.com>
References: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
In-Reply-To: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=2203;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1rniyVcGag0eNeLrwWvT+jPUnbYZckhT5xHhMRAAH+k=;
 b=l2GT5L9pAQRtDgsWVqS+DYQaoA9WM/piy1ZMyGQlFSWPnOn4Iu0+Cx1X+c+14JETVpXYXUSZG
 OuF5a5+ClugDUoZC+MFwQGkSpPLyriD5qv5z8o68Yc9UQicY/PaoMCP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 697490ec-c8b2-4178-fab6-08dd73ab34d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjQ5R1FsNFA2eW9jblhEdjEySC8rWXJEWFljbVljKzJ6dUFEQzVXT3pJcUd5?=
 =?utf-8?B?eXZoUnNEVm4yOTJkUFc2Q2RpSUpWMEYvemtibitOSS96TzFuZWV4ZmZEbVEr?=
 =?utf-8?B?MllZOHpORUVCeHBsTkp6UXRjNmR2WnVUa1I0R3ZMNnVlRTJJMnRLdk83SmZC?=
 =?utf-8?B?ZXlyMHlyL2lVcUEwbjMyM05iYmFxRklBSWpNSlVVb1g1b2ZGM0h6T0FkdTF2?=
 =?utf-8?B?V3hlWUVybitmcnN2K3JRc29KeW83Smt4dUpDdlQwelgvczZQQnBqY1NFdXNV?=
 =?utf-8?B?bEVvWU45YSszZ1JHMDQ3enRXam5KR3ltcnQ4QzFGckN6SXBhdG9MMnpSYnEx?=
 =?utf-8?B?ZEg2S3JSTENtT3hkSTE0VlAwODVYUVAvSm02R3FJZy9jVm9VeXB5cyt1S29w?=
 =?utf-8?B?Y1o1czdMYjdBZ1QxZ2hBWU9SSUNhSytSdDdVaEJwZmg0UDFSaWQxVVVYNldn?=
 =?utf-8?B?cnR3VFN1RFlMQ2ZYRFNsMVd3UkVveFQ3UUhaaFJRWW5GcGMxelprZjF6YnZH?=
 =?utf-8?B?M0dPbFlMalo2WGFsSTR1bkZWTWJuNFFhS2JYQ1dhVGJtZk1FNStPM2dKV3dD?=
 =?utf-8?B?SnJLd2JVb09xMENNZ2taTUZEL0x5VzJJK3lNamVEUW05aXJ1UGtRMDU3RVJX?=
 =?utf-8?B?aXNNc1BzN21tcmViQXl4Vkd6bGlhaTdPZTZuYmRXZ01vQldqdzh3M0haWlJ4?=
 =?utf-8?B?T1BWVnphQjJkUlhxdHJwcmJSLzB1bGJQalA3dUpkNnFCem5yRDVGVXYyQ0dC?=
 =?utf-8?B?dkpMbURWdDRlNnYxUXYvR2tsZmYrVmhjeC9PcHpzR1NqTmRzSkFlYi9UZzBo?=
 =?utf-8?B?ZmNEUDRxSGoyWldlWk1iazFoOWZWQk94TGxuQTBzQlg1ckFGSi8yQzB0UzJT?=
 =?utf-8?B?SG9nVGJTWENRek51THhnVHN2bXV1dlVYblBodXcrVXRPeXhpalIxMEN6dFZT?=
 =?utf-8?B?djlRVXNSRitTdEQrc2RSNkJJVzQ5WmlQZEtNakY1aFgxNndxV0NubnJ6K0NN?=
 =?utf-8?B?VFBMOWRTM0tHOUVCVk1YcVYrK3dIYjJYRHZDVDF6OGkxWXY2NmJWVVZBbFZP?=
 =?utf-8?B?NXlFbUJoQm90WmJrVW1xS0NTWlFWODFuM2dIWFEyYjVvOGt3TEdMa0paOFdU?=
 =?utf-8?B?VFJIOWRueTVScEFzVUQrU3pWN0RIRi9Xc1pPK3lpWWdZOFV5TXhtRnVjeUpw?=
 =?utf-8?B?TzdvYUtVUGhRMUtUZkVncjBJL2xrelV6a2U3eDNISTdiclhNeHBEV2F4RERn?=
 =?utf-8?B?SGJzNXVTemcyYldscHAxUmhBem00dEo4VGNvVFh0cVFwcjY1RzZWV0RETlIw?=
 =?utf-8?B?VDRZYzhEMUF6N2w2NkdZcnUxZ3FWSnFMUDJ2ZEpETmR3bzdiMU9wUXBKdXE3?=
 =?utf-8?B?VnRlenF1Uys0bytpQjNKdXlETm1tSXNZNkd5ZXM5N0xod1pMWHltNldGQ2ZH?=
 =?utf-8?B?S3Riamc5YjRqMXp0cFducEE2dWVIS29aNzVhcEwyQk5EWDNMenkxcGh4ekRj?=
 =?utf-8?B?QjJGNU5JR0Qya3JFMVRnWmtFU2JCaVdpaDFycXNSVVBKWE5Fam4vSTdkd2tN?=
 =?utf-8?B?L1dmRE9PWnZUSG4yMWRRTVc4UE5TUTV4ZEdRWGFrUm9ZT1NCakcxMlVvSC91?=
 =?utf-8?B?b2RuemhEZFRpcURPazlLSEZWQzJVWEhpRjZveWVOOGtDR1NtM0cvWkRwdTFs?=
 =?utf-8?B?OU8yLzAzUkVQc0duRzd4R3FkTGpObjZvNXJRYWJXbGhiZGZyQlhhNHNhck9G?=
 =?utf-8?B?c3hTRU9iQm1JWXZiTFFvbUppRDg4SG5iTWUrMjFrMlozYk16aVVaSytFNmti?=
 =?utf-8?B?bGowV0EvWUQ3QzRqT2FNcmZ3dzE3QkY1eVd5RzJVTEdXZUh4OXA5RDJDV2Nl?=
 =?utf-8?B?NTFDOGtFSmg3QlMzTm1MNE9vQjFqZVluRDhBQXV2V1hMR2ZvN3o4SUxzZXA4?=
 =?utf-8?B?YldpS2JzNkY0MkI4R2RkbWxhQVIyRjNaenZuUGs4RVBGWXU4THdoNjB4dytt?=
 =?utf-8?B?bUM5bHArOEl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnFTUHppcHdXT1Y2TzVxU1lVSkZYelk2UDA3Z0dkMVVwZzRxRDZLOTRTb3Iy?=
 =?utf-8?B?a3YvYXIrLzlZRE0yKzdMMWpCL3BrNG5XMno0ODA4b3ljTWxoNWZKbXk2Ti91?=
 =?utf-8?B?YUk0MnVLc1JjcktDbjZLRUg0c3p0S243NFRjYWgwMjZwakJRS1NtYW9LdURC?=
 =?utf-8?B?azlGWG4xVU5pdTFLSGF1QTVGV2FmSTFpTDdaK1RST0JGelNPcFJ6RVFGN0Np?=
 =?utf-8?B?S2lJNG9yS2pwUldIWUdMRy9GU2NsbDlVcG1lOVgyR0c0d3IxMGRlNEFlVVYw?=
 =?utf-8?B?cmU1ODNsQzJWQWU2aFFGb29NQ2x5YkRVS241L0pwUE44TGlPNG1CTXBIcWJ4?=
 =?utf-8?B?em0wMXYwT2pFeTZmOW14c214TWM1bU9rdjA5ZUdwSi83cnoxZUMwcE5QbEFu?=
 =?utf-8?B?SFJ3dithRC9tWXN0b3BRLzc3cmxUNXUvU3ZaOU4vbDFNTDkrZW5Pc2pER01W?=
 =?utf-8?B?NHZNMm8wSWRnVDV0a3VCSFBETDVydVZRWlhyeXBSbVA5d21wMExYRjJzUFR4?=
 =?utf-8?B?VkJBYzRHY1I3c0hHazEyL1p3UmNGT0QyWitkNWo4VGxlbGVlMlFlRFJCa0JQ?=
 =?utf-8?B?UWcyOTErSjkvWUZhTzh2c3dMNHBtWU5YNDNYZ0JkZ3pRaEJYaTF0Q0xpYk14?=
 =?utf-8?B?TjZDQ2FHZEFiYjRXdXFybStsVnYvMUowOGREbzByMVNBK0t1b0xnOXFRY3dX?=
 =?utf-8?B?V0ZUU2ordUFGZHdtcGlFb1htQzl3WXhSV3JrN3N6TlE1U1VObW9WQTMyYkZh?=
 =?utf-8?B?d1JyZE4rT1hMTmMwaHBUazR2MEZ3U1FtRWlIL0VTMlUxcXVja2JGRHYveW1E?=
 =?utf-8?B?VG5QVHNneHlScjlybW1vMlpEcW1kMUlmR3lUMkwrUFBENGE3d3lmbDVrdHZE?=
 =?utf-8?B?YWE1YXBNWG02VHBjeE9LNTFTWUIxbTQzSE4wOEF1cVdQWVNaQU5adWVJWllp?=
 =?utf-8?B?SitWQk1ScGxJYlYrOVR5WEdjZTdnMXhFYjIrZUloajNCZmgwOHZzSUxSSjNK?=
 =?utf-8?B?UVBPdXpDMTRvQjZ4M0pCME1YVjNPeFFsYzhHbGhoVTNBZG9TWk9WdjYwaitk?=
 =?utf-8?B?Q2tkcUhxenRKOUwxSlc4c1ZsTEljQTJqUGhhSUhvc2lsVk9NNUVVYlNpWVNl?=
 =?utf-8?B?cFZrSEovQWdQRkZJc0Npcmp1bVRDcGx4cmRMcEtZeFFIQzR4TUp6K0ZXOXoz?=
 =?utf-8?B?M0FPakZVZVB4Zkp0VmhRTzQxbVVlbjBPTllPa3VaSkRNTWdhZUdlSmwwVlZZ?=
 =?utf-8?B?dDNvc2pDZUI3N2FhcXJtUVhoa0lIVk45aWFTdUY4eDlCejhreWN6UTNOMFRv?=
 =?utf-8?B?Q0ppTnhMZStoS0RERmhKV1hPcWpXb0dKNnVCcWNNSU1Xdm5QaWhnbHBmSXRn?=
 =?utf-8?B?RFlFcitYQTY3OHNNSmR4M1lVVWhvVE1RUTZ1aVVxMGIyc25jbVpsTXRmZFZQ?=
 =?utf-8?B?MWpBRWpiU0VGbkNmMjA1WEE3T2owZnBZQkphU3NPWW5EYjQ4WStFUEpTaE9r?=
 =?utf-8?B?RklYY2UrdFRrU0ZlYkhMMjFNaUliNHB0bjVYV2hiNTcwMmdiZ1ZwbTFOYlRu?=
 =?utf-8?B?d3FIZXdkbjlLNlg1c3Z6RWYwN1NiVUsvNDh2ZFBBaFVBSVIvQ0ZlekpVT082?=
 =?utf-8?B?OHJpQVlnSXZiait6dXhyRzdvdFdUY0taQktIWG1WTEh0UmdGYWlrbWNuMHR5?=
 =?utf-8?B?VEpsYlJWcjNZcWE1azR4VEtNQVBLMTliVG9ydVRzdk4wRVVkWVJhWmM3Mzh1?=
 =?utf-8?B?bzdPR0FiUVpCK216OWJtdTZRdFFzRzRiUDlxdElMbTFTOVUvMkZFV2hIUkFa?=
 =?utf-8?B?NUpLQjNrRVJ4S01ZRWJTNHlFWE5YUHEvaHU0a0ZSZTRmZWMzYXR0bzJuZHJm?=
 =?utf-8?B?d0hnZUFpQ2E2cnlTcDhLV2NnbkxDV2p4SGRjNDBpZlNxNVEzcWpPMkQwdnB2?=
 =?utf-8?B?NmhqQlJ3OEEreU1HMmplbzc2c1R2QTRibmNrUGJrOWMxMlR6blVud2VZQUd2?=
 =?utf-8?B?ZU5DSEpvUkZmSXQyWWVLbXd4KzVsY3ZyTlpLb1IwSDdoK0x0aGlGeXRQTnNZ?=
 =?utf-8?B?Q0lEaG1lQ3BPQWgzelNiQmlycGx6N041dlQrcVQ4S014bUN5cG1iY1U3amlI?=
 =?utf-8?Q?+hjQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697490ec-c8b2-4178-fab6-08dd73ab34d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:02:12.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjI1nPgwbDXHP2/CRycx1qFmwRg6uocSF6Oi1789kAdlynK13qnp4LkEKZgg+GD8TLjMcJuW8wL+bHyf3wdPJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

Set device ID as 'vfunc_no << 3 | func_no' and use
'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
device.

Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
functions use the EPC's device node, but they should use the EPF one.
For multiple function drivers, IOMMU/MSI should be different for each
function driver.

If multiple function devices share the same EPC device, there will be
no isolation between them. Setting the ID and 'of_node' prepares for
proper support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 4 ++++
 include/linux/pci-epf.h             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8dec..d04224b8e1631 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -120,12 +120,16 @@ int pci_epf_bind(struct pci_epf *epf)
 		epf_vf->sec_epc_func_no = epf->sec_epc_func_no;
 		epf_vf->epc = epf->epc;
 		epf_vf->sec_epc = epf->sec_epc;
+		epf_vf->dev.id = PCI_EPF_DEVID(epf->func_no, vfunc_no);
+		device_set_of_node_from_dev(&epf_vf->dev, epc->dev.parent);
 		ret = epf_vf->driver->ops->bind(epf_vf);
 		if (ret)
 			goto ret;
 		epf_vf->is_bound = true;
 	}
 
+	epf->dev.id = PCI_EPF_DEVID(epf->func_no, 0);
+	device_set_of_node_from_dev(&epf->dev, epc->dev.parent);
 	ret = epf->driver->ops->bind(epf);
 	if (ret)
 		goto ret;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 879d19cebd4fc..1040d83740f9a 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -213,6 +213,8 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 	return dev_get_drvdata(&epf->dev);
 }
 
+#define PCI_EPF_DEVID(func_no, vfunc_no) ((vfunc_no) << 3 | (func_no))
+
 struct pci_epf *pci_epf_create(const char *name);
 void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,

-- 
2.34.1


