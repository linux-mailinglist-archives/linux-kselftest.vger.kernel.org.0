Return-Path: <linux-kselftest+bounces-26413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F441A31504
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C8D188A899
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D284269D1B;
	Tue, 11 Feb 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="At8OmAG4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE57263889;
	Tue, 11 Feb 2025 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301766; cv=fail; b=rI69V2p9+sddusCz2mazI1ITrxdOqhUg2Pv8JUIlZafBY+OP2tk4zl1PKoMS5E14JzU9CUOK3oWcGDXWrUawLjBd3yDQfrflE4BZyZej1jUUPP8ksW2h+polkDUe9xmJYAt9QHPmqBd4rYd5gcfASXHHs3KlqGgxu0Ow9Vky82o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301766; c=relaxed/simple;
	bh=yqW3ugWGC0Fl1AwT/TvhzlZpjGJD/GZ1k6diCFJ92+w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=crImhczGi/0LpByx+UNg+8jyy+1UxYzYYLHK0tSPQUCYGCp2JymoDLJ89j85r/919xfkit8/Kezz9yyvWXa4124uFKYgDvRLFva+DlImDYq1QuGJ4bjND25PFB9J82gyTUuXhrPVYUXh2k4ti12p7uQ3U6ITXihgPZW2dYj00Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=At8OmAG4; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxEWa8ulUb3A/O3hMvmpPH8TXMFEjkr4ag04ud7NIfS++uIRKJgdMtko4Amo03i4t8dVdoQudFGo01NRSFH9KeO3jiwYCmIM9KeVf544dorm8dyMDCceHUFoaGfYPd7gO+mBD53shZ1OhdSWoQYebAftLSmqfVcBfqAJo+L+xJCZZvFYjHD3iq416pFvvOcjFNElG+SfjoFlgxoeaUJNRhpdV8CgxbT4egyc1V5AHGyeOWSjlV52ZWA0VCHLjgktidO/xYicodpR3pqNNE0q0UO4wxbiKvDTuviN46SIPE3OPjsztujlHjP3qA9B6rsr2DDafjHqJa+jMUEPpNd9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DT2WOkJ8Nvc0VXVdwiFl7hn8FMKS19hoAXWYe73lro=;
 b=OqxYceuS0Q1Bg6IVrziAEjWgqlMfIffC5/qItrrXByc0oHRhJgNXo5CumNOj+0RVQvhm4x1NwE2Sent6r/HVmOYuXzEMpYJYePPKARiUl/IwE4lPP5XOXnwSMZk5IcGnir47zsl9TaNNTw57+ylz9E54JhEfRYfMzhUKWOnyq5Uxgnqrx97gVgwa5OvTc6B6xOGv30ETlg23emEhe2qPkVJGITLYkLed/vwHDzsK5boV2S5HWFXEmWZ4n8ZmjLmUulahMb+i/DNjcwFw7pv8n4Vb2d79T6CaLKhKNa1pw+ItMa5lYJJprdnCdfaa6CGmm9e5S5MRO1Cpt+xP2YudSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DT2WOkJ8Nvc0VXVdwiFl7hn8FMKS19hoAXWYe73lro=;
 b=At8OmAG43xA3ZccDf++hygcgN1mJvwmb6WoTNjNcS82J4tKiz6UVA6Fjba46FAa9qt/3P60jQ7j/O7ZGUr5SRYT2b6ebvBJoVO80a9ogoq4NIHTPmfQQbPzUo71+BX0l3APi5vcoH1JRKHRnloLh8aYxaMWgGkdZ41naYpO6ZIdY+OTdy6/cUb6DTAWVMaxk2CIV37KPrEjrFPo0zLMKT0z0BP0IemK+GSiLr65BguI5hIFIppJ+OqvjTtDmiXZQadKu81EITSL0jvqsVqbVd5kTzZsOaaJEdzjDUCxeKvnDnFZxh8WyLyTTWeQeml7DCAYHPKoKyY9i5Lzv+DpOxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:22:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:22:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:21:57 -0500
