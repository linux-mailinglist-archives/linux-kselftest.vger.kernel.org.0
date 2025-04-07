Return-Path: <linux-kselftest+bounces-30306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF6A7EE64
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C453F3A38CC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B55252903;
	Mon,  7 Apr 2025 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PQw/JY/O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C324EA98;
	Mon,  7 Apr 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055489; cv=fail; b=saarAe5/fZxBKiWD4/VYpaB9iFe8AoS4GWMH5IroXFCu/ld6ZiKyGlWQsJLl4zsAn0RUSaFr0PGpazCnfIxmS173qZx+nGwnTx1uS/NQq6WaNzgie24VS0VtuK65QRxvej4amRuyJJqirWrefVuIPb7jMNFk5EoYG2ifKEt3tNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055489; c=relaxed/simple;
	bh=p7gntWoxGh4gHuQtzBxv9euNYS3wHZIeRIkw2TEkLdk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G7sd+2JWU/sXiGQjZxRsGgNQrQmrXwN1O0t9/UR2SADS7TSh6Tr0SH1zmGNULjQcBhHJ2QypXuL2P3La+J/N/CsvKJKgXq0+vW5gEuCm6ibvKzMqy6W73KH8uy+znBYdef/HeWFR3i+xFpfhsig44gH7dH6QuLJahk9nGtSkOZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PQw/JY/O; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajtx3Hdx/wl6XYGT59QRTr+M7rtCjcjtqpDFOZm/7s8IDXSLMbmgPC2HUQttROQcv8jYrZQBlGTISZzuUOOZgl2UC3W49/tXsM3C8IxYv6K6JfLB424iVuccrYYdkyRRP6SogevUPfkQzrHEwsQX+KSjsvYCtuFafARSPpGafr6FgGkdv9XdoJXkerDUvCI/2TXUv3sUz7Vg/cD5/lC03s7awlFQ4gW7/+GrkfnoaWnM2Xek5UYI79T466x6Vxet6HnhzCBUfOpzGDngZl0ceNhAZ9eeAcpJ7SuKEewrrOdkspPACzvaSBkk2Cu5ypk6CEzjv1ddjBSo9j4uSWSZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR0Z1iTOQebA6NDkRDEaFkcBL+OLXn2bv7Llb/KWBuc=;
 b=sh2NjDUZMQInp+dUm+dciQfghigXdGOUmpcu+5au/ooerT2hx93Y6rSrMl0Syn5niFMVjFzm4qBLMBQ6o5VF9nj+r0jfaUPwjRF61CXbJudpWiFun8TRlQaSTOAtic2Iy9I9S7nOGUsFfegQ8aZ33yfBLcpkwPnHWZ+rjz2HnrcECeqglNnQH7OyP0w1tm0wgkdGX69BqghykyVbhwGj5qGgjMh3tE7tpFNBnJ5wvbHCZco7v9CskoF+DKAtvHWOrdpIkqAvlzNNqzN3yyvT6AJtMKzNX08WBn1Hz2UYz3ocsUE0Q5NMg3PrM77S/DIVZy6rBErF7ddhgwrxxO2CdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR0Z1iTOQebA6NDkRDEaFkcBL+OLXn2bv7Llb/KWBuc=;
 b=PQw/JY/OqY051e32NRI2x/SHQyIcopDr1B24qL8iyf8kI9GFx0fOu4PsO5Z7h0cJ5RMTAc2YUji8vZUdia50tqD2Rlk8QyaOt/jxcHlR/M3wGeEX3a15eH+wwxZW2oW53jyrzr/XGo9fpzQcBeKMOKBJ83kFJnbJJ/F6qnbK/d1HE3yxf9nm11FF+2ifEJNLIlEzdk+yAGN2jHE5xxeQfNhgiJyzyIw9owpJXjOwp9YPqYNpkc0dk+O8zHarZBYs1cAJBDp4mOv4DkgWJwKv0KTz5oi0xWVpUjIm3g7Bg6LKvfziqesbXeoREvqt1E00XESEpEWUj5sxRskmjNcaZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:51:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:51:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:50:52 -0400
Subject: [PATCH v17 02/15] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and
 irq_domain_is_msi_immutable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-2-633ab45a31d0@nxp.com>
