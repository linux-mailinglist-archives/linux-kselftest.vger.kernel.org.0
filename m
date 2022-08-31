Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F875A8745
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 22:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiHaUJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiHaUJi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 16:09:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C25F14CB;
        Wed, 31 Aug 2022 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661976568; x=1693512568;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P6NZIMRn7fapW2/7DT7i0ZQp0iqw1RkwP8YIStXHwD4=;
  b=cw4kOoKx6aBEDodCTuRIEB7sZ6U3I17ybhDY98rMQDKzKRtG6+/lR2u0
   dNuevzndYkh5m7cAGsk32OxUr8gpY6f0vnTdas5VajLb/FTMm+HflghwJ
   RCz8KMaKUtgdT0RFVQ3BqNX6pTL6mI6MrK2fXCeMUmYkyVpNLgIwPApXa
   TY+trK77zR56a7PrqmvqlsIcAB38vpRaz7Bg32qRe10elubxpbPSg/SVw
   9Gbpn1G/tTmy/cHWc6ToovQy2bgsO3nsjlF5XwHjxGbwQcckFQ2cnPbmW
   7hMekFarSQVzzhH1K0A6+/GFhGJAziNhnkOtWqe4FmBkB9o/ha33fblzb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="278552317"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="278552317"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 13:09:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="787975577"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2022 13:09:27 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:09:27 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:09:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 13:09:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 13:09:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK71aqe8VHzn5k+aOkhJtqtYdBclHacwWy/N6BpAlPXPhD9Y5ijwA8QM9qkZ3gNYiWSi+xMNtsrq6oQfkUGzgBOe79zXdITBhJUW6cJMGZqnJCFweqFzned4xbWTK0uwwGWNlauRPjXHSaFTqgQKC8yxZX1FJnVHGqXuJWGQfPaG3ILV18BXpe8u/rxRtB1P/8LkLIndHyrQ1urN9XHcHIJDSXh0IlaEXXohq9khpAivXqWXW8AfdAXnxETaxQX0fMuIaccJks2FJ9HlCBWx9QMy4TnSEqKcKv9j/r50c76RULUIT/haE5JE6+TRqmfptIc0nySxFgbp67YfTDNbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcrw34C0MzvgAmpxVkSRTwkEgfEcUEbs5H07/W2drQw=;
 b=ZjRMIth4Fmb1NetdJCL2uyvhiebIzgz0aD+YQEg8b+8C7+3IIZJX3B70ipDILS6NIAIjzPsITq/ocx0ervRLl1b/5ZRQk9c0so14bd2XiKkYIEgBMS+WMFonMCF4UUTP14yBtrtpG30cGUlrP8+PjQQrdNFJOg5eqkMXwAzvJqF8q0ZIvi+jJIdzouNQkH8dQfvoiqKuJQnAIFrsedqO52S4lj3KD3NxKGleICkBog6prmVZWDAaj8kZWnF1NEY9nUnrWeImfTN3XRq1omXdRtGLndLDxqP4p8FGw4yGLL0TGl+G2sTC7PQ+vd1vAhDHz4H5rflQOAZnmVIMppUynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB3116.namprd11.prod.outlook.com (2603:10b6:5:6b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 20:09:24 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 20:09:24 +0000
Message-ID: <048cdd4c-0454-1fb2-ebac-3bdb4cde792b@intel.com>
Date:   Wed, 31 Aug 2022 13:09:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v2 6/6] selftests/sgx: Add a bpftrace script for tracking
 allocation errors
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-7-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220831173829.126661-7-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b02a5ab-0498-4363-8eb2-08da8b8cb31a
X-MS-TrafficTypeDiagnostic: DM6PR11MB3116:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omM2LTgGQkPlwk2SxPwdFgBeZLggBp19ZxGx1fHkfGi9GoVLsTUjQFrXw++s7UWyFAxXa4am8Kz79ghTx1uINlQh1vK3qPCuCCP+YWsq3n5Wvhif6dQbH8xoZF5cMUYQjLQFq/S2VtZb6r3tvu7mVEOuJnzblSX114fTZ0OXUkR8tY/WCTO3iyIXMo8C//DCKst5AkLzGEIQfGQKMkkZq43Gt79SkciO4xinFlShUtfNSQ6zkOG7QUXYOMA02WS6msa+yNUbb/LixHu8L/TzbM9PCoiT/vzGfthS9IUxwQ/C2F1hbgLvmfU2lSYlhqbrLRaHzupYp7h1jfn2f8ovUTJYi6RzhrfHW8qL41A/OmIb+YKedFIkKByI+uDCaQnzKld78LocI6+gAU/Z+Xruh646jPZFpz0dMHq3iVwJt+iM3N7g1oelMM2uUXPDTmj6i1Yrr62LZ3ipWcnzArpaZ9nmoH7dLFRGy4apku6csTdthnqvftpA/ZH8AJlrQfUNTW+zfBJzspPkN03X1QTfCef7sWk24rerMqDn+/lkIxkkE2mujwrroBImJRiP1LuPKTxkPvgQlJrQ2LU/ge8+7y+1+QAotXFjpoa0RfulOaJrup3d3xbcMM/c3wPnaSHZ98BP0lGvONEyFkqHqslnx1UmnyEbXfJF84NeKpBgq8fyt5oKDq2O5gBSGtrRGhTAjLJp2c6AsKnXaaD6o6Yqo0M9T3KrbMzXoS0t1PUvpNHtJ2CRoZg4+/tVviaAMaXhEGGsBSoPBrBPppzBUH63JGIAS9kfxmwvRBdD08381gL930HDrBRxLPPPjPUeXXrCH4sMXVZfe/rwRs+rrzooEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(346002)(396003)(376002)(31686004)(66476007)(8676002)(66946007)(316002)(54906003)(66556008)(6486002)(4326008)(966005)(31696002)(8936002)(5660300002)(478600001)(36756003)(82960400001)(86362001)(41300700001)(38100700002)(6512007)(6506007)(53546011)(2616005)(2906002)(26005)(6666004)(44832011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUpwak42bkpMa216VHZRbkQ5ZWlwQU9aUnNXeUxXeFpCVVNnYmZsOFp1c0VB?=
 =?utf-8?B?d1JVYnhyamp2ODVlNyt6dUhuR1pHMTBTMDNlMXBvMVpSNUFGMCtCK0pUT1dU?=
 =?utf-8?B?WXdKQWhPU1pnbVdnMFE3Q2hZQUxCMmNHTVZtUFZwYk8yT29ZcUpadEhSNW5L?=
 =?utf-8?B?U0s3Tnk3TkZsRkhSRkJrbEtScEFpWEx0bkY0Ti9RL1BVbmQ1OGpYLzhZcXBS?=
 =?utf-8?B?a2hDaFUzVktlVUFDamR6VCtWNzU4aG5NYklwa0JnQW10Z0hwTTM4RlJKM2p3?=
 =?utf-8?B?czFwZHlmdkQ4Wm5HekRqYnFUSWtXS0hkQ0Qrc3l6Zmc2V2U5MjU2VkFaRTdn?=
 =?utf-8?B?Mkc4aHZwZHFMd1RFZmljeVE5T2c2ZS9NWE5NRVQ5VExPYnZ6cndmeTM0MEFM?=
 =?utf-8?B?TGdLNHBQSi90bURpRGc3Skg2aWlmUEUrdHl4bW1xM1pTVGZkTmZsRE5OQmx3?=
 =?utf-8?B?ODFKTnR1U0VBbGhWRGM4OTVVbWE1NTU0Nk4zdzI0TktlTTluTlFrR09qSzM4?=
 =?utf-8?B?V2l4eUt4SjJ4aDMyK1JKSWZWQUI5UjROQXdURjVxTEJPdE5HSzhLaXc0K3Mw?=
 =?utf-8?B?Zmt5dnVudWFmQ1IvK1JpQ0RoUkgzemVzemFNMFBpbGUzblM4alhDaXRFRzY5?=
 =?utf-8?B?NWQrSXVDNUJka1ZqV1dQY1lpZEN1TUllZFpRSGluSWdZU1dWeWtMZWJER2RS?=
 =?utf-8?B?bWtLVE8wWHJBWGI1U2NTSUd2aWVBMWY5NnVReCt3THFod1RDSkZVRXkyR1d1?=
 =?utf-8?B?NHFUVGpkQ2NLcE96enV1Q1pXcWphL1o1b1ZVd0ZFVjIxem9ZTHJnZEs0Qi9v?=
 =?utf-8?B?NC9TZldMYVB5UWpMUm5TcUEraHlSdnF6MnNQVnhrSWY1TkxKNDRHeWZiaHhV?=
 =?utf-8?B?VC9hMEtNMjQwQlF0ZVNTckY5QXRvT1FNVDlGQ1YxSzhXbHc3TE5qVnFPcE9n?=
 =?utf-8?B?cE42cmRBY0FjWWdHZnc0akdCZXBRSzlSb29ORDIyQnZBVFNrMGQ5cHVhU0pI?=
 =?utf-8?B?QzREK1hKMXF0UGlEbDFmTElFTFloWU90RDV1YTVLMGdZdjNOVU11NzMwTlM5?=
 =?utf-8?B?RGdSdGprbVNuQUtVdEh0a2pubE45U1JIZEpLYkp0LzNBOFcxNkthWmF2Wlp0?=
 =?utf-8?B?TGdHSTdId3pNU2tQVzhqbFlqZlhZa0JRc3FWSW5TMW15c1gzV0tQL05GY1R3?=
 =?utf-8?B?N2wxaXplTGhYNWtpYU85VHdaY09VVEZWaENtR0poeTlUVnhjQkwxdGNXOXh4?=
 =?utf-8?B?Z2tXayt1VGpnRE5TMHhGazNEa2dLN2FXdTBBUzFLQmNHNmdTOVpBYWswR1JQ?=
 =?utf-8?B?Y1RlS3JocE5McFhEUkxMSzhkOHlsTGVDYzA4cXdkbkl4Y1FOd1U0ei9WMzJy?=
 =?utf-8?B?Z01QSFRZc1lYU1dsZk5iUStEWUlJTFhnV0g1enQwRUd2REZkYzZkeHN3QVZ0?=
 =?utf-8?B?dG5sUDJJdzZ4eVAzdzhWL0JCUjJEUkhlYmlad2VsWWJQbjNtM2R0MVRYeXJE?=
 =?utf-8?B?eFhvVDJmOVRMbWdSTGc3TU9Ja0FiNFpDQnlvajBjcW1SRE53Yzh4OWt3elY5?=
 =?utf-8?B?enNVQ1ZaZnlyWkN3aS84TWxSTXg4OVJLZWRIazRhV0VjTm1hRlIreXM2R05i?=
 =?utf-8?B?M1BkL0FlMExTekpZQVNtMmg0U2VLZW9ocytnb0EwYnJsT0FSdlloaStEdllL?=
 =?utf-8?B?VFhHY2dJSWI1aE5XUHFrT2RRSko1dDNzK3RoNGJodHdlVFhWbnBPVTgvWURI?=
 =?utf-8?B?Mm9JUjJHKzUvUkFFaDB2Y0VlSFZXdHBES1ZnWi9WVEFoeGlaMEFtajZ1Q1pF?=
 =?utf-8?B?Z0lHWk0yYVhpaC9YMjdvaWRlb1U2TUpxam1Gek5BSzVMWVJRNjloYzVUUzdX?=
 =?utf-8?B?aHE5MGx1bmZwTWg3MmZFTEkvYzRkR2t6c3BSL010eThDODBrUEpoN3ROVGs1?=
 =?utf-8?B?dHNybWkybUh2T1p4eVhVUGQ5M2kzMkJYY0FrT0JMdWVVTkdQQm1JRlYyV1RE?=
 =?utf-8?B?cHg2RFJjTDlxc3B2VzFPdTE4QjkxRHNDZVNtRnpLc3RzOTgrMTA3UzJGSDV1?=
 =?utf-8?B?MzZjQktHcGE3MEViQzJGUEZCemhNYmZZZVRMdFIwU3UyWm5IRDg0V1ZGSVpM?=
 =?utf-8?B?cXJDWDg4Qys5V2lCTCtZeUp4ZzdIYU9RVzh4eDNVUTg2Y3Zod2xONTFJck9N?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b02a5ab-0498-4363-8eb2-08da8b8cb31a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 20:09:24.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSjSg5AXL7S4qC60mJ43Yom+ku0WXHRcmB1DI8LGL8Y0rRaElo2ythwbainZ22OS6r5biPJIZKe78etRvRgL69aDcx41Imkd1kTpsl33cXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 8/31/2022 10:38 AM, Jarkko Sakkinen wrote:
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> * Added comments.
> ---
>  tools/testing/selftests/sgx/alloc-error.bt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 tools/testing/selftests/sgx/alloc-error.bt
> 
> diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
> new file mode 100644
> index 000000000000..0cc8b2e41852
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/alloc-error.bt
> @@ -0,0 +1,9 @@
> +/* EPC allocation */
> +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
> +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
> +}
> +
> +/* kzalloc for struct sgx_encl_page */
> +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
> +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
> +}

I did see you response in [1]. I continue to find this
addition very cryptic in that it assumes global familiarity
with BPF scripting which I do not think can be assumed. I
still think this script can benefit from a comment to describe
what the script does and how to use it.


Reinette


[1] https://lore.kernel.org/linux-sgx/Yw+nCBVYfueEXVZK@kernel.org/
