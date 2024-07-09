Return-Path: <linux-kselftest+bounces-13401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B1F92C3AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 21:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA75D1C20CB3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284E180038;
	Tue,  9 Jul 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="N19LCdH2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C51B86E9;
	Tue,  9 Jul 2024 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552020; cv=fail; b=OmKBQFKBRGf4AzPSqRgQEkS0Vjd4h8P6f4WWXd9GT1Ma89ztP1W6c6UBwOqeMGhKFDfe2ZUDlcAq0JkenIwbLb4Qxpp1JcpR2E9OQZz+BCQfKI/FvQ74GRx3N5L3d49m3uBclz7h0SEVjX54P6rOq/J9GLSyhm+cTGMAd/2uH/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552020; c=relaxed/simple;
	bh=cawEw5e+XDkqoO2sh71WScPiOFCjTI3nrd6HVfI2sSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hQw+GTo53fZDC7mnTuarG6Ev0GgRbw3JNt5iFn9OlO5+tp8TBCZbid+GZ0YpPko9BXHBjvaKgf9mUn9ah2Y6CSwq8F+V7D/qUZ9I8sgOoI6UAmH/11EWGiFkDOSLj2ffSnuPzMUA6VusGCTRU+f41clO/fDCcAhkYB75/fJ67zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=N19LCdH2; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469H8guS010156;
	Tue, 9 Jul 2024 12:06:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding; s=
	s2048-2021-q4; bh=MFjJc8+GHHSKQPPdAtYMONz7U+PkPKtAv+Z9OXsPEHM=; b=
	N19LCdH23E1ZE8+c9hJ4op/vlzmADKdnvsKwiPYyQERiCYIMWYjINiJ1jrn7vDGb
	iSzFGiHBSbAE+y4YEENW2HL0sSiou22WZoL9bBuhF43EG/9KjdVSF/xPIWefIb4I
	WQyJrOMeOiZWJv/5bPEWxxNir+09CJbCJKJw64eYEQLa3YDG/XnCr6l1hBDh4R+j
	WzpETHTXx+Bc/yoVQ9gIMjdknHQQhWqp8N1AGUIGp3B87hImY2pDasE4suRTkDNT
	8FOWjAOqac8PfC4T5lIELVtp+lTn0egQqsryb58uX25tNfcN374alxrTEUtR99NR
	7sBIS8jv96RL3Hblnn2NBw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 408sy06119-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hnt5fvNj6QfUWkguQ3u2n5ueYHcJHd70wcwqhuffDNuxEbP427rLbkaALmBRmPmUo5TBGeAADuLxy3zDFmqEUuY8+vucTDjVO0BeId8J0yOWrLhLXP6aTl3xFb7ohDupAExowdCSZoG572lpkd7u4N6/3NTJtxL1GshTs/4HbKhDiRmp7js86nyOLrWFsJ8KWBVZXDRyatJu+XsaPxN+LILW+gA6obYrXubyaB1cmWwvUvHA0cO2eLCCZAg8CakDQ9ccGod3rhk8lliCHYYd0iIukS74GdxGUecvD2yE3mUEbzd3GLb6sc7Zn7QBwP25cH/vSwKLIawwRS8Gi6cqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1SOnnYQPLDqnHeOG+oZokwoK8XblAx18xgNUB1RKG0=;
 b=X39+KmBDgh4Csst94SmwZKUU6x2wczya/+JyFJhPqvtozEAu93qqXT9Ebqt2QLl5pragnpIegwD0uw11sIsiHuyD/sn0v1TC3xt4goBEzX+VeDtaQqyxPv4BXrmMlMRbYWnmbks2ngmkb1RFekKbKnNW+ZFx0YwT9z/ngM2vLUgW5IDNSJjqis53t4dgn93bGDN9+WxONbryhjEg8+MCMGI0P7QiC9OR0nXHEVOSgmvzXVj0vVDVceREgZnSf2hke4upz/OBWlmS0T4Od5DMT22AU/zDRYKdIWGLbbmJDhcRjuIKYwQZKrAyUQ9lr0uEzFuecpG2DIr2qs4ZTdTPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16)
 by SA3PR15MB5655.namprd15.prod.outlook.com (2603:10b6:806:315::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 19:06:52 +0000
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a]) by SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a%7]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 19:06:49 +0000
From: Manu Bretelle <chantra@meta.com>
To: Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>
CC: Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Mykola Lysenko <mykolal@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John
 Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florent Revest
	<revest@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
