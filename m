Return-Path: <linux-kselftest+bounces-13696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3763A93013A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 22:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB52284BB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 20:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD4638DE0;
	Fri, 12 Jul 2024 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NFM29xWR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xLnfuIkQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D429402;
	Fri, 12 Jul 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815389; cv=fail; b=EfqAtSd0sYB2PbCZm0rzmDckCvpnmt6CEBOf5tmSvRnbeLzpx4dbTxoo3MDGMIhLcs2+tAtDScJVP9nrGZRY95nPhKOaHGeJKB9rtOujWW8wBG+a3Owi4ks9GiPhBmw55XWvboiIrxDFxElQ1eM7aTphPPlRRtzK/BwdZYRh+50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815389; c=relaxed/simple;
	bh=apNTHrA61ScOOUlJUxwNP0Qb4SoaLBWWy5MaRI4QNHM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5xpY/UwlMKYVTHGsMtbHyXDow7KqDnvzCc9bJZ3Rd/NOq04XmLhXDln7U8SRmyzdj6I4S59RBRQdd41l+xGXwsALqyp+rgEMkomUxqMHf5RWOhIxMz9Plbl/6lToJ+v17EnE88fLcGTJPFK6ZbKN8DLj5TaOXTG60q8ttWvGdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NFM29xWR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xLnfuIkQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CJtZwI023783;
	Fri, 12 Jul 2024 20:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=apNTHrA61ScOOUlJUxwNP0Qb4SoaLBWWy5MaRI4QN
	HM=; b=NFM29xWR6YcqxrHR9CsaBfxUGKDIu4OsEwAG2Hy5BB7EQrgHmsepUQkLE
	w2BxqgvDybJ4oQt52/kBd0NQFZeDpK6mc5JXNNH5GFE0gBg63EWq6obpA4etHfBJ
	kdUrNHq5gD3mLWv5vgIIF321ZMUPRF/k+Zw5K3Xqia2Hlyb//kiCc0P1XZ/6HVpN
	taWTEYACeCY/jfZms2rLyIbZIZZVwlvxYCoq6qetJU1CG6ongYrvpGyb4GBFbsC2
	nhQQPEDpcjgMVpB3I/5FCST+fo2RceLgf/7yL8vufwVk05U5oM4YsRzwSgif5Zs1
	D3jLjMjiPo+ZsmLg/nalD97/wo86w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkycu30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 20:16:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CIPT7Z022018;
	Fri, 12 Jul 2024 20:16:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv47swd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 20:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BacLMpZykfTV5srXDNVvyhenQPMKHHUkFSferH1/btHjd1xc97jKKarn+3rULJY3uss+nER1d1TaZSUC5CK/n5Pq4hK4IBHSNwdevAMuhegJXreSdxuKfviykjbe/jMUNCMNHJDhzEHisd5onrJxxlA5cz5aY7cSqgtj4owKslbjVOxuPxjAK8miNRIkyZNcIO9t8+BAYV6GehilBg0ifcitRjVBm/ucmBmrOJT5daGoV73hVuAFvZgV0uuLMf8YyAsRREeG88t9Js8OMkrnsennU96PzQ+p5/p2L3t3qoDoZ6XARq9ZchupDsRdZLKKUb4rE4pNnw7H0cIwVxyj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apNTHrA61ScOOUlJUxwNP0Qb4SoaLBWWy5MaRI4QNHM=;
 b=p6dqGeuVmm/gbCUVd44T/8VTd/dB/+MFfk2Vc3I3m6/cGEemF6+f5zgyVntJz7gZl8FpW/TBr1pybKvkgyzfR5fl6WeQujXxNfMSwoNiBdrF6ovIphfeoypQZ81RcWIde9yF71iMg5iLsyFUhm3VPHGFLYwsdtivrUeKa8Sg7Ger6wrj/0ErWpyHJ6PygzxbEkU6Hz5lePr/FdnG+VrY2q03ex3B2ordcwPLwHqLcDvBpfHSQJidid/kr7fWJx2G1nxxup5GTS1sfdm1g/Cu1j9Kesm8wtK2Ci1LZAeVu12zEkLyY3QQrYCSuNgzMigCeoj03O0vCo7PsvLKql2p1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apNTHrA61ScOOUlJUxwNP0Qb4SoaLBWWy5MaRI4QNHM=;
 b=xLnfuIkQG7BaO2l+crvSPllCmLtTnoHzDfmW8EDoYRvW7wUar4Swj0dxzX7Gg4A+zUnIm5qnCNpzR1xrh90C6Q8OSTWNbr0dNP8i/QGIZbuPKuRS683SrRS4iZioEnECQXNUSzd1g7JlJ55qJo/E0L+DAySCmMF2uVtWaiIh2/Q=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by PH7PR10MB6532.namprd10.prod.outlook.com (2603:10b6:510:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 20:16:18 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 20:16:18 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: Chuck Lever III <chuck.lever@oracle.com>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>
Subject: Re: [PATCH net-next v1 3/3] selftests: rds: add testing
 infrastructure
Thread-Topic: [PATCH net-next v1 3/3] selftests: rds: add testing
 infrastructure
Thread-Index: AQHax2gyvzMniczkdEKeAdl6X7TVaLHcRcAAgBdcJAA=
Date: Fri, 12 Jul 2024 20:16:18 +0000
Message-ID: <4ace517a9e1cdd4dde0784b7911ec6c704582fa1.camel@oracle.com>
References: <20240626012834.5678-1-allison.henderson@oracle.com>
	 <20240626012834.5678-4-allison.henderson@oracle.com>
	 <20240627163232.1c2b5e49@kernel.org>
In-Reply-To: <20240627163232.1c2b5e49@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|PH7PR10MB6532:EE_
x-ms-office365-filtering-correlation-id: 83a229fd-3697-4b6d-80df-08dca2af7d6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?enJkMTNSajhuYXhXZWZoZnJHak5vTVk4UndTT25JWWRqcWg0aDVkUnhBdGhO?=
 =?utf-8?B?ZlNoWmZsZXZ1Yi92dmFENE1acGoyUi9qdHVJTXBKNkRkWVNUYXN0M3k0amxH?=
 =?utf-8?B?a2FqbFJhNGlLWU5FSncvL1N0c3FqUEp3cmE0bkMwaGxWQTFCOHc4SGxGVUV1?=
 =?utf-8?B?NGJJTFFBazFYYkpVb0FObjh3NlJoTmZTWkxFdjJmdkVCa09RRUNqMWlLWjZH?=
 =?utf-8?B?RjFKZUFWRmRiOXJ2K0ZtdURkQWQ2aUo3Y3ZXTVNBdFpPS3hRbmxJZkJGOVRC?=
 =?utf-8?B?U1NZL0FLOS9XTlRoSGdnbjZrSzRCbllsMzhOUXRCMUQrS3pQUnNVWE5GNGNn?=
 =?utf-8?B?R0xOUkptdEU2OG4rQkcySGVFcnVNRTAzTFpSaDJ5R1lUZ3lPc25IWWxkQ09S?=
 =?utf-8?B?UmNob2tPcFBjYy9oZVhsdHR2U251OVNaWlRrZ2J0VzlsRUFvenkrMmNUWjc3?=
 =?utf-8?B?U2laN0R5bkk2R3ppZWRYVFJoVGZXM2Nxd1E2cEZacm80eVVvUGlpUnpOR2k5?=
 =?utf-8?B?L1JWNSt6NGpCakF4c3F4eWFwR1EzRjJhWTdIamVZclFwa1dQY2FrdENabTc1?=
 =?utf-8?B?aGhReE1SUmZqeXFnU2ZzRjhyR1dyYkpPZ3ZJVVFnNjdjc0JFMUpva0pKb0Zl?=
 =?utf-8?B?S0tSL2dzSklCZEdNbXh2OGs2V3YyVHRQTG5qalpucXlmUUZyZ0RzdE9Melor?=
 =?utf-8?B?TFRxRW5IaGtpU0ZwMFhDTWRTOFVuS2dBUGk5VUNvV2M5dTRIRGt6dkdKYkRp?=
 =?utf-8?B?ekROb0pGNkNTUHRCajloNjJTUXl5OWM4VW1ESld0Vjh0Kyszd1ljWlRSRTJC?=
 =?utf-8?B?ei9NZHFqOWNmRjVKNVEwWUtiQk1qS1UwZnZOSDZKdDdLUlZlK3hTVHBVemFW?=
 =?utf-8?B?cS9oQ2UzdHJENDhQMXFWMHloaGVQeUdmc1FmaytoQ3hPM1lWdlROOUsyc0lh?=
 =?utf-8?B?WlhHZWdCNG02WnFjTDUwN2JnbitjTEk4VURHUGRXVkFycWlhUXo1ekdVUHRz?=
 =?utf-8?B?c0JGMnNqTnVzZzFxSENsa1Q5ZmJJR1pXcTRoQlNvdnpyem1MVmdGaUJPQmRl?=
 =?utf-8?B?MWg2c3hzZU9Gcm43SUI2T2lYTW84Nm5nR3E4YWtKeGlwNmZ1aUF3MzlQYTg3?=
 =?utf-8?B?dUllS1ZGam1UN1RHQ0hiSXhFYnk0ZnlTSGhTUzZlMzBRazJjOFkrcEFnUFN5?=
 =?utf-8?B?dzBFMGlMR2dPYXFDZEVuTGdtdWxNYll3RUwxdnZ1YnJBcVVHVVBKbTd4NkRQ?=
 =?utf-8?B?L1JlYlV5R2YyNjhleGhITWlQQXJxY0Y3M29ZamxHZVB6VjNqZDl1SlhpQlcv?=
 =?utf-8?B?Vyt5YU5iN2RVQTlIMkdVSWpnZVluMWkvSGRzWWVjMFlLVE1BZlZrWlZiZFA1?=
 =?utf-8?B?OTRlZlZBSllBL3ArZ1hoVXZVZVI2aXJ2b1hwUWg3eUV2eWdPWmVPOGVvNjhw?=
 =?utf-8?B?a2VvSVdlVjUzZUYxTE1GZUhsSy9tUDNZRVozUlZJN2crZWk5YXRKTVdycHpT?=
 =?utf-8?B?QmM0cTdnTUZFSGd0VUwwQ2pIbVZ1enMrM1pLb1J2NkxXYk5RUUhxL3R4Wk1n?=
 =?utf-8?B?amJUd1hyaUpoVjNLaXlJYlFZNXdLRlVxZm9LODVUN3A0ZW1oaGdkTlpMcE1Y?=
 =?utf-8?B?MG1VWDUrN2I3cnRtbXdsT3JSMHRTbFA3ZE5aUit3MEJzWHlmZUY2VHpndWtL?=
 =?utf-8?B?WmtpeDhFdy9FYmJsTlgwcVR4TVpVVWw5aWJqeXJwSC9sWXpQM2wrWmovR3Fv?=
 =?utf-8?B?U25kZHMxTkk4ODhVU1lJeXZwT0VoQVcwemthQURacTlwaE1mQ0pvM3JxeWoz?=
 =?utf-8?Q?fXPaYgxnwDmoq9G1ph46Y0M6tn8hAO03Bwyus=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Szg1Q3g4YTRDRStMOHkxNmhQb1NVS2RaVzdBSUJXTVlXQ21zR2hPMUczNDBu?=
 =?utf-8?B?bUY1NllpSk5tOW1nbEo1NC9GUXc2dGFRcVhza0tLSHB5cTFhMDlVcFBPWE9l?=
 =?utf-8?B?QzY3cmllSzVwOTh2d0JIRWVMNW5sYnk2MDQzY2t0SDYzUUNnYmRYWU9RZklL?=
 =?utf-8?B?SmpEQ0ZkNzkyc2NQMTk1OUdvbSs5VlYzdE1odkU3WXpsQjV0dUc5Q0VZeHdk?=
 =?utf-8?B?aW1hN0h3a0xZWDByY1loZ29mLzdCS2JEME9iTGpLNjE4SnZnTFVTeFN4WUE2?=
 =?utf-8?B?dGdHa1BhYmFxdWljL09QeEh0MVhPOUt1dDNFTEJCem5ML2Y3L2VLdmc4TzVI?=
 =?utf-8?B?V3dlYnlOcDREZjBnTHRpdndOSmpqT1ExWWJ5YllEM2laM0xFdkFjYkRzcHdL?=
 =?utf-8?B?aEU3OGxxK2QwYTBrMDJVRjNaaW85NG43aUFOZTgrMWxYWWdTZ2pvSGlJUW9G?=
 =?utf-8?B?bXdTbU8zNVcvNWJ3OGZueERKVEh0Y3FwSmZ6SCszcUlJVFpPblJJaURXTktJ?=
 =?utf-8?B?ckQ3cEhEbmVxL2dkbjRVV3VZNUowNGp4cjkwa295a0pUaDNob280RXArVytO?=
 =?utf-8?B?cGdFZmJRMXZXYXNnNmhBMFVrMXkreVlla3g5Qzc1V0pGM1BvNk44NW9vcllY?=
 =?utf-8?B?K245SXZ3dUdXR1RtUnRkQ3Jtcm5LNWNpMTIzTlVGbER6RkhxUkhvQlJQdnBT?=
 =?utf-8?B?Q3hpTnoxTkJHUnFNamRQOTRvV1BzVENCM0sxQlJiWURGQnJicXJIRGZITDFC?=
 =?utf-8?B?WG5NdE9MbTBQUlBEK1dkbHBON0JWV2c2VCtFWlBHY2JGS3hJM0pJUDI2bjdJ?=
 =?utf-8?B?Vmw3RGUyeElsU0JTV2twbE5kcjFoZG9JT3VPdU1LWHF5Mko5WWgwck0rMTQ3?=
 =?utf-8?B?UnlyT0FxTXU4OUVvMkVyQ093MzB1WjVCNDhrRzloTTFDWHU2aktKV09CWmVH?=
 =?utf-8?B?Wmo0bWhxSFo1NUc1T3Y2SU02S0JmbHp0TzJ4NFNGRXdodFBrNWNtRCszU2Fn?=
 =?utf-8?B?RlJxa2FNZEFrR2hZbmdBSk9hS3gzREdVNjhDQWRaNzl1cCsvUURadW1lVE1E?=
 =?utf-8?B?RVFPcENEaFZrTmV3alk0b0xHSEFRMVFkS0VXZTFDR2pOdlBwVnB1Qjcrckhk?=
 =?utf-8?B?bHRvTmJYN0FKVDF5b0dqd0x4bW45VndKMmpCdzBiN0F3Tk1maXQ3bGl0WTJG?=
 =?utf-8?B?V3dCWU5iR0wwRVZoOHB1aVVCdzVOcGxOYkRzVHJIQnJJSTB2VmJ2alZIQ3dK?=
 =?utf-8?B?c3ZEaWZsdDFVTit0WmtSUHVYV210VUgybmtxM1NablVCV0hSdDE5OU96eWJv?=
 =?utf-8?B?TlhEMHBCMzFyNWR2dFNkOTZIbEp4V0JNV00zY0tsZFpoMmU5dVZlQ0JqOTZn?=
 =?utf-8?B?VGpoRmlPOUNNTEMxdEhkZzkyZSttbURWMGxLempQNmtlaENmUlYxa0NIVU5m?=
 =?utf-8?B?UjNQVmdaMnArTkk0VFF6K1h0QVdzNml3ZFZ2TnA5dUhzOHl4cllBeGpFVlRr?=
 =?utf-8?B?cmVIcm8yU3JSUVdScVgrN1JMcThWL1A5MGpqdnI5eElNcUF0L010YUM2RTZl?=
 =?utf-8?B?dmVaYzBQSVpCZkRoaVZESDRZRXN4cXZzTmoxTUlneWNBdDJ4L3h0ZlY4dGQy?=
 =?utf-8?B?YmJhSE8rcEVRdkxpR092OUtFck1UL21pNkVaRWxsTi90RU5oelM4S3JlMmNE?=
 =?utf-8?B?OHR3SXI0WDdjVmdoaVlSS3pLK0Y5bXY5b1RLY1BvdEl4RDlneHZiUU1Cenoy?=
 =?utf-8?B?eEdQVVpjaWkvN1BHcjBSUVFDRkVEc3FHZWt4bEszV05uNUhFVGpnUUptQzZR?=
 =?utf-8?B?ejJienRxaUFSR3ZneGtqZDJnS2srSTA5MDhlc2RaV0RUNWlrMGRWaU9CTEd6?=
 =?utf-8?B?YmZqc0dnWXAvU3gvNHlUalV5UTF5NU1WWkpuRmtobmlmWFF3WkNNcHFuMVll?=
 =?utf-8?B?aFM5ZUQxZVVYdkNoc1BQU2VHM0EwTlpTQngyUWphdTlGWjh1RitLL1lrWDY3?=
 =?utf-8?B?eTBpQlp0RE5YQ0FFdFJya1BFd1U1bnZ6S2U4NEdyRnhZczlPQ09hU29vS2lt?=
 =?utf-8?B?L1RNWXhZNEI1ZXQzV3BGYXhLM0djbTd6L3VRdUVvcXZFNEZEMW0vcGRYMGJH?=
 =?utf-8?B?b2ZLeVRicW5WTGhDcXpkcE5mNHFwUHhWWnhvMnk4UE82TndhY2EyVysydGhr?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94B1D0CEC85DDB489E2F8692E186CC92@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zLZiknnxw2dLk+nujcd/6gepj3edLUlKv2mi4AbLLsHAXvUDMF9vn4j5w2QyWYRw3OpWxNqdJsKq5RE/ipzivg+um86C8wMuNRc4vnR/R1C4OGQQZbTmbZJAR+1LKcn4fyU5gl2+Clndfjw2IN2qGq06oxq0vW1TZd1Z3r26uKHqPk4tvGJZ8j2tVlOXs8TUFVPH3AIkSc1AiMU91A/RE33pbRToXoaFzlP5K3K7rzjAQwx6F8DL9JKHKDaLHrIqa5GfeZtwUeevUOvL4VoIdLAMmNL0RhqPhootgzHOKwQAvC6gHCjDG/n/YAr/hBLhYvEk/xq/9eP2L7LtIng9e+bFwlCG0KvPB3gA3v2JbtYP+OPYVRhYzuD7tUzidUm7UGUNrV6iFedOq1doVh+CL7LtPLObMs0th/Lsk5qf++xoVnKMWGi62rip4GhSuVzGks3klcghnAGixKs5oihLcgz2Upbh+I+fCq3U4sGlqz7BPbU04+cSH2luM/eR8CHky4K1ro0VhZpWwg+GastLMWukSA0w/3Lzu3LIPeZxwWqQeSHOGIEaBDhWem3n9bbYENdWOCXUq39NFlUqCZTLTNr7nBM+o8pcW4+ItymNwk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a229fd-3697-4b6d-80df-08dca2af7d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 20:16:18.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KweSCI0lWCHmBzD9Zy6cypqkIy7CtwJLlT9PdOctjFzWFtedDcRcJnHI+/zImEj/s2ugVm/YIjwG2+B7Sn35a+EotDMVJR/8owcop0oCtnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6532
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120137
X-Proofpoint-ORIG-GUID: dmL0Q6ff6Wyhor4v-jQPIlROjjFEhW5s
X-Proofpoint-GUID: dmL0Q6ff6Wyhor4v-jQPIlROjjFEhW5s

T24gVGh1LCAyMDI0LTA2LTI3IGF0IDE2OjMyIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAyNSBKdW4gMjAyNCAxODoyODozNCAtMDcwMA0KPiBhbGxpc29uLmhlbmRlcnNv
bkBvcmFjbGUuY29twqB3cm90ZToNCj4gPiBGcm9tOiBWZWdhcmQgTm9zc3VtIDx2ZWdhcmQubm9z
c3VtQG9yYWNsZS5jb20+DQo+ID4gDQo+ID4gVGhpcyBhZGRzIHNvbWUgYmFzaWMgc2VsZi10ZXN0
aW5nIGluZnJhc3RydWN0dXJlIGZvciBSRFMtVENQLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFZlZ2FyZCBOb3NzdW0gPHZlZ2FyZC5ub3NzdW1Ab3JhY2xlLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbGxpc29uIEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25Ab3JhY2xlLmNvbT4NCj4g
PiAtLS0NCj4gPiDCoERvY3VtZW50YXRpb24vZGV2LXRvb2xzL2djb3YucnN0wqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDExICsNCj4gPiDCoE1BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4g
wqB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDEgKw0KPiA+IMKgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9NYWtlZmlsZcKg
wqAgfMKgIDEzICsNCj4gPiDCoHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvUkVBRE1F
LnR4dCB8wqAgNDEgKysrKw0KPiA+IMKgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9j
b25maWcuc2jCoCB8wqAgNTYgKysrKysNCj4gPiDCoHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25l
dC9yZHMvaW5pdC5zaMKgwqDCoCB8wqAgNjkgKysrKysrDQo+ID4gwqB0b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9uZXQvcmRzL3J1bi5zaMKgwqDCoMKgIHwgMjcxDQo+ID4gKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gwqB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL3Rlc3QucHnCoMKg
wqAgfCAyNTENCj4gPiArKysrKysrKysrKysrKysrKysrDQo+IA0KPiBMZXQncyBzdGFydCB3aXRo
IGFkZGluZyBzZWxmdGVzdHMsIHdlbGwgaW50ZWdyYXRlZCB3aXRoIGtzZWxmdGVzdA0KPiBpbmZy
YS4NCj4gVGhpcyBpcyBob3cgd2UgZXhlY3V0ZSB0aGUgdGVzdHMgaW4gbmV0d29ya2luZzoNCj4g
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LW5ldGRldi9uaXBhL3dpa2kvSG93LXRvLXJ1bi1uZXRk
ZXYtc2VsZnRlc3RzLUNJLXN0eWxlDQo+IA0KPiBJZiB5b3Ugd2FudCB0byB1c2UgcHl0aG9uIHBs
ZWFzZSB1c2UNCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L2xpYi9weS8NCj4gaW5zdGVh
ZCBhZGRpbmcgYW5vdGhlciB3cmFwcGVycy4NCg0KQWxyaWdodHksIHRoYW5rIHlvdSBmb3IgdGhl
IHJldmlldyEgIFNvcnJ5IGZvciB0aGUgZGVsYXksIEkndmUgYmVlbiBvdXQNCm9mIHRvd24gbGFz
dCB3ZWVrIGFuZCBqdXN0IHNhdyB0aGUgcmVzcG9uc2UuICBJIHdpbGwgZ28gdGhyb3VnaCB0aGUN
CmxpbmsgeW91J3ZlIHByb3ZpZGVkIGFuZCB1cGRhdGUgdGhlIHNjcmlwdHMuICBUaGFuayB5b3Uh
DQoNCkFsbGlzb24NCg0K

