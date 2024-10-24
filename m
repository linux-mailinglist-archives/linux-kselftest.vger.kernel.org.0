Return-Path: <linux-kselftest+bounces-20550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A739AEA71
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 17:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AEE1C22EFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D31EC01F;
	Thu, 24 Oct 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hEpO0suO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T6ndNo4x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0309F1E7668
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783727; cv=fail; b=Z/ktaeoFYSwh7xLs0CFCt2B19Jf1VgX348u0QfMPmhu59qZthN5PuB721lAF/7nmJcNV342db/nXoo8napU+owWf18w22MTuAuCN+UaiwrDcQfKFC6bViwZnWs36h/euuVciTo9cwcG0MPBBaxlPQOS/MJI6qaeJcnIwCJ6/rnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783727; c=relaxed/simple;
	bh=hTks9CVURXkB8jXwED8SKz3Q58iM0yRdd8x/JFmoChU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uwftaQAyE18oCuHpGmM2eawHpkaI0SZsBxbGPyorPtYQnwS9qqFS0aTsNAU3roTTu3Lbuyy3cfhtHVlW4W3V8hmfGYRtWaKM+Cr/KMfjA1/p9BgCznJnzL1Rw/cmfU2Q4G1I7ELoK4h4HuXXj+6kWASehIFVkP+XrK+ne/bpbJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hEpO0suO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T6ndNo4x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC25w0031256;
	Thu, 24 Oct 2024 15:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lUTvEVqDo39JFp2g+kd8Oy+RFHM7LmtjmOCEyBN8iEA=; b=
	hEpO0suO/zDunU1a3/vXI2PjwRBtBdLYPkbBE/Khwi4ZZegn2tOwY8FqG8cUX3SV
	dYZ5nAH3hCTZUE+Svl1QuyCw3r3S2Puy7OmaeqQPreGHFPkMonAIBXuEGh++s+qa
	isyW5tz6NyRkcRUKBkXwyafI1uEktrIx6I4MMNUbZycZGp9/ZG4BCMDWDMqkrO5b
	G9BQWk9GY7txnbh5//cO/jY3oEt+HuZgMYOSZUuE9DHLhKjBbHEv0XUpHPhJkRC2
	MjhMvjqGV5Hk5/Z/gKXaoMUXinTt8sG1xfTn1/RtiTjIuHUpDel2o6cTgCYXiFzu
	cUrrZfquwOgTRWap+VAmSQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qjy56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:28:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OEjTBe036243;
	Thu, 24 Oct 2024 15:28:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh4463f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGdNxi4lRjKMnRxs3E8J9YKW7SDbeCATAwbdu1+pnc54XYtsuW4VplUmREg7p0WzQlG+YUNHnQnEFRvP75gfhbZqqgbH8mS17so3wslDLJ71vunrtCKW7wx8mBYQYm6h2bhuI/aQards7ZzQ1fs8Rf+Rzj7erk2Jxzte/D0Cod+PC3nIaIxXMatejuUdytcPCnvj8Q9OJCHFSlJSR6cAlK4088S1qPuVV5VsBWSctphaUJpt4Ntgby9kU0QuxFzJmS/HIMKOdt8dGa0cBzsrq0I/kJSckh6pE0X1wJVf4ZVcdK1zK/yAZKQDUSXwDDYR1C/79w7rUY2/ry93OqZNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUTvEVqDo39JFp2g+kd8Oy+RFHM7LmtjmOCEyBN8iEA=;
 b=g2ZlrF8vLCW2rYlHJfXahMf2BgBXpTrHci7NL5NXjnfOPOhC2I0zwKfcUBzcY7g2+a1Rn9ayXcqxkhXtOJD0DpyptK+EJ6DBNU/PR7DVow3Cmd+kKXH/q/LSPBusya4B26njwau6PVfrUWZE1KzvDjg35dA6t0IudU4ASW/RHHZWp2mug3voMSY09ZuJejbCk1wZfcU3uz/41cbVK4Bd8setf5+i1bpMWBVei+qz9kBW5hi6tgh39dAA86RDTeJUStMwi1xffwfc+kFO3s+vMhYWbcowaq4GCMj44UATe/cRImjnAwOBqt8tIvZfkXD3Hg7MgkjB7uS9BYQ6giWgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUTvEVqDo39JFp2g+kd8Oy+RFHM7LmtjmOCEyBN8iEA=;
 b=T6ndNo4xMinDM/vO9DT+hZm/0LWpEt3uSPXsll5Nq+h1/vnf6Fe3q2lvitLsKARthq4toeL4CqZwNwKat6+fpFXMAjbS9YdDXdArs3ohwW59NqH7yx0BspwrfI+VGPnooIDpQSceeCIwYIcRIvCdQNLkPuHSaGyfooWE01JsfqM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6402.namprd10.prod.outlook.com (2603:10b6:510:1ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 15:28:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 15:28:32 +0000
Message-ID: <a835a627-14ca-4258-96d0-406888c74784@oracle.com>
Date: Thu, 24 Oct 2024 11:28:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 9/9] iommufd: map file selftest
To: linux-kselftest@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev
References: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
 <1729783554-56916-10-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1729783554-56916-10-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2b1083-1e60-4967-6b36-08dcf440847b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0Rzb1lrcVFvcDlHS0VtSmtvcTRaODEvTTYySlRubjJGRTNQR0RDSEF2Vmtp?=
 =?utf-8?B?TXBWa0hwb1ZEeDhBajVXVDVmcFVCbmlCcCtCT0ZqSXROKzBaMVlNVWQrV0N5?=
 =?utf-8?B?MGFPRitiMU04c25CTTdwdmIzWDNNMkczQytzeUtlWkU2VkNtY0FSbGtxczJi?=
 =?utf-8?B?bjZsWHovaXhyV3NsMkZDMFdLMVllcjFGNnFOdWlTcFZNSkM3a05BdlhZVlJC?=
 =?utf-8?B?TFQ0VHRocE1NQmJldEtCeWtEb0h6T2hZN3RqY2dnc2xQYk9hbGZuQlE1SE9h?=
 =?utf-8?B?dnYvcTZ4emdIb2dMR0FVdVpEc1l0bXl3L2dDdkQvQ2kyZWZrajJMaUdtQyt2?=
 =?utf-8?B?MGZtY1JvM0VlYkxWTFNzTHRqTVplNTdFR3I4bWdrd1ZzVkVRWTNkRVZmYlZv?=
 =?utf-8?B?dmk5SkJoRWFndmE0ZVFLWStwRVJOTklJTmdIbUZraTdPRENPMHh0NXNaME1L?=
 =?utf-8?B?WGEzc1h3T2gweHdWNWM4c2twM0hQQVFFeU53MUxWWlJWRUYzckF6N0FOOHpu?=
 =?utf-8?B?bmdZN0lOK0NXZlpWTGFaQVVvbklvcnY1bU03dGpoanBaRWJQM29hVXQ5TUwy?=
 =?utf-8?B?UDQ0NEsyMjlrTkJZQWorSkttMnRKUG5TdXRkMEhSYVN2S0J0ZlV3TGxmVGo3?=
 =?utf-8?B?YXJuRlVKd1RYakR1ZUtSbUJmWTB2eFBtN0lXRk9oUmFRaDhEL3UySVJYM0xS?=
 =?utf-8?B?cVV4ajBIb3gvTHY3ck96eGFLbEZrVmhadTZNWnBqNmt1d2pmc0FEU3YvS3RH?=
 =?utf-8?B?Qy9Ic3BPMWtTQlFXbGZzRitCNWpvaW1PTVhpa04ybU5uZHl0VU5wUEV1Uzk5?=
 =?utf-8?B?ZEUyc1hEa05iWW5UY3p2OUxyNkVkTEFVTG5GdWZ3QjZOTHBCZElMdzFrWnZx?=
 =?utf-8?B?bFU3QjhXS3NiUkJKcGhUZ2oyZElwZnR3NkZ6b2kybzVQbVpaL1RFRzlUWG9T?=
 =?utf-8?B?Q25zbGdZVFJ6UlY0SFgyZ2JJc3laZnhBSjZxc1ptWnVpUWdJOFlGWHprcVZv?=
 =?utf-8?B?Qk42aytJdEl2aWljZm5MSzJ4dWo0N1NSZVlhcEx5eEhQZ3JRbkU1SmxaM2N3?=
 =?utf-8?B?U0EwMVFFeUJOWWtGdWE0dmVxeGhjY2V0dGxFUWFoYkErazlBaTNnSGZyY2Ra?=
 =?utf-8?B?d1hsdXA0a1VCQnZMMXNnRXJ0Zi9jSC9nNUJtQXVFazlVQUR4T3MrcEZrb25F?=
 =?utf-8?B?OTVsMzE4Zm9lcFh6b1VDb2drMS9iL05BclVHWG96WFZDbCs1NWpjV2xiUVVM?=
 =?utf-8?B?VmtCTHk2NTZJcDU5cGl3WGtCcmRGT2lzcHBCZ0V5TnllMkZpZkJlSWowQ3RS?=
 =?utf-8?B?SWxOTHJrRGNvTkZ0cVlyeTl3akJiYVQyYUdtRjNoVnhQREhKdUJobk9WRmZN?=
 =?utf-8?B?QnJVaGVlWnlYbTl4V0JUbTRid3BZNFgrUVpSRjVsTHJ1a3R1NlZBd3RnM2Fs?=
 =?utf-8?B?cGswQUtqT3BJTXJzT3NWTk5ndzM3cmZiNDZmQm9PMUhzbDJTUzMwV29CK1Uz?=
 =?utf-8?B?YTZwQkgxaFc0NjlKRzNuWWR5YmVLVGlKODVid3AzdXM3dEZ1eUhaaVZESVlm?=
 =?utf-8?B?R1oxZ0dQZGhpZ01Fd0dObElad3VoNDMzVFVOYnUyT0RtdkFnc2NRRzlCa2ZS?=
 =?utf-8?B?SjU5Z1dWa3lFZ0kxYXJzbWNXN2pyNzhqQ3VLTFdGVDNiQ3dWSjk2OHhsVnJS?=
 =?utf-8?B?ZGM3L1lpckR5VXdqK0lJL0Z2WllYNVJjcTBGeUE0L2VaK29LWld4bC9uemN2?=
 =?utf-8?Q?tOHnnlTOjlQv/8C6L5M+pPIRkF77oNb6DS7ga9g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXZGRmhzU1VOc3RNM1k1dTNYQnRNQ2xtL1d4OWI2UEdvL1FQdGE2RG91alZB?=
 =?utf-8?B?dlJSV3dVL2d4ZDd3L2FWUFJ5cFdabzZwSk5Yc2VNZVNwSTliWHNMK0RseDRQ?=
 =?utf-8?B?S3BVczArV3ZqbXBySTFGb0paYXVrc2NWdk5pbEtOaTdWdzV3V2RJeTB0d216?=
 =?utf-8?B?djNNcE1TOWdRUXVmZ2JZTFpvOVVEdW5oQTYzb01HcTNROFREeWlNNzFTL1BG?=
 =?utf-8?B?aC9kSXFHbHhYTWxaZUxwNU9zS1Y3UWc5ZTlkOS9Qc2FKckNSK0RXNVBXK296?=
 =?utf-8?B?d1VhVWNienNsV3hWbm94ZXJOSlptcEZja0ErSWZPR0tuUFJnRWkyeU9tZGF3?=
 =?utf-8?B?YmZGdUF6M0VYM0RwR3JoWFgraUgyYjVrZHZqc3ZOaGh4dXlPWEYwdzJTbm1M?=
 =?utf-8?B?K3ZtL0d6WmlqWGZsVkpIQU9RSU50UFRaY3o0WGVyb3hDcDVHc080Z0tlTnNs?=
 =?utf-8?B?c2NOTkJ1ODZVZ3NEOUxyTTlPN05zUHU1WlZVcjJuVjh0UlQwYWJ3RWZENEt2?=
 =?utf-8?B?YThreTdybS9lVzZuc0FYYXl3aHQrc2pTK1h1amQ3ejIzeWxwQ3dsUWg4YjNH?=
 =?utf-8?B?R3p2b21uZGl4enJPbW9jYmZBMExLd3VmNWpWcThxcGdEMnhXQzRGOUZJRVFZ?=
 =?utf-8?B?bEE1Vkd1TnhLSng4MVBSVW8valQrd2hBclZEY2VrTEpPNVkvakk3M3NwcVMv?=
 =?utf-8?B?bGJNVi9RTm80Ym9ORUdObVhHVkUrSGJPL1hxNmJramFJS3NmUEtCN01xSk9U?=
 =?utf-8?B?Y2JvZDV1Q1NwVm8xSW1IS0tqMDNtb1YvU3U3UlJLdHB3anhyeUJVK01BRlJH?=
 =?utf-8?B?NTBFbkJjUEtJbVYvRG9NYS9hQS9mRndQUkFOZnc0ZE9pN1pkY2YzclA0Zkxk?=
 =?utf-8?B?Ulh2cEp1NHppSC9zTnVDR2R4MFJXN2RnbEs3RWI2Q3lOaWhCcU16RXphd0wx?=
 =?utf-8?B?b1JJcVhNSW4wczJlMU5FSjNNWlZnSGhQZXVoSWRXL3p1N2ZMUi9TYUk2ejlK?=
 =?utf-8?B?WllQUnVSTG11cUYvSGNabVp3aU9obis3eUtIYjJ3OXFGQTA2eVdLMHZVeFk2?=
 =?utf-8?B?NFErMHY4UFRlcW1hY1h3Y01TQTFwTmNQOGtvUVB0TDNYVXZVdGJBMDE4Njd5?=
 =?utf-8?B?QjFTMTFTSVVCS0lkUHN1UzJnWHM3c1ZZNXNRYW8rSkt1RHRoNVZ1dmlIOFY0?=
 =?utf-8?B?NXhtc0xHekx6M0dWUXlNY3dFY1ZQR01JVUsrdUc5Q0RqWGRLSE9ESjZNcU5O?=
 =?utf-8?B?dUgwT3ZNTFdVSFNqdEhxRHJXa25UR204dEVNTFFMWEJJczBZemtXS1VkSDcv?=
 =?utf-8?B?Vkt5ajFlZHF0dWNocGN4bWp6R3VVaVcrWE5MNlVUK2Y2ZzBPZXpqTVNncGZF?=
 =?utf-8?B?Wi9Ed1NVTkFrYXRaWVZGZ203MFZpeXBnTWQrWHhwdkNzWitBRTlkSkM5TEZ4?=
 =?utf-8?B?a0xPbEdMUnU5SmFTVkMwTzNpRlVRRTA4KzJCR2E3ZTg1a2ZGdlJPa29ER2FO?=
 =?utf-8?B?M2Zad1QzMUZLN2YrV0Vtc2lLOVZIVm9aYXJzMEJoWjFRM2pYZnJ6anYzZUc4?=
 =?utf-8?B?dVRZMnlmQW85ZUN4YUpHTlMvY0xyTkVlQ21ET09RaER0eUx4TWNxY3djSjU0?=
 =?utf-8?B?MHA1YUxuOFY4ZG9UWjMzWXBmU3ZJMFgyT2lzTWJjUTA1eXdMa29YWStHVzZV?=
 =?utf-8?B?VXVhblZCc0VvakdXVkMzRlR4WkI0QVFnVkVIVisyWWVvQUNtYVdYcGlkSVBm?=
 =?utf-8?B?NVBLY1RLTFpaNWNGdlcyNUl2N0dCZ1BQMDBMOVpoU1ZrU3oxUlp4QlJ4Ukx4?=
 =?utf-8?B?bldLMy9XVTR2M21hWjZFY2pmU1A3aVNOMjlvM01EOURJVkgwa2NuV1Zkam8z?=
 =?utf-8?B?bTlScStHTS9qUmdkaWpEWmhYQy9IeDJZNVBHN28wS2pZYU1ZMjhSSGtweG9r?=
 =?utf-8?B?aE1hR09ITUtOWGxXL2h2S2xCWUFUektpMzE2NzNWRzlHSHBqcXZBQWxFRjVr?=
 =?utf-8?B?bGN1YWJOSzJPZWV6N0hmRERsQ1RCM0dvNjR6VVduQ1gwUERRWWNOOWNKUTgr?=
 =?utf-8?B?TjQ4SmdFd2FVLzhJcDlmOU9FUjMrT1dvblRleUEwTWlxa1lENEZ3RTdmZ29F?=
 =?utf-8?B?QnZnZ0ZPZzZib3J3NW9tTmdCRm1iMFNpQ2ZOdDQvckc1TnUxUkdaZkxSMEJa?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QOXTzXH9WhR5vktSKaUVcYGJUXHJTl5IGu7NHC3rII/5Z5OJ0toe/eYCNwu5lAdlKbwsADzLBGFDEfJlYsQUJNgSJz+Ar8x2++yD1Ym2E+5uW79U2DnTzBg7IQ8rbJvhczmie+LOScuR5opYXozhSqrPKSrd/Wl7rA/LRMzVfs1tjpS9M+hqrcgL1wX9k68Bv4wwsH4f0VYsIkXTUphzy0iT5FSyFAVZiM8aEebfUR6lJ7NRoeg29fRWFUSzn6Tf/6QF/9wqC8vbvH4mnMFLDvzvY9oWw1ncy2u2vuooBW52umfbbCk2MoQlo6ARDujORmpYTQOkjk9SQoWdXul0g/Is2xffpLzahDG21nrtbyb00lxEX9RQmKFcT69YDNP0/49to+XluzO0pR2kJuryhR8qra9R9n6aCFn2AzalRLACq1zkTlvbDbFhVthHvNQc1HKEwqcPtF9dILlbstCEJp63dNT0OjRdiVHQd17eshgCWmKDPn5KC1tMYI9TXG+2dsuZxqs5VMWkich83pujuz+Fm0QmXxsnmmQAch9AnKyLoxl80an7LMSqxNieXJ8qw45Q/cvlVLQlZnGrJiSS0u9qAccrlmkBkZhaxV33iz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2b1083-1e60-4967-6b36-08dcf440847b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 15:28:31.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RY7rDciPTllmzOgQ3lqqBkiHZ5zTr5QWbTyVq4O19bZk2rt/sF2llT6N/XPwp3fd2vwTLcD6HbPMb/wGKKFAaygQTPGB9nRz0i3kNZxGwWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240127
