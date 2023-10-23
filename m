Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA47D3FC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJWTBs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 15:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjJWTBr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 15:01:47 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F80B101
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 12:01:45 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7af45084eso35111707b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698087704; x=1698692504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zqg2MrbwUBHop12bezxykXk1XkJASgD3Vjm9dX2RSP8=;
        b=nhRwBvf5B5dVVjrNs1IllqUTDPbpqQ2HLwbaDjehM4okzVtkSNbXs6CB3yjfNNnKyU
         T+VSaeTDQT1IigKk+2mPUvmzayOLYNoJsY5H4AwfanRQf85egQ3zUxgHcRVt+mrRRIuA
         2NceyG2QR+0kXSE0PgTuISBHzETzhFxFzgxc3nbA+6+XZ1R63ryySr8lnuHiXFqrxRLz
         KLp008cIeW+e53wHbLk2MY5rLtMjGrFIBuI4+4Pk3QO/BEuhK6M+aHnDkPKUVGCcvvY7
         F7bNHVg4FIo7B/f3xfHnF0Y3ipbrsumona9sJGhIgedO/pP98VLCd0pHIkkTnIZn1oIJ
         UnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087704; x=1698692504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zqg2MrbwUBHop12bezxykXk1XkJASgD3Vjm9dX2RSP8=;
        b=nvW28nnTs9gt7UatpD1D3x07lFuKEjliYlmURSgrLVJ+pTZFnm279e13YQpoy2/GnP
         7UYMbMv3uD15bJ7LtVxflqgjQHBv8zLSNzo9dvL1JZED++Sle2R2CasvdWGqFfCTuGmz
         dZGi66kloBIEmAgAwF44yUzS7Vl14xLYpH3aWvn3AlN2OYwd/NHU7aGtOM/7uz5Zj43V
         537DWGp9DL8yEhHIj0wi3Tgm7Ci2qnmIm4FCRmRG7Rzhf4Gje4iixYvBGJOZYHFWvkAa
         VvhdKA2PwFmQxrbOtXUL/CAbcSGDAGNusoN3fwfRhkIg/F8D0FR+0rMQh7u16A1hVUaB
         VHvQ==
X-Gm-Message-State: AOJu0YwHZbcktNiwgN3HidC+O+U3yqnGa03dDYZz9X3hjCitdsqgAyyM
        o+n1x6VX7wEfJD1wzOVOdx/Z7/FAGCyq24o2NVoTHQ==
X-Google-Smtp-Source: AGHT+IHoAt2gVqrgRoqwdRIpKxcUmNNTfbU5Vcl//A9wd9dXnzR/3ka7Iq0f7Tyi5EsdxWj3DjAV8pYMZpaDZxugx+M=
X-Received: by 2002:a81:65c2:0:b0:583:3c54:6d89 with SMTP id
 z185-20020a8165c2000000b005833c546d89mr8889708ywb.44.1698087703993; Mon, 23
 Oct 2023 12:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <ZShsQzKvQDZW+rRM@x1n> <CAJuCfpEtaLs=nQK=oPHe9Nyq1UoqLk1pt2k-5ddDks3Ni2d+cw@mail.gmail.com>
 <ZTVVhkq8uNoQUlQx@x1n> <CAJuCfpEDEXHVNYRaPsD3GVbcbZ-NuH0n3Cz-V0MDMhiJG_Esrg@mail.gmail.com>
 <ZTa9Y++/PCV7HRoM@x1n>
In-Reply-To: <ZTa9Y++/PCV7HRoM@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Oct 2023 12:01:32 -0700
Message-ID: <CAJuCfpF6rfrbT3Sk7+azUH9=CfERYnb84ztoCuA72AxtZ_1FLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
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

On Mon, Oct 23, 2023 at 11:37=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Mon, Oct 23, 2023 at 10:43:49AM -0700, Suren Baghdasaryan wrote:
> > > Maybe we should follow what it does with mremap()?  Then your current=
 code
> > > is fine.  Maybe that's the better start.
> >
> > I think that was the original intention, basically treating remapping
> > as a write operation. Maybe I should add a comment here to make it
> > more clear?
>
> Please avoid mention "emulate as a write" - this is not a write, e.g., we
> move a swap entry over without faulting in the page.  We also keep the pa=
ge
> states, e.g. on hotness.  A write will change all of that.

Understood.

>
> Now rethinking with the recently merged WP_ASYNC: we ignore uffd-wp, whic=
h
> means dirty from uffd-wp async tracking POV, that matches with soft-dirty
> always set.  Looks all good.
>
> Perhaps something like "Follow mremap() behavior; ignore uffd-wp for now"
> should work?

Sounds good. Will add in the next version.
Thanks!

>
> --
> Peter Xu
>
