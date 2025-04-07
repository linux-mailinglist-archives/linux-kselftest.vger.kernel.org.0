Return-Path: <linux-kselftest+bounces-30314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1C6A7EE2A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CDE188763D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B92221D9F;
	Mon,  7 Apr 2025 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S1bgTBOx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B572561D3;
	Mon,  7 Apr 2025 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055532; cv=fail; b=nF85PHyvR5+LGrJqN3NJjywNFFwtFt0Xl597KwCsUeJ1Ox9WTBCAp06JMsU12EF9L/bdIMHyIg2cQYRy8gnBVxSpcg4c5n94vzXwIN27n67bwTQnMO33gtkoK+34sxW7g450EszsB/xaelBoD27e47AMvLVIR/ele/0CnZWo4eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055532; c=relaxed/simple;
	bh=GZxnLuC67KA9+f1ZFFupamn6BH671XQaImre37vE7/Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sLFxKMjqCTv+U9zzEGcJZYlvhncMRW/U4bh8bzoCSCtkleFUJYWb9UAiuDE6BWSJycVa2Ciq5nZSlposppHAJfxEpK1ki7w12KWF+my8qUbAarj3EpXU64hbHhyduCuni8MWofDnNWdvnIA7nVgzwr6ebY0VjZAxQsmtBBo9fDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S1bgTBOx; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0DjktY4ZR9fjVTvV3baX00VJ0S7tZuj2Zw3v2e/glhXMopZzf5/qLGp2yREa/4aRvQsqLP9X9jflOnhu/NC6xbCckJlEzGnylNlSUC6I7R9vSWSFToHZde7PjN+3KgddMVeEY/d8JAwUrvYg0hFn25POw2Mx04bDMSiWuZlIKEhRCHSWz9JWI9/q1RsKfhODGUhcThzMQSaHTlAj6LkWZXpEFzyFD2GL3eDtzxp7fqynN4mX7fqCJ3GmLG1K3dC6uL4AUOuQc76YSQxX/wEvec3M1bj9FTtwBvjbdrWteHmKBBRzWEDKdb51Stjclzk5wR8Ri9HluEzsowZGBj+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKlGqegoRweF1++Jqh2S5594pr64Kj2EekHsAJSq3y8=;
 b=tt6YYDAq6uEeuT/zeG93WpmG80lpnr/HxxdfWQ/zjsBaTTLOt5727ELJfRWuvV/ukD4cwaEmGE+Vs1SMILIbHk2Oht2u6uhiOu43sqPFkn+6YzZj1B3ObgMMydmvq5XWnyXgb2CwynhbqV//xedVqBW0wZ1VA/MccaHbrWcRSjPH3vpRapMrcNUgZsOTk0xNDRnPj4AmzE4EJ6eTx5X0l3/axt0n0k7SRTW5eyR3l7ta1WPR+ymUPb9k+pEeJJgNvtIPfJBxMy/QG7IIb3Orwxe+hQXd1wpX9rpgFitrqyyAZ36BQVNFOyX7t64CNl2AmRXfAlhX0GjSAUMXCTipqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKlGqegoRweF1++Jqh2S5594pr64Kj2EekHsAJSq3y8=;
 b=S1bgTBOxF+w7153eM4HeNssbO6JWlmpvryF/CVVacaq1BNDe9ld5uPasbQe05MPrY3w2DMeNnxUShrA8exjBKp9qtjY5BK8Hc0Fsvkae08Xx0uivRhIizu32pQICCDoLMa5aBglhvgUCEA0EnoiVYa0rQtrpoPO1IHIrswxKmKEfn4AXFA3AybKlO9PPTl3hg2APVsAqUZfmb9LmZzSrrCElgldcvBJABA9HaGVGONWkjg0UAkpiIXG+G4cgAGi8/wRPMSgR5x7gi5nKr/yqY6yUYD8aKJsd6yVYaFIaPno9tvcTEs3Dfl/8FT8EF9vkSTqczYYJq+t8jWQcjayEgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:52:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:52:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:51:00 -0400
