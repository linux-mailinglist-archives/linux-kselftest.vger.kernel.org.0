Return-Path: <linux-kselftest+bounces-32443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E122CAA9E6A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 23:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0946C3A5434
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 21:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017B2741C7;
	Mon,  5 May 2025 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dyMfbJYA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79D5680;
	Mon,  5 May 2025 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746481995; cv=fail; b=tf+w9m3HIVzu9m1kz4Qhskr70QZEil9TG5EHykZO8DTsuGDgDvBJSkBbFgoRmyUTx6gCjQkohyJKiSoz/K9icvYl+XdkJGqHavYz+pe5DyRYnPlVSMBCIYS3cZaGqmh3MAk5BMnQTwU39cSvecrJ4SPPr0+LFjEDRnu53LyXQ0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746481995; c=relaxed/simple;
	bh=j32IhlDdzhhDFkZS5K+CgUUpyqZyq9G/oUpqjtSktXM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IA8snNJHJFNARwk/eqodgWIzGOWvQfcDN1FPgdO5STPtTNRXQflugxVsbEnIlGXgDVJE4zti25wVOGgFVTcSr3b8pi6d6lM7yxTN/GbNoOd7VCHiqAgbBsRdf8UCY8ZO2HSLBnA70NOZqi20N1kFpbzN9dEsT8fRhvGY95wzz6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dyMfbJYA; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKHo2OMBt4zmFzKPk10ArjSnL6d9ej754UvtTp1wG9LZTBzjTjVczSe1ok6WauHGPhgSeBXsJlmr05sw0VrQnleMOL2j3uRON9yiLjG9BmnHJmR635JHdWO69IAvNreMuA0rNm7AgIcn1pXcLAWsOdnMuUX9SRsf+cAxQb3FtRSyrCvoYcxEIt1i1rBYGxpn6yv9dixFN0OJhsq9/eSm0o0WrVuEKGAVtSd4YCEeHXHtFokL0o2MBnxptgnOlo0UffNReQ4ZE017+e0yz1s1F15JMP/6cLlf33dRE5DVKWXDZX1M4pjcdRfUC8Se3XNdc5ciyWHlnFlQJSoHwxqZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j32IhlDdzhhDFkZS5K+CgUUpyqZyq9G/oUpqjtSktXM=;
 b=BUAmvRnvZA3RCRvGU45PNWikcmSz2op8JToyW5PnPPn+GNmcYImGSYQtvHW4dfIFrlpxpk1DdTSojQsSSpRfbMN/SRirL81oAyt2Z7RhkjYTA6fWAOYSmj5e4qcEO+C2VZSbrR1BxlQDpSng8ajt3MCyWHcR3h9LV498u/ke3HzUr1WmsFi5NQOf0y2C2zifz0KwJFLKUaIymasqQATcyL3sgUxKCoOP9FWffkZHBda0bw0uZLqy9kMewlRrz+hPA3TXIpNdgwX0bmufMylM/FoaaVZtQWPkYADMLPu8bDcI2BLx1hlVx8n6nBicJ31hF18q0PgFFFnxwJlt19Hejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j32IhlDdzhhDFkZS5K+CgUUpyqZyq9G/oUpqjtSktXM=;
 b=dyMfbJYAVo0mTymOC58O36m3KsCqrtQx/c4CLGqsnRT9Sw9nn+f7cnOY6CBzc3lZ/hInS3HhCxYImfdV6Ovg47E/0py3jejWrtyuD0yYr4kdrv6wme69W+aUWbJSyuu2VXa4CQqzMSwQfA7ko7B/8SbQhxctlfnA3g2iT8TjGjGdUDh0i8aeeVp3ZdKpemuQhwnAFlG4BgyqCBJobZNoyWqKfC5bHfHYVRj0As+8mcV8lLd/9yEeDig5wsGaedAtbZAmw3vAnBDNJfvsav4Gt0TDrHqjQz385BogcDJNinndPZyIZBT+k67SFdo15Vz8bOac29O+Qj6evomGs9DYUg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PR3PR07MB8244.eurprd07.prod.outlook.com (2603:10a6:102:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 21:53:09 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 21:53:09 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net"
	<ast@fiberby.net>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v5 net-next 10/15] tcp: accecn: AccECN option send control
Thread-Topic: [PATCH v5 net-next 10/15] tcp: accecn: AccECN option send
 control
Thread-Index: AQHbs5yhYBNq0obf+kSooJOXCggc+7O6mBIAgAoPfkA=
Date: Mon, 5 May 2025 21:53:09 +0000
Message-ID:
 <PAXPR07MB79845AAB1468B67FE9BD2EDCA38E2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-11-chia-yu.chang@nokia-bell-labs.com>
 <0a5c7897-ed95-4198-9896-ddae64335083@redhat.com>
