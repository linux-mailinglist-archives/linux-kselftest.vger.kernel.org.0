Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3AF7B572B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbjJBPz7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbjJBPzz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 11:55:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8B0FD
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 08:55:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d58b3efbso14688015f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Oct 2023 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696262147; x=1696866947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE6kgS5NryeWM2eNYlqUNOE7bxNuh8Nz6QyL7U8srO0=;
        b=Y/A08K4rOTR+BD603+oKzq7iRMgXVNysGNpUPpUZ9BBTMGHCHOYDUBeTXqcsPieb1U
         gYUNif5kQKO7ZjwS9Nun9P7nP9AU+NYi6P6JAkivjsRVhAMhB2O+0L6hTo5ZH82t3YMS
         7ZzGTFcnMWL2aYl4ynwIIBESrQOEOZhPyowjz0wlNvqW+yZJvt5SJg8dSZGqw2mFP2B3
         oveLYGvvV9aeZEcRjm2nYdhBt6dxKrIyvu8TAaA5vRPYmNSx5xkndLZeG0ccBASUy4+9
         KeU4I/iZl+5hdh0uSIgWV6XW1B1I6uoh90uwm62nuyp+xtydQT/V6UHnYgYJ9Xqlr3zd
         20ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262147; x=1696866947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EE6kgS5NryeWM2eNYlqUNOE7bxNuh8Nz6QyL7U8srO0=;
        b=qET+j3ZNKy+jPZUPEaIn2I8NYwUSjv2j+bDatnaqQstfK2yWLTavHKxnQKuJnQa+4B
         /FX+rj2HuI134Trv4uwdelL6nSbDhTJ9SBXDt48iG9ki1SNEYnixf0QLAv29mSA65AvN
         fP+TyZ/RjCAYsvPQFFoyjuYcksS+K3qCdO7s0b+kleOXEASfUHnq/MyYf+QsnG7Rzr2w
         Ua21JscBD6pkjbFe/5UNq6x5aIjdyHJEsILe5XL8z5zZp4rav9MOAJOw7bfecP3BG4iU
         Zh3kOxgml/TPAoGlNqv8uDxABKRTwOyrBr9z5ta02WPOzCw5Lvrmg0itqigqU4q4P3Xp
         Jyxw==
X-Gm-Message-State: AOJu0YxS6brmAj/4DWTcg/eyzbtbgrmezJWy/gBeqTZXWaleFuWOnKxL
        PUAfLQoaTxULf0IXrJd6nseZK6dXw+FtC3D6G94hCg==
X-Google-Smtp-Source: AGHT+IEFiHW93RRhSDCuf+q2eF19Rn8mISAafthoGCjUC4BHJ+ls1MS4+3DZHpu9OZqLfupwwY4gh+J9TIS9DnIhBRI=
X-Received: by 2002:a5d:610a:0:b0:314:1f1e:3a85 with SMTP id
 v10-20020a5d610a000000b003141f1e3a85mr9647998wrt.61.1696262146901; Mon, 02
 Oct 2023 08:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com> <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com> <ZRrf8NligMzwqx97@x1n> <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
In-Reply-To: <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 2 Oct 2023 16:55:35 +0100
Message-ID: <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
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

On Mon, Oct 2, 2023 at 4:46=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.com=
> wrote:
>
> On Mon, Oct 2, 2023 at 4:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
> >
> > On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
> > > In case we cannot simply remap the page, the fallback sequence (from =
the
> > > cover letter) would be triggered.
> > >
> > > 1) UFFDIO_COPY
> > > 2) MADV_DONTNEED
> > >
> > > So we would just handle the operation internally without a fallback.
> >
> > Note that I think there will be a slight difference on whole remap
> > atomicity, on what happens if the page is modified after UFFDIO_COPY bu=
t
> > before DONTNEED.
> >
> > UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, threa=
ds
> > can be updating the pages when ioctl(UFFDIO_REMAP), data won't get lost
> > during movement, and it will generate a missing event after moved, with
> > latest data showing up on dest.
> >
> > I'm not sure that means such a fallback is a problem, Suren may know
> > better with the use case.
>
> Although there is no problem in using fallback with our use case but
> as a user of userfaultfd, I'd suggest leaving it to the developer.
> Failing with appropriate errno makes more sense. If handled in the
> kernel, then the user may assume at the end of the operation that the
> src vma is completely unmapped. And if not correctness issues, it
> could lead to memory leaks.

I meant that in addition to the possibility of correctness issues due
to lack of atomicity, it could also lead to memory leaks, as the user
may assume that src vma is empty post-operation. IMHO, it's better to
fail with errno so that the user would fix the code with necessary
changes (like using DONTFORK, if forking).
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
