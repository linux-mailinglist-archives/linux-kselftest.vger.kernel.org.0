Return-Path: <linux-kselftest+bounces-30756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF136A88B5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9572F17BFB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3AA28F527;
	Mon, 14 Apr 2025 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TwcHh/pw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B22949F8;
	Mon, 14 Apr 2025 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655555; cv=fail; b=YNzx59I1suaV5QsdnSlkmFVx11mQRFhLqSi+NPR8EhpkuHF5r0T+I/bthP/gT8xhjJDFugJGQovIkINp0gpVrTfvy81cvWlq8ZFHPcKHf5674eWoPR5GRgLyDazvqAo51g8H08E+EQYiwq3hbr361g+SmMQyQldxKqufU9EbR9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655555; c=relaxed/simple;
	bh=+SgZEl+0x0mkZbAhvLt5Evhno7zgilVYjrIje6KjXVc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ua9wkmK1PwzEeE0NPBNF5f8QtiFTARUOsBCYGR7hehoX7XjxlsQr8OFy78BgLl6S9O5wNPzpWzVr3cGfcSOPMW7r+2bGHh+9s5BQsxT76VXzJANx5bYu+RaSL32AjhJgDv+/aK2s0zSqW7Ap5pECG8BvOCzlc8ecBjdKz2LK3Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TwcHh/pw; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNix5Shu+n7C5wN6xZswHiqeMIren2PsdNzYccTanu3BqCDNATT/hVh+m5y3NEY4GqFsEBZ4MDyqi0q7xjQF4bivGohdFwBLpPW27UaXDtNRW/vIgBDcbV+GYaZujbmYPuEQ5m2X7t2CnMVbJ/HXkmS9xi/092EWQdPzDdCesf+6OBTb/6wbtqzoIfdPkS4i3o5NIJzf00CE93twzbkxz+T5ebk/EKyTVG0WaSRjbjMswHf+IOkG42Qk53eVOx75XLzvPPg8kJfUXvU5dsTSz4f4kZNAokTfNRQC0z4QY5og7CyDYnu50AQ4e6c3DT3PmF5lSBIUl9iH14uk8FOy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO0i/b34tXG//kvU4HGnKVOSOCmwct33MArJWNqY/sY=;
 b=nqOtwlFbiFNkXFySfS807KkFOJ63/1zwq/fsg1w/RJbuBXXHVEn2bjzywgMcxHi7JyBzzTB7X4X5oxkBjOn/m7jbcrsskyJU20q4LoSExOvL2bRBcAsiPy0kaazXUXAsUSgXnEGtXc2KthVhlUtFLz2W/aQ8Hd0YQlKUkMaDoy+DPz5hi00Q+FyEgipLh6VY8mKhVi4+CvVrAJQyCXK1du6gRiHqT/nNkSTPVoIj4iRgxyO7KhDBbmCP0ypiRYHWuDuIVDwr9D1OfMTiFvxq2R5GlNjnYuI8wdbqlx1wups8vGWVseCOrasGeRHFBQuSHdVY2z9JLr4o/pow1FmnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO0i/b34tXG//kvU4HGnKVOSOCmwct33MArJWNqY/sY=;
 b=TwcHh/pwvFlJSThanmI7UvaqGe+L+BKfaTyD41diDd3dI0LozPXPYLKflULt/D1ET5riQg3uSoX3E7Ha1oPgW8XntPEtcu7z+lX1UpBvu/pRyqNqtY3HSp6uHKaSjBKPRDoPIAd2MzjCkKxbUzyZa1mC9GrM5UUDJEPa7wA+ZvMTU0dFSCs36A3DyiM8qHZsSbw52eM1li12f0RBzvbczlsBJGJ+3XVfUxnY9FbXjtNC/JNPrvBh2NMbBb5PIAtEv4j2napDO85ouT2xMmDZPgFMDdBlNwAyndpwpzIzL1VwDLAOfprOKKOSNIUkXGhEGO/GaBs9Ed91RZQnP70Jug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:32:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:32:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:06 -0400
