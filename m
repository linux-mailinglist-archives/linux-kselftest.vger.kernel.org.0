Return-Path: <linux-kselftest+bounces-1406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE068098EA
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 02:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDC3281F99
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD751851;
	Fri,  8 Dec 2023 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4+rSBYO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670EAD5B;
	Thu,  7 Dec 2023 17:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702000611; x=1733536611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ETX7yA4gShZDuOKyBlrB3dngUmKATMd14xnWkWsUOAc=;
  b=n4+rSBYOY5airRX6jdvEuKTnO9Or2d9EIRxS6WeuymcMnDECDF/NUep4
   YCk7ByAfcMTEY9eYpeaxhqAWbdTurlKuWTkHXJIY+ufaLFVrdUBBE+T9Z
   9x7IbjxlTLXZUhU+SrP70ugpzMNzFs2Rm7IgcqI6Xco+1wr5KUoo0x/w5
   eUvpgBAOKpNFqFGxfC2PQqsGM3B6k1Wj/5Z82m4kYLJ+cSow/XoPGfKiq
   HPtJU9t4IUKQ/GtNXnDy7LDp5qa0WGYaqFCBr/a5OEgam6kbW7dwBI+9q
   rCSxvU6jco6UOk6oq6sONQJ3Sev+ampWXusFD4AF5jjrJJAWstYQu4NOy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1410650"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1410650"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:56:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="775647281"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="775647281"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 17:56:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:56:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 17:56:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 17:56:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAGFZXIWn6iCE/t7DM3IEDBvF8Iy0A8Ft4mkN8WRrHoqMO6NGMwvvH92xWALzc0gKF1Xfl8b9iT1bBmzAB/NCbPgKgYNoiZejqGziQptjESKQe2lUv1hHDdPaC2ozXq0T2/3VBmiEr4+pSV0+rsF5fu4Qge+Iyc171lyRDOfMwXc1hlhF0/xldfkxEzvSu5PIDrmw+SNM7YRNcOSw1oAcC1GgD0icY55I/34XIhAuFC92uAg1gw8othuXpgJAwhdLlCUvpva4RYNi1mJYAonZlVPTBvy5XOgdQAB+D8YKrw3BBO5cuQuQQkJB/5H+ZOWpm4FCxqb8CVUAnLx8LzNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ptaj+stbKXzT8OrUYN6gygeOjSdbaYdr1Yj6mKRDLY0=;
 b=IU17f1pGmIxjnbDgysTq5g3Ig8w19Jaz93n/0ftciYhfSSHgnuSjkHvpHulTJNi5l8EcdkntNkLWBuc7MBVqM2dEbm19iip1O1RPwJto7C4ObkSPpRU2XqaNHd4rg/ckIMItiAaEav+bcv3HnbT9K1RPxcyXaF2PhLogG0aoIyfeJLNZP9c1ddsm2XV7L7srx69wvXakt/wAQxfAUFitxMfok0NrJnyVVR2QQhlCvRUhJlL1bbmeZPhaF2aWFxy1ZtTBrV5/WUAWMdgxtgC7HxogFzQnckevxmmIzaAjIOalCz1ZDID2bVP7BZBkWFGFq/WTD2bvQrZocTHYfWsCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 01:56:46 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 01:56:45 +0000
