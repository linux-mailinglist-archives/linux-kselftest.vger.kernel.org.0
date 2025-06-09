Return-Path: <linux-kselftest+bounces-34504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDE5AD2422
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B89416F0F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954CA21FF2A;
	Mon,  9 Jun 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fmpqA4aY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C121FF28;
	Mon,  9 Jun 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486915; cv=fail; b=eiveNlxEcRAAjvggwsvLQwmDenMjIgOuvATmsD6Fa8pNCG38xl1ZxE1olmuMu8SlJ30ql6kSHh5QxVOEM+3cw/aeqaccT+La38svLFjy01F1zwiS4XRbbaBUwZXZXYqrN0qPzPkokuSypWxvPo0bHOw6D/oyUBIFawin6EMi/qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486915; c=relaxed/simple;
	bh=+SgZEl+0x0mkZbAhvLt5Evhno7zgilVYjrIje6KjXVc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lJ5svssJHXUV5amwuiyRZoqB/8Z71IwoPu4M8Mzex/phZkUtqrx2hBvtq3+8MDlaJG2aVLJR+okTTdUIoFPge2uu35j3bgloaMcGqoGgJAcUVlNhQhVRSos5E5VFifXML1BMh9vysJ0ZAExSLq4KC15Tg0yOVbEtaf6jFnKmV3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fmpqA4aY; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzWf0q3FW4kzv2eOAdratNJv2rZ8AWT+i0VZoLQ2UrfIKIXhV7XJBwKtJwle9WNfRDEUFRvJu/oUWmE+MVyhkfzk5uGCMF7+wWniu9amEBjwbMNmSf1Cz6Pz34mfHn6MopTJm98+P9QsJpuBE5b0YTqs87EU0IYUhu6UxCA016RxI8LHLvpwYLZMWjvJecxFgygbFLW10B/MXdY2UbCMrE/PVnEHK8YN+FD+RyWpvrJKuMBrRCzamlvfY7AcMdIXcltfcsSQiwzdLkT0g8/zxUtGAOGpEEzZ2ccqPs7M+WjS8/9sRCm7BYMWP3l16Up6sjW8bA97You4nCMnnqIv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO0i/b34tXG//kvU4HGnKVOSOCmwct33MArJWNqY/sY=;
 b=v6EBa0rIVgu8zUFzGgBtlraCqG7mA79N8Ou9Y9XzfJpY2OxU2u9KA4r1Ia+r4qbE16bwqVqOHW+EkUjqqaJScuTBM5kM6+LBHIlBkQMfT9v9N81fm1oX7JiH72OpZhz7fZMSbcTsPeQVgfrIec5M6FHEIJA2uUhuSYeFhp2Z6oB8PI5/dM84GaJaHdERv+WuwttBH0ZoUROqKh637IM6tZ/pcuV4YXnWO4IHid2xsVpnFtLdz+Rnho9H0ZiK8DP90abFkrt/i+n/OeNNYLAptJoIS4rTGI5AOqImSVj7tN9iW6e0uo1jx2nFOYJRg/N18zMSCKHG7nojqFome8gChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO0i/b34tXG//kvU4HGnKVOSOCmwct33MArJWNqY/sY=;
 b=fmpqA4aYSdi+kQH/nX1qHbhHBdhctdxtS3YsJZWZHjOGgs7Sow6+Twycjq4tUblS1X6ZdPgpiDTTv6DyeKFMk4isjb3dU5m924XPkNxCz3jmexfzV+XyJBWLdfVuszDJnBM/pZtBZNALbpxEs8AECeRD1gKyZabgu06JEaFK4FYViSGwvXfqjoZutCpHwuTpBuc9RVaou0gpjS5ULe7XBiQU6/kCiwg3GJ4nz9grUU+V+KFWQpjQuUxYBYjVPTdIdDqakj8BFjEZyoGMklgYGLVLwpMxT3IWLfDaC0wuYCwXfjUFDCbIkOt7OzyXEgNMixatfEohrvSCErUF981dsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 16:35:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:35:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:19 -0400
