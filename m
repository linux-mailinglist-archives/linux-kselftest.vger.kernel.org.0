Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428E269ED43
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 04:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjBVDFs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 22:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjBVDFm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 22:05:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F9722024;
        Tue, 21 Feb 2023 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677035112; x=1708571112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FOG7t1ZHxqoIOZvM/Ex4d+2CUZT5YXGXA9pY89DPCDU=;
  b=h7cKxRJSBTi0+auDtkeeN3Ylzv7XhEpF1YcB+j9WrpAZVaStsvUMk2Cx
   n49B40CS2LiECvS/SE63uKn8aA7b/AJI3t+AjZKClCM1+fch17OLFSIeV
   vFbkUz2SNlmzhttfsOvGdwVRsTCuB8BBGlJA2hU3OOARqJS0Bk7iPew2o
   eYhKEloU3JyWE4wXbDAS8mM8B+Sf5ruv4f/fKASYGL9L6HCL4yvWS7Vq4
   92T7McXgayST/KFglrHq88TQjFrgU/b4hihzKaOC78jihmjJ6SpPLwb4b
   YamegiNPfHgdWk6yzWGTKiUbNpY7lhqCzo/JkA22DyXeFMsa8gPA88zKK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="360299555"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="360299555"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 19:05:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="673940514"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="673940514"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2023 19:05:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 19:05:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 19:05:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 19:05:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLg2kY12Nr8ZXrvU1e/o9wXMEFDwFctzqim76EHuj/AXrqkPeo1/I672RQZtONqyzyv0L0i8JBSahg9cA5GSk60ZpToTydhE7nF1P0IZNN0PFffICAE+26f8ckRJfDp/Pte5B+p87mWJo8w0760Db2BPVbxn98Ktvdn1LPva8ntMGyBiL0VLW3CVFB03GTseTIERBUFkSbilnFqPjpInLE26aTSUcIGIvL/xgUm1OwBxRbpuDYWN380NhnuIoXsXr/lLxfo5rNvJnMxWmwarDGxM41aq1jHiOp5OCzMXw1CWDXGmbgc1vX6hH+YD4GiwdKKxGEJH4fjXw1anSBcw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1taIPWxGhOg/p85L+QDza++jgi0nUkD3JZAGIlP6auE=;
 b=FUNyaODAUgo/ZXdIsE3nVrt0pXoWVxU2njmBEaMnc3mNKSDqx+IX559qd4cbmIRmkZN1698Frcc6j75p0P/BAdLXhqnqyZy2w2RmuMX9m7rnP+tpPJAzdfsvfnruPuIsTyK3t/Bl5EHdepLuXke64o7nKBrM0fi7z1LxDrBTEb30WR7ZfHULLAQNqUiRGFVSQs16HQtvBm3v61p9jTbKphAf+VIWmePM+JpIdP8bFJsgfqSNqRiiFRMUu8of82RKmwkq8LmOAhUxxpQywh9pSnEz2x+Lhp8jGXejmPaHEx6kmTjvZPSr117utXYtS/D9ZGksalMZXLoOO6KiQS8YUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 03:05:07 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::f8d2:a65:2549:e36e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::f8d2:a65:2549:e36e%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 03:05:07 +0000
Message-ID: <e91b9172-8a2e-e299-a84f-1e9331c51cb7@intel.com>
Date:   Tue, 21 Feb 2023 19:05:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address of
 init_fpstate if fpstate contains the component
To:     Mingwei Zhang <mizhang@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        "Aaron Lewis" <aaronlewis@google.com>,
        Chao Gao <chao.gao@intel.com>
