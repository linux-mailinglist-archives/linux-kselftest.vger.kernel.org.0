Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4A2DEABC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 22:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgLRVHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 16:07:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgLRVHJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 16:07:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608325586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5KbSIN55suX89YOBcIXDM5LxH+O6LLG2triQiwJQEiw=;
        b=lxq0Z0/2O14CTwirAq+bb6fuW6UqCM6iqC8qzHXHLrZfy+sDRGOF/0How3eiSpYti5hyy1
        PPjKqCf3MKtrf7IQYaOFjyuXT4RetV9r+fcaYWFfkisBByb0n0d6/Oz8hpeuclU2liQ+zF
        b9UZig1XjIDtkpFQUGed0hJ9FSlPU8zI3iu4ngwn8ZXccAFZTXAmD+IAi9lNZOjDIv05V6
        0hdumIZXflEtEFfoAyzhRw6zWRPLAlhR2F6ZwRzJTud4+jkuGbq92iptCpTRZzgpYytBBv
        +1bhFOhdCmZjOEKl9Odfaojy3oH3jv/xMNUCbWSAye7FSC970xo3MgIOPjbxaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608325586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5KbSIN55suX89YOBcIXDM5LxH+O6LLG2triQiwJQEiw=;
        b=BngWZDtOpkOjDlsMazPLISfJ/Wv/jD0wklYW3MtSj1b941oW4rqP5E8tjXsT4f09a0QbS1
        JhvFAp2tpTn1qMBA==
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Weiny\, Ira" <ira.weiny@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com> <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de> <878s9vqkrk.fsf@nanos.tec.linutronix.de> <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com>
Date:   Fri, 18 Dec 2020 22:06:24 +0100
Message-ID: <875z4yrfhr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 18 2020 at 11:20, Dan Williams wrote:
> On Fri, Dec 18, 2020 at 5:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> [..]
>>   5) The DAX case which you made "work" with dev_access_enable() and
>>      dev_access_disable(), i.e. with yet another lazy approach of
>>      avoiding to change a handful of usage sites.
>>
>>      The use cases are strictly context local which means the global
>>      magic is not used at all. Why does it exist in the first place?
>>
>>      Aside of that this global thing would never work at all because the
>>      refcounting is per thread and not global.
>>
>>      So that DAX use case is just a matter of:
>>
>>         grant/revoke_access(DEV_PKS_KEY, READ/WRITE)
>>
>>      which is effective for the current execution context and really
>>      wants to be a distinct READ/WRITE protection and not the magic
>>      global thing which just has on/off. All usage sites know whether
>>      they want to read or write.
>
> I was tracking and nodding until this point. Yes, kill the global /
> kmap() support, but if grant/revoke_access is not integrated behind
> kmap_{local,atomic}() then it's not a "handful" of sites that need to
> be instrumented it's 100s. Are you suggesting that "relaxed" mode
> enforcement is a way to distribute the work of teaching driver writers
> that they need to incorporate explicit grant/revoke-read/write in
> addition to kmap? The entire reason PTE_DEVMAP exists was to allow
> get_user_pages() for PMEM and not require every downstream-GUP code
> path to specifically consider whether it was talking to PMEM or RAM
> pages, and certainly not whether they were reading or writing to it.

kmap_local() is fine. That can work automatically because it's strict
local to the context which does the mapping.

kmap() is dubious because it's a 'global' mapping as dictated per
HIGHMEM. So doing the RELAXED mode for kmap() is sensible I think to
identify cases where the mapped address is really handed to a different
execution context. We want to see those cases and analyse whether this
can't be solved in a different way. That's why I suggested to do a
warning in that case.

Also vs. the DAX use case I really meant the code in fs/dax and
drivers/dax/ itself which is handling this via dax_read_[un]lock.

Does that make more sense?

Thanks,

        tglx


