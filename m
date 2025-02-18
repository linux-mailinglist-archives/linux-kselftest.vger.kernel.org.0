Return-Path: <linux-kselftest+bounces-26872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B50A3A31B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F431731C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171626F46B;
	Tue, 18 Feb 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdSBBiO1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xs8mJMSq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077F24336D;
	Tue, 18 Feb 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897059; cv=fail; b=gviusrZqntrBP/qHOhOVgnaSqp9T5sRCqO+0Rc4NrRn7S4qYB+/vLWTTqmB3BygkCOAB7pNELOEpV5SCwrluFiSUfvQxEQQWm2jUiuNZvf6WmUEgXXoIkRjDzRoH0Ow7Fy6BaSYBsGsRyyNWeU4uV+b4y69ZktMRPaGi72rMT6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897059; c=relaxed/simple;
	bh=q2Yfo0RFmtw4O4fdMVdi2IQMZ+0AdwT8s2ZGTF/9FhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y641J4MxaUiU0FF+/CkZWBYflr50UUej23iO10lc+M3WcMgY47bo3ecAYxhHFCAc8PO8+6WrSDmu6aw9T8rhQkcGXsWJJjsXYFZyGCWXfxaGptLxk2DFMqmPzUPOj2fRNR0qQQkx+lRP2tYhER1ZgRfa8S4o87FrpWcINOHnHgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WdSBBiO1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xs8mJMSq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGMYOB010336;
	Tue, 18 Feb 2025 16:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pXdTRremb+BSGiDNjU
	9teXf3saAWStgCnbAiFLIYGUU=; b=WdSBBiO1aFc29xhBtn9Y6R5o4FPF2jceOO
	X18A2aU5boimFKEPuMCjAuFPj3g18YzdrfyEDzlt49gyNbnPYs7LzN1GdfypqosS
	1SOoB0e9QUqYz5BYmze9fWt7NczQmsxSjzccXB0KHoe2eIQO1ZoieQXXrC2JvulI
	G6sOXq/KJ4eYI5JPe5159/MAMkeUwzc5ZnGSFSaoBFpQo2bDPA0hgtou8n0N8WCm
	grA7YLcseNJJcAeKDc+jKDnSSJh45afThymDxKEv2LISG6tF/X5KcJWGEfMQOY/H
	A9lwV7bqYVzLHusn9VOMJ/1J97ipP7BFyvfCFRqggCBn73ENJdwg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjhsf113-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:43:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IFo0CR036687;
	Tue, 18 Feb 2025 16:43:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc994yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxcNGWaKX17Lq0s2QvwhGn1lH74WyUFMVMTx79kanmI4hIEbek7Vm80AOgjXS6yon43KFCWpVQkVI8no02qbvSX2O4vkTRRRmsZtZVDCK7IiqJMQWEqvTD9z+Nq6audXyOstdgoplQgjwTIp27FqPjzDk6dlFmN22DD7nbO6aJpR7GaPOQ+ktIHdl45ogPK+hzInmnjC2CQjulr1orzF+yuJRJqW05zI/Rf1RU6uHGJyuOOXTPCuZrmS3S1POBbNl3rl21tAm/MLrcHWQadUa0Q4itV/FZLBN6W+VjkjivWLdS1PAVW1G4VzHh2yKcQW2Ji5eC3zAGFMEQxoEUM36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXdTRremb+BSGiDNjU9teXf3saAWStgCnbAiFLIYGUU=;
 b=pOvoBnL7VX1OPEh1SmOO//ZMGCmp+/CuQjh5N0WvSXZiNbFzQLaTtOetPrd084QYPXzgpoyRay6lvRkFlaEAOfIjni/YmVwGfCnGAMFOn3+1C+TGdj7+oAte+uHeisgJqne/G+A5kE9nfTH0fv6xjDldayDy2k5kT7VPYOcuO4V1+kAcc9nNC7EGyfAf3d/r+butmW3cLi3Amjjq9KPP2SRN/PmhMv9O3/YXBkR2oEsnx5U8/L5lm8KbVexI7Mx15CPxXEwvkGvvWdSVNC1LJQHR9xBQ/3ewM/UjhMzSQ83gQ/2lDC/dekmeACYfhb95DSSdaJfg7JgoyaiT2rShog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXdTRremb+BSGiDNjU9teXf3saAWStgCnbAiFLIYGUU=;
 b=xs8mJMSqv4VDT/QDaVFAnxfbHfnQVellltLU/2fDcCMFFP5EIXLRHJaNsjcVSdpeoyxS/RC2diXDRkPLHZSobgvt6rjwugAPe2FZqHz+gU/Z3F4ETW8OwTFvFp+1DfscPbbGmZOr5JIR4t7Av3m9OjMsvyz8/Mnnei+cG6gMrOw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:43:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:43:49 +0000
