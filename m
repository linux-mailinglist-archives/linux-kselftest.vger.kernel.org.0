Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04A97D3FA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 20:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjJWS5J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 14:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjJWS5I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 14:57:08 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E96D7B
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 11:57:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso2802996276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698087424; x=1698692224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yqqvVSxSrZk5/pIhCtZC81tg5RVxwkjwG9586NW/1Y=;
        b=Wk56tLmfhHoxYX77HGCVbTeFROiZFFkVFLPcQwJQqM7BSRIW5v2qGxIfsFGfv+S5Dl
         I6UG48TfQ2ovJu1bMLmhY6Vz+0bCVJZLIgOnDbqP9k6zR/m4irt4Xspx34KpmENbUwu4
         3Iqo6d9SQi5BwpCxcuwIs6Dv2KT2qvRSjXLSQrEx73ALQskoJb+MTSnGVSDQCkOucYnH
         HElD7bALWRZusECe9Xqm7C1LHY6frbnASp7V9UvKr9VjrEtQyBkbpqSsh/iQRhKj3XHI
         CsmLjh53BW9oEqb4p+5mDigjDFG3gl1LVJS36sNkRjt8nHAp+L3WcQFpW9PcisW37yth
         wHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087424; x=1698692224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yqqvVSxSrZk5/pIhCtZC81tg5RVxwkjwG9586NW/1Y=;
        b=l5hUhVashCU4Y/+I2lbgHlIJsS44ucLStnwX3X171/JjfLU+pqVP2fpjj2GksJwJ1t
         nb5A5wcgHySD0xyQzNXK/nf1zt7C/mVZPLgJgXmg+YSr/gve8YQIYxG36Lzfb1Qyc2+P
         PR4PVVR9ZfUJvNmvZvt50lIwKZvkKKM5ze0r+TiMZ6ht1o/5x3DFxSCRzL/JqB0KEFgu
         iFPhPXNEFtCm3Nv/z3sgd5cKplkKepsBQlGjYOAZsJsj1xSL8ad+IcSvLN7lYK1hMVUt
         7fFIGizo0kDlKaV3u0YJqNRYpvYRv98yNClohEjmmGC9JGisgK58WeAmAJto4w2GbOvJ
         QzcQ==
X-Gm-Message-State: AOJu0YzaD8f5+1uaVAWjNAqmCcBXclmDCgV3l90O7moAEetkIxxl7ed6
        H5PlndpNCPi/j0iJCpvPTWSrdXccXduCjOGnr+r6Bg==
X-Google-Smtp-Source: AGHT+IHNQUEfjaARExOLomnsfHsumATRv6sH0Qq1Lhf5GhWbo8qoEifZvXPrlpQp8hcXTGjjpDeRLsUE+mhmHgPPud4=
X-Received: by 2002:a25:410e:0:b0:d9c:a3b8:f39d with SMTP id
 o14-20020a25410e000000b00d9ca3b8f39dmr8025930yba.65.1698087424379; Mon, 23
 Oct 2023 11:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <721366d0-7909-45c9-ae49-f652c8369b9d@redhat.com>
In-Reply-To: <721366d0-7909-45c9-ae49-f652c8369b9d@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Oct 2023 11:56:50 -0700
Message-ID: <CAJuCfpErrAqZuiiU5uthVU87Sa=yztRRqnTszezFCMQgBEawCg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 23, 2023 at 5:29=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Focusing on validate_remap_areas():
>
> > +
> > +static int validate_remap_areas(struct vm_area_struct *src_vma,
> > +                             struct vm_area_struct *dst_vma)
> > +{
> > +     /* Only allow remapping if both have the same access and protecti=
on */
> > +     if ((src_vma->vm_flags & VM_ACCESS_FLAGS) !=3D (dst_vma->vm_flags=
 & VM_ACCESS_FLAGS) ||
> > +         pgprot_val(src_vma->vm_page_prot) !=3D pgprot_val(dst_vma->vm=
_page_prot))
> > +             return -EINVAL;
>
> Makes sense. I do wonder about pkey and friends and if we even have to
> so anything special.

I don't see anything special done for mremap. Do you have something in mind=
?

>
> > +
> > +     /* Only allow remapping if both are mlocked or both aren't */
> > +     if ((src_vma->vm_flags & VM_LOCKED) !=3D (dst_vma->vm_flags & VM_=
LOCKED))
> > +             return -EINVAL;
> > +
> > +     if (!(src_vma->vm_flags & VM_WRITE) || !(dst_vma->vm_flags & VM_W=
RITE))
> > +             return -EINVAL;
>
> Why does one of both need VM_WRITE? If one really needs it, then the
> destination (where we're moving stuff to).

As you noticed later, both should have VM_WRITE.

>
> > +
> > +     /*
> > +      * Be strict and only allow remap_pages if either the src or
> > +      * dst range is registered in the userfaultfd to prevent
> > +      * userland errors going unnoticed. As far as the VM
> > +      * consistency is concerned, it would be perfectly safe to
> > +      * remove this check, but there's no useful usage for
> > +      * remap_pages ouside of userfaultfd registered ranges. This
> > +      * is after all why it is an ioctl belonging to the
> > +      * userfaultfd and not a syscall.
>
> I think the last sentence is the important bit and the comment can
> likely be reduced.

Ok, I'll look into shortening it.

>
> > +      *
> > +      * Allow both vmas to be registered in the userfaultfd, just
> > +      * in case somebody finds a way to make such a case useful.
> > +      * Normally only one of the two vmas would be registered in
> > +      * the userfaultfd.
>
> Should we just check the destination? That makes most sense to me,
> because with uffd we are resolving uffd-events. And just like
> copy/zeropage we want to resolve a page fault ("userfault") of a
> non-present page on the destination.

I think that makes sense. Not sure why the original implementation
needed the check for source too. Seems unnecessary.

>
>
> > +      */
> > +     if (!dst_vma->vm_userfaultfd_ctx.ctx &&
> > +         !src_vma->vm_userfaultfd_ctx.ctx)
> > +             return -EINVAL;
>
>
>
> > +
> > +     /*
> > +      * FIXME: only allow remapping across anonymous vmas,
> > +      * tmpfs should be added.
> > +      */
> > +     if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
> > +             return -EINVAL;
>
> Why a FIXME here? Just drop the comment completely or replace it with
> "We only allow to remap anonymous folios accross anonymous VMAs".

Will do. I guess Andrea had plans to cover tmpfs as well.

>
> > +
> > +     /*
> > +      * Ensure the dst_vma has a anon_vma or this page
> > +      * would get a NULL anon_vma when moved in the
> > +      * dst_vma.
> > +      */
> > +     if (unlikely(anon_vma_prepare(dst_vma)))
> > +             return -ENOMEM;
>
> Makes sense.
>
> > +
> > +     return 0;
> > +}
>
>

Thanks,
Suren.


> --
> Cheers,
>
> David / dhildenb
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
