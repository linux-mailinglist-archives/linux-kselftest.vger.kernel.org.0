Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA07C672F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 09:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347120AbjJLHdN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343617AbjJLHdM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 03:33:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C1490;
        Thu, 12 Oct 2023 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697095990; x=1728631990;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UiFttsOoW7Mz27JtYwwBqYmmqlj0Qo+GL6/2Xe552ZQ=;
  b=L/MOREmbSmJVciAJCGy1glxGr7DEGrPOjuswmZ50jvlWO+KB5Tj9KZBN
   aFAdPk7NKOIPyaC3N8jPewAMhRkexJglr356gPwBnzHY+2h8SHSKZp048
   JxeLJ92elxzWoKt9QNXzy6NSELh/XkcWdEusR0kSlVwijdwEcfebL+AoI
   nVb6XJoT371xIlv0uzH3ypOHNxuvUfAd5W6IrLUwlQL+/l9AvfEZ5KEnE
   xTELBLpv4KKnX0co+DJGTgiU7jjmEyJYOIziMvPpjBgIfZuS5iVIGLqxR
   FBi+LBEkFQ63xWMu6jP398/oIJfYuyO3xL5uMkqqR3glV9eKwE69VkQ0X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="451345990"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="451345990"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 00:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="789279358"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="789279358"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 00:32:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 00:32:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 00:32:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 00:32:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 00:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cABH7v1Y/DufTnSAM3+8y6ZRovYMK77ZI1KddrX5CtZMfgdiCoVpvCpDoDZnJqsnntTCdbhK1BvJbobdyshZLoTNlC+ZNG0AGAXdoW/2+xpRG3gpj8qd4P74eFZhpsyeEyDqGV7duw+Or0Tj8OgAc6ePtKqu7gOQrUTZLlng6j2xbhmI+EckPovVHZsXrgFu5WMQYUhmKckbSWXDI0zOrTlIfrVuBWYeL5pbu8+XMPD+FEUQFeK4cE8dHD69EZznhyS7FPQUsMUTS3yG3KiUiS7fSnN8W5cA+6icjS5FCgjpgjz7Us9uT5YJiaPKS0SPr3sIFcRQm4lBELyyyePxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCpc4rbGjv1JHyJla5JGD1ciLNhpiTTkKVNlz10jxZY=;
 b=EMjpFTAzsQu3hJPn0Xa4NA6jmJ+tYnQ6UYiwIDESUP4TCLEzxC6bP2OPksvU7/cuEAbuTAW0zc6rKLnmqPqHPXWdqsCcWy19sTNMCgXRN54PYmpkFy0wZb92RyauQoba372JXJ5tAZMxCCu1iU7miQNdMvI3GE3rMgoITsYwwKVRdSF9ZtbyWKPurZ/v6CbWj0nWkKcI1DHmlEW9aMfMz9Hh77yxjj4LHdUqosGaNX9Ix/LNLZ+/1EpxScljFBDuvd9PKzWdgddIjqOuc9qAnf0r72cMijxNaqr2HiA7CESwsflAsASHWjzyjXv7kfp3Q4NpP4KKuY61LNPnyebiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 07:32:46 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 07:32:46 +0000
Date:   Thu, 12 Oct 2023 09:32:39 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Shuah <shuah@kernel.org>
CC:     <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] selftests: Add printf attribute to kselftest
 prints
Message-ID: <4h2eu6yhodrujbvem24v7cwal5tnk2agsqulpxwi4myk7n35uq@phbxlajivrpq>
References: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
 <13a47130763d109aa40de153ecbee9ede22d8356.1697012398.git.maciej.wieczor-retman@intel.com>
 <a2a5cb05-8604-4303-9802-573359c68368@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2a5cb05-8604-4303-9802-573359c68368@kernel.org>
