Return-Path: <linux-kselftest+bounces-2437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B081E606
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 09:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5EE282ED9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A364CDEA;
	Tue, 26 Dec 2023 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maU5iwV6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA174CB3C;
	Tue, 26 Dec 2023 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703580470; x=1735116470;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Aa/XrjwmKLVpr8yWysNjtY5HGXltcGL04/6/jtAfnBo=;
  b=maU5iwV6chf+ul5TMaHoeY3J6FPjaTwDiVAfGxrENGEcoOa/Z0ayd/Gy
   dmp3xst4pFgUY6fIk16ei9VXSTTVxe18hYpDzaKpHht2SgWsMTxmDyYRH
   EWXIcFzYpUJ/nJX+U/OlYDLEy7gV6zIiaP0S2Vpwaa/cte8eeMxBZVqc9
   Iynw8GGmG9hNiEVzj9cP7srrDWnWJeKom9qEEVlrlNIdKc2qoSFA6IQro
   /QdjDHH3GkbWof/8/696LQXGRC32H/ccHCAL1Ov5+x7ivoY1/Zng8xM1z
   GCbYelgnG6S4wcHwgo9gvYffsudneVqtVBMeE54eRC/mqmw4eCgItiDwQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="427502104"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="427502104"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 00:47:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="771124951"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="771124951"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2023 00:47:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 00:47:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 00:47:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 00:47:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDI6W3W/IvBKT9eGxHSCeukSmC/d71FEAD567pl4UIHPuVTt84Ngv5Gc0KdijwYlnsDwdKej0ihm5GIiDXZ8/yR9mgHsdT4fkwuJXNb2D23PJmnUwrKp4crOSsXuE12GzPtP7S/TMAOmJ8WAnP9jCb6f0jA2UNzhP06y1j+1lPZYgfje+SfV4T7HkjQ8zl7r1W0o5Rg0iDs0GS2Vdr27KXnwp2fUzy2BxkRVDXt4n7JKlXu63YVv7Rrrl1gtPZXUfQvEhLhp3z/hVj+7W61ORGM+FWTpoXpdiPGMz2iFaao2C0+g+hUtkdsFjQGTSqyBwbbEk4mVObAFxm0vjiMm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QU/9FF4ZZpiDpUQj2d4g6IjmKshrIuz+dm/c7bNAz5Y=;
 b=Od6fgWrni57K9uR8C8E//WuTWzsd6KkHjzTuac0cKi9rP+ypevMP8q3oEZwa4aTbDZ/THlMxBW+5iFgIvF9nF2S4CjRjyHYiraM4Oa5umWvd+dVm22q5yKsWRLveAZsTa/0O+HKk2/QU1423gnE8czju/EmBenhAmcHH0KWvFTcKs1BbQWUUUqBppmIQvd6Li2Weq0/pG5AhEJyEuLa60uF8RyFIIGX0tsmlahUlWFGxMEMIrfdXuN+XiH524WO8VMfqpBB48qVCwBupqs54aMOBIws3oHlAJkH9esb6M4QbvxruiMQQTT8qvBG+o89SA1gpPI5oPqsKjJ7/IcPHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 08:47:45 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 08:47:45 +0000
Date: Tue, 26 Dec 2023 16:43:18 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lkp@intel.com>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [PATCH net-next] selftests/net: change the shebang of
 unicast_extensions.sh to bash
