Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29087AE634
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjIZGqJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 02:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZGqI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 02:46:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF9F0;
        Mon, 25 Sep 2023 23:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695710760; x=1727246760;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=/CWzfvMlR7ThN63/qn2lmwjJDfkEWcsvkbL/SqFdDeI=;
  b=S4x4ytxqNGFWqobKUvA/VG+bOYmgK9BOt9+q5tsi6yYhyIH3pHb4Uo14
   V/T9YRCKB4Ovs3YswLjJ4aEazTEJ6ZiQ0RaDMQGz9oOS4P9HItIz0JQ9I
   RgQg83ijdHJSRliKXeUtBebO8QRzxmWagxhXUrAEFzRYPZDLLM6F7iOkN
   Ost6OdJ8KAX/iGUkk6cAFQuYeAffLkJwtAxajR+ciUkDrQRRC4JXijOHl
   54hZbQym9hkK6cfXBjLxSAshCKUEzum0Twk9AXPGmTjrlaPM9bz30NnGL
   Hh4I9eAzoUhgcbIRbvAlZIcVU9YGxPenDBZ1Fk08D3fcQilGD/KV3AmXA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385348495"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="385348495"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="752047218"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="752047218"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 23:45:57 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 23:45:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 23:45:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 23:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izr+KnHOwQsnRXGs4JA/qq+kgpyO5E3dsj/E3ggcJLUljk7uKkntakdKI/sP0FDuUsDg64wOEmducbPbXa7j75hJtqVr3uQsIbCao3WzTzop+9TMdW086Bp0ZhTdfX9rh91/KTY2SKF2nimy/Ywh3t/r6+25ROkxoMkCYrw8Zi6R7YzNwrYF6XL1ZLLlcxBa9s6kOy6FFJzgmgx8DmoJ+5D0mU8J8OruHbbm/nA36O3hp0s8cIFnxHPbVO/Da0LGPio7Iv2AX7ep3ENHrHdKJq209mcA+mnwpIVIZJr6RyCDeSB4qNoiDatlIfo1qTDH/pxFXO+d43EwupsCctFMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZVs81wWZ6OL6o9jm+6JXf/rb93C6SAH2Z1a1tTMGhA=;
 b=YFbrKyvqK89A8RAtY//Y5HTsWjwJwg2rYiRMzJiRFA9L/nxQpCc7D3R2mK+W+3sFKzMBoT2Pk85Suc1N1wzCUAut9Eb+QxRtGE7Sl6ZvE/ISFUGiyzlfKlmn0kvEuDCiEgRYVR0Nnf5tSOJ66hSAJIjv+qdy+niWeUTG712Rwjvxy4ILrZf8g1DNkW8rRpsku2CvfkUbOs+8BzIJxhg2PyHWB+RnX5O9rAsUeY2CgbuBb59CTtBu9fRR/YvPlR0Bfs9pVL4Wl265L9i5/se5+llP+QZD/WFsPUSU7W4gJikgQ9ydmrPJ1IgP8CS6bAH8EAqq49tukJdP4A4p/oXpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 06:45:41 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 06:45:41 +0000
Date:   Tue, 26 Sep 2023 14:45:27 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <bpf@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "Song Liu" <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        "John Fastabend" <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <puranjay12@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH bpf-next v3 8/9] bpf/tests: add tests for cpuv4
 instructions
