Return-Path: <linux-kselftest+bounces-36712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3966AFB8A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F054A1874
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF1021E08D;
	Mon,  7 Jul 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CpDakYP5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F418035;
	Mon,  7 Jul 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905835; cv=fail; b=qxooVu203N0Z47pZM7Mzl7oxRVhqJnlDlAhr7BsXmfDh2dTM7IKcsb8VgD7a1hEu2YfU6RjoNR2ugjwS+/ZmtuXveix2xMXWhjEnixRbC8MTffWh708/DuydZsjudjL+LXlwo7dtHhdpwvAcjXobqB4YhmR9o1qzJeo/EKSfDqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905835; c=relaxed/simple;
	bh=T2s2pyrfP/b755KkGWHF8dSguyig1LZ9iZRJxhyMWFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIpX2fHdMiKaL7x/J7Irpjxj3ZA7wOcDrmERg4johT4UhXRZPkPl33TXHuh/NIxQ/l8bZ47mowLh1vr8JCeq896vW91gh+5W8V0pVEp3rXrYrqaViQvWtWJn296HULIHJT3cg9Sj7esW2wMXIwLFNXzDhqgg2320JcSqi3jtVXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CpDakYP5; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjjdKSn13jpx34pU9CPTsCmfqQznzv21rYidJah7dlXOj/ljU6g6F+5NVUII2rW99g9DuA4aO+qp98SY7VhO1XjUTgi8Gh0rh8wLx10MbxmwKgpk7rpWaDCmSIryYZjNje/7LQSMu6BIcBT89LjFx0l3zsjbxzOUlYBDGvUYjCyo9ak0DEwW1ejAKLEQcnC6qPy2C3r3IXjsnlsbWmzujy4VukQkfgtU/AU7QF8wsclnn9XAGrBrARvm64o+6JiHV/I9nUKvTUYvuAd9Y61tQEYKFULijFF1t3YV4zrpY3OM0bf5ktdEj16Yg6ol5avVgUiBn/NMCUyY4oxz/pfgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VlnYGO+m2VMVsDiJuo2NyXJWz1uRLD1pmS7NZRGfU4=;
 b=rbQ+ZAMwsKscKxNT3KNmEcFlBhjQpaAYCOP2oPU1e4MzPnICnRZrkRPWR9PmvC9O18d1PIw9VXAdxRMSeXv687uovnh8DWH5j+13z+cxBSl/j1T9vKb6AJY7UM5woSJJ2S+qJnEWEw9+xTG+5ADlD5hRgRyEnUpYfFvHnFW7SBVVMcwnqlHvP5+BMlbRTCxYZ+Fl4wG6j+uct7lRyHscBEr58abm23Q4iWzhIyI5GVN3RzLbDk08MpzfLXBBOqDedDGpUCoP27nusdlYduniACwv18iUl770WYN3VBAyPZqy/E5+3I4va4DZhqnKfj/I57l/MIGnCaeYaO6b7fs93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VlnYGO+m2VMVsDiJuo2NyXJWz1uRLD1pmS7NZRGfU4=;
 b=CpDakYP5g51WBZ70O06wJisxTdtuRpLuv3keJtcJXHXP0wORmiIjoNy5Uy85x3n+7YjzQ2uDvO3si0ySTVjJo9y7PxDrnaG3Vt0+hZUR5+ciET03ic9cXUKWA5eLhi0L0d74MhwX4H7MvbYyajhJRoSwMh5/2qE2lXKuW4uPnMo03nlBSeHKdDPqbLQtvOzkLVEDIrS0kwJ3vZ6kI7eD9m7jAvBl1OlxhWXI3DoCpHjBWDZZuSREy3UZmxPjKbQHT52Q741z+o7TO78MhXFFG0proWBLSV799VRsfr9rCffBph/6et02aZQ1xLuBNXfb6i331M5UTPDb////MbTH+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 16:30:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 16:30:28 +0000
Date: Mon, 7 Jul 2025 12:30:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v19 01/10] PCI: endpoint: Set ID and of_node for function
 driver
