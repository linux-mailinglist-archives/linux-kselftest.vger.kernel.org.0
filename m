Return-Path: <linux-kselftest+bounces-4148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D599849BB4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 14:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03010284F23
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2A1CD05;
	Mon,  5 Feb 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b872zwlq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D841CD0A;
	Mon,  5 Feb 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139567; cv=fail; b=PCusF1tlB+RfqqRn+P5wmzD7dm/KbUZ/5c52Vj7L4foccbr3F+oQPL+yaXr/0AqkknNwZKK4acIzYLb+bvCGe5knAevN3R3JFr9Xc92MKXnVyitlmd4k43tJNLAv61U3WDcgmhjY9L5FzUyiWhospietviWi3EB3TNVHEzO1np0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139567; c=relaxed/simple;
	bh=phxQF3rMfxTT52Kb5Yshbx5VqyV7fgdRe2gKO/huF1Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J/MZTH6HKXKvfaPDMW4ThgG55Rxyor+iISTsiVIWDohjsVrKH0B3UtuZSAG9owlzjJeyNh5MVsbMDMT4Kgo5cMqXqc23oA4+IEeponEpdkokxzyUuaCVajDS0ACYueDbq8qHjo5Upoz2M2uxnOiiT39BC/A8ovn6jJS0E0PgCJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b872zwlq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707139565; x=1738675565;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=phxQF3rMfxTT52Kb5Yshbx5VqyV7fgdRe2gKO/huF1Y=;
  b=b872zwlqIHsjoWJ8VKx9kHgnyVDd4mQXfozdyZfD/oEpVQUi1LznMWQ9
   8Rfq23OE8Q6GFaEL+NAS2PJ3vJTPKwV3KBCACk2xVsjLzr7/nTTLdHlnF
   FAOsYdxHzFnZkfs26+o3RD/pJNxTbNRD0lAxhsjUAAzFY9fYAn9sn65Zd
   tyLCtNl6RvDk7lNLVkVSZCdaqiGLiZw8s7G++YHZ+DFCtsb4ZsmEtPy9D
   lHBKgXQU7Qgj2lRx/Fe5PTRWQXE9NVCR07Qx9lNEm5cXaw7Nggytfh35d
   i7JUBuuGR7u9TGmb5EfsBTheAjhKPZDUhat+0PejfObiLtvz1uthSBmqz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="669737"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="669737"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5334509"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 05:26:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 05:26:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 05:26:01 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 05:26:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNV49YxYKYQ9y9vprF7Red3XFmIRY4ReqqqWneUALBafl8QAefb1hgwlzvko2xaYa8jTKBzAJJXjhCQTCOWI25yLeOkf4cm3wS2gP9bfx4+EPvsTmYxBsfWyhyVFGOCUOM8ejtzIC54/sjoGVFZ1WiyPaKAkKL78caiVwhq4q+6E4a54VOPYLVn7Yzy8QPTLkoc2+FWUyfZ+/FunsM6jgow2zDt4DBUDU5d2jmts1wnPNWyFMLQI6BeBBbMNq0gDO/8cmY/n6h8ztvPgs9br/6H7lKmtsOErRzp3McEJ5oi7SmO5PrucXGEvMO7cECAAIxadVc12HZ5phyAkHkTvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M07000tpieL4ZvGVIiMLI6SSfJtVBCWb7jlhUYW61IY=;
 b=BFpp3VcqRA8KZUbt6Ni/pjHDaimV5LcvgUvsBtPlL12OV6SM9eEuwe/K1JtKGR2cSvgdJrICiNV61hR+K0Pd2j28R/tZ+ZpG1HLqqn5508YjaSZimnVwFsx9r5YTgGIebtx2MFFHt0ScIvp7Cao0bqXqHen2xTXUaX4GvZmJjbR4UBzFEP+4lstbH3WvbL79AqMIlriUd3E38dpX0+/e57FpCjucsd2kEpzaNzEA816CiG97nClfExuXW8+uoT0K9xpr+ItTFLIwNMWXDWK+drFZyk6hcacE6drYyPCB/IeIO0+1fBzcyvJ0JTOcR14udd8QZsOcy2NIqK21GHYZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 13:25:58 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 13:25:58 +0000
