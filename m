Return-Path: <linux-kselftest+bounces-30746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F587A88B2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A6D17D336
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917228BA89;
	Mon, 14 Apr 2025 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UpxvSlVU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32028E5E8;
	Mon, 14 Apr 2025 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655489; cv=fail; b=khNUbgx0hnqUELklh7I25MSMF6lYRz+++e6ZCDLN8L3lHRnBfWxN55e1JI0bXamw5pYPjMSmr7TaPAIhDZz02q3rtZa+kVsbvOpuHX+16I0+vQJ6zg1TEJEC2UpGiBbHwEZs9f42Hw4X//X94R5pPfSa1ZMGghDKICT6kBahYVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655489; c=relaxed/simple;
	bh=p7gntWoxGh4gHuQtzBxv9euNYS3wHZIeRIkw2TEkLdk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EcgoDhIufFKknKF4iYBwGVYpVIokwE+PG4Ta7B9J0V1yqMYXOkMvZuT9O9tEm0DLfrBbeeu4SwOXeMIUTMqYtGP+Csaw/N0jZ3nl1aloYs81ak1QvlIGj3FDo3W+GM8lIFE5V+4/eDmlU689sKXoaK9arSjfKdANQu/jrBeDCwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UpxvSlVU; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKwZfQgY+ieqsCQHiF5K33YN1SRhO4NJ5m/edG2chW4oTy8oiwL9leuU1vXrhx8qUCTXnogxq8+V/IWaSWpD+/bbdjf8nZRdA3H/9lYbKEEhii4aZ2swxwAklSg6uHKU2lcbSHpHH9C9WiE9b2NlLHKhetLZouidLugMk5YaUXwL4q7HHZbIQHL5vxhps/77d7LaTI/ofqTAWlq2inBXZzEcguUIAjpoc9+uurK7foFNghkMuoFKGY5eNx/S9iBAGYgvvuW83C6gfz2ioIk8CNBJyFoq5SuEAYeil5S/jOqnYinoKvLdAa+e37DDeQKLwQB6+qQmpBm0c8UPiTj28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR0Z1iTOQebA6NDkRDEaFkcBL+OLXn2bv7Llb/KWBuc=;
 b=Bq7nA7MiFeLDS16k9ozv11HofapcU4CK9PoOWKqMKDxRWzC9tYyf/CxXN/M65h0c39BEDWdlaZJyFPAZmjvupwk5qyWtDuWN1SEN1qeYXr3+YaK5DPfz3z64Xbfd8zkwotIXk/mXmpgS8VAzRK1gTO4KDxwjPOZvM+nxD+aODKerH50xJcUunXaW26kPFnBNQnabFSCjoqS8LNhJa+zRM/BVObi9HaS1r2BH7vj/yrkumuPJJdCoBhr//UEOgrwwHRUmy/2r0jzlbId4h5J7qOUJtRISHTe2f37Cue/NnM9tEEw+Qv4acW6SgLXapsNGZgSA73g0nfFimfyeDz/JGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR0Z1iTOQebA6NDkRDEaFkcBL+OLXn2bv7Llb/KWBuc=;
 b=UpxvSlVUHjEkscH9D+La8hWIZeXZd/N6xgB56RMA+tsuJ5f/2zmGtjnPc716QAAku7qH44ZeKezPjyITuTmwj7X563AxnV1OPLIbMC69TeR0K2Up3UrYLNuIbJz9FkinKDcHB/Oge7unkzNSvs1CjmSU2YWQ/PD/f5DZHC+5AHK6QQSkFy7uomaB7Vpl9V/BE5SuqX6pKaVsyOWuaQLgoU1KdF4xvLrgvbxv18Dw61miyKT3P5e3z9Ltfousua8xQtOQwnHKoWveswtvWzvvMJ+yhOTC2bSoa3vYZ6VSYbzsZZ/tKEbvGP5jBOFpxaHOc/MN788og4yPXZhjhbB0hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:31:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:31:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:30:56 -0400
