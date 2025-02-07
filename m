Return-Path: <linux-kselftest+bounces-26031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942CDA2CCB5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3EE3ABDD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F31917D8;
	Fri,  7 Feb 2025 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XZQliQKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F86187872;
	Fri,  7 Feb 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957217; cv=fail; b=PVtwvKgaQ3+xXAz2zKwk448HRawPJIx0xfjpiw6XWmVY9DKzAJg811RR6876GxqW7qMgfBZdnPLCQmv11xK9iXHv+0u6pMTuCTJ8q64xXGx/wZW1Rk91RBP7hDylEYSPxFoBedtuNv3YTh4ebc+ecOCnOw8xvKvvOWnlkbwaRV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957217; c=relaxed/simple;
	bh=+oxXXUJIJNBgPkCnbKE0lvq0c0/lh3WWynbE4q2NmCM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=jyjBux55pv2iX9+McL9aQh9lggqmTIkKBURvcJcq4gHi8vnvdMSoHMrYuHvkqashPU80m3nCbXaVeFadqPGqgjj+ls+sxuR6hCM0SFH2c5YCZxxdcU+rhck5pbIuAyP7HbmsS5SzU2at3JnQVrXn+5KfAqHK0PVFGAmo2cWGvJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XZQliQKr; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xU8LVMANY0QOI68dH8MxsLWKouO6g/H8r1QqCmUVaifunbmHmEh9xXbJNeMG5UP7Rn+GZjT4pvMIHuBJDxTbhPVOztjU8XoYRFcOLZ5ThIOWiW2kZhrC4F3ZTxSGBJgWxiMNfuDkV4B9dCJ/GQZ4ql2+Fi4Y88+jiEWUtbKFhIG7tU16iSG56Qnpot5BcAVOatgKkhHxCQG9BJ2aBw9xfTnrLbqbIdmpmtLRc90P8O5RoInq6A3luR+a61VMfSHkgF5/0xyX4bT5dclkvBAooUEqWkJwXKK1Gf64az7Mofz+KoNKvnxPDEEja0j4XOqtvBKxv7tv5m/99SsxBVLPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiFaYVYQRnRv0nQVTAjUhbDNbOp/ElHchUF1907w52g=;
 b=s0nkmS/mF8SVXYpnUi0KAZC1h379k3LwXGwjgiS3DtfOa99iX+BtGwTxLycH66XU7EKMcZJSXsuH6r5p/duTHjKVZkyLrrG4KzHI4D190BxA4gwPbmuiB9m48aRTv4tLqevqfFRGAnFBczrsoaLQgJnMSh1zr6rlfFdS7kOaU2wPMXjw/NLDLINosAKemtfxlu7VCMYD4K6tfI7AntRc3s0KKMbNPXyZt+d3y7f6TDtkjceGo0R6WkqqAY8hnrQUX3YReeoE6/Q4rncNk6dvzW7ANJv4kJGDikwQBRGhNaQFjV6uuBsQMyy0eUIvXT48ZHI+4JjyUHu0UlDFDzl50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiFaYVYQRnRv0nQVTAjUhbDNbOp/ElHchUF1907w52g=;
 b=XZQliQKrx6jBZQmKY0FK44lrNeua2S8NNajVKgW4+ai19pzAniQqb7AAIgOYbZl3oasWTDysqN26M4V2WS+Yc13nni8LEBKTIMZ3kIlGLWlpDOk2gCBRSHMtkcU3xAqUMJ+z2kb9JoBAlG+eWVDdlBYKTaW7a4URUTQfMwHFB9qTe0zveRB3zjDi6dpVS+oh4QAQVDTrpakmo2SGxgm4ml5OBwxbtZJ5Cd1YspX/XC1FI7dgeNVhkuMjcA1ORq9hl6zjXshCNkNLYILWV8URL7hDzksFRHaS7azKJlsbz6J/S3/7BVx/ANbZLZ+GgfqysdK8q8MnzC7/Jfb3Nr2fCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:40:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:40:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v14 00/15] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Fri, 07 Feb 2025 14:39:42 -0500
