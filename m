Return-Path: <linux-kselftest+bounces-30759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D2BA88B60
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB5189A8A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30828F52A;
	Mon, 14 Apr 2025 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PxHPupQH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41662951B5;
	Mon, 14 Apr 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655575; cv=fail; b=qcspJg7AOWXKVBoY3xCO/vRd5Cwd3QSukFK1gsjIZiD8J7wR2nywfXqHwNc7cfspqVoYDt9zd1L/ZCEV25J/VETxH7l1/tQ6ECa1WJ+w3r8fxTVrDrSYU40pXpKEQD2kbiyClJGvZmVB0E/NKopaptjAx6rlkRhSF1LOrnL0tdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655575; c=relaxed/simple;
	bh=qxV51hE9iVaqehK/qn4rz9KrbxpDkLsIBLjf7RRGT20=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SBEc6MmKboG1W8emGDp27P3AgHKZhv4KV/P4QKdNbNbIFnGApwwVYQR2QRPeEKBmp1Fz5wVOp1TPqkge4o39te63kuPhnYOURWfB1DxogkCKY+m0hrOV6kbT1D+C51ew/fqNjMKRMQ5n1+S8c+nvdxHNR1j42dLK4GMv+jt4OmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PxHPupQH; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QofYd/+E0dlOm5HThk53sJYmSh1EgAejdztVK4uS+n46VB9T17VeNRGfh9vbUG0Jxd3hdRJ0u7aakBwQ8HPQiy1ul8wH1XScrWNgubx9BTQZoAeGATH/+faoADSsTjkpJGTLrtw8DoQFQ2RbB/bbAPUvWdDzLGFEe/3NO3pTey3w74IkKXDljACpBVN2TiIH2MR574UGLMsWQT+2OY0CwLpqSYwrNFqFbLxfCNJ35iP7Q1OZW6kSeHsD9zUvysoZId/KqB/7hpXhmghxWvPbNSXvb301tgpjQn/JeFHZ0pkp4hmvJPARE8wWE5dmDGdh24GJ9GcxdAxxa2gbET9T2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HXJMXZ9LGUTZustVJgA/C/zKgpGDb31Acgkq44bsAc=;
 b=xKzgWYMikQ7bVp0IrJgiBXim0iTsxtDugAoT2vGYxJ5oGrLDIsN01kwP5ZrplWA4gl8G0yQMykOQPH8WhoikL31Lq8/0JW3jnbMONgRxBaXLSHLKsFTXiJqvlQOt8D26/YKT8xpmRqaIXxm11ko+7LAiI/Np4NR0DLTfEdG9QEeejvewRkkHooewzQdBZ9S+R9e0BmOxYAEVksXbsZZtWtt5Vp0aT8MXKBDypBqB5F22SEPW9GO8AKMGEPF7pgx0bhuPBTbLmW5338CjfRHUxDlmQbthrCGbFweE2AqkUmgRI8E7AqZ9bQq5ka4pE24fTyhifbn5IVPj10/WPDrYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HXJMXZ9LGUTZustVJgA/C/zKgpGDb31Acgkq44bsAc=;
 b=PxHPupQH6qNbxkY7H7SyySR8P1Mv4JrPuxAuJcUSi/A17FTT9sEeqvvScmakyvnQm3fh4gfrooq+xiQmnc7l66SnvtIcd++pXhVCa2fHVqhJZAMyLhF9giaw/X8wsTXzoeom7JCtf9JsmHYRTiZHZJHMhHKaeiN2g8ZYJO1LB1PfAKUMuyGNsCmNErbkVf6CMta5D0/SQynihp5ZBm7FdpKSy8JkeZN51sV1ikwLOAmTL+r3t4mHZhJwtHh5k4ggMbCc4ji0+8fXb7zHiIa/3YGTX4b4OfibajnNG2LN9Hd5guV/YHidMvkGKIIQK+SVSXxI2fAF0cQMBt5Oo4Tz0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:32:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:32:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:09 -0400
