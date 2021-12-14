Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6929474D3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 22:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhLNV2i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 16:28:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:55310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhLNV2h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 16:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639517317; x=1671053317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nob64GerxPiR1mnQrHBHqjiAka9OBOOSRUHVB1kIRFw=;
  b=VFUq/frTNJKyynaeyTULO5bomPwiunPrCpQwHiBQZUN5PuHKR/ZASvdW
   3w5tNv2uLCZkKHth9q39b6bxD2KsI1CsnkLb11yNNm9I0AqVPv3aHlCj5
   UsNuy3EZBQT7dHD60HHRoL2v340ZP6np7y6qj82KYQm699dP5MckHyEBS
   oaPQgKfXzT+5c1VTQDXRM6CJoKm2olJ9c2HlfW++LkJBmypH8bBtBiGpm
   U+RRdF3sNStt5mzqBMiLtJfNotji1jbR9j6wNd5NVL0JULUXNcMd40WTp
   EgqrXkz6MD8rSD/MKK7kH3c7nlgxurMJb1kBeEyURXx+IZcEe9NCY782I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226367186"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="226367186"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 13:28:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="610101958"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2021 13:28:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 13:28:36 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 13:28:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 14 Dec 2021 13:28:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 14 Dec 2021 13:28:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQmGWLLcqRndk6HCFZ/HMjV/+Oj969HBNdbW0SNMopJBFOvOtR4Hv+g7F+Qod+jhP5SGJ9FYiPk0TxcCQxKWazt4AfAam4a/bddT7WF/bpMVucwoiCQk0Byt6qk0hQWzTsa/k9MxfknVyO2pjvQofsP+Hqz/QLS8BFOcgLilvNeL20HsHvj5m7l/ofEdJnqvk8yBK3ZTOP667EjPbLmat9Kx6LXgvXtD40V4fVo/V4grJjNIUkOmBrPIM+xNWj3WpCsvpsWvJ6VGnLDd3FDfHbATDYbCYJJZacSo+n05reNAj+U5RIIxkSD8Wwo0xC3ilqGgZIP7MRtedCRY27vEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPuTt2mISRyXkrgGxK6/913r4aEmaB93E2DgH0FusCk=;
 b=G+zRkxZIJC8zuEUNjQtzgHb58FN8SCUGIZoC+uUgVyybLmWoMjwupYySpz+lW9xED665SERYRA5266L9Xa2PCpLa17AoXrJ5xve02YQNV3RMaEgRyqv1F/DkWu4+s5tAyCfuPXdCF+oZ1RSVyLLQPm7G+F/jGbt+fEQetLNdiJm6y2VPj2s1kK8CfTEBhQsDQsILIFoR8WrAxOkephUpYShDzSqn/PSgtOFvwBqUjIlFERtKSyE9CHtSXpfhCfa1MPhrIGiTT/jiWfaUv0CTJGDV5IvrKQh8IIFDTBjDbmH79WU/Yb91iYcWjhoIjuj1XBFzCWaKm4uw0Fy9kL4dsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPuTt2mISRyXkrgGxK6/913r4aEmaB93E2DgH0FusCk=;
 b=EvdeCSQsjbrJOcq24jWnpV4CIn7m+Lde1PnvF1GemYhDRb3OF8/6hCv2le489VT32VQZw6hujIWCvt7Jbkum0Vx95JwAcKPVmKIYsEKHUcuOWfmu9F6yJPE4IIN8snWDOk+Cmv/RH2aex0sbEOQruO3WxkdJZKWPJogfPqWARzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2820.namprd11.prod.outlook.com (2603:10b6:406:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 21:28:34 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 21:28:34 +0000
Message-ID: <4dc1dd00-320b-e625-83db-70184141e9c9@intel.com>
Date:   Tue, 14 Dec 2021 13:28:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH V2] selftests/sgx: Fix build error caused by missing
 dependency
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        <dave.hansen@linux.intel.com>, <jarkko@kernel.org>,
        <linux-sgx@vger.kernel.org>, <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>
