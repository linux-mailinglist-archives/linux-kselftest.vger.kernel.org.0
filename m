Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795851F01E
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 May 2022 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiEHTUt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 May 2022 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbiEHSKH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 May 2022 14:10:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1987663B4;
        Sun,  8 May 2022 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dXIZlnwHK15rrJZENweUDVLbVsO7X3h09BOXkfnZAVs=; b=BeB2FaaWyCXFJfYPOVlGrRxyyh
        JkDouCOTyf7MkyluZIxxnUmR87Z/DW0C77jKJIqfoUoI4nPE1ilfTi9PvRLwTXhJhdLROFvWDHHMp
        000VX4SrbogSTZvQ4ISTjHh4zNfXVtbK/k9ItAde5GaNKad/et01ucOFYnGCdxFOMk8ivYtMYUiOa
        LxiuMlpYfAy3bAi35IgiKblbkjCiRIRjJVG9azAjXg28jNJSRdKKWlpLRQquoU1LzZCBVcNqNjl2k
        T6r3MF4ww2+rXqRroJFYp5Aw18fci0MKTzKr92fIKjYfvoNR8En2Q9Oq1MQTSBonEX0blOhFfkm3u
        xJL5hOLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnlIH-002hid-TS; Sun, 08 May 2022 18:06:09 +0000
Date:   Sun, 8 May 2022 19:06:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v6 00/23] Rust support
Message-ID: <YngGkZTy+byxnD5n@casper.infradead.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <202205070056.ACC3C3D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205070056.ACC3C3D@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 07, 2022 at 01:06:18AM -0700, Kees Cook wrote:
> On Sat, May 07, 2022 at 07:23:58AM +0200, Miguel Ojeda wrote:
> > ## Patch series status
> > 
> > The Rust support is still to be considered experimental. However,
> > support is good enough that kernel developers can start working on the
> > Rust abstractions for subsystems and write drivers and other modules.
> 
> I'd really like to see this landed for a few reasons:
> 
> - It's under active development, and I'd rather review the changes
>   "normally", incrementally, etc. Right now it can be hard to re-review
>   some of the "mostly the same each version" patches in the series.
> 
> - I'd like to break the catch-22 of "ask for a new driver to be
>   written in rust but the rust support isn't landed" vs "the rust
>   support isn't landed because there aren't enough drivers". It
>   really feels like "release early, release often" is needed here;
>   it's hard to develop against -next. :)
> 
> Should we give it a try for this coming merge window?

I'm broadly in favour of that.  It's just code, we can always drop it
again or fix it.  There's sufficient development community around it
that it's hardly going to become abandonware.

