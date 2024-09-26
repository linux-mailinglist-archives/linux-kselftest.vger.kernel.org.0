Return-Path: <linux-kselftest+bounces-18395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062F9870E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 11:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D4EB272D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A721AC8B5;
	Thu, 26 Sep 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h1MUEZXq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JiG9hmd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F641ABED0;
	Thu, 26 Sep 2024 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344643; cv=fail; b=ifu9RtZwE/OvoF10e3idoQT1shdx0DkcX+fCYT07ZgFwxSeMH4Upq8rEDttPvpxZUJm8VIcaS5A9GRcDYUsXmZByvlf+HSmaBONBqoaFYZIYveaZbkPSjKaOITedHQn+8V1TtnlG5XXbYiB7vdmF0xX1zB+FsChf3NxSfVW/1dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344643; c=relaxed/simple;
	bh=SspOIMzSedjcYIxWsDsGBni8TIeu5y1hV7MsgOw/PHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMlgRQ/XV2R5NWiVH0hkjM1k6U6WvLNWvBRHFOQ1gbnS9JmXtrMHHFKAbdj2wPV1bWi/LWxrerjG4FGHkTt9f6fy0Yr85VsuSKo/j87IjtvjPjQWOxwaB6cgb/IdvTObbGBOPoKUl75DEPYag+C8LSi/abz0CJvMAkWMlVo2+Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h1MUEZXq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JiG9hmd0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q1fdsR005383;
	Thu, 26 Sep 2024 09:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=SspOIMzSedjcYIxWsDsGBni8TIeu5y1hV7MsgOw/P
	Ho=; b=h1MUEZXqiWmXSwEhyzYCiEc7nppq7CI9EJjBU1onwQ0fcWNCxZVvfJ4Zo
	9/I++4Z2SxG/ML9M1xP/hzc9kpJU+JcIDvAZOWanZLhA+Dp8s47RXb62z35YM4AM
	DC1yfTO82LVT9EmLU9006dn6WGH/CRwvN6VCPS8JlzYV/gCH1oD49rNWNd5Ihyhm
	pKp6ZYCcBQG/miuITkMR3ktIl1zKk5eRtuFmTZos5noF67nBqCVBOY16XGjaedCF
	AocXv40ThtlUiCdyuykYX6m6fLqKSpCA4dOZC8ziNTl1EjREkGwxKVGQzJlIHuzm
	3XVZO1yTqgU054JXcszOMJCJx/4Pg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppucq69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 09:56:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q88mLZ025353;
	Thu, 26 Sep 2024 09:56:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkbx4ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 09:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgmZrCUKmjbJ8rajRh8gKFBOdtAJ0ZPjvhaVDDUDTJd0CV8JC8/oxaA7myg2UO9kRe+GEN+WUj/bMdXYcb4qDqSM7nmiFqzRt8R6LuOsdqPTGtDkN0jDUGt93EmiFTqsMmptt3rDEuKpU+Ckm1o3Q1kkivNNHVMc9SUaS7ZEa4mYgidAg4Gj4qTnHv8J0XYdKZMXLjPHskctFVYnpYqGqoF6A9EfKXn5XLe+KYcEK2gmc2V/taA/3mcbpJqGI2vesxTzlHHRZ8EjBIvwJB9rwFFDFbxMHbT60WuXJQc9X0yGk4Ql/BIE/B9lZERMOHezTlulPj0ODCA0sTELxVNoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SspOIMzSedjcYIxWsDsGBni8TIeu5y1hV7MsgOw/PHo=;
 b=L5pgbT/NY/dAlwF/+iVYCHh+3o2z+dRpLRBttmW0nkUSLUDIriYljMVLvrOHjV5OZZCWiIj3Q94uRelQgW78fGnH+QSeLdLzg+U7asir+kGFWt0qERo9BmZVZ0UDQj2NsybDyFpndNdrSGxxdfwyTZ4C9P/nvy8usQZa4Am5tVtKhjcpNjGR9Otn7DNqbDw+RQ8Q3erLiWHgXNf7Bh1HnYlc468pwLgWKrPd9evmPUPk3YS/N3suQmJHTMbnDaQF8wE5Cea32MLe/MrFG5EOrxrKiu15uzwu7UDFyyvcaCOyWUZAmsAz3sYKX8Bk6xcBjlYreBmGklqmDfJNd09mjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SspOIMzSedjcYIxWsDsGBni8TIeu5y1hV7MsgOw/PHo=;
 b=JiG9hmd0tWnnoOt+N3CeYGRgUwaUQuam/ygl4fg5Km1GPv3O0e9eljj9zOK6DweGW6DQTqRNRrdeo0QEfo97rfkyc9b5+VuRpNQabYamk97wFNmbaUuROJWSkFqlHnb3Q6USij8bLEGMdPeVlyVZ4Sn445Ef2EgOkhDe4ptq6AU=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CO1PR10MB4770.namprd10.prod.outlook.com (2603:10b6:303:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Thu, 26 Sep
 2024 09:56:46 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 09:56:46 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        James
 Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo
 Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, Shuah Khan
	<shuah@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] firmware/psci: Add definitions for PSCI v1.3
 specification
