Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6773D7D0641
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 03:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346827AbjJTBwi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 21:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbjJTBwh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 21:52:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217B013D;
        Thu, 19 Oct 2023 18:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697766753; x=1729302753;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XabN5vSDMVDC5maAqMOcKoLO95nDyY2CGDjVgoVA4zc=;
  b=Vlr6N8x1ZxZw3QxCIN6R7zB9/QLt4U0s7waoRncOgIgnY21vVxUe8JVm
   +Wvip7RPy2T7PT9FaJQm0F70MfYs4Xlhg6RbNYEchRdQtPkaumLTilV4J
   XLTL6uAGCGkrDfa+hevrlykE5m2JRstqAEmFAsk22+31q1HmpJfMhQlcb
   r7MVn+mgeynTFv3hMMk1PrfuY2SpSLeaC8v9LxDwDN5F6ZxXAp8dB2hCH
   or8ZNZnQEmbkS1wJjZGFS70XzdOK2zk0RjwCVgWnXBMQogZqG8Hu5U46q
   LLri6/pWZn5BVnZTo+EB7iRod4M3AdPL+ZHXDOYmU64FfGbpOtC1jjSod
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="452890379"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="452890379"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 18:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707078777"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707078777"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 18:52:31 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 18:52:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 18:52:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 18:52:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+beMcsht+17z1X+5XiPxpG3qUjc7c2n129eV4xOspwzz0/4+ZFamgLdsG9fTO9wxrk8fnUDg6lxPjlhbDR6NhjmhL8KuiQZgsCGepEN5Htz15KaWiPvsX0q/vSMrx/RbtApU3Mu1RAppNLW6Iftkua9AVUBf+HtZ2wIQ30xooNI8ijOJz57inIih8NZo2kcgfF1dzUw4Pmy9vme8wE/uHVToMxR9S7TMey0jWE1Dys46Y9513bmM8w1OUiRT6UsmfZlyaYYPMzjW1gn56Bq/grddyqnpbuUSFHQ8yuQ++vAUZmIAUwgj9+J5tvDLlwc8r2x2CSgdY3jJWpnDlYBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwuArJXCkz1EXCJj8p7DZmYsAkX63I7ouV46zq6+Xzo=;
 b=CQmx9BAwxKxX8dxp6UvSOTKQGpCGvFNRVtQxN4MBpbTxMjm4gLp9fa3jTyFfzcNRpO18SOoHdionn500WlF5KdOdlBNifxIPD/nMOLGoSX6wFcnZJQ5bmkfjIyFXqUMuylXHWJaR+4YxSN1pUqo7G3hxr+RGWuxvE8Nlh9ar0caBmoDT0Y7/Pm2cKAs33+0s6m0wJKGIUODw0EpgbDSYEgHdapyYHOX1NhCTDQ9+y5z3BA7jxrPr+1mWtQdBJZQlmWiOsifahGNKzUjoUzFlLK9CwTSsQvH0+3P3Kv9jRSsQsZZF3pbZySMsDXDxPh5lClPkaVZsL03+46YnZ/YIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CYYPR11MB8359.namprd11.prod.outlook.com (2603:10b6:930:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 01:52:27 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Fri, 20 Oct 2023
 01:52:27 +0000
Date:   Fri, 20 Oct 2023 09:52:13 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <netdev@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <rdunlap@infradead.org>,
        <willemb@google.com>, <gustavoars@kernel.org>,
        <herbert@gondor.apana.org.au>, <steffen.klassert@secunet.com>,
        <nogikh@google.com>, <pablo@netfilter.org>, <decui@microsoft.com>,
        <cai@lca.pw>, <jakub@cloudflare.com>, <elver@google.com>,
        <pabeni@redhat.com>,
        "xuanzhuo@linux.alibaba.comshuah" <yuri.benditovich@daynix.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        <oliver.sang@intel.com>
Subject: Re: [RFC PATCH 6/7] selftest: tun: Add tests for virtio-net hashing
Message-ID: <202310192236.fde97031-oliver.sang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231008052101.144422-7-akihiko.odaki@daynix.com>
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CYYPR11MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fb5b69-ea16-4a9b-3453-08dbd10f36b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcSs+wn7+WruNXDomJGfIq1NEVzeYG8Zi+lSLFM/i6QsU8Y+1vw9rzTWSQ6qmZdIWVmSXc2TrFNCy28rG6tlfwwaL3EaSvP6JIajAXolXFg1uhcPFGWpSV3fNYI6LRFlM7Zud0DhU8hz8L+3JycGuM+qQ21DIOCViXk4c8hZrXRPLZ+MQimvN9PjToZd9lYLO3tamDEw4TYMUS9gvXEjRxqGyDMDs70699m//OGPkmpAUmxUmd7wSneysYFfEG0kIAu4d7Z+5Iu6QA0OxH6PFjjYFPPHwC/BAMiCAx7voqs3sb6NNxZEZ9JndYX8bftOiIqyOKE0vryT8h0pHDA7DGV5RSnkGj1I00+mo/Cn4Sd1nLgs6QK3TMDbwln0rVRATZWOkKDz9hfTPx4IYaLTeZTfHfZVfXHkVhyLF1eORI1RBCdnjQUkfLtEeNdKjoPdpEan6c0B4VzYr000KdmBYSfcE7EEYdperdiTG+MaevgDbZeWJDYeoEPTQeZhfed4XC8LULwe3t0lMhKi127RBUTdcAdpmOPWYp8NrAgQxsA9wCX7ulOfG4sp3ynXpEhrs628EDKEIqra0WbdqxxyIFmae8aaZtnqF9u+BS8iokYw/3fxze8xB4D56omCdun3sMNd1C+9At5GmW+Ch70DuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(2616005)(6506007)(38100700002)(82960400001)(86362001)(36756003)(1076003)(26005)(41300700001)(7406005)(7416002)(30864003)(2906002)(4001150100001)(6666004)(107886003)(966005)(6486002)(478600001)(83380400001)(8676002)(8936002)(4326008)(5660300002)(66946007)(66556008)(66476007)(6916009)(316002)(54906003)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1wY01oY1pXSGNrdUg3YkEzM240R0tDTFFpSi9oSVNFU0Z2Wm14RWFQWCtv?=
 =?utf-8?B?T2RHK3cxcjZ3YmNwaXo0a1VXRS9rbDJXSDk1ZnI5SXpDUlM0TlFjeU5zUDN4?=
 =?utf-8?B?WUhSazNjbWVjUEpmNVNCUjJ0YTVNRXNpc2x4cjJXMnpNZjM0MEovZ3lvbG8v?=
 =?utf-8?B?Z2VoazJuWmZRY3RVT2M0ODErNFMxMlYrZTB4ME91bVk5L1dtSlk1YmdsVjN0?=
 =?utf-8?B?K3F4RWhIY20veVd4SjNIc3ZtSVNuY1FiS1dKb250NFpWWC8vRFJtbXZ4OG84?=
 =?utf-8?B?WDRFdnVjaUptRURWT2E3NTJ2Q3h0YWlKd1BtSFdBSHpIV1R3RThwOXREYlFq?=
 =?utf-8?B?Z2phc1pNSmJJQm44aWRBWW5EZSthRDd6WTdEazhQLyt2ZFh2ak5WdjJZNlJF?=
 =?utf-8?B?Vm4xQzNFY1MxSHVkVHR0MTdvSGVlKzN2b09ydWtQUDROVnlxbkpwYU5NWnI3?=
 =?utf-8?B?MjNrTHQvTS9PNDNnQkltVHVkS1pjNDM3aGVUNC9pdGJOTVhoUXNsSzk0VzZD?=
 =?utf-8?B?WloyVlNmWHVZeHNoUzQ0TDk5RkNIUzlKVFVEWXVHRFYrb0I0RTFZZVdaZ1VQ?=
 =?utf-8?B?QWR4d28vMEFkdUkxTGdVdWhXNHJHRlRRZDk0VnlwUkJGY2Y2OXFxeEU3TGdE?=
 =?utf-8?B?aG13ZEJsbVBnTHUwRnRkRW1YSTVKVG5uSDdrM0d3MWk2aStGb2gxYTlCUnNU?=
 =?utf-8?B?eDhEMWdZYUJCOFBqTE1DRmg5cUo0QkxPWHpwa0E3bUdEMHRuQzVuM1p1clgx?=
 =?utf-8?B?azNDV0FseDY2cmxybUl3N3B1KzFmUGQ0UEpDTVM3WDduczZEZnhsbHVxWVo4?=
 =?utf-8?B?b1p4R2NnTEsxakZ5S2dlNkRLcWlHR2ZPWWtCdHNuMU9nY2N1dHNvM1BCUi8z?=
 =?utf-8?B?UHhtTzhyR29LS1VYeUlIYVJ0aDMydGcwcXIrRWNnRUVKYjg5aDZDQXh2MFZw?=
 =?utf-8?B?UjVReW1mSytGUkNXd3dyUU0yNmZEYmtIQlJYSmdxZTRnQWtUSUFQSUhWc2xx?=
 =?utf-8?B?Z2FMMk43QzRJMCswdmNReFBoQ3ZIWm9SYjNFSlhZNzhCNHlpaW5yN0R1Q3hV?=
 =?utf-8?B?TWRyYzZmWG5rQkQxUDJtLzVxeW53bVRsVm9Mc0UyK0NXYlFWTjNDN1FhTFdv?=
 =?utf-8?B?WDg2YXpDNnljME1LMTVZMGVmTCtaS0FHV1dZYTR0MnFPMjZ2VDVLcklzOG9H?=
 =?utf-8?B?TWZXbU5FdTVVaXZPcFBhTXJabkJJcTBlQkZnN3pwcUdBMURQbjJPQitHVDI4?=
 =?utf-8?B?SzZwd2VTWTZOWXlBSU5Wb3lwSFpSbG5INFROWFdjR1dtOWwzVHJROGhndWtD?=
 =?utf-8?B?ckhHOHQxTFBHcmpudG1aVTBqZ3V2eU9JdTh3WG9Db2wraThsODU4YmFpaEZ2?=
 =?utf-8?B?RWVaNCs0UDh1N2dYdk5aU1FjaG16Q0dialpEMWQ2aklHbjdwUXZzTnlxNzli?=
 =?utf-8?B?d056NEFKcnlNY2VsT2s3eFYvRGorMWRWMEI3K0RoRUU4SlZBeHdyVFM0ckNs?=
 =?utf-8?B?RFlYdFFvcEdFdlFaRFRiV2hPdmZQSDd2aHRyVUVSL0Y1NmdjYU5UL01waE5l?=
 =?utf-8?B?MUxGaTkzdlNhTnZRVFhyWGZEMmhZcFJhbXQvUkdaME03aEsxaGszOGhTOEwr?=
 =?utf-8?B?NFJ0TUlpV2MwUThERktvQzdpY3B6eTlCekkvR29MOW1TRzNYalMrRmRxWXQ4?=
 =?utf-8?B?Wk5saFp5MjNVdS9iV3FDVFgvNXVOa25pbjdIelB5dUlMTTF5emhoeE0zekNj?=
 =?utf-8?B?R2JjRmZpenZOWjZKZUdCYXJMTGFmSzluWFhIN0g3N29GRnl2OGFDd3VMWjIw?=
 =?utf-8?B?VkZnQk9idFNnaUYxb0dSK2FVdC9JUjZucXNnTEhiekZzM3JVSUxlekF6RDYw?=
 =?utf-8?B?U1ZNOXZtUUUwdjJBL0ZRcFdrRkFPd21PZzFwVVBIUHBBUE9JMWo4aFRnN1RZ?=
 =?utf-8?B?SFhYc1ZHU1lOQ0NzNkR3c1ZHeU1JUGRFRk9kWU1jZFRJeHp4L01nL21Wb0xV?=
 =?utf-8?B?aFo5VitzVzlQN2MwSGNyWXRmT1liaWk0QjYrK2hXSmlGSWVLeXM0cDRmVVVu?=
 =?utf-8?B?czRwUVJSSm1Pb0Z4cGdTeG9BUTdzTC8xbVJ0T0NGaHcrclBBRXVUaWM5VW9p?=
 =?utf-8?B?TVltR3NWYnd1VWliZUkyUElPSkI5NnNTM1poOTFaVmUydHprZjF5aEthQVVE?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fb5b69-ea16-4a9b-3453-08dbd10f36b0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 01:52:27.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw8rJ5R4AX3gDhaKbsEGoBsFhR/XwRkUoJh+svbbX7jZZOZKQJ2kgFDh5BBUFigE3GVI7udR2uJVKVf/O+2mGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8359
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


hi, Akihiko Odaki,

sorry for sending again, the previous one has some problem that lost most
of CC part.


Hello,


kernel test robot noticed "kernel-selftests.net.make.fail" on:

commit: c04079dfb34c2f534f013408b12218c14b286b7d ("[RFC PATCH 6/7] selftest: tun: Add tests for virtio-net hashing")
url: https://github.com/intel-lab-lkp/linux/commits/Akihiko-Odaki/net-skbuff-Add-tun_vnet_hash-flag/20231008-133245
base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
patch link: https://lore.kernel.org/all/20231008052101.144422-7-akihiko.odaki@daynix.com/
patch subject: [RFC PATCH 6/7] selftest: tun: Add tests for virtio-net hashing

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: net
	test: fcnal-test.sh
	atomic_test: ipv6_runtime



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310192236.fde97031-oliver.sang@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d
2023-10-14 17:54:16 mount --bind /lib/modules/6.6.0-rc2-00023-gc04079dfb34c/kernel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/lib
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/tools/bpf/resolve_btfids'

...

gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/ -I../../../include/ -isystem /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/usr/include -I../     txtimestamp.c  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/tools/testing/selftests/net/txtimestamp
reuseport_bpf.c: In function ‘attach_cbpf’:
reuseport_bpf.c:133:28: error: array type has incomplete element type ‘struct sock_filter’
  133 |         struct sock_filter code[] = {
      |                            ^~~~
reuseport_bpf.c:139:29: error: ‘BPF_A’ undeclared (first use in this function); did you mean ‘BPF_H’?
  139 |                 { BPF_RET | BPF_A, 0, 0, 0 },
      |                             ^~~~~
      |                             BPF_H
reuseport_bpf.c:139:29: note: each undeclared identifier is reported only once for each function it appears in
reuseport_bpf.c:141:16: error: variable ‘p’ has initializer but incomplete type
  141 |         struct sock_fprog p = {
      |                ^~~~~~~~~~
reuseport_bpf.c:142:18: error: ‘struct sock_fprog’ has no member named ‘len’
  142 |                 .len = ARRAY_SIZE(code),
      |                  ^~~
In file included from reuseport_bpf.c:27:
../kselftest.h:56:25: warning: excess elements in struct initializer
   56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
      |                         ^
reuseport_bpf.c:142:24: note: in expansion of macro ‘ARRAY_SIZE’
  142 |                 .len = ARRAY_SIZE(code),
      |                        ^~~~~~~~~~
../kselftest.h:56:25: note: (near initialization for ‘p’)
   56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
      |                         ^
reuseport_bpf.c:142:24: note: in expansion of macro ‘ARRAY_SIZE’
  142 |                 .len = ARRAY_SIZE(code),
      |                        ^~~~~~~~~~
reuseport_bpf.c:143:18: error: ‘struct sock_fprog’ has no member named ‘filter’
  143 |                 .filter = code,
      |                  ^~~~~~
reuseport_bpf.c:143:27: warning: excess elements in struct initializer
  143 |                 .filter = code,
      |                           ^~~~
reuseport_bpf.c:143:27: note: (near initialization for ‘p’)
reuseport_bpf.c:141:27: error: storage size of ‘p’ isn’t known
  141 |         struct sock_fprog p = {
      |                           ^
reuseport_bpf.c:141:27: warning: unused variable ‘p’ [-Wunused-variable]
reuseport_bpf.c:133:28: warning: unused variable ‘code’ [-Wunused-variable]
  133 |         struct sock_filter code[] = {
      |                            ^~~~
reuseport_bpf.c: In function ‘test_filter_no_reuseport’:
reuseport_bpf.c:346:28: error: array type has incomplete element type ‘struct sock_filter’
  346 |         struct sock_filter ccode[] = {{ BPF_RET | BPF_A, 0, 0, 0 }};
      |                            ^~~~~
reuseport_bpf.c:346:51: error: ‘BPF_A’ undeclared (first use in this function); did you mean ‘BPF_H’?
  346 |         struct sock_filter ccode[] = {{ BPF_RET | BPF_A, 0, 0, 0 }};
      |                                                   ^~~~~
      |                                                   BPF_H
reuseport_bpf.c:348:27: error: storage size of ‘cprog’ isn’t known
  348 |         struct sock_fprog cprog;
      |                           ^~~~~
reuseport_bpf.c:348:27: warning: unused variable ‘cprog’ [-Wunused-variable]
reuseport_bpf.c:346:28: warning: unused variable ‘ccode’ [-Wunused-variable]
  346 |         struct sock_filter ccode[] = {{ BPF_RET | BPF_A, 0, 0, 0 }};
      |                            ^~~~~
make: *** [../lib.mk:181: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/tools/testing/selftests/net/reuseport_bpf] Error 1
make: *** Waiting for unfinished jobs....
reuseport_bpf_cpu.c: In function ‘attach_bpf’:
reuseport_bpf_cpu.c:79:28: error: array type has incomplete element type ‘struct sock_filter’
   79 |         struct sock_filter code[] = {
      |                            ^~~~
reuseport_bpf_cpu.c:81:52: error: ‘SKF_AD_OFF’ undeclared (first use in this function)
   81 |                 { BPF_LD  | BPF_W | BPF_ABS, 0, 0, SKF_AD_OFF + SKF_AD_CPU },
      |                                                    ^~~~~~~~~~
reuseport_bpf_cpu.c:81:52: note: each undeclared identifier is reported only once for each function it appears in
reuseport_bpf_cpu.c:81:65: error: ‘SKF_AD_CPU’ undeclared (first use in this function)
   81 |                 { BPF_LD  | BPF_W | BPF_ABS, 0, 0, SKF_AD_OFF + SKF_AD_CPU },
      |                                                                 ^~~~~~~~~~
reuseport_bpf_cpu.c:83:29: error: ‘BPF_A’ undeclared (first use in this function); did you mean ‘BPF_H’?
   83 |                 { BPF_RET | BPF_A, 0, 0, 0 },
      |                             ^~~~~
      |                             BPF_H
reuseport_bpf_cpu.c:85:16: error: variable ‘p’ has initializer but incomplete type
   85 |         struct sock_fprog p = {
      |                ^~~~~~~~~~
reuseport_bpf_cpu.c:86:18: error: ‘struct sock_fprog’ has no member named ‘len’
   86 |                 .len = 2,
      |                  ^~~
reuseport_bpf_cpu.c:86:24: warning: excess elements in struct initializer
   86 |                 .len = 2,
      |                        ^
reuseport_bpf_cpu.c:86:24: note: (near initialization for ‘p’)
reuseport_bpf_cpu.c:87:18: error: ‘struct sock_fprog’ has no member named ‘filter’
   87 |                 .filter = code,
      |                  ^~~~~~
reuseport_bpf_cpu.c:87:27: warning: excess elements in struct initializer
   87 |                 .filter = code,
      |                           ^~~~
reuseport_bpf_cpu.c:87:27: note: (near initialization for ‘p’)
reuseport_bpf_cpu.c:85:27: error: storage size of ‘p’ isn’t known
   85 |         struct sock_fprog p = {
      |                           ^
reuseport_bpf_cpu.c:85:27: warning: unused variable ‘p’ [-Wunused-variable]
reuseport_bpf_cpu.c:79:28: warning: unused variable ‘code’ [-Wunused-variable]
   79 |         struct sock_filter code[] = {
      |                            ^~~~
make: *** [../lib.mk:181: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/tools/testing/selftests/net/reuseport_bpf_cpu] Error 1
In file included from psock_fanout.c:55:
psock_lib.h: In function ‘pair_udp_setfilter’:
psock_lib.h:52:28: error: array type has incomplete element type ‘struct sock_filter’
   52 |         struct sock_filter bpf_filter[] = {
      |                            ^~~~~~~~~~
psock_lib.h:65:27: error: storage size of ‘bpf_prog’ isn’t known
   65 |         struct sock_fprog bpf_prog;
      |                           ^~~~~~~~
psock_lib.h:65:27: warning: unused variable ‘bpf_prog’ [-Wunused-variable]
psock_lib.h:52:28: warning: unused variable ‘bpf_filter’ [-Wunused-variable]
   52 |         struct sock_filter bpf_filter[] = {
      |                            ^~~~~~~~~~
psock_fanout.c: In function ‘sock_fanout_set_cbpf’:
psock_fanout.c:114:28: error: array type has incomplete element type ‘struct sock_filter’
  114 |         struct sock_filter bpf_filter[] = {
      |                            ^~~~~~~~~~
psock_fanout.c:115:17: warning: implicit declaration of function ‘BPF_STMT’; did you mean ‘BPF_STX’? [-Wimplicit-function-declaration]
  115 |                 BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 80),       /* ldb [80] */
      |                 ^~~~~~~~
      |                 BPF_STX
psock_fanout.c:116:36: error: ‘BPF_A’ undeclared (first use in this function); did you mean ‘BPF_X’?
  116 |                 BPF_STMT(BPF_RET | BPF_A, 0),                 /* ret A */
      |                                    ^~~~~
      |                                    BPF_X
psock_fanout.c:116:36: note: each undeclared identifier is reported only once for each function it appears in
psock_fanout.c:118:27: error: storage size of ‘bpf_prog’ isn’t known
  118 |         struct sock_fprog bpf_prog;
      |                           ^~~~~~~~
psock_fanout.c:118:27: warning: unused variable ‘bpf_prog’ [-Wunused-variable]
psock_fanout.c:114:28: warning: unused variable ‘bpf_filter’ [-Wunused-variable]
  114 |         struct sock_filter bpf_filter[] = {
      |                            ^~~~~~~~~~
make: *** [../lib.mk:181: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/tools/testing/selftests/net/psock_fanout] Error 1
In file included from psock_tpacket.c:47:
psock_lib.h: In function ‘pair_udp_setfilter’:
psock_lib.h:52:28: error: array type has incomplete element type ‘struct sock_filter’
   52 |         struct sock_filter bpf_filter[] = {
      |                            ^~~~~~~~~~
psock_lib.h:65:27: error: storage size of ‘bpf_prog’ isn’t known
   65 |         struct sock_fprog bpf_prog;
      |                           ^~~~~~~~
psock_lib.h:65:27: warning: unused variable ‘bpf_prog’ [-Wunused-variable]
psock_lib.h:52:28: warning: unused variable ‘bpf_filter’ [-Wunused-variable]
   52 |         struct sock_filter bpf_filter[] = {
      |                            ^~~~~~~~~~
make: *** [../lib.mk:181: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/tools/testing/selftests/net/psock_tpacket] Error 1
In file included from psock_snd.c:32:
psock_lib.h: In function ‘pair_udp_setfilter’:
psock_lib.h:52:28: error: array type has incomplete element type ‘struct sock_filter’
   52 |         struct sock_filter bpf_filter[] = {
      |                            ^~~~~~~~~~
psock_lib.h:65:27: error: storage size of ‘bpf_prog’ isn’t known
   65 |         struct sock_fprog bpf_prog;
      |                           ^~~~~~~~
psock_lib.h:65:27: warning: unused variable ‘bpf_prog’ [-Wunused-variable]
psock_lib.h:52:28: warning: unused variable ‘bpf_filter’ [-Wunused-variable]
   52 |         struct sock_filter bpf_filter[] = {
      |                            ^~~~~~~~~~
make: *** [../lib.mk:181: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/tools/testing/selftests/net/psock_snd] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-c04079dfb34c2f534f013408b12218c14b286b7d/tools/testing/selftests/net'



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231019/202310192236.fde97031-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

