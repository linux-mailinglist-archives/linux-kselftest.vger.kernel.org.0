Return-Path: <linux-kselftest+bounces-34506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D19AD2428
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83F716F81E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FA220F24;
	Mon,  9 Jun 2025 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gZSpfAAk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873A2206B5;
	Mon,  9 Jun 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486923; cv=fail; b=fkYpleb+bOHesUP6/AsSJXZ5uM1GoGf6xvYHA6wu6fqegofpqG+UeI/wL4EU53sKLP8h3uJjGeYgYV2uOo+KPD4TZKoIDByi15mI1Rav4tN9iHrvWfUe/zuHTeLcY3q/9Lnm80UaBXzFhC8jBHHxecgGgmKPHW6++ROFvpeJwyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486923; c=relaxed/simple;
	bh=u6PeQ+E4pLV4IUPib75on3phclu7KzXci5Cv7UMA7Lw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PEQcJySiKj5K84dcY7vym4yGub7+skRdAWijK/tORluSv0LE+SfYL/smmf6qxRYCkAcbTS35pI8oJepMzHSY9RnbuV65rsTYgySlrjB6hJpxgdibAN+3XJ3lozsPgwRscgvYa4OfbOwFPKjwijVM8cfpoMZDlndWweU9SnnO0q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gZSpfAAk; arc=fail smtp.client-ip=52.101.84.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdzNd5O6AOM55QZUBW+grgayKardF+MFbhmgQz48brwpkDh0V91AIisNGR9OHd/clfTCPO7G+P9HvDB2vu0TwXSAHDYhuy5pT2bqCHJ/S1k+Wd0apFcSHVHeJvN2X2N7htfRW4bzcIkvbF0KPyRt2iB3UowvRKQLMYw+LxnnKjVvgOSvh+53u3a9cjAX+HcmW6705zLHmqH4zgkkx3WlVY5ex0z9eIfCdqL/VZR+6c4CPjcmYSnQ6zjmeSDnRxece+UlzIVeF4LZS7EKnR3/meUFhsvoB2NMA6CLTr9ZL0DNpwbNUpaYUzNTB3lQGtuaBPfzozBHw42CSCZstZzH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLcL4vUWRfRvGnIfFwSRSx97iMB4Ecq8byfMn2B4AlU=;
 b=mIg9kq9WgbHBmv7ge9t8rx9Gjuzcy1peRKLESqn4dbtAHO5OdHnxqgJMtztEpsoj7N7okgdUE4jYQ133r2YP5k2sfvGKXs/jf4/U+amnj9j+3pKKksTfhdetiPoxKPJd3cIkr5Y1SFrum+bEB56Y41N22QUQzQY4pGYKXhO3N5CZ9TmfDvVvBsZkksIr6VI4PBjL/ZZECX++UCnCZ1rlpjP6GOtUuCx+lHrPzTKV2S/3aJsUjOOMa5g8RRgQT4xfmRFMDXBDrMHFH7usUmdLElLz9ZNLR5jBBG53OiN8QERSP9pTz+JXBCFERLZcRbPNGXnupFpLxS9v7RKR7RLaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLcL4vUWRfRvGnIfFwSRSx97iMB4Ecq8byfMn2B4AlU=;
 b=gZSpfAAkFpH1odXvtSR+nLdSZEn20ovlYcxT5KCqNPxkhDSIYEevBY6RlsEhc8ppg1hwXV2KZyJUS3dEOpnlaoux/PtKvEcavS/jfahFa1tZiS1gYB3JMNkhW5T9mNb2atEesSXzbW+R139sBRG1+17A+NuR9RoY2PIEoPZ50+raFvW3fkxY3NsgpULBxpCnLS70xIzyYRngCFrxa33VzpZKy+wr/Jrumw6BHFcUauo8HqdwNH0N4UmcgorHPn3nwrkPo54pRE54DNR7hQ5aBteCO1PY4wYBk429TQKrwj/7ThF2rK9oyWjGQhVXdagCShIeAd89MrcmZZEeaXxkpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 16:35:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:35:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:21 -0400
Subject: [PATCH v19 09/10] pci: imx6: Add LUT setting for MSI/IOMMU in
 Endpoint mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-9-77362eaa48fa@nxp.com>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
