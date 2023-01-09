Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA106661FA6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 09:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjAIIGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 03:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbjAIIGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 03:06:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C08D61;
        Mon,  9 Jan 2023 00:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673251571; x=1704787571;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TSf2aNve5uRCwdTkUOBWIlDn5E96c3dTD3mL0IYMMzc=;
  b=lG0azOVzLULTinofn/bfuMja2tkUg4fhA9SPoRW3GeN+XzQ1BB695oh9
   9xryv2SAEk8xLqaAxQCMgjZj29JUHMw7L81dc7Ycc3pFaKhBKgA7kxbHv
   TMHdu/nqWqJedNn3IWlp5QlBBh4J0fDuLge2nmKtqlynpE/OyIcMcOUiR
   qPpxlZdOo1Pba/eXtoPYEBXYSox0DHqQcxKQrbFSjZnjNCeTwgp8IctNq
   OMUKvX5XdFCxl5Ce+SseXyjvAesjF6sdB9N5bqPPWYEyd2p7I6JzFAPK+
   hUGnxqO87BzpONuhIqQ9+7lnUgZ8/l1buj2pujZbsVWDhANFsMuu6qTom
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="302516747"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="302516747"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 00:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="830516512"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="830516512"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 00:06:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 00:06:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 00:06:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 00:06:08 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 00:06:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9UZF63eTGtw0ZEnah1kQ0/F78c0OqFsFZ5NoG3D1QUkq6UfpnnEj5YzzRXtncyATlhIZFPmL6/N2pRz7mn0NTDTj510Hn5VLX1Bphu47flAPqGoLYm8evp6OOtQRSwzVmFCHVyRpJqRITerjqJHm19UGV0EEfjBq5W1/PT8N6Mm1feHZsof969ijiI2FxMPK8+Xie+w/oQoBiNNzd3LvZW1pnXP5kKjjg44KOIaAXmfG6qxo23gEBqKAMHFR0h/+feDh3elqaE0eVWy2L3IlJQxm4CJfmPn/j+UJ8WNbDTaoHvcYFLDqEoP9ZGgSWDpREf11wN10QRsis/qsm9UOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x4KIaMwK96ANdQU9SSwpxC0fpj6/Vv4HPpeCegEBVo=;
 b=cOYYRDIQHu9Hm2vqn5oFsm53NBQhU76qWzUARPv0X9kIzEt1e9It1WkxaDuIklNcuMGnX+BWkqqIwxc9XeNs9AgbN3IAl94W7fAU1XhHH5SMEu+5X8GxPXYIFysvWiuw9eT3a45M//tLW03A5LaXXayxxgQhTK5Jcoy7ii4pcha56iFfTG2c9BvvEUHG7eKa3YbpBWfrSg7EoHjfbFk1m4CzDVun/X3o9oEvAcSPgWSjezONIbONI3mI4fREvwx9VHh3zh9Czs20Udo5xu0u6q8CJMff4kjK6yeBadMhkylPmhC/O8BZX0kUI0VO/cYKD1rZI+xzXQZv0Drfj3AuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA0PR11MB7380.namprd11.prod.outlook.com (2603:10b6:208:430::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 08:06:02 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 08:06:02 +0000