Message-Id: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH5hpmcC/13SSW7DMAwF0KsEWleFSGrsqvcoutDYeJEBdmGkC
 HL3ygFiyV6K0PugSN3ZlMchT+zjcGdjnodpuJzrAeTbgcWjP/9kPqRaYChQggDB85WfpoHbIKM
 PRAFCZvXydcxluD2Tvr7r+ThMv5fx7xk801J9RahXxExc8JhTtM6DjuA/z7fre7yc2BIwyw4Rr
 EhWZMAkj8m5gHaLVEMg7IpURR6kUxBFEsJske4Q4Ip0RVIVZxAzRdy1Z3okV2QqStJH430JCeM
 W2R7pFdmKdIGibSkJQtgi1xAKWpFb3qRFCpEKqJS2CESvWn91g4JbE8nYKpPeM+iZawyWsUuSx
 VtyJuwZdgzasuo0BSdKUhEWr1DsGPWsrQuWn6GlzggOU0TZ2OPx+AfMHd+wtQIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=10660;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+oxXXUJIJNBgPkCnbKE0lvq0c0/lh3WWynbE4q2NmCM=;
 b=iyDP5w4txkRdjPaGBUIaEUk+gyvXluNTMjb5DuxtLPToS0vMcvwdlDHVPiKqxpGs3jyKuVnzh
 e75Eow+LwnLAjVoTUo4TbxTfsTNyEbEVNs6K8os8lTwnlsN/JD/7Aa1
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
X-MS-Office365-Filtering-Correlation-Id: 6bfcdc2c-8bf5-426a-5dd7-08dd47af3be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MElCalZiVHBQbng4NTIwRWwrOHRSK2ZDTUxkZUpCdHY5dXRsbDk5Y2dwcXps?=
 =?utf-8?B?VStBcDRkbFpzLzRxYnVNR0w0OTA5MXE5aUZnUVY1K1ozN1U2dlJyd21LV21U?=
 =?utf-8?B?dTFXN2g1YmdFUEdJeTF2RldpTU5GRlVUQ2N3b2tOaE4rWmQrNjB2QTlVS0tv?=
 =?utf-8?B?WUtOSmx2NXBtRDF1SmZWYTRDUFhTNDVDSCtqOXdaeEJxOWVXeU0zazRINmZ1?=
 =?utf-8?B?NVVtWVVOK3luY1NhZldhajJjV3J1cHl6eUd1QzhONGpQbnNFUUUwUmNMaUFB?=
 =?utf-8?B?b1ozeTVoY2VkQ1dTZ1Yzc3c4NXdhZ05STkE2OHp1ZmhIL29NR2FrL25lck5U?=
 =?utf-8?B?TmMxRU12MU5VV0k0ZWp5Mjh6dlhscW00OU5FajRZaHpJYTVSYVVkanNzSnF4?=
 =?utf-8?B?OVlDSWd3VGZPRmZmUXBlYUpCVXExNWkwVXkvbURXVXByTVc1cUd2MzhFSHJk?=
 =?utf-8?B?bnU2d0U0Wk9USG5rYUNiRXRRcEhRQmlOSk5OVzVkSkdsRFhwbFNFVmp6cy9t?=
 =?utf-8?B?S1ZVVkdVZ3BCbStGTUttZnZiajY4MVZTT1JKSU5jZFhYMHFkL3RkaDZLOFhn?=
 =?utf-8?B?MmM4UjFHQmlKUCthMlVjVjdJL0ZUUFpIQVNnbnJDTzVRcWYxNEEwZEJkWXo0?=
 =?utf-8?B?Zm5TREdKMWVEZUZSOGFqZC9hSDAxVlVKKzlNV0ZuWDlhY1Y0aERFT3pFRC95?=
 =?utf-8?B?bWg3MzdpZ2xzU1JBS0xOZXZwZEQ2dGwzNU9oZkd4NURRcjNURytiM2IxVkNP?=
 =?utf-8?B?ZzNRSGJtYzlJalV3K2hhM1NPdWlteWd3eExWV1I5Y3pFaGxvMC93RTdGZytm?=
 =?utf-8?B?YVV0ZzJhRHhmNDlRWGw0SWlwUUhDRW1PNUFKVUNZdTZnS0tFeC80eE5XUkcx?=
 =?utf-8?B?TjZqNk1mM2Jla2g5M0JYeVJRdEFXZlpxVk92d2p3N283Wk43R2tqSUxGdkY4?=
 =?utf-8?B?WnNZL2NzTkhxRU41UmhJZHJMemszeCtSWksvWU44UUlLVHFWUnZVT0prT2VU?=
 =?utf-8?B?OW11V1BsQXRQcGEyRnRMam1zaWZwcE5nOEFsNSttZjcwNG5VQTFCL0VMN0Zo?=
 =?utf-8?B?YlZESFhlWEdDTXpUaGc5UUpaUlRmQm1sOVBvaWVjRGFzV0w2S1FzSVlVSTRs?=
 =?utf-8?B?Y1c1dWN1KzZ5QklCelBjdnU3bVVNcGQ4Q0Yvbkl1V2xZanpkOFJ1RlVTQ29M?=
 =?utf-8?B?UHRndTZobmpmdVdGdW0zWUx1THNXS1ZSVnlsbkplWWoxWHJCbnhkY0lVUm9q?=
 =?utf-8?B?NkVoNjk4dWJQYis1TjRTdEFyLzJoNHVyZ1cxVURqakt4c2pNcWNBdmhVcGpo?=
 =?utf-8?B?ZmtOcDRhbkMzeGgxbHlDS1V3N3ltQlh0V0R3ZkFEcHR5ekd6eGxiaU1aS3h0?=
 =?utf-8?B?UDZaSHR2WHNVcDRQWHNCUGZTaFJUd3A0MS9xWTJ4dm81aVRoUWl6eUtQTFh4?=
 =?utf-8?B?eUt2aGdUQTYweE9xNUxpRWFWMnBKa3pBWG9KckI0LzhQTVhOcHNIdG9HdHU4?=
 =?utf-8?B?S3d3VkxUVDhpcjhBajZEZWpHWnIrMERhV2RRV3NYZHZGTVp4eWxNbkUySWgz?=
 =?utf-8?B?dW1NdVBLRmhWckxtNHVaUDJDRU11Sy9UM3Jadks3d2FOZ1hvWmxDU1F2OVdY?=
 =?utf-8?B?YzdyRy9nTGJRMkROYURjREd0UjVUNkZNT0NWUDdEbE51T0xHVlozUWRVZndB?=
 =?utf-8?B?MnppcVdmUE1BcDY5clU3dERlRWRnRm0zZ0ZiOVVWelMzM3BmY1hpTzQ5eEQy?=
 =?utf-8?B?OUc0S2RTR3hGTEE3SWpCaFQyZmpBSmo3aVE0V2hCMjBMMTF5elUwaDRWQnNH?=
 =?utf-8?B?dzNjeWRIam0wV0Y4NE43MGduSVpia2c3Rk42Njhpd2dpRklQMXZTMGZsV0R5?=
 =?utf-8?B?Y2ZSaFZ4MjQzbzJzRGQwRUc1cVF5ZVpFeFFiaUtjOTVESCtzaTJaK3pPR1g5?=
 =?utf-8?B?WHVtLzN1YnJHSGN3ZlNWT0pxOWxKWlB2bWFhR1Blc0tCbEpNZk14UE9VUkky?=
 =?utf-8?B?V0ovQTlWVXVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2dQR1BvMG5VVm1IYUpjN1djMyt6S3BzdzJLc0w5cmdpakRQeUNKeFBzRkRa?=
 =?utf-8?B?NVVOUngwRmh1ZERCOENFaEtUclM1MWp4SXI3UzRZRWoxTnRHZjdyQTRSai9n?=
 =?utf-8?B?WG9hNStJVFU5KzJJODlBREVrZWI1Q2RSamlKeXhCaVhjcG9IOWZJVlhQRnln?=
 =?utf-8?B?eW9SNUdiWC9ESjVKOUpQWHFkOWtkQU1abEp2b203VDN1THNyS1J3YStqRXFx?=
 =?utf-8?B?NFlRcklWdjF2QVZzb2lveGlZZlBqMEJYSEZqQ2FkMG1rbmF5QTh2MDVaWTk1?=
 =?utf-8?B?OFVYZmVZUTFhYkJ0ZDJWVVZIRG82OUxycmUyZXo5Smo1TlJDcHpkL3BDZDMz?=
 =?utf-8?B?ajJmVkExL01wMXp0bEtSYWVIWjA1ZnZUNDBDQzhrejVhK0hvZUZXN2VsWHpG?=
 =?utf-8?B?d3JORnJIMGdteUdiNTZ1OHRtZkVvT1FhQ1M2SVkxM2lyV28wbmtJVVpxNXlN?=
 =?utf-8?B?R2lrOHdoM21tSTU5cWFyT012K2grK0w5VVByTk5WN2JvdEZGbC9UOEtkNng2?=
 =?utf-8?B?VnNPM2ZpRU9wMXV2UjVZUHNlUUlZYll4aWZVSk5VZmlFaEpUM0lIRi9JRHBh?=
 =?utf-8?B?MmdYTFpQWEhTZ2ZVaVhieG1XdXUvcGJQZmthZVpnVE9MMFpTY1p0cTJEUFdy?=
 =?utf-8?B?RDdGMzNJWFhGTUgzUzdFM0tCcnRENE1Qbk9IZnZoVnJUWGV4UXIrQ2NDWDlS?=
 =?utf-8?B?bU5obkJzcXZNVDM5czRlM2MvYzNGMVBjTjR1dWVKWVlSSHVOWmxJMGEyU3Jj?=
 =?utf-8?B?NzhEakoxdy9GVzZIam9XT0tWNEFQaGVsWkdJZ2NIMlJ3eUtheWxKWlFwQlMy?=
 =?utf-8?B?SGtxUERma2VEZHlFNUFQaWphQjNaVnA2VVN6WC9uOHc4bVRFb1dkcTN0WlRt?=
 =?utf-8?B?eTdXcWpZWk1McEFWYnFZM3VqcThzajBic2RST2M4ZUtYZm1mMCtXR3czS3Vx?=
 =?utf-8?B?Zk9MdDU3TzQ1Mkg2UUdSa3h0bTQ1c1JjWHMvTzl6YVJwaCsyZUIzNi9zY3pW?=
 =?utf-8?B?N01pcmNKZitwNnhDenpSbHNndVJiZHdzV0pNMFcwY0dGdmUrak9VWVNVUlZj?=
 =?utf-8?B?dGswUWJDSEVXUVBya1lrTDh1U3BlRVF6cHZNNmJEV3FvWS94a1Z4OXdyMlNT?=
 =?utf-8?B?Si81dTBzZWRaUW5FN2VzL3JaNXRDL2wrc2N2SWlUNVFzR0VnNjdCWCt3Snpu?=
 =?utf-8?B?NmoySUQ3cm56dkZuLzNVSzdqdDh3cFZHWnp0UWpjNXAzSTUvQ2tVUG43MEhk?=
 =?utf-8?B?SmxteGh4dUswNXR3MVhGQkVnVlRuL3ZEbDRodDAybHhHU2piN2daTHdCdEZB?=
 =?utf-8?B?MlkvL3lNWUhKajlzRnJzTCtJYjNZVHZWTFhrVlNKRlZLNi9TNHZuSVkvR0xU?=
 =?utf-8?B?eFJ4VzhEV2RxOVY0VFhTMFhGcXY0TlpQeTRldzkwdEhIdTRUVllKUXdrbU1t?=
 =?utf-8?B?QURWUEgzaU9JSDN0RFNZR3BEelZ2TnpRdUtmMTdzeDBxb0svT09xaStHNUor?=
 =?utf-8?B?SDJpR1pkN2VrU0NJS29BT2NQWnZKQUpXSm5HZFIyZzVtNlBoNWxOenhqUjdk?=
 =?utf-8?B?dlM1VkFkYlNnYld3Y0dSN3lTT1F6UUxEaURsdUJQUHdCQmJ1VDNwNm1vZExJ?=
 =?utf-8?B?TkRPeUQ5bUJqeVZwcjJWZHFRSGxpemkzdk1NOHhvWTh2U2hkZ1pFVEx1bjJq?=
 =?utf-8?B?eFRPVDY0QW1jZ2d3dkU2dVdIZzBhaTZkTEw4elhKVGY0MzB1OVc0YXhXZ0Ev?=
 =?utf-8?B?TjhmcjRmQU4ySS9uWDlDY0x1OG9vazgxUzdWUmRiQW0xOHpxSkRrMUNUNlUy?=
 =?utf-8?B?SzBBTkVEOHQ1Z0VLeXZlM0JYSnBodDZyQlVwVGMrZDFuL05WQklaWHYybE14?=
 =?utf-8?B?cDFxWEdKTGVNRG05c2JxSVZlM1JCUW1CYWU1dGNkY1FESmtHeXhoY1BwaDV5?=
 =?utf-8?B?SHI5b2g2ZjdrVGE5cG1XajZHbUdBMkdPQzZYMFp0NWZadDJtZkRTNmo0NFha?=
 =?utf-8?B?RXFyYVZjenp0V1JIaTd3MWd5WTBnUytvK0lYdDlpQ09ldm44QnJSTDlZK01h?=
 =?utf-8?B?YkJVeEFlcVRMRnpqRXp3MVo5MnhQcTlXWUV6azFLVi8vOFFEQ2pXMGZ3QXpv?=
 =?utf-8?Q?Q0hY6NwevmXYUFymQ7mEJGKE+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfcdc2c-8bf5-426a-5dd7-08dd47af3be7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:40:10.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rboelwollwFI3TdzM4JIgwcNBeYKgRyXkSVEOGflDIuZnTCx2glSIrMH/f4OJh58YjhdzcYIILvx342uFPw+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v14:
