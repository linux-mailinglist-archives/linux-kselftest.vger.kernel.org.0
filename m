Return-Path: <linux-kselftest+bounces-4000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03A846DC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 11:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684441F2798C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E57CF05;
	Fri,  2 Feb 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwZ/ti89"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE347CF17;
	Fri,  2 Feb 2024 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869095; cv=fail; b=IKtIMVINBBVEIbBHCM38lxwdSaHgTE8n9xMr7J417Nxatr2R5dphluXpa4Ody/mEsvgu/FkaBsM3pK+dSiECcm/zAxyAoumnJNZ9MY7M0LEJh3vKijrM7WBGEn58xSmMZBr+Y00uwxtWXbX4GIiU8hGI2cxIHhE2nCOvBEnAXgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869095; c=relaxed/simple;
	bh=ioRFD6sIwS/fqtSPK2figSJC7SgphB44LaxwUEJDto0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Aj1I2VyMmNR22xAAFNjIbhtglQ83nHtlt/oCqf90A2TIpf5qY86eJLXKdICWMQ3ijY/88uYioi5/9D64mXvyKKOrsL7iioj4NLwtFeKWXh4h/89cw7Y9O0qvrJ0steN5NsMHp/qEynMow50TUE4Jad8m8qYrOh+B0bnFJ1kAaCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwZ/ti89; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706869094; x=1738405094;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ioRFD6sIwS/fqtSPK2figSJC7SgphB44LaxwUEJDto0=;
  b=MwZ/ti89KCRmg2IVYXtbRg9qD/2GWBrbsyHmOvap0m464xNrV1SVxnxn
   2Nh9drvh2LGBouPBbmVnAKg6fgSIgQ5vUXGEst1FLlV2kgiJKp5v5AaSC
   IHwJRRiiHZ7Knpf03lu3rH1c75ND7DUrQiksPtr99hSXEeyIRnv+k2ohC
   aaFHuBUgSlH90h+oM7UVKdFkXDNEvbkVOITV5SVFpPzfYXrknBDgVXUgL
   9f1lQGSqxDJJPmkXEG0V0phmCAbdLULz4nlmN6XzEYrDrIT2odbQVi/3C
   LPS+wYmGw/cgX1ACSUJIiGXFDD4nCF8wbfTKkG3Fqbml5bLLzz7exYQBD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11228896"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11228896"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 02:18:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="328998"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 02:18:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 02:18:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 02:18:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 02:18:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 02:18:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko3oGOx3/DsT/F87Z+k7ranGSs+pIVrJrMbswp2nnJOGCdm+e5MS35n4SJjtqCnY2uURSWS+9HnLIaT/9twe8PBj7itdFlTQ9t+W3VAo0EoLHnPXrqdP5wypwxCCLUpZTxFjYNNrdf9mdJJrEjjLfk9BV4CvlmZhnLjY4RWe1Rdo7JeYm00AJx9PrzPP6cOCxvKaHO879Q/+IFM7cPhQuixXk4oHjCCH3pTK/NROcQ236At2KKH4KP9U5YzYwgvl6XdH24KrwHlIUDWjcjW7B5jO3L4AMHlDbnv7ywGOntk/7vGJs+xMVG5qJEMUUo9989Z/Jq4Jfikf4NUN/MlWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80Xz9NcsG4Np1lwlJgzwasbW+S3xEC66PI97PCCho4s=;
 b=b32eKSSi+gvJzD4ir63OndpLgZl1brSAa4f7QoRbR6AATqnCjeuCCcvhyJi79e9lEz0UHpdgNoVAxeBczsPkNdNiCPtKnT6U5f81XZuh1BAah5tHUzZpUSzXSpzGo218N9UcSAnH2c8kOezzU93SQ07P92ynpubrDdXzVOgFnHea9EJ/Cgz+l8KXMoTzECYsduLsXrjjGQ0mt/tjMNAjMSYad6QU/CAxtECvZffFnm0HRHIm0RZ3yJ1MN8efOj54YWe7ZF/G7n/rDz5XH/6lRaDkrsXErxVWr08Igu9GUnuzJAt3FuaL5DvQGhk6h7WQvWqRYpk7vP2e+b5BCcaDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5007.namprd11.prod.outlook.com (2603:10b6:a03:2d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 10:18:06 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 10:18:06 +0000
Date: Fri, 2 Feb 2024 11:17:57 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <icdfnbyc7kvt7llxc5qq5i7icmuev5us3i4pqapyreqfmkkztk@iqsthvhf2uem>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <647fbfd449f8b0e0ad6cfe58bb280ff44ee162b8.1706180726.git.maciej.wieczor-retman@intel.com>
 <db08ba56-ae73-4c70-87fb-aae59e524238@intel.com>
 <jbgkiwfkotntcdzhwf27dceit4w3j37sumkayixmyuee6zyaqg@un22a2iljgmr>
 <6a7b14a7-966d-4953-9b9b-0c847c83ddbb@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a7b14a7-966d-4953-9b9b-0c847c83ddbb@intel.com>
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To DM4PR11MB6239.namprd11.prod.outlook.com
 (2603:10b6:8:a7::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: db964d2c-32a2-4a8b-b235-08dc23d83f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VlMbqpHH4w1pUO5obQQprLyBwHIcBG/gi/9k4sWFynhh0Taa05mqPl+MB1ihiir5URbBwY//g8ubPCXNomwzcZq1zVhe5mA+2F1kILN+T6n2rWCP5evGRIUrr8sBDKx6nT3S1vhKsAHpWQCyt9/XnjawAO5J4sB3D78uPzMan+eYgKydmhGuYcPJv5tmxJoG6g4pRIHPMb2oWwrHjTZW/EAjoCUTftUbm6B3HbiyVcaUrbn2WPw+gxvsVcJU04wgIYInqVdMJu+UlnTkD8+2RELn93mkgf+7BAsV6ssAvxkYtu1xh4Efjg/kFz52uQd3hzAEAHZ8whj+BDKJz5KR4eLAgCrDB0eaUaBYxPBRDSG2ChxCYkFVIndQVKq2gxvwg+fhM18ur3Tbr39CbaCb3WtUsTG9Uw1MoL2V/2x1QVpTO7fX92sVvB2/1cYBgtWEB3i56v603V+hy+a4vhOICMVTBaB3c0036yULLBs92hqr4U0lGFYX4r5Qi13C/36fVU5T5bjegiiYlpYINXYDt6Gb7AMI+j2ERjmCMRdkuxW7T8NWZhq59FIu3F52WAN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(83380400001)(9686003)(38100700002)(6512007)(66574015)(33716001)(26005)(6636002)(5660300002)(6862004)(4326008)(8676002)(8936002)(6666004)(478600001)(6506007)(66476007)(66556008)(2906002)(53546011)(6486002)(66946007)(316002)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pQ3su7gUGzccgoMXwQ097PXhwxIsiOUycQYTbAqhMFp9ghh84vdVHyKMGn?=
 =?iso-8859-1?Q?znOb2KrGNb5qtdNG3NeArm78cHtW02NwwSjaMjvv1TIJLsUER5k/3wtKDM?=
 =?iso-8859-1?Q?lhLEqBq+dsfsM42apT7nNj//yRjfe6xWxbYWh1Jt6yL1iWI1Lu9alWCorM?=
 =?iso-8859-1?Q?zEzKis2X/U39GsC/uqOB60Y1Bplp8awb3LaTw8dqMdHB/TDK84aHC2H0PA?=
 =?iso-8859-1?Q?DHNDTHcFitPTZAKzYMV1qBAfR8xy4mZVxORBcU00bYlZvoOcOqAP60OR5e?=
 =?iso-8859-1?Q?oexIEjr1xf8cQSiG6dkPOz/smJ16jd2DVB7ZyaggZrBLvgvA/CYR9IGcmu?=
 =?iso-8859-1?Q?ZLTnxknyEeqnh2kKR1quefZJ1f5haOClAwEExrbMBBV7QL5LgX9FAysRq4?=
 =?iso-8859-1?Q?mVEwROf4xJLpSRY6KDJMsWT96TBlnmXE5Vw4EgTuZgGJoEVprmjpw2UuR2?=
 =?iso-8859-1?Q?MgMF31bqjxViYrTRmNDVNHzFXYtk3+4B3AwvW/7lHGt8t0ByWLBMcz/g3o?=
 =?iso-8859-1?Q?yRlPe8WzsMpa6NQWB2AxIZOJ7DNcqozv1ALt296yYxWnzlNbOsrKxauUFG?=
 =?iso-8859-1?Q?WAdnmiXfMOnIpY623eG257jmI1XBVeUBqDb6508jf2SHTBGYVvsZ8Tt/dS?=
 =?iso-8859-1?Q?P/6DnOljl9ppJ1c+ca7ykdNnmKrDDxiHIaOutbvpuA1ntDtNK343kS9NdG?=
 =?iso-8859-1?Q?09d9p4HywqHXQkdk+Jiyjjm8U4hm/ra7FDQTwmcHmZhVhUBYqRkzwyouW2?=
 =?iso-8859-1?Q?fnOYaFkUVeRyUz3V/8qtvBdD1UDfP54BjCc6/ieg/hnYuxMxzQvfDwdkBZ?=
 =?iso-8859-1?Q?XkSP/SyCE38CuGDHMjzAh420YVoeznrnd7HNryHmdW1PMKPHAZ1lOQbYBH?=
 =?iso-8859-1?Q?4iYrmfu/NGgtWzzHomkP3GEEKum5X88SQsbCkTSoBwlTh9GuHr5yHAq1Pa?=
 =?iso-8859-1?Q?QtPjOyvsXjPgyII+r1J/ku/Ku9+mXV88A5QrFcvssWA6ZlKlGHi0ERfwIA?=
 =?iso-8859-1?Q?vd9nTdqy+yEQMGCjgWliFA/S42QNyvYcM1IYK52fe/yAJ2/R4lxLQzOidy?=
 =?iso-8859-1?Q?h2x2WkijCGr3GxI2Lr6ptGrKAnwRlPc4yuLneqGapw4zRYzEJIGR1efnkk?=
 =?iso-8859-1?Q?ELzQS6VGts6mA71dHPR4Nm47nbx6QPHg+R53+tAl34LSZ7du71DmM/olVG?=
 =?iso-8859-1?Q?lbH2X0IW+YQttsOiq97v8SvHI9Jgm/zNZyoXw/eQL2jdMv9hva6ZXjrsNU?=
 =?iso-8859-1?Q?MEhkJoMd5uCi7B6YbpaEwoMBUNZex6w5P51Ha1cV8PA7GOpmjxg14/cv+H?=
 =?iso-8859-1?Q?JJHsPNAdL4uTfikNHdOfhQg2wdXXuRBc/N795JoeVSe8l8pYzDu+IRxvJo?=
 =?iso-8859-1?Q?ENKHt/v/sqxPu7PywuF1TchpwOno7H8ICnq1FOxffw/L68gWQn9KJcj7bI?=
 =?iso-8859-1?Q?CaobLZ3yIC/eeIWtjwa2Bbuudo4tZH2BRj9kHPgHuHc54iKbHx07pJedA+?=
 =?iso-8859-1?Q?msxYjBR0kR5VNpxOTaQNtFctFX4dng6qMTJTb8bJJa7D1LkYwxkmm26U80?=
 =?iso-8859-1?Q?HBpp/wR7bHAbvSG4p6vjjhO3bt2vHs5RkeIeb8v38NCOfBBG4LG2Cz9acr?=
 =?iso-8859-1?Q?R7xjb+qYeO6/Nsyw9Qwj/fxdgZU1OI+/9HmyCr25Q6bW0eT//hCSVVQHEx?=
 =?iso-8859-1?Q?Coh6wsVVlhjFhNcSGXE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db964d2c-32a2-4a8b-b235-08dc23d83f21
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 10:18:06.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGA6htMmsD01en+NxmI/Vh6gEvOHpQH2qCJhChm0R5jxpCN5lEkKbZxPcjRItjmpAW++YL5kQIPz9b/mFDoY+RlkfkV8cZRII0aVWm8CPPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5007
X-OriginatorOrg: intel.com

Hello!

On 2024-02-01 at 11:47:44 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 1/31/2024 4:55 AM, Maciej Wieczor-Retman wrote:
>> On 2024-01-26 at 13:10:18 -0800, Reinette Chatre wrote:
>>> On 1/25/2024 3:13 AM, Maciej Wieczor-Retman wrote:
>>>> +	if (sparse_masks != ((ecx >> 3) & 1)) {
>>>> +		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>>>> +		return -1;
>>>
>>> If I understand correctly this falls into the "test failure" [1] category
>>> and should return 1? ...
>>>
>>>> +	}
>>>> +
>>>> +	/* Write checks initialization. */
>>>> +	ret = get_full_cbm(test->resource, &full_cache_mask);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>> +
>>>> +	/* Contiguous mask write check. */
>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>> +	if (ret) {
>>>> +		ksft_print_msg("Write of contiguous CBM failed\n");
>>>> +		return ret;
>>>
>>> ... although here I think the goal to distinguish between test error and test failure
>>> falls apart since it is not possible to tell within the test if the failure is
>>> because of error in the test or if test failed.
>> 
>> Is there even a distinction between test error and failure in resctrl selftest?
>
>There is such a distinction in the current tests (and from what I understand the reason
>behind the logical XOR used in this test) . In existing tests the running of
>the test precedes and is clearly separate from determining of the test pass/fail.
>All the current tests have a clear "run the test" phase where data is collected to
>a file, followed by an analysis (aka "check results") phase that looks at collected
>data to determine if the test passes or fails.
>Note how all the "check results" return either 0 or 1 to indicate test pass
>or fail respectively. Specifically, you can refer to:
>mbm_test.c->check_results()
>mba_test.c->check_results()
>cmt_test.c->check_results()
>cat_test.c->check_results()
>
>> I've been looking at it for a while and can't find any instances where
>> ksft_test_result_error() would be used. Everywhere I look it's either pass or
>> fail. By grep-ing over all selftests I found only five tests that use
>> ksft_test_result_error().
>
>Yes, from the user perspective there is no such distinction. This seems to
>be entirely internal to the resctrl selftests (but I do not think that this
>should or can be a hard requirement).

Okay, thank you, that's what I wanted to know.

>
>> 
>> Furthermore there is this one "TODO" in kselftests.h:
>> 
>> 	/* TODO: how does "error" differ from "fail" or "skip"? */
>> 
>> If you meant the distintion less literally then I'd say the sparse_masks
>> comparison to CPUID would be a failure. What I had in mind is that it tries to
>> validate a resctrl interface relevant to non-contiguous CBMs. If it fails
>> there is probably something wrong with the code concerning non-contiguous CBMs.
>
>Wrong with which code? As I understand this particular check compares the
>resctrl view of the world to the hardware realities. If this check fails
>then I do not think this is an issue with the test code (which would make it a test
>error) but instead a resctrl bug and thus a test failure.

I also meant a resctrl bug. I was thinking about the kernel resctrl code that
handles taking the CPUID information about non-contiguous CBMs and putting it in
the sparse_masks file.

If there was a hardware problem and CPUID returned wrong information, then the
check wouldn't fail as sparse_masks relies on CPUID too and both values would
match. So in view of this I thought that this check could make sure that the
resctrl kernel code handles CPUID returned information properly.

So should this check be moved from the "run the test" phase to the end of the
function ("check results" phase) to signify that it's not an error but a
failure?

>
>> On the other hand writing contiguous CBMs shouldn't fail as far as the
>> non-contiguous CBMs in CAT test is concerned. So if that fails there might be
>> something wrong on a higher level and I'd say that can be more of an error than
>> a failure.
>
>I think that the write_schemata() can fail for a variety of reasons, some may
>indicate an issue with the test while some may indicate an issue with resctrl.
>It is not possible for the caller of write_schemata() to distinguish.
>
>> But I'm just saying how I undestood it so far. If there is some clear
>> distinction between error and failure definitions I could try to separate it
>> more explicitly.
>
>I do not think it is possible to clearly distinguish between error and failure.
>These are already lumped together as a ksft_test_result_fail() anyway so no
>risk of confusion to folks just running the tests.
>I think the final test result may be confusing to folks parsing the
>resctrl selftest internals:
>
>	run_single_test()
>	{
>		...
>		ret = test->run_test(test, uparams);
>		ksft_test_result(!ret, "%s: test\n", test->name);
>		...
>	}
>
>above means that a test returning negative or greater than zero value is
>considered a test failure and resctrl tests may return either in the case of
>an actual test failure ... but from user perspective there is no difference
>so I do not think it is an issue, just lack of consistency in the resctrl
>test internals in cases like write_schemata() failure where a possible
>test fail is captured as a test error. 
>
>I do not think it is required to be strict here. Keeping "test returns
>negative or greater than zero on test failure" seems reasonable to me.

Okay, so the approach I applied in noncont_cat_run_test() with write_schemata()
is acceptable?

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

