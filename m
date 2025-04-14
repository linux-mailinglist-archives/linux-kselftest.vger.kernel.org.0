Return-Path: <linux-kselftest+bounces-30750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FAFA88B3A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B549D189A667
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E1C2918D0;
	Mon, 14 Apr 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gIeEkS57"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A42828BA9D;
	Mon, 14 Apr 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655514; cv=fail; b=En4kbQb+IkonQjt7e67zkNdT3J1K/ksIppY8kcJHpnDOd6qHiG/M4QldrT6l6mMP4Vdl95NMEy0zFWUpiOq9Ivn2nfVL64fumhbbVMeezZkxRxJfm3pfB2n3sMCwFhjlRpXlcANKALTRbFFKSvVd0INC3xsr5hc3p4x5Ms6nmU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655514; c=relaxed/simple;
	bh=1rniyVcGag0eNeLrwWvT+jPUnbYZckhT5xHhMRAAH+k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=osaIJUdyrbu1qGNgyAohdoxkOGc6MCaa7pEcCIW0io0CIpMWVIiYF6JlAi94qSAA02s9FuOP5JSTzVcPJco428L659i7q7JagzJsQ48cU/NQbOgSlOljJzEkII4hmnOamw59reVeKDyVwJby6W8sOxLecKw8vR6gtjA+CSb18jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gIeEkS57; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfcUfU4BRFHwcJyv7iz0JGZYZF2zrdPIVswWAMgK5hkAdQh/3C21e1EmJ62WWXLYFbW8fZjXwVVDJscZ+mrO5Rzn4gTnOJNQBewDjij6G2nPpGqtxHfsTNBtfSjHzKKcRxo19OhPIDgShbXdP6upd0J5LUMIFzSmRJ4Rr1TisPLN+yRa+S4DrNs19sQE46Rr9YfulhswXBXw/HchP22piB9NJ+0OZ9oJV59WESLOdZqZV+bdPVtKCRBAH4v3XJgWyikVqlFqro0RyGwjET+/dZ/70LfG4K2FvXCM1qaM1BIH327ikiR4MY1CvsoqVd23gB31LhN33C5vPuuagcVPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV43Lv9xcy4k1Ss3c5nbEs7m6Hdf2yF4V9lxFdIqHso=;
 b=f42/jeqayDkDDZcVoopGnTLJ39boXpe9Vk14k1qEdjmXdviHgyMEqYzFsqnpoDoP8aDQHfajMqRfEEL3uUai3FWBIG41A/MTeEXFdjHm0cgI7X3s9lwXjI44fIgnHi7W5adCtQi9jn1K9VfIutcTJOJJfExXBdl+S/lmWdUAzfOAvMlULZW2K++73NaFibALWFJ9wNgmaiyYigVtIqiX9bN56aJhZhqqf7u1U20abYKKSxzTMmYALoTM9uNcnOKh1UUntzSlIXHKMsx9hdgljjBzRNGHmuy7nYi9xL2FYP3C3ZTFvu8yA9KzH3lRwXci5PM23TYSg8/OaWjHIsLG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV43Lv9xcy4k1Ss3c5nbEs7m6Hdf2yF4V9lxFdIqHso=;
 b=gIeEkS57ujCOWbKAAQgBh+A3YXN5lOxert/gIMcIUUJamPD2+n0+4htexSoA/boGPxISIq9TEBJuZeqyfjfiDQ676vO/aM5P7rpFayXdrzODceMc4OrYIJosQBtS3vN5LaBlXKeY/9lqbdFrV7jWEXnKCkUS4cWwHc2wFtgZoPM48xfZmp0LCQJ04FWNokJvx9y9dJyGFU7hpo+idwA8Kyh2t7+9bkj1pTpU3gQfucz2eVP1D2uZkvInjg+CxCW+ZwMBHmFF4Cxkl491p1awOCu0pzphJMr/VDHlYSAWWUW2AE/BHlPIIVuJSUmL3Y6P28pUCoSmoaHo5yIjyh3tbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:31:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:31:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:00 -0400
