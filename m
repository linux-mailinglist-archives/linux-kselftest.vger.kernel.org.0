Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C094C6EB665
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjDVAUZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjDVAUY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:20:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3E826AC;
        Fri, 21 Apr 2023 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122820; x=1713658820;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BgL72AAtI2XRakTGTom6xh+RBsHerjZi8Gyau6FkHfU=;
  b=jsPuTn9+fPaGGVlWV8ptdFTlHIp5UKWdkZHVZ63zDKizBjNn9OVegvka
   YWx5f6LNhn4tE9DzrFjxb+cCcpQD/OO35emmuF17DAHf4U7ZrZOH7Q68+
   FHtdIrCUziJ/UAcK2etQsR+TSqBxrbYe/vkvLreH0JF4dH28Xw+vo13qj
   kKlMxzv8U611s3+IrBTPGk+QgbbwpSbmqZq5/8cjk7ctgOd1srLJ1a2iv
   qyh2ZTjGvipSOA1r/bBFCisJSq4vkjx0q7goDfPRzocHwXQrREXiaftZy
   Ir4ybCGMSpL2/KM5ZW2lUWg/xULvbkb543QPtiibSZFy+qvFMZR3vx9jX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348906495"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348906495"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="938672176"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="938672176"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2023 17:20:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:20:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:20:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDlbS4lvmBbTumJDxPIVLlWifztQJKGJAuaGkH4A3i+82SFny8jUkwuJ7eQMlmwsime/M6cQYGjXPbPOGgCng4YlWHZrl1X11SLvO9v+u04J0g87GkOOABInCLYEprkkwVlYP1jjCfMKX7wdTuqnofN3zFcEsZiaMOs4g1Dm54R6YmqyZZcmPkKzdJ6Rwtx2sS+UAFIyANueQsHD3k5iSubltYD95I1KjuxvBxhqYXEV8iwYQr7NSw7IwiOS38ipphH4z863h5Qwo4jT6+GcGv4/yBCcHHWnuJ5Mf2H9lRdynTWscN9KnTHB2x/+beRITo+7MVG6zmW820me1nXP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1elTTiBoFWuWot3+DGbuc4ZUeNTcGS6NzF15v2NaHOA=;
 b=GZ1jvvk5xQSUxR8NQn9tY/BtOcfNZvLM0p9KR3FhqKJHhpzfyvLU7TJgzQYUsnnpUBLGdLk/CWA5bp2YhJhFchW6MODdIjVnimxd7f50Z/FPtEqEPdVPoj1LQ0Y+Gmts8CcK5DSzx5TDm9jkbBdAyFq3gcx+X/c/bBWc0uF0HkeBaG0LCZYP5dyi+JgiAFaTuIDiPJ7I03DlwGyl/LJMRhu7ZjGPCfSd1/SY+ViN9Sov++XjdktMW8bKF+zfx+EdnY+I9uql7XtSfs8iV4rDT4MOMKUM/+1m5AlRGNcN53+doqZpFHgnwfYET7MMz+aut0KqoymwQ5KvnS/4aKwbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:20:12 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:20:12 +0000
