Return-Path: <linux-kselftest+bounces-48955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D77AD201C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 17:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5B3930060E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C123195E8;
	Wed, 14 Jan 2026 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="P3BP0r2J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A721D585;
	Wed, 14 Jan 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407182; cv=fail; b=G7fZFOKTJHm1MOuEMAzsTfqpu0uqWUW6cqrc11mqcZZGY27pevJi64TMbkqK2lHG51+2lIkUaX4uDmMu+0HG6K4TNHZ6/vwVymNfxedmNPVeyOyRCCF8mJgxAh30pzUxDUhW+W0iSTBAGpRYDQ9Lupax1mDsnj8QG7E2KDCZ8UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407182; c=relaxed/simple;
	bh=gxQus86anp4NP0Z4H2L/VibXOB3V04O+qb6cOQF7rJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+9H+eIiT2RDOV1lC+413Z68a8Ire9Rh2SMSxk3+XSAnSqoR99Q0uG5vq20UmsgpqWekebb2FgViqHTTdTe5cjCk2L48JjVbVjJ87vm0TcJ9FpgGEP5ZtJnOLmyflTqoggr7DTw9EELA1/k2SvL1wrREVogWdfsdy8U7yLKu47k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=P3BP0r2J; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THBkMBqGpuVPJC5W4QKC7/HmiVq2K1kQTDYwsf551JUwh0kD/HPpj0HfC/B6qpeQ1xhkTAM7HOrJDzni1cEMAcB9FsNAhXaKGgynerW6ECYGrFUMNf/7ApmtrsrzYbfTw/TAZx/LKzg4vELJIGbEyiIY0fpfPxXHITD7dsVGixEavSCR0TFWCNOrBcPpcsp8P4tmbGQSfL+Kvm2/Ujnx166NMZdM/MRos2+Qp/q1vaurXVMdYl4Hv2+uUm52gyy2ADAH4xw8GcL1kES66/p9MQUwcXJRe/UoyWMN0sZACQm2PRDWmKcj18a3KdHVh7Pbmij2iwoD1I6kQ1nT43m5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxQus86anp4NP0Z4H2L/VibXOB3V04O+qb6cOQF7rJU=;
 b=akH2WxDD2uXmWQSb5l+WpldEe77izmlH8VkxQ5Z93vl672JcMKDCFymL5gLzLp0s8pYhZkQLKc+Cr4RTX0noNmYV8C1pA3CqmHRm1wb+mLUh+QhnQ+NY8RTYSLWz+08LYyGwIBqnGwhDFSP8c1ZRsPHfK3WgLWUe+hxYyNcnq1zqRPYIJ5H7lJS9DcVPOcucAYO+B3ek0ovn7hVnuf/szGMCD+Ufwt5rfwVmC4Q+vE5UPYErB8Wok9ToqCY5vK6iepirLAkI03b1TMDrWZ5MSOzLBXyW7BvKDrgslfm+sjQgk/TlQP1qeTBXEyfcggeVNcOyK6Tc0h8HbEKuG+0USQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxQus86anp4NP0Z4H2L/VibXOB3V04O+qb6cOQF7rJU=;
 b=P3BP0r2JPUw4ciXMFiY7ZBRegOyAom94QP4EGt/8znvAvXz8LYdEgmXF3giLI5oDdlf1DWopjTosQYFH+VFjD2Hq+ifQtUVKozmwwWFPFI6zGIoXPU8wbbJEUiZTohKuto/FqXpxFr1KtXYHtNVG9veKUeGtjtktFzrsYd2IFaJLJIwOtjcOso1N9+Tsf2BGnxA89nPBXO3fYtuXB/GGpODFw3lI7KUcrOtyONhRfnFcv3vS8Dh2PCE6ZgeC3yXOD+6MgALY+/IxaV0AbBIpcY1LzyXDo/QnSLui4OvC9kq5O1sckOLJ7/uEYoTpCy43mJXCxs6bKkzcaNnw42HHHQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7479.eurprd07.prod.outlook.com (2603:10a6:20b:2af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:12:56 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:12:56 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Neal Cardwell
	<ncardwell@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
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
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, "Koen De
 Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire
	<cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel
	<vidhi_goel@apple.com>, Willem de Bruijn <willemb@google.com>
Subject: RE: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill
 cases
Thread-Topic: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill
 cases
Thread-Index: AQHcgLegOXymg0Ec9k+0aqtx9yIf/LVI3+eAgAik+TCAADr7gIAAHCCQ
Date: Wed, 14 Jan 2026 16:12:56 +0000
Message-ID:
 <PAXPR07MB7984206EEC94880B5A7CC54AA38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
 <PAXPR07MB7984F8BDC1261BD144D20DCFA38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <willemdebruijn.kernel.a2eb52bfa5d5@gmail.com>
In-Reply-To: <willemdebruijn.kernel.a2eb52bfa5d5@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7479:EE_
x-ms-office365-filtering-correlation-id: d694f11c-57f2-4d8f-f43c-08de5387c7ac
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlpHR2h3MThJL3NlUnErZmZmQnM1R0dGcDg0TUhXc3N6ck54SXFKMTVTUW5n?=
 =?utf-8?B?TWVSVDFJZEIwa2RLRk5rL29wbExJMVprS0NJQXo2QU12R0s5YWtzbDcyK3dG?=
 =?utf-8?B?WkV6MGVVUVhFQ1pvcmhTa0t1aUNrZExHSFdJby9QNzRBVHdxUU9LR3k3anla?=
 =?utf-8?B?NW56SEtQMngvZG5LR2JvR3ZFRWFjS2gwT21JS1VwZ0J0K2hsQ2hQbXZBR0dv?=
 =?utf-8?B?T0pPNldETnBvaUdjamxuMEZDUGJMRnJYbjA4TTJPa09BdkMxY1VCNkpxWEhJ?=
 =?utf-8?B?TjBGbEM3M0Z2eVlKOWtaeEZ3c1ZKNVdpbGo3SUJoeDcxd2p6QUN1cEtubHpo?=
 =?utf-8?B?bk9qMVp0UEYrTVM1N21EcTJIcGYzTStNNEZlaTFQZVFmQzZQUytOVTR3enFl?=
 =?utf-8?B?Nm8vamc2M0Y0cnZER3R3Y2V2UkV5dmFzT3VtRzVveGFBcnNja0h6ZGpKU3Fl?=
 =?utf-8?B?RzJDU2ZGK3VpK2NmMXZUQmNJQ01vS29TVGZQQVh1SEZtVlB3WXNRZEZpelpT?=
 =?utf-8?B?ZUltelZLek5CaWlHNkMzbmtmZldERU9rRXkwWnY0QjBOdjdqOFJOLzJFWkxw?=
 =?utf-8?B?RTRaaHVZTUNtZVNxRVZBTUI3bG1VQXg0aURHcnJtWXJyd21aSlpJZTNlUk1x?=
 =?utf-8?B?N0ZYOGdRZUdrVVdQWG9TRUFNT3d1ZWcwcUZESWpkQmQxejNNK0s1L2wxb1Nr?=
 =?utf-8?B?MXllbHVxbG1SYmZOcG52V1F5MXJLaGxlOEkxaGZldUk1MkFLek5rRVo0R29R?=
 =?utf-8?B?ODhCUTUvYktDMnFOZWRWNWFCL0g3K1JUcTl2RGE3OG8yTWNRYmt3SkY4SFN4?=
 =?utf-8?B?d0pKVTY1QVh2UURjL2dFdEN4ZFh4SUYvQytLZm9UelFGcmVDOGdHSnRNQ2tu?=
 =?utf-8?B?ajZhZ0ZsTjBDbnl0TlBDSVU1ZzNldFo4a1dZbkdhWHhpLytaVytqWm03NVM3?=
 =?utf-8?B?VzBydVJyMzVNeTdSNFpmYmRlTjNGbXNxaVdKVE5EL05aZlpLK2pPV1FMbFQ3?=
 =?utf-8?B?ZlU5N1lYU0dYRlNJUlZXZzBLL0tRQnMzWGl4bkpESlNTVW9MWXE1dDhzOVQy?=
 =?utf-8?B?QmhuM1RIcTdQdXR5ZkQ1VUZ2RVpJRGtTMktTMVd5emRHWWpEZGtDWWY3MFo3?=
 =?utf-8?B?aWxSS1k5UXVNYy9nT0lQb0ExcFdGSEhrY2dwYzV6b3RKVUN5ajFkckRTbUY3?=
 =?utf-8?B?M3hDRXFDbTZwRGw0ZUZ1OVluS1Z6cWJpaFZoTkNETExHWmJwenVSOHlsTC9P?=
 =?utf-8?B?YnIvZzVCVnFLbjNuZ05aYlVVb1RDWWYrNkowNVVkRFFXcUg0c1dSWElTdkJX?=
 =?utf-8?B?N2lXR2FvdGk5TE9JQ3MwaEJBdVNvdU1aVWE3VjhZRWpNaW5nSEFObk5CVTNl?=
 =?utf-8?B?bFdNTVBjUW1DUVhzZFZUWWNveGRBMFYydGU0RStVOUpBTDlWeTlRNm1OaUZp?=
 =?utf-8?B?Nms3YUJ0MFRiY2ptVllVNGwzVU44T1lIcnJzb0FrSlZLZ0p4c3E1dkhnOGJi?=
 =?utf-8?B?R2plM2FkamlDaHRua2ZacXRHdkkwbjU0MkpFT1FKaDErcGhyMVUzOE5BYkxO?=
 =?utf-8?B?OHdxUnpTY2I3dzRUTzdUVW5OOSs5YnZXZzF0WCtJOXBDamtwdTJEbXhCbE11?=
 =?utf-8?B?YkRKSFMvSWlWcTVRS1FNaGMwTmh3Q2lLWHdZaG1vSG9mOFpWSlpNM2tTUnVV?=
 =?utf-8?B?ZFV2SXc0ajAranVKNWYvZ0lpWmNESllvNmsrZzdsZ0tZeXVpZllJbFQ5eDZP?=
 =?utf-8?B?amNkWTlPL0lld2c4YS9vWUJUQ0tyVXJ6Y2NPRnUrOS9EQVZMcGJHYjRTRUNC?=
 =?utf-8?B?MlRGQW5nc08zTnJhWDEzRU0ySnVDbE5QTWFoU1MvVlRxc0NuTU5VWnhiNENy?=
 =?utf-8?B?WGMzSWdzZ2FPVk1NY0lTQ0hhS1hLb2dVbk5NMU4wV1VyRStOQ3FFWXhHVERX?=
 =?utf-8?B?REtyNU5ZQVNleS9hNDB6TDNibytGUVZkczlna1lwVmpDRTd2bU9oeS9TamU3?=
 =?utf-8?B?M21pamRSdVRESm1ONDVTejZ1a2ZoMkRxZHkvclhjSUtLMlpiQTRpSjVnMndp?=
 =?utf-8?B?aGNrSk9DbHk5bmxoWFBWYTR0c3VGb2tsRXFPNG9yQlNxS3ZnY3o3aUZqYWNs?=
 =?utf-8?B?Zi9CbFpNQmMwOS9aaGZwRWhsM2YvVDVIR2lkSDNHZzdIYTNYVk14SkJnTS9q?=
 =?utf-8?Q?K/+OtP60qHaz2BBWL/Y6dXw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VktMRmdsaGFPUHNCNzF1bTlyNFpjMklGVEk0QVBHVmxYWTFUcFh0ZCtvYmVl?=
 =?utf-8?B?ZjFocEdmNVlVVWdNQlAxNlRrRjJ1YzBFa1BwSkJHOHlDbkpsRGJCcjBYT3Zo?=
 =?utf-8?B?M3JWc0QzaHYrcVg0MVk1bFgrdGx6dVMxYUt2U0VIelNzb0ZkUGNOOG51Qzc0?=
 =?utf-8?B?YmpnRE04V09iaGhJSUo0cVFpR2hmK0RJSXZlNmhFTlRrL0x2ZitmVFFzTkJX?=
 =?utf-8?B?SENlQkN1ekl1OGR5VWNCVWRGWjZWV2JhblU2ZWswK2VXa2g5WVRaS2I4ZGhX?=
 =?utf-8?B?ZmNsT0xkNVVGZWpUQXQ2WGlvMkJIbVk4M1p3dmZsNjVVaU5uZlF3OW1GRmM3?=
 =?utf-8?B?dEFjamdLYVRGSDV4aGtVNkFBS2tnb3RlekVwZS9OLzJJb2hSUVFxeWdmSFNP?=
 =?utf-8?B?SmVGVnBRL3QwZllJc0hiaFhKSDBVV3lZaDIwWnE5THBoa3RqaUpYY21mZ3FN?=
 =?utf-8?B?NUpXbjV0elhVWlQrdGNVZzJIcmxZbXJiMWJQTkZsZlN0TUFwRjZTandvUnh2?=
 =?utf-8?B?aXpiOGtReVV1VDVmalhqL0IxUTQzRUx3NzdZL3JIMEoyTk9NRUhZbm12YXhW?=
 =?utf-8?B?emxwMnpFWWFwdmlJUlBIRGE1aDR3TU1WVUo0U2tRZ0VzMGpjRzg2Z2ZtNWhU?=
 =?utf-8?B?cGZHU0VUNWduaU1ydnkxNkZYRnNSRjZtYzEwZDZqYzFpQXJ1d0FvZ0NiU1FN?=
 =?utf-8?B?L2xNNHRFbTFjTEkrMmgzYWNJSGlYbnFBZFJxTGJpbEhUTzZsZkJXTExlZ0dB?=
 =?utf-8?B?K3RocGJyeGFtOW5jSFdLYjJzUTdJWVhnUE8zRnlBeHZEZUVRVlB2K1lvK0F1?=
 =?utf-8?B?MjVwbmV0cU56Y21Ld3htL2JGalo3d0xJelJ4RnE1M1AyeGN2bnBSbmR3cGN0?=
 =?utf-8?B?QXJOSTIxR3VFeUNRVWcrcXY3Z2Npb2FMNFpBU01yNVVzemRBSnhSRXhZVXRR?=
 =?utf-8?B?N0lUVitlVUNkSTZhMUhMelFpQVlRTEtXY3R0cnZoWGxiWGhSZDE3ZW53R21t?=
 =?utf-8?B?S25GdWdITUlJdXRWSFhGREhmdHN0Wmw2UTJPTGM0ZkJiVWhDSy9BU253clRV?=
 =?utf-8?B?am9SWlV2NitrUXlSRTRENUYyWUhKWHdKWXNnOEJCa1Y2cHdHcFlGZEpTbjZZ?=
 =?utf-8?B?L1F0bHZJdWRRNXQvaDZkSm5hVXRKNEpGaXRzWTgzbEVwVytSY0plcEhJbUFl?=
 =?utf-8?B?VGd1ZXFud2JnMEF1TERnaXVncDBlU0RFTzI2Q09CYlVyZFJrejY4ZDRMSytG?=
 =?utf-8?B?bjZDY0FPcXN6bVZiOUNBUEpGQVVkaFd1aEkyb3o2amNTb3l6QWI1aW4wUksw?=
 =?utf-8?B?dUhhTkt0QmtOZVlhZDVCR1IzcUt4YmVkWGdtVG40Uno1T1NwL3Z2Q3dPRFZF?=
 =?utf-8?B?K3BWTE91TlFka0Q5Q0lGMVdxV3FqZ3dVK0Z4RzhrNEZRR3ZoeUQra1BwK3lp?=
 =?utf-8?B?SktkQ0FSV0FpQ3FObDA0MUtadUppRTZKUHpEZlA1aGxVNStQbVQ1Q2FXL0xp?=
 =?utf-8?B?YXBLaFBzTW9YWTRrbTNicHVRL1liNW5Vc0tpZURmQ3VqS2g2ZW1Ba0FXa3J6?=
 =?utf-8?B?cGQ5RExxRGVkejlDSHhubTVkenc4d3A0Z2JjdmhFRW1qRkRZMGhSRHRibGFx?=
 =?utf-8?B?STJkWGQwQmIvSGJhVWtzUW16RXZlUDlFci9UWW96YXJ3OVdSZzZSWTdaRFlz?=
 =?utf-8?B?a1pUWmVNdFFRdlVxVEFtMEk3WVU3U1lPVEVNNmJUbWlXdHlwL2QrWGJrQUdI?=
 =?utf-8?B?L3VRcGpIcnRiSEZZZUhQTTA2TWRCWHJLUzRkblBCei9sLy9NZE5CTmZXLzdk?=
 =?utf-8?B?WWRQTmVKYVhtZ0F2V0FyanJhSXc0WHljMDZsMVYwQmJuK2hDcENuUEpNR0wy?=
 =?utf-8?B?bnkyQmdCK0tMS2Y4T3BWNzJ0OGsxbVVsR3RIbm9vdFlIamFzVmlzdUVYaU9U?=
 =?utf-8?B?MUJldnRGYktFZUloUjRHRXRXYW1NdGdaa0oyTlZUM2pUU0RRRVBDcmVVdFZ5?=
 =?utf-8?B?RmRNcm5CWVRnVDlIUUk1S0NodUYwaVJjTUtyNWZxUW4wS2NMQzdYbnJaSnFL?=
 =?utf-8?B?b3AyTnkrRVo5VWNBa2poUmdBT2lnR0NIQWxWRGVaTlBQZEt3RzVjNEtpZDFL?=
 =?utf-8?B?OVFUNjNnTmVKTXFtU0dkS3lWY1huVmh6NnVTMmZUVWdUY3NtY0t1aHVhcmNq?=
 =?utf-8?B?WFl3UXNZeHhwdFg0QzdPZ3NHK2grbEw1VUIycUhkdi9WMlZUKzIwSkhocFp2?=
 =?utf-8?B?TFk0eEM0dWxXRE5sOGVhRDlrU0xweWRrMVpIdUxQSU1xbU4vdUNQaEtlR2tT?=
 =?utf-8?B?LzV5RG13S2dhS1dncEUvbHI3SVArcnhnbEVZWFNRYTNJMU1LVXE0L3ZRQkJq?=
 =?utf-8?Q?YQermrKfNz6Ibzb0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d694f11c-57f2-4d8f-f43c-08de5387c7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 16:12:56.8560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+GsiTJWu4pXfZc9cla3m1t2ucZGDhDJYvsGGhH2e6GfUsuQM4A/3HsTtwtPhfZhocpMiMcNFI7k4XKv9Y7kflj+ndMquHlqe71TzP7YKv5fhIBIxmLS4E8IBOYvwUf4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7479

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXaWxsZW0gZGUgQnJ1aWpuIDx3
aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVh
cnkgMTQsIDIwMjYgMzoxOCBQTQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1
LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+OyBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29v
Z2xlLmNvbT4NCj4gQ2M6IHBhYmVuaUByZWRoYXQuY29tOyBlZHVtYXpldEBnb29nbGUuY29tOyBw
YXJhdkBudmlkaWEuY29tOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5l
dDsgaG9ybXNAa2VybmVsLm9yZzsgZHNhaGVybkBrZXJuZWwub3JnOyBrdW5peXVAZ29vZ2xlLmNv
bTsgYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0
QGdtYWlsLmNvbTsgamhzQG1vamF0YXR1LmNvbTsga3ViYUBrZXJuZWwub3JnOyBzdGVwaGVuQG5l
dHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tOyBqaXJpQHJlc251bGxp
LnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5o
dW50ZXJAZ21haWwuY29tOyBhc3RAZmliZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29tOyBz
aHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBpakBrZXJu
ZWwub3JnOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEt
YmVsbC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgaW5nZW1hci5zLmpvaGFuc3Nv
bkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZSA8
Y2hlc2hpcmVAYXBwbGUuY29tPjsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21j
YXN0LmNvbTsgVmlkaGkgR29lbCA8dmlkaGlfZ29lbEBhcHBsZS5jb20+OyBXaWxsZW0gZGUgQnJ1
aWpuIDx3aWxsZW1iQGdvb2dsZS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggbmV0LW5leHQg
MS8xXSBzZWxmdGVzdHMvbmV0OiBBZGQgcGFja2V0ZHJpbGwgcGFja2V0ZHJpbGwgY2FzZXMNCj4N
Cj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB3aWxsZW1kZWJydWlqbi5rZXJuZWxA
Z21haWwuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMv
TGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gQ0FVVElPTjogVGhpcyBpcyBh
biBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxp
bmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQgZm9yIGFk
ZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+DQo+DQo+DQo+IENoaWEtWXUgQ2hhbmcgKE5va2lhKSB3
cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBOZWFs
IENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBK
YW51YXJ5IDgsIDIwMjYgMTE6NDcgUE0NCj4gPiA+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkg
PGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gPiA+IENjOiBwYWJlbmlAcmVk
aGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFyYXZAbnZpZGlhLmNvbTsNCj4gPiA+IGxp
bnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3Jn
Ow0KPiA+ID4gZHNhaGVybkBrZXJuZWwub3JnOyBrdW5peXVAZ29vZ2xlLmNvbTsgYnBmQHZnZXIu
a2VybmVsLm9yZzsNCj4gPiA+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmUudGFodEBnbWFp
bC5jb207IGpoc0Btb2phdGF0dS5jb207DQo+ID4gPiBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5A
bmV0d29ya3BsdW1iZXIub3JnOw0KPiA+ID4geGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tOyBqaXJp
QHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiA+ID4gYW5kcmV3K25ldGRldkBs
dW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgYXN0QGZpYmVyYnkubmV0Ow0KPiA+ID4g
bGl1aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rc2Vs
ZnRlc3RAdmdlci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBLb2VuIERlIFNjaGVwcGVyDQo+
ID4gPiAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+Ow0KPiA+
ID4gZy53aGl0ZUBjYWJsZWxhYnMuY29tOyBpbmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNv
bTsNCj4gPiA+IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZSA8Y2hlc2hp
cmVAYXBwbGUuY29tPjsNCj4gPiA+IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29t
Y2FzdC5jb207IFZpZGhpIEdvZWwNCj4gPiA+IDx2aWRoaV9nb2VsQGFwcGxlLmNvbT47IFdpbGxl
bSBkZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggbmV0LW5leHQgMS8xXSBzZWxmdGVzdHMvbmV0OiBBZGQgcGFja2V0ZHJpbGwNCj4gPiA+IHBh
Y2tldGRyaWxsIGNhc2VzDQo+ID4gPg0KPiA+ID4NCj4gPiA+IENBVVRJT046IFRoaXMgaXMgYW4g
ZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5r
cyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBhZGRp
dGlvbmFsIGluZm9ybWF0aW9uLg0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gVGh1LCBK
YW4gOCwgMjAyNiBhdCAxMDo1OOKAr0FNIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5j
b20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1
LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IExpbnV4IEFjY3Vy
YXRlIEVDTiB0ZXN0IHNldHMgdXNpbmcgQUNFIGNvdW50ZXJzIGFuZCBBY2NFQ04gb3B0aW9ucw0K
PiA+ID4gPiB0byBjb3ZlciBzZXZlcmFsIHNjZW5hcmlvczogQ29ubmVjdGlvbiB0ZWFyZG93biwg
ZGlmZmVyZW50IEFDSw0KPiA+ID4gPiBjb25kaXRpb25zLCBjb3VudGVyIHdyYXBwaW5nLCBTQUNL
IHNwYWNlIGdyYWJiaW5nLCBmYWxsYmFjaw0KPiA+ID4gPiBzY2hlbWVzLCBuZWdvdGlhdGlvbiBy
ZXRyYW5zbWlzc2lvbi9yZW9yZGVyL2xvc3MsIEFjY0VDTiBvcHRpb24NCj4gPiA+ID4gZHJvcC9s
b3NzLCBkaWZmZXJlbnQgaGFuZHNoYWtlIHJlZmxlY3RvcnMsIGRhdGEgd2l0aCBtYXJraW5nLCBh
bmQgZGlmZmVyZW50IHN5c2N0bCB2YWx1ZXMuDQo+ID4gPiA+DQo+ID4gPiA+IENvLWRldmVsb3Bl
ZC1ieTogSWxwbyBKw6RydmluZW4gPGlqQGtlcm5lbC5vcmc+DQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwub3JnPg0KPiA+ID4gPiBDby1kZXZlbG9wZWQt
Ynk6IE5lYWwgQ2FyZHdlbGwgPG5jYXJkd2VsbEBnb29nbGUuY29tPg0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4NCj4gPiA+ID4gLS0t
DQo+ID4gPg0KPiA+ID4gQ2hpYS1ZdSwgdGhhbmsgeW91IGZvciBwb3N0aW5nIHRoZSBwYWNrZXRk
cmlsbCB0ZXN0cy4NCj4gPiA+DQo+ID4gPiBBIGNvdXBsZSB0aG91Z2h0czoNCj4gPiA+DQo+ID4g
PiAoMSkgVGhlc2UgdGVzdHMgYXJlIHVzaW5nIHRoZSBleHBlcmltZW50YWwgQWNjRUNOIHBhY2tl
dGRyaWxsIHN1cHBvcnQgdGhhdCBpcyBub3QgaW4gbWFpbmxpbmUgcGFja2V0ZHJpbGwgeWV0LiBD
YW4geW91IHBsZWFzZSBzaGFyZSB0aGUgZ2l0aHViIFVSTCBmb3IgdGhlIHZlcnNpb24gb2YgcGFj
a2V0ZHJpbGwgeW91IHVzZWQ/IEkgd2lsbCB3b3JrIG9uIG1lcmdpbmcgdGhlIGFwcHJvcHJpYXRl
IGV4cGVyaW1lbnRhbCBBY2NFQ04gcGFja2V0ZHJpbGwgc3VwcG9ydCBpbnRvIHRoZSBHb29nbGUg
cGFja2V0ZHJpbGwgbWFpbmxpbmUgYnJhbmNoLg0KPiA+ID4NCj4gPiA+ICgyKSBUaGUgbGFzdCBJ
IGhlYXJkLCB0aGUgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3BhY2tldGRyaWxsLw0KPiA+
ID4gaW5mcmFzdHJ1Y3R1cmUgZG9lcyBub3QgcnVuIHRlc3RzIGluIHN1YmRpcmVjdG9yaWVzIG9m
IHRoYXQgcGFja2V0ZHJpbGwvIGRpcmVjdG9yeSwgYW5kIHRoYXQgaXMgd2h5IGFsbCB0aGUgdGVz
dHMgaW4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3BhY2tldGRyaWxsLyBhcmUgaW4gYSBz
aW5nbGUgZGlyZWN0b3J5Lg0KPiA+ID4gV2hlbiB5b3UgcnVuIHRoZXNlIHRlc3RzLCBkbyBhbGwg
dGhlIHRlc3RzIGFjdHVhbGx5IGdldCBydW4/IEp1c3QNCj4gPiA+IHdhbnRlZCB0byBjaGVjayB0
aGlzLiA6LSkNCj4gPiA+DQo+ID4gPiBUaGFua3MhDQo+ID4gPiBuZWFsDQo+ID4NCj4gPiBIaSBO
ZWFsLA0KPiA+DQo+ID4gUmVnYXJkcyAoMiksIEkgd2lsbCBwdXQgYWxsIEFDQ0VDTiBjYXNlcyBp
biB0aGUNCj4gPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvDQo+ID4g
QnV0IEkgd291bGQgbGlrZSB0byBpbmNsdWRlIGFub3RoZXIgc2NyaXB0IHRvIGF2b2lkIHJ1bm5p
bmcgdGhlc2UgQWNjRUNOIHRlc3RzIG9uZS1ieS1vbmUgbWFudWFsbHksIGRvZXMgaXQgbWFrZSBz
ZW5zZSB0byB5b3U/DQo+ID4gVGhhbmtzLg0KPg0KPiBBbGwgc2NyaXB0cyB1bmRlciB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcGFja2V0ZHJpbGwgYXJlIGFscmVhZHkgcGlja2VkIHVwIGZv
ciBhdXRvbWF0ZWQgdGVzdGluZyBpbiBrc2VsZnRlc3RzOg0KPg0KPiBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0LW5leHQuZ2l0L2NvbW1p
dC8/aWQ9OGE0MDU1NTJmZDNiDQoNCk9LLCBJIHdhcyB1c2luZyBrc2Z0X3J1bm5lci5zaCB0byBy
dW4gYWxsIDU4IEFjY0VDTiBjYXNlIG9uZS1ieS1vbmUuDQoNCkJ1dCBzaW5jZSBydW5fa3NlbGZ0
ZXN0LnNoIGNhbiBhY2NlcHQgbXVsdGlwbGUgIi10IiBhcmd1bWVudHMsIHNvIEkgd2lsbCBub3Qg
Y29tbWl0IGFub3RoZXIgc2NyaXB0IHdpdGggc2ltaWxhciBmdW5jdGlvbmxhaXRpZXMgYnV0IGp1
c3QgcmVuYW1lIGFsbCBBY2NFQ04gY2FzZSB3aXRoIHRjcF9hY2NlY24gaW4gdGhlIHByZWZpeC4N
Cg0KVGhhbmtzLg0KDQpDaGlhLVl1DQo=

