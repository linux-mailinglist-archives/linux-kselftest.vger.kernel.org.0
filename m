Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788A3228DE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgGVCLU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 22:11:20 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:32111 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbgGVCLU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 22:11:20 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 06M2AmTB032054;
        Wed, 22 Jul 2020 11:10:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 06M2AmTB032054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1595383849;
        bh=Aih6VBubiSXnprivmgnxaVTSC58fZZfIbh+5AaCTBIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EK80SaE1oXZzPoKURYSTxTH+hxVXKvKr12Tsuy/FX5trsgAahkshxC3XvvjFV8sKp
         kvotbDYshJF+qwdVkQQYifZ3+p5XbQPCpf7NpGo6h/4SAC4fDPF0PE7zVmWgGQMSC5
         0m3wOAfD08HO837L/IdMOPyCR2dKjbl3qXPXwhL5F0NcX88G6GCXNdaRnxw3rmBmWQ
         0lpwHzpXbHChzvgzNs9gUkl7CDhLTAd2xKp4S7Wkpizq8GR3wjLLfzLcwl7EVGVrXO
         PQ9Ye5lj1XuTXoMaojlnlT72b0Qcj48tzNwqpLcZdjIYZEGDOIjehke/+UON54o26F
         j1ed1QcFQuTWg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id m6so308180vsl.12;
        Tue, 21 Jul 2020 19:10:49 -0700 (PDT)
X-Gm-Message-State: AOAM532hd9TXd3U8NO2/v9pvDAN9mdt0OZd3LJx5Zq7WAOv5BRj84pde
        7NZZ1/ng5/lcAMkqR1JZfeK2M8EM97RlQlziUfo=
X-Google-Smtp-Source: ABdhPJxePnkwQjGrTtR0b/vKzaaoGDrx5Lo9YH6/7fWyDIDmz0k8/gl81kgwfi+UC9Pxo7G80Dx5Q555MuZEA4oNWjo=
X-Received: by 2002:a67:2e4d:: with SMTP id u74mr21559012vsu.215.1595383847947;
 Tue, 21 Jul 2020 19:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707092117.963394-1-masahiroy@kernel.org> <20200707092117.963394-2-masahiroy@kernel.org>
 <20200708065223.GA11164@alley> <20200708092324.GA4751@alley>
In-Reply-To: <20200708092324.GA4751@alley>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Jul 2020 11:10:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFTzfx772bTUnLxbN9pwyX3=H284cg-YWKc3YUY9_8KA@mail.gmail.com>
Message-ID: <CAK7LNARFTzfx772bTUnLxbN9pwyX3=H284cg-YWKc3YUY9_8KA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: trace functions in subdirectories of lib/
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 8, 2020 at 6:23 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2020-07-08 08:52:23, Petr Mladek wrote:
> >
> > PS: BTW: The livepatch selftests fail in Linus's master now. But it
> > seems to be for another reason. I am going to dig into it.
>
> JFYI, the livepatch selftests are actually working. I have messed
> the testing here. I am sorry for the noise.
>
> Best Regards,
> Petr

No worry, thank you for testing this patch.


I deleted the following two lines,
otherwise $(CC_FLAGS_FTRACE) would be added twice.

# Target modules to be livepatched require CC_FLAGS_FTRACE
CFLAGS_test_klp_callbacks_busy.o       += $(CC_FLAGS_FTRACE)
CFLAGS_test_klp_callbacks_mod.o                += $(CC_FLAGS_FTRACE)




-- 
Best Regards
Masahiro Yamada
