Return-Path: <linux-kselftest+bounces-6758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC1F8900D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 14:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC34C1F22EFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F818287E;
	Thu, 28 Mar 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lEIgbMRr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gfh9gbKk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73D7F7DB;
	Thu, 28 Mar 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634118; cv=fail; b=UQluoulNHlkhCUy5RTtmPJCb8EcCrZqNu5246AgppQrimf0IavAgaC5byqC7SjuEOdvEjYybRjbH1oRJqahKPpPmrEv85QmkxhqRj47Ct8vVRuU39CohDOMKu8QMJsPUHP2HInjVQKrTZ144C59jANAfCi4/iYROF+PvGc9Nzu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634118; c=relaxed/simple;
	bh=KswD3hMV1mky21BbivyKpEowue//kXXn8Hqf8nr1IQU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lA/Iu05nEGekoJEFUys7FQ46LhkvWMNiFiybXrl3+BSPpWt/zGkGUzToQqyrdfNPke7xsLnI5zABkOA0lRGURxeekeRjJt2ad0CuPBtVosGaR59x1k8uMh9eJPpMv8VmSCZjcF1pLBMQk6tiEWB4MdWD4aVyidZNe3ECnH9mxwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lEIgbMRr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gfh9gbKk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SCfmw5012679;
	Thu, 28 Mar 2024 13:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OKl4LzmCLDWG56TdVJZpJ76+Vd77a1g/7Ai8XlqdYAM=;
 b=lEIgbMRrGX2olYBcdhDhasUVkiyK03dpon0Wu5QG+aFwFZe7M0R0SFHxTy4nK+YEbBJU
 vo8HfcRJO4ZR5hO5pLbkvThkAeXeTb4A7hI7KfdglFAjYMplLf62oKBXma4QDNjVo5za
 lhCEgdvKQkgTUk0hi2uZVqYXm/kiAlIJYp5Cj+zVc6bvIiGU7H9uI2xH6UKJLG4KobKk
 LfLw5MZ8m3KeyGYWIef14rmkKxL3pf0zcMamqER323W9woufDWOcEEfBxBdzTWioR7mw
 SBAElx2tZTsR/JRXF2tJGtefz7W+jMx04gdJ2FN64i/gecvJYXeVrZXM8PLRZ6cUpB58 zQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybsm87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 13:54:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42SDeif8008868;
	Thu, 28 Mar 2024 13:54:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhacxsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 13:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I48K3wC1Gc34QyXPEgqU3miUbBNHpWKHFFuFrTw4JYRk6mEzCLM9Z/ntrHrO3B6ybZw2vWu1K/bWgQrFHIixLT1frzJldx4msHYjzXpeazX0muBMk3byGb+ju2kQZ7F2Lb43nImK9WJ3oMl4oJ/pG7LCbfII3x5yc//dC1PNQEolv6quaFRHbSKwpNqFzw1N4qgvDF8VdUDLvWwCbum2+L4mEyDpyeItF5xgTS9nFgJBr7APTZPfPo5cYf7tXF+AAGxiBS8jzW4C9tv3R0Ovr4Vmbng4Ib2m1C0+YSaR51SHo/p/V9In9bzaYErDctb5ZNNNfn8b5FpqPkk6pJVjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKl4LzmCLDWG56TdVJZpJ76+Vd77a1g/7Ai8XlqdYAM=;
 b=ZF124WMCjuruA4pr/+NcqAAsAdqO/KtS8dh4ATgvz6ioc5E0qnjLLQVdWAqAxxE8FlqBQnUsj1ogg/SQwWwI1+R7mqXtMS0WXrJ1ffknc+F/QjNSgD4/D7Pdj4dQjnYdn3VnTbdGhg4qw/cw/CKg5hu0rAbaGo4r5UM2zdm9tNZEayfMJAcMzm2QI22sGbxntSwE9+Fi3em2iMUQt2mVor/6MD+0C3treJeL3O7ggMPV2U5Vwq2Gj+s5sXN7srtKxn3vYnnM5Xq8VTT0h0157zhVB+DR0lusAU50SHI7lev2eHCQBqeYXapISvYYUMyiG9mWY0xu3JvPeWVR33iBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKl4LzmCLDWG56TdVJZpJ76+Vd77a1g/7Ai8XlqdYAM=;
 b=Gfh9gbKkturyvDs36ZPnkANVlPBJG1JCQ9HeyexARJrHF96Ug10T0w3seTdMQE+f/Tu1Vzf+Vexeb8tMZwmhyv0vOBbvT58WxP4hrIsb/XLtNGEZT2YLevMkbS1viifqDnSMShPgY/PZFWod6rlWVqQ/GRy6AdQ3v4ThEJoWd1s=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS0PR10MB7201.namprd10.prod.outlook.com (2603:10b6:8:f2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Thu, 28 Mar 2024 13:54:51 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 13:54:51 +0000
Message-ID: <b6d884e9-f191-4ece-8d9e-51ee72d7b28f@oracle.com>
Date: Thu, 28 Mar 2024 13:54:45 +0000
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after a
 failed assert()
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
 <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
 <20240325135207.GC6245@nvidia.com>
 <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
 <08a13b79-e94a-4f80-96e9-ce223d928b3e@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <08a13b79-e94a-4f80-96e9-ce223d928b3e@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::23) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS0PR10MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 5817473e-3b59-4e66-ed10-08dc4f2ea396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OmUqnWBBsfR/S+BrZEGUZGeEaFqx/PTYCWOC8qt6/6DG58YCbda9w9HnyqoOLAExtB+QJcT1dMtOACfgJfXtKYd5avsvnhFk7Q3Kbn664IyQfvycqPawssOPshAJFU4VmfzIRV4TSGk9oqoR/ygxMmQTPU2OqXP8tgN2kVvw7vVRuqPoEPyl+JBaV4OQw26hH8d9Uozt3PyJg4kclq2yEiK33IMx3ft7l2wzXxkXlDqgaKat137UaB3F/QwzFWoGq8dPAptNnTSvxNT2O4q/2Wp7wl/VODAjnPuC+Kywc9rpODW5KDbDsIKlq89kZUMps5ARhs63IK4fqyFKbbGh6vLhe7N2Mc9hpNLS1Fbdt50h4oHhgp3INhQaRWWDotGH6Dy4yK5c3iFTCkXB8IZpA4bqnzK+yyFinAIBdDYIrOeSErcvpA9610IJSMHyQ7Flw2V5pK6VghonFfgq/ynYHM4ItMoVgngOk/4lX4uHRojlwgPGVPgWIUjxKQD6g4MyIkgqFtM1g2zWy59FRUSlJi0OlmYsrupSdEPv8EdqgQnNnLR0iBPw2UpxoqAMYhXaOXoM1v+rdzF0KZl7IiswwzcYP+aPPpvx6at6KpG6XrVjGrlqy1TZq8K35aFXB9YyOWNXkbfMd6/rpUybN/DNkjljfeOpqHXLBb3eTSGuke0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWVtWmxYeHNmKy8vVUVZMmlWLzVMbmhZb3g1c013K1ZFSlM2R3BPclJzM1Ur?=
 =?utf-8?B?ejVmY09JeitJb0NtNVhmamhTc2R5bTM3UGlZQTV3K0EyaWo5Zys0b09mY2h6?=
 =?utf-8?B?RVdlRTkwZGtkSmdUWUlRVG9tNEUrU3kvRWJ5emY4SEFmaENxaExicCsvY0pN?=
 =?utf-8?B?dTlxWTlFWHdOSjdhak4vRkQ1a204a1VkeFZwQjJDY3I0TFBqNlB4L1BENHRp?=
 =?utf-8?B?RlhGODNCREdLdk5XSG8rY3dkQlZabjdVUlk3ZHJpU0FpWG9zZnp3bmN3RU00?=
 =?utf-8?B?MzFTQkFNRXJUTEFMc3M2eDl3Ykw4b2tZRHF3SnVLRmYxd1ZIdEdzczd4SWpo?=
 =?utf-8?B?ZnlhdlRlMkRCSFZjWnBJam9qd1JQZUFYSnVKUmZESXJhQnZYSmZpV05CWlBz?=
 =?utf-8?B?dGhVM3JmZzdHTTNZQVVFdTZwWTgyeG9IR1MzMnlxcEtxN1RQYWtuV0x6aHV1?=
 =?utf-8?B?L0NtYXRBSEVwU3c2NE8vVXlEWGpEYzlVSXBhaVYrMDJGNCs2Wnc4UmJwUmsy?=
 =?utf-8?B?SktTR2tZOU5nWGRBSHhoa0ZVUTRiM1dESDhWSUQyUjdHeHNOK2VQT0xrR1Iz?=
 =?utf-8?B?RlFVZzJsait0QlpmL09ZOG9BSlFDdC9MUTAvUjNvTm1ZMXJMdFJUdUhoQjI4?=
 =?utf-8?B?QlpwaEpidUFIYlBVbE5sVjdDSU5Ub001UGtWN29HYUx5TE1FU1oxc1gwdTR0?=
 =?utf-8?B?M25IOGt1dGozajVUMG1PcXE3TDVnMHM4eUhNcHVvRGFzL3RkV2lsOXRDTHRC?=
 =?utf-8?B?VTBsY1VvbEdoK1cvUjU2UmQ2eW1Rc3c5Qmc1VzZuZldpb21xR3o3cjd0bTlZ?=
 =?utf-8?B?MEJmRXlVT2FyVlQ5Ky9tbFljeFZpVTBzcWFTUitoSFJ1cTAvYTY0QnRNTy9X?=
 =?utf-8?B?S0U1RjIvSVhQNmNxWVArTzlKeUIrVkdsL25URWpOZUdpaU9neWI1bWhROFoz?=
 =?utf-8?B?S2ZpTk55cERTa2p5bENIMEpEa3dGQXNnOTNUa28xK09MalBmaFlYVnVBb0cv?=
 =?utf-8?B?cjBua2t2L0ZyOFQwWGRNNEZjdGQwL3ZGZFZFK3lDdUdiUE0zeEZodUE4VGR2?=
 =?utf-8?B?Q1Z5VlRhR2t6bExzaHBSVVpOU01yYUZmVjk0dVE4cFFJWWc0eHlxUWdHcTRp?=
 =?utf-8?B?dDVvSzQwZjF4a1VoTXY3VEx0SWdRbmpKVHYyeENYRzFGaklKRHp1OHB0QTkx?=
 =?utf-8?B?d0hpNlRiTzhCdWU2anlTSUtaSE9iZGlSKzFVdzFtUEpXY3U0SjdEWFNjMnB1?=
 =?utf-8?B?MldWa0xoRzFoMTJJak9CZm5uS2c3dGhoY0pWOXZtbUpCSWpVWVR1ZEJXUkd6?=
 =?utf-8?B?R0RZTWViNWlhZ0txZXA2V044YTJNNzJwUzBtMk5QcTRGOVZ6V2krWm9zUjhK?=
 =?utf-8?B?OWlUZlZZSWpKTVpqa1lkdDFrNDZBUmlOdk9EVERvaFNkeUlZNzBFQUpvOVU0?=
 =?utf-8?B?anptbWlyZXkzUmtKeGp5M284Y1ZFMXRSeUxuYUtpWFI1Q0hUY1BrWXpKUTl0?=
 =?utf-8?B?MnB2SndNeWZDZlpxaVRuL1BkRUExY2VSN2VNdjlCdFkvTVdMTERkOVlvL1J0?=
 =?utf-8?B?Rmp0cFRJbGh6UXRQR1BhTm9mZEc1QzA0SGJhWlRrcml6S2FtY0VjNUNQaUVq?=
 =?utf-8?B?NElJTVJQcnliakhoblNxREdEYWlrblF1Ymhua2RzeEhtblBjcEtlWTdVVkNr?=
 =?utf-8?B?Mys3a1JaWE9uMk80Q0hsQWhOWUtUN21OeDZiRDR6VE9UUnp0bjAvNkR4V1Yv?=
 =?utf-8?B?U25HVm0zV3ozUFhVZHRTRG1TWVFkWTdZR2szU3dWdkhnS3BPQk90WEpNSW0v?=
 =?utf-8?B?RDhNQXMwRXFjSWc1eExHd29pOS92cm4xYU1HWUJKRHBSdUZHZkwxcDNvbmF4?=
 =?utf-8?B?YTd4cmFlQUthbVlnSVJaUDVBdURkUEF5Y2l5YyszQVpsUmRJTHQycmFQOGtn?=
 =?utf-8?B?ek5NY2RKbFNHZHhTaTF4K04wVGpiR0xNaEp4NllHU05uQnVEUHFXbnozRHVl?=
 =?utf-8?B?bUJZY1l6VWFrbzIvQ2l6OXljZFhDeXAzYkgwUy9mUmNDeC9yTG1ldWZEQkEy?=
 =?utf-8?B?a0IweU5iZEU2WEFPUVFFa3E1cWQ4cCtEQm9PZkxwSEJTajA1bEY1NWdGamta?=
 =?utf-8?B?TnBHOCtzMFoyWXJoNXRFSXphUlVrbGNTYStMalFZWVZGYi9iUlFjN0VLWk1J?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CIznLaTrqwgmUMVQ+bXvFghKRDGYkMcyVNslOkMmcMPKFPoZ0mvFhA+9j8np4z5ikv5XAFrSWLz8YS32WUnMEnZn9Wc6SAp+QtRV6aPS+U7Zf3KsX8Rcq0i6ufeBKBWW+1TUqOSoQM8JppUyfPZWdgnS+lvzmQBmHVf73AJV7oY7tkilz3OePWL10zHNWPuwANPWLZyzuOlJ/gPPSfIGVr6fMktmwYVMHUhWM355t5XaEncjaFm1S+MHsYAv9BHH1FHStccD/ONUhp8atXa76b+a6TTnMVEmKUtR9e0n9wjrLOaAGBSksQUr47CHtASfFzjhzkTtY3fcGAT2ncUMuaMMzA6rm0LeJ7f5RqKgHetwu10H4umveogmvK1yfr5QInF0FjDbn50PtM94/EsHeasMDPlwExd7kFuA4kh8M4o0h8cbPSQQU2JXyPi/dLqafz1Whu+9swyoq3uTLeVw6Phheg9l/oPTkfkdIEAqwnbOtwBWhSwImaE+R1VSKXPS8MOzHyqQqSIiGJxdIv56xac/hj9Wwy7vGpeYoBw/xz9q8R6O1wdfew8+tS2qmBODQbt1qHNGgAYOH8rnZzZZNlgLw8p008KrNm/6CAAXHOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5817473e-3b59-4e66-ed10-08dc4f2ea396
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 13:54:51.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0Fd9Vf8kPwTce5pBBAn3GwMsxIlzNkEhDw2xaoteex5Rny/ClNM+Pt1a/mFizCJT0/nQuoSjw+SR6seqnUNHMNr+yXLuLNX7N6e8JYvFKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_13,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280094
X-Proofpoint-GUID: sFLr_oqvA0eaGa4-GjOY8G3hhQ5tyJ53
X-Proofpoint-ORIG-GUID: sFLr_oqvA0eaGa4-GjOY8G3hhQ5tyJ53

