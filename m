Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC64CD91A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiCDQ2e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 11:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiCDQ2d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 11:28:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE6DE0AE4;
        Fri,  4 Mar 2022 08:27:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CA8D61D9B;
        Fri,  4 Mar 2022 16:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F54C340E9;
        Fri,  4 Mar 2022 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646411262;
        bh=yZI5SE6Yu+jf7Glt6Q2PXdc260ByZ2le2G+I7rC8g30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhjbWDuzVvPCDeEj1zw4Zlqge7qOxShxUw02Rp0btAvpb5w/0LC8Imq9dZ28tjC8z
         c72oJQxuGOD+ci74xSH+nFhX4jjJu6t9p2vs8g0T/IbuW2kXAsnEFoPIu/iuRtRk1d
         eLhVVIzZ9dW9Bxu1RNAUQN6JNpSGGOO2OoAcstmdr6dEx/z9CjfbGCAvHdqqDHOY9w
         r3NFNerdsKRzeFaCJOJ7CU09WhkuoCDzL2Y6Utx39ZL9IqlRUjMBbX9mlgeNFpgUIB
         d7TUFZXl+R32aSVPO31VJemVXOBVG92w43Zl2aYLFis869e5gYqUYU3M9vvJ7l9LEO
         bbZjRUgnggwDQ==
Date:   Fri, 4 Mar 2022 09:27:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kbuild: Allow a suffix with $(LLVM)
Message-ID: <YiI993aaIYSv23sI@dev-arch.thelio-3990X>
References: <20220302234400.782002-1-nathan@kernel.org>
 <CAK7LNARAPqTaO0Zho0VFib6kxjfpbnvrX-ZwcVPQgES5T8z4qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARAPqTaO0Zho0VFib6kxjfpbnvrX-ZwcVPQgES5T8z4qQ@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 04, 2022 at 08:16:00PM +0900, Masahiro Yamada wrote:
> On Thu, Mar 3, 2022 at 8:47 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > The LLVM make variable allows a developer to quickly switch between the
> > GNU and LLVM tools. However, it does not handle versioned binaries, such
> > as the ones shipped by Debian, as LLVM=1 just defines the tool variables
> > with the unversioned binaries.
> >
> > There was some discussion during the review of the patch that introduces
> > LLVM=1 around versioned binaries, ultimately coming to the conclusion
> > that developers can just add the folder that contains the unversioned
> > binaries to their PATH, as Debian's versioned suffixed binaries are
> > really just symlinks to the unversioned binaries in /usr/lib/llvm-#/bin:
> >
> > $ realpath /usr/bin/clang-14
> > /usr/lib/llvm-14/bin/clang
> >
> > $ PATH=/usr/lib/llvm-14/bin:$PATH make ... LLVM=1
> >
> > However, that can be cumbersome to developers who are constantly testing
> > series with different toolchains and versions. It is simple enough to
> > support these versioned binaries directly in the Kbuild system by
> > allowing the developer to specify the version suffix with LLVM=, which
> > is shorter than the above suggestion:
> >
> > $ make ... LLVM=-14
> >
> > It does not change the meaning of LLVM=1 (which will continue to use
> > unversioned binaries) and it does not add too much additional complexity
> > to the existing $(LLVM) code, while allowing developers to quickly test
> > their series with different versions of the whole LLVM suite of tools.
> >
> > Link: https://lore.kernel.org/r/20200317215515.226917-1-ndesaulniers@google.com/
> > Link: https://lore.kernel.org/r/20220224151322.072632223@infradead.org/
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >
> > RFC -> v1: https://lore.kernel.org/r/Yh%2FegU1LZudfrgVy@dev-arch.thelio-3990X/
> >
> > * Tidy up commit message slightly.
> >
> > * Add tags.
> >
> > * Add links to prior discussions for context.
> >
> > * Add change to tools/testing/selftests/lib.mk.
> >
> > I would like for this to go through the Kbuild tree, please ack as
> > necessary.
> >
> >  Documentation/kbuild/llvm.rst  |  7 +++++++
> >  Makefile                       | 24 ++++++++++++++----------
> >  tools/scripts/Makefile.include | 20 ++++++++++++--------
> >  tools/testing/selftests/lib.mk |  6 +++++-
> >  4 files changed, 38 insertions(+), 19 deletions(-)
> >
> > diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> > index d32616891dcf..5805a8473a36 100644
> > --- a/Documentation/kbuild/llvm.rst
> > +++ b/Documentation/kbuild/llvm.rst
> > @@ -60,6 +60,13 @@ They can be enabled individually. The full list of the parameters: ::
> >           OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
> >           HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
> >
> > +If your LLVM tools have a suffix and you prefer to test an explicit version rather
> > +than the unsuffixed executables, use ``LLVM=<suffix>``. For example: ::
> > +
> > +       make LLVM=-14
> > +
> > +will use ``clang-14``, ``ld.lld-14``, etc.
> > +
> >  The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
> >  disable it.
> 
> 
> Perhaps, it might be worth mentioning the difference between
> LLVM=1 and LLVM=<suffix>
> 
> The current behavior is,
> any value other than '1' is regarded as a suffix.

Maybe just adding something like:

"... prefer to test an explicit version rather than the unsuffixed
executables like above, ..."

? I'll try to come up with a clearer way to word everything for v2.

> > diff --git a/Makefile b/Makefile
> > index a82095c69fdd..963840c00eae 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -424,8 +424,12 @@ HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
> >  HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
> >
> >  ifneq ($(LLVM),)
> > -HOSTCC = clang
> > -HOSTCXX        = clang++
> > +ifneq ($(LLVM),1)
> > +LLVM_SFX := $(LLVM)
> > +endif
> 
> I am OK with this, but please note LLVM=0
> uses 'clang0', 'ld.lld0' instead of disabling
> LLVM explicitly.
> 
> This might be a small surprise because LLVM_IAS=0
> is used to disable the integrated assembler.

Right, but we have that problem right now, as LLVM=0 is currently
treated like LLVM=1. I suppose I could add a line to the documentation
in a follow up change to clarify this.

> If you want handle LLVM=<suffix>
> only when <suffix> start with a hyphen,
> you can do like this:
> 
> ifneq ($(filter -%, $(LLVM)),)
> LLVM_SFX := $(LLVM)
> endif

I did think about this. I guess the only reason I did not do that in
this version is someone might have a different suffix scheme than
Debian's but it is probably better to be a little bit more precise based
on what we know in this moment. I will change it to that and update the
documentation.

> In the future, If somebody requests to support
>     make LLVM=/path/to/my/own/llvm/dir/
> to use llvm tools in that path,
> we can expand the code like this:
> 
> 
> 
> # "LLVM=foo/bar/" is a syntax sugar of "LLVM=1 LLVM_PFX=foo/bar"
> # "LLVM=-foo" is a syntax sugar of "LLVM=1 LLVM_SFX=-foo"
> 
> ifneq ($(filter %/, $(LLVM)),)
> LLVM_PFX := $(LLVM)
> else ifneq ($(filter -%, $(LLVM)),)
> LLVM_SFX := $(LLVM)
> endif

I know I personally I would use the prefix form when testing with LLVM=1
so I think I will just go ahead and support that now, especially since
Peter had aimed to support a full path with his CC patch that we NAK'd.

> Lastly, I personally prefer to fully spell LLVM_SUFFIX
> as Nick originally suggested:
> https://lkml.org/lkml/2020/3/17/1477

Ack, I have changed this locally and I'll send a v2 along shortly once I
have written some documentation to codify these suggested changes.

Thank you for the comments and review, cheers!
Nathan
