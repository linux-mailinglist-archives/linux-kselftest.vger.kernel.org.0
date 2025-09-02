Return-Path: <linux-kselftest+bounces-40590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A99FB40045
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C90F189EBCF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1E12C026F;
	Tue,  2 Sep 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aNPVR5pT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9A2874E9;
	Tue,  2 Sep 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815834; cv=fail; b=amMi7bRuNYltfuyits8abSWqSZswqNuEv76TIJVX25z5exNNGqqlu7ePXXqcY4+72YacQ3nt/eXj4qL1ZdTnYy/dC3x9JhMASeIzj4fTRQOsfrMif/0cu+lvsL+1nt8RDgFOYWYhTdfKSayLaUy7cmadExfay5RoYgIP2Jh8hLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815834; c=relaxed/simple;
	bh=lmSb6ziqRSYcjO2QC/7wXfjPtkWTQkWTF1u76pkEcGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N+kV9lEFykdL0ghm+F6ZMLRlC4KE9h1PV0QGkSe3pdYoZg6Q38XLyW3JEAMNHYQC9TGIYveTUc+LvcTNGKA+cOChk3y1pg59YfVFPZXUEXeMgHxIP0jj9Eel5plxwGsRBhsXpI2UOgoZ3Se9TbrrhKASjZZMi34EOeASgjEGacs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aNPVR5pT; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hv62Ux1jifbatekFDke6N6ONSCZbFbhw3kN+lcK5+NoohWTESNWDzJiXNSnF0Z/0SnNB9Em5sS6+Gz7e6AvvHeDzYeBSW7vVoZxvNU/mgf5eRTFWhS/rDOoPdU/PhhAMeAzptIfO6nj0mq7WgpCeU/nX2q9/iqEJvStAAVgJFLwAirlmPGoEs1ghpf1GtaP44/nKlmK1g4O6E1DQciDIRvkDBC2bUGB0E+NgNjqBteSLBe1fWpa+IlYn6XpoJ5e5d/R8cXxYSAVUvxC9+wQtho5yN4yrmA813AFrqTJEW5WkxwCauNKhB8xWdwa/S42L/BKTRjGYMO+iWFqKS0/t0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmSb6ziqRSYcjO2QC/7wXfjPtkWTQkWTF1u76pkEcGo=;
 b=QWTSmjr7sdxJhSbU9SUKhPGASh4p9PE9LeNR3C9Agerh1G3BklIS3rEa68WveUpAqerWKHGOYUnBKS9OQbG3fO1ioYK64vmwwkSEklfIvlJKfSXDYrHqF57Xx1BcGB22oJSJAF3isErOFKkQJpaXTBeOIBmFQ1XYUxiu1xwgv5+W908NJ0gByl3BNRUvGTAH7JB6vkw30Brvc04dotDBG8pcJwyegraSvv1UJpco7dfesz7/hIwc69tk8BjN6Fq9tYwkIeuPYbG9xojKg+M84dZjVHiczC1qD6f2NjyyrwFtdvpq8suz9X7rx2N626Sb7dY2FLZew49Gb1pXz1uSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmSb6ziqRSYcjO2QC/7wXfjPtkWTQkWTF1u76pkEcGo=;
 b=aNPVR5pTNiLpRXp/rXijk1xBjuhjUQLYesazY5N1RhlijhWhmLhIFLJFaNuy7wBSa96Sduvl/V3Tg3E0AkZvXbYL8Pi+MvTLBB5IBaxZpiTDUXsJJnMQrn9045ViMV10YLYssWGUWr/Gh6oGm69blPW4G/psRX/GednKEEcP9Mz2aESskOmXyI24z+pVDWEN8cUda1vYCFOucXuFHKnES7BuRBW/ZoV8xVZ8cfAqKpt0PMTvslghAKz9ATQ37oTPn4Ij1mnkQOB1C8CqBjLSfd0FlFK8Gi0oip8rPFN8w35YdPgAi6PIx3Ok6jj5yGV00Ev42SK5mxXjwfy9ycLJNA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAWPR07MB9346.eurprd07.prod.outlook.com (2603:10a6:102:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 12:23:48 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 12:23:48 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
Thread-Topic: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
Thread-Index: AQHcDcAxy2pRdXRRoEee7i9sQ4q1KrRtEwQAgAAi57CAADWdAIASgLeA
Date: Tue, 2 Sep 2025 12:23:48 +0000
Message-ID:
 <PAXPR07MB7984B32F3B306334EE2B8C36A306A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
 <20250815083930.10547-11-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKPTWBdi8upoxjFok2CPFhkGB9S3crZcefZ0mRhFHGPhQ@mail.gmail.com>
 <PAXPR07MB798496F6B674558AFD2B1641A332A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CANn89iKyU-r93MWukKRh4qPmEgLwSNKudOp_xQ2A6YpaWoUJFw@mail.gmail.com>
In-Reply-To:
 <CANn89iKyU-r93MWukKRh4qPmEgLwSNKudOp_xQ2A6YpaWoUJFw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAWPR07MB9346:EE_
x-ms-office365-filtering-correlation-id: 05766817-e2b7-4c1f-00d6-08ddea1b91a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWUwUGNJY3B5cmVFNllFVFVqcFppQkMzL1VnVXZTYmlJSGtHRUNQeXdsZFdj?=
 =?utf-8?B?aDlzNzhUQ2VyMy9vOVJ1YXZjWVllbmdwUm5uVUtXNUYwWTBGVzEzaEtobUY3?=
 =?utf-8?B?ak03TnZYczZRMXVPdmlYci81S0NUaWF0MnhoRTJJa2M2Kzd0TnV6c2hKMWJm?=
 =?utf-8?B?SElUbU4vL2h5dm0yRFl6ekUvcFFpdmNqNEx6b0djOHpHLzFRa0wrbk51bmJO?=
 =?utf-8?B?eHlPWEhVUXVBZDc5TEc2UWFIWEh0RnM1dXA5OGpBRHZ1WExJWFcwU2pvRkdK?=
 =?utf-8?B?MU14b2swMHRVTmMvRFdFaUY0NHdRMUg2RXNyUTA3TFBpK2JiRXcyUm8zNEpD?=
 =?utf-8?B?QjJ4d0JIYVovOERBekpmVHFSbW9TTjN4Z0cvUW1FNXp3dlpiT0FXRDEyVWRQ?=
 =?utf-8?B?am5QSTJUTlNaQ2FwWS9wVHpjUlVrL28remg3TFczbGVmSXkzMHdYcjNTaGZD?=
 =?utf-8?B?TmpWY1pMRmpRUXR4K09jYVdrRE45ZHd4RGFUeHpBdTFaRFYxbnlrNEttdHpp?=
 =?utf-8?B?dXpZY3BGQ29uc3FXMVFwbzYvTStPMEVQTEJTTFMyeWo4cDIxbUh4eXZIVzBM?=
 =?utf-8?B?cDd4clVkQlZnNllIekVpUDlZbTVxN2VFTWtKM3pwcWQ0NWVoVC94ZmRGb2JE?=
 =?utf-8?B?MStmVHlhVnVKY1d6M2JTVWNZaU5MRE5BWUJjZExPU1RLdjF6VkhvcTJJZXZa?=
 =?utf-8?B?SmJVOGJ1NWMrOGpvMDQ5U3lsQXNLSlZNU2tGMlF6K0hQT2o5NWZTMWxrQTFZ?=
 =?utf-8?B?RHBYdTh5UDlVUXdvb3pFZEhDaTBBcU41c0FKV1NkT041a0l5RmJKU3V5K1B6?=
 =?utf-8?B?dzdvSy9wdkdYbjBycks1QkdtbmF6ZGN1UE1XQlFzMDZWZ1BRUFJGZXpoQ3JR?=
 =?utf-8?B?RG01c1VLZHNiUll2VFVSNjRMVzZJVm93MlUzNlA1RlA1UTBnbzgweXFweE9r?=
 =?utf-8?B?L2JrUmgyb1FYUExnT0NkMUF1VHlBM2Z4dW54STNLMU5KZEJwVFVCVnNCYXZi?=
 =?utf-8?B?UG9tR0k0bEdGaGRsNXpzMm9QcXRDMm9tQUNoeE5tMTNPaHpJcHNWUjZsTk9y?=
 =?utf-8?B?Wm13d0dPVFMva0tsSHd2aWpZYzdPV0FzdFpIcktnWXJOSTY4SmlBcU5DNHdq?=
 =?utf-8?B?dkI3ZG9ScUJxdk0xbjlIK0xLNVQ2cDQ5ZDJCVVlKWjVFVjFVdm5HaVFDNXBo?=
 =?utf-8?B?N25IczZqR1FxcmNkL3I1emhmM3I5cVkyaGkxdFZsTXp0SXZSQ2ZDU25OaE5U?=
 =?utf-8?B?YURjS3BjWGhWZ1JpK2ZsMkNrTTR2Si8vM0xXSExaRTJXOEZCalVzYUI1Z2wr?=
 =?utf-8?B?OFZjWG5odk1yR0Q4enk1aURjM2pab3RscEF3V3YvSFBzZlpXbSt2VVlJTGhn?=
 =?utf-8?B?c1E1ek4vMEdWK0lOcGZ2dVF1V3FhbjVPZHQ4V3pZRGFpcWxDbkpnbFVmTEhK?=
 =?utf-8?B?VXFHa0ZMMDQrcVpLWTcxOGJuRkpKSHdIQnM1R0tadkMxT3JCSWJOM0s1N01E?=
 =?utf-8?B?T2NQWEVxWEk4clRka3ZHdXNjZndaYUZYYWVabnpINDBtcStlMlppNDREUGpH?=
 =?utf-8?B?R09KOFQvanB5NExzRThpelY0YXRXdVY1YUhEMy9KbW9ScnYxTEpPdUp5bjRJ?=
 =?utf-8?B?eEdtdWtuUThRczZLVmF0MTEra1QvSE5OaHQyN0V0Y1ltTFlwc1pqcnZmWkJW?=
 =?utf-8?B?TlBLWmVyU1hDWkVJaUhOWDVocjB1QmVxRmw2WkhjRExYb1dnVlVGdHFZUy9n?=
 =?utf-8?B?UW4wMFlXcTFXaUY5OC9qNTcxcVBrQ2dURnNSSkViR1hDSkdBNXFaUWNxMWY0?=
 =?utf-8?B?ajdTWVBDUTRVeXBpUW9GOTdLejVpckVlcFh2SlB3S0dWcVBwbUJOYjJNeGRr?=
 =?utf-8?B?eE9KaXU1YUhmbkFMek5iNGtiYmQ3TWRZVXNLWmF0aVpCc3NpRGUxck9lL2dZ?=
 =?utf-8?B?QkFrVTNMcHRPTSsvZmxqaFdyMzZPV2NLd2dNd1ZjUEloSkp1bnNxUk5QNE1G?=
 =?utf-8?Q?DKGAWU0BNsnl/Z4hTMcjqpmskD2/Ok=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0IzRVRFQ05sQkxjdkdFVDI1endGZlNlSjhRdGVPOGF4UGpXdmVHREtVWUVZ?=
 =?utf-8?B?UEN0NERXL3dja1VvYUlQMmN4QTVQNHBTbXA1UUtkNTcvNXVpWEVKaFowREZp?=
 =?utf-8?B?OHprZy9HRkpSdG9UTU9Kam9sek9kTnVibmtSbGN5Q2pYOGpJeURuZ29LSHJN?=
 =?utf-8?B?ek4rcithMUJLNnByZGVwK256QnVxYS8vbzRRTEN2QmNiRHprYTFoT3hYelJh?=
 =?utf-8?B?Ui93UVR6b1hJeCtPckNFekpWazY0amkwb3EvMWRWd1h6b01WUy9VSkg5VnRr?=
 =?utf-8?B?ZXZwN0tReUFMVDN1bExoUlY5TWhmTll1NUtqMVA4czdLQXJBbmxiYVQyeVhC?=
 =?utf-8?B?bHA1UHNKNkhzMmdlWngrSkZRZW93clFGWjFiSUkxT1kzN0VTdXR3aGE2NXFZ?=
 =?utf-8?B?QW1pQStMdzhiWFN0TzB0My9vcTdKRWpUK3d1LzIrRDFodWNNRUpLamt6QXRq?=
 =?utf-8?B?a1pQSkdFYzM1aWxqUzcvREo5Mm8xSlRZTnJ5TzQyejBqaDQ3N0xRdUIvVWRS?=
 =?utf-8?B?Mk5wK01CRWtVNGRkZW40UzNVU1I5eTZrd0xxdFBIdm03eDBaZWI3S1plWTEy?=
 =?utf-8?B?Y1ZQd1luRFRoeitZWXhXVEltaWtGTllnQnBLc1V1Sm0yVXhJblEyVDhlcmZq?=
 =?utf-8?B?RHh6UWhXTTZGNFU4Zmp2KzhPTlJlc2l5Z2hsWlRjeXpxZHZ1YmVleTA2WVFC?=
 =?utf-8?B?aituOUpuNEhsSk5NY0orUnVXcFg1TTZlSXd2cXI2OWRER2M0NFkrRnVLR1U2?=
 =?utf-8?B?UFVRSFZYK3BNQkIwZ2tNZVhsczlQdzhiYVdiK01oNGppaGlZRlBQUFZVczFF?=
 =?utf-8?B?NGFDdHE0bjNEZ21aS042bng2SU44K1FlRTRjRE1sRm5Xc0ZadWxPeG9pK3Av?=
 =?utf-8?B?bFVKaUd3UDc5TzdyejlVVmFCZG56aWY4MFFMZTAvQnZhS1NkMWhYeHdyMTBI?=
 =?utf-8?B?TzB4bnViNit6QVcwSnREQ1EzcVNORS9TQ3JINlAvWDV2VGx3TVFrSlJ0RnV0?=
 =?utf-8?B?dytsZkFlQU9LVzFvZ2FPcExMRThGM1FPa2NEcXVWU0pGR0FQVXdPcFhIWi93?=
 =?utf-8?B?TjI0YyszZWp5aFZ2YTErYVNqVVFrcUQvL1IvSjZRcVpMVlBHYTFpenpncGhK?=
 =?utf-8?B?WVEzdDFFZjNwdllUVi81S2FuUmdBb2tUa211N1dPOUdJM2l0WEtNZTVENUFU?=
 =?utf-8?B?K2FBYnhsL1ExTXdTRkl6NE5GMUpzS1UwZ21oVVVOVmRKR2NqNEhOc01pbW5o?=
 =?utf-8?B?aEQ5VE84dmd3QVF4N0ttZTRqOEV6d2hXeTR6N2toajZFNy9HdUJYSVVud2Js?=
 =?utf-8?B?OEFKakFML3JFZXUya2FFVXNjMkQrbnNZR1JmT0xCTVhHTWhHVFNBNDJ3NTA2?=
 =?utf-8?B?UXFsRjIyZThIUmo1ak5WM3MydFNGUUZZZ0t4dFo0MTJxaW5oMFhTaXdNRE1o?=
 =?utf-8?B?WkZZY21aTmF1NFNZUjlDSXZrYytkRmhZUkNLeDdrVFlCRWFVYVVMOG9veEFB?=
 =?utf-8?B?V2dESUVkemYvOUg4SXlTa3ZBM25ZeW50VUJ1ZFp4YkI5Y1QxVW0zZkRhMG1O?=
 =?utf-8?B?aGhkZjJVYzA1YVZLa0M3VngrWjUvZWhaUXFNVEdsc3Z1N1J2UGhxTnRXSE5n?=
 =?utf-8?B?UjBraE5aMGo5NnFGcG5XUStydnpCV0ZHYnUwNU5mendzZ2RnakovUDFLTnp2?=
 =?utf-8?B?anBQOVk5cjBSZWhjYzV1ak82MTVjcWFVWG1qZVZaVlNWM2VEZk16cGxCdlcw?=
 =?utf-8?B?cEdDUTI2YmUyeml4bzVHWFhVdUpOaERVcjR6ZEZETjNZVkk2VGFmTVIrMjZn?=
 =?utf-8?B?WTBvU0ttSU9tUTdqNGgyZ1R4YVlrNHJ0RVlWaUhCeXVLRm9CWVA3ekdRUmY0?=
 =?utf-8?B?eWkzejVRNVUyUVFRWUZlVzE0MHZsdHpJTG1FbldGZ2xqdlFSQithS2xGSEJn?=
 =?utf-8?B?U25LTm5HQTdKUXhwQ29Bc2h1emx1S3JZNENpREl4Rk9QTEVxUUpSREZLRGxy?=
 =?utf-8?B?Q1dWRDZ5bkN6TTVteTdnMjNxWEE5a3oyMVgxWjBVemN0WmJUeXM5Rkp3Y2VR?=
 =?utf-8?B?em9wNHg1VFJVMUxBaXVaRzh2TEFVSW1tUWlLeEdncDNYbUxwMENoMGxPWjd5?=
 =?utf-8?B?RjFmOHBNbzRIUE1wSW8yS3U5a3AzbGovcjdIODVjS21CNVMvRW00bjVPRkdP?=
 =?utf-8?B?TXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05766817-e2b7-4c1f-00d6-08ddea1b91a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 12:23:48.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTEyJKZuSPxue1IIhd4eRj53bdIS+/qPtbWxNmosAD1pU2I2yJAjaFp6XcNaL/lccoFNfyQp0duDTpdpmwncZ5YcH6SyxXMPSjuCgwJ/r16cO1UdJk9PYnsGXhbAZT0+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9346

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIxLCAyMDI1IDc6NDYg
UE0NCj4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxs
LWxhYnMuY29tPjsgTmVhbCBDYXJkd2VsbCA8bmNhcmR3ZWxsQGdvb2dsZS5jb20+DQo+IENjOiBw
YWJlbmlAcmVkaGF0LmNvbTsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgY29yYmV0QGx3bi5u
ZXQ7IGhvcm1zQGtlcm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsga3VuaXl1QGFtYXpvbi5j
b207IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGpoc0Btb2ph
dGF0dS5jb207IGt1YmFAa2VybmVsLm9yZzsgc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc7IHhp
eW91Lndhbmdjb25nQGdtYWlsLmNvbTsgamlyaUByZXNudWxsaS51czsgZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldDsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgYXN0
QGZpYmVyYnkubmV0OyBsaXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1YWhAa2VybmVsLm9yZzsgbGlu
dXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgaWpAa2VybmVsLm9yZzsgS29lbiBEZSBTY2hl
cHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndo
aXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBtaXJq
YS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29tOyBycy5pZXRmQGdt
eC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2VsQGFwcGxlLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxNSBuZXQtbmV4dCAxMC8xNF0gdGNwOiBhY2NlY246IEFj
Y0VDTiBvcHRpb24NCj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWls
LiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBh
dHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1h
dGlvbi4NCj4gDQo+IA0KPiANCj4gT24gVGh1LCBBdWcgMjEsIDIwMjUgYXQgNzo1OOKAr0FNIENo
aWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPiB3
cm90ZToNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206
IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5
LCBBdWd1c3QgMjEsIDIwMjUgMjozMCBQTQ0KPiA+ID4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lh
KSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+ID4gQ2M6IHBhYmVuaUBy
ZWRoYXQuY29tOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgDQo+
ID4gPiBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBhbWF6b24u
Y29tOyANCj4gPiA+IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
IGRhdmUudGFodEBnbWFpbC5jb207IA0KPiA+ID4gamhzQG1vamF0YXR1LmNvbTsga3ViYUBrZXJu
ZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgDQo+ID4gPiB4aXlvdS53YW5nY29u
Z0BnbWFpbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IA0KPiA+
ID4gYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgYXN0QGZp
YmVyYnkubmV0OyANCj4gPiA+IGxpdWhhbmdiaW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3Jn
OyANCj4gPiA+IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7
IA0KPiA+ID4gbmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSAN
Cj4gPiA+IDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNh
YmxlbGFicy5jb207IA0KPiA+ID4gaW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IG1p
cmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyANCj4gPiA+IGNoZXNoaXJlQGFwcGxlLmNvbTsg
cnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0LmNvbTsgDQo+ID4gPiB2aWRo
aV9nb2VsQGFwcGxlLmNvbQ0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTUgbmV0LW5leHQg
MTAvMTRdIHRjcDogYWNjZWNuOiBBY2NFQ04gb3B0aW9uDQo+ID4gPg0KPiA+ID4NCj4gPiA+IENB
VVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwg
d2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBu
b2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiA+ID4NCj4gPiA+DQo+ID4g
Pg0KPiA+ID4gT24gRnJpLCBBdWcgMTUsIDIwMjUgYXQgMTo0MOKAr0FNIDxjaGlhLXl1LmNoYW5n
QG5va2lhLWJlbGwtbGFicy5jb20+IHdyb3RlOg0KPiA+IFsuLi5dDQo+ID4gPiA+ICAvKiBVc2Vk
IGZvciBtYWtlX3N5bmFjayB0byBmb3JtIHRoZSBBQ0UgZmxhZ3MgKi8gZGlmZiAtLWdpdCANCj4g
PiA+ID4gYS9pbmNsdWRlL3VhcGkvbGludXgvdGNwLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdGNw
LmggaW5kZXggDQo+ID4gPiA+IGJkYWM4YzQyZmE4Mi4uNTNlMGU4NWI1MmJlIDEwMDY0NA0KPiA+
ID4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdGNwLmgNCj4gPiA+ID4gKysrIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L3RjcC5oDQo+ID4gPiA+IEBAIC0zMTYsNiArMzE2LDEzIEBAIHN0cnVjdCB0
Y3BfaW5mbyB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKiBpbiBtaWxsaXNlY29uZHMsIGluY2x1ZGluZyBhbnkNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIHVuZmluaXNoZWQgcmVjb3ZlcnkuDQo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiA+ID4g
KyAgICAgICBfX3UzMiAgIHRjcGlfcmVjZWl2ZWRfY2U7ICAgIC8qICMgb2YgQ0UgbWFya3MgcmVj
ZWl2ZWQgKi8NCj4gPiA+ID4gKyAgICAgICBfX3UzMiAgIHRjcGlfZGVsaXZlcmVkX2UxX2J5dGVz
OyAgLyogQWNjdXJhdGUgRUNOIGJ5dGUgY291bnRlcnMgKi8NCj4gPiA+ID4gKyAgICAgICBfX3Uz
MiAgIHRjcGlfZGVsaXZlcmVkX2UwX2J5dGVzOw0KPiA+ID4gPiArICAgICAgIF9fdTMyICAgdGNw
aV9kZWxpdmVyZWRfY2VfYnl0ZXM7DQo+ID4gPiA+ICsgICAgICAgX191MzIgICB0Y3BpX3JlY2Vp
dmVkX2UxX2J5dGVzOw0KPiA+ID4gPiArICAgICAgIF9fdTMyICAgdGNwaV9yZWNlaXZlZF9lMF9i
eXRlczsNCj4gPiA+ID4gKyAgICAgICBfX3UzMiAgIHRjcGlfcmVjZWl2ZWRfY2VfYnl0ZXM7DQo+
ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFdlIGRvIG5vdCBhZGQgbW9yZSBmaWVs
ZHMgdG8gdGNwX2luZm8sIHVubGVzcyBhZGRlZCBmaWVsZHMgYXJlIGEgbXVsdGlwbGUgb2YgNjQg
Yml0cy4NCj4gPiA+DQo+ID4gPiBPdGhlcndpc2UgYSBob2xlIGlzIGFkZGVkIGFuZCBjYW4gbm90
IGJlIHJlY292ZXJlZC4NCj4gPg0KPiA+IEhpIEVyaWMsDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRo
ZSBmZWVkYmFjay4NCj4gPg0KPiA+IFRoZW4sIHdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gYWRkIF9f
dTMyIHJlc2VydmVkOyBoZXJlIG9yIHRoaXMgaXMgbm90IGFuIG9wdGlvbj8NCj4gPg0KPiANCj4g
SSB3b3VsZCBwcmVmZXIgd2UgdGFrZSB0aGUgb3Bwb3J0dW5pdHkgdG8gZXhwb3J0IGEgMzJiaXQg
ZmllbGQgcmlnaHQgdGhlcmUsIGluc3RlYWQgb2YgYSBob2xlLg0KPiANCj4gQSByZXNlcnZlZCBm
aWVsZCBtYWtlcyBpdCBkaWZmaWN1bHQgZm9yIHNzIGNvbW1hbmRzIHRvIGtub3cgaWYgYSBuZXcg
a2VybmVsIGlzIHVzaW5nIGl0IGZvciBhIGRpZmZlcmVudCBwdXJwb3NlLg0KPiANCj4gTmVhbCwg
YW55IGlkZWEgb2Ygd2hhdCB3b3VsZCBiZSB1c2VmdWwgPw0KPiANCj4gSSB3YXMgdGhpbmtpbmcg
bGF0ZWx5IG9mIHNrX2Vycl9zb2Z0LCBidXQgSSBhbSBub3QgeWV0IGNvbnZpbmNlZC4NCg0KSGkg
RXJpYywNCg0KSSBoYXZlIG5vdCBoZWFyZCBhbnl0aGluZyBmcm9tIE5lYWwuDQoNCkRvIHlvdSB0
aGluayBvdGhlciBmaWVsZHMgY2FuIGJlIGV4cG9ydGVkIHRvIHRoaXMgMzItYml0IGZpZWxkPw0K
DQpBbm90aGVyIHdheSBpcyB0byBpbmNyZWFzZSB0aGVtIGZyb20gdTMyIHRvIHU2NC4NCg0KQ2hp
YS1ZdQ0K

