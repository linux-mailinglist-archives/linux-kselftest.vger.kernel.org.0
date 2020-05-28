Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B691E6B3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406651AbgE1Tin (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 15:38:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:53663 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406540AbgE1Tim (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 15:38:42 -0400
IronPort-SDR: GXBnmyQ6wSHGnIwwAHXaU5E+Yn+EOV6zVnPprRqdGRJGQYZgWn/2WldcfgPtIMtToB4GL7+2+T
 aLxoSkE9nBmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 12:38:41 -0700
IronPort-SDR: 9HOb7WvJFdbYjWp6h4nwPYosl1cE/gewjfxnveuR03MQZ2YPCjJ+V5QhtGBKTDmX0X3v48gDN1
 VgvEQkpzRI3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="302584054"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2020 12:38:41 -0700
Date:   Thu, 28 May 2020 12:38:41 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>, eesposit@redhat.com,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: BUG: arch/x86/kvm/mmu/mmu.c:3722: kvm_mmu_load+0x407/0x420
Message-ID: <20200528193840.GD30353@linux.intel.com>
References: <CA+G9fYvnJNre4G=ZsPAon_Zt+kT_QLQB_VZVhdWKYbn29xtsRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvnJNre4G=ZsPAon_Zt+kT_QLQB_VZVhdWKYbn29xtsRA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 29, 2020 at 12:59:40AM +0530, Naresh Kamboju wrote:
> While running selftest kvm set_memory_region_test on x86_64 linux-next kernel
> 5.7.0-rc6-next-20200518 the kernel BUG noticed.
> 
> steps to reproduce: (always reproducible )
> -------------------------
> cd /opt/kselftests/default-in-kernel/kvm
> ./set_memory_region_test
> 
> BAD: next-20200518 (still reproducible on next-20200526)
> GOOD: next-20200515
> git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> kernel config:
> http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/777/config
> 
> kernel crash log,
> -----------------------
> [   33.074161] ------------[ cut here ]------------
> [   33.079845] kernel BUG at /usr/src/kernel/arch/x86/kvm/mmu/mmu.c:3722!

I'm 99% certain this is already fixed[*], I'll double check to confirm.

[*] https://lkml.kernel.org/r/20200527085400.23759-1-sean.j.christopherson@intel.com