X-ClientProxiedBy: FR0P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::21) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 843c2a4e-1eb2-4125-a1dd-08dbcaf56d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrqKJ+TlH4rukV/8fPslbahfAsTvYJyshDhCGeE3zPV1KQlAPq4OSz2fXAw7TTurjJtjDHUYdR8706lI548DcNtovLLr3pBDKTjD+zolp0EUNXgT3mruKOBy3AzJ2zzQ91N8ir5JAIgbjuJfoAfnvgupEftO7+h0s6fTnKMemRzsf0zfGON6cv1uo/EkRf5cESrouPD4G8PnhttG+BoWew+UOH/hxDquTAM6xncsDYwucymAqimKcUs8uHqSVmYuJ/6Kq+UsVGFJ79+Z4NjhW8VeT0OZgI8S7+H9FUvH84Q42Mn6F0wCzAUTnK6QL3VTroywWW/PUj6ATwVzGVMBsQOV1i4YjKKciV5BhtzWKRPu7hsbJgsWNVCRlga9ahzMaWKIikwJHL/7RzjVLqvIzweZt5wBrVqPYHezWh2MEEqNEsST9SYcN5v9NT+P3DsS1r5+bKDODawuazr9WT2Exp0PGa7bL2+ewxXriAnLjvObITn7AGlFmmXEe5Z1Rv1FMK5xP72NK68adSEU406o7TcMmHcDkt2j0baH/fbZ4oDw0N3k+lf5XLMVMIsZulaWXALLg+iKVckZBOkQ6P15oysUSMdIOSorX+3eE4wU6kFPUZ8fmHnlEIMtCGcIaif4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(33716001)(6512007)(6666004)(53546011)(9686003)(6506007)(26005)(66574015)(6486002)(478600001)(6916009)(66946007)(83380400001)(66476007)(66556008)(316002)(38100700002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(4001150100001)(2906002)(86362001)(82960400001)(27246005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?X2YNg8hDoEeynQGX/LMmNzWyeoI1BaAhjZX2rnnyFnf7SZMFiP0750N1cJ?=
 =?iso-8859-1?Q?kN0xfA8zfRUouFrSZqIiLpZwSn2KjQG/XosAzbLbn9O02OEWdAF4hv8QG/?=
 =?iso-8859-1?Q?yHIToTfJ/I4ojo4d4sGZ4OtqYw3WPQ6MceIABA01W70Ms1s5TlCBOFaQbn?=
 =?iso-8859-1?Q?w7FqJEuPjlt8tvbJKwW3ht8uBlVASXpw/Nx4jl8vZAGLYGjJxB18YeKP4n?=
 =?iso-8859-1?Q?tDkYWH2Ac4lZJWxcRDHbKFerw2DLR5axqrhQ2tGQmKZTHB4MDh54O9tmrU?=
 =?iso-8859-1?Q?RLM1/L3mIpNz6mPMDCkWofrZozjNN2+TrpYlgiGzAj4CD7rxcrN000Giy4?=
 =?iso-8859-1?Q?h+8RUKUuN7C5EGxUGDhb2pO1TtrKvwvbXDO8BQngG2trWIJDnH69hCRxdD?=
 =?iso-8859-1?Q?f5sVOqMFpJ5C9X1WR7wa2KW6Hwuhu8X11B8V+VoAYmODLvhzdazSSRrYkp?=
 =?iso-8859-1?Q?U5pcVBcWcFskVOTa9SmzYoQjH4/7bKRAlluq2ExFL5t3RM9a1Aj/wtBm6u?=
 =?iso-8859-1?Q?OOelQ525TUPM+CncHrNGwlhMWHJoNFRA0y52X/Q1tB1TOlssfZWAPXMlgI?=
 =?iso-8859-1?Q?IotsS7ZBOoxz0q3D0HXhF5y+Y+6WqTSWZmfSWiPi+eaxJtza4BEJa3Zypm?=
 =?iso-8859-1?Q?c4dBMhSjlSkh0BvWnPm8/sm8Ztf9TVWWq+PpBjybYIIxpPRI3PB8h+Re+l?=
 =?iso-8859-1?Q?3ux2mav41NeE7DJguHttH0n3W2U1ebX3ttfE+FBGqd6YeLwZVXtIvDBvYD?=
 =?iso-8859-1?Q?Svlnmk/CP36tI69HuIP5XqVebXXzaYgVbnhsMVVbZRQW37A4vx9Gfw1Vbd?=
 =?iso-8859-1?Q?QOUcfbEhGAhro3n5aI06VLYvRRzfts/svyibZkt/jP2X8IPp35DXz6EnoR?=
 =?iso-8859-1?Q?mneyF2AYcRAv9ZqwikGZ6Oz1ULyDzFhwbOASDbGIfcJv9Dbp6Xjo8KQwuW?=
 =?iso-8859-1?Q?5D0wDt0Ie+a+9iU8nTSAUOULmoW5fxgv0b/tPSg14kXQFw0e1GVD2CJvy+?=
 =?iso-8859-1?Q?4TcWGmFns3Nd5+nP88tIN3MOJbJVf1QBZyVFf2C2uTqy2UJtpkOPGYAyUn?=
 =?iso-8859-1?Q?/aSe/3DgpYweIt4GegAY7s99U3GIrocGfIzMWJSUexcPC3k4cqFLYnbrmd?=
 =?iso-8859-1?Q?eE6elWOgtRWT35CL33gidB5564hIMlMWZf6wkR7eqpFXtSVAUmva9H7FRx?=
 =?iso-8859-1?Q?aZ2DbnTwdLxheIpiocZgCIMht4yHpEO7fdAt/QnjinPGY9fP4ThGnEfASR?=
 =?iso-8859-1?Q?aGzTtPbTS1huh8cOkgEku8FwaZnMe6CY+IJWFcW+Svte31V6g9FVlaRMyo?=
 =?iso-8859-1?Q?axeKUiavP7ASL/Hi9fJr1p6XNKvhDtXYWssW90DxlmNz9uh0XYs6IFCEIz?=
 =?iso-8859-1?Q?kSLI9qMZyiFlKeI92S5HAlgxXtUQ1GFHGtwQfT3y8S+12WW1vWrszSwV8I?=
 =?iso-8859-1?Q?euAC63pNv/JyA09ruHSLtPYnr8f750xNioqCP/JCgY07p/Rd61LQeLuGe5?=
 =?iso-8859-1?Q?Lr7iXE5kFVWJszGWM0rgLbMxsvM2LlTxqjRQ/qUiVCre0VoXlvJbGvNfgo?=
 =?iso-8859-1?Q?agj1NoVFEOEHUyZkeXM0NiFjKDl0Ku2Plj17w10R9uLwd+CyNimeawFPzx?=
 =?iso-8859-1?Q?OFfazFnqg+oMQBbTRxGoxIil8cZg6kxPsNdpbmvvY8IR3fI7D1X4X0bDpu?=
 =?iso-8859-1?Q?G+YY79OOmy2ao5jJe4g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 843c2a4e-1eb2-4125-a1dd-08dbcaf56d1b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 07:32:45.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8imLXS57KbodA4Shn2UYhW/VVbKPxlm7Tff13OwhI0cR1lxqMwYUHYIla1CXkKYRBLCF8he02eUWtKt/DAuJhdU0nD3eEmm6Bg++jNNlYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-11 at 13:40:48 -0600, Shuah wrote:
>On 10/11/23 02:23, Maciej Wieczor-Retman wrote:
>> Kselftest header defines multiple variadic functions that use printf
>> along with other logic.
>> 
>> There is no format checking for the variadic functions that use
>> printing inside kselftest.h. Because of this the compiler won't
>> be able to catch instances of mismatched printf formats and debugging
>> tests might be more difficult.
>> 
>> Add the common __printf attribute macro to kselftest.h.
>> 
>> Add __printf attribute to every function using formatted printing with
>> variadic arguments.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> Changelog v4:
>> - Fix typo in patch subject. (Reinette)
>> - Add Reinette's reviewed-by tag.
>> 
>
>I still need information on how you found these problems. Please
>add it to change log for each of these patches.

Sure, I'll add notes on methodology to patches 2-8. I understand that
this patch (1/8) message doesn't need that addition since the problems
it exposes are in separate patches.

Or would you like me to also note here more specifically what effect it
has in the rest of the series?

>I am seeing checkpatch warning:
>
>WARNING: Prefer __printf(a, b) over __attribute__((format(printf, a, b)))
>#102: FILE: tools/testing/selftests/kselftest.h:81:
>+#define __printf(a, b)   __attribute__((format(printf, a, b)))

Running checkpatch.pl with --show-types shows the
PREFER_DEFINED_ATTRIBUTE_MACRO is raised. From looking at the error
message in the script it looks like a false positive:
	"Prefer $new over __attribute__(($orig_attr$params))\n"

Please correct me if my train of thought is wrong but I think checkpatch
sees __printf() macro defined and it sees it's raw version
"__attribute__((format(printf, a, b)))" which it wants to replace with
the macro. But since the raw version is found in the define line that is
obviously not possible.

>thanks,
>-- Shuah

-- 
Kind regards
Maciej Wieczór-Retman