Subject: [PATCH v18 15/15] arm64: dts: imx95: Add msi-map for pci-ep device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-15-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
In-Reply-To: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=827;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qxV51hE9iVaqehK/qn4rz9KrbxpDkLsIBLjf7RRGT20=;
 b=1zj9eSgOn+rmyo2cw1RJpm1r3xGjbYHkylDMqmpqOgP448OJnuNdkt2pQOfNj1pmu1ygcwGsn
 /nxsX1RsenUAnfiaeBLDpiXLJe0LioDDiQhLBikTw+R8oUBZZCr8RlB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:510:324::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10245:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a8769c-9496-4f15-4940-08dd7b82c33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVhHcEdlRXBabnl2NUVYZFFON2NPcnBhcGlKbEtKVGdXcW5WVVA4ZElMckVT?=
 =?utf-8?B?NG9xbllPUFpXVUxaQ2pnN2lhSkNGc04yMjZTZWFSMmc1YVJSQTg3TFV2dFNL?=
 =?utf-8?B?aU1kbTF4THE0eVR2WVB5RzVYYTNZS2VKY1Eya2JSckRXZ0l2ZUdHRHRhWUVn?=
 =?utf-8?B?Vmozbi90aVNrUm1Qcmo3SVJhL3k5WGYxTEh4eHQySnhHbC9WWTE2cUEyU1Bu?=
 =?utf-8?B?VysrS0d5a2JuSVhHSlJSY1FqcHFLZzFXdW03bmtJSlZHOEZYbVMrWlE0bGZT?=
 =?utf-8?B?Ni9YUWZlUW02b0JKLzNxK21pNW9jcWZiRzJZU01MN3p3TTcvV0tvSjd3UUs5?=
 =?utf-8?B?ZEZXM000d2RqZFlwUzM2ZGJTZmh5Wk0rdlNaYUlXN3VtUTg5R2lWdlBValA4?=
 =?utf-8?B?TnAyRldhZy9mUVZ4ZkUzdTIwMDJabGJ0SHF0dE9jYmhtb3BPN3RxSVBqdVRs?=
 =?utf-8?B?dStjT1VFQmxUaWdNeUs4d0RoRkdQN1lsUFQ4UlUrYjhnOFE1WE9Fd0I2Q0pr?=
 =?utf-8?B?ZFpuVndhS2pBek1sa2ZkMHB4dXZhQWc3UXBKelM5OS9IZGc2SXhJcGtFMWJQ?=
 =?utf-8?B?Y2hlUzFsckdiblk1bTRXWVNrY3U3VlIwejIranc4QW9oTU5Dbkt3eWNuWi9C?=
 =?utf-8?B?NzlJSi9rd3k0dEd6eWpHUVVjRkhYYnJwTVZsNUZSc01MLzN1ajd2RXQxaWVP?=
 =?utf-8?B?d3BQbEpsYlV1TXFBMUxSM3NjZjZJVWR2aUVnRGJJMXJLaG1TL1h0VGUwVGV5?=
 =?utf-8?B?VEppUFplN1pzcWZjTFZ5K1k4a29PZjBSMS9HcE1IZjUzb0hWZjAvdGNNV1J0?=
 =?utf-8?B?d1hFRWhOZkoxc3ZFYUt6UDM1THJsQ2ZZWnlCSDc0U1NGczk3b2EyUkNZTGxz?=
 =?utf-8?B?elY3MVZtNUJXRm5QbXhYSXV0WlloWHJrVWZXODJ1U3ZEcDB0aFVoQUtTSkFL?=
 =?utf-8?B?Ti9zUEtQdGlhaVpmTGRCZncrUU51aForWm05bVNWRnlWZ3h1WDYxMzZQRkFo?=
 =?utf-8?B?RFdScjZyVzlNd2hXOUo1Mno4OVFid0QxbSsyR2tTd0k1cG5aNGQxRW9TRkU1?=
 =?utf-8?B?VWQ0RVpGM3pkdkROc2pubHRkbmZ0MzR5WGFSUk1Hb0wvYjRKS1BYRlFjb1p1?=
 =?utf-8?B?dmltaDk0RFE3Y01VcEhXV1piVDVrNlNNZCtaSkYxeER2dWJqSEw2TlB4ZU5a?=
 =?utf-8?B?a3U0US9HbTdVUnRBaE9lY1pSSHZraGlVdWVxM1hSSGt2MkRyS3QxUVR4TVl3?=
 =?utf-8?B?amt2eDAxODBrMC9XUGdJRGYrZVorS0N6MnBWdnVPWTJYSGh5K3V3VVlyaVEy?=
 =?utf-8?B?NmZOcFJuVnVCTE1kaFVDd0xYWnRrTnIvbm5oL2FicnBuQVJZZmFZbmxFUW1M?=
 =?utf-8?B?YmFrVklpZEhCMHRzT0Y2TlRTUksrMUxBUGdLb3ZxTUMrNGJWa0s3QmRmcjRs?=
 =?utf-8?B?akIwNFc0c2w0ZXlJWVIrREFmN2oxc0pNSTE0QjVsMTR3cXpiVW9pSzh5TFlo?=
 =?utf-8?B?ajVoVmNiVTM2SWdKbVJoZ0JsdlR2SWd5UGgrRDQ4WFk1byt5STRMTzRXUTls?=
 =?utf-8?B?UjVvQm9JQzJVNzF2d2JoYjlnZEtuUzBqbzJBV0RiVWREbEg5NHVQbGN3dXdR?=
 =?utf-8?B?cjhjL2lXWStQeHgzbUYrTmdKU3NJWEN4ODhBZ3lhKzFTSWJTcHZjZzRDMms0?=
 =?utf-8?B?ZXF4UVV1dHd6NWNvK3BBY3dEdndiaG5rZ1BHUGJXZDFTWjl6dU1qUEtLa3lu?=
 =?utf-8?B?MlhmOE9HUHdYZDlEd28va2IvWUdEekNiblI0SjRsU0FDVGVwUzR3RmhKTGN4?=
 =?utf-8?B?cVc3dTkwZ1N3Y1l4QmEyNUhmR1RQVGZianV6c3d6OExTZG80Q1ExMks2YzM0?=
 =?utf-8?B?VzJCZEZsS1BqYnYwOFAyUkZlQ2haVmJ0ckVFbloyd2hKTThlWk0xbGVQQ0dt?=
 =?utf-8?B?MDhiMzE0OEx1dk5GWGFtTzkxdlNYYUNackNEL1loaUxzMmlMNldLdmlLc2RU?=
 =?utf-8?Q?jGRaxY16gv3VlHI3pHOxZXlOerrI5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmFweThyOGdDWEFIWTRyS3pvekd2MnM0cEQ1YVpud2JITHpaejZlZDJZSEVM?=
 =?utf-8?B?Y09KNTk4clZ3VkxDQ3QzNjM2R3B5M2U0aVdnTXRxbjVsTGpMaSt3dit3TCtY?=
 =?utf-8?B?TlZvRkpKMnlkYUlsTGxMQmx3SlJJYTU1YzJCQmZsekV1OEM4THAxVlVPbElt?=
 =?utf-8?B?U2c5eTMxaU9CMElZbzhXSFk4cVlLZWNraDlPVnRRS0dsdDdPRGMrNlg2V2ho?=
 =?utf-8?B?OEVTbTNwbjBIVlRtYXBGeHc3K21IcmpyTFJ0N3hObjJaZ1l6YVY4M3QrVC9C?=
 =?utf-8?B?SUl0MG9ZTnBpeTZmRFp0TGVPdG5KczZxc1gwRGsyTTc3VngyNmJpRE1MR3l1?=
 =?utf-8?B?UDVpYnNQQ3J0UTV6YWdDWWNDZWVJUkJCYkExTnJSdmo0T3JRRE5GVUdjQXM3?=
 =?utf-8?B?M1VQNm8xTjNZSlA4WWtnemRMZzFHU0EvSHB3K0RtVHI1cGk1Tm5TOG9DaUUv?=
 =?utf-8?B?NG1sdUt6cUg3WXlWQXB5UlNDajluZDZpK05EbnZlL0tNclJZdVhJbXZXSTIy?=
 =?utf-8?B?WkJKZnA5NTJDTWhUSmJnOFJxU1UwMS83Rzdic1BIVWZWYVdiZUZmNklURExq?=
 =?utf-8?B?Vmgrb01hNjRneFhSeFpabFJuZHg0a2xLb1U5bnB4L3lhVmJEa3RMK242V2pW?=
 =?utf-8?B?VTRVN3djSUFMcDFFTEIra1R4R3h2eEEzKzhzc0o0WXFSNGluZXNNeUJseFhB?=
 =?utf-8?B?SzlIWUgxdERxTGNqRkx1WWFPeXczdm1wK25WQTFHblQ4RnpSRmM2Y0crODVV?=
 =?utf-8?B?NUJwRWszMGdJVXdXRWdkN0diNSs3OVZpZVk1OVZhanptT3d3cDE4SXZtTGtF?=
 =?utf-8?B?NFBHMHA4OVJtY0Z6MTVxS2R6VTl4eUdRbGZjSDdCSkVMV2U5QlVvcTlKT3M2?=
 =?utf-8?B?NEtQcWhsc0YvQ0hTQU1neGlpZjRCU2FEZWtoUXRweTNqb0hySldrdFlSbE1l?=
 =?utf-8?B?Qk9uci9PMloraTFPUWw1ZWRxSGJwMEt0MisyeWM0bk80U0xFenBZdXpIL2Jl?=
 =?utf-8?B?SkdPOUJyQStUWkc0ZkFBSk9rOStSeTRHb0JZazRONTExTkZzY05NcEVkWE9W?=
 =?utf-8?B?NkNmK1NmNksyeEhVcytkK2JTdjdNZGdhUC9DdkpJUEJoSlVOOFFWcnZSWUpX?=
 =?utf-8?B?VklSOTVQemZlc1RldG1TWGxHd21icE1sQUFlZjJBaVdjdUVONGViQURBZitI?=
 =?utf-8?B?NS8vdmptQXJJdHZYZVBMdVdudTE2NWVZT05vVzRERmU5cjdqZ3R5eXF0bmJH?=
 =?utf-8?B?eG0ramlvZWpzb1FSN3prd3NTS3U4aFExc01kYkY3UDVMR2k4ZnRPM09sTUtJ?=
 =?utf-8?B?dEovUk1TK0dWOTVLZTNhazFZVmVsc2l1SXhzMGRZUWkrTDJBMklTQllzOHh1?=
 =?utf-8?B?a3piZGlkNFFxUXIyUWZlQlRzVm0rUU5nTE1uZVVYQnRhOXgxZURBMzBEMWZI?=
 =?utf-8?B?V1dFMXowSjFmNndaZ1Q3UW9xdmo1THJlUGh4TGdlbWMvMHBBVFJrZ1phZVkw?=
 =?utf-8?B?QkVLV1hLWTNFbUtMNkU5YWZjajQ2bWhRS0IxblB2SnhZTEF0SThUMlhIRXRh?=
 =?utf-8?B?aXppLzNIZXFab1dFV1V6Q1BWL3RFWk1CUXdDNXdPTHNybkZhNkVXNW9GMmFP?=
 =?utf-8?B?K3RnU2psWnVqcjl2emtQSXFRTFA3Nml0eFNwQ0FzeTVXdnpybHZGVis1SzZB?=
 =?utf-8?B?bXFIYTgyZTc1dnQ2RkoybVBEcXJQK3VJM1ZYS3RsMEYxaG41bWpsbk14Y3F2?=
 =?utf-8?B?V09WNzRlVitsTFNjRmdxelFWZEQxY2pNK3c0UjZYV0xiMklGOE5yUENpUkNo?=
 =?utf-8?B?QkhCekJXTG1XV3ptTExHUXlBcHZHcXBLeTBTTDJ6NUhmbUJ0QWxMOCt0VUlN?=
 =?utf-8?B?eHNSRldCM05QelB3UlR3eU82WkpYWUQ4aHZSYzdScmxpZ2w2RmxNUjhiREov?=
 =?utf-8?B?ZFl6OE5xbDdKclA2cm11V0tDTGFJME04OGdvenVXZFlPd0xORjk1RkhiNnFi?=
 =?utf-8?B?ZmZuRGs0VHNxM1BqeUFsUENqQVpoUUJVV242bnhtYmZmNEg1T21SSG1wSi9O?=
 =?utf-8?B?bW5YSTZMNml0c1poQnFLa25Qai80amJGTk1ucTlCWmNzTXJDUEdKMzRlUGhl?=
 =?utf-8?Q?k0jI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a8769c-9496-4f15-4940-08dd7b82c33e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:32:50.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqaWIJaw6p9PevJPrpjeJQV8dwG596quAHuvY0nWA7iMt6qsTJdWRvY5bB69NgokvX4iTeA59NYxFztICYYGSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

Add msi-map for pci-ep device.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- new patch
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 15ba83ce691f4..c3c76991f1c8e 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1768,6 +1768,7 @@ pcie1_ep: pcie-ep@4c380000 {
 			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
 			assigned-clock-parents = <0>, <0>,
 						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x98 0x1>;
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};

-- 
2.34.1


