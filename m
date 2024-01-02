Return-Path: <linux-kselftest+bounces-2554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD16882184B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 09:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9F51C2095D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A9C468E;
	Tue,  2 Jan 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Is64eW6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAAD3C05;
	Tue,  2 Jan 2024 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704183893; x=1735719893;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YwsW0ptpJXN/4ntz4A2tKIqUo7cZS5qmgc7FBnOTG24=;
  b=Is64eW6FiX4j6UzQJ/wu9H2N0g1drTw7X5+tqYBIwTzct5iXuQdNuCia
   M4fmzfrEalWSWLOCuTNfSmlN5E4VPNmq8BrH9l1/vPMyK+XyVuwsO5pPp
   gplH9JDh8efsnVLD4nM8Lwql87suwJQCb+7M7NsPs03/BBqw6V2lVOiqF
   aYNKcxxmuhqApQ+XITFVrzEoaNRvmHvyzbYbrtrjXPWEN8E3DtVhV5XYI
   8lzUXdybIcCT5oiFDdeyz+EzNFBtH28/svxB+FVQFwN/y9yrunwTBHU37
   HoKFZChQowumIhv7IpDgw+FrXTU4eqHAYknX2XgjWSzcrAYQMqMPRvcnh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="396582559"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="396582559"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 00:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="28013280"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 00:24:53 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 00:24:52 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 00:24:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 00:24:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 00:24:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsa2dxcLUki44rmHlHnuq+Od/jZdTYnAKOljnqE0FRlz2w5XUWmiiPrL5MyftcaX8fq0CDKTPVAGTtfEvKKjTAIAq3BXphPHcjlg2L5Kv7FUilGAwcgXR9KZtimVfE83Zvh4xq5fxrHXAa++WWcN7JRUX/v+Hba8hcaI00boBWc7iyv3hCaqFGIyYwpMd1+s1mZa2p8Comr3vV6w/O5ZRnLyq56R6HSC0vXz1GB0CtBrHoLlYgoZRA8pVl17SsjwRmai535RmtZ2U1gKWRR4CI8GlzODM8EoTofaOq1gg8x2QIqQyUerb2UosAOsRkKnk/rUxZ0gzqnnBQlAL3dNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF2k3ay7RA4spQ0lyPGGorqiV2QeQXUgGmlt+ZENSOM=;
 b=E+kukVLcymIm99KtVufwA5/uBMZBiXf122Wn7Uj2EkMoic2rNVEA1HMzr6yEqZKvVQ88WSteFVXt/fp01EEwNBDdz2IxWyrdFQiqzly3zvqldbLbPmwW3vnpsQe0uNk8QW0MOz6LdYmW1DLZCa2vy6LiqfArfG1nKXGqqJJoYK2E3Jb9TQNzOUdJuM4KhSPyvX0jZxvyvo8DkwQvXAIgkNJc99zbdKyqKLlVifCpjqadGnIe+KEHMinJPm0XtYyMRDMPCZOHxFU8kFMLErn0yx6yk0thVl3QUlsE8U82tXflPg+XWITL3QosfH2qiRL3s5IqI+Nti2UBIZXSI0XI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH0PR11MB5580.namprd11.prod.outlook.com (2603:10b6:510:e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:24:39 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:24:38 +0000
Date: Tue, 2 Jan 2024 16:20:16 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Guillaume Nault <gnault@redhat.com>
CC: <netdev@vger.kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lkp@intel.com>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to
 support "source"
Message-ID: <ZZPHQF6wL95oSGzK@yujie-X299>
References: <20231229131931.3961150-1-yujie.liu@intel.com>
 <ZZFbxyQeHgf3UQrN@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZZFbxyQeHgf3UQrN@debian>
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH0PR11MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: 38cf2d3b-a602-4fb3-9639-08dc0b6c42d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qmicTl9Wx3pQiYtU/dnjNceeMaX7YdNVKQgoV/xODsP+CEpLr/mTyhrP4j/HQCQ1Vf7r0xn6A7HygwSSFhWNNpw8eDIuM/SSNF9bPFmfKTPYsp3XZsfsjQZQs21lspp+7cLrOomjWsTFp4pb05SufO0eu7trSFw65hOCUJ0QoxpkzIdGQVSmYHRU3e2llbzlcNz0dFRBmjd3XccnRDmqTe1Y6xwjXziTffGRnhX+edGVh8cFucD9DNyc+n7WYVY+iiTr5e+Pban0IoExArnD6r+oXtTlB1Ar/3LqfI4NVy1Zr5tHuiBNx137k3UWIF7iGfwCbcYlVEUbPg14uCd2pGEu0rrjdDNMYOj1aN9iyqruwwOArxsl8FyN9mUK1w8s1HdLVLo6OzN+S+T0IPR+6ZHf/pjU0JYZpiUIFsYeQhLiSAJYjOsmdy02+XtvpY11zE01tPy+LJmuFLowbEmN+EdPP4LbQkeUFxd73vAnufvfmb+JLMsVKHtQ3w5i4Refd42z8dhVqk1cq2Ca6kcYtwAQzpo+ig0wjhZN7Uw3kIfXTuDCztw0Rh+E4LEafrk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(82960400001)(86362001)(107886003)(26005)(9686003)(6512007)(6506007)(66574015)(6666004)(54906003)(4326008)(6486002)(478600001)(316002)(8936002)(8676002)(83380400001)(6916009)(66556008)(66476007)(66946007)(33716001)(41300700001)(5660300002)(44832011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OT7jquSx/v2wDsiD4ycYhGj2jWvOwcS4XnUDnt5MhVlS/lFnJe8XWEkI42XF?=
 =?us-ascii?Q?/U6D8NVZCdPb7RJNanJZ6fDbQZCZT8qZAJXlr4/HYZxomRxw+ZCsktR1uOOT?=
 =?us-ascii?Q?w0X+9UXEXO17nAQaZVkJe9aQFmXAzAOzRmi30ZtNbIVt8qKtXwTAbLoS38Db?=
 =?us-ascii?Q?DUcnrNRJ84Im5KhpMH0XP39VFLDgJLzDh31fMEjmRQadyuFohxFkcsF1229R?=
 =?us-ascii?Q?Q47p6YjcEXF7OfXg3U45HJDR0qYZVE01DhDna8zCjyBJQCqQXvaOqQyc7+7w?=
 =?us-ascii?Q?BDT2HBqhTRE19+NpGq4MTFAPYxWVhMrrwvpfR/tI1sI5Fu1AVzNxymx/wXW5?=
 =?us-ascii?Q?1XPfdxr2xJ+o839F20zL4Jra29xuO8O3RJNU85jipJ7yfuAxwbkaOP1TECZ/?=
 =?us-ascii?Q?kOdUyrTU1eRKUwbYPY1xeh22iaeNE52bPvInpljz/3MK03Hb+T7P8q6DY9SJ?=
 =?us-ascii?Q?vE4ws/4RUzdmyzQp0JmWnz2h2J/junv68BADN1jYsApUgCSTE3QdvFm4PdkK?=
 =?us-ascii?Q?Lq0Nfb0RfFOC5oppnbfBhewWoS2jHvxIIKR6ai4a6Gq9DkWn5m8sIFMI+as5?=
 =?us-ascii?Q?kgAqZnZ0fa9MvPoMxJRl/gFFsIcggiTLyndeQsCpcA8MjH4JSgZM1aKkcMfl?=
 =?us-ascii?Q?YSJ+E01EYaPZWaix0RuYB0Y8b3HVqhZq03jvD9TIhv9ejf84XioEsu30OYWy?=
 =?us-ascii?Q?NuNiN6D/4xs8HFtWua7+CnsxB+dtS02mhZ+tUJ2H96ODp7EwbcUiDO+Igvax?=
 =?us-ascii?Q?BX+2w/0WvR1+JQENtsR/Ju6aTHo3Ap4Ln6d1OOUjZKcXSrYEzrzXflHgREDk?=
 =?us-ascii?Q?nMS7txtSJQ9qs7/CgNyR0kj9n4eLdcNZYhgr4F62JP1Wwiv4Dh+fyzgxbdVO?=
 =?us-ascii?Q?oTphOj2DhxhSM8blGq2eKjzSeoZQs68qA0Y4VEvLFY3OhQ4TDbGExRN4vbbJ?=
 =?us-ascii?Q?7ZpfeBobsRADbZhC/74WmeZm04+5cllHSdWJBg2Vw4giqyHH+sropkC0OMys?=
 =?us-ascii?Q?YMSzjQQdD/BybOEV9GWe0CwTqdGACbodoH94YZ/lfX7GEnZWVr64A9FKtMMK?=
 =?us-ascii?Q?oYg3J8qrTZtSqAE5XLp6Dh14Gzbilh3isoMYaxV0cnX0sixc1foKV0ZbcEfk?=
 =?us-ascii?Q?qu4yRWVe/w+qXVBiAFARbqeDHMVrcbT5QvtWnSMEagDGSJW0DY7X6ekkm2D+?=
 =?us-ascii?Q?p5PGK3fHe7p7hoTUsianYzpXo7ArTsz23MVj7Fbsxofizgy1VRKzxxGdBrbk?=
 =?us-ascii?Q?C1+Yu6zxBzm80Z/DJ4e7EgvFAB5jVGahmnbKKugjgB7rUkFJ+dGrKvJiQk1K?=
 =?us-ascii?Q?sGfjdvL29X0oa8GdGOgq2PcLQt2oCiPNUoJ/0nGgpPJ7CYTvfqUuKo0NBAzl?=
 =?us-ascii?Q?QeojfEt5KtsJGYWnZ46MVeI3gbfI8AJWgjV6UKGjCGzCuNIgO10/4uBPX23/?=
 =?us-ascii?Q?XsgSzsvNG8hG/DwcMXiWvS9csCDm/jVc8FpA3AMwJLN/IBgBCsDQrUQE1qAJ?=
 =?us-ascii?Q?1icLU0hlSvjBRuuNLNuO/ryoQaoHOxicgdFVpRfFPbQG8Bj+9cR/Pj/1AjHt?=
 =?us-ascii?Q?bPdwPx8gYf9uFUYpaMkpygO+JnXaEb63bjxkU0xa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cf2d3b-a602-4fb3-9639-08dc0b6c42d3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 08:24:38.8173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sH3Q+x2kXVFajhzEoE4AhaaAz8bP7PuQUXHwDS5/IxiCmMXCqOpQzNA/c7Uf6W8CapTtgxtwp/aCPGND2lMwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5580
X-OriginatorOrg: intel.com

On Sun, Dec 31, 2023 at 01:17:11PM +0100, Guillaume Nault wrote:
> On Fri, Dec 29, 2023 at 09:19:31PM +0800, Yujie Liu wrote:
> > The patch set [1] added a general lib.sh in net selftests, and converted
> > several test scripts to source the lib.sh.
> > 
> > unicast_extensions.sh (converted in [1]) and pmtu.sh (converted in [2])
> > have a /bin/sh shebang which may point to various shells in different
> > distributions, but "source" is only available in some of them. For
> > example, "source" is a built-it function in bash, but it cannot be
> > used in dash.
> > 
> > Refer to other scripts that were converted together, simply change the
> > shebang to bash to fix the following issues when the default /bin/sh
> > points to other shells.
> 
> Looks like it'd be simpler to just replace the "source" commands with
> "." and leave the shebang as is (unless there are other bash-specific
> constructs in these scripts of course).
> 
> Generally speaking, I think we should avoid madating a specific shell,
> unless that really simplifies the test script (which is not the case
> here).

Hi Guillaume,

Thanks for the comments. Actually I also considered replacing "source"
with "." at first, but finally decided to change the shebang in
consideration of being consistent with other scripts. We can see that
there are 140+ scripts in net selftests that have "source lib.sh" and
"bash" shebang, but none of the selftests has ". lib.sh". If we replace
"source" with "." and keep the "sh" shebang specifically for
unicast_extensions.sh and pmtu.sh, we will get only 2 scripts using
"sh and ." while most other scripts using "bash and source". Maybe it
would be nice to keep the consistency by changing the shebang as well?
What do you think? :)

linux/tools/testing/selftests/net$ grep -rl "source lib.sh" . | xargs grep -F '#!/bin/'
./test_vxlan_under_vrf.sh:#!/bin/bash
./test_vxlan_nolocalbypass.sh:#!/bin/bash
./xfrm_policy.sh:#!/bin/bash
./test_vxlan_mdb.sh:#!/bin/bash
./test_bridge_backup_port.sh:#!/bin/bash
./vrf_route_leaking.sh:#!/bin/bash
./l2tp.sh:#!/bin/bash
./netns-name.sh:#!/bin/bash
./rtnetlink.sh:#!/bin/bash
./ioam6.sh:#!/bin/bash
./drop_monitor_tests.sh:#!/bin/bash
./test_vxlan_vnifiltering.sh:#!/bin/bash
./icmp.sh:#!/bin/bash
./gre_gso.sh:#!/bin/bash
./fib_nexthop_multiprefix.sh:#!/bin/bash
./icmp_redirect.sh:#!/bin/bash
./vrf-xfrm-tests.sh:#!/bin/bash
./vrf_strict_mode_test.sh:#!/bin/bash
./fcnal-test.sh:#!/bin/bash
./stress_reuseport_listen.sh:#!/bin/bash
./srv6_end_dt4_l3vpn_test.sh:#!/bin/bash
./test_bridge_neigh_suppress.sh:#!/bin/bash
./cmsg_ipv6.sh:#!/bin/bash
./arp_ndisc_evict_nocarrier.sh:#!/bin/bash
./fib_rule_tests.sh:#!/bin/bash
./srv6_end_dt6_l3vpn_test.sh:#!/bin/bash
./forwarding/custom_multipath_hash.sh:#!/bin/bash
./forwarding/gre_inner_v4_multipath.sh:#!/bin/bash
./forwarding/tc_tunnel_key.sh:#!/bin/bash
./forwarding/tc_shblocks.sh:#!/bin/bash
./forwarding/router_nh.sh:#!/bin/bash
./forwarding/skbedit_priority.sh:#!/bin/bash
./forwarding/tc_mpls_l2vpn.sh:#!/bin/bash
./forwarding/gre_inner_v6_multipath.sh:#!/bin/bash
./forwarding/vxlan_symmetric.sh:#!/bin/bash
./forwarding/bridge_mdb.sh:#!/bin/bash
./forwarding/no_forwarding.sh:#!/bin/bash
./forwarding/router_bridge_1d.sh:#!/bin/bash
./forwarding/tc_flower_port_range.sh:#!/bin/bash
./forwarding/router_multicast.sh:#!/bin/bash
./forwarding/bridge_locked_port.sh:#!/bin/bash
./forwarding/vxlan_asymmetric_ipv6.sh:#!/bin/bash
./forwarding/dual_vxlan_bridge.sh:#!/bin/bash
./forwarding/bridge_port_isolation.sh:#!/bin/bash
./forwarding/local_termination.sh:#!/bin/bash
./forwarding/ipip_flat_gre_keys.sh:#!/bin/bash
./forwarding/gre_multipath_nh_res.sh:#!/bin/bash
./forwarding/gre_multipath.sh:#!/bin/bash
./forwarding/vxlan_bridge_1d_ipv6.sh:#!/bin/bash
./forwarding/ip6gre_flat_keys.sh:#!/bin/bash
./forwarding/gre_multipath_nh.sh:#!/bin/bash
./forwarding/bridge_mld.sh:#!/bin/bash
./forwarding/ip6gre_inner_v6_multipath.sh:#!/bin/bash
./forwarding/ip6gre_flat_key.sh:#!/bin/bash
./forwarding/vxlan_asymmetric.sh:#!/bin/bash
./forwarding/tc_flower_router.sh:#!/bin/bash
./forwarding/router_bridge_vlan_upper_pvid.sh:#!/bin/bash
./forwarding/mirror_gre_vlan_bridge_1q.sh:#!/bin/bash
./forwarding/q_in_vni_ipv6.sh:#!/bin/bash
./forwarding/mirror_gre_lag_lacp.sh:#!/bin/bash
./forwarding/ip6gre_custom_multipath_hash.sh:#!/bin/bash
./forwarding/vxlan_bridge_1d.sh:#!/bin/bash
./forwarding/ip6gre_hier_key.sh:#!/bin/bash
./forwarding/gre_custom_multipath_hash.sh:#!/bin/bash
./forwarding/ipip_flat_gre_key.sh:#!/bin/bash
./forwarding/mirror_gre_flower.sh:#!/bin/bash
./forwarding/router_bridge.sh:#!/bin/bash
./forwarding/vxlan_symmetric_ipv6.sh:#!/bin/bash
./forwarding/mirror_gre_bridge_1q.sh:#!/bin/bash
./forwarding/router_multipath.sh:#!/bin/bash
./forwarding/tc_vlan_modify.sh:#!/bin/bash
./forwarding/vxlan_bridge_1q.sh:#!/bin/bash
./forwarding/bridge_mdb_port_down.sh:#!/bin/bash
./forwarding/tc_flower.sh:#!/bin/bash
./forwarding/tc_flower_cfm.sh:#!/bin/bash
./forwarding/mirror_gre_neigh.sh:#!/bin/bash
./forwarding/ethtool_rmon.sh:#!/bin/bash
./forwarding/hw_stats_l3_gre.sh:#!/bin/bash
./forwarding/router.sh:#!/bin/bash
./forwarding/ipip_hier_gre_key.sh:#!/bin/bash
./forwarding/tc_police.sh:#!/bin/bash
./forwarding/pedit_ip.sh:#!/bin/bash
./forwarding/ip6_forward_instats_vrf.sh:#!/bin/bash
./forwarding/router_mpath_nh_res.sh:#!/bin/bash
./forwarding/mirror_gre_changes.sh:#!/bin/bash
./forwarding/hw_stats_l3.sh:#!/bin/bash
./forwarding/ipip_hier_gre.sh:#!/bin/bash
./forwarding/q_in_vni.sh:#!/bin/bash
./forwarding/ip6gre_flat.sh:#!/bin/bash
./forwarding/router_bridge_vlan_upper.sh:#!/bin/bash
./forwarding/bridge_igmp.sh:#!/bin/bash
./forwarding/mirror_gre_nh.sh:#!/bin/bash
./forwarding/bridge_mdb_host.sh:#!/bin/bash
./forwarding/ipip_hier_gre_keys.sh:#!/bin/bash
./forwarding/pedit_dsfield.sh:#!/bin/bash
./forwarding/bridge_vlan_mcast.sh:#!/bin/bash
./forwarding/mirror_gre_bridge_1d_vlan.sh:#!/bin/bash
./forwarding/router_bridge_1d_lag.sh:#!/bin/bash
./forwarding/router_bridge_pvid_vlan_upper.sh:#!/bin/bash
./forwarding/mirror_gre_bound.sh:#!/bin/bash
./forwarding/ip6gre_hier.sh:#!/bin/bash
./forwarding/ip6gre_hier_keys.sh:#!/bin/bash
./forwarding/ethtool_extended_state.sh:#!/bin/bash
./forwarding/router_mpath_nh.sh:#!/bin/bash
./forwarding/tc_flower_l2_miss.sh:#!/bin/bash
./forwarding/bridge_vlan_unaware.sh:#!/bin/bash
./forwarding/router_broadcast.sh:#!/bin/bash
./forwarding/bridge_fdb_learning_limit.sh:#!/bin/bash
./forwarding/ipip_lib.sh:#!/bin/bash
./forwarding/ip6gre_inner_v4_multipath.sh:#!/bin/bash
./forwarding/router_vid_1.sh:#!/bin/bash
./forwarding/mirror_gre.sh:#!/bin/bash
./forwarding/router_bridge_vlan.sh:#!/bin/bash
./forwarding/bridge_vlan_aware.sh:#!/bin/bash
./forwarding/ethtool.sh:#!/bin/bash
./forwarding/loopback.sh:#!/bin/bash
./forwarding/bridge_sticky_fdb.sh:#!/bin/bash
./forwarding/bridge_mdb_max.sh:#!/bin/bash
./forwarding/pedit_l4port.sh:#!/bin/bash
./forwarding/tc_actions.sh:#!/bin/bash
./forwarding/mirror_vlan.sh:#!/bin/bash
./forwarding/sch_red.sh:#!/bin/bash
./forwarding/ipip_flat_gre.sh:#!/bin/bash
./forwarding/mirror_gre_bridge_1d.sh:#!/bin/bash
./forwarding/lib.sh:#!/bin/bash
./forwarding/mirror_gre_vlan.sh:#!/bin/bash
./forwarding/mirror_gre_bridge_1q_lag.sh:#!/bin/bash
./forwarding/ethtool_mm.sh:#!/bin/bash
./forwarding/vxlan_bridge_1q_ipv6.sh:#!/bin/bash
./forwarding/tc_chains.sh:#!/bin/bash
./forwarding/ip6gre_lib.sh:#!/bin/bash
./fib_nexthop_nongw.sh:#!/bin/bash
./srv6_end_dt46_l3vpn_test.sh:#!/bin/bash
./cmsg_so_mark.sh:#!/bin/bash
./sctp_vrf.sh:#!/bin/bash
./fdb_flush.sh:#!/bin/bash
./ndisc_unsolicited_na_test.sh:#!/bin/bash
./traceroute.sh:#!/bin/bash
./fib-onlink-tests.sh:#!/bin/bash
./fib_tests.sh:#!/bin/bash
./cmsg_time.sh:#!/bin/bash
./arp_ndisc_untracked_subnets.sh:#!/bin/bash
./fib_nexthops.sh:#!/bin/bash

linux/tools/testing/selftests/net$ grep -rF ". lib.sh"
<-- nothing

Thanks,
Yujie