Message-ID: <ZYqSJk9rMxGxLx8s@yujie-X299>
References: <20231225072109.3835503-1-yujie.liu@intel.com>
 <ZYl37fnxGGop7VCs@Laptop-X1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZYl37fnxGGop7VCs@Laptop-X1>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 563f04b4-1c8d-4fcd-ffb2-08dc05ef541d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svr0SursnZV/o3Mir/LgugQHOBv5JNrDLq+co3muNEEGM2Ni6X67mzLPBOmMDWQcIJpXWak81sLsFUPcMTZaEBIXDDdq1oqEYMgOM5oQwMncWtoe9oaEs83BDYX3giM1wHCJ6VtVyhY6Lg4dOVjh7+73Vtw5S/VByDrCfHKeHZYOKYYf3MMtjpbEnfVd2Ji4OhsrX7gvKuv1EIPzfPuHhj3Kdr4guJ5tkot2vCpMSkTo5z9v6i/eXNCv1piHDmEyRdRJLZ5hUksFB0YG8Kpfyd9RbodvBXeQs4g/DA3CmW89TJ1NO/GRpXuLocZypgrG6NLu8q8tMUpi13HMh4GpOLdCgHQczFvQoJnGfcH4R7wyMtAZqfPbBUIzxRO8t/uql/8jDmMh5Tf3UIE+YXfeB1XCz92QdpGjaJDWplEHDHZyRd9Grc+TNrCzLUd/jZ5mB/bLAOyf49NvWmkX3k+ckdTH9eSK1PPPaSYIt8mhNLKG76di9DexGVV/aV5i31FHAP0Y86leeq5vSzZuxJ/1aOtp7IiYtJ0V4LoeeCjl1TQv3BGz3FlmpV73VZhgY0Uy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(5660300002)(82960400001)(38100700002)(33716001)(86362001)(44832011)(4326008)(8936002)(8676002)(41300700001)(316002)(66556008)(66476007)(6916009)(66946007)(54906003)(83380400001)(26005)(107886003)(478600001)(6512007)(6666004)(9686003)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qdvCXcikiky5FW4yzdXflmYfqaJTM9/g8FcD8TfdaoHnz5tWKbfgNvxWLF5?=
 =?us-ascii?Q?FwZtzyRmM3IjH+Nl/wvBpTof7y0M3eAJzOn0IR9i0UQvCGk1EjTxFb8X+jWj?=
 =?us-ascii?Q?1vAdijjXb2qNAKWCS6QTKSOn4LRmwaUQLYl9qNCtvX7aWqXv+aNes8JjR5VE?=
 =?us-ascii?Q?kiKE4zcvgKyUVYxoM3J3hrugYrR+hGNQm7TjY8pxxtNsKMvRfgXJPthl4Yaf?=
 =?us-ascii?Q?1b3ExTVjI4WY7rhCQzLeAQoayZq3PfvYcbRmJW3B4oJUug5TPdsqlMSf0gQV?=
 =?us-ascii?Q?dNbe6qMKg7K1xpjPm3vHYK1674ygzyUXi1TCEJ5JKmV1h0BWrhYHqeMMiI9S?=
 =?us-ascii?Q?w0eIYF9miiJqwbRRE5mP9zLFcbc5vVn8OPO4mxR+6pDICFvRUznAUyJ4TnRv?=
 =?us-ascii?Q?3EDzRKOKT01z8A7XiCdWkCV8QA/jaqnPahllK/Yay7Eup3l8OP2C+UlrpgJ3?=
 =?us-ascii?Q?51yGD+TXvOMfK2c1UKqZqrtt84wSfPXQZgrU3JiLEK/2sosrYRM295F+tT5E?=
 =?us-ascii?Q?1IQiD3pIqrfafCpgeOp3JrQACWJVy16RrBze0WHt41x8kWXind7/2ip8t3Xj?=
 =?us-ascii?Q?TIcUHiXvyXhkiNQbndIAGxteF5m+lMbHMDmcNZUkVjEAXz5CobbW17l4ydaP?=
 =?us-ascii?Q?DOUoS4vPyRbjegtuVxltPPUAoocqkWybhNyPi9aUMiPUOmUBDWXWxjrMn+Nf?=
 =?us-ascii?Q?3GJ+bUC3JE6L22Vu1TEXmVhWFT79kNgN1gRDQOkSQXqd1nUio7O0ANqcOGeS?=
 =?us-ascii?Q?PpKMwL7WqpKtAa4bvRBX/2xGYfHur6Ur7CmNrmT4rV0CZePnysgBbhx56ciW?=
 =?us-ascii?Q?aCM4uSmV3EHpcLRz96x7zPpcjmMQcPal02evKmmmcIGy6qUk/oNtDrB21ROG?=
 =?us-ascii?Q?sQqqU7fx+2MCL5tbNhXYM7+GJAF/PC9w8Qh5O3nzyzjjUUTQjzdGm2FYHDJ0?=
 =?us-ascii?Q?lxaSSWmjJUElJoPCPBspFNWKzwCQxlwizzyGerYhsxHejk2A+ee0Z7EI40HP?=
 =?us-ascii?Q?nDtE8LSrRLLlE2XMTx3VvYonL1G9mrVWOzAqzlLs5ynIPs+MEe9+Zk7K6F9h?=
 =?us-ascii?Q?Lr1gxsE4Ox/Nv3uw3+YalyIaFcnprIFzDdz+BzPuAikxEIG7JN8iXGxAVZFg?=
 =?us-ascii?Q?beh4KcnINRCOe7Tk1Z9UuB+BcDhp5lSFCXj793ImezYdhVwEzX1KiFOzD4I5?=
 =?us-ascii?Q?dYpUQ2r0Jcvj5RJ3h3ZTY6SuHsInYIVEV77QWLxVjqNaTW74D/Wrq1txq4ZN?=
 =?us-ascii?Q?G8aKD6WQO6Uk104JKzqd7wg+YnO7p+/A7LP/FLtG+5Ac4BSTj1XmhCDGewCb?=
 =?us-ascii?Q?r3kj4HGJ7z9g9U/jK117NB0EfHb90lh6JN6IcXvhOa+gQVUI+sDcb02+v9up?=
 =?us-ascii?Q?SWL/KeL0zW5a3pgq0i0DMVUA9Az/kIFsJrwInPwB/F8ghydI1nuUz0bGI9tn?=
 =?us-ascii?Q?3nCGlsEFz2FuueCs9w2orNuKOtHF6AJzJ34kUwC+cHQnLF1spUwmr+Io7ei8?=
 =?us-ascii?Q?tH2VDS1sE6vzKVvW1uCQH/8sAJvnL2wVjxA462XBzvyyc8/Q1ZDmHD/FfV8h?=
 =?us-ascii?Q?J0ydKmSND0H6/4tZtGM7APVlpasqo4NtGwN6jmwm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 563f04b4-1c8d-4fcd-ffb2-08dc05ef541d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 08:47:44.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fatbzr2uIjVNcoTpHYiakwL7NnHHRTZLKKyeP7/FplYVGjRG88+nKF/E+m48F07HUPwO3T3baTcyu9WZsvcHsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com

