Return-Path: <linux-kselftest+bounces-30315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9840CA7EEB7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2363BDFE3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9672566F6;
	Mon,  7 Apr 2025 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fNtuPEvm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A2256C90;
	Mon,  7 Apr 2025 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055537; cv=fail; b=PbguWosLxlz/Tmp8I63+KcNZjNHS1eAlzixbpDGpHNJqoVL8XU91yS8L5993qCjS57xvWHZ2InmiCRROeb1/gffUN2fRf4O/OzYL1MZ0JrgNP1BhA89+IhG+nQ9vUYKdwwDTrppvBs6fMnGHXj/FS38SjGn5KMpr2j+hVMcU3Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055537; c=relaxed/simple;
	bh=Q75HpsG7AQZeyq/78WIzVSdGpQ6JBJuHxf6b6uNsmfE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V/+6n82Q9kNQgBX8TJQ6I6kCNwLCdjworoHFvRwlPiC7XYw/yxpiclS0ShgYQ9p4wjoKXJVxJMSHhVyM4ZPJiwkAt9Ig1UbjB7TboGg9bOfrCjkUD3xnx87MqfW0F9/Uu3fO7Ilq3dgwVfeXAJZ5Rt2ZH6VcMiZmSpRd7GV6Nq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fNtuPEvm; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypHZ8S3TNF7HQpIXRFvjoJSyvyfd4d+Yy0yniKndgvdJmUNCxBQUmsIHSFC51rBhmc2jM0v5jiEPXOIw0UrePl0Dezve/eXPex0ByzSYYQGrr4QRkB/w5Gz/GkSLUjS+22XHflhdq4u3tqYHHfFGLLljH9M0ONQkBlWgYDpnHXoHEJLPazXysugdM4QMz9YlknpkS9HQLZ1PciXFhhFx+jwGRxT/0Q7qTTgHznS25qLenBgIiFyeM6v0TEy73AICe8WOXagewT+fDvYGqla/lqbNHoseEp/ruPjy0nxnFvktELEubrBT9RMafwoUdqYs6wLoncBZblEngFltRHjjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8Qp5FfqRuQHFYCFtVEMJWoCYl4K1g4dfDwvdzdP/uM=;
 b=mktFofOzYEeE5xNcYY2LXJ7r6I9bsK6llZdNHBxSDklKTHOrtuKQw0huN9ho+zI9nHHVY2P7f5yDnvgxtdtFCoL1ra9+KF7YquYtEGL0RUXW1nA/ezPy9gsibvIYixnlpZ7kAF0UkG5WzFZcXYYxbFP26nZqASbwPAkhOj88E5DZtzAyJ7bs0wC+dlx6uhBTbSrwGhUYOLOi3+qqMi3fijNxgpZ/1gcExvpHrafNgeUACLD8akghaviJUcoq+m3FsFktZ1LYe65daClF0eIEwbZmBxGDJCHuLlnitMMH0Fdy4U4mN2b3LGvJjkXyfSn8MkAX9DL0Lj+FIv/HUe98ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8Qp5FfqRuQHFYCFtVEMJWoCYl4K1g4dfDwvdzdP/uM=;
 b=fNtuPEvm2G8kHCGS3shUXjG9PS4ygnYCKMfWM1Xs1fT/pizXQVO6CqFkIK20appS1fYcyD7F7xWl/oOc7pl25mopfFtXOKBN+bWCkep+OiyDq7CWCtGtqV4l9GZchM1JEWl4zFLSUG3VBbhB9ksFnzC2OqfQ3Uh8eqsQi5wpMZJ7/pv0QEiRs9R9S4daYpOND7IRvrA3w3DHNU9cIVbyracHeLnH7C5LE4aINybIUITMua5H6cSDCqq2uk4DfZuOTcDnsTKS4TFOv27bk7cKdUwaNuTj+YJQTIr51N2xI8s3wdL3nqvmzLPHOEordqwyAvb1qlcgHi9ooOg0IMq+cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:52:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:52:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:51:01 -0400
