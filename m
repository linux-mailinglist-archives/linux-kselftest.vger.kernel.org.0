Return-Path: <linux-kselftest+bounces-30749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CA8A88B3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CD117D9E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ADE291178;
	Mon, 14 Apr 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TdUFkipz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2E291169;
	Mon, 14 Apr 2025 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655509; cv=fail; b=KF8aLIt+oaLXmFaioyl9BZFlzuWC/J9AlONHhkjm7EoUV/05sJU+qBgkIrCnjXu2Fa7tQ2K9ovUu6bjPfDutg9Q7ntJCRLPSakkZvejF+Z2hBL4lOfApHjmD83M61cW0YJ0UX097gTZ7Rh764/wBW29C854/Xjn6utUnS/3T0GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655509; c=relaxed/simple;
	bh=jis4uAlk2Y8+00RUPuARjfibBzjm61NUigLnBik7ARw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sa1M+ndihfpbXNUesX2RAvTl/xCzQCvqq9NAmWVqTGOFmQmxsFEcvV3P32yCuhMzKzbSE9V9kwOlaoyz8cMMViUYoRg86g/sv7hpjVquELWmcWTWtnv6lC4i1oT/rHnzlWAl6XHbbI+9hlDsB/cCKmzmaFgVyfX6iZXdFjD0YWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TdUFkipz; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7AqabQtKmm7CRymhR4AAZwy3MNeV99jwET66TdcXORTbxnVinSONzUA+8EKVenrB/DgakmnJZXm+/ic7DHzCAvAM2Sah6UX4ine4gUWzrLWQh4HNsYbQd41ISht8itfDKQADXFdBhZ1/fP0JTD8kvad92IX3RiWARqe0wEmayPsZIAVgPOBgO3R3mI+SBZ0EYh5oBkX8CmOPurVsQ6a/E1GwOTkB7AQQgWSziPYKH1d4UDcreb2FfnBn2Y+TW7zvMZnc0lS+0oJzMvZKvQoY2ZPR73fESM1Hp5xWa4veUveHwzSnZ1E17xLgUTiN4IYUTHN8IC1q/CXirMY2DA9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGHcDy0qLXRPv9bDtIJ2M7IEz1TWHDvcXEwtams7Bbg=;
 b=dols7QL8VPQwAHZMSgRI0VWGKrVOm/icboLF8Y0X37Oqq5V0z2FSadsIqar8I72WqNeJyef9GoKuw0slK4xh0dOrgzn1r2TQ0Wvr4UY7BZTGZt81rz6TEYrOun2YZCuvjPOZ3L57YwvB4gjKMkEM3EzP/Bz3l9+MMFnQrzgHtGn1FpibUqHKHRbTeXcwJPcyubVlRAPKiJbBuNWcr1Jxw+TP7SXC/lBEtjI9eOWPB6nkcanNhfQvAK1qanocNXgdmQ98TWVkssXn4Jm9ABlJg/c/evpVXk3Lse82KzGpPeTETixcplFX/N/yuH7kZ8GXj0oqRyAZ8ZfRT+wPgtYAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGHcDy0qLXRPv9bDtIJ2M7IEz1TWHDvcXEwtams7Bbg=;
 b=TdUFkipzpSanNCXE7xZFibe45kurcdiEoqiVsJdO2hMhD3GoZVl8SKpJMabW9IYP9LELP+cW70kh/lYAy/LVfNMUYuGVN6mfbEcWWefvVI+bZHrgDGxmKqq/0HPjmvi05mqK3TGjvZQdcxv/JlFqX5PzY1tRYQaXl85gkPSTQuwrr33fRRDmh1jCvPfHo8D09JNVOn29G+rZbYZByis5NgIRaStrbfWF3rrKedBePKQ+l9eDgOLPNKTv/FqI0QvUteEYrujQcr0zWvfWYAjQvKiy9vn3a0fxu5it+W6J6qkEdWO2d3hDsxuqRHwJcXkiQDJuXEMObxjrR+vofJA68A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:31:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:31:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:30:59 -0400