Hi Hangbin,

On Mon, Dec 25, 2023 at 08:39:09PM +0800, Hangbin Liu wrote:
> On Mon, Dec 25, 2023 at 03:21:09PM +0800, Yujie Liu wrote:
> > The patch set [1] added a general lib.sh in net selftests, and converted
> > several test scripts to source the lib.sh.
> 
> Oh, I didn't know dash doesn't support "source". Thanks for the fix.
> Would you please also help fix the pmtu.sh, which has the same issue?

It looks like pmtu.sh was not converted in patch set [1], so it doesn't
have "source lib.sh" yet. The cover letter of [1] mentions that the
whole process of conversion will be split into several parts. Not sure
if pmtu.sh will be converted in the subsequent parts soon? If so, would
you like to change the shebang of pmtu.sh when converting it later, or
change it together in this patch? Thanks.

BTW, in addition to pmtu.sh, I noticed that there are several other
scripts in net selftests which have "/bin/sh" shebang:

linux/tools/testing/selftests/net$ grep -rF '#!/bin/sh'
openvswitch/openvswitch.sh:#!/bin/sh
in_netns.sh:#!/bin/sh
netdevice.sh:#!/bin/sh
test_bpf.sh:#!/bin/sh
test_blackhole_dev.sh:#!/bin/sh
vlan_hw_filter.sh:#!/bin/sh
run_netsocktests:#!/bin/sh
pmtu.sh:#!/bin/sh
bareudp.sh:#!/bin/sh
l2_tos_ttl_inherit.sh:#!/bin/sh
veth.sh:#!/bin/sh
ipv6_flowlabel.sh:#!/bin/sh
unicast_extensions.sh:#!/bin/sh
reuseport_addr_any.sh:#!/bin/sh
run_afpackettests:#!/bin/sh
ip_local_port_range.sh:#!/bin/sh
amt.sh:#!/bin/sh
udpgso.sh:#!/bin/sh
ip_defrag.sh:#!/bin/sh
rps_default_mask.sh:#!/bin/sh

> BTW, you can change the "source ./lib.sh" to "source lib.sh" to consistent
> with other tests.

Sure, will respin a v2 with this change added.

Thanks,
Yujie