Subject: [PATCH v17 11/15] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-11-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055468; l=6407;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Q75HpsG7AQZeyq/78WIzVSdGpQ6JBJuHxf6b6uNsmfE=;
 b=mliM/Q5aCS4NzJ3tRmVPyAgxfZb08QVmxcdVK3+/7GN+kHsiKzL6RdwWBwR67l+FHZ6cj5kYa
 O1H4DMIdy/VBBUITOGa1aKQZ4CVFLMAl1GZvxTFjenin0AUWpqx1R3x
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
X-MS-Office365-Filtering-Correlation-Id: 27ef522e-e225-4968-7a6d-08dd760db027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHRtNDVyYVhhZWpHU0JYM1VnZlNWbHZYRXZIOFpUbHRRUU96ZllJaE83ZkxI?=
 =?utf-8?B?K0F0S3M5QjRLNzZPT21KYVpIV0JWdFhla1czRDFYYm1NRmJKTitNUWhIVmwr?=
 =?utf-8?B?SkNEZUJzL2FlWVJ6NmNTWUNVUW5UeVFJL2JCRDI1T09CK1RQR2pYK2w5U09i?=
 =?utf-8?B?K3RHTzBOWnZDUnJwMzJxbHRucS9ZYXF6dC9WR1dXL0JiMVhvNWxaZGJuNC91?=
 =?utf-8?B?bHl4alZsemcreTJwTlpDc3lzWWdoN1A0UDBOVG9SMHZYaWltR21POUxuTmRH?=
 =?utf-8?B?V1V5cjdWY1h1UmlmL2prQjFURVFrZC9LZ2FoODRnWkVDZnEybkFqN2NCVTV2?=
 =?utf-8?B?OEQrMjg1RDNXaHJqamJDVGNJaEQrQnNZSi9KYlF0WE1YV1VRTk5GckpVQUFG?=
 =?utf-8?B?dnE0QTZsc0JNRFhvaHFpbUJIRmRLWTJrMXVjb2ZCUjI0cUd0MVdXWWtyV3pT?=
 =?utf-8?B?R2ZYMDVFN2s4SXUyOWVlVWl0ZFBxaHU4c05rWDRSUVNZbUE0b2NzR3VSaGdT?=
 =?utf-8?B?aGU1UGFrb3BLK09CVHRKaEhEVHU4S1U1Z0dqeEh6OFdlemhCY2VYTmdPelhz?=
 =?utf-8?B?ZkZmMWxjV01CK2RRRHNxa1hETTN6M0R5enJsL3VPck9TOTAxaXRpTUVMVDIx?=
 =?utf-8?B?SFhNdDhsbjZ2bzdiNFp0a01mMkd3V3JXWjdUSlYvSkpCdTVJUVNTTXVjWisy?=
 =?utf-8?B?SXFTR3EyWmx3aDRkc2cxL1F5TmcwMU9QVnh1Vm9sMUthaDNjTnhkbXVCZXdh?=
 =?utf-8?B?ckxXUXBETk9kazU4UGV1OEx0eEtra2JZb1hoV2M2QkpIZWNMeEdmdG5lZkZk?=
 =?utf-8?B?Y3FkQjF6eXUvWXJNRVZESUt0dXl3RWF4K01mdnRieVY0NTZYM1BINll6RWF6?=
 =?utf-8?B?TmlaVjBaQjZicXBpbWlZbENKbFl5NStRamdxdHdzTlZuQko2dTVRaEM2UFdT?=
 =?utf-8?B?Tzk4dkRPYVYvZHJTM3R0Y0tlWk03OGhNS21MK245Q3VEQW5yR3NkbFdDUCsr?=
 =?utf-8?B?d3R3OHZCMGhkYzJCQlRZOW5WVGpnb3oxUS9FalFuam9yYktOdk14VkhLUVVx?=
 =?utf-8?B?UFdJYjJ3eXpWY20zRjVibGVCQk1JbG9OeUtmRGNqNFhJY21nRWRDemFwaUEz?=
 =?utf-8?B?clo3Um1kMktzVjVnUnFuUFJTUzdrdTh3amhCNUpHcHVsQWxTT21uYzFyMUtG?=
 =?utf-8?B?d1BESTQvVWRMbCs3aFRDd01WZlA1czZFQ1daM2xwZmpBb1FsaHpSK0xyemdK?=
 =?utf-8?B?TllzMTltOWIrZjc4RHZDTFdTSGFySWlGREZwTnNFOTBQMEpNeks4bDZKSU11?=
 =?utf-8?B?ME9mNlM4RHJucmR3bHowaUtmdUZZdklYaGlkTEQzcUJabm0zSmdzVUhxNzZn?=
 =?utf-8?B?djc1ZUlNNmJjTHNxN1NwOW1hRWNxMExjSlBTSUlOeEhLZ3IwV0Joc0t2dGVx?=
 =?utf-8?B?NWFLS0RaNlpzdFNQdUg4czArVnpieUZGQ2lQUmlTdUN2Um5ScVZ1SDFyMVcr?=
 =?utf-8?B?dzZkNG1rQ2VzMzhXYUYyd3dFL1lwVDZzYzUrTHVKV1ZpVzBxTks1blpRdFlu?=
 =?utf-8?B?dWZqMURtM01TKzFyWjFPbEVBRnhBOE14WWJVckNEYUNzZXpWSmZuZWxCUU5I?=
 =?utf-8?B?clFqdm9pUGlBUzdLaU8vSXEwZkptcmwwRkxsSzJaaEVJMmNDcitacVNCK1BS?=
 =?utf-8?B?M3NadFE4WnM0bHdVRDl6NEdMSWdiWkkySXZweGRvMWFZZHlpRlpibGhBb1o1?=
 =?utf-8?B?TXlPODdUOXpjbzV1b05hWDU0czRveXNSMUhNV25HVHhYTzV3R2FtRTRUenho?=
 =?utf-8?B?NStqNnVyV2Q3elZaeDREdm1MaWhmSWVONm1HaUdhWWxEa2N1RGVsTEdYcUlx?=
 =?utf-8?B?TFg3Y0MrUjVaTjVyVjJqV09BVW0xYzZubm9KVjNMYVVsUy9Bc2hiSFpUNkdv?=
 =?utf-8?B?bytQNmtWVGdMUDJMSmMyS1hwTVdENERVK3pEMHdMczBPc1p6MGN4Z1BBTmV2?=
 =?utf-8?B?bVMvZnIxR0hnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDlYZGZ3KzJXVjdqNnFQMTlzNWVNbnZCNHlZeHMrWHlkY2ljWUcwaUwwTzdT?=
 =?utf-8?B?V0U0bDJsQzRsWEh5M1JJdjZJait0ME5qM3g1ZFgwMjhWajZrdldkRmxleWJI?=
 =?utf-8?B?SEJOTDlteDY5dHN6RTJtRUZkMHVnVXZNbDZlWUNmUFlpWXFyUzVQWXRyOXdF?=
 =?utf-8?B?cGZCMzUvRWZiN1dRODdOdWRDNTFhNzNZNHB0VVUwVTY3VGxhOGRrR2RWYU0r?=
 =?utf-8?B?djVBMnFDeGRXY1lwdUxSa0dzT0RKR1RkRDBYYXEvZWluN2NuQzBsZ2ZKQ01Z?=
 =?utf-8?B?NFkxWFBqanB3Y2ZFNnFRdGNicEkyWGF6allqZ2cyMVlZRnFTMTZmcGRqWHdh?=
 =?utf-8?B?VGFCUDRZczc1R0g2TDZqdjlxRU9PazlrM2xqbHEvbGZJdzFCbVlPUFlJNVJM?=
 =?utf-8?B?TmlJdHRZTXhQSG5iaWpoZFhiWGNZTm53eUd6MVN0bk5rVzJRMzZCMGdiMXFm?=
 =?utf-8?B?R0xNaFk4TGMzOUVtWk5IMUs5enRUREl4bDFqNGtlSGxzY0FMci9JMmVxZEF6?=
 =?utf-8?B?cnRGbGNqWjRXRFFmNEZpNWRmMWdSRGd2bGsrMVBaYWJETm1IQ3YwdXdSQXUz?=
 =?utf-8?B?UU4yWStnbm5NemFjOTdreGNYc0JOZGRCS1RXNmh3WVRFYzJoTGM3TnZBWGFH?=
 =?utf-8?B?cVNud1BsNk5Wd20rY3VYelhNWWZhdmZubHdnQXArZDI0Y2QwTkFKT2doVHNY?=
 =?utf-8?B?engxUkRNK3lkRTNhc0JPZXc5cHU5ZG1EenVyQVhGRFdTWTkxekJablJyUjBs?=
 =?utf-8?B?NzAzY29hbnpCTng2WERybys2V3hTVGJlY2tycjBielQvUG1KU0FPVWRRVmEx?=
 =?utf-8?B?Y0FZaGZKOWswdVRjbjVuYjh1c3VzMU8xV3hxWnl6NHVmYjJZK0ZZTjJLbHN6?=
 =?utf-8?B?aWcwSFhvZmlaMmhwQ0x1MjhXK3M3UDY2VTFZWmM2MFU4MlJsUVBPQnpzTzRL?=
 =?utf-8?B?UXlrQS9JNHRMak92MzBxT1lOSnZoUXhtOW9URHdtQ0dscWpNWEFHQ3VXVy9n?=
 =?utf-8?B?KzcrMk1Nakcrc1BNT1d0cVJNVlVpM2JQeW9yeFR4QjRxU1JBVDViWHludDdJ?=
 =?utf-8?B?cnpGTUw3c3c2bGlMRVJOaWtWRzJoNmNRY29sZVBCdFpoeE1zaXhBRjlRb3JU?=
 =?utf-8?B?M1o1cVVTNFlHc3owZmI2NExHUThsT1M3bGZuL1NvdmZtVExxcC82aTdOY1hM?=
 =?utf-8?B?eVV3SjhqNVovUS8zaVkvcG4yWkI1ZlJKTm9XcnBwVzZNbno2WkVZQWVIR3Ew?=
 =?utf-8?B?WnJOZ0xsNm9mTDZncWdSSmhOQ1A0Y09zWk9aM3BQbnFoY0JIMWI3TlV4eGZk?=
 =?utf-8?B?c3h6bXBvUWxLd1pCUEUrNENBZEZnTTU4dklyN1h2K1ptNTh4dnlVYUxzMVlX?=
 =?utf-8?B?TVpwbHEyUDNHNmJPUDVaenJTamU3MWlTYWRUUHRUNytIYnhUMkQyVG1FelJI?=
 =?utf-8?B?UVBjckxPTE0rVFFydkxPQkhmcVpRdWRNQkQycnphbUMwLzczZklOcFE3cFlB?=
 =?utf-8?B?V01ZTkd0YTArT2FSbk5LSWRmU21lc1h1VStmU2tRQWtEV0FZd2JZSmEzaGEx?=
 =?utf-8?B?N2NzdWdwcnBnQU5oWWR1WXZOcndNbG5lcmkwRVAxcEladzJuWDlEaVgxUXI4?=
 =?utf-8?B?YThLaVlSYTYyT0wzcFc5QVZiVnQ0OWVoNEZBZkxuVkthVjRDQy9uREswRTVZ?=
 =?utf-8?B?VE5INVk5N3FuSmJ1NGExdVlGN3psYVVQTis0QW9JUlNFdzdIc3RBTnFwcVlr?=
 =?utf-8?B?RnljSXpHWkloOG80WTZ3OGYvQ2FBa2lTRmE3WjllQ2VMYW1iOGp0SnFiejUw?=
 =?utf-8?B?Z2pKRU82K05qY2g0NTF4VTBDRUprTjhaSSt5K09pZUsreVRQa1psQkxDbmFt?=
 =?utf-8?B?SW5HRzZHamJycEtoM3JDU0dRKzI4VVNsdXRqQ2hmRTZzQ3RuTExrREpvWFFH?=
 =?utf-8?B?a0pzM2RJM3lScDlqOGYvSnJDK1A0SWhhTGZzdVRueVFiZHYybVJWOXYrVHBw?=
 =?utf-8?B?M3F3cEpsZktLMmFDWVdaVCtvS1JFVDRoeXBmc24ydE10L3I5S1MyS1V1OFYv?=
 =?utf-8?B?bno3ZjZLR21Fa2ZXVERTNmZBaG5QdUp0aXl2MzJVNWhmT3pmMVQvbWFEd1hw?=
 =?utf-8?Q?ZPA37HTvzxHqirj4WBHM6T5h7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ef522e-e225-4968-7a6d-08dd760db027
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:52:11.9916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6lPVb/KUVV5euzsVhpr6Wi/9jfQ79Nhvg2L4FhfN4jhKxHNwM7oRXsSQvcAhona6t35HoZRsTDlgN9ESikH7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem, which
host side driver miss-match with endpoint side function driver. See below
table:

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