On 27/03/2024 20:04, Mirsad Todorovac wrote:
> On 3/27/24 11:41, Joao Martins wrote:
>> On 25/03/2024 13:52, Jason Gunthorpe wrote:
>>> On Mon, Mar 25, 2024 at 12:17:28PM +0000, Joao Martins wrote:
>>>>> However, I am not smart enough to figure out why ...
>>>>>
>>>>> Apparently, from the source, mmap() fails to allocate pages on the desired
>>>>> address:
>>>>>
>>>>>    1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>>    1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
>>>>> PROT_WRITE,
>>>>>    1748                    mmap_flags, -1, 0);
>>>>> → 1749         assert(vrc == self->buffer);
>>>>>    1750
>>>>>
>>>>> But I am not that deep into the source to figure our what was intended and
>>>>> what
>>>>> went
>>>>> wrong :-/
>>>>
>>>> I can SKIP() the test rather assert() in here if it helps. Though there are
>>>> other tests that fail if no hugetlb pages are reserved.
>>>>
>>>> But I am not sure if this is problem here as the initial bug email had an
>>>> enterily different set of failures? Maybe all you need is an assert() and it
>>>> gets into this state?
>>>
>>> I feel like there is something wrong with the kselftest framework,
>>> there should be some way to fail the setup/teardown operations without
>>> triggering an infinite loop :(
>>
>> I am now wondering if the problem is the fact that we have an assert() in the
>> middle of FIXTURE_{TEST,SETUP} whereby we should be having ASSERT_TRUE() (or any
>> other kselftest macro that). The expect/assert macros from kselftest() don't do
>> asserts and it looks like we are failing mid tests in the assert().
>>
>> Maybe it is OK for setup_sizes(), but maybe not OK for the rest (i.e. during the
>> actual setup / tests). I can throw a patch there to see if this helps Mirsad.
> 
> Well, we are in the job of making the kernel better and as bug free as we can.
> 
> Maybe we should not delve too much into detail: is this a kernel bug, or the
> kselftest
> program bug?
> 

I think the latter thus far. See at the end.

> Some people already mentioned that I might have sysctl variable problems. I
> don't see
> what the mmap() HUGEPAGE allocation at fixed address was meant to prove?

That just sounds like the setup -- you need hugepages to run all iommufd tests.
Most of my comments is about what your first report email in this thread on the
selftest getting stuck at 99%

If the use of assert() within test/setup is the issue then snip below should fix
it. But if Jason is right it won't make a difference. I think this infinite loop
is __bail() where we are doing a longjmp() in a loop once a ASSERT*() fails but
it only happens if we use these ASSERT() functions. Maybe this is because in
some test functions we end up doing ASSERTs within ASSERTs?

--->8---

diff --git a/tools/testing/selftests/iommu/iommufd.c
b/tools/testing/selftests/iommu/iommufd.c
index edf1c99c9936..d2661a13a4f2 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -353,34 +353,34 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_err_hwpt_invalidate(ENOENT, parent_hwpt_id, inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
+		ASSERT_TRUE(!num_inv);

 		/* Check data_type by passing zero-length array */
 		num_inv = 0;
 		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
+		ASSERT_TRUE(!num_inv);

 		/* Negative test: Invalid data_type */
 		num_inv = 1;
 		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST_INVALID,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
+		ASSERT_TRUE(!num_inv);

 		/* Negative test: structure size sanity */
 		num_inv = 1;
 		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs) + 1, &num_inv);
