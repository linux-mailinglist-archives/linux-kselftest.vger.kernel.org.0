Return-Path: <linux-kselftest+bounces-30136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B87A7C38E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCAC3BD242
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFE221D86;
	Fri,  4 Apr 2025 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aKtepLbT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1C221D9A;
	Fri,  4 Apr 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793349; cv=fail; b=KiZtN0MlV8PBcrJ6JXQ5JXygh/B0R4axefZVhUWT8C1sTta7gKfezctcHif6y/WLkHkqXT9lRgwTcogBsF0To7YMr01i4XjRlG/kQVAfVXk7n5oG+2zlDpqd8R4X5oaRahGxUs4qey/H2IVw1ANDZk1fxLXazzmbbcoBbtrtQkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793349; c=relaxed/simple;
	bh=N/Rcdz4WASrCVzB40i3dK6NDhujmvhnmUfU9wknM7Kw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hGVWsqrdW/0R/SGtQBx51fRMXAozTbEyv/R5ihWqbKApx7T4fqPLdlsIcD2nTIXnhsDTDpSfK1GHENnGx19vAVAUz8LGYyQQNAmW4LpSPX9AjaHR9+O+WLdPSUyRCy4ENdVxNy5Wghl7jxDvOUb1dhzzw/effLmBWrZZ82LVHm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aKtepLbT; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD81Vc6vngu33xjhk9+i5u2QC4o9WBydXamZecb8J51KCwnSsCiuceOMX1W4F70xfgscSl6MTxrPDvyAIWRWx6IrHyKW0VLzs3TQrK7Lu8OZM3rZw6ttQxljuc5rGi3zIV62F3oDrJyn82tZCmZtUILXWDrFrjeQ4Ef4e82HM5m2MFhM/DOE/oAGBJi7KpIfp95pk81IXXu58yE/+1KxeHDrtWk0nzYChmCvnypqOq670M4Cy/Vv13EX1CpurGDGiTxm0gZI0oAcq4p7+CjBTPqjub7p16SQRwdjFRd2rI1YszQTMiRDGptf8muo4ov0ARCJjBiyVrDUozCT6303TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IZAfUVaAOa7chBgO8REmAJsb14Zp8lXTUd7dS+omz0=;
 b=YDNrprgKn6PiTIeCvf6BfNB/H9OKFHT2UZuGmbrbUrgPlaUOy8sNGpVisYts78OvJ8L4H3nJq0k/R7V5t6RvNpmWNMSfOdYIMYL/VcQYpimYm+MRA+G8DD3VcUkMg4tw5YPcJRGTedpU6dItj1iWS6nO+Be4VmGCpIFE3ABlJf38F9NJmlP00Qn00i9SgJmwYpl8cLG323Rw26kpsdYSoyaBZhuG33tZ62zG8ouG3UITJzIFjpOC5Dlpd2fwrF6aiOEcWLqRuHiKHlZhHzSkBD1q2jPkure+dmOKibnmZdu43VeX9/3O9s+PPQdOYF/4wBdple5tpVQjbDp2GYNmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IZAfUVaAOa7chBgO8REmAJsb14Zp8lXTUd7dS+omz0=;
 b=aKtepLbTZFHKqgR5Eb9nrXKXwTGsCw6NFRmfyH2/grD8mixgfCN4k9Jvva3M6NYoMyrWprqcw5/tIyvXnyaUajOjCT3D0wxLujLx6Gx1CEfpFb2hMrnJPdUVIQu+6jre2Uj0pUT7QXBW7wZqe+eflyupC1BJL1FhfsF/Gh7mEc+cpy1JGQBG+BbuC7w9d90S/Hd9FJaT0EZilb/ir1OXTjJ1XGeQHoLxG6+izTcCkkrWfQCCD+QUk4jTNePWiVrKxuI2aGeCwYLjByIivbpq6tQzKicm2EoAHMSctucvB/Mklo+5N3+bKEytHY99YGxV/HAoTXjED0ZzwUz92WhhhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:02:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:02:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:09 -0400
