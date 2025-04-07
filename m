Return-Path: <linux-kselftest+bounces-30309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282AA7EE42
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543F917B05F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB09254AE5;
	Mon,  7 Apr 2025 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gPL/8AG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1D254875;
	Mon,  7 Apr 2025 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055505; cv=fail; b=HMy60KV9qpXFEK+Ll20gaqKW8nV8Dz6yETQvsAXjNvTN9d65ATN1ZhmXmhCdVEaTmHDcwUnI2GcGkemEObsuAbciuR1DNnQxfp98oHVDQ+x7D9qc3RsyAyFmYkv7yhbg8j8bUgaP7GeFAzP3NAGs9fuL53RwYgK8eODaSkRymYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055505; c=relaxed/simple;
	bh=jis4uAlk2Y8+00RUPuARjfibBzjm61NUigLnBik7ARw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D9bTvUCnPLNt+hrPJTISnxYfbxwg/qrlWG6ZI8lTqo5w2BAMM+Pfp43E83jkCDil+bICLtyCGoIBMmFbV5DLy6m1nV4y96537X5HmqMrbAXGgzrh13iJrObcZ4x+0YmGR4xmAllR1fNSbuQWZgIcVYzJqodWBpw/qDAmAj4LAwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gPL/8AG3; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOSh7mgP8yUnB7MwxZr/2GAGlH01Alys+e9xxRzIwqW8pJemcdp+34UW4VA2c7TJBeR96drsOBv7+LcS29AZn56v/VIP8RPIc6ToERfdUfdUp2dZjCI7Wc+21tasX5axXybeOk1Chndv5XX4qlDRUHeHKVmcy8dM3rAaf6tRyxAAup66RYFCsJ/uRqoxj0b1OQEMej9yt8bJeQeTkzBRvwJUVZOaEFO0cw4U9cRMKDOcmDCXwntlrFG/jbIn+haN5oXNPNR3aFHPpP7qJMoWTpi3JvykeJMfi6JIFd71PSa7zCrWQ8S5BZGVqm8VEPKN+sv1k99lC93eoZAFfzaonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGHcDy0qLXRPv9bDtIJ2M7IEz1TWHDvcXEwtams7Bbg=;
 b=eB0b4pfmwS2vNCnb8PYRL0Ppri7QBIWbw/tYJLF5fMiKitbfodzHgb0wQTxg/P0+7vVUcBv3bujzr5hmxa9+bhRA2wBAydT0yph56CHIyMtiQwnpEUZIN7UZQoCs3xryDW0GZLczHaEAcGK8lbB0WC5/MVvp7wTqoKSYuNt7AEF66ydMqqleF4NoOM+oaYKPMyYzxEO1xfoBgbmBimlcwLZ1vN+ZQzNTCHKOyB68QGtEYX1CvQ+51LppNhZTgdtg7UjUPPWYEzGgPD6fVmsCNA+QYGrQRATrOvRvJNMDAAR4Lnf0MrcuWoEqKSCVv/wVZa++JQRhqwkQXZZlf9ayGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGHcDy0qLXRPv9bDtIJ2M7IEz1TWHDvcXEwtams7Bbg=;
 b=gPL/8AG3Wp3e3qhbtN+HUY90yYJb0NbGH5dnCC5uWyFDSipMt0sNp24au3VVwTHBermaUOye90RS7N/0U2pEWRFVgHQWcZXXusxcYRZLV4YzrX8VMx4PBAotGcrX7Q3vV2YmqoOCQWzRIGZuZV1gDUFyuKZS6d2HjHsPvdciJk7AIFniGTUoBekDEkK9zmZ/IAGH4GXWJZYs4bDuOXY7lnMXD8wBi/8Ewyt/B9ePF4nzVfEXyS7LU0hiOsvG15pKOTL548ed5PB80en67hkGEMVOhdJSBLHZJNPHE6JuWUoc/d9W1zRgxKEvKiZd1zQVeUCVX9sArVQi5Li2wzMGfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:51:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:51:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:50:55 -0400
