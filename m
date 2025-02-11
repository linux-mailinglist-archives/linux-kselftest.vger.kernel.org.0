Return-Path: <linux-kselftest+bounces-26349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F5A3094B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB9B1626C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C351F5408;
	Tue, 11 Feb 2025 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gnfCH6db";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pAzfBfv+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D101F4E41;
	Tue, 11 Feb 2025 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271540; cv=fail; b=iqBiKMGanXcKKG8KGKrytnRVkhYMEczioywc3RS/uXGAV3jnRP0HIWTV0zb2eEW7farPYidyPjvahKnR1f6K7VHCQ/ehFwi+9ztg78ivF7A7Cu9qgdm4sQO/gR4bREOj2sx/A4fmY7nMl5W42QVHo5wwfePsI1C2X9F190pTxMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271540; c=relaxed/simple;
	bh=ZXts47LnY/rQjjC5w3dT/OXI+O5eUXc9IXbP5zLcFqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S9cTEKjwla0EqQzlJsimXd5Gn2gBNdBnORyzhqMi+TySUDdWYS/j21x7ZV+Cz7JKZ+SULjcyXtk8e/Ot0eWKGPWYvtuSeQDjrrTosSPhSnfZQINYD7bro8D9FL3WW3jn3s/d6xoCZ/kZR73gKJYWRXj6iDhsVauuTkQbyteArEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gnfCH6db; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pAzfBfv+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BAtlF5026711;
	Tue, 11 Feb 2025 10:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wYcM1PcVkVLB20gj8aO6hfZ4e2tEX8ODgHcyDCNgomw=; b=
	gnfCH6dbyKV1SWt/5gBUFSpWEH6h4KKPWYpTupR+PtXmBMu36p7Goi5eBtRdzK4K
	oi3UoE7j+XmINc4HUaGyCfzJcDK4+iwfNu5+bcQLVqdhCWHBu/NyvZpnhwtdKCBQ
	NA6rpYmf1FoWU4mpa0Pw1GLQ2nnjLAZgSh/vYFPjdRjbg6TMxIMATIxyAMLelt+Y
	ecl202+fwl2YI3Cr2co5FEydGCLw7VhDP1VcfV6tmh5yaBewFhvlw8boTXOkHCuN
	AG6dDd0aVreV68HBsYUHzRCVISaEbJuxner92BicAeB7VbqFpvIsp8ykxWH9/fGQ
	+/xJIauZ6cn0d3wfyGMZIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qymxrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 10:58:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51B9UKOH030510;
	Tue, 11 Feb 2025 10:58:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p62y2u7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 10:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3tvR01NWzBAMFZYgTVEEBjy4undXEG6wr1/hMDj/2ImBe3ywbcWIWFpSfrH3EV8JlTHgZDiBnNG+mBHateaYZuM/gBWnASF99qpO+KptdkjdgR5GjQWbp9fSWeRZg9kaVjJxXa+1am2OCLtRfXZVH9tRtzokcdk+m9VkN66pfjt71F9E0i9LVcPtbDEjM05eB3QM57kgFW/tHJIP35gi2TD62sF+uJQMo5ACgy97MdoP/nXaYLxtVfH5qdC256WwcHdsZLreec5GuezGSJYhgTlaJ7kvFch/EeauItKVrjeTUWIuxPvBVGimm3XuxDf8A+IbXdNxp8nm6kSxiG4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYcM1PcVkVLB20gj8aO6hfZ4e2tEX8ODgHcyDCNgomw=;
 b=sGvQijhG86MdnIS37qW1bqnOiPWbMPQLsLI7yY1ik7bPijCrtHx33hvIwOjkg0xH/iP0WSfSdpORY9Et0M2LcmFbl4LEjnAggMjNWd3T+IQ+eStdUd9Q6n72e+60MY2fb7jkpWb6630IKpYkMqsz3+ypYWzHDsP5PDJnlrm+hLxeIGo+ROTNEp9e3j/sZsn+B3T53gZLljHkW2QOHNNH6GhVyGOqCQfGRefiRcXg6HIHxdrc3jq3o+AxOR8O9c2+jb+2zFVYMdkhwEV9/waUWTzxnNWovmelUpoHwpGjJT6WMj7BfdCXVD+HEHkK40qIw95iP8SMGVyCH+s7RUFmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYcM1PcVkVLB20gj8aO6hfZ4e2tEX8ODgHcyDCNgomw=;
 b=pAzfBfv+7UdYs/3oeUN12umNj0TSNDpjllShR06Fopg2UeeIKU+B9ELm4D+owvNMBoNTMxQMFiGk/L6Eg+VAk5USFgt9PcGJPwCTc/08jJVddfTcgcLGg7z24olSWGonOlXg3zzdyXkp4Yqt+EQbb7mR2znVUpHCLqynAMyP2M8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 10:58:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Tue, 11 Feb 2025
 10:58:22 +0000
