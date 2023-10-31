Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006577DC7C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 08:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJaH7Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 03:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJaH7Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 03:59:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497ECB7;
        Tue, 31 Oct 2023 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698739153; x=1730275153;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VnSkK0SsR7Xl1jbN8kcs9lZZgzg98EevkVNEC0VSnbk=;
  b=EwStmB4KZgbfw1RgFEfioLJDrYPPcahLSVKTXDm5fEhoCaYk4X/rPU/k
   spabnmWOOg+RsKXOHHnXXWFwkJjP/3W12LRFRbQL6WFkgy5/wK/9BMkla
   w08kD0ozQapq+Nuvz7MDaDLyW/XhTJoLYAL3sdx4JnVDnIpq5chX3dRCQ
   4TYgWibdzxj73bcZadDT8DqsSlOOOT5n1cpRivpkCGqdScgESbPVLXv9H
   +p6KjQ+Oc+nrjC/5V0AE7Jbk/J40/VCiFe/62/eEmbvd+G8eTjIO3Uoco
   AZNTfBVAIMy6Y5eh2bWiGBVxGdr2Ifcjsilh/6UEkiLy7D0xAb5Mt5x1B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1081675"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1081675"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 00:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760546636"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="760546636"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 00:59:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 00:59:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 00:59:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 00:58:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAGu3h1oujqPWJDaOvhn1qNCzEVw3UnK9Gvwd+NOuXQGixZHkNzk0Op5qEtoNLUaR/IfQjqU00JaeohdYtZ8jtgnKzpy5CAISgThxEm7P1OpTROxJKobFzng4ntYW6oDcXo3WukSLecIIf8Mx9FWpdq/k0gHwshPqF1ctk9EatedZQ2unZ3nCih2bcQwNO8c76q5DopdpdMCnf3SnD/L8RvlJrx6FfZ+URhyIvHETU93akxwbDzo9jmNF+YUNsZp1ODXJ8etlP4xEm9nyz7p5RGW+FgBVKGE6GbXIQY+UWPxV5b7awpeSGVH1TBvh8gRpM3wn7r+2Pr34PxxMozBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFYLdrbf20XpG/uxBPd35KBPT1Am9MKfQRu/tU89Xo8=;
 b=fdNOPwUn3Uw72OUNkDkNuyJc5NUxdJt7teF9XHzgd8PVW/NnVez5WJ804yTEiEsnU8ep+GuJmylonq9PjSR1vf2otfLEsFuH/XdIwR9KyFi41/yuDIvHlvybwe/Unz7K3Fqm+aMMIe16QdD8RdD+d6YUIj3+a78arUt5+x4ese489A67fAA3OfoFerEW2D8RW2Jcsx5QcnXqr3JItVO9C3MJlxuNlgQuxRNKBOFeDjYxI9tXpxh7jqmz7wGCmLlUxd0Bn2mI7KjuyoG6tr2OLp9WX1+9NyBrDP5SO88cxkpiTMsoUmKLXY+hfuI/JU9pBThj9f0phOOH7vetVwAKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Tue, 31 Oct
 2023 07:58:53 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6954.019; Tue, 31 Oct 2023
 07:58:53 +0000