Marc Zyngier raised concerns about adding DOMAIN_BUS_DEVICE_PCI_EP_MSI. As
a result, the approach has been reverted to the v9 method. However, there
are several improvements:

MSI now supports msi-map in addition to msi-parent.
  - The struct device: id is used as the endpoint function (EPF) device
identity to map to the stream ID (sideband information).
  - The EPC device tree source (DTS) utilizes msi-map to provide such
information.
  - The EPF device's of_node is set to the EPC controller’s node. This
approach is commonly used for multi-function device (MFD) platform child
devices, allowing them to inherit properties from the MFD device’s DTS,
such as reset-cells and gpio-cells. This method is well-suited for the
current case, as the EPF is inherently created/binded to the EPC and
should inherit the EPC’s DTS node properties.

Additionally:

Since the basic IMX95 LUT support has already been merged into the
mainline, a DTS and driver increment patch is added to complete the
solution. The patch is rebased onto the latest linux-next tree and
aligned with the new pcitest framework.

- Link to v13: https://lore.kernel.org/r/20241218-ep-msi-v13-0-646e2192dc24@nxp.com

Changes in v13:
- Change to use DOMAIN_BUS_PCI_DEVICE_EP_MSI
- Change request id as  func | vfunc << 3
- Remove IRQ_DOMAIN_MSI_IMMUTABLE

