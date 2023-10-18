Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0995D7CE40E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 19:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjJRROm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 13:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJRROl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 13:14:41 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7655114
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 10:14:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41b19dda4c6so10861cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697649279; x=1698254079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxyGP1aBivHX+AXORIadgXhguJIarGguet1dgSguQtQ=;
        b=hMh+AtPXbOLlCOMOk1bJIuiKgIrFaWev5dVIPjVvZbUc383ON12sf1zqHY+CywqTTR
         5kod30imCKWk29UIxMLZqeV5v+fA6QJya83nZXmlZ5e96KeOZ94A9sei38WJaverrHb1
         UD/Es20kPRerxiIvIKLjxm5v/AWkYbHdrsnxKkMMbFERGhXOePTuYPx8z6OOkhNOa3dv
         NLoq3brL+zxqPX5XNxGPr3VsGQmTht7JW1ls2WFLQ3WZcUkRGrtP4OHJe+v2REq4NxI+
         y3wwgbfA49RlUedhKb3/4EvoqfveNyLHsfpEywyU4Rcxxnz2R9GuRCBWrumiNp+ZmNbc
         baPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697649279; x=1698254079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxyGP1aBivHX+AXORIadgXhguJIarGguet1dgSguQtQ=;
        b=CMs0MkYEuxYNQghi4n3J6SBUWAqYpFiotD5mhkdXh2HRqIN6bCtNL3X8W5BhHY8+lL
         UpkX5MqZq8A/3pdwe2MX9UykauVHjtny+KmdoKl8fAbtEhdxQIchkZnScvqHTb3c0ION
         kxEalGOx+08W6DpSw4UFhV++sstV0aeXU+CMoMCRoil8+C0S98NLNR+Wk160lxSBaH4e
         kV5bMcCjSb9ykEqJj1agiw0Txier7DCrDJ8A4hbTfwwEd11zCbEkI3FLJAOLiuK+8CXe
         Gtovshly6CXQC3GK3l+ZZiCRgvcx4yLTJKCBph0+sidQUXp87xhWYhYOLjL8MtEBgxQ8
         4XZw==
X-Gm-Message-State: AOJu0Yzee8nK7EDSBEKTIj9F/sE8iClJ/7oCNPi7wz9cVe8BWRpMKqdz
        k55AqNUhP6HUlGN26sdhIvBbQIdZB7lbgfA4+qWVbA==
X-Google-Smtp-Source: AGHT+IEx8unH0tTtFuD3qM/gmmzwuSTL87BuIGpNM0vGMDgmYaSjk/NG4CaQxYRwo+pn8/4o0oj3+4jWGdf0BWNNry4=
X-Received: by 2002:ac8:4d4a:0:b0:41b:aedb:a82d with SMTP id
 x10-20020ac84d4a000000b0041baedba82dmr15384qtv.28.1697649278489; Wed, 18 Oct
 2023 10:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-6-jeffxu@chromium.org>
 <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com> <CALmYWFux2m=9189Gs0o8-xhPNW4dnFvtqj7ptcT5QvzxVgfvYQ@mail.gmail.com>
In-Reply-To: <CALmYWFux2m=9189Gs0o8-xhPNW4dnFvtqj7ptcT5QvzxVgfvYQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 18 Oct 2023 10:14:02 -0700
Message-ID: <CALmYWFvgM7DOihdUpUC5SREhUMn9t53HYCX+YioeHHhLSD1KHw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 18, 2023 at 8:08=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrote:
>
> On Tue, Oct 17, 2023 at 9:54=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, 17 Oct 2023 at 02:08, <jeffxu@chromium.org> wrote:
> > >
> > > Of all the call paths that call into do_vmi_munmap(),
> > > this is the only place where checkSeals =3D MM_SEAL_MUNMAP.
> > > The rest has checkSeals =3D 0.
> >
> > Why?
> >
> > None of this makes sense.
> >
> > So you say "we can't munmap in this *one* place, but all others ignore
> > the sealing".
> >
> I apologize that previously, I described what this code does, and not rea=
soning.
>
> In our threat model, as Stephen R=C3=B6ttger point out in [1], and I quot=
e:
>
> V8 exploits typically follow a similar pattern: an initial bug leads
> to memory corruption but often the initial corruption is limited and
> the attacker has to find a way to arbitrarily read/write in the whole
> address space.
>
> The memory correction is in the user space process, e.g. Chrome.
> Attackers will try to modify permission of the memory, by calling
> mprotect,  or munmap then mmap to the same address but with different
> permission, etc.
>
> Sealing blocks mprotect/munmap/mremap/mmap call from the user space
> process, e.g. Chrome.
>
> At time of handling those 4 syscalls, we need to check the seal (
> can_modify_mm), this requires locking the VMA (
> mmap_write_lock_killable), and ideally, after validating the syscall
> input. The reasonable place for can_modify_mm() is from utility
> functions, such as do_mmap(), do_vmi_munmap(), etc.
>
> However, there is no guarantee that do_mmap() and do_vmi_munmap() are
> only reachable from mprotect/munmap/mremap/mmap syscall entry point
> (SYSCALL_DEFINE_XX). In theory,  the kernel can call those in other
> scenarios, and some of them can be perfectly legit. Those other
> scenarios are not covered by our threat model at this time. Therefore,
> we need a flag, passed from the SYSCALL_DEFINE_XX entry , down to
> can_modify_mm(), to differentiate those other scenarios.
>
> Now, back to code, it did some optimization, i.e. doesn't pass the
> flag from SYSCALL_DEFINE_XX  in all cases. If SYSCALL_DEFINE_XX calls
> do_a, and do_a has only one caller, I will set the flag in do_a,
> instead of SYSCALL_DEFINE_XX. Doing this reduces the size of the
> patchset, but it also makes the code less readable indeed. I could
> remove this optimization in V3. I welcome suggestions to improve
> readability on this.
>
> When handing the mmap/munmap/mremap/mmap, once the code passed
> can_modify_mm(), it means the memory area is not sealed, if the code
> continues to call the other utility functions, we don't need to check
> the seal again. This is the case for mremap(), the seal of src address
> and dest address (when applicable) are checked first, later when the
> code calls  do_vmi_munmap(), it no longer needs to check the seal
> again.
>
> [1] https://v8.dev/blog/control-flow-integrity
>
> -Jeff

There is also alternative approach:

For all the places that call do_vmi_munmap(), find out which
case should ignore the sealing flag legitimately, set an ignore_seal
flag and pass it down into do_vmi_munmap(). For the rest case,
use default behavior.

All future API will automatically be covered for sealing, by using default.

The risky side, if I missed a case that requires setting ignore_seal,
there will be a bug.

Also if a driver calls the utility functions to unmap a memory, the
seal will be checked as well. (Driver is not in our threat model,
but Chrome probably doesn't mind it.)

Which of those two approaches are better ? I appreciate the direction on th=
is.

Thanks!
-Jeff


-Jeff
