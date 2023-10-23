Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9AA7D3FBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjJWTAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjJWTAf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 15:00:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A710CB
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 12:00:23 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso2806258276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698087621; x=1698692421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtdA9ub/ANr7ejS62Fd8050vwxz1kSazOAjElqLmkxM=;
        b=PMoDV5oPWWZLd9mFQbXBvL+JlLndRu926JSGLEhJMxss3Lp8WoBDWKdmp+xRF0Lf7E
         GkLPVBkUCV3ME9LzUyD+VC283keAsJ+wwhGBV3N/tgEZXRGXnJtTj12tteov5HxVufgm
         b67/0BZddh+lo0ekqlQnsY42r4/wrmeMXmSA60x1Tq4L5SaBijYBr8w3Hn6Hntsv6w8V
         PoTJY8RclYmTmh2JWK/rYqkD58NVAK/WffOkhzICBJE4/FjvdRRd1fPHCH09StKc5/6b
         pGc6SRBHBCOq6QCdQdDcB/x1zCG1BmlluAhrbtZq9KyZ8AL+F8AhBPdLXebKQiOunsOS
         KtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087621; x=1698692421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtdA9ub/ANr7ejS62Fd8050vwxz1kSazOAjElqLmkxM=;
        b=jKDhqg/6fGcnkdr4TfYY2vpGo47rhmqezHCe+SXpw1PnxFwx1uX3KlTqjkatsbY2HZ
         mnklDmoO6U/p5OMbIbx9JYxtaeOWBvgMN++8G+d6E5RYNCg1dmOQ/IbfaXwNOOH3cy8Q
         Ol64kF9xjjff5bHTt9CJSA2WmjDnxbdwVN/YtAEAhbKVvojMwzazTPS+NOTkzcjcyNjt
         zptgxUaL5GN83FXIPrexfaVXpA5jViLDhXyHkw76SgHP83e9nVghznRd9emn8W99MLT2
         veoCpA+YPTvq8Uw5jke6gRRmil6Q1fCR4fCs2fnjd0NclMcv4sUwg/LTmmDjvSsr32Hg
         zLOQ==
X-Gm-Message-State: AOJu0YzIzfGvxnPeGGfYw/Dkq575N24RlTP932uHuIvkPfAiCx6dXqIH
        f4wkVb/8+6GTEcTk4ImaTohiMfq7OpuBO7henq/CIA==
X-Google-Smtp-Source: AGHT+IHoBU3f92OsehjvOqFbu0XBgHXFL1aR9fooZex3IOmb5ltIYm/8vL48yXoinuA4SJCQtcFh+3IhHsrl1XTH5gA=
X-Received: by 2002:a25:86c1:0:b0:d9a:b522:6870 with SMTP id
 y1-20020a2586c1000000b00d9ab5226870mr8756763ybm.0.1698087620747; Mon, 23 Oct
 2023 12:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <721366d0-7909-45c9-ae49-f652c8369b9d@redhat.com> <045c35ba-7872-40a7-bd86-e37771076b88@redhat.com>
In-Reply-To: <045c35ba-7872-40a7-bd86-e37771076b88@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Oct 2023 12:00:09 -0700
Message-ID: <CAJuCfpH8oare_erzHuhiV0knbwVEmOzq6DnoywNQpOCAqJMucA@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 23, 2023 at 8:53=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.10.23 14:29, David Hildenbrand wrote:
> >> +
> >> +    /* Only allow remapping if both are mlocked or both aren't */
> >> +    if ((src_vma->vm_flags & VM_LOCKED) !=3D (dst_vma->vm_flags & VM_=
LOCKED))
> >> +            return -EINVAL;
> >> +
> >> +    if (!(src_vma->vm_flags & VM_WRITE) || !(dst_vma->vm_flags & VM_W=
RITE))
> >> +            return -EINVAL;
> >
> > Why does one of both need VM_WRITE? If one really needs it, then the
> > destination (where we're moving stuff to).
>
> Just realized that we want both to be writable.
>
> If you have this in place, there is no need to use maybe*_mkwrite(), you
> can use the non-maybe variants.

Ack.

>
> I recall that for UFFDIO_COPY we even support PROT_NONE VMAs, is there
> any reason why we want to have different semantics here?

I don't think so. At least not for the single-mm case.

>
> --
> Cheers,
>
> David / dhildenb
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