Date: Tue, 18 Feb 2025 16:43:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
X-ClientProxiedBy: LO4P265CA0232.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 801bf217-9838-4732-09c6-08dd503b6b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aqy5lOiWfGFn7b4ZQHNfkrUHKRG18SrAAod8fIWQ6qpDXGMMf4CKG4L8lIaP?=
 =?us-ascii?Q?4nvuz0HN5Q3PwBlVYA6dYwvUH4wU89oOlBsD+e9vTkvPHvWRr9SimXKOjQr1?=
 =?us-ascii?Q?Va+ODKFgLC9Pf0PNO1ky1AgNjkbyWDvTo3PySPBILNVo13nnUZucGRYI0NWh?=
 =?us-ascii?Q?WxXTiDa0owJZxgsrV6HSS//xyLPXtIE0l8cCJRyBnSxrOnN4L7cVMSnX0gRn?=
 =?us-ascii?Q?vhhGH+pWCjwgn+hbHFRXXHkvdY2FXCJQfLGIDf5EH6hFTQ+oWisvYjy/uvji?=
 =?us-ascii?Q?RnMbWueQAMfR5ildWc1grrZHXD4DMGrICJmcL0I6H3uuDELzeCXoMu7WR+Yo?=
 =?us-ascii?Q?+mdNavvqnXl1qvqUbPlJlRpq9QlOA3+gE3+ONHAbmj/9hxZCViftiu3A1zVk?=
 =?us-ascii?Q?4lGE8BgRnQAfYAijuDF/uM81jFzCCfLltEjh40efuVt/YnURhq+VvD/baSNL?=
 =?us-ascii?Q?vfE90bmEMpsNjRwp9hBgtlIHs9q7w0CIjWDSgdF2llzv5fRXgUft1pAhXNof?=
 =?us-ascii?Q?N5OnW4dJ070MEzc8nHtbBlhCBw47CxT5FawcpGW9pWPtN23in/v1G+ss5W3I?=
 =?us-ascii?Q?P9aQrZjkTYftYaVdKSh/JeqtVRiSU8wCMmsyYQgLtqMfN4zwPaQ7tj8jiElE?=
 =?us-ascii?Q?cuAl85Y6GF8hSpb+wXb0RuoSoc5/cuUv8x4j54sKE58oxmEdsWPiFouYDc6a?=
 =?us-ascii?Q?L5Vaj5mzWhuU4zlXe8+9C4Npn3CnzmmD07l0A5OFhx7Y3LRPp9psXw4HHXfS?=
 =?us-ascii?Q?mPMg5Xo8q8/83zgdmO+TNSUvXEuGVKrOLJO8TG7LPtMnF0mFNc6pv0URi3Ql?=
 =?us-ascii?Q?orf1s43Eex6hCARWfjMRFtGrWZ2yPJ9yv+A1OJppjPj+PPsdfxqkVGJR8I5i?=
 =?us-ascii?Q?1nFJp61Ml7iEHmG/tpBXYoXn5O1b7e4tQEVm00zbRuegvHeUErkzMkPzw6eh?=
 =?us-ascii?Q?eshaRb3fLISrP5b8k732ircZ63mnt1rSOZKyqBgOB13O6+gvkRX/o5rzoyqV?=
 =?us-ascii?Q?rYFjtMBivYIQZX7g1ZUN+iKD035h/xEmCq4dUCwSkN2mcmlVSDg4Dz6tkfsw?=
 =?us-ascii?Q?/vLPSMBArq5nYDTwL/OtNORbMrQYYPSOh0+bmktgTlls+c7I1yuVGcl5XvZa?=
 =?us-ascii?Q?cBmqM4ggRdjYYF05WLo5laMmIMtmBrZ2MznTWT+QN4FaUfr9WOqniEhxdVxE?=
 =?us-ascii?Q?CaGR5SEan5IBTkO4dvHVHWve+hRpflIBSxjonI7kTP6HUpnzR5tFV6e5DNaK?=
 =?us-ascii?Q?ElKa8+lxetB1rQOmb7Ih+OxL5sJkDzhw1a3xpi5Q+s6pBi2eWsYQdW8nfqkp?=
 =?us-ascii?Q?NoHHIHdeZ/PtY+2UOEFMMBKnjal/ZCXNNTuaQsd751yVM/+FpklMJvuSq8Cw?=
 =?us-ascii?Q?w8MSKG8eoabmBSBHd1oHkXK8/wEs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WuE5VE3sLJ5nvl0EbCpELLttBceha6I4eK+XcvdMoZDa9LqFODQGdrsX2NNk?=
 =?us-ascii?Q?p4sYYYB2drZuOc+M0xI1Qnz3obKdJzz4vMwVxH2lWHyMt374w3NtmeAMnYIr?=
 =?us-ascii?Q?GPenTuM3AFMae5gxIeqYHZvGQXzHFdi/ZAx9lqHsaqwrq7d+fU6FmwqJdCde?=
 =?us-ascii?Q?k/1P0JYYnjMBkTt38F35f4zDDEw3a6NYN+ZrckuVwNNC3V5mIqGrh8TLa3uo?=
 =?us-ascii?Q?iaIJTSdO3sdjnVznKuC5y8JnBjk4YfeDuiCSteX4pKgynUXnHOPgKOOkw5Fe?=
 =?us-ascii?Q?kqEX0dkyR9747QVDwvs9VQTSxlYQ4k3rJWZ16XdTs18+5Nv5+e+T4lTXSzBP?=
 =?us-ascii?Q?22bppObeiCMUOg9c7WJ+kSNTUjI1L8K/KxsU7plUdvxI6usAH6pgZGLMV2b1?=
 =?us-ascii?Q?BIaYe9ekUvFwWJEGCglQU9AIH7z4sLggDS3dyJn/mKW/5SP076xVoXAqkWbi?=
 =?us-ascii?Q?tswFUmdA3+MXz+sgQRN0n1SC7o6nzdWJWM8RR/Cp6/r1b/CS51wgRZP5z7ll?=
 =?us-ascii?Q?/c0E2/kpFw+bFFbglpx++bmZ9eNMn6RE8WfEl315Nov3+GBUwnDxu4HJ7bO9?=
 =?us-ascii?Q?nTNvODhQugELvhVnyWRKvYzsb1/xniAQ+fYSwPIAYybNYil3TDLRF8/FIynq?=
 =?us-ascii?Q?vGilbID6yxBradqx3zpWZxOoJ+bUZCqFTRPx7DrgAOLGMIYXAHfum8u0rHsU?=
 =?us-ascii?Q?vpTiat52KYdn4koI2RGPiAmlj72ifUlsUJDYr2W6MP2NvXStkGMbtr/dzLMr?=
 =?us-ascii?Q?TjXE7ynR1t+4jW9gMyWjBV8+1c3mJl7bOgA8tI9Qxts3xVqEzSJ4GAQgnL3r?=
 =?us-ascii?Q?NHvv/CvlEFf1iJVywB3tSgoPcvWmKiocw8y+jtEYReNREWez8Iv8fTeQ0cdn?=
 =?us-ascii?Q?Al4VJguxaTqVBWK9iGwNw8SHAaz34S7Bdp5UEO0XU182UIW/eRDlUcHlurEZ?=
 =?us-ascii?Q?jqC+6voQutbNHm9v0XM3zrfw2ruImlN+rHPC3bdUoj9e6u61435QhHja74Lg?=
 =?us-ascii?Q?SkCP8MR9p+XlydrPtgQAPQpy7R2OvRr+LtJ+AcuvZBs5r+GSwdSxxJYprxAp?=
 =?us-ascii?Q?uYZGdmJc9TY3ZeVhb7g112KLIu2ATV8a743Fe+rU2ebLkF3/okxy7wc2zVW8?=
 =?us-ascii?Q?szUyq9FsL7N5Hni7ov8hVTfHepw5HoVxsmYBVBrptsfO17gGUniQtofeFkfL?=
 =?us-ascii?Q?vTgsBPXAieJF8HnozPhtwTBnfb+IaWDF9M0M5rafdH2ctf3Lsq5LDOcPANk0?=
 =?us-ascii?Q?NXT3m/dIRHRC/V5NBRDY/b4T+DCkTY1mv4nBw9TBoV1at5+QDpcYgrCM75yK?=
 =?us-ascii?Q?S1witv2rKcCShLYTiqzJHJOhvtaL/azCV+Tn+9aCyI2Mpmc5fziDcSgxC1TH?=
 =?us-ascii?Q?xgiXLwx7QIRC/HlQz67nO6QM0/bzjyQCe3NZF2stNjiGvhnxNI4mVNt+G4aZ?=
 =?us-ascii?Q?KLDT+Ikm92pxof9e72ZeEZTwdXfb+0JofCpire+w+MIREfATFwcgTdbmPMkj?=
 =?us-ascii?Q?ZQ3Nlzsjn+anZaCAYhYuh+QD7oCm2F6rMflqUWb9ku5q3khLyVsL9wLa2Yj0?=
 =?us-ascii?Q?QHM6qb67M8Yvg1q66keaSoZ7y3zghW7uFVVr9Jzxo1d3yJJgc/T6FR6ktIcZ?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	97JRN41LImXwxnWGu4nw+LuX45CONw6yOkodtRzNTWZJ6L9262K9yHGCa6jc2mtJFcUJyvM2Sz1ZlhaZSu/l/hRJlT1DdaEaJVsIsWO5Zpq01MDVk8X/3HIe8rPKa6mcugXcCg2upBubFpg9tLQmVclu8Ypko5p2DJtd0GeVaNYuUNNHJEPFSH8ZkhkNmghjCz49xXYymrrfI3bNGTSVU8SVb23u7pUfPTPsTgrTzqTrQ1huTz04LUQMzp8nUgxh7u39fbijzw3J1lLK0R8njkcBaEhZdfzvuhJGBk8JlUZu+Bq1JqdU+Y3eywkA3bzWZjwdIB1Va8Oo2hjg7rkM19taaZQkgd84hKiuGQyJ/ZNxogQ0bfus8D8DIO7CD5kfx4KObW8vCCPpqneRSLMIrUAG/6G8w23VkE8SaZryGcOEcSSnYL4qTSy6BR2hkGlPWOErxl2Xq01h2MYhFxPiSohzmopp3ZlGvsrxaMsKqXMAgjrrainje9a+TumBFjl/1njtOn3fNyzB48sZ+tAwqw/146eUgRG5TwHwBx2IqPikXpUkuTaPThHsRQS2x3DYYeBFP0wCpJCccYyPFzn3dgvLlJEAn37tl9BR8yZ+zn0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801bf217-9838-4732-09c6-08dd503b6b77
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:43:49.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTzJ9XUKWX0aifeUyKXJcZzR6XZ5lnIHTSte99UDrweH3i1eI/ksda3RoN9tIPXFiI6NhBmCkxEjZZ1wX4ROPN/eaHpIK5VNiL0z8U8e3Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180120
X-Proofpoint-GUID: k_bhFq9vmiVi5g8v2XGg6wTONbKKDohz
X-Proofpoint-ORIG-GUID: k_bhFq9vmiVi5g8v2XGg6wTONbKKDohz

