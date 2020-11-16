Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7452B52B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 21:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgKPUg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 15:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730895AbgKPUg0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 15:36:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90206C0613CF;
        Mon, 16 Nov 2020 12:36:26 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605558985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXSHVKbd8G8tskYWByySCiOR7/WBbSL8QPOWjVNEWvc=;
        b=iXDImUK3RinKYmmlQOfDDW4hI6pAtsc1AtcOeOZ8UQQ2fBZgWm1Zia9Npot9r5YJ/IVEm7
        /FmfSLTy7hfavoIAbBXp+wh7I7zDMTKofH87R5kGS1pGzuEYbBVufB103vcXwCLIJp8HVq
        DGTJ41tJsAtRK9CxPHkPnRuZU62IcLVInGq+hBPUHZGIAYB+IfzGFyGzBRHiHDB706uvN0
        KY5/G2VChYFgwPjjsQtfvAUEkdUWeBqEAgFpMR4sFeY6tI50WGsO2901uTtixfWL4kPqYw
        tg/uu2fWLw+K5ga4ECaTZd7lpke0jg8ZUwm/ifvsvjTZBg2wGqSqU7nfydd8Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605558985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXSHVKbd8G8tskYWByySCiOR7/WBbSL8QPOWjVNEWvc=;
        b=IuQwfP8hVspbuZD5CWYGKGeEGWiCjNyd1bMK4ypFeE1jL5NUVm0Phzi/t2Y7+U89FU7CF2
        vOEu5WKh27Fa2wDw==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 05/10] x86/entry: Pass irqentry_state_t by reference
In-Reply-To: <20201116184916.GA722447@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-6-ira.weiny@intel.com> <87mtzi8n0z.fsf@nanos.tec.linutronix.de> <20201116184916.GA722447@iweiny-DESK2.sc.intel.com>
Date:   Mon, 16 Nov 2020 21:36:24 +0100
Message-ID: <87lff1xcmv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ira,

On Mon, Nov 16 2020 at 10:49, Ira Weiny wrote:
> On Sun, Nov 15, 2020 at 07:58:52PM +0100, Thomas Gleixner wrote:
>> > Currently struct irqentry_state_t only contains a single bool value
>> > which makes passing it by value is reasonable.  However, future patches
>> > propose to add information to this struct, for example the PKRS
>> > register/thread state.
>> >
>> > Adding information to irqentry_state_t makes passing by value less
>> > efficient.  Therefore, change the entry/exit calls to pass irq_state by
>> > reference.
>> 
>> The PKRS muck needs to add an u32 to that struct. So how is that a
>> problem?
>
> There are more fields to be added for the kmap/pmem support.  So this will be
> needed eventually.  Even though it is not strictly necessary in the next patch.

if you folks could start to write coherent changelogs with proper
explanations why something is needed and why it's going beyond the
immediate use case in the next patch, then getting stuff sorted would be
way easier.

Sorry my crystalball got lost years ago and I'm just not able to keep up
with the flurry of patch sets which have dependencies in one way or the
other.

>> The resulting struct still fits into 64bit which is by far more
>> efficiently passed by value than by reference. So which problem are you
>> solving here?
>
> I'm getting ahead of myself a bit.  I will be adding more fields for the
> kmap/pmem tracking.
>
> Would you accept just a clean up for the variable names in this patch?  I could
> then add the pass by reference when I add the new fields later.  Or would an
> update to the commit message be ok to land this now?

Can you provide a coherent explanation for the full set of things which
needs to be added here first please?

Thanks,

        tglx
