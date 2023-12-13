Return-Path: <linux-kselftest+bounces-1868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449B3812102
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53921F216C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437F97FBB2;
	Wed, 13 Dec 2023 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6Ys1WyV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E45E3;
	Wed, 13 Dec 2023 13:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504566; x=1734040566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0yfhR0kiSW/MutJM97G/gZ+4fdjxHC3V4G/9zwvkMH4=;
  b=W6Ys1WyVg6UkKUCLMCKfuJzcgsAFFofM2HfAFBGIdjtnxahLtHgYS/xc
   EMt7sCqQUnnNY/jL2oxBH+J86DnDqnM6B2lLO2M5P3i7PsC4FfayhJMbf
   ZGd3kUsawE985yRqBOqQXSVxp9GqlCb3xTBeskbr8SnK4l0EdFlj88S05
   RE7/KEg7yDoFx2DiDoh1QjekXtyLTFUCYpft43rGvUCoN8uPrr8OMhwjj
   w/uh3XA6r8mhnc8ZC7vH78goDU7w47kod7et8hsQm9oQSxMp/4bg/dFdf
   qbAQLQUMKTH0I+VX2zDTj+gBaTcJaELLnLXTOE2zu2KmcNgj/4doZ31EW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16582729"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="16582729"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774095916"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="774095916"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:56:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:56:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkF2wh1X2VDrG2iRBHT31I4I4CPobVky7bJdKM/0tCd/EuDjFf4KEFzNVt/zborsl/vALUB/13jgkskpCJpHcnNGFjxhBIpho4OWAPJOf+f8XDJ+04QL7M3opPZm+KMJbTuW6mi2K77jT6QQVcBT2pJWLs592g7esfzxRTFmzpOr1/RPBnrNuXA7aQZRAdi8q5zuMjWTk6H/HK4M63E3136q9XSWjCS90PaEp7wpNIRBY3Ji+SenkQ3aufNdf+/uVnWqvLOzUEwtaatoH5ZzKrAsuh8hFr9W8UCWhlGivDpo5jhCv4lmobwDQ0CFfz6PVgatWM5tIrCxx0iWt5QXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfLVsxMI+tJHVOaoncrEj1Mw5jJuv8LcQrJJH68vutU=;
 b=cXbauxi6OU7+oCQHNzrN1KpUe+lfzqkpWHXOYjGPLDA+MktxbRgWl78tUT9y+a2zVBnKge3xIyeVOXgT5toJ5u6HHFuhO/4SChDgVWVKHqABmdUvKLrvGGl28NcjDAL6NkfQebArRrOjgymH5c0jmoxnMcBB/oOijkwNBRtpwmJ3RyLVQD5m9m1IFiG4mifioICqjj/8Ou4LbifuYEDIyhmVsm94Wmn7T1slq9WAbn6MTVp/us3CZa5dOcExMbrgEjZqwTh9y7DZWjvgnhonHneo4dtPVXnh5hqPHZLYXHS3Xw+/hgXsyWniikhzvQQO67DrFTdKuQeufErSoFNAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 21:56:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:56:03 +0000