Subject: [PATCH v17 05/15] irqchip/gic-v3-its: Add support for device tree
 msi-map and msi-mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-5-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055468; l=1711;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jis4uAlk2Y8+00RUPuARjfibBzjm61NUigLnBik7ARw=;
 b=iI9pwtljBuLt5jIUX+ZiQVLS/Az2zUc43cUiYGvdxPHQqUiPYE96L0dFFJM6hMF56AuSdFiV6
 Xp5R9HVp69/Dk37YPzvJqnG7sp9relzlf6xlXaDke9NP02aSuqcd/u5
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
X-MS-Office365-Filtering-Correlation-Id: 4cafad40-d60c-468a-70f6-08dd760d9d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkxvQUtjNDdtMHo5cmdVQ2ZEWHlIZXU3VTNva0wxa1JnS2J3amljTEplN0lN?=
 =?utf-8?B?VWprVDRZcG1zZWM5R3dVbFVNY2J4MXJDNEY3dCtNbXd1Um51aU5WY2dhRGtC?=
 =?utf-8?B?T3dFY2pYOEo3WUlwWHRvMmtqM2t0Nm5OT1V1ZkFLVStCenVZNmExdXo0NXhY?=
 =?utf-8?B?S3RsZmVCMVVqK2RGb2Eya21meEMxSHl4T2lVWFR6bU9JS3F4WUlVbnlyeCtT?=
 =?utf-8?B?WFk4V1dMeU1HUUpyKzNwNWY4aG5MM21CUExCQktYb2VWVHpNOHB3WGhsVGY5?=
 =?utf-8?B?czNBQkIxRDR4TWEvMysrT3l0eXowMkF0SEUxQklUb1hpVW05bTBySjRvRGhD?=
 =?utf-8?B?UUowTDFwTXN2eGgva1JMbmZvNFRUcWdnM08ySW1vTG8wWDl2dGk5MkhaTTJD?=
 =?utf-8?B?TC9EOFFneXlXQ2pXbCtKSEtDRjlCQXVPQjN3RXI3eVNhaGFZSXdOY2JNYjda?=
 =?utf-8?B?b3dqOSsyYXZCQzJXTmJ4dXJNU0oybWJvaTNlWnBJaGRYazNCa2JWaXVYSWtL?=
 =?utf-8?B?TjZOQlJEMnBLbVhKb1lHT3EyWFBNZlIzMGd1c3FMbVZWWWtNSE0zNlNqOG5R?=
 =?utf-8?B?VXVRK29iMGs3UTVKN1BNcU5ieWpwblUyYlN2U3BXMExmMzVZVXdmbWdJTS9E?=
 =?utf-8?B?YTJFWm9vSmxvNHdxTmxPWVNnVWxYNlhoakl2Z0ZGNVZEVkpJUTRSUkovNVJn?=
 =?utf-8?B?c0RBYmt5RnZFNitoSTM2ZHhZeHV6eGtmSlo3STBIeG1qMHRZYUxxU3dFTHQw?=
 =?utf-8?B?NW82WWovQnBMVWMvaFBrT0tCczUzQ2kxcFZwaEkySlVpcWh6SENqcDducEZQ?=
 =?utf-8?B?OGFtbjdSN2Z2YWxET21NZWVZNE1UbFcwM2dFaUFlWW1ydmdUMXlmeEVkaGZo?=
 =?utf-8?B?OUx2UnpaOUVSeFByR0NSemdXMmZkbmtGdEZzRTJwOStQRS9VY3p0b01qcjdT?=
 =?utf-8?B?QjdTVHJQVWRGWlhMNktiYStHUzRxZkRkNGxFajkxZFQ1WGVldW9KdVRzdzFl?=
 =?utf-8?B?OStCU3dpRStCMFA1M2M4S2FLN0NoREJTWG9HazBlYjNtSVlBRHJDRGl4UnZ6?=
 =?utf-8?B?Y09QMWlSai9Tb1dZK05mS0pPbnUyc2hjWkt6ZklwWEJoSE8yR0tveS9YM25S?=
 =?utf-8?B?Q2ROUjNNN0JLQXVLaU94QU5KQjF1SWVUL3BUWFB0U29taDZzL3djU0QwTnVv?=
 =?utf-8?B?Skx4bFQxcTlPako3aHdGb2tIWkJndEJnVHZaUXJUSHI2Ym9NUUhuNUx2em1L?=
 =?utf-8?B?bTlhSWkxb3ppOSsxNnYrOWNKQ3krcGFQaHF3dCtkcldwY2ozQzRBWWl4QVFq?=
 =?utf-8?B?TlhyNXd0RzVyVGpVVmNNMGFhWXQwNUdoWkNWaWs5OVlkcHl1N3M5dVVoeWNT?=
 =?utf-8?B?dlNuM0p5UWhqakR4UERaaGd1RWVvL0t0NTc4V01oUE5LVzhyaVhoMUNNOEYv?=
 =?utf-8?B?b0tKdjZ5dG9GY2hKTHZFbGcxN09aSFdSeGJtU0xZQVJTZnprbmhUTi94TzdW?=
 =?utf-8?B?aE5DNVBHbkxoZkZVUXlZNWF5SWc1UHZRUzFUa1dMZ1JFUlFsZnJnL0xDeWd3?=
 =?utf-8?B?NW9JTG1FcWYxOUNBMHFMK1lqenNRQTlHYkNyMU80WjVlV2Z5VFRMdG9halZG?=
 =?utf-8?B?RDRsZVo5UnpHQisyaURnaHFmYmNzWmFkck01cTVHbDEzallxRTJtUDJTMDBj?=
 =?utf-8?B?TWlOZWdyLytxVFREWVV5T1B1V3BYNGp6SXBrakhvbmkwcFMvNTF1WUVCcVp2?=
 =?utf-8?B?ak1ZWFVtNFoyNjJNMENjUXRwNGFWeW00QURiYlFUaThDaC9FRUdnY0dadzlO?=
 =?utf-8?B?OGRBN1dBZXpUYzMwdlg5b0VYNUZ2ZGNQV3AvMVp3VzZ2L3F1T0JENHNjLzB5?=
 =?utf-8?B?MzVzWjlaWncyQTd6djFxYWJERmxQTTIySHM1a3NLVVlVYkM2a0h1Njh4MVNx?=
 =?utf-8?B?S2JXZXlnUVpLaUF0L0R1Ym9FMklhYXdWQkwzMzJhVllVYmxVaWlIVWlGWnFI?=
 =?utf-8?B?RExRVlNtOFFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFJ2cmIxSmdmN0ROOUdBK3Z1bUYvbzZqUVRNUjhDMkxGeU04L052NjI0RTNB?=
 =?utf-8?B?N0MwQnQ3NUdtMTJiV0lzVWQzZVZGYlV3djcrQVBSeWRzdjA2dlVTWXN4Qm9E?=
 =?utf-8?B?bW5FM1FOZE9kL2VnZlpMd0M0ZkxOTGRra0ExaWdVaW9yUFpBZXQ4cVNkUUdL?=
 =?utf-8?B?NHNsVUdBRmg4UWVsckdjWnJyOTBRMWt1VWpZQTA3S3ZNdDBLOHlIL3A4Vmxu?=
 =?utf-8?B?VUpNLytDNFhtb2M5R1hNdUJ6NXY1a1BGemgxQzlreW5wZ1JmdUVaNDRhcko2?=
 =?utf-8?B?cE91bUZnYU9WSXpYZjlBeVdvZ0R1R0krNmx1MjVrTnRHc3kvZ3pNOGNPS2pX?=
 =?utf-8?B?aVgzUXR1NjU1c1VUdHBIS1hCQXlXRjhZZ1NRRFRQbkNCYlliOG53a3NqQy9Z?=
 =?utf-8?B?bXdTTlU5b3VQWUdhZXZteUMzazdTMmhQdTA4M0J5N09Db1pYbnVGNlV3dWQv?=
 =?utf-8?B?eUlOb0IxaVV2T285ZzdxWGFYYWpXWDErRnNoRit5Nk5FODR6QTd0ckhOY0JX?=
 =?utf-8?B?K09uNkcxNWViYkJFZFRPUmR2MUhEZHNEYXVNWEVpZzZBK24xRGVkVGt6aWY2?=
 =?utf-8?B?SnZ6NjlvWG5WRHd6UnFkNkJoMDBnc3JQc2RpYXNBTDVUZ2czVGxqUjhRb2xu?=
 =?utf-8?B?UkZBMUZqMmhXTkJMT1hGRXBKb3JWY3RCblpBNEZlY2svOFlJTS96SzlqVnBm?=
 =?utf-8?B?eFBHMzVvblRmUUNDajRzOGlFVmpLK0puQ3MyckNHQzJacFpDdDJ6SnhOWDhn?=
 =?utf-8?B?Rk5ZYkNKZCswWVZFSzdiMk56ak93M2FQNHhHeFpCWEVibmQwUUkwMlNrK0lO?=
 =?utf-8?B?WGtyUGd2WUFteEpPQ1RmZWh5cy9HVXY4bWpKa0UrQUxOUlV2WGppMDJPTWZ1?=
 =?utf-8?B?ajM3T3pJbytlLzlRdnZFakxybzl2d0pmbDZic25XRkZXaGtnVFg2TzZldjgy?=
 =?utf-8?B?WFZ6VEoyOEZ1V1NQaUJHekZTTFJML3dvOS9RVzNvQU1IMU01Z0JjdlBzWE1T?=
 =?utf-8?B?SU41SGxrYnNTeFhYY3FyYUxFVjRrU1lqbnp4cVVlQWFiTkdkSmhVS2Y0NzFQ?=
 =?utf-8?B?b29GaDZiVFYzR2E0dkROT0tNWHVOS2h6R3YvcWh5aDk0WmtLQVAwQk1uUHpI?=
 =?utf-8?B?NThkWXYxYWlFL3NIeE84UWw5VDJwRFFYU3lWSzU5bjdLaVlobnZHZWh2VklI?=
 =?utf-8?B?UFlhRFhEQUdDU2FRTUY4U01SWERPaEVUVEZwZGVSNEJKeW9aZzduaHduTTNF?=
 =?utf-8?B?M29JMEROZWlDZFlEZW1DOGxvT0YyTGVlMVdXa3EyR3ZwVjQ4alpNMXNyc2pv?=
 =?utf-8?B?b0RVNm45VTc2bGtCVEtCTFR6Z2h5VVBuaFRBeUhoRitZcENhM1hMMFdRYWFD?=
 =?utf-8?B?YTd4TURCNGhMRGE4Z3Z5MkhCeTc1WjArVUVYMENBb2ZHbU55Z1B3dDFWNFdn?=
 =?utf-8?B?VUtJT05PdlBSU0dSME9PUkVFeFV1ZTROK3YwV0t6NmNTN0ZkYmFqSHpmcHRG?=
 =?utf-8?B?ZU5WMVhtYi9SOXNOaFJadVpmcW4yQU1Lc3A3ZXhucEpGUmdNd3hyVytsWE9P?=
 =?utf-8?B?NTZ3NlNOMzJSZDFidDJqU1o1c3VmQ3l4Ym1MZklqZXVYaE5YdUJhQ1hFTElm?=
 =?utf-8?B?bFpPN0VBUjA1M1FFbStRU2NGSm9jZTN6OGt0Vm1KZlhpanpWQmdFY1Bqd2c2?=
 =?utf-8?B?cFIwVy9mQnNJdFRkS0hIYTdXZldQQ3ZVL1B5UFNFRm45QzlvMFh2U1hJLzlI?=
 =?utf-8?B?QmFDU1BPZ2JwSnM3WTE5V05Ga0szVndBNnV2YUJkRTN1MUc0b0xmckFoUVIv?=
 =?utf-8?B?Y3ROak9zM3Z4R3ljYzJLWnM5Y1RQOVU5djV5bllYam0yU1ZOeGRzQmhhTFlq?=
 =?utf-8?B?MDdHSjYzNHBjN3Q2V0RyRlI4ejUwcFFmU1kvdFRvYU5hOStweUhVeVgxQU5q?=
 =?utf-8?B?ZXA4Vmw1WU0xd2dBbzAyVXhZWXdySGZybkt2UHFCWUNUeWNNOGpyT2lYY3Fo?=
 =?utf-8?B?QlF6RHFvVjlRVWhtZFpLUlI3U251bGRrdWl1TWduUy9MMFRzeDdzM2p4a0pI?=
 =?utf-8?B?T2dTaHR3T2lZMzl1RG9FbUtEUnFWQTlzTUk0ZCs2WDFrWHlCOXQzbVlBem9N?=
 =?utf-8?Q?Z01TmV+wzxNTaoB9P78lrpW71?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cafad40-d60c-468a-70f6-08dd760d9d3e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:51:40.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E14KVPTbC+Rr44E/Ac8QVTxfWTUcxaSCf6bTUgLNLb66xjNpgRkQVXbd6DJwhOLpsi2EgxdKNhY1NmePCOvytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

Some platform devices create child devices dynamically and require the
parent device's msi-map to map device IDs to actual sideband information.

A typical use case is using ITS as a PCIe Endpoint Controller(EPC)'s
doorbell function, where PCI hosts send TLP memory writes to the EP
controller. The EP controller converts these writes to AXI transactions
and appends platform-specific sideband information.

EPC's DTS will provide such information by msi-map and msi-mask. A
simplified dts as

pcie-ep@10000000 {
	...
	msi-map = <0 &its 0xc 8>;
                          ^^^ 0xc is implement defined sideband information,
			      which append to AXI write transaction.
	           ^ 0 is function index.

	msi-mask = <0x7>
}

Check msi-map if msi-parent missed to keep compatility with existed system.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v15 to v16
- remove ascii figures in commit message

change from v14 to v15
- none

change from v13 to v14
new patch
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index bdb04c8081480..68f9ba4085ce5 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -118,6 +118,14 @@ static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
 		index++;
 	} while (!ret);
 
+	if (ret) {
+		struct device_node *np = NULL;
+
+		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
+		if (np)
+			of_node_put(np);
+	}
+
 	return ret;
 }
 

-- 
2.34.1


