Return-Path: <linux-kselftest+bounces-26045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22ECA2CCF4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6523AC724
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AA61B6547;
	Fri,  7 Feb 2025 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kaCt64wK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCAC1A316C;
	Fri,  7 Feb 2025 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957320; cv=fail; b=J0GyweZLr7O92vxjksvulXncicQOo+LGbNvbIRd7ZXsK3Nj/OReYbdkJX9JAIxQkO51l8VLi+GnGkk7lzlcWCEZ2Jd3bHTV/aZ7uJ3DtdgCdRpW18lg6+gDwzg+9WWS7DgVf9FdJ+iuzznMOIOUlFbV6+IyZt7UCqBT6ess9vrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957320; c=relaxed/simple;
	bh=QyRzyTj4H9XfJz0RXs6v2irireYwrEY+q6I9MbtdtrE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ns0TIX5VlYOWJGKevy4vD5wb4fBIEiYFojkrX/VLtAJlOoJmUz7RNbcAtO0JWnSJScVvi1HofIwV5gAF74dvhLOrbzqdVO0BL4raXKs4QUiSm8IWKG0uQ6YCEgbMQzYJykfQntv5o0VOFUjbWwaWVXzigPw1Dw1avGk8DL7CJEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kaCt64wK; arc=fail smtp.client-ip=40.107.249.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7bVtk+iCU7HRUP7fAOkoM0TVF6RDoxjfp8H+GISFHR/iEtVe/1rdGfTms/PRmWVCiAkkoIq8RCdkIgAbK9MNBn3kS4d2GZsqc8XSkKFc1TubczkOUViUvcuCg+CNPZrANHdrIAV1qBdXBMvS0Vy0xsPrL5kn8pTTOeGTXIE+4JZKmLHVu2MPMev/PH7MUBgBRlMDsmOCORMWd75NZpKJ8rxkE7ClVygXNZ2+U8wnDO0N6DugbqMoRyLpKTfRN9YIgrAdN6OKhYxMARWxhcM4PiVteli/ucNWx153phVp/2wADCrFkzSYkzRhINNrHI7OkIZ4er+MY4s5TyQGMHLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkqCxlx78Y0kqjtRFKi6ENQ42Lwu6slECVoGMlUZ0yw=;
 b=VZWzfKn2kvGieV8pzRojhdOULOiDJ0n0yaDotZgb64W7S8xW1+1fEFcQuEUFRd08nWxg4/yhOGDu2Oml7TlrJK8QEqnamxlck3yRqiA4Li4EIJfI4+2VViB8kHN/GTdCIHZaDRv+FPhMZK65hkIS4suz02CmP/3k+Mpib1eSJyolvLWIKS/0xBym7HQScB3v5mAITpVQR9IhoKezzc5YM+YNd/W8JzCep9eHMmfET3SomXX28Xwix6kndVlSx3lwzZMKYiXmhzE87rL2H9hDvpqRoxLQSHysWHTpkT3CwXWYWVqjoL8SHSCnl9ZZMIfmLmn+C8KBLG5jfXf0S69oSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkqCxlx78Y0kqjtRFKi6ENQ42Lwu6slECVoGMlUZ0yw=;
 b=kaCt64wK3HbAtZ9/KyKhpbRRin3vRAXCQRJUHxwTDADTdqIDFh4U5NfwEZgd8xPWbHmqyaVZNprGOKJjyHjTJaem7dgr7P+xj7+GA8LXxZ0HmsV0XKn25cSKNBvLy2cq+60O3po6jPH3fXdAvIaurC/FzoWFkYwhw9zjVv38t5bKeuzHt1z6xDx/O/MFDlUPsiNbkk6LqOpEbo5VON2q1x2x+J8ELnF0bP15C5OYFlgR2CQoQgogfLcgXL+ABT8rJCUDc3C67TRKG4/g8/JOgBJsJHKYlfTcLa3NJbDx1qSp0u9XCAKgOe5sQbyJ6BXv5Z7L7SrSbw38ATzExLN2gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:41:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:41:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:56 -0500