Date:   Tue, 31 Oct 2023 08:58:46 +0100
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 21/24] selftests/resctrl: Get resource id from cache id
Message-ID: <ok6hd2zpswhmxq7vsychb7cqmtqkgadfqq6cz4uxtyourrktxb@tkapqzdmqn42>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-22-ilpo.jarvinen@linux.intel.com>
 <cb2ctfignowlom7lb2t5zhdgtm4s2jlzlvtumlnvxecwwtjk34@ysgepmgkv6bb>
 <ab4c6aa5-ea49-363a-ff7b-2215665f185d@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab4c6aa5-ea49-363a-ff7b-2215665f185d@linux.intel.com>
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To DM4PR11MB6239.namprd11.prod.outlook.com
 (2603:10b6:8:a7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MW4PR11MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e02aaa-0814-4300-f24c-08dbd9e738da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtf7Ce2sF4LHzjZFVDVReCHd6023lqqwzeMfGRqVw6sWVo1nOAC2PsX7fXgnN1A6JV5uJFcoyE+8bZgRWlHid+OjLPAsFvm7wbrkxmE2zPJuXbbATiOKpDEuoTdRXGNVLo5Sff7Ciy5Xy54IemnPab2apUTdw2Bd3Ei8wZG+p9YSMLQGfewvm5nAB8XIEyVcu77AAn1wJOYYkhcr4lzvW2xxt6ydWCMf3GwZc85pwONUbvTIu376z5C6GBwGj06wfazJ/Fn+Y5RaWDy4Qgqde6zXGrGCB9t9Q4241r3dM2AayM4KRgXIVVwuTQejdkQNfEorpanSf4Ki8RRzVml6szhFsEcEzRhPfLCCJNDHsmiIXb1pt542jo0KjOeF26sS4oWLY4bia8RfI6E9eXfVBBXv2KVi5J6SJoSb45aASOBZMPKRSjlN0aTUY75dr9sCdnPDeaaahQs66sCPDNbeTq8y+rYohae7KNdwkCob6aY095j3nVnc6mJJa2Tmvar7TWS1Z4VfMJeDRTwqr8AZryTCcCyuc4E1DTHyZQGacCmWWkknSjJR4ahth9ok7eb3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(6666004)(6486002)(4001150100001)(33716001)(54906003)(38100700002)(316002)(66476007)(66556008)(9686003)(6916009)(53546011)(6506007)(478600001)(26005)(66946007)(83380400001)(41300700001)(66574015)(82960400001)(5660300002)(8936002)(86362001)(8676002)(4326008)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xVms6JtswUMcrXjPzlngVmARkR+CSEukcrXV+AdEWaX7wMHBa1vm8o6yLY?=
 =?iso-8859-1?Q?OI+vtaVCMqq5HKLUnqVhrITnzU5IL/KWlJuDj5F76+90PzG0OIvsFOn/Sa?=
 =?iso-8859-1?Q?4AyR8j/KiMxYK4Jv5hvGBlWfdq5KStQsP/6XawuVEPlLR5pw8qiQbLgHqi?=
 =?iso-8859-1?Q?vJejQLChqvEr8ZGq51T/dh8iywJUIlEjVKnLfot2zrC91PtIyAJBrVRYwt?=
 =?iso-8859-1?Q?G1wdxeyDHI0nEqi70f1E11xtXKZr4Iy3LYBLMQVxCD1C8o+ZaIBh7sw8sc?=
 =?iso-8859-1?Q?SfYKx+6P46rVpNIYh12npp0nGIvOF1qr4qlmKSENNOJxZg4taMrItU3S6R?=
 =?iso-8859-1?Q?eMQXBHT+66UE12QRA795eV1Ynfhxme4g76sqykrWOHdLUBhnyZ7+dDEaTl?=
 =?iso-8859-1?Q?BqfkJOvt4PnMBiucjWaTDb5k1bmGbiTcc2bPNEtyQ3fblS9rHiG9iJ6J5Q?=
 =?iso-8859-1?Q?KaQu9aRz3zNPiGQvYu5yBGj4d2wpgK1l5hsDYMpcBLghs+oOMf5xYXPg30?=
 =?iso-8859-1?Q?7Xuw/CY+Anc/9kbQw/hBIYvq5uAf1cWFiWZ/96kOJYv3a5I+CCPMJ1Goho?=
 =?iso-8859-1?Q?3XJ6WbmM7IUQI8X3c1TrIClVuH5MepRGGVyDNKirrdOkWTpigp7k2fAH3+?=
 =?iso-8859-1?Q?CJRamq+kPh2zTAF1QBQNJmiXrMZew2ri9EXXsoYNVS6O8fzcKCrBFUgRtQ?=
 =?iso-8859-1?Q?JKLSRWs18jw9D7F/6iWwCT7CI+x3TtcQbbhXRp1wJ4ezy961avlHo9BhKF?=
 =?iso-8859-1?Q?4TzXjtDEVLg9bI4qkNXYLxrniraqEEy1A5VaJ1PuC1pD1LWnnu1cPXIBXu?=
 =?iso-8859-1?Q?nj62W03aIuK4lmDyQygTD/hgDuj7nLtQTC1oWRFGSr2kYN1wOjRF1DG/92?=
 =?iso-8859-1?Q?xeyoIKvUuVO+px17EyqSONkZiR8m5lnNNxOM7lTwtKPsz33nBK1RhlCVBy?=
 =?iso-8859-1?Q?5k90d/1+ZzqQiMYmlR7vKAODeIad1xZ4tkNMEdTO268QN+vIllv70K8B7D?=
 =?iso-8859-1?Q?2+WFBYJZNHRK6gC+HbY1mnlltOmNJMWgEmjMF/vNkQNm5/tP5ipuV/VQ4X?=
 =?iso-8859-1?Q?0SnpX5sDPb+GGPjodWK17B9lm34jWxBMztzlZhjBkUO/Db0OGy1/esroKB?=
 =?iso-8859-1?Q?0MrayOJLrgQVjLyhY49vq+/XxVYc9d9rkEmra6ah88ZTYJSiErw+3WzWNt?=
 =?iso-8859-1?Q?7mtjUop3oc+QmPoH3ex+rjTtrd/geeZw87cDuh6ou4OB6j+/TVNSIdwgl0?=
 =?iso-8859-1?Q?qCcK1ggj4PQta6eQj8T8f5YyuEGk0n/ZOUKiSiuf8Xo6nXYD+RtFKk89Eo?=
 =?iso-8859-1?Q?8qfopDsxRq2d80dzAjE3/hUZ79APbhW4TD9LgSvIt7MKOLtpGLkNheRDkx?=
 =?iso-8859-1?Q?tALvZ4uI+kegRtQjVLHPB3V3FkMfEb47qS5K2NcYjn6bLwHjqIdpYLDqF9?=
 =?iso-8859-1?Q?ddDTgMxWbwpLdQXYf+ryko4RnhydIGVbS5YiMaCXDPdfiaS84gj+xasH3O?=
 =?iso-8859-1?Q?UWEmjXplwaSw2CtlQ459JtwQaql8Jeh+Jw+dB5RExjZxqMFnedggoaxnzq?=
 =?iso-8859-1?Q?0/zjlEBJZiYQRLiln0E0KguJD9/qodJ59j4uKoSDgtzlirpoKPUvefrQXv?=
 =?iso-8859-1?Q?2iqbQsncqoOeUtNXM/1cUi8zbbZflaitcLqrLhjgyKJDus7nZo47s1D12h?=
 =?iso-8859-1?Q?39pW0K0Bnmg9w+DZd5U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e02aaa-0814-4300-f24c-08dbd9e738da
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:58:52.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oRCdoFg1JxQoDJXbO3knlsknLs1MjDPjnPwWHJKUcykcjZwQ8FTGXBqIqqIk6HZ+mzlBp9F6KzGsHxI/JyCH4sq3hFZylu2tpE/gLVTDRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-27 at 16:30:38 +0300, Ilpo Järvinen wrote:
>On Fri, 27 Oct 2023, Maciej Wieczór-Retman wrote:
>
>> On 2023-10-24 at 12:26:31 +0300, Ilpo Järvinen wrote:
>> >Resource id is acquired differently depending on CPU. AMD tests use id
>> >from L3 cache, whereas CPUs from other vendors base the id on topology
>> >package id. In order to support L2 CAT test, this has to be
>> >generalized.
>> >
>> >The driver side code seems to get the resource ids from cache ids so
>> >the approach used by the AMD branch seems to match the kernel-side
>> >code. It will also work with L2 resource IDs as long as the cache level
>> >is generalized.
>> >
>> >Using the topology id was always fragile due to mismatch with the
>> >kernel-side way to acquire the resource id. It got incorrect resource
>> >id, e.g., when Cluster-on-Die (CoD) is enabled for CPU (but CoD is not
>> >well suited for resctrl in the first place so it has not been a big
>> >issues if test don't work correctly with it).
>> 
>> "not been a big issues" -> "not been a big issue"?
>> 
>> "if test don't work correctly" -> "if test doesn't work correctly" / "if tests
>> don't work correctly"?
>> 
>> >
>> >Taking all the above into account, generalize the resource id
>> >calculation by taking it from the cache id and do not hard-code the
>> >cache level.
>> 
>> In x86/resctrl files group of CPUs sharing a resctrl resource is called a
>> domain. Because of that I think "resource id" terms should be substituted with
>> "domain id" to match core resctrl code.
>
>Okay, I was just using the terminology which pre-existed in the selftest 
>code.
>
>I've really tried to look how I should call it but things were quite 
>inconsistent. The selftest uses resource id and reads it from cache id.
>Documentation uses "instances of that resource" or "cache id" or "domain 
>x".
>
>
>Documentation/arch/x86/resctrl.rst is very misleading btw and should be 
>IMHO updated:
>
>Memory bandwidth Allocation (default mode)
>------------------------------------------
>
>Memory b/w domain is L3 cache.
>::
>
>        MB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
>
>It claims "domain" is L3 cache (and the value we're talking about is 
>called "cache_id" here which is what you just called "domain id"). I 
>suppose it should say "b/w resource is L3 cache"?
>

I believe so. After some looking around it looks like the "L3 domain" naming is
also present in rdtgroup.c:mkdir_mondata_all() and "mon_data" description in the
docs:

Docs:
	"mon_data":
		This contains a set of files organized by L3 domain and by
		RDT event. E.g. on a system with two L3 domains there will

rdtgroup.c:
	/*
	 * This creates a directory mon_data which contains the monitored data.
	 *
	 * mon_data has one directory for each domain which are named
	 * in the format mon_<domain_name>_<domain_id>. For ex: A mon_data
	 * with L3 domain looks as below:
	 * ./mon_data:
	 * mon_L3_00
	 * mon_L3_01
	 * mon_L3_02
	 * ...
	 *
	 * Each domain directory has one file per event:
	 * ./mon_L3_00/:
	 * llc_occupancy
	 *
	 */
	static int mkdir_mondata_all(struct kernfs_node *parent_kn,
				     struct rdtgroup *prgrp,
				     struct kernfs_node **dest_kn)

From the reading I've done on resctrl my understanding was that L2/L3 are
resources that can be shared between domains.

-- 
Kind regards
Maciej Wieczór-Retman
