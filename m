Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0044D73C418
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 00:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjFWW14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFWW1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 18:27:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E164F2D4C;
        Fri, 23 Jun 2023 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687559237; x=1719095237;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d3GxqioHLBKuv8OB6sOgyAepT7JfD7sqbF+dN/KIGN0=;
  b=DmJs+rlvooSY1JrOeY91g1rFllZpOKQwI4xEfxDAayGiY3Lm7/Otk0Tn
   vrAok0RpH4Sr9IzeLXQXiG3MuQAQxV0GrCPdWNmbwrCsL0ft0K2KlH3C7
   w3hvqXDo1usVALHfhFDRNyDYNnd4P+r8Ky7m9dLwb3/fVqcRWuPr195jt
   H0DZCN+hhq3WEVHYk4g898IJuay9iiPxawkWW6iFDVqf5LpBllPl/rEg3
   ycNjskzFrm+XIxqAnikAkzL2gs+JuxmfVrdFweUfl2Jdv/HruX8MbNvcQ
   9yHGMu0IRz97Msfpc4NCAyZnlGEuyrs8+sJrY6gNRuH4qRDwnsirHeLdG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="341219191"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="341219191"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 15:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="860023649"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="860023649"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2023 15:27:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 15:27:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 15:27:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 15:27:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLwNSmx0OeZVKGJ2ttRsR5NOwXORN5eXEpcc40EZ5PamRLWJSWtC1VZmjrNUdVJ84cXWjYr16XeiqAgOibgZT6TdNv692W0qgsuYPlSpHiJSRUfPVA0BzYlLGCoTL+JfNqk8q6+CK0RNLzJ688dannnUsNPS0bxOFReOiUN6gXFjv09tRFu3K58Gq45xI7EGehTdEwPVnsiSJ+3Tg+uSH0DdjVYBqvuma8vH/Wb50w3tlSN6A/pyU8t5yd/yeW/00D+3RYaEqt2/TjW5mq+fCelbemZDKWKzXsrVhcQ3q8CgnC5WT3t3IFvZdpj+bJFuxa+vKGaNCWGH4MGAebqf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGI04IjQSNkyOzHqOXkz3oEt170tLjaAP2C8Q3yfQnk=;
 b=aEp91C56QDDX2afyOnhhMPyyr1iAN4Q9Zr3+DqEyPPD0n8CBV2XKjswh3KwpcgdKGa6fuZr1T4TAVntrXqZN44w51Z87dhX+4YnCu1jOMBXVJNEMLGhwMfMdCwL0+QsICynrWbVZSuGvELJSTT3ZFJXWVH9OM//S2ncCUpo8dReABYOQctGB1qhQTQ39O5ZxXVTn7MaKHOn8G6mmDjn+jZsBqMhwCMWQAzoaB/N3ve/UhBQUlDrnWQaHpf2lNlMTMCK9ODhRIUcGgE7AyM4h7rDl3TtZudVEkKDft13xrSmfqHodjwzvB77+WO3rFBjB46692fCGqVjlCl3i4O32Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 22:27:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Fri, 23 Jun 2023
 22:27:12 +0000
