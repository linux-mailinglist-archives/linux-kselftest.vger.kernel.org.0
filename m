Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B77B7537
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 01:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjJCXjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 19:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjJCXjp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 19:39:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72CD7
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Oct 2023 16:39:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406618d0992so15125615e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Oct 2023 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696376380; x=1696981180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmO5pFavK4wOcon/sDd15Ws2jqSVTxN561D6YV6OXgg=;
        b=vxZ1ZTPTOOxb5/1qxhAJb2c2IfhyYzzjuEXDD9ujXo0jsaCJxOTI84fSQ29XA3FoRz
         sFMShgnFGi54mN92ZvGJ8cqb1ff31wejT/7cuflv8l5h6ut6Q9ILGrP9atX1vQS9xLQT
         o3G6+lxIjGp7y6oJViOOw4C2UMxhxsujgQv+4mkRNhJvDh7kRXSZj2alBsOI5B2gG6eO
         bRcsRvCLwU38HN6Z6uUhLfuL5nWNYKMV3SICUYn0mAvO+IfPafI2KQRecZOUDCohgbfQ
         O8D4g1EC9nATGSZ8AH0C8qKZrFFgM/g3qxsO8srg0fFcgNpz+X6422nG3W1vwQ9Ki9bq
         G1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376380; x=1696981180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmO5pFavK4wOcon/sDd15Ws2jqSVTxN561D6YV6OXgg=;
        b=XaW+ocN8qv1d3FCc2oDJSRlqzx37zeOzC4FMWj1nqQIGQyp0Nd1kSMnrhLethxnt5F
         Y2ee/FSe4e4uK5aUnzoTwsR1QDmRgLaDR5Yy4lxYFfSdrA/kK6OX81UtOHW7bTo9MmHS
         hsAAvgURqcBT+iJvKEaIAh1jaoVO5T//OhJMCFTNnEa5gqVrQ3IAvKT4lqRdHDX6OVxf
         ayRGuTLrwwvKmFHJMO12rWNG0NqZQOX+E92eFAmJjiOKo8mmtqnOda8HEPvHJufH+Lxp
         6f/pXS/fSxdbJknqumep9iEOclM/UsYHmb/puzcIJqQFCgOF2PkZrJCw5gzkyme3F24M
         DJww==
X-Gm-Message-State: AOJu0Ywk7yu7ZgpPa3GuIb0X194yv0mVb532JizGcWwy4IF10dfj2U0u
        JuXOtZeQntFQDHP5oid2IgwnZH5O4VVdiBxRlY4l6Q==
X-Google-Smtp-Source: AGHT+IHsUX5Map++iKhy04cGuLtW7ImZgA+PIyHNa+JhlI79jYhvJUXLaOyVS+J7sm2Cvgu4hfMreGatARTKDQkrC+w=
X-Received: by 2002:adf:f491:0:b0:317:e5ec:8767 with SMTP id
 l17-20020adff491000000b00317e5ec8767mr638253wro.21.1696376380430; Tue, 03 Oct
 2023 16:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZRXHK3hbdjfQvCCp@x1n> <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com>
 <ZRrf8NligMzwqx97@x1n> <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com> <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
 <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
 <ZRx31TKFDGRatoC8@x1n> <c837fc02-3dbd-ba88-dacb-cf150272a4c4@redhat.com>
 <ZRyFnurIgVFVD8hd@x1n> <CAJuCfpFggFpPxJjx9uGe05x0fTNONgoUf=QzkpCHLx43Tbryjg@mail.gmail.com>
In-Reply-To: <CAJuCfpFggFpPxJjx9uGe05x0fTNONgoUf=QzkpCHLx43Tbryjg@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 4 Oct 2023 00:39:28 +0100
Message-ID: <CA+EESO5UPJrWpUKLg6m=1EmG6P9oXW6ADRkbRKjijVxj641qFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
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

On Tue, Oct 3, 2023 at 11:26=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Oct 3, 2023 at 2:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
> >
> > On Tue, Oct 03, 2023 at 11:08:07PM +0200, David Hildenbrand wrote:
> > > Sorry I have to ask: has this ever been discussed on the list? I don'=
t see
> > > any pointers. If not, then probably the number of people that know ab=
out the
> > > history can be counted with my two hands and that shouldn't be the ba=
sis for
> > > making decisions.
> >
> > For example:
> >
> > https://lore.kernel.org/all/1425575884-2574-21-git-send-email-aarcange@=
redhat.com/
>
> There was another submission in 2019:
> https://lore.kernel.org/all/cover.1547251023.git.blake.caldwell@colorado.=
edu/
>
> Though both times it did not generate much discussion. I don't have a
> strong preference though MOVE sounds more generic to me TBH (it
> specifies the operation rather than REMAP which hints on how that
> operation is carried out). But again, I'm fine either way.

That's a good point. IMHO, if in future we want to have the fallback
implemented, then MOVE would be a more appropriate name than REMAP.

> As for UFFDIO_MOVE_ZERO_COPY_ONLY vs UFFDIO_MOVE_MODE_ALLOW_COPY, I
> find it weird that the default (the most efficient/desired) mode of
> operation needs a flag. I would prefer to have no flag initially and
> add UFFDIO_MOVE_MODE_ALLOW_COPY or whatever name is more appropriate
> when/if we ever need it. Makes sense?

Agreed!
>
> >
> > --
> > Peter Xu
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
