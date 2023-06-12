Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E6672CEE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbjFLTDe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 15:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjFLTDd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 15:03:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262EAD;
        Mon, 12 Jun 2023 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686596612; x=1718132612;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jWbJRWFg4ljIaTwK/HUWBT7d253Zb1hXl+DtdnjIzCg=;
  b=PowSFfEZEoT0E/ipVHCNh1buc2i1u32OZlutO/IIdj1zFtuK5NKJ8t0Q
   6Hjwi6PtxAyPNjhYHK+bVdzFjiZvXh7yFQKWyDZ+oGHzU9Lvc1UOQhRKa
   ZGxkVyLpYvbDsrCUbAdIuVJE0n9lua/NKbRieeQK/v8rxIG0GhElh7tQs
   e7XVus+d38fJqwk4eRDhalpXeWgY0aPrIFLd2vrSr6GTXTkwrK54iotIu
   yucD2kPsRsRiw6wY/nPNBphIDU259rkF/5y+ehNKN0Y6xJQfXP7FXPACn
   WufGkAnPGH7r8x2YZubNv14NPypBmW+EkbsZIHjJ6IqE8wv8rp5yUaFuS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342822139"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="342822139"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 12:03:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="801127943"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="801127943"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2023 12:03:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 12:03:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 12:03:30 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 12:03:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAyZiDPnO5xOyYRlaqPmssheiAa344Za0+S8oG+7XlP9DSflb2zQ6Li491RBEUNoEzIyOVwVE+wSzlFZ9idfd0v7ZSiW+jprCSyo8h38V2E4Tc+ZCVueq361UyaRkgTZuPWTt/9sK7SFLuhko4Cp7WpPwsua0hUtZngqVHavc2OGEX7384FvCl/3381tDMTYvo023ypS3Nd94IsRivYsbuExKthZAEAfQrrZfwM0SWFv67zLvjz2kOH7AR640/v8I3YcYzpsA4h7+/wjLiyyNT9MqMGr62+bEIyT9h29n9ThyRO1tHe5aaWTfU6ilc47S7y6KQS7dp90+yBztX7IJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EOrSDdB9FJEDAo5xrAgvOV9SgyvM5Nm7M/vDvlTzA8=;
 b=XxSDgHgSjzlxEdbXd4CT9HVM3W7DGE7BRib/lJkYd88lFwKHz3N79u4MjTDo7HApSVTV3y74s5Kst1brEEkl8JmV7oPVMCFpEdKZwpiF3DOM6EuTAT05VCrv6kzqOgsh8TwDAVVLO3an5vI4flpTuWCyqf2p9wZsKcM4y7LPmWZPTtmdZVRjATuqXEofjUBDfU3pHRL+V3HTYKsWfxUzbfw7aU75uxFoUQWfTe/tm63eYGPmY07sddRmcD90i42IrHuNSNLlL/jPt7x5Rfx6BI73/uHyB3YJuspPsALQG3NuTaU9lU4TKftMn1Sx7HHQHkuhzSrqtOG0o636TX84WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5607.namprd11.prod.outlook.com (2603:10b6:8:28::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 19:03:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 19:03:22 +0000
Date:   Mon, 12 Jun 2023 12:03:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Wander Lairson Costa" <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        "Du Fan" <fan.du@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <dhowells@redhat.com>, <brijesh.singh@amd.com>,
        <atishp@rivosinc.com>
Subject: RE: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: SJ2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a03:505::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a94278c-e999-4fd5-bfdb-08db6b77b111
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aSOYcgTlyVZM1bc5AayzDuxTniJ8GdV3BXZO6iAXIgFl0rw3SjTiPTfDYwaok9Ley+yWlliGJ07qA61lcbRlAmbvOF2da8fXMFmIlBu+QiMpE83sL/dHsY/zSvgATCE+Lpms2R2IHqvKK7VrbP/j41q2JqzrlNe3DE91AGvj2saOiOcJe2mNman+FPfzKsP+v8Hb63B4wr9LcraZVtVQhl3/CzZfS+48/Y278E73ZS7QXxHlXs8F22z4vX1AvsUVCFEZBUfBS+LboSgavUDEMuZ3aqjto9XwLjkjWKjLhqcfSXPZmIrxF3qR7gW3rUZK5eE7DJ9KndMcR4IMtIfEuh2yeXjCPOvvmj/BILeUQGN1+8sMzyoOmw3vX478qTzRHh5F6kXNVmev0342rqBbhIewbJT4mxYSK8JQgYjUDiOaAeYbBVWsIMmVjuhc7qo+qk1tp8VPiHNnXoVr9WtFn/PfVQW/PruWRV8lYFzcSvWCIdMsygjx/CUqFMO/kUrFrOOz+AQzSMguU7dc2YTHasWan+J6kkyX+ueURiPmICgSIt/UonM1Sg+S1Uh8SdX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(66476007)(66556008)(4326008)(316002)(7416002)(41300700001)(186003)(2906002)(110136005)(54906003)(478600001)(66946007)(8676002)(8936002)(5660300002)(6666004)(6486002)(6512007)(6506007)(26005)(83380400001)(9686003)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdK4XvzzGpS6MBdlNBbBU4nI0Jcos1dzVEzfEpjiPXJhVuYOd2bUZrdwfiDu?=
 =?us-ascii?Q?lzdTcQuOwOaHoBF5kyn62peS0gxvb+3AKfXj2AusifwoW1J4KHdoIQDoWdTv?=
 =?us-ascii?Q?cDf6b3IZk1DiUh1IoC2lD4PBJXvFIFajNS2jTL7r6rOdTRklRfg1KHDjkw0G?=
 =?us-ascii?Q?vsZg2wgKsCowjQP3wtN7RqvUyiady8AEcubq85O7I4eCo4rAYvH7p3eThKTw?=
 =?us-ascii?Q?Tu+FguU3Qh58smzLo6E2FAqpxAbrkQ0W1P/IVAYMy0bdEhK2a4kiknYRiFuj?=
 =?us-ascii?Q?Jx5ZEyq0xPUYxo9B1ZUOaiko6za5bL1Pi+Hdvv8XpO/ogJSCqpE6mV2dsl4z?=
 =?us-ascii?Q?092G01FXBYan0JZHebQGcU9dfViwBnD/zf7Evm8rToQGRdtL0fwfxzWxXu5G?=
 =?us-ascii?Q?wity90cWcErkDIEmuoU11tJxNSxNT1NZ6XOQq1R358lY+G9Ua8uAfpnuLknG?=
 =?us-ascii?Q?sdvGn6cBCh/+j2mAs9ui97FoRh+nC9HpI1mrKj0XNTRsSWnaWxJ08UvyTpQs?=
 =?us-ascii?Q?FIu3LNRI43oYxHvWvPdkQveE3LlWNeob3ID3SuaKKqCACMu1y6umE52SlJst?=
 =?us-ascii?Q?HwuF+0cHcIz29a9+9xpeoFCYW9dKQGaUBvKfp/R4oGpXUcF8HSg9G+ZIl0nW?=
 =?us-ascii?Q?OV3wSjZ9TcRhdQJWsW9dwoxJ1xHsCMryB8qourcIo+2gwhkX5Hep7qWc0e03?=
 =?us-ascii?Q?BgE6YkkvkQbo17uaNHCshwudENtSiwb+aWw6C0iUUtJllUjjWzHtIg916LSK?=
 =?us-ascii?Q?aLvrrtXLp1QzFgMvEj4DDXkQah9hG1qh2aBCglDq4pLn+MOuL06b+Q5SvUYt?=
 =?us-ascii?Q?b4bfsABujkysVnBLRpsIpJUJzpvKd00gBKbPHXTf8rrC+0Uxe/L6Np2gyOdy?=
 =?us-ascii?Q?VM9nZlg7ljemp04+fEz6Lsc7FKa+sFrLI91aX0YUIaQGq7V7Ye9jhDElzHs6?=
 =?us-ascii?Q?AL6aM9pgyYOEdDZ0IjVpbbnDO12gWTSp7ygE36sf87wjHpHcjfAkLoZlNGT+?=
 =?us-ascii?Q?4Csp7Hltb//cWJEqa3FHUmr87qFWTsSp/gVqTVIX7ZsrdtdcEboxK6MvBF76?=
 =?us-ascii?Q?SHIQF2KB+nRYwXYnuCh/zlSAasELOwcqEjG/a6KThKL4XYpYBSHZ4vlZDiZj?=
 =?us-ascii?Q?Wbngripw0qgM/LP2jWo2k82TfJT7ZNNNvF4GlCisPuwK0kUkHVHjNBhWhuEN?=
 =?us-ascii?Q?bZ7vtkmBHNHlvEQCj5rNia3LXaHgS7z4HCuQL0lxz4132IGoe0NB3EGWEVUD?=
 =?us-ascii?Q?eVyzxp2oE2W7xWrK5V1toNqznhLwobRnLZXHrPGYE5kxwhPWJl/WouRPqhZj?=
 =?us-ascii?Q?+8WZzYJIKT2/iBC6AKpgu4ICh7z6qz8T49ZZ1l1gkTVhf2VwJTTE6BIuJoUm?=
 =?us-ascii?Q?j8FEHuVtT3FGgXs5r1kfPO7LNwGufJ5orGS+zOjMDtg57BDzd9otdcCRyMY8?=
 =?us-ascii?Q?3nn/9HjsivY64zeXMoakNQFla+d5Qal4WEjUZ28Bbs48yWmc+oCU8Dl7qrg9?=
 =?us-ascii?Q?HqH1OlCJ3OY0yS7z7ZVB14qW/sF4p5IWrN7Awzmq9TUjwhPPZtnkdDF5MxyZ?=
 =?us-ascii?Q?wjq79ydFKOGvwuRK9Y73bdikDG2igx3A6qScJ/G+PEeKEkg6yOeYnv1OGdTj?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a94278c-e999-4fd5-bfdb-08db6b77b111
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 19:03:22.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX83VqSc2ksN4kHbAo9ik6hqLpOJfT2W3N5UBgtvVyZcTCQT75d09V+737vm4PZRGKGc9es1i2ctUD7dGeMSY5xOzh+omIbeZpgQBOApifo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5607
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ add David, Brijesh, and Atish]

