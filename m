Return-Path: <linux-kselftest+bounces-26411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA2CA314FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA3A7A277E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54087269CF4;
	Tue, 11 Feb 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e044l9ll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F602638AC;
	Tue, 11 Feb 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301751; cv=fail; b=o2rO8IB2JZ77XJm1NO3NfrkbN7n1kiZWj9m+ccz2z/RD/uyzhlLz0inB263gTObrE8I5V59on11ctXCylkCfWzwt7GzESXX5gehcE+78p7n2kj+gTHiMzM1wwVW0KI0Hjh+BSNPWFOuE0QzwyQariG6OUghZKMYhjMCV+pdnGD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301751; c=relaxed/simple;
	bh=fJUb3Qo5pj69Acq54kcwlUPnULEPbDHzxWgCizfGqA4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GnvRkeSozWZRri2dv5YLmM5orNdcLG+rwRxyK8UBFSMZb7m8Sv7dq3imu30qvLO+Itt8MQXKdP1wplMNVv9K2/FQNwQb+xhN4I1TzouQJSLopQ+Q0Uc5wlS7VJSBDd2RBJ/JNFdNKlAMsxzanGIEeYI15EcH1z7fFcWDjBimDKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e044l9ll; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9wjfGIlt4EQbGhnLcRwC0IQ/QxmzD1jor6khajtev8Je+UQkEZtCAkNHdBpXuYxidh2YAR32fP+/Q3XGaodMY5Ly4q+pWZ6uvAhLFo41HiSKrVovgyj41KSfFtMgVET6XIds+pFKJvdhh3wxIyp5HdZ5jsgkyz4FWlyGuU+Zk/zyAlGdAFN85u/JbP36NgDhBvYFdOkTLa1n1tPGwP1tCuIdTy3FcurdvD34vHqIt1A18HOd6fbVZJ5bz/2HQEOjc/0GCTvrRpsWjRYG4EWOvP1AjiKHHsFBFj3spuZIfvQXcA+g0mVBl1Nkb9KhoqESeIe6GcJFgLI0SMOsfSjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9NmlTi4mUZwPLpgsYhtEUIIQqxBeTa69EOtiogTNHY=;
 b=iqQpMmJjwGMp2Ajr0I+gwQEq8yvskm/qAYxK9A5T6htnsIlTzZGvirGqPKsI/5t+8eZyHWT5Xusf0Y7T0E3DplRUlX0fMTwW+ijc0YBVLgTuiaHql2aK96vOTxY1kt8AKcu+JyadGovkJep9lBjavnRpRVsWyYqI3/7hmjNcvgI1qkONKI67TJRYWPhdOA3MyCjrmfqktz3ytsrc9eVGTk2RyOWyZUojiLr0pYo83vqGLgUsLcjZ212C0TqFy89v+fbrs1gBe9y/RDCzDV0N61D1aNnV2s/ab9+zNDosjeIzDhDnDJZyI7urUgP1lM/lT6bPp+Vn1M0UX70sEuv+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9NmlTi4mUZwPLpgsYhtEUIIQqxBeTa69EOtiogTNHY=;
 b=e044l9llgc0EUcd9LyemovTsO7Yo04CVZebdRhO0KZm/la8oPGaJx+N66g+uQIx0IwDTwgZqqWGnh53ah1Top40csK971ImjdvD+VTTCItXnXexAhz6xD/KKZ6tt5kYpch35bopCoSxB09xTbOBFK8y0uqp1dO+2pymikdasSpO0bFGytVVUGeU1T4FTUWr07WnyiscapAtpC7xqsXRXN6pemv05zcdEdchiAa8ck+U6DEXCV9n+Pf0N2+To/uOM+gdlEAVThBn4n1nSUMC9D9+I9qkrj40TLlvdrB1JxO0Pd3rhHHCc7cZGASb8VRaZ+ljVF4RqxcN7HSqFptBT3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:22:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:22:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:21:55 -0500