On Tue, Feb 18, 2025 at 04:20:18PM +0100, David Hildenbrand wrote:
> > Right yeah that'd be super weird. And I don't want to add that logic.
> >
> > > Also not sure what happens if one does an mlock()/mlockall() after
> > > already installing PTE markers.
> >
> > The existing logic already handles non-present cases by skipping them, in
> > mlock_pte_range():
> >
> > 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
> > 		ptent = ptep_get(pte);
> > 		if (!pte_present(ptent))
> > 			continue;
> >
> > 		...
> > 	}
>
> I *think* that code only updates already-mapped folios, to properly call
> mlock_folio()/munlock_folio().

Guard regions _are_ 'already mapped' :) so it leaves them in place.

do_mlock() -> apply_vma_lock_flags() -> mlock_fixup() -> mlock_vma_pages_range()
implies this will be invoked.

>
> It is not the code that populates pages on mlock()/mlockall(). I think all
> that goes via mm_populate()/__mm_populate(), where "ordinary GUP" should
> apply.

OK I want to correct what I said earlier.

Installing a guard region then attempting mlock() will result in an error. The
populate will -EFAULT and stop at the guard region, which causes mlock() to
error out.

This is a partial failure, so the VMA is split and has VM_LOCKED applied, but
the populate halts at the guard region.

