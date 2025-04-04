Return-Path: <linux-kselftest+bounces-30131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118A9A7C36E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55CE17C748
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A0C220680;
	Fri,  4 Apr 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHn6eJX6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D527B21E0A2;
	Fri,  4 Apr 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793317; cv=fail; b=VbmDPByGbIcKAZJb+Vj0FPw6rYWgTx6OIwZxIz2KynI6x2xHXF9D2k2nb9CI5OS2BtvI5yO9tjaUdJhN3NhAdnu6UjiSRuneHKJtFXXs7ELQZ084AUCVEGHABbUqWnWr5abu58NyTq8IvMlZIA9mnUye0SHiaEvhLREaa/yYgG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793317; c=relaxed/simple;
	bh=nuOSilx0xFIrmQ7q/FNnVVZ6I8tKFEDBakFZ9GZOgfU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=atpuUR5fiIO9hzUWh2WmRsED64PMDCfDclnd0KrkadSvjMgwEsCaC+nHwnhL0c76oRjWuKx0M3DuCLFwdtrYEqVUp5by9n6fzq7UIwfHldwsJNThuu1aX5vmqQsVgACwPomU3x3iEP+hnOni+lVW6HEGrBORYRAtsPHiLxZgFgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DHn6eJX6; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fo79J6hdmsb6EdpNHvKdL8N15gCkN/wY3IAGt7B8SWip0QRfATj6WMZ12fZKE+Y6LQhHa6TVJLXOUBndC+QUgT92aXZpHqSfPdP1D6JtyT4GtmjBwsdB3sCzUI9JikpgjIparWzsUg72jOncPr/HbSj+38ylB/JwSiF3lLdG6s5MP4AeRNvIc7oH0ZfXDCPqeOcY82HacTGiTrdBvocdjKYMC4Wopqke8Wk1LD1rtWe2F60PV9nPzlRymE45mmH+Yv2Yy8D7MbU8hWmo+H65bkfU/2NohhgmhIDm6p88XmpSBTKA7fHEUoouuAzHlaIHZiiWJYdBUeqNrzbymoXTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvzvkawi1c4jyl+gIIApohWSfi73eTZ55zDdwaLFIxs=;
 b=TG7e2eI+KptR3yDWALy/khmBuCXhzXSd539DgOhQJCVtYV4eZEEQN17Rbbjy//WDmnPJ7RhfivHeFdlcO7NtXW/SG1WhVbj7eyMdlgVYL1lO7TVjsyFtnqTzNmXD0WSdwmmAh7srvKhDjDpbbQ3W+PYbrwwe1ZqBgb7OcwajIxDQ/JvZQ0+X5Gt+0iHQQ/m9iCKfO51RfD7dZ9Seq8wGQqHcokJRr9Ij33H1NcJnroKRUPW05WILEmmwhVkfrltXZescjEgRqMhrn2Y1YosdOSajKLuyskNIU4mqxy0EVRDIdiTwsDvTXFDTsf2hDYn24uzeetol1qET9oYksRy93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvzvkawi1c4jyl+gIIApohWSfi73eTZ55zDdwaLFIxs=;
 b=DHn6eJX6nSsvUSGKzSfLJlDPpIdGLXMTOlYYEDeTn84rDv70qJ9MCsATvnAz749r9h4uO/rAV6t3hpV4DBewlgxLPOb4w695+pgJzhCqGKypX/Hp9A1BbvnhAksVVS53755AWXfw0JMyYECSO+aIttJR+vzRroGMVxvLCOlCVIfp6HJU9hjASw7kceN7tui/2JZZg2OVuu8iP9xc8wsIlE7wqU1ulpKlhM9TFd3kQ+FkY2RtOQXFItEm/cUNu+sjKUW7q1/wZdAYwKJKjNC5J2UC5fUOAPQXFBaIq/Xz4Q1mXzfxjPyD4WA/i6pL+QmzlK8zZcCI+MNnf9Cwc6JVZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:01:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:01:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:04 -0400
