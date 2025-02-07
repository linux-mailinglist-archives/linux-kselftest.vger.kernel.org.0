Return-Path: <linux-kselftest+bounces-26035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7CA2CCC5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014E13AC327
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D51A00E7;
	Fri,  7 Feb 2025 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dlB6dqZi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497519E96D;
	Fri,  7 Feb 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957246; cv=fail; b=tNo/cy+1AS7+LRm0C690QG6ky5TQ/8Pe98URgZvdE+a0o8MyTHnH4zGrfUthrkP6vPvrGqSYfCnSpFI3OgAvwX2BQLMrLdBHmGCZ0ega629ghS2/2NApuhNXzvNDMMauDHtbjeM3klfkN+23hzJeed762kViBxs7ZjdXNK4OZUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957246; c=relaxed/simple;
	bh=zewGXlefLCDyIXy6F7+H1XUs+Kz8KbsIP9ChTnteHw0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SL5Z4PYCsfDQ+t+sIlIrc/B+rJmRcxKJhUJRJLkYj52NanMmeLDOzX9cSyV6zpYoim7qfh5nwfj4hvnOg/a6oLxYlU6i4UPaoHBLBQQowWMyO0yc0h9mUf5Xq3RiCoVYGihYjiQequrFVjrvbojNKzLw4umDKAKfBWByobq0d0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dlB6dqZi; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAJuet8rgjxR/z6gWwjpzbhruZR5lpTaBS8Q+dcvSHDTSIfJdYycjskdgyjICFO5Hu4PKqUF7FyjxwExpU9PRZzpeHDAS6WCKoar72POMHcULUVXp3AV/+ZNhyzIjtWQJ6muteVqishU5x9ovOaHJ+rkPxfrKgyXjj3Hr+1YmMXHDkjO1odr596TkewkzqaIkyp8k+/bNgtbLZjsPMRsK34lb8EIRi6AGXu97PVAtxxMsVVEQSa3dIaedHHEYuA4G9ZgGZREmObxG4VpBrDduIGDSKdIrQl3KISCIB1f7KQAiYnHJlM0zZWu/dpTlPOj0rbS5m4NKGIRffg7sW9NsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU+R8/iNVZHTkewMXkj3i0F5vaY6NmwCtObIidgiHw4=;
 b=ZW/4/1VTWODGroiNJrmJKWlTBzTSjVu6rwNaGPPDo8CtpdowYNtheNQ9hdWI59JPrxXzZP4bIEr6vwTcYORYEGpuI8L0O4qPyNV0fjQLxdZYkdHGTJ9GgRE2+TiCStP1oBMg4hquSKxhLJ0Yb9cBh+rtqb1khhre9iroybylmjyxlRSEMTrD01gzDh1Nd3PUOsyRv9NNJfQdYcEdM4p7z3Z10uD7NeEb6k+xJOsXTV82VwkbaSWTozOyy9p5eU8KjiPL9B21lIhvLMvg5/+55pLb1tbh0Ml255WVKDJe+YjsN8uZ1wfMpCp+lK9kK9nHn1132oRGGv/xAcNCGWKvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU+R8/iNVZHTkewMXkj3i0F5vaY6NmwCtObIidgiHw4=;
 b=dlB6dqZiNuPCtyIZ5XBTy1Ub3cp5YfM/Cs8W9vE84oiKWc0lWN1Pajw7oiYln3O3FyDK3mlveQCz3wmMRgppEnfsgsDx5uGO4a1fIIhy37yk5aZ/IAz1oSdf5Y/uDh7eGCU13E3KGgRXpNmF0A0eYOXRf6ddc7wYF6f2a/v9w8xjPtJfTsLBZmtmTdN2l4VN3ABID/0guTcFXDqIMI9STOUn82mgCg9Jl3921PEnd2Jcar7SMII6FF9VEzrKEqI3IHTKaOXQihLuCrM1wQT5nVsZ6eHsz25FndzmHANKN28K4wORiJrn9Me0mNMSoP7XZRSOUv0p1FzgsWn1GoAXmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:40:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:40:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:46 -0500
Subject: [PATCH v14 04/15] irqchip/gic-v3-its: Add support for device tree
 msi-map and msi-mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-ep-msi-v14-4-9671b136f2b8@nxp.com>