Message-ID: <202309261451.8934f9ad-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230907230550.1417590-9-puranjay12@gmail.com>
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a12ec24-33bc-4e8a-626f-08dbbe5c334f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vE/2bEt337oIR/4YOV70oY5QRnYBBr4UT4v1oVfbGrJudizQ3+v+q9eyIgXnNPSaFNxuKq4g8lJvB+k72SPu5XDjODu2vQTG88olHw3B4g38Bq7InQE+ljT/kaIlsXFLnOUw09WJHmCmytrO/e8EY644YOz3q0T3PlGlqBfeHwMspFYpWtAq9/UD5SfZjImBpe75CLk7Ew6QRtZdrke2dxCDCcwXEZJLlBPZ5JEp/hX4+ndPgH+CZNh72rM5s3ouOaVQ81cxIKrVIdQSaVy5XcNTXUUveFSjg7CL3y5N7udc3CPcecIR12VDuAqyRtqAZcnELTCrCzt2kgPMleyeQap8nen8HkaftQiRXZQ36HU4aVOF7NuFJhZ4/zcZJDrQHf3FrYERPDOHPSOHUpLhKCXOCUjlJrN8MRp3oMfv8sGcndgE8uxQ9IP9cm1P21zm1bkU15snWXS9JftnSh18QCCtLyrC1VIt+22tDssUmZvq9HyezKcFu7jASoAQ16eoYyq4ZPuBT41xvFuUE7OlOwvOJ5v1pvNOd4WPb+9o6DS/y7n5bn8/Pwcy3oKTDhXosuxz2YRGceOpsk5b2p0tXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(2906002)(6486002)(38100700002)(966005)(478600001)(36756003)(83380400001)(6666004)(26005)(2616005)(107886003)(1076003)(82960400001)(6506007)(86362001)(6512007)(7416002)(4326008)(8936002)(8676002)(41300700001)(66476007)(66556008)(66946007)(54906003)(5660300002)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFlE16BMyBQdFxKUibMh9cZwXELm6PoNCEUMJ0mzVstd1fAxD1is4S5ejnWd?=
 =?us-ascii?Q?Igqjyi3Tc4tcqdreV1zYeUuAP04Q9r0/8kkNg8eibW1bCgJX0CtGn/Uvckuv?=
 =?us-ascii?Q?TnHZmZV2boXmYapuBj7I4/aGS5Q/1rWV5GPcqlzJr/4tjMU3T5nBrQk+0JiH?=
 =?us-ascii?Q?CFrud5RDWwo6DnFi6QseAf3bAR88e9iNg0Eq/gvXgs3l7WbvqBwphwwLUH4T?=
 =?us-ascii?Q?3YPnP5D9IjgE2tSWaimvbJDf1pznCsnEhRaKmfFnbaoqqZGA9eybNaK9XTIZ?=
 =?us-ascii?Q?A4n27mnlDpzSE5t13Ags8zPBT7PivIz6mDDj4tTKYp3AqIbkXNg/ifmJjoTE?=
 =?us-ascii?Q?phInoy8/0aQpphT3du1qoKEKTydiiK0GTHLgX3NWq62yiOyYpjgCl0UQn5R8?=
 =?us-ascii?Q?trQvm7eDNAYx9BDGDfVPWOwi9m6irl1OMxsqU4YjwoyJCre8VZQbFW3PD//h?=
 =?us-ascii?Q?fXw7JmfJsJjGsFPCevuJHWylcLnvAxFrP0aSkobxjfDfupSN++34Su8xtbdV?=
 =?us-ascii?Q?btoQae2rzYwM36Bph24CZPKNAv42VynE4InPApNpQyOk6LTKi0NXmTfkgBqx?=
 =?us-ascii?Q?iTDDQAC5v9AhAwjaaYHzPg1QuhFNDbQaEjm20Hsyt+WNjuu3FkT35wU8xI/C?=
 =?us-ascii?Q?gH1RTimRFQFQBsLI0wKisdYzIIvnjAH6VVaTH9qfPslaTA5jijee0oRj5ZkA?=
 =?us-ascii?Q?R+fTRQqWtRycIhEAqPztf7eom0IvTEQir1OiMJqLGyBXsaeO6TFEFPMRcfoZ?=
 =?us-ascii?Q?//wwIA3XnNqYCcFUCgYfQ1V+QUrR222K4QZ1Ufwk2pdKNFI6IJ+HsW2rQ4UB?=
 =?us-ascii?Q?ZPcVeyPRffoIaWLRDcuzqwfAoLExnVhlgaEgmt8d8Anas8vv7rTLIz7df5fN?=
 =?us-ascii?Q?/Uj3qQtv3P9uD9nJ0NjSSYyEeYttks6+mVS0+8aIT6VBIxHuSvdyr7amc3Fb?=
 =?us-ascii?Q?0/CZt1QsX4Mqt1dJgjaSbk3jG1R1DnnPP/uabSDVG4FwgHXFsYNzA7LwUlfZ?=
 =?us-ascii?Q?Cu/z3HUCgHKLrjI8+BjGoGQSRL28SaLZF1xw47JKm19NMDcXIdE6NtT0g2sR?=
 =?us-ascii?Q?uJ1nQfslTE7UW7vH6VTS0nwbIOLv8H1qOZfhL76rRdzk98Cf4GWww1ub7P2I?=
 =?us-ascii?Q?cDcz6fSyRzfqPQ7NytNhha+TvrLJgybAFBslUGDJ3xZfWeSH9ZY2Vre3Xrtb?=
 =?us-ascii?Q?QJHdxml3xPggNbP//cvoae+zC0RmsVz7ihaVWI/0fn92ut20PnT0dQ7OD+o5?=
 =?us-ascii?Q?OUfuRcwnuiLyOKyxeoRPOLDe5tfR/QbON0MZD7vTOwplOKDsHhVQGVV/JFsv?=
 =?us-ascii?Q?6tD5T3tt8fil7HXbnatoJoKJ8WMKVvBlDnNvQylNggr2OJz1DshFXKfF/2Rb?=
 =?us-ascii?Q?2mKSLngS/xQv6nW20kvPn4uvJV2heiYNagZ0sIFr3bfDLz3lCvNKbvSvRXWU?=
 =?us-ascii?Q?+MeTzIKxbQ75PTWhpWXIGBw4MK03ipw0i0rZ4AmruARqyeV5wtDEnaQD+uy2?=
 =?us-ascii?Q?hDswMxYBSRg+AtJtbf6xMxObr0GLquYewALCzcQhQAhtiiEzSR3b/02fglPA?=
 =?us-ascii?Q?+5UxJjZ53Amyh2yKl6AIzdZ6B5P0LcFS4UPKj9elzkCgrh9suPvNQojwNXaI?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a12ec24-33bc-4e8a-626f-08dbbe5c334f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 06:45:41.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGy/Wner2th1WXKAqjoPojbyTDqa5jCnqUnayNVFTvMf+q4UUTaHF0iQwgWPG+AKP0fzIesq1MHy7wB8Z1vxow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
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



Hello,

kernel test robot noticed "kernel-selftests.net.test_bpf.sh.fail" on:

commit: 361ceaa10db461a35068f21db451a02c07e2a6bd ("[PATCH bpf-next v3 8/9] bpf/tests: add tests for cpuv4 instructions")
url: https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/arm32-bpf-add-support-for-32-bit-offset-jmp-instruction/20230908-070721
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git master
patch link: https://lore.kernel.org/all/20230907230550.1417590-9-puranjay12@gmail.com/
patch subject: [PATCH bpf-next v3 8/9] bpf/tests: add tests for cpuv4 instructions

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: net



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309261451.8934f9ad-oliver.sang@intel.com



# timeout set to 1500
# selftests: net: test_bpf.sh
# test_bpf: [FAIL]
not ok 13 selftests: net: test_bpf.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230926/202309261451.8934f9ad-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

