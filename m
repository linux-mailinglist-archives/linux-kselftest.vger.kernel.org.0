Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669173C422
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 00:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjFWWbf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 18:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjFWWbe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 18:31:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54D2693;
        Fri, 23 Jun 2023 15:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687559493; x=1719095493;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7fAmSr2fNCpwKtJadIWCpe/J2wR6ybS0sTc+AKVandE=;
  b=gOXTExBUGDNMUziJKvYwaMtwYCtXgHTrrxX2/LuP9G2Tr4FHCxK5BSgt
   Y8wjpBrBt+//8AdvrDP17JejGjRpf0k/jB0nFyiyYShU+4FVUIhOor2Ar
   RLus9hMu1LO2ArR5AJySsmy7iPUybHzY2V2WWQPH9cL32dYDqq1diFPUP
   TaysTArWPhADpgY+px1eQIXvRXkvgzCKQW64m1IId8n8rdxF3xW5R2S0q
   9qcCByhWJeRSPaQ/UGHO2/mUpRofGTZQ6MDomFDPxGevo6WZvzSPVuRCj
   nWx3PQYkjvS0r8/JO1G76dkbBVlXzSDsqzVc5qs6mVeHSlmLWXw61+7G/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="390935552"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="390935552"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 15:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="1045792660"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="1045792660"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2023 15:31:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 15:31:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 15:31:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 15:31:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 15:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa5BUiFneuPTmU9ZCJyGw69p3NsV980dDNxjVevL6vHcyXNtNoDIshf33onS1zeqvawfQh9LWEsgdUO2jH1bFZk90VyBs30yMzUGvfm6STCpRos6MxKXfQbIBlBb+9VUURuvmBHHVE8rJLCQ26eTJO9AXYeT8wPxpeBm2+12ECwjRF6YJO4GR7hOmjbI4fyp7EXdxw+zfJCA0wT9XivMXl/7F4GAvSGnm4MXH8t+GMdm/4j43BZiO3dPEt9DhEcW2cZ9EkldFAdUL6qcSVmAmvXzDQxaA6W90ubcVRhNQLlgDmu5TaX9fIQYQU3XDYSFyle/axK49FMvlpToVwdfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkqlObJb3X/GdXzafTtOIQ4Dnoo3rNdHedIjDlF9toA=;
 b=dEDgdqN0c/KyffTaKFWF++l4lBf6SyFvk6WPaQnWRfDBg0xSA3N/5eB9L9o0LZQ1WxPcWdLXrIeZK2CJD6dfl3L/w3eljkk9MgzMlgG99zbrkpM+SlyWP8Se/qX3Lwi55HPj74stKalow5ptPcLuN5/DF5c6MxeaDZLwJSzCOCzpHjnWSq2bpM/ffAr5iUW4vHa3jMH0CP7paA+kj4FddxdWbCIR0QyeiwuxtQGO2Pb/zcpt1bS97uJi2QbJ8bDhnkAIAT7jg3MGgj8X05C5v/X3ZW7Y+BfI1TNznMspGRaO2gQiXlXZGhqDbK5dfpZHzoKGY5/svGJ8cr/pspoo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 22:31:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Fri, 23 Jun 2023
 22:31:23 +0000
