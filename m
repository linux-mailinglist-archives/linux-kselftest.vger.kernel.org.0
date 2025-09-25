Return-Path: <linux-kselftest+bounces-42352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E80BA00F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B528162AB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047DD2E06C9;
	Thu, 25 Sep 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="O8jvq0Sw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011067.outbound.protection.outlook.com [40.107.130.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E358F54;
	Thu, 25 Sep 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811583; cv=fail; b=LhW46yKFhNUPEDO7f02cAjghGPLhco02bYHrXHpX9CfJ09m59bpIshH4ZzTP0DeN+oerXLJl27TxvrgZGZvXUvHYLugTDbMsd8mJfsZ0Uw4kaYlfjRV2DUuywulEwJbK9U+/h0awzeFqlxudtWAcw3rDPHpu4KI5tyZYLneDLxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811583; c=relaxed/simple;
	bh=p5j3diULu9Spx5KaryEVmRYr7R3AI69kTAANGdfZHC0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q0M9RiU9icqNqkZuQ4Joa/L/J6MRnmvAFPW8migDHRpX+eIIUh/CwgxBKlzRB1UIOcdzzhvZ1bp+MmvwyMvfCsXbtfuzsRrcrGncmlSfXPPuX3hJ5H+EtJZP4cvF3g/Pi3XvDHWxtkkpyMI1IQfo2Lx8k9TN436Uo1a38A5dxO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=O8jvq0Sw; arc=fail smtp.client-ip=40.107.130.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlE2ZqQ3eAxP5Yz2Rlw/toHbIyv77Lo1pOb5V7gvKX+ZjreuF+BkIW7oKGvWmOJo7dV4ywyioxTKsEjLdn/MOnIR8JDdYP/v5Py/75Z5UrpvHILvnRrgH5X4mfrK/T/I6zC45Aa6NRmFgYsrET+OxctnrdITdsqU0yBW6TBI7f5RGbVMjvotppNaIdl+fOzcdMUXrdZn4hObvvnSUFIXQKxDHHR3gNwm4FH1YiOYpqlXvgtG2rlFFcVHLb9IYL9Eckr5mNiUfsQf6z7fko3PJ2vw9Csmr8LgAfMjHHzu24QpNO/iTve/fTdmdj4moQbuMAsdzsYBVL57zxbyHekOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5j3diULu9Spx5KaryEVmRYr7R3AI69kTAANGdfZHC0=;
 b=FQxPn+Vx5faG8Xxfo3hnzkL0Wm/UwWGvDiS5LKBSQ/Md5tiIArAyiJPMyyMGaIh/6vc+HRlLqdF4Ud7gRkKmlYcwh9/h7jEj4EakGYLP4QPO2okdkziuuuBfO71qbgQiOgH+dzvjxFx0HnC6Ckk8e1NTfntPeU8s2I2pAmwdXSr/tjhdAKhB/0yuGlplEaFEVR9eEg6ZFyn/BFnprKXR9wN4B18MGKMUPhGQrzL3WhGkJMbhuIMCm2sSqMtRL9bHoM3pJFDgrhYE7b8ouiDhxebE20lwmXuCwiB8FAiEdw2qW8ejJgd5+DhmJK6TuRP/yUBlHChQJnto20j9p/Xwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5j3diULu9Spx5KaryEVmRYr7R3AI69kTAANGdfZHC0=;
 b=O8jvq0Sw//vOmmL9H4byoDS0Ix448ejfe155FdnJEnY0Quh+PywVElIo0U32QKuM+HJwRZVoArvVZXTXvIzCanrmOdyTmOlWSVSShYKkI0WyCL4wON0JIQTAGviC0YbbPE73AQjpKKlDz07nq/RRn8BX1S5jxmlSK1tKrhMAQyaZVnw6ZM80brYmoQKXF/Rzhm0qq0CnVkP7R/iOOCVDNueBZA3mDKjubkdSaSpt6o4WzuIdGfyjsI3u+67LwI7AnRsCaxbOv2vN4/u7XMGqgiBzIJ7Jfr/LQ4TDak4pJLu5cg3N0c3d+Z9hA0NkDeoF64/sWue7yyqbv8rDuC1VyQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB7068.eurprd07.prod.outlook.com (2603:10a6:10:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 14:46:16 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 14:46:16 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v2 net-next 13/14] tcp: accecn: stop sending AccECN opt
 when loss ACK w/ option