Subject: [PATCH v18 06/15] PCI: endpoint: Set ID and of_node for function
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-6-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=2203;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1rniyVcGag0eNeLrwWvT+jPUnbYZckhT5xHhMRAAH+k=;
 b=M3XttcIZE2pngOxFRfxV2aPLfa0RAPtnnD9lKF59WlR7mZzldABZFnoY5rwp7zgVNqaNLThtw
 dxECiC90i4uB9/02b7C+KkBk8wyiQw/LS16q7Z8+FkW4qMZ/wuvbkz/
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
X-MS-Office365-Filtering-Correlation-Id: 15b24752-751e-41d3-df3a-08dd7b829efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVl5bkFpSDQ3Y1NtbUJIZnVpQnBhZDgyc0drQkY1USsyV2dEbHBtQXRNSmxC?=
 =?utf-8?B?RlBaZUtjaXdJeThyQ0dtL3lUcyt2cExVQlEwMll3NmlWUFZZVUcrMzFYTkJB?=
 =?utf-8?B?UzBvWUNMY254eWFnNHRtUzVKL1UzRlJiVDJJS012L0dhd3ZoRGplQlZweWxW?=
 =?utf-8?B?MHBkYk1vTU9ZV0R0UURSWlZjNkMrSVo2N1lTakVMVnk1eDN1Y0Qrdm1MeTQz?=
 =?utf-8?B?QmlwNFF5dmFXQ1Y2Z0xHNXlYZVNMMUZ2RGFRY0FOVVlQTmFiQlY0anQ1K1ow?=
 =?utf-8?B?YmIvVUZFdXpUajRjazFZTWZOejRZVjZxQ3Bza1FmeXlWaVloTXpmcndRQ0N4?=
 =?utf-8?B?MUdGTVl3VW1SZlZRTFVyNFhNYmxQUE9PbmlqZkErRlVQeUF2cjJIcTEzYjh1?=
 =?utf-8?B?QUd2TVlkUFVSNFBIMHZVaTl4Y3NlMlhoVTlWaUJvZDhnSk9lcHdOZm9VdXNK?=
 =?utf-8?B?UkQxdEtSbmloN21FdmtSaVliQ2xIMkdORzVFTHVyK2t4T0FXTkMwZjBHSjFh?=
 =?utf-8?B?Z1dzNTY4OS8xTmVTNTlIQUFObXEyalBsZmQ3eXB3VnlrUTE3QVRqMUp0K202?=
 =?utf-8?B?MWJGSWtKMzl6WDZwZkE4RlBxZ2oxazc5c1gvemJ6SU9HNGhIWVZYSyt4NTRY?=
 =?utf-8?B?TTJaUzFZenBrWTVNcjhkbFZ3TDhNMk9XWkVjdkoxVTRCb0UyVTB6bG9VcnFs?=
 =?utf-8?B?NXEwMzZRbllLc1pIUkYzRklZekN5QTVaajQ1NG96ZHkyWW1PTXFyVEwvV0Np?=
 =?utf-8?B?WS9ob0plTGY3UDBoUmhHRVdCdnBjWUFTc0JkSVZsc3hSYVlieTZTUWdWVmZs?=
 =?utf-8?B?MkFJK3k4eVQvQ01EdW1PTDYxdjZIVGVUYTlqQ1lWeHNZSWM1djhPV0c0b1Fj?=
 =?utf-8?B?Zm1XZzRSc0JNUktWSUt6dXlDS1ZjUWJveTlpZDhwYVE2eTd6NWpVZFQzZGpn?=
 =?utf-8?B?MEZuMGtTTThxM0laZmZ5MmdZTktDMVVrQ0NTRXFXbFp2SXN0cTV1eFd2azYx?=
 =?utf-8?B?K2lDdHRydlVIeTU0a3UxMGpkaFdaS21oVGpkSURab0UrbkxvaHp0V1VSVXBH?=
 =?utf-8?B?cFZVUEFuTGhtTC9Ld3ZuZ0srTU56Z1BhbmFwbEptY2FQMEIwL3dEZEFBNzZq?=
 =?utf-8?B?YUN5Umgxb2ZLbE1tSHA2T08xY05lbG8vTythNkNZVnprdVo1cFN3SFcwNUUz?=
 =?utf-8?B?enFQOERad3R5L0M3Q1NPM2dFeUgreEpkcXE4Smx2bDlGaE5xQ0l0bHU4dUdS?=
 =?utf-8?B?Zzc1dnZUcTVaWjV2elF1WVljQTJScDRTKytFS0krL3NWUG5IdWE0WDdnL213?=
 =?utf-8?B?dlRva3RVRU50WElRZ05aRVc0NEJweHR0dkVPcUN6aWRIQk0vbjVpQjFBNWV6?=
 =?utf-8?B?ZXNHNWowMGJqWkJjcjU5djlIenZvTGJWVEVnczdFM0hVMHd3dysyNjIzVUtT?=
 =?utf-8?B?anlUdGNOQ3ZrWC9IV1RKK0FGSkNWVnJTZDJybWpmMHg0RnB6aGcwUjZTa1Vi?=
 =?utf-8?B?NEdDdmZLMTA1K0pqdDJET2dvVURNNDdlTmsyZ3UwRndiNXUwTTlzYlA1VWRh?=
 =?utf-8?B?MVNocU9pOER1OHRHMHpaZHBiTER1QkYrVzl6Q09HZXFHQUpySUJydlpGT0Q1?=
 =?utf-8?B?QmNnNHV5bjN3RS94SVFHTDF3VmYzQ3VCZkRwZ3J5SDUxVGVsZ3hWZUxOeTRL?=
 =?utf-8?B?Zlk4aG9jelRFNmE5OTVXY0pKVC9iNElENVpSTjdKdldENTFUcEljVzBJOWF5?=
 =?utf-8?B?MkZZY1NJdzNvTWJ6TmV4SWxVOENsZGcxeitCRElXYjU4aVhjRnV4MHRlK1R1?=
 =?utf-8?B?QW95RzhkVlhlSmRYbGVYZW5tWEhYdU9TU2hFU09rMjVDdU9XaFhUWWhlQWo3?=
 =?utf-8?B?VUh0MGlyamZoei9WM2ozMjVnNUpwRTRmM2tZTGFsYVJybUdsOUpGT3NtdlZE?=
 =?utf-8?B?RURDZitoWjBmYWJ4blhUTCs2TGtDdFhlSjNxblFYUVFxNUc0VkVPN09YNFdl?=
 =?utf-8?Q?zB2p5xIzfv+29UQFK19tPRsR9yzYOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDZYeHVURmhROWlwa1FkelVoaVh6SEwrZlQ4Y0gzaE5QZEFyMmgzMzVYSVNX?=
 =?utf-8?B?aDMwbG9HaFEvNWE5SC9BOW5TOTVmU2dpNFdmNHVveCtHWVhWYm42dWRXTUVN?=
 =?utf-8?B?ZjlwS0I4YTZlMEVIU1k1N0ltdUhmRjYzWXgvTlhPdU1WT1FIRWhWSzlvWUhv?=
 =?utf-8?B?ZVhBby85dWVIR1BaMzhJNmZvbVo2VUJxem5za09jZFIxQ3BJZXROYnE5MS9t?=
 =?utf-8?B?bzhSQnAxWE9lRUJwNUFYVURWQlhGdmlJMEdXOVhqOGpPMlVROFBMVWNoQ0hB?=
 =?utf-8?B?SHZFTkdPZjBiMkdvTC9IcnJySlVna212OFpyM1ZRRWgyNjUySzdlVTZBTWI0?=
 =?utf-8?B?Y2lEMU9ERWIxNWN2TWNrdGpvL3BZY01FbGRFcTJFd0syQlFLbkplcnAzdUdR?=
 =?utf-8?B?Rk1tcVoyTjA3dUlBaVVRbTVRaXpXYzBPM3VBVWNDejJoeHdnaGlvL295eHBQ?=
 =?utf-8?B?azF6ZmRhbk45MXBuNXE4SGQ2YkNodGU2RlEzZnBoUmg2SmhrMGlDS2tqbGdy?=
 =?utf-8?B?RUVoOG5ORXVoaUV1dnVRTllydEFRRml6WVJTMXpSOS9zMHhtOEd3bjZiZ3da?=
 =?utf-8?B?ZGRWczQ1dVcrdWFLaDVGb1VtZ3pYL3NOekcwZDdDRUh0cmM4T1E3eUFveVd6?=
 =?utf-8?B?TzNUeFA5NTlXaE5rRFNreVRaU2JkU2laTk54WFdhYm14NFBLcVFYMGQ5L1BY?=
 =?utf-8?B?ME8xN05YV0h4ZU0wa2hUYmFMdy9YMjdjSi8xek9wZXVoZVdNNFU1UUw4ck1W?=
 =?utf-8?B?UWR2VTN3cEptSGYweWxyOE1qR1lQcE9GUnVqaDVlRGpuY0VHUk9zc1orTlh6?=
 =?utf-8?B?TjhiN0pta1ArQ0h1dS9pOVVEQWVPM0lrYk93a2N5dWRFZUhBSENYQmNaY1Zr?=
 =?utf-8?B?ZEpjVCsxNG5lMTR3dnBWK2pmYmxWOWlMcDl2YmhZWTdqRWh0WkliVGtDQUdq?=
 =?utf-8?B?NFFmd2ZRck03YzVYUlZ3TGF6SWE1UE8yUkk0QnpZSUkzNFF2THJheEpGY1ly?=
 =?utf-8?B?eHVGVCs3REphbnM1dGZPS21tSUxkYlMrc09qZHlPbXd4aU1pYlFTZGovcWJG?=
 =?utf-8?B?OE9TVnl1dzdwTDhONk1zS3FKRkRXOWpTeVlMOUNlOXJUZ25sTWRjTEplNkpB?=
 =?utf-8?B?MERBUDJrZ0JiQkNPVHpVcklQblFrdHc1WExpTFA3ZUVzK0RBbVk1YXFqNG9h?=
 =?utf-8?B?WlZLd1JUM0ZkUzNzeUI2S2g3SitGVDJPSCt1QXVsN0RIdmVOZXdzOXNQSEc5?=
 =?utf-8?B?RWwyVktiNTJ4endDTlk0Y281ODZmWVpQdlQ2aVJZRGsyZy9KK0hQWGYrODRj?=
 =?utf-8?B?TzR4TkFnU3F4UjV6cUd4cUVOYlEra2p5N2JabE1vZGQrQXByQ2FOUU5kbEpm?=
 =?utf-8?B?Y2NTellJZ2pyZnlueUJCaWx6cWVWSlRJU3pnanF2OHBhdVdtRjlKV0h0ZlVv?=
 =?utf-8?B?czdsektIRU04bkJRdXhCRmREMjVDVjVMWUVzVEtBSGFmK0JyTHllNWI0V1F4?=
 =?utf-8?B?M3g0UXJqVVkyVHlWMHdvYkx1MkVsZTFxQ3U3NkZ1YTE5WE12SE1ic2tDOURU?=
 =?utf-8?B?SW54K3ppelBselRRYlF4UFhoVUdoQXFOR05HaE1qdDFtNGNYMlV3RlEyN2dz?=
 =?utf-8?B?U1FoSnljWHlTejFtcXJNN2xlUWxoOFp3MVQ5aVc0SHU3V3p3NU1Lc1R5dEhE?=
 =?utf-8?B?VEkyTW95c0Mzc0ovK2h5UXMwcFhtdDZsMWRic3d6WVBRTlBTeVRvdk50Nm5W?=
 =?utf-8?B?MHRwbWFZTXhQZUU2bnF6ZkEyRGdoV0tyY1htWDN0ZC9tS0o5RTBKM2ExZXI3?=
 =?utf-8?B?VDBybEJmLys3MWNUcE5aZ0x1WDh5NFY5VUxoWkVvNTFJSGplUXdZODJSdEVM?=
 =?utf-8?B?NGRwaEFpY2lOQjJxSGRBQVhRamx2UU5BS1FNUktpV0M4OFVPZmVMQ210cFRP?=
 =?utf-8?B?ZEJXM2RmdkVBMTVHQVNkRk0wRTBSSzRTenZhMW1YcUhsY2tIQ3FxK3VXOW5s?=
 =?utf-8?B?WWFUeUNiWUxySms3aUx1aksxRGFOQVJ1alB3UzI2UWRORjl2TmxueEhUb2NE?=
 =?utf-8?B?V3FrVE1UWnRZQ0JyYzNVQ2o1blBlWW44djVxYlBkSTZZVmhCTkN2eDdGMjZH?=
 =?utf-8?Q?4C3I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b24752-751e-41d3-df3a-08dd7b829efc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:31:50.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Eoz48DY+soC5H9I965MBtDeBDwC4/MSGBTCb8eiwPXXRhJzy6piwFHkjc2+UOIroCky1qDxTN9jMcVZcBK3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