Date:   Fri, 23 Jun 2023 15:27:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
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
        <atishp@rivosinc.com>, <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:303:8f::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: c4240ff9-950d-40db-7caa-08db7438fd07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psyGjmDYJ3Nc0z3tOIkk9zY/tOKB9t+IMYHZwKNEUqdflkPSxEZ2sDxG1AUP49FV2X/WtOLm342sPgzYRZrvTEtbZhlKW97G9ZH05z4+7eG5Y7bDOLOaafBnND65vwe1k0ZaECH9Kftbpq53ppuqIywZKNuvanY+KkkCLj9aKbHnezjqrrwt06zVRCFma5qQTslxKHQDir6cMJm0NWrwucj0Rq8RP9MPNbiGVPDQJyZOWNK4hYZxN7gc9zicBjO+w1RexStXZYcAx/rrj7BUNS/VuL4SFeFWGQEr8vZcbK0y+QlI3Ky09dk9FGBaN5BeBjvm3K7FvvUbAS+eWnTQUOh9k+x15pQI5wQtpif5kB3LTH8I2cufGKFjaVLYm9nRCYAeqlmzXZugn36riO5HMS3KeDS+JKscZUFYXVOXuTWitgL4jZteinUmpTmnSUV0sAc7bcQ/zWs6G+e4cr+iTwEiFqvg/XNSaK5ZPihFW8iRFztLOLTZal4XIICuRukHbS23+v3Z3DLoeTHd+KBWoVm6yep0FeJSYDns0QtovVAwfd//7A9beLrZ8P01mB2snDGxeorvUJW7ugea4FWAv+Lymdra1ga8hg4n8Bm1LvveDAZ6H0/hg14/BfX8pVq5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(82960400001)(38100700002)(86362001)(6666004)(6486002)(8936002)(186003)(9686003)(6512007)(26005)(30864003)(6506007)(316002)(8676002)(5660300002)(7416002)(478600001)(41300700001)(110136005)(66946007)(54906003)(2906002)(66476007)(66556008)(4326008)(83380400001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Qhw2W4KurQrgNMEbz4jOXd6hOv5VyDsh8AzNOSDSJb2lJ+bpwTs0tvWYz8V?=
 =?us-ascii?Q?YprtX5Skc79mJsllTZGpao13Bt1BnF4zlq66KA9z+Pv4DzJvv+86SFZqhU22?=
 =?us-ascii?Q?QmzqqNpqF4/j7kmMKz3XlVZqPucGgVZAOR/CohOV3AmJqUlj2fB9Lm8wbvBU?=
 =?us-ascii?Q?OfIP10xhIbNiMOtOWykvOkJ4V2PtRkZGoExdqlnjJe6AVti0YjTn/K66TyBA?=
 =?us-ascii?Q?739LMcXj3TedsPxx1J85g5tELgpEBZRn1+hKqB4ynSRUhmZ9wsNgFgeoKOrB?=
 =?us-ascii?Q?F0BUmAVqmUeC6YJMU9PfMfVhL07OXR0EJDYxRI/Zz4eoiBHohhpaatQLja6F?=
 =?us-ascii?Q?cF9ui1Kh1rSLTAJN61JD63FjuUPFHFjPMVHfFdKYiJyQsMTLoAQOwFK8WHmi?=
 =?us-ascii?Q?SsiKeyx4azgbcSlpJMOAxcuD8Os0f2SeM2b6EDgMipvkE0+bYanM4sxXVQXQ?=
 =?us-ascii?Q?xcxnDLVFYYMDSlUxmBGGbQtGJcJtwNJdI2+tzMh8NnPXrI9HN1sldExZDABF?=
 =?us-ascii?Q?H9nZZoJ0GSowYy5TxMLXq6ks9CBl6NkJBJP/r4SZCu7bwzcMFpBKv5fCMlMy?=
 =?us-ascii?Q?/V/bnfG5Eop2M0kb4FvU7V4FxokxAfm9Vs32xnKmDDrwETL4iSA4mjE3ZIAq?=
 =?us-ascii?Q?NT1Woo1Tcgp+PuO2yh47FfU1XzxwE8oZIrDwcYWEuWwtzm9Tt3E4Ek5n83H6?=
 =?us-ascii?Q?mBvLf6vWsxh2eFrFtWOIU4oJicfAUAUW7y3CgzNAvqdil3UbSrIiAz/br5kV?=
 =?us-ascii?Q?xkug+mB9VafkHNbMpcDanXTsqHfJPVzDSGecmcq6RHE2JfkJUnhBv+fdeE7W?=
 =?us-ascii?Q?Yg9WoXPi7fMHOfLm2d6BTm6BG/ceocCAvwJERCMLIrY+92/JQAQKm67pLOrk?=
 =?us-ascii?Q?b2cTRiQI3/MWpNvyeuW4va0rhnGgSebEpj0282jeR20ZuV90SiIVdvWbDVXV?=
 =?us-ascii?Q?Xm4LXG2hHNaN6BxbQiCEMWrBnUMINTADjM8jqQ9DttCKGDoahvP8msjuyU17?=
 =?us-ascii?Q?JAk/QmpEZhx27DtfrXypAXnnsCZSvrWciIDBPr3iGphKJ7ZRDPZZRwVt0Oqp?=
 =?us-ascii?Q?oNCe3rX8r4B4ZhkfMYg/hHDD4pjGgDdrgVc55ZMytj9tFDxcKE69QYHrVBRk?=
 =?us-ascii?Q?lAaIHTCzPwkUyh8o8pQxvjRskUthMh6loQ86W9I+kRsfqXrIWKyaMRnAxBIZ?=
 =?us-ascii?Q?vakGwB5nJWgOcyamxAo2k2Lj4Z+T+ydQOf4XQCNI5X3UVXVGVgDmGXQlkmmK?=
 =?us-ascii?Q?4LgWuZDOmLNxsMNItLZZ741oFU9sXijfO2Yo/qc1Vo6k+zgbUfptOVrEsH5z?=
 =?us-ascii?Q?UFVa9yo74wn27bJLZr6j7GmfDiWxixIKDnWZ7aSKN4rDWEzZgAuDBl2Si350?=
 =?us-ascii?Q?p9ZpVRdKOWyRccvyqUDs0Wm3H0xiSjCPB6nP6K4hYXOJ421TbtH8wKHm9x5V?=
 =?us-ascii?Q?uKX63DoVUokTbMeWanUv3KWlOnmSUuutokiUPb+QinqAVQMWleP/+YNPWA8O?=
 =?us-ascii?Q?qxXLUKxbbu/KnNbhVkXxT9MkizLAZe/LV67Ezh9T7jznmnoHEBu8NRqZNVkf?=
 =?us-ascii?Q?6OrjkxGx2PuLsmxKQupwhPF4h0TgQtMwaZxl6lW5oRsodp3YUeq4YPZiWOTh?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4240ff9-950d-40db-7caa-08db7438fd07
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 22:27:11.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiJITitv+fQQtWO22o6HGT6gkpQaMN0ZjPFQSC9xY6cPqYaW876GKmeiZCWngJw8U9fXVfFyQbcJL18z3SXeLtP2CZIui9b2nyRsQQZRTOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dan Williams wrote:
> [ add David, Brijesh, and Atish]
> 
> Kuppuswamy Sathyanarayanan wrote:
> > In TDX guest, the second stage of the attestation process is Quote
> > generation. This process is required to convert the locally generated
> > TDREPORT into a remotely verifiable Quote. It involves sending the
> > TDREPORT data to a Quoting Enclave (QE) which will verify the
> > integrity of the TDREPORT and sign it with an attestation key.
> > 
> > Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
> > allow the user agent to get the TD Quote.
> > 
> > Add a kernel selftest module to verify the Quote generation feature.
> > 
> > TD Quote generation involves following steps:
> > 
> > * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
> > * Embed the TDREPORT data in quote buffer and request for quote
> >   generation via TDX_CMD_GET_QUOTE IOCTL request.
> > * Upon completion of the GetQuote request, check for non zero value
> >   in the status field of Quote header to make sure the generated
> >   quote is valid.
> 
> What this cover letter does not say is that this is adding another
> instance of the similar pattern as SNP_GET_REPORT.
> 
> Linux is best served when multiple vendors trying to do similar
> operations are brought together behind a common ABI. We see this in the
> history of wrangling SCSI vendors behind common interfaces. Now multiple
> confidential computing vendors trying to develop similar flows with
> differentiated formats where that differentiation need not leak over the
> ABI boundary.
[..]

