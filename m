Return-Path: <linux-kselftest+bounces-26421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51896A31528
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D9C1883402
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1622690FB;
	Tue, 11 Feb 2025 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gNIG2y8O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621042690EF;
	Tue, 11 Feb 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301827; cv=fail; b=sJphZb34o9qBOktxoPrGrvkUO01fdeNmKsSDUh/gGjekU+qcPYt1eBgm2YeFcB5qlLQ9t/fW8QaBpxW//TaKOQGIKCpSftNvGdcg2CO9WcO5FkLtIH57HE6VEMHDLd2a1Ck13RrRmVbuHXAzHb7CVZBfC9Zz32CIsYvY9mxp7gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301827; c=relaxed/simple;
	bh=7pmqEFLHmuAdjphVId9zqY6Dp3yltx1/mobAvWyI4Dk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oTEtE6mIv796MVBLxNm5AjC7dpAfzZrF5LnfN5wUN3vF7gVd57mCf9KxQWceMuW7tw3xFZTr2yqfOJINEdiOAvRWTttTCxQNSpwchwLIaaKLqpdBjB1sZok6vZt1t/MVnw2P2F9vGNDbjL4R8bExKqKjh9JIeQLT0BvYkff7s2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gNIG2y8O; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rakR4oRP5p4PAJezcJHJ5Zeog+zNKWLigRVifeeO/uorGbqzyf0KpKCQ+Qe49608QN0ofAaI78u9bsKDDMDHFeclsFcbPkA5FcCfsQVRAroF8nFfiPGYwz8S2bW6A3P9QelSghTJ9LzPrb+FlFGWeyCcpJm1oubFhE408avPe6X5N8eMz7sKN4RmTKbvK22Ek0yQ9AOrR7F9DUtVCZEc4qYv6KrfcD5BFNS4kUtgWU4rt1P9c6CC+4m8JxOfH3WyEQUlWU9GBhy9WvAcgDYIDGWxL7zvgoPQZHy0V9flyCSFiKPU0G3B3Vris5CmAXX1HqoTpDYUe0XhDEyB6msfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heJI0gjvgnmhV259tk7QZqcCO0L/eWfnnIJKsXgCA+A=;
 b=QmHSfFmHBpXcgBeC9EU0/Mm13AsQ8PY1ZlsBvZ6lVVFN3nRZOaztECDIObQyq5YdOvi26SvJcyN2AtJVRw+CXKEKy+pI80QgU6S+epLnFs13bdzC1MBB5/iR8BbPE1wtY1jIbMOZG0692kuBNd3J5sdm67BvenRqBmmWuC5DTCFhn6I7U3U5LfSLaCS8EXtXm0ZpaqNhKbj52GvGzJ73KVtrc/D9vvSTqnQWLGEqC7bssgCCn0IAdRTCmoCNWdcLnJ48kHb1C2EasrBz1MK+NcXagJMUASsSoakT0oaBUM7KhgKhDnMCIxtBu/2tfuRyO2WSkjIVdB4PhjgDSCk3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heJI0gjvgnmhV259tk7QZqcCO0L/eWfnnIJKsXgCA+A=;
 b=gNIG2y8OwHbLZU+oPvmmoWDlM97l8F1BUZdLeJVtrXLHuWvz7SuK9tN4rfWPRIsbshXkszJexs/yg3NNnebvp+XylrGKShvRFW0qj6VW2Yb357kqI1PfGGP9++WZ0lw5x3BwSSVefLRFHoy32o2sZql9dkf+G78wV1x93H1b7zjwnVgiRUGLKuYCom/XBYjTNfZOixnJbLcUpt2SGQIFUhUrgWfUujA/87Epvljqy2jdXwnvMWcnZ5fj1JhUAtzXquBGKeJ04+3RPI9dgfZMy8w/qNwD2rcakIFx1MbgclEzsxhpPHiKj6pwcyNi4/1yWK7bItXswjlnOX3NX6MCsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8553.eurprd04.prod.outlook.com (2603:10a6:20b:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 19:23:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:23:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:22:05 -0500
Subject: [PATCH v15 12/15] pci: imx6: Add helper function
 imx_pcie_add_lut_by_rid()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-12-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=1816;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7pmqEFLHmuAdjphVId9zqY6Dp3yltx1/mobAvWyI4Dk=;
 b=KNe54F8jrdBsYpiTKquyZPbx5TB0HdgQVDlmvF+YwMK2c9EcqvpfL61drWA5C7JTCn0B21i8c
 PBpAKE3aQFADXWth+/sH0Y9Y9hWK7Kt6w3cny7v5o8Vo9SDZo+wx738
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb5199b-12ea-44da-0cc1-08dd4ad1985d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1BRUHduUkdnTzJtU01EakZvaEQreHozMVoxcS9CWjRBZ1NjbmVrZWxFNXV2?=
 =?utf-8?B?d0RLQVliOUIzNEV4cUZ6ME1BRjFiZWJkUnBpRWhaQXRaU05sQk9DTWQvZXRE?=
 =?utf-8?B?NWpLSVRhNkZXQTh6NzZkR1R1dXYxcWcvSkk5ZVhablhGd3JDOHBnNGcvY24y?=
 =?utf-8?B?SWhjaElVVVNFS2pnR1RpUHkzNjV6cEJ6b2o4ZUNlT3YzRW51QUpIVzl6N05T?=
 =?utf-8?B?Z0xxM1ZlYmlOaG1pK3BJRHBGbm9kd0ZkYmdMSkdsZnZwQkhENUtZZG1tL1R6?=
 =?utf-8?B?SFFKQmFSOUl2WERDeGZkYmJuZTFtYXpFQm9mRUxKcksxSGIvaWw2T2ZyZWpM?=
 =?utf-8?B?TDE2ajdFNnhuZldsRExjTVNGQWpzT3dSYU9FWFhsUUZNOEJSVTF0cUE2TWRw?=
 =?utf-8?B?WnYxQzJHTWdPL001OFFQdjlyNWE4NGJMNDhWMEh2bWs2UTVMb0RtSnB1Zjlw?=
 =?utf-8?B?cTRibE1jMVR2NU1sZ3oxbGtoZk5Pb1FTeVRCd3dSaVA0Zm5mekgrN2tEeUlo?=
 =?utf-8?B?SWplVmM1M2NNUkF3VGlEamFUaE9OK2FTcnZJV3ZxUVdxTFo3LzlzeVEzUm9P?=
 =?utf-8?B?elBvVGFVRmpYaDlKMjI3bFoyR2tyUUpQVXZoejhhbjZJYnBXWUNYUjMwbzAv?=
 =?utf-8?B?NFgydk5OaVhIeGtCRXV2M0VTdzhCdVFUMGJLcllLTFlBbzcreGJQOXdHNnlH?=
 =?utf-8?B?YnhhZFlKN1RTbmJaNGpOeTlqZXlCTTJObi91cTJWQk8yZmg1Ry9ieWw0YTBB?=
 =?utf-8?B?RDE2bHc0TmVVUUFaY0IxOHYrc0l2V3o5T3BmY1ZGeTdSM0hEZXAvMnl3cHdD?=
 =?utf-8?B?QUtmWFJmYmsxUld3VkcvNy9MOTdpL3pDWHJPaVVPa21SRW1mc1dWaUV2amYw?=
 =?utf-8?B?aXZDVjN0RXdwTkFmVTR1R2xsczdZeUh2YWQwNWM0WW5WWVJ5cEhtcnhtOEFG?=
 =?utf-8?B?OCtJTXUyMU1jZXhkY1IxVVVyY2xOR0dKeXlPSkxrNno5dHQ5ZkpIMk1hMVNa?=
 =?utf-8?B?c3ZUUFhVNTA0SWg4ODZFSjNVcVNpRUQ5SUNTVjNBWldzOXNLVTBVbVU3RUFG?=
 =?utf-8?B?bVVtWDdPeGczcUtvWklsZ3V6NGF3MFl2YW1LK2EvNTdPNUN6dnFpV1JzTjFH?=
 =?utf-8?B?NnlQYXdSc1drZGhuV1JJaVV2Q0lHdTlCMlFOOU13cTZIR1VkOGI3aWFUZHpE?=
 =?utf-8?B?aUk2RzBzNXo0ZXhCdFV6c1FQQUk1eUM3MERXMFo2WU5XQmdBUzFmUTRROHgr?=
 =?utf-8?B?MGR1RU54WjhrNFFpeG9RY24ybmM4aWZlL25POXVhV252a2swK1VXbFNBcjVp?=
 =?utf-8?B?V0xBOWk2NXRxbkVWMDJDbCtVYmhZVXZSVWF1NzlpQ2QyUkEvcVV4OVpOYmY4?=
 =?utf-8?B?K1JENm5vaUlXSjJJbXh1SnJxdFFuTVE3VWpkNUJDL2lYMzVPRG03dDY4bkpT?=
 =?utf-8?B?SFFJZlNiaDljdjYzbGtHWHN1MWgyRlJRYlI3VGZJUEhOMElOZkdHSjhYUUN4?=
 =?utf-8?B?cHVWOTNweHc0WjVQQ0JvWXk2dUZJWkFFc0poK2V2TXFHUVhVblVGaGNEdzJy?=
 =?utf-8?B?R21laEJVeVlLTkNDbUpNQkVHOUNLd01pUUs4TC9iNmhTUE1RY1g0WkVXazd4?=
 =?utf-8?B?eXdVdXF3OTVVSTlublhPTE11Z3YwT1RVU2VRZXV1RzBNZHpYZUQwdnlFWG1z?=
 =?utf-8?B?OE1IbzFpVURvNGdtS3gycnZ1WXlzYWdSbDhnUGtQbHMwY3dkckNRZ3hLSW1w?=
 =?utf-8?B?RWVKaHVwS2E4aVF6Mk9WU0hYUGM5N3VUWk5yL1g3SmwwL2NXaDZUTkNuU0FY?=
 =?utf-8?B?VVRRSVdnZ2g0UjBIek9tTFFFQjBOWWpvYUI1SGFqZy9xTEY4VzRiQTB3ajRD?=
 =?utf-8?B?MGFQYTN1THNjMzlSdkczS3lLS2VEUmNJeGdSL0Q2eGZhV0RqWk14QWtMclNI?=
 =?utf-8?B?dFVBU2h6RXRUd3RBQjJ1SWk4cFNsWm5DSklleHIxdkFGZ3pZb0xRTVk5Wk1O?=
 =?utf-8?B?U0N6ODNRM1dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEZmdndPbVVmSlVPNE1XU3AxL01zSk1naTBFcFh4SityM2wxY2ZXUmZhWHBL?=
 =?utf-8?B?WXZ6eVc3eCtkbzdkS1cyM2I2SElkN08rWnY2dTl0b21LNGsvc0ROSXpQT2Zo?=
 =?utf-8?B?dkdIaTFCOTViQ3VTQ0l6c1NZbFNhOEQzT2htRjJqZ2w1c1YvMVk4YXNBbjAx?=
 =?utf-8?B?WERpeWozaUZzZXFGWkxjWkZRcGJpZTU3OThsRUlkMmJoQzBhN1hZeUJRelhZ?=
 =?utf-8?B?bHgyZ1RLT1BmZ0FyOXNvOU1NVzI2L0tkVjR1dU5YemMwWHhqSEVYNUEvZWI2?=
 =?utf-8?B?Rmkya1pqQUUrMDZSYUtEMXI2cVJWaXVpaUdWZnc5aWlQaHZta0FJYWRTTytN?=
 =?utf-8?B?RWxnUUJXVGkrWmQ3b3VieWdWWE43NFBzQ3cvY0lSSXFsTHVGVm5rYlNUOElt?=
 =?utf-8?B?a0wrdEw1VEdlNGJKSkpzV1lQOE9uZGNHS3Z5a2tsNkozdGVCcldLSmZ0eTdZ?=
 =?utf-8?B?d3dUb0I5YnZCSzZqeXJLZjJESVlvSVUxSlE4YWFVWmY0L1k5WkZITmJkUmoz?=
 =?utf-8?B?NDBPR1hFNEJkNmRLRVJWRzhDR25qY1ZNZHQ0SDRETnhaT0dUc1BxTkhIYmUz?=
 =?utf-8?B?d1poVzFjR1FMdTdoL0pjMVliYlBxSGVQN1ZlWHFRQlZUeUJBNWZCK1FHd1A5?=
 =?utf-8?B?QWRoT2ZiQVVUNWpMcmF0QzF1SVdsYTlwSFZLMVo0VC90K3BOVXpDTkw2RzBk?=
 =?utf-8?B?OUZnQUJDOVRFYlorUnhVWUtsdmNUcGRnaTdONDBIV1ZtRElBY00wWWxacGx2?=
 =?utf-8?B?L05uQm11OUx1WktROFpiMFpyOGJzbGZrb0FvQlVWSTVXQWtKZGU4YmtadnY4?=
 =?utf-8?B?cDk3ZVhjbUZjNkt0bFF6WVFQRlNZejIwcjJnSEpKdWdIaGpybkQvTjhSN3NW?=
 =?utf-8?B?dFJJcUlzRmZuV1FyNm15NEFQMmFaK1I0cFplYWQ2aFgwZlJyRDAxalZqbmZM?=
 =?utf-8?B?SzdCZS9SUTl0Mkc0Y3BucmFiU3Y2Rms1Tk9KMStCZUp0OHc5bmpqakw5TjVM?=
 =?utf-8?B?RVQ4R3h6OEpKUVAvUWt6WlFYR2RlZzczbVIxV2g0L3JmWHJ2dXRzUVBYUzcv?=
 =?utf-8?B?ZlRJY1YyNHN2WXRZVDZVY1NOaVIxNXhaS1NtdnpLbi9HUE00cDhieFB3a3VH?=
 =?utf-8?B?SUhZNG12ZzJRbVpxYUNyMnBjL1psd1QxMnpLcTdpQytOaHk1cDFObk1VVXJu?=
 =?utf-8?B?TXNxb1o2amdDLzdWSElvUTVSZUpSU1NkRmZIeUxKRFVSZFFDL0Jzc0w4YUky?=
 =?utf-8?B?enhvcFpWcXZrNDQ0K3dsTkczZWVrazFEeXMxSUZHUXFvMmhObmFPQlVzVlRF?=
 =?utf-8?B?YkFqbnYwOXdVcTgyZmxHUTZ1V0MyMHNHeFU5MktvdlpNSGE4T0xDZGpnbkdQ?=
 =?utf-8?B?V21GMXhvb0NpRXBOSHdmRk53YWRjSU5HRndZK1V1MkNCeTV3cnJBRE0zU0NL?=
 =?utf-8?B?dE05RmZRQkNvTDJja1M2dVBCcUkvRXBIdFdsZmdrMFVycmErVmlFcGZBMDlZ?=
 =?utf-8?B?QnZVSVdJWmJHb3JxM3JmRjc2cCtWLzIzaDdVQXRkbU80UExLN3RnZmgyV3Rt?=
 =?utf-8?B?YmF4RjJIOGdLajhlMjVjM25ER3RDemJKdkYrbUtJV08walNGdEh1d1NzZk92?=
 =?utf-8?B?aFJSRElEcEUxVjFRN2loaDd6b0dkZk1meFE1MExLdHNvQTZCa1o3dGNSQkhs?=
 =?utf-8?B?UDBCZm55eXVxR3FtbFlmZTdvUWNkYmFjR1hFbXdnWk10OUM4V0NzTUtaNlBQ?=
 =?utf-8?B?eW5kOUZIdkFITHVVZisydXpsQ1k3eURrRy9JVTRGamR2bXZrNk5yalRwTGtK?=
 =?utf-8?B?aDVlSWxXcUdRQUdiaHU0RE0rNU0zcUpOV2Q3bnZoditiQWxZOGEvVUhmU3RN?=
 =?utf-8?B?dlI0akl0UDc1NEJrSnYzNm5ydEduam5FSzU2bkl4Q3RZVzNJN1d4ek1uUzdi?=
 =?utf-8?B?NUlWdG5HWUxYN1huc3lobjdoemNRQ09Qd0pYbk9KaXlNZ2lJU3o5NTAzVHlh?=
 =?utf-8?B?aXMyeXFQZ3AySmN2TFVUWEphT2hhM1RsbmVLUktWaVU2NTI2V2dIZVVvSU5N?=
 =?utf-8?B?QVB3djJuenZXdTZPSThkSkloeWtSUC83d1R5S3ZDWitMYVRVeVJEUG11YTEy?=
 =?utf-8?Q?MyC2gErUvqXEyqtRoOZjZpscM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb5199b-12ea-44da-0cc1-08dd4ad1985d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:23:42.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGdVlPYNVRlQib04xwVxe8k9JaaEyHkEXx7ezjcIfMglAa2gk0osxyCDXp/u8/ctZJ+Tm/fsghV6AI4HPtPw6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8553

Add helper function imx_pcie_add_lut_by_rid(), which will be used for
Endpoint mode in the future. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v15
- none

change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 90ace941090f9..e20d91988c718 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1028,18 +1028,14 @@ static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
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
@@ -1114,6 +1110,13 @@ static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
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


