Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64D02A3743
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 00:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKBXlO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 18:41:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBXlN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 18:41:13 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604360471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jRvDQIBB8b8SAPT0B0dD6eemT/oEgAx4YjAntCS9bbQ=;
        b=4TF/U7T3YLoTMqN3StcRo2h/phddVV8aM3F/vFj3GZ1c9J98v/ao07Y/guFBkq7kfco6Q5
        nwzblZcW+fWvAPnTM/9Pi3JCFbDH/oee2SNemc40ww1h85qBtsGhyNXu9IaehgxW+38MeI
        jBXZN09HgFcstxGXPmXKg4kAnKExQEpRHdzixm3a7Pyb8tzzmZpcdyXa0LMG83R/WQBBBC
        DNknNZKqOADNmbf7xFJR2xYqn7uHo4jjtpaaOU67VdM8qjkHDMyP40ZjW2+54BSF2i8MzR
        2hf4hAt1eA0wl0EhuwrwdHMsSiI1/VGrodSchj4JVLxkQyr/dc1UASzaeUtcMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604360471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jRvDQIBB8b8SAPT0B0dD6eemT/oEgAx4YjAntCS9bbQ=;
        b=/B7J+2Rz4YQyBg5LQ8YeydLrxZv4W1kG/5V4+h88nIcwLfXPwJLjC8xz3eJoW5bLR4Bf1T
        8gTlvxwU11pWeGAw==
To:     ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS) support
In-Reply-To: <871rhb8h73.fsf@nanos.tec.linutronix.de>
References: <20201102205320.1458656-1-ira.weiny@intel.com> <871rhb8h73.fsf@nanos.tec.linutronix.de>
Date:   Tue, 03 Nov 2020 00:41:11 +0100
Message-ID: <87y2jj72eg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03 2020 at 00:36, Thomas Gleixner wrote:
> On Mon, Nov 02 2020 at 12:53, ira weiny wrote:
>
> This is the wrong ordering, really.
>
>      x86/entry: Move nmi entry/exit into common code
>
> is a general cleanup and has absolutely nothing to do with PKRS.So this
> wants to go first.
>
> Also:
>
>     x86/entry: Move nmi entry/exit into common code

this should be

     x86/entry: Pass irqentry_state_t by reference

of course. Copy&pasta fail...