Message-ID: <0d6cff29-9cda-4501-a29b-48e76fe2a9d8@intel.com>
Date: Wed, 13 Dec 2023 13:56:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/29] selftests/resctrl: Create cache_portion_size()
 helper
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-10-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 2691c3d4-074b-48c3-21cb-08dbfc264cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJM2/Dmox0zJWhj4aLXasUOazlc7Ypu7zqr7cDWbpKUQVsgOuersRnXSfLnm+jb4Bakc9neMKJEnbOCETcAZ0NLv9tAeHMWkflC7J+1jMmg9s+Q46xQ3MZWwMicZZmDaxpd4vBIRXGwtFYg4hWEB231g64e240T6PkukHwZGNxEUNQ67dQuR+osn5USgjAyXRt7Qkqk880k7NhT2bJoVCUER+G1RlYgIAsRZ95bzf91S2LTxfOMryup4JU6BGTxIwweITwMyaJyTbgjINTlMJHY+Sn8ElIvJZx8GjrKM4ZAkUd+h4AC/NlGEyaGzoDWqhmwHCFESSzDhr1APfDm6x3bvRhhVQwxFoPtbc0xjGK628JoVMI9gUcvTm26wBO5feYrYCzwTT8Kn1QyXtrowuo+PYTaPP5H81mBz0qRZFB/MUn/cjDUvs+81bJV62dSdwyTtbo3xBHIn+7xm/wcU8bKo7gKqEd4lB2R/j6NOxyB/QnlrVu4whFZXTDdwiGDoGkP+i4rw+8ncP/HNySu/HFWosT6Asr6L+t2q2TR+qKlPNkxZKYok07nYOHE9gf//iVoKUngvzIkxxMpnWa2wxod3YXfDbPyzOdMc1Y+Nf9QDItBSgV6kXTy64cXrzEvda4SYug8yWqPmn2BaLS201w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(6506007)(53546011)(66556008)(4326008)(66574015)(8936002)(8676002)(316002)(86362001)(31696002)(5660300002)(6512007)(478600001)(6636002)(66946007)(66476007)(6486002)(110136005)(44832011)(38100700002)(31686004)(82960400001)(2906002)(4744005)(36756003)(41300700001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ozekUwKzR3WDVLb3VQcWFEdnhpejBxb1BzMEhrbStLa3JQRHR0QVBaalAy?=
 =?utf-8?B?Z3pmMDNSMmUyUlZVVm1kNlpBdmFuc0xaRXExaHVpZDF5cVpQeittRnRGdWJX?=
 =?utf-8?B?MWdZdWd0THFRb21IdEIxVm9qbWFIS040MFZFVndoUERZNStUWittcVlzZGhw?=
 =?utf-8?B?L1VYNDJFV2h5UVRLM1BtaTFVRGpLdk5tZml5cnpGUjNYS2tyZ2szaUR1aGpM?=
 =?utf-8?B?R1RIbTJNMmZxY2hmVDk1OTd6cTdOT29sOEFiVGttOUZhRnY3ZmF2R0NoWktE?=
 =?utf-8?B?TWRwSklaZW5BWE1ScExtSDdkVmc0NWEyMzN2MzYvQXFYU3BTelBwZ2JrWUp1?=
 =?utf-8?B?Q21LVFNOaUVwNXZURlFKbHdpYmhQVHI0UlpDYTJmYXA3RkZzMHpDNm95b3hM?=
 =?utf-8?B?YTdSbGszTldrQjQ2RmhXVzJkaDF6cldkTW5oVVVaY1VIdVdodTl3VUwvU2tr?=
 =?utf-8?B?OE1QTTdCa3B3dTZ0ZkdMMlJLc2Z0R3lBYVh4b3dsVm0rWDJmQjZ5NWhPbjNu?=
 =?utf-8?B?VDZkZWpGbXBESEtrcWN1UHJmWExCNG9ZOUIwY0l5Q2x5L3BjUDRUem9rZEhn?=
 =?utf-8?B?QVU3WHRvL0E4Y0lDU3NZMUlEZzRzNFZTZ0ptRkxBLzdEc3lhMnFMUXJjS0N3?=
 =?utf-8?B?ODFqTGNPM2o3K1VoUTFlMGprSENBVjlGQjUxYXliLzdEaFN4ZHhDbkZ2c01n?=
 =?utf-8?B?M2IxQ3pQTzd1UFlRa0pZemw4NFBrRXBGUFhndDZMMWFtZmREMU5wVFpiNVVq?=
 =?utf-8?B?d21CV0dXUHNjekZHOUVjS000a0FhMFJtWTN4L1hvNnByaXk3UXpMZ2wyVlVq?=
 =?utf-8?B?d0wxeW9ua3BXWkRHbTVoRkF2OEpSbDJjenZnM1VhTlppUlNBSE0wby9RY1ZZ?=
 =?utf-8?B?QTJCK0pTTXVvRUgyQ3N1Y1BCU0ZlQmRnelRpVHFDRzNXdG5qc0tGL1paSnZ6?=
 =?utf-8?B?ZXRSbGpMd2VRWVdZWlMwNFRNdDNsanRZeEZ5aFVjNEs4TnVobHN2MHhpaXRZ?=
 =?utf-8?B?d0RJUmJKVTlJNHVvc0JDdHA1dTV3WmRtWG56V2VvSDljZTJLaEMrSG5rK1dJ?=
 =?utf-8?B?eGo2VG13bHNaT2pSOHI1UnlxRzM4U2VWSU1BY1V6TkdJZjk3M1VSRE1zbDY2?=
 =?utf-8?B?WUUzM3dJSCtGSzhJMWRCSE5IUzNpKzJjZm1BVlpVU09JWVhxUEZqUmhKNnRS?=
 =?utf-8?B?YXZQMEdtU3pvc0c1SWtoTlUwbXpZdWFMS1lBWXRNUXJnZzc1Z0M3N2JrbnZM?=
 =?utf-8?B?bXpxVlNKRGJCc3d2Uk9xK21zS21vaWM3R0xqRnhnWkY0YkZKZnkwbmNjQjJB?=
 =?utf-8?B?UWRYRnRiZ2p0MDMrWnhvRUJCZklMZ2J1ZFZnUTZCb1UybUVYMm40MVQvOUNE?=
 =?utf-8?B?ajJydzR2WDlZUGErSmRCWFZMTFZoY3A2NWFCeDBOWGtrN2ViRDdIQ2gvelVB?=
 =?utf-8?B?Rk1DeElBdjhQMm1DNDNaTnFoZnp5WEZUNWd0NUppRVYzcWIzM3h0NXBPbWhh?=
 =?utf-8?B?YkVWeWpqbGRoTjBqV3lpZ1lCc3RnM1cxaTNnQVhSUW5yZ3pFUjFxRm9kVUV3?=
 =?utf-8?B?cW51Q01kRHBUcjJmT3Vjalp4bHU1SmFqWGR6clEvdkFMSE9nTGxrVWhuWG9P?=
 =?utf-8?B?OHM2WkRqSFBqeno4VU92THdtajlhVUZLWXZjanllY0xqN1ZKMXVSV1NqaXZR?=
 =?utf-8?B?dnc4NHNDWDZXMFg2MnlOaCswMkRHZUdMencrZFZORy9KTzlyajdwSTh3b3Vu?=
 =?utf-8?B?SHBtQ05LU0JXd01paVp2L3JVL1FaSzhkOTVXT1MyaGFDL3IyT2lNWjFYMDdO?=
 =?utf-8?B?ckhiMkRCSDRmMGw4bUQ2SnA1NGhuWmcyTktTM1loQmZqN2dwNktBQVFmcSs1?=
 =?utf-8?B?Qm4rSEh1U0x0enNrSE9UZ2JhQWpQZWNYNVB4Q1ZPdWk0UmRSMzNEdlJSdWJv?=
 =?utf-8?B?RnhvWXFPcVJBVDFJQ1JOSUJSZTZ0aFhXNzl2QUVzTTIxeUt5b1R6eTZaUFNT?=
 =?utf-8?B?YTdjTTN1OEQ4eW9ZNnNMZFVnUTVmTm5lQ2dva3g5TklQc01tWmdQUEFkR0Fl?=
 =?utf-8?B?aHJNNnV2Z3lCank5WjFVakg5bHBvLzlTSEh4Y0d1dkMvTUtXUTFNMEZMQmhp?=
 =?utf-8?B?UnZybVVxam5GRHl3Nm9hTUcvQmtiUnZMblc0Z2wwcmY5U2kzL2hYRDJsMFBG?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2691c3d4-074b-48c3-21cb-08dbfc264cb6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:56:03.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+geTl0pkbZ0/8SEQt7CzhwiQwIB6DZonPOowrYNVzkKZ4ceTViOwdD6lcgzBfWOlYtIHmKYp+hUSoOpqQoXaKn1AxVacB6sZvZVG6/f0sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> +/*
> + * cache_portion_size - Calculate the size of a cache portion
> + * @cache_size:		Total cache size in bytes
> + * @portion_mask:	Cache portion mask
> + * @full_cache_mask:	Full Cache Bit Mask (CBM) for the cache
> + *
> + * Return: The size of the cache portion in bytes.
> + */
> +static inline int cache_portion_size(unsigned long cache_size,
> +				     unsigned long portion_mask,
> +				     unsigned long full_cache_mask)
> +{
> +	return cache_size * count_bits(portion_mask) / count_bits(full_cache_mask);
> +}
> +

Even after you added the new zero check the static checker I tried
was not able to recognize that this is safe. Could you please add a check
to ensure that there will be no divide-by-zero here?

Reinette