Thread-Topic: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
Thread-Index: 
 AQHazuq1+2PUFsFL2EKpG1WqJaaiDrHs7xQAgAACPYCAAAdNgIAAALQAgAABvgCAAAmFAIAACTyAgAGjroCAABOmjA==
Date: Tue, 9 Jul 2024 19:06:49 +0000
Message-ID: 
 <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
 <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
 <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
In-Reply-To: <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_|SA3PR15MB5655:EE_
x-ms-office365-filtering-correlation-id: ae08db96-ce44-4523-1ced-08dca04a48ed
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NExXb3doRXFlblM1WmhBNXBJQVlEcURGeXltZXZ2KzJJSVF4YWVJa0x1anUr?=
 =?utf-8?B?ejJTcmNMWHlyUjlRNUFUd0tjUFBYemVQUXZTOGl0a3orWTFtNzUzYTJramhV?=
 =?utf-8?B?ZlUrVW0rWlU3ajVjQUxTU3ExSjQrZWgxb1p0RHBCSiszdEJyYngwZ0VnQ2I0?=
 =?utf-8?B?RlROWFlsMTIzR2MxOGRrVXpWMGNVSHBaczZsb0VlVnRySzlUcDNPdldtTFkv?=
 =?utf-8?B?MEdaQXNldzM3QWZDMG5WYnE5MXhnMFZNS2prSFVYazNYcW1hQ1M5ZGtnQ3JT?=
 =?utf-8?B?amlLSkRKQVg1T3VYdWU1dmxHVy9VeFRtblFMUU80d2VsK3BtVU00MU9HbnBS?=
 =?utf-8?B?Sm8wSTRMM1ZiVUp4dEN1TjVVa3AxQ1NrQUs2N0k2MjUrMnNFcURPSmJxSy9s?=
 =?utf-8?B?SUFIdUViTkhqOUEyVitUeFc0Rk1PZ1dDbldqazJ1b1VjT0F3OGhjWWdJVS9J?=
 =?utf-8?B?Y0t0Ulk4U1hhRG1TTlgyVHI2WEJmZzJ0empkV1NNYWN1ZFdNR0ZGNVExS2R6?=
 =?utf-8?B?Um9ia0tLb1ZvS2t6VmRTa3BQQTNYQ0JSaU5td2laZmtXTzFqY1RsaU1qUXhH?=
 =?utf-8?B?Lzk2N04rNEpGTkg5QmhKbHNuelBDdEozVXVlWGw0U2YwcitKTFl3WUtQUThL?=
 =?utf-8?B?SER6bmNETVI5ZHZRUmYzQnBsZllRRUh0WjFHTi8wVUxZeGxycmZVUnpRUDI1?=
 =?utf-8?B?V1BEMVZmQnpaQ1Y1TUtIdVliczF2eUFib1hrSDZ3ZngvanE5NlJpT3BCQ1hJ?=
 =?utf-8?B?MGR2a3d6a3lhTEF1bmpYeUdqMEwyblJaUGJMZWNHcWlRNnFIU2JrMVdRU1Bj?=
 =?utf-8?B?U2x1NFY4akhCMjJMd3NBUHdmNTlhWHJvMW1lMGF5Y3N2SHNwY0RBM1MzamZX?=
 =?utf-8?B?RUlyR3llRUkyQW1xN3hGRVV6WUtEeE0wUlF3bHdsOTkvbXhTbFQ5aWRCcy9k?=
 =?utf-8?B?OTFFcWYyRFFHQXpXWitpK2JGUWRsY3p6WEY5VCt5UXF4VGlaSkFPOTlTTlhM?=
 =?utf-8?B?ZklwS1pGQWlleDlTMzcrdExHemxTYzdKOXMzRThIWHRJeVhBdzAzZ3FrK0VU?=
 =?utf-8?B?cjhGMjJOV1NnbENqMTJXRmxadzkyTHRSOWJtdkkwWUxYaDdHM1VGTTBSUTRs?=
 =?utf-8?B?c0s3T2QyeStEQkxJRERqQTRTaG9XNWRpWkJlUTljbmlwblNyRlhCem1SMm82?=
 =?utf-8?B?dmpuRjFOMXJVRHpOSnUwdU9MMktOS0cyRjhoNk5EZGUrRnk2OEJDbUowT1Fw?=
 =?utf-8?B?N0EzR3hjeWR5UTEwbnl3L2YrQS9ycE45T3BWczZQUkh5K1hMZE5WUlVNdHBq?=
 =?utf-8?B?dEtOMWRxMng0ZnN5UUhBOXVIZ3JNMHdNUkttb0F2R0pQUU1nd2taaFFSN0l1?=
 =?utf-8?B?VGY4SlJycHJoWGhRZHFhc09TUHdZVk1YVjgxOElLMkdvTyt0STlBNzIweWVQ?=
 =?utf-8?B?S1hoc29JRDZtbUJsbVJXQ0o4akYyV2djUXZxbUdOOXFDMkVEVUlmRDEvNVRs?=
 =?utf-8?B?ckZiQmROOU1rVGExSTNRL2h3RWdQT05SLy92UHRvM1VoNHZYbUJkZ2o3THQr?=
 =?utf-8?B?aDFDNExPRFdSL2lpRGhUZkRaWTRIbU4xb3F0QlVFeS9zUVdzVkNrbVVGSjMr?=
 =?utf-8?B?ekQyaDZwTS9MV2kyQ2lNTkNGWUNUU0hkeVR4eWRKQnZ6OUU2R0d4WDdRWGR5?=
 =?utf-8?B?bytDT2t4RzNpcS9mVFJXY1FqS1pWbm5URi9sN1NlQWJ1TFRGSGZPMnZQN1lw?=
 =?utf-8?B?bzc5Ylg0UmhPbFVta3ZacGlkd01lSVpjekRyeEhLaFhnbW83djJaMG40NzVv?=
 =?utf-8?Q?2mR3o6eIWVhsBu0sV4oQhVxmq985vBY3VbXEk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4615.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?LzF4eHBsZitDYmFmU2h0bGdwc2pBRXhlckRNMmxlZFVabDA0cVpKQlNKMzlZ?=
 =?utf-8?B?WmtscDZ2enUxdWY0ZGpoR0ZBS2JIckxCUEZzeUpoMldZTVFDOEQ2eGMwOHRm?=
 =?utf-8?B?VzBHV3lWenBObjhSRHkzWlI2TVkyMTU5Vm9aRXRra1Vtem9VWmFkVElQRVYv?=
 =?utf-8?B?RzVGZWNVZGxlOFJWeVZlbWlpUWZESGVJclV0MmdXSW9OY0YycVFuNkttVjZx?=
 =?utf-8?B?aVE3N1IyaEkvZ010eG9xSTZXQnQrUFZpMTlOLytXeUxyMHFwV3FoeHF4T0wz?=
 =?utf-8?B?YXpadkhVUlU2cWVLRlc1YVN4Ukg0MTN3dDJvTmkxM2FaejEzdVpsazFQY1p3?=
 =?utf-8?B?WmkxRm1rbUg3U2RJVFpyUFlRTTQxWWh6SWJheHFTTUhVaG5RYk9Hcm85VXJp?=
 =?utf-8?B?eHlyS014R2xpdmgySEpJdzBkUkRpSGpUOWd5UjlKTi9JVVVnYThzN2FMYVZR?=
 =?utf-8?B?YnAvcTR5M0FxMjhkVkh1NkJkQnRFQXQ0VVFLWURlVDFkL1BKcE91bktUb0E3?=
 =?utf-8?B?aFlHU1RXM1d6bDNLdFBSTjZTWWNtb1hjeGt5VUdJYWxUb1U5aDRmZ2pteUpa?=
 =?utf-8?B?Y2pUUUxsTU5PK2U0UzN1bTZEeGdNb0ZXaG5ia2lRV28rTVVQSklJN242QXNT?=
 =?utf-8?B?cnl4TG16S1VJSTJialZjV0hUcDFSUlRQc2xORUYxK2R5OVRiVWFHUVdRVmZI?=
 =?utf-8?B?TlN5SmJFcjViM1dqalhZaVJJNEE0VWI4b3NRZC9DSUxmbmEwZ1FwZ2hpLzI5?=
 =?utf-8?B?UXZXV0ZvdkdBSnBPK1hsV0JBbXlKWFJ5WFNUcDNzdjBob1ZVN0ZwbTRoRURO?=
 =?utf-8?B?NmpwQmh4ZW1SRjh6b25KTjlvOVpIQ2JrclloRHU2ZXZFY3FJdEZqOGI4SlBP?=
 =?utf-8?B?ekU0YjFGTnB5cTlSSjhoSHB2YTE0RVR1NkR2YWVoam9zTlIwZmJ1YVFvTmcw?=
 =?utf-8?B?bTNMZEZGMmFWenVCWWJaaUs1d2tLQlZSZVI0bm5zTGlpMzQ2RkJWY3VHcnB5?=
 =?utf-8?B?dWxvSFQxUnZkSHVzczB0bGt4TEp1RU9FWXhUamEyODVaeTRXUHEwNmMrR09X?=
 =?utf-8?B?VkhxMnJMNjBQNGZUQzB3Z1VXV1FRbXJidFBQRHprYlN3b29aeVMxeXlQdU1M?=
 =?utf-8?B?YWwxTzV5YmtRQ1VlSFZrbHJhZUx4d0VTYUZsWlhsK1dlU1EzVGJJbFBOSS9y?=
 =?utf-8?B?NzVGVEUvVnFHYnlVRkJQcGVmZ1ZXbXgwMW5zOEFVVndZL243U2RVaGZzN1Ra?=
 =?utf-8?B?NnkydVoyaEZsMm9yWUpEeTcvVC94OHgyd25LZm1JTzdGVStsMEVlWllUSXNI?=
 =?utf-8?B?U3JTZWJzazNycWdVUk9rckY1ak5CSUZNQ2lsL3pvZjRpV3J6KzRzeDhIeEJ5?=
 =?utf-8?B?M2lxTFRYb3E5RVVKSzhlbkNJRW1wdFVxeVVXSjZzQS9TQW5SMlM3ck40SCtw?=
 =?utf-8?B?eUw3bmpnNERBWGN0Q0k4WTVreXpFUzBPNzRzYjRaY1ZVTXh0a28yQmFoakNE?=
 =?utf-8?B?QnRrQmdmQk4xamJreDFmZWFJQW5ROWJnTjl6ME45K0E2bDRZa1ZoaHNrelF3?=
 =?utf-8?B?NXkxZngyUTJKUU5XOWpoVFhuUlkySW91UlhNY1IyYVVwRTBGVTRjeDMxZTZu?=
 =?utf-8?B?ODNNaXQ5WmF5eEtEM2FFaFZHLzNPaUVXUm1lUUdNRy9JOU91b1l6TjRscHVn?=
 =?utf-8?B?bUwyNHhNWmV2LzVhcHNTT3grUk01dEpFTGcwTktNdkpYcnJaenpsVm94aU5P?=
 =?utf-8?B?UEFVc0FIVDcybENISnNoMjFjWlYyeDJMa2MyY0lSNDVOdjl1UElldUdTYWps?=
 =?utf-8?B?RHdpb2p1VFB2Ky9xbzhJblMvMVRwNWJtUjZZVHI0L3YyRWN2YVhCM2V0VG9X?=
 =?utf-8?B?UEEvaUo1NzN3eGFjVUFVeWxHNytqN3o1aVFNeGQ2T0RmbWs1RFVGYVpqSXpx?=
 =?utf-8?B?SVlna1RlaFVKQmF4NVhoMmlvYm9PaFdUT25QaUkzYUtmalRZL1NRd2pQMXpS?=
 =?utf-8?B?VWN3ZldsRnZraHl6cW02Uk0wcW9XMzRkd0V4aXh1b094dEpQMUl1VXVWc2Rs?=
 =?utf-8?B?UUlXZ2tueXJoZEEzSkxFb25IcENHK29TcXFtbzBXK1BXa3pGT29SZkUzSkdT?=
 =?utf-8?Q?M6T8wYIOqLgQEmUMWTy3icuO5?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4615.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae08db96-ce44-4523-1ced-08dca04a48ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 19:06:49.0992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Os2CeY9b7pKJ3GHzxVu+W2EeGVNWLFQLdh6JoMsLYlbgFju20b6cWeeR5R91I+LHhjVtUEM9kNvVi1sfy4EYnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5655
