Return-Path: <linux-kselftest+bounces-34503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE24AD2419
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BD01890929
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E721E096;
	Mon,  9 Jun 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="boGL1Zrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAC21D5B3;
	Mon,  9 Jun 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486907; cv=fail; b=iP3FxVmh2a9GSRfSZBWeGSE31dxdbfu6jPw8csAP+Zqvb2Po9TMhlHp6zQSXLu+h7IaMKTHwNHwrcnN9uOXB4QXvZDWuxALZQb69R3hhF/gDubzoa3uSc50wchmAQOmqg62rdDZQMI+ve7EYt0/4qAotwunuA0+lgCikjRDLjMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486907; c=relaxed/simple;
	bh=Q75HpsG7AQZeyq/78WIzVSdGpQ6JBJuHxf6b6uNsmfE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IfdBD7upN0tOzO/GCwcL23ztRuejLK0u6bMWUJuQlyZ5zhNBVYRxieR4o47UDX/bMlrRF+p0IQkOYdYf5hXdngKSTyTghzM4GqlTFC4SPvkqdMoHpvWlzTlaJwToo4WY8Py0cMLwHldzvGi5cftW+m4iF6+36zJIpFzT9f7CWp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=boGL1Zrh; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvuyY9XPnDIszRqPW4sAPblMqYfeo4tJynxIM+YW9osIIaqu1aXbPY0z6MfM69h9+W0u8RHkz4IbSWlV4gXd/suzf+vW+ENbb51PA8pC5gajT4rmSzrpwONuttM/yK35VB/SyeOGWc7ffQJh4Wpg89jgs8H/fdFj4N96Vq+T+K+X3rtBIUd1WkfMxJNHdkjdjYHKYPMoTv01QFdFzeDaa/ajezqgZf9fnjwzq0+Vk2AXPDZMaTiTz6S79zCx5DrAJdmiCViFL0rO8L46rLM5K8lspGKEWsFcAtoDpscElFy21iSwFHnFuiCVluwHOqbngSuP4jlekY5/YnhdpOEkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8Qp5FfqRuQHFYCFtVEMJWoCYl4K1g4dfDwvdzdP/uM=;
 b=CFdKMveo3FpCn6djqSCXolwkPgU3g/X/41KR6rX3udUlSMamY7Por+ePqQ/bkIHn+VWshFOEcNti7fN7DXWd9SWkdreygCx9tfo3bmthF4ALrcP83Kkl6BO+b2j7TIalaf8NnlZ/TOoM2JHrRXKGlf43zsL3INLCUywPenu1MJFZ1F1EFcqDwUOeVs+rXWrvyKhTyQv9fiuMvkteKmxumHw2Avn1yN17NEVtcWoJCTCw034xGwHWmLXtNIJdW++S/RUlYLHGMAindf3YB5bVQ3sEZHXpoc7etb+UM/16R8bP/c3tn19MUls5l3wpY35dmcxtH9tCmIIh91JppoxPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8Qp5FfqRuQHFYCFtVEMJWoCYl4K1g4dfDwvdzdP/uM=;
 b=boGL1ZrhEhgE4ZdtoNIRFkDH5zoZ2qln0f9a6k7BX/wHdRM1Ytx1DulnF2tGsnFxC+Y8VVtckmcfiQKK+XH1rxcVVphfzkprlLQmJlG87D9qT/wM4OCZnb/awdi9C0//BKJ6UzXutn7uqF80+HjynZyBdaYjvqec+iKxnXKHOlUHvCUSN2atziAKILdxg8nvpNV3QX2eQllIbvF6NsSt2YZH9c0pNWbDc2j1k+uxHwFFZygglAGAhkyKOWTGHkr32Uwxd6cf9KKgtWG2Beh6t0hWJpkWCDYwiA7IlNgSQGbV+3tRBenfyJkDOM9wvOhm3tte2eauPRTKtACjtN1F1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 16:35:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:35:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:18 -0400
