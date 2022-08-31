Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479A05A8740
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiHaUIf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiHaUIe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 16:08:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF4CE319;
        Wed, 31 Aug 2022 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661976513; x=1693512513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bpPnNUq+ihQmaEmSoDXdo0lFeyIqi72N/mkYG94/4w0=;
  b=I7yWYT1kiQhAMA7tu/58jTYcWNGP7mQe+gOwXikA55pNeOrEq39ce/QD
   0eEMuimzI4xMYZHZl+9a9ewf1etkNEZOCUtLN3luvKLIEH+LjCAHF4JJ+
   zWGpKulfEqcUeANvL+DawmHRkcQdPstZC47WftlwH8LiULXISCVNyHaln
   VQ6U10nuAfnx/hMrUI6K2X3A+rP2Pe3qkIQZ5WzyY7F4FA+1nkOxYAnME
   TmlJqqpVGRDgH5VrX7ucTe2gFyhwp0BP8zyk4hc8fqDuK1tr2rAr4pkHy
   sOhGLl0sqSltAlZqVNHaGCnw24D/TdejWA4GjRslRzWiHCmAmxGklJy8T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294274380"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="294274380"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 13:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="787975341"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2022 13:08:30 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:08:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:08:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 13:08:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 13:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7KwJ6+ALidpX1MX3Kjtz7uHNWAFcu6uNZ/MrAvYc8pec9fkuXqb04Omgo2UfhukQ4DGYSywsh3rh3bqydxCQteDShBhUzTGznV5Q27RamlR/3oaksnAUY6zmuDdFSlekyx7zr6m+YdzLKTwqePaHU0PopiYu4TZWpTFu2PmAHWygOIsZzwTO8I61SIjFojMYNud0ZI80TAN2OPbub6JCuqq9z4ycqJUk6wZplrmTqMx/+/nkiAL4U/NzieYnwdCYnrrI3WiNHHDEuVc04/dO5fM471nr9yAZIwVYin5LA0U3e6rnoILR6YvTGR6RWJ2gp1HD6nFMmf5Nts7bxEEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWyNuVZtS+Hke1XOpv8wRR6kIwE6UHir/lyH486NwBI=;
 b=P5cbP/zW7wks/4wmp0cJXwoT8yDVAe166uE30BPtIUtPCuvxCh4kijvX4NWCmSyZREMtxk9ET+j8VkWN8HEE/+nzC3j2gB6LK1tmJRfZilL2218oihCkhbMBTlKo7coIpTLnm3bo7+BP2DMOe3QwX4E8oKrXMrLjsMpIpjO3TltiEaL59GvMMcTUGSaVYO9dgMxWlVYxf13Ow+pDOBPbVBrNZsbpbVgkAL/J1MjAHa/T0h1vQzLzEe4oCJKeBZeu+6UIUWFM6OvswaM7XJ5nbB5bZ9N3dts0pebe41oiBoRXG7XxTBP+jN8csNdnZSFGWy1TthfV/S2kHWe63fIjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB3116.namprd11.prod.outlook.com (2603:10b6:5:6b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 20:08:27 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 20:08:27 +0000
Message-ID: <75e0121d-2d24-4e72-8514-412d1fd0d23b@intel.com>
Date:   Wed, 31 Aug 2022 13:08:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v2 5/6] selftests/sgx: retry the ioctls returned with
 EAGAIN
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-6-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220831173829.126661-6-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fc76224-8ec7-4354-8ac8-08da8b8c9145
X-MS-TrafficTypeDiagnostic: DM6PR11MB3116:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFNMI85kElujLd1a2vEHwGXVMdYurv2nlLKOaoBdcmM6oy9JkrlJVO3XhTKbRUfbRpqAOuaJQQ/duMyBEEI7eYbQYwz+c/8Fui5Bzq+B74evNjLJ9cPuR9N3TL6yCJ1cf0KOzdxNHO7CCV507gvsUsM71wOocl71M+zj3v0hBgYCDAFO3wFOKENhGVSKFMHHNmSKkdMYp54lsaBApHqPj254hnpQDpKuFrGat4oqtJRDLsygC4He0pa19DxFcYWXr5QdOKVKDUCYbL5zkZ9It5clSQociBQs6xTz9xJu8CYETHZ2jIigtCmCMBOs6Mc4TUwczybjxBAJRKFC9FHgr7KMjfw41jAHL52AwHMNFcGsw5Ve6LVVyeP5WI91kYK5j3UZJ94mOWm48rrR36s6OXPoOxjb0whOP+poAjyOvCTEjdvF+P8nAmFd97/gBHe6IaSlwMHibaLr0sejLPZZw9vTCv671xZXRcZl2KLD7/hGuFpr7Yt3kfVdpdDubJ+lhI5lZBwZVZZr1Jujg9jBguZS1DNVqeuba0DFPQdeJxr5zQyAOcqTmYb9q1KgkPflxGMb/VCaIVcC71aaAN9S3LYGDzlaqN6DApOVQ+Ft704UjmRwY2DctkCtvmqyPxc1AE5c4oR6NeHrnaaucMj9wdBLiXUhW/ipHKtZP6QkWCMc2Ax98etCnPiL/NZlKxsrBhfbPrSRXjWQvMFRaujsxhPnu4J0w4ykVu8DkJVmnoUEYCR8/GcxvYYBQB4I1P30dDM8gbnwfsaPaWZYg+azOxFh9nyi6+y4+H2xVH4c0CM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(346002)(396003)(376002)(31686004)(66476007)(8676002)(66946007)(316002)(54906003)(66556008)(6486002)(4326008)(31696002)(8936002)(5660300002)(478600001)(36756003)(82960400001)(86362001)(41300700001)(38100700002)(6512007)(6506007)(53546011)(2616005)(2906002)(26005)(4744005)(44832011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFk1cWk5d1lVSTFSSlVXWkE0elhYU0lmbFJwNTRBYmZLb0M1U0ZuYU1zYmJT?=
 =?utf-8?B?bzFVUFF4N1F6TGEvOGYxUmhpdmRkZTl6Q3lZREFLdjdMNTVJSkhRRUlrbFIr?=
 =?utf-8?B?VWpiaDdmNlVoOHZZVStLY0FwZ2ZzdlhYTjgvSk1Jd1k5SVlDNHUwdmo0bnEy?=
 =?utf-8?B?Q3F4eUZLTmxpMmlHMDh0N1ZGNytlWlF2N2NZZHdUNnlXWDNkbjkxeERmcFVG?=
 =?utf-8?B?TGJhN3ZPeFVicFN6RzNKcndPbzI5YUNvQXZGbWhDNXRFSHF2dU5ZeDJVa2RT?=
 =?utf-8?B?UThSbEtIUUFON3laY2F0aEp3N1g2N1g2Sng3YVo5bGxPdHg1UlZiVU5ON3hR?=
 =?utf-8?B?akttejJ0elJJR3p4M1pnQWwzbkFyanZTZy9Fby9tSFl0T2MzNFVLVEVLSUx0?=
 =?utf-8?B?a1U3NUV0OU4yai96MzAvbnRabWJsV21nbnlzZlZCd1kzajUyU3FDU1ZTM2Zo?=
 =?utf-8?B?clBOSE12VlFOakJpRFJYTzVxUG1JYnVLRG1XbWVwZWpNZUt4UFBqS2NKclM4?=
 =?utf-8?B?M0Npdi9BNWlXb0ZKbTB5OHdMcFJzeGZqZ3hDaEhtQTNRdzNFMWpWMlVIVHpm?=
 =?utf-8?B?dlpKWTNVTnNNK1FYMG1qMGRmczFkS0tpVUxtQnlHR3JETmtXRWZYR3lpME9s?=
 =?utf-8?B?NThWNEl5K0E1LzRTYWlzZC9mK0Z6N1NGNnFPdUsxQ21kOWZPeVV4YmthM1F1?=
 =?utf-8?B?OGovUzhyRlhYQVp3SnVBLzJTOWZqTmd1ZkswT25xQnJzczVUWUNabHlTdDFv?=
 =?utf-8?B?TVFRNHpBVnNHa0lKYmhTSVNPNkpqMytsN0lIckg2cEFSSGEvSlUyZlJ4OFRT?=
 =?utf-8?B?eHJGVFhnODBvOHdxODMvUnZzWlZWeWU3aHBUcnA2TzdEQlk3SHgzV3F2N2Yx?=
 =?utf-8?B?RHBUQUZPZ2pFQWhpWWpHK2ZJd1U5cVFNQ1gzck5WOVd3MlBmRk5mWUlyczlm?=
 =?utf-8?B?NHFOaEtqNDlIMjJ6T1R6L3JpNk91NGpuSVVYV0U4ZElkbUw0WklOQlQ3Wm0x?=
 =?utf-8?B?azFybVI3ZXRuR09McEFWRURNcC8zUXM4RUd1ZGNYMjVnSHRTa25LY252UE5v?=
 =?utf-8?B?eVJjbTZvU2FJZlZ3NTI3R2d2aTE3RjZvcThsVExWcmZBaUFDY25DR1NjVXpT?=
 =?utf-8?B?a2tVbHhsaFFZY0VrWkZ6VmpIMkR0MldIOFpTcTFyQ0JqOG9mUnIrYkt6SGpO?=
 =?utf-8?B?S3lqOHV6KzBabEd6RExxR3cvQ3R1VHU0OUl6Z1FSeC9CK0dLWm5vcmVodW5M?=
 =?utf-8?B?MEtKenBzcDRoSmxKNUdyUGI5YmVFV01pMjZ6Syt1SjZzZWhOd3ZaMXY0QTlm?=
 =?utf-8?B?RGxRczJZQ1JVZzhPWG1aZEN2U09PSjBEZ3oxSE5Sam5mZStVOFhaTGdvYnZB?=
 =?utf-8?B?WEdOVkhHd2VqS2YyZ1BYOHgxNytuaG8ydjh3SWpQWkFERldjNWFvNVptR3Nn?=
 =?utf-8?B?eXBXbUsxNk9ZVlliSDRJYlliMEdMSkRIRUpRQWZPOUM5eGVGZ0g4Zlhrbitm?=
 =?utf-8?B?ZFpiSzlwWDVzY0E3ZTlIWmZ5YXZhaW45YjFibEorQml3OHRLNjI4RHpuZUIx?=
 =?utf-8?B?T1g4MVRlWE9jVVNTcytZOE1HMC9iNWdOUzIwalNXY1lHL0JlS0lYN1RIWnJh?=
 =?utf-8?B?emhmY05SUXp2cndWcVFFcXkwT0RnWlRKRHp0VEZBV05RbUszTVlzOWVaZlQy?=
 =?utf-8?B?M2dDY0hQQ1luc2xQOWlpVGhEMUJIQXgyWUpHR1IwQVlGUkIyZ08rMUpsTHFN?=
 =?utf-8?B?Yzh6NUFnOGdwbGJxdHdqd2t5dUlESkVMTklUWERWZEpVM3BQZFExd0M0ck1M?=
 =?utf-8?B?bFBDS2xsZzQ5YzFwUDF4YzArOVRXVEN3d2xRSWRZbzRZOHJrbndGcUpvdXpn?=
 =?utf-8?B?TFg0dFlwRXp4RTBFRjE5dWpvWXJJai9GRmNYMmR6MHhlZy83a1dCODlOQlFN?=
 =?utf-8?B?bXZLSXhEbk9tbnNwaStONE5GRU9LamViZmZPS003K3BBSXBMeXQrMkZ1QU85?=
 =?utf-8?B?b0czTjRqVjVHNmtNbERBZGxIWFBOKzZjdU9lMnMyTVNveU5HMlhqRE1SWlp3?=
 =?utf-8?B?WVdQR3pTNFdKWmVSN0dIQUNvTDljeWc4M1NRbmRLUzFTeUsrOFdxK3h0eXkw?=
 =?utf-8?B?MTEwYmhzZ0UzSUFObTJKM2ppVU5VVDlwcHgzNnE3d0M3Ymxod1FFTDhVWjVB?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc76224-8ec7-4354-8ac8-08da8b8c9145
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 20:08:27.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjCNbGqiQIUZNUBZm5Trm3X0IPCGqb1c0s9MpTYPrO1MS0LYWY1GFr4xfK6g24X0t556sPJidNpqCH1BnXN1bVKk8aVCCAw5XD3f1zsHzu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 8/31/2022 10:38 AM, Jarkko Sakkinen wrote:
> @@ -458,16 +459,30 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
>  	modt_ioc.offset = heap->offset;
>  	modt_ioc.length = heap->size;
>  	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
> -
> +	count = 0;
>  	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
>  	       heap->size);
> -	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> -	errno_save = ret == -1 ? errno : 0;
> +	do {
> +		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> +
> +		errno_save = ret == -1 ? errno : 0;
> +		if (errno_save != EAGAIN)
> +			break;
> +
> +		EXPECT_EQ(modt_ioc.result, 0);
> +
> +		count += modt_ioc.count;
> +		modt_ioc.offset += modt_ioc.count;
> +		modt_ioc.length -= modt_ioc.count;
> +		modt_ioc.result = 0;

From the discussion in V1 it seemed that you were planning to add a check
on the result value instead of just overwriting it. Are you still planning to
do this?

Reinette
