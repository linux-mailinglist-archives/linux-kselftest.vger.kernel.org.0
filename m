Return-Path: <linux-kselftest+bounces-30319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86926A7EE39
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829901895D34
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ACD259CA0;
	Mon,  7 Apr 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d752ZsQN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA49258CEC;
	Mon,  7 Apr 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055557; cv=fail; b=TN3It/6BfWU4/bqFfOAjKgAPZ6m6UcRoVqL37oG5ANwp2RYWk3ppY/+w18J9UTCbYgqLLDLPQD+ohLxMSpNWULzi/kKJm3kKL4NI7bxceV6SIuazZAcQRAgNKrjsrjYGwuMyc1xfawHHixK78diAMSpUQPY3blwi3hyIlZXbv9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055557; c=relaxed/simple;
	bh=qxV51hE9iVaqehK/qn4rz9KrbxpDkLsIBLjf7RRGT20=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CcUpOl5epW1F1AL+WBxPcNXl3EIkJkAwGuu6+0ezj1aDMEc3eaM2sLEw2bMdl6vWOwuRsaHhsWPq5cfYIwDwn7zMQ3Lhx2TxS7+V4++QqdZP130q0bmrFisFHIf/e3FvaJGrRecyNz2n4qAmcI0/aj0yrJnLoygskn09y5lcP3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d752ZsQN; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp06LB8Bek7Ua4jXlJlSb8ao3XYfSO/NQEY8XFizwWLTGL+6bZVdnVLyOHxAaDErmNkUEZxyIjRp6HeaaWi2X4cbkBBrF/QGsnm2yph1MQUcc0MT4b5+esT1Ey+INm5gLAhRGt+pIyGWaGbtX+ogUDidtSnXual88g9eq+XvdjbywblcnDYgclE5eu2b+Z7G4W0n99cU2MoVC/9TSZDHIMrkVxkdBVlbhr+N7I0G2VhuvBZPYCCupC63DPAMtXzOza4378mwIDuX0hPVl6QpEN0Zzihbe0dKAJ5WQ9uX9x91aNACurLXGnzNKbL2qDvFMMoJiXudXyMYo9SHZvdBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HXJMXZ9LGUTZustVJgA/C/zKgpGDb31Acgkq44bsAc=;
 b=FXSAd+YHTG8o0LSf/nB6U4faFM7pd2BixGY1d7yskMv/pxXCdRxwlILYAclNIw8NcDBwHrJXdRl0uqJ2vHavG2rd1U18AkwbRSREMb3UeQeG34y9KT3TBDmuE3Bd5LQfzLLjAXYkzBHDW82RxcGPJL5u+c+fSXhL7j9JJm77njW9168Uf/8eQrYUKQfnQjDNBJ8Kaa4EnG6KQNOcvcupOJvgL7/TVGciC0zQGG9jah0pNXlI8on/5Gx4kny/H0CunUdi/rLNNtaiLDmLpk7Sk0VIZz5ehY84Kcfeq89JtI1HH8g9v90SzwSZraDqzq1CfRvgZMgJw6LfO6GyNjuLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HXJMXZ9LGUTZustVJgA/C/zKgpGDb31Acgkq44bsAc=;
 b=d752ZsQNlLkRl+iX7nsN2I1hAwTL8q1PIOGI3zQcHCv+2m5H0wHbGI3kG+D+Hhe5i5j/MbgEDQIA3k39np8E8B0CLr0K+8R80oxQ4IohfzeP+nXL0fPqXmH6mXBzy/+KLv2gZYIlKDq2gFURztZIXUdU9YEZDSLm7BN4+aQXhnK+7ejYPO7bpCRMHjAUGCH6qBLyv19GXjc6ZbLYKAnLlpOqk1jDHkRrI7dm+0peVQUE5IJmvrw6mIk0KkRZTe6x2kevWanH6LvXGsN1W3HX5ON1yVid6RWkAt1blYoUHQxybjTR3NtdlbxRpeHvURPkUa6Bw89DycuEG8cagS/1YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:52:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:52:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:51:05 -0400