-		assert(!num_inv);
+		ASSERT_TRUE(!num_inv);

 		num_inv = 1;
 		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 1, &num_inv);
-		assert(!num_inv);
+		ASSERT_TRUE(!num_inv);

 		/* Negative test: invalid flag is passed */
 		num_inv = 1;
@@ -388,7 +388,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_err_hwpt_invalidate(EOPNOTSUPP, nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
+		ASSERT_TRUE(!num_inv);

 		/* Negative test: invalid data_uptr when array is not empty */
 		num_inv = 1;
@@ -396,7 +396,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], NULL,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
+		ASSERT_TRUE(!num_inv);

 		/* Negative test: invalid entry_len when array is not empty */
 		num_inv = 1;
@@ -404,7 +404,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 0, &num_inv);
-		assert(!num_inv);
+		ASSERT_TRUE(!num_inv);

 		/* Negative test: invalid iotlb_id */
 		num_inv = 1;
@@ -413,7 +413,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
+		ASSERT_TRUE(!num_inv);

 		/*
 		 * Invalidate the 1st iotlb entry but fail the 2nd request
@@ -427,7 +427,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_err_hwpt_invalidate(EOPNOTSUPP, nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
+		ASSERT_TRUE(num_inv == 1);
 		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 0, 0);
 		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 1,
 					  IOMMU_TEST_IOTLB_DEFAULT);
@@ -448,7 +448,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
+		ASSERT_TRUE(num_inv == 1);
 		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 0, 0);
 		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 1,
 					  IOMMU_TEST_IOTLB_DEFAULT);
@@ -464,7 +464,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
+		ASSERT_TRUE(num_inv == 1);
 		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 0, 0);
 		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 1, 0);
 		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 2,
@@ -481,7 +481,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 2);
+		ASSERT_TRUE(num_inv == 2);
 		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[0], 0);

 		/* Invalidate all iotlb entries for nested_hwpt_id[1] and verify */
