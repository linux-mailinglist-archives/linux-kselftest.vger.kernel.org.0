Return-Path: <linux-kselftest+bounces-18237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72A297EEEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFD71F22C68
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779091990D0;
	Mon, 23 Sep 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UixJDWoa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NEqQIlHj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4746B5
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107853; cv=fail; b=ItlGTdvKcdB+1y1HybV/MNov/aY7hKmx+7GzgU7/p5kfRuAzUYWc/cAhI3GlFEJHbEoQkRavwRtdzxe0MxdTPLCmo0FOhr15KugdUpDKmvKhUTCMb6c6jf/BH40lULraFsZVl1rODPVb4Srx49eedUx91UPhPkWRrDdS7J9dm5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107853; c=relaxed/simple;
	bh=hs7K97X6tOoMond78rN/scpLs2SU1eVsdOVH2ZmAdU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rmeKB7Fh0St0sS9BBYWrGPz85v930LcepxuW7AxQ4bhYHnHV6RDUBLD+KclT/yWto7rudYYnmf8yt7s7Gai03SzL3hugHxlegNj1HZgpM3DPaat5vCz66IkbGv9ez7J5q0fMe3xtzpNSGZGBiwcf74V6+9hnOEst8D5UVSGlD2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UixJDWoa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NEqQIlHj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFtZVB015446;
	Mon, 23 Sep 2024 16:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=hs7K97X6tOoMond78rN/scpLs2SU1eVsdOVH2ZmAd
	U8=; b=UixJDWoaWmovanXjOc4rVZrh4j0epeAZDNfGONOKvcsr/vKKV5tn2yc7o
	WzbjOkr6ZzYPrlcigtn6BSilTO+foygBw2XeU+IbRTYsWnGUpyIfP1cc89IdKVic
	dNBA5w0dNBypZHD27YRU6ZcbFDnT0bNzJzaBBKh7hPIPiov8mUTRza8Qv/OMbsDd
	VmapJ6LtKniJLcS2Swzzpl9vPeCMge/YDMY2u50Yo6q9EbYoPF1BJFZJaUK8jT/F
	vqIHqVBsER536AB0Rj9YyMs+Pl4O/zNehx/eDDRb1QcKX2r7MtYQ8DQ0I8h2UeXg
	uSkq27GAshgc2HxWSH4N9jKBN7N/w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cn7w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 16:10:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFYnE7028270;
	Mon, 23 Sep 2024 16:10:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smke8stn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 16:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI7ViuGg60FTGp6nHpDbHqFyG3ui/3+7LfUqrRhcwbVom72+7MJ3bDfMNL0s6lm7GF2OPxL8k8ZYOQu2Kfx2RHi2n4UBgPa+uC3mOP9Rqq4t2MLa1OIovcFTLVKcV0Z/Z2sCfKZFYnXmxo2aYXXHjrd3GG0YOeVKqRnoAuWq72qWu1ravzBgE8B8eRJxt8J3x8GDJBWYFHmT1/7ZnegaZ/pEdMRSYmoMkj4eKxFSoSGa60oci+QmK3Tl8tg1nPWMehE12k+xnH/KGeLo3piYxRRTgAB8RO7O5diRTpL7xDvSmhZwjM/worgQyFUk1w0gIdBo5lOGMWTwpLhTtVhZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs7K97X6tOoMond78rN/scpLs2SU1eVsdOVH2ZmAdU8=;
 b=e9ehgH5Jsv0rjmb4ZJbFLtTyXctvK390+sXqHdkPxP6xZD0Dq35hbIZ7YFxAg5poAnPVIrcHnFfhUk6ulfF9iJPO8rwlSTYIHhY07IEKbtwYlhJU0i0KI6FSoI23tW8+Nrlu6eUppZVbiay9mW8unCqa7586vZvH0JIjIF8WAwkkNdF4BPKkXsEcQLuLR9mp7DbB0r6AMmgb7yA8L/t15DKdP8iTSww9yuizZJ1rIElFCIESxPvHMzv/nTVW7CUklgVyT7HkR1l4/wrLmUHkaJgUCrOg2TgfspjP9VgwnP9xHDsn6zGBnJTdi+vmHeR1dDMEA/1mJhf3Hne3Ga8Aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs7K97X6tOoMond78rN/scpLs2SU1eVsdOVH2ZmAdU8=;
 b=NEqQIlHjZVbOxpzpkPt7fyn1qVgCXuQdXYVBSiO9mzzlmIKQgUtLGibVHcqJQdoHoFGJUnq8oSiCR3TTitJc0QsOyx0ITbYBsZEsNfTeq6ohFUIMayj+ep5wRTbvMEcA8tQ5IuvqxwK7VT2ICxTm49XNiUa9mxzDAXbAutpyNpU=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by SA2PR10MB4668.namprd10.prod.outlook.com (2603:10b6:806:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Mon, 23 Sep
 2024 16:10:35 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 16:10:35 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Ramanan Govindarajan
	<ramanan.govindarajan@oracle.com>,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: Re: [External] : Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use time passed to check if suspend succeed
Thread-Topic: [External] : Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use time passed to check if suspend succeed
Thread-Index:
 AQHbCVPEQLti3BwH2UaJUde74H2DlbJfcxqAgABMJACAAQvcgIAALeAAgASRYwCAAAktgA==
Date: Mon, 23 Sep 2024 16:10:35 +0000
Message-ID: <80A7E15E-8AF1-4574-B200-4A06D48F95B0@oracle.com>
References: <20240917224837.478684-1-yifei.l.liu@oracle.com>
 <6cdd7cc3-e5ca-48b0-bd49-d33bbf908cda@linuxfoundation.org>
 <504209C8-0565-413D-BE89-A0ADE4E153AF@oracle.com>
 <9c1e9b57-649f-4f96-ab5d-ea512e05c1b9@linuxfoundation.org>
 <C8B50D46-3294-4B3A-B731-3A4B1ED0380D@oracle.com>
 <c89d0a27-7641-4832-b598-51c5eaae3a30@linuxfoundation.org>
In-Reply-To: <c89d0a27-7641-4832-b598-51c5eaae3a30@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|SA2PR10MB4668:EE_
x-ms-office365-filtering-correlation-id: b87bafa8-7966-49d7-9eb2-08dcdbea41d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnk1MTJOVldxaEdwOEgxcGhURVFhcGNmWnFGNWNEVmNPc1MxQjJoOWlmaTc1?=
 =?utf-8?B?N0FucWdMYkVaZkF0enp2MlkzWHRaYXJ1dElySkNrUWFXTWFFUENDOVdhakJJ?=
 =?utf-8?B?cnU4emZFbnVjRUhTSXBBT3d1cDl4ZFdYZ0dQZlhONjJoOS9EazIyKy9vN2hu?=
 =?utf-8?B?MFdzWW9pdnI0RUNTNFh4SFV6UWZkbHFaM2I1d2pFeUdiS255aG9oc3M5a3E2?=
 =?utf-8?B?TTc5MFBUVm9QWjV5TFBubmE1RUdzb0ZDbGJEaTlBa0FGWjdhSGtsTEU1TmZB?=
 =?utf-8?B?ZTZHM3Y1ZjhET0FHWFFoYTlWS1IrRW9vdmxmb0ZTUll1VC9nZEpuUFBpTjZy?=
 =?utf-8?B?SjU4OTVxSHdLQ1A3Qnk0K3U5UGVvQld4eDlLaWVVWFFBNEx5NTJTSHVkTzhz?=
 =?utf-8?B?K0FNNTh6VGFNMXZ3elpJdHpPaHRoRFpOc1Q4ekd4eWVsZVk1TEtia0lieUFC?=
 =?utf-8?B?eDMwc2hDa3p5OGJES3FZWWRWZWFCWGpLcmZvSVBuYWFvNHlmU1BES2dsVC9n?=
 =?utf-8?B?MkdzbVBWMDFzNnRMTGhmWEgrc0dhdSthOFc5UVAxbksxSmgwOFJwS2NsL0Mx?=
 =?utf-8?B?OVU3YmZ5MHZJeXYySkdJbTU4MUJmNy9MY0tuWVoxY3BIZm5XVG1lRWVxaGoz?=
 =?utf-8?B?SVdrZUROMHdxSzNyK3ozSW0xcFg2Njc3aHU0VkpyMTFscHdRMnhrQU14MExz?=
 =?utf-8?B?bU9nUHN6MStSd0NWeUV6YTdJVGdWT0hlZERVOWphMExXSlZ6UGNmWHNGdTF4?=
 =?utf-8?B?VndrNGFRcmFsK0ZSd0o0ZC9QRWY4aGJrYXBQcXJxTnJLaURxZnVhQ1R2MEtk?=
 =?utf-8?B?Smw3RUpkcGVLeVpleGRFUXNUUFQvbGdPK3NlMjZlT3M0TG1uVG5UWklNK0V2?=
 =?utf-8?B?RlR6TDlNQ2M3UW50V21MeHBHQ3F6MDRMcWVLcWgvL3I2ampjQ0ozZkt2clJS?=
 =?utf-8?B?Nk8xMTg3b1p0U1hlUEl4enBtTjIwK3dqWVo0ZkNsWnhPT0dRbzMvWE9GZWx6?=
 =?utf-8?B?NlZNMnNJUkk0QU1vcVVlTi9nUEhHWEovQTBZa2d4MkxvNUhCa3kzeHlIZW50?=
 =?utf-8?B?K0NkOHpJa0JnVDYvbVhuK202U1QyL2tleEpGK2E0bGw2SDNYaml4a3dUcVFG?=
 =?utf-8?B?aUlhVzdoU044bnRiMktRY0pjRUZwUVhpYWV0M0FyQlZ1dThTMEdRNGp2ZHYv?=
 =?utf-8?B?akFET21kOWJMalZFMDQ5Uk10NTlGQXM4QnN1SHdFd1VlcG5GTTZyblpYMmdD?=
 =?utf-8?B?NDB3TS9CYjh4VU9GaHBzNk9YR0RCdDNpU2ZhNGRSVlB4RGhpWk0zZi9zRnh3?=
 =?utf-8?B?dWhCbExiKzFmTWVsaThoK0NuOE5Hd2ZVR0tnb3R3Y1F6aDhVc2RKaE5MbmY5?=
 =?utf-8?B?cEtvU3QxRFU3V0tvMkpZSFB6OWVpQlVrODVrUG1aT0xLZzduSDBuTXZCc2JE?=
 =?utf-8?B?a01hQzJCL3FkZjdHVGQ2RUxqM2xRQzdtQXhiNXJpdkpNUjFqa3FpRjZsU2RM?=
 =?utf-8?B?Q1kzUzl5aXNGU2JMM2RTdGJIOC8vYUNPNWlLRUJ0ZlFFazI1VEFZenBrUSt6?=
 =?utf-8?B?Qy82TmlSSE5DM1pJR29OcWJpSGJYdXJxUERvUHBSNkpRbE1jQ0lVUzVDWHBH?=
 =?utf-8?B?cmVyNWs5elNXc2ZaMUZqREVFRWhLTThzbzN3ZkxHL1dDUmxvL1NaaWZYTTlG?=
 =?utf-8?B?RzMrYmhuU1pCcDE0cUV3cVJ6SHRXR3pRSGFhdzk0bWpXcmJaL0Nua2M2VTda?=
 =?utf-8?B?NERyb1NtWDFyZWNXUUdaZktFbE5MaWFHNmU5c3hqYXpXT1NqOEQ1UkNGcGhl?=
 =?utf-8?B?MlJpWHNmMU1KOFVCR2NiZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDg2NDJlMVZZaU5kRS9WTklwTE14aTBEWHdCVW9iNStaRXROTWh1L2NoYnRa?=
 =?utf-8?B?QSs5OVVhNzdYR1F5Wko0bkZJUWJjYUJwcmlpM0FaWXUxL3NkQlpnSVllT290?=
 =?utf-8?B?Wk8rUStBMERJcm83YTQwbXNVd3Y0RzBIYU0rRU5WQmE4NmxSOENGL0VyYWYy?=
 =?utf-8?B?VllYYjVIQitUUE1vRlNUbGlEWC9uTHNERjBEZndNdG5zaVRaS25ZV25NeHE3?=
 =?utf-8?B?enljeXZQZlhPRzNsdVArWWxERVhtdVRLeEZYQW1YZXZBM0VEVkxNTm9McTVP?=
 =?utf-8?B?WmZZKy9oMkZMcmNwSkpxUmVwK1VYWTlDajlkQUx3MFRWeDkzK0IycVI2TjAr?=
 =?utf-8?B?TDBWNG52S3RIYlJvL2xqblNMVEcvQzc4cUszbmhWVkZVbzFVY2owUTBYU0tG?=
 =?utf-8?B?S1ZEL3dBNnIzTU92V3pCTG5nUTVSRkMzQVNFNHJaTjRPWnhVUmgzczN0YnV3?=
 =?utf-8?B?OHA3RXB3Qjk0ZldVMTU3U0VKY0trWmlZQVBUSGlKTmhSczF1L0VQT0xBYmlt?=
 =?utf-8?B?NmlMcGFYUnZRUjZ6ZTlYcDZzaUpELzJRZmhGZEY2U2lHeVY0emt1bnpWa3FQ?=
 =?utf-8?B?Y1BncTd1c2M2SGNvNkNRRFpHOXlBWVhYNFNqdmlXWm1aQU40VWxnM09Uc1FR?=
 =?utf-8?B?RlNxdHJJWDZtU3F4MmlmV05ZdUswdnhFUFBqTmFYWHRQamk0RElXUEg4TlRm?=
 =?utf-8?B?SUMrdEdJdTd3WGJ2N1I4TUlaeWg2WlpzWHdyUjBEZGpRWUczQW5OMFJPbnVh?=
 =?utf-8?B?MFY3N1NGNTdkSk55elJkM29FKy9LMlkwcmFLQi9CbFVIbDVPcUZ6Y1NGQkF1?=
 =?utf-8?B?MWZoTmpQT0JudzcrZTBkd0NaU1h4bDlMMXgwSHVxWCtrSi82MzZMdGEvNHhR?=
 =?utf-8?B?RVlvWWFRSXhPRmx1Wi9OWjNGUkdkOGlGWlVOQnlyVk1YczU4anJNQ0Rkemt5?=
 =?utf-8?B?MjVSeDN3ZzljQks3Y3JxQWsrUDVwdDNuZHNTbWxCdkJzQXFDaFh1SUJkK3hQ?=
 =?utf-8?B?dmNKMEhoZzA4MVdjSGNLaGlWYkYyL0ZpdDFGejRlQ0twSEk0ZXpzcDlUVm1q?=
 =?utf-8?B?RGc4L0o0WkN0WFJKS2ZwV3A2VHZNbHFTTzMvSlRoNXJNNnJ4VjBFWW1ia0FI?=
 =?utf-8?B?bFJwT2hEVmhDSmJ4elh1dmV3aWxtOGFneHlVejBxdERKTmRFRkhSTzBwMk5Y?=
 =?utf-8?B?d2xnVi8zdjhPTjNkekRmOGYxalMzUk1OazdOVjE3U3pUQlZ6WEVtaFBHR0JY?=
 =?utf-8?B?MXdEMmZMTkEzZlJqekVRdlFTV3VrSWJqRW9JWGQ5VnUrR3JvMDh4QVU0Tkc1?=
 =?utf-8?B?SFVvc2JzQmVyVzB0bGhWaUlGWWN2WU5tYTE4V2dhSGRldTJ1OVRuTkVEbmFu?=
 =?utf-8?B?MktJUzFVUTdNRXVxMVU2L2pYZHVGYUxvb3lOcjN6dzgzN3hHTmljQmlCSmRS?=
 =?utf-8?B?ZFpUSDUzS2dad2NoV0pGZk9iZDhuL0FLMTVFL0h6cktVQTd5N28wWStiUitB?=
 =?utf-8?B?S1h0M2ZjYzNNVUMrZStOeTFYdG9QVHZVMWwzNWk2UXR3V2o0UjFVWHFEeEFm?=
 =?utf-8?B?T0RUbjFtWXZ2WHBuZTRDNVdFZ29NYUlzdXFhUlhEc0FmdGFJZ0t4Z2hQMHdj?=
 =?utf-8?B?clZHWGZCelhaZmlMeDJpcUpZek9ETlcvRFExKzVEKzZndG1OTGdPQU1mQmRW?=
 =?utf-8?B?SWorb05QY1dKdHpuRC9jMW04aS9QZTErT2xkaDVsVXBVSkpzWTlva3QyK3dX?=
 =?utf-8?B?elBEcTk1S2ovSkRCdmU1aU8zYldmSm4vSmhSMDlUMUc5SEgyaWtHNGFsUTdo?=
 =?utf-8?B?cURhMWJ5Mk1kQkIyY1hPMHFqNGxKTk1ITnZmbmpZTW1jMkg4dTBubmpEMXA1?=
 =?utf-8?B?RE1jRTJVNlFGb2NCWkJuUWNDQTc4UzVVbXJNcUdxOHFyZGR5QmE3RjRjS2o2?=
 =?utf-8?B?L2w1K1NqTDVKZ3NnYzR0YzlVNnNibTA4YTRYcW1VNGowSEVKQzREUVpiTE5j?=
 =?utf-8?B?WkREWGJzQ3orbG1ERDZuaUVzV3R3cnl0VzhpeTFHYS9HcXdRaHVCakdNdXdq?=
 =?utf-8?B?VWtaaWEvMGRKcDZITW5Pbks4bGtEMFlzZ0I4c2tUcTFaRWpoSitDb0c3aWsz?=
 =?utf-8?B?ZGVSSkphb0c2VHAzaTVOLzZBVGF5djJJWVdMTzBGY0hVTnVudEhLWmFDZy8z?=
 =?utf-8?Q?x+itDkS+1hHWfkbWQkod+hU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A57EB15CA0D24E40A3CC4E22113BE1AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qiTNcN0pFukskeeH7cdQ8rwKTJphGeGA9NbkaPSPLz6cxGGdoHJOgWZ55qtXK9OYVD4TnZ4ks927dNtsDsaGKtBculY3IBCmTQWZ5NEXaEFPB7+ux4CXaiAxJI0x2MDUoXEKdI8sJou+Q5YNfSqIKLrxzV3zeXdY0t2h5A2gkA8eVEW0trA+5cxEFsjXEJ/CN0GdRzeCmR5g5+eHAzYuzr037aql+Ux7HWjLnPv1m7VhwEZ7uKZp/4ztLS66flg5SaIbv0zoujv8kKAN8LQ3gIh9dRH42IVp3WFKAcEzWUbJjEKqYLnQmjAnNQiN3jQmGs0S6z0H42pwyGH9dd21hep1f6yD1rUDeUYio2q6FM7VT5PoaA9pPbQV3UM/tXrhRHpN3r0JdKsiuteD9geDelZEa28n6xZDwoljh749Vskfao/OtZTO/zJ1BPEFCEhXNCnwogUbQ7Pr7PPZdCfb8DoI0ZB9c0OdnspfdgF7nOQYNzKishyusLeN/2Je89vj9Lz9laBdrS76OBGVuQgFm+sC0A4+EKpOXG7lVvIG/lqI8Uzvz+JmkJWhZgr4xvoF4snSSoR2I4pNcU6MAvfabeMP+8H0XTHGui+XMWzjs4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87bafa8-7966-49d7-9eb2-08dcdbea41d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 16:10:35.2958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbdHrTu9iQKTANqVjFK7NJ2T6cMcGjvbuWVFyJXuchG1rF1W6AZVMVM7TMkvmrJqm0/T8q7NfN7y89n5Cq3viA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409230120
X-Proofpoint-GUID: 85l2EVXDse6kmH_3ckmU4F1ykYw2tvYL
X-Proofpoint-ORIG-GUID: 85l2EVXDse6kmH_3ckmU4F1ykYw2tvYL

SGkgU2h1YWgsIA0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJIHdpbGwgc2VuZCBhIHYyIHNvb24u
IA0KWWlmZWkNCg0KPiBPbiBTZXAgMjMsIDIwMjQsIGF0IDg6MzfigK9BTSwgU2h1YWggS2hhbiA8
c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiA5LzIwLzI0IDExOjUy
LCBZaWZlaSBMaXUgd3JvdGU6DQo+PiBIaSBTaHVhaCwNCj4+PiBPbiBTZXAgMjAsIDIwMjQsIGF0
IDg6MDfigK9BTSwgU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6
DQo+Pj4gDQo+Pj4gT24gOS8xOS8yNCAxNzowOSwgWWlmZWkgTGl1IHdyb3RlOg0KPj4+PiBIaSBT
aHVhaCwNCj4+Pj4+IE9uIFNlcCAxOSwgMjAyNCwgYXQgMTE6MzbigK9BTSwgU2h1YWggS2hhbiA8
c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9uIDkvMTcv
MjQgMTY6NDgsIFlpZmVpIExpdSB3cm90ZToNCj4+Pj4+PiBXZSByZWNlbnRseSBub3RpY2UgdGhh
dCB0aGUgc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3Qgd291bGQNCj4+Pj4+PiBmYWlsIG9uIG91ciBw
bGVudHkgZGV2aWNlcy4gIFRoZSB0ZXN0IGJlbGlldmVzaXQgZmFpbGVkIHRvDQo+Pj4+PiANCj4+
Pj4+IFdoYXQgYXJlICJwbGVudHkgZGV2aWNlcyINCj4+Pj4+IHJlY2VudGx5IG5vdGljZWQ/DQo+
Pj4+IFdlIGhhdmUgc2VlbiB0aGlzIGlzc3VlIG9uIG1vcmUgdGhhbiBvbmUgcGxhdGZvcm1zLCBp
bmNsdWRpbmcgYmFyZSBtZXRhbCBkZXZpY2UgYW5kIHZpcnR1YWwgbWFjaGluZS4NCj4+Pj4+IFR5
cG8gLSBiZWxpZXZlc2l0Pw0KPj4+PiBZZXMsIG1pc3NpbmcgYSBzcGFjZSBoZXJlLiBJdCBzaG91
bGQgYmUNCj4+Pj4gVGhlIHRlc3QgYmVsaWV2ZXMgaXRzZWxmIGZmYWlsZWQgdG8gZW50ZXIgc3Vz
cGVuZCBzdGF0ZS4NCj4+Pj4gVGhhbmsgeW91IGZvciBwb2ludGluZyBvdXQuDQo+Pj4+PiANCj4+
Pj4+PiBlbnRlciBzdXNwZW5kIHN0YXRlIHdpdGgNCj4+Pj4+PiAkIHN1ZG8gLi9zdGVwX2FmdGVy
X3N1c3BlbmRfdGVzdA0KPj4+Pj4+IFRBUCB2ZXJzaW9uIDEzDQo+Pj4+Pj4gQmFpbCBvdXQhIEZh
aWxlZCB0byBlbnRlciBTdXNwZW5kIHN0YXRlDQo+Pj4+Pj4gSG93ZXZlciwgaW4gdGhlIGtlcm5l
bCBtZXNzYWdlLCBJIGluZGVlZCBzZWUgdGhlIHN5c3RlbSBnZXQNCj4+Pj4+PiBzdXNwZW5kZWQg
YW5kIHRoZW4gd2FrZSB1cCBsYXRlci4NCj4+Pj4+PiBbNjExMTcyLjAzMzEwOF0gUE06IHN1c3Bl
bmQgZW50cnkgKHMyaWRsZSkNCj4+Pj4+PiBbNjExMTcyLjA0NDk0MF0gRmlsZXN5c3RlbXMgc3lu
YzogMC4wMDYgc2Vjb25kcw0KPj4+Pj4+IFs2MTExNzIuMDUyMjU0XSBGcmVlemluZyB1c2VyIHNw
YWNlIHByb2Nlc3Nlcw0KPj4+Pj4+IFs2MTExNzIuMDU5MzE5XSBGcmVlemluZyB1c2VyIHNwYWNl
IHByb2Nlc3NlcyBjb21wbGV0ZWQgKGVsYXBzZWQgMC4wMDEgc2Vjb25kcykNCj4+Pj4+PiBbNjEx
MTcyLjA2NzkyMF0gT09NIGtpbGxlciBkaXNhYmxlZC4NCj4+Pj4+PiBbNjExMTcyLjA3MjQ2NV0g
RnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcw0KPj4+Pj4+IFs2MTExNzIuMDgwMzMy
XSBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzIGNvbXBsZXRlZCAoZWxhcHNlZCAw
LjAwMSBzZWNvbmRzKQ0KPj4+Pj4+IFs2MTExNzIuMDg5NzI0XSBwcmludGs6IFN1c3BlbmRpbmcg
Y29uc29sZShzKSAodXNlIG5vX2NvbnNvbGVfc3VzcGVuZCB0byBkZWJ1ZykNCj4+Pj4+PiBbNjEx
MTcyLjExNzEyNl0gc2VyaWFsIDAwOjAzOiBkaXNhYmxlZA0KPj4+Pj4+IC0tLSBzb21lIG90aGVy
IGhhcmR3YXJlIGdldCByZWNvbm5lY3RlZCAtLS0NCj4+Pj4+PiBbNjExMjAzLjEzNjI3N10gT09N
IGtpbGxlciBlbmFibGVkLg0KPj4+Pj4+IFs2MTEyMDMuMTQwNjM3XSBSZXN0YXJ0aW5nIHRhc2tz
IC4uLg0KPj4+Pj4+IFs2MTEyMDMuMTQxMTM1XSB1c2IgMS04LjE6IFVTQiBkaXNjb25uZWN0LCBk
ZXZpY2UgbnVtYmVyIDcNCj4+Pj4+PiBbNjExMjAzLjE0MTc1NV0gZG9uZS4NCj4+Pj4+PiBbNjEx
MjAzLjE1NTI2OF0gcmFuZG9tOiBjcm5nIHJlc2VlZGVkIG9uIHN5c3RlbSByZXN1bXB0aW9uDQo+
Pj4+Pj4gWzYxMTIwMy4xNjIwNTldIFBNOiBzdXNwZW5kIGV4aXQNCj4+Pj4+PiBBZnRlciBpbnZl
c3RpZ2F0aW9uLCBJIG5vdGljZSB0aGF0IGZvciB0aGUgY29kZSBibG9jaw0KPj4+Pj4+IGlmICh3
cml0ZShwb3dlcl9zdGF0ZV9mZCwgIm1lbSIsIHN0cmxlbigibWVtIikpICE9IHN0cmxlbigibWVt
IikpDQo+Pj4+Pj4ga3NmdF9leGl0X2ZhaWxfbXNnKCJGYWlsZWQgdG8gZW50ZXIgU3VzcGVuZCBz
dGF0ZVxuIik7DQo+Pj4+Pj4gVGhlIHdyaXRlIHdpbGwgcmV0dXJuIC0xIGFuZCBlcnJubyBpcyBz
ZXQgdG8gMTYgKGRldmljZSBidXN5KS4NCj4+Pj4+PiBJdCBzaG91bGQgYmUgY2F1c2VkIGJ5IHRo
ZSB3cml0ZSBmdW5jdGlvbiBpcyBub3Qgc3VjY2Vzc2Z1bGx5IHJldHVybmVkDQo+Pj4+Pj4gYmVm
b3JlIHRoZSBzeXN0ZW0gc3VzcGVuZCBhbmQgdGhlIHJldHVybiB2YWx1ZSBnZXQgbWVzc2VkIHdo
ZW4gd2FraW5nIHVwLg0KPj4+Pj4+IEFzIGEgcmVzdWx0LCBJdCBtYXkgYmUgYmV0dGVyIHRvIGNo
ZWNrIHRoZSB0aW1lIHBhc3NlZCBvZiB0aG9zZSBmZXcgaW5zdHJ1Y3Rpb25zDQo+Pj4+Pj4gdG8g
ZGV0ZXJtaW5lIHdoZXRoZXIgdGhlIHN1c3BlbmQgaXMgZXhlY3V0ZWQgY29ycmVjdGx5IGZvciBp
dCBpcyBwcmV0dHkgaGFyZCB0bw0KPj4+Pj4+IGV4ZWN1dGUgdGhvc2UgZmV3IGxpbmVzIGZvciA0
IHNlY29uZHMsIG9yIGV2ZW4gbW9yZSBpZiBpdCBpcyBub3QgbG9uZyBlbm91Z2guDQo+Pj4+PiAN
Cj4+Pj4+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgcmlnaHQgZml4LiBDYW4geW91IGNoYW5n
ZSB0aGlzIHRvIGRvIGVjaG8gaW5zdGVhZC4NCj4+Pj4+IEl0IGRvZXMgdGhlIHNhbWUgdGhpbmcs
IGJ1dCBpdCBnb2VzIHRocm91Z2ggc3lzZnMgaW50ZXJmYWNlIGluc3RlYWQgb2YgZGlyZWN0DQo+
Pj4+PiB3cml0ZToNCj4+Pj4+IA0KPj4+Pj4gcmV0ID0gc3lzdGVtKCJlY2hvIG1lbSA+IC9zeXMv
cG93ZXIvc3RhdGXigJ0pOw0KPj4+PiBTdXJlLCBJIGNhbiBkbyB0aGF0Lg0KPj4+Pj4gDQo+Pj4+
Pj4gRml4ZXM6IGJmZDA5MmI4YzI3MjggKCJzZWxmdGVzdHM6IGJyZWFrcG9pbnQ6IGFkZCBzdGVw
X2FmdGVyX3N1c3BlbmRfdGVzdCIpDQo+Pj4+Pj4gUmVwb3J0ZWQtYnk6IFNpbmFkaW4gU2hhbiA8
c2luYWRpbi5zaGFuQG9yYWNsZS5jb20+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWWlmZWkgTGl1
IDx5aWZlaS5sLmxpdUBvcmFjbGUuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICAuLi4vc2VsZnRl
c3RzL2JyZWFrcG9pbnRzL3N0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMgICAgICB8IDkgKysrKysr
Ky0tDQo+Pj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JyZWFrcG9p
bnRzL3N0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cmVha3BvaW50cy9zdGVwX2FmdGVyX3N1c3BlbmRfdGVzdC5jDQo+Pj4+Pj4gaW5kZXggZGZlYzMx
ZmI5YjMwZC4uZDYxNWYwOTFlNWJhZSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icmVha3BvaW50cy9zdGVwX2FmdGVyX3N1c3BlbmRfdGVzdC5jDQo+Pj4+Pj4g
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnJlYWtwb2ludHMvc3RlcF9hZnRlcl9zdXNw
ZW5kX3Rlc3QuYw0KPj4+Pj4+IEBAIC0xOCw2ICsxOCw3IEBADQo+Pj4+Pj4gICNpbmNsdWRlIDxz
eXMvdGltZXJmZC5oPg0KPj4+Pj4+ICAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQo+Pj4+Pj4gICNp
bmNsdWRlIDxzeXMvd2FpdC5oPg0KPj4+Pj4+ICsjaW5jbHVkZSA8dGltZS5oPg0KPj4+Pj4+ICAg
ICNpbmNsdWRlICIuLi9rc2VsZnRlc3QuaCINCj4+Pj4+PiAgQEAgLTEzMyw2ICsxMzQsNyBAQCB2
b2lkIHN1c3BlbmQodm9pZCkNCj4+Pj4+PiAgIGludCB0aW1lcmZkOw0KPj4+Pj4+ICAgaW50IGVy
cjsNCj4+Pj4+PiAgIHN0cnVjdCBpdGltZXJzcGVjIHNwZWMgPSB7fTsNCj4+Pj4+PiArIGNsb2Nr
X3QgdDsNCj4+Pj4+PiAgICAgaWYgKGdldHVpZCgpICE9IDApDQo+Pj4+Pj4gICBrc2Z0X2V4aXRf
c2tpcCgiUGxlYXNlIHJ1biB0aGUgdGVzdCBhcyByb290IC0gRXhpdGluZy5cbiIpOw0KPj4+Pj4+
IEBAIC0xNTIsOCArMTU0LDExIEBAIHZvaWQgc3VzcGVuZCh2b2lkKQ0KPj4+Pj4+ICAgaWYgKGVy
ciA8IDApDQo+Pj4+Pj4gICBrc2Z0X2V4aXRfZmFpbF9tc2coInRpbWVyZmRfc2V0dGltZSgpIGZh
aWxlZFxuIik7DQo+Pj4+PiANCj4+Pj4+IEkgZG9uJ3QgdGhpbmsgeW91IHdpbGwgbmVlZCB0byBh
ZGQgY2xvY2soKSBjb2RlLiB0aW1lcmZkX3NldHRpbWUoKQ0KPj4+Pj4gc2V0cyB0aGUgdGltZSBm
b3IgNSBzZWNvbmRzIGFuZCB5b3UgY2FuIHNpbXBseSBleHRlbmQgdGhlIGFsYXJtDQo+Pj4+PiB0
aW1lLg0KPj4+Pj4gDQo+Pj4+PiBUaGVyZSBuZWVkcyB0byBiZSBzb21lIGxvZ2ljIHRvIGNoZWNr
IHRpbWVyIGVsYXBzZSBhbmQgcG9sbCB0aGUNCj4+Pj4+IHRpbWVyX2ZkDQo+Pj4+IFllcywgaXQg
aXMgYWxzbyBhIGNob2ljZSB0byBjaGVjayB0aGUgcmVtYWluaW5nIHRpbWUgb2YgdGhlIHRpbWVy
LiBXZSBjb3VsZCB1c2UgdGltZXJmZF9nZXR0aW1lKCkgdG8gZ2V0IHRoZSByZW1haW5pbmcgdGlt
ZS4gVGhlIHRpbWVyIHdvdWxkIG5vdCByZWFybSBiZWNhdXNlIHRoZSBpdF9pbnRlcnZhbCB2YWx1
ZSBpcyBub3Qgc2V0IChzZXQgdG8gMCkuIFRoZW4gaWYgdGhlIHJlbWFpbmluZyB0aW1lIGhhcyBi
b3RoIDAgb3Igc2Vjb25kcyBhbmQgbmFuby1zZWNvbmRzICh0dl9zZWMgYW5kIHR2X25zZWMpLCBp
dCBzaG91bGQgcG9pbnQgb3V0IHRoZSB0aW1lIGdvZXMgZm9yIGF0IGxlYXN0IDUgc2Vjb25kcy4g
SWYgdGhlIHN5c3RlbSBmYWlscyB0byBlbnRlciBzdXNwZW5kIHN0YXRlIGFuZCB3YWtlZCB1cCBi
eSB0aGUgdGltZXIsIGl0IHNob3VsZCBub3QgdGFrZSA1IHdob2xlIHNlY29uZHMgb3IgbW9yZSB0
byBnZXQgdG8gdGhlIGNoZWNrIGxpbmUuDQo+Pj4gDQo+Pj4gUmlnaHQsIFlvdSB3aWxsIGhhdmUg
dG8gY2hlY2sgdGhlIHJlbWFpbmluZyB0aW1lLiBUaGVyZSBpcyBhbiBleGFtcGxlIGluDQo+Pj4g
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL2FsYXJtdGltZXItc3VzcGVuZC5jIHlvdSBj
YW4gcmVmZXIgdG8uDQo+PiBJIGNoZWNrZWQgdGhlIHJlbWFpbmluZyB2YWx1ZSwgaWYgdGhlIHN1
c3BlbmQgc3VjY2VlZCwgaXQgd291bGQgYmUgYWxsIDAgKDBzIGFuZCAwIG5zKS4gSWYgaXQgZmFp
bGVkIHRvIGVudGVyIHN1c3BlbmQgYnkgYW55IGNoYW5jZSwgaXQgd291bGQgYmUgYSBub24temVy
byB2YWx1ZS4NCj4+PiANCj4+Pj4gV291bGQgeW91IHByZWZlciB0aGlzIG1ldGhvZHM/DQo+Pj4g
DQo+Pj4gSSBhbSBjdXJpb3VzIHdoYXQgaGFwcGVucyB3aXRoIHN0YXJ0aW5nIHN1c3BlbmQgd2l0
aCBzeXNmcyBmaXJzdCBhbmQgdGhlbg0KPj4+IGV4cGxvcmUgY2hlY2tpbmcgZWxhcHNlZCB0aW1l
ci4NCj4+PiANCj4+PiBzeXN0ZW0oImVjaG8gbWVtID4gL3N5cy9wb3dlci9zdGF0ZeKAnSk7DQo+
PiBJIGNoZWNrZWQgdGhpcywgYW5kIGZpbmQgdGhhdCBpdCB3aWxsIGdpdmUgYSBzaW1pbGFyIGZh
aWx1cmUuDQo+PiBzaDogbGluZSAxOiBlY2hvOiB3cml0ZSBlcnJvcjogRGV2aWNlIG9yIHJlc291
cmNlIGJ1c3kNCj4+IFRoZSBjb25zb2xlIGNvbW1hbmQgd2lsbCBnZXQgaXRzIHJldHVybiByZXN1
bHQgYWZ0ZXIgdGhlIHN1c3BlbmQgYW5kIHdha2UgdXAuIE1heWJlIHdlIGNvdWxkIGRvDQo+PiBz
eXN0ZW0oImVjaG8gbWVtID4gL3N5cy9wb3dlci9zdGF0ZSA+L2Rldi9udWzigJ0pOw0KPiANCj4g
WWVzLiBUaGUgaWRlYSBpcyB0aGF0IHdlIGdvIHRocm91Z2ggdGhlIHN5c2ZzIGludGVyZmFjZSBh
cyBvcHBvc2VkDQo+IHRvIHdyaXRpbmcgdG8gdGhlIGZpbGUgZGlyZWN0bHkuDQo+IA0KPj4gVG8g
YXZvaWQgYW4gZXJyb3IgbWVzc2FnZSBpbiB0aGUgY29uc29sZS4gQW5kIHdlIGFyZSBjaGVja2lu
ZyB0aGUgc3VjY2VzcyBvZiBzdXNwZW5kIGJ5IHRoZSB0aW1lLCBzbyBpdCB3b3VsZCBub3QgYmUg
bmVjZXNzYXJ5IGZvciB1cyB0byBzZWUgdGhlIG91dHB1dCBvZiB0aGlzIGNvbnNvbGUgY29tbWFu
ZC4NCj4gDQo+IFNvdW5kcyBnb29kIHRvIG1lLg0KPiANCj4gdGhhbmtzLA0KPiAtLSBTaHVhaA0K
DQoNCg==