Subject: [PATCH v15 02/15] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and
 irq_domain_is_msi_immutable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-2-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=1874;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fJUb3Qo5pj69Acq54kcwlUPnULEPbDHzxWgCizfGqA4=;
 b=WsPdfyikds3DFNtJaxtanKWQHljWU47bVC73D999Nmd547z6HXbAP/R1S1MLBb5ldq+6CYHDd
 2CoLOAa2WIQC+3V0sO/UjNdOIjkbODn8UuLprCurk0ax42y1b7BMhWl
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
X-MS-Office365-Filtering-Correlation-Id: 778830b2-391c-44ac-2a9a-08dd4ad16b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzJUWVE3YVJQUWI1RVV1OWlIU0U1dGpnQmtJNGM3NXI5V2F1TmJDU204Q013?=
 =?utf-8?B?QTVSSU5lNE9xekVnVjFrQnVKRTNTK3UrYkh0UzRJTnZxSnBWOFJIKzFXR2NN?=
 =?utf-8?B?Ulp2N0JPNk5kZEtnWkJZcldxQW1KRGlobHVsOUlxS2NFOS95bmNEcitDYXFw?=
 =?utf-8?B?c25rS2RwSS9xQTZzSDUwZEVIcTJBV3R0Mjg0end3UzkwS09DNlZlSzdQMkR2?=
 =?utf-8?B?Z1MyQllJK3NWS0JITzdYYm5OTlFRak5HSVcyS21DMTlKdGY1OW44WW5HRTRV?=
 =?utf-8?B?M2ZYaVRtRDVtTy8yQ2hQZ3d5QnlVcVFoMmZYa0xTeVlZVFVTWVRwL3EyYWw3?=
 =?utf-8?B?T3pWbHNyTk5odWk5NTNQVHI3ZEp5N2EwejdPQzlJWloyWERDQlhxTjFMczRL?=
 =?utf-8?B?L1VtdjV6RG9BYzlQaG1hc0VBVUlySzdVY1pEVFpVaUxrRU5VYXVab1M0bUc0?=
 =?utf-8?B?NXR3MXNrV0w5VTB4eVRtQVFBOE1HQVVFS2cxS2MvcXRZcWhFUlBWVzV2K2RD?=
 =?utf-8?B?ZmpLWXhFR3VQbGduSUNVWmg3eUptTVpmcVgxVkt0U3ZMdDEwTFVmL1d0aEVq?=
 =?utf-8?B?SWg2LytIaXk5NTdDbU9LMlBUMFFncEZhT29YWjRYRE9pQUdjQUdhczNxbXZT?=
 =?utf-8?B?NTdTWjRVc2k2MjBqY0h2YmxPRUE0dlF4RUM5Y090TDZybnBiVGJGb2pNMWE3?=
 =?utf-8?B?QUFqeG5GK0JWaE95b0pSNDRHVGxQZWVhWWszMWpyblhqa1JxVE1TSTVmOGV3?=
 =?utf-8?B?T05UbGhlakpDQUIrMThGeVlJcmtpeTFIVlRmck0xYUlTeW13eHl5VXg2SDNI?=
 =?utf-8?B?d2ZsRzE3MEZWQmVMa2lvVjJ6TzgrL1dnSFdJMmdya1R2T1gvMkp6alNqRTNj?=
 =?utf-8?B?RFZpQW94ZTdOT0FWZGJRMkJzakZJcURvVitjN1ovMTlpc2ZXc3RYUm5RNy9N?=
 =?utf-8?B?Y3p3L2ZJUFFaQXQ4YVNVcTNYemlsSU9jNjhWODMxV3kza1JUbFM2dTRzOFpv?=
 =?utf-8?B?ZG16cnJjVC8weGx2WkxhSHBVL0xHaFN3dnQ1bmNGdjVVTlVFazB3UURLV3Uy?=
 =?utf-8?B?a2VBWk1YTW9LTk5uVmVNdnNCSEpyWnR3RWJSc3R6TmR6WWM2RE5DaGNCTjdY?=
 =?utf-8?B?UHVrdmkyRG9wakJJd2lMRVVLdzhRZ3YyajlOaS9YZWdSY0M1NnB2TGt5b1lY?=
 =?utf-8?B?NE5sRXBJYjNVTE14QmlKeTJSWS9hZlY1KzNma05VWHJ0bisvaXhETURBMjJm?=
 =?utf-8?B?MHFuTm13TGhuc0toYVh0UVpmUW9SY25SWkVxYm5lVzdQRklBaGtMNWJMMC9H?=
 =?utf-8?B?NXFQMVZuZmJIcWNNYlNiRG5mT3dqcjBvZjlYQkRQOHhaYkZOb0RNdlBudlpI?=
 =?utf-8?B?bDNGR3VjQlFWMjFsOUVTenp4N3ZFdGV2MWJrU3dydzYxbTlEWHh1MHlYcFFq?=
 =?utf-8?B?UVdQVk9vcUF3UEJrbXBhZnNuU2VzSEFvRVN6VlpVZlpZS0ZiQUJYbXprSmxw?=
 =?utf-8?B?Y1dEOTRSRHFZaGpmQzNvb2JoNVNWS2VOOTRZSVF3MzFrY05mMjdIbFV6ZG5m?=
 =?utf-8?B?WjdWTFNvUktRNEVNdWFLb1lsYVlyTC9PckJXZE15RzBwSVhWc3pQdjc2K2tM?=
 =?utf-8?B?a1RuSThFMng5ajlPekVQMXFtUU9GTS9QQ0VIR3RGZEx0SHdWcUl0SGdJWThp?=
 =?utf-8?B?MmtwK1lrOVYyd2IxbTZLRlRYU21QS0c2VWNqM0JtQUdoei85cmhkNjg5QnJW?=
 =?utf-8?B?ZjB1aVpTYlZuaWxOQzJlM0pMcmozd0tML01vaGhsc3VIUm1BV096WGFpMXV3?=
 =?utf-8?B?cFIvV0VEZnI1bUpCUDF5NlFtVEcwVlNzS0hNRUJ6eDZUcTN0dlc2M09EdDVa?=
 =?utf-8?B?MjRhZEZQS1dEdzhPdGZERVh5WVJFZ2lTVlJYT2x2cURjTHFzNVMxejVJL2F4?=
 =?utf-8?B?OGVYeGl5MGZ1d1RKcTFGbVF0MXVZUFYyVmJ5VDhUb0UxM2svYmplSHpoZy8y?=
 =?utf-8?B?c3doUEJReWFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ukp4emN2NjRyNWxGMHNTVFRaSkNsT0JxUmJFQzYxTEM2QXdQbUxiWkdCcVJt?=
 =?utf-8?B?SFFBL0orY25tYWZnNEx6NHNRNytMRFp1YjJRY0tYRjI0cFhpcGptclhJeGNV?=
 =?utf-8?B?RHFqV3NLTjkyd1hoZk5pSThzajVYSUp4VkFUdG81QVUzZlI3M093cy9meEl1?=
 =?utf-8?B?QmxMd1VFYzZ2alpzSjFJVTI3T1lOMTBNajljYys5Ti91akVISXpLMjh2Qm5l?=
 =?utf-8?B?a3lxZ3N2N2p5MUt4ZFdiY3orM3c5RU5ScmZXckRnOTNBeG1yT1RRMW9lYTJW?=
 =?utf-8?B?SWgxejliSWdpc1Jza1lQSnJOODRsWngxYW13UDRLMG9qeVdRL2IvSUVhcyt1?=
 =?utf-8?B?ZEtOTCtFT2JDY3dSVlhUT2ZmalRsV3BqWVYvbFJBQ0IvazJLdVB1ZHVSMDA4?=
 =?utf-8?B?eGpUa1MveEhjRExudWYvUW1XQUU4RUFOSWttbVJxanpYTmV0b1UxckNlQUFo?=
 =?utf-8?B?cytyclRETnE2T0pHMlh0aWV5T0hodHdlOEJTWEhzSHBCOHBNYVR0ZVR4blZi?=
 =?utf-8?B?TW9DaWlJMHhBMVArMk5wckR5RVp0MVBZdWhpNzVzOVNON3pOQWFQNWpaeXFn?=
 =?utf-8?B?QTNyWlpqaXROMFVsdjc2eldtNmQyUjA4d0xJU3daU1I2M2hpbkVQSVhhWmw0?=
 =?utf-8?B?MXlrbE45a0NoUG9XNHl0VkErNXlOZHY4Z2Y2UE56VWIwc1lucG9rZ3JLZFN1?=
 =?utf-8?B?U0xOWGh2L0tTN0poK1RGWUgraDRoUldJSnJQa05yK0xoU2N3S1FLZVo2VXYv?=
 =?utf-8?B?c2VHWk1UK3Jja3pvcFBiOVRQQ25xUjBUZis0U0Q5S1RwS1ZYMTBpMFJqNkNY?=
 =?utf-8?B?Mmp5MlNlSFZkS2czdHdsVW5vK05XU0ZNWkNieG5zMktRTlZyREZuYmJxRW10?=
 =?utf-8?B?UUUzOUlTS1V4Tkt0WU4rQWY4anhwTFZrUzkyNEF4c2ptTXRyUHNQMUc5bmpQ?=
 =?utf-8?B?eWNUeVlIcTVrSzV0ekVzSnk2eXpKbEFnRVlyWjcvckhCcEw4RjJzem1jSEdn?=
 =?utf-8?B?cVhjcEVuSGJieXFpQ0hBM1piSUFOWHROcUQ5eUs4Q0xlbE5PYzRSZXJxZ2Zt?=
 =?utf-8?B?SjJRRytaK2VHcEVXRStJbllVSm01ZVhqRDh2SlhiZlhSQU1BQjJ4WHRoNWIx?=
 =?utf-8?B?L21PL21FaVMxZExESlRlVDB0WHB2anpFY3ZSWXh4MmFiMEs1cWM4em1ZRGhH?=
 =?utf-8?B?NTgvaEE4MmFwTXNaZ0JNVTN0cms1bktwSXZncWpzcktFOWpyOTBpYTdFWThQ?=
 =?utf-8?B?NHN1VkJpV2MvYWJLdnZMTlJjNkVtWVY2YzVsTjRTM0hMVThEK2Y3Yk0wb2FV?=
 =?utf-8?B?dm1EaHFGQVpkRDVMWjZhUHlqUFJra1lxazZCcXVBa3NLUmpFcmJBVjFQb1JE?=
 =?utf-8?B?OUkxa2V2SjFEcUxJVnVOZTN1OTZyYnk2dUFUVVdLWFJvQmY0c0k0SVVDbHNS?=
 =?utf-8?B?UmZOaFlMQXNTMW16WTJ3UVIrUHRhbnhqWEUrS1RYMTl5ZmZkazZnRnFlUjdK?=
 =?utf-8?B?aEtnTWptLzZrREt0bGt2UUwwUFN5Z1VYQi9pemI1S0dsc3dYdTh0M2s1MVZQ?=
 =?utf-8?B?QUlZU01PS2kvcFJoTFIyZXlUKzRQeTBRdyt6d1JTcDR5KzNUYjhDa3BIMWpz?=
 =?utf-8?B?aHMwS0pNQXNnQ3FYRzZGM1NZY3FPRmFLQVdVSjAzU0ROR2ZPKzdFdjZaSk9P?=
 =?utf-8?B?c3ZleStCL0h2NjVXTFd6RlBQOWlmVU0vR2packZ5NURDaThBUGlwQTNVQTZu?=
 =?utf-8?B?Mnp1VU5vNWlvZi96RFhsdWlQbkZ0SWJDTUlZTEpFemFNSFE3bWsyZU1nK0JL?=
 =?utf-8?B?dUxJb21mYnRxT1JzclkvMlRzRWNXT2lWNld0UFNGSTU5cXJMOEhHbDc5R0g5?=
 =?utf-8?B?a0JQYU5sRkRzcExuWXQ0Z25sdWVkc3h3VzczbDBPNW9ORmsxeUFxMitDeHFm?=
 =?utf-8?B?aDRPS1c0Z05JQXhPZUM4d2Z1Y3FYWkRpRUgwVDA4cC84Y0o4SEJWQTE1eE41?=
 =?utf-8?B?WmcrOENyT0cwNkNDYnBGRU54aktCK3BtRnlHQWhMckRvSENISTdtQis0Q3BH?=
 =?utf-8?B?MHNWVGJBNEhQa3VxQWRnei8vYmxvV1BOd2NSNXRjQ1VhUHlVdmVCQ0tPeDV6?=
 =?utf-8?Q?OPUnhRrOv8HE3TvICuHvTan4P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778830b2-391c-44ac-2a9a-08dd4ad16b56
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:22:26.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zGLqx4taux6ux1FbtVWdzQ5Wkmv1qvbw3adoYnCDrpGD8Oyfa5zpefWAS0Hgy1CXaJA8GXy0O5+mXqsOIW0nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

Add the flag IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and the API function
irq_domain_is_msi_immutable() to check if the MSI controller retains an
immutable address/data pair during irq_set_affinity().

Ensure compatibility with MSI users like PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged after setup. Use this
function to verify if the MSI controller is immutable.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v15
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
index e432b6a12a32f..3dbe05d8740e6 100644
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
@@ -692,6 +695,10 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
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