Subject: [PATCH v19 06/10] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-6-77362eaa48fa@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=6407;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Q75HpsG7AQZeyq/78WIzVSdGpQ6JBJuHxf6b6uNsmfE=;
 b=OkHigk8u98iu+hSrmkOGgOnGK9CLtV/EWJ+Upi6BhUZxHRE7plri8HuqjJv3emSKqDFnQ9mo6
 iJXpE/AWVGiBR1By/NknVqL4IpbwQBtlmOcp2AkT5iFhqoHzWjFiFGj
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
X-MS-Office365-Filtering-Correlation-Id: 6281c70f-63fc-4847-b30f-08dda7739593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWk3R1ZndzdOQ0hzdWVzMFNnUjA0Y1Z2WDRGajdmczk5YXhjU1hidEZucUJV?=
 =?utf-8?B?a3VaQXVlRmlsM2xndlNtRm1wcVMwZlJWQXdoSVFrUENXMkNiWCs0YTZDTjBu?=
 =?utf-8?B?Zjlqem82OXRJS21WZGVsZnA3dTdqRkthUjg0Wmp3YjF0L2dMYm1nVjA2dEtm?=
 =?utf-8?B?NDIyNGhVUTNQL3NaTmRYYUplMEgraEIvNDNKYW90WllNU05UWDA4c3AwczVo?=
 =?utf-8?B?RENHQnh2UU5RMW5kZmxNbG5NdWVkeVZoUHBOQXRwSVRabGc4ZVZheGJLUmxa?=
 =?utf-8?B?aUQyTkhubmpUeGp4NmJMeFhTb01QVytDdjNqYytxU2lOcHRWS0tJQ3hJeGlJ?=
 =?utf-8?B?b2ZwcGc2M2NoQ3IxSUs4S1FrTHZvRFRTa1RXSkFyZ3lvWTRGbFhVMlIrenMx?=
 =?utf-8?B?dE9QNVEwM2FaUi9GcU9mSHdqbUMyVW1BYkdkb3g5aVhKUFZZUnR3OHRHZVBH?=
 =?utf-8?B?QTk1ZmZDZG5Bdk1YbnNqUjduWUF5aStJME5VbnZtOGhRaS9RMkNaWVU0Yld4?=
 =?utf-8?B?WFdCNHJxWW94b25nNUtmYzZlRk1wbU1MSWNYTzJzYjlDQzlLZ0lmZ0pNSXVC?=
 =?utf-8?B?RmJndm8va0JIV0ZQLzBzNjJDN0RIRzE5di9EV1c2VVZ1NHo4cEhUYkxoUW9q?=
 =?utf-8?B?by9yNUZhdW5oNEd3VndXUFhGdE15OWl5YVd6anpxL25hNzB5YTF3b2lvRmFw?=
 =?utf-8?B?eERJSGZxS3BFZHdDc0IvbE03VlJSVC82UUhZVWx5WmViRW9ZRzh6RlFLZmd3?=
 =?utf-8?B?ZTRKL2tvWGJ2NWh6cFhWbVVEcndnaXRWSTRQUS9IaXNudnVFOEgyWS90YWgz?=
 =?utf-8?B?MmFRbE5oT0lZUmJzNVQ2bUFmNGFjWG5qajI2dEp5YlRzcEpka2ZtWFpNWVla?=
 =?utf-8?B?Y3FhRmVDTHJQbndTUko4WkZ5aTNWRi8yT2c0Qi9VOWlWbzIvcUJ6RmV6Sjht?=
 =?utf-8?B?OFZSVGZvdXBmTUNqS2hkZVNuL2gxTDZISXhMaXVOZGQyRXhWNU9meGNCeGc3?=
 =?utf-8?B?UytKRld0ZjdHYlNsVzV6VVljbi9HMnRYRjJLQnJrekFmVVlTNEpCTEowZVpI?=
 =?utf-8?B?V0RKVGhwMUdpcVZOa3RwMjlNZUVlYUMwRFVTak5RQkp0OFdHTk1CV2tFOFFQ?=
 =?utf-8?B?UzZmdklqamFBUDR4czhDQVd3ZzFkRXhzbFF0WG43VjVDdS9NK0ZOWHVuVkMz?=
 =?utf-8?B?WmRiZWI5RDdVTVVuWndzZzZvRmxIVUUvQWl5YVo3NDhOY3FDdlMra0FiTm0r?=
 =?utf-8?B?YzdOMUdXZk94bmk3dEhJaVNuNGV6RWxtaVg0WEhjOGtWWG1yS3RkNnlUL1Uw?=
 =?utf-8?B?aHZibWY1b2h2WjhyTm1zKzdBbFp6dGVyRDhDSTFnczV2dDZiWCt6L0pLLzN2?=
 =?utf-8?B?Yms3VHI1WUIrMGFGTmNoNEpNTllOSndvUE1wSlprWVZ4SGdTZSswekFYZHdr?=
 =?utf-8?B?OEMwb3NUYllZM3F6dnNWeUF4cmcxYnVpQWVZNEpGV1VRQjJDclFLU28zRG9X?=
 =?utf-8?B?QWJMdGQ0YXpRNTlyVlRSRzYzMVBvRHNtdWdpQmpJbHdsdzJzWTNTOWZNblVT?=
 =?utf-8?B?MTFQNWpnVFZmZy92VEpTdDcwVHV0WVl1V1VXOXlsOEtkYXNsRFFkR0FuTzhz?=
 =?utf-8?B?dTREbWNHOW5HVnlrblVaYXZHYm00ZzdXbVl4dmVVV0dFNmtFaTVnT1oyQXBj?=
 =?utf-8?B?dzBOdGxPVGw3V3BCM1VvaURKNVVibi93OThGdVdsclpHa1dDcytsTnVyZFVs?=
 =?utf-8?B?M3piSEtTMmE3b0R0MWhNeTNVSTVCQmh6dUxRMndGY1RVYUlUdXZ2Nk1CTWVa?=
 =?utf-8?B?SndvQlhUaDZoMVVHVjFpS2pydTVFdnpMTTRTSElicllIaFEyc3JmL3FSTU1T?=
 =?utf-8?B?R2FFS21EOE81ajdXZzRxcVZaMStmWms3OHVIdkJEUWhPSzNJUE9vYkhyOTVj?=
 =?utf-8?B?cGNocW1adUxLbVpXckZHeGF6M3crQjBVd1JpUGNGeGpkRUhiUlJId0pEZUlp?=
 =?utf-8?Q?WZ4VCmz3pO+QF365wNuKTuK1g8evMU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVBYY1hXNFptdUtWYStCVm90bExRSFoxUElUYUVrbm44cWEwNGJ6b2lodmVz?=
 =?utf-8?B?ZWxYOGUwemlSVXVTR0dIbkZWTkNZS2VqVGVGMTdmaGw2RGVjT0tMQ3F2REJz?=
 =?utf-8?B?SGFvWldQWjYweFZkd0JRcUJoa2YzMm9MNy95S09yY0FBZFFXQi9XYkRHancz?=
 =?utf-8?B?S2ZnYUQvQk1PS2NwbUNic2Zha0wrRVZsMHFxWUUyU3Y2VldXS2hyNzhGaWxz?=
 =?utf-8?B?MnZXNEFHNkFucDF2ZWhGc1NtTGxWeWloaWhTY0VqSlVSNW1RdzM1UmVpQW1y?=
 =?utf-8?B?TEFqQlNVV0VCMzk2S2JLTmcvbU1jZXQzQ0kxcEcyTm1oazZhako4OHBFSWdk?=
 =?utf-8?B?MVVLdXU3NmdLS3lzVDh3MmlIN0FJcEJVRS9RaFNncG8yQXcwTFpnakVXTEw5?=
 =?utf-8?B?ZHRCbXJSbnZDeXdtWUxvQ1JlY2VWcHlKcXcyN0V2WVQ1Nng0cmlVblplM3Zx?=
 =?utf-8?B?Zko4cE5XWEJQRjJoL25uSGpCNVpuTEwzeFFnTVZld29QNmpQYkhnRWZ1SVB2?=
 =?utf-8?B?ZUxHYzRtNWFTcTlRQm9adXUxZjVES1dld2NJdHljZlRGckVDK1g1L2NhUGVj?=
 =?utf-8?B?N211ZWFDUmlGSHlTR2tTNlFvSGMwdGd6T25aL0Z1VzBVNnoxRW1lbHRneVMx?=
 =?utf-8?B?VFE3ZDZSaWZzKzhLMWRucTdheWt1c1MzNlp3dENzSUFPVVJ5WEZhb0xSMStQ?=
 =?utf-8?B?UU14NkFnSUNuYjJtWHkyd0NWeGJNb3ZzZWduMW1ia1pvRExMeE1OTitLUkE3?=
 =?utf-8?B?U3pOTitLaThmbG5GdVV6K0ZxOVZvNlB4cXorTDZzdEhLN1llWlN5RGFnMXo0?=
 =?utf-8?B?YmZiSnJJaXlTazRSY1hOc2tLaUxIdmpLZ3pXQ0tzQ3pBd1dnTlJWVlZmZmdv?=
 =?utf-8?B?UGxFU0V6emNmYzdyVzNlN0RiS2F0UXRodnhaY0p5dU4xNmw4bklVMXNobHA2?=
 =?utf-8?B?VDNMTEpHR0tPSXdjY0tqd0JqZnZIVERpWXVHQVNrV3pVOWFyUVBvTFEvMUJB?=
 =?utf-8?B?R2lZRGxkQk5MZmY4aEgrSDFaVy85MUxOYjNWVmkwOWNQWmJ2WVp4NUxFOStn?=
 =?utf-8?B?TnBxeFl1b2NPdm1ETE94VzRJY1Z6dGlWT3Vhbmc4Y1BaMFR5aGFTVXZZWTB6?=
 =?utf-8?B?M3RTUE5OSk5BNVNiZEZ4OHZGbVIvRnlLSEJQSXl1cXFwTDRaQXVmbVNPbXNO?=
 =?utf-8?B?N0xLYVQ5eWlrbmFYQ0ROTE1pUG52clFSRkNZWUJRQ1VFZHZyQW1vYmh2V1NI?=
 =?utf-8?B?cGNiSngwaXlXWUp1MHVPcmxjd1JXNkh5ZklZUjlDNFhjUW5xUVFqVlM1VVIv?=
 =?utf-8?B?bFUySjhHWmxkQlVSbERVdEphWHFkV281STVCWFhQcjRmdFV2N3Z2ZmtpbXI2?=
 =?utf-8?B?YUF3K2hrd29mNVZjTElmWjY5RFJONHFSQXcraFZqb0ZQQzVFYVZzbEVYejFm?=
 =?utf-8?B?cEg3OFJHU29HUjNmVjdWQzZBa2N2ZWpwdGYrbVZyUTZQaFBRRUdaaVg2eGxF?=
 =?utf-8?B?ZzRoY0RBdVBvVEJsMjlPWHJrSkZNYjR1b2tRVXlxQ3VsZ1hHdG5SVjBHa3J2?=
 =?utf-8?B?R2NqcGNMcjNiS0VyalJLeFJxOWxDT203WUlCUmpzZFlNYytoUEpHNnVxdk8x?=
 =?utf-8?B?aGFIVmNXdzBDbHpjRUh6RThtUkJUOXl3N3Byd2g1cEFLVXMyQ1VBMDQzN3ZY?=
 =?utf-8?B?ZytHMzVLcUh4OFJnZkRFWnlCTmRrSTNnMXdkbzBBOU01bDRiTlk5R0FPZGRG?=
 =?utf-8?B?cGZKeUl5SzJaV2hBUGRjTUs0VExxUjQ1R1dYR1ViYmFFTDJtQ0JzV1pQdkl5?=
 =?utf-8?B?YmErdkpiYXowaG5ZTEJ0WlVJdUI0UFhaVTN2UlQ4dXpTbVA0d0RBaEF5eEl2?=
 =?utf-8?B?ZmN5cTV5cTVHanZFMjV0QmJKNTdmWGY5UEN5YVMvbUUvN1JyaW43UExTMGYy?=
 =?utf-8?B?RXgreG5qV2lNT0dLWjNFa3F0SFpGcXNCRUdUWTJyeU9hWVRFWFYvd2hyc0ZV?=
 =?utf-8?B?em84bW5DdTY5UVBjbk10UmcwdnlBcG5NdnpxaE11SUxuVG5sM29hbm5HTUY1?=
 =?utf-8?B?blk0Z3pOampUdkhMRzdrZlMyVkREQktqQ3VhdmV5MlpJeU5ZLzRjemprdUVN?=
 =?utf-8?Q?puakkm9aH6BjbnD65+fvkdpoE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6281c70f-63fc-4847-b30f-08dda7739593
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:35:03.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuG7uVRPsZuIn7NMDyv6hqn0IAU/vNWl69oWwaLg53si0yZUgRFg6y8Nd7evp0+zQXWxP32N43cIPceHXApMWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem, which
host side driver miss-match with endpoint side function driver. See below
table:

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