Date: Tue, 11 Feb 2025 10:58:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH v1 1/1] selftest/mm: refactor mseal_test
Message-ID: <94924bd5-c0e2-4d97-a693-57786d9c7fc9@lucifer.local>
References: <20241211053311.245636-1-jeffxu@google.com>
 <20241211053311.245636-2-jeffxu@google.com>
 <e81dba68-ee9b-42ea-911a-4eca907c8f6a@lucifer.local>
 <CABi2SkXKW2EGPE9BV9j+c5tzxj8a1t2iXy7ckZTCNW_ZniC-hw@mail.gmail.com>
 <CABi2SkUv_1gsuGh86AON-xRLAggCvDqJMHxT17mGy-XutSTAwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUv_1gsuGh86AON-xRLAggCvDqJMHxT17mGy-XutSTAwg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c041ab-765d-40df-2912-08dd4a8b004d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TS9mTll5djQ2aGxVM3NaZTI2ZlMzSWZkV1NTSEs2K3JrUU5yaUVTS1NoMUUw?=
 =?utf-8?B?Vzl5TmxSK25pNzNNcDk1MklsT3Vzc21vdWI2QVkyaVp2bm50QUVnZ2RUTTVU?=
 =?utf-8?B?Z3hkZWMrVHF6OS9UM1pkaFlpYTlCOTNTVjVBSDMzUkVaRFRQanpjMk1IcE1I?=
 =?utf-8?B?U1g1b0pFRDQvZDFuQ0lvL2lSZ3JXVmZVOG5sT29aSkU5OWJqaGY0c1d4RzZZ?=
 =?utf-8?B?b0hUV0ljRThkd2pyOTJoY2FXNGdlRjJQMks1K0V2eGZlUmdLMVZrdkxQWGZy?=
 =?utf-8?B?ZlUzcEFTaWJhVzJON2ZOd3dTVmJvYk90TXkrckRCNzkyS25YelhLZUlTOTha?=
 =?utf-8?B?NXUzWDgyZ2FJT3V5MitYdTE4aHJFS3l2VzFiMkdlT24rTG02UUMvQllWa1Vl?=
 =?utf-8?B?MjA3b2tJbkVzSXFLckRzRmo5SXg0T2w4cHZEVmZmNFFnU1VudlhRM2JUUUtI?=
 =?utf-8?B?aWZVVkpvS1E3K1JNa2JYdmNyUndoeHlnamJuWHpjdHBlZCtlTVNrblpLU1Y4?=
 =?utf-8?B?R05XT01vSzVGc045SnJVYk1tamhuemhGazdvYW1OYmcvNmpaTmFxMUJzdUwr?=
 =?utf-8?B?YUgrUUdkTUYxajJ3QXJ0dkNtMEJSRWRCdkE1bE1YeEYyNG9aTGlVbnJ3bkkv?=
 =?utf-8?B?WXhLWmNSR08wU1ZRcmFHeXhFOGRMeDJEaDdTbzV5SXRXNHBnbk5LK3Y4Tmpa?=
 =?utf-8?B?M1BOVFpDQ0xycWl4SlJzRDFGeFBRTHlnWHFtSzVFY092c081K3dSRGRNekdJ?=
 =?utf-8?B?ZVlxRUFwZU1jMlBRRjRMcGFLb2g4R0I2aTdGd0F3eWoySFBxdDNWb2Y5TDlk?=
 =?utf-8?B?ckQxSGNsY1dRSDhlRDBkWS81N2JFT1B1cDZPYTdONDRReXJGN3pObWhOMFVL?=
 =?utf-8?B?b0tNdnhSTlVObk8xREZDSTUzWHNSSGFGZGRDQ254ZTcwV05lVmdVNGtsVmVy?=
 =?utf-8?B?dzdNMUNDTHBmWHZQSXJ5aTR3VmpnSmJ3VVl2UlBXdnVYSk5OWHBuTmt6aVFj?=
 =?utf-8?B?eGFxTG03Z292U3hPZFhYLzRhRjdvMG42WDJKTnhnV2dxMEJWV0RVc2gzUGls?=
 =?utf-8?B?ejVZNnhOYVNNaVVvNnJhdnRtdFBxRTFDM0ZjNUNLaTZyYjduZUY4SFYvaTND?=
 =?utf-8?B?UzhSR1dJWG14T2dYLzk0V0JGZWhKZGxNNS9HMGtlVkhLaVZEL2UxTTRSU1pI?=
 =?utf-8?B?SkxKWUY1eGd2WkUxQWxLTVJkRFhxK1hJajJwSFNRYnlpYmVDVElBdDhTYncr?=
 =?utf-8?B?ajlLNHlIMG81QWlCb2FVWHlabUY5eFQ5R21tWkd4aVYxUEZaS2h2M1ByUDE3?=
 =?utf-8?B?WHA5VzdTWktkd1VhT3krcmYwZGZQT3Z3UkkxNzJaVFdXQk5UOEVVNGFjaFVU?=
 =?utf-8?B?QkJhT1JWREZLN0YzdmJDQTZHcGhSamllbWc0NXI0UFFVTS9scUo3S0RQVG0x?=
 =?utf-8?B?V1dpUmlKbEdGVENwN0duclA0Sm9VdUs4Y2hPQktPSXRvajQ2eGZDQzFFZ0hv?=
 =?utf-8?B?QXFma2RkdzV2a2d3ZTVHNTVnRlFLWmdMT3ZyQTBOZldDSjEzSzJCbVhYQ2E5?=
 =?utf-8?B?WkZnNHcrc1N5Z2N5aVpkN24rd0VHckppWkk4Zmh0Qm9BdmNDN3dWMFBYc3BK?=
 =?utf-8?B?UnYzRU5EMnY3M3BlczFqV3BzODh5bnFxcmFXeHZBWjdCTitic1dDV3o0bDQ1?=
 =?utf-8?B?K2p6dHZ5RFc0RXl0VXVFNDYybnpoSVdZV3FxdFpIcHp3S2U4ajgrNnlzRlBl?=
 =?utf-8?B?V0RGbmsvb3V1bHFzVnhEcURvS0hZTi8wZitkdGZiTktnMWJEV3lJblFHWnhY?=
 =?utf-8?B?L0s2c2FsUm5VcUd5Y3RVZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VktncUlscjIzcFU3eHh6U0xORHdwUVprYVRuMlhrTWdxcHROY2xZckdOS3hK?=
 =?utf-8?B?NDI1QXNKYnFyOTRMNVFGSFNSbm1DZHV4Vnh3K2l5MjdZM0xBb1pBZEJTNld5?=
 =?utf-8?B?MkFHdWw1Q1BrVlhsZVdIaWM3dkVaMU52NlNENmFheWxUL2lLTFg3S0p4N2N2?=
 =?utf-8?B?dDVUcWxSdXVLOFYxZWhtL2t1UzZvTW5EZ3JBRkhFVnI1Vk1GVmhjcFVoUnll?=
 =?utf-8?B?b2kzdTg4NjVzcUh6YXJPaEFXQVlqSW5MY2ovekh0RnhXZVdTMVl4OThFdnFB?=
 =?utf-8?B?cXJ0eWlrUHFNUmIzc3lJTlA4MlF6TTZZd0luYVpaRjRIWmJ1MG1QZjcrSHNT?=
 =?utf-8?B?eXNzcUd4NmxLT2ZWWVdmYlBLY21xMHRwQkpnNlp6Wi92Y3Q5UC9WV092MUNH?=
 =?utf-8?B?MmhRVlhnL0I5d2hPOE02T1U2NlBZbTBES1NqK0x4ZklyK3dIN0h6RU5hcjJz?=
 =?utf-8?B?MGFpQ0U2NGZXT09EdHgvc2lVMVJXVFdvQjhkNW1GM241WmFPcG5jOVhRN2Rq?=
 =?utf-8?B?SmxVMDNRMGtiWWE0cm10V3NxSUNrME1CVkNLV3NvaFVhSjZQdDJUQjgzcUZ3?=
 =?utf-8?B?UGxOSjEzc2lWWEd2U2swNno4Y3ptN3RYMzQybzJqT0szK2l5QzR0WDdSOUt2?=
 =?utf-8?B?bk4wTmJkQ2pzNHJsVW03SGErcXdOeVZhNkpLRjJXS1dkSkovTFFYblBXNzd2?=
 =?utf-8?B?WjlscVRRSVJNalJ5UE85RmxuN1ZqbHJCZVIvQmkybGFlZE5sZ2c5cmpodGRw?=
 =?utf-8?B?RjE5ZlozV05IVHUvWTNCWWlvYmNyLzl2T2dNUXo3RWthMk44T2hwQXA3TXNj?=
 =?utf-8?B?WUpJU25WRzZlZ21kdjI1NmVhNWJpZHZyYkJZOFVuQ29ENlhHZmpIb1hYV2ZC?=
 =?utf-8?B?d0ZDZUZ5cUdGbnlEenZHaFJqZHBzd2Jud2RRT1lqbGduTTc4STd2am9NcGl4?=
 =?utf-8?B?QVcrRk9XOFY1R21HSzBLaWNTL3hQQ2xsSzBCU2ZnU0xISmNlaFdCZmF0SkZ0?=
 =?utf-8?B?VzhOak85aWNrNGo3MGl2M2crSkszOHIvKzg0aUxLQk9UODNoMUNtOUozbFNs?=
 =?utf-8?B?cEpJdGZVVzc1ZnptdlpoUDBHYWJXVm5CNXV1UU1uVFI0UWo2Tlp5VTlNS2Zh?=
 =?utf-8?B?a21adkU5eDdHUElUYVFTN1hXYlQyUFhXTG9BUXZEM2pES0VIamdIcTBFdlRs?=
 =?utf-8?B?SzBxMDFtZ0s5N0FUK0p0QTZ1RkVwZ3FQbnhhVzVEWlp2cit1cEVBSElmbnFX?=
 =?utf-8?B?ZHVaMHdiUWtVbTlHVUNSRXdCVWV0aTVvZWoyWTNqQWlEbTlJNmNNN0RRNzgz?=
 =?utf-8?B?NWRROGMvUlRybDI0c0lhTXRqR1ZyVHhkM2xuUUlhMWNiazhyY1J3UFgxekNl?=
 =?utf-8?B?NEViYm9XQkJhWGlxQk44cXpHYWc0NG5Kbkx0bEkzdnpXZTZ0VU93ajdpSExq?=
 =?utf-8?B?clEwOFRjSlFnajl1aUpuSDlkSGtwWXVpYzB3elYrUDdnbnM3cXJnSkdVVjlB?=
 =?utf-8?B?Ym9Gdk9aQjhzaTRDcmhweEJvREVjZnl3QXlweXdwakx3cHIzeU9GSHVhZFlI?=
 =?utf-8?B?UUFNOU9JRS8vUDMxbkN5aHE0Q1R0VEx0WlJLeU1KekptRFlsM3dmeVc1ckF1?=
 =?utf-8?B?SUVuTGx3Q1hWWXNOeHdXNzI5WVZDamJ1SVg4Z0tIbUtQbkIzellRWmIySXp2?=
 =?utf-8?B?SWdiOFZpUThicmExNFdGcnV6d2padmUwWlNhR3VYTEIrVi9OUG42TnFzbGI5?=
 =?utf-8?B?ZU84ZWZYY3c5elpYZkNnaHYvVkVtT2g0K09nY3Z2KzVsUlYycTIvMldvZ0NV?=
 =?utf-8?B?ZUdnU2tNNmlqTXF4TlhtNFE4RVN0Uy9Xb2V1UjhLMTA1YlBkUXdSS01odi8x?=
 =?utf-8?B?dGZrbWhRU0g3QStYekdlb05jckJPbXBZbGo5SENpK1VQQ1JXSldWMUJEMUM1?=
 =?utf-8?B?OW9yN2QveER2eG9ORjl6ckRqTDFoWHlQNFFkL00zNW5mQkpIUmF1WVJMajJV?=
 =?utf-8?B?Z043clV2ckJYZnpuLzVDSjlmWlExTGI3YkRXRTdMMDJrNzh3TXRMd1YvU1ho?=
 =?utf-8?B?RXJFMFRGZ0h5SVFYRTcrKzJmZTV2cWt4YmI2dk5zNEJjYmtLZnBwRWxNb3cy?=
 =?utf-8?B?Q0hzNVYvSk5xaUxaTytFVzJGNmtBMlo0UVlhVk90LzBHeXk2YmZNR0pnTnBN?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PZxooFZv3y6ghsEwigHR1UuYlGYJWqcw58TyhbgDVVmnzVGHRhKmlQnTJa4Ed64lL02hB0H7oMgRt4U+SLRb9dzjyrwU9M253kWih2w2XyAqeBUXZxhvWMHRMOP4X9htDuUELTPCuR8qlayGGrmzEHU/rq8VphOpkSs38u/fUoHdH/9cC6s7tYJpzlQ0YINKK2edXUme6exoGhW0O7KWa3uZVmPwblnk/bKFaaG8yKgdqwFvObVF/NCcDiIcM+gVMKZMwARRnoULuBdgvkd6HDtIWDNkMGNE3GU5E66ya7j/8FX8C9Cm7WlTv0ElSkBx4c3xo+qVohsqrwuY1qMKTAOpUY1xJdzKs4vvox2ijNNuoDGNgN+IqsG9UnPdj973PJlSPmvT2TmmhEJSpDWGm7zhtJ+3MrX0yZzYcx0nJh4QJf5Fd62pAYZ/8N9jZPXBj8MSaigMPTrNT1wqnCVcSc1WTW+LJixYXx1zqCaS52eAYeddWNdj5cL8dSCCRRCUlGT9VfSi9oaUG5fiuq7EJt1NCpSNWYr1uyoYGs6YpefwOkKcOSTd2iLEkevFyxdJM6osrpkqMZNnF+Nzb2SsDHWeL1cRgCf56O1ALaijj5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c041ab-765d-40df-2912-08dd4a8b004d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:58:22.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IakJKN9sz8jXNUjD79KsIxlabu/OaS4ZHSWFQ1fpV8BHyEArBYrOVwBw0KAbmRZvuXBQFrg6pml0AXhoKbX5xQMJW8K0NmIzOZaKiitCTV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_05,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502110070
