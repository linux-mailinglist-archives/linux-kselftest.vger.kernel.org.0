Return-Path: <linux-kselftest+bounces-4174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9E84AD54
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 05:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C136C1C233A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 04:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD8745EE;
	Tue,  6 Feb 2024 04:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fo+kT7pS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0FF73188;
	Tue,  6 Feb 2024 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192952; cv=fail; b=emIwpOfuov587tmBEenssNdJ62cFlT3wivZcstXEtcb3eaMZ14GVwNctmMZcRcILT9Qn/o/3b236vuSJV8Jz2tiW4bVmLFxOdPdcEAWj+tgEteVBhE3DowFl+EPntDcTTeicwKMhHzC8C03EXYchRU/ksgzH0NQXj2BoaN2FwXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192952; c=relaxed/simple;
	bh=ZWRw4yGiBmxWKN75yO1zeL+rD4t8zOJMfzVTQQy+rRA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UKFf/EiFmwc1otrAdGMzI1u1ZLsHuXaZUywM5A8AGPW8cNH6Axj5uPlvRVWtDTvWGnQdw8lkI5fwzEAhhF0huUHY7UN4U6RBV0IYQY5Sw1Zg1H8xKPeUQeUNeYoqwNlzCPdlNZ0QYcWtDuPWqkmhXKN8jAXMS1gT8lgC9kLqH2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fo+kT7pS; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707192951; x=1738728951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZWRw4yGiBmxWKN75yO1zeL+rD4t8zOJMfzVTQQy+rRA=;
  b=fo+kT7pSbqUA2ohxlwGyStRMGFP5QpILezRb5N2UbmoF7qJLVlS3jSo2
   NN5EWLq+3To4jqzFsDfueUdP9TkOi5W7Nx2CJGEhnXvt3O6k9KdMT7IrP
   CBT86NQyNh5bSiQ3nDI5BmNtKP2MC708Z2qv3s12U4sWEUgUrwdDRnvze
   91SSt+KoKLd/3s5DgSMb3hovlfgL/UA9m9gghrsSJRFDMEBXLgQnH4W3j
   jAkd/rdTqdVkxbToN1yF9gB/tiT56xh48xeALY0lFf70HsO7gB3pajw6n
   x5xwoF8QHD/JnnK/H7rRxdUBpNfYitta7d8k4yd7rQvoxHXZTjOkKdYQW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11308411"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="11308411"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 20:15:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="923329"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 20:15:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:15:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 20:15:49 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 20:15:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhxZQgz2ixRzEtqOj0EaTN0MzyoSlSH0ajrNpQCq8JtNxdRlYJuvaXbvHE2oFQSiVzb7wy2mQqjB7wjJovQRc6syCdInRMRnjD6FjcMPsOzJYUHaB9xjzbMhoXVf3PSn6ysvAF3neD6JGdZqnBlWDemw6tEnRFEcsCJbCaP8NCoESqRgV1zyqhEhPV2faIlodqyTjuyn1E7Luzsm71h7R+RGbFENRR4zo1UlDEGeFbA5tPpzuPQ3OFn+jdyiJGCzTbZWKPCoSCN3S3hwxdxYG6+DFWDNsjl5aPp4VYQp1XeauDrAa8wL9gaw3tsTqhDQHrJ8MMIOTVAsJrzqV4uT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIDHZ+hlXwVkL/JB9fgPwqAKyTuOY5W6SvKO1q5DJ+4=;
 b=MRpv25NEeoVhjerMZzw3P+Fk2SQDrIqhlJcVJYVPCS/4Ecs7qET+JaZpWSu/vxvq/lwGKtjhTVfeubQoT5NiauFccXYVNcEg/yhGPUS0dG0EyhaHRlqxpcqn/IVdOsrGb5b82DSs0x4628e7FoiHhX31KJXfdRrj68/ULlCt5lOo/IUn/znWNvH2Dc95h5k1LOSEls5y46kKZcpCZPni/W3e9fq5m1DmwL4DLOoL2BfMKf6oi0Y7xrX9q9IrjFKZccXz7V28+Fci9N49elaawaDpRGacktNgc3FOgj/x+y5rMduC+yma4yJajdaZhth1KUwS7Viee38sLRB8ZbkL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 04:15:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 04:15:46 +0000