Subject: [PATCH v18 12/15] selftests: pci_endpoint: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-12-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=1300;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+SgZEl+0x0mkZbAhvLt5Evhno7zgilVYjrIje6KjXVc=;
 b=JehGXaSQJ4KujakP5WgF9HhvLyEet8gPYZZL23fyfZp9mULVD+CHUw58BGB4YF5+HFQWNX8qo
 MRC3lKct3LXCKqRbK/esigFO609/Pvo4nunkyX/HbdNLFDAfCILpBav
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
X-MS-Office365-Filtering-Correlation-Id: c87d510e-2065-4ded-3b08-08dd7b82b729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXlvR1JUTm10Q2xXeFg0S1A5WG9JcEFtMGMwWkNMVE9MSk12ZEpwSDFxNmNJ?=
 =?utf-8?B?RFlhcWdiSjZXS0RYdUxPcWFpd2tTUHpTazFjd2gyKzJ5ME96cEFIRmhDVmZU?=
 =?utf-8?B?bFVWTVV6OXVJYVRtd0prSHhiYjAyQ2pDNzBSaWdMM04vZ0x0VDFyQzZ0N1FB?=
 =?utf-8?B?REZycTF5SHRXU0NreHl0dTV6R1FiSnM5VEtXY0ZEd3BaVGZDelJPQTI3M2lp?=
 =?utf-8?B?L2xVZXIzZGh6bkdvQjRSSlRldU5LNzhFTG40RjBJWnordTlkcnY5NysvNWZn?=
 =?utf-8?B?TmpOdDVqVVZ5QUw0OEhlbVROZXlmbVJkUDdPNGJXSE9yV0Nsbk5uem9sUlNx?=
 =?utf-8?B?YjB4bmVOZGp6N3c1ek85UTZiVWJOTkRMWXd4aDVMQXZ5ZWhmc0YrYUZ6ZlJH?=
 =?utf-8?B?UXFHc1lSYkJCMjNSdG5VN3VsRzY2T01UdDlCUWpYdjFQbG9qZ1B0RnhuN09S?=
 =?utf-8?B?djJ1SHkrMVFNcW5TNkNPMzdCMGRmcWNkKzRpdVhCWVc4WVlyaTdubzJkUGlS?=
 =?utf-8?B?aHo1ZDQyMW9RaHNxSVJrR1lXcXFXYkNXVHQ5UVBHOFlLbDViL1lGYnhPWlZQ?=
 =?utf-8?B?VkZ4TGRPRm03NnhaR2RtRzRVMlY3N056N25BMXo4VTgvVERVQThyb0xqdGNt?=
 =?utf-8?B?dUNUNDVjWlpUQVVDb3RTR3g3RzFSdHZ5emFMU1M1anhGZjNsWm9xVUhKMkRw?=
 =?utf-8?B?bXMwOHJ0eEpFSTBydXg3VWpsYTN5UzNnZkFWT1E3dTFCeFJHV05RMXBDTmZr?=
 =?utf-8?B?RmNIajlOcVFDbldNSjdmQmhTUUlCR3U4MlVHbmFrdlBKM3lmVktaNjlib2U1?=
 =?utf-8?B?ZmRIRXJJdlYvMUNBME12RVh3WFdrYmZlZHg2Q1B1dmpFMnFCcGI4b2w3dGk0?=
 =?utf-8?B?UXZSRHhZRHN6Q2Z2YjY0SlYremJ0U2xhQStXbHZnZGs0Ym1BRG4vVStjK3hi?=
 =?utf-8?B?UXVnYmFwTFRvbnc3RzVGSWd6UVQrdVU2UGNJeWtjK2FhYUo0MDNwYUxIeUJO?=
 =?utf-8?B?anppc1JoalZ2a205TUJITE54aWFTdGxvOWFDc1NJaThyMlJRdXliK2RjNW1o?=
 =?utf-8?B?c3pPZUVWQiswQTFRYjEzU2tnbEFJM1dyRHMvYSt2U2ZwVHFSaE9KSy85dkcv?=
 =?utf-8?B?S2ZSMEwrNjJIQVREd3p5bjdCMVBiaVMveVBlQnVzU05HYWpQMzUzTTcwSllj?=
 =?utf-8?B?MHZkWnFLeUl3UEdZTzFGbk9zLzdBRk1aV1hUZVdwaE1MVkZKRzdzdXN4ZlVX?=
 =?utf-8?B?YzN5QzVaS2p4V0V5bkFnWjVqSlB2aktwdGVFa28vb242YXVYaXBEOUFvWUdU?=
 =?utf-8?B?RE1JTUt2TUJTLzZ5RWs4N0RJWXNuTUNJSFVoMnd3K0lLNzBPYVo2bjBGeUFN?=
 =?utf-8?B?cnYrN282TDl0UGpNZGZCRDkzUEF5SkhhSTJETjE1dmM3ZmFOd0E0Nm0vVXVU?=
 =?utf-8?B?RURpOU1zRkFLL1JJc0NEOTgyRFNvcjNTVTk5U2N4N2FNbC9KbGJGQ0JMQVBS?=
 =?utf-8?B?b2lVZWw5UlRUV3BBWUhVdys1RHk0Y3pUWkF3Qkk5cXU0RHhza0NqSWJrMm45?=
 =?utf-8?B?YzFOWHp0K3N5bW4ySnhPWU5hZEFMZTVkTkZtRk40ZTRXTVZRcHUrVlhpTFZu?=
 =?utf-8?B?MWFjVnorUCtxbzRPaWZvNDFSUk5wWGJVVEo2cEdtRTFBRVEvR2J5UkZwNFJz?=
 =?utf-8?B?SkNUbHdBZ1EycEJ4TkR4bzRDV0tLajJwM1BRc2hJc0ltNzh3c1Y3WHZoS2wz?=
 =?utf-8?B?c1VPckdZWG9ZbmQ0SE0rV0ZpSkw4QXk5d21zR0djUitTbGxHaFY0c2k1RXFP?=
 =?utf-8?B?citpaDh0aXZ0UWtaRVhYcTRKYzRNdldSR29JZDlySExZV0ZHdWtqYmpaY1Nh?=
 =?utf-8?B?MnIwQW5ZSjFJc2NRSzFPV3IzM3p4S0dhZXhaajh4TU5oaENRRnkvUlVNb3hk?=
 =?utf-8?B?MDF6aEEzakxDQ21ZWTI1WDM2eTFTTmhaYjF3SXk5QmtFVVdqMEpEbnNiUjlC?=
 =?utf-8?Q?iu1OHIOSIvCZwjrU3+tuoprtZKlgrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2d3T0dPTmM3RUY0bHhlTkw4RTc2WEpCSUR2SWFtY2RQUzIzMjJOdldiVWRv?=
 =?utf-8?B?TkFWdzNoQWtKdDMxUXo3Wkg2blZTU1dnMjRuMmZ1WVFhQ0FtRDFVWCtUbnBv?=
 =?utf-8?B?UW9kRWZPSU9yeDJZV1dJVzNodjFwYmJYeG5lM2VRSWhqYVZKWHpuekJSR3ds?=
 =?utf-8?B?UlljbFlOelRxZGYyVklnakVTSVpiN0JYL1JmU3Q2Q3kvRHRCRnZyL1Nvai9V?=
 =?utf-8?B?MnplZlNRVFV0NFFBUm4vUU11TUNmb2NGa2VXdm5UVlZKRDU2Um0xTHZMb2ZS?=
 =?utf-8?B?Yk8vOHg3ekl0bmV3UW0wcDZiUUIrdXJuOWZ4RFhMVGwxUWkwR2wrdGMwb1cv?=
 =?utf-8?B?ekVxd3Q5aGdXZll5a3REYUlGcTBGcmhCRnRzcFlsekYrVE96MVliVGR6aEwr?=
 =?utf-8?B?N3hLOSs1c1hvT3FMUlBlRTlZSGtjbEZXRVZYcW1uZ3Zaam1nVDJPd004dU9V?=
 =?utf-8?B?emNxWTIxYTVHczdJUXFpUlhqeHpocmFoL3BudnhJbWZ1eUVMdmxDR0Mwa2dC?=
 =?utf-8?B?c3dpRVl3SGhmUGk4MnFYMm95L2Q1VDg1YndlMXZoY3MwWVVJN1NNSUxjdFJa?=
 =?utf-8?B?MHNwQVFLS2FUbW5TN3l1ajVOc2hIMTZyWUNFb2YrZ2RYRDVXZUg4dUJLRk12?=
 =?utf-8?B?RFBhYUNMQTJyYVZTOEY1aFJ4VzRmRVJTa2hOREJBYXJOQTJWdHRvR0RtZ0tx?=
 =?utf-8?B?TmtVZnhYZnJ5MzlnNElualNzeDY4ZkdIVDBYSDQvMlFNWjVxVmZvek80NFJR?=
 =?utf-8?B?S0VOYm9OVk9udlpMcnVxUFNXTnBWczJEMGhsbFlDM1pxUXg1TVJINk5tbWx0?=
 =?utf-8?B?c1d1SVVLa21LamZPMTVqTitGek9ORWxvNzBoTzdHeGR4V1pxVFVuS08rZ0xw?=
 =?utf-8?B?b1cwaVFNSFBSV1lCZHNsMXdQeG4wejdPZDB4YmxZUlpENGErLzR1SnZkR0FX?=
 =?utf-8?B?Y1ptUUZGTWJMYXBRdDJ0NVFaS0tJODFhbGI4U0lkTmZXeEdMQkh0bFJ0M2t3?=
 =?utf-8?B?a2hUd2RjK21EZGgySk9YVndTNittWkswczZRdmZFbktteDhMUHdMUHVQY0NF?=
 =?utf-8?B?a1o5UmpML3NQRzNmbG0rWGxHUExWQXJ2NXBwbDVWZ0VrdXR6V1YzYzZUWXZK?=
 =?utf-8?B?dVExVXVTdEdUekhHQ2JMTjhNK0RxUmJmelpPZ2s0R2M1UHN2dUhSVWlTWGd2?=
 =?utf-8?B?NXpVbEg2YzE1blZRQ0VicWE2cmlqTmNIT3c4ODhkNnpueUloNlZGbWdBa243?=
 =?utf-8?B?NnNqcCtXbkVtT05ZdWQvWXBmMUF3blNKN3QxaEZpN3ByQlBzZ2lqcUFEQnBI?=
 =?utf-8?B?Q0Z4UExRQVNQWW5Udks1U2k4UmxpcU5wWmFlSndaeXM0WkdFVHVzZGpMdmM1?=
 =?utf-8?B?VjBjS2U0TVRvcWUwMG8wYmpEV2NFUGlPR0Qxem5ZQXZyc1dkVWtQSEhiemhB?=
 =?utf-8?B?ekwzcGxRd2EwVlNKSldTUzRaVzVBdjk1TEhGS2pLUDFTY20rV052Y0xtWUg5?=
 =?utf-8?B?SXIwN2hGSkNydlFITHBzV2dpek1sREZJcDhPMjh6eVZrY283b3FhV1BpNnJP?=
 =?utf-8?B?OHc4RGJsVktkMnZId3BHM0ZLZHVmakdrWTQwVUt2SDB5K2xSQlM4WlVQaTlF?=
 =?utf-8?B?UHYwejdCUEE4WFl6TDJ6dVloTW9HTGhQQVk3WGVSaXIvSVZUTUprdGZlVmRK?=
 =?utf-8?B?Zi8wbkl0MHk2SWplc3VBUHBWNFl5QlFVVVR4TXRoZE9hNVVnYzQ1eTYzcDI4?=
 =?utf-8?B?cC91eWFMa3Y4Qk5ESlZFemtOWkxPZGhTeUpPZFJyekIzd3BrMjdBeGNQbi9n?=
 =?utf-8?B?YkRiVUZXSVg0ejRUK1dCSFMwaHZtMUJ4MnMwVS9HR1JYM1pReWFIQVdnbTdU?=
 =?utf-8?B?T2xrTmlFTFd0RDFiVVUybm0vejFQeVhXVlU5bmUvUjFSeE53NVVvcWhDSE5x?=
 =?utf-8?B?SlhwLzBSV3RxbC8xZEVEQUE2NXBzTXcyR3lWUzM1U00yaUhZZ09rNitjM3Zq?=
 =?utf-8?B?a1JXNEVKd2krVjRvc0h4Y1YrSFRYTmNyNGZKL25rTFBMSEtWd0dtaW5DRWt2?=
 =?utf-8?B?NTlsazFqMytKa2tTMHJoeTh5bWI2RXNRR01ibm1rR0JCK09BQUF3Y3VrcWE1?=
 =?utf-8?Q?HyU0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87d510e-2065-4ded-3b08-08dd7b82b729
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:32:30.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycstlvjybAg65+oM71ppWIK5hI1qvx5qE/LoB2pkA1rKEA242TBcaUmk6LShpRvE1QSyg02fYPEFE+Zz9SeJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

Add doorbell test case.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- Add set IRQ type

change from v13 to v14
- merge to selftests framework
---
 .../selftests/pci_endpoint/pci_endpoint_test.c     | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index ac26481d29d9d..da0db0e7c9693 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -229,4 +229,32 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 					 test_size[i]);
 	}
 }
+
+FIXTURE(pcie_ep_doorbell)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(pcie_ep_doorbell)
+{
+	self->fd = open(test_device, O_RDWR);
+
+	ASSERT_NE(-1, self->fd) TH_LOG("Can't open PCI Endpoint Test device");
+};
+
+FIXTURE_TEARDOWN(pcie_ep_doorbell)
+{
+	close(self->fd);
+};
+
+TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
+{
+	int ret;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
+
+	pci_ep_ioctl(PCITEST_DOORBELL, 0);
+	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
+}
 TEST_HARNESS_MAIN

-- 
2.34.1