X-Proofpoint-GUID: IHmjalD6LxQaunf4WYmfawAKopnthTqB
X-Proofpoint-ORIG-GUID: IHmjalD6LxQaunf4WYmfawAKopnthTqB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_08,2024-07-09_01,2024-05-17_01



________________________________________
From:=C2=A0Daniel Borkmann <daniel@iogearbox.net>
Sent:=C2=A0Tuesday, July 9, 2024 10:44 AM
To:=C2=A0KP Singh <kpsingh@kernel.org>
Cc:=C2=A0Puranjay Mohan <puranjay@kernel.org>; Andrii Nakryiko <andrii@kern=
el.org>; Eduard Zingerman <eddyz87@gmail.com>; Mykola Lysenko <mykolal@meta=
.com>; Alexei Starovoitov <ast@kernel.org>; Martin KaFai Lau <martin.lau@li=
nux.dev>; Song Liu <song@kernel.org>; Yonghong Song <yonghong.song@linux.de=
v>; John Fastabend <john.fastabend@gmail.com>; Stanislav Fomichev <sdf@goog=
le.com>; Hao Luo <haoluo@google.com>; Jiri Olsa <jolsa@kernel.org>; Shuah K=
han <shuah@kernel.org>; bpf@vger.kernel.org <bpf@vger.kernel.org>; linux-ks=
elftest@vger.kernel.org <linux-kselftest@vger.kernel.org>; linux-kernel@vge=
r.kernel.org <linux-kernel@vger.kernel.org>; Manu Bretelle <chantra@meta.co=
m>; Florent Revest <revest@google.com>
Subject:=C2=A0Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit=
_sleep
=C2=A0
On 7/8/24 6:42 PM, KP Singh wrote:
> On Mon, Jul 8, 2024 at 6:09=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>> On 7/8/24 5:35 PM, Puranjay Mohan wrote:
>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>> On 7/8/24 5:26 PM, KP Singh wrote:
>>>>> On Mon, Jul 8, 2024 at 5:00=E2=80=AFPM Puranjay Mohan <puranjay@kerne=
l.org> wrote:
>>>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>>>> On 7/5/24 4:50 PM, Puranjay Mohan wrote:
>>>>>>>> fexit_sleep test runs successfully now on the CI so remove it from=
 the