Subject: [PATCH v15 04/15] irqchip/gic-v3-its: Add support for device tree
 msi-map and msi-mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250211-ep-msi-v15-4-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=2969;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yqW3ugWGC0Fl1AwT/TvhzlZpjGJD/GZ1k6diCFJ92+w=;
 b=5l09n7cv47mDdeFDZx8CpGOgxGOOlE7d5lC2j3UIq0UQU5LvtNMMwjcTCw16shgdeNMk1eV1R
 s5cjjY8j/q8AefC0XyDDHlwx5FTSjMnDoUiG3Qw5g7rl+uMnST2GBGs
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
X-MS-Office365-Filtering-Correlation-Id: 72f8b663-d1c3-4453-d07d-08dd4ad17427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGFneURwMHFTRmI5aHFseFNuOWpXelpLUThaS0FWYVJxdkFKOHdKM2N2QjVB?=
 =?utf-8?B?T0d2VmFiL3d6a1BkdG1KQTltNUNaMFFudWl6Skl5OGp6cC9JMEZHQ3gzdHVV?=
 =?utf-8?B?SzdFbmRYZVAyZ0NoT2tDNVBwVUNKMUd4SFNMb1NzME9JWFFEOXRrdzJyaUVM?=
 =?utf-8?B?emg5TDJaOWV0RkhVZ0NLaWFJY0tHN29nQkx5WFQ5eUo3dkd3YWphb1JlK0Vq?=
 =?utf-8?B?MXd4cXlLZXkrRU13YjhjNXlOQW5UTE1oQXkzbXpURDUzVjdaNlQ3WVNJdG1L?=
 =?utf-8?B?cGFUaWdkMUVWQ0NwMXEwRmsxQ2RvSmxWUmEwZVF5alFEcEh3WHJ1bGJ5ekMr?=
 =?utf-8?B?aGpya0gvTVdMUEJwZlpHOUlXN2J6eDNseHRvWWN2Vjg2WWprc0ZjRy8rY1Aw?=
 =?utf-8?B?SVBnMDFWM3dZcjhIZFNVQXZma1MzeTlXN1FkemRJdDA5ak4xR1ZMZjlNNXBQ?=
 =?utf-8?B?S1dENVR0STliNHpxOEt6REpXSEJPSW5DcFZqY0RtL0ZNdGYvSXc3dWg5NEJ3?=
 =?utf-8?B?L0w0YlgyVlRQQmszMXVSazU2MEcwR3ZWNk53T0lMbkdVbjJCWHVHTUgrUFBs?=
 =?utf-8?B?NUFTNSszSG9BUTVjaUd1RjFzbkk2cVRkYjhxRDdoZWttNXU4QUJKRktwVndp?=
 =?utf-8?B?emVjSFljQnZHMkNPTXptU2xTMHZKd1AreVVoWFJoMFg5b0hRM2h4bTM2L1B0?=
 =?utf-8?B?RlVYTVRmZGZ4VlMwWllsbXhuWnk3S1RQWktJYURMbUE2ak5IYzRuOG0rWWdL?=
 =?utf-8?B?QWFNVllydFBtdTRlZEJzYm1WRHRCSml3a09lYnM0VGY2bFRQbEdBOUxGQmxV?=
 =?utf-8?B?V2FTWTJFNVVKWFdFV0FRa2UvRm1jdEpxTG8yUS9pYXZPVXgyejBjOFJtL1JP?=
 =?utf-8?B?cWhxS01kUE81R2JJRExCQ1BUWW9HWlRQbFhaK0Z5ZlI5L0lSK09BaHMxS1Fl?=
 =?utf-8?B?OXpPQW5wVW9iaUpER3RIT0dFMitscklDZE43emtpRmd4RHhZRWIwVjFlQmRw?=
 =?utf-8?B?NGJ3WHlqMlV5enZncEhmR0cvRTlBOTVFOHkrZW5KMGlNN3luUjJrYjVBempN?=
 =?utf-8?B?QXJDVVFLZkRzOURpRmQ4Qk1iVFBGa2JOZ0ZJMnlGd2d0OVV1dGFpdU15T3Jw?=
 =?utf-8?B?aVBhaW5hUTh4aWE4bGk1MVFLcWw4cms2VzkwTU83TXpxZ1ZDVkF0d25Oc2FP?=
 =?utf-8?B?SDBtY25QdGh3NUcvbi8rUmJkbE4wV1gvakFJZmpxbmN4SS8xSUFEblNyNXFm?=
 =?utf-8?B?Vjc5ZlB5MXhsajhrNnpsV1VSTTlpWFpSWHRjQjNMLzJtcUE0Yk52bWtISE5X?=
 =?utf-8?B?WUVRbnVaSk1yY0pCcmZDcm1TbTgzLzUvMHVQdmJyMnZWZU5aTUdKYlRDb3JB?=
 =?utf-8?B?TjlXVEprcDNvaWJtVzhqdnp0elNMN1dub25Demh3Z1JmUEkxWmcxZ0dQOEx0?=
 =?utf-8?B?dHBxdzN3elBSM3dwRFRGOUJmSWRLME1mamlrMnFZM2kzYkN0MW4zOWFUVWxa?=
 =?utf-8?B?Y3RqbkNFRUdzUCtoRVFyQStZeW44eVZYOW1mMHh2NTlDVVgrWUFrc3IyNkNz?=
 =?utf-8?B?dXgzMEFyK1VFK25DUVBqVFBzMjQxMElWamJhZjRpSTBQTGJIL1RxQThLK2Mw?=
 =?utf-8?B?dnI0dXRNczZsNHJzUk1uNWo5Mkh5b0w2ejEvL2hEdGlZd0diTjhma3RYSXZt?=
 =?utf-8?B?S2dSQU1tekRGQkVlR0xQZXlDUXVDTCs4RlViODFqSmNtUzdDaHV1eXlKaE9G?=
 =?utf-8?B?VkU1Y25kdlJzMDdwZSs1dm11dnVEUXE0QnhjT2FpSFpXSXdoVGpWTExpeTc4?=
 =?utf-8?B?UlgwYm8wODM0QUl1NDNlR0l3ZTI1NTk3VG55eGozTzcvSGVGK3FFSmtSbE9u?=
 =?utf-8?B?elBiODl4UVBUUVRORVRpVFFtK3k2YTU1azcvdUtSOUt3cXNtQ2hWamcyWmJm?=
 =?utf-8?B?ajIvQ0pWUFBFcWU2VmhLY2hMSTNmSHp4blZqR1lGWEhkNDJLdlBHcjRlQ0tS?=
 =?utf-8?B?aGgxYk5WRCtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUZCOWkyOVNVb1ljRk93cS9jTmp1MTNuMzZML0I4Qm1VRFhSMEg3YkJPZnVs?=
 =?utf-8?B?ZmFCR3o0REZoS0FCL05mUmg2bXJ4N0R4dUptQnlPYVRwQWNRSldFMDIwZ1Ey?=
 =?utf-8?B?YTY0NzYyQ1diTFhWTE9nNXNqM0puMStkK204QVc2eDE1dnQxYW5tUi9URTNz?=
 =?utf-8?B?M1VBZ0h3bGNmSzkxWENQeFpjYXE2MDl6NU5FVU9UUXFWLzlPWEtpSE1rMlYz?=
 =?utf-8?B?MFkyR3hBb2NtZThZRlV5V091TmtmTnB0dHR2YW1zUTFtc2N3Z1FCTENwOXA1?=
 =?utf-8?B?SEN5NFhma2M1WFVvaFVpNVF0QkFkSUFiaFo5YlRUcUl6N1ZZcmxGWGp6VE9k?=
 =?utf-8?B?eGlQY3oxOGxoV1ZubjM1RVo4NThlNWtlMUt0Q0NaN2F2bGtvTm9RUEJTdDdQ?=
 =?utf-8?B?THJWQmFYU0ZoL2hZK1BWOWUrT1Q3RXRQRm1vSy9ORlhRWkU1allDVE5RZlVl?=
 =?utf-8?B?Q09xUnNocFdYNi9UUlhFMTh4OEYzeUNsRDBOYkNsZjVoQjdXaUtXUU9BVnY0?=
 =?utf-8?B?eGJ5bk0rSXM4UDZhSU9SOHN1VnVnaWFIck05WUF2TzZSOUlQSlVsV2sremY0?=
 =?utf-8?B?YW1tQytSRThVOUdxOWtuWGluNmZmWDVWZ21TQ01qNkZuR0ZnTDF5bFhEK2l0?=
 =?utf-8?B?UVdRQkZuOVcvaVl2SEw4dThnQUVGVWVYWTBjYU5pNHZodUpnMVJaMDFtNG5s?=
 =?utf-8?B?T1M5SndpQkg4R0dEM0ltZEs0ZmthVFdNalpFeU9STGlGSUZmUUFjTHZua1Mw?=
 =?utf-8?B?NWFQVDZrYXlSMldiVzhuWFY2UWE1cWppSHRuRU5ScVlPdysreFdaWUVDNWVa?=
 =?utf-8?B?enhvVldIb3dsWGpGeXdadUszVnNreHpmT0w0RFJXRnBLUzA2VlBBaVRWdDRO?=
 =?utf-8?B?cUQvU1NhUkNhWUFPRmd4ZitSa0VLRzRKSlcrRkY2WTk5VkJROW9jSGtGeVpF?=
 =?utf-8?B?Zk5pTWtHdFFtMHZldmR6YlZKRUh6SXhYRmduUlNJaExDMnB5UmthSkplc0VZ?=
 =?utf-8?B?d0xDYVZsRnIrVDVaa0VmZWhyU1c2N2ZmVFV4d2JxMkZqMFMyVnpoUkF0SjE5?=
 =?utf-8?B?dE9Ta01tVm40MnFHTUNTRVFyTUczMjdMWnlic1B0V2ZNNlFWSlJjajB0WDdF?=
 =?utf-8?B?RmVoODJKMVZKNy9KcFlRKzE2azg5cDIxdGt2UkpaYXU3ZTJFbE52ZVR5K0hD?=
 =?utf-8?B?bmhSZWxXQ1pXNWhhOUYrQWpRNmVVQmhFZ0Q1TzdoaDVGNTJTZjJSUzNIVFFT?=
 =?utf-8?B?aHNIVmtZMzNhclNDWWppQnVBZlZKazIvMEsxaDM5c2hXNTNucXdaMnFIRUpH?=
 =?utf-8?B?NSt1dDRCeUFJWDM1WHZ0N1NabDNqL2ZWcFJ2SUVMYVFwQnZtRFVHUCtYY24x?=
 =?utf-8?B?NG5DWk5iWUNmUURjalZrRVp3RWh0a0lmZGFZZldVSzdKTndCdUFGM3N2c2Z0?=
 =?utf-8?B?dG5rR0RrN0VkOEd3VU5EQnlYc0RzSy9XWHZTM1QwQVAxb215Yjd5eWJTeEFW?=
 =?utf-8?B?SjFnR0RpcTc4U0ZPTXkwMEVuRDQ2NXc5VXdFNVFFYWJ2NnRFSzJOaHNUcHBa?=
 =?utf-8?B?eGdFN2VoU0c5V2ZOM2huTmNYVVVOdytCdlhIUmhRZWRkTUtEd1J0SnlueUZY?=
 =?utf-8?B?QUE2K0tWM0tEa0o4blc1cFFWczYzc0VVNktrcUtNSjdGQjBHQklDTUZNRXJy?=
 =?utf-8?B?SVRWUG9aTTJuaWdZMUR6aFhSWUxhcU1VVkZESVpGbGIrUytHVEJLU3J6a3Vk?=
 =?utf-8?B?OXFPaHRaWWxialgwbXp0djladVdBVkdXa0ZBajUzdFZScXJmQTN1UmYxZHhH?=
 =?utf-8?B?VXlPNnBnV1VybWovNkNHWDZlVGNZclRTdlRKNzA2NGFRbmUrVXFzc3ExTVRv?=
 =?utf-8?B?SUJVTjRhUWxTeUFCYTF3aDh2bWpEMThBMEtQYmFXM3E5TWVzdnk5WGhVMkcz?=
 =?utf-8?B?K001NHdud2ZrYnVaRnYwR1hJaEFBM0Rva1VKS29xTWxiOU9uSkV0WDNGS1Rl?=
 =?utf-8?B?ZjZzTmwzRzNDemtJeFcrWmlaeHQ3MnZWK1dYSjhSZXJyS2YvU3hUTWxaeVl5?=
 =?utf-8?B?N3NsUDZ3eHhqWTB5czZidjJRVThYazRxQVltdGRGRmtjTG1vTlpJcmtwR2Ur?=
 =?utf-8?Q?Ub7/TUoZrucKQ8BVtBkv81gdw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f8b663-d1c3-4453-d07d-08dd4ad17427
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:22:41.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxgGS5Z2vrNpkFEPH+Y8e/bTuiVcY8j7BNJyRMx+8YkNNHE+r8oAI4d0CRAdaCy1dFAH+BQ9/N3fo9jGB90MQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

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
change from v14 to v15
- none

change from v13 to v14
new patch
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