X-Proofpoint-ORIG-GUID: NsGEjhoNcTKu7ufBskPKPVsI4H1AQvSM
X-Proofpoint-GUID: NsGEjhoNcTKu7ufBskPKPVsI4H1AQvSM

On Mon, Feb 10, 2025 at 01:35:52PM -0800, Jeff Xu wrote:
> Hi Lorenzo,
>
> Gentle ping for my clarification questions.
>
> I also tried the new ioctl PROCMAP_QUERY, please see below for details.
>

Hi Jeff,

Sorry I thought you'd send a new version which is why I didn't reply. I will
take a look through and get back to you, it's on my whiteboard now...

Apologies for the delay, this was just an error!

And thanks for taking a look at the ioctl, will take a look and that when I
get a sec also.

Cheers, Lorenzo


> On Wed, Jan 15, 2025 at 12:47 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > Hi Lorenzo,
> >
> > On Thu, Jan 2, 2025 at 9:30 AM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > Sorry for delay, was super busy leading up to xmas break, then had ~2.5
> > > weeks off.
> > >
> > Thanks for reviewing.  There are lots of comments, so it takes some
> > time to go through comments and experiment with some of the suggested
> > changes. Please see below.
> >
> > > And happy new year! :)
> > >
> > Happy new year !
> >
> > > On Wed, Dec 11, 2024 at 05:33:11AM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > This change creates the initial version of memorysealing.c.
> > > >
> > > > The introduction of memorysealing.c, which replaces mseal_test.c and
> > >
> > > I mean I don't want to be a pain but I would kinda prefer to have 'mseal'
> > > everywhere mseal is to avoid confusion vs. memfd seals.
> > >
> > As I tried to explain, the memorysealing.c will eventually replace
> > mseal_test.c, after all the tests are moved to use kselftest_karness.
> > How about mseal_test_new.c ? I'm open to new names if you have one.
> >
> > > Of course we in the kernel absolutely _love_ to overload the meaning of terms
> > > but some traditions are worth breaking :)
> > >
> > > > uses the kselftest_harness, aims to initiate a discussion on using the
> > > > selftest harness for memory sealing tests. Upon approval of this
> > > > approach, the migration of tests from mseal_test.c to memorysealing.c
> > > > can be implemented in a step-by-step manner.
> > >
> > > Well, I for one like this approach so (unsurprisingly) :) but perhaps
> > > sensible to do it iteratively so we can also tweak things as we go.
> > >
> > Yes, that is the idea.
> >
> > > >
> > > > This tests addresses following feedback from previous reviews:
> > > >
> > > > 1> Use kselftest_harness instead of custom macro, such as EXPECT_XX,
> > > > ASSERT_XX, etc.  (Lorenzo Stoakes, Mark Brown) [1]
> > > >
> > > > 2> Use MAP_FAILED to check the return of mmap (Lorenzo Stoakes).
> > >
> > > Thanks!
> > >
> > > >
> > > > 3>  Adding a check for vma size and prot bits. The discussion for
> > > >     this can be found in [2] [3], here is a brief summary:
> > > >     This is to follow up on Pedro’s in-loop change (from
> > > >     can_modify_mm to can_modify_vma). When mseal_test is initially
> > > >     created, they have a common pattern:  setup memory layout,
> > > >     seal the memory, perform a few mm-api steps, verify return code
> > > >     (not zero).  Because of the nature of out-of-loop,  it is sufficient
> > > >     to just verify the error code in a few cases.
> > > >
> > > >     With Pedro's in-loop change, the sealing check happens later in the
> > > >     stack, thus there are more things and scenarios to verify. And there
> > > >     was feedbacks to me that mseal_test should be extensive enough to
> > > >     discover all regressions. Hence I'm adding check for vma size and prot
> > > >     bits.
> > > >
> > > > In this change: we created two fixtures:
> > > >
> > > > Fixture basic:   This creates a single VMA, the VMA has a
> > > > PROT_NONE page at each end to prevent auto-merging.
> > > >
> > > > Fixture wo_vma: Two VMAs back to end, a PROT_NONE page at each
> > > > end to prevent auto-merging.
> > > >
> > > > In addition, I add one test (mprotec) in each fixture to demo the tests.
> > > >
> > > > [1] https://lore.kernel.org/all/20240830180237.1220027-5-jeffxu@chromium.org/
> > > > [2] https://lore.kernel.org/all/CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com/
> > > > [3] https://lore.kernel.org/all/2qywbjb5ebtgwkh354w3lj3vhaothvubjokxq5fhyri5jeeton@duqngzo3swjz/
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > ---
> > > >  tools/testing/selftests/mm/.gitignore      |   1 +
> > > >  tools/testing/selftests/mm/Makefile        |   1 +
> > > >  tools/testing/selftests/mm/memorysealing.c | 182 +++++++++++++++++++++
> > > >  tools/testing/selftests/mm/memorysealing.h | 116 +++++++++++++
> > > >  tools/testing/selftests/mm/mseal_test.c    |  67 +-------
> > > >  5 files changed, 301 insertions(+), 66 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/mm/memorysealing.c
> > > >  create mode 100644 tools/testing/selftests/mm/memorysealing.h
> > > >
> > > > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> > > > index a51a947b2d1d..982234a99f20 100644
> > > > --- a/tools/testing/selftests/mm/.gitignore
> > > > +++ b/tools/testing/selftests/mm/.gitignore
> > > > @@ -57,3 +57,4 @@ hugetlb_dio
> > > >  pkey_sighandler_tests_32
> > > >  pkey_sighandler_tests_64
> > > >  guard-pages
> > > > +memorysealing
> > > > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> > > > index 93a46ac633df..08876624f46d 100644
> > > > --- a/tools/testing/selftests/mm/Makefile
> > > > +++ b/tools/testing/selftests/mm/Makefile
> > > > @@ -67,6 +67,7 @@ TEST_GEN_FILES += map_populate
> > > >  ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
> > > >  TEST_GEN_FILES += memfd_secret
> > > >  endif
> > > > +TEST_GEN_FILES += memorysealing
> > > >  TEST_GEN_FILES += migration
> > > >  TEST_GEN_FILES += mkdirty
> > > >  TEST_GEN_FILES += mlock-random-test
> > > > diff --git a/tools/testing/selftests/mm/memorysealing.c b/tools/testing/selftests/mm/memorysealing.c
> > > > new file mode 100644
> > > > index 000000000000..e10032528b64
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/mm/memorysealing.c
> > > > @@ -0,0 +1,182 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +#define _GNU_SOURCE
> > > > +#include "../kselftest_harness.h"
> > > > +#include <asm-generic/unistd.h>
> > > > +#include <errno.h>
> > > > +#include <syscall.h>
> > > > +#include "memorysealing.h"
> > > > +
> > > > +/*
> > > > + * To avoid auto-merging, create a VMA with PROT_NONE pages at each end.
> > > > + * If unsuccessful, return MAP_FAILED.
> > > > + */
> > > > +static void *setup_single_address(int size, int prot)
> > >
> > > Nitty, but size should really be an unsigned long.
> > >
> > sure, thanks
> >
> > > > +{
> > > > +     int ret;
> > > > +     void *ptr;
> > > > +     unsigned long page_size = getpagesize();
> > >
> > > Trivial, but we store page size in self->page_size so why not pass it as a
> > > parameter instead of looking up?
> > >
> > sure.
> >
> > > > +
> > > > +     ptr = mmap(NULL, size + 2 * page_size, prot,
> > > > +             MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > > > +
> > > > +     if (ptr == MAP_FAILED)
> > > > +             return MAP_FAILED;
> > > > +
> > > > +     /* To avoid auto-merging, change to PROT_NONE at each end. */
> > > > +     ret = sys_mprotect(ptr, page_size, PROT_NONE);
> > > > +     if (ret != 0)
> > > > +             return MAP_FAILED;
> > > > +
> > > > +     ret = sys_mprotect(ptr + size + page_size, page_size, PROT_NONE);
> > > > +     if (ret != 0)
> > > > +             return MAP_FAILED;
> > > > +
> > > > +     return ptr + page_size;
> > > > +}
> > >
> > > This could be done more easily with a single PROT_NONE, like:
> > >
> > >         static void *setup_single_address(unsigned long size, int prot,
> > >                         unsigned long page_size)
> > >         {
> > >                 void *ptr;
> > >
> > >                 /* Ensure we only merge what we intend to. */
> > >                 ptr = mmap(NULL, size + 2 * page_size, PROT_NONE,
> > >                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > >                 if (ptr == MAP_FAILED)
> > >                         return MAP_FAILED;
> > >
> > >                 return mmap(&ptr[page_size], size, prot,
> > >                             MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > >         }
> > >
> > sure, create PROT_NONE mapping first, then use mprotect to change the
> > middle part.
> >
> > > It's probably worth having an equivalent freeing function to avoid leaks:
> > >
> > >         static int free_single_address(void *ptr, unsigned long size,
> > >                         unsigned long page_size)
> > >         {
> > >                 /* Also free the PROT_NONE sentinels. */
> > >                 return munmap(ptr - page_size, size + 2 * page_size);
> >
> > [resp 1] could you clarify? I think we won't need freeing because
> > mapping will be sealed. You might recall, mseal() blocks munmap(), and
> > munmap() is atomic,  so the above line that you suggested will result
> > in no-action during FIXTURE_TEARDOWN. There will be separate test
> > cases to test munmap under sealing. In addition, the virtual address
> > space is big enough for this test complete without worry about the
> > out-of-memory situation. Do I miss anything ?
> >
> > >         }
> > >
> > > > +
> > > > +FIXTURE(basic)
> > > > +{
> > > > +     unsigned long page_size;
> > > > +     unsigned long size;
> > > > +     void *ptr;
> > > > +};
> > > > +
> > > > +/*
> > > > + * Setup for basic:
> > > > + * Single VMA with 4 pages, prot = (PROT_READ | PROT_WRITE).
> > > > + */
> > > > +FIXTURE_SETUP(basic)
> > > > +{
> > > > +     int prot;
> > > > +
> > > > +     self->page_size = getpagesize();
> > > > +
> > > > +     if (!mseal_supported())
> > > > +             SKIP(return, "mseal is not supported");
> > > > +
> > > > +     /* Create a single VMA with 4 pages, prot as PROT_READ | PROT_WRITE. */
> > > > +     self->size = self->page_size * 4;
> > > > +     self->ptr = setup_single_address(self->size, PROT_READ | PROT_WRITE);
> > > > +     EXPECT_NE(self->ptr, MAP_FAILED);
> > > > +
> > > > +     EXPECT_EQ(self->size, get_vma_size(self->ptr, &prot));
> > >
> > > I mean fine but this check seems a bit overkill here, we don't need to
> > > check to ensure that PROT_NONE works.
> > >
> > [resp 2] Those checks are there,  for the same reason that test cases
> > usually check the return value of mmap(), mprotect() in the
> > FIXTURE_SETUP. You are right that those calls are unlikely to fail,
> > however, test cases generally do those  "housekeeping tasks"  to make
> > sure everything is OK before  the actual test. If you don't want to
> > keep those, what is the downside of keeping them ?
> >
> > > > +     EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
> > >
> > > Nitty, but this seems a bit 'Yoda style', that is placing the expectation
> > > prior to the value whose expectation we are assessing, that is perhaps it'd
> > > be clearer as:
> > >
> > >         EXPECT_EQ(prot, PROT_READ | PROT_WRITE);
> > >
> > [resp 3] Both styles are used in self tests and I believe it is
> > equally clear,  I can accommodate this request for this patch.
> >
> > > And again, I think this is really overkill here, if the kernel is unable to
> > > do an ordinary mapping correctly we have bigger problems than an mseal bug!
> > >
> > please see [resp 2]
> >
> > > > +};
> > > > +
> > > > +FIXTURE_TEARDOWN(basic)
> > > > +{
> > >
> > > Probably worth adding munmap() teardown here.
> > >
> > please see [resp 1]
> >
> > > > +}
> > > > +
> > > > +FIXTURE(two_vma)
> > > > +{
> > > > +     unsigned long page_size;
> > > > +     unsigned long size;
> > > > +     void *ptr;
> > > > +};
> > > > +
> > > > +/*
> > > > + * Setup for two_vma:
> > > > + * Two consecutive VMAs, each with 2 pages.
> > > > + * The first VMA:  prot = PROT_READ.
> > > > + * The second VMA: prot = (PROT_READ | PROT_WRITE).
> > > > + */
> > > > +FIXTURE_SETUP(two_vma)
> > > > +{
> > > > +     int prot;
> > > > +     int ret;
> > > > +
> > > > +     self->page_size = getpagesize();
> > > > +
> > > > +     if (!mseal_supported())
> > > > +             SKIP(return, "mseal is not supported");
> > > > +
> > > > +     /* Create a single VMA with 4 pages, prot as PROT_READ | PROT_WRITE. */
> > > > +     self->size = getpagesize() * 4;
> > > > +     self->ptr = setup_single_address(self->size, PROT_READ | PROT_WRITE);
> > > > +     EXPECT_NE(self->ptr, MAP_FAILED);
> > > > +
> > > > +     /* Use mprotect to split as two VMA. */
> > > > +     ret = sys_mprotect(self->ptr, self->page_size * 2, PROT_READ);
> > > > +     ASSERT_EQ(ret, 0);
> > > > +
> > >
> > > > +     /* Verify the first VMA is 2 pages and prot bits */
> > > > +     EXPECT_EQ(self->page_size * 2, get_vma_size(self->ptr, &prot));
> > > > +     EXPECT_EQ(PROT_READ, prot);
> > > > +
> > > > +     /* Verify the second VMA is 2 pages and prot bits */
> > > > +     EXPECT_EQ(self->page_size * 2,
> > > > +             get_vma_size(self->ptr + self->page_size * 2, &prot));
> > > > +     EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
> > >
> > > Again, as with the prior fixture, it seems a bit overkill, as this is
> > > essentially testing 'does mmap() and mprotect()' work. We should hope so :)
> > Please see [resp 2]
> >
> > > > +};
> > > > +
> > > > +FIXTURE_TEARDOWN(two_vma)
> > > > +{
> > >
> > > Same comment as for the basic fixture - let's clean up after ourselves.
> > >
> > please see [resp 1]
> >
> > > > +}
> > > > +
> > > > +/*
> > > > + * Verify mprotect is blocked.
> > > > + */
> > > > +TEST_F(basic, mprotect_basic)
> > > > +{
> > > > +     int ret;
> > > > +     unsigned long size;
> > > > +     int prot;
> > > > +
> > > > +     /* Seal the mapping. */
> > > > +     ret = sys_mseal(self->ptr, self->size, 0);
> > > > +     ASSERT_EQ(ret, 0);
> > > > +
> > > > +     /* Verify mprotect is blocked. */
> > > > +     ret = sys_mprotect(self->ptr, self->size, PROT_READ);
> > > > +     EXPECT_GT(0, ret);
> > >
> > > Yeah this one is kinda egregious, this is genuinely hard to read. Wouldn't
> > > this be better as:
> > >
> > >         EXPECT_NE(ret, 0);
> > >
> > > As it explicitly says 'not equal to a success case'. Rather than 'wait 0 is
> > > _greater than_ the result which means the result is _less than_ 0 which
> > > means an error but let me check the man page can it be positive, oh ok it's
> > > -1 on error, 0 on success', which was the Lorenzo thought process... :)
> > >
> > [resp 4] The man page says: "On success, mprotect() and
> > pkey_mprotect() return zero.  On error, these system calls return -1,
> > and errno is set to indicate the error."
> >
> > I wll switch EXPECT_EQ(ret, -1) which is precisely what the man page says.
> >
> > > > +     EXPECT_EQ(EPERM, errno);
> > >
> > > Let's invert these, Yoda style isn't really useful here and is a little
> > > harder to read, e.g. we should do:
> > >
> > >         EXPECT_EQ(errno, EPERM);
> > >
> > please see [resp 3]
> >
> > > > +
> > > > +     /* Verify the VMA (sealed) isn't changed */
> > > > +     size = get_vma_size(self->ptr, &prot);
> > > > +     EXPECT_EQ(self->size, size);
> > > > +     EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
> > >
> > > Again, no to Yoda :)
> > >
> > please see [resp 3]
> >
> > > I also wonder how useful this is - I guess belts + braces, and linux _can_
> > > do partial failures, but is that something we would care about in practice?
> > >
> > [resp 5]
> > Those checks will help to detect regression, such as  when Pedro
> > Falcato implemented in-loop change [1]. Liam R. Howlett also commented
> > that mseal_test should be extensive enough to check for size and prot
> > to avoid future regression [2]
> >
> > For your question about partial failure, there will be additional
> > tests for partial-sealed-address range, and those will check the
> > sealed mapping only.
> >
> > > > +}
> > > > +
> > > > +/*
> > > > + * Seal both VMAs in one mseal call.
> > > > + * Verify mprotect is blocked on both VMAs in various cases.
> > > > + */
> > > > +TEST_F(two_vma, mprotect)
> > >
> > > I'm guessing you aren't necessarily covering _all_ mprotect cases here
> > > (though perhaps you intend to later, iteratively?)
> > >
> > Yes.
> >
> > > > +{
> > > > +     int ret;
> > > > +     int prot;
> > > > +     unsigned long size;
> > >
> > > I think 'size' is a bit confusing as it refers to the size ascertained from
> > > the get_vma_size() later on. Perhaps call it actual_size?
> > >
> > To help  readability, I will change size to vma_size, which
> > corresponds to the return of get_vma_size().
> >
> > > Maybe worth adding:
> > >
> > >         void *ptr = self->ptr;
> > >         unsigned long size = self->size;
> > >         unsigned long page_size = self->page_size;
> > >
> > > For convenience?
> > >
> > > This is totally optional though, maybe more effort than it's worth.
> > >
> > I don't think it is worth it.
> >
> > > > +
> > > > +     /* Seal both VMAs in one mseal call. */
> > > > +     ret = sys_mseal(self->ptr, self->size, 0);
> > > > +     ASSERT_EQ(ret, 0);
> > > > +
> > > > +     /* Verify mprotect is rejected on the first VMA. */
> > > > +     ret = sys_mprotect(self->ptr, self->page_size * 2,
> > > > +             PROT_READ | PROT_EXEC);
> > >
> > > Why PROT_READ | PROT_EXEC? Is this arbitrary? To be thorough shouldn't you
> > > loop through all of the prot flags that you think should fail? And perhaps
> > > check what happens if you mprotect() the VMA to set it to what it already
> > > is?
> > >
> > [resp 6]
> > Not arbitrary. As commented in FIXTURE_SETUP, the first VMA is
> > PROT_READ, and the second VMA is PROT_READ | PROT_WRITE.   The test
> > wants to use mprotect to change the proc bit to a different set.
> >
> > For your question about mprotect() the sealed vma to what it already
> > is (doesn't change any attribute), I don't want to solidify the
> > current behavior (which is to block). It should be successful instead.
> > With in-loop check and partial update behavior,  there is no reason to
> > block it, i.e. no security benefit. I already plan to address this.
> >
> > > > +     EXPECT_GT(0, ret);
> > >
> > > Please convert to EXPECT_NE(ret, 0)
> > >
> > please see [resp 4]
> >
> > > > +     EXPECT_EQ(EPERM, errno);
> > >
> > > Please invert to EXPECT_EQ(errno, EPERM)
> > >
> > please see [resp 3]
> >
> > > > +
> > > > +     /* Verify mprotect is rejected on the second VMA. */
> > > > +     ret = sys_mprotect(self->ptr, self->page_size * 2,
> > > > +             PROT_READ | PROT_EXEC);
> > >
> > > Hang on, isn't this just a repeat of the first test? Shouldn't this be:
> > >
> > >         ret = sys_mprotect(&self->ptr[self->page_size * 2],
> > >                 self->page_size * 2, PROT_READ | PROT_EXEC);
> > >
> > [resp 7] Not the same, this test has two VMA, and  the mseal() covers
> > both VMAs in one call. In the first test, i.e. basic, mprotect_basic,
> > mseal is called on single VMA.
> >
> > > > +     EXPECT_GT(0, ret);
> > > > +     EXPECT_EQ(EPERM, errno);
> > >
> > > Same comment as above re: ordering.
> > >
> > please see [resp 3]
> >
> > > > +
> > > > +     /* Attempt of mprotect two VMAs at the same call is blocked */
> > > > +     ret = sys_mprotect(self->ptr, self->size,
> > > > +             PROT_READ | PROT_EXEC);
> > >
> > > Same comment about iterating through prot flags that should fail as above.
> > >
> > please see [resp 7]
> >
> > > > +     EXPECT_GT(0, ret);
> > > > +     EXPECT_EQ(EPERM, errno);
> > >
> > > Same comment as above re: ordering.
> > >
> > please see [resp 3]
> >
> > > > +
> > > > +     /* Verify both VMAs aren't changed. */
> > > > +     size = get_vma_size(self->ptr, &prot);
> > > > +     EXPECT_EQ(self->page_size * 2, size);
> > > > +     EXPECT_EQ(PROT_READ, prot);
> > >
> > > Same comment as above re: ordering.
> > >
> > please see [resp 3]
> >
> > > > +
> > > > +     size = get_vma_size(self->ptr + self->page_size * 2, &prot);
> > > > +     EXPECT_EQ(self->page_size * 2, size);
> > > > +     EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
> > >
> > > Same comment as above re: ordering.
> > >
> > please see [resp 3]
> >
> > > > +}
> > > > +
> > > > +TEST_HARNESS_MAIN
> > > > diff --git a/tools/testing/selftests/mm/memorysealing.h b/tools/testing/selftests/mm/memorysealing.h
> > > > new file mode 100644
> > > > index 000000000000..aee6e6700028
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/mm/memorysealing.h
> > > > @@ -0,0 +1,116 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#include <syscall.h>
> > > > +
> > > > +/*
> > > > + * Define sys_xyx to call syscall directly.
> > > > + * This is needed because we want to avoid calling glibc and
> > > > + * test syscall directly.
> > >
> > > I do wonder if this is worth it, but I mean, I guess it's not too egregious
> > > if it's wrapped like this. Same comment for other wrappers.
> > >
> > The self-test should directly test the kernel syscall without any
> > intermediate layer. selftest is not a libc test. It is practical too,
> > glibc's behavior can change across versions which result inconsistent,
> > and Padro Falcato reported one of this and fixed in [3]
> >
> > > > + * The only exception is mmap, which _NR_mmap2 is not defined for
> > > > + * some ARM architecture.
> > > > + */
> > > > +static inline int sys_mseal(void *start, size_t len, unsigned long flags)
> > > > +{
> > > > +     int sret;
> > > > +
> > > > +     errno = 0;
> > >
> > > Why are we setting this to 0? Same comment for all sys_XXX() wrappers.
> > >
> > The test is only interested in the latest error associated with the
> > failed syscall, and I'm not sure the kernel clears the errno for each
> > system call. Note, there is no glibc layer here.
> >
> > > > +     sret = syscall(__NR_mseal, start, len, flags);
> > > > +     return sret;
> > >
> > > Nit, but this seems a bit redundant, why not just drop the sret assignment,
> > > and simply:
> > >
> > >         return syscall(__NR_mseal, start, len, flags);
> > >
> > > Same comment for all sys_XXX() wrappers.
> > >
> > [resp 6] I think this is a different taste in coding style. For the
> > test, I prefer to have local variables so it is easy to show them in
> > the debugger, when needed.
> >
> > > > +}
> > > > +
> > > > +static inline int sys_mprotect(void *ptr, size_t size, unsigned long prot)
> > > > +{
> > > > +     int sret;
> > > > +
> > > > +     errno = 0;
> > > > +     sret = syscall(__NR_mprotect, ptr, size, prot);
> > > > +     return sret;
> > > > +}
> > > > +
> > >
> > > The wrappers below don't seem to be used yet, could we delay putting them
> > > in until they are actually used?
> > >
> > Sure, I will remove sys_mprotect_pkey for this patch.
> >
> > > > +static inline int sys_mprotect_pkey(void *ptr, size_t size,
> > > > +     unsigned long orig_prot, unsigned long pkey)
> > > > +{
> > > > +     int sret;
> > > > +
> > > > +     errno = 0;
> > > > +     sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
> > > > +     return sret;
> > > > +}
> > > > +
> > > > +static inline int sys_munmap(void *ptr, size_t size)
> > > > +{
> > > > +     int sret;
> > > > +
> > > > +     errno = 0;
> > > > +     sret = syscall(__NR_munmap, ptr, size);
> > > > +     return sret;
> > > > +}
> > > > +
> > > > +static inline int sys_madvise(void *start, size_t len, int types)
> > > > +{
> > > > +     int sret;
> > > > +
> > > > +     errno = 0;
> > > > +     sret = syscall(__NR_madvise, start, len, types);
> > > > +     return sret;
> > > > +}
> > > > +
> > > > +static inline void *sys_mremap(void *addr, size_t old_len, size_t new_len,
> > > > +     unsigned long flags, void *new_addr)
> > > > +{
> > > > +     void *sret;
> > > > +
> > > > +     errno = 0;
> > > > +     sret = (void *) syscall(__NR_mremap, addr, old_len, new_len, flags, new_addr);
> > > > +     return sret;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Parsing /proc/self/maps to get VMA's size and prot bit.
> > > > + */
> > > > +static unsigned long get_vma_size(void *addr, int *prot)
> > > > +{
> > > > +     FILE *maps;
> > > > +     char line[256];
> > > > +     int size = 0;
> > > > +     uintptr_t  addr_start, addr_end;
> > >
> > > Why not add a:
> > >
> > >         uintptr_t addr_val = (uintptr_t)addr;
> > >
> > > To avoid having to constantly cast below?
> > >
> > sure.
> >
> > > > +     char protstr[5];
> > > > +     *prot = 0;
> > >
> > > Nit but not sure there's much point in setting this to 0 even in failure
> > > cases?
> > >
> > > With an error code return you can avoid having to do this.
> > >
> > [resp 8]
> > I don't think the error code return is worth the effort, it currently
> > returns 0 size in case of error or not-found. For easy debug parsing
> > errors, I can add logs.  Notes, the parsing should always be
> > successful.
> >
> > > > +
> > > > +     maps = fopen("/proc/self/maps", "r");
> > > > +     if (!maps)
> > > > +             return 0;
> > >
> > > Might it be better to return an error code or something so we can identify
> > > this case? I guess any sensible call will fail on a 0 but you're sort of
> > > just implicitly hoping for this.
> > >
> > [resp 9] we could add logging in case of error.
> >
> > > > +
> > > > +     while (fgets(line, sizeof(line), maps)) {
> > > > +             if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, protstr) == 3) {
> > > > +                     if (addr_start == (uintptr_t) addr) {
> > >
> > > This is a Yoda comparison again, let's put what we're comparing first, and
> > > the thing we're comparing to afterwards, e.g.
> > >
> > >         if ((uintptr_t)addr == addr_start) ...
> > >
> > addr is the expected value from input and  addr_start changes after
> > parsing each line. The expected value (addr) is in second position,
> > why is this yoda syntax ? IMO, introducing the yoda syntax concept for
> > "=="  is more confusing than useful, A==B is as clear as B==A.
> >
> > > Also I don't think a space after the (type) cast is necesary.
> > >
> > sure
> >
> > > > +                             size = addr_end - addr_start;
> > > > +                             if (protstr[0] == 'r')
> > > > +                                     *prot |= PROT_READ;
> > > > +                             if (protstr[1] == 'w')
> > > > +                                     *prot |= PROT_WRITE;
> > > > +                             if (protstr[2] == 'x')
> > > > +                                     *prot |= PROT_EXEC;
> > > > +                             break;
> > > > +                     }
> > > > +             }
> > > > +     }
> > >
> > > On the impl: This would be neater if you used guard clauses:
> > >
> > >         while (fgets(line, sizeof(line), maps)) {
> > >                 if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, protstr) != 3)
> > >                         continue;
> > >
> > >                 if (addr_val != addr_start)
> > >                         continue;
> > >
> > >                 size = addr_end - addr_start;
> > >                 if (protstr[0] == 'r')
> > >                         *prot |= PROT_READ;
> > >                 if (protstr[1] == 'w')
> > >                         *prot |= PROT_WRITE;
> > >                 if (protstr[2] == 'x')
> > >                         *prot |= PROT_EXEC;
> > >                 break;
> > >         }
> > >
> > > This is a lot more readable?
> > >
> > sure.
> >
> > > On doing this at all - it feels a bit crazy to check this, but I guess it
> > > might be the only way to assert things about merge/split.
> > >
> > > I'm not sure it's _really useful_ to do that though - merges/splits are
> > > internal implementation details in effect (modulo mremap single VMA
> > > requirements), and mseal is an external interface, really the check should
> > > be around 'can forbidden operations be performed on sealed mappings'.
> > >
> > This is related to resp [5].
> > This test not only verifies the size, but also verifies the prot bits.
> > The argument that VMA is an internal behavior is questionable, the
> > /proc/pid/maps is user-facing and applications can read it and parse
> > it.
> >
> > > However, if you do really want to do this, I think it would be much better
> > > to use the new ioctl interface for this [0] which should avoid having to do
> > > unpleasant text wrangling :)
> > >
> > > [0]:https://lore.kernel.org/all/20240627170900.1672542-1-andrii@kernel.org/
> > >
> > I could try this. This is a new feature though, I do think this
> > selftest should be self-standing and has as minimal dependency as
> > possible.  Is there harm of using /proc/pid/maps ? parsing
> > /proc/pid/maps already used by selftest in lots of places (see below),
> > I would prefer testing to use well-established patterns than relying
> > on a newly developed feature.
> >
> > filesystems/overlayfs/dev_in_maps.c
> > mm/mlock2-tests.c
> > mm/mremap_test.c
> > mm/virtual_address_range.c
> > mm/split_huge_page_test.c
> > filesystems/overlayfs/dev_in_maps.c
> > exec/load_address.c
> > bpf/trace_helpers.c
> >
> I have tried new ioctl PROCMAP_QUERY to replace get_vma_size, and
> observed a few facts:
> 1.The ioctl requires the caller to set the correct PROT bits for the
> query to succeed.
> 2. The ioctl returns the VMA containing the query address, which may
> not start at that address.
> 3. The ioctl doesn't return the sealing flag.
>
> What get_vma_size wants is: for a given address, return the VMA
> started from that address, with PROT bits, size, and the sealing flag
> information.
>
> In the next version, I'll add a check for the VMA's seal flag (by
> querying /proc/pid/smaps). Since the ioctl doesn't support returning
> the sealing flag and smaps already contain length/prot bit
> information, using an additional ioctl doesn't provide any benefit.
>
> Thanks
> -Jeff
>
> > >
> > > > +     fclose(maps);
> > > > +     return size;
> > >
> > > If we don't find the line we don't seem to be indicating this, again worth
> > > being able to pass back an error?
> > >
> > It can be normal that we don't find a line, i.e. tests want to verify
> > that a VMA does not exist at address, return 0 size is correct in this
> > case. If a parsing error ever happened, the test would have failed at
> > FIXTURE_SETUP to begin with.
> >
> > > > +}
> > > > +
> > > > +static inline bool mseal_supported(void)
> > > > +{
> > > > +     int ret;
> > > > +     void *ptr;
> > > > +     unsigned long page_size = getpagesize();
> > > > +
> > > > +     ptr = mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > > > +     if (ptr == MAP_FAILED)
> > > > +             return false;
> > > > +
> > > > +     ret = sys_mseal(ptr, page_size, 0);
> > > > +     if (ret < 0)
> > > > +             return false;
> > >
> > > This is kind of cute, I mean it speaks to the need I think for us to be
> > > able to expose 'is X available?' programmatically. But I digress.
> > >
> > > I guess this is ok, as this is something that should never fail.
> > >
> > You might recall that mseal is not available on the 32 bits kernel,
> > automation might run the mseal_test on a 32 bit build.
> > mseal_supported() detects this so tests can be skipped.
> >
> > > But we should definitely clean up after ourselves here whether this
> > > succeeds or fails.
> > >
> > please see resp [1].
> >
> > Thanks!
> > -Jeff
> > [1] https://lore.kernel.org/all/CAKbZUD31EK2ah=vWJ46y4nL9OygzAa6ZxPnPHmWYO-sop5t+5Q@mail.gmail.com/
> > [2] https://lore.kernel.org/all/ko3pjllsgufbz33hqvwdpdsyxvgrgzqiodxexnpcng3mssffeh@dfgfkqlg46xa/
> > [3] https://lore.kernel.org/all/20240807153544.2754247-1-jeffxu@chromium.org/
> >
> >
> >
> >
> >
> >
> >
> > > > +
> > > > +     return true;
> > > > +}
> > > > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> > > > index ad17005521a8..8dd20341de3d 100644
> > > > --- a/tools/testing/selftests/mm/mseal_test.c
> > > > +++ b/tools/testing/selftests/mm/mseal_test.c
> > > > @@ -517,30 +517,6 @@ static void test_seal_twice(void)
> > > >       REPORT_TEST_PASS();
> > > >  }
> > > >
> > > > -static void test_seal_mprotect(bool seal)
> > > > -{
> > > > -     void *ptr;
> > > > -     unsigned long page_size = getpagesize();
> > > > -     unsigned long size = 4 * page_size;
> > > > -     int ret;
> > > > -
> > > > -     setup_single_address(size, &ptr);
> > > > -     FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> > > > -
> > > > -     if (seal) {
> > > > -             ret = seal_single_address(ptr, size);
> > > > -             FAIL_TEST_IF_FALSE(!ret);
> > > > -     }
> > > > -
> > > > -     ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> > > > -     if (seal)
> > > > -             FAIL_TEST_IF_FALSE(ret < 0);
> > > > -     else
> > > > -             FAIL_TEST_IF_FALSE(!ret);
> > > > -
> > > > -     REPORT_TEST_PASS();
> > > > -}
> > > > -
> > > >  static void test_seal_start_mprotect(bool seal)
> > > >  {
> > > >       void *ptr;
> > > > @@ -658,41 +634,6 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
> > > >       REPORT_TEST_PASS();
> > > >  }
> > > >
> > > > -static void test_seal_mprotect_two_vma(bool seal)
> > > > -{
> > > > -     void *ptr;
> > > > -     unsigned long page_size = getpagesize();
> > > > -     unsigned long size = 4 * page_size;
> > > > -     int ret;
> > > > -
> > > > -     setup_single_address(size, &ptr);
> > > > -     FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> > > > -
> > > > -     /* use mprotect to split */
> > > > -     ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > > > -     FAIL_TEST_IF_FALSE(!ret);
> > > > -
> > > > -     if (seal) {
> > > > -             ret = seal_single_address(ptr, page_size * 4);
> > > > -             FAIL_TEST_IF_FALSE(!ret);
> > > > -     }
> > > > -
> > > > -     ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > > > -     if (seal)
> > > > -             FAIL_TEST_IF_FALSE(ret < 0);
> > > > -     else
> > > > -             FAIL_TEST_IF_FALSE(!ret);
> > > > -
> > > > -     ret = sys_mprotect(ptr + page_size * 2, page_size * 2,
> > > > -                     PROT_READ | PROT_WRITE);
> > > > -     if (seal)
> > > > -             FAIL_TEST_IF_FALSE(ret < 0);
> > > > -     else
> > > > -             FAIL_TEST_IF_FALSE(!ret);
> > > > -
> > > > -     REPORT_TEST_PASS();
> > > > -}
> > > > -
> > > >  static void test_seal_mprotect_two_vma_with_split(bool seal)
> > > >  {
> > > >       void *ptr;
> > > > @@ -1876,7 +1817,7 @@ int main(void)
> > > >       if (!pkey_supported())
> > > >               ksft_print_msg("PKEY not supported\n");
> > > >
> > > > -     ksft_set_plan(88);
> > > > +     ksft_set_plan(84);
> > > >
> > > >       test_seal_addseal();
> > > >       test_seal_unmapped_start();
> > > > @@ -1889,9 +1830,6 @@ int main(void)
> > > >       test_seal_zero_length();
> > > >       test_seal_twice();
> > > >
> > > > -     test_seal_mprotect(false);
> > > > -     test_seal_mprotect(true);
> > > > -
> > > >       test_seal_start_mprotect(false);
> > > >       test_seal_start_mprotect(true);
> > > >
> > > > @@ -1904,9 +1842,6 @@ int main(void)
> > > >       test_seal_mprotect_unalign_len_variant_2(false);
> > > >       test_seal_mprotect_unalign_len_variant_2(true);
> > > >
> > > > -     test_seal_mprotect_two_vma(false);
> > > > -     test_seal_mprotect_two_vma(true);
> > > > -
> > > >       test_seal_mprotect_two_vma_with_split(false);
> > > >       test_seal_mprotect_two_vma_with_split(true);
> > > >
> > > > --
> > > > 2.47.1.613.gc27f4b7a9f-goog
> > > >

