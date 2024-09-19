Return-Path: <linux-kselftest+bounces-18147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA2297CF5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 01:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E463C1C21633
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 23:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D01459EA;
	Thu, 19 Sep 2024 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jw4E2P1O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jsyxyFlw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B192594
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726787386; cv=fail; b=VUESEGGiDkgS2thB+8OmHzhLGU/iM94yS8JErUh7fkTAOrocKl///yLvEt/VsJTo7HyDgQg8WaU4odvSp5B2rzJEfP3Lx1w8fEPX98I/2Grf0Z6EwlzyQNz+eVEzPKw6EViGotQoIY8mEn0BG4vgBH3NderEj8IiheBJQOMYM5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726787386; c=relaxed/simple;
	bh=mMIOxR2NqwiD1HeYzxWmmR5uMEPmTNx7tFsjcUSG7/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BGmm5vSOVcwjdwJpo6Ao1v0d6ulWyNzIWFNiLyT2h6mBFx49nIF7J5b8YLTJ442PlLg3aJcAUyvxWgOS3tMJZDZNpPpOudkdZ0oKKLaCvHJnMd1mGMrrE6K4/KDUkyCi7Uu+/23dK+kTuPbyh0pwVjAifzcg1jIiZAzHei2FIFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jw4E2P1O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jsyxyFlw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JLMZmg001256;
	Thu, 19 Sep 2024 23:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=mMIOxR2NqwiD1HeYzxWmmR5uMEPmTNx7tFsjcUSG7
	/E=; b=Jw4E2P1Oor9TQ9ccC5kTNX0jAg6ovlk65VjlQAaukyMZ5WmFDW8F+BDtl
	YCoG2hbu4YbUVgQ6lY0upkdWSOvO5Eyv+VVupi/Sf40iFJJNDgrgCdyAg2XsnLio
	evrlXD5+1ULJKT5XXiXU93tuN7cP8TDQCgAsCu4lNz/pDOfwDR1+X0uxqd7cTIwq
	+15yLItHwOwnKn60BipNxaJCfftASBWz+nSzWsWGCiUV2+nYxuhqhvZSI2KpY8tB
	chsDvOcPwgpjcCco/rJvz0nqCqod7NS+upwHh2GVr0xS54H2ZiRr5/mnIT/us8EZ
	/Ijk3GjLSez2RIWGHv5ujSykDxfbw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nsnfmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 23:09:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48JLkiwP015016;
	Thu, 19 Sep 2024 23:09:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg6rn0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 23:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrdYPlFMAbfb2qzyYUuXg5ITiUaqQO1DmZJ6WalqWXI9LD9HzFx5oJoW6KSl+hAxbJ+FQemyFhyA8FJ907xFL8daENf/t4ZAYb8l6SHLdNI0jH7yr6TN2j1I1XV3MR2vUQOzsXLQi5B0n0DIlL30+DkUvB3yIv250RJZmM7hL3HVyQ809a8GebyVbRwxtIbVPDwpy2jlT6orV8Vu/RlxtaiZX8A2A3aWJr/6wiijug3JgAXkclIXFK8YrV6YBqXHretXg70pyFZs3w3MQvkrYcvM0PA/Ae0bfgao3ZBHqzdQaGI1vRMu+9y0q/1itxODWSWJ/B6/pdMl/vRYfdg6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMIOxR2NqwiD1HeYzxWmmR5uMEPmTNx7tFsjcUSG7/E=;
 b=O5rV4H9Bt3hoA0lXEeVrkf8utMmkjdFBiviDFd7SQ+gwF6X3xC2zeqMO0StxpszIRS+tHIdeGVjwwxNDQjxbrWjP3L8tWSZUc0+TUAu89zfZjanwGxcJdXKhNuAHnu+FFJNHpKGC1ve0ezdk8bj62e+NvilwzfkhjxelI2SefUkg52OD0UgR59ebzHQGnoK2Hz6TAjoD1Ktfw62mrDJ7llNz8xgCDsaQV3xYc+XbEJJFyYFBdpOnBzGLGdDMfU7J2dbPnWFNKwCvqhS03FgSBbRzcpBdVgtCIUtzsqPB44K/WiX/C/QxB+umBTra+ZWdDYShUvid5jtkBl5WQwh8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMIOxR2NqwiD1HeYzxWmmR5uMEPmTNx7tFsjcUSG7/E=;
 b=jsyxyFlwSFADWDP4JDAHAVcAUJmShYDUDgPcz2G3cw++Mdz8OZsf5B3r9tg4D+OMKxZK2LTR+5/HLPX4W0ipuazZ9zJvNzggyRgOZqFWDts68r5YpQxHlLaHvSVBdEyfkIbnj2UPVrHbzsOPpIIgpgRfVC9AN+4J6lawbRfG1GA=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by BN0PR10MB4982.namprd10.prod.outlook.com (2603:10b6:408:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Thu, 19 Sep
 2024 23:09:27 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 23:09:27 +0000
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
Thread-Index: AQHbCVPEQLti3BwH2UaJUde74H2DlbJfcxqAgABMJAA=
Date: Thu, 19 Sep 2024 23:09:27 +0000
Message-ID: <504209C8-0565-413D-BE89-A0ADE4E153AF@oracle.com>
References: <20240917224837.478684-1-yifei.l.liu@oracle.com>
 <6cdd7cc3-e5ca-48b0-bd49-d33bbf908cda@linuxfoundation.org>
In-Reply-To: <6cdd7cc3-e5ca-48b0-bd49-d33bbf908cda@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|BN0PR10MB4982:EE_
x-ms-office365-filtering-correlation-id: 6cc87419-4502-4023-8c0c-08dcd9001c11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWNXWFlJTmZmanRWSjlORWg2RmE1eExlTzQ3U1dsdmNla2IvSE9ZamsrNWJw?=
 =?utf-8?B?TmF0eDFUV3R0MVlGczFnWktQSGpSSEFQSlYyL3VUbXNkRXIxUlRGUloxYnIz?=
 =?utf-8?B?SkZWYzUzdkJxVkRsVldLamhrSktrN1JUWlRtOGFxQzVVaHpidGZtdWllN09P?=
 =?utf-8?B?bU9ZWVpNbVJsR291NGpvTlJpUmdPUTBNLzNNUkRHZmF2WnZQY0Y2RXBkN29U?=
 =?utf-8?B?QmlKeGZNN2NzaHRKWlVtTTM1WEZkVC82dytyMVF3MDQ5MGE2VVZGNGJUMnNL?=
 =?utf-8?B?bStUdU9xSXMrYjI3MnFBOTlNaWNnQ0owdHVzcG1iV00yYjNaZlJFOW8xS3o5?=
 =?utf-8?B?M2JLOWxrZ3oxN1EwOG5WTXZPdTRNTUdPeHM2MWE3dDlIWFFvMGk3RDFaZG0z?=
 =?utf-8?B?S0ZNTThQSEd0VTJJRElncGJRTWorUktjK3Z2WkcwQmJ4eGxvV1o4TDA0ejJL?=
 =?utf-8?B?VTQyWk9HNDJQaTR0Mm1KQ3NSZDhoMlFzWURGMjB0T1RPTldEUFBwSytMdWlq?=
 =?utf-8?B?bXRnYkF6YnZYaXV1UDJqbERKT09TMXhiQnk2V3FjM29aNU04YkU3bjlCQ3ha?=
 =?utf-8?B?OXFlNlVnb29qSlFSb1BlWC9yUXZCNTJoTmYyUEROeGhKMzNjK1JocUpnVkdI?=
 =?utf-8?B?VjVEeWo0Kyt6bkZYb1AvOC9TM1pvMWVPVWd2MElGN20zUktITm8yY0U1bFdl?=
 =?utf-8?B?KzZkTUNiQzlUbXNpYU9YNis4cHlSaEFuL05sWUxLUUpHNjFhV001R2FYZ2JV?=
 =?utf-8?B?TVhjVzlhakxpcmQvSTl6TkF5SDBJK1J6YjcwRlYwWUNKc1FZQTZ2ZDBPS3BH?=
 =?utf-8?B?Q0ZSa25POThYdDFsYXNGYmxyMzNuSHllNzBxZ2tBNkY4Y0ZJNytHTTUzZjNv?=
 =?utf-8?B?NGd5Z3QrS05FSjNtVGhoaldkL05hcXhiR0R3U2kwSFZXbGZxWS8vajFZRU5E?=
 =?utf-8?B?UXZDdHhNZXVxaW42UmxxQmg0NSs2VkZ0V2hDK0MzTHdxS1JZYlRVNjJsdUZa?=
 =?utf-8?B?cHBEa05DbjhGRDBLSytEK1pzNWxvWmNhZkNYS3pxM2ZVYzU4WENXclVOVlVy?=
 =?utf-8?B?ZE1rZTFaa2twQ3hhS3FWUUVOSHc4TEJEUUdnTnAxS0UxeWEwTzNPUURxQ2RN?=
 =?utf-8?B?Qk9lSE1UYnZQS1BTU2dvZFdCUmk3U3pRMUsvOWV0YUZIeVllYUtmRXY0Ui9u?=
 =?utf-8?B?LytkcmQzbGpBeU1uVjdzZGlvK0FrUTU2azRUekhjSEVVRnQ0Mk5CZlp5ZjNp?=
 =?utf-8?B?SENaVnNoaStCQWgrNFl3ZGx6SXVUdVBwRWp1a0syZ0JNSVVrZ05OTUhLdDRm?=
 =?utf-8?B?S2VMN2dCUmo0cXJLYTlKVzJ6NERHanh3SThKcUVGemRrUEE4dUxFb0RrY0lL?=
 =?utf-8?B?U25kVm8wV0lEbVZQTXRiSEtwS1NDMXBuR1NseDhIRXBWV1VVYkVESlZIVGpL?=
 =?utf-8?B?LzVwWnYwVmxmb29qMGVqQ1hwSnFvekRwQ3VlMlcvd3RnVnJCclh2c2MzSkMx?=
 =?utf-8?B?b055MVl1eHoxSGVTaHowUzgrSFZHL3Q0alJHVmRvWmFmYXY1SThkWDNHZWx0?=
 =?utf-8?B?bms2ZTcxeUdmc0lVOXgwckdwRlFpdWtNVUV2Z25Fd01YRnh3MGI4MDJObW5D?=
 =?utf-8?B?UmF6Y2VVRkU3YUZSVnVBU25pOUxhR1pzYTc1Y1g4dXI5TlAxeGNaSHd3OURp?=
 =?utf-8?B?dXlnQlp0aTFrZDNzMHFGb1FPRysyQUhZZ20vd1RvNzJWYW9TRUUrR3JnVmRZ?=
 =?utf-8?B?QmpKd3E0MFk1RDM4ZHRFY0MzMEFMWEYvcXFkNTNhUlhvWHR5TVkvemZSOVlF?=
 =?utf-8?B?WVZ6cGpwejg5Wlg4bGJIdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXFuMmxucDFkekY3a0p6eHlpN29qZGU4aWpGbmoyWTJpeW1ndTZmSmFrbFNy?=
 =?utf-8?B?Q1hqNkdnWnk3bjh5Y2FEeUt6ZFpKNm0xdFJ6eFJZTVJhQWFSTFZwdXVrc2kz?=
 =?utf-8?B?UEZ0cTlYTTVxMG1zQUtleUg2bjJ1RGNtSDBTSzJTTms3Zm9SaWxLNzJCWVJj?=
 =?utf-8?B?czRlL1NRdyttYWZrcS9kdWxkRnduWk1iSStpcWJMMmN2NHJqallteXpDTy9M?=
 =?utf-8?B?UHZIcVE3Ui8zMDMxZHBEeUVFc0lCaTRiZE5TN2JwT25xWjNWbU51VGhyUWZW?=
 =?utf-8?B?YWpOekhQbS9ZUmthNDJ4dXlUSlBuUEs3ZHFJblNOc0dtU3FwTFVQMGdRYTJj?=
 =?utf-8?B?YUM5emxXMVNrTzd6ZzBnYVg1clhBa01NRzRSRHVJeUFYOC9UL1R2MzFwODJH?=
 =?utf-8?B?NWlDQWJpMzFKNkZvMUtYQUJBckdRVEdJQTh0QkRxMzYzWmlGSWxDOUg0TzZj?=
 =?utf-8?B?cG9tMEQ3Z0xHODBIMTlDa3VleENEQWdYcFp6UU9LdU5kSUxGWEdvL3BHeXpz?=
 =?utf-8?B?M00wSzVZZVcxRFRNclliamR3dkFmRW5jdklUL2IrNkdyMjd4L3lkMi9IQzZ4?=
 =?utf-8?B?d1VOVTlyQk5zSW1GR0hObUkxWHlEdFdnajd4QUlWdm1oZXFYOVYwZTdETklz?=
 =?utf-8?B?cmVwN21uSjd6TW1IWVZ1Y0hIRXQ5TmFvT2kxZmRuSGxYeTZuaUtqZ1VNR21v?=
 =?utf-8?B?N2FXOFFlU0VQQWQxYnZ5SmtCZEY4Q3BPTEJ6TjlROU9ZM1JSVG5QMXNpYWM0?=
 =?utf-8?B?SGxnMXJCMFB1UUh0endldzlTZGNJODNQTUFNSk9GMUxDVWVOVkRQQ3JDNEJK?=
 =?utf-8?B?SEFwWlQ1Y0tsOFd3N3doaFozVEd6MVZuREVSV3dTZFZ3V3I5WC9Da2orVmdp?=
 =?utf-8?B?bStJZTZlSHBneUNiRTJpbnVFd21aM1dodmduMnNpamhRU1dkeS9PcWtOWWZv?=
 =?utf-8?B?TXJFckx5azJXdy9zK1ZCNXI0eWZKVTV3V1pKYjlpUjdCbFpFdkNWaFk1RGFG?=
 =?utf-8?B?QlBuNy83SUs4K3pmSHRMbVhHOHpsMzdRUmM0WGZxMGltZ2pQS3Ezc0RwVGtT?=
 =?utf-8?B?OFppQTFYS2F6S2FiZ0xEMnFPUlVRTmlaTG9ERG1aVVBkSm10UVdGOEJWYjB2?=
 =?utf-8?B?TVN1Ny8zNm41bkxPZVJJY2Zja3owMisyUG1HM3hRSkw1Q1hvN2RvaWdQZVpU?=
 =?utf-8?B?bVIrVnYrbEJEeUVyRGJtMWVZcjVOTGFEQU5RQWFvS3dFOExIdGlyY0dNbnBE?=
 =?utf-8?B?OGdaRG1BaTByOVpDejgyd3RxRmZkcUNyMVdRYWFHSU9FbldLL2RLSUhZTXA2?=
 =?utf-8?B?V3gxRStMNG1ZbDBKdWgwUUpLNnUxYW1FUnluNmZxaU9UWHhJT2VuQTJhaWU3?=
 =?utf-8?B?M1B1MnBpQVluU3ViRVpXVDN2Vyt4Nzhhb1ZCR3JlL0pTYWdDQzI2cGJQTm9R?=
 =?utf-8?B?WGZralFQdnd3aGFzQ3VvcnlyMzBwd3FXbjNYNm4rcm5NY0tMUVcrNjhLTEV3?=
 =?utf-8?B?TWg2elh1NFEyWU52VWM0Uy9WRGd0ZlZZdFNEM1NBZEw3d2dIMmFtbFJtbkQ4?=
 =?utf-8?B?WWlFNDJIR3VRMUxUY2lYWFJOY0Yya3AxMlhZRmVmTUlVWUM2VTB5NFpjWlZJ?=
 =?utf-8?B?cmR4RXBvY2ZXZ2t0QmRYbUhzS3dic1ZNc1VoRGlpZ1gyRnN4ZExyRlNMUnlI?=
 =?utf-8?B?clBRNCt1YTBoSGRhdHF4L081ekJpYXRvWENiZHhvNGp0bVg2ZDQwRGpSeEVG?=
 =?utf-8?B?Z2dDYjdySnhoWDJkUnhLM2JGd2NCT3QwbHJMUjRQNWhnZUtSTG90WUlKWGtm?=
 =?utf-8?B?UVN6MFZKaFZGMDdRRWk0Wk96UTcvYXlMR0JRb0QxQ1E2QlNsL1VJVW1hNjlp?=
 =?utf-8?B?VzFWWVY2cmZtc3FRL1IzZGNlbGNrZFlGMHlEVGd5Skg2dEJoU0JmaTVZMzFY?=
 =?utf-8?B?WTRwY3Y0bEVySHVabGUxTEgxRkdqc0xwOE9pRDZMM2ZtM09VOC9MZ0diUm5x?=
 =?utf-8?B?dmJLVzA2K1d0UUlRelZ4NlZxTFBXU054SktiWms1RGFSUTNscXdVRXAxM2JG?=
 =?utf-8?B?ZnhlRC9ZR04zOHE0QkJ5N0pFTVFOTG5CbXYwNThHYjdKdlgrVm9GbEhkVWlF?=
 =?utf-8?B?SDRZc1hkc3BDdmxHaEptaXloV0V3MEIvVVJ5a2Z4aEc3aVRwQkdXUlE5VUts?=
 =?utf-8?Q?p4gmXDNjCgRgJ/Qtpxuze2o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93F8006DE6DDF841A3C8DC3F6AB33CBE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iQ4eJdcUTkc5aPlKDkGYLUm+uM8A5tu3Evpeaccci9a/a5im6pl79Sadm4WJtzf/JrEHV/hFh1OjXGYVOlfLV3dd/zcvhB2EL7cnNFwCZ3fX+wfbGWqRGJ/t3SmdJQ8mg29unJBJLPt9eGDvR61c7xXaLHxxpUwxj3MKg9343p5bN/bc0RWP8MT6bOFlopoqgsFmTBWy6Cely5hjD3OjmkxNgz0PS3jcD0OoMSH1BQqITrGxHhrSHUFxPsY/Y61gxgeu5V3JgQzMjTSyJ7Upv5O802llf/EH3OtC5suljBARqdWVaHhPUwvXZrOnk1dQg2gpX0S2Oq90w6B8HsjIDXcVNRChDLj0nyl44kis43fqX5Ft44b/KDmLn1WIPj/H4DxKxoJL8I7kq9vTqh/iD3QmZbkVYQ/NL8yQoUatFbeTb+ebAv9gPGBcCFvjLeRUOd0aoK9NHyGhZRBMzNlmiEZVqAc1AYtudoZqEYsTCTgSsoovNWWQTK6G1njrh7tulC7CeCr2H/xNySMVNszv3/Y/NK8u5CU2fp1TC1EIebn5tE8xcc91ncfKZorpMf6rSDSXxr0ikABT2tRWtSOY2a8c3upXSBl9QADglgvh+l8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc87419-4502-4023-8c0c-08dcd9001c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 23:09:27.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Mj0XiVp+x6wQpo+fY44c3nI2sBiLOBzfl9alT3JeqOSrsZyvR1eUFd9/LTP4JRIyE75aPzMRrNc//kDULDqDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_22,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409190155
X-Proofpoint-GUID: xuBhFeZTn1p1r73qKAboGr5qtYf9cXNq
X-Proofpoint-ORIG-GUID: xuBhFeZTn1p1r73qKAboGr5qtYf9cXNq

SGkgU2h1YWgsDQoNCg0KPiBPbiBTZXAgMTksIDIwMjQsIGF0IDExOjM24oCvQU0sIFNodWFoIEto
YW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gOS8xNy8yNCAx
Njo0OCwgWWlmZWkgTGl1IHdyb3RlOg0KPj4gV2UgcmVjZW50bHkgbm90aWNlIHRoYXQgdGhlIHN0
ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0IHdvdWxkDQo+PiBmYWlsIG9uIG91ciBwbGVudHkgZGV2aWNl
cy4gIFRoZSB0ZXN0IGJlbGlldmVzaXQgZmFpbGVkIHRvDQo+IA0KPiBXaGF0IGFyZSAicGxlbnR5
IGRldmljZXMiDQo+IHJlY2VudGx5IG5vdGljZWQ/DQpXZSBoYXZlIHNlZW4gdGhpcyBpc3N1ZSBv
biBtb3JlIHRoYW4gb25lIHBsYXRmb3JtcywgaW5jbHVkaW5nIGJhcmUgbWV0YWwgZGV2aWNlIGFu
ZCB2aXJ0dWFsIG1hY2hpbmUuIA0KPiBUeXBvIC0gYmVsaWV2ZXNpdD8NClllcywgbWlzc2luZyBh
IHNwYWNlIGhlcmUuIEl0IHNob3VsZCBiZQ0KVGhlIHRlc3QgYmVsaWV2ZXMgaXRzZWxmIGZmYWls
ZWQgdG8gZW50ZXIgc3VzcGVuZCBzdGF0ZS4gDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIG91dC4g
DQo+IA0KPj4gZW50ZXIgc3VzcGVuZCBzdGF0ZSB3aXRoDQo+PiAkIHN1ZG8gLi9zdGVwX2FmdGVy
X3N1c3BlbmRfdGVzdA0KPj4gVEFQIHZlcnNpb24gMTMNCj4+IEJhaWwgb3V0ISBGYWlsZWQgdG8g
ZW50ZXIgU3VzcGVuZCBzdGF0ZQ0KPj4gSG93ZXZlciwgaW4gdGhlIGtlcm5lbCBtZXNzYWdlLCBJ
IGluZGVlZCBzZWUgdGhlIHN5c3RlbSBnZXQNCj4+IHN1c3BlbmRlZCBhbmQgdGhlbiB3YWtlIHVw
IGxhdGVyLg0KPj4gWzYxMTE3Mi4wMzMxMDhdIFBNOiBzdXNwZW5kIGVudHJ5IChzMmlkbGUpDQo+
PiBbNjExMTcyLjA0NDk0MF0gRmlsZXN5c3RlbXMgc3luYzogMC4wMDYgc2Vjb25kcw0KPj4gWzYx
MTE3Mi4wNTIyNTRdIEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzDQo+PiBbNjExMTcyLjA1
OTMxOV0gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgY29tcGxldGVkIChlbGFwc2VkIDAu
MDAxIHNlY29uZHMpDQo+PiBbNjExMTcyLjA2NzkyMF0gT09NIGtpbGxlciBkaXNhYmxlZC4NCj4+
IFs2MTExNzIuMDcyNDY1XSBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzDQo+PiBb
NjExMTcyLjA4MDMzMl0gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcyBjb21wbGV0
ZWQgKGVsYXBzZWQgMC4wMDEgc2Vjb25kcykNCj4+IFs2MTExNzIuMDg5NzI0XSBwcmludGs6IFN1
c3BlbmRpbmcgY29uc29sZShzKSAodXNlIG5vX2NvbnNvbGVfc3VzcGVuZCB0byBkZWJ1ZykNCj4+
IFs2MTExNzIuMTE3MTI2XSBzZXJpYWwgMDA6MDM6IGRpc2FibGVkDQo+PiAtLS0gc29tZSBvdGhl
ciBoYXJkd2FyZSBnZXQgcmVjb25uZWN0ZWQgLS0tDQo+PiBbNjExMjAzLjEzNjI3N10gT09NIGtp
bGxlciBlbmFibGVkLg0KPj4gWzYxMTIwMy4xNDA2MzddIFJlc3RhcnRpbmcgdGFza3MgLi4uDQo+
PiBbNjExMjAzLjE0MTEzNV0gdXNiIDEtOC4xOiBVU0IgZGlzY29ubmVjdCwgZGV2aWNlIG51bWJl
ciA3DQo+PiBbNjExMjAzLjE0MTc1NV0gZG9uZS4NCj4+IFs2MTEyMDMuMTU1MjY4XSByYW5kb206
IGNybmcgcmVzZWVkZWQgb24gc3lzdGVtIHJlc3VtcHRpb24NCj4+IFs2MTEyMDMuMTYyMDU5XSBQ
TTogc3VzcGVuZCBleGl0DQo+PiBBZnRlciBpbnZlc3RpZ2F0aW9uLCBJIG5vdGljZSB0aGF0IGZv
ciB0aGUgY29kZSBibG9jaw0KPj4gaWYgKHdyaXRlKHBvd2VyX3N0YXRlX2ZkLCAibWVtIiwgc3Ry
bGVuKCJtZW0iKSkgIT0gc3RybGVuKCJtZW0iKSkNCj4+IGtzZnRfZXhpdF9mYWlsX21zZygiRmFp
bGVkIHRvIGVudGVyIFN1c3BlbmQgc3RhdGVcbiIpOw0KPj4gVGhlIHdyaXRlIHdpbGwgcmV0dXJu
IC0xIGFuZCBlcnJubyBpcyBzZXQgdG8gMTYgKGRldmljZSBidXN5KS4NCj4+IEl0IHNob3VsZCBi
ZSBjYXVzZWQgYnkgdGhlIHdyaXRlIGZ1bmN0aW9uIGlzIG5vdCBzdWNjZXNzZnVsbHkgcmV0dXJu
ZWQNCj4+IGJlZm9yZSB0aGUgc3lzdGVtIHN1c3BlbmQgYW5kIHRoZSByZXR1cm4gdmFsdWUgZ2V0
IG1lc3NlZCB3aGVuIHdha2luZyB1cC4NCj4+IEFzIGEgcmVzdWx0LCBJdCBtYXkgYmUgYmV0dGVy
IHRvIGNoZWNrIHRoZSB0aW1lIHBhc3NlZCBvZiB0aG9zZSBmZXcgaW5zdHJ1Y3Rpb25zDQo+PiB0
byBkZXRlcm1pbmUgd2hldGhlciB0aGUgc3VzcGVuZCBpcyBleGVjdXRlZCBjb3JyZWN0bHkgZm9y
IGl0IGlzIHByZXR0eSBoYXJkIHRvDQo+PiBleGVjdXRlIHRob3NlIGZldyBsaW5lcyBmb3IgNCBz
ZWNvbmRzLCBvciBldmVuIG1vcmUgaWYgaXQgaXMgbm90IGxvbmcgZW5vdWdoLg0KPiANCj4gSSBk
b24ndCB0aGluayB0aGlzIGlzIHRoZSByaWdodCBmaXguIENhbiB5b3UgY2hhbmdlIHRoaXMgdG8g
ZG8gZWNobyBpbnN0ZWFkLg0KPiBJdCBkb2VzIHRoZSBzYW1lIHRoaW5nLCBidXQgaXQgZ29lcyB0
aHJvdWdoIHN5c2ZzIGludGVyZmFjZSBpbnN0ZWFkIG9mIGRpcmVjdA0KPiB3cml0ZToNCj4gDQo+
IHJldCA9IHN5c3RlbSgiZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRl4oCdKTsNClN1cmUsIEkg
Y2FuIGRvIHRoYXQuIA0KPiANCj4+IEZpeGVzOiBiZmQwOTJiOGMyNzI4ICgic2VsZnRlc3RzOiBi
cmVha3BvaW50OiBhZGQgc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QiKQ0KPj4gUmVwb3J0ZWQtYnk6
IFNpbmFkaW4gU2hhbiA8c2luYWRpbi5zaGFuQG9yYWNsZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZaWZlaSBMaXUgPHlpZmVpLmwubGl1QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+ICAuLi4vc2Vs
ZnRlc3RzL2JyZWFrcG9pbnRzL3N0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMgICAgICB8IDkgKysr
KysrKy0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icmVha3BvaW50cy9z
dGVwX2FmdGVyX3N1c3BlbmRfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnJlYWtw
b2ludHMvc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QuYw0KPj4gaW5kZXggZGZlYzMxZmI5YjMwZC4u
ZDYxNWYwOTFlNWJhZSAxMDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jy
ZWFrcG9pbnRzL3N0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMNCj4+ICsrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JyZWFrcG9pbnRzL3N0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMNCj4+IEBA
IC0xOCw2ICsxOCw3IEBADQo+PiAgI2luY2x1ZGUgPHN5cy90aW1lcmZkLmg+DQo+PiAgI2luY2x1
ZGUgPHN5cy90eXBlcy5oPg0KPj4gICNpbmNsdWRlIDxzeXMvd2FpdC5oPg0KPj4gKyNpbmNsdWRl
IDx0aW1lLmg+DQo+PiAgICAjaW5jbHVkZSAiLi4va3NlbGZ0ZXN0LmgiDQo+PiAgQEAgLTEzMyw2
ICsxMzQsNyBAQCB2b2lkIHN1c3BlbmQodm9pZCkNCj4+ICAgaW50IHRpbWVyZmQ7DQo+PiAgIGlu
dCBlcnI7DQo+PiAgIHN0cnVjdCBpdGltZXJzcGVjIHNwZWMgPSB7fTsNCj4+ICsgY2xvY2tfdCB0
Ow0KPj4gICAgIGlmIChnZXR1aWQoKSAhPSAwKQ0KPj4gICBrc2Z0X2V4aXRfc2tpcCgiUGxlYXNl
IHJ1biB0aGUgdGVzdCBhcyByb290IC0gRXhpdGluZy5cbiIpOw0KPj4gQEAgLTE1Miw4ICsxNTQs
MTEgQEAgdm9pZCBzdXNwZW5kKHZvaWQpDQo+PiAgIGlmIChlcnIgPCAwKQ0KPj4gICBrc2Z0X2V4
aXRfZmFpbF9tc2coInRpbWVyZmRfc2V0dGltZSgpIGZhaWxlZFxuIik7DQo+IA0KPiBJIGRvbid0
IHRoaW5rIHlvdSB3aWxsIG5lZWQgdG8gYWRkIGNsb2NrKCkgY29kZS4gdGltZXJmZF9zZXR0aW1l
KCkNCj4gc2V0cyB0aGUgdGltZSBmb3IgNSBzZWNvbmRzIGFuZCB5b3UgY2FuIHNpbXBseSBleHRl
bmQgdGhlIGFsYXJtDQo+IHRpbWUuDQo+IA0KPiBUaGVyZSBuZWVkcyB0byBiZSBzb21lIGxvZ2lj
IHRvIGNoZWNrIHRpbWVyIGVsYXBzZSBhbmQgcG9sbCB0aGUNCj4gdGltZXJfZmQNClllcywgaXQg
aXMgYWxzbyBhIGNob2ljZSB0byBjaGVjayB0aGUgcmVtYWluaW5nIHRpbWUgb2YgdGhlIHRpbWVy
LiBXZSBjb3VsZCB1c2UgdGltZXJmZF9nZXR0aW1lKCkgdG8gZ2V0IHRoZSByZW1haW5pbmcgdGlt
ZS4gVGhlIHRpbWVyIHdvdWxkIG5vdCByZWFybSBiZWNhdXNlIHRoZSBpdF9pbnRlcnZhbCB2YWx1
ZSBpcyBub3Qgc2V0IChzZXQgdG8gMCkuIFRoZW4gaWYgdGhlIHJlbWFpbmluZyB0aW1lIGhhcyBi
b3RoIDAgb3Igc2Vjb25kcyBhbmQgbmFuby1zZWNvbmRzICh0dl9zZWMgYW5kIHR2X25zZWMpLCBp
dCBzaG91bGQgcG9pbnQgb3V0IHRoZSB0aW1lIGdvZXMgZm9yIGF0IGxlYXN0IDUgc2Vjb25kcy4g
SWYgdGhlIHN5c3RlbSBmYWlscyB0byBlbnRlciBzdXNwZW5kIHN0YXRlIGFuZCB3YWtlZCB1cCBi
eSB0aGUgdGltZXIsIGl0IHNob3VsZCBub3QgdGFrZSA1IHdob2xlIHNlY29uZHMgb3IgbW9yZSB0
byBnZXQgdG8gdGhlIGNoZWNrIGxpbmUuIA0KV291bGQgeW91IHByZWZlciB0aGlzIG1ldGhvZHM/
DQo+IA0KPj4gIC0gaWYgKHdyaXRlKHBvd2VyX3N0YXRlX2ZkLCAibWVtIiwgc3RybGVuKCJtZW0i
KSkgIT0gc3RybGVuKCJtZW0iKSkNCj4+IC0ga3NmdF9leGl0X2ZhaWxfbXNnKCJGYWlsZWQgdG8g
ZW50ZXIgU3VzcGVuZCBzdGF0ZVxuIik7DQo+PiArIHQgPSBjbG9jaygpOw0KPj4gKyB3cml0ZShw
b3dlcl9zdGF0ZV9mZCwgIm1lbSIsIHN0cmxlbigibWVtIikpOw0KPj4gKyB0ID0gY2xvY2soKS10
Ow0KPj4gKyBpZiAoKGludCkodCkgPCA0KQ0KPj4gKyBrc2Z0X2V4aXRfZmFpbF9tc2coIkZhaWxl
ZCB0byBlbnRlciBTdXNwZW5kIHN0YXRlICVkXG4iLGVycm5vKTsNCj4+ICAgICBjbG9zZSh0aW1l
cmZkKTsNCj4+ICAgY2xvc2UocG93ZXJfc3RhdGVfZmQpOw0KPiANCj4gdGhhbmtzLA0KPiDigJQg
U2h1YWgNClRoYW5rIHlvdSB2ZXJ5IG11Y2gNCllpZmVpDQoNCg==