In-Reply-To: <0a5c7897-ed95-4198-9896-ddae64335083@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PR3PR07MB8244:EE_
x-ms-office365-filtering-correlation-id: 82b89f8b-ce24-4231-953c-08dd8c1f39a3
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2hNYnZyUG1tUUw1QTN1aTVKdjg2cGE4KzFRRUU3MEZ2M2ZDdjdXUnBOS1Jy?=
 =?utf-8?B?elpJR0I5aFFSekZsWmFtT0dxTk9IS29IKzF6aEtHanVub0ZBb0lpNWhrYk4w?=
 =?utf-8?B?aWp0K2VmaXVONjhGZzh3dHRGVVFGSXhlSThtc2ZPRm05ajFBZzcxNm1KSTZD?=
 =?utf-8?B?QmtNVW13MGFTODBPU0NSY1pmQWpDYXNCWjQzeHFYYkZaMmxmM2dHdWk2aWFR?=
 =?utf-8?B?elA3QU0vTzdTVCtNTExhY3RnTFN5WVdIazZrZHdkNUdRV1hsa0srVlg5KzJl?=
 =?utf-8?B?dVFJME8xR2cwK2VMZ3M1bFppZ0hOMXdnSmJhWHp1cXpZSWdxWmYvZ1hqaFBE?=
 =?utf-8?B?UzJmWVcwN2NXRExuZm9WUGM4Q0N3RzVWZU8yUVRpajIvc0RXM1dhdktXSVV5?=
 =?utf-8?B?VDh3NDdSeHh0bEFVK1lJckhFVjB4Q2x5bXBOaVFsaWxhNktuZk1DaEpxUitQ?=
 =?utf-8?B?VURYcGxMVDh6MHhzUjBNWmd1SFk2aTNUc2xpclp1dHBRQVVnQXBZaWU3RmZh?=
 =?utf-8?B?T1BDVWNnUTFzK3R5UTRMMDNKZWxVZ3VrZUsrVnJ2eWY2b00yQXJvYjQ1VjRW?=
 =?utf-8?B?SkNjckwreTNiR0pLOERSTWp4U2pyS1dIRFZaSVNuOVFkMXNoM3o1MU1ESUFK?=
 =?utf-8?B?NHFGT05lMnN5QVlqb0kzdldNOGNkWUkyVFJVY3BtUTYwU1d6am9Rc2hjWEFD?=
 =?utf-8?B?RWQ4YWNUbmpnd25vS2NFOWFETWZQeXNhbzNZdkJ5bTJKWG1ZVCtycnU2OWMr?=
 =?utf-8?B?Z3haMmJrSXpwaWgvbFdaQW1zWWoxb2dpUG5sQnhNN0ZtLzhIb0pWSkt4TlFB?=
 =?utf-8?B?eDFNem1MMndBVGcwV1BsRDRsaVlwbHNxTFNVWjJORWhINFpTejRCdEFyRml4?=
 =?utf-8?B?SWk5TmkybCswSXpGaVowdkFNL3hLRlZPSmdHbVpZWkdiZklCRmpYekxOb1l5?=
 =?utf-8?B?cVVYVmxLaGxVeFo3QlpjbXJDYUwzK29VV3BrclZqUUxDcXo0QWRPeUNQaXdC?=
 =?utf-8?B?eEVjL3BQVm5rSHo1WWtXTURlYzFOTzdpZGFDNzNhdm8vdVNHRnRHdm9HYklK?=
 =?utf-8?B?cmZ1dEk3bDZQR2NwM2cydDRQUCsybWRmYXMrNFhJTUxjclQyVTN2WklobzVM?=
 =?utf-8?B?RnhHcVkwRHczMnZyRTNQYUpOK0VjcS9xQWRZNStiK3YyQThIYnNSMFdscFUz?=
 =?utf-8?B?aTBkaFFnVXlPb0JPWVNOWlVLVjh0VXdiYkZuOGM2bGw3RHZkdzJYc3JGc0Jo?=
 =?utf-8?B?Y0lGSGpnWmtVWHg5MVJGaFNmT1dnc2dYSnY2VUxFa21NT2tZZk5oNUFCU0FV?=
 =?utf-8?B?Y0FyS09rU2J4N3QxY2R0ekFBMHdhRU5TZHZlMkorZXFOczF2T1hIeFdkaXZE?=
 =?utf-8?B?d3U0QXM5QUZJWS82Y05tZjVUV1J6VVI2T3ZMRldDVjhHV2VPVHFjcnJzNHk0?=
 =?utf-8?B?RGkzNFh1cEp4ZXVGYVBjaWZmaHk4SUZEVkpYSUYyYXVmSmNEbTl2YzNtMUtV?=
 =?utf-8?B?RUdmN0tmNXlGUGk1M2Y3K2pwZzhtN2x4Z1RGSDI5MndXQjU0Zkk0UWg3Q3dG?=
 =?utf-8?B?d2VLZlpUOW1rV2RHWUZGNngxYTc5RFZGSWVTN0FWUVlMbFNtS0RzL1BxSzI4?=
 =?utf-8?B?bDEzTzdxaE9tOEdjSGFIMkhyVjg2Vjl1SHRwM2ZWemhzRmNXWXdpa21uQVE2?=
 =?utf-8?B?Wm9qMVd3WkNyejdqTjJLbHVPNHl2cjFQdmNVMXJPVnJQUWhaak1OYVlRQnE1?=
 =?utf-8?B?allmVnFISDhjckRuS0xucDduTVFNR3ZMOUJCNVF2UytLVXRIVWNxK2ZzM2p1?=
 =?utf-8?B?MHo2QnpBKzloNU9YSncvdG85T3d1YXZmODdrcjBlTXNUQURPaWZ6ZFFPc2ky?=
 =?utf-8?B?elBETmMwQlJNMVZ5dURsMzNOZnJaaTJpQVBDOFFBeTBRWFpDK2xKSENZL0lM?=
 =?utf-8?B?MDhyVDNsNkgxL3hidy9yVW5PdUd1UjV2VjQzTW16aVpKUHdiZ1VoRUFrRzdC?=
 =?utf-8?B?WHBoKzVDU2kvN3FhMEY4cnFjZk5MRE5kQnJaNjdST2hLT3JjL3dFbFQxdTFN?=
 =?utf-8?Q?wHnX25?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmZ2U3cyNHFrbjRFYk9FWEkvdWlIV1psWEovWEl2bHB6SmozYzJvVk0wamU4?=
 =?utf-8?B?eURtdFo5YmZCRnA5OW0zOEl6VzdpU0FKRFgzbUFTR1lZSEUvekhPODRMNDNY?=
 =?utf-8?B?T3puRWNDUHlIYXJXN1dPcGhUTjdHTnlORzIyc2RzQWxEMVd1bXczZ0hBTWQv?=
 =?utf-8?B?WWFnMmtMUDd4K3hVS0taZEdlN0w5ZjhnNVVuanJmTFBrKzd5TnVWWkZwWEEr?=
 =?utf-8?B?MlNRazVVMDdlYzBxVmpLTjFjYlZaUmMyaFZJNytSTEFkMnM2WlpLY0tYbnNj?=
 =?utf-8?B?SlJmMVo2VGxBSUsxa2JORHk1eGVHVGMwSysvZExxMm9YMGptT0JTNzE3WDk5?=
 =?utf-8?B?UHNWK1JMT1pGZDdpeFh6aU9jK0JJK2lTUWhDSDk0dWRoeHM1a0dZa3NqWkRh?=
 =?utf-8?B?U3BYUUtCUnFUUFppZURYQTJVTlNFalR3eE5VNWljckoxaFc2QmJoQVlOSUFi?=
 =?utf-8?B?Z3JJSnozM2NtaHZacDc3OTZTZzZMamtWditmK2VHSEh2Vk1VK204Mm9ZWFdU?=
 =?utf-8?B?SkNlUVhwVkdCbXo2enVJQ0FmclJtdnpDdG1QV29YN1NhTXpqOWJ6bFZ4ZjdK?=
 =?utf-8?B?SlRySlhvb1B4ckY3RTZscHhLU2doaVF0QXM0Ry9EaE9ZYU1uT3lrZE05K1I2?=
 =?utf-8?B?bTltME84eVpRbThySjYrVWtCSm1VMDBEd0kycEZuRm50Rko5QnY1cHdWQ0hW?=
 =?utf-8?B?K1hhT0lsRTl5ZWFWZDA0d2x5d0ZPQW1jMjVSckZzVks0WXFLcjdEWFN4a1BC?=
 =?utf-8?B?bExoektVSGE5akozaVlQRiswa2I3UjFXb1RseXFQbm1zRFEwbFZHZUdGdXNI?=
 =?utf-8?B?amZZVzFJZy9vajMzWG9lWkFrN3M3TWREL3dyb3VPZDhVdjdXMW03UTI4Qks2?=
 =?utf-8?B?dUVxelVCNzhMMUNHb2wwaTdnb0lTZmNhQmt6YW5zVVlXb1NIbHZQVVl5aDNn?=
 =?utf-8?B?WjdMNHFVMGUrdGR1SldZSU5wWm5FanVFVHVkemR2M0wzUnpuNmpoekRqdGlz?=
 =?utf-8?B?WGVzUlJ5TkppZ3RFeWZ6UTYra2xjY2FKb2ZMYWpCUGRiaklibkgreTY3dG5U?=
 =?utf-8?B?OG90N0tzZmJzTVhyYkVRdTJjcXNsNS9TdlNIWWRwK1M3bzBRMnVhL294WG4x?=
 =?utf-8?B?ZGlXNGxCVDAveHA1Y0tjNVBITG9yeWxPMStrUStxbWh0TUp5L3lKMkJQOTFC?=
 =?utf-8?B?L3RzZU51Z3BSeFVsdWRpVk5adDJza2tKZUNHcXNrM0k1emRPT0ZZV25VQkJa?=
 =?utf-8?B?NzEzaXJyNGtYOXVDVzVWV3FKTkdHbGVSSjZPNGlKQWJXYjFzdTMvSmU1MDdS?=
 =?utf-8?B?R0lSK25mRWpaSlZiR29PaVVldzB6cFYzTnVCQ2tUbXFIMGkrTXd6dnFROFVU?=
 =?utf-8?B?dDBlb1NmNGpScXVxZ0NPVXdGYkRQU25WbFE0OWQ3WW54L3p3STYwbGNrSEtV?=
 =?utf-8?B?YzNRay9hSkZ6d3JMWGNKR2dmVmpXQXB0KzRFNGx4djJ6TThUMWhDQjJTWDRV?=
 =?utf-8?B?aktsbExKN0pNVno4cGtOaEVRdExaT3NJaWp2OHZZbmsrWVdFQkowejc2TGRr?=
 =?utf-8?B?VEZ0a2xrNml0dTRDT3QrbnZpUzl2c2dTcHp3YTIyVnYrWlRoUzVyU0NRemxR?=
 =?utf-8?B?L2d0M2JKejFNN2o4NWRuUHVoOGI4RGtRT2VTWUpWdnhmTkt2d0QrbkZsWmtX?=
 =?utf-8?B?L0RjZlNRcFZ3T1dIVWtqR0pHMTQzb3l1YW94VzMwMS9ZTHc1TVBTdUMvVHM3?=
 =?utf-8?B?WDMwZ3cyVCtsRTQ4ekhaVzJUTU4rNUdvNDZBYitmZTVBOFozYTc1elAxa2tT?=
 =?utf-8?B?alV3QTRjNnRjOWd2KzRZekdwWFh3Tnd6cmJWZnBoUUxtWWQ0LzJsV1dQUTF1?=
 =?utf-8?B?NGFKdFdHbUlGbWhiK3JnMWNiemZZaGdXOERiTER3Sy9yOVV5QWYxN00zVktE?=
 =?utf-8?B?c3ZCS0lFcjFWTThvVmxQOGd3RzVTdEQ5aGJmWCtPaGpEQ2IvKytYSzBicnIy?=
 =?utf-8?B?WVhPb3FiWUh0YjNleUhvSVVPT2ppYzhpRlRxZHBaZ2VNZi9uWlF2d2U2ZWNR?=
 =?utf-8?B?ZXVDUHRrckVzbUlKZnFJSDBMeVpzY0lCTHQ0TnJYc1RFMDRIUUNUVDkwallh?=
 =?utf-8?B?cm9nalpPU29RMkxncnpnZm5NQXM1ZUxtSTA3ZUlxU2s0bFc4c3M1ZzEvL21E?=
 =?utf-8?B?OVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b89f8b-ce24-4231-953c-08dd8c1f39a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 21:53:09.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ks6OZdES7PQPWXK59DV2Sg7NKb/m7Aj6wS1OgX3phy6RZzAdN2kKuJ4J0QVUvO5QHEbeO7KiIFaPR7Ki879VpPRaL59STYyW57s6c96aFy1JrLPAkbYRx6MpmIiOsmJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8244

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyOSwgMjAyNSAyOjEwIFBNDQo+
IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJz
LmNvbT47IGhvcm1zQGtlcm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsga3VuaXl1QGFtYXpv
bi5jb207IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmUu
dGFodEBnbWFpbC5jb207IGpoc0Btb2phdGF0dS5jb207IGt1YmFAa2VybmVsLm9yZzsgc3RlcGhl
bkBuZXR3b3JrcGx1bWJlci5vcmc7IHhpeW91Lndhbmdjb25nQGdtYWlsLmNvbTsgamlyaUByZXNu
dWxsaS51czsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgYW5kcmV3
K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgYXN0QGZpYmVyYnkubmV0
OyBsaXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1YWhAa2VybmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0
QHZnZXIua2VybmVsLm9yZzsgaWpAa2VybmVsLm9yZzsgbmNhcmR3ZWxsQGdvb2dsZS5jb207IEtv
ZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMu
Y29tPjsgZy53aGl0ZSA8Zy53aGl0ZUBjYWJsZWxhYnMuY29tPjsgaW5nZW1hci5zLmpvaGFuc3Nv
bkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZUBh
cHBsZS5jb207IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2FzdC5jb207IHZp
ZGhpX2dvZWwgPHZpZGhpX2dvZWxAYXBwbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1
IG5ldC1uZXh0IDEwLzE1XSB0Y3A6IGFjY2VjbjogQWNjRUNOIG9wdGlvbiBzZW5kIGNvbnRyb2wN
Cj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUg
dmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4g
U2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+
IA0KPiANCj4gT24gNC8yMi8yNSA1OjM1IFBNLCBjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFi
cy5jb20gd3JvdGU6DQo+ID4gRnJvbTogSWxwbyBKw6RydmluZW4gPGlqQGtlcm5lbC5vcmc+DQo+
ID4NCj4gPiBJbnN0ZWFkIG9mIHNlbmRpbmcgdGhlIG9wdGlvbiBpbiBldmVyeSBBQ0ssIGxpbWl0
IHNlbmRpbmcgdG8gdGhvc2UgDQo+ID4gQUNLcyB3aGVyZSB0aGUgb3B0aW9uIGlzIG5lY2Vzc2Fy
eToNCj4gPiAtIEhhbmRzaGFrZQ0KPiA+IC0gIkNoYW5nZS10cmlnZ2VyZWQgQUNLIiArIHRoZSBB
Q0sgZm9sbG93aW5nIGl0LiBUaGUNCj4gPiAgIDJuZCBBQ0sgaXMgbmVjZXNzYXJ5IHRvIHVuYW1i
aWd1b3VzbHkgaW5kaWNhdGUgd2hpY2gNCj4gPiAgIG9mIHRoZSBFQ04gYnl0ZSBjb3VudGVycyBp
biBpbmNyZWFzaW5nLiBUaGUgZmlyc3QNCj4gPiAgIEFDSyBoYXMgdHdvIGNvdW50ZXJzIGluY3Jl
YXNpbmcgZHVlIHRvIHRoZSBlY25maWVsZA0KPiA+ICAgZWRnZS4NCj4gPiAtIEFDS3Mgd2l0aCBD
RSB0byBhbGxvdyBDRVAgZGVsdGEgdmFsaWRhdGlvbnMgdG8gdGFrZQ0KPiA+ICAgYWR2YW50YWdl
IG9mIHRoZSBvcHRpb24uDQo+ID4gLSBGb3JjZSBvcHRpb24gdG8gYmUgc2VudCBldmVyeSBhdCBs
ZWFzdCBvbmNlIHBlciAyXjIyDQo+ID4gICBieXRlcy4gVGhlIGNoZWNrIGlzIGRvbmUgdXNpbmcg
dGhlIGJpdCBlZGdlcyBvZiB0aGUNCj4gPiAgIGJ5dGUgY291bnRlcnMgKGF2b2lkcyBuZWVkIGZv
ciBleHRyYSB2YXJpYWJsZXMpLg0KPiA+IC0gQWNjRUNOIG9wdGlvbiBiZWFjb24gdG8gc2VuZCBh
IGZldyB0aW1lcyBwZXIgUlRUIGV2ZW4gaWYNCj4gPiAgIG5vdGhpbmcgaW4gdGhlIEVDTiBzdGF0
ZSByZXF1aXJlcyB0aGF0LiBUaGUgZGVmYXVsdCBpcyAzDQo+ID4gICB0aW1lcyBwZXIgUlRULCBh
bmQgaXRzIHBlcmlvZCBjYW4gYmUgc2V0IHZpYQ0KPiA+ICAgc3lzY3RsX3RjcF9lY25fb3B0aW9u
X2JlYWNvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IElscG8gSsOkcnZpbmVuIDxpakBrZXJu
ZWwub3JnPg0KPiA+IENvLWRldmVsb3BlZC1ieTogQ2hpYS1ZdSBDaGFuZyA8Y2hpYS15dS5jaGFu
Z0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWEtWXUgQ2hhbmcg
PGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVk
ZS9saW51eC90Y3AuaCAgICAgICAgfCAgMyArKysNCj4gPiAgaW5jbHVkZS9uZXQvbmV0bnMvaXB2
NC5oICAgfCAgMSArDQo+ID4gIGluY2x1ZGUvbmV0L3RjcC5oICAgICAgICAgIHwgIDEgKw0KPiA+
ICBuZXQvaXB2NC9zeXNjdGxfbmV0X2lwdjQuYyB8ICA5ICsrKysrKysrDQo+ID4gIG5ldC9pcHY0
L3RjcC5jICAgICAgICAgICAgIHwgIDUgKysrKy0NCj4gPiAgbmV0L2lwdjQvdGNwX2lucHV0LmMg
ICAgICAgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICBuZXQvaXB2
NC90Y3BfaXB2NC5jICAgICAgICB8ICAxICsNCj4gPiAgbmV0L2lwdjQvdGNwX21pbmlzb2Nrcy5j
ICAgfCAgMiArKw0KPiA+ICBuZXQvaXB2NC90Y3Bfb3V0cHV0LmMgICAgICB8IDQyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gIDkgZmlsZXMgY2hhbmdlZCwgOTAg
aW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC90Y3AuaCBiL2luY2x1ZGUvbGludXgvdGNwLmggaW5kZXggDQo+ID4gMGUwMzJk
OTYzMWFjLi5hY2IwNzI3ODU1ZjggMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC90Y3Au
aA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdGNwLmgNCj4gPiBAQCAtMzA5LDggKzMwOSwxMSBA
QCBzdHJ1Y3QgdGNwX3NvY2sgew0KPiA+ICAgICAgIHU4ICAgICAgcmVjZWl2ZWRfY2VfcGVuZGlu
Zzo0LCAvKiBOb3QgeWV0IHRyYW5zbWl0IGNudCBvZiByZWNlaXZlZF9jZSAqLw0KPiA+ICAgICAg
ICAgICAgICAgdW51c2VkMjo0Ow0KPiA+ICAgICAgIHU4ICAgICAgYWNjZWNuX21pbmxlbjoyLC8q
IE1pbmltdW0gbGVuZ3RoIG9mIEFjY0VDTiBvcHRpb24gc2VudCAqLw0KPiA+ICsgICAgICAgICAg
ICAgcHJldl9lY25maWVsZDoyLC8qIEVDTiBiaXRzIGZyb20gdGhlIHByZXZpb3VzIHNlZ21lbnQg
Ki8NCj4gPiArICAgICAgICAgICAgIGFjY2Vjbl9vcHRfZGVtYW5kOjIsLyogRGVtYW5kIEFjY0VD
TiBvcHRpb24gZm9yIG4gbmV4dCANCj4gPiArIEFDS3MgKi8NCj4gPiAgICAgICAgICAgICAgIGVz
dF9lY25maWVsZDoyOy8qIEVDTiBmaWVsZCBmb3IgQWNjRUNOIGRlbGl2ZXJlZCBlc3RpbWF0ZXMg
Ki8NCj4gPiAgICAgICB1MzIgICAgIGFwcF9saW1pdGVkOyAgICAvKiBsaW1pdGVkIHVudGlsICJk
ZWxpdmVyZWQiIHJlYWNoZXMgdGhpcyB2YWwgKi8NCj4gPiArICAgICB1NjQgICAgIGFjY2Vjbl9v
cHRfdHN0YW1wOyAgICAgIC8qIExhc3QgQWNjRUNOIG9wdGlvbiBzZW50IHRpbWVzdGFtcCAqLw0K
PiANCj4gQUZBSUNTIHRoaXMgZmllbGQgaXMgb25seSBhY2Nlc3MgaW4gdGhlIHR4IHBhdGgsIHdo
aWxlIHRoaXMgY2h1bmsgYmVsb25nIHRvIHRoZSB0Y3Bfc29ja193cml0ZV90eHJ4IGdyb3VwLg0K
PiANCj4gPiBAQCAtNzQwLDYgKzc0MCwxNSBAQCBzdGF0aWMgc3RydWN0IGN0bF90YWJsZSBpcHY0
X25ldF90YWJsZVtdID0gew0KPiA+ICAgICAgICAgICAgICAgLmV4dHJhMSAgICAgICAgID0gU1lT
Q1RMX1pFUk8sDQo+ID4gICAgICAgICAgICAgICAuZXh0cmEyICAgICAgICAgPSBTWVNDVExfVFdP
LA0KPiA+ICAgICAgIH0sDQo+ID4gKyAgICAgew0KPiA+ICsgICAgICAgICAgICAgLnByb2NuYW1l
ICAgICAgID0gInRjcF9lY25fb3B0aW9uX2JlYWNvbiIsDQo+ID4gKyAgICAgICAgICAgICAuZGF0
YSAgICAgICAgICAgPSAmaW5pdF9uZXQuaXB2NC5zeXNjdGxfdGNwX2Vjbl9vcHRpb25fYmVhY29u
LA0KPiA+ICsgICAgICAgICAgICAgLm1heGxlbiAgICAgICAgID0gc2l6ZW9mKHU4KSwNCj4gPiAr
ICAgICAgICAgICAgIC5tb2RlICAgICAgICAgICA9IDA2NDQsDQo+ID4gKyAgICAgICAgICAgICAu
cHJvY19oYW5kbGVyICAgPSBwcm9jX2RvdTh2ZWNfbWlubWF4LA0KPiA+ICsgICAgICAgICAgICAg
LmV4dHJhMSAgICAgICAgID0gU1lTQ1RMX1pFUk8sDQo+ID4gKyAgICAgICAgICAgICAuZXh0cmEy
ICAgICAgICAgPSBTWVNDVExfRk9VUiwNCj4gDQo+IFRoZSBudW1iZXIgb2YgbmV3IHN5c2N0bCBp
cyBjb25jZXJuaW5nIGhpZ2gsIGFuZCBJIGRvbid0IHNlZSBhbnkgZG9jdW1lbnRhdGlvbiB1cGRh
dGUgeWV0Lg0KDQpIaSBQYW9sbywNCg0KVGhlIGRvY3VtZW50YXRpb24gaXMgZXhwZWN0ZWQgdG8g
YmUgYXQgdGhlIGVuZCBvZiB3aG9sZSBBY2NFQ04gcGF0Y2gNCmh0dHBzOi8vZ2l0aHViLmNvbS9M
NFNUZWFtL2xpbnV4LW5ldC1uZXh0L2NvbW1pdC8wM2RjZWMxYWVjNmFhNzc0ZGE0YzE5OTNiMzhh
NWI5MzcwNDBhMTFjDQoNCk9yIEkgY2FuIG1vdmUgaXQgbmV4dCB0byB0aGlzIHBhdGNoLg0KDQo+
IA0KPiA+IEBAIC02MjkxLDkgKzYyOTQsMzYgQEAgdm9pZCB0Y3BfZWNuX3JlY2VpdmVkX2NvdW50
ZXJzKHN0cnVjdCBzb2NrICpzaywgDQo+ID4gY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4g
Pg0KPiA+ICAgICAgICAgICAgICAgaWYgKHBheWxvYWRfbGVuID4gMCkgew0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICB1OCBtaW5sZW4gPSANCj4gPiB0Y3BfZWNuZmllbGRfdG9fYWNjZWNuX29w
dGZpZWxkKGVjbmZpZWxkKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgdTMyIG9sZGJ5dGVz
ID0gdHAtPnJlY2VpdmVkX2Vjbl9ieXRlc1tlY25maWVsZCAtIA0KPiA+ICsgMV07DQo+ID4gKw0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICB0cC0+cmVjZWl2ZWRfZWNuX2J5dGVzW2VjbmZpZWxk
IC0gMV0gKz0gcGF5bG9hZF9sZW47DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHRwLT5hY2Nl
Y25fbWlubGVuID0gbWF4X3QodTgsIHRwLT5hY2NlY25fbWlubGVuLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1pbmxlbik7DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAvKiBEZW1hbmQgQWNjRUNOIG9wdGlvbiBhdCBsZWFzdCBl
dmVyeSAyXjIyIGJ5dGVzIHRvDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAqIGF2b2lkIG92
ZXJmbG93aW5nIHRoZSBFQ04gYnl0ZSBjb3VudGVycy4NCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmICgodHAtPnJlY2VpdmVkX2Vjbl9i
eXRlc1tlY25maWVsZCAtIDFdIF4gb2xkYnl0ZXMpICYNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgIH4oKDEgPDwgMjIpIC0gMSkpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1OCBvcHRfZGVtYW5kID0gbWF4X3QodTgsIDEsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiA+ICsgdHAtPmFjY2Vjbl9vcHRf
ZGVtYW5kKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHAtPmFj
Y2Vjbl9vcHRfZGVtYW5kID0gb3B0X2RlbWFuZDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
fQ0KPiANCj4gSSBndWVzcyB0aGlzIGV4cGxhaW5zIHRoZSB1MzIgdmFsdWVzIGZvciBzdWNoIGNv
dW50ZXJzLiBTb21lIGNvbW1lbnRzIGluIHRoZSBwcmV2aW91cyBwYXRjaCBjb3VsZCBiZSB1c2Vm
dWwuDQoNClllcywgbGlrZSBteSBwcmV2aW91cyBlbWFpbCBzYXlzLCBJIHdvdWxkIHJlZmVyIHRv
IHRoZSBhbGdvcml0aG0gaW4gQWNjRUNOIGRyYWZ0Lg0KDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9u
ZXQvaXB2NC90Y3BfaXB2NC5jIGIvbmV0L2lwdjQvdGNwX2lwdjQuYyBpbmRleCANCj4gPiAzZjNl
Mjg1ZmM5NzMuLjJlOTVkYWQ2NmZlMyAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvaXB2NC90Y3BfaXB2
NC5jDQo+ID4gKysrIGIvbmV0L2lwdjQvdGNwX2lwdjQuYw0KPiA+IEBAIC0zNDUxLDYgKzM0NTEs
NyBAQCBzdGF0aWMgaW50IF9fbmV0X2luaXQgdGNwX3NrX2luaXQoc3RydWN0IG5ldCANCj4gPiAq
bmV0KSAgew0KPiA+ICAgICAgIG5ldC0+aXB2NC5zeXNjdGxfdGNwX2VjbiA9IDI7DQo+ID4gICAg
ICAgbmV0LT5pcHY0LnN5c2N0bF90Y3BfZWNuX29wdGlvbiA9IDI7DQo+ID4gKyAgICAgbmV0LT5p
cHY0LnN5c2N0bF90Y3BfZWNuX29wdGlvbl9iZWFjb24gPSAzOw0KPiA+ICAgICAgIG5ldC0+aXB2
NC5zeXNjdGxfdGNwX2Vjbl9mYWxsYmFjayA9IDE7DQo+IA0KPiBIdW1hbiByZWFkYWJsZSBtYWNy
b3MgaW5zdGVhZCBvZiBtYWdpYyBudW1iZXJzIGNvdWxkIGhlbHAuDQoNCk9LLCBjb21tbWVudHMg
d2lsbCBiZSBhZGRlZCBoZXJlLg0KDQo+IA0KPiA+IEBAIC0xMjM3LDEzICsxMjUzLDE4IEBAIHN0
YXRpYyB1bnNpZ25lZCBpbnQgDQo+ID4gdGNwX2VzdGFibGlzaGVkX29wdGlvbnMoc3RydWN0IHNv
Y2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiDQo+ID4NCj4gPiAgICAgICBpZiAodGNwX2Vjbl9t
b2RlX2FjY2Vjbih0cCkgJiYNCj4gPiAgICAgICAgICAgc29ja19uZXQoc2spLT5pcHY0LnN5c2N0
bF90Y3BfZWNuX29wdGlvbikgew0KPiA+IC0gICAgICAgICAgICAgaW50IHNhdmluZyA9IG9wdHMt
Pm51bV9zYWNrX2Jsb2NrcyA+IDAgPyAyIDogMDsNCj4gPiAtICAgICAgICAgICAgIGludCByZW1h
aW5pbmcgPSBNQVhfVENQX09QVElPTl9TUEFDRSAtIHNpemU7DQo+ID4gLQ0KPiA+IC0gICAgICAg
ICAgICAgb3B0cy0+ZWNuX2J5dGVzID0gdHAtPnJlY2VpdmVkX2Vjbl9ieXRlczsNCj4gPiAtICAg
ICAgICAgICAgIHNpemUgKz0gdGNwX29wdGlvbnNfZml0X2FjY2VjbihvcHRzLCB0cC0+YWNjZWNu
X21pbmxlbiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZW1haW5pbmcsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2F2aW5nKTsNCj4gPiArICAgICAgICAgICAgIGlmIChzb2NrX25ldChzayktPmlwdjQu
c3lzY3RsX3RjcF9lY25fb3B0aW9uID49IDIgfHwNCj4gPiArICAgICAgICAgICAgICAgICB0cC0+
YWNjZWNuX29wdF9kZW1hbmQgfHwNCj4gPiArICAgICAgICAgICAgICAgICB0Y3BfYWNjZWNuX29w
dGlvbl9iZWFjb25fY2hlY2soc2spKSB7DQo+IA0KPiBXaHkgYSBuZXN0ZWQgaWYgaGVyZSBhbmQg
anVzdCBub3QgZXhwYW5kaW5nIHRoZSBleGlzdGluZyBvbmU/DQoNClN1cmUsIHdpbGwgbWVyZ2Ug
dGhlbS4NCg0KQ2hpYS1ZdQ0KDQo+IA0KPiAvUA0KDQo=