@@ -490,7 +490,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		test_cmd_hwpt_invalidate(nested_hwpt_id[1], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
+		ASSERT_TRUE(num_inv == 1);
 		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[1], 0);

 		/* Attach device to nested_hwpt_id[0] that then will be busy */
@@ -1743,10 +1743,14 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 		 */
 		mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
 	}
-	assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
+	ASSERT_TRUE((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
 	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
 		   mmap_flags, -1, 0);
-	assert(vrc == self->buffer);
+	if (vrc != self->buffer && variant->hugepages) {
+		SKIP(return, "Skipping buffer_size=%lu due to mmap() errno=%d",
+			   variant->buffer_size, errno);
+	}
+	ASSERT_TRUE(vrc == self->buffer);

 	self->page_size = MOCK_PAGE_SIZE;
 	self->bitmap_size =
@@ -1755,9 +1759,9 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	/* Provision with an extra (PAGE_SIZE) for the unaligned case */
 	rc = posix_memalign(&self->bitmap, PAGE_SIZE,
 			    self->bitmap_size + PAGE_SIZE);
-	assert(!rc);
-	assert(self->bitmap);
-	assert((uintptr_t)self->bitmap % PAGE_SIZE == 0);
+	ASSERT_TRUE(!rc);
+	ASSERT_TRUE(self->bitmap != NULL);
+	ASSERT_TRUE((uintptr_t)self->bitmap % PAGE_SIZE == 0);

 	test_ioctl_ioas_alloc(&self->ioas_id);
 	/* Enable 1M mock IOMMU hugepages */
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c
b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index f590417cd67a..4a88f9c28fe5 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -315,7 +315,8 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)

 	fail_nth_enable();

