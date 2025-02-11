Return-Path: <linux-kselftest+bounces-26417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7EA31514
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D756188254C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316326388C;
	Tue, 11 Feb 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MZtwmwd/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E51DDC14;
	Tue, 11 Feb 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301796; cv=fail; b=t9zl6+HeKg1TjqW8gMcyaQ6JTdISSOyNS0rTA1A06urWtt32GfnqjzcQH2In11e9BjkYULDr85oPT5hGcN5/eU8QqNyNUcy41suDJZhRMThZIZYEElWWoSdL0xRvVcEhlR/N+91s/WXmgDEJ19hWFC1B3KRtBR7UUdNA6sAJa+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301796; c=relaxed/simple;
	bh=LQZt6j6fL/xsVdnnuehlbkvt1tbnzwcl6b8tL0dpbNI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tpoJan0eMLBBJ1CP4CjFaxOJcR/4RP9d4WLs9QoMwlBDddFuRqtuaqG2IwSUV4WoJ2bF/pESstYyMHB7BCGtMl6vvBJnv+mx/3Y7yRR3T1xR7iGLxyJWvRQMeCr7ygVwYPJTRqOZLCRQlp0SSW7cMDux9pMw1ElcThsC80+sgIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MZtwmwd/; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLKWK2649rQApiwcfU7hLYa/ngKr8JFK6ER+V5DmXq1kGdtkwhnsarUjMqswn8KxhHyBc6wb1JgY6DTCf8k5P/J/bZMahqt9BvE4AmWU083GQ9ZkF/4VfKkeah+efP8nHo7wE64BmVsRuqSBuP26H+0iEDcGKnsmZOZFE/gSkdfDk5lnKo4U34H7/PfNKp8z7VHfL8iGnDqzBkkEzhha4XHvPm+5Z1qSGPKOMB4iDwg1xwtiYfAa7BFURBeQqtKCjoBLNK9+yA3oUELwLDWh5FdmR6Do4YWxvqAKe4hxUuQNjp58+GxPGcSlLT28nb9Jo4yJ9Oz8Bf1X0R03z1IPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1HdnhQnV1oQ2GDQovC7o9TtckUnVNvZLq4tO+pJCYY=;
 b=djhIR24oEOJvS3LoGeSaStkVTrOi2rfSksaC85SonuVp63ti5ghDCzf5DI8D0JOt1u3JFLjvy0vp8SAj2c4KlhNzMk1pbbVrTwPXXWHrAd1h9507YJOaRlhyynzwUVCxXMQCfXnKBAAfCSZkgRjNHdGlrHWmG1zFLoOUxusjY2vS2YFQEeAdYWN3+rqAkr+8ZnIA14VWAZOSZvz/D4ibLcbPhzIocQPKAKIwb1f3Og6VqPXV7e2OhjCLoz0hT3+LXe+E82HrzbGC5nt/PLSie+/xvOrFEzwoKKnUCY5BsUqMh1JU2QqjSKkQmUn8db3xKBYU41pYaMKDbkw3JKEmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1HdnhQnV1oQ2GDQovC7o9TtckUnVNvZLq4tO+pJCYY=;
 b=MZtwmwd/Cc821Sujgfvaxw0fP+Z9UX0tJyAK2olvQQVLLCcQQoTRWCdryfXVYSKBCI6oKpkyJk5JAr68Qk4YZ0tECy93bk8GGFoUM2ECXePDSrEAj3SQQQ/Q8m5p2dUaKdLzqbcTwn5iONNUR0PmHWbzY+ITV2pDOMwHy8tqW/eWhSX1NXrtIERFOPTpmXIpZ6KZ1HSbQNj9YihZF8efsdbL+CIcOrH7HGOVhIeV6rHKsuBPrnzJNztq6txy1u0ZsA5/ucFCMD9IuE7CceTAhF0ZVWpHbSnv4ZaVSChuFXcnhJCoRSCcMhiHWnA903VXo5ryu/2IDob2WoxrJS+2xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:23:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:23:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:22:01 -0500
