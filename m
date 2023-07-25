Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B69761FD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGYRM2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 13:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGYRM0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 13:12:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A558C1718;
        Tue, 25 Jul 2023 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690305145; x=1721841145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fq0MiyGtfdmEy3j11xkXHlesEoaC2GKhOtTrGN15RYs=;
  b=QAHjsUaHOriLvxDau9WpfAXbQoPdZr6Ws3ztbkKz3v/ju1OVCccak5YO
   APcUwkkbVNmqp1onD9nPZ88T9kcgWtadBX/BJxfp106jyJDFVZaYFRMHy
   SE1VbAQvR1knQCRxgYaD/2Yf3Z8OHh8ycI+Cfranw6K6/wYXlk2ryFtbg
   Y13JQvkOyKvhPxz0GZfxhRxJN3QzUy6mVSFBmyAli2Upl5iUp4fYiCDoT
   6t+j1VMvLUwTwu5R1DToj8gLuXZLezld/HSR+BV47mnlrjeX7L1cOyeC9
   koo8mFRmbYtoZEJi5Kj7/VCg3dcQaY6SxhndKcgyZ7F3IiZiFgKGVhJg9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="366675112"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="366675112"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 10:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="720114234"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="720114234"
Received: from chrisper-mobl.amr.corp.intel.com (HELO [10.209.69.88]) ([10.209.69.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 10:12:22 -0700
Message-ID: <abdc2626-d776-e3be-81b5-eca669b6becc@intel.com>
Date:   Tue, 25 Jul 2023 10:12:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 20/20] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Yair Podemsky <ypodemsk@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-21-vschneid@redhat.com>
 <188AEA79-10E6-4DFF-86F4-FE624FD1880F@vmware.com>
 <xhsmh8rb5tui1.mognet@vschneid.remote.csb>
 <2284d0db-f94a-e059-7bd0-bab4f112ed35@intel.com> <ZL/6THDvmC5mVyBI@tpad>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZL/6THDvmC5mVyBI@tpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/25/23 09:37, Marcelo Tosatti wrote:
>> TLB flushes for freed page tables are another game entirely.  The CPU is
>> free to cache any part of the paging hierarchy it wants at any time.
> Depend on CONFIG_PAGE_TABLE_ISOLATION=y, which flushes TLB (and page
> table caches) on user->kernel and kernel->user context switches ?

Well, first of all, CONFIG_PAGE_TABLE_ISOLATION doesn't flush the TLB at
all on user<->kernel switches when PCIDs are enabled.

Second, even if it did, the CPU is still free to cache any portion of
the paging hierarchy at any time.  Without LASS[1], userspace can even
_compel_ walks of the kernel portion of the address space, and we don't
have any infrastructure to tell if a freed kernel page is exposed in the
user copy of the page tables with PTI.

Third, (also ignoring PCIDs) there are plenty of instructions between
kernel entry and the MOV-to-CR3 that can flush the TLB.  All those
instructions architecturally permitted to speculatively set Accessed or
Dirty bits in any part of the address space.  If they run into a free
page table page, things get ugly.

These accesses are not _likely_.  There probably isn't a predictor out
there that's going to see a:

	movq    %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)

and go off trying to dirty memory in the vmalloc() area.  But we'd need
some backward *and* forward-looking guarantees from our intrepid CPU
designers to promise that this kind of thing is safe yesterday, today
and tomorrow.  I suspect such a guarantee is going to be hard to obtain.

1. https://lkml.kernel.org/r/20230110055204.3227669-1-yian.chen@intel.com