Subject: [PATCH v16 03/15] irqchip/gic-v3-its: Set
 IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-3-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=1326;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nuOSilx0xFIrmQ7q/FNnVVZ6I8tKFEDBakFZ9GZOgfU=;
 b=3fMclYrp/jnpYoJhiR8raMxGRqTy2TBUVKnoU8z7TUGHzI7WlPdJN7sYrinkEwi8L+VPCG8pf
 hkzi/LXd4VsCIiR7KLB67bFX1ucxnCEstKMmIUSkz2URyyTHMHbfkAl
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6c0b3c-034c-404e-c1e1-08dd73ab2990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGVORk5OVlgvblUyOEU1WldVL0lnSy9iLzFrbzFJOTRyMGtBcHV2KytiblhV?=
 =?utf-8?B?MFdpVy9aTmEyMnlRNE9ZZUNxWnFPbC91STJ3RjFaNUpBRmczalZXTWpVYjFT?=
 =?utf-8?B?aW5KUmllZEVTcGpVYkd1ZzU0L2V2Rmg3eWh2N3VPQjhHcDQ5ZHZGQ1krNHEz?=
 =?utf-8?B?U2tSM0Vua0w2S2t6K2JNWGZVS3QxMk9oc25tanJyY2VYNGJUSjByMzd5MXlr?=
 =?utf-8?B?MUNvZnhza1dyRGRlL1hkb2V4UURlQzB2QnUxOXpvL3dSOFBNdzVjazIyaUpE?=
 =?utf-8?B?YVZmTXVwSjRhWnpWMGpnRjFScHFtTTBGZGU4Qndva1c4eUlpVkdZY3E1R1dY?=
 =?utf-8?B?aW1CWVFUWW8wb0V3Y3B0dWFwdXA1dTNxR3plVHAxZ2NnWmhvYmFnWHRXUS9j?=
 =?utf-8?B?N1Z3ZHdqeU51dlMxanBGZkZrUnFJek92TXFySXRFekhuU2pVQjJUUVZWZm1D?=
 =?utf-8?B?R2UvblZBZEdLWW5wOWc2TXNNZVlISnNtYStEaG5DRUxaT0ZmVnJ5VTU1QjM1?=
 =?utf-8?B?VUJ4TkR6ZEpNTFdROHdVZitobElvMENIN3FpTFpFMWdSUnRqZEIyY3A0Z3B6?=
 =?utf-8?B?UWFKZ1cyWlg4SzdRcHlkK3lPZTJhTjdlVS9aUlEyVG9POGNaVDUrYTZ0UktN?=
 =?utf-8?B?RjFMbWgvOVpMQ2pvdk13dVJjNFU1QlJEdVJzS2RmZ3FCNkhXNFN1cTVVTnZR?=
 =?utf-8?B?WkZZMFlrYWxNV2NaT2d6Slk5bHhZSUI2ZG9VbUhNMDcrcm4zbjdzLzdqWDBV?=
 =?utf-8?B?RUJtbUZqL3BWdkxZTG9zU1Q3cmZDSU1aOTl6bWhuTG1CZVIrWkIrbHptMlE4?=
 =?utf-8?B?bkowOHY0U01QK2IwdW9KNHFuV2tQMmpEV2dJbXRZbjdlYnFmNHhJTmMwY3E1?=
 =?utf-8?B?N3d3eVlPNWs2NTI4UWhzZi9yUWQwWC9iNGxzWjBGczNidFVKM1I2Tkh5cUJr?=
 =?utf-8?B?cFVCTm02ajhLOWhCcS9MNjlLV0NWVllRL2V3anI1ejhTNVRzY0VjUzNqcjZn?=
 =?utf-8?B?QmlSUDVIOEZsUkFhaktIci9lNW11ckpuRWNXK1dmRUplWVlnZllnZGw2VHZR?=
 =?utf-8?B?QjhBSi96d3p3Q2g0cFQrQW0zQm96NzhOUDNMaGtRNVk5L1hBUEFjU0VOVTly?=
 =?utf-8?B?NkY0RHQwRCtoQzR6NFJpTzZlUHdGTjlZemlvQW9wRmR2ZzB0Z3BPWFFFdXNu?=
 =?utf-8?B?VHgxQkFtMmkrT1Mza0NkTFRrWG50VkxIZXhEUXV6dFM1OUFRZS8rZENVRGxG?=
 =?utf-8?B?aTNGRk16cHAxUllOS28wZ3hYRDN6NXMySFpRZnhaNG1MVHBvNFFRMDFlZjZn?=
 =?utf-8?B?VGlLQlhMbkIyaGJia3g4M0VJQ3ZodkVLUFJrOTgzd0l2YUtCbEEyZ09laFBl?=
 =?utf-8?B?Qi9MRVBzazBVSnB3NlpWZTg1UzRvcWFKbjdMVHJibFVSK1c3UzhUN0JyRGo5?=
 =?utf-8?B?SFN2QWIxczgyakhQR3h2aWxGNkhZTXZrYjVqenVnZXhXQ1pvRjdkZUtFRkxh?=
 =?utf-8?B?c0NReE9lMjZ0QVFzeW92RWtiZGlTRERXVkhsUnRtWjBCTGxVTDFVV1pSSmls?=
 =?utf-8?B?VE1qcWNYS2RHRVVubkVlMGJjcitjMmZWY1FQNWpOT0lrWmp0SHd2anpYaGlC?=
 =?utf-8?B?aVIvblMydlZNZ29JREhwbmI1Nm1mdzY3dWdtd0hHWU41blc0T0xBMG5MRUEw?=
 =?utf-8?B?SUtkd1cxQmwxdjd1dmRoSjlnU296SUxwQW5oYy9DdnNNZTlPRXFRUkZ1RGxW?=
 =?utf-8?B?RWhFWkRSNjNWMkp2elNQTWpnMENGTXNNMVA3Q3huUjFacWpsN01LbmFxcHpp?=
 =?utf-8?B?V1hlRVpXMEZXcGg0SjU4NGZjR3ZsVkp4aHBSK3VvWFUxakhLMjIwL3Qya2N2?=
 =?utf-8?B?WUloNk1RZWhGOWJYdjcrUUlJYURwT3RpcEQ2R1lNNzRpVm1NelRTYndwbDNi?=
 =?utf-8?B?RkVWdjdGcjJxUXhYRDJxZDVLQ1BCajhsUUMwTUlWQ2J5azZIdUk1N25ydDRD?=
 =?utf-8?B?OEFic1lRRUFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEZSZDlqTXczMHlZVVlrNFZsd25DbjQrekJJb2ZVNktqL2I3SkFsalRTME1W?=
 =?utf-8?B?T0IxS2JsZUxwRUtvZnZWb1NleVlGeS9hSzN4RU9PZzB1Ti8vcTVheTlxaUdL?=
 =?utf-8?B?UjhmZlVLSnZNTk45L1JCQTZvcVllM29za21ubVdZeFdMaG1Ec1ppL3FqRi8z?=
 =?utf-8?B?OEh4ck5IL09PcWMrRTJ1OHB5eW1zMXUvajZtUVJiSjFqajFwZTVNaGlhVTNW?=
 =?utf-8?B?M21zcmdPdDFQRG1qR2tpZS9Qc0N3Njd3TG94dkhUUmpLVW00SFoxSWhjZ1dH?=
 =?utf-8?B?ekFVOEYveGNzRjJGY2FmUklEd0wvSlhZaXlmekoxS1praEtmQ3I0NC9SMzlp?=
 =?utf-8?B?Z3BSUzFFSVpDZ01maWJiUFhOOEEydVhXL2JEaituOUpaa0Y1Kzk2dXlyejlm?=
 =?utf-8?B?eDVDUmFwWTViQjJtWGdOOEJHNFVMMXhxdHd4QmRBb29Lb29ta0hhL1RZUlhC?=
 =?utf-8?B?Y3FDTVRjTjh0RDRhQVBKYmRKa3hzeW90K3kyUjV6ZjJKSXR5Z3hKNmc4N1RC?=
 =?utf-8?B?WnhpZmtpT2M2MHVvZEJMbVlzMmN6UXRXOXVoQkc0ZXhKaWJOcHdpUzdOVHh5?=
 =?utf-8?B?aFRLSUl4S0RPZ1ZodHFDVGNUMlo3WGlkSkw4b05ocW1wblNHWXN5UlE1WFBa?=
 =?utf-8?B?S2U2bXpyd29IblBNU01vUW9hQUpGejBRZUhrdkd3YkNNdEk2cVhEZlBFU2hY?=
 =?utf-8?B?b0NybmlHVy9pdStOUXhtbEhzSDZtdHB0SkFmWHRqNm51UnpxeFl4Y0kxZXUx?=
 =?utf-8?B?WlNTVmR0ankwbEVTYmdKSDdQMWlwVXJQMm56UjdPYml0MzhjcDlZeW5IR0hs?=
 =?utf-8?B?YURJSW1vMTBzRFlCZXhVY0RwcWdZM1E1akJTRC9CdDNPcjRtOTMrOVJwUFYy?=
 =?utf-8?B?dnA1L3k2L1FwbmdQV1c5Y0NvOXorSjdESGRoSDJXTGZCTTlObmdYbjBaMzRr?=
 =?utf-8?B?SFVXT2s0bktoQ2FnMzNjWU9WVlFxVDYyNzgwd3ZRNVY0WCtpQ2VGMmlyZkxK?=
 =?utf-8?B?OUpRZ0ExWnpJc2VKVjFRWEcrcWNYYmp5VkJIaC9ib00xdTJiTDYrcnNId05l?=
 =?utf-8?B?MGlWdExvdVJWbnVjZldzUTBvZ0ZzTlhCMmhZeW53VVg4OEdUY1NmZGQyRkNk?=
 =?utf-8?B?YjJCVFZaTUltQUdPR096aXgyZVo4ZFcrYnFYQWJweVRPQlo1K1VTb0RVMmo4?=
 =?utf-8?B?czBYdVZGOExnck90dUJGV0pSK0FpTU0wSTRlVjIrTkRuWVBLYWdhNnVwOGdl?=
 =?utf-8?B?djBjSlVDZ2xBVnYzcnZNcytORWNhR0VKNWEzSXlGdTU3NHpjSnpja0oreHhX?=
 =?utf-8?B?S2tidXhEeUZUMnhYU1JpL1hHTGRYSEFkTFVRVkZ4QnBPSzBkMW9GMzl6Wlk5?=
 =?utf-8?B?VFlKa29ISWRVblVEVENEYTlzUS9RNWJsWDdRUjhxMFBIcG56SHBkcHBSRG1T?=
 =?utf-8?B?RzBXa29NZnN1M2ZTS2F1S2pJV3ZoTDUwcVBJLy9rTTEyMGtoVkJtdWI4N3V6?=
 =?utf-8?B?Ly8vVDlMM09RR2o4d2xQa1JSdDFKTExXOWhvNExDTDE5d29hb29mOXVSOWxo?=
 =?utf-8?B?ek8vT2NwYzRibkZXQXlNRHordldRL2N4NWs5dUVPRVpKQmxDbkNKWHd4a04y?=
 =?utf-8?B?K0trdGpSVTVsMnJkRVFTbmV2aU16Zk1vYXhMWnBhNmNyaGpmVnFiejNSVWcx?=
 =?utf-8?B?UGhDaWdwWTVzMlhSbDYrWEtmYTR6eWNlOGZGY3Jmam5pRHVNVlJVeDYyUWt2?=
 =?utf-8?B?bUtVZWlvajE1RnFKN1dhYzJBOUQxZDBFaVN1WXJyZ0Zpbm0yTzBqV0lINW9N?=
 =?utf-8?B?SmpBd0EyYUtnREZNT08zYXNZc1h2cVpTUmF4VitpWmNHeVNza0Irek5vckox?=
 =?utf-8?B?YmFqZ0JzU2xKaFpGVGZXUnN2L3J3STBIcVNzalVIcWZKNjFpQmowN2FuNXJo?=
 =?utf-8?B?cnprM2JTQzBpWXhDTC8zZkZoNGY5K0E1alc2M0xNRlEyNWE2TmtZNHZtY2Rt?=
 =?utf-8?B?UUJiYXJlMTNxZlpTU2RTSXBJU3Jic3JpdjIzUkVnVUZzV3VmSjlBN0Nwak9J?=
 =?utf-8?B?Z2VxV0poYzZtVmU1WW9OdUZ3QTcwYnYxc0k0aXpPOElqN2IrNGZnSHZBOFlP?=
 =?utf-8?Q?6mu8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6c0b3c-034c-404e-c1e1-08dd73ab2990
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:01:53.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8Qn+KKmiJWm54Bi16qDx/RweeOqrFeN+9s36/JPR54kwuoeOFu+RivJjb/Vvr3YLvIDZOjUhTqeEKgRFMoA4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

Set the IRQ_DOMAIN_FLAG_MSI_IMMUTABLE flag for ITS, as it does not change
the address/data pair after setup.

Ensure compatibility with MSI users, such as PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged. Enable PCIe endpoints to
use ITS for triggering doorbells from the PCIe Root Complex (RC) side.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v12
- roll back to v12 version because Marc Zyngier have concern about add
DOMAIN_BUS_DEVICE_PCI_EP_MSI.
https://lore.kernel.org/imx/861pxfq315.wl-maz@kernel.org/

change from v11 to v12
- new patch
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0115ad6c82593..fd6e7c170d37e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5140,7 +5140,7 @@ static int its_init_domain(struct its_node *its)
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
 
 	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT | IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
 
 	return 0;
 }

-- 
2.34.1