>>>>>>>> deny list.
>>>>>>>
>>>>>>> Do you happen to know which commit fixed it? If yes, might be nice =
to have it
>>>>>>> documented in the commit message.
>>>>>>
>>>>>> Actually, I never saw this test failing on my local setup and yester=
day
>>>>>> I tried running it on the CI where it passed as well. So, I assumed =
that
>>>>>> this would be fixed by some commit. I am not sure which exact commit
>>>>>> might have fixed this.
>>>>>>
>>>>>> Manu, Martin
>>>>>>
>>>>>> When this was added to the deny list was this failing every time and=
 did
>>>>>> you have some reproducer for this. If there is a reproducer, I can t=
ry
>>>>>> fixing it but when ran normally this test never fails for me.
>>>>>
>>>>> I think this never worked until
>>>>> https://lore.kernel.org/lkml/20230405180250.2046566-1-revest@chromium=
.org/
>>>>> was merged, FTrace direct calls was blocking tracing programs on ARM,
>>>>> since then it has always worked.
>>>>
>>>> Awesome, thanks! I'll add this to the commit desc then when applying.
>>>
>>> The commit that added this to the deny list said:
>>> 31f4f810d533 ("selftests/bpf: Add fexit_sleep to DENYLIST.aarch64")
>>>
>>> ```
>>> It is reported that the fexit_sleep never returns in aarch64.
>>> The remaining tests cannot start.
>>> ```
>
> It may also have something to do with sleepable programs. But I think
> it's generally in the category of "BPF tracing was catching up with
> ARM", it has now.