Date:   Mon, 9 Jan 2023 16:05:52 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Pavel Boldin <boldin.pavel@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Igor Seletskiy <i@cloudlinux.com>, Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y7vK4NDlpfvr9zA1@ziqianlu-desk2>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
 <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
 <Y7bg5sxEZDIaGoXK@kroah.com>
 <Y7dypc4sFcmYlXQQ@ziqianlu-desk2>
 <Y7kqx5cBCVojq6QJ@kroah.com>
 <CABohvEPWBHmrRpZcQejTkZ+CYtYCyu6rFMd4doNn_CMk35um+g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABohvEPWBHmrRpZcQejTkZ+CYtYCyu6rFMd4doNn_CMk35um+g@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA0PR11MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f14b1f-f550-4b02-1299-08daf21859d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7WrSWoCWzyuXek8n3HhW3u01IuaLMdC3TR41PESMImFW3+fwxYICylRYFxSZG0fYA2ET8Z7q6HALmjhc9LWPAeN6MAA+B/QXy9VK9MZP9XYJ6PEj98SVurBBd4LiOkl2O9nDFsxVqJiQEiue1a8JhfAzzfjOG7ybbqWhnyMvCPo2ZmCHvWEOw0eM3FuYILHfl+3cviDGz9NaciJqJI1nWZNfov2bWpFxg/mYWaD09tOFP88d9+i2Wc9id4sNtMgwoD/41JMNu73esU1Q9qSx4Y44yWf+8rfHM7bJe2TAWnM/HG3frmK0aB3JsZ2tMj+8MW9XmByIKdaM9tlFx4q2kMsEe9jeIcb2kvJxEfnt7kSREv1njlWoURMOpFNSkJp3T956ng/doBfMpyYKKnrMkNMG7Uiu+rzK4wGAQ/vseF75PeKLMzWwqkW1Ni6FxfSNe7bwrFl7JtX+ydf7zM4CaNskR12TbAr24uEIhMukZmmk9OQQNfDRz6oxZrqlilep3KviYKxHHd4M6E5J4nJDF8eD1dqbCPMgKtsN4urwWCvanvfqihLf6qM4ZD4D5VR+BYzKtEhOsXde6qRWVHNcDbd9K1WjPsNFggYDAWO9zKYYWUAyQsuvIXOlWlhXnzjxdOXqype4AMoD8Du1MQEjBnJwsZAQgRFDOYzz49+Lhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(2906002)(6506007)(966005)(6486002)(478600001)(186003)(6666004)(9686003)(6512007)(26005)(54906003)(316002)(6916009)(66556008)(66476007)(8676002)(66946007)(4326008)(41300700001)(5660300002)(4744005)(38100700002)(33716001)(82960400001)(44832011)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aJtixyZZ9/ffSxlU5bdDI6SMZ3pWyxX11RvhQmiC1OXBR/T/U6q+Bg1mGQO3?=
 =?us-ascii?Q?/eTwYN/yv3QPsE4XNymOZ1ST/w3g1U6NA7rlklg7moADEUnifGLc11BPU6ey?=
 =?us-ascii?Q?3GEx4JjppXNSWbZmyRvzy0zsnnJOfSiElnR008gWRManqqi2k1Jodd+PhXf3?=
 =?us-ascii?Q?cqr3YagtSGCrb6NLPJE2OCWXP3IJ5o/etfbA0SnXkCNA92d9em9EN1x6gBjd?=
 =?us-ascii?Q?kv70gkSFjn/dFxEBeF36BrurjEoTqkXf7lWBvrHXtLP5PuFcgFcMqa1olewc?=
 =?us-ascii?Q?9/sNZq5Vw+UOXQSWpRF/KNHWDFbH9mBLgzebGm0uyL9v1rv554mIp5pPUOpT?=
 =?us-ascii?Q?BqfzAPImExDh4/IdSpDVrHCtijwiTTJiZP96NvF2+32p0Awt1PljoLZhmJyQ?=
 =?us-ascii?Q?hpIiQs6iKKyIm0GMy+DSpJrffzZLTjIApjnXb36TrL7W1AaNleyktuqku0do?=
 =?us-ascii?Q?qmMxivsVO5/81thQ/61eiLtbUK1TBcDqMZobuUm1hKoOq1rgbnrflVrAIPeO?=
 =?us-ascii?Q?RE2gG98/SV1NH5BoKvWP/dtQpg34quZqnAdM28bv+4bZ+wPpoHYC5MsZVEgE?=
 =?us-ascii?Q?+L/oPyx0K09wAmKSN48bqH07Y7e5ULsiVlZBWepO8+cHkchASjpwJSdHax+H?=
 =?us-ascii?Q?rEGzB3yYWF+0KornU7bFgcDW8ScE9oh4cuO0U/xjKLo/P1kHjXsxOovi9ZSj?=
 =?us-ascii?Q?PEaQAeDrGV2ezHa9syuOFUmmwmYgzNYpmjOedwcKHnSnAkCsnBgk/ayktIjR?=
 =?us-ascii?Q?FPn9oyUn07jElrpERQeRuQZMxN1laMAkdUDEHxP+bcijsszsDOUx5Xwspb2x?=
 =?us-ascii?Q?GYvHbtAJ5jhJijdR7sGsTCyiPPtvQdpQHicjSB3gkEp20ztNo23hTDGqTwG9?=
 =?us-ascii?Q?8jjtdNA+tdOd8kJHXvqhOExLYaoeh8zwc6y4Xy3iXFihQo5jOBj7JYIIKFG1?=
 =?us-ascii?Q?iPQOoBZwjfiAFCZAJCGz0uYWUzI5c/I3W4X6cuQ52ke4pkZUhGoQRXE0zhID?=
 =?us-ascii?Q?B2lyyisp22tGE4iiIkv7jp6KWeG03e8Fr104nTR7iIV4yIDrSW3SNSCQe3tW?=
 =?us-ascii?Q?pJpT3Zn3J9WFwywrpUaL5OWr37qEWwVVBxXnikXkajd6xGEUGGtrRgxhiqHN?=
 =?us-ascii?Q?aZdCdDCZ7YydOsvJFoGMgncSJfgpJ/L9TaF3LZM+cYEQY2JI/+QOhIxL+jzs?=
 =?us-ascii?Q?M9Q2JcA4TBSBUWgRcRawrV4OeYAOfCQOVOKqAVxsJD2ZS37E+qWj7srt1ugB?=
 =?us-ascii?Q?ISA3hGmt3/HVu4jJGOXsEP8w5DBGSNaHBX9/5fDqH/UOMIxLR+h//LBMV7Re?=
 =?us-ascii?Q?k8Xl82b/SotTWuVCEFWN8LxyVUPD5bSSldwV75xSpsrvmJ2fWbGCG3nNVN3E?=
 =?us-ascii?Q?ZgiFUSSbDfSZ2rO3WHaLmLEclJHX96cQ40+DwpqMd7aTIkE6cEq5W0hU1KhO?=
 =?us-ascii?Q?sip3cMvwNl242ATiW8XLREZoiFw9N/Y0dOTy+nBoGNtRXmTaEGp5oiZt2mIQ?=
 =?us-ascii?Q?tAW3I9DdKYAmpdyGAOUW5liB/DiCf0iZVm7+/LiFwm+Hro+E9kZ3KXOceAZH?=
 =?us-ascii?Q?BK79lFfp79TdazAbZTatxv8LpRZbU5gEEBQhIhGT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f14b1f-f550-4b02-1299-08daf21859d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 08:06:02.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cofCXp0rqAb+5K8LEzT/JA7cfMf0eewOiJxe/2IhMflArcQ5adS9kp25apS99hh7xnqWH5dQp2Mh2JQBsou3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7380
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pavel,

On Sat, Jan 07, 2023 at 10:50:44AM +0200, Pavel Boldin wrote:
> On Sat, Jan 07, 2023 at 10:18, Greg KH <gregkh@linuxfoundation.org>:
> >
> > On Fri, Jan 06, 2023 at 09:00:21AM +0800, Aaron Lu wrote:
> > > If you do not trust what I've done is what I've claimed, now the
> > > original author Pavel Boldin has given the patch a "LGTM" tag, does that
> > > address your concern?
> >
> > I don't see that anywhere on lore.kernel.org, have a link to it?
> 
> LGTM.

Thanks for the review.

In Linux kernel community, reviewer normally gives a Reviewed-by tag
when they think the patch "LGTM". And in this case, it would be a tag
like this:

Reviewed-by: Pavel Boldin <boldin.pavel@gmail.com>

May I translate your "LGTM" tag to the above Reviewed-by tag?

BTW, the kernel community's explanation of Reviewed-by tag is here in
case you want to take a look:
https://docs.kernel.org/process/submitting-patches.html#reviewer-s-statement-of-oversight

Thanks,
Aaron