References: <20250407-ep-msi-v17-0-633ab45a31d0@nxp.com>
In-Reply-To: <20250407-ep-msi-v17-0-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055467; l=1874;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p7gntWoxGh4gHuQtzBxv9euNYS3wHZIeRIkw2TEkLdk=;
 b=zG4QdGGdfqxDzshMU7Ve7oQJlFKli2a6ZVYWvGb/TGaz4n0XHmKNqynlcFyI+BEZ72WuuWoZT
 CDPTrvS18HQCCFgZIu/vituhjD+febT193Yu6L/YXCad3GJEQqEWjlZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AS4P189CA0041.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 3470ed2d-29ea-4c20-86b7-08dd760d9392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnZWUVVxMFA2cEZHT3MveHYzVEFEeWVYekM3T0xKY3I1UW9oVFFLK0hUd0hW?=
 =?utf-8?B?UlJCSW9nUWZXNFUrbXRTWENFMzAxdjU1TGlkQ1BjR3VRSVFnUERvemUvdkhp?=
 =?utf-8?B?WGV0cmpjQXRRNHVIMHdZTkswS0VyY2dyekE3d1M1Q3FOdVdVL3lsSnFCei84?=
 =?utf-8?B?a0FPbWJMTEVrWEYzY091VkRDNVVnNGxIUlpsYlEzNk0wcjNNQ1FNQjZJbGFU?=
 =?utf-8?B?bVJkc1hGa0xPODdmNGtBMGYzQ3FZTks4RDFCaHppNE5JOXBvV05sN3BwSU01?=
 =?utf-8?B?TUpJY3VqbnhleHRTRGNoOU1KdFR4dlZEYWZ3ZGNvNklkangyRFBJU2tLSzVZ?=
 =?utf-8?B?R1dnejZIQSthTnJNdDV0cDdRUmdmRklJUHBld0xRL1VhY01mNkpYck9nTi9F?=
 =?utf-8?B?eFdLSkxjVnR6aTFZK2plWXNDdm9RS2xFNTJQZ0RFemhrcWNPMDlYNzZONnFP?=
 =?utf-8?B?UnNJTjZZNys3SFRPTkdMRjJMSjNoZU1iZzVXWS9FeGY1cmtob2RpaE9Wak5x?=
 =?utf-8?B?TjN3bzJ5SFlsNnNUbWxJZzdUdE92VkxNYUx3ZWRsQThNdXk2MnFwdHowamR0?=
 =?utf-8?B?cjlSak1jSFBzRmtYSEtTQlJqUkVpU2svbEJYdEp5c1V0cHFMdlZNM3FGOGFJ?=
 =?utf-8?B?K2hiU2IxdXpvaUNuY1BEb244ZzJ3QnZhVkxVdmpLeERXM3FnSTc0cWtGS3du?=
 =?utf-8?B?RURSS0k1QWRNY2lpT0RKV1VBN2JXdkF6TE96ZVNueHdhajhDZDhTeWxKVmhK?=
 =?utf-8?B?M3lSWW0vRHRIVGRIaGFhS1BwYWVWcmpNT1hreFYvcnEwV2VyN0phSVNZU0l2?=
 =?utf-8?B?aXNCbWoxbWVOVXd0cmdvT0ZncGdmQmpnejhqd0tMY3Z5Z3NyK2tVbnZxRklU?=
 =?utf-8?B?Q2Z6NloxMGtFMUJ5U1NueXNRVGlkaE5rb1p3Z1h1ZzlnZTBmUXJlTVpBOFVD?=
 =?utf-8?B?T2k0ZXpLRHV4dVBOVkYzSnFrQlU2WnVnNUdRN2htc3hJMHA1WjY1ZGsvUmtU?=
 =?utf-8?B?QW5WbkpXNmkxWStyUFJxY3VvQ2UvVUZiM0hpb21pTXRnVk9LU2s1TWlWL0pj?=
 =?utf-8?B?azFtMEJGS2cyN0doL3Voa21tVXJCRkdZamVnelllSXYwNm5xM2ljZGVnUHA1?=
 =?utf-8?B?bHNDRFhzQVhvZzBrMmRuK1NxYVMyL1hRSEpCU1c2OGFXQXkxUlFKcE5sNUQr?=
 =?utf-8?B?ZnJZZ1JMeVNUdGprNUxLVjdGU1paUjFKL3ZIazN5WDhpN1lxVG9tNDZqL1BX?=
 =?utf-8?B?cXRCc3FNWXBrNHdDcTBwU3B3azVMUjFEeXVpYTNwY3J1aU1HYXJlcjh3Qmoy?=
 =?utf-8?B?MlhHVG9aWVNSR1FYR040a29Xb2lEUjJQUk95UEg4NDZHODZjZDZmeE5JNnpD?=
 =?utf-8?B?L0I0Q1lGMjE2aFkyc3JNbmdWS05kVDNieDNXSDlXRjZGTTVqNEdSbkJoSk5Y?=
 =?utf-8?B?TEVNTnoxdlFvYmZ3YXFZaGJsNVRLeVNtSldwRGQvZWdrWmdZL3hUUkhIRk13?=
 =?utf-8?B?MENBVldXb2dmbUUyR2N4d0xCaTRXbHZYUDkwU05XbS90eEQ0eXk5QWVaYzdh?=
 =?utf-8?B?SktmalFWVHZrcmsweDNjVkd3WWF5QlcyNHV3WHVKNHA3ZFk0eDJwSTZTMVJo?=
 =?utf-8?B?eHMwVFpNaDdNaG5PalNEZG85Z3ZYNC96eFdRaXBRS1Z5bElHcGFacVFYNERW?=
 =?utf-8?B?N2wxRUxXWUNTdnFsNmFpc0VUKzdKeGwydDVxMTI2RkRNU3NpNHN0aEkrVi90?=
 =?utf-8?B?MkQvK0VxR0krYjRrNUN3NGlkL3lVbDZRT1ZhNDJKM2h4Q2RHYyt3RDlVd3F4?=
 =?utf-8?B?R05DazZySkFoY1EzdWRIOHdzQS80Zk1NU2J6ZWF5K1p6Tk1kZW5UKzFhWkhn?=
 =?utf-8?B?OThTZ0lXQmFjendPQ056VkdQUTFmejd4QmZRd3NDZnpINHJOeE1kc1lsd2tU?=
 =?utf-8?B?Nkp3QkgwYmlDdnhXTmxod01FOGUrSTI4bDdldTFqUFNTaks1RVBBZ2E5Sm1n?=
 =?utf-8?B?R1VUejRENHh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VElvdmNZYU9zUGhXY3VFSnVmRWxwRDFtcXo4Q2VRNjBQRVh6c0tQejg2ZmZq?=
 =?utf-8?B?VE1GdzR6ajVhSDB5SVZvZzRaOUVuc0pzaE1NMlJicWs5RitTWjByWWVCN0tL?=
 =?utf-8?B?T0w2eTVTTlRwMmJTT0JjcXVrRzRsZkNEaVJ0SFdrWDlPRi9wcjFqMS9rckZw?=
 =?utf-8?B?c2NQREF2T0MrR0tMN1RHR1Vmd24zM2hpOExXZjJTdlNwdnhTdzZNdjNhb2R2?=
 =?utf-8?B?MDJhZ3FVaS9zSjNMOU5UeEY0cXpabzRkYzF4RlVYOURZQ200NnlFdGhiZEFr?=
 =?utf-8?B?TmgzN1JDL1dVdVg4WGc2aHNFSUk0M29sSERvd25ndGJYbk54TlQrMTFNa2Zm?=
 =?utf-8?B?clNjU3RNL0UxMmNoVjRXTEtOWFRtUjZYc1hVRzMzOHl5RFpneFdkTkpJcEVn?=
 =?utf-8?B?TW9BMm81ZEFRUzVCWkVkMllaRHpucDBEYmdLYkRtanIra0laWlo0eDZOZ2wr?=
 =?utf-8?B?QXUxMXcyazR5dVQyNEZ0UXFOZjhRT2lqeVpWeXh1V1BQUWFaUTF5ZFJERUxl?=
 =?utf-8?B?OHprVjVET3E3aW94cWVsbDhPQ21DK0NRNE1kMmZtM2lDSVV6bFNlY2llT3Y2?=
 =?utf-8?B?SmhwWlU0TWJoRXQ5c1hWeU1hOVAzaUxsYU1kVmtaSHhMZzlMK3lhTW9FQzVT?=
 =?utf-8?B?cUx5QzR6TUUxVGxDa24wTHYydDlPNzBHdU5YYWZmNUJZdlkvTS9wbDVKWmxj?=
 =?utf-8?B?a0o3WlQ0ZEZwTDBEa0Z4cXI3K3h1S0RQcExZQjBDV1JyS1BrSnZNMHUxZU1R?=
 =?utf-8?B?RmZKNjBXckRqL0NjVGtHMUtxN3k0TkovQlMwVGFlL0NCZm9OSDJCb28yUTlP?=
 =?utf-8?B?eFMwWjVhcUhUQTBJUW9yTW1IcUh0Sjd2Zi9KQTJmT2RFLzdyY3lKZzluK2gr?=
 =?utf-8?B?QUVyYU5vTHdXVUozM21US1ptc2JoclYvTmpzaEJnam1zSkFlY3oyazhNUXBa?=
 =?utf-8?B?UnVZZkQ4TllacWJwLzMwK1JTdGx3aE4vQTFNcDJmb0NaK0lZTVVTTTlQSjUw?=
 =?utf-8?B?cUtMTVplWm9GbDNGdG1wTUFuY1RXNFV4dXY4RGFCYU02WDIrTmMrcWY5dzUz?=
 =?utf-8?B?M3lQOHR3a3FldFFXZ1Q4bE1SSlRtL0JpQjQ0bWhFS2diazNxV0ZUdHBGSVNC?=
 =?utf-8?B?WlV0QVhLbk5LcE1RbzEzZmN6TnRmSXB0N0xSaE1NTEhqWDZva3laandTWURr?=
 =?utf-8?B?eURyYWFZUnd6VWZXTjR3TkN1N240eGx5U0d2OE5DdU85NHpGczgzNkF1eUV6?=
 =?utf-8?B?Z2ZFNkNodjNaMDFkWjd4YkMxU1VlOWRMS2xsd21CK3lDSHlkdlh5dnRWR0RY?=
 =?utf-8?B?UzdoTUpFZXBqWmM2citFT0JUVGtFSjA1ckxEMU5FVTFCZVg5OFgxMUxIekFw?=
 =?utf-8?B?a0pZRFdEOVJnd1duOVVVYmsxOEg5M2lIUGtiWWd4NUtPcmRzRWpJdEUvS2ZY?=
 =?utf-8?B?QjBsaFJxQXppWDlzYmZMZEhTNG0wMFA2YlpwK1gxTnhRYXllMWNJMFJYU29t?=
 =?utf-8?B?U1ZLYnQxRWxkSEVrL0Z0RHVmRmEzUWo3am1qWHFzNU5rR3hSeFJsWklYUjRz?=
 =?utf-8?B?VGRzTFEzdXRkYVRjR3grd0JyREsxaEU3d2RpNHJxYmNzdUUzT0hxK2FYV3Rs?=
 =?utf-8?B?N1ltai9EVFJjOHRUVWhuZFQvVUJzTjJXWTdSeFJkcVhEVG50K1F5cEUzTEg4?=
 =?utf-8?B?cU9qTU1iZ2pYYzVVWmMrbmRaNXNQdzdGbi9NdUo4azVHVDQ3ZC9KT08zNldl?=
 =?utf-8?B?c1IvcHVnd2xZT2hiRGdnY1RUWDJ5R1BVbWVCRzFmdjlCbGZHM0szZ21kVWl5?=
 =?utf-8?B?MnhSaTEreVdnQ3k3TmhaeHFRMjdlMU1TanJYTUh5dU1IV0swQmtBcGxSaTYr?=
 =?utf-8?B?eW5rTXFWMFk5NXJhSElCdU1wMVFDNWtoTUxjRXFQbC94TDNEQmM5MXU3c3Ro?=
 =?utf-8?B?TENmQ2V1Y044NlE3dHZXcGlLTWY3NVBsbkRnNk1xOWFaekFQdU93L210UjZS?=
 =?utf-8?B?dGpTTEJzeDJJbG55c1M1NDlxVXFMUXVCMjExRjlBa21IRUM4T3h3R0treG53?=
 =?utf-8?B?NnV4SEJQcDhndVJwWjZuVWVMVkdCcWs2ZVNHdTgyTDcyd3YrTUZRSkF1TjJI?=
 =?utf-8?Q?4ALv2dBnZQVkhDDqFY8FrtRqD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3470ed2d-29ea-4c20-86b7-08dd760d9392
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:51:24.0193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: om0VB3FGAcAxZ/EaaRFlb0Z5JKtG35bdnz47GG/8uDCfHUTmURSDwUhdxMvMv7Y9d8fiKzJ+p/NRCxSjFFdjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

Add the flag IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and the API function
irq_domain_is_msi_immutable() to check if the MSI controller retains an
immutable address/data pair during irq_set_affinity().

Ensure compatibility with MSI users like PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged after setup. Use this
function to verify if the MSI controller is immutable.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- Roll back to v12 version because Marc Zyngier have concern about add
DOMAIN_BUS_DEVICE_PCI_EP_MSI.
https://lore.kernel.org/imx/861pxfq315.wl-maz@kernel.org/

Change from v11 to v12
- change to IRQ_DOMAIN_FLAG_MSI_IMMUTABLE to minimized the code change.
---
 include/linux/irqdomain.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 33ff41eef8f73..86222602744e9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -231,6 +231,9 @@ enum {
 	/* Irq domain must destroy generic chips when removed */
 	IRQ_DOMAIN_FLAG_DESTROY_GC	= (1 << 10),
 
+	/* Address and data pair is mutable when irq_set_affinity() */
+	IRQ_DOMAIN_FLAG_MSI_IMMUTABLE	= (1 << 11),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -691,6 +694,10 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
 }
 
+static inline bool irq_domain_is_msi_immutable(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
+}
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)

-- 
2.34.1


