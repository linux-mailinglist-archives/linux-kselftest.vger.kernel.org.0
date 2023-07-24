Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAA275FDEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 19:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGXRkK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjGXRkJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 13:40:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F9C0;
        Mon, 24 Jul 2023 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690220407; x=1721756407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c5Z6pBHbsES+jLFL8lHM4LvuACi7M2wwU23RdacU0yA=;
  b=CtK0goGQkODinWx2CYn5Iyvj6TNpOz6xmeFPka2f81gfQD7UH9qAh7/9
   IZhN3MzQ0+6pb4zRhg8PUriOR3lv4+QPaqW8Kr8UrVJEd2F2SdqRmr1i8
   JB2wE8wfxpAcnzkkq6iX3Qa6itlq+GppDlMj5lQ9xfVinegPEWVB+//xb
   tR9PA19OPZCBxd3fHT7XFoBtKrZoD0WEoWuC68FzH4ZCTsVGmJeUyjyER
   +zgML7vpKOfJrvreCELAPmk52oT/Vwoi/30kV/ZagwyTIJI5uQ1h45csb
   fIi+/PfTVLBY4T22Ov2Wb3sBrWCJBzas6qtxsLDsFGqhuQwYxvycV0sFT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="364968436"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364968436"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 10:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="849718874"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="849718874"
Received: from zhihuich-mobl.amr.corp.intel.com (HELO [10.251.18.158]) ([10.251.18.158])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 10:40:05 -0700
Message-ID: <2284d0db-f94a-e059-7bd0-bab4f112ed35@intel.com>
Date:   Mon, 24 Jul 2023 10:40:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 20/20] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>,
        Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-21-vschneid@redhat.com>
 <188AEA79-10E6-4DFF-86F4-FE624FD1880F@vmware.com>
 <xhsmh8rb5tui1.mognet@vschneid.remote.csb>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <xhsmh8rb5tui1.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/24/23 04:32, Valentin Schneider wrote:
> AFAICT the only reasonable way to go about the deferral is to prove that no
> such access happens before the deferred @operation is done. We got to prove
> that for sync_core() deferral, cf. PATCH 18.
> 
> I'd like to reason about it for deferring vunmap TLB flushes:
> 
> What addresses in VMAP range, other than the stack, can early entry code
> access? Yes, the ranges can be checked at runtime, but is there any chance
> of figuring this out e.g. at build-time?

Nadav was touching on a very important point: TLB flushes for addresses
are relatively easy to defer.  You just need to ensure that the CPU
deferring the flush does an actual flush before it might architecturally
consume the contents of the flushed entry.

TLB flushes for freed page tables are another game entirely.  The CPU is
free to cache any part of the paging hierarchy it wants at any time.
It's also free to set accessed and dirty bits at any time, even for
instructions that may never execute architecturally.

That basically means that if you have *ANY* freed page table page
*ANYWHERE* in the page table hierarchy of any CPU at any time ... you're
screwed.

There's no reasoning about accesses or ordering.  As soon as the CPU
does *anything*, it's out to get you.

You're going to need to do something a lot more radical to deal with
free page table pages.
