Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5F73C6B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 06:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjFXEFl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Jun 2023 00:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjFXEFk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Jun 2023 00:05:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE48E5D;
        Fri, 23 Jun 2023 21:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687579539; x=1719115539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XDEbcu7RewQgXb440rVeb+JTk1rdH6CQ6OLlDJEGfK8=;
  b=jYN+TmR8uXzjswpk47UvDEFJZdcACm09TMsI0CLLvNsQe9r2qUSeFBL+
   8wkDR+smCXsjTPuMIkIQnX0+2jsMWBd88KvB29Y0JKN85DpXSCji0v57p
   OHyvE0fCtC5V0PuFBoxzff21SOqULFlGg58A1Ew9GpvrbE4kPG0Ni/Dx6
   dQpyGMb/Q77BSMfo6/Db1ldAk4iPY6wC1662HBKxmZHlKku2zCeznNjhP
   IPLgmUwftpahEC9em7OpkhovljZ9VHcY0VyfWLz+BxnRHWANahf7KtJDH
   3s84B8IADzNsGcQ2hhnugdQBxoCZu4oK7Apff3zkl3uysQr8LlLZbtziJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="350680531"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="350680531"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 21:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="692870132"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="692870132"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2023 21:05:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 21:05:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 21:05:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 21:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4sK1B1jy7Cv2/L/5+J7YJmSkP7SeTVZyQuq6ynlsQ2rsQaP21ximZucOQKMNpEOC6OZUabAHhYpduxfETDVnLK9K1KfxPRTTjT5s7Ecjfv71iQgJrzWYyJ1ZlNjsb2320ta3na2uw5Te0aFrBkX+YvDM7NBTLLkVVgqdPfrfWJ3Wkpsep+S9BGtLpQ/E5kcfExoOSwE8COVY+GZwO7Rrqmy1fX8eaiiSfd8bgge0Qgp2oivAKgAFth7x5tVLwvgFFeaJZvvttfevXqcEduXIKJ/9ywVtbnTh/S/xDYyPhVg/QTOTD9JVuFNrY6qxKZfZnSq6/enS5i7cikB9UOIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZoSFPNMa9YSRN5O8y4CXRBAenOyCkDVDRCqTlLLI6g=;
 b=TuUOeUFXD7fCIvpyxuOoTc81/H5cRvSXIy3vdnGzZfNo+UcdvntiOmU5ZrMQ851pkb+fej4Z4kPmAWsy4DUXSEiQxT24080AiptcWFcGHQTm33LPokmU0/qjs+yQPQp1HPRKG1ttq05V7R+XiCatNxq95KpW8M0RMvi5GqY9tktqxoW8dGuZgNdkW5W3zogwrlcCIzKDJ9YrWsB2pgzaGvdR2m0iSClzVOA0ptzCm4wWmpBDEeaqwmp3t9nkHOWQ5iWYUTuJkJUrGrYOVyeTUQazepjZCY3vLWqKI7CfbwRBxtSaNP+7a7kBXvINFgur7cCKU5RfIAMaafMqqoxMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6966.namprd11.prod.outlook.com (2603:10b6:806:2bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sat, 24 Jun
 2023 04:05:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sat, 24 Jun 2023
 04:05:29 +0000
Date:   Fri, 23 Jun 2023 21:05:24 -0700
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
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v3 0/3] TDX Guest Quote generation support
Message-ID: <64966b842becf_142af8294a5@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: decb8e28-2221-4ebc-d78c-08db74683ecd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBi+Bkrh3tu/DhniIbpNTXiGieuj/H+hkdF1v9OqsMGu8Ge7aZ9mp1mUEFEgUNaXs/Ynk/+dT+MdDZMZI9gdGSSyQ9MdrNHObpRedT+yONZxgyn7e4wFdHrc7J0agSTYfpStXWLhu2xN/YankKa5bK1DV3Z6q2sHqh3IwM9HkHoj+nVxYUECVfglF3EY2mXQIRNyUHkuvEaODvoXju/gbBBcM0/Ji7Q9hIs2g3CI986lCbL+UxHi1OA5VIeeqeuFGCJiPmut44T2FGfARQmpf1A+gRiX9zpmRLMANfYnYzAxF7XgomaCYue1PVIQc/IKJ+EmNMTQomUe83xgslHIPIROpibzLFi44S1JR4HSMYxF0w3IGX9weJwOxsJclLZRoqoxSwpyjz9PLY2N/i8xqOHzMi8rnp3kVDaLX2MDGbl6BQNR8+LrrAts+/XSm73I5M8d4KkupOyxMhcPOshVRdxm4YFURE1dZOxmS6TahKEG3hK+YOtTRs2IkF+idC8GNimW1aoAonI4CsVQuo/F40UYMydAnTH1Rg/M2Nw/jCvRYvBqjl4F6wRhzxnPnwdr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(6666004)(82960400001)(110136005)(54906003)(6486002)(478600001)(6506007)(186003)(9686003)(2906002)(6512007)(26005)(66946007)(8676002)(4326008)(66556008)(66476007)(7416002)(5660300002)(8936002)(38100700002)(316002)(41300700001)(86362001)(83380400001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?srpdxkKP9ZVZ2/cTO6/nVMhcmaG9Hdip5bQ3w5h4vcWYZwuhKf6DhfC0kwgw?=
 =?us-ascii?Q?Wj2+taBXE1MbidvoUG7XXFC17Rc3tHVpR3VwqmBlJcwyu+vyUeBfrnn231Lz?=
 =?us-ascii?Q?Tk86CGdQBPsD8IRXcRHfZGEhNQ8gPRYeBKMWfDl3QssXOHT354bx+q7xp4eJ?=
 =?us-ascii?Q?4zGnVnSgPtT45HjM3AyNk/X1f3jnoIfCTJVnHqLTqRvDI8jENvU+rFEtvPTX?=
 =?us-ascii?Q?dUeE0iP1Dm2bOXIeqOFqNHNxLAIHMKf/AOq6JxJsjzGADc0YqPNjTvUX4yWl?=
 =?us-ascii?Q?0sJcstpNtv/pAR0efpBmnsptXqdyjhyyDKlfatUXxZEZhy2qsYRHWPRsVEu2?=
 =?us-ascii?Q?w6SlIVGhh1inaLn5b7cClXhVymlnbhuZVWJ5rjWia3Nc7SA7TO6SvpiLqZ1w?=
 =?us-ascii?Q?6Illoetd0MdUSl5EfqVWsUT9Hzg06uKnXbEwlhN7fNBttv1Nd5WusCMMYBBj?=
 =?us-ascii?Q?yYQb/FsuXu51Vno17v5Z9d4c6KcxH0wj9pUglEXJcFgYkRdGC+bWonYivIiH?=
 =?us-ascii?Q?JQ33ob0IrxAL8UMI/XGpTInx6hfjdDrEV3KX2knK0K/7ESUASKZFTTECh2ta?=
 =?us-ascii?Q?xpSyUtc9EHgkt/cta/h9kjf6lOAWbqnovSgwcY6t4SBxoG+0o1Sh9E/Gous9?=
 =?us-ascii?Q?s7RpImll0cLwmTo671bG+764VFXakqCNa00T/IFh9JYYhwp0CBTF6Upq3TYq?=
 =?us-ascii?Q?qwWOozcJmVNzjLG6k/tNAfGwhaWwacNnz5p9+bmoK52S1cb7sh9G4QX6usFG?=
 =?us-ascii?Q?UM7zS+yKbwa0IAhdvxjeFgbLYL1891NxjZ+YK5pLHPtMRqp71HT/d/IEym19?=
 =?us-ascii?Q?1MToHVE7cXUbX+hoNPBZr4y4GVygrg4+lSzaLvKvhoT5DamouLQVVS0vdFVH?=
 =?us-ascii?Q?oGEWE/YLIiPW2wuwjfMTQ6ZI0iJdc3yTMujGddCrwjeCNciXoJ6GgvWChuBP?=
 =?us-ascii?Q?PMTYo/SVmxIKLlXZQvbqL9cWa8cTBnfp7GAeb4aUDZwNj1CajSOkF5JvEq80?=
 =?us-ascii?Q?XNys25d+04Xo73VIFIFKfVGslWFFGlba33OXuhOII6KdOFt3pSEEatmtzEJ4?=
 =?us-ascii?Q?V7xCYHgTXyo8f0SFHPBZXM5cXz6unfVMfm+A2JjQnrQs5q871LrcJMKgHbB+?=
 =?us-ascii?Q?zpHzRnCANW4NH5bBhoRrfuE4TIJOe159pq/J1eM3SSjyHtVshb/CxIeJUCn2?=
 =?us-ascii?Q?05bn/J/0x/SR7paARKd5KsmLQpkhw203uuOGxDAA1F+KZNtlT3qRYx7thXJd?=
 =?us-ascii?Q?5dH/G1Bea1kS1V50RlZ4M0aFS03W0oleiPibRZVl8j1PFKuEOi7hIa9HL3lO?=
 =?us-ascii?Q?4Nc6aJwFWQ+8KG3nAvI5N6hAGxoxq0dZ+CCE30uTQ5pWh238lh+ggkmI1g7S?=
 =?us-ascii?Q?IsWQOHnVtUFY6HaYNQVrnUVIOl0/CxR7zv+LOWMzYSjV0CFxYnpcs6YUPq6a?=
 =?us-ascii?Q?RbEgR2O01q0AMU+S3A1r5Exd9dfWViTr1EB8BBPOChwO/M56aSPdgN81MrsQ?=
 =?us-ascii?Q?i244QPCFS7w9CVb65eDQoaE6Aba5CjZrJcg568mXH+h3J34DCgWAS/z3J66L?=
 =?us-ascii?Q?j5x8dV7cIFBPf0g7D/IoFzst4sthOPvmzAm9Qc82wdPzu2pwBdSMWscL6QHq?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: decb8e28-2221-4ebc-d78c-08db74683ecd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 04:05:28.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/2maQTWuVCXI2jBhEjZzpavqQR6oMjkvMjK/3WIaI5AxhsW2kiVaJwT2e0yBt+ZGOeiC+imJ57vSnewyK9aEYi3yxlOoWrSah4FiPFh73Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6966
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kuppuswamy Sathyanarayanan wrote:
> Hi All,
> 
> In TDX guest, the attestation process is used to verify the TDX guest
> trustworthiness to other entities before provisioning secrets to the
> guest.
> 
> The TDX guest attestation process consists of two steps:
> 
> 1. TDREPORT generation
> 2. Quote generation.
> 
> The First step (TDREPORT generation) involves getting the TDX guest
> measurement data in the format of TDREPORT which is further used to
> validate the authenticity of the TDX guest. The second step involves
> sending the TDREPORT to a Quoting Enclave (QE) server to generate a
> remotely verifiable Quote. TDREPORT by design can only be verified on
> the local platform. To support remote verification of the TDREPORT,
> TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
> locally and convert it to a remotely verifiable Quote. Although
> attestation software can use communication methods like TCP/IP or
> vsock to send the TDREPORT to QE, not all platforms support these
> communication models. So TDX GHCI specification [1] defines a method
> for Quote generation via hypercalls. Please check the discussion from
> Google [2] and Alibaba [3] which clarifies the need for hypercall based
> Quote generation support. This patch set adds this support.
> 
> Support for TDREPORT generation already exists in the TDX guest driver. 
> This patchset extends the same driver to add the Quote generation
> support.

I missed that the TDREPORT ioctl() and this character device are already
upstream. The TDREPORT ioctl() if it is only needed for quote generation
seems a waste because it just retrieves a blob that needs to be turned
around and injected back into the kernel to generate a quote.

An ABI wants to care about the abstractions around what the hardware
mechanism enables. The TD quote is not even at the end of that chain of
what the ABI needs to offer. The guest wants to use the TD quote to access
/ unlock other resources, just like the SEV report is used to
"...provide the VM with secrets, such as a disk decryption key, or other
keys required for operation".

That's where the ABI line needs to be drawn. I.e. for the guest to be
able to request the distributions of keys to unlock resources by a
key-type and key-descriptor. Enable userspace to interrogate an
attestation object without blobs needing to traverse the kernel. If the
remote service needs more than just a blob and signature to validate the
state of the guest then provide faclity to interrogate that property of
quote / report in a common way versus the ABI risk of conveying vendor
specific binary data formats in the kernel ABI.
