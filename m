Return-Path: <linux-kselftest+bounces-37342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6D0B055E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 11:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3833D1AA4D44
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238632D4B6C;
	Tue, 15 Jul 2025 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="CVopkc32"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013031.outbound.protection.outlook.com [40.107.159.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629D1FBC8C;
	Tue, 15 Jul 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570499; cv=fail; b=m45VCRjvWw1/o7BWUk85er8+4EufTiHdeNlEQnq0Ufiioul7eFHRNY9D05FwhLKfeU+27vuidNn/nB5WFmunECokq5QmMEiNS2yAAS+7SNR8oQgmiWC4MqyF6wcg6OLTwVsMLtnk44XIO+XjyKOhdIzeJCiTaolVdIy+PUVNg/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570499; c=relaxed/simple;
	bh=fKvfwR99/ByPsNN4ij874hhQTqxtcnxbxdt/qOnQZRY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OS5h9gf7hkPK/xlRjD+yoTC+yTEEcIN8bGqy8n1WIFtKsD9aY17KVs3OClrnyRDWJzUYOW/fUWZs+FfxcWWwFZcUcZNAWgKjvYPzNEbxCaKSOg+OCfURyRQSTxDx9ij6LV9MzxBGv/9cu2lC0of5UjjRKUk3QSVVLWL2OH4KqzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=CVopkc32; arc=fail smtp.client-ip=40.107.159.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsgX8lw2TQqgYl9ebUd+MGQ6guL2ynFh4gfILlLSFAU/cZB2XzUl3ckykmCQNPn2K1mDuJxZtAr1ye6CUyHcDTjGGe+jickLvleb9zCIEblqFleV7GKVSDaDTLPsDabOlb6BXiCINwj/t7n+sdObfXDuurSw1ucpDQxCSwBvJ530Wm2dBqz6fXuh5wcUGxW03xyQbqF1n+O9Wp6fnAWSZINh7+aiMrqHKC5BYEKneH/1acD89VdU8zkz6PUYZ8EzrYr6rgdiJ33jEttlogiiee2Jm9VI+pLltTkD17vNGJ0sNoZO1JXp211DcpoHpyjAwDUucaQyF05mvSgR0qc0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKvfwR99/ByPsNN4ij874hhQTqxtcnxbxdt/qOnQZRY=;
 b=LRdQyNlfOAEPl61lvSfEiElmzN70y1EEToCYCYVqcDxUCXWK4NzgsXS+Xqc/D4n6laORiawUl17grBx8WBFrcmkN/8u3oTCpyLvf0PTNDVzYJNEH8OVbpeUH+7dO1DJ0LAfUWG1HcmJlP+HMnExwj6Z8oixiIz4ELEZbcCw0Mo3kpQLsjqHgfNGPLTRwbSXy60B+D6EC5VsGAqYhjt+rxrv5U5o43BTv7I5nbV2kpXqJ3WGAYmT1qDzl2nwceDlOIgQzW8FPkqEQRiGN19YjYXNQk4xPFpBSbO1yl9JsuFKXMNX6DjHGUuiDBKO7qWX87Pixr00fmthIFlFsqlE+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKvfwR99/ByPsNN4ij874hhQTqxtcnxbxdt/qOnQZRY=;
 b=CVopkc32tWJB/lM0e5OswdzwslaXvVQiq52XCO0e5f38Og0E8oFSZMuI36q5N78Wfn1pqEDe0ODsDbiAaFLx+BGqq1SZ5rdT+FmKnkmPTyMWUxERgYIdD3t5yFbOMEJ1+BWDwILweakCsw5xrmSN5OtFXt6p3gAvHpEyO8qR2r64ZBQOtT23tdf2glp+poxCGmH3QgKbLpbn+Ledbox+wDXND6aG7sxXTPnf2lPeiSvk5GRfN8fIvRwAhioOBQyZmFiLVW9vZlxMHbWaAiTGvMQQZ1IVTnTx0ZFubChhLrPolfHOp1dkIciGwAoC/2u+hS4L8rITPA1yPVzRqD8tMQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DBAPR07MB6984.eurprd07.prod.outlook.com (2603:10a6:10:17c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:08:12 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:08:12 +0000
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
Subject: RE: [PATCH v12 net-next 09/15] tcp: accecn: AccECN needs to know
 delivered bytes
Thread-Topic: [PATCH v12 net-next 09/15] tcp: accecn: AccECN needs to know
 delivered bytes
Thread-Index: AQHb7MFipACBkVXviUG/0wlsu3u5BLQxrlmAgAFEJ5A=
Date: Tue, 15 Jul 2025 09:08:12 +0000
Message-ID:
 <PAXPR07MB7984A9327EF12B0E011511CCA357A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-10-chia-yu.chang@nokia-bell-labs.com>
 <226c49dc-ee9c-4edb-9428-2b8b37f542fe@redhat.com>
In-Reply-To: <226c49dc-ee9c-4edb-9428-2b8b37f542fe@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DBAPR07MB6984:EE_
x-ms-office365-filtering-correlation-id: 293cea54-27e8-4edf-0128-08ddc37f2056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0dsMlNwK1dac1dqK2xwWTBoakw2cVFiSjMyZWUzNUh4L0ZzNVA1K09mNGhw?=
 =?utf-8?B?OG56VVhRTG80SytpZTZ0MTZuQ0k5NjFxeXg2QW1GMjg5VVViOGw3UFdFNTht?=
 =?utf-8?B?K244enVKN1JhTy9tSkVBWlR5NHVSaHNxeEhoZVg0UUdhNHBHelRiU1B6eXJR?=
 =?utf-8?B?azVDV0J5WHhWYzMreS9DY0hrbUJ6R05KRFRUVGhRN3VpLzdDbHlObDBUeDlx?=
 =?utf-8?B?emd4cWZiVjdqTy9UeUZrRXFacUdzMkNQMHYrVjR1Tjh0OSsxQUt0aDh5akFq?=
 =?utf-8?B?QlBwZWxLd3kzRUNkQWhPMTdzWDY2V0x3Q21iMVhpMExaTFJEVnppVitvV3pE?=
 =?utf-8?B?VExKcnZVc0lJL0o3cmduUWpyVk0xWTRPTmJ4M2NodlJEVWFsdWlLY2JQZ1FD?=
 =?utf-8?B?VVhoaFgxMFp0N0hCNG5Md1JKblVlazU4enB1NUhZdmVJeWQxVWJLd2NRVnVa?=
 =?utf-8?B?WDY5SVpyMDB6cFRDYVZaSjNXL2hTS2xMS2ZJUmRTQ3JDcVQxYi83bzVMTmtu?=
 =?utf-8?B?ZmtDN25BTWc2cHhIWWZhcFl6a0h0Z0lTQWY0MlRQckQyaCs4LzZRSGY4Rkxn?=
 =?utf-8?B?NmJveGY0SmgzcWVsTG00cytzQ2N5WFNmWmFSamZJbVU0QXJlVHJmcHFEMTRl?=
 =?utf-8?B?eXNtTmhmM3VBeFV5NzJyaXJuNXNRR09mMFRQa3JiYWwxc0hCMS8xM2Fua0Vu?=
 =?utf-8?B?Sit2UExmR1h4WmFzQmdWMXNCSGVsMTByTXQ1ZlNCbXRVby9rVkpUOFhLTUlX?=
 =?utf-8?B?RmZNbWFaY25rYTlycUVBUzVmbHU4dnkrVldlTEEwNlJFZkZzTkg1SlBwOTAw?=
 =?utf-8?B?dmhUY0tFbHJYSEF1ZjB3WUwyUk40aFNjeENKaytVNmZmMlVyZVN6azU1b1RP?=
 =?utf-8?B?WEVqTU9odU9XY1c1U3R5RHFjaDVzalJXRk9OMGthL3A2SjV6Z3ozSDQzcEt5?=
 =?utf-8?B?aWhOVDdqZTRqMFhHUHB4RTJWQURHV2NqSnYvMTY2NEZpb0pud0prU2R4VXlk?=
 =?utf-8?B?cm5aV3FOdHd2WWk1Um1FVmJtbFpXbitNQTRQNzJSSmgzWkkxdnRGWThqVWs0?=
 =?utf-8?B?bTdDdE41MGhJUzFxSHl4bTdoTk5yUGc3S0hmdit3WVg1NHd3WWlTNXB3ZkNM?=
 =?utf-8?B?N2pSTGU2U29hSGpjZkNjZFJqVm1PWFZaTUZUbm50cHEvS2VvREZTa2hwS1ZR?=
 =?utf-8?B?c0lNVHQ0SXU4ZG1FWldhcUhRWHhsSERDRlYwemFqN2lxcnlURHp2UlJwN2dh?=
 =?utf-8?B?RXBnN3FMeWJiaW1HbXhYK20wd2JXYnhZT0xvQ3huRXAvTEF1ZEMxTmFUS1Za?=
 =?utf-8?B?UXdnNm1MR0E4YUU3MGczMERWdWkyZUtQRE5EbGlRTzJhMW13MzFVdXVRZHpu?=
 =?utf-8?B?cGVVRkVIMDBuaGw5TVBwWUM5aTBWdm1mZHlVMWg4Rm5NZ2JVT3lyU1dYZlNK?=
 =?utf-8?B?L2tLdWlDS3pHSEh3S1FUT3JINHlmOXFzRGhXNFdQbjN3SWtWUEZrQXd6WWVV?=
 =?utf-8?B?R3QyQWdLVk5nVGdiekF0WUxDT1I2YVdSVDR1d1BqQ0krb2s5aXVDWU5HK0pX?=
 =?utf-8?B?d05oRHh6M0dqT09ZdWw3THZaSHB2Sm5YUjZ4VFMyM3lXRnRnWHUrRytHamxm?=
 =?utf-8?B?VzBzVm43MzR3NkZJNUhTUUlISGpZY21zVUwzT0ZhSDBESTQwa3Y4Z2wwWXB1?=
 =?utf-8?B?c0REMTRmZDhSS3JCb2x2MHl0U014VkRXR0hQclQvalc3YlhMZFhWTUJYRVo1?=
 =?utf-8?B?SFZTUG5mbjBaT3RBTW5aZ0V5NjVkaXNrV1UvTFpJNWFIMXFHZXgxaDNXMjhn?=
 =?utf-8?B?dkdMNEllc0xXUVhzU1MxK0tzZ2t0Z0M3QjlTckpZYkJhS0FDTFhNRkxVallZ?=
 =?utf-8?B?Wkl4ZEZMbmtaY0luS2xHMTYxd2V6NUR5eEhBVm5pTjNjdXdGTVg1bGtnN0xR?=
 =?utf-8?B?MUxCVy9jbjVmL2RQQWw0OFhWakVjam91d2VVYWQyQU1xa2dVNDNodGhIdzZv?=
 =?utf-8?Q?MHmUNW8cB3FHzJv06DN+3xsir6Vm/8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUNHYXo1ZnBNVjVVaUdlMkRvNFpra0dnUFdaYnR3WlFvK1RmQ1dOYk0yQ2dE?=
 =?utf-8?B?WWxVZmF3Uk41WEFTZndmVXVvZlp3VEV0VHd1RVE4OTN5ZXUzTElNalJnUzBJ?=
 =?utf-8?B?dFN4ZENiKzhVYWxHckJpL0V0S3p5TitGM01oZjhtbmRXSk1JNnZxbENWczdM?=
 =?utf-8?B?N1NOdkN0NGFrTHArVVpNVzJyUTRPZGlJZ0l2a2FydGh3MVJkcU8vcUQ5T00v?=
 =?utf-8?B?N25pSG53YjRrdGNMUTA5Y0wvR1FiSFBqanBaeGQ2a3YvSHRGYlRkdFYyQVRH?=
 =?utf-8?B?MnJmZTV1SDVLWTNDN0dxeVhLWG9LQXJnblYzWC94YXFTSjRQQVhHRUIvaHVr?=
 =?utf-8?B?eG0ybXU2aERvcEVHVXhWYWZYNUNlQ1Nsc3F3VjZ6RHVYQjZVVDN5alhIellM?=
 =?utf-8?B?L29yY0RJODZLY2pVNEk4MkRYbGhBclFmNnVEVVB3VHFBbW8yNFlFQ21TZVFY?=
 =?utf-8?B?SVZSZURqTktYOHBrNHQwUzYzRG14L3JzSk1qSmV5dlNpelRzd2NsRlgwOE8w?=
 =?utf-8?B?QkNjazlRNGl4ZG9QVWJacldDL0MwczRTMGlGNVUzU1oyQTAyNGxaVVY3N2RT?=
 =?utf-8?B?a3h3MFVadnlQUGpaS0wveGF6U1JFQnp4S2E3WXR3LzNCQUFMRU1wdnE4b1BG?=
 =?utf-8?B?eXAzVExzTlA1REJwNW15U0swZUNURjYzaURaWEJGK3hiTmNzMXhyL2YyNWRt?=
 =?utf-8?B?YUpwcGxlMTJjUzFNbkRTOWNISlhUa29qc3BEdlJ1L0Y2d2FCaDlKZktNSC9w?=
 =?utf-8?B?WEtDN2NGMUpjRDFyZEZDYTR4TlZQTmV3aFk4UXNHOGtURStOOEhPNjc3NDlx?=
 =?utf-8?B?V0ZnSmg3VWNac2RySjh0VzEyMnI5S3NsOWZKVk9qcVdiN2ZZVjdtVVlXZG5O?=
 =?utf-8?B?b0VXT01PRFJiMjJLOU5aUU4zVEhsZjBMOHRnTnVWOFNBSVozS25TSXlEcXR3?=
 =?utf-8?B?SzNScTZWazFqSE0zS3ExVTBReC9RcGRsaGVDUVpIOWEzVEZuTFlEMlo3ZEls?=
 =?utf-8?B?UUNEaXgxeWdtTkE3a21DU3B0U0RSYXRsRnZQZXBoR2VCL1p2R1B2TVZLZWU5?=
 =?utf-8?B?L3BabFVGTGVncTlXWG5pVFIybC8xZTczaExKZDl0UjJEeFhFcEV1S3BxZzQy?=
 =?utf-8?B?OHRzVUZsa1ZIT2xudllTWEZqL2xNdU56VzBpSENCMTlQcmk3c1JyaElObWxS?=
 =?utf-8?B?aFF4UEFNSTVuWlhzMDNEK2tib1Frby95RHljOXpHeTJYSk9FRkNUbzNiemNw?=
 =?utf-8?B?M3g5WXNXdlM1eERUeXkwazl6a3R5ZC9uTXUzU1VIVFhjMmpQSHVITllmQ0FV?=
 =?utf-8?B?dFNTRlZlaHRjMUhqYXBNV3ZpNTdBcXM3dGVpQTRoUVB4YVBRWk1QMUZpcnUv?=
 =?utf-8?B?Y3lUL0lWNEMwWSt1NUpYQnV6Si83WXlXWDl6Y1g1Rnh4enpscDhBc01OUEly?=
 =?utf-8?B?bm1KUUNRL202cFBtZXVELzJ0Lzc5ZHY3UFYxTFNhWkd4bVllbDVmbXNSS2Nt?=
 =?utf-8?B?cVMxOFlzQ3Q0clZnYjJaZjkrNHp0TjhIZjNGSzEraEM5SXY4Wi94cGFtNXBJ?=
 =?utf-8?B?NHN1aEdZNjBucWpLUXMwTEx2RW42dG9zc1lwSXRsVVA5Z0dPYy9aSUhVeVNG?=
 =?utf-8?B?SllCT3g5VzZPOEk0VFREU2d2bTN0cmplNEZobDVZV0lZRUN2UEVSWitEaE9m?=
 =?utf-8?B?UDFrRTBhTXN1Y3ZGNXNnSGp4dGY5SFQvNzluZDhjM004Z1pLZER3VlVPSm16?=
 =?utf-8?B?Y21IaGhFbVZzcm5MYURSNzBGVjRFTURMSkkreGswazFiTUU4M05lamlNSmlG?=
 =?utf-8?B?eGYrdGI4bnZFMUowNGg0b2VIQ1NaYldMcGp4RGhVaW95dlkyYTJmdDJiY1Jh?=
 =?utf-8?B?SDF2NW1aZVgwUjNwSDloNXV4Ukh2SEJLK1BOMjVaWDQwZ3AxS3hXVFRrNmtt?=
 =?utf-8?B?emwvUlVMUDJhZVFOM1NyS0pnT2ZuaitjeWplNFBsSmR0cjNpNlppZTBralFE?=
 =?utf-8?B?KzlUYkRKRnZTSWMvYzk5amVtaGZqdFExSStiNlJHZWRzeDJLNENBcmtZay9D?=
 =?utf-8?B?ZDJwdmhtU21mdElNOGgvNm5SS0NiRWVnTlUzTmplUHd5cUo3VVpsKzE0S2JH?=
 =?utf-8?B?UFdEdTRWaHh2KzNrK1A0eWs4UUkrZ29kbHlKN2FOYnM5alNUV1FuaFhSdXEv?=
 =?utf-8?Q?NGiVc2kEbooUo0kcjEyWvFY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 293cea54-27e8-4edf-0128-08ddc37f2056
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 09:08:12.6999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWPQoZqgJqF4PTI5fnXirQU939DnwI3bw+fzqDGAOeF2CYnH/dRf2Z1nIDm7bYZX9pMr34UeJerAHtDCh2cFvupfiU2LOKI2qP+xlBYfxdWEk6GkZ+Vg1a1uKqbZpE0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6984

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBNb25kYXksIEp1bHkgMTQsIDIwMjUgMzozNCBQTQ0KPiBU
bzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5j
b20+OyBlZHVtYXpldEBnb29nbGUuY29tOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBjb3Ji
ZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9yZzsgZHNhaGVybkBrZXJuZWwub3JnOyBrdW5peXVA
YW1hem9uLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
ZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1vamF0YXR1LmNvbTsga3ViYUBrZXJuZWwub3JnOyBz
dGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tOyBqaXJp
QHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7
IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmliZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21h
aWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3Jn
OyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxAZ29vZ2xlLmNvbTsgS29lbiBEZSBTY2hlcHBlciAo
Tm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNh
YmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVo
bGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29tOyBycy5pZXRmQGdteC5hdDsg
SmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2VsQGFwcGxlLmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxMiBuZXQtbmV4dCAwOS8xNV0gdGNwOiBhY2NlY246IEFjY0VDTiBu
ZWVkcyB0byBrbm93IGRlbGl2ZXJlZCBieXRlcw0KPiANCj4gDQo+IENBVVRJT046IFRoaXMgaXMg
YW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBs
aW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBh
ZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiA3LzQvMjUgMTA6NTMgQU0s
IGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0
IGEvbmV0L2lwdjQvdGNwX2lucHV0LmMgYi9uZXQvaXB2NC90Y3BfaW5wdXQuYyBpbmRleCANCj4g
PiBlZWE3OTAyOTVlNTQuLmY3ZDc2NDk2MTJhMiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvaXB2NC90
Y3BfaW5wdXQuYw0KPiA+ICsrKyBiL25ldC9pcHY0L3RjcF9pbnB1dC5jDQo+ID4gQEAgLTEwNTAs
NiArMTA1MCw3IEBAIHN0cnVjdCB0Y3Bfc2Fja3RhZ19zdGF0ZSB7DQo+ID4gICAgICAgdTY0ICAg
ICBsYXN0X3NhY2t0Ow0KPiA+ICAgICAgIHUzMiAgICAgcmVvcmQ7DQo+ID4gICAgICAgdTMyICAg
ICBzYWNrX2RlbGl2ZXJlZDsNCj4gPiArICAgICB1MzIgICAgIGRlbGl2ZXJlZF9ieXRlczsNCj4g
DQo+IEV4cGxpY2l0bHkgbWVudGlvbmluZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdGhhdCB0aGUg
YWJvdmUgZmlsbHMgYSA0IGJ5dGVzIGhvbGUgY291bGQgYmUgaGVscGZ1bCBmb3IgcmV2aWV3ZXJz
Lg0KPiANCkhpIFBhb2xvLA0KDQpKdXN0IHdhbnQgdG8gYXNrIHRvIGNsYXJpZnkgb24gInRoZSBh
Ym92ZSBmaWxscyBhIDQgYnl0ZXMgaG9sZSIuDQoNCk5vdyBJIHNlZSBpZiBJIG1vdmUgdGhlIGRl
bGl2ZXJlZF9ieXRlcyB0byB0aGUgZW5kIG9mIHRoaXMgc3RydWN0LCB0aGUgcGFob2xlIHJlc3Vs
dHMgb2YgQVJNMzIgYml0IGNvbXBpbGF0aW9uOg0KDQpbQkVGT1JFIFBBVENIXQ0Kc3RydWN0IHRj
cF9zYWNrdGFnX3N0YXRlIHsNCiAgICAgICAgdTY0ICAgICAgICAgICAgICAgICAgICAgICAgZmly
c3Rfc2Fja3Q7ICAgICAgICAgIC8qICAgICAwICAgICA4ICovDQogICAgICAgIHU2NCAgICAgICAg
ICAgICAgICAgICAgICAgIGxhc3Rfc2Fja3Q7ICAgICAgICAgICAvKiAgICAgOCAgICAgOCAqLw0K
ICAgICAgICB1MzIgICAgICAgICAgICAgICAgICAgICAgICByZW9yZDsgICAgICAgICAgICAgICAg
LyogICAgMTYgICAgIDQgKi8NCiAgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgc2Fj
a19kZWxpdmVyZWQ7ICAgICAgIC8qICAgIDIwICAgICA0ICovDQogICAgICAgIGludCAgICAgICAg
ICAgICAgICAgICAgICAgIGZsYWc7ICAgICAgICAgICAgICAgICAvKiAgICAyNCAgICAgNCAqLw0K
ICAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICAgICBtc3Nfbm93OyAgICAgICAgICAgICAg
LyogICAgMjggICAgIDQgKi8NCiAgICAgICAgc3RydWN0IHJhdGVfc2FtcGxlICogICAgICAgcmF0
ZTsgICAgICAgICAgICAgICAgIC8qICAgIDMyICAgICA0ICovDQoNCiAgICAgICAgLyogc2l6ZTog
NDAsIGNhY2hlbGluZXM6IDEsIG1lbWJlcnM6IDcgKi8NCiAgICAgICAgLyogcGFkZGluZzogNCAq
Lw0KICAgICAgICAvKiBsYXN0IGNhY2hlbGluZTogNDAgYnl0ZXMgKi8NCn07DQoNCltBRlRFUiBQ
QVRDSF0NCnN0cnVjdCB0Y3Bfc2Fja3RhZ19zdGF0ZSB7DQogICAgICAgIHU2NCAgICAgICAgICAg
ICAgICAgICAgICAgIGZpcnN0X3NhY2t0OyAgICAgICAgICAvKiAgICAgMCAgICAgOCAqLw0KICAg
ICAgICB1NjQgICAgICAgICAgICAgICAgICAgICAgICBsYXN0X3NhY2t0OyAgICAgICAgICAgLyog
ICAgIDggICAgIDggKi8NCiAgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgcmVvcmQ7
ICAgICAgICAgICAgICAgIC8qICAgIDE2ICAgICA0ICovDQogICAgICAgIHUzMiAgICAgICAgICAg
ICAgICAgICAgICAgIHNhY2tfZGVsaXZlcmVkOyAgICAgICAvKiAgICAyMCAgICAgNCAqLw0KICAg
ICAgICBpbnQgICAgICAgICAgICAgICAgICAgICAgICBmbGFnOyAgICAgICAgICAgICAgICAgLyog
ICAgMjQgICAgIDQgKi8NCiAgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgICAgbXNzX25v
dzsgICAgICAgICAgICAgIC8qICAgIDI4ICAgICA0ICovDQogICAgICAgIHN0cnVjdCByYXRlX3Nh
bXBsZSAqICAgICAgIHJhdGU7ICAgICAgICAgICAgICAgICAvKiAgICAzMiAgICAgNCAqLw0KICAg
ICAgICB1MzIgICAgICAgICAgICAgICAgICAgICAgICBkZWxpdmVyZWRfYnl0ZXM7ICAgICAgLyog
ICAgMzYgICAgIDQgKi8NCg0KICAgICAgICAvKiBzaXplOiA0MCwgY2FjaGVsaW5lczogMSwgbWVt
YmVyczogOCAqLw0KICAgICAgICAvKiBsYXN0IGNhY2hlbGluZTogNDAgYnl0ZXMgKi8NCn07DQoN
CkFuZCB0aGUgNjQgYml0IHJlc3VsdHMgYXJlOg0KW0JFRk9SRSBQQVRDSF0NCnN0cnVjdCB0Y3Bf
c2Fja3RhZ19zdGF0ZSB7DQogICAgICAgIHU2NCAgICAgICAgICAgICAgICAgICAgICAgIGZpcnN0
X3NhY2t0OyAgICAgICAgICAvKiAgICAgMCAgICAgOCAqLw0KICAgICAgICB1NjQgICAgICAgICAg
ICAgICAgICAgICAgICBsYXN0X3NhY2t0OyAgICAgICAgICAgLyogICAgIDggICAgIDggKi8NCiAg
ICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgcmVvcmQ7ICAgICAgICAgICAgICAgIC8q
ICAgIDE2ICAgICA0ICovDQogICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgICAgIHNhY2tf
ZGVsaXZlcmVkOyAgICAgICAvKiAgICAyMCAgICAgNCAqLw0KICAgICAgICBpbnQgICAgICAgICAg
ICAgICAgICAgICAgICBmbGFnOyAgICAgICAgICAgICAgICAgLyogICAgMjQgICAgIDQgKi8NCiAg
ICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgICAgbXNzX25vdzsgICAgICAgICAgICAgIC8q
ICAgIDI4ICAgICA0ICovDQogICAgICAgIHN0cnVjdCByYXRlX3NhbXBsZSAqICAgICAgIHJhdGU7
ICAgICAgICAgICAgICAgICAvKiAgICAzMiAgICAgOCAqLw0KDQogICAgICAgIC8qIHNpemU6IDQw
LCBjYWNoZWxpbmVzOiAxLCBtZW1iZXJzOiA3ICovDQogICAgICAgIC8qIGxhc3QgY2FjaGVsaW5l
OiA0MCBieXRlcyAqLw0KfTsNCg0KW0FGVEVSIFBBVENIXQ0Kc3RydWN0IHRjcF9zYWNrdGFnX3N0
YXRlIHsNCiAgICAgICAgdTY0ICAgICAgICAgICAgICAgICAgICAgICAgZmlyc3Rfc2Fja3Q7ICAg
ICAgICAgIC8qICAgICAwICAgICA4ICovDQogICAgICAgIHU2NCAgICAgICAgICAgICAgICAgICAg
ICAgIGxhc3Rfc2Fja3Q7ICAgICAgICAgICAvKiAgICAgOCAgICAgOCAqLw0KICAgICAgICB1MzIg
ICAgICAgICAgICAgICAgICAgICAgICByZW9yZDsgICAgICAgICAgICAgICAgLyogICAgMTYgICAg
IDQgKi8NCiAgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgc2Fja19kZWxpdmVyZWQ7
ICAgICAgIC8qICAgIDIwICAgICA0ICovDQogICAgICAgIGludCAgICAgICAgICAgICAgICAgICAg
ICAgIGZsYWc7ICAgICAgICAgICAgICAgICAvKiAgICAyNCAgICAgNCAqLw0KICAgICAgICB1bnNp
Z25lZCBpbnQgICAgICAgICAgICAgICBtc3Nfbm93OyAgICAgICAgICAgICAgLyogICAgMjggICAg
IDQgKi8NCiAgICAgICAgc3RydWN0IHJhdGVfc2FtcGxlICogICAgICAgcmF0ZTsgICAgICAgICAg
ICAgICAgIC8qICAgIDMyICAgICA4ICovDQogICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAg
ICAgIGRlbGl2ZXJlZF9ieXRlczsgICAgICAvKiAgICA0MCAgICAgNCAqLw0KDQogICAgICAgIC8q
IHNpemU6IDQ4LCBjYWNoZWxpbmVzOiAxLCBtZW1iZXJzOiA4ICovDQogICAgICAgIC8qIHBhZGRp
bmc6IDQgKi8NCiAgICAgICAgLyogbGFzdCBjYWNoZWxpbmU6IDQ4IGJ5dGVzICovDQp9Ow0KDQpJ
IHNlZSB0aGlzIHBhdGNoIGRvZXMgbm90IGNyZWF0ZSBhbnkgZXh0cmEgaG9sZSBhbmQgaXQgY2Fu
IHJldXNlIHRoZSBleGlzdGluZyBwYWRkaW5nIDQgQnl0ZXMgZm9yIEFSTTMyIGFyY2hpdGVjdHVy
ZS4NCg0KRG9lcyBpdCBtYXRjaCB3aGVuIHlvdSBtZW50aW9uZWQ/DQoNCkJScywNCkNoaWEtWXUN
Cg==

