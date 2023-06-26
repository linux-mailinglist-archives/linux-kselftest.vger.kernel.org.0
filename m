Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555CF73D6E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 06:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFZEcB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 00:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjFZEcA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 00:32:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6F136;
        Sun, 25 Jun 2023 21:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687753919; x=1719289919;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KlhYVU5lxL40eo+3rxiOSdgWNP/ZVfwnyX7RgRZ9WGk=;
  b=YgRClUMlB86eB5u4ygiShMH6mXm57dlpExlUK3ik77It/rj1h6h+kGdi
   tdIBOy7JJRJq/usEKaCOVgGqHC8xPuNEco8ALkI2yO7P/B6liXFz7gr2a
   BDJUuaKecp32cNa/uoYFU5DWNeVG8Zxd/m6L95MygZe/OAT85AtsGL1Ga
   BeVF6uXzDRSVk7DfFRedHnwgj742OUspIpMC5rocRbA7BS1Ogu0+OfPP/
   G2KQDpkGDZFVIbe0yPhzz+h5DWFJnN7trW2fmeOPpzK5OewDrzq60ZoLj
   s97C1t8cbp3ITqxBHt4wykTmUeHBQvbCP1CNFQzznNvQeh8vDyISQjRyZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="350945440"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="350945440"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 21:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="1046345454"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="1046345454"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2023 21:31:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 21:31:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 21:31:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 21:31:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 21:31:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=og5iia9bbPkyyEtNsqFHoBAUrP0ZIhnx3k9zOeeY0HJevjy8qFFdwskwC+KoZ3/YFqW2lUdVRX4V4o++FGO9dZYA00P2KsnRYDqB6o2UIlodd4KkBVlD6FeHulsvV68U71I2u+BX+G6aBLro7NzguH5gPl3ICkV/k/bVfgcy0y4qO+E+ACwYr9xkRqGusrsK+tRZoCc0Jj9v1v6+oTy3NCtm0I+wGIKBf1Didcc8QSZ+Ekhb1joVIfBpu47C+op0XLnPkkCxooZjwv7TOTF+dwpi1U4fkaLLRiQiW7w/WC84R24GnL+2rJ5nGkqtt2qmKMDIR42w5vRDiwornDvB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAaz7sEeSz6kPAfAlt0yRQD+vzgXyeaAyMvKq6JxzpA=;
 b=S/vkdlYvE94jybas1GSq19I/AnPZbzXi4L2PlVUV8KY1DIZTABX4IpPJFOBYs99gb6//0FHKulC8sRoyRBY2F42CLMig8ZA2FRrd0RHyKk3e+HD1kPr/WijLWnSLAZcUwpAjYF+4WTojf/Ys4YqjcJq4ycFY8gjjy+mzL43+UJpR6ugeYTV9506eLR8GivtUU+dcXRYy9ba2cjv+ImOq8beXiJdA80XRZuAFf2xgJUo5CAaOdRWUkH+I6tDYRH4HNB83NWEgOnduyJsHPkK1RGDYe5U/vzIUuDwQP30KCUUta2lX/gepJKJUWeMhr4dr9HMXnZEHQt2s5T77ynLi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8061.namprd11.prod.outlook.com (2603:10b6:510:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 04:31:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Mon, 26 Jun 2023
 04:31:43 +0000