Subject: [PATCH v17 10/15] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-10-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055468; l=8739;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GZxnLuC67KA9+f1ZFFupamn6BH671XQaImre37vE7/Q=;
 b=G1y6ZNLM9mWS55DqIMI5QiC45Wq4mZe5ca3M9jQw9S75HY429CPq+WwLzN/uU/mNDy0MRRbVx
 wqbn+o3LMwFBJTlbmKZIZ9zAR4a1hPlBUE70oQm4ZWbZOufxQXnG5/N
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
X-MS-Office365-Filtering-Correlation-Id: 4f1d7dfb-9567-43aa-6624-08dd760dad09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1NFMjh3eW9EazlDMVJkcVRBSzJmU1BsYS9MRGMvd0FzMmFYNFZHWWFWYUlN?=
 =?utf-8?B?K3FWdTV3RkNXdXFkYWxRZFR3U2NXU3Q1QTlyYWNHK3Zqb1RVV1BSY29VdFlt?=
 =?utf-8?B?d1dsYUJjaVJ4bmp3N21KTitJcjFaQmc2dGdLdlJqR09hWi9hTEFmcDIrYjhK?=
 =?utf-8?B?YnNIS1o5UHJrMmdUSjJFYmRISDQxSTZmZ1F5a2UvckhyTEsrOTMxTHdURGha?=
 =?utf-8?B?MVlweWRGbjRzcDlvTjMxZWJPbDM3b3paRit6UXRLUlpNaklwSFp5S0w0QWVE?=
 =?utf-8?B?ZkFmKzZIZVByeHpDVEZpN2kxTHFncVdMZjZRTGdNbXhmZnhpNXBYZFo1L2Q2?=
 =?utf-8?B?STlSNThWSmZGYnFUckUrUEtJUkh1dlJ3bTczSVFUdjVydS9TWHh6RGdmNVVC?=
 =?utf-8?B?SHpQVVlWZWxpWlZzNmtRMTFnRk16VE1wemdLbEZlVFVXUDhGUDZJQlJ2c2Fq?=
 =?utf-8?B?UldsV1dnVTJPeXRIQ2tEUXZxSkt2VWIvQ0IvbmJPbzZZb2w4MkNJNmZER0d0?=
 =?utf-8?B?NzFPb1E2TkJQVkxDK1R3bXNRbTVxT0I5eTFxZnlBQmlVQkk5TDVZSklvbGNp?=
 =?utf-8?B?TnZic0hvNUNwcUplaGJ3RElxVkk4bFFtR3p6WHRGWVExWDJJU0l1NTVKWVRJ?=
 =?utf-8?B?clRJUlZBY0VoY2V3MWpvT2orM0NMS0RGcmwxTHVZV2MxQUlMWUQvR25KL2gv?=
 =?utf-8?B?MmVMc1pWQVhUOW9CanZlNGsrdmdlWjJNWE1udlFjRjBaNmtNOVFXRTRpQVBZ?=
 =?utf-8?B?NUw3RkdoWkVxQi9rbGMxZVNKOFdTU01JUDkzRllXcS9wU0NMbjRqUi9LNzhR?=
 =?utf-8?B?UU5hUW90eWd3eTUrSytLZE9ITjVIVmR4NXVQc1BJeUFBWjI5NktKY2RheE9h?=
 =?utf-8?B?VnhtZjlVeXpFOWxZeFRmU1czdloyVHVBQVk2TzdpZEVocUhHaElXeTdFZE5r?=
 =?utf-8?B?cnJJdGtQUDFZUU16YWhWbTlQQXNZSUo5Y3FIRFREMmsxYVdJUk14YklaUXla?=
 =?utf-8?B?RHNwblUwQ0xVVVAzaVJwVzJFUHlRYnNWa2M4M1pWOVhnVk0xWWJFRDFLalVD?=
 =?utf-8?B?RVRMTjJKS2I4Q1pNUGszVDNVTGxxSTY4WGg1U0xaZkxwdkFudWZCcXRJZ3pS?=
 =?utf-8?B?SzkvanVGbTQ4NzlwYlhXaDJTRDhaNERIMlcyZ0FMOHlyK09vL2EzWXZzT0Rj?=
 =?utf-8?B?RktsZG1tWUxzRE12RVJKOHlGZ2FpRklwZk5wTDdueWZiOUV3VzJ3Nk90ZzlC?=
 =?utf-8?B?S2ErZ2FEci9xVFhxWklOS0xvbmcrQ1lleW5Sd0VGcXk0N2lYbXc3NU1KRVFs?=
 =?utf-8?B?NUhnMmMvQzVIcVpmeHBDNVBucVFwejZielVtVEtiY2pRMm0rYk9UY3MvQmZS?=
 =?utf-8?B?SVg0eWJCaFFvcGNXYzJRa2x4REZtY2pWQlFVcXZCVUppeENSaWFhWk5MZ0I2?=
 =?utf-8?B?V1JueG5idmZIaGhzd1phQzh6OW1vc29MWmZzTnlRZ1R3V2wrTE9JQTRHck8v?=
 =?utf-8?B?SXROZnFvR1J5Ny9iZkNrSFkzMURRN1lzY1VPU0F5c3hqbnluYVFOZW5QUWFo?=
 =?utf-8?B?WFhpeDl6akRmNzgxNXJIYzc5VWRoOFBYSTRZUTUxTG5PbDhpY3lVYjEvS1cx?=
 =?utf-8?B?Qmc2NE5tS240VjladGpTQUlvQzVGMzlpUW5TZUttSzFlOFVqQVRzMHhIaWps?=
 =?utf-8?B?UlFHSndyR1h3N1Z0RHhTdVBUSDlGdGpxdFpId1BORGtuM3U4cXoycjNXc1Rj?=
 =?utf-8?B?OGtFN0kvaXZTdUdNNkFWa0syc1VCZ0toenBaYU83ak5Yb2NDT3ZLcU1RbUhX?=
 =?utf-8?B?alpjK21veCtFTTRDYVh2UjgrbTZ6dDRVeEsrVEY3VjFZQktBa3ZQVmdmaHh2?=
 =?utf-8?B?Vy9WSjFYZzh1Wkc5cHhJV3ZTSGZpeEpxSjVoMG1FN2htK05XdFplK2I5OVd4?=
 =?utf-8?B?eVdCQTlYSUlGcDBINFdJUGRYNVlSUCtQL0xFWDMwaUJtUG9Wb0RWRjAzc05I?=
 =?utf-8?B?TFk2dDk5dUZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0dQdWNMWTJtc3VuK2F1TGk4UzlMcFRIN3VJVWQrQjd2citRZnNPbitNMVAw?=
 =?utf-8?B?Nkc5cHhKUTdDNHdUVjAreHpDdnVub0lIbndzVWdpNndOSVo4c0I0QW5UNExY?=
 =?utf-8?B?Qm9DWHRvVHB5YmY0cXFqRE5WbWF3YnNKQ3hZSlZ6aVl6V3R0aXJyMDhQTVZ2?=
 =?utf-8?B?aklVWFU2dzBmdi91SDdHdXoyUVFQTXRETzNYTDNubkM2TEljaWhMMFpaWXFx?=
 =?utf-8?B?OCtqZHZtMGlORTg0a1JpdW1TQWN6cjMxanhvYTU0SDJmQ1E1UkdmcUtpRmpo?=
 =?utf-8?B?Y2JrN3BMdWJjZU5pL2sxYjhaNTRCWFdZQzM4NHVibzFuTURYSCtIUkNrN0U2?=
 =?utf-8?B?eUs0elB3SkFFNjRXTGNTbjRJNGFoYXc1RE84U0NzWk9GZ2JXSHkyUTNBVytq?=
 =?utf-8?B?OHlnTlpZd0F5TktaZ0FCdTFZL09kSW15eTdSSFVtczY5bHl4VCt0czJHNlhB?=
 =?utf-8?B?T2dpVDdNSnN3WVdQV3ZQeU5GSnNySExtc0puR2RQeFBPeWsxVUp3dWNJSTRV?=
 =?utf-8?B?bzV3NUdpM0lERU8xdkw0Q1dscGkxYUlkNjl1aUhrb3VtTlBacklxSnFkaFF1?=
 =?utf-8?B?c0ozT2hsMm9lSnIzamRGT0twN25KL0h5SXVXMUUwWkQ3OFpwdnRuaGI1RFlq?=
 =?utf-8?B?aWhyVEI2Q1pzbFQ3c1prbnFicFFTREhWRFNuVnNSRDFvMzkvczU4QVRZL0RJ?=
 =?utf-8?B?b1owaXJMN3dTY2ZoZ2p3RDNnV1pMbGU3WDJBejFmUnYyTDEvamg4VlNpMXA4?=
 =?utf-8?B?Ymp3alBjamluYnNyZkxKT1lyRVVRdFFTbVhwTDlaQURFRkFoYzhkd1ZIK1Y3?=
 =?utf-8?B?U1VVamxFeDVhTmFQTWV3QmFNMWYvR1ZXV1ZGWS9XWHovWnVNOG5GSUNoUGd5?=
 =?utf-8?B?b3NuYVlLZDhQcGRsYlNYYnlMSXBRUkN0Z3lvVk85c0NjeC9IQzNjZWQ3R1dV?=
 =?utf-8?B?V1JCeUxEazlNYzRTb3ZlcERaKzdLNkZLYTF6NHFSNTV3dUt5Qmx5UitCV2VY?=
 =?utf-8?B?VEQwUjhSSkExVmsxRmlvRHZteWdvdTc2SHRmVGtEUEZybEdTbUlPYnBWU0xw?=
 =?utf-8?B?S2sxR1pnS29mTjI2RjROT05WTW9qendpdTF2Zk41QTNmbUJhN3Z6Z3BlelhM?=
 =?utf-8?B?V0ZXOHJDbFplaTg1bjFyRGVIaWdKNGF2Y1BWTlgxRVBFenBMTUx3Tjk5TCtQ?=
 =?utf-8?B?cWhTQmFpTHdBL0pVZUd2dTRFMWtzcmN5U0lkZFFjTFVDSnBEcjhjYkYzOEJy?=
 =?utf-8?B?SDBPM1BhV2w1eXJTWDdmOG9ReWJnK0F3T2ZjcVJ0cDI1UEpuS2RDU1Bad3Ri?=
 =?utf-8?B?T295L0VtZlA3SllaSVNKanZSdTlqa2p3c2sxdzJkL2I2L0ZXeGdjcDVzY0RM?=
 =?utf-8?B?NFdjN2gvRXBPaE1DRGlkTU9IZUIxWXByQlFMMXlUczI2NkV1NkpERUhVOGFS?=
 =?utf-8?B?N2RPM0RsU0F4b0UyRllDcDAvcjM3R1ZUWEVmNjR5bXAxeXY2WmJiQk1oNWF4?=
 =?utf-8?B?dHZrTWZuMllMYnpOVDE2Z2l6VlVITW43VVIyTFZCeGgvM3NZUTA3MDhlazdz?=
 =?utf-8?B?L0N5eWR5dktuYkhIcTlCZDRzWWR1UkpHZDJZLzRiOVFKdGEyUXBUK1krN3pM?=
 =?utf-8?B?dzNPb0ZBZzNUb0t3eUJuajFVWTlIYmN6OE9UK1JsYVJFWXdsd1NXSHYyNmk5?=
 =?utf-8?B?WmVGalBmejJoQmZSYjlCSzM5eW5oZWdRcHp1VWZzbCthRDU4VTd4Q01rR0ZF?=
 =?utf-8?B?U0FlV1c2MnZ2dEVxN3VWWGRXdjJ3d2FhTDVWMHNZbGpjS0VoOGFkaHZtdG5W?=
 =?utf-8?B?ejZuc2N1WTZjSXYzT0dOWkhFMjJpQkpvdWRUUXFPUm1HcEtjc0hGb2lyRjYx?=
 =?utf-8?B?ZHBXTW1IRXJQRmRWZWdKbGZRVEMvMUxLTSt4aWlVYzZIaWFONm5YRHROOWE2?=
 =?utf-8?B?N2czMnovVWZjQTRmZFdabFpqeWVOL3ZEMEQyNDVOUmM3OUNhRG1mUW95MW1r?=
 =?utf-8?B?Z1d1S1lOSVBIZSs2eGxsOEVqekZwYllZNXQwZElwcWx3cDg5WjNiem43bTU3?=
 =?utf-8?B?Q3VBWFEvYW9MOEtjTUVsS1ZoMVFCOG4xZzJPcFMzQXdmdm9HczVLZHozQ1kv?=
 =?utf-8?Q?mug6878JOqz/h9D5wwsW7V9Ci?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1d7dfb-9567-43aa-6624-08dd760dad09
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:52:06.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sUCmRmC5nqxDFt7FQrPOzJuHzVVdSOnxwqT/7qaoUKQJLeh+0Xdx4lAWdhDTKo9U6UsPP1bA77gqSg+5IQ7Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v15 to v16
- use le32 for doorbell_* register and use cpu_to_le32() and le32_to_cpu()
when use it.

