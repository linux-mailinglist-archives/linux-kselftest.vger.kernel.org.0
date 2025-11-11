Return-Path: <linux-kselftest+bounces-45307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9BC4D558
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA8D74FCE7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F58E350A32;
	Tue, 11 Nov 2025 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ebBMb0VG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BA2EAB61;
	Tue, 11 Nov 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858979; cv=fail; b=L7pM3Rtdv+SXX8slyUsnZxXzmiq2OgkDxgumwJb6/qoAYB2PH0cTsGeVatJ1U1lRfZRTxhujGaYpOTS9AUtkoeUKUOAiNIzl1Q9JdZ+TR1WiZyRCarGYdZUaFV/ZJVwX6xfyTV5eNzl2IT92FkhnSVrXDrrbwniqiN22FfNp38c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858979; c=relaxed/simple;
	bh=ZBc6g+tt4t8Aucws9Wh1YdYLWsNC+opdcBlYrCc/DXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5y1AutqH2nRS0e/VL5KvSOKAuRbPGQyxmPkbEyBDv3J5i5wVesF0sbISVfXkv+HnAc5I3X3CsLFsXAR7s1J1ESpfKocPR3QY2eRsJQehvCBnleczrFVbdjaQ9OfVakZPpJ0uOCb94GhmDTY5cjSv9Gh/ULrrq74js2892kruWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ebBMb0VG; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsWBeGdtztg1rfGVF2OG/mgGukBO5d3sO21Tmbx3iClNOoFBtmxBFpXbxy5IJEfXbuBycKlPTQnloXwi7CQnm97+tHJhF8m6kKk5RxXXk9p3bo6G7Bm0GtAiOZts9f7CcKZEkzKnMqvP4d1Ily62SUn+3qZ/bV2r99u0/nvnXNvoxj6IedcbMjtIIV9jSIrUYkrfbYIXaC5pI0OnfFcjk1m5z5o/mzGyOCOL1tYXaRW2cwWViRaFt3ieTxXhR+XGmJWGY31ia1URBmROt9+pSq1Aq8EKqC1f+vF6x8sr+ynjurmibnxLUaOOek7BljEYq+2oaGrSvT8ufLliJHvluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBc6g+tt4t8Aucws9Wh1YdYLWsNC+opdcBlYrCc/DXk=;
 b=refzyw2kZ69xmbf+w7o+LpuFf7AL6/IihClpKNrPO8SuM2VtjDLlDO8GXcmn5O3yzb2XFSVmLxPefmdXb+2TWQtZwk7DFJcjz9KdRQ9lRFzbd41W82c9mm3JKH4ZSXdavLrhlrvftl9nFNvY98BGnGs5MfA1eKj+UmgVdr73CGXp8in7d44wB68w9B3CoPp3N9dGTZEuLUi13wNJhXRYfF/+bFLlEkHsXNcXuJLvLI1PYqm07PhWwQNF6/EXcmBEhfFbwPPWQkoPW5JNTi8HdBFgljY/mC1tzayXcxYBKxe65AtIVuwiZ/UuTMLSWBoce7tW9iBmIEIX7tha868vDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBc6g+tt4t8Aucws9Wh1YdYLWsNC+opdcBlYrCc/DXk=;
 b=ebBMb0VGqUXwzmDyJC7g6USf3GfEZRXfrjB1AY6lgff1upt9ci2m71zVt/E1wlMBRZX0qAtOzHzcgoQEVTAOJaEs+teYKdT6yYEdocn99dKH8EEjSsONOrA0K3OXz6I5LJN+5zAYUk4uHRbDxb3nfm8NFlWIFD8Eo5+Q4zFZz+6eAksXzfDEhUYLeaWgJTPNJML6ArsnN7H05vJ4dp9a/XCMg5A6PFYM3uydr0UaWIBkvRDCY0KWXE6u9EwInya2DRKxHxEzKLQ+TNELn7rRGZBRLSHzMxLVJgghJDsCeFV76nl+f4Z99KLAenJsj0JouweMibLj8zjLWJtwPLoJYQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB6335.eurprd07.prod.outlook.com (2603:10a6:800:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:02:50 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 11:02:50 +0000
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
CC: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
Subject: RE: [PATCH v5 net-next 05/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
Thread-Topic: [PATCH v5 net-next 05/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
Thread-Index: AQHcSapXzRega4IaJUCwRvwoJCfzaLTlkH0AgAM6qwA=
Date: Tue, 11 Nov 2025 11:02:50 +0000
Message-ID:
 <PAXPR07MB7984498C0F152D504B2AEC98A3CFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-6-chia-yu.chang@nokia-bell-labs.com>
 <bc1ebcd0-c42c-4b59-a37a-13ee214e90a6@redhat.com>
In-Reply-To: <bc1ebcd0-c42c-4b59-a37a-13ee214e90a6@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB6335:EE_
x-ms-office365-filtering-correlation-id: 40dfb147-1570-43bd-2ff9-08de2111db2a
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmxrMFJiSTdaZ1RrL0poa1hhVTROellSdTREeDlQYjlwTFBrdXBORWlQQUxU?=
 =?utf-8?B?WjFyc3FxVUs0T3JFN28zSWtRaldINFBjZzBqRFEvNTBRUldVWUp2bHpQQ204?=
 =?utf-8?B?Yys0V3lmemlqL3I3bGdWSGN6dGlzVld2V25QVHNYWGMvaGx3RzdWL3EyYUpR?=
 =?utf-8?B?eVZZazZJMVlXUGpKZWR2VGk5eGUwZ1Y1MmhWY3V2d1BraFpFVGU1eVpEcENk?=
 =?utf-8?B?cjVpSUUrc213ZWxZM2t0M2VQZVFVWGJzTk93YUF4VHlOTGhIL2VxdHpTZVlT?=
 =?utf-8?B?NmxldmJMOHVMQWF1Y1BaMjhDZ2s1Q2ZYcGlmb2hVVTk3UWVtWFNBUzlybGMy?=
 =?utf-8?B?cnZWZnZlQnJZUmIvajlEL3FjSHhFNVo4NVl6cmxGNnd1bjRkajM5UGdLN0xR?=
 =?utf-8?B?NDJxN3ltRTZHa2UzbExLWVJuUEF6TzFCbUQ5M2F6U0ZIMUE5dGM1THp2MGRR?=
 =?utf-8?B?clIzWmRya2pvMTk0Y1RJMUoxOWlJZmlncnpZNFVCUnlnVXRRUXBCWXFPdzg1?=
 =?utf-8?B?Z2VoOTlJVXk5aGNGSkZIRXNDNngyVzVEbXVCVUxPc0RjVituK2diTHlpelgv?=
 =?utf-8?B?L25ROEE5ZE5VcUl1bWFBQ1JGcmN4RUJXRWViR0tOY0tTUTB4cWlETGoxTWNN?=
 =?utf-8?B?MDZsSmlQQ284S0ZUNnFHTXlPWktaWXdYRElCZEJEcG1oS3RnQThTYy9JdjRZ?=
 =?utf-8?B?VTdDMzdXT1MvdGlmOFN1d0dpN0Q1L2VZeW51RjRYYzRNMVVGUE14Y2k5RUJR?=
 =?utf-8?B?dklmYUVpbkcwY1NIMndhOFZDdU5RNWFlalJ6NHRZRkFRejN5TXQ3eXg1WXNM?=
 =?utf-8?B?REZsRHNEL2Rma1FrQjBZY04wTU0xam4vdlV2aXBPc0VQdnViZjhzZjJDZWN5?=
 =?utf-8?B?Q0NtY0tJUkU2d1JBVkpHbVBaeDdZZG94VVJDUjM1bW1PU2hOR0J3Q2h0a2ky?=
 =?utf-8?B?eW12WjRmK1JqamxyYVdtbmlkNUp4Z0EzVVNjcU5iamZlVFV3NDBtZWpDb2hj?=
 =?utf-8?B?a21JUXAzb2x5Q3M3NDJFb09VZ20zMGFtVGVhaXZYSDYrVldMcDJISm5MamFJ?=
 =?utf-8?B?cWFqZC8wbm8wRVl2MnBlendiU3RWTUl5WHkwZ29NWHRJcStiMGgyUEdpTDNy?=
 =?utf-8?B?RE5uWTRGV0EzZkJ1OVhyb3VhTStHRy9TTXpTZiszcUZQTXJBSmRQOGkxT0pJ?=
 =?utf-8?B?RnBxbEZHaDJJdHR3cGlRN0dta2QxZUFNaXlnOXdDSlZzU05NZTNvbHhuUk5Z?=
 =?utf-8?B?TTBTZkdpUk9KUDlDRjJoOVhFT2s2UTVMSFFjMnYrVG5oUzJxRXVsMFlidG12?=
 =?utf-8?B?QTVVVVVLU29HY3pCRHNoRzJUN3lhQmtBVlFyZHRob2hYdUxqMWdiYktneTd5?=
 =?utf-8?B?c0tXMklEV3g3dldMT09oVCtzRzVHbjU1WnkwUEpBS3I4UFpHOTk2SnpIZTIy?=
 =?utf-8?B?cXRpOW5uSTVYSDM1bGNoWDh5ejJOdk1ZM1RUTjEzVGpWWVVOd1JOaE5HRnpq?=
 =?utf-8?B?cTVPVXNudUdNKy9jV0Nab3ZHbkpPV1FzWXRmVjlXKzVuSUQ1bDh6M3pSbVdk?=
 =?utf-8?B?KzZiV01HN0RjQzh5TGpVVklKclpsVjFkMU5JSHE3SXN2dFhFbzd1RTlYUUpC?=
 =?utf-8?B?ODY0c005QVM4TUxQTWxGUU1XMHpGWWFvUU16Y1hZMDkzZzdLRW5JbU0wL2p3?=
 =?utf-8?B?cmtodkIzK1VETmt3T2ZxOGI2b2JKaFRaWngvSG4wV1JCWjlKVGhobkZPdEFP?=
 =?utf-8?B?YlhVcHBKSUViby8wcXY3dlh6blA0dXRvNFAzbUZka0NzN0lET0szc2hmeTZt?=
 =?utf-8?B?OEtZc0xUbk83VHdUL0F6OXROMjlxemFaOUl6eFByYlZvdWliNCtPNnFNWmQ3?=
 =?utf-8?B?Q0tXL0g5NklSSkw3dTVKUVJEL0RTQzdSSVRucEd3ZVFzdFFySkQzUDNZa1Vt?=
 =?utf-8?B?T25rTUdLL29vRkRLK0NGdVA2bG5oZGNGcFpsYTNjT05GYWl3L3V2TkhLUkU2?=
 =?utf-8?B?MTdWZ3B5UWthTXdJeFVKVDJjNVorbUprT2NFY25DeEF6MEZDS3NLc2tyZWtX?=
 =?utf-8?B?ek1lRlBWbUFoY0UwOEVla29QRkc5ZDc4ZWxFdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTNnMUdaTWFON3FFVmxrUXA1UEZ1VytBTi9EMjY3ZjMwV09QdnZ6MGdLdGk0?=
 =?utf-8?B?S2VrNEFKSzhXWnIrcVVCemZUS25SZ0Q5Z2swaVdrVlpTMm9jdFp5U0hCYWZO?=
 =?utf-8?B?YW5vMEw5dEdPWU5hTEV6d0c5VC96UUt1N1ZhakhhRnJKUmlKcGhocHFtN3JU?=
 =?utf-8?B?VGhhS1BSQjgzdm5mQkxxM0lpR3YvQmtiNm1JT3FRUFF6eHQ4TnVoZWtRd2x5?=
 =?utf-8?B?ZFQ2RDhZRy8rQ1BkZDg2NjhBYkFobVhsQnprKzJ2Rks1SjdNTElVOGliSW1M?=
 =?utf-8?B?L0Uvby9mRVFpN1F0NHB5dU4yRlVOTlVNdkIyb0lzRG9zTCtIVTZnOTJ2YnAy?=
 =?utf-8?B?ZHBxemhvMlV5QmtITHNqS1ArNGs2VGhGY0tidUh0UEthU29sak9SYkwyMm5o?=
 =?utf-8?B?Si9QRDNWZHEzY0pJN2xFODBRZDBtK283UmVSczZjb3QzOHJ3QzhaaXlaclA2?=
 =?utf-8?B?Zy9QVmtCRDFkVG9STXVoVld3VndIbXluU1E1WFladmJ4djd4dk5pZGthOVdI?=
 =?utf-8?B?OVZRNXp1RG1aSzhrM1RsSWJNbVU5SlZkNjJKSG42OCsyRldyU3E5c3BPamlz?=
 =?utf-8?B?SFVaMU0vc2RkY3ZYWEZuc2tIQnlReWdReUF1MUtGMVRyR2dRc2t0NU5SUVVG?=
 =?utf-8?B?enZDbXhzaUV4TFBFUVBpMERGd1hMQ2c3Z0VRNjVIUlo5K1N4STJiMUtMUDlU?=
 =?utf-8?B?V2Rpd2lVL1pPRXorNDZwZ2prYTlBNlhHY1ZVNkZsU29IaWp5VjljZjJOY1Ft?=
 =?utf-8?B?QlozR2R4Rzdqa3hLczY3bTdkdXNySHM2dUJXeTVYWTRqaDMwRTd0NnYrZWxv?=
 =?utf-8?B?eWFLRE9GZFM3NHJ4UFd3UlFzaTNBR2UzVWlIRkorbkc1NEl6Yk5FV25ZVS8r?=
 =?utf-8?B?WjdMNHB6NzBYSUQxRUxuQnVtZXNqMm0wSzBMaWVnOERMRGJtNTYvMWpLRGNK?=
 =?utf-8?B?ZUlVV0g1S050SlFxMGdDZUV0SU1ISFFLbDBKTGVIcVdaUFgzTmZHczNiNmoz?=
 =?utf-8?B?TXArMkJrZ3RHUVVVcjhPeFhzY3E2V1J0Y0dwVmRUNzJ2aTF5Sk1xcXpmcHM4?=
 =?utf-8?B?dlB1d1B2SUl2cjJ3V05jM2hxZm1VSWk2b2RxVmdKdVBXVHpoYituSHhuWWhP?=
 =?utf-8?B?Nk84TnRWeDhxckxWOWhTTlIxWjlZWk5lUktvTGV4TUdGVDNVQzYwZmxiK0Nk?=
 =?utf-8?B?S2JjVDlnL2pwaytuNnJQWWZZazl5L0lWOFRCdTRkb1gxL1Nucy9PMGtBQk1Z?=
 =?utf-8?B?ZjNhVE5aendBMXBWaUtiZndDZ0x0THFIVFd5bDNHbC8raTJ5WG9yTHBOMjRU?=
 =?utf-8?B?SmJGVUF1M2FySi81cXlFZURPdWsvRlZiTG0yZ3hBRWYxKzluc21GaHZLRkZP?=
 =?utf-8?B?YnMzbHdrUzM1VGRnb2w0MDQ4OUFJaFRrYlNrQmNOV1RpdEtHMk9ESHl3QXVC?=
 =?utf-8?B?M2QwMDVJT29hVC9acnRiNHhpUVZsOXNTWUY4cUlKMlVwbmx4cnQwclJMR2NN?=
 =?utf-8?B?MUJHVUJYNFhQQkt0eDFwTjRGbDRvdjd2QmE4TlBFcG9FUlhCdGU4bVJnbFRW?=
 =?utf-8?B?eVlEdUxRbXMwY0l6RDcrNGd4QzkwcmUwMEpreG1jTXdObFVCMTJkNTBkYjI0?=
 =?utf-8?B?VmRDcG4wSU8xOTQzQldOR1pPZFV5M0k4YTNwZS9IMDd5dVpHVXYvbHRjTm1v?=
 =?utf-8?B?WUVtLzhGb1RPNDc0KzJqOFplSHFzVUdYeXhiUW15V2Vhay94cklvMC9VaWsy?=
 =?utf-8?B?eXVxVzZBeGtJRFVwZDBHUElnclNWdDFFalVBQmpBZm9GMEhRckM1b1h6M3hF?=
 =?utf-8?B?YnJTY01abm1vanBiNEJYdkh2bEdJSUEvZ1JGVEJDTUR3Z3dFekM3V3luVzU5?=
 =?utf-8?B?dllrWC80WGdSNGtzZkhpMVl0T3RHRFRkRyswem9Qam5QUnI1M2RlZk5LZERp?=
 =?utf-8?B?QTQ2NDF3RjFJOC9vemdXYmI4YTRYc2R3NXQvN2IzWDNzbVFzMjV0TmhLcXFN?=
 =?utf-8?B?RSt6a25qM3pkYjBxS0NwTXhiS1BwNXdaT2wvNjZEN2ZMVDhhVUlOWmY3YUZE?=
 =?utf-8?B?d0xVV3BxWTFqRWxBY09JREJaSlJSSE9UL2xGU3prdUZtV0VZOW1RM2l0WVBB?=
 =?utf-8?B?dlYvSDl5eHNRR285bExhbTFobm0rTUpGd2ZKRlAreWQyNVN6L3ZvcnF2cEZn?=
 =?utf-8?B?dkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dfb147-1570-43bd-2ff9-08de2111db2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 11:02:50.8002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvRAfezooEulH6Chns29YEQo/+fXRw4EIUW625G2/lInKn+FzZWFzTNgljVX5OXx5nn9x4+K9+S01JfWQEFcuki3hb9baBrTDZzxLUfXw+0WS2KIwa7e/5HS+X5sIGlx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6335

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNiwgMjAyNSAxMjozOSBQ
TQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwt
bGFicy5jb20+OyBlZHVtYXpldEBnb29nbGUuY29tOyBwYXJhdkBudmlkaWEuY29tOyBsaW51eC1k
b2NAdmdlci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9yZzsgZHNh
aGVybkBrZXJuZWwub3JnOyBrdW5peXVAZ29vZ2xlLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1vamF0YXR1
LmNvbTsga3ViYUBrZXJuZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uu
d2FuZ2NvbmdAZ21haWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0
OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmli
ZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1r
c2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxAZ29vZ2xl
LmNvbTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJl
bGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25A
ZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmUgPGNo
ZXNoaXJlQGFwcGxlLmNvbT47IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2Fz
dC5jb207IFZpZGhpIEdvZWwgPHZpZGhpX2dvZWxAYXBwbGUuY29tPg0KPiBDYzogT2xpdmllciBU
aWxtYW5zIChOb2tpYSkgPG9saXZpZXIudGlsbWFuc0Bub2tpYS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjUgbmV0LW5leHQgMDUvMTRdIHRjcDogTDRTIEVDVCgxKSBpZGVudGlmaWVyIGFu
ZCBORUVEU19BQ0NFQ04gZm9yIENDIG1vZHVsZXMNCj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcg
bGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3Ig
YWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4gT24gMTAvMzAvMjUgMzozNCBQ
TSwgY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIHdyb3RlOg0KPiA+IGRpZmYgLS1n
aXQgYS9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMgYi9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMgaW5kZXgg
DQo+ID4gN2Y1ZGY3YTcxZjYyLi5kNDc1ZjgwYjIyNDggMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2lw
djQvdGNwX291dHB1dC5jDQo+ID4gKysrIGIvbmV0L2lwdjQvdGNwX291dHB1dC5jDQo+ID4gQEAg
LTMyOCwxMiArMzI4LDE3IEBAIHN0YXRpYyB2b2lkIHRjcF9lY25fc2VuZChzdHJ1Y3Qgc29jayAq
c2ssIHN0cnVjdCBza19idWZmICpza2IsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgdGNwaGRyICp0aCwgaW50IHRjcF9oZWFkZXJfbGVuKSAgew0KPiA+ICAgICAgIHN0cnVjdCB0
Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOw0KPiA+ICsgICAgIGJvb2wgZWNuX2VjdF8xOw0KPiA+
DQo+ID4gICAgICAgaWYgKCF0Y3BfZWNuX21vZGVfYW55KHRwKSkNCj4gPiAgICAgICAgICAgICAg
IHJldHVybjsNCj4gPg0KPiA+ICsgICAgIGVjbl9lY3RfMSA9IHRwLT5lY25fZmxhZ3MgJiBUQ1Bf
RUNOX0VDVF8xOw0KPiA+ICsgICAgIGlmIChlY25fZWN0XzEgJiYgIXRjcF9hY2NlY25fYWNlX2Zh
aWxfcmVjdih0cCkpDQo+ID4gKyAgICAgICAgICAgICBfX0lORVRfRUNOX3htaXQoc2ssIHRydWUp
Ow0KPiANCj4gSSdtIHBvc3NpYmx5IGxvc3QsIGJ1dCBJIGNhbid0IGZpbmQgZWNuX2ZsYWdzIFRD
UF9FQ05fRUNUXzEgYml0IGJlaW5nDQo+IHNldCBoZXJlIG9yIGVsc2V3aGVyZSBpbiB0aGlzIHNl
cmllcy4NCj4gDQo+IEFsc28gd2h5IGlzbid0IHRoaXMgY2h1bmsgdW5kZXIgYGlmICh0Y3BfZWNu
X21vZGVfYWNjZWNuKHRwKSlgID8NCj4gDQo+IC9QDQpIaSBQYW9sbywNCg0KVGhpcyBiaXQgd2ls
bCBiZSBzZXQgYnkgY29uZ2VzdGlvbiBjb250cm9sIChUQ1AgUHJhZ3VlLCB3aGljaCB3aWxsIGJl
IHN1Ym1pdHRlZCBhZnRlciBBY2NFQ04gcGF0Y2ggc2VyaWVzKS4NCg0KSXQgaXMgaW50ZW5kZWQg
dG8gdXNlIEVDVC0xIHJhdGhlciB0aGFuIEVDVC0wLCBhbmQgd2Ugd2VyZSB0aGlua2luZyB0aGlz
IGZsYWcgY2FuIGJlIGlycmVzcGVjdGl2ZSB0byBBY2NFQ04gbmVnb3RpYXRpb24uDQoNClNoYWxs
IEkgcHV0IGluIHRoZSBQcmFndWUgcGF0Y2ggc2VyaWVzPw0KDQpDaGlhLVl1DQo=