Hm, the latest run actually hangs in fexit_sleep (which is the test right a=
fter
fexit_bpf2bpf). So looks like this was too early. It seems some CI runs pas=
s on
arm64 but others fail:

=C2=A0=C2=A0 https://github.com/kernel-patches/bpf/actions/runs/9859826851/=
job/27224868398=C2=A0(fail)
=C2=A0=C2=A0 https://github.com/kernel-patches/bpf/actions/runs/9859837213/=
job/27224955045=C2=A0(pass)

Puranjay, do you have a chance to look into this again?

Probably unrelated... but when I tried to reproduce this using qemu in full=
 emulation mode [0], I am getting a kernel crash for fexit_sleep, but also =
for fexit_bpf2bpf, fentry_fexit

stacktraces look like (for fentry_fexit)


root@(none):/mnt/vmtest/selftests/bpf# ./test_progs -v -t fentry_fexit
bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
Successfully loaded bpf_testmod.ko.
test_fentry_fexit:PASS:fentry_skel_load 0 nsec
test_fentry_fexit:PASS:fexit_skel_load 0 nsec

test_fentry_fexit:PASS:fentry_attach 0 nsec
test_fentry_fexit:PASS:fexit_attach 0 nsec
Unable to handle kernel paging request at virtual address ffff0000c2a80e68
Mem abort info:
  ESR =3D 0x0000000096000004
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x04: level 0 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
  CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