References: <de2a262e97e7b173548b909a608e9e99aab38e9d.1639509500.git.reinette.chatre@intel.com>
 <8b7c98f4-f050-bc1c-5699-fa598ecc66a2@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8b7c98f4-f050-bc1c-5699-fa598ecc66a2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR18CA0053.namprd18.prod.outlook.com
 (2603:10b6:104:2::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe505478-69b8-4b62-794d-08d9bf48aec1
X-MS-TrafficTypeDiagnostic: BN7PR11MB2820:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB2820CF33D03EC4244E7E1AFEF8759@BN7PR11MB2820.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnPo/oab2sj8ipt2LSMh0NhGmLJySCVKEz9JjSY7owAHh9hmOID97W9Gn8sEoMsI04B4sFqJPjZwz7mZ43huoBtkZfcVayhTATs9D4Ht0PDVJVfyknOUwjuR8V7eF9G0jRG0tRY6QDGKDGME4Kh4DjZTBQIdf5Zrpwx0YMECfmEdy0C+B2gbZDYNMah3wi8T6c8K0WyRxpcDFDK3tE1qMzSf5BRRlWUIWtFiykME2EWsqGCJD3bEpSnZpDsybQCNUXusVwNywr7It7bCfHuS3Ao5mTCsP4g8kxGygjKrDmKuOhpDJcyjOC6iRES5GM2bC9+EZCLFhO0waEoqbqL7HsxohsfcBh5xJ2LbU1yvg3y1gMk6TQpzNKaUHImpf+90ODYwFaJOjOXHV2A0mURbSpdbH71yM5dGelRlq6iRsvNagrhRP8UKN+aiYrD7ZWPl5FFY6M5uTMIxs7uZEG5Pp1zUlTwPwHu60C+u6Xi69eS7CNzy3oC0Wav6OLF9YOa1PjxnWnB/DH86IkiV5q4ZaomLueFysD4KsEHtMiauQgM2ClsLAMDHhtR8WmEm6/QD43V4NwroQzvdaYIigt222Z2U5RtBOQAXbnJg71FVtm06HqrxDaC1/aLdKf7yYuUDW+f2QnM1TKLTkMQHuy6z/76I8lkk5GT6tXDQijRNNOS9ZX6OHAxhIilzPOarGobZC2yo3aDZpvUGjNksTSwOfhzHO2+5H0f4Dqme/FUkv1XjWjF1ppw3V2x0lsxHfQJR6ZQfJFAdr5wvS7VLLs8/Jykl+thnm1WFpHO+e4C2kS8Ap6X+dLsazEvV/TBYehlt5s7LWtnWl62MT/EYOBpyaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(6506007)(66946007)(31686004)(8676002)(38100700002)(4326008)(82960400001)(31696002)(2906002)(316002)(53546011)(6666004)(44832011)(8936002)(2616005)(36756003)(966005)(26005)(66556008)(86362001)(6486002)(66476007)(508600001)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkpvMU5TZk93TzBRK205RHlYcnJCaU4vZktqOG9lb0VmbHFINmRadis3K3p0?=
 =?utf-8?B?Skg2NTFOVXR1cHUxNktHRTB5ZHhiUkx0UTV1VWM2cDE0ZS85d0dVWFYzdWlE?=
 =?utf-8?B?YXFUUlVjRU8ydFQ3TGdPYWdvaFBvR2tGU0o0R01uUDErVVNwNnFNcEhXczNB?=
 =?utf-8?B?OU1sUENxMGhPRnJnaUNRMzRFanZpdGFLNEROc1lGbUxJY2tMMTNLUDRTbnRP?=
 =?utf-8?B?WWhHRDRUc3Q3aHFtMklFOVc5SjRsc2dCeFo4SzZvRVpyRXRoZnBVWmNuVHdk?=
 =?utf-8?B?T0k4bUVDZmNBM1NmbHNNUTJMZDIyZFIzY3pndDJQRUdhNHVDYnBhN0o5ZC9w?=
 =?utf-8?B?ZmpHQ3dNOFUwTldWRFdvTDRyU3NuaTlSN2ZkL3RiZS84UDg4Z3F2djh6RjFO?=
 =?utf-8?B?cTJQZzZxSHNUSW16TUtVWjJBU29MMXBDRXQ4Vk9LbWNBVXNhaXZHRmVMRFFN?=
 =?utf-8?B?NHJBSHpWTzczWTZxK0VnUnZtVEJJSHhLNjgvUnZ6Q0VheTN1K0xreExDWHF0?=
 =?utf-8?B?RFl5eE5iUzdYODNkV1BLRDVRbDVoY29rWFBWY2NPTUJnc0lPNWJCM09jazdq?=
 =?utf-8?B?b0tMMzNMR2pheUZzMzRRR3E3SWxjNThJR3BNL0NFVUFhUmd2QmtRVlFLMWdm?=
 =?utf-8?B?NkdWaXcxUFJNNWRCNHp1eEVBdjFOQ0pkTWhGazVlUm50WVNSK1RRSmNJSDZU?=
 =?utf-8?B?bFJqeWNyMzRvSGd2Z21KSWJmZUlLNTBSVksyNFlwR2U2S3cvZGZUUTRadjN5?=
 =?utf-8?B?NUJWTFZlRDNwY2o2N04zWkNrM3k4NnpTb0F3cEtFaHRWbnlmbmVURWdMRWp0?=
 =?utf-8?B?UVR6QU1pNWNRQlIrUmpVZUdZMzlwTkhEdFRXVEVVTk1jcWtET2hyRnBqZERp?=
 =?utf-8?B?WTh3bzZkbnRoU3Q1bGJIa09KWU1KeFIyQWFpWDdtdG4vZmQ5d2N3TmxyUy9k?=
 =?utf-8?B?aUVhekx5ZFpIRDFscExWN3FvVGNNTHBhcEFNZDUxeFNkTlJrdjZiZFhudHRx?=
 =?utf-8?B?RnhRajVlaHBlVUt4dGVLQmF6MzVCSTNsN25QNElYU01LZ3FYZmg5NnJ3WjFC?=
 =?utf-8?B?bVM0K2VialhpRTE0YnhDQ21tUnREdld1aXg0WjRPYlFISWZxK2VEU1JFcjhq?=
 =?utf-8?B?M1ZyZjVGb0R1bUNscm50R3BNbDlnV0tHYnRmMFIzNTIybnFTdUJzeW1KMDhW?=
 =?utf-8?B?a3Jwb0xRR2lSaWh6NWVoNUh1TVNUSWpXdU5KK1lydFRCREQwaURIUnhSK0oz?=
 =?utf-8?B?Y3pkcFNwdnUvYnk2b3hIOHU0TU0yRnpZUlZMMUlHQVRmczhTZVpCaWVwUkt1?=
 =?utf-8?B?Z3JPR2tVS3hKMlE5dTloVnByQnVmYWU1VUxsczJHV01Wd1l2QzVNbWxIL3pz?=
 =?utf-8?B?c0Z6VUw3RVRHTmx3M2tKYmExcDUxaWlpbzNDQWlGWlc4OW5QTGtPQUE4eG9w?=
 =?utf-8?B?NDJUU0owa29tYmxTVEx3eXkrR0xRQ25paHVSUzA1U0gzMjlHOXB5dG14bkJK?=
 =?utf-8?B?VFNSNXJndWczVUZid2hRajBjUDgxYUJNU0JWYWtUUU0zVTdUMUtCaUxCMHZ0?=
 =?utf-8?B?RmVNMDZYSE1tYXZaZnJhOEVZUkE4S0JUMEZua2NjUzBGNFBjWjRNQm1qK3p5?=
 =?utf-8?B?dmxJUXBDNDVTaW9BWVVqTERiV2grbGNrTDAra0FZamk5YUdhSjAwUURjUktS?=
 =?utf-8?B?U3VTbGRpM1pWT2ZhM2prOUYzOEhKMnY5b3JiVGxFditDUEV4WTBmazFncGZp?=
 =?utf-8?B?Z3BmMytTdEg3U09WUzFacjhQSjlSKzhyeXErYi9Hb25SclJwMVkxVmtCazZi?=
 =?utf-8?B?UEJDbDJuQ0dCckt0RVFnSnB1cUI1NGlHb29ud0t4KzExK3czN3piN1ZYTTlK?=
 =?utf-8?B?TXZRNkhTUG5FdklYcFlLMGptTzNmM2lCMWlvc1hOcnVCYktxVFRMZElpVFVa?=
 =?utf-8?B?TE9KejB4ZG8rQk04S3M2OWVVbVltUDlhd1crOCtiTnhuUnpDUTkvS0JwaTAx?=
 =?utf-8?B?b0ZhcThFVU9EUlhJdVY4eU54R2xOWWZWbmV2bVZqbk40QTRLV1VUL2wrNUtu?=
 =?utf-8?B?WHp6RVlnMFArdzg1OU1mQ3NsOFpOQmZ1TEFqbStHaFB2THRDVkFXakh5b1Zh?=
 =?utf-8?B?cU9qZEE0NnBMNVorTlJYdW5VcStTaERpcVVRSkFLN0xhWnhoWG94WnNEWVAv?=
 =?utf-8?B?VUxUSTNCeEt0eWlOOFAxd3BwaGZTS29adm1RSlYyQ0svTFRIWGYzeUMvaEUz?=
 =?utf-8?Q?9d2dO9A/ya6GI/8938QNvH0K2X4xyrgNGxtDYjA5sQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe505478-69b8-4b62-794d-08d9bf48aec1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 21:28:34.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+ZsShmkjppw2tV31qp8Xnku6IDp2w2NU2hMfLdnSWzZzGRBOBslF/4A0TN3ep8LY3lMTnj6BbU1NIvyCworp2kH/seq7kB/thUe5GEWQLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2820
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 12/14/2021 12:10 PM, Shuah Khan wrote:

> 
> Let's not add one more __cpuid() define to the individual tests.
> We so far have:
> 
> tools/testing/selftests/vm/pkey-x86.h
> selftests/x86/corrupt_xstate_header.c
> 
> Let's move the defines to kselftest.h and remove all these duplicate
> defines.
> 
> For now you could include vm/pkey-x86.h just to fix the build error
> and do the proper cleanup.

Thank you so much for taking a look. We actually do have an alternative 
fix that could be considered for the other users of __cpuid(). Instead 
of another clone of the kernel's __cpuid() the fix includes cpuid.h and 
uses the existing __cpuid_count() from it.

Please see:
https://lore.kernel.org/linux-sgx/20211204202355.23005-1-jarkko@kernel.org/

We decided against the above fix using __cpuid_count() because we could 
not explain why all the existing users of __cpuid() implement their own 
and decided to follow the custom instead ...

Do you see any problem with including cpuid.h into a selftest? If not, 
then we can go back to our original fix of this issue and I could also 
submit a change to remove all the __cpuid() clones and replace them with 
the library's __cpuid_count().

Reinette
