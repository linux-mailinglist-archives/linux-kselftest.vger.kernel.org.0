Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2968D69BF1D
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Feb 2023 09:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBSIdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Feb 2023 03:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBSIdS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Feb 2023 03:33:18 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F8F75C;
        Sun, 19 Feb 2023 00:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676795596; x=1708331596;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VcNXnRuS0kJoeZkMB/4qDGvap7fMsNQwIOYOyU0KMU8=;
  b=LSpuWpuuNjohJeo1E9AcKUVS18tetC2wRDK9pdieQlPjz62cuZUy1aLB
   Dk6/7TLLohEiHkmxo0wU3Y3lW6xZ26c5IUFzTAYC3cJSHbfMi+eT6Wbzi
   fV1yIQPrF4+SlTDX3/DNY7T0NUpgFj1TnCgQSiNJoa50dCjsketquSJ+p
   HEAWb0MfblTdhV9JAPvrWUqRjc4Ub6gFcqP+q/8KROOSeX8D773fXgyvM
   A/IqktYq6OwrGi7kJYH1cZ0d4MWqyIyEIlqXI6CUX+mzdpM+x95mXdbIG
   gakbK41L4zW78YyxjJfzG+AMSuM5Is28gGxCHLSrIr36zcaKzZaa6oNiF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="315947701"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="315947701"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 00:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="734795258"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="734795258"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 19 Feb 2023 00:33:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 19 Feb 2023 00:33:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 19 Feb 2023 00:33:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 19 Feb 2023 00:33:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 19 Feb 2023 00:33:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gadl9RuyntcwrAX2swkFCteDZ293ZO97EM+2EgcUX//kmglLgNLr26GR9TK5vIjvkSMGB/qbyQMWYwUJ58S+New1naiaKi7OPQiZrtN/KJfi1wCubQtMwtbFyUPtwmaKIGGWDRiiumSy4wmR/3vWUzlyujZm5zYbJAlXZkwf6LMNdhslc62p66oMaNxnf80iReU79fgpemCrvdYUetD5KH5W+Yvcv6/ZO4SJzyIr7QauCNcFYSHOiOYfSI6l6N+ZJsg9GV/pFuXAKimwz+Z9A/4uoS96lD6TjmXeII1a7l5674FmYCm68/WOiLwgaJwKYO2nVjkA/YPHGr4RIWYimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf8ZulLOGmzEFe3rHJSHeCmrNc595/B8LgFPKZu3EFE=;
 b=Z4VFIOk0sslcgc0oSzA1r+6L73yqQPCrMRenWU58p3uKv31J+CPBFmW5QCErzNnJ0donAwK9bawYM9Hj9R0e8noMIjfpNRahC7k1RgVe9ImQeCK5ctP/i9zK1rpfVI5LwJJby4AxF5MG9ilSEc39W7JxK2LmKMZ4CtRYr7JseHekYj0rACRPxMAhVoyKpNHq79bkhrD9LkXwoA4/ENrsdHYBa9T66hfYYUhbd7qCxRuS7vLoP85rPQXlshXkKqkRga0Mr5YCRgGhFwmCI0X08L69e4unpxNPqtIA7PJMMyWVBDZmr1lrkm3dGXBDumgvzvB7b4mxEwzj5rHn7QZN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sun, 19 Feb
 2023 08:33:06 +0000
Received: from PH8PR11MB6780.namprd11.prod.outlook.com
 ([fe80::5cb1:c8ce:6f60:4e09]) by PH8PR11MB6780.namprd11.prod.outlook.com
 ([fe80::5cb1:c8ce:6f60:4e09%8]) with mapi id 15.20.6111.017; Sun, 19 Feb 2023
 08:33:06 +0000
Date:   Sun, 19 Feb 2023 16:33:25 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Mingwei Zhang <mizhang@google.com>
CC:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jim Mattson" <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 1/7] KVM: selftests: x86: Add a working xstate data
 structure