-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL,
+				  _metadata))
 		return -1;

 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -326,7 +327,8 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;

-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL,
+				  _metadata))
 		return -1;
 	return 0;
 }
@@ -350,13 +352,14 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;

-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL,
+				  _metadata))
 		return -1;

 	fail_nth_enable();

 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
-				  NULL))
+				  NULL, _metadata))
 		return -1;

 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -370,10 +373,11 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_destroy(self->fd, stdev_id2))
 		return -1;

-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL,
+				  _metadata))
 		return -1;
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
-				  NULL))
+				  NULL, _metadata))
 		return -1;
 	return 0;
 }
@@ -530,7 +534,8 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;

-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL,
+				  _metadata))
 		return -1;

 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
@@ -609,10 +614,11 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	fail_nth_enable();

 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL,
-				  &idev_id))
+				  &idev_id, _metadata))
 		return -1;

-	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info), NULL))
+	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info), NULL,
+				  _metadata))
 		return -1;

 	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, &hwpt_id,
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h
b/tools/testing/selftests/iommu/iommufd_utils.h
index 8d2b46b2114d..cd8bb14be658 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -64,7 +64,8 @@ static unsigned long PAGE_SIZE;
 	})

 static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
-				 __u32 *hwpt_id, __u32 *idev_id)
+				 __u32 *hwpt_id, __u32 *idev_id,
+				 struct __test_metadata *_metadata)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
@@ -79,7 +80,7 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id,
__u32 *stdev_id,
 		return ret;
 	if (stdev_id)
 		*stdev_id = cmd.mock_domain.out_stdev_id;
