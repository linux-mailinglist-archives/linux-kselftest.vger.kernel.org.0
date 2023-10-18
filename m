Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F87CE0C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjJRPJa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJRPJ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 11:09:29 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4494
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 08:09:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41b19dda4c6so254381cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697641767; x=1698246567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvfWp1C5xv3xuTQ6WUqjUh4zSLJkkTSPfVE2loOXpbY=;
        b=0jEu3mNalZW4sYjmW1SzcVilxuXEYHji310yhmvuXE7NXtCoNiXXrZBkyN11XwBp95
         xef5o23/l9dw2F19XFwatSK6tyykDsd+ZBv2cc80OQQqqVIrosuIujuo/s/4FTzzA+P4
         klXTf4U5Xn2F08Tqfy8ay/AVMdx/c4xgaiqF5qb7D53fjINkmLT9dYPXnHwdp4aXPcgA
         nYQwvAqMrjEnWLBpXCUvunD64YfG3N0yPfz3neRg2060IUhGDXsg9djK50ix4yZcu89G
         +Hyi38JTvsKkX6LPRi2widzY76CcSpTiDTDvFMvSd1C8OfruQ23WsucLw5eyyIWEyJpL
         DnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641767; x=1698246567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvfWp1C5xv3xuTQ6WUqjUh4zSLJkkTSPfVE2loOXpbY=;
        b=XnNJc788Qa9rb55tr60gw0QB05RAPdaOnHmFUUFiNzyN10gLRE+guL1dwTCGGkJINO
         9OPJed+sselhVgvAxsCREDz1mh9Uzw5ZOHdl5tbBLdQiIekUxgvhlnLT2acKFzB3taxX
         tEtbm7R/TGcvfOMNB7AiH9qrPTVzdi+s2Fj/XC5e2NLF60VcOlvgN2WoLt7AjMjIAOaR
         kPblHuuOLqsYjx8iYPEe37F4eMh2fjUS40h/zb3GN7Olhu9OZD1ack+MfB+Rvb4/NhQF
         mJ5a/rF3Y4tkLUtgRUCseOSzTXVBi+ktrJEa/c+DfKmuEYYdkBCrrH9uW5awSnzA9A95
         x6YA==
X-Gm-Message-State: AOJu0YyTs35VYU53h8x8P5e2JRmG6LgqyeD5TcN9k01zyZ9HUUBeetD1
        uO8GHp9wQwTT6nhrUJbFLW1NuuEGkfmZ1u2QDJN5Lw==
X-Google-Smtp-Source: AGHT+IFgbm8y7iUUT1tE/b9dwff4sTV8f+SQuOOmoj4EcmFYIHZ0gjVlcjmYUYdkCnzE862dRzyTETqhK35IYA7Fv4k=
X-Received: by 2002:ac8:4b75:0:b0:410:9d31:68cd with SMTP id
 g21-20020ac84b75000000b004109d3168cdmr221871qts.27.1697641766704; Wed, 18 Oct
 2023 08:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-6-jeffxu@chromium.org>
 <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
In-Reply-To: <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 18 Oct 2023 08:08:49 -0700
Message-ID: <CALmYWFux2m=9189Gs0o8-xhPNW4dnFvtqj7ptcT5QvzxVgfvYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/8] mseal: Check seal flag for munmap(2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 9:54=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 17 Oct 2023 at 02:08, <jeffxu@chromium.org> wrote:
> >
> > Of all the call paths that call into do_vmi_munmap(),
> > this is the only place where checkSeals =3D MM_SEAL_MUNMAP.
> > The rest has checkSeals =3D 0.
>
> Why?
>
> None of this makes sense.
>
> So you say "we can't munmap in this *one* place, but all others ignore
> the sealing".
>
I apologize that previously, I described what this code does, and not reaso=
ning.

In our threat model, as Stephen R=C3=B6ttger point out in [1], and I quote:

V8 exploits typically follow a similar pattern: an initial bug leads
to memory corruption but often the initial corruption is limited and
the attacker has to find a way to arbitrarily read/write in the whole
address space.

The memory correction is in the user space process, e.g. Chrome.
Attackers will try to modify permission of the memory, by calling
mprotect,  or munmap then mmap to the same address but with different
permission, etc.

Sealing blocks mprotect/munmap/mremap/mmap call from the user space
process, e.g. Chrome.

At time of handling those 4 syscalls, we need to check the seal (
can_modify_mm), this requires locking the VMA (
mmap_write_lock_killable), and ideally, after validating the syscall
input. The reasonable place for can_modify_mm() is from utility
functions, such as do_mmap(), do_vmi_munmap(), etc.

However, there is no guarantee that do_mmap() and do_vmi_munmap() are
only reachable from mprotect/munmap/mremap/mmap syscall entry point
(SYSCALL_DEFINE_XX). In theory,  the kernel can call those in other
scenarios, and some of them can be perfectly legit. Those other
scenarios are not covered by our threat model at this time. Therefore,
we need a flag, passed from the SYSCALL_DEFINE_XX entry , down to
can_modify_mm(), to differentiate those other scenarios.

Now, back to code, it did some optimization, i.e. doesn't pass the
flag from SYSCALL_DEFINE_XX  in all cases. If SYSCALL_DEFINE_XX calls
do_a, and do_a has only one caller, I will set the flag in do_a,
instead of SYSCALL_DEFINE_XX. Doing this reduces the size of the
patchset, but it also makes the code less readable indeed. I could
remove this optimization in V3. I welcome suggestions to improve
readability on this.

When handing the mmap/munmap/mremap/mmap, once the code passed
can_modify_mm(), it means the memory area is not sealed, if the code
continues to call the other utility functions, we don't need to check
the seal again. This is the case for mremap(), the seal of src address
and dest address (when applicable) are checked first, later when the
code calls  do_vmi_munmap(), it no longer needs to check the seal
again.

[1] https://v8.dev/blog/control-flow-integrity

-Jeff