Below is a rough mock up of this approach to demonstrate the direction.
Again, the goal is to define an ABI that can support any vendor's
arch-specific attestation method and key provisioning flows without
leaking vendor-specific details, or confidential material over the
user/kernel ABI.

The observation is that there are a sufficient number of attestation
flows available to review where Linux can define a superset ABI to
contain them all. The other observation is that the implementations have
features that may cross-polinate over time. For example the SEV
privelege level consideration ("vmpl"), and the TDX RTMR (think TPM
PCRs) mechanisms address generic Confidential Computing use cases.

Vendor specific ioctls for all of this feels like surrender when Linux
already has the keys subsystem which has plenty of degrees of freedom
for tracking blobs with signatures and using those blobs to instantiate
other blobs. It already serves as the ABI wrapping various TPM
implementations and marshaling keys for storage encryption and other use
cases that intersect Confidential Computing.

The benefit of deprecating vendor-specific abstraction layers in
userspace is secondary. The primary benefit is collaboration. It enables
kernel developers from various architectures to collaborate on common
infrastructure. If, referring back to my previous example, SEV adopts an
RTMR-like mechanism and TDX adopts a vmpl-like mechanism it would be
unfortunate if those efforts were siloed, duplicated, and needlessly
differentiated to userspace. So while there are arguably a manageable
number of basic arch attestation methods the planned expansion of those
to build incremental functionality is where I believe we, as a
community, will be glad that we invested in a "Linux format" for all of
this.

