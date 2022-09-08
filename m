Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70505B298C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 00:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiIHWoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 18:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIHWoH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 18:44:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4904BF341A;
        Thu,  8 Sep 2022 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662677047; x=1694213047;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y1k9xWOtGqTy/1Obxgka51HN39kSjc5ZDCkTY1pRXFg=;
  b=eFuhxGEcxJxcOXMOTBgabvAnJnTBqvez8bdjyml+pZbdswPGscfP5WVx
   IO0dVoJxLpDoKTmSnU7vOhTvMm7pTyzzKmCyyYyDWe1naJbq+Qe/pQmXT
   J0WNVcC8TGijmtl3td++QZgtPnMjR/1ztpvm9BrB+QRgd6YIBFpsXLBwr
   BgAinCWheFdbmI/O9hPW4QXFg4wtazljEvgt3YZ3o5g3IR7/TSGEMYkf6
   wdP92uGHnFYQmFgZHhXuC+Z8G9ZJdwEvdDgNF2fHbxVBICI5+d31tQhv4
   4VihVQHfG+1uUsRi5x2qOOyQ8WXxzcphzlHC6WyTXXS+EsjOVrKz5oq+w
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284361254"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="284361254"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="683414658"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2022 15:44:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:44:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:44:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 15:44:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 15:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+ijchAAJicr9e/7b9zrMbdKoSkxGuXIglxJcReuPLgA4uJrY5Sg1TKQUVrxSl11dMBjjnUSSJxyf+DyG4nP9LI2Vzs0m+fLeVBA++9qA2RoLkx4fMDaWK9wGMesS+fe/eC33xvJFlxUCYGLPUW5lsCV0LF+FGD8oiR9T6wsrE8Ck1+6zLjpMff0LpqNetrYahWMTYrqKdl2gzmNzMZlXL7l1y2FKrro0Ct0VX9I9rUGz9h12pYcqyePnZhQOqjUVWybgkwnfSbEtervSJqJmB1lp00P8728TV5TEK3eGAWNKC9hd+s0eFSD/rpcgaI3FE5A3REyCUBJIfactPcNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO6ePGenb+zldo8VCtB7C/zwXuO+0UOdZFY4Duip9Lo=;
 b=TvIUaxKGtiF1VIPuMECPTNY07yeQSzIKXwZ+GuKcD4vv+K7nFXjdpRYCp4HdrWrNIghvxzcThceWUROfBEzKHtjX9T+jIF+KT8lammbE7Ce3VFb/qj1IsEmAeXqbQ8k50Eo28+yATfl/y5kn35G7NrRdXsFR3qClnvUwIhV50IszDDPZkqDjnKcgLNU3HKuWnd/UFh/BPcgRfVC1lUooWNf+bG+9dwGgbG0ob2WQQLppNP4nu346IIBt1cGYmDnbCcZk3sETJf9SBY5GdvMy9hlSdn4v6bsLbfK3akfPEgyutOmfkka1e7UFZL6wTpPsj/XdNJTiOXnaDn2b4eoCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 22:44:03 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 22:44:03 +0000
