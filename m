Return-Path: <linux-kselftest+bounces-45024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE72BC3CDE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 18:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55063502F1A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7805234EF1F;
	Thu,  6 Nov 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AMdZV6kB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6933A006;
	Thu,  6 Nov 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450247; cv=fail; b=Cayxar1iwBhgBRIobxM9eCNBz11MMVACaJJhD223lBZSxE0XnjI3JrmWsZkQLdyQjWZID2vWus/wUxSkmzHihyl8Ris1jsagyr8TEQaMj7uf1zRwLl8lQvg3uvBMR40NGpU3T3RmyMBTTphsUcTF+09CmBHAcOApI5oXV+mvtwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450247; c=relaxed/simple;
	bh=vG1UcTrO+hBKDvPROVQnXse7pZUFXEslL0+g4uS3FZc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+lEgzsWdsfctwItSWllkaDlDNPaol8MnKVJCXrscxNkTmK1tVmhKCqiO3iNtbPH/NGPVCZo4v7vFRiTPeQZ/6RnJNi6aJ1fhOqijOL0vTuefY5pX60MEXcZL3OFnAP7SusVJINQObhSxGAIT516VsXRMHxHZEtb/KuniTLDXEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AMdZV6kB; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPJxD2uHxUAaneRXzoXA/7dj13UiyjUPRQmCPRuyE2wmoydQUE4DY/tNKFUm5YSIhGMONRlwK86zz4LCTR5muyw93pTaH6VmSMJQ8ZS2XJfd+3ae3qYWk782WowxPGQ7ETg6AtUgZDGtgNCFTOab60zftA1n4dUHRwz/VUxV5DJOnw8Y48ErrO26Z3tZqUs+O2uRq41IulyXhG48PCNOeBj+AzOyJ/HtY3fsyYlA4uX2G3TE+bn6oFicG0v4/8y1vfclvsIZrAWgKE+WCefuyylMKzhUj2O5u8VIGpvj31ql1TAW//oCU2TLaGYg+8pMAkgLR4OofCZJjEku7FCfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG1UcTrO+hBKDvPROVQnXse7pZUFXEslL0+g4uS3FZc=;
 b=b1OYx1xZJnR5x9UHiaJ+UUjm7mE5a2CJPDUSU2ZPa12r4u/6HODi7piQtqk7aijSHmSWNcIygHqYcU1wmiUeWww7MsfYjKGlm/yeLhGvl8xSnbsDyXGAZ1i4JIk4kSKfj6zRfoM+9V5oYwPyzKj6VOi3vZMYHC4UjkXr7hkHmkbgH1/bwBwMCISGs5OceZbX1xvsKOGYOGxy90WoIhKcMexbdCPKHm3cbO9bEyOMHY2v97vn1miNSW73YWwhy5L52EV6AKv/LOFePtGQggnOkQSqNkz6PQXC9it8ZenmngsdP4PD3pxk8g7FCp3bFe9eaUnEsQDB8+uNsB9sGOuHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG1UcTrO+hBKDvPROVQnXse7pZUFXEslL0+g4uS3FZc=;
 b=AMdZV6kBazTihqIHVikmv1SYeEIBQmuQ7V2TeImFjJ/tK35x36PGRyu/CtGuS6NKbcefGUgpxAzZxouTtc+LTZjntURbJtevtAzRLa38BQIqF4DGNLcio1ein4OexsWYzqFCUrjoTLDEvswcbio21CRtN85Z6OAiiUuHIVak0RKT0A9FaREsL8jdFImsD+t5DHI9hYtrbR0xBdrnyEQ/yeErpz0L3MO3b8vMwTc5wToJHaRLJStQilMjxcIecPETaBRh8YAXXyJwwOuxu8VlIEchEzlXuOSPQGGR6yth9+LqIjC6+myuB3UNyMB/vSQO7AL7gJ5HOLdzEOlA6tTj5w==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB9067.eurprd07.prod.outlook.com (2603:10a6:20b:56a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 17:30:41 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 17:30:41 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
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
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v5 net-next 11/14] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
Thread-Topic: [PATCH v5 net-next 11/14] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
Thread-Index: AQHcSapdfdHsQpf87kOefzyXnm5eh7Tlm1iAgABFPJA=
Date: Thu, 6 Nov 2025 17:30:41 +0000
Message-ID:
 <PAXPR07MB79842FCCAAC5FE8C18DFE77DA3C2A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-12-chia-yu.chang@nokia-bell-labs.com>
 <f88dac3b-3467-44cf-9725-7d8525615bda@redhat.com>
