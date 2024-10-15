Return-Path: <linux-kselftest+bounces-19748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BCB99F240
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8F22820C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DF31DD0D8;
	Tue, 15 Oct 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="dH7vEGub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE621F6676;
	Tue, 15 Oct 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008115; cv=fail; b=Z+d3yBZyHr8++pfH2zSoUi4Bojxr9bSImxk8EAOFg/WbIqsB0BP+lwAgBLwLv3jZWRG0MM721AmH749sm/URe5CBEdPbQoczo6aFp2LQS7hxazNq8iu3fV1Vk2Ixf88Hf4jNvJQ+f+CGWsRxCVsc8P7SzqjbD4ks4opNrqyLdT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008115; c=relaxed/simple;
	bh=BM1kVyX7w+GsY7WPfrYCWVDGZJpRXfn7JBy8vAfKCsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iD7J3F9HlX66vlxirTQXBtT3ABlwRSYyOXY8Pqqv54jb7CedGyOuy6eAZpwZA3VtVWNLU97j4NtptBl/+hIWPqtCHFoxQYgKwHSr9hrT95l61g48PovuPbDpWZQf0wqCjkzQdCYbCE4vFsZ5xQiUcLdhYx8S5Fg16Aq0ypvKcXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=dH7vEGub; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCe5fi031339;
	Tue, 15 Oct 2024 16:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=BM1kVyX
	7w+GsY7WPfrYCWVDGZJpRXfn7JBy8vAfKCsQ=; b=dH7vEGub9eUrp5/ZIsBWv2c
	46kNfYepqqy75fd2uw2KaC0kiebF+J24BCp3hx5e2bFM39KskfRacNyQ65uJMsJr
	KJul8p7ApsECnfwyhUsswyogxYYyCXl1viHL4UXOAlmuicT4N823sXF6njPy20AP
	SZIsNYwhUX6DAf/fwpG+Da+FGRpKr39vo6C3Q4adNdl63Q8MDemozdzDEBXwLpyW
	RsWpPH6MRUdEZFBc3iN/KVHhVbgXjX+XdENNi6HdcZdgYerMjlgQqhtcrK049GLp
	SRcSFG43Ufx2jng+nBqnMrMCYoXW5YyVeLyphIRfzhyBlkn5zUMFdJzbLq0FTYw=
	=
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 427fp4ak43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 16:01:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcoJoMHKNdHK4ksxNz5SNqPY4kfDzfCFHyfYz1P6xZR6KrdHYas+pYEdPv9jzkqBxuiC15vclc5/ng8uCrVDNRsknST38Ow+fPDwincgGsFm42npjROlbgCrq87iHoq2UGZOTPnkIY9QktYhRTqSOy9vkzD+xGAw1V/OCb5jjV2mU/DC15mAEtmarLOrYDDKw0R3yMFufOBKnQfFnPrEQAkAsCqCfghKKzXN2lVwbnzDo210VM4GxhudRMELy1j7VsdJt+9uRRryPOq7347YJV54SH96xurnuzoyWk+xfjOUYXldYVZjM46QiyY4HKhWMC5zhLVzJ6cyXxfmSYVGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM1kVyX7w+GsY7WPfrYCWVDGZJpRXfn7JBy8vAfKCsQ=;
 b=rnCFpQ1ZzyyDxIN4IQCGHm+n6ajybWO0csNkQ4gN3slRIqwYXrVjl+nzC6bBo2NZUth6iULaSEjawllKgSpTQHk4rSNmOe69KyFRsReUqZVwnnuurry+OODBHHAafcpo/ca2jwWe7fsXXotEyUgagA5AsXya49XGey54asKGdkziSm51oJT05TQ8cftMziRIOfgcXylDXgXFopfh4NbCJAsFl51QXiOggkRhRK2+PUAk39Z4yTE2NXom9lTwckpvo8+kGod4O9EjOQE98tZbyxBYSRTzFng/juQDYDK/qO5Uekdoat6CkKNfEB+Jno9t9glvaokX7y1uVpK5YLE8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by CO6PR13MB5290.namprd13.prod.outlook.com (2603:10b6:303:145::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Tue, 15 Oct
 2024 16:01:26 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 16:01:26 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Don Zickus <dzickus@redhat.com>,
        "workflows@vger.kernel.org"
	<workflows@vger.kernel.org>,
        "automated-testing@lists.yoctoproject.org"
	<automated-testing@lists.yoctoproject.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        kernelci <kernelci@lists.linux.dev>
CC: Nikolai Kondrashov <nkondras@redhat.com>,
        Gustavo Padovan
	<gustavo.padovan@collabora.com>,
        kernelci-members
	<kernelci-members@groups.io>,
        "laura.nao@collabora.com"
	<laura.nao@collabora.com>
Subject: RE: [Automated-testing] [RFC] Test catalog template
Thread-Topic: [Automated-testing] [RFC] Test catalog template
Thread-Index: AQHbHnhF/GfpVw2ux0qqqtDBG5fmGLKH9/Tg
Date: Tue, 15 Oct 2024 16:01:26 +0000
Message-ID:
 <MW5PR13MB5632C443F9D7E658168BC77DFD452@MW5PR13MB5632.namprd13.prod.outlook.com>
References:
 <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
In-Reply-To:
 <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|CO6PR13MB5290:EE_
x-ms-office365-filtering-correlation-id: 151f3224-5ce0-4d3f-1f3e-08dced329f90
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1lhNVhXRHRLYkd5MWE2MUJjbXJHREVxU3M5eGNvU1prMnJoWUs1bEc2WlB4?=
 =?utf-8?B?OHFXZ2lNSGRPVUpINFlaVk53d0E1MDVyRElBRmpOZE5LRTNvU2hNZTVSd1pv?=
 =?utf-8?B?cWxiSTJPTCsxa2U0dXV1V2lGZ1pydml2d3lUZnp5eTZrNDBFUEljWHVWT1BV?=
 =?utf-8?B?bnJwam83THgzUG5xWFo2Uk1OMUpwdEJBcmVQZ05nN1M3UkJvY1FGbHZ0Q05Q?=
 =?utf-8?B?VmNreFdYT1pLYXZoWGFhK1dvZG5zbWFBaUVyYjdwbU1Bd01IQ0w2Mk82VElZ?=
 =?utf-8?B?QXA4aEQwYVpTMGpaMlA4Y2xBMHgvUmdUaXhEeUpWdFJIMzR6NmxYdVM3Y0ZU?=
 =?utf-8?B?djJoSEsvU1R0Ynk1OVZ5c0RyblN4Z2I3bWxqM0tNNG8xOXAvOTJ1alNsRGl4?=
 =?utf-8?B?UHVvUDhxYUFaTmR6T3Y0Mmh4K29TRjNmOHJTTkNKRE1vTGR5SWk0TkJQaExM?=
 =?utf-8?B?RXBzbGsvUkhlK3V5bER5NEROOGtIangyQWR1UjVoQ2ZVVmlKN3gxZXFLdEZy?=
 =?utf-8?B?WDh5eEZsMExMdWxZU1dxemNuS2I2eUo3TUZNOCtYZXlUUTA1ZCs3R0U1MWhS?=
 =?utf-8?B?cUlyT2RRS0ZRT2tjUnUvUDh5dnlJL0hVL3Zud2pia2JFR0ZoRWZaTXA0SWt2?=
 =?utf-8?B?YS9DOEhjVU9uWDFLS3FNVDlqZTVNRmsvMmxMZXdTVGNVWmVmdmp2RytRRCtV?=
 =?utf-8?B?SC9RanZJMVd1L3V0dldPc3ZxQTFRTXlreTNUY1RVV3VNSGJncW5Sa2NJN2w3?=
 =?utf-8?B?NGVGWGlzV1RvOG16eDNqYkN1cWtsK2tSSENOZW1wTTJIZFZ2dUFmMTZNODJS?=
 =?utf-8?B?YWlWL3pKeVdkanFTNjJBWVZXODQzWFhrZUNSMWF3YW1lY1BKNDllTGFsNnNP?=
 =?utf-8?B?V0E1M3BadnlaSlVzZ1pZNkZpbGFZSVhDeE5hVmQ5aHlYYzJUc1VKUU9sMzU1?=
 =?utf-8?B?Q3dyZlhUYUxwM1RyQnRqT2ZHRmRXUU1vZXQvbnBwSHUwTDg2d0ZCUGdLQVFi?=
 =?utf-8?B?WTJLdWRES2J5WHFVbUcyeGVacWNxK3ZWZ3hOdjFGRStsNVBhK2laKzVLSHJq?=
 =?utf-8?B?ZEVJcnFNTmViU0ZFTy93eTUzYmFZakdPcXY2MTlqeDhBVDRGRUFaYU1VUksy?=
 =?utf-8?B?S1lOYlRoZnpyTE9FL0pqMUR0TWhFV2pPZEF3dmtVMXlWMG9xV1E1SDJ6cFRI?=
 =?utf-8?B?QXpPL1Y0cmJaeW1KOHRYbWRYS3JXN1JHWEZBMHFFNHBiQWloeERIK2VCSEdx?=
 =?utf-8?B?M1NaWEx6Qm1wYm9KaWVSaXNsMWN5cGw4Rk1HL3pMYWFXZ2RJVEwwaVlOc01S?=
 =?utf-8?B?MVVFZklEUzBQUk55T29pbStMQkJvRjZ3aW9oWXByWndxWHkrVTZ4clJWMDM5?=
 =?utf-8?B?R2VMR3JmeHJROEZpdG9YU2xBUHlqL042ZllYOWx4NWg0WW5kT2NQeDUwVmo1?=
 =?utf-8?B?aUk0UTZFM3NMVGRHWTZ3VUJpd0JaYkI2Q2xCSyt4SExoUmtKR245Ry84Uyt1?=
 =?utf-8?B?WnN4OTg4RHV6RWcvK0dKNXBVRVp2N0J2STFRb3NOQlpYQkdRZ282K1lGQjZz?=
 =?utf-8?B?UWJ1Z2ZlZXJkSlhTUjU0L2lKaFhCQWZvaUZWR3F2U01RTlhMckY4REdwSTI3?=
 =?utf-8?B?UzlhMmVJZzJOTFZVcFNlV1pnMXVaOFVZTTRranZXR1Ywd2J2UHBHV3pDeFF2?=
 =?utf-8?B?NHBlUlJMc0dXR29LUUV3WFJyZDJ2TmpBK0FIYXNBSWZKSzZHUi8xemhLWjh3?=
 =?utf-8?B?bTFSNUpoQ2NQTlZjRjVmWXV3Qm1MNzdaWmlNeWlKZUR2NkFXMHkyUEtyeHdi?=
 =?utf-8?B?MDFKVE1Qek0wTTJNTlMyUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzVncERaRm9NVXk5UU1tRVBpWCtBMHBwVmlDbC84V0w2Y3p1L0ErNk1Bd1Jh?=
 =?utf-8?B?WGNMK3Y3YkpZMlZjM3dkRFgzOGRtV25YKy9LVGdiY0oybHRuaWJBbVZtVFp0?=
 =?utf-8?B?UDJaY1A0bllXdjVVOEVJc2lNcjhxRGh3d1U3RkNHblZGaVVRMG1yeTkxV3Q3?=
 =?utf-8?B?WXk4MmRZWWlrOHRwMFJKUEtnWU5YazZLWC96bWJEM3BvTkhLQ0JmVUVEcllu?=
 =?utf-8?B?dWhQRmhJZXRNK0NkQ2RxaHA1ZXFEdDZUTjMySXFoZmtjOTZ3b1JOR1dta0Uz?=
 =?utf-8?B?c1V4dUlYcitvcHA3N2gyRm9iakdhV2hMbmp3NVBhd2VGeGFZTFdINEdXNHN6?=
 =?utf-8?B?Y0VWeWdJWVdnenNMSzhNckFjek85R2lJcGhvbnBRaU15SWJEckZFL2M5OUQ4?=
 =?utf-8?B?VlFIWngwcld2Y2ZmS09acENhKy81WGZBSXpEelh2UEhCdEpvVU5Na2ZSeEF2?=
 =?utf-8?B?RHZ1dXVQUXZPMitWTlo4OW4xMklYTGF0VktEd1BzVTl4bFlBdlNnZkU4TEJX?=
 =?utf-8?B?a29jY20vTGo0bWMrVmVSMWFTOUFnVDlxeVdTS2wvZ2NnOWYzamJzL2s0M2wz?=
 =?utf-8?B?dU1RSkVVQmI3ZnVVV3V5b3h4MmFLMTZUeWRlQ1hVYXFrMGwvTzVjVncwMTFZ?=
 =?utf-8?B?aXdyQ2RaTTh0REx3SnFZUnlkRUlJcm5DY3lhcG5pR2g2T3E2cTgwamR4dGtS?=
 =?utf-8?B?OVNIbkp4R2F2T0FXTlByNGxUR3B6Y08rWnNSTWowUHF0TmIvcE9mTmpNNFc2?=
 =?utf-8?B?bXR0Qyt2U0NDUFBlVGxLenpEelAvSmdld28xK1Vta0ZDSXRrckJKclZBeENm?=
 =?utf-8?B?aHBmaTNmMnI2d2xUUHQxamFBcS9VRE11QXAyZ0JQd0tYcytMb2FnT1BNc1JH?=
 =?utf-8?B?MXF4dkFZNWdVZG1WZmd4L0hRYmgyc0tucVByZG83bFNrSFhKbWxsRWsvVkk2?=
 =?utf-8?B?amlESjJiMGJ5Tk5RRERkNm1PR1BZMkhWdVRxS1FwWlNvN0xhOFJWcTVGUlRm?=
 =?utf-8?B?OXVnMnkra3JXUUM1YWZmTjdBMElWQ05XTFNkbnpac01ybGVXeitMQkZibk1J?=
 =?utf-8?B?Wk5DY2NsTmJKQnlCV0t4MXBSbnVmRkxPWXJWczdpTmtEc2cyZDk0aVdZMjlG?=
 =?utf-8?B?aVdKMjBIb2pWb2FUUFVuTTBQcElSR0FyL1FEOEw1SGJ0WnlIRzNiSElnOElh?=
 =?utf-8?B?ak9xQ3dDSStVWkRJc2ZZSlJnUTVsUW5peHE3WHZKeUoreGk5MzVsODdCbU5l?=
 =?utf-8?B?ZU1rOEpILzA1di9RQlRrcXRVbnBrbW9jVks2OGx6UFRrMi9YbDZLdVFKT3hW?=
 =?utf-8?B?WCtOMjJNeHc3YTlkeFpKRk9zTEhlcWVFNkNuR2tqRW55VGtoSi9FcWx3S2tn?=
 =?utf-8?B?SnMxWTdRbG9rRjFaNDFlM3hYZm94OWlNZER0eHhLZnZiMlNHdHFMckg3b3B4?=
 =?utf-8?B?TEN6WlN0UlVhbWx6QnV0UHNGYzdUSU5RUnNkWkc2c1ZtTnZwdG94K2JmUUR4?=
 =?utf-8?B?YmgxVXdCME5CQXBoT1c5MGZuSmljbW5jUE5PK012aVZvT0V5UGpXYTdSamtS?=
 =?utf-8?B?OHBadjV4RStROXdrYXRnbExldmlsb2tjUUJCT1R5bTdiSlFoTHdiRFhpcFdR?=
 =?utf-8?B?aFNRRzVxVmhJaWhPUjlyK3FiR3o4TC9MVjdJVFlucmZDMGw4U1l6TTRaYkIv?=
 =?utf-8?B?dEg1V0RhUFh6N0R1cTI1YzhOQ05icGQzWXkzN0o0NDBnKzhJclZTY2NqRUFl?=
 =?utf-8?B?cDY2Z1dMTG1keEdmeEVJdEZGeVE5OHFRNFF3YWlzdXVSMENlTlFpK0J3SlBW?=
 =?utf-8?B?cXFxUlcrUE1ZL1NaR2RZaWoyZHV6bkRFUE1tOHgyZWtBTnAyTXRFZXNMbzNC?=
 =?utf-8?B?YVk0U05sV0tkTkJzMUtFUkpTMjBrT2ZSaXVtaVl0Zks1OUt2VmMwZkpVWGha?=
 =?utf-8?B?WExYS3I1YWRZUi9RMm5zR0cyc3REVWlYTDRhWDN2VTRmcUVRb0ZyMTZoY1hr?=
 =?utf-8?B?dHljczBEbFl4RTcrVU5VZ3ZndmNDWjRMek5TMXpZMXBGSmY3OFEzeENoNDYz?=
 =?utf-8?B?eGxtTHRqbnhVNm1RMEY1YkZwYmZsdXlRV0oxVEc1aFplMGI3d0RVamZOTURx?=
 =?utf-8?Q?U/3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DfWx/swqU23wkxBPMnA1vltwdseeF0y+qQ7s2G4ij+bRIne8rRnHuZickID+hT4zL9lAfgQQbg33QRugzOEVmEFp+OqcBhVbUn/Xt4UKRuInsiGk3zgBGS2HP40c8m4nBuqNGRIeX9vUV0KU9ls9nrPlu1EdsoX74tIVe+JNqP4md/2Dv3P7nDjqJrD7cxtiq0mB6jjTS9q+qAhuObNJpkT+LgaQfKh5M2tqoImFZi+zIwTHdeOr7B3aI/lTwcltt9M06zXp55XU2qJU4w/hJqw9exFppojvuTe9QN2lGzxcvQBUgBZsEnGk/+WYcJz82t3HzOsAvLshhPgZp4IpN8kpHHa5Pyb/+qhrgHsC6nC5n+xRKjr4ckgFVZOOp8NNmUI7i45nAh8C0By9FaGSdcRvpBjKk7PpT6BRCwu0M9n3lY5uh0WzTDGw9BkIAhQewFbLngDH8mPh2ap+oYkuFY2fD+xwRMdqTGVxk/M8Lyw7R2v7xMCz6v0W6jwvAK/kclJLkrOsRdeOL5GjEzEldVvdC+KtFeu0IIBhVZ03zbRxwrkI+pUf7pVHL3uo68/JPl8x6MdTkI8z/jHkhqWOG3J+3HZsp0UrVwXKnO2SKgsJLd0kTsjj7chR3hNX98D7
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151f3224-5ce0-4d3f-1f3e-08dced329f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 16:01:26.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMtBUY7rlqoROYbtSt6fsW3d6J2FCRGbg+FwOOrOWw8eubkrFX6fdOk/gTyTy3gmzVBR5flhLyO1RdBGloeK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5290
X-Proofpoint-GUID: azxmSsrSX1uBc5zqlXLKT8VYB6pTsT6e
X-Proofpoint-ORIG-GUID: azxmSsrSX1uBc5zqlXLKT8VYB6pTsT6e
X-Sony-Outbound-GUID: azxmSsrSX1uBc5zqlXLKT8VYB6pTsT6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_11,2024-10-15_01,2024-09-30_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhdXRvbWF0ZWQtdGVzdGluZ0Bs
aXN0cy55b2N0b3Byb2plY3Qub3JnIDxhdXRvbWF0ZWQtdGVzdGluZ0BsaXN0cy55b2N0b3Byb2pl
Y3Qub3JnPiBPbiBCZWhhbGYgT2YgRG9uIFppY2t1cw0KPiBIaSwNCj4gDQo+IEF0IExpbnV4IFBs
dW1iZXJzLCBhIGZldyBkb3plbiBvZiB1cyBnYXRoZXJlZCB0b2dldGhlciB0byBkaXNjdXNzIGhv
dw0KPiB0byBleHBvc2Ugd2hhdCB0ZXN0cyBzdWJzeXN0ZW0gbWFpbnRhaW5lcnMgd291bGQgbGlr
ZSB0byBydW4gZm9yIGV2ZXJ5DQo+IHBhdGNoIHN1Ym1pdHRlZCBvciB3aGVuIENJIHJ1bnMgdGVz
dHMuICBXZSBhZ3JlZWQgb24gYSBtb2NrIHVwIG9mIGENCj4geWFtbCB0ZW1wbGF0ZSB0byBzdGFy
dCBnYXRoZXJpbmcgaW5mby4gIFRoZSB5YW1sIGZpbGUgY291bGQgYmUNCj4gdGVtcG9yYXJpbHkg
c3RvcmVkIG9uIGtlcm5lbGNpLm9yZyB1bnRpbCBhIG1vcmUgcGVybWFuZW50IGhvbWUgY291bGQN
Cj4gYmUgZm91bmQuICBBdHRhY2hlZCBpcyBhIHRlbXBsYXRlIHRvIHN0YXJ0IHRoZSBjb252ZXJz
YXRpb24uDQo+DQpEb24sDQoNCkknbSBpbnRlcmVzdGVkIGluIHRoaXMgaW5pdGlhdGl2ZS4gIElz
IGRpc2N1c3Npb24gZ29pbmcgdG8gYmUgb24gYSBrZXJuZWwgbWFpbGluZw0KbGlzdCwgb3Igb24g
dGhpcyBlLW1haWwsIG9yIHNvbWV3aGVyZSBlbHNlPw0KDQpTZWUgYSBmZXcgY29tbWVudHMgYmVs
b3cuDQogDQo+IExvbmdlciBzdG9yeS4NCj4gDQo+IFRoZSBjdXJyZW50IHByb2JsZW0gaXMgQ0kg
c3lzdGVtcyBhcmUgbm90IHVuYW5pbW91cyBhYm91dCB3aGF0IHRlc3RzDQo+IHRoZXkgcnVuIG9u
IHN1Ym1pdHRlZCBwYXRjaGVzIG9yIGdpdCBicmFuY2hlcy4gIFRoaXMgbWFrZXMgaXQNCj4gZGlm
ZmljdWx0IHRvIGZpZ3VyZSBvdXQgd2h5IGEgdGVzdCBmYWlsZWQgb3IgaG93IHRvIHJlcHJvZHVj
ZS4NCj4gRnVydGhlciwgaXQgaXNuJ3QgYWx3YXlzIGNsZWFyIHdoYXQgdGVzdHMgYSBub3JtYWwg
Y29udHJpYnV0b3Igc2hvdWxkDQo+IHJ1biBiZWZvcmUgcG9zdGluZyBwYXRjaGVzLg0KPiANCj4g
SXQgaGFzIGJlZW4gbG9uZyBjb21tdW5pY2F0ZWQgdGhhdCB0aGUgdGVzdHMgTFRQLCB4ZnN0ZXN0
IGFuZC9vcg0KPiBrc2VsZnRlc3RzIHNob3VsZCBiZSB0aGUgdGVzdHMgIHRvIHJ1bi4gDQpKdXN0
IHNheWluZyAiTFRQIiBpcyBub3QgZ3JhbnVsYXIgZW5vdWdoLiAgTFRQIGhhcyBodW5kcmVkcyBv
ZiBpbmRpdmlkdWFsDQp0ZXN0IHByb2dyYW1zLCBhbmQgaXQgd291bGQgYmUgdXNlZnVsIHRvIHNw
ZWNpZnkgdGhlIGluZGl2aWR1YWwgdGVzdHMNCmZyb20gTFRQIHRoYXQgc2hvdWxkIGJlIHJ1biBw
ZXIgc3ViLXN5c3RlbS4NCg0KSSB3YXMgcGFydGljdWxhcmx5IGludHJpZ3VlZCBieSB0aGUgcHJl
c2VudGF0aW9uIGF0IFBsdW1iZXJzIGFib3V0DQp0ZXN0IGNvdmVyYWdlLiAgSXQgd291bGQgYmUg
bmljZSB0byBoYXZlIGRhdGEgKG9yIGVhc2lseSByZXBsaWNhYmxlDQptZXRob2RzKSBmb3IgZGV0
ZXJtaW5pbmcgdGhlIGNvZGUgY292ZXJhZ2Ugb2YgYSB0ZXN0IG9yIHNldCBvZg0KdGVzdHMsIHRv
IGluZGljYXRlIHdoYXQgcGFydHMgb2YgdGhlIGtlcm5lbCBhcmUgYmVpbmcgbWlzc2VkDQphbmQg
aGVscCBkcml2ZSBuZXcgdGVzdCBkZXZlbG9wbWVudC4NCg0KPiBIb3dldmVyLCBub3QgYWxsIG1h
aW50YWluZXJzDQo+IHVzZSB0aG9zZSB0ZXN0cyBmb3IgdGhlaXIgc3Vic3lzdGVtcy4gIEkgYW0g
aG9waW5nIHRvIGVpdGhlciBjYXB0dXJlDQo+IHRob3NlIHRlc3RzIG9yIGZpbmQgd2F5cyB0byBj
b252aW5jZSB0aGVtIHRvIGFkZCB0aGVpciB0ZXN0cyB0byB0aGUNCj4gcHJlZmVycmVkIGxvY2F0
aW9ucy4NCj4gDQo+IFRoZSBnb2FsIGlzIGZvciBhIGdpdmVuIHN1YnN5c3RlbSAoZGVmaW5lZCBp
biBNQUlOVEFJTkVSUyksIGRlZmluZSBhDQo+IHNldCBvZiB0ZXN0cyB0aGF0IHNob3VsZCBiZSBy
dW4gZm9yIGFueSBjb250cmlidXRpb25zIHRvIHRoYXQNCj4gc3Vic3lzdGVtLiAgVGhlIGhvcGUg
aXMgdGhlIGNvbGxlY3RpdmUgQ0kgcmVzdWx0cyBjYW4gYmUgdHJpYWdlZA0KPiBjb2xsZWN0aXZl
bHkgKGJlY2F1c2UgdGhleSBhcmUgcmVsYXRlZCkgYW5kIGV2ZW4gaGF2ZSB0aGUgbnVtZXJvdXMN
Cj4gZmxha2VzIHdhaXZlZCBjb2xsZWN0aXZlbHkgIChzYW1lIHJlYXNvbikgaW1wcm92aW5nIHRo
ZSBhYmlsaXR5IHRvDQo+IGZpbmQgYW5kIGRlYnVnIG5ldyB0ZXN0IGZhaWx1cmVzLiAgQmVjYXVz
ZSB0aGUgdGVzdHMgYW5kIHByb2Nlc3MgYXJlDQo+IGtub3duLCBoYXZpbmcgYSBodW1hbiBoZWxw
IGRlYnVnIGFueSBmYWlsdXJlcyBiZWNvbWVzIGVhc2llci4NCj4gDQo+IFRoZSBwbGFuIGlzIHRv
IHB1dCB0b2dldGhlciBhIG1pbmltYWwgeWFtbCB0ZW1wbGF0ZSB0aGF0IGdldHMgdXMgZ29pbmcN
Cj4gKGV2ZW4gaWYgaXQgaXMgbm90IG9wdGltaXplZCB5ZXQpIGFuZCBhaW0gZm9yIGFib3V0IGEg
ZG96ZW4gb3Igc28NCj4gc3Vic3lzdGVtcy4gIEF0IHRoYXQgcG9pbnQgd2Ugc2hvdWxkIGhhdmUg
ZW5vdWdoIGZlZWRiYWNrIHRvIHByb21vdGUNCj4gdGhpcyBtb3JlIHNlcmlvdXNseSBhbmQgdGFs
ayBvcHRpbWl6YXRpb25zLg0KDQpTb3VuZHMgbGlrZSBhIGdvb2QgcGxhY2UgdG8gc3RhcnQuICBE
byB3ZSBoYXZlIHNvbWUgY2FuZGlkYXRlIHN1Yi1zeXN0ZW1zDQppbiBtaW5kPyAgSGFzIGFueW9u
ZSB2b2x1bnRlZXJlZCB0byBsZWFkIHRoZSB3YXk/DQoNCj4gDQo+IEZlZWRiYWNrIGVuY291cmFn
ZWQuDQo+IA0KPiBDaGVlcnMsDQo+IERvbg0KPiANCj4gLS0tDQo+ICMgTGlzdCBvZiB0ZXN0cyBi
eSBzdWJzeXN0ZW0NCj4gIw0KPiAjIFRlc3RzIHNob3VsZCBhZGhlcmUgdG8gS1RBUCBkZWZpbml0
aW9ucyBmb3IgcmVzdWx0cw0KPiAjDQo+ICMgRGVzY3JpcHRpb24gb2Ygc2VjdGlvbiBlbnRyaWVz
DQo+ICMNCj4gIyAgbWFpbnRhaW5lcjogICAgdGVzdCBtYWludGFpbmVyIC0gbmFtZSA8ZW1haWw+
DQo+ICMgIGxpc3Q6ICAgICAgICAgICAgICAgIG1haWxpbmcgbGlzdCBmb3IgZGlzY3Vzc2lvbg0K
PiAjICB2ZXJzaW9uOiAgICAgICAgIHN0YWJsZSB2ZXJzaW9uIG9mIHRoZSB0ZXN0DQo+ICMgIGRl
cGVuZGVuY3k6IG5lY2Vzc2FyeSBkaXN0cm8gcGFja2FnZSBmb3IgdGVzdGluZw0KPiAjICB0ZXN0
Og0KPiAjICAgIHBhdGg6ICAgICAgICAgICAgaW50ZXJuYWwgZ2l0IHBhdGggb3IgdXJsIHRvIGZl
dGNoIGZyb20NCj4gIyAgICBjbWQ6ICAgICAgICAgICAgY29tbWFuZCB0byBydW47IGFiaWxpdHkg
dG8gcnVuIGxvY2FsbHkNCj4gIyAgICBwYXJhbTogICAgICAgICBhZGRpdGlvbmFsIHBhcmFtIG5l
Y2Vzc2FyeSB0byBydW4gdGVzdA0KPiAjICBoYXJkd2FyZTogICAgICBoYXJkd2FyZSBuZWNlc3Nh
cnkgZm9yIHZhbGlkYXRpb24NCg0KSXMgdGhpcyBzb21ldGhpbmcgbmV3IGluIE1BSU5UQUlORVJT
LCBvciBpcyBpdCBhIHNlcGFyYXRlIGZpbGU/DQoNCj4gIw0KPiAjIFN1YnN5c3RlbXMgKGFscGhh
YmV0aWNhbCkNCj4gDQo+IEtVTklUIFRFU1Q6DQo+ICAgbWFpbnRhaW5lcjoNCj4gICAgIC0gbmFt
ZTogbmFtZTENCj4gICAgICAgZW1haWw6IGVtYWlsMQ0KPiAgICAgLSBuYW1lOiBuYW1lMg0KPiAg
ICAgICBlbWFpbDogZW1haWwyDQo+ICAgbGlzdDoNCj4gICB2ZXJzaW9uOg0KPiAgIGRlcGVuZGVu
Y3k6DQo+ICAgICAtIGRlcDENCj4gICAgIC0gZGVwMg0KPiAgIHRlc3Q6DQo+ICAgICAtIHBhdGg6
IHRvb2xzL3Rlc3Rpbmcva3VuaXQNCj4gICAgICAgY21kOg0KPiAgICAgICBwYXJhbToNCj4gICAg
IC0gcGF0aDoNCj4gICAgICAgY21kOg0KPiAgICAgICBwYXJhbToNCj4gICBoYXJkd2FyZTogbm9u
ZQ0KDQpMb29rcyBPSyBzbyBmYXIgLSBpdCdkIGJlIG5pY2UgdG8gaGF2ZSBhIGZldyBjb25jcmV0
ZSBleGFtcGxlcy4NCiAtLSBUaW0NCg0K