Subject: [PATCH v18 05/15] irqchip/gic-v3-its: Add support for device tree
 msi-map and msi-mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-5-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=1711;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jis4uAlk2Y8+00RUPuARjfibBzjm61NUigLnBik7ARw=;
 b=M169c5a8igsdcHqV1CjIUVQEpAB+ONQ1dje9iaO8DI/KlF//vdcpr1DEez81JPyNcAQuly683
 TGQpno4ameOAmMeMtYsXy94LVG92Af3/pgRaHei2HrbjWsvWmaQt8YB
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
X-MS-Office365-Filtering-Correlation-Id: a945349a-0f41-420e-27bd-08dd7b829b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm4wTTRvUDVSMlpmUFplNW1XTmlDRmtkYzlHT1VpYmFvK09CMU1BTElubXVJ?=
 =?utf-8?B?NmV4Q0gxZTR3aVB6Q2RaMS9VbmFtU3J4MDg2MnVOTnBobjhCL29TRStJQUdz?=
 =?utf-8?B?d2tHNUVhTDJtL0hsbW9hc1VpTStxcUswc0ZqcUJaZzRoUnVBYTI4Y1Q1UUg0?=
 =?utf-8?B?eGpvZGIzdEhRMS80L3gzaWdhaThPaUdObG5kcGVaazI5c2RQaUZwbzJmTExy?=
 =?utf-8?B?ZjVpRE9kOVlrMVR4QS85NDZJVytVMnRucGxwb2RCN2xWZmI0SkJwa3BrMDdC?=
 =?utf-8?B?VlZBV2RJa1VsbllHZkc2Y1JlN1VDUmRnQnduYXpzY3NmL1I4QllxYSt1Z1FN?=
 =?utf-8?B?a3R2aUY0K2VXY0xORlR1bWFQVXpweVBnR1Y1d1BuMUZXbkpzZUtRREJlVU5P?=
 =?utf-8?B?SkdLR3BZV0lpam1JbDAwVW5uYlc3TGlWQkdpWm1YSzFJZzZtUlRFanlsQWda?=
 =?utf-8?B?MHhjb3Q5dU5MRitxSXhTYWs3bmZWNjNTWm9UbHh5TDdueFpDN3BXRTlQM1Jo?=
 =?utf-8?B?a3RPSUplR0ozS2JFTG1XRlN3NmVmM2FzV2ZRcUpjVmxmOStPaktDSE96UWNB?=
 =?utf-8?B?TjNUOWtWTzBsMnZOL25oNnN2SVJRMHV0aU9aK1JTeFVXQ1hERFZ3L2EvQUpB?=
 =?utf-8?B?ai9XV0Z3eC9xQjkxM3NVYXdJZE5TOGNFS3c1THNCd3JUSlV6TDk0and5N3Q4?=
 =?utf-8?B?ZkJteWpDTmVnZ1VZaFhLZnArVzhVSTlEeTNTd0FiY3hZYlNFODg5ZjRkYTBX?=
 =?utf-8?B?eHF3a2FFWDJyY3k4OC8wSlZ1ZmZ6TWo3U0lYaE9JTks0SnFPb0ZwUWRpNUNl?=
 =?utf-8?B?VGlwTVNJam9oNmpPVG1hcnpiaTFhRDdmRkhZcTc0NFBkTVNsakg1TmZMMU9H?=
 =?utf-8?B?RjlFZTZVNyt5d0dQQTB2QjdONzZnYXhYVTNnU0lFN3pNUjB1Mzk1Q2tPRWM4?=
 =?utf-8?B?cUxLZDFHRnRpVE01ZjRnRURteU5qSGVlUUd4RzJrMDVVLzJWUGhQRFdjMmMw?=
 =?utf-8?B?U3NHRGRTc3F0K3hXSGJ1Q3pLdjlpYTROLzBNRFJGUlNlcGw4elhDbHRtZHJ1?=
 =?utf-8?B?OEJQWHY1OHZRN0paKzdvUEQ1VnJ5LythRVlPOVBUQWRoa1FDSmk5c2M0TVIw?=
 =?utf-8?B?Si81QXF6WXBvT0RZK3Y4WWxLSkwzbDlSYVlaVXZmM1pJeFlYMG5qNUZlN3lH?=
 =?utf-8?B?R0NrT0ZQYTFmMU1lYmhQTnl1Zll3Z3RqVUxadXA4cS9ieW8ySHlNRExJZGhF?=
 =?utf-8?B?VW90V2J2dUlrSElEZERvbW5NU3h3bmFmQ1IxMHArbjhpUDdMZ2FqVUhlakZT?=
 =?utf-8?B?QldpemlwVFpER2d0Q3NRN29aUXBmNGdFTlAyK05KYWQ0c3RVS1lhYmh4ZzVj?=
 =?utf-8?B?bDkzTDBpWkRsZHpDQnBJZlF1Mlo4WndVVzk5TC9Gb3Q4UTgzQ3lRRnpqVjcw?=
 =?utf-8?B?ZXVBbndjdjZONjBaNmF1ZTh5WUh2ZnNwTUZ5VlMrcDIvUWlIWHpja00vOWZl?=
 =?utf-8?B?MlVRemFUM1lDL3RJaHZzQnJqVEJNV1pYcWF2S1B4ZXJYQ0VuN3lUQXBMSGFJ?=
 =?utf-8?B?MGZVMmVHMThVSXUrUmhyUWFKTC8xU1diaERUdkF1bkVLUFNJYk9XbWZzeWhk?=
 =?utf-8?B?NVZSOEZNcXUwUklaTUtsL3NxdTBXWGlMbldNUDJaU25UaGNLWnFtMXcySHda?=
 =?utf-8?B?UFlyd0g1NmFRVlBrdGd6ZDEwQTRGUCsrR2lHRmJ6bXRVNXdxeTZRU3N6aXk0?=
 =?utf-8?B?WUx1NWlnNjRKQndwV1d1dUZ1OUUyYnZmWWZTbmthWUJOM0o1ZG1yWklrTWxQ?=
 =?utf-8?B?L2JPWVNsL2Z5bGFWT1hNVVdaTW1IaktDWEg4MEI1d0p0YVR4QWVsVDdrSk45?=
 =?utf-8?B?TVlucjB6NVJDOHBwQ0FpdzdsMkx6TDN0S3hXbURub1dxeGpxTVc3MjlXdlYz?=
 =?utf-8?B?Mmlqekhna0F1K0w3aC96cEpudXh6SlhQR2JLK1RTRS9abUNKV29SUTNDQWo4?=
 =?utf-8?Q?aLj3+SDDA+y1ayVL4MhF72435JWZo4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTF6ZVNNREEzTldwVmY2b2duVHVreGVOSGxncXZhMHYxMTczNHhDK3dUanlF?=
 =?utf-8?B?dUZjd1BWS0VBRm96bXJtUFVYT3F3dklPanlCR0pJcHAzQ0Q3TEh4QzJKS2J2?=
 =?utf-8?B?M21XcngzaTRKb0pMUTFndVk1Y0RPcERnQkZBdlZLZTBJQXN1WWRrVlJHMUtE?=
 =?utf-8?B?WVQzYWZsK2dUcmZxcFpIVUhCRVpqQ2pPSW9BQWFlMlZRd2wxUzUvZ0hPanRC?=
 =?utf-8?B?cmVrYU5LNzg3cW9mTGlWRXRUc0laSG82VGJsejNQNmdRSGhnWEpIZXZnVVNi?=
 =?utf-8?B?N2JtaWxDbFpRc0RMUGVGK1FhVXN5RksrTzRoeUsxdU42Uk1ES3RLV2xhYnRj?=
 =?utf-8?B?WEhFUllDNThTbzkxR1R3SVdlaFhRbVc5MFcxMWptazBDWFFrR24zNzZxaG1i?=
 =?utf-8?B?eVFySzg0Umd3VTdRMmRobUNjYkx2REJFSXpPaHRubW92eWVSQ1RpR3hNOUNR?=
 =?utf-8?B?VHFlQ2FJZHZBWmVyZG9YK2ZQaTIxSU5qZVhNdFNFMFZkY3RTTUN0MXFMc3Ix?=
 =?utf-8?B?NXVxaC9OU3plenovbjllZjk1WlQwajRiaTRmR3BtQW90cUF2ei9INnphVW0y?=
 =?utf-8?B?MS9BQk1VTXFyL0dBNnl2ZDFPdWtGYlE0MTVvaDUzamxUUHNOenBqTkZ3ZEJH?=
 =?utf-8?B?N2FvT2tsaTVLbTdtOWFMWnlBc3pPNStiOE1PeHQ1ekpSUmNrVEVFeHJER1dh?=
 =?utf-8?B?NlN3UENQYzQ4UkhWVTVUVkduMnE2eXNyZENUYXV1SzB5Z0JHN1FLbEc1dWdB?=
 =?utf-8?B?N2p1aTNKZExrTHQwNTd6WWhhZmhFZjF1ZFhXN25yamFBbjRWWkd1ZDF6TEow?=
 =?utf-8?B?cVZINVY5WVIzU1NVVW1tb0V5SHd2ZVZibWFsLzRWcHhtMEF2NUpmY2ppeTUw?=
 =?utf-8?B?ekxBYW91M3dSRjE4bXlQcEx4ZHJQOFUzTi9LL0Yrc0ZiSk5hTUsyN0FhTTZR?=
 =?utf-8?B?REhFQThpc1QzaVZCcGdRZGx5cjZxcnlIZ0pkaStJMWl5NCtXQTRNSWZCRDJF?=
 =?utf-8?B?RzU0WjhjRXk2SW1zT1huL0syNk1pbEtPbXZ0c0JSM0tlZkViOCtnS05qNkNm?=
 =?utf-8?B?WHVqZmlxcGEzZllWNXV6SVozNkRLOUVUaXNHSlVoNnJ1N0EyVTQ3b1IzbFdh?=
 =?utf-8?B?NG4vTjBSOTBneFMyVkwrZjFPSkVmVWxmcmNmM2JhRHNlR3hPQnd5Y3ZsWTRO?=
 =?utf-8?B?cFRnYTVpL3dveVcyMlQrblVWNklOWkwwT0duRVRZRWJTdHd2NERsa2hkTit2?=
 =?utf-8?B?WnZjWGxjTU9DaHFra0NQR1R3S2liMDNJOStuMkEyM3Zzam12Tk1VTjl2cHF1?=
 =?utf-8?B?b0hNcm8zV28zakVFY0VUL1FEckU1OXpGQmdPblRYRXgyRWlFNWViSCtITE1a?=
 =?utf-8?B?T1JvcHJudytNeUNwK2s3QTl5UzdWY3pTalVyVWtnejVZb3hHTlNoUVViZkNX?=
 =?utf-8?B?OEVDb3dSWUpyb1NMU1dwYVZQQnRtaWZ3cWZZdU9YQ01ObnVyMnNmdDhTS0dM?=
 =?utf-8?B?WTBJNGZLNThtYmZVZ004UytxdlAzby9kZkFTMkZtZDdTb0pHYU5ZcXFKeUNV?=
 =?utf-8?B?dGNTaDJtczB6dDJzdXJvRmhmTWFPeG5EcUJpSHFQbXg3MDRTbU1NYWdyeVN1?=
 =?utf-8?B?SkRmSjM2VkxGNXdhRXorUEU4WWoraGFwcy9ZTkRDQ1dYb09icEdHQ0ZtTVVS?=
 =?utf-8?B?RUFuS2tRWVc3aGFYMStFWGZORWM5MlowaUlYWkVhMWpndWlMemxoN0F0ckw3?=
 =?utf-8?B?L0lubjFISCtlRGo2MHhmdS9jOUtsWFBJU1JpOUlNN2R4SVRzTEJYRHdmVkNI?=
 =?utf-8?B?S2JNZXU1Yk9ZSnJhMVZwamVpRzNTTXQ4bE9FQy9SQzdIK3lpU3BEU0dDT0VB?=
 =?utf-8?B?UjZHRTIwTkZvYnRqblpKYWp1VVNCWlZwRUhINWRISnFEeEN1SEhhNkl5RGJI?=
 =?utf-8?B?cmljZjl1akNQOGdUQmZPUVErWmhyQi91a2JOMnRoLzI1L2JEZGlKTzNvbEll?=
 =?utf-8?B?eTBmUkVtTXNGT1lzcTZ0eTlIaVRjb1pZWEJ5UGdYd2FERXl3TVR3RXJiRWxH?=
 =?utf-8?B?MUpzbVovV0owNDZadDd4bm93RkMxeTFweVNpWDVNMlRjUFpwdVgyY21TNzl0?=
 =?utf-8?Q?E3fY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a945349a-0f41-420e-27bd-08dd7b829b27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:31:43.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjsMtssG9LnH7Flk3qK/6rNoW1/kurEBqvyBnif72TlGaEviKt0PdQ2ioFEu7oesfKh2f//gwxeZqm9nFVfGSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

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


