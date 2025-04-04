Return-Path: <linux-kselftest+bounces-30142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C42A7C39C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F7417D6EA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A122222A2;
	Fri,  4 Apr 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fAipUcy/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2922257E;
	Fri,  4 Apr 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793387; cv=fail; b=tYP8zD5SYM2vJcMRL7iL+n2+6Do/ftpHR8MGFqPM3sDm0q6YP84NjImPoz52h+fKZe3GZo536eW1D2iT/NRuwSaZ9OQzLqFIgZJXYSxuN3Mum/vvZq9f7uL8udVH9FqddvJM7gN7nEHo5oGm0/ZsZIZFz/to6ZNMEQKdCBrWhJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793387; c=relaxed/simple;
	bh=y13NGoBJeE1mUHUBweMBxtJI2C8OON0QvH2vvgiDgJs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jBvpJCIe2WKVms4EDf98XbZUrkNt16o7KllQdrFbLaxv0iqKY3ju7Z5IquWFDAOJ/UqbS6JBzjsZ6/E2usqN/JQ6ydFDTXcC8I0cxyXOfwrVhtfNtkyeMQC6xEl/3UKCx6qo4ClPmRIaTgMFatIHGWkzUHza3pxD0TKb2tRczgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fAipUcy/; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs1XnALMIxzMByMZ1v6uutjV7yLDsp5Idj4iS4gc8GwKN/rEr5q2qep5lyO42sbxxmoL1QmclK3h9xKgwfzRwFiLzETBK1jj2RJEMIfJLmf+3nVs8kKscK+fI2wsmB7+pQs9sQ08WfVays+kGu+OUTXgKM7aw5xkq3vF3lDvew/cNtOwJG5isZ+JsxSG+XLTtdJC+kFIIJF9iQkw86zTTiNY2DTkn4peSCMIymmmzAGhS7htuOReRgB1y2jTwO0aL/+whJ+7acwHrFKHNfjPzBw7CY+nrsnMeghoa6GqqcZMm5758X1iTq9MuhqPIzml2vOlWichMlnMkuWZ/m1qUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbXHpTIvY3lK/PUhp27uVmw/pyQFw3cH2yjbLrE9G6w=;
 b=N+fTA1fbvb0dz7xUZrIOhnbP5uilpRSQLJgL6jhHnaffgO350AclgGY6H3VyduE40olIr/STh0cIqj088YrA/V5DTBKniIyHrHachQdup4XLdOSZWN4t3oBTNx8Huzo9r59dU/HyodJV1sIsj056tqxA66NWtskcN1HIeBi5VG+0WL4SDPAekhGDusMfzHk41yJAzPbH9t/TMLQal/j+9ZC2PTsJ58iWsMYywZ3pN7eFtlJAXCoDQdXw/CkZtN72LuIrNRobYWOB5BcInWc+PXppZ59mk7IDUV44pYKiYOsRjLl/N18pVcUcdtP2tP1jQpYBQTAVG2XwuaRMQqKSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbXHpTIvY3lK/PUhp27uVmw/pyQFw3cH2yjbLrE9G6w=;
 b=fAipUcy/HVhad7+40DT5toQdl/YfM5DgfkykYFRoZw1WV5Kf2G9EeScc9YEnMSs5dbldH+f+aMlS6b3WbwMGilUjbjvt+DkXY8aNzuavxBw8DhHqhGAlu0vkwbJx+Ayv7AU6v0NhjPxXI02L9iMyL3wKQcc/s6GqHZOe+vAorU2DBWbw7ipzpUtS56SFJKbSGA1qJ63AcXzZuP55402B4y2AUdfr1E7bSz1XWgtacGkPeTuK+Y+oUrsOwa35HoTEDbmgmMcBjoSl6n7ecYt+dHjh+ZNdApcCYIn55B9HNk+M6KKscZw9AMtraNCr1BHl5wx5Tb5yAIGVD+0HdK+VGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6966.eurprd04.prod.outlook.com (2603:10a6:20b:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 19:03:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:03:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:15 -0400
Subject: [PATCH v16 14/15] pci: imx6: Add LUT setting for MSI/IOMMU in
 Endpoint mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-14-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=1486;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y13NGoBJeE1mUHUBweMBxtJI2C8OON0QvH2vvgiDgJs=;
 b=LA/1ZGTjtjWjZZ+8a0NeE8RHCbYaAEKtbEzuculjIYYN0/6aihXgSpfJRi6PSJXRfYF0c+g6L
 pmyTaCALNL5Ccw/FPr2/ok5FMczhQ/VtQNIu7dBHTkCfxnH08kSjsks
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
X-MS-Office365-Filtering-Correlation-Id: 3323eb2e-ead0-475c-737f-08dd73ab52a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1RORjlrRS9jelRadUwxTTc4cllvd1k0ZEtPWlFsck1jWUlIMjYydEN2OXVL?=
 =?utf-8?B?dnN1dmE4M00vczBxdEJ3UERLSXNYOHI1T0RqYStHWGpkZ0p1OEFGTmgraFBG?=
 =?utf-8?B?UnZyeERJQWYxcmVTdlhVVm9nMURXcjEvcXg2aUNCUGdwOGhiWE1oazFISnBC?=
 =?utf-8?B?WGtHZ0tpMitWZGxMQ29LaVVGRlg4NC9jZE1VdkdZTzFrczRMZENWVW5FVHp0?=
 =?utf-8?B?MlBVMHA5ZXdkTlA3ZFVNR25UNUJ0MGluU1llTm1kcWdSYjEwb05YbUUzejFE?=
 =?utf-8?B?Q05zbFZkRVhCRStHZTkwSFo1QXZhMWF4SnJjMXpZZmJ6dVZ2VnhjQmRZblg4?=
 =?utf-8?B?TnptQnRjZ0VMQkNHWjk4V1lLcmVrcFBxRllMRVlzQUZ3T21tNXg4RzJDZ2Yy?=
 =?utf-8?B?cDl5ZlVjR21abUpHeDlMUEdZaGRERk1zeDN1bzBXRUU0UXBhV0lvSEE1Tmt4?=
 =?utf-8?B?bVJzalAvRzNGbTRUWEdYNW1QN2RJQ0FsaXNwbzgyOTAvWHRwQ3ZJK0dPdFpp?=
 =?utf-8?B?SmNCNmdZOGtRSTRvL1NZZlk5SjdaS2M4WnpOOFd3RlVjQlRHVWNuMTNCY1lC?=
 =?utf-8?B?cHA4VTBhTUtrK3pEVlJzMEZUUXNTV1B2ai9Cdm1IZnNKc2VVanUzbkNjNlQw?=
 =?utf-8?B?eUFBOTljR05EVmlvblNiS29TMjhxdDlIYU1WYlpySWlLK0k3Ly91UkQyWXJQ?=
 =?utf-8?B?YkgwejVFV1dybmhCaTgzNEJLZ0NKa3RMQWpBNnVmQk5CSHNyY3Q5MGdVM2xn?=
 =?utf-8?B?Ykh5ZGtueUdTWnA1NXlQWUdaeWlGR25NT3Zub01QR2MrWHVNU0FEdFh6TmNm?=
 =?utf-8?B?dmFTY0RjOEV5WURUaDNUSDN3cmI1UUtNUVNWc2ZJZ0JuTFlrYjZhTHFzZkJv?=
 =?utf-8?B?MlFxYjBqZnpHbFM5YXNpUG4vRTJKYldRZytBSUFSUUMrdjRHRnNycy9XODRG?=
 =?utf-8?B?Q3pRUUlxM2VPS2VHc2JOOXhaS0R3Z2Vwb1p4cm1XcWxZR1VhR1BFb2M5TUZB?=
 =?utf-8?B?WXkwWEJYaHd5Y2ozY2tabEZkTVhibEM0SGpYeldHSUcxaU83Vk90M0xVOHA5?=
 =?utf-8?B?WE52UFYzdS9rdTdGOTgxNUlUZHdnMjRPcXNPSnFyRkpKcHo3bFVub3dWNllF?=
 =?utf-8?B?TXRiSllPbVhjck5nbHBvRG9wMC9DTUpGVFdIN2NqRE96S1Q1cmhkbHdsdENt?=
 =?utf-8?B?N3BETVU5YkhjTjZ0ZWMydFN6RW1xVXZ6VFMwRXpzbjgzR0lkWXlRMks2VGhQ?=
 =?utf-8?B?U01uSmxCMVZFaUF5VGNCNFdyRHZ0aThDczR2SEYrNmpFaFlpS3BvYlJWOUsy?=
 =?utf-8?B?b0xIbmdscmhOWk5OSVVJaDFRUG56dk5UVjVjM3lDOXptQ3RPL3pMcHVNbkZJ?=
 =?utf-8?B?Q0Flc0d3eW50TmJrM0ZhUm1IVGlYOGNYYXZaeHJPYnZnNUNyZ0pJdzZLNFk3?=
 =?utf-8?B?SUNpdXhJWUtaUDBNdTJCTjk4NkNZVjhsM1JSWFk0MWVVaGpRMEo4aVlFZ3Ft?=
 =?utf-8?B?R0pvMWp3NnI1am03L3VyTGN6SHhnejNLOEc5cHh2QUtoTW1DbWVac1VNRG9Y?=
 =?utf-8?B?R0hUNXFkQUFjakVwdTNjbHRKdzl5UlRPZ1ZkQlhZbU50M3ZnRDZFNTFTYmpK?=
 =?utf-8?B?NUxsRnZHOUUyczRmQTRvZGRJTVNacUdYYmNENXRKM1NIeGwwVVV0eWp3dzdZ?=
 =?utf-8?B?NFNpazYyWWdjUm5OdG5pWU41eTRvcmZzeDlYRjM1YlJTbVVTWHh2V2dFcWhB?=
 =?utf-8?B?SEE1Vy8yd29JbnFCUXRyR2oxL29vYVlJTENBZCtRQmF2NEF6azRYNU5oT3lq?=
 =?utf-8?B?aVpmbVFxVS8rUy93RU85T3VUTDJma1FTSndsL05DWGNCYnBtUUVjYjV0YTFT?=
 =?utf-8?B?MWFiTjlkWUVKM1VTbkxCeVpxK1Mzbnh6d0pDejh2M2VvTE1HeDc4WjBiYU0r?=
 =?utf-8?B?Q2JXdzM1SE85Q1MyT2JvK0NSKzdpbGVyUlZvN0RuUDQvRWJ3NWtBU3FCRk5m?=
 =?utf-8?B?dkZidG12NFZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alcyeS92RTNvclJ5bG5CY1NSRGVHOHQyTlllZklZdURRb2dlZm4vbXhrREtE?=
 =?utf-8?B?UUJNdm1NLzFZTG13QzNWQXJvNmtiaVJ5ZFB2RjRyNmdScnEvZ294ZWRzUGI1?=
 =?utf-8?B?c0VRMm56MjVWY21EZkpOdnF0N0R6ZVVvQW5WZTJNMk1NL3NLSE9WMVp6YXov?=
 =?utf-8?B?S0ZHeWNJYUtUTHIzeWl3djUxa0dRTy9QZEtpWTZ2RnM5SjUvZ0NCZUxFRVVX?=
 =?utf-8?B?b2F6SkVCMzlnazg1dklXOEZNSjFWNHFSUnRZTDB0RGhKYmQrVEhDR2FHN0NN?=
 =?utf-8?B?OHlhbVBHMWpwM3RBSWtQcUN4Q1cxOTJQNGk2WEp3dDB1NDVyRlB5RmNNZFdu?=
 =?utf-8?B?akJuVmpONS8yOTc1REJkQllFMk83K3ZwVy9QVTl4bTQ1RzVoL0FqWmNFdWZG?=
 =?utf-8?B?TzJSZVc2cmVFaTY2a1FOaVhnWjBiMlJyRFFUdlZUUWU2Sm9BSkc5RmVCRmJs?=
 =?utf-8?B?Y2NMK0lsL25IUlByTUVKOW56d3c3RUgvZ3VKVmc5S3poMFp3N0JWU0lWNjdh?=
 =?utf-8?B?OVpETmcwcXcvejFRZXcxY0ZVU1dEUGVBUzlmb3haMjJDeDNKdkpZd25IVkwz?=
 =?utf-8?B?RHFjQnFLMU9OYmN0TzErNmV2aVlydmlCWGtoRG9yenBkU2ZPaVNSSjVZSDM1?=
 =?utf-8?B?UDMySSs5cS9QYS96d1hvSWtaYzIvUlk4c1BGNDRxZXpOeE5rUkRSdjh0RzBk?=
 =?utf-8?B?dG4weG44U0ZHbC9EYzZ1a0xFWDN3cHN1V1dXY3J5UDIwc1h2WCtUNHdqMGNM?=
 =?utf-8?B?NFJsUGc4RmtyZFRSWEJCUmNlWXFYYjdwL3psSzEzQmpFRkNuSXNYVDlhTFEv?=
 =?utf-8?B?VGI3Q0dTaUQzQ3hzZ242TkpMZGF2ak1QYXhOVUc2aUFYdlRqb2NSOGhQejFJ?=
 =?utf-8?B?S3hrOWtqY05QeTVQcWp6WWF0Y1JGb0Faak9FTGFkVWVVLzNNbXRHYjhZK0gr?=
 =?utf-8?B?S1lNdE1ndkFzMVR5c1N0QXRodEp2YWNQUWFLMkYzbm1EN3NwVHhKeTRoR1Zo?=
 =?utf-8?B?TFd0RWswcTV0bGhxNnRFdkxMVHpBZEcrdE01bVVqdmVONmIwQ2hJbU1SKzFB?=
 =?utf-8?B?RkN0TlJyY1J3ekNNUm1OMWxOM3pCUEo1TFV3cXQxZkd3UTgxc3ZzS3BjaGx5?=
 =?utf-8?B?NnVOamhEK1FJMVVVNG15SWcwTU8zNDhmUEtXS3cwRGdHNlFIeWFTRjR2Q2ZH?=
 =?utf-8?B?VVBnbVN3U0l5S2JOaW1QRmNlcDIzZTRSaE9DOGZCU293UWJaTFgyZXU4UjRR?=
 =?utf-8?B?cnNWY3pPSFgrZUhURHZKZkdZZmprd1hrdU5qVTQvdWNOYU82YzlBZjdWVW1W?=
 =?utf-8?B?Y3dyR2ZlRXZTb29TdW4zU203dmdOV3c0SDhicXB3b1VKTlllUmVFSkV3Y3ZP?=
 =?utf-8?B?NTNhTXRyZXFCL29rK2dpSjh3aE94Q250NWJzcVZEOEpnQnZRL25paDllT2JI?=
 =?utf-8?B?M3RicGltYmI2U1hsa0U5Y0Z4Q21GVHZCL2g4WEROaUZ1aXVyejBzSGZmNkFi?=
 =?utf-8?B?RlZ4ZlJ3cytIY1ZmUlBXNDU2RTdsRzdJNitKbk1OOFp5QVRYNjhjY1NvRHdI?=
 =?utf-8?B?aEp4RkV6V09mR2pRdC9Cd0hqcDlyNUd6aUlwa2dERytlei9Xci9MQS81TjV4?=
 =?utf-8?B?ZHYwdGRnY1h6K0YyT3NkTUViSE5pM2hGcnp4YTVFZDNVZEZObmRkT1MybmJU?=
 =?utf-8?B?V2VuMElmNXZqVHZpcDVGeDVxQS9obnlrRlBQbWxEYndhN3JiWEVWQWJybzM2?=
 =?utf-8?B?U2g3Yzcxd0x2STdvNnJDdFFrVVRNbld1aXBWMndBK3BFQ1Exek5zYmEyOTll?=
 =?utf-8?B?UVBRcGpLQTc5WVNqUnJ6Z1Q5SjRrNkc2Y2RTVysyd1ZtcHRkMWRGM3ZTVHBn?=
 =?utf-8?B?d1k1My9HS3JJOUtsNlJQQTMxTEFyRHdadzZZaDJOYXMwSy91QUI0Y1g2N0lx?=
 =?utf-8?B?WkxLb2szVjBWcmN3UUgwUWlZZUxrVTQ3UXNXaUxYekpoV1ExQ1NMUDVuZG1y?=
 =?utf-8?B?UTBjRTlaMTNTa1ZrQ2dqdmJCMm45cHppVk1PYXF0aFdGVDhwTDJaTWluYTlr?=
 =?utf-8?B?citjQW93dTk1Y2EwQ09maEd6Q3MyZmRKRTVQU1BZNFR4M0srUEZzWFR3MGIv?=
 =?utf-8?Q?Udbo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3323eb2e-ead0-475c-737f-08dd73ab52a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:03:02.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QDEswpRmQN0Rv++/MHpm5SBHhh3k9mDAPamAMXPQ6gH4hVlLz7/F/h+aCKFlAN8NNqZU6jVkrBxXZRmSEhyRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6966

Support only one physical function, so call imx_pcie_add_lut_by_rid(0)
to add a single LUT entry when operating in EP mode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d1b1365e7469e..a6e4630fcf530 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -992,7 +992,10 @@ static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
 	data1 |= IMX95_PE0_LUT_VLD;
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
 
-	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
+	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+		data2 = 0x7; /* EP side's RID from RC, only 'D' is meansful */
+	else
+		data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
 	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
 
@@ -1622,6 +1625,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
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