Thread-Topic: [PATCH v4 1/6] firmware/psci: Add definitions for PSCI v1.3
 specification
Thread-Index: AQHbDpvhaEWnn85b+0SYmsB4oiosBrJp14AA
Date: Thu, 26 Sep 2024 09:56:46 +0000
Message-ID: <2868989D-73CA-4208-8B54-CC3C78A2F1EF@oracle.com>
References: <20240924160512.4138879-1-dwmw2@infradead.org>
In-Reply-To: <20240924160512.4138879-1-dwmw2@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|CO1PR10MB4770:EE_
x-ms-office365-filtering-correlation-id: 1fc953cf-9fca-4e74-4518-08dcde11886e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3lXZlFjblRCaDl5amhLazJkUGgxK3lLS3lIaWV2WVhnTmE0UkJwWnVZWU1C?=
 =?utf-8?B?d3U1U2M0OUVHY294bE5vOVExT2x5MlhMZVVuWElKRVh5NXVkVXRsdFBXZWZ5?=
 =?utf-8?B?QS8zMURvQTVCQUJUeS9NWDM5YzFjUGxzQXpCd1JWcGFLazVIOGZUbVRaQkJI?=
 =?utf-8?B?RzRqd1ZxUTlWbmxlNUNRc2FDeXZiaGxpM3ZyaE9RSjF0ZFViVWxzeDRUU0F6?=
 =?utf-8?B?V1JuUGU4VmVucHZDRWdTaWVHc2tVaC9ZeVhXR3NEaEp1Ky9oajJSajBKRU9Z?=
 =?utf-8?B?NHdBdURwMDJnTFRzbmhHWVJNV1h0V09CSmlwdlNpTjNId3V0cUhRdHFwK0dp?=
 =?utf-8?B?TTJsQVVURElYczNNcTdmUnlhdHlkeklHY2V1dm1HQ1NKeGsxWFVsUFIrU3Fn?=
 =?utf-8?B?enQvL1ZtYTFwdk93cWpjT3U1YklBVDd0Mm9BTlUvbkxGM05uS1NCWm1ISjhT?=
 =?utf-8?B?ck9vOEl5MGJ4dDlNWlZHeGJJUUYwS2FWaGcza0RDcyt5Sk9sVzhGUmZXQmd0?=
 =?utf-8?B?c0hJd1hiRCs2WEk4aWlLYXRRbHMzTHlSM2EyS1VmRmJpQVhQdlVaMU82TWZD?=
 =?utf-8?B?TnYrNG5oYk1UMFFRZU5qL1ord1plTGJsUlJmTkZtRmR3S2RhTldGbHJzVDhs?=
 =?utf-8?B?YXVYS2pCcE9PUzZHS0dZcTdUOTJFTXk3VVZoUEhSakdINnN6OWJDd0FWRytF?=
 =?utf-8?B?K1g0S3ZUNFYxWFBRUm1oV0NOenFJOXF1emV0Y0xTTzBILzZ3cGJ4UXBFYW5O?=
 =?utf-8?B?Q1QzZGw5ZnpmNkM4eWlWVjlKMnl1bWYxdXdRd045WGQvUTNTTVRnVlZMUXBi?=
 =?utf-8?B?Vmh2V3lNU25lZC82c1Rsd0pyT01haEpqbWNYNHE3Ym9NZVk4b09DVlhkWGRR?=
 =?utf-8?B?UG91L2ZLVTloQ0ZZWWdwZFp1ZHJJc1pOY3RaSTdTTHZBWVBMcFZObm1jUkJw?=
 =?utf-8?B?RVduZFpJZ01RSmxGQVZ4ZVZ5REJqUU91RGdReUtzOEdrRzVmN3ZYM0lMSTRj?=
 =?utf-8?B?ZUFtU3A2Qk93V0M1YWZLNTBheU16Q0xocTV2T3ZxQVJCTGRSTHlGQmhFQUI4?=
 =?utf-8?B?ZThyWmNQNG56QmJLQnNGYWU2UHE0bFYxcXo2TkZZdkhHMkxLamJZV1ZCeXJQ?=
 =?utf-8?B?aHU4WDFlM1FyN25qMEtHanl4b0JydTE3VUxSdnczREZsZGRpU1V3a3Rsbk5I?=
 =?utf-8?B?UkxBM2N0dW9Wa3JkamRMdkJUNFJKa0NUc2hqSmwxSkZGS3FlZEJaQzBUa2hZ?=
 =?utf-8?B?VENBNkROcW9VSjhLM2RFK3hTS2tXRWtTd0ZKMytrc28wNEZ3dTUrOVp5T205?=
 =?utf-8?B?SzFvZjFkaUFMV2laYUhNeTFuMitqWjhBZzFxTXZYSTlvd0Q3RXlFamNZNlVP?=
 =?utf-8?B?d0M1cEI5VUd3ellVTUF2S1MvUmFmbmtmUXVKZGVOd3BEWkhMVUMwQXg2eGV6?=
 =?utf-8?B?OHlqRFhXRk5UeFBQMU5uVHByM0pDSDRlMWRWblZSZVQvWExiWjhPSCs3bnpI?=
 =?utf-8?B?U1NKMWpXaFByQWJMM3BrKy9WQWR0cjZ6K0Q0MjVpeHUreGcxZGVGZUt3WStF?=
 =?utf-8?B?VlVSMkd6N0tON2RZTHhpS0xnaS9wYXNsM2tveGpsMEl4cXhUZW9TaXdDOWJj?=
 =?utf-8?B?TDZQY3FoUE1jV2haWlJURUJiM1NFbDg2cVdmeGJWWWEyL0hacm5kZWRjNVp2?=
 =?utf-8?B?VVplTWhGblFzLzlveTdsV3hFYXdaSnIxQWN0QXJPU0RsZlc4WE83SkZGaXNL?=
 =?utf-8?B?THZ2REdkTnlQMXc3d0RhUm1PVVdJNDZ5eldDdXE2NVczaTlVNzdMYzNkK1Vy?=
 =?utf-8?B?TkJQd0RsczZrRDhPY1NuUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHJpMW9oVXA1dmhlNFBsVmVsTUQvSmFpTzNQejY2K0Z2MWFiZm03OXBRTGFl?=
 =?utf-8?B?TXdZbnppUE0xTVg0NFB4VGVkV3NOL2NLcGZFUEpqK1NWODgrOTRNYWdZNDFX?=
 =?utf-8?B?bzc3Qk9MM094ekZpRnRucEo2MDhXRk15YTIzQnY2TkJBZksvZlQvNEtDbXZI?=
 =?utf-8?B?ZFBydnVTS1A0YUU5QzkxUDdhSjlQczR4aXVoU01BRDZvOFd1bHNqMFFZSlRn?=
 =?utf-8?B?WDc2LzFwQlBaaTVDN3c4eVh0c0IwSS9QZXdjSEg0U0dqdGZJR250T3lhR294?=
 =?utf-8?B?cHl4NEhSeTJ0M2FUWFRneUlJRkxCM3V2TEFpNjdObGZzMVYzcitmVjZBamNr?=
 =?utf-8?B?VjFDSW14UVhvd2YwNmJQOVJPUFZwRWJENjU3eU9LTkQ4RXdlN1l5OUNKOTA1?=
 =?utf-8?B?Y1ZPbGl6ZnZEc09nUFJ2WXpqb0x0anQ2dkZ0SFpTSFZVUi9HQmVidUhWWEhX?=
 =?utf-8?B?QnA0MmtIRDlMWVpCUXM2WEZFYWI3R3dLdmRYbHJSaVArYm4yNUM4dXpKU3o4?=
 =?utf-8?B?Q1JJYytkRHkwallpaUFLUWlRK2plY1FRYUhqWUIyWGIrL21PVnlSSHdSVDFT?=
 =?utf-8?B?ejZhOC9MUnk0Z0hoZ3B5bmQ2QWt1Mm1DbmRpZGJ4WDQwUWtrak9Ua1VVaUZD?=
 =?utf-8?B?a1NmTTVLT05raHc3ejNpa3JJbHhTVXRTMjROaGptOUVGL2hBTDFocGVaeGlo?=
 =?utf-8?B?SW15TU96VUpiWXJiSjBxVDZoOHBhUmlMYnpZZk5HcUZPOXV4b3NmVVp3YlNX?=
 =?utf-8?B?NldQdnBrYVVqY3JBemJkaUxoL0ZRYnExZXg1dENMelpvdFJpYklpVVBUK1NH?=
 =?utf-8?B?WVpqc2h4dnVrZVYwU0grOTdyN1l5TWNjWHVVaFFlV1lGTjZ2SkFkdTl6N0RQ?=
 =?utf-8?B?WlExMHJNSmZ0RUhxeTR4YTVkTm1TclNvQkE0aVEzK2ZDWmNQWWltdVlCMXB3?=
 =?utf-8?B?S1JFNG9qamJxeFpJMUJxdWxURk1HTGprYmZjQXBxaC9zZFNhbmNJUWZScUJl?=
 =?utf-8?B?akpOV2R3a2cza0ZlQzhPSXozUW5KL0wrbzVHMG1zeVdSZTB6dXFLWnFPTGhv?=
 =?utf-8?B?K09ORmJ0TElNaE5HL2trMUJIODM5dm9BM2xrTzEyQVE2V29mS012TFRyOHVu?=
 =?utf-8?B?cFFTb0pmenNHMjFWSytRMlRPOFJzREFvRHNtUlBwVzZ6YnRzanlFc2Z4Uk02?=
 =?utf-8?B?ZFltZUgyQW5Ra25xWWZabEtuLzRwWk1oOUxYdXBRZXczN3kzWnZSeSsxeVh4?=
 =?utf-8?B?NHVVb2RWNWJZZ2laVHkvQWJyYmxLYUdGa2FwL1MwSGFMRjdXRTFyV3g5TVFW?=
 =?utf-8?B?ekFrR0l5TTlDY0RSZmpScldHbWlpUVp1U29kNFVFeEh4ZW5YQVBzUlRTSGJj?=
 =?utf-8?B?bEZHNjFVT3NyMkM1RVpFNWorUWxTUThRcUswa000Q2VQc3M5WEpVd2VsRUF3?=
 =?utf-8?B?Zm9ZMWxmajNQK3BlMmxZU0FJdlhoKzcwN2lqcmo0aEV2OGNOU2RGQ0RhM0cz?=
 =?utf-8?B?czRzbEJzMXh4MTVjaWltQlFhV3lHVUVQV21iZDRHWDJZTWxKMGlxMjNCcmRr?=
 =?utf-8?B?Q3RZSGQ3NXBrUE5PMVFMdTBVd1M0WWdMMnZrK2d1VlBtYVNXUUNOMnphS1JZ?=
 =?utf-8?B?cnhqSnVtUzBkbW96WVNteGxyR3FsWE82TktQdEt3d052UFR5L0ZrQnc2aVBM?=
 =?utf-8?B?TXRteW5lblRubkRSeVFzU3RyUllENVExUjJCTFVwZDJ1YlMyMDBRTUJDN2VE?=
 =?utf-8?B?NWVDQmN6VVcwZ0RmampBZjJyejlXOEJTTDdQN2Q1TENNWHRrbDVuVXVSUGlw?=
 =?utf-8?B?dERsK3k4SDB4YUoyZ3dKYVZ4Uk04clp0VHNCMGViWnhaekhtN2k3b3BWZ1or?=
 =?utf-8?B?bElrbFlNOHowbzI2SnJwUU5NeDUwWDlUbHAyRXlxaFAzb0JKNzdwb2wxZ2da?=
 =?utf-8?B?RGpLL0VCaUtSN3QxbGp0VURMRGhJd0Ivb1ZiaHR4VVN2NUI2cHJwNDBwSi92?=
 =?utf-8?B?NDNBUnl6Y2JNbXBuNFRsSlB1Rmo0NHVjY2RoSG1KYlJTVE9VckVnelZLRUtJ?=
 =?utf-8?B?dkF2R1k0V3g0aUZOTEs5VzJiTTZiM0dJdWc2cFpDa3Y2U015SnVoUE9TWUZm?=
 =?utf-8?B?byszY2N3SFVhUlBhYWZkVVhzd2VhaUJkclRZMDFhaEZ0WlJTTjB1eGdITHpV?=
 =?utf-8?Q?sMn+we8RiYTvjFY0AaYzJAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED5AB20A464D4B4DBE0C235E268DAA57@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IzP4XLT0oxaJ6kPLnnrdgPVQ3ceLZ0P5ruYJN7E0BNmV6AI7dlSeN5/iCVljz05jBwe+JgEXMA5rwoTgbxE7rw/7CdgY+WxpFuJUB8d4zFSGkYj6CR5fvakTt+xBCIpclyQAYNf98uPqHbzbArp4ANWVIfM8UA8KMNknxOHWS7PODkiipXFQthdV045VqZK+E1JMuhwIEsHoUrFlEWZYGyLEe0M6sP3oL0lvcM131MqMbzZW5VNKuSetBglWb74BJUKgMMZykJic7Q7oxa4EsJxyaYDDrzbHLi4LFtAT4zjrDpGLQ9MpBF1g8uPC5/FPNImibYhRTRqwdmy3Nqyclq5cUZg3FkuZkSk9FOdxFXdmlHvhm0W1a/hJ6OjweQDxCyD5O//xEiYQbRVd3oERV1D3CNrAB5XyKmPDCzW7HF/m1GeKQLXgCAqDuRZtpcj6/xJ+t3Z92wVi5oQXtd5WOxZQzZBs/AGK3iVUUr0FcJ2w8kwCC/SLoyZs50TT5zdvLftLLInarLtgGfr0KabKC6nh9ig0b8k2a9jJnnnoC18b764jACa+RIYc31aTrCdzSL+6vrmGDu2g0CO8wBoeKaXE1L+zeI+RAv8NM1xZ1VM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc953cf-9fca-4e74-4518-08dcde11886e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:56:46.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ns8gpOWS/xW61J5HrqqmQC4vefcojNY8kJtWjw3GFL7bfuLPE6zxBJqG27YKPH/Lb6hIP3mTPn0pDhh97lulrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_03,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260065
