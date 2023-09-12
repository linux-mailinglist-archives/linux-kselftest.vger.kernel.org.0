Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B179DBB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 00:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbjILWLH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbjILWLF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 18:11:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E331715;
        Tue, 12 Sep 2023 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694556659; x=1726092659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vDoVTMUsQLTDKaTLmLQixmILXt9cxnBquvoWfJkf5dw=;
  b=bUtclqnAAL05+dFGPLODyJaQM0EcWDQRugztrMJl+Blf/kTPBSo58X+m
   phDF1ZVkkF05sxuGov8ux9bAQJXaCSKRo2tYjZbjnEWSd2fYm3MAcgzaC
   ykl2NyGTcAEK5Dxp8otelbITpMGAonbhpvUWiOSCvk87pHyOQOHKH2jQL
   1BIgH2pOQhfBQlP8/DLAuFsd7kA6zYyyb4nhN6lt0eUW0MElDSDDva9rR
   gXK9+bxrXmROKDzaW35LaF/Rh/8y/RyezVUAOfwPT6WnXPbeNuhUc+6xm
   3mSMFShsS89C/Gq7CE4S4NmbJC24ddS/FUIN3SI0DiQLEr+Zb3ZgaaNuq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368771371"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="368771371"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773206876"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="773206876"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 15:10:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:10:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 15:10:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 15:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7dSsOJ7TXAYxDz0/sIXLg0N11I7kMPfhbbIUbD8D0I2uMq0nDZEWZKmTVOkcF+CX/c2iCesqHDBEk1KZ8taF1D3TGZUX9WHXLWArB1I5v8uBYy/uVxcMXUNLOtYQbAVx8+zYE7UtwP8C9banLoawBiJxuuET2Wd1e55TvjIVf0ejGY9gHodCUvllw2RfVP8BRWiaLorESpoP/tgvUtUfIQab+LTB5vq3I3lvIawi/Ea3WU5QzOWkWfTR0K4SKc51qCX2AvQD9Z/M143DAs35Rls13oNN43cyQCD18SoqcfCXaiRCjKni1aPT8B7yYayXp2eik7j0ZdfKNkIVcDbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IgaWjW4JhhL4MJjI2nE9rdwlL+6J6FIiRWw/Io3jkE=;
 b=IKuFfue7cu+du5Gml/PNr8jv9ajnYYO/7vYAi9eX0fHwF06NFqIuytL2pEO7Gacy4lh7VIN2xzikxrMB/pVxJdmwMcV3eXYHoSmeJc6AZj/70BHKGSuuwP1ZVMdQrM1l6GGiLRXU2UEVxfrwb3YQEbgH2hRjntclF0/z1HlDQDHcfIzgNqAdwe5XoaBTs+QSPc4yDDdjeKcXbBvYNGfDXRGhnZtClTGo2i4fDjwY3DiHnluAGzhRarZWH7CcvV+jFKhkKkwFrrI3zIag+EwfP4QpLYwSGqqeGRnmlDVytwOvT9mq1mHVZl27cUNVtnHAAbzWukYj9T7BfcuhViNK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6029.namprd11.prod.outlook.com (2603:10b6:510:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 22:10:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 22:10:55 +0000
Message-ID: <cf7439c4-f72c-a145-5a65-84ae15c5d96f@intel.com>
Date:   Tue, 12 Sep 2023 15:10:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 5/5] selftests/resctrl: Reduce failures due to outliers in
 MBA/MBM tests
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
 <20230911111930.16088-6-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230911111930.16088-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0069.namprd16.prod.outlook.com
 (2603:10b6:907:1::46) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: df7db4d3-d090-4567-1c2e-08dbb3dd229c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va5kg+lOQCmMtIOIEQy3ziZlF9WDDv7CzK4qCewJcuFGlQUrTjfZHcgiSbsXq+f5h8T5vPcawnzriVJXQEE0/+2+s0TnSqK3RXtwEKfpGD8ZLQBcSNVbQPsqmlusKvwbzJPAVpD5TWhhYWXb9j2HdiPLQfGUwsxHmFRGAliMHTEfeyUQAJ5yx2gpX7Mva/bpqYCRujrR0bczFRChkUHWObx/X3VF23DmTrw3D93daqAviVHhMzZYnyKw4lenc2rPBOAZctmIpAhkZW4Di6PZ47nC4IGKDtFgoLVFlkujPQ3TRAs3goTsoTUTpZ5Y/zHiiJWlu3XJDAaiRl5ethrlKHHsJMDOoDoktBKGk8+Ta/F7GmCZ3SgDJTR8sWUcs2aU6J5hyJ44Ioh39UjKfh5LWcSBTPeEL9VdK/+I2+k1V9/g3uQk9E24k7P7pgX8gfsnJxszGS7Z8CYxzX5QM9PFiqX5MyRWenLrHsF+HgOOr6et/FNfytqI9MzirgwOlxBpq2Gs1MH/LtwUqMkrV++uPVU0IzMf7h2qW5lges+csOpW/Amypkpw3aH9Npy2JFv4ikdJxvrzbhKIVmvbhmSEaf1RlW+flBnlm8ED4rqy6wZ8hUzmerK9rPORMTfxiWNaOJAkEVPU7CRbqza1L58R/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199024)(1800799009)(186009)(4326008)(2616005)(8936002)(8676002)(478600001)(6506007)(66946007)(316002)(53546011)(6636002)(6486002)(41300700001)(6512007)(110136005)(26005)(5660300002)(44832011)(66476007)(31686004)(66556008)(2906002)(83380400001)(86362001)(36756003)(82960400001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU9Hdis1Uzh1N2l1Vlg0TWRNMS9zSW9walhod0VLNGhQcm9qNHJvQ1RXbkRY?=
 =?utf-8?B?LzIzdERqMGNaNnNVYm5KVkFiV3dwYU5zemI3NURlMHVkZnJwamdjc0NSZHVH?=
 =?utf-8?B?QmM5bVZGRjNaaUJDc2w2M3dLbHNiTHV2cVR0RlhRckU1SWg5Wm1sMlNTbjZW?=
 =?utf-8?B?ZjB5SFZianpORlBmenZIZFlaZTIrSU9iV204N3EwUlB0ZUp6S2J6OC9uMVhS?=
 =?utf-8?B?UGErNTBtVzg4aG0yNUJGV0RDVWQ4MHJ3M3pWMGhlNFEyZ2NGWGZNQnl0bXZt?=
 =?utf-8?B?VXRMbFczMTh2b3pRODI3eTRyNC8xTkZJMkJVdjNLMnVwRHlIS20zS1lJTHcv?=
 =?utf-8?B?VTVHVnloeEhUNnZuRXlGYnA2NFVsaVdmaTR2a0YvWlhNZ1ZWRGNEMUdVUmwy?=
 =?utf-8?B?b3N5eXlZWU4xeUluNkNvVFREMXJMZ1lFQlE0a3NtazYySzdIaTdReE5yQlIz?=
 =?utf-8?B?b0dZQTR2QUlDK0E4UlBvTFRZUWtmQ0lMYjc5MTRmcWN4Zm52bjNNdVduZmUv?=
 =?utf-8?B?b2tWQlFzdHIxL3hDR08ySWdHWjdYcHpvZWQxZzNIV1NDRSswOTNOZURGV2hT?=
 =?utf-8?B?akdWUlREM3RNVzdwZEFSWkxZYVFPa0ZPUlEzS0dlL2Z1NDVlTys3OHpRNUlY?=
 =?utf-8?B?NnFFa2xBeU1GQ3VOemtqSEdhTEUrdjZ5WFE2TkNOK2lHSFYwRlEySXhLV0RT?=
 =?utf-8?B?bm5KYkNxR0tXYXVGdFdRL1NjS1Z5S251L3lDY2orandiWE9WSVhhNUhndkR6?=
 =?utf-8?B?dXV5MnF2L1FDZENlL0wweE5ndkEzc0ZxRVY5T0dYRGxkL1BHTGszSS9KWnp6?=
 =?utf-8?B?OFRPYXhSY0JQdXVDUngwR2dSZEJhdWNab2Q5Yng3RlJwSndTamhxYklMNVkr?=
 =?utf-8?B?b3l6ZWJjbUlwWjUzRTNMajdPUTB6OGVFS2N1ejdBWlRMSGdLOG5xRkpia3Fo?=
 =?utf-8?B?bFdtd3BPdVFjVTJsdC9qbS94enU5bC8waEJBTE90MFBhWFJNZyswdG93aGhE?=
 =?utf-8?B?Sk1oUnBDQXYyTEoyUjZIVFV2QUp1Nkk2UjRqTkc1THZIRmJPNDlkS3h4bE4r?=
 =?utf-8?B?M1owQVFUNjJJdTdVakdZWFJQSFFwYWU0RVAwemFjSzI4ditIYXZITmtMaE1r?=
 =?utf-8?B?VG9pKyt3ZXo4VUdrQWdNandHWlBWWUtlZEdZbysvNmQ2azh6SVR0NFAyY05G?=
 =?utf-8?B?bXFGOHpWYWFDQmNWZU9keUFPTWVvOXJiSWZhcUtIclZ3SkxqbFBwMXRqZzIv?=
 =?utf-8?B?SlBOdW4vNFM5TkpZVWRBTlc1a3FLUWxYdDJkeTFEbTNSL0VyQlliOTRZL015?=
 =?utf-8?B?MEp2VHJkYWJwWWloSE1HbGlGQ291T1NqNHd3U3FLV0huSm16V3lYYmJBWWpp?=
 =?utf-8?B?S0NlVkJQVlZNTmovM3NpOVRvWTRvWHJHN1hhREY5YjkrVlVBMTl1M0JSV2VI?=
 =?utf-8?B?MWZuaVJZVlA3ZDRydlNTaUVTWXQ4UUhiS1QzM2V1M1ZOY2szOVNXTFRZMWlH?=
 =?utf-8?B?VkxLcXVKaGlxSmhjckhYQkRvMzJ6NHJOVUZsNWphdlVQRlpGNnNkeWMxU2x2?=
 =?utf-8?B?WERlcFVBWlFmSFVzWEVrOVNiMVZWNXRNdHNxUmlWOEVlVklEazBsLzlZSWFN?=
 =?utf-8?B?VFcvMU0yKzlwRWtyQjBBdnF3UElTSVc2dGpVeUFlQjEycDIvdnhLVFZpY2VP?=
 =?utf-8?B?aU9iSTJjUlpHRkxDVFZWVyszZGxzMkJ5MGhUR2FJWFY2RnZ4MDBLY0VLbGp3?=
 =?utf-8?B?bXo4N2RIaWZhVjdqQkN1KzNGdmM4UkQ2Z1VIdlRZZlRGblNaL3FKWE9nMC80?=
 =?utf-8?B?TzBZbFczd2FiSjh4ZUpveXQ2VjFnTXlCOENKbTVDc1diUnF2c2pmMHFsVVY1?=
 =?utf-8?B?YjVHbW5lRFd4UWlvYmRhdXRHZDhnWkdtSTVuMHQ5aWp5SllVL0pzbzJKUG9I?=
 =?utf-8?B?b292N3NmSWpwVmt3V1p5cjhiSlR2RWdTZ05Nc1QrRjd1VzFFc24yV1NVNEdU?=
 =?utf-8?B?YjdYQVE2Rkp5ZFM4SkpBVGRnZ0E2dGVuMkNRY3o3RnBFamtPamp5c1k3VlpF?=
 =?utf-8?B?UnB4NkRvOU9FanVEcnE0azBrS1ltb2k3bTdlSVQzaWJlSCtDcDR4WTV2NE1O?=
 =?utf-8?B?V2lmcll1eDMxYmhmL01HNmEyRXAwUklkNnVSNjdUWWhBNEo0RXFkOXVRdFh6?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df7db4d3-d090-4567-1c2e-08dbb3dd229c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:10:55.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zliYG7JFMvcpOxtVFBX1FXIvZPRhKPDEm3YzHyKSh6Al4u2z6x1MUGtsCQ34TfmxRStwdSvI0wwY1mcM5o+M1wHgXDg530Ww9AdPUeMmHOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6029
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> 5% difference upper bound for success is a bit on the low side for the

"a bit on the low side" is very vague.

> MBA and MBM tests. Some platforms produce outliers that are slightly
> above that, typically 6-7%.
> 
> Relaxing the MBA/MBM success bound to 8% removes most of the failures
> due those frequent outliers.

This description needs more context on what issue is being solved here.
What does the % difference represent? How was new percentage determined?

Did you investigate why there are differences between platforms? From
what I understand these tests measure memory bandwidth using perf and
resctrl and then compare the difference. Are there interesting things
about the platforms on which the difference is higher than 5%? Could
those be systems with multiple sockets (and thus multiple PMUs that need
to be setup, reset, and read)? Can the reading of the counters be improved
instead of relaxing the success criteria? A quick comparison between
get_mem_bw_imc() and get_mem_bw_resctrl() makes me think that a difference
is not surprising ... note how the PMU counters are started and reset
(potentially on multiple sockets) at every iteration while the resctrl
counters keep rolling and new values are just subtracted from previous.

Reinette