Date: Fri, 8 Dec 2023 09:56:31 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "Cui, Dexuan" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Message-ID: <ZXJ3z0yCqnHm52sC@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-14-xin3.li@intel.com>
 <ZVMkVmBPVfaMjDTL@chao-email>
 <SA1PR11MB67348D3637C2BC6B107C5CCAA8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <SA1PR11MB6734EFF17E15C68AAD12A227A884A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZXGFcuwwmkBlqq5s@chao-email>
 <SA1PR11MB67342A44E1C2E17E127AA44AA88BA@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR11MB67342A44E1C2E17E127AA44AA88BA@SA1PR11MB6734.namprd11.prod.outlook.com>
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA0PR11MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 5468d439-62ce-4ad8-5b0c-08dbf790edcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnRbtemkxzrrfUFAndUD5Sos1vXzBA2SmBK6GFY9XskvwtWn+Yw4ge2M/uCNbfK4KHKjxmEYnBzMJ61ahqNsk3R1l6vWotr/oEtsShpKjeyHmIm/rTNlYtiCPd/muLdHuiOs5Iuepb+NbH0yZbCAft4QJVqmoJm1eSvZJka8OmyM0XXaSYTiCPrspim2dU/sHXhdrs5Gb/aQZld+YDrQhN6BBufxE9rvON/HWFD7qC/kj+PPkG/JDQ22ZxI0+MLbiWEkf5c83k3Zzy79IZlW3IYKg2Bgba8kjhUGAnGSP7WtOLylJLGh6KhbE60TM7DnpDWOC+354Mfc65ZsLLODKEUR9OC2B1nCsGcWiwAfSnArnbrJYBSYm6KYKivSnN7QjeydGSV1tKCWpbbI4okcxLzKUr/vEo/gZqbV3hKxsz2iZ3kFAL3XDxj/z5O7u6ByKDmPZnwzcKIdzkzk7m8p1DtiMtR/8uDhR5l8y9I/P3QjnTpIQJP5Crp65DcH5BDSA7ex+zEXIluBR8HGow9G4jNPn1WIASWGHG0m3doHrN2YTPnT8Is2DRBuy4wibJGp5dnxNf4v5EXaNZCXNPM9Z2DBTjVnrzLxcV/R9kNtYszjqi8OSs44pAHQYgkbmOl2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(9686003)(6512007)(26005)(6506007)(6666004)(478600001)(6486002)(316002)(66556008)(66476007)(66946007)(6636002)(33716001)(54906003)(38100700002)(8936002)(8676002)(4326008)(6862004)(86362001)(44832011)(5660300002)(2906002)(7416002)(82960400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2rcLwWwekIRLlYct7i02xhVE+Mt3TyRQd6AfrvIiv4IvPew/fqKm57MCnwk2?=
 =?us-ascii?Q?SxZ94dMx7sScZ4CHJtPlzifWrIYkUV6W4RcBKifpSYIZLfkDosjsDwDaQj6H?=
 =?us-ascii?Q?DwGe/wpoxwdqeY2Yq7UC9HMkQ47+QaB88kjWCc8oXai9kOuYtkBSAXQyq07F?=
 =?us-ascii?Q?zkIyxTG3U/BTWV24K6oyWNf+zSpfVPGMR1IxfEL5ETtN96p6y0bGFmoWwqwV?=
 =?us-ascii?Q?XLHaZNsdpWwpXO17ppUEpMb2ytQJRqMx4cVl+kIZo1V6GGfZ3cPsuu+Una24?=
 =?us-ascii?Q?pzHegLP43jNSJh+vw6gs7Cj/qpKIXkxrwY2W+U8gAkY6b6/mfEJ/aFVbD1gH?=
 =?us-ascii?Q?B3Xnf0p9+Q0na6gzCLfjHBLbxBHhLzDDjCchHFZbTWzPhzH6hJNmEzlfLWeX?=
 =?us-ascii?Q?AEd+Es2kt24oeroI8Lu5rgE+fv3zCvuUaYpTCbIfka78z/WFfCGhd0pZ+Qb+?=
 =?us-ascii?Q?+rLsHezBaqJpeF4Gczrwg7d3EKmoYd3s9vnsXswmxXxTpxsLZ3pWeQqL0IG4?=
 =?us-ascii?Q?9FhyqrGLAzNAk0nZZz//UcAUqhUx/dfMDCKGKQ6/jn6K2ZU3dS/Fac+Ljlvn?=
 =?us-ascii?Q?l1GDo4wR8qJSz04fsUvLtLm/XcG5h8NEmTq8tZVDdcjZo9821X529HQObetW?=
 =?us-ascii?Q?Gy5FN6UZrGraDrtevUmQ4BeQI0RuJlmEs7qullpeEC/R00Gd3imjDenmBMmo?=
 =?us-ascii?Q?ZEY2rVoKHwATWryNqJoOjwmyCglluKVbp4ODe3Nx0qVhbBSaVAu42xOjSFGv?=
 =?us-ascii?Q?bBXwp6tB5FDUbyAPflGNb5pGGzmsSByqMQigoJtOltoYv2BFhzl9JbrI4iFm?=
 =?us-ascii?Q?jGkrTnsIIkSLrYzLUPornE94q+xEyen2jJ8IeO+t0R48YPEBssdq/aaXuhZ3?=
 =?us-ascii?Q?oLNRouvy87g8j84wQNYcoqZvJ7DsOCNG/zmyVZk3K0w5ioSln7NUBM3zCxAI?=
 =?us-ascii?Q?30MxF47ObgXASCWSbsEn8Ll9IeF5mLRLnm5n9dMnT7bMTiEMRrJe6fkeK1LD?=
 =?us-ascii?Q?hlqlpiQbpz+Q/8i+/b8tLFFBMB4Js3xYzPBm/osEWh97Gsp506WnvEICjcU8?=
 =?us-ascii?Q?yBxMLQMNBay1chlMVtGHBzV4kOnWs8fHHjtyIZvQ5MTcfy2FdZEAnjwAtUeL?=
 =?us-ascii?Q?HQElpPZeTdumktJ4TKP/air1fsmqBoNJU3B/obMQWb+8AjkqedrPk3MslWl5?=
 =?us-ascii?Q?BXlsUU+iNpvA6mnt2l0TzGwhx2gxukgZcIIQsPP8P2h/7j4im5onLPiH+Qdf?=
 =?us-ascii?Q?F2n9rv6SovROeLPwf/pDHA8iOviUnGe5HCj6Bms7hHKkpF9aVF99MvTH9D3m?=
 =?us-ascii?Q?/O/TkOTwM339qNR8/VCV+nYM5J2CJ2R+zIqK6g91An6O2m9NHyMk/P54uY5f?=
 =?us-ascii?Q?Ppuwg8FC0cr4mF32BCxrlB9n945LRExW2QTRhMz8b2Rg/uMHzUJXKZZh7+Hg?=
 =?us-ascii?Q?w6xSiv215kYity9A74G3XimOTEoFEso6XoZikEqf3BxMt/Ju82PN9R6WKWaH?=
 =?us-ascii?Q?ZkqVzyPfO2Bfkrfv+ttJdUtgmyY/tNikYQWL/spb9Hsz65u/HM/ramutP6cY?=
 =?us-ascii?Q?2ntanI4nl/NKXDv4H1foqunFwjTwBZIlFUZAz2wm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5468d439-62ce-4ad8-5b0c-08dbf790edcf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:56:44.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uehR7lT0zt1K2k9DRILTSM/GVZChnPAlFMxa3qh2otcMynn/kQjMH4CiYry6z2jzKrgRJcNI7cfeWwVtAbqCAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com

On Thu, Dec 07, 2023 at 06:09:46PM +0800, Li, Xin3 wrote:
>> >> > Exiting-event identification can also have bit 13 set, indicating a
>> >> > nested exception encountered and caused VM-exit. when reinjecting the
>> >> > exception to guests, kvm needs to set the "nested" bit, right? I
>> >> > suspect some changes to e.g., handle_exception_nmi() are needed.
>> >>
>> >> The current patch relies on kvm_multiple_exception() to do that.  But TBH, I'm
>> >> not sure it can recognize all nested cases.  I probably should revisit it.
>> >
>> >So the conclusion is that kvm_multiple_exception() is smart enough, and
>> >a VMM doesn't have to check bit 13 of the Exiting-event identification.
>> >
>> >In FRED spec 5.0, section 9.2 - New VMX Feature: VMX Nested-Exception
>> >Support, there is a statement at the end of Exiting-event identification:
>> >
>> >(The value of this bit is always identical to that of the valid bit of
>> >the original-event identification field.)
>> >
>> >It means that even w/o VMX Nested-Exception support, a VMM already knows
>> >if an exception is a nested exception encountered during delivery of
>> >another event in an exception caused VM exit (exit reason 0).  This is
>> >done in KVM through reading IDT_VECTORING_INFO_FIELD and calling
>> >vmx_complete_interrupts() immediately after VM exits.
>> >
>> >vmx_complete_interrupts() simply queues the original exception if there is
>> >one, and later the nested exception causing the VM exit could be cancelled
>> >if it is a shadow page fault.  However if the shadow page fault is caused
>> >by a guest page fault, KVM injects it as a nested exception to have guest
>> >fix its page table.
>> >
>> >I will add comments about this background in the next iteration.
>> 
>> is it possible that the CPU encounters an exception and causes VM-exit during
>> injecting an __interrupt__? in this case, no __exception__ will be (re-)queued
>> by vmx_complete_interrupts().
>
>I guess the following case is what you're suggesting:
>KVM injects an external interrupt after shadow page tables are nuked.
>
>vmx_complete_interrupts() are called after each VM exit to clear both
>interrupt and exception queues, which means it always pushes the
>deepest event if there is an original event.  In the above case, the
>original event is the external interrupt KVM just tried to inject.

in my understanding, your point is:
1. if bit 13 of the Exiting-event identification is set. the original-event
identification field should be valid.
2. vmx_complete_interrupts() is done immediately after VM exits and reads
original-event identification and reinjects the event there.
3. if KVM injects the exception in exiting-event identification
to guest, KVM doesn't need to read the bit 13 because kvm_multiple_exception()
is "smart enough" and recognize the exception as nested-exception because if
bit 13 is 1, one exception must has been queued in #2.

my question is:
what if the event in original-event identification is an interrupt e.g.,
external interrupt or NMI, rather than exception. vmx_complete_interrupts()
won't queue an exception, then how can KVM or kvm_multiple_exception() know the
exception that caused VM-exit is an nested exception w/o reading bit 13 of the
Exiting-event identification? 