-	assert(cmd.id != 0);
+	ASSERT_TRUE(cmd.id != 0);
 	if (hwpt_id)
 		*hwpt_id = cmd.mock_domain.out_hwpt_id;
 	if (idev_id)
@@ -88,14 +89,16 @@ static int _test_cmd_mock_domain(int fd, unsigned int
ioas_id, __u32 *stdev_id,
 }
 #define test_cmd_mock_domain(ioas_id, stdev_id, hwpt_id, idev_id)       \
 	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, stdev_id, \
-					   hwpt_id, idev_id))
+					   hwpt_id, idev_id, _metadata))
 #define test_err_mock_domain(_errno, ioas_id, stdev_id, hwpt_id)      \
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
-						   stdev_id, hwpt_id, NULL))
+						   stdev_id, hwpt_id, NULL, \
+						   _metadata))

 static int _test_cmd_mock_domain_flags(int fd, unsigned int ioas_id,
 				       __u32 stdev_flags, __u32 *stdev_id,
-				       __u32 *hwpt_id, __u32 *idev_id)
+				       __u32 *hwpt_id, __u32 *idev_id,
+				       struct __test_metadata *_metadata)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
@@ -110,7 +113,7 @@ static int _test_cmd_mock_domain_flags(int fd, unsigned int
ioas_id,
 		return ret;
 	if (stdev_id)
 		*stdev_id = cmd.mock_domain_flags.out_stdev_id;
-	assert(cmd.id != 0);
+	ASSERT_TRUE(cmd.id != 0);
 	if (hwpt_id)
 		*hwpt_id = cmd.mock_domain_flags.out_hwpt_id;
 	if (idev_id)
@@ -119,11 +122,13 @@ static int _test_cmd_mock_domain_flags(int fd, unsigned
int ioas_id,
 }
 #define test_cmd_mock_domain_flags(ioas_id, flags, stdev_id, hwpt_id, idev_id) \
 	ASSERT_EQ(0, _test_cmd_mock_domain_flags(self->fd, ioas_id, flags,     \
-						 stdev_id, hwpt_id, idev_id))
+						 stdev_id, hwpt_id, idev_id,   \
+						 _metadata))
 #define test_err_mock_domain_flags(_errno, ioas_id, flags, stdev_id, hwpt_id) \
 	EXPECT_ERRNO(_errno,                                                  \
 		     _test_cmd_mock_domain_flags(self->fd, ioas_id, flags,    \
-						 stdev_id, hwpt_id, NULL))
+						 stdev_id, hwpt_id, NULL,     \
+			     			 _metadata))

 static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 					 __u32 *hwpt_id)