Subject: [PATCH v17 15/15] arm64: dts: imx95: Add msi-map for pci-ep device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-15-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055468; l=827;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qxV51hE9iVaqehK/qn4rz9KrbxpDkLsIBLjf7RRGT20=;
 b=r2+4fvsAkmquI/lDxL6ovaIFymtnoci8MOwzny0OC8txBlZqw8k4FA2/YUz17OfVfYmxv/mGm
 iuXOBfZVv4TC13rhFmXvJLx8G3wlQplCtBogmVwohaGgMRmCGywMwEH
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
X-MS-Office365-Filtering-Correlation-Id: 0da3af99-c323-42d5-0832-08dd760dbcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGQzTnhGTG1od3QrbTk5aFNGcE11c3pmTmoyU2JZSmNvT1FTL1VQWXRNMmdK?=
 =?utf-8?B?WG5ueWw2a3p6ZUNMaVV5MHAvZjBycDZtT29BUS9LY3NQSWMvN3JWL3hSMWNw?=
 =?utf-8?B?YTYzeFZRWU9kR1BzT2xpM05oUGozb3V5YkREL2lXazlGeUU3cU9EekdWZzZ3?=
 =?utf-8?B?WkFpektBM2s5VVJDb3dKSjVxMXk2TGR2UkRseTg3eVh4bUtzYzdCd0tXZWVv?=
 =?utf-8?B?eXIzdFE0V0ZJSmZZWEZtQ1A5TTliMjh2bzFMUER1MGZ4VDFqemNvZVpxZFMw?=
 =?utf-8?B?dTZWOWErak5mdm9tdGxvQ1hmQzBpbWVVZXBhWlVxTDFYQ0pTYWdKZkZBSDhu?=
 =?utf-8?B?ZGxuSk9VdkFoL0VZOWVhQVVydzlkT0c5Mm1OWGVnVm5uMkVnM1hFM2I4RlhD?=
 =?utf-8?B?N1A2RDlFMitsUWlFWUlKWDNhTTFUSkV2cEhkQ01YSlVjbG8xY2MySWRqR0h1?=
 =?utf-8?B?VnEwWWt0M1dDN3E4T0lJblQ2UkVLMllIMWxBYTA5SjJIeHJROEt5UnJnYk1Y?=
 =?utf-8?B?Yld2RGJhTk4zVDlpV0s4eWozamRsbTlGWTF6L1NvRC9JMkRDczVOWmV3dHJ0?=
 =?utf-8?B?YlZQQ1BvNVFiSmhLZFBjUUMvNGVzS0RXdXdTbjZPd2c3bnlWYjJMVExYMktZ?=
 =?utf-8?B?ZkFZVmp2YXNuOFc1Ty9HWS9YOFluQ09RN0hLTUpDZEk5elJjSi9pSHUrV1Vk?=
 =?utf-8?B?VXk1SGpMcGF6aXJQSndyQi9Sb1JCNHhmb2k1NDVmaUo2NWJUcithN2RucmZ2?=
 =?utf-8?B?MXc3VFVqUmRDK05yTUlDZnJUYTR1QzFoY2Yrc2srSm5zcktFd1U5UDBiS0Jt?=
 =?utf-8?B?SktZUTF4UHk1OFdGQTJkOWhHcXAyeVlmWS9RdHE4NzZUN3JvK2Q3NHR2Q0FL?=
 =?utf-8?B?NkR0UUhCZjRaSmNYSUllaXJiRGdDU2d3Z0UzcjdRWGY2NGRvTnFudnBnRzFD?=
 =?utf-8?B?M25GZFJtTUFaNFpvM3V0cUI2VExySW82SFpwT1EwdE9GMTB5U2dQNmtReW5L?=
 =?utf-8?B?MGlTWlZ2MGRoWEN6U1h2WnQ3MWFRN3VRcXFEdzF1K0tjV2Izb2JsYnlOdU1X?=
 =?utf-8?B?ZlRSTEhrRjV0bEltOTlpaDZVM2VGV09Ca2ZDb1V0QU5LZllwa3ljNHo4aXdZ?=
 =?utf-8?B?NkdRWnBEa3hKdFo0L2FQSHBBQUVHRnNJYVlxVWd4c0xmalVRdVg2UVBuMG9H?=
 =?utf-8?B?WStuZENIY0xzaDlkVFRBRko5dlBpbVhYZGU4TmpYVzE2ZFUySEIyWW9nSUk5?=
 =?utf-8?B?emlZalFRRUFaV1ZWWEdYd3owOHdIY3R0VlJWbCs4U3dOZUJzczRBcHUzMUR2?=
 =?utf-8?B?Y05mTExRQTAyOTNzVDIrV2R2eFUxV1NiUURSQ08wRkZFdWtUNXJ6NlM5cXpi?=
 =?utf-8?B?N2xIRlEwcGg3bkcvMm5RbVgzb3pWQTNWNDRLRHQwWTc0T1BTaW0yR293WjRV?=
 =?utf-8?B?dm9Bd0U0RzhvVHdyL1I4aldaV3BZUEZlVTh0dWNCaHFDaGtpejh5czhxK0Fp?=
 =?utf-8?B?TnpTdkl0ZW5HWWtiMHBBMW05czlrWVpwMGtVTmtMUFlGcGFQa0xUVVNMSnp0?=
 =?utf-8?B?NEhCV0RCdFI1Z1FONmJnOEZqUGxhbUNqQnJ1U3JPRWRlRHhlRGVDdi96cWh3?=
 =?utf-8?B?dG8yNHdyMWFtbHljcy9kaDhDUnZMWFo5WDQzRDQ1NEJOZHdxZmdjYWtLckRv?=
 =?utf-8?B?UThlb1h1cC8vSC91cjNMWDk1Y1orSHZUVVk4NkxkWHNBNVo0RUJ3cjVuVTFo?=
 =?utf-8?B?VFIxZXMzc29uamhmZGErZTVOaUJrWURENHB1d0NFV0g1OGtCMUFnS21DSnZw?=
 =?utf-8?B?MU5xN3ZhQzlXRlU3NzZxZk1uS3JmNnVGdWxzbVR5WkFVMDdrWm16a2FqaHM4?=
 =?utf-8?B?dExieWE5cjZudXlqWG1ra0hoR3M3NU9pMm90ckcrLzhlVFJyRXZVWHRpeW84?=
 =?utf-8?B?WWsrY3d1Ni95QVNrZlJGMmpuTlpXR09XYysvcERjVU1ZNjFpdXloR21DTHhz?=
 =?utf-8?B?RnB5WVFjRmJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlR6cE5XUzJLa3FpT0NqWThmaVB2Q0lUQU1BZmI2R2tKYzJRb3N6WUkzUDlF?=
 =?utf-8?B?RHpJTjU1VUlYMC82NDlLem5XT1hXYnloUVd6V2o4R1JNbUZPdkM1dTYrV2Fx?=
 =?utf-8?B?OGtrbndEMWdab3lHMXhjVVB0WUJvWlZDSmFLM1hqYzhSZmFSa1I5cVczNVBJ?=
 =?utf-8?B?UFFGUHNCR3BrdWF4WUgzY0lrcE9YUDNZYktURXZ2Zkc1OVhObUJzZlUzK0Rw?=
 =?utf-8?B?TWVwQkVGUXNFRFlhOXo5cWh0OTRYdEJrQ1N2NGFvV3c0Q3hSYS85VTJrb1c0?=
 =?utf-8?B?S0tLYVp2dVNqbnZWTFE0SFlDcjRERGZpKzJtazBoVitpMXoxZ0F4OWxTckFU?=
 =?utf-8?B?QzZiRGpkZmZEM2ZxbVd5S1VYekpaSDdWZkdPRFUwVHlBRFVucXUzNDJkaEFO?=
 =?utf-8?B?YUVHb2VIWWZYVVUyejJpNGxDelVtUmdGbG1NNmxud2hvT1Y1eTZjR282dHFQ?=
 =?utf-8?B?Z1BRUW9VbmRScE9RTFljMyt1blRJWWFPZFJuYlRHOElEcFhDNTJmV1hNSVJt?=
 =?utf-8?B?SlZPOUxzN3FjODNKM282RmRzUHl2dmJ5S3YzbVZURTZhTXBmR1ZxNDRNZitN?=
 =?utf-8?B?d3dHc0ZwT3RHY0ZxR3pnRUZHSEV2OFhudGFaVEtrNitOcGNYcFlKaStWekJZ?=
 =?utf-8?B?VjB6aXdKNUVRQzV1UjhWYnMzMEhGMTJRcldKUkk2ZFc5akc4WE9nTHRGMU9n?=
 =?utf-8?B?UHZMV1hUVmVoWGc1bDNKOUdCSVRYTzQ0UTBzU0NzOTFmN1BudGxqM3hjRStG?=
 =?utf-8?B?bVQwdnc4cVl4RVlickZCU1NvUUo0MmgrWTNjTFFuY3Y3SHZETUgra1BrZGhL?=
 =?utf-8?B?TTNjRmZHZHNnc1BGWUlPcWx6ZGpIc2ZOa2Y4T0UyMHQzQ1VmWWRKZzlRMERy?=
 =?utf-8?B?bnBjYUV5WE9TUzNpNGxUZkhMc1g2aUsyMXFVbE5Gc1hFd0xwdDdYbDR3U0c4?=
 =?utf-8?B?WEs0QWpFTVg4RDd2YlJnQ0s5WXM2U1FJVEZ0Tm05ZlIveHExVWVVREJyT0VR?=
 =?utf-8?B?MU9VVXBSNW84dDR4R2FOOWRTY3prVExOZ2ZiNWlrZ25VRWVhUEl4d2MrcGpT?=
 =?utf-8?B?QXp1RGYwcVhUZlo4MDZmQnpraElJWjc4ZXBMRURTellxL2RET0E0dEV5U2Vl?=
 =?utf-8?B?N2dIV293NktiSGxONVFlNVZxSTVlOXpTcisrYUoxakhaaU45aXpMMG80Tk5E?=
 =?utf-8?B?Yk9xd2pxS0hUdERYSy90LzNTRTRTeWk4bExWdmhpeDQrN0x0TjhQclU3dEtD?=
 =?utf-8?B?UmNIZDFCcW8wb084VjFKZklmZHNtcFVXRjR0QnR6Q0wxRWRHZEFjVTgvZVkv?=
 =?utf-8?B?dDBBRHRqbkY4MENFSG9UZDVBZTU3UDdlQ1FnQnd6VEJVQmJ0YkxRTDZHQ21H?=
 =?utf-8?B?a05uT0NqcUVYSCtNWWpnRVZmbm5jUXpRUjJMcG1RVHJTdHJJMThTc2RjTWNz?=
 =?utf-8?B?SFlqcm96YjFyZkhDdzhveGRyR1B0VFJGTmt6UnUya2JkMHQ4M1Z4M3dqekJn?=
 =?utf-8?B?b3BtcUlIdEhQOHRwY1o0eEU3SEpFamZCYzBneVhHRXhtYVNGdUM1d1BKTXkx?=
 =?utf-8?B?T2VEOWpRdjFrWkVmV0pzTkhYbnFySHcrMldRaU9kZExxSjh6Q1hiMjkrTnlZ?=
 =?utf-8?B?WHEzY1VMaXNUSWhpK0lia096aVF2N0J4dUMvTnVKZW5qRWw3K3dEL1hUT1hB?=
 =?utf-8?B?Nnp6ODVxQlkzMXpqTld6Vm5WZ3FvMjU3K1pabHdMZHNkN0NpVkhULzlRb2tF?=
 =?utf-8?B?dzh1eG9IK3JnQjNYUVlGZkhjQjA0cDZNVThUcU1RNEpDdDkzb2NFYVhrTERC?=
 =?utf-8?B?YTZqUVQva0o4VWlFWTdPVWpPV254L2k4cVNrT05OVzYvaEgwSTRMamloeDF2?=
 =?utf-8?B?b1pnQ3RWQUR2dW40WTY2UmRwQ2RuYWxBZ0JHTXU1VFk3TXduNEVidEwxTVh2?=
 =?utf-8?B?b3c3ajBVSFhvQU9yTm8xZTVSbExNbGdQSHdkMXdmRkNDZFg0VDJYcEVQQXRq?=
 =?utf-8?B?TXJtWUNjYlZsczdFT3Vnb01WNzlxVURuOFVncFV2UVNDOXV3dnlUSjA1aFBn?=
 =?utf-8?B?WlB4T05hYzA1eUFDMGpyS3FFZWhySU1XOUdwQmRPQ3RvaHNLMi9ReCtFSVVE?=
 =?utf-8?Q?YYkvoySe764/3fwezxr9rLZIZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da3af99-c323-42d5-0832-08dd760dbcf8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:52:33.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/kYlHgUn37NfHzz8yWaww88PoOvzMxELgOCoSF1Y+iZV9siMn1mt0C9iKiKw4jPYJaVXxnZ8usQMyp/fvZXaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

Add msi-map for pci-ep device.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- new patch
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 15ba83ce691f4..c3c76991f1c8e 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1768,6 +1768,7 @@ pcie1_ep: pcie-ep@4c380000 {
 			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
 			assigned-clock-parents = <0>, <0>,
 						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x98 0x1>;
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};

-- 
2.34.1