This is ok as per previous discussion on aggregate operation failure, there can
be no expectation of 'unwinding' of partially successful operations that form
part of a requested aggregate one.

However, given there's stuff to clean up, and on error a user _may_ wish to then
remove guard regions and try again, I guess there's no harm in keeping the code
as it is where we allow MADV_GUARD_REMOVE even if VM_LOCKED is in place.

>
> See populate_vma_page_range(), especially also the VM_LOCKONFAULT handling.

Yeah that code is horrible, you just reminded me of it... 'rightly or wrongly'
yeah wrongly, very wrongly...

>
> >
> > Which covers off guard regions. Removing the guard regions after this will
> > leave you in a weird situation where these entries will be zapped... maybe
> > we need a patch to make MADV_GUARD_REMOVE check VM_LOCKED and in this case
> > also populate?
>
> Maybe? Or we say that it behaves like MADV_DONTNEED_LOCKED.

See above, no we should not :P this is only good for cleanup after mlock()
failure, although no sane program should really be trying to do this, a sane
program would give up here (and it's a _programmatic error_ to try to mlock() a
range with guard regions).

>
> >
> > Actually I think the simpler option is to just disallow MADV_GUARD_REMOVE
> > if you since locked the range? The code currently allows this on the
> > proviso that 'you aren't zapping locked mappings' but leaves the VMA in a
> > state such that some entries would not be locked.
> >
> > It'd be pretty weird to lock guard regions like this.
> >
> > Having said all that, given what you say below, maybe it's not an issue
> > after all?...
> >
> > >
> > > __mm_populate() would skip whole VMAs in case populate_vma_page_range()
> > > fails. And I would assume populate_vma_page_range() fails on the first
> > > guard when it triggers a page fault.
> > >
> > > OTOH, supporting the mlock-on-fault thingy should be easy. That's precisely where
> > > MADV_DONTNEED_LOCKED originates from:
> > >
> > > commit 9457056ac426e5ed0671356509c8dcce69f8dee0
> > > Author: Johannes Weiner <hannes@cmpxchg.org>
> > > Date:   Thu Mar 24 18:14:12 2022 -0700
> > >
> > >      mm: madvise: MADV_DONTNEED_LOCKED
> > >      MADV_DONTNEED historically rejects mlocked ranges, but with MLOCK_ONFAULT
> > >      and MCL_ONFAULT allowing to mlock without populating, there are valid use
> > >      cases for depopulating locked ranges as well.
> >
> > ...Hm this seems to imply the current guard remove stuff isn't quite so
> > bad, so maybe the assumption that VM_LOCKED implies 'everything is
> > populated' isn't quite as stringent then.
>
> Right, with MCL_ONFAULT at least. Without MCL_ONFAULT, the assumption is
> that everything is populated (unless, apparently one uses
> MADV_DONTNEED_LOCKED or population failed, maybe).
>
> VM_LOCKONFAULT seems to be the sane case. I wonder why MADV_DONTNEED_LOCKED
> didn't explicitly check for that one ... maybe there is a history to that.

Yeah weird.

>
> >
> > The restriction is as simple as:
> >
> > 		if (behavior != MADV_DONTNEED_LOCKED)
> > 			forbidden |= VM_LOCKED;
> >
> > >
> > >
> > > Adding support for that would be indeed nice.
> >
> > I mean it's sort of maybe understandable why you'd want to MADV_DONTNEED
> > locked ranges, but I really don't understand why you'd want to add guard
> > regions to mlock()'ed regions?
>
> Somme apps use mlockall(), and it might be nice to just be able to use guard
> pages as if "Nothing happened".

Sadly I think not given above :P

>
> E.g., QEMU has the option to use mlockall().
>
> >
> > Then again we're currently asymmetric as you can add them _before_
> > mlock()'ing...
>
> Right.
>
> --
> Cheers,
>
> David / dhildenb
>

I think the _LOCKED idea is therefore kaput, because it just won't work
properly because populating guard regions fails.

It fails because it tries to 'touch' the memory, but 'touching' guard
region memory causes a segfault. This kind of breaks the idea of
mlock()'ing guard regions.

I think adding workarounds to make this possible in any way is not really
worth it (and would probably be pretty gross).

We already document that 'mlock()ing lightweight guard regions will fail'
as per man page so this is all in line with that.

