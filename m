Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5045B78F7FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 07:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbjIAF2r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 01:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjIAF2q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 01:28:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C3CE7E;
        Thu, 31 Aug 2023 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693546123; x=1725082123;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DhsHqHXU+DSpnyYrnS5FXIEelQFey/YVq9ZAgKxOJDc=;
  b=b6ACE/02DLgtZX9d9+tK+wrveRAkQWegis2B+CjxBUGdxuUHHG4FrvL4
   grIq7HUVB1DyrAQH7KCG1JvsVe+C2xmNFnxMtf5BIakyuBFSZx96nt+xo
   svuF2jPtXOwwNhezoEiP3BobOhIaJDPcLyMouWVxUeq+8+ShUpwe/6GQG
   ugJ0e6DMg3RqnjnSNof2KSipxZUY2trm+QTZtv4IrxcyBNxecgIYft35w
   YUQmp2BrKtoKOhBZFUFVZsP5waeYxwc7rSHL8/5fllgTn/aQGi04ppmT+
   1/AHAFiqR8e2qGnA8l++g9B82B+MDFLbVbdSqc4M8KkeZXW2kq1UTdaxE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="355634852"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="355634852"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 22:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="913576900"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="913576900"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 22:28:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 22:28:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 22:28:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 22:28:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 22:28:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiIzO5kq2KXG/TNHT89gIKtmD0d8J2lyRlVovooljwJvzNjLdmL/f0+7U6Lf+u5tmmgTQAOa/jpp9xaUN/oIyR+ii0YEosmr5dsu1qKwyhSr01DP847PqJHb+HBtW+Z7UlLYkZqU19iif+nn65F66y/YQQp8lYaJUr5o9F48QLzk15ZMedO79Faxt1UDjAF5HYW1COvdk+LkY7gN0D9gtFR7yOU74kpxk6PHX4VjgkoMl3OAVP4ExEqJmG1e1z+p729e7MFjvtqbAa7Hz+HnVioJmeh7MPLvtLe4gOZXSbLTW4E4+8pTZ/siaJAiXMBvWLyOWZvYL78crtcaJIk+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIgi8+AeL0q+RrRBv/kNhC1mQMlLYgwHef+SiqegTcU=;
 b=YpodPCxvQ61KiMq3CW5yL+eLfYtovzxBK1iGdpkGlOnKBlQbPtReeN0l5GRv7jJka4lWSLZZb4vXKQYZ1zkI0eJMeVe/YZufexp2H93M/5fMazlAOJLrVIvSqRoUOXWgv03CrAlaJnzW1Ds651076Z0B07bOluD2OOha4ikkiixUfn6csgv8GadANdZ8lIjHWWIdqOVN/b52dxpSDVLY+XpqQd5hoIUkrVJmUEJoDdT5hQ/qrQ1qR9yGXBmoU5+zmuvo3q4WLjCKytLYLzzX3VAh1oXmGkiqjxWB/scY4NCNpN/USOcVwAEj5X2dFFn/t1aVp4T8g7LwmHCrzQipiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BN9PR11MB5401.namprd11.prod.outlook.com (2603:10b6:408:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 05:28:36 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 05:28:36 +0000
Date:   Fri, 1 Sep 2023 07:28:25 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] selftests/resctrl: Rework benchmark command
 handling