@@ -623,7 +628,8 @@ static void teardown_iommufd(int fd, struct __test_metadata
*_metadata)

 /* @data can be NULL */
 static int _test_cmd_get_hw_info(int fd, __u32 device_id, void *data,
-				 size_t data_len, uint32_t *capabilities)
+				 size_t data_len, uint32_t *capabilities,
+				 struct __test_metadata *_metadata)
 {
 	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
 	struct iommu_hw_info cmd = {
@@ -639,13 +645,13 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id,
void *data,
 	if (ret)
 		return ret;

-	assert(cmd.out_data_type == IOMMU_HW_INFO_TYPE_SELFTEST);
+	ASSERT_TRUE(cmd.out_data_type == IOMMU_HW_INFO_TYPE_SELFTEST);

 	/*
 	 * The struct iommu_test_hw_info should be the one defined
 	 * by the current kernel.
 	 */
-	assert(cmd.data_len == sizeof(struct iommu_test_hw_info));
+	ASSERT_TRUE(cmd.data_len == sizeof(struct iommu_test_hw_info));

 	/*
 	 * Trailing bytes should be 0 if user buffer is larger than
@@ -656,16 +662,16 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id,
void *data,
 		int idx = 0;

 		while (idx < data_len - cmd.data_len) {
-			assert(!*(ptr + idx));
+			ASSERT_TRUE(!*(ptr + idx));
 			idx++;
 		}
 	}

 	if (info) {
 		if (data_len >= offsetofend(struct iommu_test_hw_info, test_reg))
-			assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
+			ASSERT_TRUE(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
 		if (data_len >= offsetofend(struct iommu_test_hw_info, flags))
-			assert(!info->flags);
+			ASSERT_TRUE(!info->flags);
 	}

 	if (capabilities)
@@ -674,13 +680,14 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id,
void *data,
 	return 0;
 }

-#define test_cmd_get_hw_info(device_id, data, data_len)               \
+#define test_cmd_get_hw_info(device_id, data, data_len)     \
 	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, data, \
-					   data_len, NULL))
+					   data_len, NULL, _metadata))

-#define test_err_get_hw_info(_errno, device_id, data, data_len)               \
+#define test_err_get_hw_info(_errno, device_id, data, data_len)     \
 	EXPECT_ERRNO(_errno, _test_cmd_get_hw_info(self->fd, device_id, data, \
-						   data_len, NULL))
+						   data_len, NULL, _metadata))

 #define test_cmd_get_hw_capabilities(device_id, caps, mask) \
-	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, NULL, 0, &caps))
+	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, NULL, 0, \
+					   &caps, _metadata))