Set device ID as 'vfunc_no << 3 | func_no' and use
'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
device.

Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
functions use the EPC's device node, but they should use the EPF one.
For multiple function drivers, IOMMU/MSI should be different for each
function driver.

If multiple function devices share the same EPC device, there will be
no isolation between them. Setting the ID and 'of_node' prepares for
proper support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 4 ++++
 include/linux/pci-epf.h             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8dec..d04224b8e1631 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -120,12 +120,16 @@ int pci_epf_bind(struct pci_epf *epf)
 		epf_vf->sec_epc_func_no = epf->sec_epc_func_no;
 		epf_vf->epc = epf->epc;
 		epf_vf->sec_epc = epf->sec_epc;
+		epf_vf->dev.id = PCI_EPF_DEVID(epf->func_no, vfunc_no);
+		device_set_of_node_from_dev(&epf_vf->dev, epc->dev.parent);
 		ret = epf_vf->driver->ops->bind(epf_vf);
 		if (ret)
 			goto ret;
 		epf_vf->is_bound = true;
 	}
 
+	epf->dev.id = PCI_EPF_DEVID(epf->func_no, 0);
+	device_set_of_node_from_dev(&epf->dev, epc->dev.parent);
 	ret = epf->driver->ops->bind(epf);
 	if (ret)
 		goto ret;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 879d19cebd4fc..1040d83740f9a 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -213,6 +213,8 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 	return dev_get_drvdata(&epf->dev);
 }
 
+#define PCI_EPF_DEVID(func_no, vfunc_no) ((vfunc_no) << 3 | (func_no))
+
 struct pci_epf *pci_epf_create(const char *name);
 void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,

-- 
2.34.1


