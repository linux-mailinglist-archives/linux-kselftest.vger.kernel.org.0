Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C369869BF32
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Feb 2023 09:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBSIqK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Feb 2023 03:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBSIqI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Feb 2023 03:46:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990AF774;
        Sun, 19 Feb 2023 00:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676796367; x=1708332367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vApCXXdpCnum+B/QpBy4jNiyCsMPZd4TGQJKPraVxmQ=;
  b=UvUrIGadShGSEA+fRniP0TcfigGN0w7yhJhdBAV6gSObXVbHQRRNUNq0
   2C+8mk8Cej0Mo8r53xyXwXnaNOMazW4BNaKmCrHcb53cRZ/lthLQCeylw
   ffsa2H/M2eyvkQc62ggmyx/ZA8eFHnpu2ThOm54iWQwB4vuJ5X6tmrBCd
   7t5XMvPrSsze2lZK7JUD3yAW4zNYxoRLXdxB707GYrRkvJ/pbYRPGLDHr
   3azMWosjx2jjcMHItp8+13hVJi/nJVwLQM8f9Gg7KN6uoh8PR/DrcWVZv
   vzuyOrw20pDakaiLVeqtRiZDtwBN6NC0/Sca5OcLxk3gH9oznnuiYnM9H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418458133"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="418458133"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 00:46:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="701367816"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="701367816"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 19 Feb 2023 00:46:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 19 Feb 2023 00:46:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 19 Feb 2023 00:46:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 19 Feb 2023 00:46:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBbc7QT6iHRXE3OIXycFWaGbnc0Rq+Y3X7TFQ/ptQb6bz79VZgpdwaS7Zv/xrP3XKcOYS5zovW2joGrC2rDDH+8K9drF1XaZn6fr90mcqb7ObJmyW/Z0J2SuYX9AE68pzfrh85QZR8gud2Svcv0dX4ytAIGLZcF1do2OxPIu1oaaJICyuoucfwO9l2QW0w3xBE6zZz95lols7PlGvJIUpURlnWG72nLVhWhFDQiKBg4vwDvSouP4e9ItQF4/zIbduAZbz9WFKSTE9Z/i4foxtoowdsEl12nS4G+CRhaOBKe4tAQMiYLIhCmjD89owW5jG11jaTg67+IVoyUAMfbHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlvNmVUnlfnXidQLe1EnjAGjANH7fGEuyVWPgEGLdXc=;
 b=BNWMP6cHPdke6XUDzAgATQaA+KY77K0W3erqYpmwrnXwVvXXzwkzIKj9GNMGPZidBrSMiXBbWEAhXQYdOU99GTPWWV9pVtmfinOO85EPa5MY9PwXX3FYZKEHXk7ksuplRV6IuPjJNpRxJzSvFQnkwZK7k8+jleBxm2yVQj6Je0zfe20ihvtwZVQ9pJHlGaZ1qteosDg1B4zKtpEVHJWqe97kjSn0bHSiPKXTSg4ITfv8DlaEauMeb/E+SR53UHKIFgmLb6gf37tNFfZGkHaIDymf7p1Uxrk52CiLwnx/eiWxuuV9tMXd589sU9gLIyKv7pUDwTSDD7pCb0aiQaroXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11)
 by DM4PR11MB5406.namprd11.prod.outlook.com (2603:10b6:5:395::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sun, 19 Feb
 2023 08:46:04 +0000
Received: from PH8PR11MB6780.namprd11.prod.outlook.com
 ([fe80::5cb1:c8ce:6f60:4e09]) by PH8PR11MB6780.namprd11.prod.outlook.com
 ([fe80::5cb1:c8ce:6f60:4e09%8]) with mapi id 15.20.6111.017; Sun, 19 Feb 2023
 08:46:04 +0000
Date:   Sun, 19 Feb 2023 16:46:23 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Mingwei Zhang <mizhang@google.com>
CC:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jim Mattson" <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 2/7] KVM: selftests: x86: Fix an error in comment of
 amx_test
Message-ID: <Y/Hh31GLftx3eZJY@gao-cwp>
References: <20230214184606.510551-1-mizhang@google.com>
 <20230214184606.510551-3-mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230214184606.510551-3-mizhang@google.com>
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6780:EE_|DM4PR11MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddb096b-acd4-40ba-d40b-08db1255bbf0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikE1BihLvsnO16z4+VJsS9qYbZZv+9Na9Q7w+UKcZjP/F/fe0v0BwYT4/ob48lvxHix09ddmdIBEFsxKcIAlpZHeoOkbcFLeO0zNVBUvR07q7zyUvVXQcbIDmDn2UW2ZW+CO7m385hMecyMShyOdTrOltzzT/eLphOAwmle+I/h1rLZTDopIFgmdPgGYNfB0k+r6XBgNOrU7fq6WQLvG8/v4hs7Clyaxb4Hayc2jLyuabU6YxBvs8E/BkShE6txpwItaE4gCTCf2V7X0FjqQz1KSKAyhHOxuuJnz/lxCZ0ESAkYO+Mt17mo/mj34eBFBw7TWJZFQ74S5iIc7ESh6FbwLPkTFpgb8Nthdo16m5YUDlUBKZQPqGncdxQr8l6yjv8cXakJnTSsKpG13n7Z7Ah/J6OHKpfjCe3ONqd0h0hTRwMhFANoBvgse7LyjmKIc3U4aK42BKUMsO5Opv66SV7+cyHV67dr2Ad4+L9bwQviXJyD92jN32AGKwc7Dt0ANkejv7F4OjXyJLVNHee+L4XCZZoEPyp47c6dMV50iilmsa5cEBSwN6FihSqLYMES0RKSETcx1Ak1JIPUERe62hxqcEBND2aORmAS6rG+4CrQPunhFITnEu+8b0cWgxVk2x3r0Jy30ufu7PfBdhYkiJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6780.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(86362001)(33716001)(82960400001)(38100700002)(5660300002)(83380400001)(54906003)(8936002)(2906002)(44832011)(8676002)(4326008)(66476007)(6916009)(66556008)(66946007)(316002)(41300700001)(478600001)(186003)(6512007)(9686003)(26005)(6486002)(107886003)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YX7i2G3lRoeCnL0VyupyrPAXKd3np8ZhzBWLDRFrhNFC9DTT/PRgKnstXEdJ?=
 =?us-ascii?Q?NHV2B0Xrc8GRGEd/RDrd7bdMFz/SjvJ0eIeXGp6GRTr1vJa4eGkUFjAMHKHE?=
 =?us-ascii?Q?OctLp/jZ8snITBjjlUpObgKECwBtAgHFyqrP6TRA2NAcoWZkXD01JOr8LH7h?=
 =?us-ascii?Q?8fJVv6bXdK45k9/i1R4ganuAxcOts3FzHbTy0cJvW4L+2dVRzQQdy23+KObS?=
 =?us-ascii?Q?avlxauGfCvUctsmmqqTE1PMPoJyWyhWeDRUXmU9K5frkvlRogKnuBqHnI8UU?=
 =?us-ascii?Q?Aeq/Wpwl/MCDg5xEAX4t6x9o1VBNNlaRUNh54Z+3hHer+KGRo1oLDtHGroVD?=
 =?us-ascii?Q?dKrlPu+5fUwRjKOqeCy3lXTIqvHt/h/ew0DtMZQ6BB7J0+Z5wSZ1KfYYmndY?=
 =?us-ascii?Q?TB8ozWgiqA6EfuSQOtbQwzWQLAlxvjvsO1kuy8SHM5USsupIhvAvYQgY9z/F?=
 =?us-ascii?Q?Pze0gzuPbJM44unp7KzxK3b6XiRKrG/CkHHai8iXxJhhSOpgu88elROY6AZe?=
 =?us-ascii?Q?h6mF189d+d3z8qzned0n8xO+CSwLPIZcfwsox6IRzmLOolyGPwPw6I+OJ2ad?=
 =?us-ascii?Q?/2a2eK/GS7Gm/B8gLCFVpQj4My6bJ2z9AzmHcRohrGowzb0FCCcDtlqWkgxj?=
 =?us-ascii?Q?I63Sf/uDfsemL2iM9k5FAsYTJzFIK5e1lnmA+Gh6NT+6X3qzyHJEuJM8dB8x?=
 =?us-ascii?Q?Mi9+s7GA4dB5MKekGCgZsLOULxOr2Sbw16d7ASP9FOw1498SOfEcBlYfSorx?=
 =?us-ascii?Q?L6vOZRPArvVKPZvPN0RNPuXNRMXYg4AWlQ7vhA0RgdsQn1/ZQbg4+lVA9fdC?=
 =?us-ascii?Q?6sids+A31OSFZVj3F88BpbyFoJt1eFWAMsrwD0IPPOnzp6vNW0kCkDRMsgsM?=
 =?us-ascii?Q?Xc0haO0mwI0+MVSKDixs2WnJU4Nu8U8VTq+NkfX0C2nRAQ0Nn0+VhC68lYzq?=
 =?us-ascii?Q?GAlXAVq/YvGYh8oQJHX08NgqQaWkLe8KHs1tfJlFtlAwxYfj/+pRJyKrmxBZ?=
 =?us-ascii?Q?FDp39rlNCJ1is/nTN1HySdT505XT7cS2jXdLYWN39dAi64KCf5I5zIIovtDt?=
 =?us-ascii?Q?S6Iicm58bj2cttS4koAP885twc+YJ6gF5b7GHRfdoN5z+K2w8ihixxxHfNa8?=
 =?us-ascii?Q?r+kKebxvIj9bLt5BYV3m4+gPyOFnQttTgA6nB0Sf61GHC8y9/mZmf8BX9t5R?=
 =?us-ascii?Q?PVkL6hr2HHcmQuTSi2fC6IQMeDj22P1O7SvOUfEQ6xtkOeypFZUV9cRGPtln?=
 =?us-ascii?Q?zMusT4ppqn6jv5Pqd3BwBDwWa2AoKOoedMec3dwVCdvkDLBYi5aWTQTTf8nk?=
 =?us-ascii?Q?o/t8mZSiuJlTkrqA+gazRjAkVBwpH7Zan862VKcFljnTtQLt/yF4sYjWvsQ+?=
 =?us-ascii?Q?/ON6QL0F55vek3Ae9vriYwJKAjLgHsUK93p/EU83dVq2G5OdjdYNklmmdg/r?=
 =?us-ascii?Q?aR+AYnYhiZzNSJRuCQJHbxfiUFZKjJObtariQy5Rq9Mz0yyDZauIrQZq/Yiu?=
 =?us-ascii?Q?AtTzEWGyzIIYx/zrb4akQYSFybLbvI9h3Fa7djTIidGFO7QBrLTNMrqEttzX?=
 =?us-ascii?Q?VSIXnbDOnvIl353O3iHCB9rPySwFp+Jq9U68jLor?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddb096b-acd4-40ba-d40b-08db1255bbf0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6780.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2023 08:46:03.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKsvq+l90iSAj8f2BKmhzkVgOCcLvwHOqjytWo6cjScixrGXhwR1o3JhrlqxgI5988e64PCTIX5Zj0/Uio+HEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5406
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 14, 2023 at 06:46:01PM +0000, Mingwei Zhang wrote:
>After the execution of __tilerelease(), AMX component will be in INIT
>state. Therefore, execution of XSAVEC saving the AMX state into memory will
>cause the xstate_bv[18] cleared in xheader. However, the xcomp_bv[18] will
>remain set. Fix the error in comment. Also, update xsavec() to XSAVEC
>because xcomp_bv[18] is set due to the instruction, not the function.
>Finally, use XTILEDATA instead 'bit 18' in comments.
>
>Cc: Jim Mattson <jmattson@google.com>
>Cc: Venkatesh Srinivas <venkateshs@google.com>
>Cc: Aaron Lewis <aaronlewis@google.com>
>Signed-off-by: Mingwei Zhang <mizhang@google.com>
>---
> tools/testing/selftests/kvm/x86_64/amx_test.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
>index d506821a5a26..aac727ff7cf8 100644
>--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
>+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
>@@ -190,7 +190,10 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
> 	GUEST_SYNC(4);
> 	__tilerelease();
> 	GUEST_SYNC(5);
>-	/* bit 18 not in the XCOMP_BV after xsavec() */
>+	/*
>+	 * After XSAVEC, XTILEDATA is cleared in the xstate_bv but is set in
>+	 * the xcomp_bv.
>+	 */
> 	xstate->header.xstate_bv = XFEATURE_MASK_XTILEDATA;
> 	__xsavec(xstate, XFEATURE_MASK_XTILEDATA);
> 	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILEDATA));

maybe it would be better to add another GUEST_ASSERT() to enforce that
XTILEDATA is set in the xcomp_bv.

>-- 
>2.39.1.581.gbfd45094c4-goog
>
