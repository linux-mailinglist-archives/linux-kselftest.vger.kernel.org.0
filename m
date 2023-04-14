Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069F86E2C5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDNWMD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 18:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDNWMD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 18:12:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F84227;
        Fri, 14 Apr 2023 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681510317; x=1713046317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WiWXTGVCF+qXlWmQRnmUTBXheyJciBXVKqlJT/z2Yn0=;
  b=J7UCc0kyPb1fgtVfbS224vXnc9LjO70546hvZabMLsen1iUXOsLTtTDe
   O37QLlk8XuoRX8wsPdwmEKuG41o5aKdMgznhfAL1zex7xrjer5h62dTIo
   v1YwOGIOE6YZ4KkjJUHWfa9lNYx7QtfN9FvuDpz/TNWNTU+9RMFKlZ6Dx
   bgwEVoK5dsAJthPAKapICFkDSkO+IuKGZXyDK2UIrPV5XzqFZ3Ti0ypUe
   lCHA0uZeZRfrRShNLkQ+NCS1wIxsJ/G4Xku60UdF6zbiDUnf1/q787+TE
   LSDsD/2XAnP6yHdyFyb8HRPgkmhza6WzJRubc+4GtTvsfvDYcOeRy0vip
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="372450078"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="372450078"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 15:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="833708633"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="833708633"
Received: from ibaremetalpc.amr.corp.intel.com (HELO desk) ([10.209.10.51])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 15:10:23 -0700
Date:   Fri, 14 Apr 2023 15:10:17 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
        Jiaan Lu <jiaan.lu@intel.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Babu Moger <babu.moger@amd.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Matlack <dmatlack@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Nikunj A Dadhania <nikunj@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        Zhang Chen <chen.zhang@intel.com>
Subject: Re: [RFC PATCH v2 00/11] Intel IA32_SPEC_CTRL Virtualization
Message-ID: <20230414221017.i4nfrcxrbxlznrxk@desk>
References: <20230414062545.270178-1-chao.gao@intel.com>
 <e956f4b9-34a1-de7b-2157-0101b586ab46@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e956f4b9-34a1-de7b-2157-0101b586ab46@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 14, 2023 at 05:51:43PM +0800, Binbin Wu wrote:
> 
> On 4/14/2023 2:25 PM, Chao Gao wrote:
> > Changes since RFC v1:
> >   * add two kselftests (patch 10-11)
> >   * set virtual MSRs also on APs [Pawan]
> >   * enable "virtualize IA32_SPEC_CTRL" for L2 to prevent L2 from changing
> >     some bits of IA32_SPEC_CTRL (patch 4)
> >   * other misc cleanup and cosmetic changes
> > 
> > RFC v1: https://lore.kernel.org/lkml/20221210160046.2608762-1-chen.zhang@intel.com/
> > 
> > 
> > This series introduces "virtualize IA32_SPEC_CTRL" support. Here are
> > introduction and use cases of this new feature.
> > 
> > ### Virtualize IA32_SPEC_CTRL
> > 
> > "Virtualize IA32_SPEC_CTRL" [1] is a new VMX feature on Intel CPUs. This feature
> > allows VMM to lock some bits of IA32_SPEC_CTRL MSR even when the MSR is
> > pass-thru'd to a guest.
> > 
> > 
> > ### Use cases of "virtualize IA32_SPEC_CTRL" [2]
> > 
> > Software mitigations like Retpoline and software BHB-clearing sequence depend on
> > CPU microarchitectures. And guest cannot know exactly the underlying
> > microarchitecture. When a guest is migrated between processors of different
> > microarchitectures, software mitigations which work perfectly on previous
> > microachitecture may be not effective on the new one. To fix the problem, some
> > hardware mitigations should be used in conjunction with software mitigations.
> 
> So even the hardware mitigations are enabled, the software mitigations are
> still needed, right?

Retpoline mitigation is not fully effective when RET can take prediction
from an alternate predictor. Newer hardware provides a way to disable
this behavior (using RRSBA_DIS_S bit in MSR SPEC_CTRL).

eIBRS is the preferred way to mitigate BTI, but for some reason when a
guest has deployed retpoline, VMM can make it more effective by
deploying the relevant hardware control. That is why the above text
says:

  "... hardware mitigations should be used in conjunction with software
  mitigations."