Change from v13 to v14
- update to use pci_endpoint_test -f pcie_ep_doorbell
- change ioctrl id to fix conflict

Change from v9 to v13
- none

Change from v8 to v9
- change PCITEST_DOORBELL to 0xa

Change form v6 to v8
- none

Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 82 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c4e5e2c977be2..0f3af7adea107 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -37,6 +37,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -48,6 +50,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -62,6 +69,7 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
@@ -70,6 +78,10 @@
 #define CAP_MSIX				BIT(2)
 #define CAP_INTX				BIT(3)
 
+#define PCI_ENDPOINT_TEST_DB_BAR		0x34
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
+#define PCI_ENDPOINT_TEST_DB_DATA		0x3c
+
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
@@ -100,6 +112,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -841,6 +854,72 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return 0;
 }
 
+static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return -EINVAL;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL) {
+		dev_err(dev, "Failed to enable doorbell\n");
+		return -EINVAL;
+	}
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		dev_err(dev, "Endpoint have not received Doorbell\n");
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
+		dev_err(dev, "Failed to disable doorbell\n");
+		return -EINVAL;
+	}
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		return -EINVAL;
+
+	return 0;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -891,6 +970,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index d3aa8715a525e..d6023a45a9d03 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_BARS		_IO('P', 0xa)
+#define PCITEST_DOORBELL	_IO('P', 0xb)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_IRQ_TYPE_UNDEFINED	-1

-- 
2.34.1


