Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB9C7DC1D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 22:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjJ3VWf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 17:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjJ3VWd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 17:22:33 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E323FA
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 14:22:30 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-da37522a363so144031276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698700949; x=1699305749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwJPbkzTcW2a0Aake5KdIVl2hETAF8IjmbwWVJSuVUw=;
        b=Wx0iAWYlcDRAmwXfeDu1TIGeyf2a03/2CWVPGcQioNB/aaFiWvz90T94M4WYfoSqrU
         9QZTpRC1AIUhUVYs5J+/SWqyFtsNFOKoiJTst5mrlSU8qxE1g2rqaj00RVNjxl+JsvA9
         n4UggqZSccmnxcq4kY37ADju4VGy8Riww0zPhxRBiQMopa2XY7VuSQc3N09+ta/C5SRY
         5HYLouNCHser50Vzw8S8awr8qREytcoKY9jpytWQUoCKGvyckPtCt3NxNxZGMdCMtDr7
         56Szab0mLt3wDKsI9cjAWD5s8j29ZtyuAXwR9/tdnWWgaNNyr1nm2sJvnQ+3K5FAZWye
         Pc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698700949; x=1699305749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwJPbkzTcW2a0Aake5KdIVl2hETAF8IjmbwWVJSuVUw=;
        b=V5dWLIYlffD3C73WJ/sfjOQBy3UK7ORhAtYd0tYmJiqRF5B4JgLQfSK0qR5tKbVnmf
         x+GxKnqMxlBYWoKWT9egXvyCy52e4XhCQD5DV6RGS07AeeqylLnPB/2XedXrJ0Q6bY3T
         pXOUS8mSdtQ6kKb5MkzsV1fXfWkpcm9/SPSPszYHWLCvqK1AyqTp4H3k5MNVSip+UXIm
         ZJ3c7PVGPsOpf4+CyjFUaSKSfW3SSgqNoYpbUm8X+ZveNzlIsP3lFDt/+IZacN5aAaRk
         JU5+SeOOr3GExI3o68c96358bOR1RF2vPo6ZYzVhJQrgapZHNnfCIQgtd/fuMvOvYl6C
         K0jA==
X-Gm-Message-State: AOJu0Yx0ByPRfPfb0hbuCMngDdI1/El1HkifCmDUfb2TqY4vhkTz5Caf
        hrvKH0aUlwhUXZk+Tb0BN6Rpb7HalzcZA1chK+3s3g==
X-Google-Smtp-Source: AGHT+IHUKCGn+zcI97gOSVY+FNlKbbSCWP6tGfywZjOb4ubvvKE7w61Yhe1EdRLZDEeh63lNRWL2VU/yYTIkofZbYco=
X-Received: by 2002:a25:30d:0:b0:d15:7402:f7cd with SMTP id
 13-20020a25030d000000b00d157402f7cdmr11851887ybd.27.1698700949306; Mon, 30
 Oct 2023 14:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com> <20231028003819.652322-6-surenb@google.com>
 <ZUAOpmVO3LMmge3S@x1n> <CAJuCfpEbrWVxfuqRxCrxB482-b=uUnZw2-gqmjxENBUqhCQb8A@mail.gmail.com>
 <ZUATjxr2i7zVfL8I@x1n>
In-Reply-To: <ZUATjxr2i7zVfL8I@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 30 Oct 2023 14:22:15 -0700
Message-ID: <CAJuCfpHzEn0=6-4sngq8qQ6h5mSM+Gj-4OqOGF=cvefouk1cbw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 30, 2023 at 1:35=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 30, 2023 at 01:22:02PM -0700, Suren Baghdasaryan wrote:
> > > > +static int adjust_page_size(void)
> > > > +{
> > > > +     page_size =3D default_huge_page_size();
> > >
> > > This is hacky too, currently page_size is the real page_size backing =
the
> > > memory.
> > >
> > > To make thp test simple, maybe just add one more test to MOVE a large=
 chunk
> > > to replace the thp test, which may contain a few thps?  It also doesn=
't
> > > need to be fault based.
> >
> > Sorry, I didn't get your suggestion. Could you please clarify? Which
> > thp test are you referring to?
>
> The new "move-pmd" test.
>
> I meant maybe it makes sense to have one separate MOVE test for when one
> ioctl(MOVE) covers a large range which can cover some thps.  Then that wi=
ll
> trigger thp paths.  Assuming the fault paths are already covered in the
> generic "move" test.

Oh, you mean I should not share uffd_move_test() between move and
move-pmd test and have separate logic instead that does not rely on
the page_size overrides? If so then I think that's doable. Some more
code but probably cleaner.

>
> Thanks,
>
> --
> Peter Xu
>
