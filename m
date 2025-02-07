Return-Path: <linux-kselftest+bounces-26036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4933AA2CCC9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C803ABFF2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7531519E96D;
	Fri,  7 Feb 2025 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AgvPwHXO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5A1A08A6;
	Fri,  7 Feb 2025 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957253; cv=fail; b=euAbDmtLSu3exiJlNfh8n4EBbM3KcMZz052njJT77O/N6DBJxCClTOvQQqtKO8RdmdIJjGxkj/AOG9GZdi675P1/B3wA6CNc7/Bdu/Khk+SN2hB2K9U0nvpBGnuRd3u6HpralymYcnoQNb+RPLfkbPpb+ON5aUwduzJ1hFtZg9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957253; c=relaxed/simple;
	bh=vRHtci20BPYiFjZjfFd0qqbS48D1yD+a6xNdiE9Qvlg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Bz/F2XkPkwLHBU0dRYLpJvaAby6gCfG0c9s2vIl19pIZxUTG6YsLt+zuwfUO/DvTi0bd+ebNTzhm38uwPrwVVaEWl7nMrZHxpCClScNunrUAOr7Ji9G08XK3iU8SC5wNEIOD5QOT2hPDWJ5kJGk9UL562dyN67ub8p7Pu1IixnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AgvPwHXO; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufBhgDKI9zx9Rf0MXeUuz86xky4RBHjCkjxh/ypdG4qVVdZHC0k9ot32caSDGEFm48OLufV2v1Rs6wFQxyp0cvKihqHIqrJdPkcslHrxzM+DYrl77q2mTXYIZvnIgfREKdsXkIJ4iWQbG0eLC4gEobPc97p2Nq9ZB9T4qsRxxgq0Oni0FaZGw3Zg1InxJ8BE6OEcR7KCxmJ3L23lIkaMiq3GAMXdKT64GbVHaFk4nYekZ3VVuTfrd6FcrI6GF9fP0vjZ6gYeD2R5L3A+bahJ1Q0AKockUeu4AuNVKJQwveuilO3BGjMDFSXpHYEXrbrbBwLNV86rboCqpYCKUPB+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpGga/ZzLiq4iZ7S77XwN43rsuXGj7ucNhAOt1l6zJQ=;
 b=fQcNIQI/cG3IgRzal/L9J2jOw9UYNduf06eDmxass1iRSMmXfSoVsqK/P8M9gBcS+TdNJ0BCHjrnCJsDn31DhyYYw/+DXAHfCmIYanOdmS1BqchQT2mifngPWD9JDb+Epsqc3VAu8GZzOvrD0a7TW+nsErxR7ohP9I6y2Va2o3qEdtiTxFxA6Nzd4sVtzAd/rST1cIrvtUZ3HQJn00WTAzw5rVozWTsWZopFY8IhMbPbJkhMaNxC2MlnqRc+JNeeoSN1MLedeuvULeZowVBAaiNEyp+Q/HKqf+ZPhAuCm37pYoE3pRgU7fxKm6LmmPChJEkDhC9uZIsYTGPmV1WM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpGga/ZzLiq4iZ7S77XwN43rsuXGj7ucNhAOt1l6zJQ=;
 b=AgvPwHXO4SiTu+P//8ixFSRwrEaeJW8OAAPN7ArcmXICmLzcuG99/MJNhEegTlS2o4e1c6aRufIS3Vu1L2bQmKGqLrkQeZKzZvWmSFRkE+uakF+u66dXEsoXae0Hk+hNF9FOASGSE5dOAxaJHX25Rw+qGqymgzAo91o7XC8QoZlczInOJ0IMaEe7v2go/LLijkDq5r+BOsfhn8dvDF1o3pyCyosTs6BMttOqD5FbcuFxv6NkyxlouFjzolURfQLSMrtK6dsCdFtRmNZgvNC9fHIH28iFaT7R1zWO5QWzbJJmgPMRwL76/vNy1GbRI9TyV8TLnyZ7Weasgnp/fXSKaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:40:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:40:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:47 -0500
