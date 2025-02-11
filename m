Return-Path: <linux-kselftest+bounces-26420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F33A31522
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C20E18834DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14526217C;
	Tue, 11 Feb 2025 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QvpsvuUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8C2641FF;
	Tue, 11 Feb 2025 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301819; cv=fail; b=OwuhmlAkFxZluUc/4gYGoK/FZBgGj7Qo9zv2oa33mrFtoH6CH4oRIiAhnM4rjsXYYqVzhTIgSjBOp4OWt4T/86Gr179nnkGN5D1d1Yk1FtdT3FTdTx2R0fg7P7E2WjgzV+XFbJ/wSHPi2Gj/hzn3R9UW8txaCbyyN0ZSqbD6tRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301819; c=relaxed/simple;
	bh=dwA02TIh5o4yYij52lz6L+8x3KIMABUE/BqUfLVg4B4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=E9t+hA3mM3MA4tjmwh4/Sz1O1U12TGDKBJMjPgLWkYPsLCKqOXeGUyFUS3/aPiHRT7+1DqgeJOiTg8iuS9aYg/m+MZNuzdKXPwL3WJmkDizU3D4eMbXtXcltkV0iB08TKKyYtgKe4kVUc2MnfJGttsZrFpnDyxpqw6VsMiSaj/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QvpsvuUO; arc=fail smtp.client-ip=40.107.105.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvwfwd9Isf4nf3Whf+qqERz2JdmIF9QCn9azQGAFdxbfivdyc9jykQM/bPthntydYyWaXqAlRwFlWCZkmkpkwkPUc6ujtUaSsLJqd52igpXw7jDMDx3hjdeo03PBFV1AeM+UhByZIQAD8h2IXSlAhEBFTeRWJPw14Cr511GeEa+1MRO4WWAH640npM0m4egyv7cdfQ7ppI/jjQWgUqeAvV+rq1Qi3rQN47Nt9/W21Pd8/+q9efZkrmklGDYK/YzB8xW6q3N7q0flplzcz5NVIraBU1/sU4sd9K1h7avlypB8BWG6fqBoVpg7QXaKPktb4VjXoABGgzbUH4/3WUqy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q449xgBpoiwReMJbT90O0SoQaf3VqYQx5tR0JWQICBI=;
 b=ojfyNo5aDHsbfmJwqAF/J03WujacHEm6t+AD8hNoI8rph927y8MdowSCIgAIP9SGecIMka+fpd3wNKsULAr0EVQsCW0x4OiN264CqB80cdK4z0AOYrf0hb+zypjgwmw7NkVYMdZJkQF0owudTBCcXSmOpOfbtiez3ZrEGq0kTNAT1bt6UH4f91jIdX+W+Y5IpX9OYO235iy8ZmiS7GSA9d3aR6nKaxz8sFNyZcIz8Y+tRbgtQ2gdsitGjMWqXcQeE9py9OcQtlo7VhMKRtR3G+efNOrn4jKR5KhsOCGsZ00lHPka1FT+HQOMlwlXNeqIG7Zo+myiNt6eU9bgmS0NrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q449xgBpoiwReMJbT90O0SoQaf3VqYQx5tR0JWQICBI=;
 b=QvpsvuUOR/cqlLXdQSYkzbzuXTvNOdXDrXv6RR32rqqSXUDW1lEuAFN+IjMj8qI7GMYlUyszpiUJWSroHn7Oxr4TpczGS48u+s3yz3EV2hUjyVukiKkJnJ2MuhbuvMdkP6W0vwVIQ9OBUOnwcx0SLUi1V7ba+1GJPdh6zxrOKruS8IYzom2i3BP9tlb4DMxXaoMmLgm9kenmO82pZ2niAkAuPteH64FJ4DAM9fD/ECcKlNDYEgESGCrfQdNJc6mvuMdzLv7oldu3mYnKj+0jS2cdZJUGMrf8CFuw6fGlPZET/AwVLi2iE5SixEJDuyCDUY+2OgO2cXEv/6CLnEZmVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8553.eurprd04.prod.outlook.com (2603:10a6:20b:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 19:23:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:23:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:22:04 -0500
Subject: [PATCH v15 11/15] selftests: pci_endpoint: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-11-bcacc1f2b1a9@nxp.com>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
In-Reply-To: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=1168;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dwA02TIh5o4yYij52lz6L+8x3KIMABUE/BqUfLVg4B4=;
 b=KbpXM/stwLwBzsopNbtHzg6np9YGDszyZyffRiwIPkemDYrs27Ox+OB7Zl02HW2w2SzbLmUtb
 GwMWnJQ5R0PALDBazSA9C46whkABq2mGVTc6s7wlxIKQwLxl0wsacvj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 8222c9be-9618-44ed-902e-08dd4ad193f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3BZbEp6N3hhaW9sRW1VQUpCUUdGcGk0TVNKVjlSVFlqSW1xVnFTZGVkN2Za?=
 =?utf-8?B?QkRpdjlxL1V6TXg5YzVaWlpNOGZGSklreEN1U2NsS0ExdmFyVU4vOWdFcW1B?=
 =?utf-8?B?aEd1aEJXTFo4WHQ0bXQ1bVVRMXZtZXc1bUk5aCtSdDNBaXhHWXBUdDRSTVpw?=
 =?utf-8?B?TTNMeGVhNkhqaXpSN3JuNmg2cTM4NVl3YmtMWEduWlJ6WkNmRmxxMkNzK2cx?=
 =?utf-8?B?ekllVWFiMDZQQXJkbnp6TGpyRzRyRGcweW54TUM3bERQdUxZRk55T1dTbTNF?=
 =?utf-8?B?TnNqZFNKMDNuSDk0bFNtajFORHAzaFBCSjhwQTVlKzczZmQ5SkhZRVdDTW8w?=
 =?utf-8?B?d1ZoL3ErL2ZMajFGZ1FoVm9Gc2xxemNCN3FRVTJteXlyNU4yNmZWMStRNG1I?=
 =?utf-8?B?ZkVsb1N4aGNUSlZOTDRITCtIZzg2RnNpUGtqdWRPS0twYWxGQkoybGluZ1ox?=
 =?utf-8?B?WGpibEoyazFhaE1FNGtVMVlTK3Z0WGdWOUVhdUsxVk5udlFndUpMTUs0UndM?=
 =?utf-8?B?cy8waVhwKzhXYTRhd0dlaXRlblBYUzFiYit0cjZpd3JZUENqeUwzeGwxS2lu?=
 =?utf-8?B?QmZWTUt1NFpkU3JpVktRejVsVjYrMzVFTmZYSjJCRTJRZE4vamRobmZYRS9i?=
 =?utf-8?B?TXlMK1pGUEpXNmUyZFltVElqL3Ira3ZWS2dMdWJhTGg1RkNkQlRiVHRyK1R0?=
 =?utf-8?B?NWRmZ2R1dDRQRVNVY2swQ0YrcS9rM1VOdFRpNXFkcUtwdG5vUll3NGZuUUVO?=
 =?utf-8?B?ckx4STJXNFZpMUQvUlhUWnpCNFRXK3g1ZUJxcHZsSEk2NlVXNCtZZ1l6VUhj?=
 =?utf-8?B?WXAvRTNWNFpmVHIwMzFReVgyZnBWTHdhbFloQmNQV3NDbWxkbUIrTjJWeFpq?=
 =?utf-8?B?SnRFd2JkMXNmSC9XU1N2Z2NiMURSUldOWUtTYzhneE94c0dBUTFoUW5pbi84?=
 =?utf-8?B?SFpuTlZvWWY2d3JLbzdHQzZuVDU0SFRCNmtGRFlZSEZpRVY5UVJWKzdRR3By?=
 =?utf-8?B?NHVtS0dVZHNyZGZDQmNPbTFQalR5bWtHQ0RTV2Z3OGIzU1FJY2Z6S0tSZEZV?=
 =?utf-8?B?UlJaakxMSHUxbHBEUkVKOFRDeVNDaXR5ZnJKeFA2cm9hblFUTVlSeWs3ejlB?=
 =?utf-8?B?SGNSNEVzbGM0NWlEWUtVdmgvb29QR3BDYTQ4em9nZzJuM1RsOHMwUjlLOTdV?=
 =?utf-8?B?b0hTcHB5bWlFYlE0UU0zY3hzc0FhOXlhWXI3SDY1OElrc1BvRnRTR2sxNkww?=
 =?utf-8?B?UTV1WEpjallpdnlUU1dvdHYzZWxBUENFWTlPRjZWQjVwUmd0T3oyZWIzeWxu?=
 =?utf-8?B?bHVDZEJUV1c2NHZaeXN3cUk4MER4U0V5a0VnUWVlM095eVpWdm51YTV4Y2Zv?=
 =?utf-8?B?cC9rdVFiazN6RGsyZkhtdC9JdWRBa2VvQTRNemVZT0YrQ01vRkErakFLUzI1?=
 =?utf-8?B?bWJqakV3Q1grNngvNVYxM2tPMExCa0V5NlJYc0wrV1VrR2R6TGdhRThUUUVv?=
 =?utf-8?B?STZIVTFMY1I3MlpaMkM1RkgrVCtRenU3K002c2hraVhHeUtObXZNOXZqemRs?=
 =?utf-8?B?S2E3d2Q1UHUzWWdQTTFaWTdjemlablVCUXRDWTZwTVNHNmkrb3FRamtVbW9J?=
 =?utf-8?B?ZHFCVVlqckl3UnowWjdWbUhldG9vZzdNcmN1MVo4WlViczBNcmFoRDRnL1d3?=
 =?utf-8?B?MGtidkZwcXBwS3NuZHdGUWVKa2lCN1Z6QWt6WFVRY3pVcGtLbEJLWUVWVnUr?=
 =?utf-8?B?U3lsdXZ1TVFBMkJISWJXdVJ5bGF2MnV5dXVqT3ZUa0xGa1pJdnkrNFl5N3RR?=
 =?utf-8?B?azVvblpNWHlobzUrVVV4MVdGZDhEb0lpL3FSaUNPNlBFNDZodllWQ2hCMWNm?=
 =?utf-8?B?aWhTMlYxWlNIb3RVMytIZFNCYW4rYkIrMzJGelhYc3BwMm1vRW05U0JMZWlL?=
 =?utf-8?B?SndXeFd6eTZtSXFiOWFCQnpNL1lScFhiZUdxOVpVa0Q0bytFWFRFamxKU205?=
 =?utf-8?B?eENLSHNvZENRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHowTnBmM2RCOHZ6TUxsMlY5b0ZmVGt4RnBtdlNlalI1ajdNL3E2ejdIWVNV?=
 =?utf-8?B?QlJNQXdPeEwwaDFnL3ovRittK3FoTHRsQkIrWlV0Vk1NS0Rsakd4TXZNeWpa?=
 =?utf-8?B?czBTdkQyNDR3V09qQkpaOWJ0cmFhOWV6Q2ZqclBtejhKNjF5ZU9RRW51VVYz?=
 =?utf-8?B?U0VqWUFYWHo4NmR0bzBaYjd4cTgvVnNkYm9tNEdUc3BobWlMNVJST2lmZzRH?=
 =?utf-8?B?OGVSNHIwak95RW81R3MydlhMZG5vQks4QWpSSlMxa2NiT2oxNUhZSjV4c3V6?=
 =?utf-8?B?ZGI0UXFWSGl0R3g0djlEdFRqOEFuSHNWN2Q3emF2RVV4SG90SFE2OGpQaTBo?=
 =?utf-8?B?SXpHb0diamY0ZlNkREQvWmM2cm1ZU0pKaURGRmx3OGFNaVV4WjVNZHFCNVlR?=
 =?utf-8?B?VjlzUWcrUFRDUDVpeFNad3AzeGhsaldYQXBWbHp6dlhXS09BK0R0Y3JxenZx?=
 =?utf-8?B?VXZ3eElud2VPK0ZJMG5QWHlnNmppZ2RoU090L1RPd1lWMTZPQW1uaG1UYXBS?=
 =?utf-8?B?Lzl4bEFEbGxTL0V5Smx3OWxlSjFTNGROMHJhN2J5dnBmYWcxaE8xeUVuQWdz?=
 =?utf-8?B?SFNjK0t4Rm9vWnh0TlRZK3BJMlg4aHM2RzA3TDNqT0JTcVV4MkhFQ0xBVHBM?=
 =?utf-8?B?YVA3WERIUkd0VU45TXU3MHQ3c040YWhnYWNrZkRCdEEyRnM4SXRCUlFsY215?=
 =?utf-8?B?U0xHVWQxZmkyQnNaZWhKaStXbzlxaCtLa0FrcjdwNlNEdlAzOXlkTzlDUVAx?=
 =?utf-8?B?b2lON0p2NGZTcDQvVHdaQXhKSkdZWFJjUHNMclNGU1A4R1dyY3huckNDbSs2?=
 =?utf-8?B?ODdVaUQxSlpKdDZXdllHcnArZVBVdjlyOEJyc1hBb2JucEN6SEFmV0NVR05H?=
 =?utf-8?B?T3ZsRExPa0NWQmxDOWkwSStJOFRVSUl5NUY3cDVGbjc3bUtUSk5BTkRqK3Fr?=
 =?utf-8?B?NDYvL1E1N0lRYm9BNmVEclBMMUxJcEJ5aVFQNHFVbjQ4aXNlNzlrNHlUL2Rq?=
 =?utf-8?B?RFdSd3NNZDlnUTQzYk5qNzYrTXd6UVAza1c3ZVRMRHVIS3ZiU21BdHhPSDdx?=
 =?utf-8?B?QzQweGhNdy8zZTRFMG0waVh1RzNvQTFIOTIxekxiYmFDR3YzQnFWelFaWnJK?=
 =?utf-8?B?cVFxV25tZCtKNWZJeWZVRVBFRXZsNjJPdzk5Y0EyMnNlb0dpMzRhSnpDaVpI?=
 =?utf-8?B?VUIvVVZTWjYxT2ljUXd3cXplNG9NeGxRWWpYdktTcXo0ZVdQeFZvYmw2STQ1?=
 =?utf-8?B?Nzd4bW1CRG10RmNYaVRXaHRWSy9Nc3RrdEtTZEZUeTI5SmVtRFUwU3BOR1NR?=
 =?utf-8?B?LytLOCtPbHdIR2JVOGdLZndLd0VQZy8rS3VoVC9abFVwT0xGYnEvNS9PUEZ4?=
 =?utf-8?B?S2MrUEphaHRIcmhKQU9mY1NkSjhYL2JhWDlpMmEwM2pOUDNvcWtvTHBwQW5k?=
 =?utf-8?B?L3N4L2hnUTZyUHBuSkF3WHhmN2NFdUFwSGVLRHUxb2V0M0FEb2NNQlZLT245?=
 =?utf-8?B?SCtRWmc0b2FQRllXbUwxVHdTVm1ERXVOQzk0dWppWkRKbEJpTy9ySloyZ1ZH?=
 =?utf-8?B?Q25PWlY5VTFjbEhTYjFsYnFveFg1MjRZVWJBNmhQNU1XNjhzM3Vtb0FuaXFv?=
 =?utf-8?B?U0JlRnVYelMxWWFCa3p0QkJPNWkwWHE0MVRBLy9CSFhnTitLckRZR2RmY05Z?=
 =?utf-8?B?STZlT1BFbW9ISnEvZExHUTd6a3Q1OUpJWk1HdlkzaTkrUXROZVZaL3I1VUV1?=
 =?utf-8?B?d25MVHFyVVRDWTNhOWpxcWdrMXVHS0JHR216U0FmVWpXQStiVmdrdVd3c25x?=
 =?utf-8?B?QUVFd1dZRTRxUTdOdW90aDlEMnY2SW1MQkpkZUFkT2VlUUErNERVek9XNlV5?=
 =?utf-8?B?M29Fa2VkUDMwRXM3OU4yTXRaTlVWcE5jdkhqUkVXSmxDMWxBdHk1V25oUWl6?=
 =?utf-8?B?Y0FML3pCYTNiQllVVUVObXVuVHZjSnB5Y2pjWldYUjlyTDlyeUh4Y010Ujh4?=
 =?utf-8?B?QXhyWHRhSXRHVU1RVDZYL2dJVjRoODJFMzJhUmpObjdhMnlWK1ZVTVVoTUYv?=
 =?utf-8?B?WEVXeldDdjR6WmFSR0ZsNTA3Uno1NHlvcEh3eWFsaDIrVHFqQWJYRU1qWm1j?=
 =?utf-8?Q?eyP+v/xQiWPXJiHaFe68g0nfs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8222c9be-9618-44ed-902e-08dd4ad193f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:23:34.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQc0aHrvQwVFwGraL5GCYRDLNKMJtmTkG6w/5CQbr3RNbxjSaS/B9jSzRC+L5q8nR+AZedjyP7tbDvtX0vDp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8553

Add doorbell test case.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v15
- none

change from v13 to v14
- merge to selftests framework
---
 .../selftests/pci_endpoint/pci_endpoint_test.c     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index c267b822c1081..ed14c9fa073f9 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -218,4 +218,29 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 					 test_size[i]);
 	}
 }
+
+FIXTURE(pcie_ep_doorbell)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(pcie_ep_doorbell)
+{
+	self->fd = open(test_device, O_RDWR);
+
+	ASSERT_NE(-1, self->fd) TH_LOG("Can't open PCI Endpoint Test device");
+};
+
+FIXTURE_TEARDOWN(pcie_ep_doorbell)
+{
+	close(self->fd);
+};
+
+TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
+{
+	int ret;
+
+	pci_ep_ioctl(PCITEST_DOORBELL, 0);
+	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
+}
 TEST_HARNESS_MAIN

-- 
2.34.1