X-Proofpoint-ORIG-GUID: dDCVWtFHyR0MtTFTnaCtr8JEkx9Rt7_d
X-Proofpoint-GUID: dDCVWtFHyR0MtTFTnaCtr8JEkx9Rt7_d

cc linux-selftest for this one patch of a series.
No framework changes, only added new cases to existing iommufd selftests.
The full series is here:
   https://lore.kernel.org/linux-iommu/1729783554-56916-1-git-send-email-steven.sistare@oracle.com/

- Steve

On 10/24/2024 11:25 AM, Steve Sistare wrote:
> Add test cases to exercise IOMMU_IOAS_MAP_FILE.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   tools/testing/selftests/iommu/iommufd.c          | 127 ++++++++++++++++++++---
>   tools/testing/selftests/iommu/iommufd_fail_nth.c |  39 +++++++
>   tools/testing/selftests/iommu/iommufd_utils.h    |  57 ++++++++++
>   3 files changed, 208 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 4927b9a..e379adf 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES */
> +#include <asm/unistd.h>
>   #include <stdlib.h>
>   #include <sys/mman.h>
>   #include <sys/eventfd.h>
> @@ -49,6 +50,9 @@ static __attribute__((constructor)) void setup_sizes(void)
>   	vrc = mmap(buffer, BUFFER_SIZE, PROT_READ | PROT_WRITE,
>   		   MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>   	assert(vrc == buffer);
> +
> +	mfd_buffer = memfd_mmap(BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> +				&mfd);
>   }
>   
>   FIXTURE(iommufd)
> @@ -128,6 +132,7 @@ static __attribute__((constructor)) void setup_sizes(void)
>   	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP, length);
>   	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
>   	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
> +	TEST_LENGTH(iommu_ioas_map_file, IOMMU_IOAS_MAP_FILE, iova);
>   #undef TEST_LENGTH
>   }
>   
> @@ -1372,6 +1377,7 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   {
>   	unsigned int mock_domains;
>   	bool hugepages;
> +	bool file;
>   };
>   
>   FIXTURE_SETUP(iommufd_mock_domain)
> @@ -1410,26 +1416,45 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   {
>   	.mock_domains = 1,
>   	.hugepages = false,
> +	.file = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains)
>   {
>   	.mock_domains = 2,
>   	.hugepages = false,
> +	.file = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_hugepage)
>   {
>   	.mock_domains = 1,
>   	.hugepages = true,
> +	.file = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains_hugepage)
>   {
>   	.mock_domains = 2,
>   	.hugepages = true,
> +	.file = false,
>   };
>   
> +FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_file)
> +{
> +	.mock_domains = 1,
> +	.hugepages = false,
> +	.file = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_file_hugepage)
> +{
> +	.mock_domains = 1,
> +	.hugepages = true,
> +	.file = true,
> +};
> +
> +
>   /* Have the kernel check that the user pages made it to the iommu_domain */
>   #define check_mock_iova(_ptr, _iova, _length)                                \
>   	({                                                                   \
> @@ -1455,7 +1480,10 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   		}                                                            \
>   	})
>   
> -TEST_F(iommufd_mock_domain, basic)
> +static void
> +test_basic_mmap(struct __test_metadata *_metadata,
> +		struct _test_data_iommufd_mock_domain *self,
> +		const struct _fixture_variant_iommufd_mock_domain *variant)
>   {
>   	size_t buf_size = self->mmap_buf_size;
>   	uint8_t *buf;
> @@ -1478,6 +1506,43 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	test_err_ioctl_ioas_map(EFAULT, buf, buf_size, &iova);
>   }
>   
> +static void
> +test_basic_file(struct __test_metadata *_metadata,
> +		struct _test_data_iommufd_mock_domain *self,
> +		const struct _fixture_variant_iommufd_mock_domain *variant)
> +{
> +	size_t buf_size = self->mmap_buf_size;
> +	uint8_t *buf;
> +	__u64 iova;
> +	int mfd_tmp;
> +	int prot = PROT_READ | PROT_WRITE;
> +
> +	/* Simple one page map */
> +	test_ioctl_ioas_map_file(mfd, 0, PAGE_SIZE, &iova);
> +	check_mock_iova(mfd_buffer, iova, PAGE_SIZE);
> +
> +	buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd_tmp);
> +	ASSERT_NE(MAP_FAILED, buf);
> +
> +	/* EFAULT half way through mapping */
> +	ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
> +	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
> +
> +	/* EFAULT on first page */
> +	ASSERT_EQ(0, munmap(buf, buf_size / 2));
> +	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
> +
> +	close(mfd_tmp);
> +}
> +
> +TEST_F(iommufd_mock_domain, basic)
> +{
> +	if (variant->file)
> +		test_basic_file(_metadata, self, variant);
> +	else
> +		test_basic_mmap(_metadata, self, variant);
> +}
> +
>   TEST_F(iommufd_mock_domain, ro_unshare)
>   {
>   	uint8_t *buf;
> @@ -1513,9 +1578,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	unsigned int start;
>   	unsigned int end;
>   	uint8_t *buf;
> +	int prot = PROT_READ | PROT_WRITE;
> +	int mfd;
>   
> -	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
> -		   0);
> +	if (variant->file)
> +		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
> +	else
> +		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
>   	ASSERT_NE(MAP_FAILED, buf);
>   	check_refs(buf, buf_size, 0);
>   
> @@ -1532,7 +1601,12 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			size_t length = end - start;
>   			__u64 iova;
>   
> -			test_ioctl_ioas_map(buf + start, length, &iova);
> +			if (variant->file) {
> +				test_ioctl_ioas_map_file(mfd, start, length,
> +							 &iova);
> +			} else {
> +				test_ioctl_ioas_map(buf + start, length, &iova);
> +			}
>   			check_mock_iova(buf + start, iova, length);
>   			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
>   				   end / PAGE_SIZE * PAGE_SIZE -
> @@ -1544,6 +1618,8 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	}
>   	check_refs(buf, buf_size, 0);
>   	ASSERT_EQ(0, munmap(buf, buf_size));
> +	if (variant->file)
> +		close(mfd);
>   }
>   
>   TEST_F(iommufd_mock_domain, all_aligns_copy)
> @@ -1554,9 +1630,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	unsigned int start;
>   	unsigned int end;
>   	uint8_t *buf;
> +	int prot = PROT_READ | PROT_WRITE;
> +	int mfd;
>   
> -	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
> -		   0);
> +	if (variant->file)
> +		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
> +	else
> +		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
>   	ASSERT_NE(MAP_FAILED, buf);
>   	check_refs(buf, buf_size, 0);
>   
> @@ -1575,7 +1655,12 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			uint32_t mock_stdev_id;
>   			__u64 iova;
>   
> -			test_ioctl_ioas_map(buf + start, length, &iova);
> +			if (variant->file) {
> +				test_ioctl_ioas_map_file(mfd, start, length,
> +							 &iova);
> +			} else {
> +				test_ioctl_ioas_map(buf + start, length, &iova);
> +			}
>   
>   			/* Add and destroy a domain while the area exists */
>   			old_id = self->hwpt_ids[1];
> @@ -1596,15 +1681,18 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   	}
>   	check_refs(buf, buf_size, 0);
>   	ASSERT_EQ(0, munmap(buf, buf_size));
> +	if (variant->file)
> +		close(mfd);
>   }
>   
>   TEST_F(iommufd_mock_domain, user_copy)
>   {
> +	void *buf = variant->file ? mfd_buffer : buffer;
>   	struct iommu_test_cmd access_cmd = {
>   		.size = sizeof(access_cmd),
>   		.op = IOMMU_TEST_OP_ACCESS_PAGES,
>   		.access_pages = { .length = BUFFER_SIZE,
> -				  .uptr = (uintptr_t)buffer },
> +				  .uptr = (uintptr_t)buf },
>   	};
>   	struct iommu_ioas_copy copy_cmd = {
>   		.size = sizeof(copy_cmd),
> @@ -1623,9 +1711,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   
>   	/* Pin the pages in an IOAS with no domains then copy to an IOAS with domains */
>   	test_ioctl_ioas_alloc(&ioas_id);
> -	test_ioctl_ioas_map_id(ioas_id, buffer, BUFFER_SIZE,
> -			       &copy_cmd.src_iova);
> -
> +	if (variant->file) {
> +		test_ioctl_ioas_map_id_file(ioas_id, mfd, 0, BUFFER_SIZE,
> +					    &copy_cmd.src_iova);
> +	} else {
> +		test_ioctl_ioas_map_id(ioas_id, buf, BUFFER_SIZE,
> +				       &copy_cmd.src_iova);
> +	}
>   	test_cmd_create_access(ioas_id, &access_cmd.id,
>   			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
>   
> @@ -1635,12 +1727,17 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			&access_cmd));
>   	copy_cmd.src_ioas_id = ioas_id;
>   	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
> -	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
> +	check_mock_iova(buf, MOCK_APERTURE_START, BUFFER_SIZE);
>   
>   	/* Now replace the ioas with a new one */
>   	test_ioctl_ioas_alloc(&new_ioas_id);
> -	test_ioctl_ioas_map_id(new_ioas_id, buffer, BUFFER_SIZE,
> -			       &copy_cmd.src_iova);
> +	if (variant->file) {
> +		test_ioctl_ioas_map_id_file(new_ioas_id, mfd, 0, BUFFER_SIZE,
> +					    &copy_cmd.src_iova);
> +	} else {
> +		test_ioctl_ioas_map_id(new_ioas_id, buf, BUFFER_SIZE,
> +				       &copy_cmd.src_iova);
> +	}
>   	test_cmd_access_replace_ioas(access_cmd.id, new_ioas_id);
>   
>   	/* Destroy the old ioas and cleanup copied mapping */
> @@ -1654,7 +1751,7 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
>   			&access_cmd));
>   	copy_cmd.src_ioas_id = new_ioas_id;
>   	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
> -	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
> +	check_mock_iova(buf, MOCK_APERTURE_START, BUFFER_SIZE);
>   
>   	test_cmd_destroy_access_pages(
>   		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
> diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> index c5d5e69..2d7d016 100644
> --- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
> +++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> @@ -47,6 +47,9 @@ static __attribute__((constructor)) void setup_buffer(void)
>   
>   	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
>   		      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	mfd_buffer = memfd_mmap(BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> +				&mfd);
>   }
>   
>   /*
> @@ -331,6 +334,42 @@ void __fail_nth_enable(struct __test_metadata *_metadata,
>   	return 0;
>   }
>   
> +/* iopt_area_fill_domains() and iopt_area_fill_domain() */
> +TEST_FAIL_NTH(basic_fail_nth, map_file_domain)
> +{
> +	uint32_t ioas_id;
> +	__u32 stdev_id;
> +	__u32 hwpt_id;
> +	__u64 iova;
> +
> +	self->fd = open("/dev/iommu", O_RDWR);
> +	if (self->fd == -1)
> +		return -1;
> +
> +	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
> +		return -1;
> +
> +	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
> +		return -1;
> +
> +	fail_nth_enable();
> +
> +	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
> +		return -1;
> +
> +	if (_test_ioctl_ioas_map_file(self->fd, ioas_id, mfd, 0, 262144, &iova,
> +				      IOMMU_IOAS_MAP_WRITEABLE |
> +					      IOMMU_IOAS_MAP_READABLE))
> +		return -1;
> +
> +	if (_test_ioctl_destroy(self->fd, stdev_id))
> +		return -1;
> +
> +	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
> +		return -1;
> +	return 0;
> +}
> +
>   TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
>   {
>   	uint32_t ioas_id;
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 40f6f14..6a11c26 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -40,12 +40,28 @@ static inline bool test_bit(unsigned int nr, unsigned long *addr)
>   static void *buffer;
>   static unsigned long BUFFER_SIZE;
>   
> +static void *mfd_buffer;
> +static int mfd;
> +
>   static unsigned long PAGE_SIZE;
>   
>   #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
>   #define offsetofend(TYPE, MEMBER) \
>   	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>   
> +static inline void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
> +{
> +	int mfd_flags = (flags & MAP_HUGETLB) ? MFD_HUGETLB : 0;
> +	int mfd = memfd_create("buffer", mfd_flags);
> +
> +	if (mfd <= 0)
> +		return MAP_FAILED;
> +	if (ftruncate(mfd, length))
> +		return MAP_FAILED;
> +	*mfd_p = mfd;
> +	return mmap(0, length, prot, flags, mfd, 0);
> +}
> +
>   /*
>    * Have the kernel check the refcount on pages. I don't know why a freshly
>    * mmap'd anon non-compound page starts out with a ref of 3
> @@ -589,6 +605,47 @@ static int _test_ioctl_ioas_unmap(int fd, unsigned int ioas_id, uint64_t iova,
>   	EXPECT_ERRNO(_errno, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, \
>   						    iova, length, NULL))
>   
> +static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
> +				     size_t start, size_t length, __u64 *iova,
> +				     unsigned int flags)
> +{
> +	struct iommu_ioas_map_file cmd = {
> +		.size = sizeof(cmd),
> +		.flags = flags,
> +		.ioas_id = ioas_id,
> +		.fd = mfd,
> +		.start = start,
> +		.length = length,
> +	};
> +	int ret;
> +
> +	if (flags & IOMMU_IOAS_MAP_FIXED_IOVA)
> +		cmd.iova = *iova;
> +
> +	ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &cmd);
> +	*iova = cmd.iova;
> +	return ret;
> +}
> +
> +#define test_ioctl_ioas_map_file(mfd, start, length, iova_p)                   \
> +	ASSERT_EQ(0,                                                           \
> +		  _test_ioctl_ioas_map_file(                                   \
> +			  self->fd, self->ioas_id, mfd, start, length, iova_p, \
> +			  IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
> +
> +#define test_err_ioctl_ioas_map_file(_errno, mfd, start, length, iova_p)     \
> +	EXPECT_ERRNO(                                                        \
> +		_errno,                                                      \
> +		_test_ioctl_ioas_map_file(                                   \
> +			self->fd, self->ioas_id, mfd, start, length, iova_p, \
> +			IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
> +
> +#define test_ioctl_ioas_map_id_file(ioas_id, mfd, start, length, iova_p)     \
> +	ASSERT_EQ(0,                                                         \
> +		  _test_ioctl_ioas_map_file(                                 \
> +			  self->fd, ioas_id, mfd, start, length, iova_p,     \
> +			  IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
> +
>   static int _test_ioctl_set_temp_memory_limit(int fd, unsigned int limit)
>   {
>   	struct iommu_test_cmd memlimit_cmd = {


