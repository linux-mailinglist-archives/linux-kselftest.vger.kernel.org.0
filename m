Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E730D502C9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Apr 2022 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355167AbiDOPZX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Apr 2022 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355109AbiDOPZJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Apr 2022 11:25:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5FD445C;
        Fri, 15 Apr 2022 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650036151; x=1681572151;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KtZj13mbxOnyRhYSbIkHN1V3u1IbyRT1bg+eAoklQgw=;
  b=QxIPx0DyF/FsJaNwILEYSSLabXo8VMuvitlIwSeW94JS2k2RW32gPzxa
   1S+UY1TQkkaAnZ3QILcJy6cMNfA5gpOSNkfbST8kKbQ8YNmPkuA5JOnOs
   Oa4T5JFhBnzFBjAYOrGcyrmDLl6c/8pYryceE5QoIq8knsab+GZiNmHxa
   oQwu8+pc86Pt8XL7F/8Mm5ZajHovptn0rCABElT0jCM04AD4I9snzEBSq
   mqyBzIgWh4acoNB+aEc6EdrU2DDrvRAN44xuIHPXvQWZlfKzU5Pq6PZkS
   KGU4R5b7QZNhssA3hvmKq6A8Uh4DBKjWQqD/b2/U7EbiL3PGN1yrr0nuP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262922871"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="262922871"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 08:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="574391586"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 15 Apr 2022 08:22:30 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Apr 2022 08:22:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Apr 2022 08:22:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Apr 2022 08:22:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Apr 2022 08:22:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrn8/g+k1/8y8ivIP8WaGOSGo0uALrtkup63CDAot5V+uEtutsL7gwtCd+aS5Hz9lVHqj3kofsNiT62aXINtDOTCN3U4kWsCvyqvbznZnQJgivqeBaM6sehGCQZK45f6T7EWitSqWd/VGR9isK94Ptbl3lWqOprk++g+RJqPwgy86dxNvrk9sX0ayzZaBeh0hs7DbX333BXcTwQW3+nHItgdHLlaa47b6AIQR++5nXaO60eXaX+CTvXeUelF9gvzi0zQyC+Mdw7TRhTMUVpfk0g32zsrRVsYberLvNBZGmIx1iP+1ugid4NdIXZra3zD6x6o0PhF9zQwGrDLHULSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtZj13mbxOnyRhYSbIkHN1V3u1IbyRT1bg+eAoklQgw=;
 b=SEDoWpkEkIhy8zmAWHECjz7cIjfm79kai8DQwV+pmISAGRoGflBE6jieQfxAxHXPfgyz+d3TUWGmMYMuGv+tXLeyWvmSO+u8wrlMIPaFOeE0qUljVscA0rbc2vJCFNFELlgJxgqSCSWhGIxXdJhyLAoNQhsNKts0S4YR1yib0Vs/lCiaXvd5NUKOajnewZSc/Q92Z4xArYu7i32wLLtoK01EeHxZ0KvZgtOMAphs5B/6Pdolh5n9ecYLMIFlnQZxlb2CkignELL8lQbBbqkwJ7KEjqA+hXE89RVR7UkAR1G0+l4RyE8OyH3h0YAHUD9+LttBytOi2CtMLV5nJBNMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2737.namprd11.prod.outlook.com (2603:10b6:406:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 15:22:28 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 15:22:28 +0000
Message-ID: <bd1538a8-9dce-1051-385a-191f6a6d1beb@intel.com>
Date:   Fri, 15 Apr 2022 08:22:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 14/31] x86/sgx: Support VA page allocation without
 reclaiming
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <vijay.dhanraj@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <0ab32196f5056b25c34fb89fcc4dc28a5d875d2e.1649878359.git.reinette.chatre@intel.com>
 <bf2fcc93babdbf541fffc6cc5f5756f391773a75.camel@kernel.org>
 <767b99c5-f28e-4b8f-5147-6e1d290ca5c6@intel.com>
 <op.1kn59r1bwjvjmi@hhuan26-mobl1.mshome.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <op.1kn59r1bwjvjmi@hhuan26-mobl1.mshome.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88319636-408e-412b-2f22-08da1ef3c0a2
