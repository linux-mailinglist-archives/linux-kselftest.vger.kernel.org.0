Return-Path: <linux-kselftest+bounces-43566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C60BF2811
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 18:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B8618A1592
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418E330337;
	Mon, 20 Oct 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RVAFOoWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5832F751;
	Mon, 20 Oct 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978810; cv=fail; b=afMvK26DW+zDzb76UuRGFGKwli9vx912v7+wue5rZa6Lx23PqV6hYRCP2AO7OGQS1eBPqW7PO+s1TSGddT12ltXAkgd6bR6JErTJVYRGjIHUq3Uy8xMCZ+z0sL9kqLPOdyy9/u7U5d9Q4LHO1nkZLVE8dE7I++1+0oD2gXmcix4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978810; c=relaxed/simple;
	bh=5NcRe3tRR4LO+5Z3tPR/Ckj0EZX4NipaZM/DieWpsGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zm7aeGfYEXs3Wa7NZAxKnGAvhJ1FZf4Mx+LZyFAf5Zl1hWgL5jJsdL5dDlJ2LChDFH4M7lqzXA52garAcODkaHZkmYeV7gTn9+oEavBdGBPONSMfDi6oDilz6+mqQqFQZ1M3NczK4Aw9gnR03aTmPx++aBOvT9qMYzKrbss1FeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RVAFOoWO; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBhlHr1gjqZOPZhigMt+sTu4ub6d0dPvehNW4WxRbHtoEZ/u2Lwrsg0CYc52W8uPd4eQf0zCbVWG+hqW1qqb3DSv9mScT2xzU3Jqj9KMJWLNj6JzWYYcwB/kCN2+J8WlL9N7sJ/xVMiFlDpvtVLjbyxDX/kCO/yWqDKyVukPHOYbU8+Yw6kdYr5oYptkHbNEFRkuS3ymFwMjo37Ax3YNl7n/m3fOtEVyjifm2vxDJ/W8OHUEyY8fEpi78wZLxen9YstQz4Ci5ilLZIW21xfpxClMe7hV8jFJlAAGcIb5rrMRbS3DtSVmQP60GyGn5LbPf52pdmijlu7dZnmmfSkKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NcRe3tRR4LO+5Z3tPR/Ckj0EZX4NipaZM/DieWpsGs=;
 b=DeuTCCbwaRSt0F4EhnCxageDf76jPCmr1mODgfys3YLvZCgpXB3yVXwyJEzZuXkjaRDK1UZJ9A7NDIhfhEFe+0O9v8MJMJYx6ACoSlUOLYj+6QV75OYggAjVO+n6PaIlNMeE2mcGvWusfz8uhTJsVGHjYkhJcRk6pCUJtZY6xEifFqNaH+wx73eswjDf6kft5zVlXytyFw+SuisMRzAuKmAftS2R/FaBDw2ZiJ184ZbsFc4VaHp8c6Q+UnsksT+pgnubIVJEajuKqS2lg0otGyObLpWhUWzKtDAAf2MSBA80+btTp8XNacO11EUMEq+TDD2Yqpy7rO4orHaviG+nQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NcRe3tRR4LO+5Z3tPR/Ckj0EZX4NipaZM/DieWpsGs=;
 b=RVAFOoWOAn+oh3AhfqkHkNxmCOVeLLxAYhQzf4LkVyC3AjcA8w9bCNdaMMhem57mnfjdJL1yZ1BLDuYzJ7T52BYXzj64DE7++Dwy3KYiQa0xpmyH9gu3HKCGqL7cKAFhor00WOYMem7wGp2a4VIDOvZrNy5fwox6Mjdg1MYb0iCPUlWj+w+QHQHkBd4gFUCO1JHs5jzW+EXO/otm2jtWWOfyJ1ZhzY9hWk14iihb785wsd91cyWGy8hyoPXJjYZtF71CYriMTWRqrXFZbAd+4kA1yDkLvOnTSWl0bgiTniBaLz4IO8USzK9mjzg7BZ9TKNJtfdmyCCJ7bl7Cg9+e3A==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7093.eurprd07.prod.outlook.com (2603:10a6:20b:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 16:46:44 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 16:46:44 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ij@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v4 net-next 02/13] gro: flushing when CWR is set
 negatively affects AccECN
Thread-Topic: [PATCH v4 net-next 02/13] gro: flushing when CWR is set
 negatively affects AccECN