Date:   Sun, 25 Jun 2023 21:31:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Wander Lairson Costa" <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        "Du Fan" <fan.du@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] TDX Guest Quote generation support
Message-ID: <649914ab3de4d_8e17829490@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64966b842becf_142af8294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <cdd04046-4bcb-d6fd-1688-0a85546e7b91@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdd04046-4bcb-d6fd-1688-0a85546e7b91@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffb3a67-32e3-4c1c-aabb-08db75fe3e8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRiCWf1WDiGGVSvfeDXdeDFHjDnXUqKD4wDi3hgdSmqxmfEjyXKL1I5XyjBtT+r7xjACEHHKRXAcY3fpro4sK78qaqIiQoNTR7JsWwr3ouxjYEzdzJjlRKkEuFd4XK07z15cilLiNk4rkfzJqKyrpdNbvllCUMi2vDlRvSCm9RWhpScdPV82cTlvutbKkg5oh4sYheQR1d6dOve0LJdAKCkx1IvFzVCsnCRxMQfMxRgpf0kJLyLhuo+FEwqAuVL6yG5qIs52tuJ97M9Hc+VI1GPtNsjGjbv9W9Qw56umLqeafec464T9wyc6t/OqoCSy8PN1kRJ2D1YrhMLD/7SQq1DZjKxuJE/TcR49kV2Ryb9BUqEthdxOghl+6pScq36N8/EKD8tCUwB5gHphJJ8nXMCgOiEcQTOKHqt6H49aWMV83KACoC9UX4f0i/FlrQ67axCQ5C2lbDJl1gNSwXJlXEak52ZCIKdHEo/UaDkfTPHGzb6U0FJIfcUGwVPApCAhGfhLnfYVN0U/TiVvfpfIsgWw1f+xEz9Q+okav1yNsM9UTlKZwVZlmnX/rBqwwo1q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(26005)(5660300002)(7416002)(66476007)(86362001)(8936002)(8676002)(41300700001)(4326008)(66556008)(38100700002)(66946007)(316002)(82960400001)(6506007)(6512007)(53546011)(2906002)(6486002)(9686003)(186003)(6666004)(478600001)(83380400001)(54906003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OvFTD2WE/XBQss2vroFS5n1tOxcYhsVtI9XUeQjL/D6Ion8n2iIdhqpEj/?=
 =?iso-8859-1?Q?FFTpZ5Gc/YfywSP6Wu+jbzC3k+i363KlJnxOMz7Eq0theEV1MNjRZH3Rpd?=
 =?iso-8859-1?Q?7Yc+IYZ+kWLckSBPKhQevT4Y7SvbZ323S7D9Vbgpzn2INb3mlJowsD5cYp?=
 =?iso-8859-1?Q?6/mApe42CVlvfM/bQKqUrDfbh4da9lwxgJLddfhjetDD+YtT1o6UE0K+Hr?=
 =?iso-8859-1?Q?i5BGvJIdUxBiUt8TlvYDE2+TrR6xsX0bIA/Obx2Cjm239nFaUMZPWrCDdB?=
 =?iso-8859-1?Q?TpRYRwHfCziANeTfkJ6FmWq+a8cF23kRxuwO7PXRN/+YV9mVcg/r3/ol+T?=
 =?iso-8859-1?Q?yuNMDt4okDJQOYIy/6DxUypBrtIzBDE+72iTpN3Sw2LGv17wnPCJ6pd94D?=
 =?iso-8859-1?Q?VVJn3rAQ/sv/GWVJ7EZkWKaTjQ8RcyOfWLi5YxLwvngqfQCl0LSPFrZqt1?=
 =?iso-8859-1?Q?gVvIXfB09wQHjW2+2mqUzjWd4JyXAvFdZesb0al2n5vcKSJuyzTFimZyTf?=
 =?iso-8859-1?Q?wHWBuOtymUWiVj6e5ZxU+uusq4EfLGu4CqfqNBWY+VWeDBxY7QQw6h+5hi?=
 =?iso-8859-1?Q?S2kZG9SECA+VLofn7/CHx9E9enpgcK+orIf4Yf3Lc+NPAB4z3W3jJhuLBX?=
 =?iso-8859-1?Q?vUfTejbcb02/VIWfkdS1ydY6HsOP6sOHa4pgb8f0qgjuJ8wq4JXnddL30A?=
 =?iso-8859-1?Q?bxLycOsNBQ+6yd1asuKek3T4ye+/ON+oBurI+pOker6dWsz1MrbDupisBf?=
 =?iso-8859-1?Q?/rLJkwGKP4pAQEnz4SDLoRvhBnqIPBBBq50XmT7wBPrLy5q3SODUw2dC1k?=
 =?iso-8859-1?Q?QKmDSwEp/uIPlJIBediNql2JnEEHxOk2bCzxm/6Knk01DCrpJnuMmRFqrb?=
 =?iso-8859-1?Q?r8ik1as3smn34p9MKYq+Qua18qcg6gsoXzjO+wvA196XPkxaXup6gi3j1F?=
 =?iso-8859-1?Q?j7yFWYmLGWh291F4c2APSNOC62iNN5efT3Ru7T8DJfqWYutGCI/cM+22my?=
 =?iso-8859-1?Q?swDlRyfgM5Uo0j48BK8tj+MT5P1ZJwcRvDcP6k5dZf/6vWr/4gYi/2en6M?=
 =?iso-8859-1?Q?c45WuASrOBnheFw/3ITyBKrPso8fEJuUpdFQk9/Iw9YlMWcs2kZv5GH+VF?=
 =?iso-8859-1?Q?2LbYXGWJqvXb7dQG7ogtSJf6Uz5TElVbGU15xWzbsGbiNMi6uQpPo24qkX?=
 =?iso-8859-1?Q?cEtOLK9eEv/O4KTwUQ6aOmLWG8eJ+VpVfSAzgyv4MEzSeAv/XvViND4arO?=
 =?iso-8859-1?Q?/wEPp4tx/2i5bTZN4cRRw0C4/75hYRnrJvLo/uVvQ921btpJeWhvyAnm1o?=
 =?iso-8859-1?Q?TkqvymoGfXWM4+65ud/Boh7FzQpg5cZ3HTTq6bQXfbNbR9K8lXyBv7wSJg?=
 =?iso-8859-1?Q?BB12u51IiiVTHchq6WlrdvZF8XFZnx/ni6e6EjRQy5L1N72+QiDEn6l38r?=
 =?iso-8859-1?Q?VQCDgZ/7f7rxsE8qp+3UhrBDCbXwbbrZZ766P76kdyLoJ+gWF2GotNOJvU?=
 =?iso-8859-1?Q?F1yFAruP+mpMhsqCusj8E8F2upwrwaooQOxpejcCnsCJ/vgIZa94Nu3BRr?=
 =?iso-8859-1?Q?71p3clrWQGZH8aUxB9SknuMOVU3PPHSXftpz8YRDER092hTS4qLl3+LvxX?=
 =?iso-8859-1?Q?AY4piGi6X7okzNL+8q42xfo3lzACZhQoM1yFbKZxFZJ+ISXRPLSj7Svg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffb3a67-32e3-4c1c-aabb-08db75fe3e8f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 04:31:43.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXQlGg4d1M9sKx1sgY7xMI8n12yrANDXpLQA10aawEhvmHoqeIUUoU7NG2aNB7RY7Cm7n5nLgSG/qKM4FfJhGrNg2FeFyG6UO1WQZLNN27k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8061
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 6/23/23 9:05 PM, Dan Williams wrote:
> > Kuppuswamy Sathyanarayanan wrote:
> >> Hi All,
> >>
> >> In TDX guest, the attestation process is used to verify the TDX guest
> >> trustworthiness to other entities before provisioning secrets to the
> >> guest.
> >>
> >> The TDX guest attestation process consists of two steps:
> >>
> >> 1. TDREPORT generation
> >> 2. Quote generation.
> >>
> >> The First step (TDREPORT generation) involves getting the TDX guest
> >> measurement data in the format of TDREPORT which is further used to
> >> validate the authenticity of the TDX guest. The second step involves
> >> sending the TDREPORT to a Quoting Enclave (QE) server to generate a
> >> remotely verifiable Quote. TDREPORT by design can only be verified on
> >> the local platform. To support remote verification of the TDREPORT,
> >> TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
> >> locally and convert it to a remotely verifiable Quote. Although
> >> attestation software can use communication methods like TCP/IP or
> >> vsock to send the TDREPORT to QE, not all platforms support these
> >> communication models. So TDX GHCI specification [1] defines a method
> >> for Quote generation via hypercalls. Please check the discussion from
> >> Google [2] and Alibaba [3] which clarifies the need for hypercall based
> >> Quote generation support. This patch set adds this support.
> >>
> >> Support for TDREPORT generation already exists in the TDX guest driver. 
> >> This patchset extends the same driver to add the Quote generation
> >> support.
> > 
> > I missed that the TDREPORT ioctl() and this character device are already
> > upstream. The TDREPORT ioctl() if it is only needed for quote generation
> > seems a waste because it just retrieves a blob that needs to be turned
> > around and injected back into the kernel to generate a quote.
> 
> Although the end goal is to generate the quote, the method the user chooses to
> achieve it may differ for a variety of reasons. In this case, we're trying to
> support the use case where the user will use methods like TCP/IP or vsock to
> generate the Quote. They can use the GET_REPORT IOCTL to get the TDREPORT and
> send it to the quoting enclave via the above-mentioned methods.  TDVMCALL-based
> quote generation is intended for users who, for a variety of security reasons, do
> not wish to use the methods described above.

This flexibility could be supported with keys if necessary, although I
would want to hear strong reasons not a "variety of reasons" why
everyone cannot use a unified approach. ABI proliferation has a
maintenance cost and a collaboration cost. It is within the kernel
community's right to judge the cost of ABI flexibility and opt for a
constrained implementation if that cost is too high.

What I would ask of those who absolutely cannot support the TDVMCALL
method is to contribute a solution that intercepts the "upcall" to the
platform "guest_attest_ops" and turn it into a typical keys upcall to
userspace that can use the report data with a vsock tunnel.

That way the end result is still the same, a key established with the
TDX Quote evidence contained within a Linux-defined envelope.