change from v14 to v15
- none

Change from v9 to v14
- update commit message by use pci_endpoint_test -f pcie_ep_doorbell

Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 142 ++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 50eb4106369f4..b9cb1ab218f2b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -66,6 +75,7 @@ struct pci_epf_test {
 	bool			dma_supported;
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
+	struct pci_epf_bar	db_bar;
 };
 
 struct pci_epf_test_reg {
@@ -80,6 +90,9 @@ struct pci_epf_test_reg {
 	__le32 irq_number;
 	__le32 flags;
 	__le32 caps;
+	__le32 doorbell_bar;
+	__le32 doorbell_offset;
+	__le32 doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -667,6 +680,126 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	u32 status = le32_to_cpu(reg->status);
+
+	status |= STATUS_DOORBELL_SUCCESS;
+	reg->status = cpu_to_le32(status);
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	if (le32_to_cpu(reg->doorbell_bar) > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = cpu_to_le32(NO_BAR);
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		goto set_status;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		goto set_status;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		goto set_status;
+	}
+
+	reg->doorbell_data = cpu_to_le32(msg->data);
+	reg->doorbell_bar = cpu_to_le32(bar);
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &epf_test->db_bar.phys_addr, &offset);
+
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		goto set_status;
+	}
+
+	reg->doorbell_offset = cpu_to_le32(offset);
+
+	epf_test->db_bar.barno = bar;
+	epf_test->db_bar.size = epf->bar[bar].size;
+	epf_test->db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+
+set_status:
+	reg->status = cpu_to_le32(status);
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = le32_to_cpu(reg->doorbell_bar);
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		status |= STATUS_DOORBELL_DISABLE_FAIL;
+		goto set_status;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+
+set_status:
+	reg->status = cpu_to_le32(status);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -714,6 +847,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -987,6 +1128,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