X-MS-TrafficTypeDiagnostic: BN7PR11MB2737:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB2737A69F9848C7F5F5F3F508F8EE9@BN7PR11MB2737.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/V1jhsv1TPy4pyaDG/R3nvpxOPaLrwTE4SiAnFbZs+BOkAAOb25j2S4QTR0HiT4rWdXFmo+jcpFfQTxcZFe24iDuhAUqFU9siIyiQZT7awVciMECed08DsMxkaN/5EamOgwKx+5r4RJh6zWe+Luze1216ZjfeD62wNi1i76qD/5fgzlMhSyeDtog4/1eHNLA9x3OYOrgC09qhIwwUt3usN1N7lfmHGY7W+Y9dEd96oMMt7H904xVVpuhA2Oou5ejP/Z2NYL4/xzuACGfg77jR1wYKyQc2ipH5XMWHLOYANj/sPQUqBVLuNIV6+7HfrpkUCJ44Xl4vFkCzbiD3DS9jzyOeHqcyuMlGWacJojw3Pv5LmRc0VxLwrXsJ9mMFWtvR6e7jHLjkN0WMlBEmzSzGpG0zourhZ0BTZNwTgg/eYrdDLJUsOQG9NG08XJFdZfuQdefj8w6vBlmJ0z1Sy3/WyS3MicMaAalDU4jN4q3oRc9oWVWIhHB8f+uzd56LcvCPSrezpYemVrfdBRT5DDTZWlmlWHjR8ljFETcfgA4kyiMjIEhM5VJswUVCSY5r/qt9yAgzpTeJbK0+Beobl8b3FoaNDLoYanCJWu6Mg7xdMIU3xDFOHUTnyQWhwQRZnonHl1wOEBckRswQQ0rpS6WA0FmhBUAZDSO/ldvKNaEOWAMNIiKJ3swnVEu/TnHI6LkUm4bn//ZFv6ZKqLuH6uzSu3SvZz+t0D1Vf7umBs/T/hKp6jS3r4AWlCv9hpl8bC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(82960400001)(26005)(38100700002)(6512007)(6506007)(53546011)(6666004)(86362001)(2906002)(36756003)(921005)(66556008)(66476007)(66946007)(508600001)(6486002)(8676002)(4326008)(44832011)(8936002)(316002)(5660300002)(110136005)(7416002)(186003)(31696002)(2616005)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDc2VlpIOW1oNUx3c1NjSCtITGwvZjNjNmJLNDlWdGVyUXNDRXYzTXIwWi9z?=
 =?utf-8?B?dXJUTmZBOXhESm05QUpaVXFyM3NrS2luTk91WHpZdFE0NTlveVNxRzd6ZjVp?=
 =?utf-8?B?SlZyOGlSMUhvRGNIRzJBUGlCMG5sMnIwZ0h3MldFempuQ2hnSUlLOFY1cDMw?=
 =?utf-8?B?bStkUGx5alB5TGlPNzJhb2xWOENBYjJUVisrWk4yYzBKTnI1cklnYTZMUS82?=
 =?utf-8?B?YXpPeEVGNXpmNVJldTMyTUVHOFovRXV3bGE1T0dpRzlqSWx6a1NxZUIxWGQ5?=
 =?utf-8?B?QXR0d3ZkRUIwbWZMdWxKcmZlY1hINXdUS2ZkMnA5VTBRcFNsWnNoM3pPeENT?=
 =?utf-8?B?R29IaXYweUI5d0JtaTdJMUthbE1CY2oxRkVFaHZ3b2tEaXQwVnFoTFUzRkRN?=
 =?utf-8?B?Y0U1UmE0TnRMOG90SFdsdzhXVUltZCtWMXpRYXR3STBRbENNNjlET2VWcDJh?=
 =?utf-8?B?Y1NkRGZiRkNwcCtWb3ZjM1FBczlYL0FSc0VPWXU1ZklQbGFEOWlaUzV6VWJm?=
 =?utf-8?B?bE9IaTFkbVVQbTJ5WEEyanRGKzlQNm05c3FXejA5dk5DVXJFcWx5NTMxSWVW?=
 =?utf-8?B?bytDenNoR3ZVTDVmSGJSbldjR1JVbHF1eG9NeTltaWpHM05vSWxSRHBhT2Mw?=
 =?utf-8?B?dlcvMFoyUGxORExOejVtdU9zZm9GVStxL2MwRG56V20yL1ZsKzVJcHkvZGlp?=
 =?utf-8?B?eVk3NU9BaDlYdWUyQVpsRmhOY3NnN1RiMFZvQnluZ3VuNHRiOXhNMmFNVUxp?=
 =?utf-8?B?QVpGZFBCOURESnh3VDNra25ycTdnQmZLNW1UQ0EySnlTOG4wNUtNbWdaZzBz?=
 =?utf-8?B?Q3VWSDNLYTlwUks4OG9GUmM4THd3R1F4M3htRW5hNHoyUWdsNUR5MUp6bWFB?=
 =?utf-8?B?TnRMT1RmNWFzUnFNY1RxZ0huZlpBUURVejJWODNtVU5zaTRQTjJ3ZGtFR3cv?=
 =?utf-8?B?U3ZMdVhKL3JCK3loT2tFU3VTMGl0V0pZYXRMRER5OU5sMkVmL0VIVmc2eCsr?=
 =?utf-8?B?V0pnNGZaQ2dNU0JMMTI5VnVZMU8raGovSlpoZ1ZGRXc4RnFkcjhuVS9yV0l4?=
 =?utf-8?B?T00vTEVhNElGS082MjFQNXBkWXphV2VVMUR6NGJkZjV3NmdCbHhnZTU4S0d1?=
 =?utf-8?B?TWtPa2M2V1YzeGlwZm5hZUlGK1RCWkV4UndzYVNvVWNFUTh6V1VudlNoQUMv?=
 =?utf-8?B?ejQrbGE4VzRLcWQ0Q290ZDIzV25samsyMWZiNkdwaVppNytqY2dIYVVaZDhp?=
 =?utf-8?B?Q3loaHpYaXo4ZnRCWDlwcVZaQnZlVFFhYk5zcDFvSG9UYW1Sb01tMFJtL0Zp?=
 =?utf-8?B?YkJmZWYvaFN1R1JoQXJJS3pueU83cE1CZzQ5NXFWdEFLZWNCbDl1cU9MWjhB?=
 =?utf-8?B?RnhaOVdUVDlubi9CSTNVcW5qcGlpMU52dEZKUlpIZWFtbnJ0MkJEWnU0bTBu?=
 =?utf-8?B?WG1wSC9QZThiYTVCNytENjJHQ2VLYm80ckNERVcyV3QxZ2V3RGN3L3dxeFpV?=
 =?utf-8?B?SnFPOUZLTXlWeFJWR2luTlg4ZHNSelZHaUxSeTBqaG1KU24rVEhZS1NYeXoy?=
 =?utf-8?B?UXNkRVlPNWxNYW9uUUhvQTBBZnpJbTVKOVZSVzJ4SUVYQ2NUemszNnBnQzN4?=
 =?utf-8?B?TnRYQ3A3Ymhiei8yNndnRFpNYTRRdTFEUU9YVGE4Yzd1KzN1M3dXcWF1enlz?=
 =?utf-8?B?ek90WGlIZ1Nrck9ZQjdzbnNNLzlSZHltZU8vUktiUXNCNWNWeGRzSG42TlQx?=
 =?utf-8?B?YjQwUVRudUtYMW1Nazdabms3Yy8zeUl5ZXRrRFdkZnVkN0FRREV3aDg0SXZ1?=
 =?utf-8?B?bC9aTzNrSXJ6Rjlqc0JEK0MwQ0l1L3dqZWJJd1kxOWpYVTZZZVA3NVo1VUlF?=
 =?utf-8?B?bDhsVlpxSGVuTWd3UWkyTG5RWnJORzB6VzFGeGtWVmZVQVF2OUdqdFFheVda?=
 =?utf-8?B?OXRQc04ybHFWcmNXcVJvdHFCTVRCWUh5RXNrMGZUSFJSc0dIckdOOUVZS0No?=
 =?utf-8?B?UzMwc0FuTWM3M2RvOHBDNUtvZitBQVRlRnV2RzhGeG1kcUhFanNxR2JNcisw?=
 =?utf-8?B?MkxwNmJrak5nclp4MjhyMTdrVEFXRmFDRklXQ296TnkzaDV5VkJFYjRBdGx0?=
 =?utf-8?B?a2xFeVBLeU9iMnlCVC82UGp3WFQxZjJMdHJYVmJlMFdXdEl0RGx2SzdjaWRJ?=
 =?utf-8?B?dklONnl3c3ZNUnRyWFpocCtBYXJvekxYbVA3RldtVitrRkxOSU5Da1hWNWZB?=
 =?utf-8?B?NnFoUkxqZWlyUExkTWRqOHEzbGRDN210Qk8zZHVqMEVHSDNVbFhFclRwMDlt?=
 =?utf-8?B?Qi9UaHN3ejVsWCtQNzdCZE9ydWJreitWRXBoTm5KU1NFaUF2S0VoQURsTEJZ?=
 =?utf-8?Q?lwf77DK91G3K2Qkg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88319636-408e-412b-2f22-08da1ef3c0a2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 15:22:28.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odeVv/LRMjoV6uHulj34Uj4OOBol4GnMImb8aE6wdFPxGnahCec4SDE+3zkIK1IwRBFojlaPhokt1vjp+EgZckX3KAoCS4PapHAPxezOXAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2737
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Haitao,

On 4/15/2022 6:54 AM, Haitao Huang wrote:
> You can also add my Tested-by for patches adding the new IOCTLs.
> Our team and I have tested EAUG on #PF,  modifying types and permissions with Intel SGX SDK/PSW.

Thank you very much.

Based on your description I plan to add your Tested-by to the
following patches:

x86/sgx: Support restricting of enclave page permissions
x86/sgx: Support adding of pages to an initialized enclave
x86/sgx: Support modifying SGX page type
x86/sgx: Support complete page removal

Please let me know if this does not match your expectation.

Reinette