swapper pgtable: 4k pages, 52-bit VAs, pgdp=3D0000000041b4a000
[ffff0000c2a80e68] pgd=3D1000000042f28003, p4d=3D0000000000000000
Internal error: Oops: 0000000096000004 [#1] SMP
Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)]
CPU: 0 PID: 97 Comm: test_progs Tainted: G           OE      6.10.0-rc6-gb0=
eedd920017-dirty #67
Hardware name: linux,dummy-virt (DT)
pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
pc : __bpf_tramp_enter+0x58/0x190
lr : __bpf_tramp_enter+0xd8/0x190
sp : ffff800084afbc10
x29: ffff800084afbc10 x28: fff00000c28c2e80 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000050 x24: 0000000000000000
x23: 000000000000000a x22: fff00000c28c2e80 x21: 0000ffffed100070
x20: ffff800082032938 x19: ffff0000c2a80c00 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffed100070
x14: 0000000000000000 x13: ffff800082032938 x12: 0000000000000000
x11: 0000000000020007 x10: 0000000000000007 x9 : 00000000ffffffff
x8 : 0000000000004008 x7 : ffff80008218fa78 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000086db7919 x3 : 0000000095481a34
x2 : 0000000000000001 x1 : fff00000c28c2e80 x0 : 0000000000000001
Call trace:
 __bpf_tramp_enter+0x58/0x190
 bpf_trampoline_6442499844+0x44/0x158
 bpf_fentry_test1+0x8/0x10
 bpf_prog_test_run_tracing+0x190/0x328
 __sys_bpf+0x844/0x2148
 __arm64_sys_bpf+0x2c/0x48
 invoke_syscall+0x4c/0x118
 el0_svc_common.constprop.0+0x48/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x4c/0x120
 el0t_64_sync_handler+0xc0/0xc8
 el0t_64_sync+0x190/0x198