Subject: [PATCH v15 08/15] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-8-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=4330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LQZt6j6fL/xsVdnnuehlbkvt1tbnzwcl6b8tL0dpbNI=;
 b=kKz0B5hQ9cPhdDQ8e3SwvyrKj3LKczhB/dPl9cwOrTxnxonfah6rHnV5me8NYO7xhU8kVCX8D
 TGSuzOkGOcWAvZQhANtXB/BdcxAhrSQwEs+0VvXBBeBtesgF6UR8jIS
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10291:EE_
X-MS-Office365-Filtering-Correlation-Id: e280fc38-1e3c-4bad-9f5f-08dd4ad1864a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d011MjMxY2NBeFlJRFlBcWtoQUlRWEdJWm15Z2Q3YVc0aGdDWFhScHJOVUtG?=
 =?utf-8?B?V21LYTF6b3JZSEdRUkd1QmxDcFBHVTNrZkZ1MXloUm5ZZjd4UFMvM0twaTVX?=
 =?utf-8?B?bGN5Z3pNb3lZMXI5dGZkcVBZQWVLNEhKdG1PeGREVnl2SmlrUmFWWW1jS1RQ?=
 =?utf-8?B?U21la0xkZXdwdVNKd0o5NnNZcU1ic1E3UWlCaHhSa0NGQUp0WHlzckxXR0lJ?=
 =?utf-8?B?NVh0NmJ6eDhwSmZ2emdDYThkTEozUTNrUHlkNDRKaHcwZmZLcy9zMy85cXhB?=
 =?utf-8?B?Zi92eVQwOXIxZ1NnU1ZPNWRJdnJpNklLWlNXYjY3TEtKMERtcTkxQzkzY294?=
 =?utf-8?B?eFZRWi9aWlVPRUFVWElRQ1FZNXFhVS9UUEVZTGtGY0ZLZUNHOHA1S0tNU1pC?=
 =?utf-8?B?QTNOWWlpa2RVV0tuQlR2aFpPK2RWQVdFa3ZuZncveHNpTEJWNGI1Z2t0OS95?=
 =?utf-8?B?Qk92QW0zSnl6NXBpSUpqaUorWTFqWUZKMm1JamdhOWtyMmJic3BnSGljdGRh?=
 =?utf-8?B?b2lGb0ppWEo1VkFRclRIaEpNZzU3YzhWTmkvV0VWcGpYOGNCcWlYTEZ0b1R5?=
 =?utf-8?B?K1R0N2RkVXlmVlZlNyt2ak1pM2NEdkpHNlQyQk1oYzlDanhFYzY4ZWJOcnda?=
 =?utf-8?B?NEYzNnlYR08vWFNxT21XSTlOQmowOTZBVThoY2kvemlzTjM4KzdVRGttdjM0?=
 =?utf-8?B?YTA5SmtJRzA5VW9qekR0WnR2cXRnc25kUVFLRExuRnVicmI0MG1KdlVjVUdB?=
 =?utf-8?B?eTVRdUdQa0FsTk1YdXVIb0ZrRmJpaThPbVNVS3dNTk1XRnliY3FEbHJvRzBH?=
 =?utf-8?B?QlNHTTB4Tm9OL3AwSm9hR24wbzZNai9OTTVzbElTSVVnajc1RnFlcFFSdDdy?=
 =?utf-8?B?eHBGS1NYT3JGSnVXeWxBajU1VmZ0T3M1czNwS2VxeWFSNmJIV0dzUDdkbGQ0?=
 =?utf-8?B?UWhibEZwVU1pOXRnL3ZLUkQrVFFNU3RKZ0l0eTFIZk1uZWJxcnNKRXJackcr?=
 =?utf-8?B?YTFMbEFpVjRVQWxsVXVWSGN3ZUJPblplK0ppL2VZZSsybUVEQUJYRCtkeVZN?=
 =?utf-8?B?VmdWb1NVZlF1bDUrNDZkSVNrVVJKQkk3UXJNY1Z3S1U2TS94enViU0hhcWRH?=
 =?utf-8?B?RkZqcVFpNW8xYVRYUGRJK3FkOUhoamM2TUN6T0M2VGNLdU9pWEtaanlhZ0kv?=
 =?utf-8?B?alF1dzNhZm90OEVLNEVQaUF1bzNHZVBCMVpheFNvT2VkSmtSV2tmVmZWaG1Q?=
 =?utf-8?B?c1NwSkJOdUhJL1JyQ2xrclIzSEdUVVliYU9ObHpQUnRsL1lVUFBlbWErWGhq?=
 =?utf-8?B?VVI3b3U2blp2ZHYzYUkwbE0vWGpRTFBlczUwQTJvcFVSaXorQ0tmeXVoTzJV?=
 =?utf-8?B?RU5IQ3lLMC9VUkJtQnA1Z3dNaHlIOFBqYkZIVm5UM1BEdWFjeUovejN1QzZm?=
 =?utf-8?B?NEVqN0svUUFoUlRvTkNMRFB0RnI0RWM1c1VjWnVHRy96OHJpWUx2aXNqZ2Ju?=
 =?utf-8?B?eWZKK0lIc09LdWU1WWdlNGVqSlUrWHhmWVVrdTM1bEpkcTZ5bVNmRVNPeEZj?=
 =?utf-8?B?MG5OUGFzQTRabnpMVS9LS1R0WDlDRlNOSmYrTEdKMTVPNDlEMzB5WC94UDFx?=
 =?utf-8?B?aUVPZ2tvdEo3ZUJLR2xnWkNoaWRZVTdYclRMOEwrUFdIMEY4Zm1YU29OcDdY?=
 =?utf-8?B?TVF4L3ZzQ3M1MUxuZWs5MU9uQiszRHV0Z2pmR05kSDRsQ2xaMmFGVmlVTUdX?=
 =?utf-8?B?ektadHk0Ynl3MmRHUmRSdVRFSEFpNWc3SGZkT1EzM01jV0lMcnFsS3ZLMmdu?=
 =?utf-8?B?RFlBdXlJTHZmUkppUTVJRjhXOGMrbXpqRVNXM0F2UjFpdDVTZVB3Vnp3NHgy?=
 =?utf-8?B?eVNSbzlQQmRjcW1JVEdyZXlNajFEWENQSzJOanRIcnExTWRCNk5kVzNuSmhr?=
 =?utf-8?B?QzN3RkFBNlRrMzdsZWRhK0trTExEUmhvYVJ1ekkwMDM4aGZ0d0tiVlZMR0tk?=
 =?utf-8?B?c21ONFZQcE53PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXhVa0dVbWJpQTZ4L1h6d0dGbnZrTXhxM0IvVVdIQ3RVSGxRbzRueVphUVM1?=
 =?utf-8?B?SUFlZ2I4eXRXaExGMVRpZ2JpMkJQYzdVcnVqWGpqb080Vjk2TEhyMUFsZ2o5?=
 =?utf-8?B?c0lVdVl0bjNxY21MSmpDcE8xZ080TUNaVDd4cHU5ZVRKeEpRSk5qb01pUW9v?=
 =?utf-8?B?SEFoRkZJekhpMVY5WVllVGllVUdpazUvRHV4NDZLTUpxcjVyT2QxVUw4cjVS?=
 =?utf-8?B?RkY0ZHFkOGVUTmJiZ01wV3hGZGJHc3oyWGFtQ2gwNDRnNFZsSEZQYXM0dExP?=
 =?utf-8?B?UW9HUEdEQ05Pck1XT0lIaVJiRHVlVklLVW9Uemx2UEsrd3NXNDV0WlNMMVlY?=
 =?utf-8?B?TGJVYlMzb3Vqc2NRV2tOUEtFV05oQk1tQm0wTDRwSnl5dWt5dDJOVi9SQmlD?=
 =?utf-8?B?N2U4WnlEcjBvNUFUTzhSWVZYdHlOQkJhQU4yNmVuNlEwckRKWFBZZGlDNElX?=
 =?utf-8?B?cHJyVnczUDBvR1phR3AxelEzekpmODhUbloyZVRkeHhUb1JYUHZOdTJDYWlH?=
 =?utf-8?B?Tnpha3A2SnRsTmlWUmdFM1FoWTduV2Q5d0VkM1JqcVpTcDUvQ0tHWStOMDlv?=
 =?utf-8?B?QjNDa0dhanlvQm5JaXB5SWdldmp3T0NzU3k2VFp0QkZoNDZNbW56VlVKb2hx?=
 =?utf-8?B?UVYzNHEzTXdvMmNUVFZrZ3ZNS3lMdkNZaUxOSzY4aE9FRlMvU1lCVmIxNkhy?=
 =?utf-8?B?OXJTMUZkSHhCREhNSUErbG1sZDEwd1ZtZHIwMi9zYklqV3RwTG1meWFjd2pB?=
 =?utf-8?B?SUd1ckp6ZklCTkxZd1ByQ0QyWlBOdlFRTmdzTExlSUwxYjhKbEtyN0FvT1NV?=
 =?utf-8?B?a0RmRHRiRG9zNkl1b3FOTy9lNVFlT1V4OHhNR1loOWd1emh5Z1lrcnVjZzl3?=
 =?utf-8?B?bHBBSnVpZjdOVFFZSHh0RHhZVnFldE11d1hUU1Qva3JFbExza1NqY0RWS0pt?=
 =?utf-8?B?b0tFT1E4bGlITldlbFdpdFJaMUdPUENpdkxYRE16MnpwNmU1VTVpNUV2MFla?=
 =?utf-8?B?bnJrMWgxd0JGemVidHJBVUtuZ0JIa3dDTUl1dVNXdG9MMERmb2ozN3hkaktS?=
 =?utf-8?B?UEtqeEl4Q2c0ZmJNUFlBN1hZZmg4UUd6V3psdTM2akQ3MzVqaHB0WEc3SkZs?=
 =?utf-8?B?ZmZkWnJTZFlBWjg1WFljRmRsVE9uclVhdUVBWGh1MUhSNjAzMHZsbnhiRmx4?=
 =?utf-8?B?cFlaSDgxTWRkanp1NURBNUhxQi8xdkVicnpsMTNQZG5VNzhSSWMwUW9iUTky?=
 =?utf-8?B?QnZYbG1WQ2QyUTdldHpoU2NwakJFdStWYjhTYXA4N2ZZMDk5OWdxcTJMa0JL?=
 =?utf-8?B?aHJ6cFl5cnBvRnhIWEZuS2NQaUVMd2NkVFV6VHB2ZGlVR3BueGFrSE80MS8x?=
 =?utf-8?B?cG4yUU9ad0FxZzZmUm5sbUdFNVdBNDg1MS9SbWNsNGpkZFpEMEtVUUNuSkUw?=
 =?utf-8?B?VHhsUWNIdzNlbG90TU1aZU1wa0RSMjJ2aTdBd3VmOGVrcjlqMjR5SnMrbDBs?=
 =?utf-8?B?c3hxTVF4QmxZTTQwakVQUFdIWE9FdlNVaVkwblRHVWpMeTN6N0lHREdBa1Vh?=
 =?utf-8?B?U2RySVdYWjRMU21keFQwSDJ0NVpJaTRUL29nL3NBRE1CM1VGVTU0UW5iQ2lx?=
 =?utf-8?B?S2RiRE9JenVZakpiajBhb0M0bzdzdXJtM0ZpSHB4emNYd1NkVnY3OHlyWUR0?=
 =?utf-8?B?YXUxTzdOVWtGM2FuckROZ3RySHM4a0tYMzRaT3JKRFZDbm5aQWxPdG5iYjcw?=
 =?utf-8?B?a1J5YlNISGxqQmo5TzJqUUtiNXRsR0Z3UlhITWx0UFVmS09xcmRmOTk0SmpP?=
 =?utf-8?B?SmhBNlBkUHhjU0VVOEliUzBYakw4ZGdBclJwcnFyVzR4cTdKTnV1S3l0Qi82?=
 =?utf-8?B?QzYxYmRwckxZL0xjbE84S3RMQVBPeXRnUG1mcDB5OFhjdTdQcFh2THkyQWdG?=
 =?utf-8?B?T1ovR2lSWHFHU0I2Q3U5NTc5NnM2VlBnWU0yNDRUS2xMMlF6SjN3cEVMUldE?=
 =?utf-8?B?b2VxZmozellTemt1RFNnSWVJT3U5M3VDVnk1TFhYMkxPSjZqVGZ6Z1lMU2Vy?=
 =?utf-8?B?NWhOanBFR2xTNTlENmxoOVFsVFBwdWxqWTdTSGhwQ1N1Tmh2Y0pyNTRKRUMx?=
 =?utf-8?Q?M2IaSPGfRKyIjc8n67x1xt9+7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e280fc38-1e3c-4bad-9f5f-08dd4ad1864a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:23:11.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VTM7MmeJqifdst7haj5et6V/NtvxOFF3za58oGrkiyId8rOd8gTK0nKzDzqV60KZXg2CUuPgCP12fg61Eh3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v14 to v15
- change out address type to dma_addr_t to fix below build issue

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082311.G1hWGggF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-test.c: In function 'pci_epf_test_enable_doorbell':
>> drivers/pci/endpoint/functions/pci-epf-test.c:726:42: error: passing argument 4 of 'pci_epf_align_inbound_addr' from incompatible pointer type [-Werror=incompatible-pointer-types]
     726 |                                          &epf_test->db_bar.phys_addr, &offset);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          dma_addr_t * {aka unsigned int *}
   In file included from include/linux/pci-epc.h:12,

Change form v9 to v14
- none

change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index f728ee2660a4e..b93984889f736 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -469,6 +469,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, dma_addr_t *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 518bc4171285e..a1a1bde1bc2ff 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -240,6 +240,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