References: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
In-Reply-To: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=2895;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zewGXlefLCDyIXy6F7+H1XUs+Kz8KbsIP9ChTnteHw0=;
 b=gzZyELmdKdrbBN3018qc19nhFoDA7UCZi00OkpwFBKbdvbKFJSbjIcc9fByKWRZxC2+7wVyqB
 leVT8fkC3H8BUoPD1FnJUkmW3zf4geUr9lqMMVN3pzT6H8OibLk+bHb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f256c5-129b-4fa3-4fd4-08dd47af4e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tkl5QVdzdEh3dXBPYjdhUlc1Q0R4TlQwbzgrbHg4Y1FrU0lSajJZK0pYRmdh?=
 =?utf-8?B?UEhMSDlJWExqQjF2VTQ0dDR4aHhTYWtaMGo0UnczS2FzNEl2eUJ2SnZOcitn?=
 =?utf-8?B?S1RhVlRPR0NRQ0thWXNoL25ISFRWSGpqbDNjYWI3Mml6ZXEwR3ZoREt1SXZQ?=
 =?utf-8?B?SkVmQythaUVOTmJOZ3VNUi9VSTUrbDh0S28zM1ZSMWY5ZFhianM1Q1p4OFFi?=
 =?utf-8?B?Slh4Q0d2Zk1XWFErbGE4R1lPaE00bjJKbjdINU9NbjZBaEptc3hWbTBSdStF?=
 =?utf-8?B?Unp1ai9MVHg2RlJpOW9JVEhOclFpMDRTWTZJL1ZvVDhHSjJNVmlmR3Z6aWYv?=
 =?utf-8?B?K1ZhV0xCTUdtWnJVU0czZ09KWmtEdXhkS1BLbE84RHllZ1JxYzBHa0pDaHhQ?=
 =?utf-8?B?TE56S294MHM3QkVqZmF5L1UrQTNhbThoMk82dm5vTEhnMDdldDAxN1VqenZZ?=
 =?utf-8?B?aGdLcEN1S2NoNkRmRzhxWFArUlhmaTZxQ0ZwZVBGUGN5bURRcmV0ZnF1aDZL?=
 =?utf-8?B?czJUWFUvcE9wWmQ5QWc1cFFpK1BnTDR6dEkxdkswdEN1bEFsK3lvdVM2WGZZ?=
 =?utf-8?B?YWVXbEhjMEc4T01FeDc0ME40Mnk3bzUwcnMzQnc2RjlOM0dSYlN5RkFpQ2Nh?=
 =?utf-8?B?dWZrdWNsNGJNWDYwUDdpcUpLTUJwNFE3a2NzRWV5cmc2NTAzdyt5WDdwWUsx?=
 =?utf-8?B?VXRvMkkvQ1FRd2xJZDNweXpLQzJNRXNZbitiTEpGQ2xjN3dQWG9EdE5heEhY?=
 =?utf-8?B?YUZrV0hJMTF3ZVpUaWRrZEpzTDVBNTUwT01TanB4SlJhOUxYU2p3TDdlYVl1?=
 =?utf-8?B?Z2lIQ0dzUlNCbXJNV250MTMrZm1OM1k2WGlhK1h1VFdqRmtNM2s0VHlDeU8z?=
 =?utf-8?B?dlJrdlVTZjJXOHUzYUZiUFV3THhlbUpmRzBDdnpzbWw3OGt1SFQyR28zQ0RZ?=
 =?utf-8?B?YzdQUjBDMUFtYXVUY2NScjd3M3I1bytaQ2dVRkc1cTlnOWd4REhUY1JFaUJv?=
 =?utf-8?B?ZDlOTkxHVEtJWXN6SFZWMHZ1VzRaSnA5MFl4bk9TdzJwakl3ekdCcnQxMlBS?=
 =?utf-8?B?Q0ZsRFhmZWNsKzJDOGRWZ245c2VJZDhScGQ3Y3RVUmptYnU2a1R4RlRTaEV2?=
 =?utf-8?B?cUg1cjdQZHV3SWZrTUs5dk90Y1Y4RWZFdDlDODljeDc0akZhem1xVFplU2JW?=
 =?utf-8?B?ejBrZWc1Y3RFdXgyOHpFZmM5L2YzRDM5YmxWVUJoZStsbEd1UFFSZmJtalNF?=
 =?utf-8?B?UVpHbnY3OWhPM1Y2U3VHYUdmeHpWRkFZMjBkREJQZnJSVnpCdldYMzBkcXVj?=
 =?utf-8?B?L2RBekpOMzQ1WXEvUmpFQ3QvM0g0TGtWQXZLTE1UdWNCbjJxR3dUS1lERjlD?=
 =?utf-8?B?N3RhWGIwVmNqY2dKeEI2czFGZVNXZ2dCeXVsd3dldkoyeEg0V1N2ZGs2dk5T?=
 =?utf-8?B?S1JTWmEwYnp0ejk0Mk9pSVgvVUMzMUlYV29vbXdVZ3l0SWN1bU85NFB1c0V0?=
 =?utf-8?B?bWd6NkFwWVRhbGEyT3VFUk5jaW1tbENOUHBWK0REdm0ra1BTK1l4TzB1YTBM?=
 =?utf-8?B?b3pBdzdwOHVQdFc1cXo4R1VkYkxoUkZYSjhKZG5sQ2h1SjFYZWxUenltRlQ3?=
 =?utf-8?B?YnlHZEVLOExIcEZkaGRIYWdkelZ4bUozMCtTUjhobFFlVm0wbTFoMTdaRHVW?=
 =?utf-8?B?dmUybTB1cXV3N2RKaGEzS1NId0FzQWhiUi9IYmc2Zk4wVWc0Y3RzZ1pIVWpF?=
 =?utf-8?B?dXQ4bGdFdFdGcGd5Ty9lNkZuN3U4TFFzdkJhaU9tRytsZFZxL0hPRjZINFBv?=
 =?utf-8?B?eGhuN1kvN1BrbkVLQkdEMnAxK2FxZVo2V1JER2ZqblhMSkhNZzR2aHoyUlB0?=
 =?utf-8?B?ZXRTOWZhaEkrSmN2OHNKWUk1SFhmMlI2K3hsSnZ5YUlTSG85emFJUFpZaERL?=
 =?utf-8?B?NTBpRUpxSkJxT3NVTVAvZnBVRXJlaVdZZkxCeXdPRndRY201WjlPVU5zWXJQ?=
 =?utf-8?B?M29aVVBoYm1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODd1cDBHL1BoLzlKSzUzaDNsUDdGLzViQjlOMTdjUU42ZGVCSmdxVGZoWFJ3?=
 =?utf-8?B?UDFpTFI1b0o5cXBJbVQwMXh0NWJtbTJEOHYyMjFEa2hRY3JqR09DdXF2WDRm?=
 =?utf-8?B?L2toMjRLcXc5TEYrUmRJOWdLeWdVUHh2ZEdXRWtRb3hLZUU3Zis4OWozMmF2?=
 =?utf-8?B?WGVObHREbGNlSGEycmhRcFRrbGZMUHo3V2paWkx5cnF0bTh0T2xoaTl3RCtx?=
 =?utf-8?B?NTQwY3p4S2VUTjlzMEpiWTkvME1YcXVsRW5JWko1SXJRaWdzWWRrZFpaRUFU?=
 =?utf-8?B?N0MyRFI5TllGZDZUYWdtdlVpM0o4ZGFyU3ljNFVkclNuNEpvWDVZQkhqR1JX?=
 =?utf-8?B?bWwwU1J2Wkpwci83Wlh3T1BCTU9zcUdEOVBpRmt1R1Nxa0dBUmFkVzk3QXVN?=
 =?utf-8?B?VUtIaFpuOVQyUVN1S0pOUkZtN2Q3RHp0N2tXUTdHRzNWeDRJblA3SDgvcWJC?=
 =?utf-8?B?aUpHdkw2RWxXVExtNEJ0OGdSSEtSeXpHaG5jWUw1dlNnNkZGLzlVOTNmbXJJ?=
 =?utf-8?B?b09EWGxJODhPV0pMdHN6Zm42SHo5b1hUMThQeXl2M1IvdmNJK2EyOFg5cUNs?=
 =?utf-8?B?MjJnd2E5d08ydmhzNEcvbTlUZXBWNkRqU0FIS3pJVUd4OXVmR0lMOThYVXZh?=
 =?utf-8?B?Ris0a1oxVk12T0dMeEtrTWRFTk9xSzhuRDZROEx1Ukk3YU1oU1YvRTJMUGtB?=
 =?utf-8?B?M1RYZjhEcFczcHFvRnpEYURyZ2FOa1JqUjE5MGVLVWNlSjlNUXhEWmFLTVl5?=
 =?utf-8?B?Zlh6MEJIUkp1VTNMaGlsZUhJdzJqaVpQRk82V1M1SHpGMFhRTytHUk9BUndG?=
 =?utf-8?B?dVlmTWFOcDVmczBXd0s4SlZsM0phYnFRRE1lc1p6aVRsbzdWSlpZK2F5SUI0?=
 =?utf-8?B?MkhYQ0R5S2FCSzA0aEdvTExHNjFhVmNENklRWXZKQmlsazJJbzk5RGNTVFNW?=
 =?utf-8?B?akI5Yy93dFV4K2tSbTlaeVFwK1lUUWZkVTBKMXRGN2V0WnUwaEZYUCtTOU9T?=
 =?utf-8?B?Y2NQb0Z4eUpaZ3lIRmpjUXhCMnhINnpoQklZanpDaSthREMxQkFSQUZrcDRK?=
 =?utf-8?B?TnhiaDBrUVlxZStudHI5UW9OYzUveTVCdDVkK0pmTEVjL3YxdTZudTFyMXVu?=
 =?utf-8?B?Z0hQY1p3ZmhDZTdNM3JuY1E2QXZpYm4zRDlGR2NETWJKcmhFMWdsbXhQKzJm?=
 =?utf-8?B?cDRzeitTM3ZKV2E3V2VLMHg2Z2t5ZjRFYUd0Zkticng2TnpFV2VTM1hBVlFN?=
 =?utf-8?B?K25uckF3K0twSlZBOExwODJtNSthUmhEZVdWUVpPS0MwTUp0NUgxZEVrMTRN?=
 =?utf-8?B?M25rRXUrL29sUWt0UVpHbWNxaWt3K3Yyc3dhMysxbDByMURIUlRBY3BGZVJa?=
 =?utf-8?B?RnhuWmp3ZS90c3pSUlNaYWdCNUVpMmV2dUY4TU9pNU1lMFVJNkE4cjhOanAy?=
 =?utf-8?B?TjJaNzZPV0d2a2RXYUdBM1JhdU1mYXNmYStTNVJMdmxoY1UxbmNGY3dXdG9i?=
 =?utf-8?B?Ulp2U3MwSXdndlExS0JjMlNwS3BrOC9TVE9QSTRKMDhXVjVRblRWT0VSMk52?=
 =?utf-8?B?T0Z3R2ZTcklGQXZJQldBL2lhcjY5VHdOdGQyZEVpK0RBWHFsM0JrSEJMazR4?=
 =?utf-8?B?aTdQZWpxdEh0SU0ydmFHcmhQUDhLcG95M0lERFV4eW9XaTB1TmljclRHYTUr?=
 =?utf-8?B?T3lubnpaaFBzSGxhMC9TSktrR09vaW9KYS9CWDdBeU1VL2RiT2pGRmltRUVh?=
 =?utf-8?B?S3d4S3pSTnZjUURkcVJsK1M4ZlFMVzJTOXFMZTUrOWF3UkRRN1V4UGNGUmta?=
 =?utf-8?B?bWhQUnlIS1RpNTFGNjI3WkFwRWhRczRnbXc3ajY4R1FiY2FXenhpKy8zclhi?=
 =?utf-8?B?clA2dlhjMVhrMFF0cEtyNWNaT1cxckhSYXNtamxQYlREcWY0QWQ1RlRBbFJq?=
 =?utf-8?B?cm1VRWVNZVFSb2djZlFHaGxjai9QaEhVK3BUUUd1NitLRnUxdW44SWkzRnRR?=
 =?utf-8?B?WTZOeW92Nm9pVmQ3OFd2aC9vOGdkeTlCTzRHTTZWK3lybi9KNmIwditSeW41?=
 =?utf-8?B?SEZ5ekZQWkw3UDJkRmF2TWxxUkh6N3E1UXNiUCtTUHRCTEN1cWlERnFPNFdj?=
 =?utf-8?Q?L4NZWjTqO03ZX3QnwofE43I2G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f256c5-129b-4fa3-4fd4-08dd47af4e18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:40:41.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2V6SV+xJZDg5Py2aH/hkVL+94mwPSmI0geYMzE4Le/qaG1ESn1cSsMOPe4uGdPRoFP1Mc0RWcpCquKmkEQ1F6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Some platform devices create child devices dynamically and require the
parent device's msi-map to map device IDs to actual sideband information.

A typical use case is using ITS as a PCIe Endpoint Controller(EPC)'s
doorbell function, where PCI hosts send TLP memory writes to the EP
controller. The EP controller converts these writes to AXI transactions
and appends platform-specific sideband information.  See below figure.

               ┌────────────────────────────────┐
               │                                │
               │     PCI Endpoint Controller    │
               │                                │
               │  ┌─────┐   ┌─────┐     ┌─────┐ │
    PCI Bus    │  │     │   │     │     │     │ │
    ─────────► │  │Func1│   │Func2│ ... │Func │ │
    TLP Memory │  │     │   │     │     │<n>  │ │
    Write Push │  │     │   │     │     │     │ │
    DoorBell   │  └─┬─┬─┘   └──┬──┘     └──┬──┘ │
               │    │ │        │           │    │
               └────┼─┼────────┼───────────┼────┘
        sideband    │ │ Address│           │
        information ▼ ▼ /Data  ▼           ▼
                   ┌────────────────────────┐
                   │    MSI Controller      │
                   └────────────────────────┘

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
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index e150365fbe892..6c7389bb84a4a 100644
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