Message-ID: <Y/He1Sro3hb7Hn0h@gao-cwp>
References: <20230214184606.510551-1-mizhang@google.com>
 <20230214184606.510551-2-mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230214184606.510551-2-mizhang@google.com>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6780:EE_|MN0PR11MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: e3084af5-7080-46c4-d757-08db1253ec7c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBIsNxkuKKeA8wfPkyE/kYdwQWAs+B3BtufwkfFoTQPFyH9vEXgXjmKVRCA+j7YtgsMR8lgNMdzQHbxm+pJvhEVevpZBEcdXHHsSxyhXd0SattQ/Bq4J7lzekdlx4n3S/Xa5PifXeeylf/ok8oS02YCBSJ+QVsB/PEL3i6qiEnHYKxHiW9Sppi4cjfiUNwlQ6C1YHdBpKvDKXP3v/ZNip254RRqvdHdmggdD+7CQxlkABcabVYl7JM0ikEIEO7KdGGlobdckYM4tJHaS7FCLmAC9Tyr0kPYltU5E7HJB1YJj57sOO9cOTJJ6n77D8MQ+gs32yGvb6NTDkKVIDr7RO7CSIfyOiE87mOsIWYhX9udZnAFd+FUTgL4oiprcN2bMnP8hXUL6xynqlnHW2k4ajFTwkGCuGAalNXoP1uplx/xwhRkiMQpJDnPZRgjFgyKyv+5qWmfyFhCHGToOCCnH0KA/F+egNdbQWpIZ+Hs/yC6qKpJoDHwh3TE3dy0rdjViGyJIAkap5KrHhtc6VUBPmDSaQepguLYkb/tkExd4cKp4seSSLX7Dr9bUDE28dOsC2W/kDzw+45tcp3fCDxjz9uvD04maOl1rBq+Wm2G/HwmXlHRu3M3V3azzILEZoTRIWwD70+4Sw3ZjrrwQII325A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6780.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(82960400001)(38100700002)(41300700001)(107886003)(6666004)(44832011)(9686003)(26005)(186003)(54906003)(33716001)(86362001)(478600001)(5660300002)(4744005)(316002)(6512007)(6486002)(6506007)(66946007)(66556008)(66476007)(8936002)(4326008)(6916009)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2FVxeFasO3yY0ux3l/Z8EG6IPfBZhZCwiyGYMoxYuKFtEzu/S03onPEIiFBH?=
 =?us-ascii?Q?Gv9kcq2ZmCl3uYy/2D09ouUYfuOpiD7tGzZvZKFvYgmZ4mNmVluGgQCa4ceF?=
 =?us-ascii?Q?Roox8dgKSQwHgvaLfUlZSYKlvumWcnedKay7+I3eSe/3HyWlpe4Y/1i0m6dW?=
 =?us-ascii?Q?2VOJ6jSepOdGy9WHFauKCSMAThltz5zFmem6uysE3oMQgFaVzrE3eiUyHXOY?=
 =?us-ascii?Q?v5nM1FHPqsqtHD8yaeX7nuZrn8VKq8mqEhDnvuRZ/CgdhbsJ8CiNOJ3/2QFP?=
 =?us-ascii?Q?1If/rADwJtMvN/vF93qdqfC1HMp8c5cRbJVziDvD/pRjkqS49BYMl6nEbo3g?=
 =?us-ascii?Q?Ymk5lJ2yIS3beLEkU1NE9xoL6NKOph9gXWHI3JgD1CT1kEZqBH/QIxxHa2x5?=
 =?us-ascii?Q?RNAegPnW9BMnHXrPZUBCIQadBkCLBL9keC0pFQdqlSCoPZHb3Ft/wkjk4oPq?=
 =?us-ascii?Q?4j5QeP13qKvfH2wmEMa6IUInejrrnJeFjdlSZE4kNgH3VixPDJjd/q4ZF8UY?=
 =?us-ascii?Q?WOSKy3Eu4OpOQp2gh4NVZMtle2206IibYieXsxvczf5yLN0rzmjEkN+VFu+I?=
 =?us-ascii?Q?J4hsN+mWG8sooO3SI9cz/CpElMU8ON8WjE7EH8Ow05AM2rRp4rkwwbrH9kbJ?=
 =?us-ascii?Q?XlgXyY/qCuvrQTNI8iBiFSM+mJM8VMhu2AKA0sCJLRUa5Ah3JSj+ajA3SKpv?=
 =?us-ascii?Q?PQZs1Y37ZD2eN8PcFDjKZTCczV81+7MvJrj6SxQFzgLAwZ4HkaxzgAN234ul?=
 =?us-ascii?Q?ZhPPrPQYvflPl1l2IU4hVy6NgNPdt+bVXXxaHNuKI7mXWbkRiWJ4jWIRcxgL?=
 =?us-ascii?Q?Rzbs01wrUDV75ojPeMj6tW6FuxH6UbyTi+eqOTym1H87fF1vJvHDjjHfRsO4?=
 =?us-ascii?Q?6voxz1DK7crmvX+984n9FGaFYd52gXZmG0nhtkKIEZs2PhA1wdLHsts2g55H?=
 =?us-ascii?Q?fh6NMvoWcNLg3iXZpe8jZEAvKUMMjN9ErYkRgM7jTOvr92hLOgXXyh+UXblp?=
 =?us-ascii?Q?SYrYeB+gdyE1R8wG+jv7E8p1ya85fKrUHzW1hmZ4KUQ+6BJbcGGmkDZr5OJO?=
 =?us-ascii?Q?YQHhi1pPvPY5D0DI5UZ3zWaapD2BJ1a32MCKNI9l5XL5tphHfKG7xAqAvde0?=
 =?us-ascii?Q?n53mWwL2eRHznejXmPrDmaGUlPsJUVijfVR7/+5z87omWfKyQT+OORnEcTQY?=
 =?us-ascii?Q?GVPe3sVqLHJCWNnEbmAlMNABTQKkndOB2OnDOhAxUPZx8hT3+S2Jwng7yWoi?=
 =?us-ascii?Q?3RhZ5deUbSJkaPpqMWAbNxaP/iaUTK3DpcdJtqupx90mceFRbytwVMYGreDk?=
 =?us-ascii?Q?IT2JrtzR15SO4it1a1Xcaw84q992piNCXxcPxOKANnGo2yn1zLTu638xNiyY?=
 =?us-ascii?Q?3FIJvEqIa52acYhKBdtVLcdfm07LJljf0o8yr5iJI9iEpH36AB6zIrF2REst?=
 =?us-ascii?Q?DtJ7FbhlLD/B9uDbm4Gb5NT2ZBMIBD81KNbEVxpXACHJ4/rtg4WoICn6ep68?=
 =?us-ascii?Q?+fH+HkUOz0HB019NgWcUHtrjt0owMwjTO2mIZ4gXvIxLBhIOy9HCkrOwqvNk?=
 =?us-ascii?Q?yY8+GYxzhAjAn44G5J94+RzdhO+IIIsZz2LRe4Ro?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3084af5-7080-46c4-d757-08db1253ec7c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6780.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2023 08:33:06.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI9NqIwFV5QS2xyJ/PcoTKvVC21JFPCQltSBYEttGpZEwaiyhpvlmKKDtwjNwmxFtTm9QSNMMcUJrbfH4/C8mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 14, 2023 at 06:46:00PM +0000, Mingwei Zhang wrote:
>-	/* xsave data for guest_code */
>-	xsavedata = vm_vaddr_alloc_pages(vm, 3);
>-	memset(addr_gva2hva(vm, xsavedata), 0, 3 * getpagesize());
>-	vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xsavedata);
>+	/* XSAVE state for guest_code */
>+	xstate = vm_vaddr_alloc_pages(vm, DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
>+	memset(addr_gva2hva(vm, xstate), 0, DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));

					    ^ this should be the size in bytes instead of in pages. Right?