References: <20230221163655.920289-1-mizhang@google.com>
 <20230221163655.920289-2-mizhang@google.com>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230221163655.920289-2-mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|CO1PR11MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9502e1-b147-4e54-bee7-08db148199f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEblyavliS/eURkGfIR6b5+LlNCAZFETto32hJhGXry0zy6ftwOcj999GeuZBz0gKxSrP0uHxWIH74H4lwh15O5ZplVqgm453W4fky3nqwjiefh7WR5lhETolRAya36ERrtn0ioWGZ8P9NaiuIY+M7LnfapEG2YlJeZ5CJDKWmFqIQrNXkQaA6379Pi5Px/OculEKu3I1d3mUotZ1flUea/sb2/rEs8Eojc8SwhrO7nNXFku2iOEvEUxyyADn9EiO545PiVSr16dM3B8O0UQPkuf9ZB/vTMIfSAH0lnWCYjLurSW+mXtxQtQOELbstVdo8kM20YZMCpfKQdMQKpr4rgWxwXwaZ1eDFZS5j97J0pb0Q8ymuKblt8zAsWuYOJHv4bfleSfsPsd2Y8fNWIGbhLxRoACWemfviDAN4Vq4ifQl3mJpd3oIEJlfHgSVRMBib5bMTpVPGG7WGF5r259XY0IlmPbgb52FHIt4S3y7P7tYFqqeVFaTMbxXgoEmqYTOiC34KsZsa8cIX5IrTISXzSxrZAbJdj2c9dcjH1suzerH0x/PlFEVr7bOM4QHLoYuiakEPMvPOvYP1f7SE6uPZb05cL5JLqN+IUvfjX87cqSMnRldtH0Tlycg/A+pjbkM+n4oVsdYJHBOjdU4eJpM9FFUuwfYO5Qf6w4gmvsJvtfObu1Oz2Suv6kJp2K2HgAzgp1YPG0OjFnKf87XFBae5Vuals8rbhlraz5RoQhnIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(31696002)(86362001)(36756003)(66556008)(6512007)(26005)(66476007)(4326008)(186003)(8936002)(2616005)(5660300002)(8676002)(41300700001)(316002)(110136005)(478600001)(54906003)(6666004)(107886003)(53546011)(66946007)(6506007)(38100700002)(82960400001)(83380400001)(7416002)(966005)(6486002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXMvdDRTQWpNbXVGb1hyMGdSYmpVRjV2RGY0R0QzaWpGQk8rem5wZjFIY1Av?=
 =?utf-8?B?VUdVdjlLL1ZJK2g1MTIvcTcvRi9FQzBJLzZnVk5STDJOSUttdjF2c0E2a1R1?=
 =?utf-8?B?VVVSODdSVXVST0U5aTN4UUdMMllnQzdyRFgvVWc2UGhadHVkVUk3QTFYa0pS?=
 =?utf-8?B?ZkhLbmJkcTZXTjllTS9VNHRpeHVIVnhTNUx3T2NMNDMwSXJ6MXVlaDBWYks1?=
 =?utf-8?B?YnJZUndkc0c4cmZSTjhZZ3l4ejhvWVhsNmxjT3hMQTNhYjNsQkZNaFZGRUZh?=
 =?utf-8?B?QTQvUWlHSDZORUZXS25teGozb1g5UmJZUjk3WURtZkdtK1RGY2pFdXpQYmND?=
 =?utf-8?B?YU54QndPV0hUTkd3VVg0UExKNVpGT25KVlJhVXRDMllkMW5sVXF1cGhUVDJD?=
 =?utf-8?B?VnlPbEJ3cmZyTGxyS0NrVzdka29RdTk2WkJmRjd1Q2psY2Myd2tZMFlZTjRr?=
 =?utf-8?B?anNrTldXYkFUSk1lRFJjZmhLRnhKdlgwcWF1blJDRUhFR0FxTHpjMWlsM2hY?=
 =?utf-8?B?WU0wR0pvcFBuZ1UxT3YxMXBmcHZ6Nmw4cVYvVVBPVW81UjNiMjhQZ2VXNGhy?=
 =?utf-8?B?SnNBUEE4ODRHQ0srNE5heW16QkZhRjhHZ0lKckhXUnV0RkI3RzRoaER3TUl4?=
 =?utf-8?B?WTV4a2h3amxoZ00yQzhpaGVHZmpEVGY1SlMrcE42WmhiSk05UmRoQkdNc1E1?=
 =?utf-8?B?ak5hZEhKalZveUx5YXNpZjJUamh5eDdEZzA2ZTRKQkFIWEtpSlZpL2V2MExm?=
 =?utf-8?B?Vnlvd3BxWm44cVJmckxXQStoOFBKdE9nS3R5bk9NWUpTMmZQUHpPVktkbzla?=
 =?utf-8?B?S1FIRmRiS2U2TnBmNVZ0OW83VjR0elE4QkJJdVQrNTF0RVhhMUJmdU5TNEIy?=
 =?utf-8?B?Qk1PeFhLRzlCTSt1bWJNenpDRFFLNjhYa1d5a2VsWlQyT1R3aTdtU3dVVUUz?=
 =?utf-8?B?WVJqeU4yeTdnOStNVWxwSzdzZ3Y0SFEyKzduME1MSC9oKzJ6c2JqNWtqNVEw?=
 =?utf-8?B?OVg1amMyTERiS05YTUN0S1RjMTJoeUxCZ1lJUmNoV2d5ZEg1K1FjRW5WVUcz?=
 =?utf-8?B?emlIM1RSRXl4Ris5OUl0ZTE1b1lQN0J1R0FVbUIxOWw3OWxycHEyYXl5T0Ri?=
 =?utf-8?B?TmZHSjdCRHcrUnB4MHVocnVBVmtMcVpPbVd5TXJYdXRxbFZwQlhodi9VeGlM?=
 =?utf-8?B?c0hrMTVjWHhjODNRS3NUajc3Mk8zL3ZkYW15dGNQWTIvdEh1Tnh6OHhFM2pV?=
 =?utf-8?B?aUQvWDhxVkZSWWdvcW9icnRsVm1wOUF0cEU4VzY5VEt3QVNNcEtrOTg3a2hZ?=
 =?utf-8?B?QUtFeEE3YmhvOXVwZXFmRDh4NTlkMjliT21jUkc1YUxQY3IyS0NKeXhYdXlw?=
 =?utf-8?B?TlZPNWJWd1JCZE43d2MzS2xub1RsNlpYU3ZmZU1XTFNsY254QnlDV2djMmZB?=
 =?utf-8?B?VnEvMzBLLzJhZVlQZVh4VGQwdURPdjNjeXdKajlRM3VrQVpLS0p2SlQweEZv?=
 =?utf-8?B?MER2SFRNZlBsMC9lOUJsRks3ZUFRMkRISFhkUGJOVkhrOTc4Q0JFa1Nqa3NM?=
 =?utf-8?B?RXgxdllnY0ZIRTFPU0lXUWUvK3lDbVZTMzhIV2dhMzFKKy9IKzBQdG16WjlB?=
 =?utf-8?B?TzdJTVVlSmg1N0hrbXVmeEJsdXdpRUZmY1ZPeWVBMk5wQm5NTTlBUGFyTC9u?=
 =?utf-8?B?MkVBQk5LeGMySVQwQ3V4bUgvNCt5MUd0dUtUWkRmbk5xNEtDRmU2bFBrTnlh?=
 =?utf-8?B?bjlLYTdVc1N3SnJZVE5qc0pBeWtEWDFqcUFrUDNkRE9yenFKcWl2ME9pN2RR?=
 =?utf-8?B?ZGdlUDZ1d3RGdHBsdE9EZGw0Vmp6ZGNEcnVZQWNKa2RLeUdJWDA5WFVCWTJi?=
 =?utf-8?B?a0FsL2VyUEpERUFBRkd0OWpDamhRS0F3UDdyTnZoTW5ndFVkNjFuY1h4Vjl6?=
 =?utf-8?B?OHdNNFNHUDh1aEZMeWJQVFUxbWoxcXMyREdxTVJsVTJqTHBOM0FINGxmOTc4?=
 =?utf-8?B?YUNJaVJVelFnL1NwdnpzbTFWTHVTWWVVYjBmL1ZkRDBHMVNHQ3F3a0t6OCs4?=
 =?utf-8?B?NzM2TmtiZ2hHWEdFK3FCQmNSdmMxaFRrSkVKK3FWeVJEdjZ6dXhtMmFOZnFJ?=
 =?utf-8?B?VGVjbzFsYVlhckltOHRQQng4RnIzQlpHNGVBZlpUQlZHTE9wMm04MjFIQmh6?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9502e1-b147-4e54-bee7-08db148199f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 03:05:07.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL/h5uy7EKvKgvuHj8kX4XQbLgjXFFe9/7S8Vz07nExL4LtBm2DSHKIqWR/PkthKj+OFlZOHgs7mMVAnXBr0asByTJNuLvaCABgPdjZAnWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/21/2023 8:36 AM, Mingwei Zhang wrote:
> Avoid getting xstate address of init_fpstate if fpstate contains the xstate
> component. Since XTILEDATA (bit 18) was turned off in xinit, when KVM calls
> __raw_xsave_addr(xinit, 18), it triggers a warning as follows.
> 
> __raw_xsave_addr() is an internal function that assume caller does the
> checking, ie., all function arguments should be checked before calling.
> So, instead of removing the WARNING, add checks in
> __copy_xstate_to_uabi_buf().
> 

<snip>

> @@ -1151,10 +1152,11 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
>   			pkru.pkru = pkru_val;
>   			membuf_write(&to, &pkru, sizeof(pkru));
>   		} else {
> -			copy_feature(header.xfeatures & BIT_ULL(i), &to,
> -				     __raw_xsave_addr(xsave, i),
> -				     __raw_xsave_addr(xinit, i),
> -				     xstate_sizes[i]);
> +			xsave_addr = (header.xfeatures & BIT_ULL(i)) ?
> +				__raw_xsave_addr(xsave, i) :
> +				__raw_xsave_addr(xinit, i);
> +
> +			membuf_write(&to, xsave_addr, xstate_sizes[i]);
>   		}
>   		/*
>   		 * Keep track of the last copied state in the non-compacted

So this hunk is under for_each_extended_xfeature(i, mask) -- it skips 
the copy routine if mask[i] == 0; instead, it fills zeros.

We have this [1]:

	if (fpu_state_size_dynamic())
		mask &= (header.xfeatures | xinit->header.xcomp_bv);

If header.xfeatures[18] = 0 then mask[18] = 0 because 
xinit->header.xcomp_bv[18] = 0. Then, it won't hit that code. So, I'm 
confused about the problem that you described here.

Can you elaborate on your test case a bit? Let me try to reproduce the 
issue on my end.

Thanks,
Chang

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n1134
