Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350E773D39E
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 22:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjFYUV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 16:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFYUV2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 16:21:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E01F1AD;
        Sun, 25 Jun 2023 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687724487; x=1719260487;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jVhDo+zSWzirW9WixWokd9tRzikAdDjtGJnmZ+loUrg=;
  b=gTPFaDwozrohkBDsjj/Z+dzPLTBywmLUc7nKNWSB91zfPV7/rePjUoEe
   KpwnQGAg12PZkLwMVCb/FJadcGNClb7fEtWnvFO0AsWXljPUvEbTOFcni
   NPbZDMc5vpMI5SFNryi6vWFfx5/X3KXp4rHCojGsBZgSWG7aLfwFaNhSM
   QRuY0KlAMgKUqlJV1X3ptANFe93IZq6n1nCGMj2Jm6nJa4R3Z7qzAAog0
   L6GyqZ2ugJHwoFDKLKfl1y9PsfXqXqjiuNfBedrn8sM6RQSLe/G2fwxHN
   Mw4zZRLshjFw49pUgHKYO/HWE7No0IDkYj+fy7AYjkKvB2YXbdCoYRSEK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="341453522"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="341453522"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 13:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="840056387"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="840056387"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2023 13:21:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 13:21:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 13:21:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 13:21:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtaFJWMsXIL3YpkylBXXHgqWZ9npKJnV9+UtTP3xH2uMNlHyhSqUXl66pUmc3oUSlLomMCh5OFgfC1x2AssUJmDYtEsJXTRCTAPRruEe+0BJQRMyU0eXzwneOYpss/vUQnbxDE+4dJRL+X2234PYrAiJ2T+D4ZeOyMVlUbP/KbL+UCdvtc2NIvW2kti1C7CEqjAiIpWQSAsGHgQ89pD6ny2bYEpuXCKuD2PaGTKxR6z8kcAtveCzGmjEDhJYFIgIVLxUFl0XXxm8nuGClc8zvmU5epwoMWMUQQUgSe2bLkS39gMVdV43iTnGOUwv7W5U1KxxvUso0Xz9WoJQ7b3Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuarbbyn1Ul0GHEKEHdEAkMNpo1gBdhE2c0CCnINCIw=;
 b=PGNu8BwYgDHg5tMlYneOdeoT6Y1M1w6VrG+EzVBCmko+LmewX46FaCFA+c64l1ba0F3lNoOeHxOJrWbuSQ1uu60AuVd/+sY33NySlV0OXFBOhGlbBBJgQa0Kkkiskjxww0lgD+8BKNGbZsRDdyZqpLHjoAPXLXqbUt2dh3tNC7Zu/fzcMwqGVDKeAqnVrciwU0WjtDf4topN7IkZRl71ROAE4QyVDctmyrPRxmOcwO8d9T38Fy1o2X9E6ayaohZT5mnDNcGWugAqbqZGDgUrFEY4qK0qcJ4fHsV2U7sEjRfyV+RvjI1eD3iYYPfsr2RFd9V5xQJTwNyrDQs/qaz9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6143.namprd11.prod.outlook.com (2603:10b6:8:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 20:21:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 20:21:22 +0000
Date:   Sun, 25 Jun 2023 13:21:17 -0700
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
        <gregkh@linuxfoundation.org>, <dhowells@redhat.com>
Subject: RE: [PATCH v3 0/3] TDX Guest Quote generation support
Message-ID: <6498a1bdc1db9_1dff294b2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64966b842becf_142af8294a5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64966b842becf_142af8294a5@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef015b8-5abc-4c31-8d28-08db75b9bdbc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKjh/QEtuqUCJmcaInxoQmSuH3XeJ58TO2l1B4ctex8Ig505lx9+AIQFhG08dHadp3skB9wiN+4dHnQ6DPP4GwNfUyzUOZaH2arTJqpH/wig4ecG+0yJ08sTIR6iOOaPR3+U3FYpEtRorClPINnjmXH6JwNl3zicF2GdOJX2DXvQE6k75DoRQV4zjQ5bvI4J1pL09IT+ZPlSR+O9PnN4ZDh0KEq0bHFKBtHR/rTlIJCI7b3iSgcFiAl+aO1wU2yJ5EvhWqlpRLF6gqR8PQMfO7zO90ZFwRc27GAFIK0QlNFh/Lz8Ng2FQCyrmbNTWaXQrulQYo108Kq4qXhbdR2yAUhRP4W7eg/odDH+ic2WEvJ23AgRoSr0//V7wCa8Tj4PggHiBEqmdPjdIjxwVG0qsvwkPSk1RjS15so07mqsxc4pvdZIH3RFYfpJsRlTJind6xRgg7vUk++Rju1n1NcB7SoByQhdZ6qrg/1xbCk+U6tq9/uNgQ+dp1BWROg08NfZlXoh10DWLmBhDMuVVobl1iEZlQz4R01Y0TZeq5GKVrp/k70naLy9lm2ppPp8h5/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199021)(66899021)(5660300002)(7416002)(86362001)(8936002)(8676002)(41300700001)(66476007)(66556008)(4326008)(38100700002)(316002)(66946007)(82960400001)(9686003)(6506007)(26005)(6512007)(2906002)(186003)(6666004)(6486002)(478600001)(110136005)(83380400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qXTJmaJuxqO4kBhE9SNxXcS3x2ImOhJ/TrYq/0U+WUSTgSH+30/0QLoleqQu?=
 =?us-ascii?Q?8omBajZ/Ok5dqdgP1sIzOUEFDVn9PoyviKz5Abogfs3hEhAzKFF8CLw8MFCR?=
 =?us-ascii?Q?s5zs/fuBMVptbqkNhRdLLWp2xJCzpHFZz5WNm0cq3Wa5b3P9f/4cQesaMMku?=
 =?us-ascii?Q?L/VbrhCdOy7rDtPd2rqDAWpgjbyQRmbp4K386pbqdqa3LsiDOsdUrLVhwXCl?=
 =?us-ascii?Q?jGQIsHxr/kWeaS81OmhxCfbCVA0EKEiXNNxaKVPYdb95KiYe00zFPeEOISLs?=
 =?us-ascii?Q?fxsBqU8BEVMBd3SViT23QeVbWLF8jw0VDXscd0STMw9uQzIxsNjwTMGXh7bu?=
 =?us-ascii?Q?4l0W3IYozsjg+dKT/3UQRomZrdNFtyCOVPWyt964Tiu3M1UBi6bbWxYelWbz?=
 =?us-ascii?Q?uFP2Z8BjbRSU5u97riO27blGSDCo2FGkff1ZX+9f2b4SXj+7Oo5GIMQ96zLq?=
 =?us-ascii?Q?6GArfIhXYK0Rgv/ks0UHztIZJ8StK7ulX0yl0xJy6mo0UQkGWI8riV+zdycH?=
 =?us-ascii?Q?+w7ffjC9XpGr0SrvrG5AFMCxMHVrBISV4DYZ53drjsDjUHscUfcBfrGq4qho?=
 =?us-ascii?Q?K32aj+uV2nShcYJo2ADdVe1SWMLb7B3iZhQNnsPjOivCKIZzpN9cNAjd7Kde?=
 =?us-ascii?Q?lfwkIkyWF3gjrRydlBwIxP8qsww62dLQVCye+hhbiLhs2WkMZh4Z7v+Esznb?=
 =?us-ascii?Q?q1RyrNbB6TN+3Ogf1R8wS6y0FtkUyVyE8tYMs9jgYhLD8B3bvV1WSRTjDkYb?=
 =?us-ascii?Q?Xd1Jbc63tmuYq5b+rmL3zLdOueKA8pb05jCjbGXNTnvLhqa6H8JJfn+1iQio?=
 =?us-ascii?Q?r5xRn0ib6beNqTpMo5Thnb5VElwMBZzTle31KeOJSyssWQySqNZuay2zzRnF?=
 =?us-ascii?Q?Z8LgJmdJmw4rnfnwnfygxKWEgFkDduXqooPTa4QaathR1mof0/NXURzxl9zV?=
 =?us-ascii?Q?3IYHls40rHma6SrfNjuwpOvDXlRoHU99u0OeIHtNddb0/YHqjTlKfQB4Mmou?=
 =?us-ascii?Q?hil8Qh13P6jRdZDZmhVDyEYUTB+KfBiRY54g2bPCe6Jq680TZOKhTI1QuiJX?=
 =?us-ascii?Q?ALP4NyN+6SSA1ZGDYqriHiAOHWFS1KjwVpVXJu3oykR5DZAvt0XiRMDljGIu?=
 =?us-ascii?Q?eo9KZv+hkKBJwMtQfgQRXjqRxaHBoi4v458YGWMC++Yx8hrZApRbNUkGlu7p?=
 =?us-ascii?Q?LK6X+d64qi2/s1Sd9LgST+VLSzMczKNZ4Q3IbAot1TJGjahNJOTv1/4WVkbY?=
 =?us-ascii?Q?AByZyBSXerXCDEwoqVFuJqV9Cp65Yax/Hne+g67ojkPfeLmgB6EQBPyowEHA?=
 =?us-ascii?Q?w7SLCflKBEz/6AhtY3/iSLfNg17UlkkGJ/8rIF2ZR1h5CfY8poDY+SMWy8QX?=
 =?us-ascii?Q?6SHgRcc6TP9mYbsDVKmlfzM8SbpawvFGTk1t+0VH5JerWpms6Z6wlNhROCr+?=
 =?us-ascii?Q?JoUtCPLjwlYJyx88b5Jbqn/eVJT3pB/WCr8o1Zzul/nswvIlcjJIrZxUk+i5?=
 =?us-ascii?Q?dXzaANijF0Ls80GnATvBTeVv8Xqu4mAKZt+PIiLZmxFEfFVd/djCGoJocPWZ?=
 =?us-ascii?Q?SMTc4TAVV5vk+H6HRCp+Xt+piW5lcxnvrUHHD5zZPg0iJ/pQ0EhTg0cArfB5?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef015b8-5abc-4c31-8d28-08db75b9bdbc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 20:21:21.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBt3al9eUKyG1pNVv3Tj846HtjS+/Cx5V/PDkVXd/TCJHvZfwB4/sXXL9l4kbxkiFNHNLEvdUZEz4+YkfvhyMUv3P1fO9+8bVIMDJvCPdbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6143
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dan Williams wrote:
> Kuppuswamy Sathyanarayanan wrote:
> > Hi All,
> > 
> > In TDX guest, the attestation process is used to verify the TDX guest
> > trustworthiness to other entities before provisioning secrets to the
> > guest.
> > 
> > The TDX guest attestation process consists of two steps:
> > 
> > 1. TDREPORT generation
> > 2. Quote generation.
> > 
> > The First step (TDREPORT generation) involves getting the TDX guest
> > measurement data in the format of TDREPORT which is further used to
> > validate the authenticity of the TDX guest. The second step involves
> > sending the TDREPORT to a Quoting Enclave (QE) server to generate a
> > remotely verifiable Quote. TDREPORT by design can only be verified on
> > the local platform. To support remote verification of the TDREPORT,
> > TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
> > locally and convert it to a remotely verifiable Quote. Although
> > attestation software can use communication methods like TCP/IP or
> > vsock to send the TDREPORT to QE, not all platforms support these
> > communication models. So TDX GHCI specification [1] defines a method
> > for Quote generation via hypercalls. Please check the discussion from
> > Google [2] and Alibaba [3] which clarifies the need for hypercall based
> > Quote generation support. This patch set adds this support.
> > 
> > Support for TDREPORT generation already exists in the TDX guest driver. 
> > This patchset extends the same driver to add the Quote generation
> > support.
> 
> I missed that the TDREPORT ioctl() and this character device are already
> upstream. The TDREPORT ioctl() if it is only needed for quote generation
> seems a waste because it just retrieves a blob that needs to be turned
> around and injected back into the kernel to generate a quote.
> 
> An ABI wants to care about the abstractions around what the hardware
> mechanism enables. The TD quote is not even at the end of that chain of
> what the ABI needs to offer. The guest wants to use the TD quote to access
> / unlock other resources, just like the SEV report is used to
> "...provide the VM with secrets, such as a disk decryption key, or other
> keys required for operation".
> 
> That's where the ABI line needs to be drawn. I.e. for the guest to be
> able to request the distributions of keys to unlock resources by a
> key-type and key-descriptor. Enable userspace to interrogate an
> attestation object without blobs needing to traverse the kernel. If the
> remote service needs more than just a blob and signature to validate the
> state of the guest then provide faclity to interrogate that property of
> quote / report in a common way versus the ABI risk of conveying vendor
> specific binary data formats in the kernel ABI.

A proposal for how this space moves forward:

1/ Stop accepting new arch specific ioctls in this space and revert the
   Intel TDREPORT ioctl if its only reason for existing is "quote"
   generation.

2/ Define a container format / envelope for platform-provided
   attestation evidence.

   The observation here is that although it is too late to unify the
   evidence formats across vendors, they appear to share the common form of
   a blob with an ECDSA signature. That reduces the minimum viable
   attestation service to something that can generically verify an
   evidence-blob signature.

3/ Define a key-description format that considers a superset of the
   platform needs. For example a 'privelege-level' concept can map to
   'vmpl' on AMD, but be ignored for now for Intel.

4/ For in progress enabling concepts like runtime measurement registers,
   look to reuse / abstract that behind the Keys subsystem existing support
   for managing TPM PCRs.

5/ Deprecate the multiple arch specific attestation ioctl interfaces in
   favor of this unified conveyance method.