Subject: [PATCH v18 02/15] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and
 irq_domain_is_msi_immutable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-2-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=1874;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p7gntWoxGh4gHuQtzBxv9euNYS3wHZIeRIkw2TEkLdk=;
 b=t87vp/iAJ5+ZTIxg7gTHu5pYJEUnSrZuJ9oWaxM3zOmy/1v7XWE1vGROL331Er1Z7obs7OWWC
 LWwJtZ0VOkkBJWZ972IZ7dSMY8QI1fVGhRzg2gTN6OnvOg8XL3HZWy+
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
X-MS-Office365-Filtering-Correlation-Id: 0ebd285f-6204-4dcb-03ff-08dd7b828fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTVEMGhvZWlzNEJEQ2F1bkluVjVYTjMxd2VuNCt4QWgxcUQ4M2hyOHpyZm16?=
 =?utf-8?B?TmtVKzlHbGRGY0s1TkZTSFpQYkRiSEhzL0EzMjBDRXNTekZ3ZVdDSFNSY1Fx?=
 =?utf-8?B?ekdoY29MQTJvUU5iVXRJc2xWTkhuZk9OeDFhWUNiRVM4MGZPeVpYd3VFYWtY?=
 =?utf-8?B?SkxNSk1yKzJGUCt2NVp4YVQ3eU1JSjRWcUp6T0tuTEJDSFZubUtLTEQ3NzZE?=
 =?utf-8?B?anZFczRxWWUvTkl5bzQxZEZPdTdPWTh6VU5qMFRmbjBtUnZDMzBQdUMrZGU0?=
 =?utf-8?B?RkVWWmpTOUlTMkx6amw0ZDM2SG1OUmdzT2NNdFBNMUZyb0NzMzFkekZNZTZN?=
 =?utf-8?B?Um9SdnVNdXEydlU2TjllTkxqOXd3eGI4eE9CN3lXRVZzaGZVM1Q5MDJucDNB?=
 =?utf-8?B?aDJSQ1RpeW5vZXQvSUtxeFVhZWducldpdUNRVkVyMnFaM1BIYytPUlhKaTZj?=
 =?utf-8?B?YzdoejFQb2JxTmtIWmV3Zm85N1lnKzRjR0I0WHJSK0dWSkRaL2piRDJKdVBH?=
 =?utf-8?B?NTBsb3B1NHNZbmJKVmtyL0lXOXNPQWNqOElja3BRb0h4dFF6TE52QVQzYncy?=
 =?utf-8?B?YUI3SXo4dk1VaS9RbzlpYTNZQVl4TTF4MWJPSkM2Q01KWE5rTnF6MXlsRU4y?=
 =?utf-8?B?TzdHZDk2SFpzV0xBN2tuZVU2YTZzZmJOTjI5K1IyV1VqbVMwK25wSWdKWHBs?=
 =?utf-8?B?NlEyblVLTER1YjI1UFlvanQxWXdETDYzRU45WFVKcUpRcFJBNC8xbmtxZmx1?=
 =?utf-8?B?TXYxRkwxTmZoZnA4Y0cwZldYeGUyYjhSMGxUL2xmT1NpU3BnVWlQeDNIdWRI?=
 =?utf-8?B?dlovL0w1aGFScE9WRVVGYmY3ekJ1SHlWZUFuRjVaVTBCdDhYUy85NDN3QVc4?=
 =?utf-8?B?elRyVUowRlNqbko2RDZpa251dlJES2k5d1lxTGxPdmlzRVhmWm5SZ0FHa1cv?=
 =?utf-8?B?RllRNEJsWGhaQTB0VWdraTYya2xsc2Iyb2tGdDhYeWgwYkJxUFh1dG9hdVUz?=
 =?utf-8?B?MEJrMHkva1hFcmJXTGJVYmY1NWNQMHFkMEFXV1pWV3c2bUdoSk82aE83R3B0?=
 =?utf-8?B?V0VqZXY3eVpuVjNFZU5JMWhUdnZiWmVmbWNnTkRiUHU4Sk5aenM0STBSN3p6?=
 =?utf-8?B?cUM2dVE3L3IveXZRU3AyZUttRmlqd2lDeCsxUlNPQnlWWE5YSEtyWEEzM0lD?=
 =?utf-8?B?UXRYcUZrRERGUzFMS3MzZ1hmQmFRZ2tXN0dQQ2hHcHIvODFDVHpuL3JZMEZm?=
 =?utf-8?B?TkFsbGhubS9wZWNwOTQwSVV0a2ZYTzNpU2xZVjlnMXFxa0plSDVvWXRMdVhS?=
 =?utf-8?B?b1F4cGVKSk9sRkhnU0xTQ1VjZVRYNWwxbFBsNk9jQjQ5a0tMZ0NPYmpGUDlM?=
 =?utf-8?B?OXdxTkxENm9HZGJkYjB4U3BjTmN3QzMvaFEwT0l0MmNwYWRlL3YvTFF2czR2?=
 =?utf-8?B?OUJtWUtmcGdrSzJzWUtodTlWM1p5TGM1VmZVbmpOVSt6WlorTVlwaTk3a0kv?=
 =?utf-8?B?NHdIMlptQzdyNVZ6QU11cGNhQ21Fb3k3VXlZS3Z1eHRuN2J3Q0EvdXNrZTAw?=
 =?utf-8?B?RDBUSUlGa0lSZnQ0SkQ1MnQ0NmZkUjVERCtuTGxGM29sNGZ4czRtS1Q2Qmp5?=
 =?utf-8?B?UzR5V2J3cUJMWUUrTGRCd2ZpZUxjRnkzMTBGRFloaExIVDRKbWNIdWREb3Z6?=
 =?utf-8?B?L3JUUlU3Uk8xUWR0Ly9Oa3hUbzA1endLbGEzVHh5OHdkUWQ4S3FrbG0vK1hi?=
 =?utf-8?B?K0o1WHVwQjNFMjdpcWlFaXJub01Yb28wclZWN0xnaU9vMElFUE5DNXRwQTdo?=
 =?utf-8?B?cnNBVUUrTVRiVUQ1b3AzQ3Z0eDhQTzdiSkFZaHdJR1dvbnZDTWdVZVhDaUZP?=
 =?utf-8?B?Q2ZBdjdhZ21ySHdVZXVKWlg2b3NTV1NoRmdBWkc3RlpxYmZlbTZxL2JFZnEz?=
 =?utf-8?B?Q1lTWjNMV3ZYTGlKaEc3SjlOTngyc1hHUUNsZVE3eEp5UDFmS05vblI5dENZ?=
 =?utf-8?B?eHFGWG0xekZNUWg2bm5ncXdMdjBCcmhGSDBHZVcxRGRWTGlZWVVJd3A4NXNC?=
 =?utf-8?Q?YOPqtz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVlhT3hDdUdpYTRvaE1ySE4weVVwRmVwaDNGbndkdkNkRkZmRGEzUy9YSUdw?=
 =?utf-8?B?Z0RDV3Myc3Z6MnEycW5pUnh6b3F0L0JKTlZRTjlNT3ErbkxiamFxTmVvL1BH?=
 =?utf-8?B?dkx1OFFQc05vVkF5RjZiYWRLSGxXVU1aeWhZWkRVcm4zZXEyUkRqQkNVRzRK?=
 =?utf-8?B?VFNnM0lDcS9QZVpCVTdaengySnRkcU5KejV4RmpXbHg1U3ExR01BR1UyOVNT?=
 =?utf-8?B?VnJPamN5VGIvMktzNy9YYUFaR0ZLYXpvODZUWGFZY3VuYjl2aU1RL2M3YnZj?=
 =?utf-8?B?eEt6M0ZRclFKRDNPSEhMdkFmdzFwZlBEaEt3TTZZOG5rRERiNmVOMGZKOW1V?=
 =?utf-8?B?emQxUmk2elIvMFVXazZ1aEp2Z1psRWhsRlpjODh4WHVGeUpCTXpFelFBSVd2?=
 =?utf-8?B?TjgwSnR2czlERkd6WHFxeVVZbVlHN0JmRkRTQVhFZUhRRksvazI0cXh1anM2?=
 =?utf-8?B?UlFOdXN2REM3YWtFbDg3cDVGZnc3RzZCWGNxdmUvSWtMUnJDMmx6c3Q2SGFQ?=
 =?utf-8?B?M2JMYUsxOEpUdFZzWW5WLzYyQzQ4UHlaRlA0WGZpSTdhTmRBS2pveEhINU0v?=
 =?utf-8?B?MlBYczhUNjhBb2MxYkhrWXdOVHo2QVZzT3hmUGNneXZjaG1xNy9SNVRtVlhC?=
 =?utf-8?B?d0ZLa3U3Y05TV05ubFBESzJwN0VKZnkvdzVlOE5LUWVCcGRPRWNSbkxxMWdL?=
 =?utf-8?B?RWtLYW5SLzNHcUNzQXorOFlyazA0RU53ZXI2SXBvZXZ5MXM5K01yMEIxTyty?=
 =?utf-8?B?YmI4SDNzZVpEaDczY1FMUzJaaWV5eXZLekx6cEZFOVpvR3NmS05PUkRIOFdZ?=
 =?utf-8?B?a2V6Z3NlZzlYK2hlQjNOb1FIaDV2K0ozWEI4T0lUaFpPWXNYc0NCT2FPcnR6?=
 =?utf-8?B?SkhoeHpNY1JpdFdKbTBlZHV3WUFMMEk0aVAwS0FYc0JNLzI1VC9QZ0pFSkc2?=
 =?utf-8?B?NC9wNndkR3VJemVMZDgydm1oOUdmRmdzamJjcUcvcytyaWJkaHNsWk1VeWRX?=
 =?utf-8?B?ejVRSXhBcDdVRjVzaFA0dW1QandGUC9Nd3VDaklEUnFvNHMzcy9VbTZaVHNN?=
 =?utf-8?B?RW45NWdIMHRaT1g0cnB0NC9tZG1FbXZWMk1jcEJZemxOVXRUZ1ROczl5UG5r?=
 =?utf-8?B?MG93NjN0cUlqU3FTRlZranEraTJQbzN4RGtCNTVObGFSTDVzTUVFUzY2dVNM?=
 =?utf-8?B?dlBXd29xY0VFaUkwYm1GNVp0MitZSVVuVUhCMEVsQ0xycWE0TUN4a3pUMWdV?=
 =?utf-8?B?eXIrbnJJWGxkay9NTmxERjIwdnl4eWhsQzZXczFWbFJjS1J0T0FldFl5dW0v?=
 =?utf-8?B?UGNOMFBCczQ4WnJRdWV0a2FnTGxIYWxQWFlHejN4S0VWVS9uSFZjSXA2VWVJ?=
 =?utf-8?B?NzBUNzJMWGMzbVVIdVVMR0oyMy85T0NoK0RwSVpZRkljbm8xRDloNS9Gdkpo?=
 =?utf-8?B?bmtLSnRKNUdnTStoU1g4UEVOb2dWa0lYQ2dmV1o2YStMWkRuTlo1ZW5sclEy?=
 =?utf-8?B?cTBoc3lGcDhHb1JNYnVkdXdMV1lrTWNQN1J3OUhVZFoxNGN1TmFNbkV3YSth?=
 =?utf-8?B?LzZKc1JUNWxySFM3ZWIrV1E2Ny9IUjNUelN1U0VGRllaeEVuK09YU1o2UnRJ?=
 =?utf-8?B?R2p6dXljVnZzYmVTWDZNV3Z5THZWVzUzRVArNWh6NEdoaU9vbi9kbTYzNGUw?=
 =?utf-8?B?ZmtFMDh2TUZwNnBlQTcyYVdJUk9iYTk4QTdINDZZWEFIdVc1cko2Tjc5dnNQ?=
 =?utf-8?B?WThpOTg3em92b1dmTGlBR1cwcUdqNlVkRlhra2x2WFpwK2UyaDBjb0JEaEJo?=
 =?utf-8?B?UXdIbi9YR3lrWDVFQmt0M084SHo2M2w1enpVaEhDVnBlKzg0eDBsaThXRlFa?=
 =?utf-8?B?Z1dmNkxjbDV4T2NhOXlPVUFDKytsQlBBUVlnM2NmbldDeWRKcDRIT0lhc1My?=
 =?utf-8?B?K2ZaNXRkSEQzWXVCTkNsU3JZUjRUdjZ5L1I4ejdHNDRqRWlhVnE5MzhLZDhh?=
 =?utf-8?B?YUhKbGx0Q2JLRWljSGZkNmVoOUxjUnZ2NW40OWNMdVZZYXNlc08xc1U5TWNj?=
 =?utf-8?B?V3hGRnBTVTJPcExwd3Q1VytWTVB4QXBQS1ZFM2ltK09YZys5QmluY2M5OEZT?=
 =?utf-8?Q?TIPo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebd285f-6204-4dcb-03ff-08dd7b828fb3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:31:24.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBTu83cs+T58p/eJT6yBU0lh3qVWgvWxa63XaeAttS7q4Z1nW1iN3boMkK3z9SHEYuGDFWFbqOGrwoH8bi30Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

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