Message-ID: <kakc4c4cejhxlq6y4vaerkguxqwz3idiujiwglyys4y7ej4ghi@mqnpctziw4dw>
References: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: FR0P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::12) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BN9PR11MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7e8bc4-83d1-40b1-00b3-08dbaaac4a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1i27p1FH9TdfwxhXfIW/PC02suFEthTMAAdihyrFWm9tOsF/aRscUQUa4FE8fzvcd10Yd3GtUK43dAX0yK4ui+BlCDaXF8XSUcZCsxW/YdJE7nabbk4KOS/5DGSxb5JF/JRiZR0TjPGxhLBFxogEbNRCtU0EtxqCQfGmedh8tlT9z/XbDsbQWB8N1r0pTQLn54OBJ2vSaJ6AQCdour87atSinsqci2nWhzj3clH0srexK6TyAlcl5ljXj+KnVVwkzm5CyIMaw+/bUWZQ5+GHWK/wPKJ07DoVZ0Hc8LnZhWa/6d9mbXtqiyFCh0D8C4U2c3zlt7sKFy5hV8Kddv5i1Fyze09Gej79Qu3g+oxHxvLb5Bbv2Xc0KktaFpZiRLwBSE8UQ3Ixrfg6ZWKz1YLOHUFMA5iCI/YdYNaEgAbEfQ4Ud67mx/hhoTasW86fU8PNi7AhA8bExAbdHK+7XYulLUeKJ5uIw3Ly0gfpOn+3jGLZ8yc0AcYMbVkuBkrv9B+LxtBrPtKDjSr68h5lrTvcOzItkhn20DNbSVEUj8y8yzdKEgO/QdQELJE7Vl46uGf7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(1800799009)(186009)(451199024)(33716001)(2906002)(6916009)(316002)(41300700001)(5660300002)(8676002)(8936002)(4326008)(558084003)(86362001)(6666004)(478600001)(26005)(6486002)(6506007)(6512007)(9686003)(66946007)(82960400001)(38100700002)(66556008)(54906003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XQKyeo01p6Mnh4Fglqnaukd2rDdhTiy6uR2Ri5Ccoq27ySo0FsRBTRPO+J?=
 =?iso-8859-1?Q?bH/juoZIzMlF6ruLNpdUcLdnt06z3BAIn8xTi8wyR9pLSYKt0moKNgKSdX?=
 =?iso-8859-1?Q?ReuukQ8fBQZSI6e/PM8z7ZI+HdIVjOIocD0ZUaGmAH650Tz/xt7085zcaO?=
 =?iso-8859-1?Q?hCfiPhvGdFUIrl6G57RR98lIAalBtcM1r8d8q7eXj7QyThRnNk1iqbuP13?=
 =?iso-8859-1?Q?TF9cY069Optccnkuj7nqKjzHHJU2HOIwAR4LZC0DIuiRrGPgob3N+BTjEI?=
 =?iso-8859-1?Q?tstC+6EgiCqnC70rdJesHNgeUdnP/TRQKKq9rAOQcpu3a4WFU17NZSTLuX?=
 =?iso-8859-1?Q?JMpBu2kEVCpYTAN6O5hLnGMa02amne90Gq2GRENtXiXU03OuP6dmbbkqjT?=
 =?iso-8859-1?Q?+SPNzcnZyHCf01MHl8bpXFNYzsZT5nFrjxyNoWvL1zQVWpI+NmyCfPJXW0?=
 =?iso-8859-1?Q?2ESEsizb1Q0JeffUNNWMa8prNkpFBVYeH98UElUNZG4yO1PGfTCjMTzMxr?=
 =?iso-8859-1?Q?1NechX3JC9UxL03la3mMN23d0I4fOvwLtdgaUvvaKmWAb1KKkrczxYC+PW?=
 =?iso-8859-1?Q?ZODinEuf0YLmI8FGoglgD8GDct1G3HlCEa+xJB0PjJsSSYdY/oQPCE+abD?=
 =?iso-8859-1?Q?1DFFWgdKx3wmrGuXKReI13T65EVT1VYhUTdpXQuBu6TzQ0kmp6clz66ZNY?=
 =?iso-8859-1?Q?H40ybqJs0BZiKL1snUmBsV0EJqoGoYYDUxz4VJ1zYjBR/m7ieCF5riRR7c?=
 =?iso-8859-1?Q?gzjhPSRWBFLN6x9tzNpWeyPthP82dhLpRSClgzIVdv3YUQX2MZ0Dkyx+at?=
 =?iso-8859-1?Q?SkXsrFc5V8omGphErLrlVphMgsevxCBdEUn3QlgscCTvPj9KOB0WKa3wgf?=
 =?iso-8859-1?Q?+cxKwJJO9yQoEP496kkHistUTDFWpd+vZY2Y0RiLPHdhDZtv4iTzNQ4k/L?=
 =?iso-8859-1?Q?VEy/i7O7tNEEdkOL+KHdhI6QSTsS8bkkRUFPIwuZYOlxku7lK/dTmzAqjB?=
 =?iso-8859-1?Q?/MVfOT+bUAU5LRZYHQwbtDmtp1Dmm7q/T65WPv/Ec8MsbFnMkjNt/vGJCn?=
 =?iso-8859-1?Q?2nOR8uTlBW36HlyLt+7DJWdhGJK0ay9Ob6W6Er3InLklgovCXOluLuXgal?=
 =?iso-8859-1?Q?IOrJTt8THUNgKfqGS0b1b+YL4HdF+4QPeQQzk9ba9g12WydRFBpnODHv1F?=
 =?iso-8859-1?Q?cheLWEoOxHNqYg+W338OsssQmk0DmAQ9PNMbQhQxM8EDok8YmfvADqPiU8?=
 =?iso-8859-1?Q?I8OGIEaD4wo5EYpzxsMepu3AQSAtoHP2vMhQjhXt4aJWQWE6oAeKGA225M?=
 =?iso-8859-1?Q?u4YN+XGNWgwdqhqPBVPO4ZxqGEj1RwdLuSocZtms52c6UpOfuFAmebmIP6?=
 =?iso-8859-1?Q?qiBLHICqTnhcIhG2Rb+5Y3oWrWci6H3rrZr9pJeXwOp2cJa0BUa1MSHtn9?=
 =?iso-8859-1?Q?2Faf+uoZqvzToAXHtQyeViPSQZRWABYaouL8HQ3L1EgPDL0i/L1iiTLGV9?=
 =?iso-8859-1?Q?2jhuRYnLGfshipxyws4vHQrknwjlYVZ9zKHaTDT51OS7guVpb6FILHN1rL?=
 =?iso-8859-1?Q?KtwPBly99n5WCtsAnFol77OP984or2NpNKohsCkB1Nnz6vxnp7hqntzSOn?=
 =?iso-8859-1?Q?oKGoq/b5eC0v8SIdsTKODyk01aRWEw7G69+gMdgvbOqHqE3sQLwsw6V/dJ?=
 =?iso-8859-1?Q?wI8goAfgdU7OBk/b0CQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7e8bc4-83d1-40b1-00b3-08dbaaac4a15
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 05:28:35.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J73+Ciqod7hvUS8ZrFDTh+FPp4baxpOceJakvJcxkdWGROb/nxHlU/CGY9fNiHlklmk47NLDsbioUhk9TwMudYM1GlMTK5b0cfyov9rNbbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5401
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

Hi,
I reviewed the series and couldn't find any problems with it.

Reviewed-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>

-- 
Kind regards
Maciej Wieczór-Retman