Thread-Index: AQHcPGNXbBwtXLsf+UCUrmd3vsiJYbTEgoEAgAC7KICABfJyUIAABGwAgAAUxUA=
Date: Mon, 20 Oct 2025 16:46:44 +0000
Message-ID:
 <PAXPR07MB79846A82771C2345E3E224F3A3F5A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
 <98342f21-08c8-46de-9309-d58dfc44d0a0@redhat.com>
 <24bc44a8-6045-9565-c798-a9d4597366e8@kernel.org>
 <PAXPR07MB7984DB68F2D9E7468D839BEFA3F5A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CANn89iKyQFowOpFDXbpewEiEGESdeZ_bgBViOA2NN9n8h6Vkrw@mail.gmail.com>
In-Reply-To:
 <CANn89iKyQFowOpFDXbpewEiEGESdeZ_bgBViOA2NN9n8h6Vkrw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7093:EE_
x-ms-office365-filtering-correlation-id: 8116799f-f94d-4c13-d9e3-08de0ff840a2
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|7053199007|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXQxRVFrSDNBR2tNQlBubEpWbzlWWUcxM2xkS3dDckl0SDVtNXhpUEZRMlFH?=
 =?utf-8?B?SndmNGJ6YlVTWFBTSkJXUnhqblVYOEpYYTJTWCs0Qlp0YjU2WFhXTlQ3cExJ?=
 =?utf-8?B?Q01IZzhmZ3dJcEQxZkU2YVJJK0lQdkgwbmNhK0ZlZ000QVFHQkVJNmd0TVVR?=
 =?utf-8?B?MXlLM1dFZnhHK0t1WjZDQ1B6QTJSeXVIMEhQRk5pWTlxaXFQWm9WRVdNZnUr?=
 =?utf-8?B?WFk1ODN0cUxaODhtc280Vm40dElBLzZpdXdwemN4ajdqTmtPRThCZGZpK2RC?=
 =?utf-8?B?OVJFTEVLck1Tc2RYeWlEbGFLTzJtcXp1em9lQVpwbUt0dGlLeWpESGthbzNH?=
 =?utf-8?B?WkpYOGhPVFFQeGZCaFJqeTNBTS9qeVZZSmhub1VNOGhmWTc5KzI0cVBOY1JR?=
 =?utf-8?B?dXRKZFVpU0hJbkY0akFBY2tNend1dDNFc1p1S1BQcjRRWWRQN000RWlZV2hH?=
 =?utf-8?B?M011NHdpUFBJaTh2ams4aWlJUTV2SHJYenR5VFFjd3F3cCtqYjM4QzJpTGJO?=
 =?utf-8?B?WXpBQjFVNmREV2hVOVNLSmJROTc5MjdZcllmUzF0Y2xaT1ZRSDZMNXZCakhs?=
 =?utf-8?B?Vllkc1FWRVFUTXFyR0FRQTgzZlYvSkRhbnB1ZlRGSGVBRUoyZGpVVnNLYzli?=
 =?utf-8?B?VnZ5bGJEckJrdEcrZzJQV3Z0NUEwVU84bEVuUitKK09EaHJscW5QS0NZNVE3?=
 =?utf-8?B?WnhtcW5aTloxVzNYOTZHc0FJd3RJeE52VjNkcEFHZ3RDb3dicjRvMk93VW9D?=
 =?utf-8?B?Skt2ZUNjWHRkNjZxVGJRVURNbVZVWnFaVnlGMEs4cHljUTJ0bUNieDd4M1pu?=
 =?utf-8?B?WW5NVnpFN0ZCMDFMTkFjb2JSdjMxY1NtZTF3RG5jY1czV3cxTUZWQTZTZ3BM?=
 =?utf-8?B?aFk3aWhCczkxa204cWdKYldDRnhtY2xOMVpKQkNJSWFmdi9HNStpYSt0OS9H?=
 =?utf-8?B?NGlkeXVmZXBVUmljN05XNm5TSk1ONU9ONkVtN1ZIN25DdWFmWVFVTTVWYUlC?=
 =?utf-8?B?UWxLOGdXYWZUVmNMblgwcUVqajZpMnVxTk5oTEovL3M0YU4wcXlDbXNlWXdJ?=
 =?utf-8?B?bndhcDU1UE4xTnlUSXM5SGxlT01zM014ejlrSGpWQXNnMWE3Y0Fud2d4SURL?=
 =?utf-8?B?cUxKUmxQaWdvME9OM1ZTbk80V3Zlcm8wLy9HL3NkeUU5c1R5VmhIdFJ0LzRV?=
 =?utf-8?B?TmY4S0U1NWpHYzB2WVhWU3hEYWZZZEhyNk9tUDJVVm1McUJma3MrUEU1VVo5?=
 =?utf-8?B?RUFvdG5pWlZsV1FBcWFSVGFEL2k1VXl6THBKN3hOT0tQamZEU1htcXI4QjNz?=
 =?utf-8?B?REE0bFliS1cwQ2FyODd3a3pyZUUvVjBxTkI4U0RUeHFOL2o5L0hkT0paanU5?=
 =?utf-8?B?Q2Z3UmlmMTlKNndYTVpjSE1rcWFqcWFFblFNeW1kOEtvUytMOTNiU1JVa0RD?=
 =?utf-8?B?eGpiSU4rOWw3dDBHSkJoZzB6NWsxV1l6bVR3ell4Wm12S0VFTlZZYnV3R3l0?=
 =?utf-8?B?YXNJRHY5UkFJUDBHejRoOGhuTVdUNko3aURidWZnQ2dZZXlGQ2w0a29rYTBP?=
 =?utf-8?B?aXFQaTMzcko3UHhLRUhZd2pTRGcrdSs2c1l0MFdCaUhrOXlMU08zNVhRU0RD?=
 =?utf-8?B?aDBVSjZoUW15MUo0SUMxdTYrN1VlVVZ5Nmc3eXZjV05mN0RCb2xPTUdhWWRY?=
 =?utf-8?B?SitkNHBQZko3S1lpZUp0WlA4Z2NWUHFncnl2NE50M0FLRXJ2N2tWSTRtdzdV?=
 =?utf-8?B?S2ZYT09kS0FFZDVhSGJ2Nkw2R0NhNGVibmkxOFA5RnNDckZwQkdhc3FtQ2xh?=
 =?utf-8?B?c1lsdE1NcUdXeFpNejhKSE9KSmRBM08yWUI1eW5SMGRDNXJuMksxK3E4dE9N?=
 =?utf-8?B?TWVjRVdZREMwWjBHTEs5N1Z5UUsvQ1ZDZUxacVZDUG1XM0R3M2JNZjFYeHBZ?=
 =?utf-8?B?TVAwQUVBSXBhWjUwTlh1R1lJQklHTXcyeFd3SEhMWGhkR1BHdWpxMFRUUk80?=
 =?utf-8?B?OHhuNFdrVU41RUU4ZUF4Um16NTBkSklVMWc4Q1R5Um5JWG5kcnl2UVZKRi9L?=
 =?utf-8?Q?s4QiKS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(7053199007)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnlDY1BiKzJBaEdBYXpMUHFlWmtkcnlNdDkvcjR5NVkyeG9oRlVmZkNNL05a?=
 =?utf-8?B?RWZ6ZE81VzJtRU1rSEdnZXB0VGRVZHdkdlIzVWRUaTlNSmZKUmF2MDlNLzIv?=
 =?utf-8?B?eGJIbVlPcVlxWUhXS3hMNHRicGtYRkU5UVNrcWwzL2dTWDVOdkd0K1dCNGhX?=
 =?utf-8?B?YjY4OW9EM1NXL1lyM1pBVVhLQzhFa0FEb1BxSEl0dlR4ekc0M2RDOWFkVHlK?=
 =?utf-8?B?ckV5Zy92U1ZaYm5JZWhEV1c2T0hpTDVuRTVUWldvTG1OdjdKVGlUck5XbzNy?=
 =?utf-8?B?UVZiWElLeTJOaEQ0QkJ6b3ZkMnNZYWprcmRMcmpQNkFRcnRIWGxicG51eVhL?=
 =?utf-8?B?QUUrRWVoMTl6TTlMREc3QlhFMjlGdzNaVTJLeVZoOWsrVTY1OC94bDNqQmwz?=
 =?utf-8?B?aFEreDV5VTFqMldHU21YUTQyYjFNMEpOZWkxMTIvU01lT21oTm5PU1pSSWlw?=
 =?utf-8?B?Y0QvdlZwMVdvZm9DSnVOZksralFBL0tEQUZsYjNmQ1ZUZTJpa3Rrem0razJJ?=
 =?utf-8?B?OEs0bUVjVENIcXY4UG5JSStIbGUxdGhjc2o2dHRmaDlxbEF1enZZOFZtWUMy?=
 =?utf-8?B?OFNtQzlOZWlGSnpkdGZLSVRMUFY5Y1RuM1ZjcDlUbzkyQWJXeldUZHR1QnRp?=
 =?utf-8?B?ejZzK1U0aC9LV3Y4bnlzVUJCUmJIdHFIalVISlFHQWcvYzZEc0J3OFFjMjJ2?=
 =?utf-8?B?WHM0Q1N4NHl2a0E1UUdJVDEvVlZ4bERZdE4rbDRlZThCeDZ6ODIyeVJlZG9q?=
 =?utf-8?B?Rmw3azIyQ1lnOEVKUWRSaEppS2s3U3F6UGU4Q2tRZkdycWlNSTZRZEdmQzJ2?=
 =?utf-8?B?SFBIY2pLYml2SGdFQ3AzOS9pZ3F4ODRNbUdzKzBKY2EzNjc5Rzd5ckxuWVpE?=
 =?utf-8?B?K0VWUTB0dXJIQi9zSGFWNE9pWWd0WGtjL2xSUFNXWkZsdDJqdzhoeDF1SEd4?=
 =?utf-8?B?aVdsOXRlRWFpeHlwR294M3I4VjIxaXpONEJpUG9admZqL0EwdHh6eXJyeDgx?=
 =?utf-8?B?RWhHRGdXdlRRZDQrRXREdXZYbzA3bkRNK25TWFhML1VNTE1qSzArSi9MNUFR?=
 =?utf-8?B?dk9NcjA3NkcrSUNzNDgvRHlFYkp5cXNxakJCQkdweHdHbGdNaXppbEw1MGd1?=
 =?utf-8?B?aUQ1QVZnVlQ5c1hVbVJrRHlRY3Ztem5Gc1NXaDEzTWJhbGl0a1ViSTlCQ1M5?=
 =?utf-8?B?Sk83QUljU1RTekJlcjU1WCtJaiszbm9EblFVakV3WFdsVzlUaDc5RUJXNkZO?=
 =?utf-8?B?ZU9zL2dGWkc1RU1nR04zbFRtK2xRR0tQRy93Sm4wQytib2g1anhvdmlVaFRn?=
 =?utf-8?B?cEgyQW1JQUpjWkxtRFIvamRJb0haL0lEaEZzWUtoSDd3N3ZwOWx4M2R4RHhQ?=
 =?utf-8?B?SzJSMEpMYkFhWWlSb0R5akw5VEdSVGVtVWpxMjMveldsY2FGOUxRUmRzVEU2?=
 =?utf-8?B?M0M0eG1SVmNBTGt3aks5cE1TbkRpVUY3dWpmc1ZQQi9Qd0F5MllqNm5hckdx?=
 =?utf-8?B?RVpIRUZQR1RxQjFkTWdxT1c5SEhzL1hQcUtQK2M3djFtL3JXVTdmRUlKdDRB?=
 =?utf-8?B?MXdESnFvc3VVMkplVlNVdkNmYW9ydVZDQTJCU0x1eUdoT0paNWNESFR4c2FZ?=
 =?utf-8?B?R1lkT05tc0thTmlhNlpGcjAwcWNhMGpIQkQzM2VwNjFTWWJhcWRCNGFPdXRN?=
 =?utf-8?B?QlZjcXBVYlR6ZnpmM2hxekFPMEE5Q1B5VjRDYzNxbFRhbVQ0UE9oMUgxbFVy?=
 =?utf-8?B?MnhJMXllYmM5SytmNldoTXNGSTlqSDJBallsZkJVay9zT1A1eGJjamJGZG16?=
 =?utf-8?B?RWg0VXozRFBpR0JmVGJzdGc2Y09zcGt6cHdWUUZUdjhzWk5WbXErZ3hVM0VT?=
 =?utf-8?B?OThicUJmVFhSZmxHTVlPYWdoUmdxNWhMZjM2aFhxa3BqVkQ3TW1KQzVNZ0VI?=
 =?utf-8?B?bUs2QktPZ2tHMmV3MEJRa3lIUnlTTll1cFhTYXNKUjIra2xSWE12dEFNalpY?=
 =?utf-8?B?ZXZiVC9iN1ErcVlxc2JjTjZZbFRVaUpCa0V0SVc1Zll0ck0rdmloM2szcDYy?=
 =?utf-8?B?dDRzRS9hTUdidSt1V3M0SzdLc2R0TG84emVDbDNkR0VqZldiVjRVQXN5RlZD?=
 =?utf-8?B?UjBBcE95K0FrNHMwVU5ROXdoOWxqenVicjVNNkljdzJrL1FYcTVMMGJ6bHRh?=
 =?utf-8?B?c1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8116799f-f94d-4c13-d9e3-08de0ff840a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 16:46:44.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M99/PeF3Vaa+QhX2yNSXYaHRvceifwvY1FJ1I16N9cWKMaLzl7idNqI1u/RYwMD7t+TBU/2QODMAMamPmiojswRcTZzfvtMRFWLXUkCKplj/TJhLTAS1T50fqjTq1HPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7093

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjAsIDIwMjUgNTozMiBQ
TQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwt
bGFicy5jb20+DQo+IENjOiBJbHBvIErDpHJ2aW5lbiA8aWpAa2VybmVsLm9yZz47IFBhb2xvIEFi
ZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJl
dEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBh
bWF6b24uY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBk
YXZlLnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0
ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlA
cmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytuZXRkZXZAbHVubi5jaDsg
ZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsgbGl1aGFuZ2JpbkBnbWFp
bC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7
IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVf
c2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgaW5n
ZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24u
Y29tOyBjaGVzaGlyZSA8Y2hlc2hpcmVAYXBwbGUuY29tPjsgcnMuaWV0ZkBnbXguYXQ7IEphc29u
X0xpdmluZ29vZEBjb21jYXN0LmNvbTsgVmlkaGkgR29lbCA8dmlkaGlfZ29lbEBhcHBsZS5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgbmV0LW5leHQgMDIvMTNdIGdybzogZmx1c2hpbmcg
d2hlbiBDV1IgaXMgc2V0IG5lZ2F0aXZlbHkgYWZmZWN0cyBBY2NFQ04NCj4gDQo+IA0KPiBDQVVU
SU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdo
ZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9r
Lml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4gT24gTW9u
LCBPY3QgMjAsIDIwMjUgYXQgODoyNuKAr0FNIENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15
dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwu
b3JnPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTYsIDIwMjUgMTA6MjcgUE0NCj4g
PiA+IFRvOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+ID4gPiBDYzogQ2hpYS1Z
dSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+OyANCj4g
PiA+IGVkdW1hemV0QGdvb2dsZS5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJl
dEBsd24ubmV0OyANCj4gPiA+IGhvcm1zQGtlcm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsg
a3VuaXl1QGFtYXpvbi5jb207IA0KPiA+ID4gYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgDQo+ID4gPiBqaHNAbW9qYXRhdHUu
Y29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyANCj4gPiA+
IHhpeW91Lndhbmdjb25nQGdtYWlsLmNvbTsgamlyaUByZXNudWxsaS51czsgZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsgDQo+ID4gPiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21h
aWwuY29tOyBhc3RAZmliZXJieS5uZXQ7IA0KPiA+ID4gbGl1aGFuZ2JpbkBnbWFpbC5jb207IHNo
dWFoQGtlcm5lbC5vcmc7IA0KPiA+ID4gbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsg
bmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgDQo+ID4gPiBTY2hlcHBlciAoTm9raWEpIDxr
b2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyANCj4gPiA+IGcud2hpdGVAY2Fi
bGVsYWJzLmNvbTsgaW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IA0KPiA+ID4gbWly
amEua3VlaGxld2luZEBlcmljc3Nvbi5jb207IGNoZXNoaXJlIDxjaGVzaGlyZUBhcHBsZS5jb20+
OyANCj4gPiA+IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2FzdC5jb207IFZp
ZGhpIEdvZWwgDQo+ID4gPiA8dmlkaGlfZ29lbEBhcHBsZS5jb20+DQo+ID4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY0IG5ldC1uZXh0IDAyLzEzXSBncm86IGZsdXNoaW5nIHdoZW4gQ1dSIGlzIHNl
dCANCj4gPiA+IG5lZ2F0aXZlbHkgYWZmZWN0cyBBY2NFQ04NCj4gPiA+DQo+ID4gPg0KPiA+ID4g
Q0FVVElPTjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1
bCB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJM
IG5vay5pdC9leHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+ID4gPg0KPiA+ID4NCj4g
PiA+DQo+ID4gPiBPbiBUaHUsIDE2IE9jdCAyMDI1LCBQYW9sbyBBYmVuaSB3cm90ZToNCj4gPiA+
ID4gT24gMTAvMTMvMjUgNzowMyBQTSwgY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29t
IHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwub3JnPg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gQXMgQWNjRUNOIG1heSBrZWVwIENXUiBiaXQgYXNzZXJ0ZWQg
ZHVlIHRvIGRpZmZlcmVudCANCj4gPiA+ID4gPiBpbnRlcnByZXRhdGlvbiBvZiB0aGUgYml0LCBm
bHVzaGluZyB3aXRoIEdSTyBiZWNhdXNlIG9mIENXUiBtYXkgDQo+ID4gPiA+ID4gZWZmZWN0aXZl
bHkgZGlzYWJsZSBHUk8gdW50aWwgQWNjRUNOIGNvdW50ZXIgZmllbGQgY2hhbmdlcyBzdWNoIHRo
YXQgQ1dSLWJpdCBiZWNvbWVzIDAuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGVyZSBpcyBubyBo
YXJtIGRvbmUgZnJvbSBub3QgaW1tZWRpYXRlbHkgZm9yd2FyZGluZyB0aGUgQ1dSJ2VkIA0KPiA+
ID4gPiA+IHNlZ21lbnQgd2l0aCBSRkMzMTY4IEVDTi4NCj4gPiA+ID4NCj4gPiA+ID4gSSBndWVz
cyB0aGlzIGNoYW5nZSBjb3VsZCBpbnRyb2R1Y2UgYWRkaXRpb25hbCBsYXRlbmN5IGZvciBSRkMz
MTY4IA0KPiA+ID4gPiBub3RpZmljYXRpb24sIHdoaWNoIHNvdW5kcyBub3QgZ29vZC4NCj4gPiA+
ID4NCj4gPiA+ID4gQEVyaWM6IFdEWVQ/DQo+ID4gPg0KPiA+ID4gSSdtIG5vdCBFcmljIGJ1dCBJ
IHdhbnQgdG8gYWRkIEkgZm9yZXNhdyBzb21lYm9keSBtYWtpbmcgdGhpcyBhcmd1bWVudCBhbmQg
dGh1cyB3YW50ZWQgdG8gbm90IGhpZGUgdGhpcyBjaGFuZ2UgaW50byBzb21lIG90aGVyIHBhdGNo
IHNvIGl0IGNhbiBiZSBwcm9wZXJseSBkaXNjdXNzZWQgYW5kIHJlamVjdGVkIGlmIHNvIHByZWZl
cnJlZCwgZWl0aGVyIHdheSBpdCdzIG5vdCBhIGNvcnJlY3RuZXNzIGlzc3VlLg0KPiA+ID4NCj4g
PiA+IEkgYWdyZWUgaXQncyBwb3NzaWJsZSBmb3Igc29tZSBkZWxheSBiZSBhZGRlZCBidXQgdGhl
IHF1ZXN0aW9uIGlzIHdoeSB3b3VsZCB0aGF0IG1hdHRlcj8gIkNXUiIgdGVsbHMgc2VuZGVyIGRp
ZCBhbHJlYWR5IHJlZHVjZSBpdHMgc2VuZGluZyByYXRlIHdoaWNoIGlzIHdoZXJlIGNvbmdlc3Rp
b24gY29udHJvbCBhaW1zIHRvLiBTbyB0aGUgcmVhY3Rpb24gdG8gY29uZ2VzdGlvbiBpcyBhbHJl
YWR5IGRvbmUgd2hlbiBHUk8gc2VlcyBDV1IgKHNvbWUgbWlnaHQgaGF2ZSBhIG1pc2NvbmNlcHRp
b24gdGhhdCBkZWxpdmVyaW5nIENXUiBjYXVzZXMgc2VuZGVyIHRvIHJlZHVjZSBzZW5kaW5nIHJh
dGUgYnV0IHRoYXQncyBub3QgdGhlIGNhc2UpLiBXaXRoIFJGQyAzMTY4IEVDTiwgQ1dSIG9ubHkg
dGVsbHMgdGhlIHJlY2VpdmluZyBlbmQgdG8gc3RvcCBzZW5kaW5nIEVDRS4gV2h5IGRvZXMgaXQg
bWF0dGVyIGlmIHRoYXQgaW5mb3JtYXRpb24gYXJyaXZlcyBhIGJpdCBsYXRlcj8NCj4gPiA+DQo+
ID4gPiBJZiB0aGVyZSBhcmUgb3RoZXIgc2VnbWVudHMsIHRoZXkgbm9ybWFsbHkgZG9uJ3QgaGF2
ZSBDV1Igd2l0aCBSRkMgMzE2OCBFQ04gd2hpY2ggbm9ybWFsbHkgc2V0IENXUiBvbmNlIHBlciBS
VFQuIEEgbm9uLUNXUidlZCBzZWdtZW50IHJlc3VsdHMgaW4gZmx1c2ggYWZ0ZXIgYW4gaW50ZXIt
cGFja2V0IGRlbGF5IGR1ZSB0byBmbGFncyBkaWZmZXJlbmNlLiBUaGF0IGRlbGF5IGlzIG5vdGhp
bmcgY29tcGFyZWQgdG8gR1JPIGFnZ3JlZ2F0aW5nIG5vbi1DV1Igc2VnbWVudHMgZW4gbWFzc2Ug
d2hpY2ggaXMgaW4gbiB0aW1lcyB0aGUgaW50ZXItcGFja2V0IGRlbGF5IChzaW1wbGlmaWNhdGlv
biwgaWdub3JlcyBidXJzdGluZXNzLCBldGMuKS4NCj4gPiA+DQo+ID4gPiBJZiB0aGVyZSBhcmUg
bm8gb3RoZXIgc2VnbWVudHMsIHRoZSByZWNlaXZlciB3b24ndCBiZSBzZW5kaW5nIGFueSBFQ0Vz
IGVpdGhlciwgc28gdGhlIGV4dHJhIGRlbGF5IGRvZXMgbm90IHNlZW0gdGhhdCBpbXBhY3RmdWwu
DQo+ID4gPg0KPiA+ID4gU29tZSBtaWdodCBhcmd1ZSB0aGF0IHdpdGggdGhpcyAic3BlY2lhbCBk
ZWxpdmVyeSIgZm9yIENXUiB0aGUgc2VnbWVudCBjb3VsZCB0cmlnZ2VyIGFuIEFDSyAic29vbmVy
IiwgYnV0IEdSTyBzaG91bGRuJ3QgaG9sZCB0aGUgc2VnbWVudCBmb3JldmVyIGVpdGhlciAodGhv
dWdoIEkgZG9uJ3QgcmVjYWxsIHRoZSBkZXRhaWxzIGFueW1vcmUpLiBCdXQgaWYgd2UgbWFrZSB0
aGF0IGFyZ3VtZW50ICh3aGljaCBpcyBubyBsb25nZXIgRUNOIHNpZ25hbGxpbmcgcmVsYXRlZCBh
dCBhbGwsIEJUVyksIHdoeSB1c2UgR1JPIGF0IGFsbCBhcyBpdCBhZGQgZGVsYXkgZm9yIG90aGVy
IHNlZ21lbnRzIHRvbyBkZWxheWluZyBvdGhlciBBQ0tzLCB3aHkgaXMgdGhpcyBDV1InZWQgc2Vn
bWVudCBzbyBzcGVjaWFsIHRoYXQgaXQgaW4gcGFydGljdWxhciBtdXN0IGVsaWNpdCBBQ0sgQVNB
UD8gSXQncyBoYXJkIHRvIGp1c3RpZnkgdGhhdCBkaXN0aW5jdGlvbi9DV1Igc3BlY2lhbGl0eSwg
dW5sZXNzIG9uZSBoYXMgdGhhdCBtaXNjb25jZXB0aW9uIENXUiBtdXN0IGFycml2ZSBBU0FQIHRv
IGV4cGVkaXRlIGNvbmdlc3Rpb24gcmVhY3Rpb24gd2hpY2ggaXMgYmFzZWQgb24gbWlzdW5kZXJz
dGFuZGluZyBob3cgUkZDIDMxNjggRUNOIHdvcmtzLg0KPiA+ID4NCj4gPiA+IFRodXMsIHdoYXQg
SSB3cm90ZSB0byB0aGUgY2hhbmdlbG9nIGFib3V0IHRoZSBkZWxheSBub3QgYmVpbmcgaGFybWZ1
bCBzZWVtcyB3ZWxsIGp1c3RpZmllZC4NCj4gPiA+DQo+ID4gPiA+IE9uIHRoZSBmbGlwIHNpZGUg
YWRkaW5nIHRvbyBtdWNoDQo+ID4gPiA+IEFjY0VDTiBsb2dpYyB0byBHUk8gKGkuZS4gdG8gYWxs
b3cgYWdncmVnYXRpb24gb25seSBmb3IgQWNjRUNOIA0KPiA+ID4gPiBlbmFibGVkDQo+ID4gPiA+
IGZsb3dzKSBsb29rcyBvdmVya2lsbC4NCj4gPiA+DQo+ID4gPiBUaGUgdXN1YWwgYWdncmVnYXRp
b24gd29ya3Mgb24gaGVhZGVyIGJpdHMgcmVtYWluaW5nIGlkZW50aWNhbCB3aGljaCBqdXN0IGhh
cHBlbnMgdG8gYWxzbyBzdWl0IEFjY0VDTiBiZXR0ZXIgaGVyZS4gVGhlIFJGQyAzMTY4IENXUiB0
cmlja2VyeSBpcyB3aGF0IGlzIGFuIGV4cGVjdGlvbiB0byB0aGUgcnVsZSwgYW5kIGFzIGV4cGxh
aW5lZCBhYm92ZSwgaXQgZG9lcyBub3Qgc2VlbSBldmVuIHRoYXQgdXNlZnVsLg0KPiA+ID4NCj4g
PiA+IFRoaXMgQ1dSIHNwZWNpYWwgZGVsaXZlcnkgcnVsZSwgb24gdGhlIG90aGVyIGhhbmQsIGlz
IGNsZWFybHkgaGFybWZ1bCBmb3IgYWdncmVnYXRpbmcgQWNjRUNOIHNlZ21lbnRzIHdoaWNoIG1h
eSBoYXZlIGxvbmcgcm93IG9mIENXUiBmbGFnZ2VkIHNlZ21lbnRzIGlmIEFDRSBmaWVsZCByZW1h
aW5zIHVuY2hhbmdpbmcuIE5vbmUgb2YgdGhlbSBjYW4gYmUgYWdncmVnYXRlZCBieSBHUk8gaWYg
dGhpcyBwYXJ0aWN1bGFyIGNoYW5nZSBpcyBub3QgYWNjZXB0ZWQuIE5vdCBhbiBlbmQgb2YgdGhl
IHdvcmxkIGJ1dCBpZiB3ZSB3ZWlnaHQgdGhlIHByb3MgYW5kIGNvbnMsIGl0IHNlZW1zIHRvIGNs
ZWFybHkgZmF2b3Igbm90IGtlZXBpbmcgdGhpcyBzcGVjaWFsIGRlbGl2ZXJ5IHJ1bGUuDQo+ID4N
Cj4gPiBIaSBQYW9sbywNCj4gPg0KPiA+IEkgYWdyZWUgd2l0aCB3aGF0IHdhcyBtZW50aW9uZWQg
YnkgSWxwbyBhYm92ZS4NCj4gPg0KPiA+IEJ1dCBpZiBFcmljIGNhbiBzaGFyZSBleHRyYSBjb21t
ZW50cyBvciBzb21lIHBhcnRpY3VsYXIgY2FzZXMgd291bGQgYmUgaGVscGZ1bC4NCj4gPg0KPiA+
IFNoYWxsIHdlIHN1Ym1pdCBhbGwgcGF0Y2hlcyB3aXRoIGNoYW5nZXMgKGFuZCBrZWVwIHRoaXMg
cGF0Y2ggdW5jaGFuZ2VkKT8gT3IgcGxlYXNlIHN1Z2dlc3Qgb3RoZXIgd2F5cyB0byBtb3ZlIGZv
cndhcmQuDQo+IA0KPiBIbW0uLi4gbWF5YmUgbm93IGlzIGEgZ29vZCB0aW1lIHRvIGFtZW5kIHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9ncm8uYw0KPiANCj4gSW4gZ2VuZXJhbCwgdGhlIGxh
Y2sgb2YgdGVzdHMgaW4geW91ciBzZXJpZXMgaXMgbm90IHJlYWxseSBhcHBlYWxpbmcgdG8gbWUu
DQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLCBhbmQgSSB3aWxsIGxvb2sgaW50byB0aGlzIHRv
b2wgKEFueXRoaW5nIEkgY291bGQgcmVmZXIgdG8gdXNlL3VwZGF0ZSB0aGlzIHRvb2w/KS4NCg0K
QWxzbywgbWF5YmUgd2UgY291bGQgbW92ZSB0aGlzIHBhdGNoIHRvIGEgbGF0dGVyIHNlcmllcyBh
bmQgbWFrZSBvdGhlciBwYXRjaGVzIGJlaW5nIHJldmlld2VkPw0KDQpDaGlhLVl1DQo=

