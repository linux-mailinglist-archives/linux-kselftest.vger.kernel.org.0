Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344B92708B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Sep 2020 00:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIRWAu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgIRWAu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 18:00:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC2C0613D0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 15:00:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so4302238pfi.4
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JxUdFoGAxFplTWGtoXNZgS71eI4uX7HGfO5ucGAc8lo=;
        b=F3F4STQx9TEbezd5dpqkh+1WgHncbTN/t8oI9gLXFGTIZBF4umVMyWZs6/5SC4DPNe
         BdEswkxGJNvw8UKNxsjmhcgGCOWOfL+FnYmzid7dcH3dg8ENtuW1e1zau+x+4ZWOfwET
         oYzijV7/xANP6xFwAgQjhsqbAUPQauG787ODk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JxUdFoGAxFplTWGtoXNZgS71eI4uX7HGfO5ucGAc8lo=;
        b=A7O4BHCNkR8iJH+Jn3SxwVf6hDmS9+A0BWIGa3DzGr/Yq9Wxxl38V/DtOiKTF5vJAr
         cZe0MM16ee6fWRP2fE3C6Sq4Ey7qkcpXJpCdRv/qpKz/syURldRdaTM131oFQYYN0nyn
         7V0NBsHexg8ctCGHGOksGqsrJXs553Y8w+uvPbDzUlt7XrxLPBVRm9sGn5Iuq0JU8SkY
         +KRMznXMPeG72/bohxpGqsNzSoaHFK9JD0Fv4ZS7iwijH2XBzqyhNVV7qkmK+ghAK6Vr
         5AZoqQ1SoOA3H2nnh4p2sPuyvnPLY/e7wGyayJuIAqy8YCOiE4kmkGb2ljvHb4Uwju9i
         NHFw==
X-Gm-Message-State: AOAM532kgwbNWeE2UlQvxHlhAjD0ZeI1ksDDwvXLxs3T+YPRo6l8vbKY
        5surXr4VpuNbqpHlt/0+AAQaSg==
X-Google-Smtp-Source: ABdhPJw0uH7wi+N0H7/B8Z1EuUZoi1IOCarbau2BnWaa5f2mRZZbuRvvXpA7+ce1jDkK2XKWqANrBA==
X-Received: by 2002:a63:5b5c:: with SMTP id l28mr1381997pgm.243.1600466449680;
        Fri, 18 Sep 2020 15:00:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v204sm4236125pfc.10.2020.09.18.15.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 15:00:48 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:00:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 14/15] selftests/clone3: Avoid OS-defined clone_args
Message-ID: <202009181500.9A560349@keescook>
References: <20200912110820.597135-1-keescook@chromium.org>
 <20200912110820.597135-15-keescook@chromium.org>
 <20200915162528.x7admy45pdqsoke4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200915162528.x7admy45pdqsoke4@wittgenstein>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 15, 2020 at 06:25:28PM +0200, Christian Brauner wrote:
> On Sat, Sep 12, 2020 at 04:08:19AM -0700, Kees Cook wrote:
> > As the UAPI headers start to appear in distros, we need to avoid
> > outdated versions of struct clone_args to be able to test modern
> > features. Additionally pull in the syscall numbers correctly.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Hm, with this patch applied I'm getting:
> 
> gcc -g -I../../../../usr/include/    clone3_set_tid.c /home/brauner/src/git/linux/linux/tools/testing/selftests/kselftest_harness.h /home/brauner/src/git/linux/linux/tools/testing/selftests/kselftest.h -lcap -o /home/brauner/src/git/linux/linux/tools/testing/selftests/clone3/clone3_set_tid
> In file included from clone3_set_tid.c:24:
> clone3_selftests.h:37:8: error: redefinition of ‘struct clone_args’
>    37 | struct clone_args {
>       |        ^~~~~~~~~~
> In file included from clone3_set_tid.c:12:
> /usr/include/linux/sched.h:92:8: note: originally defined here
>    92 | struct clone_args {
>       |        ^~~~~~~~~~
> make: *** [../lib.mk:140: /home/brauner/src/git/linux/linux/tools/testing/selftests/clone3/clone3_set_tid] Error 1

Hm, weird.

> One trick to avoid this could be:
> 
> #ifndef CLONE_ARGS_SIZE_VER0
> #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
> #endif
> 
> #ifndef CLONE_ARGS_SIZE_VER1
> #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
> #endif
> 
> #ifndef CLONE_ARGS_SIZE_VER2
> #define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
> #endif
> 
> struct __clone_args {
> 	__aligned_u64 flags;
> 	__aligned_u64 pidfd;
> 	__aligned_u64 child_tid;
> 	__aligned_u64 parent_tid;
> 	__aligned_u64 exit_signal;
> 	__aligned_u64 stack;
> 	__aligned_u64 stack_size;
> 	__aligned_u64 tls;
> 	__aligned_u64 set_tid;
> 	__aligned_u64 set_tid_size;
> 	__aligned_u64 cgroup;
> };
> 
> static pid_t sys_clone3(struct __clone_args *args, size_t size)
> {
> 	return syscall(__NR_clone3, args, size);
> }

Yeah, that has fewer down sides. I'll rework it.

-- 
Kees Cook