Date: Mon, 5 Feb 2024 14:25:50 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <m76an3zrp375meemqdqv2tx577kwyjy6g64ain2wp2vvnyx4ex@zby3einmlszv>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
 <b341ecc8d1143932307708aff44ab90db3a91564.1707130307.git.maciej.wieczor-retman@intel.com>
 <81064977-28cd-10bf-6721-c5a0916dee85@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81064977-28cd-10bf-6721-c5a0916dee85@linux.intel.com>
X-ClientProxiedBy: VI1P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::8) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: 198069ab-85c9-4b22-827a-08dc264dfd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbKVTJUl7R9/hCVnkJwpEQdSXCzQMGTKsGXaFaVjm0AXTvyUUH1sGmN2un7QYBiI42gP5gPK+LHd4H84EUKvHtFczIzGZ6356LEPSq2nDOQ9hNfqmlHAnP953CFWOIwsWrgjjS/nmivrR+fI44oQsfatwwHe4jBXTkK9LUZLG2v5UjwGxRPnt+AM9CsE4y1ZSzU+i66KWk8TKTyqHFsLIvPBsKLs5ieT5eD/NmjP9J58Hdny3g4MNcggh4kpmeXM+OftumsEQh9ACf2r0LIN4n0AgaWWv8ZdNE+lFQKXeLt1xxZderHFCbS64phOd7o341eQ2hVnfZ1wGDxLOgbu5tS6WC+XmSDAkaERUxSC34bOv46pWB5Ch9A39DZzWfCdaPRXEx8C2rBADFwRTgA+H4nu7ijhcUBV7qE3RtzXa+nUiSaMDIlgdH5Alw/+eOtNMxE+MLW4IsruC1V/UoVJUp5wMXdZFbtusjv2DVld6SgZPkKkNFzdB5Opmi4LTxvIW4ddvAFYWr2+8N3zLdXj1fTTOxOSAilr2v0PnxCLotRdFVyFvujnCLyEVfeOlEaW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66574015)(82960400001)(8936002)(38100700002)(8676002)(4326008)(478600001)(6486002)(54906003)(66556008)(66946007)(6916009)(316002)(83380400001)(66476007)(5660300002)(2906002)(26005)(6666004)(6506007)(53546011)(6512007)(9686003)(41300700001)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fAOytU4HuRCu2uEMWa8teKisWYWsx+edIfVBedvjP4yqid8NUawqlamAsT?=
 =?iso-8859-1?Q?fDUPDZvA71F/mBlOhgaudKs66uAtFzQ86RJYE9fIJUwgjtnkl70E1FIIbD?=
 =?iso-8859-1?Q?LgYS4s6EQq81uKLUicPWPmG3PILj7tdb5amxSr1BBWDUWVmUQ3YYldQ1yd?=
 =?iso-8859-1?Q?KrIqWJi0il4Ddf2T3ajN+s6X8HcWNN3wtKDoqpVsFmR5xvVwELit5tyElZ?=
 =?iso-8859-1?Q?SnSsjGzEkp6IuEQCQzwinhlvW2jniLT5buGTfn10lMCJtKKn88J6RZRvIs?=
 =?iso-8859-1?Q?ll5tgDYbcpBwtW5cKS87RzsXe3OGCMcTt0GLAyx0h3KOESO5QjQ5Ofu3Us?=
 =?iso-8859-1?Q?Kltej760Mktc2NJiJwUQVuEb1iLALiUUdWBVlFtQ7URueXP8ItF/P6rFr/?=
 =?iso-8859-1?Q?kI6qMzKZosqShaYf0HmoUj3teuKUNcHjvp5umdKedqgMtjvFhXpfYbnUU9?=
 =?iso-8859-1?Q?a4045uqjytxGwdWHLOHQlgi2L63nmnvA2K9ztYiKbE84xzVjBCU68a5NAn?=
 =?iso-8859-1?Q?pI/1tJakG4+Y3x7eolebGK/NGk1+IAdvwL/klnOEYGNcO44X5n2RGO12l3?=
 =?iso-8859-1?Q?6QP1nMmr0V6jfXRj72jDlZHFtfKK78CSCdZ38ti6gXMWsjpIQH2YklmKW3?=
 =?iso-8859-1?Q?0K0CP1IpIGjL2j6wpWvOR0X7zDjZ6kxhZKn+y62rCkPXYDax5dHdCPBxDM?=
 =?iso-8859-1?Q?Qr2aqpD/v0QPpZ9vi3YBiD1G2G8vhC6AkDfkfS80M7qvcfICkfmRF3a5V2?=
 =?iso-8859-1?Q?OduN6Be/Bh5953gwT9OVujFhO3YHYl7swoH3tC+YvC/QkrimhzdRUjDwkg?=
 =?iso-8859-1?Q?s9Vbcbcwsrp0ZDQGZD2Dhm+0f6ixiZ+hb/uBtDGm1z9O2QhYL9d+gey4VB?=
 =?iso-8859-1?Q?bRacfACT2OuTry+AJfdhg2nG2zwgiA1VzDGABkn6HCoREeJKXr77fPOXna?=
 =?iso-8859-1?Q?B678VOHjHXEL+ZhRUHn7IVgQlzx6EPRAhT0dTPi/DAlMKfpanIq5FvReLc?=
 =?iso-8859-1?Q?equuNhwLSYpVhG+CIlzg6c4QJKYRdqD32hExnxdS3IfN4uMAjqImivJNr1?=
 =?iso-8859-1?Q?530eN96VC8fDr0tbpdkiRicYHYMt9CRwHdY56FYWW6ArP8HduQmKrk6u1K?=
 =?iso-8859-1?Q?1pMBMIK1kHRiaCrRUMQcA8L756Cc4Cf6MtWBqL+sGNDLVeD0cgGLxlaLCs?=
 =?iso-8859-1?Q?R1wePPpjAXl/9Fw0JMxpMiPYYawoRum7pPZW/6UIFH+VnoVvzKub1O4Nds?=
 =?iso-8859-1?Q?MCAgjXQ48Um3gOdOba5tQVBi9m7ERZ39Rf5W499vcM25Ig6dXB7d9JLCnO?=
 =?iso-8859-1?Q?blx0SxWIU2QeaYHQvtIudEQeWCybToKxLGJ3+4ii96GCY8GQDawtJJqtv5?=
 =?iso-8859-1?Q?irb2OgKTEO1U/5aHrjytoryvRDCNgtclJdrmFNWDPn5E7T+tBPzwp2N2al?=
 =?iso-8859-1?Q?nPLXSKElYV/+lK0oVLpOk3uBvgYVEP4dV7D/SVCLAm/4pc8AvwTB2v9Prt?=
 =?iso-8859-1?Q?61REeAF0hfVPqxvOprR7c0Gx9pDglHPoAUf0sBDuED234+mNVoLdLGEVEG?=
 =?iso-8859-1?Q?ovAr7t62uSiUs63h7ZPfC4aISmYAbWyYERGGKXVZU+8gCR4f4U+Td1fJIm?=
 =?iso-8859-1?Q?9pYaKFFV+EzXKZB4MxAIlCCD2Swp4cLzCDiZCJX3F4mlbBn0Yb+sU5I+yD?=
 =?iso-8859-1?Q?6FCP/cOJid8/DgVSNXc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 198069ab-85c9-4b22-827a-08dc264dfd42
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:25:58.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnEmFK6bbwQKD67n7Bre4EBs8Hla8QUxEhjpgQh3L1+QzR+0hi1sZhTtI1sSxHUbf0oida3n9YHQlhzFk6si/jp4YUGqbfcvKgl7uu5bdc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com