Date:   Fri, 23 Jun 2023 15:31:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>, "Du, Fan" <fan.du@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <64961d37eafda_142af829411@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAYXXYzOUQC0G7yoh1i2+SW-FodCABwhD6TgArLf28iG=i65zw@mail.gmail.com>
 <b99d329e5a28a06dfb947270b8a9032cc6960f83.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b99d329e5a28a06dfb947270b8a9032cc6960f83.camel@intel.com>
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 931e4dd5-de9e-44ad-6eff-08db7439932f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQ+0JtUSk3OVBEtCgxg7BVGsVHcdvkHmpVSFt8yITAJTRqHBsn4MWsFIPKqtXhOJagVn/fcrGz5pHJjsuzIztd2neJ0iOiVTV4WwvNFUkpJcfKucuYyrZnT3Q1OR/VUCt2f44anuCwXtiFNQ7/9mcoZxYRqyZLVvqKUJJDnv6XeOJhxd8rwFHzCV/j05UgfTEBFyYNpUbTrmmiFZALEcnXKuWzVbT/dVagQORxqr2CKVXVcTQFRVa6Fxb5LtkgUMXxOCLeqfSFgtGsEL4NPlgf5Gay6ph2iCoFNVO6XNLcVyh94hjynbbn1K7bqqdrUfNv4WhWiuTDB9o2/liKiU36nfudt6Jyw/x/KQ3/Y24S1K7hsjX4S2m9yPDntBslUGLv9+jXVln9jDJR3/fxq5ODPJ5mGDOWDNpBeiLSST20RYKkh/smBJWHKA1XXyjBI4WmTithsZvmPcBXgW3GLZQYI8G0U43ZGZ3/p6A8EK6UJc4mvC9rb2azQHpIim2h2Dyxh7ORoSIqCziCb0FQJaVv289UFwlz07OtChynDFm2mSehd7jKUsOGHDlPlj7Gkj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(9686003)(66556008)(66476007)(66946007)(316002)(4326008)(5660300002)(7416002)(8676002)(8936002)(41300700001)(2906002)(54906003)(6486002)(110136005)(86362001)(38100700002)(478600001)(26005)(186003)(6506007)(6512007)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DXfiimDtE7SbobnzhaCarJMYTNRe8x2VT218r937I2RjDzgCU2J0WPwzNIom?=
 =?us-ascii?Q?AqPTAt0lZCEJZBM50SRSVfWErKjno/KUllUYG8mIs47K4SOvjye57Q4n7Y+1?=
 =?us-ascii?Q?qtpPM7GijbQ4GTUsBCk1DxJYjlkzHI8ne5+UIFDmL7rpulBBgk3I0D16YHWx?=
 =?us-ascii?Q?pzj0rDgMZioXXt3P9DnsB2+1EFeCYlZSHm8/Og+qKn0Z72xOFEO/AAbqU6I/?=
 =?us-ascii?Q?W4Q2ez8E71VMih4RC4aa83x0gmQzc/i+Y51FNcLWbBLV3UORg6kqpMa1/ab5?=
 =?us-ascii?Q?Ll82RsLSyCRUwV4BSlhrTUtTfBIf5y6ImOMqksMPP+wcIc5Tqy3lczJdhIN0?=
 =?us-ascii?Q?R3n/cdyp0ouVMTJb85uIg+rj9W6BJr59LB4JWdD50rgmYuaQ+hMzbbqCVnO6?=
 =?us-ascii?Q?BBTIPEvADB8LeVMICO32xiMMdfyHpvOuPo/Bmetb7MZE6+yHrFWlAt1R8lWB?=
 =?us-ascii?Q?kTQ3RzQjRtViTZN5KFY0Tj30DE/A2uGP9Euww1oEU/XafsnYOeqCx2jNpnOS?=
 =?us-ascii?Q?IOZcRYWiHSpey/DikHouBh/Ccxy5AaSBG0EBpRBBZuhEpoD4MgzWirwmwLdG?=
 =?us-ascii?Q?XRGOwF/Ksz/lMLni7nYP+hp8PJe+YsQNB5/5soPcSsSp03TbY7TCl3KWkxmy?=
 =?us-ascii?Q?KlfAdUtpvY6pDsH398jAIIXlavYBFlqKZz5vGJSlFmfMspGH+Hp4bXktLRMO?=
 =?us-ascii?Q?rMrNyhOvebutxRiKgUqjZDLaO1fzg8TDWoc06NnF5FIH6k7Z8vAW5ld+a+ZX?=
 =?us-ascii?Q?LFIENu3j6rpWM3ri2vUJmduDkQAGD1PID9CxmpxSMeAdST+Xcf+IIfEJijQT?=
 =?us-ascii?Q?2INR1xiAMU76DuEJoXvdtzvAMee+YBX1pTTWrKlfMqWv1v7LtW4LQUVwHOEl?=
 =?us-ascii?Q?o/qgSFJH5N+K4PO29Mo3z0f2zJROoBAZWgY9AwULtUIrC0MQu0CKF54Ae6gC?=
 =?us-ascii?Q?jnK1tZ+2zHhWgF5QEe5KehXr+iUui4pXg0rlHu8U9m8kwS36ErlugbR/ierb?=
 =?us-ascii?Q?I5yTLQFRuAWLLXLGYSp7D1/2C7PjHQ/nvERa3jqq0+Z3JL6Jl77R6vGNdQsV?=
 =?us-ascii?Q?S9Wc290YH+rI/1n0NVLCzqCDOFk8gQJ1iNbjGJDPZR9aR8sSqsz3k6OfiEEU?=
 =?us-ascii?Q?XFOvAbgTvI9KQLj4sGMcYjNwim+xSni21UGV6ajY0ym9NhAzgUQs+8fvFGyA?=
 =?us-ascii?Q?QIjfPY4taEYrXyDoQfEYFUMWDG7VETyWTXz5QZGb6AaKTxw6OS8mdJKGh6Ki?=
 =?us-ascii?Q?I0/uJcOSWarOcc+nxlqd/2ub8ZePEswXaa39Acs8/dEb1VloORSuLRqpliKI?=
 =?us-ascii?Q?NbSeKCiRUw3g7DdKBn9lJyiG7soyKIWqq7oARbirv/cyIyeGlB+TDkkUwPMK?=
 =?us-ascii?Q?2Eno8IcFMQSVf9Nrt0/MbyoRJYxJodgIAi1GSL+mueWZ+DCZ44uKjwI0sVzq?=
 =?us-ascii?Q?UlkN5VZMH+/tVZG9id4lfA+urZyvbCOACVMtsQUYTdfjooJcbyzDrwZKgfEv?=
 =?us-ascii?Q?mJoWHPp1aT+KtaDz0+RhhfzxfdCeRzHOg1rjGaQKsToGUvTYVTdwRI1eSHQQ?=
 =?us-ascii?Q?gPeVNcgkkl1CCQpHVv+Fspu8juGogRCJitAMVVfOiGy980P7pWClEkzoDwgy?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 931e4dd5-de9e-44ad-6eff-08db7439932f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 22:31:23.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyJ3ojto1KqD73XpWCanW1XkVIsCNBIPin2xoQw2VpoiM3B+UvEyOhXPZWqqk+hfqDbm+wSInhNYOzUBCFTr8AgCpahXL1WnUCfAbXkmqh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Huang, Kai wrote:
> On Thu, 2023-06-22 at 16:31 -0700, Erdem Aktas wrote:
> > So while I like the suggested direction, I am not sure how much it is
> > possible to come up with a common ABI even with just only for 2
> > vendors (AMD and Intel) without doing spec changes which is a multi
> > year effort imho.
> 
> I don't want to intervene the discussion around whether this direction is
> correct or not, however I want to say request_key() may not be the right place
> to fit Quote (or remote verifiable data blob in general for attestation).
> 
> > request_key(coco_quote, "description", "<uuencoded tdreport>")
> 
> Although both key and Quote are data blob in some way, Quote certainly is not a
> key but have much more information.  The man page of request_key() seems to
> suggest it's just for key:
> 
>        request_key - request a key from the kernel's key management
>        facility
> 

Read further in that man page and see the example of generic user
defined value stored as a "key". A "key" is just a blob that has meaning
to access other resources / instantiate other keys.