Code: 52800001 97f9f3df 942a3be8 35000400 (f9413660)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00,00000006,8c13bd78,576676af
Memory Limit: none

For "fexit_sleep" and "fexit_bpf2bpf" respectively:


 $ ( cd  9859826851 && vmtest -k kbuild-output/arch/arm64/boot/Image.gz -r =
../aarch64-rootfs -a aarch64 '/bin/mount bpffs /sys/fs/bpf -t bpf && ip lin=
k set lo up && cd /mnt/vmtest/selftests/bpf/ && ./test_progs -v -t fexit_sl=
eep' )
=3D> Image.gz
=3D=3D=3D> Booting
=3D=3D=3D> Setting up VM
=3D=3D=3D> Running command
root@(none):/# bpf_testmod: loading out-of-tree module taints kernel.
bpf_testmod: module verification failed: signature and/or required key miss=
ing - tainting kernel
Unable to handle kernel paging request at virtual address ffff0000c19c2668
Mem abort info:
  ESR =3D 0x0000000096000004
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x04: level 0 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
  CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
swapper pgtable: 4k pages, 52-bit VAs, pgdp=3D0000000041b4a000
[ffff0000c19c2668] pgd=3D1000000042f28003, p4d=3D0000000000000000
Internal error: Oops: 0000000096000004 [#1] SMP
Modules linked in: bpf_testmod(OE)
CPU: 1 PID: 91 Comm: test_progs Tainted: G           OE      6.10.0-rc6-gb0=
eedd920017-dirty #67
Hardware name: linux,dummy-virt (DT)
pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
pc : __bpf_tramp_enter+0x58/0x190
lr : __bpf_tramp_enter+0xd8/0x190
sp : ffff800084c4bda0
x29: ffff800084c4bda0 x28: fff00000c274ae80 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000060001000 x22: 0000ffffa36b7a54 x21: 00000000ffffffff
x20: ffff800082032938 x19: ffff0000c19c2400 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: ffff800082032938 x12: 0000000000000000
x11: 0000000000020007 x10: 0000000000000007 x9 : 00000000ffffffff
x8 : 0000000000004008 x7 : ffff80008218fa78 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000086db7919 x3 : 0000000095481a34
x2 : 0000000000000001 x1 : fff00000c274ae80 x0 : 0000000000000001
Call trace:
 __bpf_tramp_enter+0x58/0x190
 bpf_trampoline_6442487232+0x44/0x158
 __arm64_sys_nanosleep+0x8/0xf0
 invoke_syscall+0x4c/0x118
 el0_svc_common.constprop.0+0x48/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x4c/0x120
 el0t_64_sync_handler+0xc0/0xc8
 el0t_64_sync+0x190/0x198
Code: 52800001 97f9f3df 942a3be8 35000400 (f9413660)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00,00000006,8c13bd78,576676af
Memory Limit: none
Failed to run command

Caused by:
    0: Failed to QGA guest-exec-status
    1: error running guest_exec_status
    2: Broken pipe (os error 32)
    3: Broken pipe (os error 32)
[11:46:14] chantra@devvm17937:scratchpad $
[11:47:56] chantra@devvm17937:scratchpad $
[11:47:57] chantra@devvm17937:scratchpad $ ( cd  9859826851 && vmtest -k kb=
uild-output/arch/arm64/boot/Image.gz -r ../aarch64-rootfs -a aarch64 '/bin/=
mount bpffs /sys/fs/bpf -t bpf && ip link set lo up && cd /mnt/vmtest/selft=
ests/bpf/ && ./test_progs -v -t fexit_bpf2bpf' )
=3D> Image.gz
=3D=3D=3D> Booting
=3D=3D=3D> Setting up VM
=3D=3D=3D> Running command
root@(none):/# bpf_testmod: loading out-of-tree module taints kernel.
bpf_testmod: module verification failed: signature and/or required key miss=
ing - tainting kernel
Unable to handle kernel paging request at virtual address ffff0000c278de68
Mem abort info:
  ESR =3D 0x0000000096000004
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x04: level 0 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
  CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
swapper pgtable: 4k pages, 52-bit VAs, pgdp=3D0000000041b4a000
[ffff0000c278de68] pgd=3D1000000042f28003, p4d=3D0000000000000000
Internal error: Oops: 0000000096000004 [#1] SMP
Modules linked in: bpf_testmod(OE)
CPU: 1 PID: 87 Comm: test_progs Tainted: G           OE      6.10.0-rc6-gb0=
eedd920017-dirty #67
Hardware name: linux,dummy-virt (DT)
pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
pc : __bpf_tramp_enter+0x58/0x190
lr : __bpf_tramp_enter+0xd8/0x190
sp : ffff800084c4ba90
x29: ffff800084c4ba90 x28: ffff800080a32d10 x27: ffff800080a32d80
x26: ffff8000813e0ad8 x25: ffff800084c4bce4 x24: ffff800082fbd048
x23: 0000000000000001 x22: fff00000c2732e80 x21: fff00000c18a3200
x20: ffff800082032938 x19: ffff0000c278dc00 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaabcc22aa0
x14: 0000000000000000 x13: ffff800082032938 x12: 0000000000000000
x11: 0000000000000000 x10: 000000000ac0d5af x9 : 000000000ac0d5af
x8 : 00000000a4d7a457 x7 : ffff80008218fa78 x6 : 0000000000000000
x5 : 0000000000000002 x4 : 0000000006fa0785 x3 : 0000000081d7cd4c
x2 : 0000000000000202 x1 : fff00000c2732e80 x0 : 0000000000000001
Call trace:
 __bpf_tramp_enter+0x58/0x190
 bpf_trampoline_34359738386+0x44/0xf8
 bpf_prog_3b052b77318ab7c4_test_pkt_md_access+0x8/0x118
 bpf_test_run+0x200/0x3a0
 bpf_prog_test_run_skb+0x328/0x6d8
 __sys_bpf+0x844/0x2148
 __arm64_sys_bpf+0x2c/0x48
 invoke_syscall+0x4c/0x118
 el0_svc_common.constprop.0+0x48/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x4c/0x120
 el0t_64_sync_handler+0xc0/0xc8
 el0t_64_sync+0x190/0x198
Code: 52800001 97f9f3df 942a3be8 35000400 (f9413660)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception in interrupt
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00,00000006,8c13bd78,576676af
Memory Limit: none
Failed to run command

Caused by:
    0: Failed to QGA guest-exec-status
    1: error running guest_exec_status
    2: Broken pipe (os error 32)
    3: Broken pipe (os error 32)


[0] https://chantra.github.io/bpfcitools/bpfci-troubleshooting.html

>>> So, if the lack of Ftrace direct calls would be the reason then the
>>> failure would be due to fexit programs not being supported on arm64.
>>>
>>> But this says that the selftest never returns therefore is not related
>>> to ftrace direct call support but another bug?
>>
>> Fwiw, at least it is passing in the BPF CI now.
>>
>> https://github.com/kernel-patches/bpf/actions/runs/9841781347/job/271696=
10006




