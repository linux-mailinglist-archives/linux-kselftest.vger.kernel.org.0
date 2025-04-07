Return-Path: <linux-kselftest+bounces-30317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2AEA7EE35
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D47B188A1F5
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE1258CF0;
	Mon,  7 Apr 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ILZatc8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2044258CEC;
	Mon,  7 Apr 2025 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055548; cv=fail; b=Jqy4dhV3JwQsjOXu1Ze7dF9irvN08w3+4IlBySxb5UGFU/OVhxOFYEoNocOFv8QGmLVV6vMl6MM8ESBkg68eN4WHvtMGt/BjXIt4r0XC2LsH2GEwNJxZskoTG5c/pgaTTXffwW0W0SRMNAkz1y6Dd7gi3WO1XDA1dY0DOra9Xyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055548; c=relaxed/simple;
	bh=E/+49PZzSike5Srwi1bFi+VTiZ02VK7QUYMJGqtvfmU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WsHxnCBAS+0waE/XFhngdUYie0fj6Bg4koeebSoPnYlVhiYTW4AKsr6vxUX2ccvwkqkzxUaKfz84sTVLehKo5OPfnLKWs3sydEqcfbg4WB5dCE9UgrsyxGvr8Se9TcXu+zNN4jdF+eI8YvPPcn/vx6xGes+TNB3kd+oBFYbgTEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ILZatc8w; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9cXi3ahbTCIzajZL+g6Oq68FP4qM6bl9NkWQTYs9DyX606RJbbn2ocrFtcZp3OtjDRaNTF2ntNNv9Z/XtADZRyftLFeThx/3P4ENogfWd2EJHGHvFJAKMH8XEnZlomSBrClClVk29BGV3LcK0fkZeSTkFWMniCPy31eqLhPmKdKEoJ9YkZ5Us9IayzTprrHzcgGYe2fZPRUGO6EMQ2jmtk+vYUtNLfQXhY0FElUnUiaNGDMqaRutDuWYL4eQMr16gMB2FQpa8iL8kn92A6e2rXBSrdI9uuJQnOD3Yv1QYCZrpOLPbiwkqoq05ibuFxb+ytcmIwFtPW+4HF3FVLdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Uw8VyfQPkoGAJ9vh4Z/t75FAVRHjabfWtBpwRAHpq0=;
 b=rgwQaz0KqOGjrqTpMe9UDb8NPyD55+EJc1jaDXHtr/Wx6+hNqh+C0EZ89imPg0mU8lq6iXzNXzAZq92C2RgIkfDGgxrIGy0WIgwY5B90M0NqBzIBOT+7seN1/QmdpWbDzbjd13AfpsO+zUu6H92IvCSZddNhJ+9vxzkFWvpwbBuYGtSMLv9d/FCpwu5T5mnuGaxiWlGhi9fRuIahXmwMci9rdK/Rrh3NmpLzbqJKMu0zkRKcUt7uT4z9jiLkMyOX0aD2QNNYEbGQRJvTtrChykgC5MZkrgYEBbxoDVOULsg3qaXuKUNVG2xderoaTzbpCbdGXO6tbbEjZcKlvDHj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Uw8VyfQPkoGAJ9vh4Z/t75FAVRHjabfWtBpwRAHpq0=;
 b=ILZatc8wp1NEdXwu0GIpY0FR/Vxy3XzgNbcvizmYMzY2LssvuF0lGUtW2GJo2T60aB/S3VC90z0xCiqyJFp2qyFhrbILxU9YK+gcOmNll63YPODte5/59pJgSYqwiaKLreGBUHd3vmYHFOx11kxtkYLgoKt6HppXW6c9KAIg5+AS2BqK8rpR5Cgj8qH0iGFrWvbK1Qv5ZlxDXGNIXQh7DUy8H5vq56j50let7XGLDx7rUAAuAcCTesXL5wt7GtJQDSejza6jcQ9xgeQLlQ0JoM/oiat9HydQnaqZWqIiohYUV6IvPntbMIV44Sp6Sq6KNKI7ojIZkGtMsJ49PRiQnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:52:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:52:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:51:03 -0400