Message-ID: <455c986a-0d51-0302-d5c3-c6c0f1cc6bad@intel.com>
Date:   Fri, 21 Apr 2023 17:20:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 17/24] selftests/resctrl: Replace count_bits with
 count_consecutive_bits()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-18-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-18-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:180::40) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 075d0fa1-5a48-480e-de32-08db42c756c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7Urg66PISKDQgeaKnPjLn2jMuFJU1lQF8aGV9Hd2qkXR7GQ90bUFcTF61/jjtGs5JglalBSWRbai49nSPWB/0sgYtp+BokUKmFrKh45SdW9X8uAlIy6UGjiMfYWtMfF7btgUPurLkWw4czU3XxNBwhXRMdLRcoPX/AbQU8QwwwnEl3gRlfo31dSllLYrKrrBa6pIKFa25BK7HuUskYwuy49/uShKGpWxMPDqVekttLu8cc0lAUjP/OX8GLlU5IyF+Cjo2YwxTSVNW4uG4/z97C9vjnjeobSvav4h6PR+S58TI1mDeisy7qyw1gN5sJe5P1H3fMFBJBkkzm/XUE522HiwC0NUhOCnTMeLnAVhIemF6F4gapzsp0OOZCxtmpPe3/vIODzOa5sEPqQHLQ8xGKeZx1b6v3A0UpmfplhOK8lGCvDKa40enQ7KsupVBj2GASzz6z/EbXAydP5KL0fMn6Wv7izY2PmQgcnxpvFzxor8uiobBZSIL9lZAY6gyjhGEUHZdvJT8652Y7GFWZtXEg3gEib39bIVpkQegAZBmfzy+qT8TVcZVw/tfpmgs585eACyHlI8wH/vrNn4NqHZjXF3VfoTpNMtPylJz9S98Ga6isg9nl/ZGSOvn3NbKS7uSOsDhbCs3iHmXbf99whvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(5660300002)(2906002)(4744005)(41300700001)(82960400001)(8936002)(8676002)(38100700002)(86362001)(31696002)(6486002)(53546011)(6506007)(26005)(6512007)(2616005)(478600001)(66574015)(31686004)(186003)(66946007)(66556008)(66476007)(4326008)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVREQkMxaWZoOGVmVEJWUVBzUGx5ODlseElPZnJBa0JqZGlrY2lZTk9rTmtY?=
 =?utf-8?B?ajJrTTQ4d00rL0VtanNOK05LZk81aVVXM0hFMXBPVnkvblhibmY4YU9POGVq?=
 =?utf-8?B?Zm5DNzR4UFZTNHFLU2ZiSEN0cEFTNmx5elZWUXFxR2NiSDQrUGJPZXgwZUIw?=
 =?utf-8?B?cUJqZ1RaSlgvNDI5VTVNajFodCsyampxWFdkajJXVHNIT2dtSEw5eDlacGxV?=
 =?utf-8?B?R085RERTWHVMRXNTRE96QkQ0K3RBK0xXR3A1NHRuNnYydURwVURqUCt0N2Fy?=
 =?utf-8?B?WHBjMlFMT2FraUZLOUV4Z0NEREZhdHduRTAydTNPbVRFMlhoWVJ4KzFWRUVL?=
 =?utf-8?B?VUJaTSt3K0hCK2lpOU5EQVRaNWlOcEdlei9nWWkyYnpnVWY4c1hoWDk5aDZM?=
 =?utf-8?B?N0FNTU5wMDFSNlk3V0NBQ3phMVA5WlRrNXZFc2tUczRmTERVUUQyaitkWXZs?=
 =?utf-8?B?aS9PTzVnZEVsQVd0Nk9oeStPZjlhaklqTmtCZWJkRnQvRXdzcjNua3RLaHRE?=
 =?utf-8?B?bEk5L1dsbytLL3drWUk5eEhBMkhtRHpkMGx3SlB2ekdHNjdLNEF2K1N5UkRs?=
 =?utf-8?B?emhJNGJyL1l0WEo5QmRDQTZrczA1WXJaZnBGaXo0aUQ2dnVqZHZob1czREN4?=
 =?utf-8?B?YVJRM0ZSQ29FOFQ3cmRxeEx5SWFzdFlZL1hVUkhCMG9XWjUwL3RLNmM0bDVR?=
 =?utf-8?B?cC9WT1o2ZXhyWkVOVDg2RFg2NmdjdGE0Q0JQaUZ1V05vR1VDT3BHK3l1bk16?=
 =?utf-8?B?eGpHWjNMWVZ4YnlCdFNjSGxhQS9VQmRuK2ZGMFhCeDF3STJnWDBrREZMeVUz?=
 =?utf-8?B?dzNqcmY2WU82ZWZ6d042RTFaMkY5UitwRFVvdU1LNTJUN2RIZW1UeW1XM3FV?=
 =?utf-8?B?R1dCaWhsOHNqMzdqMFFGNzk1UE1mOUFJSXpVZ1ZCZUVsblc0UG5XNmsweGUv?=
 =?utf-8?B?bG1EYkhyT0xoZ0hkdXBDT3hpcWhPejg4d0pjTG54OWRZODNLdStHbU9xNFRY?=
 =?utf-8?B?NDdsOFdrOGpZWWxWVW9PS200L2JXeVBlVGQyeFR3T3VaZ2hzNjh0eEpQMkFZ?=
 =?utf-8?B?OE81RmM1MEN5bHRROE5WaE5JbmNIckdOWDNwaVVmMWpMM0dNVnI4TnpuZzFJ?=
 =?utf-8?B?NWM4Szl3cXB5enlkVUM1c0hLMEFQeVVHVnJrLzlrak45Ny81M29PbHROSjdy?=
 =?utf-8?B?dThDYm16eTIyVDg5SVRVcnV2RG9aSWsvRTU2b0dTYjQ1REYvK1pkWFFZRWpC?=
 =?utf-8?B?NWhuTDdYT0NBSmxmKzc3OGZGQmlENmRtSnNWTUZObnc0cVlTZ1ZhYWRlejBr?=
 =?utf-8?B?emVTY3RDcHZ3VFN5S2FqMXRDZ01zV1ZNRDdSYjJ6YzhsbW5WZncrc0d4SFE2?=
 =?utf-8?B?ZGdWVTJYaFVzTVFxUmFuTW0rdDQwc281eHdxejlIdlZ3Y0t2U0FsdVlGVmJv?=
 =?utf-8?B?VEJuZTBGVUZaMi94b09qaWEzeUJkaGZBYWtuZHN1aXNPaHpBSUdSQWluV2xj?=
 =?utf-8?B?cnpFbklaTVNiTkQxQTlKUE9ERGRkOW00dld6TFRCM1ZSNU9EeVNoSExxOGxY?=
 =?utf-8?B?RVpEdis4L3FTSjJMUU1mVUhNVlZGMm1Bd2RTY2VkejRxK2hNdTE4a040dHZV?=
 =?utf-8?B?TFFrcGx6TS9DYXU0c1dpZnErcytTVStSN3pBaUNjMXRHMUpoSlZtUUFKZDhm?=
 =?utf-8?B?RmFuRFNhL2RKWHJLOTRvcUpoOWlzd1BVWGRtb2lIeTIxTkp6UkRLRm5tR3pB?=
 =?utf-8?B?WG9xUm1IR2tVV2dYMkFqUVduMEk4dmJYZVJERGlYa2h5UDRicjBIYWhWclNx?=
 =?utf-8?B?bGpPYVRHa3VSbWVFbE5kZVVjSmNZZi95MnkzMUhjdWFBNUhkT1FnT0FWQU8v?=
 =?utf-8?B?NGlIRk1FTTlEdnRIR2F1VjRLSU1peDJGajVtZjRQTkxFdStWcDdxcU55c1dL?=
 =?utf-8?B?eW40eFZud2RLWmszakt0azF6UlRtUWFjSHRCTmNhb2d1dXEzZmh6anRsSTlY?=
 =?utf-8?B?aXVvcDhja0xZdlpWV1gvSHkxKy9PaFNab1dlekFCNXAvaGxJaXBqSVhwVHV3?=
 =?utf-8?B?WWZ0UFlEbHAxNFVwc3RrVEs3RDBOVnV4UWRNUjRwY2ZobForcXRVbDU5STVG?=
 =?utf-8?B?bnZSbHpHU21BL252TlJWUTRLQWwxbHNpTEs4T1p1SWFjcmJpc2YzMmkvbFFx?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 075d0fa1-5a48-480e-de32-08db42c756c9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:20:12.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sknO0RBlroRVs6jiIttzoegiU2ujmQDgs0PqnDhPHfAylxoXPe0dWZipu4KEBpyYf8OBPmXVYfBWkOGLpWNp6FGbYv3+t2NGKJfQDQoeELE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> CAT and CMT tests depends on masks being continuous.

The term used in the spec is "contiguous", using it here
may help to convey the goal.

> 
> Replace count_bits with more appropriate variant that counts
> consecutive bits.

Could you please elaborate why this is more appropriate and
why this is necessary? What is wrong with current solution?

Please note that cbm_mask in resctrl will always be contiguous.

Reinette