Change from v13 to v14
- update to use pci_endpoint_test -f pcie_ep_doorbell
- change ioctrl id to fix conflict

Change from v9 to v13
- none

Change from v8 to v9
- change PCITEST_DOORBELL to 0xa

Change form v6 to v8
- none

Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 82 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c4e5e2c977be2..0f3af7adea107 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -37,6 +37,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -48,6 +50,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -62,6 +69,7 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
@@ -70,6 +78,10 @@
 #define CAP_MSIX				BIT(2)
 #define CAP_INTX				BIT(3)
 
+#define PCI_ENDPOINT_TEST_DB_BAR		0x34
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
+#define PCI_ENDPOINT_TEST_DB_DATA		0x3c
+
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
@@ -100,6 +112,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -841,6 +854,72 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return 0;
 }
 
+static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return -EINVAL;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL) {
+		dev_err(dev, "Failed to enable doorbell\n");
+		return -EINVAL;
+	}
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		dev_err(dev, "Endpoint have not received Doorbell\n");
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
+		dev_err(dev, "Failed to disable doorbell\n");
+		return -EINVAL;
+	}
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		return -EINVAL;
+
+	return 0;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -891,6 +970,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index d3aa8715a525e..d6023a45a9d03 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_BARS		_IO('P', 0xa)
+#define PCITEST_DOORBELL	_IO('P', 0xb)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_IRQ_TYPE_UNDEFINED	-1

-- 
2.34.1