Subject: [PATCH v17 13/15] pci: imx6: Add helper function
 imx_pcie_add_lut_by_rid()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-13-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055468; l=1816;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=E/+49PZzSike5Srwi1bFi+VTiZ02VK7QUYMJGqtvfmU=;
 b=j8w0fAmlCpqyPHrV4N0qSmptnnmRiClhov/GE7Jurx7cOKQCHc6slb6gL0VhVirpzo66hJaiv
 L8kPU2Ejzk3ClgeorH8mvGFmW3dcOAtVnUGFoqpZuKuk6ysIMlMV5nT
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
X-MS-Office365-Filtering-Correlation-Id: f6183e42-0ff8-4491-7235-08dd760db68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXFRbkhUV2JaZENoV01CSmgwRktKQTlYcGRaZXoxV0xPN3dqVEJqQWdLRU5F?=
 =?utf-8?B?bGRrWE9aN0w2WFhvdEVzaVpTMjFobHVlckZWcnFCVUc2TTZlS1Yxdzc3MFBh?=
 =?utf-8?B?Y00vQ0tjdkJaWVI1Uzd1OS8vL3JEK2p2K0JLUVdtQmwydGY3MlhiRDNyNS9E?=
 =?utf-8?B?bUQxUXkrNDdreTNnMDN3YUxDVDlDcVljVW1wVkFkdzUzcTlZYjh1THN4RW12?=
 =?utf-8?B?Qml4aElMM3lrWWlNdXJoQmwrMXBzUW9URnNtdlJJQ21KSFpQOW5Ha24vVFVQ?=
 =?utf-8?B?UHQzZXp3dFdkQktIaEhZRzJYMXhlRE9GR1lwdkM0SGlkMlVDZHVIRVNZR2Ew?=
 =?utf-8?B?Q2xNZ21tdHVKVm9paisydnZjYmJxeUJEd0RFdmN3UUJKcTF4K2lMcnkzWncw?=
 =?utf-8?B?a3c0aytCRnJ3NVMzclBZRGpsTEdtRGx6Yk5VbHRxU0U5YVRSdGJDUDdhQ3J5?=
 =?utf-8?B?d3FCb1lqbDdWNkEwd2g5S2VmenNCV2tZWEI0VnFGUmdvUGhsaFpiQ2I0c1RL?=
 =?utf-8?B?MFZob05SUkFtNkFUdjJNMUJPRm41dmQ0NC9SSGtialhOTWpQVWxNOG5VVm5H?=
 =?utf-8?B?TVZjY2NTNEhkeG5wclNIZGIzUUVCN0IreXNucnpyQnlETTV6L2l2eG1oTjFo?=
 =?utf-8?B?dUJoQUJMZnBIbDRxU3hBaTVkeFVYODV0TVRkdmk2bFo1bXVzUDRhbjhuQjJn?=
 =?utf-8?B?b2xQU0ptYjZmd1YzVUFMSlQ4dTZiZ0UvWVlmRWtuNFdWVTl0SWVQY3RKYXlR?=
 =?utf-8?B?eERUQURVRkNRQVZ5WTJuOGFjbVRNaGVWMHplQ0ZraVpUMkJNUUxNd1p0TTNR?=
 =?utf-8?B?SmF4MWVSemwzak4vSVR5VHZaRC9zT0UwMFpTcWM2R2ZXYmJsZG82UjcxNTNk?=
 =?utf-8?B?cGVrMlZlUmFNU1BuTkNKVXJ5Tm40OXBnQmJrai9MSFN4MU11QlNib0NMTE5p?=
 =?utf-8?B?c3NRb01GcmpQMFdOeFhhTjFzZ1A3a1k2UDlyN2R0L0dnNkhwaldENzZzaDMx?=
 =?utf-8?B?S0NEbitBTTMyLzZzZXphUTVmaUpmU3JiWTZKWVk5cHBhSTNrazBvakNuWm10?=
 =?utf-8?B?R0FCZUhOM1dDSitSdUQ3dUk4cTBhMFV4SERoZnpBbkFPM2M2eUZubmtYU2NJ?=
 =?utf-8?B?NXlHNEwzM3loLzR5Njl3SUp4cTlDV0RmNVFDWjRma1hjc05Yc01WaHhwZkNv?=
 =?utf-8?B?WVJnekxFTkFUU2ZjbndnMHpMeThOaWludU9EeHQ5SDJOalpPRExhYWVyREhq?=
 =?utf-8?B?Y3huMnlYZFJZb1E3ZEp2RUxkRGozb0p1VHVmOENyTjZxSnRYOEZDV244MGdW?=
 =?utf-8?B?Y05ZbDFjMTVweWsrbS9qRVJKQU1hTW45MHlVZ2k0K1IvVU4rTTBmLzhlaHN6?=
 =?utf-8?B?ZDNkYm1PeStyVzVJNGFvRmJMcThvUTdveXZPSTVUZWdPOFpHYXN4eVM5Z2V3?=
 =?utf-8?B?QWk5bzc1c042TlZJaWxkd0NkWllkWkpyRTNidFF6MWdPd3IzNExjYnB0RnFC?=
 =?utf-8?B?WmlRbTFTTU1SUllxZzBhU0R3L3phZk45MnFDK0VkTkJWVTAwcHdudmFNVHMr?=
 =?utf-8?B?YXFSemo2bm8xbVVDRmJSSXQ3VzRoQlNGNkZ0aXZpbjM1WXB3U3phM25OUXdQ?=
 =?utf-8?B?RklLNnFSOEdzTmZTYXQ1SE9LNk5pVmJ4dUllN3Naem5jd1hGWVZtaGZOTVBk?=
 =?utf-8?B?TGt0OVhPVHBhUWQ5a2hlWFpYaTMxaDNkdTNNWlNJSG9IbXV3TXFjQjdHbWdF?=
 =?utf-8?B?cWtxZGcrc3N1aXNEL3NJNVN3R0RzSG0yNkhBV1Zta3liWERuWjZRQmY0ZS91?=
 =?utf-8?B?dHR1ZFE5ZVhUbFJyci9sRWZNbTJ4ampTbDZ3Q2JUYnVMeUgyN1hQWjIzK3do?=
 =?utf-8?B?NERPQnlVcHZ1Y1RpN05rSVZORUdTS3NSc1RMYjFhRExKaVdFK3VZaHVMTXNx?=
 =?utf-8?B?RjU3dm13MUpYOWF5bUxKMmdyRWh2aE52N2ZnWTREQnA2bG1NUWRrZk9TdXkx?=
 =?utf-8?B?akdPTTkvY1FRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTBzNDYvaC9IMGViZUZTem51ZEIrcm81SjRqYnlHQ2Q0cVlKd0JSQWxtcEFZ?=
 =?utf-8?B?amdZYVZrb2l6L1hYaFFuTzFYWmJLWC94Mkd1MG5zL1pQbUt3WC9mYTluSDl3?=
 =?utf-8?B?eFk4WWI1ZFRpRHJYSWJJRUtxNTZOUm43WGFPTDI1QmZENno0dGxIV0laSkhN?=
 =?utf-8?B?ZzlCbTcvTVZmV0tJbVpzU04rVld0QUNvb3BSWURSMDl4NkkyUU5jYXFsWkhH?=
 =?utf-8?B?Wk9UT1JmRnFlbzFMNFdLV1NPMVl1VzdKa2xPaFQrTFlwc1JpMXNFZG4rY3Fo?=
 =?utf-8?B?K0M1VklCUWlad2hmNnJYMjUyNEkzck9VK1NwQmhVcW1FTWcyVXNWaTNUY2xp?=
 =?utf-8?B?dktTWnNvUzZGS01laXVWQmdoMkZjRkF0NXJlL3pXcW8vamt6STFwSzBONEtC?=
 =?utf-8?B?TnJRZHJyaUs2UFlRKytUQytsUzNYSXpUa3RRNXcvOEs4V1FwWDJUSVBuNGV3?=
 =?utf-8?B?a1dMRGZGWTJaQXZrTjFTd0J6N3RvVFNwT0xIUmp2QzBNa2IyMW5GS3JUazZS?=
 =?utf-8?B?N1ZjS0E4aDJNaWowUkpDeVVheFQ5NkRYNFVwQVB5RU5NL3lzdTBRb3RicEl3?=
 =?utf-8?B?L1AwUnB6UGlBWlhwNHJnRWdYblMvR1dkSVlEbHFUNWtlSUkzci9NUndWL041?=
 =?utf-8?B?RGZ4cUovN0tUeGF5dnVCKzM0WkZVNWlQT09oZ2gzYy9nck1YbS91WnZtb1Ro?=
 =?utf-8?B?VmJLemFJWm9HM29GNFN0K043ZllUWjFKV3NpUWhtSzJCcXdndVNKVUtHVVZy?=
 =?utf-8?B?bGhMSUZjT3hWUlVrOHZtSkRYb1lCUldBUSt1TlZ1Z1BxVS8vODlOcXRqcjhP?=
 =?utf-8?B?RHRrMFp5WUo5Z2tBUnk4UUFyNlllYk4vMW0xWnhyT09zREVTblNBYnNvWE16?=
 =?utf-8?B?TW1XVXlZVkx6WXQ3RzYwRjFkTjl5S1FHVUhGR2EvZjN0YlhmWGVGYTdySHM2?=
 =?utf-8?B?anZDaUJyVjE4MmxjeXFuRDNiUjFsam8rUEZxazl1K2pYRTJFRllOMCtVaGRj?=
 =?utf-8?B?WWF0VVhSa0FjTDNONEc2NXltODFBaDN5eHlyRTBsRkp2NGlYMTZ1MVEzNDNp?=
 =?utf-8?B?K2hEaXRONmRpMWxRMjNYQisyQUwrTmt2Q2d2ZkNzSEdHWnJiMXRtWVZCU2hB?=
 =?utf-8?B?N3IySFRnYlQzL09VVnZOazRieEE4NVdPdERodHdLQVVqTzFob25kWDRpK0dP?=
 =?utf-8?B?azQ2bjlaTXBJYkh6aXNuTmUvNHVWUFp5NDFnRkw3d05weTNvRmpsWndNMmdu?=
 =?utf-8?B?eDdqY0lMK1VMU0dYREFYZjlMUmpVZmFNTTkwY2hRK01DY2VVUXdabFg4RzBM?=
 =?utf-8?B?d1U5YkpVd0NjRnpKNEpIKy8zVmdlNCsycngyVGFxQktwVUlhUGRrcE5RZ3dW?=
 =?utf-8?B?dVU2TXpsay9hYXRrWUpUZHNYbjJqVjk5ZDRCS0N0Q2dKUnBjcTFhMmdTRmJv?=
 =?utf-8?B?WExIOFlaNTRUUllEa2k1VWlOeFFPQlFBdzJFWURpZWNoMkpyVzNEWERFcXE1?=
 =?utf-8?B?S0R6enUzdlpKRzVHUmZwY1Q4eHhJSGo4NWZBTVZveWxWRzQyQUFra1RobDRQ?=
 =?utf-8?B?YWx6am4zNTZJYmJwM200czBJSmtHVVE5ditxZk4zdmtuRDRNVW81S3Z1UWtu?=
 =?utf-8?B?UzFoWmphNXY4cVZZRmp3bG1GempWVXVwUDVJTWFxQWRxbzdkVmh3cEpQcHJE?=
 =?utf-8?B?M0tHTW85QTBvQVNRSVBrYUl6NGVES2Z6Mkp6eUhPMlVBN0JINkpORjAzZjRE?=
 =?utf-8?B?d21mSTdiMGhHTlE2VzkwVnJUbjdYTERyOUJ4QXlRVCs3TFRIanhmanVsTUFp?=
 =?utf-8?B?ODRLVHJKeU1sTldqYlZMRlRxa2ZxaDBkbmVWVUk4TXhHVjFTU2h6dlFlMGVJ?=
 =?utf-8?B?M2NTWVBLOUloL2VMa3lQSkVLdVB1MGp1aERjMVk0UDZ0RGRMUVhHeWFsQmRF?=
 =?utf-8?B?QzJYUDVVck9jUFc3ai9IZlpaN1RlR2trL0RkM29tQjg0emZLR2pQd1RMQllH?=
 =?utf-8?B?L2M3VDlnMlR1Q292Q2VRQTNQZGp3UzlHN1VTU2xXNVlRR1VzN3FCVFdOR2ZY?=
 =?utf-8?B?OU5kOEZsSjRYTWxteGUrb0txUlRGb2htaEpCVnZGZi9kMmJpUVJDa0ZDNGZm?=
 =?utf-8?Q?wQwmbaG0K46ag6SbK6LbtWrVg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6183e42-0ff8-4491-7235-08dd760db68a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:52:22.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iV28CizdVmiUin/P0LMbj9D83t969PCeLiHPFFXQGHcbUr43z+dSO18qxKK2+Etsatq6CU3spKKjT8yB6PnOQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

Add helper function imx_pcie_add_lut_by_rid(), which will be used for
Endpoint mode in the future. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5f267dd261b51..d1b1365e7469e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1025,18 +1025,14 @@ static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
 	}
 }
 
-static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
-				  struct pci_dev *pdev)
+static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 {
-	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
-	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
+	struct device *dev = imx_pcie->pci->dev;
 	struct device_node *target;
-	struct device *dev;
+	u32 sid_i, sid_m;
 	int err_i, err_m;
 	u32 sid = 0;
 
-	dev = imx_pcie->pci->dev;
-
 	target = NULL;
 	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
 			  &target, &sid_i);
@@ -1111,6 +1107,13 @@ static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
 	return imx_pcie_add_lut(imx_pcie, rid, sid);
 }
 
+static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+
+	return imx_pcie_add_lut_by_rid(imx_pcie, pci_dev_id(pdev));
+}
+
 static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 				    struct pci_dev *pdev)
 {

-- 
2.34.1


