Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72CB734112
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jun 2023 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFQNBk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Jun 2023 09:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjFQNBj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Jun 2023 09:01:39 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CDE1BDF;
        Sat, 17 Jun 2023 06:01:37 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-43f5fbfe64cso682869137.1;
        Sat, 17 Jun 2023 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687006896; x=1689598896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0JhkG8Ht4S5L7KjgiH+UNafz92nKUbHli1tDVoL2P3E=;
        b=R/zJufvxo+hvz4kQPs6SlbF2LkgJIwj7zbs36vlWfd9cqqTowNXKtRFuKDB5pwpKYF
         z2z6h6+mQ31cpXybXdFw6kH8JgNqiWT7+tGxaezdmFNxf7vvOZCDzOFrOoPCKPk5kO0/
         4H/0A8nLOCOrVM5vuo4GKxgbVZORa5vp02rk+LVKCrMTofTwDFrOK1iUhGqBM5+M16jh
         DYpPk5UFdOJUjTgdjz2IKU28sDfJlUrqRUkzDXtug3lGAn0nX6/ZtVQfzxlfXDRXac+r
         PyHMBHKL/JsZQD/igRWZj99kmTG25YaXv+zTagJaOQwGDk3rKnJwtfvZlihuS82nDWqr
         Uw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687006896; x=1689598896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JhkG8Ht4S5L7KjgiH+UNafz92nKUbHli1tDVoL2P3E=;
        b=eNv6un+hIsx4c56hz/qO6/jgdd3aJzUEI4or+rgmtL+wA+Uz7hlBpRjusK7R2SDnz6
         cYXBzq0CPPmAHpuP2WsqyxaoYezZ5+xUWyM9+MhOSDMeWAYTI952WAI9Bm3Oqa0uMxSI
         A4/lbb0Faa2K0pgJqD53++kr24eupUuOO+zc732LeEgCKOWROq5u+JaucJmDvid08nnA
         c8L+vhAXK2QP/AAJTHO2c5wTC46Qu7SJggng7/LNHZfQf8GrCDQdHbK7WsL5lh0UJySD
         eyPkPUUsA/xRyrqf555whmKYsf2onOpVmhJmoMcmedDzYnQfwpD2BeoQtmnVBwYJ2viG
         +DMg==
X-Gm-Message-State: AC+VfDzdJ3LXr+c15DCi7LLaoEfJYcolrIb+tCjsDl3DvZnEmUZG4uIi
        nLm+9UYa4HVpVYLjA+SKDS5gjEh3ngWUO+OZuic=
X-Google-Smtp-Source: ACHHUZ5zaMR5nGsVQslvoYtPWgS/LlKC3Oltx6OzHl7/AvyujsTd2uKKRe5AQanNXS8pzKe8P7Yz8/YcSemgpCLarJw=
X-Received: by 2002:a67:db8e:0:b0:440:9a48:3772 with SMTP id
 f14-20020a67db8e000000b004409a483772mr1113451vsk.8.1687006895790; Sat, 17 Jun
 2023 06:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230607153600.15816-1-osmtendev@gmail.com> <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
 <CAK6rUAMODPLQeUawXMW_RNiJFdukOqdhS5GA5XRAq4U9bnQdNg@mail.gmail.com> <3c03e28b-8006-a4ac-30bc-6aaf83ccb5d5@linuxfoundation.org>
In-Reply-To: <3c03e28b-8006-a4ac-30bc-6aaf83ccb5d5@linuxfoundation.org>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Sat, 17 Jun 2023 18:01:24 +0500
Message-ID: <CAK6rUAObT-kQVGddhvxxtaKPcuaDddM6ipEDXuECCFtpR-GV6w@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Yes, I did install the latest kernel headers and TASK_COMM_LEN is not
accessible in userspace.

I looked into the test which uses TASK_COMM_LEN but the test defines
it in its own header file.

Example:  https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/progs/pyperf.h#L13

TASK_COMM_LEN is defined in include/linux/sched.h, but this header
file is not exposed to userspace.

TASK_COMM_LEN is not defined in /include/uapi/linux/sched.h which is
exposed to userspace kernel headers.
Please find the link to the header file exposed to user space :-
-https://elixir.bootlin.com/linux/v5.15.116/source/include/uapi/linux/sched.h

As for arm64/abi/tpidr2.c It includes linux/sched.h which will be
/include/uapi/linux/sched.h because the user space program is
including it.
So it also cannot use TASK_COMM_LEN directly.

Regards,
Osama

On Tue, 13 Jun 2023 at 02:56, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 6/10/23 07:01, Osama Muhammad wrote:
> > Hi all,
> >
> > I looked into it and tried to use TASK_COMM_LEN in the test. Even
> > though I included "linux/sched.h '', I was not able to compile the
> > test because it couldn't find it in the header file.
> > I dived deep into the issue and turns out header file mapped in
> > /usr/include/linux/sched.h is actually mapped to
> > /include/uapi/linux/sched.h[1] in linux source,
> > where TASK_COMM_LEN is not even defined. Instead TASK_COMM_LEN is
> > defined in /include/linux/sched.h which is not mapped to any header
> > files in
> > userspace(/(/usr/include/linux).
> > I also tried to find the TASK_COM_LEN in /usr/include/linux/ but I
> > couldn't find it. Following are the search results.
> > grep -rnw '/usr/include/linux/' -e 'TASK_COMM_LEN"
> > RESULTS OF COMMAND :- /usr/include/linux/taskstats.h:38:#define
> > TS_COMM_LEN 32 /* should be >= TASK_COMM_LEN
> > Based on this information, I have two questions:
> > 1. Would this require a fix to move 'TASK_COMM_LEN' macro from
> > /include/linux/sched.h to UAPI headers /include/uapi/linux/sched.h.
> > 2. Is there any other way to access TASK_COMM_LEN in the selftest that
> > I'm not aware of?
> >
> > [1]:-https://elixir.bootlin.com/linux/v5.15.116/source/include/uapi/linux/sched.h
> >
>
> The best source is Linux mainline.
>
> Take a look at test files that include linux/sched.h
>
> arm64/abi/tpidr2.c is one of them.
>
> Did you install headers before compiling the test?
>   make headers_install
>
> thanks,
> -- Shuah
>
>
