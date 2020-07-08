Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6F217FF7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 08:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgGHGw1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jul 2020 02:52:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbgGHGw1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jul 2020 02:52:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B597AC1D;
        Wed,  8 Jul 2020 06:52:25 +0000 (UTC)
Date:   Wed, 8 Jul 2020 08:52:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Tal Gilboa <talgi@mellanox.com>, kunit-dev@googlegroups.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kbuild: trace functions in subdirectories of lib/
Message-ID: <20200708065223.GA11164@alley>
References: <20200707092117.963394-1-masahiroy@kernel.org>
 <20200707092117.963394-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707092117.963394-2-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2020-07-07 18:21:17, Masahiro Yamada wrote:
>   ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> 
> exists here in sub-directories of lib/ to keep the behavior of
> commit 2464a609ded0 ("ftrace: do not trace library functions").
> 
> Since that commit, not only the objects in lib/ but also the ones in
> the sub-directories are excluded from ftrace (although the commit
> description did not explicitly mention this).
> 
> However, most of library functions in sub-directories are not so hot.
> Re-add them to ftrace.
> 
> Going forward, only the objects right under lib/ will be excluded.
 
> diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
> index 9abdf615b088..295b94bff370 100644
> --- a/lib/livepatch/Makefile
> +++ b/lib/livepatch/Makefile
> @@ -2,8 +2,6 @@
>  #
>  # Makefile for livepatch test code.
>  
> -ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> -
>  obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
>  				test_klp_callbacks_demo.o \
>  				test_klp_callbacks_demo2.o \

With this change it might be possible to remove also the last few
lines that explicitly added $(CC_FLAGS_FTRACE) for two test modules.

The two modules really needed these flags. But they are fine also
for the other modules.

We could do this later as a followup patch but it would be nice
to do so here.

Best Regards,
Petr

PS: BTW: The livepatch selftests fail in Linus's master now. But it
seems to be for another reason. I am going to dig into it.