Thread-Topic: [PATCH v2 net-next 13/14] tcp: accecn: stop sending AccECN opt
 when loss ACK w/ option
Thread-Index: AQHcKLhgSdByVLZCo0+IAigjdAMyPLSgnsgAgANafZA=
Date: Thu, 25 Sep 2025 14:46:16 +0000
Message-ID:
 <PAXPR07MB7984B98035A3D3A1570F4AF4A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-14-chia-yu.chang@nokia-bell-labs.com>
 <03d6dba8-2586-4ae9-8a16-26b84cf206eb@redhat.com>
In-Reply-To: <03d6dba8-2586-4ae9-8a16-26b84cf206eb@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-Mentions: mirja.kuehlewind@ericsson.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB7068:EE_
x-ms-office365-filtering-correlation-id: 6632a4e8-654e-45a8-3631-08ddfc424838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y0oyWE95NnlrVEFyNXZuRnZXYXJMMmdWNWFpM08vSHhuL2NvMVZmbnhPS2JX?=
 =?utf-8?B?RlhFMGRrdGFESWRRQ2UrTUpEWndobXVLNGx5YmhRcmVrMHhrT3dmcnlSZTNP?=
 =?utf-8?B?WnpMd0V0RnQvYmlMT3lRaTZvT3NPTThBbElyZzlBeWcwVjAwV0FtOTJkMHdX?=
 =?utf-8?B?R3J4MVJDczBjTkNiV2RHQ2M4Tklpc2FoSTZsdnQxQm9WTk1qajI0ZUgvOVM4?=
 =?utf-8?B?TGZYSWhKYk91YTRWUEtxWURYRVpLc2NVZ3h4TktaM241NzdBUXRkUDIzQ2Q5?=
 =?utf-8?B?RXZVRXQ3djUybGU3Q1VoTS9oOFd3Yk5DdnVkRjJjSC9mc1FyWmNxVEN3VzNP?=
 =?utf-8?B?M1N3ekgyWi9yU0hNbDcranlIbis4ZmlqUDJLZWcrUDROSnRVUjYzeCtRekpS?=
 =?utf-8?B?ejVlZDRvc2JFWHIvSXBERmd2Q3JHUW15Nmk4Q1YxeGNlT3U0Y2xoVE4vSUNV?=
 =?utf-8?B?OFRGdDR2Vk1vRmpET0p5SlNNclQ0Q3d0WHU5VTN0bURycW5mZkF5Uld5a2Y4?=
 =?utf-8?B?WHZ4ZC9UMGZNV3dxZUJWSVAyaUVCU1hZQ0V3QVpiS1NPUTRNSjYvSm0vZUow?=
 =?utf-8?B?VlVJckR0N3pnSG44clhXaVNtTEsxVXByOHJteHF6djdhQUJteFJHbHFJcml2?=
 =?utf-8?B?c1Y0UXdVUG81L0hJdGFiUW5IcTZlYmVFTEIrVllySWZQSUJlbyt1RGtMTGo5?=
 =?utf-8?B?bGtSaHFlQUNvZUdHQ0FzWjBnRHY3RHF5bFNBbHo5c2laVkhOa1VOOFB2QnUy?=
 =?utf-8?B?ZUNhNkVrYVd3ajBHNGhpR09XY3dZSHpFVWtNYlhkK3pWQ3c5Zjk0SGkvNWFt?=
 =?utf-8?B?WDhNZHlKTHRNY2JrbzdOdU1UVGdvY1NVTGVidUdnbEpkQnkzTDFpbHZxN2Y0?=
 =?utf-8?B?UnZZVmtxTThHU0xSKzQrZ05MWDlQTkp3RGt0eXptamxBbkI5Tm5KVGZrQlZB?=
 =?utf-8?B?N2NtTGtBVEwwV2xHQ2hORTdxenhpbzBRRlVEMFhwaThMSlhYK25HYkpKcnJq?=
 =?utf-8?B?S3R1T25wU2hGZUhDbFBKVExvdnByWTU5UjVRZkV2NjRWdlpjTGNSRno0VG1T?=
 =?utf-8?B?eFB3QUI5VHhnYUdiVVBUU2J0clcwN1YzWjd6Ym5GaFZpYVJQR3RMUXh6dXRx?=
 =?utf-8?B?S2RPWThMT1NuMHV3OVRLU1ZOdkJqTUxWZXRwRTRrZTJjQUJWSTNhVmVSNDdC?=
 =?utf-8?B?b3RzQXh6SjE4RzAvdTNFRTVtb1kzQnhpY1Vnd1ZxbDJmTjc3cmxCWnAzak9W?=
 =?utf-8?B?WFpkdlkralp5QmFPV3JUQVR1eHRoQWt6Z1lZdTRWZVc3TVBNbXZZV1RtdmlM?=
 =?utf-8?B?MjVDMFhtSFpoVHFIdEhPVE9rSGJQQ2dmMnoxTzA4S2lSVkliUGdBVFI3eWg4?=
 =?utf-8?B?MTZpVUg5RWl4ZCtJd3BMVWlyRjVWSE9tTXpBS0s1NGNsSWxsY1FwZ2pRTDRo?=
 =?utf-8?B?dU02K3pGRGpXbHBQT1JSVkNEY1UxdmRHQ0dXeUFtSlhaMGxIUUtqczMwUlk1?=
 =?utf-8?B?Q3IzVWNqRWNUc3NxRVFHUnhtL2hNSDlROG9lWnRvQTMvMXVOa3BNdDdNazdD?=
 =?utf-8?B?WU5WRjZveFVzUERQTWkyNkhNRlZVOGFJUmZBT3I3WkJHNGg2S1lwU2JWU0Jr?=
 =?utf-8?B?MHMvdUZBLzgzVmRJeG9rM2dDdTlIeE1kQVFFMEkwTFkyN0hzVFV6dk0xVFRC?=
 =?utf-8?B?dC9xUW10QjAzVXd5U0ptY3JLdDcyV2ZmcU84ei9VUGI5anJiZkFIQWN4cWxk?=
 =?utf-8?B?U1psak1JYXpNU3Qwem44cGN6UzdaMEE0WXNJNXJjREEzYWp6elhSelp4bWVH?=
 =?utf-8?B?Uk54clM0THc3YWxpSkxDNXpkYlBCSUVab3VzN3NKallJR1V3VFArWFVIaCtx?=
 =?utf-8?B?YU1XSjNrMGJrVDh4Z2VXdUxOVmtwUGF0bk9La01pY1VsTFZ5VGNDSXRVRmFJ?=
 =?utf-8?B?L2RFLzhPMTViMWZoSTZhYldmVXdOVjFpbVFpYmJJTWZhc2JnampCVk1IQmxt?=
 =?utf-8?B?MkwxNElpYW4xWFB0K21FeE44YWc2ODAzZnlwRWV0bSs4OG9Ya1R5Q1NmaTd5?=
 =?utf-8?B?V1NkOFUrYW9tWXZQL081VE1vMkJOZVk3ZENBdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEorNlB6VTV2L2R4WnpJSHJZN1c2YSthbEppTzF1MWpQZGxTc0VhNFBaVlFG?=
 =?utf-8?B?MVBsY0h5cSsyVVE1bFR5WllkcjBkc3NoaVU0djVIVk0yYmp5MnF5NWl5MWFQ?=
 =?utf-8?B?djZDVEd1SGtSdTliSmpVaDRYZ1NTcGM5eWJkd2JSQ082Vm9DblhYNDR4akIr?=
 =?utf-8?B?R0J4dXdad1B6dmwrYXdscjNFV1QrYVFyVCs5ZVhZZ0dYTjVHS0NKcFRDa2Vn?=
 =?utf-8?B?bGQrb1FKdkliUEpNNGd6SytoYkR6MDdOVGN4OW9zNmV2SUg5T0YrNXpESW5N?=
 =?utf-8?B?MmczVkE1anZyUEkrY2hnSDFudm4wWlBZOU14S003c0ZHL1RZU0Q2Yk9leGEz?=
 =?utf-8?B?VjRCaUpFVTNOYm9YK004MGdtYytML0N4MUFDWGozb0FQTmtKSzBQREgzWFFE?=
 =?utf-8?B?VjZpS0t1SnBTYzg3NTZpRm4yYXBMd0Y1MWp6MTNaNGt4M21XVTgwUGNVcTVH?=
 =?utf-8?B?NURxOHV6RmxUY3VoaVpZKzRtVmhsQmRoMzRRdHhaTklpYmsxWGwzYkJEZ25G?=
 =?utf-8?B?N0VGbzhnaGxEVzdDRzVISXJ4ZDk4U3Y5dlJlK1gxN0lLVlV3QmthR0pWRUJ6?=
 =?utf-8?B?dFRqWis5MWNreEdWcUo0dHhaMGZ0djFZU2RmU1QybjgrTW5PRWkxdXF3bmNq?=
 =?utf-8?B?Zm9nSGx5MEVaZWZKSjdkaEoxS1h1eHgwcm1UWGo1TUdaT2dKS1ppbS91N2l4?=
 =?utf-8?B?aVEzTUpiNlV0RnFvZXFIWjYwY3RwcVV4eHNRTmU1TDhjdjZjNnlraURyNG1n?=
 =?utf-8?B?cDlCTmJlUXVhRHcyUzVwMkoraDZTT2FsT3JIZGJhU0E4Rnh2TjBmZlk3cks0?=
 =?utf-8?B?SUFpS2VyU09iY1dibWZzOGdWNWU0VE1HS2w2dE5NUzhHRG5wWEYvc3lMU09q?=
 =?utf-8?B?dENEbGZjWDBSOVh2V05vQzE2c0h4djBSa25RWHlsQTVuU0wrNUE0Ti8xYnFu?=
 =?utf-8?B?dW1Rckc0TGF4dFNUaVVLaGpIcUZwYUthbElNbTZaR0xtd3Y4Y2VpcTB3VGdS?=
 =?utf-8?B?Z2Q4ODZXOEdoMEVVbnhaMzU4TlZ4MFVlL3h6cVdVYXlveVg5ZGlYMm1KcWRp?=
 =?utf-8?B?RGt6REhKMTdPNXNkUThTWDV0NkkveDRnRnY0aDZIMlhJSzJrTXFhL3VESllD?=
 =?utf-8?B?MjZIMGMrTjZXT2JvZ2Z5dVgvNjJFOFhWVmNGWGlFYmpXUHJiN0JIMkJ2UnEv?=
 =?utf-8?B?dm8rU3RqM3d2d2lUa0w0N1RlSTJpakszUFdzK09oenlwS3lrY3lLbmRmZTNn?=
 =?utf-8?B?eGZLWStFVEMrTmJrY3c4c3A3dGVCOHQ2d0c1b09SdVJZeGxqOFRSRTgxQit4?=
 =?utf-8?B?YWxYcmc2MlBsQkhXQnVsLzZVUjM1YzVkUnIwYlhrK3VXRGxxeis5NFp1Nng2?=
 =?utf-8?B?YkJWUENKQkoxaFNibEZyTHJqM2RDdVM5aGJRSHA4eXcrTXF6OE4vVnU4VWdJ?=
 =?utf-8?B?Rlh5aldoYjdOUFZyOWd4MDB6Vk9YZjBJZERoZG5tb2V5SGpCYlRGRUkzcHI2?=
 =?utf-8?B?dXUrTkZLbWthOHQ5NTQrY3pSYlI5bk1HSlZCcjVhdFEveHBuYkN1R1prSHlP?=
 =?utf-8?B?T3NiYllNUGhoMnpnL0d1cWdhZGpla2krdElJMDlmUi93UmRJZUdyZi9CbkxQ?=
 =?utf-8?B?UUt6N2Rwb0hCYnYzVExyMU9tL3Q0MlVPRmJYTDVjTU9uNmhIOTdUQXMvUGpM?=
 =?utf-8?B?U0g2ZURDSVdqcHJrWDYwcTFBczE1RFNLdlZIQkVZY1R4NGZyS05vUFE4ZlJ4?=
 =?utf-8?B?SDZrbHpWbEg2eXR0WTJmWDhFQWQwUGsvbTRjWWhzN1RNQnBMYmhZdHR0Q1ZI?=
 =?utf-8?B?d2hIa2MxSDNhWW5sL0R0U1FzbXd1N3dmcElYVFpnak56K3NIbUtydjYxeTlj?=
 =?utf-8?B?SzQ4amlHYnRLb3FCYjdaVCtsdmJNb3FQQmw3M0IvK0g2cGdkRlg2RDBjR0Yx?=
 =?utf-8?B?bEN0U0xLMi9UZ1k2S05PUzYxSmZlNDgvYk5RMXJzbXVGMDZmWjFjaGRLNmhG?=
 =?utf-8?B?ZkpmTW1zc0JUVjhSWXV4UnRuSXoweGRGTVgyejFyY1ZmOGVTdEJvZnBKZGx4?=
 =?utf-8?B?OVE5UWRwOTlBd05mc2s3NUJoVk5Nem5USmVpYkJSVkd1SFRiU1M4UURmMUFu?=
 =?utf-8?B?QXZpeEFwOVBETFE2OW1mT05HTU9DM1ZnSEc2TFl3WG1zNmN0RVEyWkVockJX?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6632a4e8-654e-45a8-3631-08ddfc424838
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 14:46:16.5921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoIoq0vScuhppJqZSiY4k67dXL6XDxSd86nFz/HCWAaysEVB8qea+NYngqfTG+S8EuWIa0e6y0sV2fvo1P3gBB4s8/7acucrE/B7qYbusEmh4smJ/8fh/Y2A5/sK2Ugx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7068

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMjUgMTI6NTIg
UE0NCj4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxs
LWxhYnMuY29tPjsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgbGludXgtZG9jQHZnZXIua2VybmVsLm9y
ZzsgY29yYmV0QGx3bi5uZXQ7IGhvcm1zQGtlcm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsg
a3VuaXl1QGFtYXpvbi5jb207IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGRhdmUudGFodEBnbWFpbC5jb207IGpoc0Btb2phdGF0dS5jb207IGt1YmFAa2VybmVs
Lm9yZzsgc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc7IHhpeW91Lndhbmdjb25nQGdtYWlsLmNv
bTsgamlyaUByZXNudWxsaS51czsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgYW5kcmV3K25ldGRldkBs
dW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgYXN0QGZpYmVyYnkubmV0OyBsaXVoYW5n
YmluQGdtYWlsLmNvbTsgc2h1YWhAa2VybmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2Vy
bmVsLm9yZzsgaWpAa2VybmVsLm9yZzsgbmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgU2No
ZXBwZXIgKE5va2lhKSA8a29lbi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53
aGl0ZUBjYWJsZWxhYnMuY29tOyBpbmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWly
amEua3VlaGxld2luZEBlcmljc3Nvbi5jb207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBn
bXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0LmNvbTsgdmlkaGlfZ29lbEBhcHBsZS5jb20N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiBuZXQtbmV4dCAxMy8xNF0gdGNwOiBhY2NlY246IHN0
b3Agc2VuZGluZyBBY2NFQ04gb3B0IHdoZW4gbG9zcyBBQ0sgdy8gb3B0aW9uDQo+IA0KPiANCj4g
Q0FVVElPTjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1
bCB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJM
IG5vay5pdC9leHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4gDQo+IE9u
IDkvMTgvMjUgNjoyMSBQTSwgY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIHdyb3Rl
Og0KPiA+IEZyb206IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJz
LmNvbT4NCj4gPg0KPiA+IERldGVjdCBzcHVyaW91cyByZXRyYW5zbWlzc2lvbiBvZiBhIHByZXZp
b3VzbHkgc2VudCBBQ0sgY2FycnlpbmcgdGhlIA0KPiA+IEFjY0VDTiBvcHRpb24gYWZ0ZXIgdGhl
IHNlY29uZCByZXRyYW5zbWlzc2lvbi4gU2luY2UgdGhpcyBtaWdodCBiZSANCj4gPiBjYXVzZWQg
YnkgdGhlIG1pZGRsZWJveCBkcm9wcGluZyBBQ0sgd2l0aCBvcHRpb25zIGl0IGRvZXMgbm90IA0K
PiA+IHJlY29nbml6ZSwgZGlzYWJsZSB0aGUgc2VuZGluZyBvZiB0aGUgQWNjRUNOIG9wdGlvbiBp
biBhbGwgc3Vic2VxdWVudCANCj4gPiBBQ0tzLiBUaGlzIHBhdGNoIGZvbGxvd3MgU2VjdGlvbiAz
LjIuMy4yLjIgb2YgQWNjRUNOIHNwZWMgKFJGQzk3NjgpLg0KPiANCj4gSXMgdGhpcyByZWFsbHkg
dXNlZnVsL3RyaWdnZXJzIGluIHByYWN0aWNlPw0KPiANCj4gQUZBSUNTIGl0IHdpbGwgdGFrZSBl
ZmZlY3Qgb25seSBpdCB0aGUgcmV0cmFuc21pc3Npb24gaGFwcGVucyBqdXN0IGFmdGVyIGFuIGVn
cmVzcyBBY2NFQ04gcGFja2V0LCBpLmUuIHdpbGwgbm90IHRyaWdnZXIgaWYgdGhlIHRoZXJlIGFy
ZSBtb3JlIGxhdGVyIG5vbiBBY2NFQ04gcGFja2V0cyBwZW5kaW5nLg0KDQpIaSBQYW9sbywNCg0K
VGhpcyBpcyBhIHNpbXBsaWVkIGltcGxlbWVudGF0aW9uIHRoYW4gd2hhdCBpcyBtZW50aWVvbmQg
aW4gdGhlIFJGQzk3Njg6IA0KIlN1Y2ggYSBob3N0IGRldGVjdCBsb3NzIG9mIEFDS3MgY2Fycnlp
bmcgdGhlIEFjY0VDTiBPcHRpb24gYnkgZGV0ZWN0aW5nIHdoZXRoZXIgdGhlIGFja25vd2xlZGdl
ZCBkYXRhIGFsd2F5c3JlYXBwZWFycyBhcyBhIHJldHJhbnNtaXNzaW9uLiBJbiBzdWNoIGNhc2Vz
LCB0aGUgaG9zdCBkaXNhYmxlIHRoZSBzZW5kaW5nIG9mIHRoZSBBY2NFQ04gT3B0aW9uIGZvciB0
aGlzIGhhbGYtY29ubmVjdGlvbi4iDQoNCg0KSG93ZXZlciwgdG8gaW1wbGVtZW50IHRoZSBjYXNl
IHRoYXQgbm90IHRoYXQganVzdCBhZnRlciBlZ3Jlc3NpbmcgdGhlIEFDSyB3aXRoIEFjY0VDTiwg
SSB3YXMgdGhpbmtpbmcgdG8gbW9kaWZ5IHN0cnVjdCB0Y3Bfc2Fja19ibG9jayBidXQgdGhhdCBt
YXliZSBhbiBvdmVyIGVuZ2luZWVyaW5nLg0KDQpBbmQgSU1PIHRoaXMgY291bGQgYmUgdXNlZnVs
IHdpdGggcHJvcGVyIGNvbmZpZ3VyYXRpb24gb24gc3lzY2VsIHRjcF9hY2NlY25fb3B0aW9uIGFu
ZCB0Y3BfZWNuX29wdGlvbl9iZWFjb24gdG8gc2VlIHdoZXRoZXIgdGhlIG1pZGRsZWJveCBpcyBk
cm9wcGluZyBhbGwgQUNLcyB3aXRoIEFjY0VDTiBvcHRpb24uDQpBbiBleGFtcGxlIHBhY2tldGRy
aWxsIGlzIGF0Og0KaHR0cHM6Ly9naXRodWIuY29tL21pbnVzY2F0L3BhY2tldGRyaWxsX2FjY2Vj
bi9ibG9iL21haW4vZ3Rlc3RzL25ldC90Y3AvYWNjZWNuL2ZhbGxiYWNrL2NsaWVudF9hY2NlY25f
b3B0aW9uc19kcm9wLnBrdA0KDQpXaGF0IGRvIHlvdSB0aGluaz8gQW5kIG1heWJlIEBtaXJqYS5r
dWVobGV3aW5kQGVyaWNzc29uLmNvbSBjb3VsZCBoZWxwIHRvIGNvbW1lbnQgZnJvbSBSRkMgcGVy
c3BlY3RpdmUuDQoNCkNoaWEtWXUNCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hpYS1ZdSBD
aGFuZyA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+IC0tLQ0KPiA+ICBp
bmNsdWRlL2xpbnV4L3RjcC5oICAgfCAzICsrLQ0KPiA+ICBpbmNsdWRlL25ldC90Y3BfZWNuLmgg
fCAxICsNCj4gPiAgbmV0L2lwdjQvdGNwX2lucHV0LmMgIHwgOSArKysrKysrKysNCj4gPiAgbmV0
L2lwdjQvdGNwX291dHB1dC5jIHwgMyArKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC90Y3AuaCBiL2luY2x1ZGUvbGludXgvdGNwLmggaW5kZXggDQo+ID4gNTNhNGEwZGEzNWNj
Li5mM2I3MmZiNmZhNzYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC90Y3AuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvbGludXgvdGNwLmgNCj4gPiBAQCAtMjk1LDcgKzI5NSw4IEBAIHN0cnVj
dCB0Y3Bfc29jayB7DQo+ID4gICAgICAgdTggICAgICBub25hZ2xlICAgICA6IDQsLyogRGlzYWJs
ZSBOYWdsZSBhbGdvcml0aG0/ICAgICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAgICByYXRl
X2FwcF9saW1pdGVkOjE7ICAvKiByYXRlX3tkZWxpdmVyZWQsaW50ZXJ2YWxfdXN9IGxpbWl0ZWQ/
ICovDQo+ID4gICAgICAgdTggICAgICByZWNlaXZlZF9jZV9wZW5kaW5nOjQsIC8qIE5vdCB5ZXQg
dHJhbnNtaXQgY250IG9mIHJlY2VpdmVkX2NlICovDQo+ID4gLSAgICAgICAgICAgICB1bnVzZWQy
OjQ7DQo+ID4gKyAgICAgICAgICAgICBhY2NlY25fb3B0X3NlbnQ6MSwvKiBTZW50IEFjY0VDTiBv
cHRpb24gaW4gcHJldmlvdXMgQUNLICovDQo+ID4gKyAgICAgICAgICAgICB1bnVzZWQyOjM7DQo+
ID4gICAgICAgdTggICAgICBhY2NlY25fbWlubGVuOjIsLyogTWluaW11bSBsZW5ndGggb2YgQWNj
RUNOIG9wdGlvbiBzZW50ICovDQo+ID4gICAgICAgICAgICAgICBlc3RfZWNuZmllbGQ6MiwvKiBF
Q04gZmllbGQgZm9yIEFjY0VDTiBkZWxpdmVyZWQgZXN0aW1hdGVzICovDQo+ID4gICAgICAgICAg
ICAgICBhY2NlY25fb3B0X2RlbWFuZDoyLC8qIERlbWFuZCBBY2NFQ04gb3B0aW9uIGZvciBuIG5l
eHQgDQo+ID4gQUNLcyAqLyBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvdGNwX2Vjbi5oIGIvaW5j
bHVkZS9uZXQvdGNwX2Vjbi5oIA0KPiA+IGluZGV4IDgzMTdjM2YyNzljOS4uM2ViNDUwYjRiNjQ4
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbmV0L3RjcF9lY24uaA0KPiA+ICsrKyBiL2luY2x1
ZGUvbmV0L3RjcF9lY24uaA0KPiA+IEBAIC00MDEsNiArNDAxLDcgQEAgc3RhdGljIGlubGluZSB2
b2lkIHRjcF9hY2NlY25faW5pdF9jb3VudGVycyhzdHJ1Y3QgdGNwX3NvY2sgKnRwKQ0KPiA+ICAg
ICAgIHRwLT5yZWNlaXZlZF9jZV9wZW5kaW5nID0gMDsNCj4gPiAgICAgICBfX3RjcF9hY2NlY25f
aW5pdF9ieXRlc19jb3VudGVycyh0cC0+cmVjZWl2ZWRfZWNuX2J5dGVzKTsNCj4gPiAgICAgICBf
X3RjcF9hY2NlY25faW5pdF9ieXRlc19jb3VudGVycyh0cC0+ZGVsaXZlcmVkX2Vjbl9ieXRlcyk7
DQo+ID4gKyAgICAgdHAtPmFjY2Vjbl9vcHRfc2VudCA9IDA7DQo+ID4gICAgICAgdHAtPmFjY2Vj
bl9taW5sZW4gPSAwOw0KPiA+ICAgICAgIHRwLT5hY2NlY25fb3B0X2RlbWFuZCA9IDA7DQo+ID4g
ICAgICAgdHAtPmVzdF9lY25maWVsZCA9IDA7DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9pcHY0L3Rj
cF9pbnB1dC5jIGIvbmV0L2lwdjQvdGNwX2lucHV0LmMgaW5kZXggDQo+ID4gZjI1MGI0OTEyYTBi
Li42MDgzMjYwMTMzZTkgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2lwdjQvdGNwX2lucHV0LmMNCj4g
PiArKysgYi9uZXQvaXB2NC90Y3BfaW5wdXQuYw0KPiA+IEBAIC00ODA0LDYgKzQ4MDQsNyBAQCBz
dGF0aWMgdm9pZCB0Y3BfZHNhY2tfZXh0ZW5kKHN0cnVjdCBzb2NrICpzaywgDQo+ID4gdTMyIHNl
cSwgdTMyIGVuZF9zZXEpDQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgdGNwX3Jjdl9zcHVyaW91c19y
ZXRyYW5zKHN0cnVjdCBzb2NrICpzaywgY29uc3Qgc3RydWN0IA0KPiA+IHNrX2J1ZmYgKnNrYikg
IHsNCj4gPiArICAgICBzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsNCj4gDQo+IE1p
bm9yIG5pdDogcGxlYXNlIGxlYXZlIGFuIGVtcHR5IGxpbmUgYWZ0ZXIgdmFyaWFibGUgZGVjbGFy
YXRpb24uDQo+IA0KPiAvUA0KDQo=