On 2024-02-05 at 15:11:22 +0200, Ilpo Järvinen wrote:
>On Mon, 5 Feb 2024, Maciej Wieczor-Retman wrote:
>
>> Add tests for both L2 and L3 CAT to verify the return values
>> generated by writing non-contiguous CBMs don't contradict the
>> reported non-contiguous support information.
>> 
>> Use a logical XOR to confirm return value of write_schemata() and
>> non-contiguous CBMs support information match.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v4:
>> - Return failure instead of error on check of cpuid against sparse_masks
>>   and on contiguous write_schemata fail. (Reinette)
>> 
>> Changelog v3:
>> - Roll back __cpuid_count part. (Reinette)
>> - Update function name to read sparse_masks file.
>> - Roll back get_cache_level() changes.
>> - Add ksft_print_msg() to contiguous schemata write error handling
>>   (Reinette).
>> 
>> Changelog v2:
>> - Redo the patch message. (Ilpo)
>> - Tidy up __cpuid_count calls. (Ilpo)
>> - Remove redundant AND in noncont_mask calculations (Ilpo)
>> - Fix bit_center offset.
>> - Add newline before function return. (Ilpo)
>> - Group non-contiguous tests with CAT tests. (Ilpo)
>> - Use a helper for reading sparse_masks file. (Ilpo)
>> - Make get_cache_level() available in other source files. (Ilpo)
>> 
>>  tools/testing/selftests/resctrl/cat_test.c    | 81 +++++++++++++++++++
>>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>>  3 files changed, 85 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 39fc9303b8e8..20eb978e624b 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -294,6 +294,71 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>  	return ret;
>>  }
>>  
>> +static int noncont_cat_run_test(const struct resctrl_test *test,
>> +				const struct user_params *uparams)
>> +{
>> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
>> +	unsigned int eax, ebx, ecx, edx, ret, sparse_masks;
>> +	char schemata[64];
>> +	int bit_center;
>> +
>> +	/* Check to compare sparse_masks content to CPUID output. */
>> +	ret = resource_info_unsigned_get(test->resource, "sparse_masks", &sparse_masks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!strcmp(test->resource, "L3"))
>> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> +	else if (!strcmp(test->resource, "L2"))
>> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>> +	else
>> +		return -EINVAL;
>> +
>> +	if (sparse_masks != ((ecx >> 3) & 1)) {
>> +		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>> +		return 1;
>> +	}
>> +
>> +	/* Write checks initialization. */
>> +	ret = get_full_cbm(test->resource, &full_cache_mask);
>> +	if (ret < 0)
>> +		return ret;
>> +	bit_center = count_bits(full_cache_mask) / 2;
>> +	cont_mask = full_cache_mask >> bit_center;
>> +
>> +	/* Contiguous mask write check. */
>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>> +	if (ret) {
>> +		ksft_print_msg("Write of contiguous CBM failed\n");
>> +		return 1;
>> +	}
>> +
>> +	/*
>> +	 * Non-contiguous mask write check. CBM has a 0xf hole approximately in the middle.
>> +	 * Output is compared with support information to catch any edge case errors.
>> +	 */
>> +	noncont_mask = ~(0xf << (bit_center - 2)) & full_cache_mask;
>
>To be on the safe side, I think the types could be made to match here 
>with 0xfUL to avoid sizeof(int) vs sizeof(unsigned long) related bit 
>drops in the & (although it feel somewhat theoretical given the bitmask 
>sizes we are currently seeing).

Sure, I'll add that for the next version. Thanks!

>
>Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
>
>-- 
> i.


-- 
Kind regards
Maciej Wieczór-Retman

