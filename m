Return-Path: <linux-kselftest+bounces-26044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31203A2CCEF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0568C3A2D3A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076FC19DFA7;
	Fri,  7 Feb 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDTHJxCp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987131A3143;
	Fri,  7 Feb 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957313; cv=fail; b=klCPS3J2KqaDq/jZKsKpjs6V1n+ytSHYLJAfxhuvAdXUPmHTqQ1Ci9zdZ4KLwLvgJoNlZEmsJLUIAYn8dmRmKTxJpX7o1cF7uhcyKIvl1mOXwrdUMvkNa/WEnlKqa6+4B1NoDkY3pEdmRNtLtk+Xwx6Q/m0FS8kfKzUdAXHhd5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957313; c=relaxed/simple;
	bh=oN0Pxva54y+kREmFI8Y3KVwAsrcH8/SuevTvoVVNFtQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NK6ajE2i06xidXN1Vv0NhlI/yNHe/Aygkd9Svd2dSOheMMIpMujocsrKkVF7RQw7pMRBg3PTkpya59xkxQoBfkp68AE0Eh1wklix+yOn34Y/8K1t5apEi6tPbVttgLqvWr8yNvMzwZU5xhdrAlsPdOH3M3TcoUBXFJfX7R3FWKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RDTHJxCp; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNw3ygOJ1ZfP0mVpIUzXp9+p2FTu18osspXj3maX2zNbGw4vU7JZPV+GjeXJ6QgQmADYuIsylEuQ+cfXXFKLBVcO6i2DbeEyeepEHBUr9a0bIrpH2RS1Sb5FrC7XbxfA2on0kqSgb/h6fzKu4pFnQOhtc0XQXmwQ4+AjRQjJjiomZv2IjQsAJN192jOdTfhCjefgHlHtWm6ECr2N8Uk5Rr+VVxfSHRHGnUaKEWBToarA8IxWIWJjzkwWJI20m/CwlXHeojbTVF9qRY+NurdZwJ14NtzqE49bC6qGCcxBVpGjJvJx4wrKUEElUx+PwANnW23eJp3Fa8GS4IMeMBJllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9X+knquTO9ej4q47PyzzFDdPAOxwjpKgKMQpW/RBiI=;
 b=uqybQ0Q3nLLAExw7T7socxMKtfzUWxQ7JZzR4zgNJVUwCQolbtuzxsVw88KwXYwLQSDRmtzZR1SufbtmjmQeKLVwmEQLL6FI5sXrEpbYSia7b/kbeyObB6V32o/aNYAq26e4YYzaV3sEqOHS0PcXfiMW2+8Tq8eJHhczPeA9H4tiReuwo7Es6fYC47BRoWt22ZWS19YcD4AnUfVNrRGPCOtKew0i3ZobKmCPmF0jqM721WNdkKZmhOVGlrQga7N6D9CZjqx7DF8Bd5cQZrqOKhECuBB2VfySKaKUoKJXgaw4t7zs0pwbbKru+nRrXKjNj8lelvdlYQsQ1rTA7zwabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9X+knquTO9ej4q47PyzzFDdPAOxwjpKgKMQpW/RBiI=;
 b=RDTHJxCpi6DMakspRocnB6DDSw+ESvEj/lHMyYixWQ0l+BhXncvLY6s85zic05+6+9LaLM60daeManF9xA68pxWX3GQyZ/UnslvlANTCydyGQQ/bwA2XkpkNzAmTcxSnXWbdPMLnPnjKVk/uYBnuGATcXB2STYIqeuFjRMisXiYx6pcGOxx+w1T4O/JuBWwFxTk2U4B+vwgq6f+4AJItLCUvUAyzNw0ovg25kIOHWh9F0eyntUYEMQFlagR3Q3uZsgxN3KBDcS9CO4wQe3AIp58gMriD94V3JDE6Dqsc3uwMPntag4ARPDaPX2RCL2TBplT9hl/+cF8xTAyJxwsugg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:41:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:41:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:55 -0500