Message-ID: <045d9793-5eed-4912-879b-9fff815077da@intel.com>
Date: Mon, 5 Feb 2024 20:15:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] selftests/resctrl: Add test groups and name L3 CAT
 test L3_CAT
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
 <4462d207c35c7d22875ab58be6aecb1a899d254f.1707130307.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4462d207c35c7d22875ab58be6aecb1a899d254f.1707130307.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a640425-1a6a-4671-3be1-08dc26ca4abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Skcg0a8szsoUmBi3HkAQbhDCZRMwoKvPiLsKCiCS6hukur0+JOptRpYE6e+KJCbZZzVNN3XDK7To7vwzOQLx6cPRyrBhu9ui4DmkiqRrz9aQunES5KidbJXcyHsPD6QBtn2S9dCEYcQOqsQ3V0McrA4kFZaXXxS9BMMcCLYqfUXA5y/KzdS6/MnVEV+BnrmHtkFtdkMhrc3olQ11LrsjOajD4ytX5bJs2bNSXUKoRFBiqrDP4gdt/BMelZE2Yf6RMeLReSMpmbeaDb4Wur+h+uJy2yV3Cr2ria/WvZYeAmrlD2NPWvXdIxrHIUxZMaiYbNXG9A7hO8zc2Vh5xEKI0KzrTeOYJrQrjppx7ZmLDjmyNQmVM56YM/4fWF4+aoCCEqAm9uxtnAt1Wj77yKZ2WN58xyMixDGDYA55j29vspZtJl71WDr0mePPzydeW/h0KcA7T9BKqjh/HVkYQ2RXDwxwWe7QQjzVo1tw4VHqWeF9UHKWa+nBjBJ2HmgKtB0fjcnaV6cqTOKkispD3KGDItEDv5+TLFK+VZQ6aFKLPSkn0dyHWKYSA+LMxI0PrbORQMCQAaNBjW7iWWH2hds3FCJV2XTKqT4NtxBOEY5sprK8dX3nPo7rtXd/giuJTcMSeJZvMGLnKjpje62s1Rd6Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(53546011)(6506007)(6486002)(478600001)(26005)(6512007)(2616005)(5660300002)(44832011)(4744005)(2906002)(66946007)(66476007)(66556008)(316002)(38100700002)(4326008)(8936002)(8676002)(82960400001)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anl6bVFta1NxeDF5Z0UrYXRaaGxNZFVPcEdWV2lIRDZGYlpHUWErUzRjNVpZ?=
 =?utf-8?B?R24xa0o3akYxTmpuT2VSWE9FR3lxakw5elZsQXBjYkh4M0J3TytHZFVZcDNK?=
 =?utf-8?B?Z1JaUUpGOEJFRWRnOWtjVDFZU2dYaDZPaHVUWHdocmRROHpiSThWTEJMQmI1?=
 =?utf-8?B?ekhJQk8zdHB0dkJFRTA2NDV5VGhEaDU0dm9QcXpkOHJJb2NtUUkrQnNwU0p1?=
 =?utf-8?B?RVlIbVF2MjlMbXc4NUJXb3QrMml4YXFqU0VBdFFXTkVPOC92RkVqbXpLR2Fs?=
 =?utf-8?B?NThTYWdHRTlxdS8ySUZBRENROGRPVnd6VHErSXFEaTBobVpuQWVQb0tVaDU0?=
 =?utf-8?B?L3FLTE9rK0laY2k4cG5scmM5NnZSODZqR3FldXNsZk5xK1N2Y0Q4bmVKZERJ?=
 =?utf-8?B?aE9RYUQ4SHBRT09CMTVndGJRL256dmhWb3pzN3RsTkMxcmFaYnd6SFJtbmxv?=
 =?utf-8?B?YUdYdGZxRWlRRDJuWERFaWJvNVQwRWVFV29yTkxPK0hIL0FxbXYvNmJORy9F?=
 =?utf-8?B?Wjcvb29iR0s3MllGdkVmbUV0ZFFPMVhQMENrYjRJdXpKTUpYTFhSZDl6SWhX?=
 =?utf-8?B?Zm5SL2UyTXVMVXpsY3RSekh6V3h3RkVOUEtoSU9LcTJwc3J1czdmaXkvdXhq?=
 =?utf-8?B?TVFvNW8wMkxZQzZ3ak9VdVI0ckVDVTFmZzl4TFhVdjJVWXpRdXNzUEhqN2t2?=
 =?utf-8?B?c2pWYUorUVJDYXBIMHZqcEZ4MkFIeFhscDdsdjY2OEZJSklEbmVMN0tUTGdO?=
 =?utf-8?B?cUZqNTVrb0ZBRTljYmxMOWd5eG1CVVkrZ2F0Y1VDdUFsNkhQZlFZeDNwN1Zr?=
 =?utf-8?B?N3RFM05DaXVRalZqLzBLd2s1TlNkc3JkeFYwMkEyaWtNaTAzSGtSbW51Z2Zk?=
 =?utf-8?B?TElRVGwybTFvNmR5OHNLUyt0ME5LNTNuSm9qUHdVNlJ2THJqTXF2Zm1FSG80?=
 =?utf-8?B?N2NGeWFKUldNRkdqa3Nzajd0QUFmWktIQTJrV0NVU1c1WkNzMHpvelNXVXoy?=
 =?utf-8?B?WCs3TWdDdE9VOVp4VVozajVKK3FMRjgrUlFNSUY5cUhnajNYMnk0bkptSnp1?=
 =?utf-8?B?aXlpaEs1Yy93bmJxbnMzWk5EVFVFQVIxd3NBbGVseHhseGZLamV4Yzl1T0Ir?=
 =?utf-8?B?ZE1NQzhhU29wRHhOWW1oUkZYRGhDRTN6Q1Bxb0ZIb1VKOWhaNFhoR1ZMQW9k?=
 =?utf-8?B?dXNJZEJtV2hrT0VWUTlRRm9HS2xnMnc1aGNXUkNNbHhtM3dQdUwwbFhmSXdr?=
 =?utf-8?B?b2JObDU0bmdQdXNlQS9ENmxxYkRibGcwRG00VTJkQVozWE1tVHcwM3JTblNl?=
 =?utf-8?B?OUNrR1ZZQzRhSzRSblkyL3g3dzhneUxwRXcxOC9rTW9tTG1lbnJSMUl3cmpQ?=
 =?utf-8?B?emx3ZmZiUUVqK1ZTOXpXVTgyQ3dneEVvMVFkVEluZUZvb05vT1dvUWl1Um1v?=
 =?utf-8?B?RFhXcEM5SWVHWXlqenpaVnE0Q0hET2tZaFRiU0FjZDNWZlp1OGpWVjdmNWh0?=
 =?utf-8?B?NFdMWjVLeTJKUTVGTFlYMzhBRTVQY2c4RzZuSGtIMkZRVERvM0xFRDliSzhB?=
 =?utf-8?B?cGRISzRvcENtL2pXQVRlM3lTckczZWFEdjdJV212c2NlaXRSVTlVQVBuVjFW?=
 =?utf-8?B?aklPc0dJL1M1NmZaR3JjbFlsQzJzeDRSaXo5UDhOUHg3RFlHMDkrWG5CejZG?=
 =?utf-8?B?MVNxUy82YnBsclM1ZWlrSDdXeTByc21ramVqc0dFQTZpRzdhZEJyU1VJS2Ns?=
 =?utf-8?B?bnM1WkR3ZkdRVDdpSy91c1pVaGlsNTBxeVkrQ2ZxY1pqckd2Y3lxOGRJbGVi?=
 =?utf-8?B?YTYyQkNKT2RBcHNTYy9FUkxRMVVzRTM2MGNQTFF5eGNGY251YVR4Qis3dGRI?=
 =?utf-8?B?d0xQZEpxejVsNTlqVEs3azc5R051STVhUWMyM09udzQ5dk1kWnpKSjY5V2VQ?=
 =?utf-8?B?VTFrUXBGQjBMSjdBWlJlN1UyMDRoRjczUzNiSHJ1NVZSMmZLbWdvUzRRS0th?=
 =?utf-8?B?NElDU0JaODNxZ3Q2QVhoWjdObnd6NFN6OTZIOWpXcE1NTXBOaWVIV2lEM1VU?=
 =?utf-8?B?WnJTWEc2N0xaUzF3cHJnWVU5b0R0b2JQZWVRMUxEeDNZQjdrZWVwSFRWWkVB?=
 =?utf-8?B?Wm8xSzhGdWlUdy9GeFkxZ1dxenhUNk56SklWaTZJYXRoRzR3bzkzenI1K1RU?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a640425-1a6a-4671-3be1-08dc26ca4abf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:15:46.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaUJZwsdmLO+Df8UvJTTepGF9mKEaahOZw2e18GA9nnU2yDMWNZbptmMY9AFNEibHSIo1Qnyj7Kb4nqJoygNBPFqvh0OS8GNcCw5d+djBlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/5/2024 4:07 AM, Maciej Wieczor-Retman wrote:
> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> To select test to run -t parameter can be used. However, -t cat
> currently maps to L3 CAT test which will be confusing after more CAT
> related tests will be added.
> 
> Allow selecting tests as groups and call L3 CAT test "L3_CAT", "CAT"
> group will enable all CAT related tests.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



