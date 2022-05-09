Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5FA51F8F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiEIJxW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 05:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbiEIJpd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 05:45:33 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707DD27161;
        Mon,  9 May 2022 02:41:36 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso10440034wma.0;
        Mon, 09 May 2022 02:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MIo4iJaNWWiT8L0aREHccyFQKBU+YIpBaS+29bvc/oc=;
        b=CljfGAPOH+8alNnaPgQ/ZfOeWWCyDXqWHuFhGjBWPlxXe37Lt6k538+7qYpiz24Uxh
         wwCnpfootpzp2ttGz1SYDaY7+99KCpsz+fl5o1BG5x26uGCJl7WBi9pFJjh8xxmFF4A6
         sfeVUHaFyqhkPTbuggUYfTosqoZ22ySb3B/8IkPYFoX6Dn/pwD0bemYob/2cu7I+NfHi
         D424KCaeTqVKYsMI1omxqI3JViqArtz2hVFrQUv0MNcYF+W/ts0rP9ccBbXprFueBxqw
         Vtall6hKoE7EYpGehq4xKEj3ijfm1tt/d1HlyDySG+5W0tIiDYhmM5WRzmDIlec7zksg
         pRvQ==
X-Gm-Message-State: AOAM533KIFwgy+QVhvkpxh3AYNikqIrIyQ27BWhMOFcfuqzwOeS77UP1
        /bOyxv5AlGam4Z60i8hhRaI=
X-Google-Smtp-Source: ABdhPJz/KKcTrgbBKiQDbLem0UVallm03r9n1V5yq/fpMjCoclkduFXgbKOowrI9BpO7enF+NSOlDA==
X-Received: by 2002:a7b:c4c8:0:b0:394:26c5:b79e with SMTP id g8-20020a7bc4c8000000b0039426c5b79emr15176076wmk.15.1652089180818;
        Mon, 09 May 2022 02:39:40 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w7-20020adfee47000000b0020c5253d8efsm10503017wro.59.2022.05.09.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 02:39:40 -0700 (PDT)
Date:   Mon, 9 May 2022 09:39:38 +0000
From:   Wei Liu <wei.liu@kernel.org>
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
        linux-riscv@lists.infradead.org, live-patching@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v6 00/23] Rust support
Message-ID: <20220509093938.fdrh5hhhreqi46wn@liuwe-devbox-debian-v2>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <202205070056.ACC3C3D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205070056.ACC3C3D@keescook>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

+1 to both points. :-)