Message-ID: <aGv2HWBAsZm6Fi+X@lizhi-Precision-Tower-5810>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>
 <ne5yrjtdevmndqds4uwo2ppq6gay2wuwjouyf33lqr5g3nfkwr@lkwqlwqjqbmx>
 <aGVE6veZm3bL0mVJ@lizhi-Precision-Tower-5810>
 <75opnvi46fbmsnmykjwn3gmir7r3uqhzp7tfoua42cado6aopu@dmos2v2qd3jn>
 <aGVN/5yoLumfmlDv@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGVN/5yoLumfmlDv@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 77005f4d-b8ff-42e3-67a9-08ddbd7395b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXBDdkQwdUJLa0phZ2grbjZsYnBuaGl0UkFqWmNxYmNWcGZnOHdKT3cycUh4?=
 =?utf-8?B?dE9KSklVRmwwMjZFWHEyMXh6UE44aW5YZFVvVG9aZkRNeVdkNEVrV3BkV0JB?=
 =?utf-8?B?TFVscXJXZzh5K0sremUwbXNmbnUxcy9lRlVIdUlyS2ozVUxqSnlaOXdpeVNo?=
 =?utf-8?B?cmlwd2VRYVpoNmF1MmlWQUpNQkVmOWkzclI0OFdzQ2xpWTUzRG1xWG9maEpi?=
 =?utf-8?B?aWtmcVpzeUVsY3M4MEh5K3JLS1BaL1VVZDJmcG5QUys3a2RXZy9pcUVVYnRU?=
 =?utf-8?B?aEhwQzgyL0lLUVBYSURVdC9GeHFOMGVxaW5lMHhhVlpNcE9sRTlDWlhrenhP?=
 =?utf-8?B?WEl3VWs2cXJMTHI3WkFBbk9uVU56VW5rUHlpMUlxTkRtaUFYWTBDaE1DSkZX?=
 =?utf-8?B?bytnNDJQR0IzR1A4bXpLejhBSzRESUozaXZpNXhTeGM0OXdONTlBZzR0OVUv?=
 =?utf-8?B?dlJ5MWZHc0J6VktORngzUERqRXVXbnJkcEZOT0pEVTgvcEVsZDVQdiszcTNa?=
 =?utf-8?B?TFc4TDdIQktGeU1aNUJQd3p0bENnS0dGK1R1dWxFcGZJWlIwMUdteGRaR2Zr?=
 =?utf-8?B?OEwybDgwZ3R3bHFScjVxKzRzV3BMdHJvckx2aytpMEFra1dVYkcwQWhjalU4?=
 =?utf-8?B?ejU5NjQzNnNmVEIxWlBKNjNLNHFsdzM0RWlOUjZHWWVxblltN2IzUTEvUFpP?=
 =?utf-8?B?bkN1aVN4MlBSY0krWW5SS094aFViTzlNRzlrSzluaHNNWVdoU2ZwQUV4Uito?=
 =?utf-8?B?aURVU0N2K2txcy9oaXBTcmNqMHdNTFI2a1ViUmNlelpHZnN3bko0VFU4MzZB?=
 =?utf-8?B?TFJDM09nSVJvVXpaU2pXbE8zRTBtdy9aaHJLMmtTaTVvVmNQRTY1a1JVYS9y?=
 =?utf-8?B?Q2RVRzBueDNHTUpmSDdHRVNzazBTbFNRS2RsSjZJamlpK01rY0NTQTJlODRQ?=
 =?utf-8?B?UTNGVVlnOHE0djRRNGV5eVRFWjlnZFcycVo0Y0xoRkgyc05LTmJDQ2trTkh3?=
 =?utf-8?B?MGtVVmdqRG5YR0FhSm11amtra3FXcElmM2p0UEU2YTYxUlBDZ2JBNkFpc0RU?=
 =?utf-8?B?cys1dmxjQytYQ2U1MFBwa2NFaEVmb0hhRTgzVmx3L3Bla3pyZmNSZHBHQ2o1?=
 =?utf-8?B?SGxzSStEelQrR3o5QmtzemlrcENoc09qOUg3SnZ2emJXNDNna0RQaU41MkRR?=
 =?utf-8?B?MHVEL25IZmxxQjNhSVdoMVM4RWpwTnBYY0hpSWVQY0paOTFHNUlRMTZ6bHQx?=
 =?utf-8?B?Umkvc1NacVIxbGVTb1hYa2ZJWGF0QllIY2Z5bGloRnZlOHRRYWxraDdMNTRY?=
 =?utf-8?B?bHMxM0lUVVFkeHNWOVZPdkdqZWFqZXIzWWtVUDg4VnNSWWFjUWlmd3hZRjA5?=
 =?utf-8?B?aWEyN1pBNDFIUXBnNlA4SWpieEZJOGd5SnQ3Y2djRGw4R0xZQmdqdTgwSjdP?=
 =?utf-8?B?MWMvN3pTMWVOdHowcUZmdlpORDI1aS9zczFHY3Q2QXl0Qzk4NHFxYUhsZFpF?=
 =?utf-8?B?SlJhTGJlSjV3elVUNERlalhkVHROV0ZudU9KazdENjRCWlVhOEYveGhpTmZ6?=
 =?utf-8?B?SG5VaFg5aGxGUnREY1BHYlE1a0lRRi9UYjc3VlBBR0xDOWZMbGZKM2lTNVhr?=
 =?utf-8?B?eVlkUnhML1Q1RkhhU3dGRWQ2UTdGNWJmMkpZbFdrOUpwM3A1QUttVEVmcW84?=
 =?utf-8?B?S0xRUDA0NWk1QkxkeHB2TG1PTGJCSG5PNXVvMng4c0t2am1MOG0xa0VwZndn?=
 =?utf-8?B?b2ZTOGxiblRkZDNYUEpEZThZU01EUTZrY0t1d0R6dUJUSEdScWVnc1VpZHEv?=
 =?utf-8?B?V3g5WDhLYkoxY0laV0JXRTM4cENFT3BjT1l5ZldBbEZCbWxUeDVTSmF0NXU1?=
 =?utf-8?B?dUI2K0NVWVhYTUVlVjJVaWw1OU9DOUo5UURwaFFsK3VEVFZERklHN2lWdFNR?=
 =?utf-8?B?eWRXWituUVVSY3F1NlFlRUlyaklxczRQSlVIb2pCYXU4WHFPUXFSTUowVWR1?=
 =?utf-8?B?THFwbXNPMVZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEpSazZMbHUxRzdiN3BGWFpRWU9Bb0dTYXUzOUpDc2RWYk9xVmRjVEVRRVBI?=
 =?utf-8?B?eHF1NlZvV1IrMmhrYVJwN0NpQWdZaE43Y2ErVFJydDVrTnoyQ0RNa1RITTlT?=
 =?utf-8?B?Nk1GWE1ZWlZwRFZ1VTFUYUdBdlRQU2Q3U0x6REdLL3IwMVVhV3ViV2R3TkJ3?=
 =?utf-8?B?VlNXS3FxckNwck5yZnFuUFk5ci9ZaUhzL1JIRUlvWGllQTU5azZubHhXY2pW?=
 =?utf-8?B?SUxDZkJXdXJjd0E3VjE3ZDVHa25FdSt1ZXFRT2luejNuNkJYVk43dzdacmRt?=
 =?utf-8?B?SkVLMnRQT1JCOGVwcWt4Szl4YjhxRGpHMjd6dGJJQUJob25CLzNZZ2I5bVFZ?=
 =?utf-8?B?cjdPZnRsb2pQNFBEUk5CNmV5ZnRtaDFidDZYTGczWVQrZHV5aWZqODBvR2V2?=
 =?utf-8?B?NjkvTSs5TWd4S3JleGttRXlFV2xWVjVweDk5TzNsTDlTc3IrMmJZbS9PRmtD?=
 =?utf-8?B?VWFmUXljSzQ5YkRTMm40S1RkQ3duMWVQT3l6cWNpSzFFVzhkMUNWOHBUVjg1?=
 =?utf-8?B?OVFQUitBSldiYXRQUGoxVzFpU3hPY0cvYWxFc3pjcERWUWNTS2FuQVVoaGVs?=
 =?utf-8?B?dlJLcVdaKzM4b0pTZU12eHZUMHo4WXo2T0lDUzNvVnpBMWVabk9TeXRjVkZ1?=
 =?utf-8?B?d2xBZWlXUTFWaWhaQWJyVysyOWJhdUZ2K0djUnV6ejNuQUtua2RaWFEycU5Z?=
 =?utf-8?B?eGwrZ2Vua2NpWW85SG1tUStMVDh2aktEMVROVWtjZlZXSHRQMS9jaFptTjcz?=
 =?utf-8?B?K0lKR2NFYytmYlhCY09sZ05BbGN1dUszM0VoZ1V6Ny80eFhVK0JzRTRjYXh4?=
 =?utf-8?B?RGdETGdXR1RocWROSjBlTEo3c3pPYUVIclRIK21iMG4rcDlKcjhYOW9vRk5l?=
 =?utf-8?B?aTZheDI3NkdIc0RPcXB2dzRBZ20vMzB3WXQ1amwrRGg0L0xYNDJGK2UwRFAv?=
 =?utf-8?B?N0lFSSthdWhXWnp1emx0U3BubXJJMEJHajRpUDNvQnJSVnNsVE5pU0NMV3do?=
 =?utf-8?B?YkRzN0tVdW9mc2JLaFVMemlXK3NqLzBJM2ZhU2Q1cUJnR0lqNFJrak9CeXBq?=
 =?utf-8?B?Z2RTSXFETmdVQ0VNd0RZejFOcmxJWnhRWFlRalVKcVEvK2JWNnBlS09ZdTNO?=
 =?utf-8?B?cS96ZWpac0NsYTR5ejRTQUYvWHFUaWd2UmRpaHlnbVdFQXhEVVlHc1FycmtH?=
 =?utf-8?B?YXV4cE5McmxKTFpyWldwN21VaXdJUmtyYXhHTlBUbFdOUkhNbG9udXRuSUJH?=
 =?utf-8?B?UTQ3eTFnTkxEWkFRV0h0cEU0UFFuWW42MExQc01OQXJXVEhkcnp2M2VIYTR2?=
 =?utf-8?B?bEJmWHE5a1R0RjlQTEpjeUhucEJHOSt0dVo1bjVLVnBuY3lZWXJLMXI0bjc5?=
 =?utf-8?B?M3RxSXcvekJHaWFjWGlRdlcxSmdQd1QwdlMvblEzVXplQUxBYUhTZ2pnOStX?=
 =?utf-8?B?dnpmVzhDS1dTbm1IUXprdWFQM0d2bzVRSDFZbFJYanB2MFJYRldnNmwzVXF3?=
 =?utf-8?B?MWVPcFVDejFwM3dPL1c1QjZWYW02bTNDSXNNdTBBaTVvKzRKTUZncEQzTTJY?=
 =?utf-8?B?Y1hkbmI1aEVSMjR0VXNHTGlkaXM5MlltMFJyZTZnOVBwSXBoQThCMHNGdFdV?=
 =?utf-8?B?bFl0UlBRNmNXTjRSVktIZGs2MXBPTmpyOE5pQnNBaGttdFVqMmorQXBVRi9H?=
 =?utf-8?B?bVhzVmRaY3ErVFB2Q0VzSFdFbFBaT2JrbTNCZUlNUFRBQmNzTzJXUVNhaXNo?=
 =?utf-8?B?SytRR25qVU5jMnJuSFMwNGVzamMza2FLRlA1REZXUHZYWm16YVJ4dDNqSUVl?=
 =?utf-8?B?bGFVSnl2dU5kME5WK0dMNjdIM2ZsbGVmTGk1QS9UYU5KT0IzZEs3TkVENDBD?=
 =?utf-8?B?NURJZVQxUU1FSDJ2ZDVCbHhBZldtaW1BUHZiNGlsK2dTWjZwcVp2MWxhWmll?=
 =?utf-8?B?dGFUeDZCTEVDbkFEajFsZ25td2ZibENNNTBuV3Z2V1pXNll2akJhS1JsdXcy?=
 =?utf-8?B?ZVMyUTF3eDVjMGlwck5IaTFGL2xLcHVjRG1IOEVkR1J5N1JMbGwzV1NFMU5s?=
 =?utf-8?B?anI1cFVsRWxYU2tyVjNMN2didzcybEE0RUFTdzRpWFNDQ3VFMUVQZGNESDh2?=
 =?utf-8?Q?8O5Iuk6OR80dvmVOtUK3Lu+pc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77005f4d-b8ff-42e3-67a9-08ddbd7395b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:30:28.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2wwEKmDTWtRzNH/MfXtjvBK5XNqXuv9qIL9Mkx4fDv+WtawcNZMkodSiRV36kA/0Pmre1wDR98+eYevIVyeiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496