In-Reply-To: <f88dac3b-3467-44cf-9725-7d8525615bda@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB9067:EE_
x-ms-office365-filtering-correlation-id: 3ffd77ce-ded1-4b9b-e634-08de1d5a356f
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0JQT2F0SXJmU2lBYisxbFRUVkNhN0Z0eVRtZ1FqOVh3YklycE1Zb2ZieDk2?=
 =?utf-8?B?dXoxRHdoakgyU1NzVTRRYTlRdzM0amtMMmRRK002cGxYWUNMdjVNNmhXZmtj?=
 =?utf-8?B?WWV5ajNqYnNoaFFOU0pkWjNpTHluSmR6TDd0aWM1c0piTjVmYmt3dWxOVXZu?=
 =?utf-8?B?eHJDSHo3dTg3NnlrVE1VYzlTUE45WWFsbW5XR0NFdDZIbFhNZ0hhR3dGeFF0?=
 =?utf-8?B?RFhRYkN4WlFldHFDNXVpQVZaemF1WlNJT2Y1bmhmdHQ2eG1zRFlnS2Z6ZWpW?=
 =?utf-8?B?VDBuTEpmNGNVRE9LL29MVUhDNXZQUXlGWFRLUzAvWnFFcDNOR3JqU3RCdGRt?=
 =?utf-8?B?ekpSRWZPZTRHMlhiSVNwenVzOUxWQUVlMlVZNkNFT1JibzdDeWRxMUFZK2hp?=
 =?utf-8?B?MFlsb3dHMCtkRW1UQnhlTFJrOFo2MFczSUk1MlBVK05BWkwyR29veXpQNEFY?=
 =?utf-8?B?NlZZUjNGTUFNRldyU2JCa3B5azBsNk5LcW9wMVZCeUlPWEorNjV3Qjdpb1BJ?=
 =?utf-8?B?a2pUQmsxT2QxNXc0L1RjVlZMbmFlMmo4UVJjSHp2SVR4WmFIRStDS3M1NWh3?=
 =?utf-8?B?djBVWER3QnhmUlFsMTdxRjViUUhXU01uRXBLbUptR1prQnZpWGdLRTdHKzdX?=
 =?utf-8?B?a2haaXllOVZ4RFEwTDl5VVJvQXNTM2s2d2E5aEpuYUNVQ1hYZWZ3b3kxaDFG?=
 =?utf-8?B?dDhwanQzZURDRjhtUlI1Q1VQaEtKRU5qMzgyK01EN2xQZjZqZHZKeEtUWjhz?=
 =?utf-8?B?alBFcWJ3Vm1SRDB6anZBOE5sbnNETndWQ2ZxeUtJZ0t2YXd3KzNFOXk3WUpj?=
 =?utf-8?B?NDZlV0FtSWIzUzFCaHd4Smw5aE9JQklRMUFaeHBlTCthYW1UVW4zSjBKOC95?=
 =?utf-8?B?TE9sZi9ibTF4T01jcGR1VmliOE54Qld1UnNkY05NVXFXbngzSmJPSTJaRmtD?=
 =?utf-8?B?RzduWW5FNmRSb0tvcWdmY1ZUSkg5NGtwcGtDMkYzOGpVVGIzb0s4V01JRU1O?=
 =?utf-8?B?Zy9zT0tuYjgra01ZaVFjUUV6WkZEWlN4T1lCbnEvVWJackZNbzZ6cDAySjlM?=
 =?utf-8?B?MUVMYklMaUtiRmlNTDl0emxpdnFjaUVmcHJJc3RWaXpEbnNYVmZZTGhKeTE5?=
 =?utf-8?B?d2NiVHZNenh6aUpnQncyak1ycjRVcStmM2tpVm5RSEhFdVp0VDZtOUtlaHRr?=
 =?utf-8?B?ditWcDhIeE43M1RYeDFLaFFoYmVrcHlGcG9CZGcxdFROTmxjVDFNbll2YVFZ?=
 =?utf-8?B?SDRtaHFoeEFOQ1VqN3hWNnZpMTZxUk4xajMzVC9PVVFkdkxIeDNSY01ZVnVn?=
 =?utf-8?B?UkhjMFYxWVB4Ry9sdWVsajlKbm5RRWZJbm1Nd2tzVEk5dkxZMURFM1R2T1dn?=
 =?utf-8?B?T3JweUp4NzY0bC8zQkZmM0x2Ly9yMktOdlc3NEp3OXhnVVVXVDkxMmViMkRB?=
 =?utf-8?B?WWxjaGg0RmIyZmUrMDg5OUVLSXloNkdIWlk4c203dE1DQTZRdFhRdXFTNzl2?=
 =?utf-8?B?azBvMFVZWkx1NUQ3c0hVY3o3dzBnOE91U2lOQWEvVGlwVERTZ2w2aDQ1REJx?=
 =?utf-8?B?MEhueFRhK1YvN1BZaS9Jbmo1cTgvbTVVQ05PR0VKK1JMVHJCVkkrdlp3Q1Nk?=
 =?utf-8?B?NzdJYnVpOFcvcWd1dDJrZ3pRR0JiNGc4WkdrdkRHR05ZTGNDT3FMaVhCblRX?=
 =?utf-8?B?SzYvS2R0d1UyVXc3bHZNYi94aE5MWk1seUtEcTZOazJaM1FpekNKMWw4T3RN?=
 =?utf-8?B?dWV0RGFWTE4yU2tUcGVoR1F2MFo1bVVNZjVLRHVwT25oTmZ1TTE5QjBUQ2NO?=
 =?utf-8?B?ODdReklQZitZRHhyUkszRW1zYUVnMytCNitQWU9aQkVHTDNMNnVsSk5pV1Nj?=
 =?utf-8?B?SVA0VDRXMVJLd0VFWVhTTDZCMVFuNkN0V0hxQ1hCRktiSkNFblZIa210bW43?=
 =?utf-8?B?QitrZDJUSlJQb3RZYXk4SmkvZ0ovSWZIeVpuSHhBN3JKNXFPcC9UMHAyWU1o?=
 =?utf-8?B?S3YzNmdnLy9MN2ExczkySGJxMU94aUgreWVjRXU3S01lVWxhdEVkaXk5bGJ5?=
 =?utf-8?B?ODFKN2dGeFJBZmhUS0ozb1ZERlY3cWZST0szQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVVtQVlibWVRaFJxbmlCUGovbGNUSVNEQlg0ZEtCNWJSRk10aHJEeEF2dmIy?=
 =?utf-8?B?QWs1ZUxUQVg0eHNJbU02V2MwNlpPWFN4VXBRN3FGaEtEOHoxV3A4Ymc4Q0Zi?=
 =?utf-8?B?M1RpcklyOHBEUnFpMWtsMGZ2b2NvaWVicjAzOUxObTdzVCtZZEhaNXJZZlBi?=
 =?utf-8?B?U2wvTTdhWUUySVVvUms0T1hLMmRnd2VxdkVUZ0xBUkxjWU5lb1BFcHVlenZu?=
 =?utf-8?B?Uk42RmRhUE9iS0twY21uZTcxcklNUlZtWkQzUHk3ODhjVW9nS3RsRG1YY0oy?=
 =?utf-8?B?Tm1kaUZRYnh5WGhjUFBkdzFhYjl4c0l0bGIwRThPVTVJcElIdVhrMnJITENz?=
 =?utf-8?B?WC9uTUlRM1VzQXhCSWI5dTYzTWU3ZUJFVUdZT2VTZ1NuR3luMjM1NUJnY0Fx?=
 =?utf-8?B?aElJSlEwVHpuSEpqbXB0ZGpDTTRlU044a1VISTV6NUNONUo4ZHJKcENqRFVj?=
 =?utf-8?B?YlM3Uk1FRTNSbVdKOFhFZS9qMEQ5VWNkKzFmMUVpM0k1TDBTeFJ3aGVZalUx?=
 =?utf-8?B?NEN1ZmVyNW4vMUlGYkZPUXdJalBsaVlrb0EwWE5VQjloeHEzcEcwbDBSV3F3?=
 =?utf-8?B?Z3VIaE1MSkk3OEl6Y2N2cEZyRTh5cnQra0kySDMrRGJScWk3SVNjaGwzRlA0?=
 =?utf-8?B?VWhEZUg0QTBPTXkxRHNMaStPOXlDcVNRWGVuV05DN3NMNGh3a0dvUXdZTWdG?=
 =?utf-8?B?MFJXV3RHM2pNUk1jbW00eUxvRmxVWWdQN2Fza0lya0tWZTBpSGlIeUNwV1Jj?=
 =?utf-8?B?STNIejZnVlcxbnRmd1JkbEpibll5RnlCdVdzbngvY21yMGhyT3M1b2IyOXhD?=
 =?utf-8?B?VWJha3JnL3dxK2FGQ2RWQW9ORXdFMFNrdHVVQ2lHVzNJYWE5V2hRS1BBaTFz?=
 =?utf-8?B?WXNMVDYwK09oZXZGbGNLclBteTNSYVh1OFQ2U1d1V1RVcXNBWWp6Tjg2b3R0?=
 =?utf-8?B?bkhWaU5qczlVeFlNSVpIYUhhNjFYL3Q0VzBwdVZlbnpCa2paNTRCVEpYeG1H?=
 =?utf-8?B?NTJhUVVSbW5jSXlnc3M5dGdXaS92eTg0NjNOUGNoSmppL1pIZU1QL2gwbDZq?=
 =?utf-8?B?UlVHOTBxbWx2NnFubG9KSHd5aWxYVlk5N1czTkdxcDNUUVZTc0o4bzRGOHkv?=
 =?utf-8?B?amo5eWZIUlA2WmF4S3psRG41bk5pT1hqdkF6bGcybFlYc3p6TndpbVdKN1NJ?=
 =?utf-8?B?ZGZFNHRUOXNKdXJzSTNGUXlBeTVBYUdVcVd4VjNmQjBsWC9CSW93VzBUNy9R?=
 =?utf-8?B?NjA0dERlZWFKcHZxRmNGc1JuRGZpM2VrdkVZbkk1eUo5Ynl1R0xacDNRUmZY?=
 =?utf-8?B?ajBkcUIzRWJwek9wdlJ0MjhJdHlMdFdtWHZLa3FHb2dyZFpTSjYza2tlSGgr?=
 =?utf-8?B?QW56bElOS0gvVEpaZVQ3ZnZHakg2dGtNQVl6VEMrSVkrYS9PK2J1VkFQa0pO?=
 =?utf-8?B?UldwdStvbmNic3ZOb0VlVTF6a2ZhbzBEVmtCWXRsS0dqWGpnbXJweEh4WUhE?=
 =?utf-8?B?Y1gxcXI1aEoyeEJNY2NMRyt0UVdWR0lZcWtoa2JRby94dFl2U3lUL3hBdEds?=
 =?utf-8?B?eGtSdzRrVy8xREFMOXJ1SUJQVkNJWHQvZy8yd0hWL0NYaTVRRWN6RjhwcytO?=
 =?utf-8?B?WnJQM3JWTWlaMVZwLzJqeG1Ba3Y3RC82ZmMwbkNkMUNzbXpQa1dvOE84bS9k?=
 =?utf-8?B?M2RkTHdQeC8rb3YrdHNCdmZvY0RqWnB2MkFRMkk0eGRPS3AxMGZsdlVrQ1Bn?=
 =?utf-8?B?RnY0YUFYUW1rR1VQY29CYlcwc2VzMWJDSzYwNVdoWjFSRzJkV1RobS9hN2Ri?=
 =?utf-8?B?SjN6SlRqWnpsaXp0YUFMUXp5WlYwcEhab3RFUDZ2amp3d1VFcUFuNjhHR1pP?=
 =?utf-8?B?YkdYejgrMkZWdmxiMWxUYTk3RFpBUHhuNHJXOWxyOG9FZ1lwYUJudHBrTXJT?=
 =?utf-8?B?a1BYVWtYWVhaZW9pQ3k1K1djQUdYWm40UTdab0hSRkorY0tTNnF3Smp2endQ?=
 =?utf-8?B?T1ZMNERucmNJTU5xaVduOGM4N2FRZStYWko0N2gyeVhlUUQrVk95dXJJRlBI?=
 =?utf-8?B?aGVaUENubG04TUV5R1F6NXBocnAzRGFKL2xnOUd2S2pRRUtVa1VzTHZ3VmZY?=
 =?utf-8?B?K2p5VkF6RUdWR2lGOWEzdm9MRmYrYWVsZC9DMlF1aWFtTXYyZitYVFBVaFRm?=
 =?utf-8?B?Vmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffd77ce-ded1-4b9b-e634-08de1d5a356f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 17:30:41.3569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pr/uIQZS9+5llK/plxPK58AtIPb8ToT4HseAqoFrbrCQdhi6IYcX8WFBGa50ProGv+6TWuos669T9fcRnkBkdUhm0dINXOhmFDMweRKLU3oVPwc2wERxm23ka2xnJ4e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9067

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNiwgMjAyNSAxOjE4IFBN
DQo+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1s
YWJzLmNvbT47IGVkdW1hemV0QGdvb2dsZS5jb207IHBhcmF2QG52aWRpYS5jb207IGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2Fo
ZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBnb29nbGUuY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUu
Y29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53
YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJl
cmJ5Lm5ldDsgbGl1aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtz
ZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUu
Y29tOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVs
bC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgaW5nZW1hci5zLmpvaGFuc3NvbkBl
cmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZSA8Y2hl
c2hpcmVAYXBwbGUuY29tPjsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0
LmNvbTsgVmlkaGkgR29lbCA8dmlkaGlfZ29lbEBhcHBsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjUgbmV0LW5leHQgMTEvMTRdIHRjcDogYWNjZWNuOiB1bnNldCBFQ1QgaWYgcmVjZWl2
ZSBvciBzZW5kIEFDRT0wIGluIEFjY0VDTiBuZWdvdGlhaW9uDQo+IA0KPiANCj4gQ0FVVElPTjog
VGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNs
aWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9l
eHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4gDQo+IE9uIDEwLzMwLzI1
IDM6MzQgUE0sIGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbSB3cm90ZToNCj4gPiBA
QCAtNDAwNiw3ICs0MDA4LDcgQEAgc3RydWN0IHNrX2J1ZmYgKnRjcF9tYWtlX3N5bmFjayhjb25z
dCBzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBkc3RfZW50cnkgKmRzdCwNCj4gPiAgICAgICBtZW1z
ZXQodGgsIDAsIHNpemVvZihzdHJ1Y3QgdGNwaGRyKSk7DQo+ID4gICAgICAgdGgtPnN5biA9IDE7
DQo+ID4gICAgICAgdGgtPmFjayA9IDE7DQo+ID4gLSAgICAgdGNwX2Vjbl9tYWtlX3N5bmFjayhy
ZXEsIHRoKTsNCj4gPiArICAgICB0Y3BfZWNuX21ha2Vfc3luYWNrKChzdHJ1Y3Qgc29jayAqKXNr
LCByZXEsIHRoKTsNCj4gPiAgICAgICB0aC0+c291cmNlID0gaHRvbnMoaXJlcS0+aXJfbnVtKTsN
Cj4gPiAgICAgICB0aC0+ZGVzdCA9IGlyZXEtPmlyX3JtdF9wb3J0Ow0KPiA+ICAgICAgIHNrYi0+
bWFyayA9IGlyZXEtPmlyX21hcms7DQo+IA0KPiBXaG9vcHMsIEkgbWlzc2VkIHRoZSBjb25zdCBj
YXN0IGluIHRoZSBwcmV2aW91cyByZXZpc2lvbnMuIFRoaXMgY291bGQgbWFrZSB0aGUgY29kZSBn
ZW5lcmF0ZWQgYnkgdGhlIGNvbXBpbGVyIGZvciB0aGUgY2FsbGVyIGluY29ycmVjdCAtIGFzc3Vt
aW5nIHRoZSBjaGFuZ2VkIGZpZWxkIGlzIGFjdHVhbGx5IGNvbnN0YW50Lg0KPiANCj4gSSBkb24n
dCBoYXZlIGEgZ29vZCBpZGVhIG9uIGhvdyB0byBhZGRyZXNzIHRoaXMuIENoYW5naW5nIHRoZSBh
cmd1bWVudCB0eXBlIGZvciB0aGUgd2hvbGUgY2FsbCBjaGFpbiBsb29rcyBsaWtlIGEgbm8gZ28u
DQo+IA0KPiAvUA0KDQpPbmUgdGhvdWdodCBJIGhhdmUgbm93IGlzIHRvIGFkZCBvbmUgZXh0cmEg
ZmxhZyBpbiByZXF1ZXN0X3NvY2suDQoNCkJ5IHVzaW5nIHRoaXMgbmV3IGZsYWcgaW4gcnF1ZXN0
X3NvY2sgYWZ0ZXIgY2FsbGluZyB0Y3BfcnR4X3N5bmFjaywgdGhlIEFDQ0VDTl9GQUlMX01PREUg
Y2FuIGJlIHNldCBpbiBzay4NCg0KV291bGQgaXQgbWFrZSBzZW5zZSB0byB5b3U/DQoNCkNoaWEt
WXUNCg==