Subject: [PATCH v16 08/15] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-8-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=1143;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N/Rcdz4WASrCVzB40i3dK6NDhujmvhnmUfU9wknM7Kw=;
 b=l7PF6H3Th9cGiq46HdUyeFG6OzFlTPz3QQTzNdCgKmZ7lLApCVYxKmrQyEDodWNDeI2ojOMQF
 UVIjZJ8SiSrC1It+ZwS+wRK/6+jcwVVp+Trzx/ajyIP2P4ROo8QFWKX
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
X-MS-Office365-Filtering-Correlation-Id: 1b3fe2f6-3a69-4c1b-6912-08dd73ab3c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDQ4dU1aZDlDY0VUWGs3WFZ1MXdYOTFDMVRxSlZ6NWVlS2FnaFdTS3FlSWlj?=
 =?utf-8?B?cHlGQUxWcmo4QS9Kaml5VmdpUk5PaE1aM1FuQUxFeHUrT0c5ajNicGhYVm5u?=
 =?utf-8?B?MUFjdHYzWDl1U1pXUzViUmZVVjRvR2c4aGh2SDI5STdrbVZrellwVFNES2Zi?=
 =?utf-8?B?bEs0M1dhOEZsdVlqODd2dHJzZWR4WUxhaklUREpXdVJmbWFRdHVrSTlDMGtj?=
 =?utf-8?B?ZmxYNFozekdweFRxaE9XUllBakxkcklTU2g5V0tmbHRJT0xNUjhCYmF2emZi?=
 =?utf-8?B?QzVIcWlpc2t0VG5YVVo4bjRqOElJM0pBbnNvQ0Q5cFBCQmN1N0U3dUxXamJn?=
 =?utf-8?B?VGNadVVuMGdNMHFPeHF3UElEUUFlSm81RGhXa1dad0Fhd0tVU2gxV0NzN1dJ?=
 =?utf-8?B?U0phNUFvWWpJZjBlenRMOHJjMzV0WjArNlA1eVZDQU11SjhoUGdmQmJ2OUxs?=
 =?utf-8?B?ZkVZZ0ZNc0ZQQTBsWExuWWZUdEZ4dXNYQkRQYXZ0YXFBL3l2NTR0S2NzaTIv?=
 =?utf-8?B?NTRpMUEzdDhxNzFHRDNWWUdWTDBxZllROUVxOFZmenA5Zyt5bDJMN1pHZytz?=
 =?utf-8?B?RnB1dEk1UU1oVFFueXBoa3Bxd0d3U3BSWTYwM1l5K1c2ZUV5RlpFWjRPZmtN?=
 =?utf-8?B?dHBKN213UXZhcG1sbC8rTWVkbDlpQ3FwNFptN3ROS3JNWEhvMGFXOG5VbU9t?=
 =?utf-8?B?enVqWlJ4ckZhUCtKRUMzU3RqZ1VrcE9aYnhleCtreXlDTlViM1NDcjZmblFH?=
 =?utf-8?B?SWV3Q214eitDdFlBWUx4amhvdmZMdk1RK2g3WTcxcTd6VnBtT0FWbGV4UFdj?=
 =?utf-8?B?SUhWZ0hvdTRHQ24rVzVOVVJ0VVFwZnVvdHRmOXVRcmZxQ05uM3RhZVozQ3Br?=
 =?utf-8?B?QmpyZE13cGxuSGtiWmJuQ0VUeFBVYkF5bUFRREtqNW95MTZDUEFaTm9uR0pp?=
 =?utf-8?B?MHQ1aDdEZWhIRS96U2Z5MkRGclh4b040VUFGNjZRSmNrRERRZ2JOZXpwMDdQ?=
 =?utf-8?B?V3g4d25nOFBjQythSzBJTUJTc2kvb3pmNnB6MGFRbHQ5TUhqQytvV1N4RWFs?=
 =?utf-8?B?UTdhY21ybnU0RFJJcXk4dEpRY09TQXFpOXhWSmRkcFJqaHJQaGp1bE1WUHFE?=
 =?utf-8?B?VGw5a0xET2VIaGQ4Z0FxRzNMYnRMTGJUSkg1YTZjU0NtQUxsRTlvaHZEd1Bs?=
 =?utf-8?B?YTUvcWE3WkNkS2docG1ucmhtVVQ4U2FMdFo3c3JOcnhiNS9RN0VLM21nMlRi?=
 =?utf-8?B?Tm54dTc3bkN1cDB1TFZiaEJGLzVPNlROc0xEekNyalhHd1NhZVk0MEZGeHBZ?=
 =?utf-8?B?SjRjQVI3L1U4aGs1MHZ6WjFxcnE4Yk1MRzRqUUdCUCtTQ3A5VElOZUFraXlJ?=
 =?utf-8?B?R3l3L0k5TTVsUFoyTWZac1BmOVNOYk90c3hyTERRUXZsSk5MVXpqNkxJa3c0?=
 =?utf-8?B?OElheG5oM2hkcG1xcHRmUnZ5VVBlTE5rQTZzZTN3b3dCRDlNb2pFT01PNW94?=
 =?utf-8?B?cmd3NFhTQzM2cTVvemJCdHZHR1Erd2xtUGhEWFY3WjFQdDBCT2NxZFFndDVF?=
 =?utf-8?B?cGExMkYzV0l5OVpxVnpYV3JGcTNDUnJ6b04zckRmUUNvWmE1dWozU3NKT0N5?=
 =?utf-8?B?NGQ3NEI3RHBDVjFPQUVwbzNRSGNJN1k0bWMydmhsZDRHQTI0d1VQcEdHWEdz?=
 =?utf-8?B?bk85alNEanpWWENGSEFxTDFqS3U0dTd2elJHa1JuSElSajdQencvZS9YOEYx?=
 =?utf-8?B?ckVhVmNzSzZXN3QyZ2VIZkc0WmZxVEEvSjF0akNaWFpmNSs0U2M5QjQ2dTkv?=
 =?utf-8?B?Mm1pTHpxc2FrekdIT1R6V0ozUDVvenlQeXlOdVBoSHlpS3NxcXJOZlBFTlh4?=
 =?utf-8?B?dUxzbStNejA3RzZERnNhMFBrN2YrL1diKzN0dlVKMGlqYk1JVEtFYXZia3Zi?=
 =?utf-8?B?WnFNMWJWdkJqODljQ0VXR1VWN0FaMU1JdjcySXZNVERHRVZiRlAvditVR0Jt?=
 =?utf-8?B?WnREZzBrNG1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZ0cm5CTkRRTjNQV0JyN2tKd1VBdC9KaWdUR2lLQTRTUWNLMVZVemJtb2xN?=
 =?utf-8?B?Vk1uOStkNHMvZzM3MlZnbXFMR213YzJwZ3ZZQkxBcjVuNEhZTWlNNk52czJ0?=
 =?utf-8?B?bkNVSGtWeEc0bmR3S2dYSy83c1hzUHgzNnc4UmQrK05yZVdwejlmdlYxRm91?=
 =?utf-8?B?SitlVS9KcDUyck5udU5FdnhsMTNYemZIK3lPakJGQzZiQWwyWGQwbUxhbW9O?=
 =?utf-8?B?VUhBRGF2cGE1c2dYTmV1eHdJSU4yOXlLdlRSeEh2b3BHSWlXV1pYV1c2OERB?=
 =?utf-8?B?bTNBTzVjbUpYZE0vTU1GUnlCMWhWR1lKbUxrV0FNS09XdUhISGhhR2dEa3FO?=
 =?utf-8?B?NEpVTkd5ZlYrWGIrbkxGKzRGenI1QUYrN1FOaHp4Vzd0Tm5Nby9VOElOQlZ2?=
 =?utf-8?B?L3NrTEdMQUZpeXBVOUh4eXg1SG9FUzJLNlVjZzBlNGlkSTVYVEdiem9nV2Y1?=
 =?utf-8?B?K2FVWGorbnRHNkdiRzRlY3YwYkNxMUw2V21KMUFBRlpYRU1JNityYWV5SGVZ?=
 =?utf-8?B?Um1HTGVCOWpoWHlaV3UrVzQwWURCd1QySjNBK3piT1JzTVNhWldrdGhkV1A4?=
 =?utf-8?B?aFNwc0VrVDU5V005OFYxSFQ4cFRHVlV4WGpLNEdnQUR6cXFpOS83azVYYmlD?=
 =?utf-8?B?THVhb2Y0Vzk0a1pyLzJtWDdQclJHNTNTaDgzbHcwcEl2WEpSZGVxU3JmeFdl?=
 =?utf-8?B?MEpnVUZzSm9BWXJyTWcvSGFhWkhQMzlkZFgwWjdQTGw0cHRHN2ZpZkVMb2dI?=
 =?utf-8?B?K1JPbW5XaDFhalhKQk0wZnBNdVJVeWxhanBnK1NHL3h1TktoRDhiV3dqMElY?=
 =?utf-8?B?SkRsZmlQOTlaQ2l5cHVnSENncEszKzdzOU1iYlBPM2JiZ3YzTnhpQTJoQWd1?=
 =?utf-8?B?YkhpdVZ4bkVudnorZ204OWR5UXpzc3pqQWg3WHVoZ0Vkb09EQU1NSWxwdm9V?=
 =?utf-8?B?eTlxQkp3TG9tVThEK0psVW95b20zVURFS29KOXRvQXNZOEUrZWVCZDFGZjVk?=
 =?utf-8?B?RmpjZ29yVFZweko4b2wva0FLK3Zwdmd5UnFHUHhKUG9BRHpPaWcrY2Q1Ly9o?=
 =?utf-8?B?ejZvM005VWRjaEtUaE13ckZFMUkxYnNtZUhBUjdHNVROQWZVNFUyc0thYUll?=
 =?utf-8?B?MFlxd01NbEQ1THRWbks1ZkxZQjFrcjN2WGtJcFQrYlFxYkpvclJYbytya3gv?=
 =?utf-8?B?NGh3MkZjbk5hd2xDZVl5aEhkbnVRVmFHczAwZlFOa0Q3SUhvOE80UVlDWGFW?=
 =?utf-8?B?aVpTcjF5cEdadmNTcE5QeU1hVFlqRExBeFNrNW1yQWRVS0VpcmlTVHJoK0gr?=
 =?utf-8?B?eWtBeTBYVGVyTFBtRkZ3MHFvOGtDZHlxSzVQMEV5S2xSVEl3OXNWZkJKWW5p?=
 =?utf-8?B?ZzhDWTQ4cER3OEQ3d290b0Qzbi94d1Z5dXB6WHM1UHQzbTVWOU1QTXgzY04y?=
 =?utf-8?B?MHJIWUdNeHBRdE8yYUV5QVZEQ1h4d3dEMEZoSnhSSkNPOE5SVXZ2TXhCbm5U?=
 =?utf-8?B?ZDhkeWJPYWdsS09HL1dsZEs3cHRISHc0aXh1V2dXQ25qSXRNZzBWTmN4VGZE?=
 =?utf-8?B?U3A4ZnJTTXp5WjNsYVp6QVpCN3pSUG9GWkdpNHl5QUp0R3JUNHM0cUthSDNV?=
 =?utf-8?B?ZWpJczZPd1dGZnFUTXN3bUhxQlpsbWZLMHpqWlhGdzFBZFpEYStzYmc1UnV3?=
 =?utf-8?B?L000dnNPSElxVHZWNGlZcmxRczFzS1k4MjJwTEdSb09OR3Q0cG96S3VwSFNH?=
 =?utf-8?B?bk84WFkwcnpNc1cwcVBJcFNnQWI1TDJqMDJ0a2ZZeERVU2M3S3Y3eDNvb0Ri?=
 =?utf-8?B?UFdYZU9ZdFNrV1NnV2ZoaFNHMWZvNUs1MzQ3Q2d3dHFFL3RvVEo0T2U0ODk0?=
 =?utf-8?B?bWlBa3ByNnFsd0hNNFZCKzNTUUphYkR6ZUkvSjllelFLaDB4WllCSUJ2WkZN?=
 =?utf-8?B?dVo0NmpSbmtTS2lFbGhmR252WFNUeU41Y2tSQXJHTTV3cTZEblpham5BbXc5?=
 =?utf-8?B?R293UkdmY2RyOXpXT2JCSFJGNHNpR3ZjM3dGa00vVmkyay9Rc040UG5wSmZY?=
 =?utf-8?B?dHlTRElFRDQrTU1sazRIcGVaVVAyM1R4YkNDLzlQeTYzUElTWC9UM0FWRkZT?=
 =?utf-8?Q?+DvA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3fe2f6-3a69-4c1b-6912-08dd73ab3c29
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:02:24.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zmdsmnf/o4Kx3RWpJQD7urwuVQiX2AaiQPeps+IcOFb6iMWQDZqL32/NHBOdlB0I6YjUKdrA1KAbsbEcWNwbKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

Some MSI controller change address/data pair when irq_set_affinity().
Current PCI endpoint can't support this type MSI controller. So add flag
MSI_FLAG_MUTABLE in include/linux/msi.h and check it when allocate
doorbell.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from  v13 to v14
- bring v10 back

Change from v9 to v10
- new patch
---
 drivers/pci/endpoint/pci-ep-msi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 549b55b864d0e..c0e2d806ee658 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -44,6 +44,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 
 	dev_set_msi_domain(dev, dom);
 
+	if (!irq_domain_is_msi_parent(dom))
+		return -EINVAL;
+
+	if (!irq_domain_is_msi_immutable(dom)) {
+		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
+		return -EINVAL;
+	}
+
 	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;

-- 
2.34.1