Subject: [PATCH v14 05/15] PCI: endpoint: Set ID and of_node for function
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-5-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=2129;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vRHtci20BPYiFjZjfFd0qqbS48D1yD+a6xNdiE9Qvlg=;
 b=gz61znD4xlb0XsPkQKROiB0nmMBFh+srmABo6XTHDXVRqXCVw8QSRBqiw45pAu7rShNSqluV+
 7oMPl+fvs5UBUUW5UzjlQGEYz3aD/XkiJDjEEqeGAB+lFzNuZnpWufq
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
X-MS-Office365-Filtering-Correlation-Id: b4eb61cd-10db-478a-c6d5-08dd47af5282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0huWkhFbGpDUGhEWE5vcjRJOCtvNHk0VEFIclc1eEJlZnJJZm1WTjFOTXhD?=
 =?utf-8?B?UllyVHpiQkdSRkRSNVB5K0huTmN6SXA2ZWRIdENCMUlXdG5yQnFvYVR1OVlN?=
 =?utf-8?B?Y2VWYjdjZm1aSUJ3U1JlK3RwR1lQNjNSYWRhbWJXcGh2YmpmYlQrbEFISEJz?=
 =?utf-8?B?bm41MzZGQUZTblVSY201c04zazZuZ25ka2VhanQrcDd2cmc0Y1BLcXdGbWtm?=
 =?utf-8?B?cXJudi84dnZTTDN4bzNhTEZkb2w0UjhXNnIrcTRmOXlOM1ArQnRFRjRxMllr?=
 =?utf-8?B?VXk2QXlPc0c4eXNZL3E1WjlVbWJUNEt2QWZFcmRDTzhRZzZOWnhiSHFyVFZX?=
 =?utf-8?B?R25NdTU2cFBGNzZLcldtOVZUWWw0TFBZM0lJL2ZoN3NOcGJ1UkRoc0poQXp0?=
 =?utf-8?B?dTFVdE80RTR0b2NjM3JZVUp4NC9FbUNnRmJrNEtOYXdhdHEyQkZHRjhnUGo4?=
 =?utf-8?B?eFFYYkYzNXk3WTFpbzJDSkF6VXUxalhMa25LU1ZKb0xoTGozN2U4SHkyb0FK?=
 =?utf-8?B?R3hjU3JNUEF4cHhDYnVXSC9VWENqckVHQVdNWDVUa1FtSU50N2lndXZkR0Mw?=
 =?utf-8?B?ZDhTVTZLTVZadVlBN3NucG9OZjZWaXI4eFBwT1J2WCtJN1JyM1B1cEpMSjlN?=
 =?utf-8?B?Q1hkMnRoRWlQSUVKaTFPaVdHanpqajJXcFhNSGlqWWNPUU5uaU93dExjcFFl?=
 =?utf-8?B?aUFCdVMrckdWOWpITUtWN2RnTzYwa0F6aTJRaHZpQjRTUVhpZ0EvcHRGNFIz?=
 =?utf-8?B?ekxhK2lmSkZ6NlBqZUNrSmpEV2R3SmZYMnRkd0JOWU9hcFZXV0QzMlA4RTVp?=
 =?utf-8?B?R0UvR3IzUHBnRS9WS2tPclU0ZllIcStyNmlNNG4xSU5PZktPcWlZSWN2K25z?=
 =?utf-8?B?R1pCSFRWN2lBV0VLUWlDd1FlWkJ5N1BsUmtwcXdMUlRGR2NBMmxRazZhVTlz?=
 =?utf-8?B?VExvdWhlV3pBZkZOMTh3ZVNWVzQrdXd5QnNJS0N1QnFzcWEvZ1YzZmhJOW5x?=
 =?utf-8?B?ZG5UdFFGcmE2c1Fha1JQMlhxL0s3L3F4enZNY1c0RGJIMjNVRE1uTmY1MzJK?=
 =?utf-8?B?VGlSZHpUajdXZnE0UkdBa1ZBQm9qK1hyeWxDZ1FQTDM1bWtYem5HOVh2djVi?=
 =?utf-8?B?Sk80YkRXbW9PZXdTbDdmcEN6Yzlkd0ZUV25ObTFPYTNxUW1JRkw3TUl3MVBR?=
 =?utf-8?B?MENuaXFIUFV2MXVMaTVNMW9nZmRnem5OV3FzTDhkWFY2NFdTRGlkdDVTMUNM?=
 =?utf-8?B?dkdUODFBTG5HKzZ6K21GbEw4SGNhQ3Jrem5UVEhmdmVZTnd5cEpUNW9zL2pw?=
 =?utf-8?B?NVpPbUgyQ0VrYjNTR2FzNVk2Z3IwdmFZWDBkeGU1QWUrdWJISmtpVk9vaGNH?=
 =?utf-8?B?R05GOThsdUg5U242d0pWLzlMUUFzWlh3ZGVkNHZqZ1h1eXdIZWdyQU1kVUhR?=
 =?utf-8?B?L1Q0dm9vM2tnRGQ0aHQvSUE0L3d4OE9iNWorZmtsMy9Fc2RpMnZGbTFiWk5w?=
 =?utf-8?B?VE5FRW5qdTNUdDNWK3BKNlVYV1AzYk03MVlwTXQzNnlXNkw4ajE0ZWtRbFBk?=
 =?utf-8?B?R1hNaFJISjhaaW1Cc00xQlZvaERWamxkb3NKak1WTEY1ZGpNeU5LTllKRlV4?=
 =?utf-8?B?ak4xY2sxVTIvd29mMXhGYU5qVXV3VStsbzkzeGFUQzRhS282Rnd2a0Q4Tytn?=
 =?utf-8?B?OU12TmZ0M1d3a29aajNpV3hzZmR4NmhxRWs0SVlmV3E5amloRjJEN0w2NXdi?=
 =?utf-8?B?N3F6MlRTZXVqdHl5b0lWM25VOEZVeGUwcTFYemVJbHVWKzdlbGM2YkVuU1N0?=
 =?utf-8?B?R1RoVkVsRDV3T1VIbXZRbW1KYmZtSlJDS3dVaUhQem9SWjdFUy81OGd0TXh3?=
 =?utf-8?B?UlFNQWtIOVBsWXVaVkxOOU1JZzdqNmJlNXljdTNGTFFyOFFadEJheE1ONjB6?=
 =?utf-8?B?QUNSZU1RRlovc2ZBL2ZVS2U4WDQzR0w0WEVLT0d4R0FCaldWcnQ2R1Bqc1Vz?=
 =?utf-8?B?dGNRdnJGNXB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1kwbG5tMnJGYVZqaVk3U2JLWVA3blhmTldRQ2tPRkRHVngxbUFaRkFlMkov?=
 =?utf-8?B?eDR5T0NiU0NxM0RYRklMS09CbnV5ODVPMSs2NG9IYjJuVzlGTDdKMHBERmNW?=
 =?utf-8?B?dTF6WnpUc3VNY21SK2dJRngzemt2Rnc1SFY5YVVZa21Bc2Zmb0hWS0pQZnEy?=
 =?utf-8?B?K1RjS0taWThxM0k1a01aYVJKeUVOank1QmcrbVd5a0ZhU2REaUcrY1ZETG1t?=
 =?utf-8?B?YUovc3doUC9TWGRKeVNHUHl1S3hsbFozd0VRSHI5dnc5WGVRSlB1UjhqOGZR?=
 =?utf-8?B?L1FHWEJONisxNmpMSGZSQnVvNjRoeDlXc3ZsK1IzYkxoeWhxcmRSa1IyMmhQ?=
 =?utf-8?B?Wm1jY1k3WHlSTmxCU2x4dlhuek1MWVhyNDdoY1ZKWWtQUEJ3czRZVXBKUDcw?=
 =?utf-8?B?STBSMDZEN1NVeVViSmc3VWNDc1hjazY5SGpLSzR2U0xzQm9HUExhTFA1d1BR?=
 =?utf-8?B?TXo3SFNzMWlDNUFsM2dPc3ZlcVNPMThXT0ozeXNSMkdmSENDV3grdnpmbUNm?=
 =?utf-8?B?L1c5RGhJV25ZZnB1amM5M2E2T1pPMm5keDZKSStCTkFHbmxsTEwwd01CdURE?=
 =?utf-8?B?dUlZdUcrRXQ3aGJKUXJ5aTg0NWh4aFUrbG5FL0o4c3hrVVV6SXZQc0kyMnRj?=
 =?utf-8?B?SDF4V212WnVjUzM5SlJKbVBpczhVUWpKRnpHUnJPQnF3LzgrYlBRZlM0QkNZ?=
 =?utf-8?B?N2xmZjh4WDhkbjN3bzAxOSs4ajBHOU5EZ2JhbjliRStRNmdLUy9TazdlQlNL?=
 =?utf-8?B?YmM2Mkp0UHYxZ1ovN1VUWkVXWEl4RWNKS1hNbEU4eGdpZ0VKaW1IY2pxS084?=
 =?utf-8?B?L2tOS21BbVpEb09xSndRaS9SZ2ZnQkdyaGdObWFZUGxUSXAwZnRwdDRrMk1i?=
 =?utf-8?B?cTh6TjNSUVJmYUFlVTZyMGdBaUZ5azRkSy9Xd1dtZVo5SVZaSnZZc25GelZm?=
 =?utf-8?B?dEo1YkttbE9DLzdHZytMV1NObG1QRG9IdDJ2cndva1Z1Y3E2RWZJQlMzc1FS?=
 =?utf-8?B?S1NOSVBwMXFVbjBCc0NlalBSMzgySEZoVElCYWdtalRlUU9qVXJJNzVoK2Yr?=
 =?utf-8?B?c1BKNEFXeHNNNENma0tRNis1dmxyVjN1aEJzVXJBUTdvNWFqTERMOUlsZHBJ?=
 =?utf-8?B?U1FpbFJVZjlTZFBuaWxXWEVxeVNGOFhXQ3pKYzErek9YVTN0ZzBmeGVucDZJ?=
 =?utf-8?B?WStVQWJXNjRxelkzTGVuOUdNbjJCR3dzWVNBdTNUeUF1QVMwMFFlUXllN21m?=
 =?utf-8?B?UmxaRkRyNUc3a1VLd3ZzL3A2QVBXSFRReFdQZUVnNmIvT0lwSGphenZKK2sx?=
 =?utf-8?B?UFBSTTBMWTJ3TFVVek5YemJxSGRmNkh4ekNleURXbFZpeS9SVERmSHFZVnpB?=
 =?utf-8?B?cG5iL0llVDd2VE1oWWNmQVZYczI5RzNYSmVJenN0OGtCempTOXYwUmVUdi9u?=
 =?utf-8?B?SHZmR1JrUGkzUlR2Rk1OVmJNK3ZZZHd5RUhINFdCTktVdjRIYjhNVE9YUlM0?=
 =?utf-8?B?YjAzS1IzS01ycGJQdWtXYjFpZE9VY05seVNhNnJUYWg5Z29vMEt4cmU3ZFRy?=
 =?utf-8?B?M1RCOUlqNGJvRENUSzdQSE9qblpabnZxMStNRWhKVSt2bzAzdXhpYTJSd01F?=
 =?utf-8?B?THpWS0YwVUFNdkM4eHQ0Z1ptYllLWXlVV0tqSis3RTJRMmY3V2JMV0w1cUlh?=
 =?utf-8?B?UmxuWktIcm9sRkRDcVA2bjkvajVPTHVhYlVxcFpaaGo0M1BvR0R1YVdSbUpv?=
 =?utf-8?B?d1hqcUljaUw5UXdzNWNrZEtSUTlXdC93UFJWaTFrd1hVaUlHbkJXSjdwUGJH?=
 =?utf-8?B?VXc0eTdlbXdXcHVGcTgraHlSWmJpR2ZybU9RSTY2K1ErQkFMczZrUDd3aUR3?=
 =?utf-8?B?VGF2bnZZMm5QUERDZmpSSjNlV3pWSnhGenY5QWJ4cGJYemlrWW5DTjdkVTZM?=
 =?utf-8?B?bTZyamlBT3dtMmhacCs1Y2pQd3NwbE5SNkd6MEJBTTFHUXc4L25iOEhOaEdK?=
 =?utf-8?B?RVNwSGUvVG96YURFcFJabi9WT0xMY1FEQm51VE9nZ3A1eEpIZVVLNC9meENt?=
 =?utf-8?B?L2NPcXhiOHdYd0h4SU03YTFncHZqTkVzWGJqd3U2YTlOM3lMYW9GeGZXUTMx?=
 =?utf-8?Q?4HOEytDbjfXvSDOkEnKBvQmpe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb61cd-10db-478a-c6d5-08dd47af5282
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:40:48.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbEV3Acocu3qauohN+o7S5Wj/BIuXsNBZcehNGLXBEC5Kv5ienvBiWo97xnEZdekP8E3P1l9ogabprEYz75ymQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

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
 drivers/pci/endpoint/pci-epf-core.c | 4 ++++
 include/linux/pci-epf.h             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 50bc2892a36c5..f728ee2660a4e 100644
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
index ee6156bcbbd05..d2790b8b29394 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -212,6 +212,8 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 	return dev_get_drvdata(&epf->dev);
 }
 
+#define PCI_EPF_DEVID(func_no, vfunc_no) ((vfunc_no) << 3 | (func_no))
+
 struct pci_epf *pci_epf_create(const char *name);
 void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,

-- 
2.34.1