On Wed, Jul 02, 2025 at 11:19:36AM -0400, Frank Li wrote:
> On Wed, Jul 02, 2025 at 08:25:17PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 02, 2025 at 10:40:53AM GMT, Frank Li wrote:
> > > On Wed, Jul 02, 2025 at 04:30:48PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Jun 09, 2025 at 12:34:13PM GMT, Frank Li wrote:
> > > > > Set device ID as 'vfunc_no << 3 | func_no' and use
> > > > > 'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
> > > > > device.
> > > > >
> > > > > Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
> > > > > settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
> > > > > functions use the EPC's device node, but they should use the EPF one.
> > > > > For multiple function drivers, IOMMU/MSI should be different for each
> > > > > function driver.
> > > > >
> > > >
> > > > We don't define OF node for any function, so device_set_of_node_from_dev() also
> > > > ends up reusing the EPC node. So how can you make use of it in multi EPF setup?
> > >
> > > In mfd devices, children devices reuse parent's of_node
> > > drivers/gpio/gpio-adp5585.c
> > > drivers/input/keyboard/adp5589-keys.c
> > > drivers/pwm/pwm-adp5585.c
> > >
> > > multi EPF should be similar to create multi children devices of mfd.
> > >
> >
> > No, they are not similar. MFD are real physical devices, but EPFs are (so far)
> > software based entities.
> >
> > > > I don't understand.
> > >
> > > >
> > > > > If multiple function devices share the same EPC device, there will be
> > > > > no isolation between them. Setting the ID and 'of_node' prepares for
> > > > > proper support.
> > >
> > > Only share the same of_node.
> > >
> > > Actually pci host bridge have similar situation, all pci ep devices reuse
> > > bridge's of node. framework use rid to distringuish it. EPF can use device::id
> > > to do similar things.
> > >
> > > Actually iommu face the similar problem. So far, there are not EP device enable
> > > iommu yet, because it needs special mapping.
> > >
> > > Prevously, I consider create dymatic of_node for each EPF and copy iommu/msi
> > > information to each children. But when I see adp5585 case, I think direct
> > > use parent's of_node should be simple and good enough.
> > >
> > > In future, I suggest add children dt binding for it. For example: EPF provide
> > > a mailbox interface. how other dts node to refer to this mailbox's phandle?
> > >
> >
> > As I said above, EPFs are not real devices. There is currently only one
> > exception, MHI, which is backed by a hardware entity. So we cannot add
> > devicetree nodes for EPF, unless each EPF is a hardware entity.
>
> But how resolve this problem, if a DT device need phandle to a EPF? anyway
> this is off topic. let go back this doorbell.
>
> It needs an of_node for EPF device, I tried many method before.
>
> Create dymatic of_node for it? MSI framework still go through to parent
> of_node to get such information. not big differnece as my view.

Hi, any idea?  how to move forward? we can dynmatic create of_node for it.

Frank

>
> Frank
>
> >
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்