Subject: [PATCH v19 07/10] selftests: pci_endpoint: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-7-77362eaa48fa@nxp.com>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
In-Reply-To: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=1300;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+SgZEl+0x0mkZbAhvLt5Evhno7zgilVYjrIje6KjXVc=;
 b=svZGkixayD4MrwVtGvpOEp4c1DiMKR+Tk907IpbIVngGjigCE+A6pTh5xVYngOizGT/75L0CC
 R/x+rytx97OBhI74dphKTW2migkAbpYPNqtuckqWWeIh9NSYZRhEl7J
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AS4P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 71febb08-9e28-4acc-d42e-08dda77398a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzZHSUROcTRSc0Z1UU1JRXlpZzFFYlJTK1dubllFenZCbGFjTnRsTHpmYnFI?=
 =?utf-8?B?ZWVnRm5LT0RJUkdMUkZ0NDhaMXRFdTZBS0ljY0xYVmd0Zkd3MUVYcFNFUEVp?=
 =?utf-8?B?TWdSZUhINjU5MlB0NEczQnllMjNXTERxWHZBNXFvZlRsdG1wNmJUT3UydzFv?=
 =?utf-8?B?R0xpTm9xa0dsVGI5QngxVy9sS1c3bFFzWjdESjNOZjltVDJZa0VrSXY4SU1F?=
 =?utf-8?B?clhVMmRxcGgySlByVlpVWXhWZ2txc3RzUlhRMU15VC9TN1dQUTFBK3pINisr?=
 =?utf-8?B?a3dSSC9BYWNJVzE2c2xNRFhRVUNLbnk2djBEQVROWTluMWRCL216VXA3SVFB?=
 =?utf-8?B?ZnlYWVNjaUE0Um9TSzc3ZkNEaE1Yck5wWWpkaVNYZWJoOVZRd0dKY2dDN0cy?=
 =?utf-8?B?aFJrdEpQNGVuM1NpQTJjeFFHUHB3V3pOL1ZkbkRlby9qVVNIeHhvQ0xJR1Ur?=
 =?utf-8?B?MFBoQVZLdDgyYUt2T0dDL1BYSVRGd1U3V0gwQWdGYWxBN2NLdWlvOUlUMVFI?=
 =?utf-8?B?T0dRZU5SQjBpYmIzOUduMUg0YXkxeXZVeFd3Ukw4WW9PWmtHeHF3RFNSMlhT?=
 =?utf-8?B?c28waVBYM2hzdFNTeG10b1pJSzlFR1dQSGxmU21uZHlLN2tUeWZRdFMvTVdK?=
 =?utf-8?B?ZzNubVBKamhROG1OQ2NYOGY1RVNlbVFlU2d2S0ZFcUVicnlUNlhqWHVPSE5a?=
 =?utf-8?B?N09ESkY2Q1J5emQ0eGJVVkhUVmVxVExwMFRRYWtrWnlKSTZXUlU5N2VwSjR4?=
 =?utf-8?B?b0xiTU9UV0REN1FjcXhhUm00RHBtajRQSVdLQVE0d29ub2ova3k1RTBRUTB2?=
 =?utf-8?B?QkZGQ1poSjFwVG5ic2EwdkpOdFNiZUZKSzVEQUs0VVBKM2JCQkZjYjhzQ1p5?=
 =?utf-8?B?ODkzQWhBcHZoYXczMjQwSFl4VndhQzQwSWNhb3FqWUc1ejFTLzVYYmxwOEtG?=
 =?utf-8?B?d3IzR1diZDI5OUlQUDJVOWJkOEljYzVxeGZQcitoY25Qb29hcjEzMHB3eTVF?=
 =?utf-8?B?Q3ZIZ2NlWVVaR1ZpblVRa0hvS2NrR3NqSUNoSVhSYTZXUUh2YjAxS3pwaFQ5?=
 =?utf-8?B?TlMzL0FScFNzY3ZWaXl5NFUwcFptdktmRkNhS0tyTGExKzlnWXJiblFTNk9y?=
 =?utf-8?B?SlhjS2FMYVM4NnoxendlaG9lUWRNai83VkdXUjJvelV0TTkyZmxqd2NZaHp4?=
 =?utf-8?B?M0M5QnNQemJLWDE1dkkzS0oxWjBqc1kreHZJUU53U2N5MnZsVHhLZDZZZDFz?=
 =?utf-8?B?dU9TVncyWElSSTlDL2JCY256bG1jQXZlK2cvWkwzMHV4NDZSaUxTNk5sU1c0?=
 =?utf-8?B?V3Zlb3JZU2lBb1ltTEFMZkRMbUR3WkpzTHM4dVZ3eFV6R3pGV0NhTjVydnNO?=
 =?utf-8?B?ODBWaHFGM0UrQlNkNG9YTXpJMVpFeEM4KzFYejZxd0ErYlRJc0IvcytvM25M?=
 =?utf-8?B?U2VUUmg5WWZZelRrdFVIaFpaZThPc3ZvL2tveTVjamxNVGY1VlEzWHpXMHQ5?=
 =?utf-8?B?ZUJvSjNXOWIvdlZRUVg5N2NLTjF1Ry8yZ0FlTHhRTFdZNXFkMmcraEZWdTVy?=
 =?utf-8?B?eU9GOVE5Slh0TXhZbmJrekgrbGhualQ5b0V0L05UUEdKOEt6OEFxN3FyRmJp?=
 =?utf-8?B?aVhpZUkzRWsxeFd1ZW5qS3dMZzNiQm1ZazJjSmYrOHVYOTMra05Sd3pwRDdK?=
 =?utf-8?B?SGlDRDVBOXJwekJSUVpmbGRPT1JBMDFvUFV0MDhKT3VBTXhBL0d6KzdTY2xk?=
 =?utf-8?B?MjZiVDBlRHgrOFUreWx4a0U3WFNwZkpHVEZiNTdWMjBwNzk2NlRSOU8xcDd2?=
 =?utf-8?B?d1Uvajg1WFNQalpZNGpBVlhSZUdqSHpOTzdCbjhMS3c2cVpic0ErcXZvWktj?=
 =?utf-8?B?NGt6WjBlTWVLMTdJVGpWRTkrU1ZUMnMzbkZlV3piaWxYcE5zYVFWZ2VsRjBD?=
 =?utf-8?B?VU1xT0s5cUdlRlZQN0RkK0NwTnZjNGNWOXNEaklBUGJCbmhEdk40d1Q5Q3Ux?=
 =?utf-8?Q?PGS0tU/aier5xoF9WcEraIH8uOrnmQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZENCbklPYThUWGhEVE9CamZyOHZ3TXdZU0Ftcnp6bE5tVjQvZlF6V0dxTlJH?=
 =?utf-8?B?UlBodFdvcmdxYmhHSlNaTDFubndydmxoR0Zack0yMzFSdkxqQlFrd0NCREVl?=
 =?utf-8?B?VVYyT1NJUjNlWStVNFA1dHV1ZmlsUzd6bFViclVhODlsTFNaNjh2RFpDWE1i?=
 =?utf-8?B?ODBzR2JMZUM3M0FUVGJTS1dINmNKTTRjT0dFYW5uZTlFNnhBMlNRVEZvRXlG?=
 =?utf-8?B?c2NZcCtjamxHTklLRCtRV2NFVWFobG1DM3U2ckxlTmZyeUN5ZVVFTUN4eWs3?=
 =?utf-8?B?UWlZbUV1VTkvRzVJY3FiM1ZPeWE1RlNiTWNQa0hrdDVoT25lQVVBNnZ4KzZl?=
 =?utf-8?B?U1BjRkd2U3BwZjFPS2c4Sm9HckNiYmVHYWREdXlrdkZDdWw0bmJyMkJLTndS?=
 =?utf-8?B?TXp1emFyZjkwRFJOSHFweXlzcy9ublZEUkMxODhYZERuSWhPNWpXckwyVGsz?=
 =?utf-8?B?TXZxL2YwNTUyL1BKd3JFd01XOFYzVGxoYXRXTU15MDRwSm4wWERndHJUWmg4?=
 =?utf-8?B?V3FodU1IV0R2NEFyMHZSQTA0YmxzUFZFTVpVN0trOEs5TXVwNmNwSklxRWVu?=
 =?utf-8?B?UEZmTEZBWk40YjU4bVkwdzE0WVFuTVFIVDdpVjJ4NXVpNE9zZk1TT2ZheU4y?=
 =?utf-8?B?eGVUUVBWZ1FUanI4clVJcENOZFZva2Fqbnh0RVJudUEzN0hNdjBKcS9VV1Ur?=
 =?utf-8?B?VXFFWGVLTHFBbXUwVDVzdVRRUFIvcmhIS2t4U0srYUJqRlkxcDVSV0YrazhB?=
 =?utf-8?B?alRJSEZWQlZjK2NIVEhyUU5aWlNNSXpTTnYyZ0paVnJvWFJqS0lRSmtjdjJl?=
 =?utf-8?B?b2MxMVIrd0xhOTBQZXpKdEhZUkJrNU9xZjJSeGgzTlZCdUxMd2VVbzIrS2VC?=
 =?utf-8?B?RVU0OXZ3OXluMHdXbzVoWUljcjhoUWhVUnFYL0JPK2oxWXkyeG9qTTZyWnNU?=
 =?utf-8?B?aHIzZXEwZlhlOWVENDl0N2NGT1JjWW51cE94Y0VtZmNGOTIvOEp2Rkxlempt?=
 =?utf-8?B?S1Jxa2s3TG9JN2EwRVRGbjNkaFZldlI4bGphRXlMMWdVMjBaL0JpdG52OFI3?=
 =?utf-8?B?ZlZ5eDl1TCt2YmdPNDBJeDl2QmJXMkdtRUwwUW0zQURtNkVyRnMyQjdVU2Iz?=
 =?utf-8?B?Z0dFSm53eDB1c0ZxWnBWWXRRYjlhejJFUDBjditmN1M5clhSRmdLcC80dGxk?=
 =?utf-8?B?ejFZbklpT05kSDRDSlk5UEhYSTh1czN5V3ljNTByOHUzMXlxdXJpZEQyVkRU?=
 =?utf-8?B?Q05OUGFsdVRzUFJSdEVrUUpFaVRxR2NIaFk5bEVkbTVpRTJRMnRQMzJBSTU2?=
 =?utf-8?B?UnYxYXk1WTVDTGtZVE5iQUdsWjUxWDgxS3NsYXNUMmFFckFsbjJMTWRkNzNZ?=
 =?utf-8?B?d2QyVWxBbFkrUTU2RHFVMkV6c2toMEhKZ1h5TndSOHBWSUhseXR6ZDAzbDlz?=
 =?utf-8?B?OVNGOUdZaU9NMVJMTTIwdGx1MVh1VVJreHBWaldUQmpSV3hSZ2ZvNitQTksy?=
 =?utf-8?B?dGVNRWpTS2xRMWdjbGl0QjZNWTRkdHJjYUxGemxLaGdPYmYvRDkzOUhDMFk3?=
 =?utf-8?B?amZVQnRLeU1jWHR4eFhUVjFEYTAvTTEzeEx0bmc4N3V3eG5aaUNUcUV3Ympt?=
 =?utf-8?B?MmJlOUVKRzRhQUxkNHN0dTJqRkdQakhJTjc5L29hSWRjNUdmT01ZdjZmU3hE?=
 =?utf-8?B?UHA0MXJEZ3hBK3NLMWJHNnozOEswLytYaWJaZlhRYTFTaTlLbmtxN1NsTmtS?=
 =?utf-8?B?c3l2SURpSWhSSUQyNjdJaTBTR0VJZGJSSjVIcHhLdEc3eVo4VEV3ZEU4ZHVn?=
 =?utf-8?B?RjRWc2dsazZBQ3lFdjdldFpOeXFpUGNiNTBNNGJVeHp6N1ByazI4UW5odisv?=
 =?utf-8?B?WmxUM29uMzh3UzV5VlgvL05oczk3bHRoRzVlMm44clRRdlBQUHo0NlJBeExM?=
 =?utf-8?B?S3NHNysrQ2R2dTZXRUZibTgzUTNGdDZETVpXZ1F4S0NBblNpYStZN3djRHpC?=
 =?utf-8?B?RTlnM2k0Vk9tU3NVcnUvaE5jSnE2Sk1uQ3pvY2dieXN4QTFxeWFJUlpESjlm?=
 =?utf-8?B?RkxycytVODFoZG0rbEN4OUdRVFErQmNlY2UwU2IvRzk5M1kyS284UHFHdUx4?=
 =?utf-8?Q?ih4i/qGmMQ+XP3MoaEcIJuUHT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71febb08-9e28-4acc-d42e-08dda77398a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:35:08.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ky6cFvuCmAZhB78DbanN9Q0cvDBKLd9xWmDk/uSkGOdVXPWc8WyPLQW4/RzRj6nhmtbt42og9b8Z9F7eYWKbCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

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