An example, to show what the strawman patch below enables: (req_key is
the sample program from "man 2 request_key")

# ./req_key guest_attest guest_attest:0:0-$desc $(cat user_data | base64)
Key ID is 10e2f3a7
# keyctl pipe 0x10e2f3a7 | hexdump -C
00000000  54 44 58 20 47 65 6e 65  72 61 74 65 64 20 51 75  |TDX Generated Qu|
00000010  6f 74 65 00 00 00 00 00  00 00 00 00 00 00 00 00  |ote.............|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00004000

This is the kernel instantiating a TDX Quote without the TDREPORT
implementation detail ever leaving the kernel. Now, this is only the
top-half of what is needed. The missing bottom half takes that material
and uses it to instantiate derived key material like the storage
decryption key internal to the kernel. See "The Process" in
Documentation/security/keys/request-key.rst for how the Keys subsystem
handles the "keys for keys" use case.

---
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index f79ab13a5c28..0f775847028e 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -54,4 +54,8 @@ source "drivers/virt/coco/sev-guest/Kconfig"
 
 source "drivers/virt/coco/tdx-guest/Kconfig"
 
+config GUEST_ATTEST
+	tristate
+	select KEYS
+
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index e9aa6fc96fab..66f6b838f8f4 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
+obj-$(CONFIG_GUEST_ATTEST)	+= coco/guest-attest/
diff --git a/drivers/virt/coco/guest-attest/Makefile b/drivers/virt/coco/guest-attest/Makefile
new file mode 100644
index 000000000000..5581c5a27588
--- /dev/null
+++ b/drivers/virt/coco/guest-attest/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_GUEST_ATTEST) += guest_attest.o
+guest_attest-y := key.o
diff --git a/drivers/virt/coco/guest-attest/key.c b/drivers/virt/coco/guest-attest/key.c
new file mode 100644
index 000000000000..2a494b6dd7a7
--- /dev/null
+++ b/drivers/virt/coco/guest-attest/key.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/seq_file.h>
+#include <linux/key-type.h>
+#include <linux/module.h>
+#include <linux/base64.h>
+
+#include <keys/request_key_auth-type.h>
+#include <keys/user-type.h>
+
+#include "guest-attest.h"
+
+static LIST_HEAD(guest_attest_list);
+static DECLARE_RWSEM(guest_attest_rwsem);
+
+static struct guest_attest_ops *fetch_ops(void)
+{
+	return list_first_entry_or_null(&guest_attest_list,
+					struct guest_attest_ops, list);
+}
+
+static struct guest_attest_ops *get_ops(void)
+{
+	down_read(&guest_attest_rwsem);
+	return fetch_ops();
+}
+
+static void put_ops(void)
+{
+	up_read(&guest_attest_rwsem);
+}
+
+int register_guest_attest_ops(struct guest_attest_ops *ops)
+{
+	struct guest_attest_ops *conflict;
+	int rc;
+
+	down_write(&guest_attest_rwsem);
+	conflict = fetch_ops();
+	if (conflict) {
+		pr_err("\"%s\" ops already registered\n", conflict->name);
+		rc = -EEXIST;
+		goto out;
+	}
+	list_add(&ops->list, &guest_attest_list);
+	try_module_get(ops->module);
+	rc = 0;
+out:
+	up_write(&guest_attest_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(register_guest_attest_ops);
+
+void unregister_guest_attest_ops(struct guest_attest_ops *ops)
+{
+	down_write(&guest_attest_rwsem);
+	list_del(&ops->list);
+	up_write(&guest_attest_rwsem);
+	module_put(ops->module);
+}
+EXPORT_SYMBOL_GPL(unregister_guest_attest_ops);
+
+static int __guest_attest_request_key(struct key *key, int level,
+				      struct key *dest_keyring,
+				      const char *callout_info, int callout_len,
+				      struct key *authkey)
+{
+	struct guest_attest_ops *ops;
+	void *payload = NULL;
+	int rc, payload_len;
+
+	ops = get_ops();
+	if (!ops)
+		return -ENOKEY;
+
+	payload = kzalloc(max(GUEST_ATTEST_DATALEN, callout_len), GFP_KERNEL);
+	if (!payload) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	payload_len = base64_decode(callout_info, callout_len, payload);
+	if (payload_len < 0 || payload_len > GUEST_ATTEST_DATALEN) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	rc = ops->request_attest(key, level, dest_keyring, payload, payload_len,
+				 authkey);
+out:
+	kfree(payload);
+	put_ops();
+	return rc;
+}
+
+static int guest_attest_request_key(struct key *authkey, void *data)
+{
+	struct request_key_auth *rka = get_request_key_auth(authkey);
+	struct key *key = rka->target_key;
+	unsigned long long id;
+	int rc, level;
+
+	pr_debug("desc: %s op: %s callout: %s\n", key->description, rka->op,
+		 rka->callout_info ? (char *)rka->callout_info : "\"none\"");
+
+	if (sscanf(key->description, "guest_attest:%d:%llu", &level, &id) != 2)
+		return -EINVAL;
+
+	if (!rka->callout_info) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	rc = __guest_attest_request_key(key, level, rka->dest_keyring,
+					rka->callout_info, rka->callout_len,
+					authkey);
+out:
+	complete_request_key(authkey, rc);
+	return rc;
+}
+
+static int guest_attest_vet_description(const char *desc)
+{
+	unsigned long long id;
+	int level;
+
+	if (sscanf(desc, "guest_attest:%d:%llu", &level, &id) != 2)
+		return -EINVAL;
+	return 0;
+}
+
+static struct key_type key_type_guest_attest = {
+	.name = "guest_attest",
+	.preparse = user_preparse,
+	.free_preparse = user_free_preparse,
+	.instantiate = generic_key_instantiate,
+	.revoke = user_revoke,
+	.destroy = user_destroy,
+	.describe = user_describe,
+	.read = user_read,
+	.vet_description = guest_attest_vet_description,
+	.request_key = guest_attest_request_key,
+};
+
+static int __init guest_attest_init(void)
+{
+	return register_key_type(&key_type_guest_attest);
+}
+
+static void __exit guest_attest_exit(void)
+{
+	unregister_key_type(&key_type_guest_attest);
+}
+
+module_init(guest_attest_init);
+module_exit(guest_attest_exit);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
index 14246fc2fb02..9a1ec85369fe 100644
--- a/drivers/virt/coco/tdx-guest/Kconfig
+++ b/drivers/virt/coco/tdx-guest/Kconfig
@@ -1,6 +1,7 @@
 config TDX_GUEST_DRIVER
 	tristate "TDX Guest driver"
 	depends on INTEL_TDX_GUEST
+	select GUEST_ATTEST
 	help
 	  The driver provides userspace interface to communicate with
 	  the TDX module to request the TDX guest details like attestation
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 388491fa63a1..65b5aab284d9 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -13,11 +13,13 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/set_memory.h>
+#include <linux/key-type.h>
 
 #include <uapi/linux/tdx-guest.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/tdx.h>
+#include "../guest-attest/guest-attest.h"
 
 /*
  * Intel's SGX QE implementation generally uses Quote size less
@@ -229,6 +231,62 @@ static const struct x86_cpu_id tdx_guest_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
 
+static int tdx_request_attest(struct key *key, int level,
+			      struct key *dest_keyring, void *payload,
+			      int payload_len, struct key *authkey)
+{
+	u8 *tdreport;
+	long ret;
+
+	tdreport = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
+	if (!tdreport)
+		return -ENOMEM;
+
+	/* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
+	ret = tdx_mcall_get_report0(payload, tdreport);
+	if (ret)
+		goto out;
+
+	mutex_lock(&quote_lock);
+
+	memset(qentry->buf, 0, qentry->buf_len);
+	reinit_completion(&qentry->compl);
+	qentry->valid = true;
+
+	/* Submit GetQuote Request using GetQuote hyperetall */
+	ret = tdx_hcall_get_quote(qentry->buf, qentry->buf_len);
+	if (ret) {
+		pr_err("GetQuote hyperetall failed, status:%lx\n", ret);
+		ret = -EIO;
+		goto quote_failed;
+	}
+
+	/*
+	 * Although the GHCI specification does not state explicitly that
+	 * the VMM must not wait indefinitely for the Quote request to be
+	 * completed, a sane VMM should always notify the guest after a
+	 * certain time, regardless of whether the Quote generation is
+	 * successful or not.  For now just assume the VMM will do so.
+	 */
+	wait_for_completion(&qentry->compl);
+
+	ret = key_instantiate_and_link(key, qentry->buf, qentry->buf_len,
+				       dest_keyring, authkey);
+
+quote_failed:
+	qentry->valid = false;
+	mutex_unlock(&quote_lock);
+out:
+	kfree(tdreport);
+	return ret;
+}
+
+static struct guest_attest_ops tdx_attest_ops = {
+	.name = KBUILD_MODNAME,
+	.module = THIS_MODULE,
+	.request_attest = tdx_request_attest,
+};
+
 static int __init tdx_guest_init(void)
 {
 	int ret;
@@ -251,8 +309,14 @@ static int __init tdx_guest_init(void)
 	if (ret)
 		goto free_quote;
 
+	ret = register_guest_attest_ops(&tdx_attest_ops);
+	if (ret)
+		goto free_irq;
+
 	return 0;
 
+free_irq:
+	tdx_unregister_event_irq_cb(quote_cb_handler, qentry);
 free_quote:
 	free_quote_entry(qentry);
 free_misc:
@@ -264,6 +328,7 @@ module_init(tdx_guest_init);
 
 static void __exit tdx_guest_exit(void)
 {
+	unregister_guest_attest_ops(&tdx_attest_ops);
 	tdx_unregister_event_irq_cb(quote_cb_handler, qentry);
 	free_quote_entry(qentry);
 	misc_deregister(&tdx_misc_dev);
