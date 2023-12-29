Return-Path: <linux-kselftest+bounces-2520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB9581FFB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 14:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D06283738
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D3711710;
	Fri, 29 Dec 2023 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwGW1aME"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4711701;
	Fri, 29 Dec 2023 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703857113; x=1735393113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wN3auRKgAU3TGFV95O7B8paB2H7lbfi6LYbGTiP1lmw=;
  b=HwGW1aMEj7v5zp8FIPc22zpHGY32tK2y+cfCAD2yTGVMd3miRJpyX98E
   VQ/HUzc9jDV6+NPWagL+KmPYLLL2/Dg4Zs61jkQjbUmlcHuEfcsqL7RXW
   JSl4SLCzcUbggtqSw7RLhWmOd2ymyDENPYqyE7v+sXFAZUINlLZgnE6WZ
   Y0C4wvo2NA5sW+6hzS3jtGBJoV+dq4JoUSEk3XQUXHtW2QgvyXsdIbxbx
   Vg7V6DjaPqh+iLEfvfo4GhFw5f6MaFxz14/QogS9vVfsl2pn9MYgNCizb
   x9NI4RH4eNzyfVkGCutfuUHCQFBG0Cr8DkIJQK+nxv5unrpwTOU7hoHCj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="3949827"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="3949827"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 05:38:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="778813779"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="778813779"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 05:38:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 05:38:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 05:38:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 05:38:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STMNZpS+NDn4uuLsT2WqZv9MHeIgDIWi2pUDaawUg6zjiWU9kg1zX+iWwCKjW0LfbqLnm8YzziOKNA+vMZ7f8MJJVEt/TkXqKe/jhHTVUTsctsdxiEcqon111Xi9xbvyy252k5XhaTUvNwAdUBxSrO6EgTvcpuo7e8E2KXWYXhKKtVIJudwjpVa6bUVkaN99LExIUWKCqfh1zrbFMS0hAV/1cnav7OL3VBlv/d8R0sGSaguMFUiBpPEoQBfKjq1IFp7C24pBOMXpRUicPMmA/Kqz2q1+Yn47E8vdq782x3V7FuwS9zszOxRdGN9CLEI4FHYF6QPKU804jwPyn31+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV+lZFTibSkf7Q/par/7fLqzlec2rCZ8Yim35tS+5H8=;
 b=duR2gf5F8gJ6LYNNPSaYPwkuD4nsabjuHhsuWi5TrA8jcxoAxQMtcaHlVpI5YncN3YlizgXTmClUMtx37cGKeeL1tvDOfmSpFN4WOlcE87Z8W704f/WX6sOzAOFChOtipw/OqgISztScaC1X6XxScb4P2GHx/htTRG1IftveSs1owstrNpGmxgYU7XWPTDKN8uSJGGccp0IjdvJtGex5Pv6E8arWtI0r3cz8EVc1l6L99j/54r/gWNJ4ghzAAKW1giLIus5gD/gJc5XUlffF7ByFjUkokD22+g+uyVVewHL8IicUvN2CYhdYmC3TFW13/GZvAiVKbbWyhiFNsisvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 13:38:25 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%4]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 13:38:24 +0000
Date: Fri, 29 Dec 2023 21:34:00 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lkp@intel.com>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [PATCH net-next] selftests/net: change the shebang of
 unicast_extensions.sh to bash
