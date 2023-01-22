Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3F6770A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jan 2023 17:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjAVQkz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Jan 2023 11:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAVQky (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Jan 2023 11:40:54 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF65B193E5;
        Sun, 22 Jan 2023 08:40:53 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id q15so8028037qtn.0;
        Sun, 22 Jan 2023 08:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05DRwYLuKPNybBZTc2206qYE9TZgh2rdWBVkpwkOzJ0=;
        b=A8GGQ75mKCkHCPmZFV3cVLEJgz45RxIhvimMNuHQbqa3F1hlyIEqCJYyaYIXaLkb/q
         r1U1EAAldMxjZ4Lr7V1GsKJEfojWTV8h8QxPu6eK96R6ll6cI59v2oepU2PGOoZ1/9sU
         D7TQ0JQkm3Gx5r0wz6Z4ZN+VbPviRvkGkF7MyAv/OxjZlD4K6L/sX25jbOK/35/7Thja
         f6UwhdhOkKjpLIO/CYkZSxPSSgF1yN5DVC84LMwHYUrnTje4ddUZ8g1khb05RjyRLeZ0
         6jxbL65BFi7h0nhIUgbsm2GRm8JBqchw2k+p6/hbBr2O4auV/kvmEIJGkKumKow12vKf
         tY7Q==
X-Gm-Message-State: AFqh2kpFmTQQAcWOgHGoQPwRoI+gR4/SGEdvQmXf+LjbO/5EV6GNWaj6
        uKI/eXADlUTgZ/MxqCFYeEFbk/oFFIn8Zw==
X-Google-Smtp-Source: AMrXdXt56zWlt1UrPh9C8DjE1rii7b15j8o4rhAwC+uwP6lgPZcFbNs6gQoa7ltikAFKRLay+nnzWw==
X-Received: by 2002:a05:622a:4319:b0:3b6:5fc7:f554 with SMTP id el25-20020a05622a431900b003b65fc7f554mr24229269qtb.7.1674405652705;
        Sun, 22 Jan 2023 08:40:52 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id r18-20020a05620a299200b006cebda00630sm30140670qkp.60.2023.01.22.08.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 08:40:52 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id c124so12127597ybb.13;
        Sun, 22 Jan 2023 08:40:52 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr1914368ybo.380.1674405651979; Sun, 22
 Jan 2023 08:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20230112035529.13521-1-schmitzmic@gmail.com> <20230112035529.13521-4-schmitzmic@gmail.com>
In-Reply-To: <20230112035529.13521-4-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 22 Jan 2023 17:40:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNxLwv8eQRCxSPh6J26gEaMzS=1w6s5zTBWGnnNzmmiA@mail.gmail.com>
Message-ID: <CAMuHMdUNxLwv8eQRCxSPh6J26gEaMzS=1w6s5zTBWGnnNzmmiA@mail.gmail.com>
Subject: Re: [PATCH v13 3/3] tools/testing - seccomp test fixes for m68k
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CC linux-kselftest

On Thu, Jan 12, 2023 at 4:55 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Add m68k seccomp definitions to seccomp_bpf self test code.
>
> Tested on ARAnyM.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> --
> Changes from v12:
>
> Michael Karcher:
> - use correct definition of ARCH_REGS (use of struct pt_regs
>   cause stack overflow on passing register set to user space
>   due to size mismatch, and has some register offsets wrong)

Thanks for the update!
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.3 branch.

> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -138,6 +138,8 @@ struct seccomp_data {
>  #  define __NR_seccomp 337
>  # elif defined(__sh__)
>  #  define __NR_seccomp 372
> +# elif defined(__mc68000__)
> +#  define __NR_seccomp 380
>  # else
>  #  warning "seccomp syscall number unknown for this architecture"
>  #  define __NR_seccomp 0xffff
> @@ -1838,6 +1840,10 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  # define ARCH_REGS             struct pt_regs
>  # define SYSCALL_NUM(_regs)    (_regs).regs[3]
>  # define SYSCALL_RET(_regs)    (_regs).regs[0]
> +#elif defined(__mc68000__)
> +# define ARCH_REGS     struct user_regs_struct
> +# define SYSCALL_NUM(_regs)    (_regs).orig_d0
> +# define SYSCALL_RET(_regs)    (_regs).d0
>  #else
>  # error "Do not know how to find your architecture's registers and syscalls"
>  #endif
> @@ -1902,7 +1908,7 @@ const bool ptrace_entry_set_syscall_ret =
>   * Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
>   * architectures without HAVE_ARCH_TRACEHOOK (e.g. User-mode Linux).
>   */
> -#if defined(__x86_64__) || defined(__i386__) || defined(__mips__)
> +#if defined(__x86_64__) || defined(__i386__) || defined(__mips__) || defined(__mc68000__)
>  # define ARCH_GETREGS(_regs)   ptrace(PTRACE_GETREGS, tracee, 0, &(_regs))
>  # define ARCH_SETREGS(_regs)   ptrace(PTRACE_SETREGS, tracee, 0, &(_regs))
>  #else

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