X-Proofpoint-GUID: knGlEh8IxIvxE_oE5I7lZX77Rfm41fPc
X-Proofpoint-ORIG-GUID: knGlEh8IxIvxE_oE5I7lZX77Rfm41fPc

SGkgRGF2aWQsDQoNCj4gT24gMjQgU2VwIDIwMjQsIGF0IDE2OjA1LCBEYXZpZCBXb29kaG91c2Ug
PGR3bXcyQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gRnJvbTogRGF2aWQgV29vZGhvdXNl
IDxkd213QGFtYXpvbi5jby51az4NCj4gDQo+IFRoZSB2MS4zIFBTQ0kgc3BlYyAoaHR0cHM6Ly9k
ZXZlbG9wZXIuYXJtLmNvbS9kb2N1bWVudGF0aW9uL2RlbjAwMjIpIGFkZHMNCj4gU1lTVEVNX09G
RjIsIENMRUFOX0lOVl9NRU1SRUdJT04gYW5kIENMRUFOX0lOVl9NRU1SRUdJT05fQVRUUklCVVRF
Uw0KPiBmdW5jdGlvbnMuIEFkZCBkZWZpbml0aW9ucyBmb3IgdGhlbSBhbmQgdGhlaXIgcGFyYW1l
dGVycywgYWxvbmcgd2l0aCB0aGUNCj4gbmV3IFRJTUVPVVQsIFJBVEVfTElNSVRFRCBhbmQgQlVT
WSBlcnJvciB2YWx1ZXMuDQo+IA0KDQpERU4wMDIyRiBSRUwgc3VwZXJzZWRlZCBERU4wMDIyRiBB
TFAxIHdoaWNoIGRvZXNu4oCZdCBkZXNjcmliZSBDTEVBTl9JTlZfTUVNUkVHSU9ODQpvciBDTEVB
Tl9JTlZfTUVNUkVHSU9OX0FUVFJJQlVURVMuIERlZmluaW5nIHRob3NlIGF0IGFub3RoZXIgdGlt
ZSBzaG91bGRu4oCZdCBiZSBhDQpibG9ja2VyIGZvciB0aGUgcmVzdCBvZiB0aGlzIHBhdGNoc2V0
Lg0KDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdvb2Rob3VzZSA8ZHdtd0BhbWF6b24uY28udWs+
DQo+IC0tLQ0KPiBpbmNsdWRlL3VhcGkvbGludXgvcHNjaS5oIHwgMjAgKysrKysrKysrKysrKysr
KysrKysNCj4gMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvbGludXgvcHNjaS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3BzY2ku
aA0KPiBpbmRleCA0MmE0MGFkM2ZiNjIuLjA4MmVkNjg5ZmRhZiAxMDA2NDQNCj4gLS0tIGEvaW5j
bHVkZS91YXBpL2xpbnV4L3BzY2kuaA0KPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvcHNjaS5o
DQo+IEBAIC01OSw2ICs1OSw4IEBADQo+ICNkZWZpbmUgUFNDSV8xXzFfRk5fU1lTVEVNX1JFU0VU
MiBQU0NJXzBfMl9GTigxOCkNCj4gI2RlZmluZSBQU0NJXzFfMV9GTl9NRU1fUFJPVEVDVCBQU0NJ
XzBfMl9GTigxOSkNCj4gI2RlZmluZSBQU0NJXzFfMV9GTl9NRU1fUFJPVEVDVF9DSEVDS19SQU5H
RSBQU0NJXzBfMl9GTigyMCkNCj4gKyNkZWZpbmUgUFNDSV8xXzNfRk5fU1lTVEVNX09GRjIgUFND
SV8wXzJfRk4oMjEpDQo+ICsjZGVmaW5lIFBTQ0lfMV8zX0ZOX0NMRUFOX0lOVl9NRU1SRUdJT05f
QVRUUklCVVRFUyBQU0NJXzBfMl9GTigyMykNCj4gDQo+ICNkZWZpbmUgUFNDSV8xXzBfRk42NF9D
UFVfREVGQVVMVF9TVVNQRU5EIFBTQ0lfMF8yX0ZONjQoMTIpDQo+ICNkZWZpbmUgUFNDSV8xXzBf
Rk42NF9OT0RFX0hXX1NUQVRFIFBTQ0lfMF8yX0ZONjQoMTMpDQo+IEBAIC02OCw2ICs3MCw4IEBA
DQo+IA0KPiAjZGVmaW5lIFBTQ0lfMV8xX0ZONjRfU1lTVEVNX1JFU0VUMiBQU0NJXzBfMl9GTjY0
KDE4KQ0KPiAjZGVmaW5lIFBTQ0lfMV8xX0ZONjRfTUVNX1BST1RFQ1RfQ0hFQ0tfUkFOR0UgUFND
SV8wXzJfRk42NCgyMCkNCj4gKyNkZWZpbmUgUFNDSV8xXzNfRk42NF9TWVNURU1fT0ZGMiBQU0NJ
XzBfMl9GTjY0KDIxKQ0KPiArI2RlZmluZSBQU0NJXzFfM19GTjY0X0NMRUFOX0lOVl9NRU1SRUdJ
T04gUFNDSV8wXzJfRk42NCgyMikNCj4gDQo+IC8qIFBTQ0kgdjAuMiBwb3dlciBzdGF0ZSBlbmNv
ZGluZyBmb3IgQ1BVX1NVU1BFTkQgZnVuY3Rpb24gKi8NCj4gI2RlZmluZSBQU0NJXzBfMl9QT1dF
Ul9TVEFURV9JRF9NQVNLIDB4ZmZmZg0KPiBAQCAtMTAwLDYgKzEwNCwxOSBAQA0KPiAjZGVmaW5l
IFBTQ0lfMV8xX1JFU0VUX1RZUEVfU1lTVEVNX1dBUk1fUkVTRVQgMA0KPiAjZGVmaW5lIFBTQ0lf
MV8xX1JFU0VUX1RZUEVfVkVORE9SX1NUQVJUIDB4ODAwMDAwMDBVDQo+IA0KPiArLyogUFNDSSB2
MS4zIGhpYmVybmF0ZSB0eXBlIGZvciBTWVNURU1fT0ZGMiAqLw0KPiArI2RlZmluZSBQU0NJXzFf
M19ISUJFUk5BVEVfVFlQRV9PRkYgMA0KDQpTaG91bGQgaXQgYmUgMSBhcyBoaWJlcm5hdGUgdHlw
ZT8NCg0KPiArDQo+ICsvKiBQU0NJIHYxLjMgZmxhZ3MgZm9yIENMRUFOX0lOVl9NRU1SRUdJT04g
Ki8NCj4gKyNkZWZpbmUgUFNDSV8xXzNfQ0xFQU5fSU5WX01FTVJFR0lPTl9GTEFHX0RSWV9SVU4g
QklUKDApDQo+ICsNCj4gKy8qIFBTQ0kgdjEuMyBhdHRyaWJ1dGVzIGZvciBDTEVBTl9JTlZfTUVN
UkVHSU9OX0FUVFJJQlVURVMgKi8NCj4gKyNkZWZpbmUgUFNDSV8xXzNfQ0xFQU5fSU5WX01FTVJF
R0lPTl9BVFRSX09QX1RZUEUgMA0KPiArI2RlZmluZSBQU0NJXzFfM19DTEVBTl9JTlZfTUVNUkVH
SU9OX0FUVFJfQ1BVX1JEVlogMQ0KPiArI2RlZmluZSBQU0NJXzFfM19DTEVBTl9JTlZfTUVNUkVH
SU9OX0FUVFJfTEFURU5DWSAyDQo+ICsjZGVmaW5lIFBTQ0lfMV8zX0NMRUFOX0lOVl9NRU1SRUdJ
T05fQVRUUl9SQVRFX0xJTUlUIDMNCj4gKyNkZWZpbmUgUFNDSV8xXzNfQ0xFQU5fSU5WX01FTVJF
R0lPTl9BVFRSX1RJTUVPVVQgNA0KPiArDQo+IC8qIFBTQ0kgdmVyc2lvbiBkZWNvZGluZyAoaW5k
ZXBlbmRlbnQgb2YgUFNDSSB2ZXJzaW9uKSAqLw0KPiAjZGVmaW5lIFBTQ0lfVkVSU0lPTl9NQUpP
Ul9TSElGVCAxNg0KPiAjZGVmaW5lIFBTQ0lfVkVSU0lPTl9NSU5PUl9NQVNLIFwNCj4gQEAgLTEz
Myw1ICsxNTAsOCBAQA0KPiAjZGVmaW5lIFBTQ0lfUkVUX05PVF9QUkVTRU5UIC03DQo+ICNkZWZp
bmUgUFNDSV9SRVRfRElTQUJMRUQgLTgNCj4gI2RlZmluZSBQU0NJX1JFVF9JTlZBTElEX0FERFJF
U1MgLTkNCj4gKyNkZWZpbmUgUFNDSV9SRVRfVElNRU9VVCAtMTANCj4gKyNkZWZpbmUgUFNDSV9S
RVRfUkFURV9MSU1JVEVEIC0xMQ0KPiArI2RlZmluZSBQU0NJX1JFVF9CVVNZIC0xMg0KPiANCg0K
VGhhbmtzDQpNaWd1ZWwNCg0KPiAjZW5kaWYgLyogX1VBUElfTElOVVhfUFNDSV9IICovDQo+IC0t
IA0KPiAyLjQ0LjANCj4gDQo+IA0KDQo=