In-Reply-To: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=1488;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=u6PeQ+E4pLV4IUPib75on3phclu7KzXci5Cv7UMA7Lw=;
 b=MYX7SJwmLtl7IWeV/rjWRHytIKCfHYMpUKtE5oR9afnkKsS/26srhO03F5y36wLoLd3G2N+Zj
 MDPhCTyEyfAA9wP3XGLbYIF5zO7a0qLlOQaEoeAdWIqLNcKrvb8WQcO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AS4P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: f9987081-c058-42a9-fc38-08dda7739efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjNpRDlCYWNmRXc1Sng3dk5NOXowaUtuV1RNamxzQ0pCaUZHT3NhdmU1TWlj?=
 =?utf-8?B?Q1FOblNWdFRkSllmSnV6MVdRMWRNNEFMeXZOTGZaeVMyZSsxTmFlSlZjN21s?=
 =?utf-8?B?aDhLSTZBbUtVZG5JdU9hY0crRXNYeHhuS1VqcW41ZXhzVVlDVmdrb0VXYmQ2?=
 =?utf-8?B?cEdadXllTVdyblZyTDQxUEhsSjVqeTcyMHNpV1AxcmxtL3hqV1FvMGdPem1C?=
 =?utf-8?B?cTVyeHNjc1ZxTXJiUFBEV25GZjVlMVFxZ3RXVmQ4NDVJUmluV21IdXEvdVNK?=
 =?utf-8?B?eXNkd1Rway9NVmROOGxZZ1lLcll1OEJyZVNMb3ZvcjFhcDZxSldReTRpSEU5?=
 =?utf-8?B?S1pxNEU3dDQySmp0clFUempWemxGTGd3M2EyTCtvRXlFMzhQT0hESGU1MGVR?=
 =?utf-8?B?RmRPdE9DeDZhS0pmazhuNENHYTIrYjZBVjgwMkd6dUZ0OFBteEhiQ3lDMCtu?=
 =?utf-8?B?WDgzekY1RHMwSVZGS0tmRUpCdXRxSy9ranNzb3kyRm5UeXF2VkZuSE42S1Mx?=
 =?utf-8?B?R2JnTnlodkFNeHRFWldGSjEzK1RTZVNZMEptRHFUdnIxTXNMR2I1SmJwRXFS?=
 =?utf-8?B?L1VMSnNDQXM5aGEzSlA0bG9TczY1Z2pBdk1VQU5FcGtuYVVqSXRxMVd5N2Nn?=
 =?utf-8?B?d3c5U01oeVZwaWpQZUVydDIwamtrb0FDUThZcUpTWHNEUmdqRU5IMS9PejRN?=
 =?utf-8?B?Vi9uWWpTS291MTBwSXZUbzVZRklmTGlvNnVUNVlUeTg0VTI4N1g1SVpRdWYy?=
 =?utf-8?B?R1I4MllORjVzSnBlTjZNRUo3RWI4cUtodVpaVzZ3dndTUVhJU29mL293SkYr?=
 =?utf-8?B?cFBveGt5U3k2NGxOVU9iYkhFU296ZERFZE1hWGlKZTlnWTd1WldNd0FDZlRK?=
 =?utf-8?B?YU01aDE0SEVRazd1N2RxOG84WXFHcllTclFBZzl0Kzk0SkVXNDQ3MC9LOFVl?=
 =?utf-8?B?b0F3VitTell4dTlqMndrdERNcU1TL2FoSnZBN1A2eW1RdlA5MHpENklwL2dL?=
 =?utf-8?B?SWwxdVlvYUFYQzlaTUJEUlZlVzNjZEwzUXUxSXdRTzdydVhRcytsdGFsRCtS?=
 =?utf-8?B?dEczZE03TzdCOVBjTFA5bUdJQkxDWWVPRlJOV0tXT0p6dGlHMEhjZ0haNTQx?=
 =?utf-8?B?VVY5RW9xSmZuNlRlTGRoV1B6Ykg2MVdkNkVZcnNkSExKMkZETmtZVVhkeTlN?=
 =?utf-8?B?TVFJd3hoaUlsR0M0UklwSzJHbDJJK05nazkrNmdscFVpcEFmVjJoekhiWE53?=
 =?utf-8?B?Z0l2dEZ1U2RYSklOL1lQakxaWXRoMGkzeDlNcHF5Q2VhQ2U2ZU8wUVR5V2ZV?=
 =?utf-8?B?Und4ajhncVRGdXFHZjBnaitCODliMkxLcEVNQzRQL3JGZmFXK3lEN1FvZ2pL?=
 =?utf-8?B?T3owZVRBLytVZmlXNWlrNGdybGNiUTQrYnpHL2hScDRqWWVCTmltMDhSNzZM?=
 =?utf-8?B?NVBOWVNKckcyUjgxKzkyZFVFdThaUTJ2SzRrSitsRDVLNGRQQXMrUGxMbDNs?=
 =?utf-8?B?eWYwZDMzVElsT2JmMnJacWtQa2NRam1wYXczMi9kVUxkRDhBbDlpbmpoQmcz?=
 =?utf-8?B?K0xLQk5zSTBUYXR5eVVvVVNGUmNteGY5bVNCMEtFbnFXa0V3YWRiVDZORy9J?=
 =?utf-8?B?L2tkZ1VoeWxKeWRkQjJvZHFRTUhVSXVyYzdwM0ViaWJYNWZUQzVsUUNQaHNs?=
 =?utf-8?B?Rm5uY25kc205d0tjVkRHL0hwNnM1cFh2TEJROU1zY3Ruck93akxaejg3NzQy?=
 =?utf-8?B?cHJRR2tWUkJkVjNaRmZqZko4UVdUMWpONEYvZ0tZUjdncUdjU3hqb0pEUVo4?=
 =?utf-8?B?UVBxMy9HZUlLRzB6NjNTd1dYNTkwUXE1WCtXYmliYk8rZHhJSnFkbGF0ZFFV?=
 =?utf-8?B?R3J2YjFZbGJuaTdFRXcwa0tWYldadUlKQm1WSG1qc2ZiQlpCZjEwTGlBQXRE?=
 =?utf-8?B?UkJtblFHNEJPcmFIdDJNM0o1OFV6VmlVM2NtRUlWeHBDcng4cEJQSzNZRkln?=
 =?utf-8?Q?LuY6XoXHvDEu54YkQnRfkvS7/5uafI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGJ5M1JzSTNjS3daZm5UbU5QNU5rZ0FaWGlVU2xlRHZUWWxiRlFJZ0NqMndu?=
 =?utf-8?B?S0liQ3JsVnhCSFRjS2sraVR1a3ZOd3lCdHBBT3E5Ym4vT2pTZzRiUDFVQmN3?=
 =?utf-8?B?S1pOZWVyN2R0bUovTWV3bWlySGFDelpKcjNEbEhkVTYwK3ZSMkV3TkpvRlV5?=
 =?utf-8?B?U2hUak1qUm1qWk4yelVIcTNPWFJhQVFPbW5mMlRzYmhDWEh5enpzeVF3TDVS?=
 =?utf-8?B?Z2RHSVJMSmVXMmx5emdDYm5tVHJjcnN5N3Nud0s2b2RWTHl5bjRNVHNHZTN2?=
 =?utf-8?B?U09PTnN4KzM5azNaeEVhaCsyemMwTmFuZi9uZTRPaDRKUThKZWlSS1RIVmRF?=
 =?utf-8?B?MENZYlRYTHh5OEpyVmJmbnNwSHpxNnc2RklmT1BidisyU1lENUlOczB0amp4?=
 =?utf-8?B?YndabzRINXd2QUpRMlU2NFNOeFh3a21RQ2lrdGI0d0ovTUs3TGR3TThaWXBI?=
 =?utf-8?B?eVNvMU9nT1FzVUQ5V1pXaUhPekhaZHByc0x3c2NiZC9WeS9LaS9RazlONzNa?=
 =?utf-8?B?d2tOUmpZbjRReGRDTGxKZ3dwUnBpZFJpaWh4akZHQ2VMaC8xV00yMkk5aGVy?=
 =?utf-8?B?NTZ4OVd5ZFVYdmVwZ0daSzBiMFNvT01KRUdzVmRZdjFhaDVjQ25PREFHQkh2?=
 =?utf-8?B?SXlmNjNWNDZ0dWlFZ3hmTU14bDNrNi9YeCtqT3VLVW5CN0Vldmx5WlBSWjdH?=
 =?utf-8?B?N1F5S2RrZUJCaktTeEFPZjRmK0QxQ3hnbWl5S2dsb05IVkloSjhjOEFpOXoz?=
 =?utf-8?B?NVpDVU9WQ0hSZTZ5M0hBa1dWaVNmbzNOTEhmMHhWVkp2YWtVWXZPanNvK0VI?=
 =?utf-8?B?cE1yUUVnYWM3Wm9aRmRCUURWd0U2Q2xxSVNNVkhaOVJYUUVnS0Fxa09KOExZ?=
 =?utf-8?B?bitsK2VsTmZ4eDBmbnJveVpqV0xqb3FyUEFLQnh1WjJ4UTBsb3lpZkcvNlM4?=
 =?utf-8?B?anY0NTFzWC9hNDFkdGYwdFdMNlpkM3doOHZjNjArd2pZYVhtdUpQQmNoSDlR?=
 =?utf-8?B?ZnJHZUQ4OHpkSlhqaDd6cExyemR5VlBvcWs5aG5rbTk4UjM2MEhzUk5BWVFx?=
 =?utf-8?B?Wm14Nk9yWHRiVmx1RExFR3o3eWJuc1RudnFjRGh3UjhaZUUxb3M4OUpUbjh1?=
 =?utf-8?B?UGhBN2RRU0RnRXg1U3c4MGQrME5MR1FrS2FjYitWWkR1OWdtYW4yZkZLUVZT?=
 =?utf-8?B?Qnc1WHZPNjljVjVIN0gyQmdVMVMrcllxbTZlRmtUMk8rSnZpbkFZekNkR3Rs?=
 =?utf-8?B?VngyQS9Sb2dtdUhOQnZPTWdDUktBK3RDNkVZYjZ4WW12c3d2QzdnRzJXOGVC?=
 =?utf-8?B?WGdRTWN5ejRYcU81aDBWeW1KSzdtQ2EzWTNneGhhVzJFalk1T21sMUYvbjZP?=
 =?utf-8?B?VTZCMlFhYmJMaHIxdEk1QVZ1QzJ4RHRieUhKUHpJNGQ1WktzVkp5VCtjenZB?=
 =?utf-8?B?UXFNdGIxVk16UkFjaXNSdlc5ZkVCTSsrMm5wc0JmSzFBUnJRZGR3Uk5sTE0x?=
 =?utf-8?B?V0ZyU3ZmN0hTbEJ5NDlWT1JJb2NXSDlpd1BONXRHcHVDaG5HUjRQYmJVbkpt?=
 =?utf-8?B?V1JDMWdIU3VYYnRLTjAyK2UvT0dOcDlHNmhHOGxqV2pFdERiY0JFa2NFQnc1?=
 =?utf-8?B?dkhidlUxRXh2dkdyeEwwMkFZWGx2UXpyVVdvZVkxbURtZlRLRWZVMVoxL01y?=
 =?utf-8?B?bXplbUR1Tm5uRHE1Skt6d0Jsa0tGTDdqTmtKNVNINkNkSGFzUE1QaS8wNVU3?=
 =?utf-8?B?Y2xHTnk4bHQxYkpZQ1p3T1BHT1hBWHFKYUJyelloVjZicVJzUjg1RVRKbkR0?=
 =?utf-8?B?V0NHRDNGWEppa3dYT3hNTDZyTHZQcEJvSGgwYkpCNU81WFJaWHFXZVpKZXpS?=
 =?utf-8?B?TGZRWUJWMVVHNzRCZmZXYlBUK0ZPMS9CdnhBVVlPa3ZTdmdNNncxbWZ2dXAv?=
 =?utf-8?B?S2U5VFA1WlpWT1pBTnFtQW9rMU5ycTUyamdyNHVkTXc0RUNEYXM4cC80bFVj?=
 =?utf-8?B?S0hWL2lrVW43dlRMLzZHbnZ4cHJUbWF6eUlPd0s1UG8wakhaTms5Y2xiUzZw?=
 =?utf-8?B?VW9NdVFVZkZOZFlMcXZMVlhicDNjWEtUQW95ODkwbWs3eXJZM2lKajdDdTlI?=
 =?utf-8?Q?rLWV9FEBUNG4vpzRzz3f2hFQv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9987081-c058-42a9-fc38-08dda7739efc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:35:18.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3MKv5cqHq+ri49s5+Axq93wSyHjMEYGTsImneen7uOOcHNmnGClPEWRnTp8rlQNeC3iw0xK4CSOrw+nQ17LLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

Support only one physical function, so call imx_pcie_add_lut_by_rid(0)
to add a single LUT entry when operating in EP mode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 032b906c44dfa..3123bf49e209c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1063,7 +1063,10 @@ static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
 	data1 |= IMX95_PE0_LUT_VLD;
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
 
-	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
+	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+		data2 = 0x7; /* EP side's RID from RC, only 'D' is meansful */
+	else
+		data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
 	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
 
@@ -1767,6 +1770,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
 			return ret;
+
+		/* Only support one physical function */
+		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);

-- 
2.34.1