Kuppuswamy Sathyanarayanan wrote:
> In TDX guest, the second stage of the attestation process is Quote
> generation. This process is required to convert the locally generated
> TDREPORT into a remotely verifiable Quote. It involves sending the
> TDREPORT data to a Quoting Enclave (QE) which will verify the
> integrity of the TDREPORT and sign it with an attestation key.
> 
> Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
> allow the user agent to get the TD Quote.
> 
> Add a kernel selftest module to verify the Quote generation feature.
> 
> TD Quote generation involves following steps:
> 
> * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
> * Embed the TDREPORT data in quote buffer and request for quote
>   generation via TDX_CMD_GET_QUOTE IOCTL request.
> * Upon completion of the GetQuote request, check for non zero value
>   in the status field of Quote header to make sure the generated
>   quote is valid.

What this cover letter does not say is that this is adding another
instance of the similar pattern as SNP_GET_REPORT.

Linux is best served when multiple vendors trying to do similar
operations are brought together behind a common ABI. We see this in the
history of wrangling SCSI vendors behind common interfaces. Now multiple
confidential computing vendors trying to develop similar flows with
differentiated formats where that differentiation need not leak over the
ABI boundary.

My observation of SNP_GET_REPORT and TDX_CMD_GET_REPORT is that they are
both passing blobs across the user/kernel and platform/kernel boundary
for the purposes of unlocking other resources. To me that is a flow that
the Keys subsystem has infrastructure to handle. It has the concept of
upcalls and asynchronous population of blobs by handles and mechanisms
to protect and cache those communications. Linux / the Keys subsystem
could benefit from the enhancements it would need to cover these 2
cases. Specifically, the benefit that when ARM and RISC-V arrive with
similar communications with platform TSMs (Trusted Security Module) they
can build upon the same infrastructure.

David, am I reaching with that association? My strawman mapping of
TDX_CMD_GET_QUOTE to request_key() is something like:

request_key(coco_quote, "description", "<uuencoded tdreport>")

Where this is a common key_type for all vendors, but the description and
arguments have room for vendor differentiation when doing the upcall to
the platform TSM, but userspace never needs to contend with the
different vendor formats, that is all handled internally to the kernel.

At this point I am just looking for confirmation that the "every vendor
invent a new character device + ioctl" does not scale and a deeper
conversation is needed. Keys is a plausible solution to that ABI
proliferation problem.