Subject: [PATCH v14 13/15] pci: imx6: Add LUT setting for MSI/IOMMU in
 Endpoint mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-13-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=1452;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oN0Pxva54y+kREmFI8Y3KVwAsrcH8/SuevTvoVVNFtQ=;
 b=Tkoj5Yfjky1aQVj0oiXNY3c5Nb5ydpEKX8yeKfFmyBTbAVkBjtwG9MzFYoFA5pjIywVNMHSyM
 AEeqvp1c3RCAfWHbGa9k0qCpqCHBiafGZcy7YMOCT+mu8zdpZ75QWUm
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
X-MS-Office365-Filtering-Correlation-Id: 14b508c1-9d98-4761-2c85-08dd47af7677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2N2WDBkaUlUOCsyVlRjVnZXV0ZVZlNPcTY3TVVrWlZwZlhUVGxDa0RORXpS?=
 =?utf-8?B?TTJrMHJRTXJRR0NNdEZHdDRnRi9tbDlWbE1zRUZ4VHUxWXdHRXpMV1FRQndl?=
 =?utf-8?B?Ky9LQ3l4ZjRQT3N2cXY0NDFFc214VXFKQTF4RGVUSHBvY0NDWWF4MWc2WU1t?=
 =?utf-8?B?a1BRZWF0MGVZbUZJVkpjUlNXVmQxMVZmSjFITytOcGw0eS9NN2NNR1hCcjN1?=
 =?utf-8?B?dHdFV0QyVUtadGN0RDdjeVczUUhJb0FROFIzbHhOQWo3Tzc1OE1ySDl4eUpW?=
 =?utf-8?B?SlhKaXFsaGhBd1o0T0RsNnZadjNQU2RsQnZFcitBUCtJUVdLT2pEWGhRU3R3?=
 =?utf-8?B?a0I3eDNrc2syTTZoWkI5WUd1bG9TWlpJdVNveHZCRnM0MmtSNWovZXZzWk5N?=
 =?utf-8?B?MVFGL0FsZ2pEY1U3R2dMckNwQ3BJTlVNVXJkeERnb2tpbFREWmwxZm5jZlpm?=
 =?utf-8?B?RVhKUFBhTDJNUzJMQjl1UEVUek1pTnpja2ZLSTgxRXQrVlFFMVprMFVLQmJa?=
 =?utf-8?B?dHBmSGVoZEFwcklEZzJONkE4eWRHdUdISlJQcGZGUER0eHVKdEtqQXZuMjVN?=
 =?utf-8?B?REVuMVV5TDhMUFY3MXE0K2x4T0hlZ1hLc2tQblU1Ky9tMGQwOUdQWkNYbXZn?=
 =?utf-8?B?bmJDTlR6UGpYeUI3VTNsb0lVdGFDYmpTbHR6MmdlQVp2U2lwMUlmTG1jMXBs?=
 =?utf-8?B?WFhLS09SN3E1OXhreGRyOHV1R09KeFBWcWhCeUEvNlZqNnlIb3JsNlJaelhK?=
 =?utf-8?B?NWdDT3V6cnBzWlc3QzJUZkVmTGdLR1NYRkgwVkRKZnBzSFlxaDY5UDIvQ0VN?=
 =?utf-8?B?cC95aW5CK2w1ZTY4OG41cldkOFlnMnlDdEdaejkwalhCNEJqVG4xUUFHWlky?=
 =?utf-8?B?cjVtRG5lNGJzVVgyTmFiaExCbjdEeElhOURSYldSYjJOaENpZnJwZnBWdHFm?=
 =?utf-8?B?OGRHcFdXZGNrTHpnZVROcWRVQUtBTUxjaTRkZFp5aFdGQ01vcU1EQkpHVnhJ?=
 =?utf-8?B?bEpHSlQra3krL1NwMGxlTzl1ZnRQNkdNSUhuTnRIK3RNckFZelhCOHF2WUMr?=
 =?utf-8?B?Z3FOcmZDUmVKUXNWc1ppZmxldFAzeXlRdytaYU1TWFhmcjFtNUtjejZnTzVj?=
 =?utf-8?B?ay9JVUMvZHlJQStXMlBUTnQwK3lxS3MwOWNEY1RxejY0UUd3YzZNdE4wVnZN?=
 =?utf-8?B?RWZmREtsNXpNbk94aE44R3ozQnpaWTduKytvWG5zSEdRRWxlQU5KOVBlb2hJ?=
 =?utf-8?B?U3dOSWJPYUdNVUE0V3RiMmJkejRmQTQ4Uml4YjRNWE5tRStqL0tUS0tRMDZj?=
 =?utf-8?B?dVhqY01IMmVIYzFtcENjSHFqRUpSQlZINlRGaC9wdmNzdUpKVTBGRlFUUFZw?=
 =?utf-8?B?YTNwcy83bFROZU1jTzgrMVFvajV0SG9JMXgxUnc0ZEl6RWpwS2ovVlQrM01u?=
 =?utf-8?B?NzdIWEl3L3VuMmh5SGZWK0J4ZEVUM1RwTHhYVUlCNTRCQzR3bitzdHRqVkZW?=
 =?utf-8?B?elR0dU1uMDk5OU44QUp2RnlTSDNFNFVQeGFBWnhNZ0I4MmNuZ0NrOVJ1bEpQ?=
 =?utf-8?B?eE84ZlpXQmtoOTlsUERZcUNyQkUrMFBQOGdzdGJ0Zmlvb2lpalhQZE80aG95?=
 =?utf-8?B?SzlGTUF4UGl6emRQbjBlSjc2UkVQSHp4eFJEdUh4L0JLMUM2ZjlvbU5UU3hX?=
 =?utf-8?B?RXJSdmhjR0FLMnRadWo4aVFzcUNRZmVJMk5mMVY2Q1EzOHpha1VnMUNHU1NB?=
 =?utf-8?B?Qm5oZ0dRamQwLzg5akw2OEFZNEY1a2pFTjIvcHpzMktYNC92N2Q2TE1PcUZ5?=
 =?utf-8?B?TCtvL3VRenZTNEJ1WTVuZVFSWUVnZXp2MDhVOXRRd2puRUFmeDlMYU1UR1BC?=
 =?utf-8?B?QzRBTlFYVGdxSlZBakZQWG1KZVlad1RGaVZHZFRDRVc1cFVKaFBzTVpKdVNG?=
 =?utf-8?B?YmV6M0V1alJSeWxlQ1JrVHVOYk1iUEdvazMydDBDU0hvekUvSVZuYWJBU2xZ?=
 =?utf-8?B?c2NOdUV3RVRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzMwb3liRkh1VWF3MjFQQVRmTUZiaGh1MzJFNkRBeUx2d1FUR3oxUUtmdFBL?=
 =?utf-8?B?aVJWRVFYQmN3M2pIQ094Y0I4dDhNZGk5K0Fvck5MKzlCakhibmp1RERGK0Yv?=
 =?utf-8?B?U0hPSTJmME05enlHQTdOUHQ3OU5Hb0pQQ0ZLRXRNRkRIeG9rZjBTYUNCdHVo?=
 =?utf-8?B?TW90bng1WTlzZkxvenhBbEgrdlZpeVUzS1RSS2FCR29LbVRiMThDclA3aUFs?=
 =?utf-8?B?K05PWTlISXhWUW9PRXZicTA5WHNYQ2hLTnB4VnNBdDZFN2EwT2YxRDBmNTMx?=
 =?utf-8?B?anUwRnlHTC9wUjlzaDAwTkcxZFEvYld3ZWJmSkJzbEg3akwyV01vTUpqb2hR?=
 =?utf-8?B?REJuQ3VNTURianhwSVdmVktWNzBJdHAyb1l2R2duekROOGxoa0VVaFRiU2hS?=
 =?utf-8?B?U2N1eGI3NCt2clVaT3dvMGxwRVpUNEtaYWFDQ3RPQ2twRUJ0cmRnQlVEcUJl?=
 =?utf-8?B?MDVEYWlVbHJkcVUzZ05zd3JxWTg5U1MxcTkxeEhLSU12dUphVFlZQWFjbTUv?=
 =?utf-8?B?NWpxbkxuR3kyWGttK2pvM0RiYVE5R2o2VzBNSDZwbFI5UUdRSkRTTGxENFJq?=
 =?utf-8?B?NWR4S1lMcSszZlpOWitvQ1ZpNDlpSTJxYzk4V010aUc5aGpMcXFhbEFGM3BX?=
 =?utf-8?B?YjI1eHFFQ0lBZTJNMGJJUGlRLzRuYjd3V2U3L0piaFNJanUxeTNIR1VTbEV1?=
 =?utf-8?B?OHNUYmFrOHM5K21nTk9EYmZ5dWZteGthbnRCY0xSRS9oclhRaHp6TXVqUitw?=
 =?utf-8?B?QVp4TDJFSDArRkRiSldSckQ1azR3RlZ5bmtobVA2RldvbnlXdDdhNTlUSWQ5?=
 =?utf-8?B?NmppY3ZkT0Y4dTc1L3dmMDRMVFVZZ3hLUklMdGJDam9WNk9jTk8yYXlQOGRm?=
 =?utf-8?B?V3VCN2MwUWdxc0JtRkhEK3RhQldlWVRpUGlQR1BnanBHc3Y0Q1NJRVcwdCt0?=
 =?utf-8?B?L2hCYkJsTTZrY3NTZ3ZsSjNmRmhoK3B5ZDRBU0hQVXdVNFFiWVM5bkZpaFF0?=
 =?utf-8?B?aE9QTE5JMkcvWE4wQjJPdHRpM1ltUndtS3l1S1o5UUpoaW9JaE1wRW0xQkta?=
 =?utf-8?B?SVB2Y1VlRUVhUWp1bWxlSVdQdWlZQURqQmZjSHdYZkl3RjRIMUp6VHhqZ2sz?=
 =?utf-8?B?MkZPSFhBRjI4Z3NMZzZEekxtMmNjbzNJR0JPaWJ4c0VLMDRQUFlweDF3LzJL?=
 =?utf-8?B?blU3ckRaaTBpL1k1V1p1RXJmc0pPYm50dTUyTDc4Wi9jQ1dmWEJZQnVLZTBZ?=
 =?utf-8?B?WDlRVmY1OStNS3dOdjBQSjFCQ0dIeTJIelhkNHNTK21BT0lOQ29XYld4dWJG?=
 =?utf-8?B?dDdDbUNZbmQzS1pMQnBvdmx4R1pnTEEzRGVmcythdDFySjczWDJnWlFwYUJN?=
 =?utf-8?B?dzRKNnlKTVp5ZzZ5ZktYSXZkYm1wV2U2QndJZnpsM1NuczVnL2M0akIwSHJB?=
 =?utf-8?B?MDhkQ3hxbm9LbG1YeUFKL0w4enNCUzhVanhyMksreGZRSDE1SUhDS2dLQUFt?=
 =?utf-8?B?SXNlckFuck9Famp2eUxZTmUxTDh6dnpJWml4dm52MTlwT2pObTVDRGVBbkxU?=
 =?utf-8?B?MlpJRUh5UzBZUTZsOU9iWjBIZnlUc0gvOXp2WGVqOGZhL2ZnTGRBeGN4K0dr?=
 =?utf-8?B?OXJ0dzhscDNaL0xNc1FaUktBSGIwS3lkNUYyei9ycVRudHB2RjR4dVh2cWI3?=
 =?utf-8?B?NzJWNUNMdzhmOXFtYWpzRHk3OVprR0dZV25yaHZ6My83OWN2NFZJME1ORGFl?=
 =?utf-8?B?eStyQ0JWN0ZqNFFmU3dKaS9SRkRTYzVGbG91bFN2Yks0WGxhNW1wOW5MQi8r?=
 =?utf-8?B?WWtlcHZ5aXJlc0QwWFR5dDhQRVkxa3lrb1FZRW8xRXZxSmFMNllkTkpmeWlT?=
 =?utf-8?B?KzFSK2MrYWRFak1ENDN2enRZalkwQnBKMjVoTEI1cmZsem0xT2Y0Rm0velE3?=
 =?utf-8?B?RklTM0VtUm1rSTk4OFF0eTRVcFR5VTlyaXR1VnhRMUdFTFhrcUs3RXB5Y2o2?=
 =?utf-8?B?K3kvMnNRZnpQTldROGViL2Y2ZTVDVlNWQjlGby9QUkhvalkrdS83MU1hOWhr?=
 =?utf-8?B?dXVWNXRJZE5TZjF3eEVIRFZXYnRxRkdXSWVVK29oRlFCN1FhNTg4UExqMFFx?=
 =?utf-8?Q?9Ag6YshCUEIZEyoHPAE37AFCd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b508c1-9d98-4761-2c85-08dd47af7677
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:41:49.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBnSJVmKnKrRETgaLipxALeL7bZhVFVd8iPNGY2yXbKuVJd+TRvl43GtF8I90uG5ZcT4mhqJjOsRKRrCRczvCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Support only one physical function, so call imx_pcie_add_lut_by_rid(0)
to add a single LUT entry when operating in EP mode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e20d91988c718..adcca3e644332 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -995,7 +995,10 @@ static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
 	data1 |= IMX95_PE0_LUT_VLD;
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
 
-	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
+	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+		data2 = 0x7; /* EP side's RID from RC, only 'D' is meansful */
+	else
+		data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
 	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
 
@@ -1652,6 +1655,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
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


