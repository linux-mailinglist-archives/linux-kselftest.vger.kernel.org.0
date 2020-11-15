Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE22B3832
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Nov 2020 19:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKOS6z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Nov 2020 13:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKOS6y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Nov 2020 13:58:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402F8C0613D1;
        Sun, 15 Nov 2020 10:58:54 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605466732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lM+Tn3Xn9woEdnNA0HLgCq49xITc6UQA2eZ6y/GPCoI=;
        b=xy4LEmo+jlz0Jq+PPQQnClThn2BQPP2VK/gIjQk5I2KRckjCj7Drnsna9lksUk/ITpwuTz
        sVtPgVlXN/2E2E21zA1k079EKJvTIkc7ENv9Jftd7gQE3ubTJ+lhaEDKmxMaSAqzp0Qeap
        v+5xHxFsmZoQ2Q87P28QIuKhRzXpFQXzNYo3nNUHhM6WSWz53AGt9Lsfov+OPHZsGOadaf
        k3qd+kTh6nngia5Ch9pnnaw/EQOevyqIT94eHQHLhmzS7VS3uXOdO+MtcdYkJjDzK6r80k
        kNKu19wadW/FwBvJKeK2w/r0iIoagaFIN0IbDi6oaV3zya4QGqNDLRPDOUbzEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605466732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lM+Tn3Xn9woEdnNA0HLgCq49xITc6UQA2eZ6y/GPCoI=;
        b=Qd+mE+OpsEvFKxHyQ2CT5n9hPmnIwB1brU84Jw4XCXyD0Jok+oJLKNA01C+Xh8tdkbW36v
        QVxMvbDeCbijnIDw==
To:     ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 05/10] x86/entry: Pass irqentry_state_t by reference
In-Reply-To: <20201106232908.364581-6-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-6-ira.weiny@intel.com>
Date:   Sun, 15 Nov 2020 19:58:52 +0100
Message-ID: <87mtzi8n0z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ira,

On Fri, Nov 06 2020 at 15:29, ira weiny wrote:

Subject prefix wants to 'entry:'. This changes generic code and the x86
part is just required to fix the generic code change.

> Currently struct irqentry_state_t only contains a single bool value
> which makes passing it by value is reasonable.  However, future patches
> propose to add information to this struct, for example the PKRS
> register/thread state.
>
> Adding information to irqentry_state_t makes passing by value less
> efficient.  Therefore, change the entry/exit calls to pass irq_state by
> reference.

The PKRS muck needs to add an u32 to that struct. So how is that a
problem?

The resulting struct still fits into 64bit which is by far more
efficiently passed by value than by reference. So which problem are you
solving here?

Thanks

        tglx