Subject: [PATCH v14 14/15] arm64: dts: imx95: Add msi-map for pci-ep device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-14-9671b136f2b8@nxp.com>
References: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
In-Reply-To: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=793;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QyRzyTj4H9XfJz0RXs6v2irireYwrEY+q6I9MbtdtrE=;
 b=Gqw1KdLNoUuB8ClOrT/QnJhIDITCPPTArKWAYvEuAg+PubESy9V4q3nPf2Fm4Wh0GrfFYzmmj
 b7I0fvoz3wfDHSHaCH6R6wrrhe8RZxRhVJxGSPzxGLlP6KESF3tPQpi
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
X-MS-Office365-Filtering-Correlation-Id: 6ccfe9c6-ab47-4048-8e29-08dd47af7aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEZhZnBKY0VyQXB2U25teTVGUjYvaVR2MTg5bEl6WUNKbWRvVFpKUUUyNStj?=
 =?utf-8?B?UjZ4SnE2a0gwT3FjTnBTNmJZRkZpQlU3SGZVdmdMaEFCbUZ6WW1LRXgyaFRE?=
 =?utf-8?B?UFNtaWVYelhrM1pUZzk4YythOGttYWdNNERSZE1HdDVSK0t5cVd6OHpoWERv?=
 =?utf-8?B?VmVFaVpZNTB5QThZaUc4REsvbmFrLzNETTVRajF5UGhxKzNUcFp1QXJ5dGFS?=
 =?utf-8?B?dTdEYTZnZTZwc1FSMXhqYWVoNHl5R2FXZzRYWGtRU1FtVUNtckV4SllQU2E0?=
 =?utf-8?B?OUswR0tMN3FYTWZvTkEwUGRZVmRjRkpWeUViL3pPK1FHWlZsYmJHT3Ztd0lu?=
 =?utf-8?B?MTdlWHg0cGg5YlhGUUN4S3BURlJSbWVKQ1dybG9VN2xYcXVEckJaZ3BYYTFR?=
 =?utf-8?B?WmpFQnZyNjREbGlpVTVjYUJZMDA3QWx3Q3JBdythaXRJQllpT3VuZzdkV1U1?=
 =?utf-8?B?amE5dnRuM3l1S29uYVNJd3FmUm01ZGZmTVUvQW02bFJWN1hjQU03TE5tMWtl?=
 =?utf-8?B?MndvNFFNY2E5Ry9TaEVPb2ZobU1EK0xQRTRxbDRIKzBMMVhqcHkwQW1Ed0xs?=
 =?utf-8?B?VGdjOVRjNDhlazExWmJ5cEl2MUdSRnRORytjNHorSjROZjZtUFlPNHU1YlVC?=
 =?utf-8?B?QW1mWWZHcDJOTVIyWVVEWmRMbTBsU3VxNm83bFJBa3JpU2hTVm96UlpQQlhT?=
 =?utf-8?B?K0U0M0tUbVRjaXNDM1EzblFtTnFzakR5cUs0aVdFV25TOXFSNVBLbzIwcjZT?=
 =?utf-8?B?SjZFMVNXTE5vb1BpdkljcmhPWDB2byttTThnSVlwUDdGd1lhdTc3OUtpbkE2?=
 =?utf-8?B?SFdlQlVxTDB5TTZkdGk1c1hDMlBNaldGQy9HckJZVDhUTHA0TnU0T21BV3h2?=
 =?utf-8?B?Z0FaaDBxSitjZUpLRzIySVJlTmVwc3RGVlZTSDhYbWR2R1NCUjhhODFYN1hT?=
 =?utf-8?B?MU50MmdkbjAwcjZ4ZVU4QTl3UGk1Sm9NM0hINkRiTUdUWEF5MEUvVnU0Um8z?=
 =?utf-8?B?V0R1Vm5uRXJnUVVTaEtYRlpqQkN4R2I4QW5Sd3FoaVhITGNuRFM0UFNvbFBF?=
 =?utf-8?B?N0YxcU1jZysralRDbUE2MWVpRTZNdVJTcFpLV1RtMDBvVE1IMkRabWVRd1hw?=
 =?utf-8?B?eWNWRTNBdmZvV1lLWEpSUVhyazJ1UEw2UFZ6Rm0vUTdUamJhbUlhUHZmQVNI?=
 =?utf-8?B?bzdieGZUOGxIcE9lbFVVMFRPd3d6Y3pCdGFwcU5UKzZlV2s3REtWVkM5d3ph?=
 =?utf-8?B?SlB5d05wZ2J2cmhvb1hNTVk4REZ4NmdCRnNpc1AxKzdYWmJ6YkoyR2xKSGxI?=
 =?utf-8?B?aTNzenZIZDZ4ZUpzYTgwZEN6YUEyTzdvRXVLb21WRFJXaS9DK21UN1B5cy8v?=
 =?utf-8?B?SU8xVko4YU9EdXpDenhZNzlEVXJvakNrQWtoRlMxY1ZJUWNGTTN5TEJxTWs1?=
 =?utf-8?B?YVZldUFweDRRS1N4ZUdBYTF3QWY0UnZSUjZ3eVo0UThxV1hvN3A4SkVKSVdX?=
 =?utf-8?B?ckxNVWlVZkRNZTNCYktaLzdXeHpORm5YczR2ZE5lWTRWTUUrVHNkNTR4SHo3?=
 =?utf-8?B?dWJqekN0NUZKWkZYMWlSOURwUWl4NlVhMyttNHRiR1FLaXEzKzdYMFFJK2dP?=
 =?utf-8?B?aXZ5dUpRdzdKeWE5OU5sb0VvUTJ2ZGFKVVJVODN3bVVsbGpKcXVnR1FlN2lK?=
 =?utf-8?B?SDRHSWhZTFQ5YzNwak9HUFlPc1dSV2R4azlieGFRQmhDeHR3U0JzT1FBRFJV?=
 =?utf-8?B?RFZqcjBSRnlyRlZNeDlITjRwMjBkRkpKNWRsNVpGdEdpdE5nK3l3T2dTMEty?=
 =?utf-8?B?MUtIVFl1Y3p1dzZLdE80T0pRUEVyNHRKbnVRaDdlRzV2aXN3ZTEzZTF5ZkF6?=
 =?utf-8?B?WWpvMDNqMDRDNnNBMkl0aTEzQXhtczhsdVFFYnRHOVFCM2tLa1JRajYzMkVE?=
 =?utf-8?B?NnZiUEdQdVhveVU2ZlkrYkR5QWhCb2JYV1pySDdXUW9hSFltSjk0MkN2U3ps?=
 =?utf-8?B?cWQybmNWMFBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkdVaGNqNEhYSExrQ3dBV0ZKTGowYkZNWnBjZ0d4b0xTY2RLbVQvWHE1dEQr?=
 =?utf-8?B?UDRlelNWcFRXaXd4d24zZVlFeFRxODdhOUlrdDNoMDNudDRQelk5WTBHWFM0?=
 =?utf-8?B?clUwRm9KRW11SHJxOHpPcE5MNTBIR1ozSmMwYXFRY1ZHeFN3SGpKa1BqRmNH?=
 =?utf-8?B?RDRzSkR4VElIYXpnZjBac2FtWnFrTkx6ZnQvRXE5djlwc3RmTGt0dUdMN0V2?=
 =?utf-8?B?ckc4d2U2eDJxYjhyZG9EcFBBYnZuMEhRc1VzN215UVBDWGtEUW4wRGRBQnh0?=
 =?utf-8?B?cWZZOWxWTUkxOUw0aEIzR21DOHZSZnhYckVXWXBaeVpoUjRVV3U3cGUxOStH?=
 =?utf-8?B?N05rYVFzRnRKb3VidWhpSEtrNFJROXAvRlRYdndmaFVKZExrYzdiZkZSK3RL?=
 =?utf-8?B?WXlzZmxKT01PYnFNdm5YSDQyeldzVjVnQlNyVGg3akFWQjRMbXZpVHFlWEVa?=
 =?utf-8?B?d2o5WWw2NXdFUTFWQXkwK1hBd2pyWXBJVmpmVllsdnRCWVZZYzRsOTdqdDNZ?=
 =?utf-8?B?QjA2enZrWG81cVUzaW93VWljdlZNUzhlTk80WW0rU0xxUXhqSU9UV1ZET3Y2?=
 =?utf-8?B?K21JYW5RYU1MeEJCa1pHNWk1ZGV0VCtPRyt0UDhNdmxNQTg5bnB3SzIvby9Q?=
 =?utf-8?B?WURPNmRoZkptcjlvZk5yYllvTHJ4bVhUMjEybWVuSDgxd0xzQkJYYll6NjY2?=
 =?utf-8?B?T2s5clQxSzFoQTJwRnk3YkFjMnJXTlF1UWVhWlUrbTFFTDUxL1kwbGhGblB5?=
 =?utf-8?B?TzQ2My9RU09BRHFNQzJiTXNqZmlsUksvM0NUT01jeC83VHRvRTcvbUZEMStI?=
 =?utf-8?B?QUI2RTNmc1pLUk85NThrUEF6cWdTekI0eW1iK0puNkdlWFo5VUxZY0tqaStF?=
 =?utf-8?B?Y0g0TXFHQXNlUGxZaG54b0M5eEpwRXcxL05lVUtKZG5MbWEwYjNWa1lQTHcz?=
 =?utf-8?B?SW9ONXEvZXZabHM2ME4rRDcrUmhtUmp0OWNMdnpManBLZ3FGQTZXbmVXbk5T?=
 =?utf-8?B?b0RRK2E1SVJjL3NoL2FKdERlYnAyOW5FV2YvOXVFRTlMN2JybDNIcTVIcDYy?=
 =?utf-8?B?Zk9jVTFHSExrdWlGcUJZU1VsZFdaTXhnWFlzL3R1M1ZVU0w0ZDlKbkNVK0xD?=
 =?utf-8?B?L1RFZ2lPWmZiNnF5U0hMbXBxTWVGcmFEWGtkUUpUZlQzdVV5QWVVSlpxSEU1?=
 =?utf-8?B?c3l3UUZBek54UWZUemdyd3BIWmk1K0JTVitNQWlEYTlZRU1CS0ZVUjFOMDZY?=
 =?utf-8?B?RWNXMXZ2d3lORGZyaTEzNHNHdVBiL1A2LzFHeno3N3Z6UStYRUJFQ285bTdN?=
 =?utf-8?B?b1p4K3ZjaXE2NS9VOC9ZZkdleHBSRm5ENFRybTFtT29DS2VvaFgyR1l5NXhk?=
 =?utf-8?B?UjN0QlVrN0V3cDhLS2ZuVktaekRKaTJPQzRwM1djVlZHRjRBMjI0R3l0cHNt?=
 =?utf-8?B?YTIwNXBlUWFDaU93bUFyUEVUcUloZEJkbDlHYi90WUJSZVkySjJoTnVEU3hs?=
 =?utf-8?B?ZVlMcHd2eU03WVZEbEZDVTZMNmtERkNRRXRRV3hpVjJPc0JwTFNFNHY2RlJQ?=
 =?utf-8?B?QVBFLzJLS2l3b2ozZHgrcHpUb0syZ1F2a081bnMwOGhMQ3FEMld5d3AxQ1FI?=
 =?utf-8?B?aVdGVXdydjZlL2xtSnVkSHAwZ3BHMEZWODM5RkhjeHdUa01Pam5zTzR6eGNo?=
 =?utf-8?B?VlJySUZFd1o3UlNKaWkrK3lOVmk5alBCTFBFdE56WUY2a2lRcHF6aS9qWkRi?=
 =?utf-8?B?a1Y2QnBDUnNSSTFIb1J1ZWZYd1RFV0E3dnFoblozaC9Ya3NsdnpNbGNlTEFs?=
 =?utf-8?B?YnJkUjF0dWRoNEJOUGtzYzR5Yitjem5URTI0WXI2aTF0azVWaVNXdGxyTkEx?=
 =?utf-8?B?clF6bkxWRU85VGtyTGNvdkhDcVV6OGxyRXF3YWxBN3plMi8vRWYyUXlnMjBh?=
 =?utf-8?B?R3pxYnBKdlFmUmwrWVJoeS9jL3djWFhVNFZyUG1vdmVOQWMzV2h4eitxN3da?=
 =?utf-8?B?YWN2eTZTcWhiTjYzcHR0UkdWN2lMUUI0cEZUVk5meTF3di9kcU9NZUZTNlhV?=
 =?utf-8?B?cDhLY2VZQ21Za3BIMUp4QW5NdEQ5M3dPd3QrSUFSdWNIWTZ3VE1Xc0gzWUhF?=
 =?utf-8?Q?c5hpXglcHO4abfTZtszPhTDaU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccfe9c6-ab47-4048-8e29-08dd47af7aea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:41:56.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuEhmOYD/aoh66lDc/Ia6VO6fN7l8FhWpNmEDWapEGEE0xNw8nSbIXmKUpASAuZBgQmZoPIPX6nD3utS5LdZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Add msi-map for pci-ep device.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v13 to v14
- new patch
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 6b8470cb3461a..cdc06dea5982b 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1667,6 +1667,7 @@ pcie1_ep: pcie-ep@4c380000 {
 			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
 			assigned-clock-parents = <0>, <0>,
 						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x98 0x1>;
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};

-- 
2.34.1


