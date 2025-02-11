Return-Path: <linux-kselftest+bounces-26423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF462A31530
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFEE1886167
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001D26B2C9;
	Tue, 11 Feb 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l6x9Oe/l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1730A26B2AF;
	Tue, 11 Feb 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301841; cv=fail; b=C63MSgELUd6fHHciibbxcE1r3eVhxbO4lx6SVHFQ4r/jTk9nc0jpOfA7KP2iLNvUMc+cHXYhfjNqiw/XR1/PcZXhgaPv2Z4m0cP3m9QC0y7shmkTtwteG6yAwoc8IcZkAiL6tulJ/LAu8py6i+xWqjE8feH9AshjcelYs+S/27M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301841; c=relaxed/simple;
	bh=lCL6z6y8CVHebkwmpyotf4ntH6iD+kZXtq/tGQQG+8w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cHmLuQy6Lx728eN02+odb7pUyEjjoq4e9xYvI7o6+NwVG1vfahena0zEozBAiVKDyu5AP3ASJa2OWvS3ZuX76qx1bf0UH8nNzgSJZqZbb/Ci+Qd2j5kNoeK1N2tg9eBNXpSHhZhm1rp9DEVykVTUmFUFsxYfn4T6d+zQeZXT8FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l6x9Oe/l; arc=fail smtp.client-ip=40.107.105.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ1sKx332zTMZz0e4plGon5QF/vV2a07NY/XzXBZ4MOCvtvddzSJ2gso8fyOf2aBtmXJyYhy3g7qhds1KJqrHjzKSbrgqEMwDEzq4QdWPLgLyazTc3wzQoHLHyWgoxJ/dKlIx9KgZ4smCn9yxGyxew/n6ROIk57AtXnwR7SBS6y9ZU2f4ZDIaezYewuoOG5EyiGI+/asGQNe3dF4dIh0I9UWAnfDvwcjQn3qjik6ee/Glwr0IPFrbafqV/3z6Ct71ow4llxZJkM1QJtPpdNuX4QwdErqfQA4PWv9AKn/RHU7uZI6zUZX1gRP6OVl4SZimkEYK8V57oqmcrJffpJtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+LzJPZ7Gi7lAxatOmcc98lvsDhVx9q2XMNbv9qEuKA=;
 b=At5Sssw4CHDrfwnZE3+hhv+cPyTcZ2/NS1c7wZrIwLBgjjPqJXWPEWj/V7IbhlUeqSDJLbcYlqtvvPlFUJ34VhSgASYJb71LOale1gUl3D4yWeiYgHYJ9hCoX0l9pzAdjV1nTq/m/5g6AND9jpa0YOKaBt1ydCIk8T19H562fVK/JEnicoQqvRLufOXCy11RbnV/TxT1C0wv/UYGhlk3XG3/4CbkuDTEcazotjTwY/mgqqg50kjH4uYWnUHocQlb5dwdJduxcuCNCXsidOnkDHlT7Tc8RkZEqfB8MTcz3UsEounSv+9lMKx7xmobVE9fOXKF5USOP0LdsKY3TJLefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+LzJPZ7Gi7lAxatOmcc98lvsDhVx9q2XMNbv9qEuKA=;
 b=l6x9Oe/lDO9JoNiLAmHqoTZY4KRvbG+8YdlgFxtz7a+QweX8aYH1CoqXiyMyrqxfLOgicSk3kQa480wGqkG84HYTwmv530ekMPSKr0aC4IhW5Vni5G4N2XoYlxs702U4soRKasQ3sbrJ3WEBuDFv8ja+qiqOa268Qo9uUiwYGduZIOazNBVenZQtB7JcCQZQttbYWqXDs4EQBdXyxBLGe81TRMT8sd/52tAE78TALHEo09JOJVNSNaJ1LPTzSymgbTPao7gK9QYnCo6gPrJfGL81yVzyc4GHvMXZPpvbDRvr/uYlrqCNj1ifOYBazdGFL77ILbIJv3JqMWhrUNC5Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8553.eurprd04.prod.outlook.com (2603:10a6:20b:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 19:23:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:23:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:22:07 -0500
Subject: [PATCH v15 14/15] arm64: dts: imx95: Add msi-map for pci-ep device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-14-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=827;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lCL6z6y8CVHebkwmpyotf4ntH6iD+kZXtq/tGQQG+8w=;
 b=sfW6AQBb2HQ2oEa5MR6KhcXy6sZ7o9IzY/NljbUL6bfMX840IU6hmYU3ZEx7V6YNHMfWRU7Bd
 0otqu/AEEsJCEUBB5hLb1+CLl53sEfDygg8pdbhURcP3mCiEA1ZqMpP
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
X-MS-Office365-Filtering-Correlation-Id: a631130f-0f9c-42ae-9088-08dd4ad1a119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T29QbkJsbndBeTcyakMxOFRQMnBKbWk5NmZsRjR5cU9XSXFhVlNYdVVDRW10?=
 =?utf-8?B?M2VpaXNRVWtOSmRCeWdZeTVzZFVWNUkwSXhLR3Q4ODJOSlhSS1IxWnUzVzNl?=
 =?utf-8?B?czIxU1VxT1BzTzE4ZVJmVGl4STJicTNkOEJnTnMzMWcrYXRWaVE2SkdqTWVJ?=
 =?utf-8?B?TmRGUTU3N0NremllSGMvUytsRnRSMGZPTXFxdndkUC9ST2dDSWpRajFjYlJa?=
 =?utf-8?B?Nkp0c2tRMTE1UGpwMVhJOFVaYnEyeko5bGRhOWdyL2h6alU5V3ExNFBKYjd5?=
 =?utf-8?B?TWxKSTliMnJ2dmlCWUk5a1RRMGtjTGFPU3FlMUh1L2ZyVEdXUnVRbnFyaWVO?=
 =?utf-8?B?QkhDaVNBamZJTmlHTmpTWE9iN0pTVVpzemlKZUdjQTFtUFJneWVSc2ducURE?=
 =?utf-8?B?enlmcis4LzR6WllYRXFhLy9zSnExTzE3UEFRZ2tCaVNpNS93NUJ3RFo5UHFI?=
 =?utf-8?B?SjRYYWdjNkovRndYWUVqNXBXV1JMNU5YQndjTi9WVlQxbkdHdzVRRWJjRkt3?=
 =?utf-8?B?ZU9RdXBrVEZTanRoWWYxYnVCZkdNZ1FuMWlOeWpXY0laZDlQaUQxV0c1STIr?=
 =?utf-8?B?MDgzUGVrMVZCNXBXNHhMbHhkZzFGZHdCR3N4eDVBWGxod1U0Z3NkL0gxRnN5?=
 =?utf-8?B?bTM4enN0THQ2UzczaGJwdVMyeTJBNEJhUkszT2xORVA4dDlVWXdxMjFPZi9M?=
 =?utf-8?B?V0szbTFPbkszN1FjdGNoYVl3L2pLNVpzNjRZYkVWRWQ2WlJkcmt5MjI5MUpI?=
 =?utf-8?B?dW50MDFqd2o3SVpOcjAwZ3N6bGR4ZExBOGVhOUZXV2tZTG9TcFAvUzU1TGIr?=
 =?utf-8?B?ZFRSblJKWENVa1J6YWFSUDJjOEovcDA0dFN1bXM3YTJDSm5zSDUwWnI4azJW?=
 =?utf-8?B?bFZhL0RxdFN3RDhCMHdSMXJOVXFqTmF5SmIxam9vbWgwMlhMdEVHQVpsQkFB?=
 =?utf-8?B?QTZpbVZQVSsvaVFiMDMySzlpdlo2eit2a2dONWNEcUh0QXFWWU01RzVmNWZs?=
 =?utf-8?B?UVRQdnhkMXV6UzdzN1RrdEZQTjZ1VUFvbnl3WUZ4Q1A5NXh5bksxRm5MVkdW?=
 =?utf-8?B?RDFiRHF6WW5VcmJod1hOb05RTXdrSzRIanlmQUttbkYyanVDVkcwNEJtZzRs?=
 =?utf-8?B?V2VJcUIvdW91dFYyVUMyK05MbGFqWCtNOGtiQk1XWVYyd1MvQVZTcU8zaDBI?=
 =?utf-8?B?SEtZRmhkR2Q4MGpBTjJCRjJveDNmQ1VacnJYOXJ2OGVOUm9zU1RoenNKRTk4?=
 =?utf-8?B?WXpHSmdaSkhJYWdhYUx4eU5zVExheE43ZXE3UDV4MlRNMmVYdFlFREFORFlj?=
 =?utf-8?B?cDBLT21DbGN4Z0dwZWttOE1YT3lNbWRzQm50WDdoTW1UK3U0eUVSSDBqTVVD?=
 =?utf-8?B?cGJ0L29DK2NZQWdqOUNQdGc4MHErRTNGRGJJcHdJM2Z2VytkbDlSZjVObXo2?=
 =?utf-8?B?QkRlS0VFUm9INkJzM0ZCbEw5Z25jMXVpSkZ4QjI0MmJicEFoRUFFQzRaYm0r?=
 =?utf-8?B?WU5Mdm9VU2tiYlEzTTNhbGVyaGJjcG55WTYrQmJ5YkhFK1Fxc0NlcStTbnlk?=
 =?utf-8?B?UTM4NGZaaXpibWlvMWRUc3BMTzFmTnFBSnh4b0hLNXY3NDI5blVGL0J5dVND?=
 =?utf-8?B?Zk9qVERSbE04VEt6MHpweExVUmkyakVZaUdJb3czOUIvY1F3UmhoN3Y3eC9m?=
 =?utf-8?B?NXU4MUpqRTRVbS9PYjhxSUlPRWJ1UVpPRk9OZ3ZFWWdBMHBjdko0M3NHRFBC?=
 =?utf-8?B?YkRZWUJyV3plVU5BdkxFWXE5dURFV1FhRkxFakp4emJxUzdPVkZHU0U4WUlF?=
 =?utf-8?B?Q203bmpab1FpWi90SkVKbEpqTGEzUW91YlNXTVJ2RWVlbXQ1a3Y1S0Q4OXlK?=
 =?utf-8?B?MXJRbEVYM3kxaC9TUW5SYWJxS2ZUUWtFNGgxczVtL3FyYVF5WmdMcTFnY1Vy?=
 =?utf-8?B?ZkVyM2Z4QWMveTAzL3UwL01ZYXI5MHV4dUYzSHVYVHFqRnpncGFOTVFjMjdp?=
 =?utf-8?B?MklKRVhUV2pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkNXQis3dlgzWHhvKzBTQU84VmEzL2poOG1WQXFmTDMxaUMyWlpLV3VVSXZO?=
 =?utf-8?B?RXBidVBoaVV5VUdjQy9XQkgxQS9BaDVkWHo3b29zYkpVQ2l6cXNhd0Q2eUQr?=
 =?utf-8?B?OFFqSmpFZHM1UDVmanMwclRtVHBsL09HM0orbzUzUlpEMFFHajQ2b2RtTW9a?=
 =?utf-8?B?U3JnOTd2eUpLdmJ4VXVEY3VJMlE0bGJsZlpnTFNhcW81QlowZkd4MUg1ZWNG?=
 =?utf-8?B?ZnY4MU1aV0lWL2VRbndxaUlVZUhCNkMxdm5KUW5kM24vc3Awbk1IL0ZGVkZR?=
 =?utf-8?B?cEtXVGRlUDlnMjJ6aTRCTG1lcnZPNnlpa3M2anNhbkJ2K3M5a2xzQTlWZEpa?=
 =?utf-8?B?ZFJBTWM5QlJDeE5tcHl2UklDV2dGM3cyMmhKSnRrSmpPclEwQURBZThYM085?=
 =?utf-8?B?ZGZnNVc2VDUwN2piRGllYy9xcm83NkphSXA3bFgvM29Ha3Jrb0t5dzJ6WFFh?=
 =?utf-8?B?eUNUSlFVSmUwMndNVjIzbjNDUkprUjNQR25qdktwUUJSVml0WWI1UTNhNDFn?=
 =?utf-8?B?QTJicFNkcjl2M05mU2pKSXRxd29KSkJvK01lS0dIQWkzRTVDMEZxK1JXTEZX?=
 =?utf-8?B?K2lpUTFTaVMwY1QwZlM3dFBUeDNtdWVpU3F5bWFUalJndlQzVEswcEJBN0lq?=
 =?utf-8?B?NkQxZ2k1UFhtcVRnbWVzZmtORUpGbkRBRVB1ektVQitEM2VrTkx6QjZZQ1ZT?=
 =?utf-8?B?ZVl2c1p6V2EvRmtWbm9xUENvNXZ2R1NrM0pRVTNuaFVySldlTFVHSnJDRHpm?=
 =?utf-8?B?MUlRMElZdUdQWXJ3VVZFOVVpQ1JIeGNHeUxNSW1QQlRnNUxTTk5xb0dMRVVv?=
 =?utf-8?B?TU9YRkRJWDZxM3BVSjYxcjNmcWZpVk5DV0d4NVVIK1FFd2xGcVRvWHVZaGVs?=
 =?utf-8?B?N2xrbXYvbnRpVmd0RDRvbm94SGNWQnV5ZDNQVTdtQ1J5QjAwVFBiazU0amtR?=
 =?utf-8?B?bk9scEVSajJhNEF5WnNxeVRWTE5hanZUOUthTE9UaGFrYi9tTXdDK2pUaUs4?=
 =?utf-8?B?VjlkN1NWRmF0eTNSN2paRkpWTGVxcHFWNnZyS1YvYnpOUTllR25HR3ZVd1JZ?=
 =?utf-8?B?RGRrNkpoZHlqUnJjQTRwa0NpTWhYeTE5NDNKWStER0ZmTEE0eUVkcEh0dDhj?=
 =?utf-8?B?dEVGTmNoa1ZYYXlZYjRubmJsdVp0bEVKaW5HSVRtSUlCR1htbVgrdGMyYVlq?=
 =?utf-8?B?SFZQTXRQbDRreTBwTkdVT0JTcFJxcFQwZU1xMlF4NjVjS0VHNUVCT0pBRWNY?=
 =?utf-8?B?ZTJyK0x6V3N6YVpFVyttbkRseTI0MzB4L21icnJ0U2JSakNPQ1ZZRUhmM0VL?=
 =?utf-8?B?Z3JjdkREa1FZYlM5bXRlYVM0UWUxMkd5NnZlV1RzNzNObVR0MGt3WWM5cDE4?=
 =?utf-8?B?SG9nYVBlNTBzQlIwY0EwaE10RmJpWldBTDhpYWZTWmdCbXpjcVRtbzZwZDU1?=
 =?utf-8?B?c1JNd2Y0eHh6NEttWm8vQU8yQVcrQkVvTTZLNHhmVHEzeWUvRStaSHNXclBW?=
 =?utf-8?B?QjFna3lBR2dDZ1FmazVrNU9LU0E0ZHZtSG9QdWtCM29jbDk5TGs3Nnk0dm4y?=
 =?utf-8?B?dW5HM1l2Sms5dnN3d0lxNG1jK1hWRGZhR0JBSjg3L2hrNWNselNyUFliZ0xj?=
 =?utf-8?B?djRUTjNtUEZiRGp4N21WMzFLdWhzUE5TQk5tUE11Szk3MWFKb1VqTEJVRGtR?=
 =?utf-8?B?MWpuaGFUZzBOSFR6dWpzMkdCcFM1WVZDK2xENzVrdTNzZFFDemEwbUdXNmxP?=
 =?utf-8?B?ZytvbFRRYkRaNk5lL0ZLNTZyTjAvczRTV0JpajJQVno1WXFFaTVrZGh4OGNC?=
 =?utf-8?B?WnllanJUaC9wNllQbXlrZ01pRnI2d1A4eWp4ckxXQm1vSVNiUFMyNUpyc21Q?=
 =?utf-8?B?a3VBdVh4YWY1ay9hVmhENlNnOVpwQ05BSXZrc2tkQWdPNFlXZ1JyTzUzcFVr?=
 =?utf-8?B?Mm5TN05ZNEtDcnk3Z0s5UnlmMm1LWGRETXU2cmxGNHlWRTNBb2xhZDhGQ0VD?=
 =?utf-8?B?UnZyYXh0bzhpbitVendCbmlyZUhybllTbVBUTWdKdGcyL1IvT0dPUmhkNEUr?=
 =?utf-8?B?bmVCVytJRGQ1QlRQdzFGa2ZZci92QkV4NzdLOHRmVlIxYlVheDFNNzZRaENp?=
 =?utf-8?Q?s8/4PKfUupNVyylfbCM+qfuOY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a631130f-0f9c-42ae-9088-08dd4ad1a119
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:23:56.9123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAnHaMd7vpotZS48Hi6kzRzEuWxrHJxerFl/M1byJwaE1jDS0gYzaUn5W6mb3KbMWI9VjdnqQZ7N9uQ2jWD0Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8553

Add msi-map for pci-ep device.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v15
- none

change from v13 to v14
- new patch
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 6b8470cb3461a..cdc06dea5982b 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1667,6 +1667,7 @@ pcie1_ep: pcie-ep@4c380000 {
 			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
 			assigned-clock-parents = <0>, <0>,
 						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x98 0x1>;
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};

-- 
2.34.1