Message-ID: <ZY7KyPhGeMJ4iSO9@yujie-X299>
References: <20231225072109.3835503-1-yujie.liu@intel.com>
 <ZYl37fnxGGop7VCs@Laptop-X1>
 <ZYqSJk9rMxGxLx8s@yujie-X299>
 <ZYrMX5GTjxCzGeK-@Laptop-X1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZYrMX5GTjxCzGeK-@Laptop-X1>
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CH0PR11MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa71465-5daa-4ddf-1c7b-08dc08736e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZFK8o0APE833h5URHZXY8R3GDUi5/fgA552Yi5TpT7tUyUEpgj4RL1ILI/LAA3f7Ql1qxUNd2v93YYOwHnuXb+rBsWscweCzVRJtpFmz+3K8Uw0MARNm/nVbjL6lbpc9ftYX3dIdZbezKzFmyk8dEV0m0DrF7KZ7uEL2Z9SjNvkMVM/ycDu8NDkayc97En/a5vcwQF6FbXqEzOMDyQfVDt0sW+TvKrHKWHJQcBmy+KCeaJGL3Rzii6Z0eN+46j8kobaLCmeVU276IV1Ma4UEpCcYZtvGSAjFD/dO95l8uRnkSarANA54XfabaXQMvdt6fRgAS6qpyW0n9b9WtfJFyIr+Au2t+aNEPDVSx+5jr5SMJM8Shdl5MWLr+wXSGNSWAM3zAWYkm29+0LxsylNTEDyALjLAW+JSo0JPU3ZArBWfC1simnta0YjQ1Q23qqCYHlMLwbPn2zmzv0dpKLaYX5p7NDnMnhPkaOgQ4m2PNE0JJ83NhTV/YkVmCSO78nbr1j9qC2iQf3hQMOIadPNlmPVEqSujua6HmZVTO2NPOEqrbDVx3hCJIsyMp6IM+7zPXTX/rvjuRkVIzek2co2uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66476007)(6486002)(66556008)(6916009)(66946007)(44832011)(4326008)(316002)(8936002)(107886003)(54906003)(26005)(83380400001)(478600001)(966005)(6512007)(9686003)(6506007)(6666004)(8676002)(2906002)(33716001)(5660300002)(41300700001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZiQiliBVfMcCZ7uMhWWMqlppLdLOH3MaF9CDzTprkSkzP1EyOkULpQ4VW2ee?=
 =?us-ascii?Q?9pFUcWO8yR1Nrjl8qDtK/VOqbr9ydJmJdfFOt0bOvMiu1zYAL3eYTaQAlYrh?=
 =?us-ascii?Q?l4XVaBgUpSL4kafENzoWMoc87+B45PJWRpZ51PoehQeyQ6qJEDMatr+aIyB7?=
 =?us-ascii?Q?v7YRC2ahe6GfEroi4eoSBC9lor7ifQCOiUO9O9lQl4i1/mZk1DwzYJFi7GLc?=
 =?us-ascii?Q?PR+45bHFC6Qa/epw4oUmg8FcHnVOD2bUWEM6v5OwHyPGJujdswlgO7MiAu43?=
 =?us-ascii?Q?Fs9E9UCxiQz/JYwe6eS5V1vEt0GOiiFcSpbExfmNvdxMuNnwQ8c1ZG0eul01?=
 =?us-ascii?Q?yN/TBByXFjGw28fZiAF9SkBGQvfLtCZhhj2vgiuV385OXSFVjDMsb7rWx40S?=
 =?us-ascii?Q?XnaXpoQmfumAdixjsYp7F6v2m22GqEKVZJ897Hs7P8nHjzoBdf5Xbu1dQtn3?=
 =?us-ascii?Q?ov4j7uvMt2PBvxmF7zgBMFxkoGRMlmjqb0QxXiWd7WeKpO4kRT9huT0kLkkC?=
 =?us-ascii?Q?6rMbDjE7w73mZ66GqQhhT3hQeq9FpTK4ZqbGnmtlMvUOTfvXgDyglrpLql/B?=
 =?us-ascii?Q?N0DQ9knPqjOXMIZREf0qvEta5MefYWrSoTIdj0OrK4Sv/XR0/2+vi9lkCH6Y?=
 =?us-ascii?Q?r4fGzDXg6217wSoEae+FVrjJDfcOw6JWVE8vZkKhmazFgDqwif6vDa+7HyMS?=
 =?us-ascii?Q?HqHBgEOWIbkdS7GLEtRBu2PIeLoy8N/4+reCZvt1b365qvEefpYUBvIVVmBD?=
 =?us-ascii?Q?rYyz6W9Fyg/ry4b6b5dSGfeqplSl1T5Rua23poGT34L2YP4yeoVVZYXoaFX1?=
 =?us-ascii?Q?RT1g+hTcLNocReW64ZQbZHR49TjUcAr+UVER8rfh/O5+RNaM10tvR8o6pvQ8?=
 =?us-ascii?Q?+xCroQ0CAl6bcZhcu6itdqzIPCbWHnr4HA8rADbrx+A1l3HYn8E84Bfo35EG?=
 =?us-ascii?Q?0Hh8hAcApb9zqB3984x/dLjkyhRmj0evO2cWcJK0IkeQxYzcwuiUFPiaMFLk?=
 =?us-ascii?Q?2c+FCOTLs37ioRPI9+Y8YlWe7BNMwXqd/xvISnVdmMn8MxdTISk7a6+cELXV?=
 =?us-ascii?Q?i/iXtluR7RAQmqTnXPMXDlJKa3lxRM1GHw0TTLFdE1T+Fn7z9GxcXmWj+GWw?=
 =?us-ascii?Q?y94iiU4Zj1s+hB3zVATl+qTMulEdusZWEd+zxlNuardMPlEhh+FVfpqm0FFe?=
 =?us-ascii?Q?Bbw6EjHBE960voHvjozN5tF6q/qy5pPgos7HSBHB0JwiR9doHmcQRURDo/cD?=
 =?us-ascii?Q?UvuKbhJ07h5uLcWIMgru5G4kR8aKd7cyrSsg3H7AZD0VKGxETfynVM3glJYr?=
 =?us-ascii?Q?EgcNZlQnUMN1oWw0zYuEzNb4rP6prLs1A2tcEZWfiyNvJhoTe5CZ3bL3lZ1s?=
 =?us-ascii?Q?U0WHQeCYX7TXXUJu19a399NGqjJEPHfZEVHqfzYxQt1WnbUaEmZFEV7W3/uH?=
 =?us-ascii?Q?YOoARyrG2MdCOO3cq8ojBDP5YZCsHf+aCIoB9wcdWr3jtBiCJB3eB1rkZSVr?=
 =?us-ascii?Q?/p0TnOycomO9tSGrRHAhLRVZ9bBJCAra9seEtpjwedUpalgV1t+X4JQNrI0U?=
 =?us-ascii?Q?uS84b3qdiyBn5rKQ6yDYbYzWFwzI5l6oUO0T5e9E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa71465-5daa-4ddf-1c7b-08dc08736e38
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 13:38:24.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS7s2JBnYvFO8bDDtYzyzY2s5/NfLTYHgJdyuLmtFLEv8SFtEi5SClIiUMVKt2ByBK7seQhG+yVkyfu93oQO0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5348
X-OriginatorOrg: intel.com

On Tue, Dec 26, 2023 at 08:51:43PM +0800, Hangbin Liu wrote:
> On Tue, Dec 26, 2023 at 04:43:18PM +0800, Yujie Liu wrote:
> > Hi Hangbin,
> > 
> > On Mon, Dec 25, 2023 at 08:39:09PM +0800, Hangbin Liu wrote:
> > > On Mon, Dec 25, 2023 at 03:21:09PM +0800, Yujie Liu wrote:
> > > > The patch set [1] added a general lib.sh in net selftests, and converted
> > > > several test scripts to source the lib.sh.
> > > 
> > > Oh, I didn't know dash doesn't support "source". Thanks for the fix.
> > > Would you please also help fix the pmtu.sh, which has the same issue?
> > 
> > It looks like pmtu.sh was not converted in patch set [1], so it doesn't
> > have "source lib.sh" yet. The cover letter of [1] mentions that the
> > whole process of conversion will be split into several parts. Not sure
> > if pmtu.sh will be converted in the subsequent parts soon? If so, would
> > you like to change the shebang of pmtu.sh when converting it later, or
> > change it together in this patch? Thanks.
> 
> The pmtu.sh update is in this patch set.
> https://lore.kernel.org/all/20231219094856.1740079-1-liuhangbin@gmail.com/
> 
> It would be good to fix these 2 tests together.

Sorry for the late reply due to recent holiday. v2 patch has been sent at: 
https://lore.kernel.org/all/20231229131931.3961150-1-yujie.liu@intel.com/
Please kindly review.

Thanks,
Yujie

> > 
> > BTW, in addition to pmtu.sh, I noticed that there are several other
> > scripts in net selftests which have "/bin/sh" shebang:
> 
> Yes, but the other tests don't use "source".
> 
> > 
> > linux/tools/testing/selftests/net$ grep -rF '#!/bin/sh'
> > openvswitch/openvswitch.sh:#!/bin/sh
> > in_netns.sh:#!/bin/sh
> > netdevice.sh:#!/bin/sh
> > test_bpf.sh:#!/bin/sh
> > test_blackhole_dev.sh:#!/bin/sh
> > vlan_hw_filter.sh:#!/bin/sh
> > run_netsocktests:#!/bin/sh
> > pmtu.sh:#!/bin/sh
> > bareudp.sh:#!/bin/sh
> > l2_tos_ttl_inherit.sh:#!/bin/sh
> > veth.sh:#!/bin/sh
> > ipv6_flowlabel.sh:#!/bin/sh
> > unicast_extensions.sh:#!/bin/sh
> > reuseport_addr_any.sh:#!/bin/sh
> > run_afpackettests:#!/bin/sh
> > ip_local_port_range.sh:#!/bin/sh
> > amt.sh:#!/bin/sh
> > udpgso.sh:#!/bin/sh
> > ip_defrag.sh:#!/bin/sh
> > rps_default_mask.sh:#!/bin/sh
> > 
> > > BTW, you can change the "source ./lib.sh" to "source lib.sh" to consistent
> > > with other tests.
> > 
> > Sure, will respin a v2 with this change added.
> 
> Thanks
> Hangbin

