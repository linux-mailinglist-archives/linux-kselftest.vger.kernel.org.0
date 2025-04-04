Return-Path: <linux-kselftest+bounces-30141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556FBA7C3A2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3993B736D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE721D3F9;
	Fri,  4 Apr 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XIGTob6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB1222563;
	Fri,  4 Apr 2025 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793381; cv=fail; b=TLi9APqLqyaD03WvbheyDnxYgxfUt4E2x9YDS20ZtFQog71/5ZfAHnscYR91/57cYadNUOdWEnnI+htFBs/GHJ/cTUkC5bXWagdUKZJF985uQXxs3lxehycXABEusmeiiRtleZAfsCcF5ZjWKHX3iBsgUlFf6DlW1r5mgViaUzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793381; c=relaxed/simple;
	bh=E/+49PZzSike5Srwi1bFi+VTiZ02VK7QUYMJGqtvfmU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VksOssQHsqS5uQrk1bYfWgRg5RxZ05PpMLrRsw5rDzv54dlDBPTThrQfdhxYd4e+7JXLdwVrv5XOZk4uhgXB60VqeBnse4h9zdWX6/5c4cPQfup4PSgSPNNh8dLPBaWCy57Loezb4sauBFJ77Vq5DaxBDozcVle804wRR5ceEJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XIGTob6p; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAewzXo6EAyI/Lof4iUiG3uEK+wB725UmPQkpVuhJ6VzGlezEuXsSzod047tKZmXYH9V/oeI+0r3b44YmoRB82a7ojyxqCXsSxE4GZ92hXOu9LZUsDFCHX0c0Ff61xGsUnuGig8dS4Z9EJhd3mlRofd7QGTk/c6UR2YVDhfPZ7Qy7HSS7pthAZxXgeOS1/UkWUb/0WfjAXNY6OJKHQ27H/L87w5WKU8TmH7XjDM9XhGNBSrFQHZdZ2lG73CxITgnWTSZzgLrEfgdWnRB53PNmJ6gEVzn1PrQa4D5dYBaF8gTRYWUwnLmKzIKQEX8xdChVK5WWKlf7LBd/eoZwD0SJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Uw8VyfQPkoGAJ9vh4Z/t75FAVRHjabfWtBpwRAHpq0=;
 b=x2o8+ynvIhsmNWZYIm+YBhhSrk0wK7x2UL7oODpFdgCuLc+FIQL787LU/H1aNmH/Ujjad3Bkty7Vd7nF4iZoI59CdZmHjMkp2Qwfx2ONtVppOHdSiFxBjG2/atjB6s+8SkgYAHiVi5/PpanUO1YuEVZuqepeXhfffYIMUt1W0aV8dmUPNvERaqijdgVXL/gzmS7BWCEDAXiD6o9xykBoSrYExqZT5SOkdDXsbCQwD9DpdvNj0VmnqkbU8tqDeXpz9/Cd51d1EjOcOsbTbrTF2s2YNlprRnEsTFgrN2BwtX7QBiOiIYwc58++xgEB2tXOcSgk/x7/h1P42qaGjAjbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Uw8VyfQPkoGAJ9vh4Z/t75FAVRHjabfWtBpwRAHpq0=;
 b=XIGTob6pHcqzS6zBbq9PkxhEK4/I6qylToXa9eCNg2ucgVTG4s+K6Cw0IQtiaXivbucJxsM+qzTO0Gi5f6ArwcrFiO1q5PqiK0udZF99WJ4m3jLQmxl4vDoqaH41zyNmkJu0pO4LQpht73jtXAahzhrZFXMvgrDv8ymr1uzwUCCbCWfdtL7AC/4vAgFhKDtgqtFGaLMSmeiU+YcdFWAf8td0C6lBA0KhakyVgcLoVzv/yiT0RfsLvu+twcTIHkiOBxHYaKlFkAJhhqwMzwhPwJCAsCKmCK5hybvWaMXy02Te247ckQCp/53YJtzOe19SgbZ+Ezbrjmfv1tJ0rB6GdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6966.eurprd04.prod.outlook.com (2603:10a6:20b:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 19:02:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:02:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:14 -0400
Subject: [PATCH v16 13/15] pci: imx6: Add helper function
 imx_pcie_add_lut_by_rid()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-13-d4919d68c0d0@nxp.com>
References: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
In-Reply-To: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=1816;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=E/+49PZzSike5Srwi1bFi+VTiZ02VK7QUYMJGqtvfmU=;
 b=K0FBzefcMK/XQJRNJONk/zeUdL2/GAkAHHIO978ki/gcQN29bNfBGvKvTWM5g4b4XjqF1rcOr
 TrgMYLAgQwcAxUYFtpm/IX7nuursznbnDsx1VsVC6F9M5kO69q9EZNC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8e54b0-cdee-460c-09a9-08dd73ab4ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVRENjViSE5vdlgvZ1paZ0ZmMWJENXB5RGQzRFQxVFNJbmZMOTR2OHVwWVE2?=
 =?utf-8?B?NUZqdHdzNVBxL1N5Wmg4c3lCNEVHWGV4VHdqOFJBRDlwR1d4V3FRWlRXaDFq?=
 =?utf-8?B?eUkvYXR6V1EwSTFkeS82ZkFBT2lpalloS2NxZHVrcGdTUmF6TmhPUE9Ja2oz?=
 =?utf-8?B?dlRITUk0cDBhRGt2bjUvNU5BcXArWnlhMk1wR3d3L3l5T05HS3FVNDZuN3VB?=
 =?utf-8?B?RHU4MjdvSnI3OW9jdG9Wc2s4WHFMZG5jUnZRMHFNZHNwSkdDN3ZUSWVWaVox?=
 =?utf-8?B?eEl0TVRjQ3J5VXc3Z2tTb1VTcEM5ZTBPNERPbDRLYk42Um8yb3lUREt2alNU?=
 =?utf-8?B?cy9UUHRXRXd3bHFJNTBWWWMyeE9WQzg0TzNjUG9lbEpKREN4MUZHbTk0SFRR?=
 =?utf-8?B?andZaWJ3aGpQWXYwTFVQNmlaK3RWaXQ5RjNnRG9jenBZNGE5cmg2L2ppWWR4?=
 =?utf-8?B?VGw5ZmU2NHNXNnZYK1hSK0M5aWxSbUZxaXZ5bWgyWld2c3JXNjJBaGFlMzc3?=
 =?utf-8?B?TmJ3MTRKeUJuMUVRSldobHI0WFFUYkYzRVlpYy9mTnBJUFBicWJUVmNBYnVN?=
 =?utf-8?B?L0xKZjJjMFl1Q0g1SnNsME5SMkRPbWNqU3JIblpPYzdGUXJHUXpEQ3hmOU1X?=
 =?utf-8?B?MFQycTJ1TlBnYXRLb1YxUmNicDRlUWsveEc4SXhtUjl0YTRvOGYvOERhcFlh?=
 =?utf-8?B?QjNjb1pHZ0RhV3oyWFAyS0NRcUR0MXVyclhLc0JBTzRTbzlSNjhtUzA3Wm5Z?=
 =?utf-8?B?YW1EbzQvNDl0Q0JKT1RnRFRvdzd0Zkt4SEd2azJtaXVSWXVPZEMza0s3bm10?=
 =?utf-8?B?b2tUbWVSdkllLzVncVFRVTl5RWxsWnVUaGUzZ0FvYnVhWTJEYXJSSFlieWRH?=
 =?utf-8?B?MkNIRktyWjhsV29UdVFvUXo3VE5IWHZOMVkzMktoWVNNSVR0VFUxc2IzbDM4?=
 =?utf-8?B?NVVTZW1US1pabE9oSHJZVWNTWFBKcy92YXRtTWVHZGdBSW9kd3QwUklKcnls?=
 =?utf-8?B?dmVTd25HU1NqSE10QWY0bkg5TG1yVlg0c1ZQeTA4QWt4VzBlNEpkVkJRenh4?=
 =?utf-8?B?MitaeEIrRE8vMm45QkRsTFM3anhWckdwNVdEempCVGlxaUpmV2VaT3ZHWVl2?=
 =?utf-8?B?aHcwUzJTR3Vwam5WbktCdFNzSGhiSVYvRlMwYVNvbUtNQ1c4Q3FDaHV6SUpP?=
 =?utf-8?B?ZWwveGdzM0p6aDQ4TzcwQzJjU2F6VGEwZGRTVEZQcDY2ZTE4dGpCdmtHUDFp?=
 =?utf-8?B?eHpkbU1BVUNpb2k1L2VGVXpHd281aFNOaWZZSzlZOFJ0MFJSYnlMOWV6ZXBu?=
 =?utf-8?B?K0VQdTl5Y1FybnpFNFBsTXRTSUZTMWM0and2R1p2NmdLYkdLbVR4SEVqVWsv?=
 =?utf-8?B?MVl3QytFVGVUMmZQS0lvRkw3eWFkYnh5RFhJOTBjT2lXWHk5ZkZ3N0t0M2FR?=
 =?utf-8?B?Nyt1UWcwV2hFYTJZTVNTWi9wZ1hiZHlTWXVVQUJGVDgyYnZ3Vy9xVjN6S3l0?=
 =?utf-8?B?WDdTOEhNSHN4bklRRW5CRDhQYWo0Uk5pK1dLRzlsK0o0RUJLaGJGR2RtN2w0?=
 =?utf-8?B?cndEVDB4TDNiVldRSndRWGwyL3Awc0Fyb0lBQmV2aGRhbVYxenA5dVFlZzVt?=
 =?utf-8?B?SWU3R3VBbU40MlBpNXJTR01NeTRRS2ZPVngrMzlJTDExZ3d1M2NxQkFlTEJC?=
 =?utf-8?B?NFVwbXF5QkZCd3p1b0RCd2d4YWF4bXlhK2FGNnRsMjROTkxMTDNLOWR3MHpL?=
 =?utf-8?B?T1B1UitqcU81YUNYVEw2aFRpYlE4MDh0Y3R2V2J2NUVSWnluUWNDeklPeldq?=
 =?utf-8?B?S2hXNkRjaE9ZWm9sSUJ1ZFRIMUM0ZEtGN2xWWDk3bjFtNWxnYzhHZmt3VHJh?=
 =?utf-8?B?cXRJZnA4UGZRODRra2FPZkg3a3BDN2VXR0x2SytMRnJiZ1Z1Vm1idnJYK2w1?=
 =?utf-8?B?ZzZzMVE1Z0c2aEVpQWVQN1ZZa1l6RnMzV05yUXNuQW1iNERLTmRLSkVqanFs?=
 =?utf-8?B?ZEUvdE1ueWxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk1ERDNncFRKeVVIQ2hyODhxTEdhZWgzK01weExYNXg1VmFWOUxpQUwyc2ZJ?=
 =?utf-8?B?WE1yOGtGdENsd2FCNmd5M3pXeWQyeGR1QlN0eVlPcEhhWTRvaW9sNUZ4bEV4?=
 =?utf-8?B?L3hFcUpKbmUrRmx6RVk2aE43SDZnMDBCNThNSVRmZG5qNmhjMC94YWhHWmhp?=
 =?utf-8?B?RzBFaG0zS0dvYVFSQVRPMnZIVENuYmppc21sQTdDd2s1Z0JIekJzSlNacDIr?=
 =?utf-8?B?aVpQbXZ1ZzJ2c1dsTnpjUThFb2taeHh3b0tKcTFENUFjTkgycU9Lb1IyQnZh?=
 =?utf-8?B?Sk11NlVYZlA1anpwUGtDVTFUdWZTeWw5djJKNkN4azkzY3pldk1QL3hKMEJ0?=
 =?utf-8?B?VlVTUmJNMzhUWWlTcTlFaVM2UVI2RlZGQ0ZYMkxxeXBDdDFGVVUvd20xQmRJ?=
 =?utf-8?B?cVFYNnZKcTY2NEs3enJtMXl5WnhoUURvUDZQVy9nVllqQml2bjlGRmFUem9J?=
 =?utf-8?B?Y3NkTzU4L0R1UzRwR2NiamVoL1pTSUlnUlpEYXR3WVZCSE5FQUp4b2xHOSsz?=
 =?utf-8?B?OGQyc3BmTjZaU1ZoVjQ1Tk15THczVFYwUGw5MXVsd2Z2Sm5YVWdpbDM1Zi9n?=
 =?utf-8?B?dG5paDNHMm9JY3llK1RTUitsVmNNRzVrVWhod0NLVnphRUJ3UnRRZXBJbDlm?=
 =?utf-8?B?Q2MwdmJKeFVhWGFiWGdkTkh3SmhjdUZSUHI1b1lmdkVlUzN3NklTQ2NjTzd0?=
 =?utf-8?B?eGpOQWlTbS9GZFB1cW55cFJ1MXhZOTVaOEM5dXB5SWdheElQamNaTG50L2Jj?=
 =?utf-8?B?bzdUdElmVjNtZnc0U2lneHhDL0lRdWlkR29Hak11cGZ4S1MwczFSSFVRTVFz?=
 =?utf-8?B?OFl1aGdsOWhMOS8vM3R5NzRXZlg4aGU3MWlmUXZCT3QvdGxsc3ZqN0dnNFpR?=
 =?utf-8?B?TWpZVVlOWFRNSXQvZHcxdVdrZkpvaE1kTnRGOXQvVE4wM1lrZE9yVkxQODBG?=
 =?utf-8?B?UncvWG1XM2JkbWp1dUI3dXJjRFBIK2ZyZVZlRkpncVlEQVpVTk5lT1ppSlNo?=
 =?utf-8?B?bE43WnREVmhDeFZtQzFGK3JlTkFCVFdVLzRvNm52NnRoTEZvZWphYzNwSFZ0?=
 =?utf-8?B?ZEsyY3lKcWxtZXlZQlVyZWIxS3N0bVZWaUczbHQ4SDB6SXYwN3ZSeE11dFdM?=
 =?utf-8?B?UDBUekxJaHZhN2hxVCtXcjNtSFlTUE9BcGIvc2dGbXNENDM5eERQYnBwdkFr?=
 =?utf-8?B?bUdCWEZVdnFsU1BabHpzeEFWajZkSEU1M1RQaFpkaHMzVktMRTVyMytsQW1J?=
 =?utf-8?B?UHRUekpkRFBzQlRlRU9XekxIVGl1K3BCb1BOS0Q2VndQUXBIbVVuMEs2SFhF?=
 =?utf-8?B?NGVNM2lZZVVwM0pOS0ZjZ0Q2YzBPRGtBNCtGV2V1bEhCWGl0bm9qLy9ySkl6?=
 =?utf-8?B?T3dMVTVQejdoYXIvZzdSQnFLTHJ6bm0xanNGY3dPRlhOcU51YWJuanRqYXhz?=
 =?utf-8?B?WHo2eHN4YUxwRTBuUW9OOUVQMG5SWGtGd2ZITUxEaUNtU0J4RFFyVnJQSkRl?=
 =?utf-8?B?Y1RhVUZHZU12SDVWSjNPNGJnZi9YcDVwbE9aVXgyMUhUdmdoa1Q5ZGhYcmZS?=
 =?utf-8?B?RWNMT2ROdm1haGxqejg3M2tZZVV6bzgvOG0xTytqSGZCVnQ1V0RlaFBwZUs2?=
 =?utf-8?B?bzByNll0RFRhVGNWcHVRNmVaa3JTaVMyNndOSVdacW9GQWNEVWVZNVd5cWNW?=
 =?utf-8?B?MzhDeDA5ZjF1M2pacWJETDBWSDZsNWNwY0VWRDB3bVJLc3RXMnYxcjBFTXBN?=
 =?utf-8?B?TmZjUGZBY0kxOGMxaVZhZTFDeDlNR0tsVEFBbElTQzdIN3JSTlBxckRIeGU3?=
 =?utf-8?B?ckIvQ0Y3Yk0vQlpJOEQyR1dqNTZGaS9yMXZiNTVOUTB3dmVhUTl0MWdBU1Ar?=
 =?utf-8?B?UTM0QW1FNVl1K2MvNVZMRURoSHpTb3BxNktiT2tWV2tlY1FrZzZHWUo5aldW?=
 =?utf-8?B?YjBYSGNSaVBtUzdHU2ZtQ05DaHp1YUpMMFROYm5ralhvQ3pndEVVUzUvRCtV?=
 =?utf-8?B?U0w4TlZuWEpCMlphR2RyalB0dytsZmZmUWM2clByc1NoNC9hSnN2bCtsRkpO?=
 =?utf-8?B?U0xJMjM3M0FLUE5McXNEeitURkUvaFlHa1VpSlFuOCtnb0hmVFM1UXZtZkJz?=
 =?utf-8?Q?4EL8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8e54b0-cdee-460c-09a9-08dd73ab4ef2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:02:55.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQ4UkLj+33eBTNUiSIJh/HPkh4+Jdgn9ne1ekIlAHmrLwqUE7CdPkYlSeA4Bx+vZwccEQwqRjyVMA66Lf5jy3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6966

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


