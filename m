Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B550974CC72
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 07:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGJF4F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 01:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGJF4E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 01:56:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54868F9;
        Sun,  9 Jul 2023 22:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688968563; x=1720504563;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wYJcIYySX+SJ0oSNuHkV0uVYqnUccs7v+gboXsjW1N8=;
  b=gs/VEEW6tbHjaS3pO6FEIXJKR3VsSE3kaF9ihKu39lZzpHHDGXYha9TL
   Pc6Koc8BadoKv4Ao4gvYDukY5dw4PHpg+4cC0CdpyfHqvTNHUeL2lkLlo
   Y6kK2pukywYXwetd3LHyv72eLFJ1SQ4hBDNnnxtJ9JGz12W3vwIDn7Hdg
   BT5o/SdAWaHZsfzfAbs9Z4lU38D95wAWO2fLJ3d404y6ir1+IAdpLCRPt
   CMhdTaAHx5WMIAWudMDFWI63VR5mjiSdck9VjHeLxbLdoIAJ/86Jpfp6U
   9vqw9cweFE+o0q7E79sHnzhzWi6UmPrU6IJQESxG9G/pwQxpJaAAtbDOk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="367758236"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="367758236"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 22:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="844769065"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="844769065"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 09 Jul 2023 22:56:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 9 Jul 2023 22:56:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 9 Jul 2023 22:56:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 9 Jul 2023 22:56:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5x9uFSle+67XJKxwZHbaxkYRLqpmEVni5jZAC4dIdKFQlYo85b1c+/I7ND6QAuwG+6xixHDgVY5T/dJ/fDVaO0aPP758p4Pn2P4qXp+Eh9TUNr9q3wGX45Qne1Na3f37lG4rRyPDSDSJNuaxbp88qNAFq7SJJHHM8ioRdXbgNSFtuAtiH7/rGhhOrf9oQYUfVO00xQV6afVTrhGR8lHk3rBubL0GvwwyLyGPSv8QRRZMFxcG8r71TuezbMEUMbne2nY6ipwJVKCMmYbtbpJY5hWFB0No44Vnn6ttoErbMSTB3IpE34D+b4hGqOmvTwv9mRyDteIBKKzzwCUPimxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwbfdKOzFnlzuLMd2+VfiBeERlrcIoWruIQT0EB/fx4=;
 b=VvnByd0c0kw6yBTx7jVFd0UovO7UbM9iQEE2n0+Pn0AsHut/2w8GtuZbP3xlKPVNRJyi/oSJtaLVz/xWCaiUVHxZRr2h2wIEZEk3HHSJKOdk3GT6DJkyMJoehVOkaFU6FNpgC8A1rxyl2FNLkPO22SJ7PcO5f06jzg8TJRV+qgi+U0J7X+XTE4MVGhVOXvmZPGyWoNHE959z45CQBuSidFJLqJZBbxnSSpzNuXXdYx20HbJ9MzXaT8QTm0sIvUjC/QAf+ikRn8Tk8NHEzxzH507OOQRxY00bIoyrOyjqjbNirxoRYI6tSxCA921DYV/kKWPhkr3ENYRkiTDxkqNHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 05:55:59 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 05:55:59 +0000