Message-ID: <3b96aeb7-4b41-9838-e0f9-bf0ea7c99404@intel.com>
Date:   Thu, 8 Sep 2022 15:43:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH v2 4/5] selftests/sgx: Include the dynamic heap size to
 the ELRANGE calculation
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-5-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220905020411.17290-5-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:303:2a::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3edb1c2-3f7f-4fcc-bf0b-08da91eba0db
X-MS-TrafficTypeDiagnostic: DM6PR11MB4075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKWvzAiHxOn2oGyqYkoM4rRhEbivFZj9xY7LMNryRANVtT7RaN/HR0iySB6fIeR5gtM0WJJ0imw48rRKxuu9VWfUCgxGUmOJmzgkMFhEREr6JbBTNOcBuEyBYl+h2Vk/lXVCGE9T9lwurMVb4TPY1vyIQavCdoSRC/Gxp+OUvwJCfcS5okNouzFJKB3FwurstFv+MVJmHTLwtWBsaIGxRWrrAm3BK6gbVLalQz+FWUOAWtGcsZj+5/ypGYEZ3G/SFAsU0GsIedHxB/8BWVI5R/bMUopR5aew/Xsl/ICH8s8nxLIaLw96zRs2UPAQNCVHxb4Y3rdY2fDBRWd32kIGxizJslikYZwwM/GHeqIoodAUo4egZAXdapDj4/TrTSvRSW6hYoN7oE+3Mf2O2gwctpz2DWRhidEL1h/WoFkTcV7ubV/LHoxDZlSO6iBdAUpZ92aenfT05V7xs1I7uQoJUv37q9E/eqEkZhT4InUaKvNT2VVGxHRN6ei7+aYQeoISop4+Whzg9VAyfkrjKXrsxyb4ws555mKvE+sKZ2wIx7OK0wNCsfFGD367VyNse5XPJPQFMUYh628og4vtSui+A6Y2NyMokge2FTtozq0RFGbi9G2RdXkP6LuRO1cxSj6+Eh79+J4tYQNxTy0JZkryWYXGIcy7isilf2Tfz9Va7C5t87xrOGOBBmkgF6mEUzvdMdtR73pBxi2p2iC+McImE6LLGXKfeP8Td/EOPB6UCyjlnA2JidsZuCDCQEFKils27WUbNYr0bqFej+W8rnbM9Ca5ac0/NNH7iLj43iHGbmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(376002)(39860400002)(54906003)(478600001)(316002)(6666004)(6506007)(6512007)(26005)(31696002)(8936002)(36756003)(2906002)(53546011)(5660300002)(4744005)(86362001)(66476007)(66556008)(4326008)(8676002)(83380400001)(31686004)(66946007)(44832011)(186003)(41300700001)(82960400001)(2616005)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmM5cWpnNXVuZGU5QUJNY04rSVJqMUNnZzFBckljcFlDNTIzWlNON0F6V2x1?=
 =?utf-8?B?a2ZVcVpudUUrMzk1QXZkRVpOT0d5UmsxYjBUc3lKUTlMSUxLTnFKNEFldGtt?=
 =?utf-8?B?K0RXR0ttaklvKzM2T0svTEtmWXg2UjVTK0VEakRIYnBKQUN1dUJVekE5b2FT?=
 =?utf-8?B?MFkwejdxZlVrc2Y2RDQ2aTV3bEg5bklWMVFibXVGbEhBK0JxWGp0Y0hMMnZj?=
 =?utf-8?B?K1YrZjF2czNRM3F1Y3M1NVBKS3VRN0NHOUZsV1dxYWd4dWlnNW5mMktUZDhQ?=
 =?utf-8?B?ekx6bDdGN3U5cWNCa1puc1N1UmZWRHFPL2VwU0ZGL3Fya2o0L3NScm9vMVc5?=
 =?utf-8?B?QXVvTDY0REFjMmVFQmNDaXorNVdJZXVydnVnN0lJeUJmK2x5WmU4enhWLyts?=
 =?utf-8?B?MFl0ZExIZHdCR3IzZ0l2RmRSVTR6b0FPQ0tJemVxRFZGRkZjVG9ZYWhTZWNi?=
 =?utf-8?B?aG1GcG5qak9vNTNlRmZrVitGQ0dMUGtsenhuNi9wUVVleDI4TVphZmlpVTBn?=
 =?utf-8?B?cnZmUlJZblN1K0tMa2NKN2wzWnhIOVBERFhtNGpkVVlUZWFKSFNOTnMvY1hG?=
 =?utf-8?B?Y3lRYjJycXNZUkVrcVhQZ0kvcjFxU280Ni9vMWxwNFdOTnRPbVp0NFcrTGVP?=
 =?utf-8?B?dHVoZjVpZFdVc0lPcXFYYUhRalR3V3E0RlJYbVJ6RW1mYnZKQnBSMkZhVU1i?=
 =?utf-8?B?ZDZyQ1Z1U3g1aWFqZXNweVkzemVHOTh3N3ErM3FrQkFvYnpidFZZU2ZDQldz?=
 =?utf-8?B?NGxSK2dxZE1nb2h3SVE4bUl2VnUydDhRbklsZ1FVYnZoWnJYL2xNZDJrNE9I?=
 =?utf-8?B?QnQ4Nk9NaGt3NGJiYzc4SEEvT2REaUJXV3ZTRHlpSGo4ckhla29ZQjJxSThL?=
 =?utf-8?B?OGlnbWVSUE5WTlNwdjhqSU12Zlp2R1o4L0FvVFZFdmM4Z1dPVTg1RDFlNGgy?=
 =?utf-8?B?bHlhbnpPS09pSjJmdnBEZjJoblJyNGUyVUNxZVlaelg4c2hTSkZ5SmlPUUN6?=
 =?utf-8?B?MjVBN0ZLdTFTNGFyd1pHQ2lsREVkbWgyeTdDQ202YTNLb1IwWHEzNXFiRG5L?=
 =?utf-8?B?SUVkekRzSHdOdXpVejNUdXNyZTRpb2h2b2c4WllZTThrc243QzJDOS9KQzJS?=
 =?utf-8?B?Nnl6a3ZDUDV1djdDOWZEMVpyN01OMkpPRjJZdzhQZjdCbWZKdytwc3JFSkNK?=
 =?utf-8?B?V3R0cXN4eWhVQkFVQ3dlY25udDhST3pWazVzenhsS2JGbFpTVzdMcm11OEF5?=
 =?utf-8?B?MWI0S1R0bzBROVhINFRzNkVOTHlQRnZPRHVQeGxOMkFjSGFsQ0MxRFlodWI5?=
 =?utf-8?B?T09UUEc1TE5UTG1DTEF0Vm5BYkZ4T05uVFhRSGpNM2JVdWpIazNNc2JCWDlR?=
 =?utf-8?B?U01PeHJnbEFOWm95TGgwUnE0UjZFUWRjMkw4czM5WWdya3NnR2JhWFFUVkgw?=
 =?utf-8?B?VzRYRkt3UnBtNW5HQUhoclRZaFY3M3JFVHlacDMrMGlzTmFVOGZuMUFjcFhu?=
 =?utf-8?B?RXpUT1JKSjR3KzhhdXJkK3FSQ05TOFlIRE5EWHR0cU80ZDh2UnJmMWVzcjh2?=
 =?utf-8?B?R2loYm9Sd28rcGExL2xOaTdYdU9rUWFBN0RNQUxmaWpQRWUxNjk0RDlGSkV6?=
 =?utf-8?B?dmp0eWxyVjdlalhqVjd4dUlSUjhuUzEybmErWDIvaUhPSVgydmYzRGJVZUNN?=
 =?utf-8?B?QzNPdGlZY3F1d1BxRWIvQVBzUkZ0WmplQ3B5dzRQZmo1bFBxT2lyalFuekxU?=
 =?utf-8?B?eVhiNVNjR3NNa2hibGxnanMxQUVZQS9CNWFlcnZweEhrL05KcGdpMVE4N2tN?=
 =?utf-8?B?VE53Z20zSG1YMlJZaFZ2clpJd3RSUGxKQkxTLzJZbEdaTzNxNzBDUlozQ2RM?=
 =?utf-8?B?ZWQ0c0NsTGIzdElIczlFVlVHa1JldXIxNE9BaDFYWnJJRS9VV1BHN3QwWXBX?=
 =?utf-8?B?Q2U5RXJudjNNbkFBUm1pRXhzZVpKdzdoSGExQ0hTYzN4SEN4T0VJWTZoZHZZ?=
 =?utf-8?B?R05SM25YZmk4RDVIbFh2amtkWTR2Zzg0Vk43MUFWZElQUUZXaDlaM2MxdFNO?=
 =?utf-8?B?bE5FeUdNdjltRHVLc1Z1dDVEaXV2SXlHYkN6aXI2YTZGSkhUZTlpdjNMeldt?=
 =?utf-8?B?L2txSzFmTEJUYlduU2R2ajlsMlAzUjZ4M2wwZHlyU2xVeG11TFl5aFlGMGlP?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3edb1c2-3f7f-4fcc-bf0b-08da91eba0db
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 22:44:02.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMX43Odaps5bPjJRTboI/JZA7Cw5GlPLf+oT+/xBkxl3gEtCk7PN3Gqn1BxxKFiFHZCnP6iQ5ErnjRg281napKRCF9OA2A1H3/JzxwGAyhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 9/4/2022 7:04 PM, Jarkko Sakkinen wrote:
> When calculating ELRANGE, i.e. the address range defined for an enclave,
> and represented by encl->encl_size, also dynamic memory should be taken
> into account. Implement setup_test_encl_dynamic() with dynamic_size
> parameter for the dynamic heap size, and use it in 'augment_via_eaccept'
> and 'augment' tests.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

This is a constructive addition, thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