Thomas Gleixner:

I hope capture all your points in review comments. If missed, let me know.

- Link to v12: https://lore.kernel.org/r/20241211-ep-msi-v12-0-33d4532fa520@nxp.com

Changes in v12:
- Change to use IRQ_DOMAIN_MSI_IMMUTABLE and add help function
irq_domain_msi_is_immuatble().
- split PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check to 3 patches
- Link to v11: https://lore.kernel.org/r/20241209-ep-msi-v11-0-7434fa8397bd@nxp.com

Changes in v11:
- Change to use MSI_FLAG_MSG_IMMUTABLE
- Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com

Changes in v10:

Thomas Gleixner:
	There are big change in pci-ep-msi.c. I am sure if go on the
corrent path. The key improvement is remove only 1 function devices's
limitation.

	I use new patch for imutable check, which relative additional
feature compared to base enablement patch.

- Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
- Remove only support 1 endpoint function limiation.
- Create one MSI domain for each endpoint function devices.
- Use "msi-map" in pci ep controler node, instead of of msi-parent. first
argument is
	(func_no << 8 | vfunc_no)

- Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com

Changes in v9
- Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
- Remove API pci_epf_align_inbound_addr_lo_hi
- Move doorbell_alloc in to doorbell_enable function.
- Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (15):
      platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
      irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
      irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
      irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask
      PCI: endpoint: Set ID and of_node for function driver
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      selftests: pci_endpoint: Add doorbell test case
      pci: imx6: Add helper function imx_pcie_add_lut_by_rid()
      pci: imx6: Add LUT setting for MSI/IOMMU in Endpoint mode
      arm64: dts: imx95: Add msi-map for pci-ep device
      arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint function overlay file

 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../dts/freescale/imx95-19x19-evk-pcie1-ep.dtso    |  21 ++++
 arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
 drivers/base/platform-msi.c                        |   1 +
 drivers/irqchip/irq-gic-v3-its-msi-parent.c        |   8 ++
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  81 +++++++++++++
 drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
 drivers/pci/endpoint/Makefile                      |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      | 132 +++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c                  |  89 ++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c                |  48 ++++++++
 include/linux/irqdomain.h                          |   7 ++
 include/linux/pci-ep-msi.h                         |  26 ++++
 include/linux/pci-epf.h                            |  21 ++++
 include/uapi/linux/pcitest.h                       |   1 +
 .../selftests/pci_endpoint/pci_endpoint_test.c     |  25 ++++
 17 files changed, 483 insertions(+), 10 deletions(-)
---
base-commit: 00f3246adeeacbda0bd0b303604e46eb59c32e6e
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