Date:   Mon, 10 Jul 2023 13:51:42 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <kunit-dev@googlegroups.com>, <kvmarm@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 296d53d8f84ce50ffaee7d575487058c8d437335
Message-ID: <ZKucbr9WHLipxmAh@yujie-X299>
References: <202307032309.v4K1IBoR-lkp@intel.com>
 <7d3d61c694c0e57b096ff7af6277ed6b@kernel.org>
 <739807cf-4551-4760-83e0-a94026b5c1b8@acm.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <739807cf-4551-4760-83e0-a94026b5c1b8@acm.org>
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c0e95d-5ff4-43e5-f757-08db810a5564
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e02NnTCzC92coVCSLdfp8EapCWzlj0c58hKShF/0e+d0h27pq5sWx3FfRsT4xq3fZoA33XHTcDncnVqTL0fMaKmTX117tK1ZbvSEv4xIKlilL9gospy11diJnLJaEpa5nC1ES41jMJfYYmAsqv+9MzRNatd8OUojnu7+9/rw+xeFs2AMDUkw1P63iqyGXEwrJepvLPBqjdKmEg4ek7M1beamfBLLTv0VsuUHG/wd7QiDJNSVAXO69nxHctngLPayN9KEtkRMy8D0NeQHAdZEHv3ca7V+EB8TRvAEegNBNRY7NMik0UcuQ0kuA7DghzDKBku1aDVth8mOzHvxy8dYWALYVCH5RwujBNQYDr2Gms9WHTimHi8/XISkKarLocfddBrYGhjdAlMyqedBXFXCSr5NgSvljtiJ5poZ8agKIe3/NCYFFSroVfOMXgTvL2Y++qGach9rCfhyLa2EHGckKdRMESr8252aZ38wAPEy3SJuVK/dNnZWIfrm29hJ+vDhKJSkJJazf5DwTGnp696LDFzU47dWwCvWS9/V0HiVtMn/5mRMxfmrEXUx/ms6KBjuX+q2aVy8l3wBvfj0vhyPWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(41300700001)(44832011)(5660300002)(7416002)(54906003)(6486002)(316002)(2906002)(8676002)(8936002)(6512007)(966005)(66476007)(4326008)(66556008)(6916009)(66946007)(9686003)(33716001)(478600001)(6666004)(86362001)(186003)(38100700002)(83380400001)(6506007)(82960400001)(53546011)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BJ/uLB6c47wttZJb1LGp90k0R5f10SUubW4C3Ncd5jmVpQiNS5+wv1Z8hb?=
 =?iso-8859-1?Q?YmTnqncsT0l8EOLFKVRQ6ijV00MFJAGDcz2rxfk1JOw6vgYzQJKlx73Qt6?=
 =?iso-8859-1?Q?UO2oLBj+MiItMcf5iCPRpOaZo+LVTFwLxIyyZlMLGI7okrf/uq0VHJNp7t?=
 =?iso-8859-1?Q?VKHTadJYNeLrkMEobM8AW7ovIzqEPuVr4oj4TW22qmYjbroQozuhed7In8?=
 =?iso-8859-1?Q?VaH0aIuNTFR+qG9wLZ4jQ5Hb+shMfGYkRTdBmmLvWb7dpy0KEgKZ4zpGiC?=
 =?iso-8859-1?Q?ZElMt/PHlLoFB4+o08Jui7/i9pbFWVmjXy9GBPkwJC4pE9A5K0HotEF2y1?=
 =?iso-8859-1?Q?aWLUMj3uUeAFIaE+9aJebcerkOMRDclqa81x9o3TyG7vLF2Qzreuui9ZMU?=
 =?iso-8859-1?Q?DOCQsXPws6grBEe5qQcyA4eFo7wLmPuOo3oO8vEqkhtUVZvDPiBZBPyrQT?=
 =?iso-8859-1?Q?k89/hYYY/3W263QRq9Wgp8PwnQxXtSLwCp0OcWCLjsr1tsEIjeDjyvJwzz?=
 =?iso-8859-1?Q?VBjwCTBXS7vQoiWx3qRYJnpCVQhLZus2w8ITTBHzzceqpVHyQJjcXVk0qZ?=
 =?iso-8859-1?Q?JHJR6YhvpIbwadZx6ob9qJjmxCwYqVLq/AINYdcuKC1oGxr82tB5Sh4LzH?=
 =?iso-8859-1?Q?MEtuW8HQO5YOmJ4LfRNhPAYV1bEkLTujztpcC1VUh5AO5xIRD4xAdOXSfj?=
 =?iso-8859-1?Q?nfhgmDHNqhdtYebZYKgw2tbmOk8MUlhU4eraKyLECfR+27NUCQ0IsjwjTr?=
 =?iso-8859-1?Q?M2VY/DOSK3At4OSD54sBU49Vy0RQ7eL5Fv482DR6iXnLteiZ4ANX7xfySh?=
 =?iso-8859-1?Q?CxijRVaMWpbGrcWw2fv/fuutBlFLw3poN8bhfzAg+Bcf0iTVxqdipQDx2q?=
 =?iso-8859-1?Q?/B5iMK44rzEzCka/m1nX6C4xGD5BgoYd+SQLbWc0VfBQbU+5d828L/B4PZ?=
 =?iso-8859-1?Q?Xkx6HnM0EH9FWW99UVPEYycNfBLU9fZnGOPGkD/P+EErScmx46Fe4//APV?=
 =?iso-8859-1?Q?5S7JAJmi5POkKXMBDff76u3/LKHYo6K4nhmpkixlVjFYBVoia6iEGMS3wZ?=
 =?iso-8859-1?Q?KbnGsy/XY91OUwvhwi/iRbIqVJFwzGXRZjNJyMOGtf2K6TGdYcwKYbRMXF?=
 =?iso-8859-1?Q?+R8g0NwDwgoc8Wu4w1zvfru796XDyrvlWAHsKMZ5jdxz+iuPBQOM0d+Ttg?=
 =?iso-8859-1?Q?zdoHcc+S/ln+A2nXgdRSWghiE3Hu6epPgP36wFlmsxQ3GePdXAFVeuL4I5?=
 =?iso-8859-1?Q?EwgWtC4EUUH3vCXmgQ4pb7kjRbFAgmLhQAFKaHjGqSBoGwnwA9xjbLIW2q?=
 =?iso-8859-1?Q?yYhI+6cPO/+5Im0IMgJzcgnwqLTrhoUh8WcotexbZNTu7NQTlps4ME0FY+?=
 =?iso-8859-1?Q?kmZuLRoKUcDGWM4QpIly1Dr0ED/k0DkdhlpAv2/y8cmSlS1ZHAnwZOPb1j?=
 =?iso-8859-1?Q?pvmvEfx/6rzmuYEa540PO3cWmIz+1de8q860jSZAaGc7FCL9jPEKjGSmNV?=
 =?iso-8859-1?Q?suC7k+l30hCwq4vtADKoRXEXA2/nza69SKVlJpW5Mh4zVQCIoZIL7Namod?=
 =?iso-8859-1?Q?8hFtxXLMDS50bVJEJegUAy7TZ3EqUjNp8wV2SqQ3cfZKqrc7g08HoHryyG?=
 =?iso-8859-1?Q?fy0WSEvKXmd/U3wdAFEzXCw1NhekGarpSd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c0e95d-5ff4-43e5-f757-08db810a5564
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 05:55:58.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3wUJtFiqKHl2zrxiJrI4UKXeVPhlm8qj1Lsu3C5jintNGMNpKe5Jin9kG9fr5GAUETNhNoFUhsM6jmfC/Ov2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Bart,

On Tue, Jul 04, 2023 at 07:11:37AM -0700, Bart Van Assche wrote:
> On 7/4/23 00:15, Marc Zyngier wrote:
> > On 2023-07-03 16:11, kernel test robot wrote:
> > > tree/branch:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > master
> > > branch HEAD: 296d53d8f84ce50ffaee7d575487058c8d437335  Add linux-next
> > > specific files for 20230703
> > > 
> > 
> > [...]
> > 
> > > Unverified Error/Warning (likely false positive, please contact us if
> > > interested):
> > > 
> > > arch/arm64/kvm/mmu.c:147:3-9: preceding lock on line 140
> > 
> > This *is* a false positive. The function is entered with a lock
> > held, it will exit with the lock held as well. Inside the body
> > of the function, we release and reacquire the lock.
> 
> Which tool reported this message? If this message was reported by sparse,
> has it been considered to add a __must_hold() annotation?

Sorry for the late reply.

This message was reported by coccinelle and may be a false positive.
Please check the link [1] for details.

[1] https://lore.kernel.org/oe-kbuild/202307031751.Ztgi3O29-lkp@intel.com/

Best Regards,
Yujie
