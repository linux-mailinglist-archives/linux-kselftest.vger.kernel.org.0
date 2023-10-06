Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F747BBB20
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 17:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjJFPCT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjJFPCS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 11:02:18 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88528F
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Oct 2023 08:02:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59f55c276c3so26868537b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Oct 2023 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696604536; x=1697209336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAT19evpcikftTKsU+k+vIv081WV5YPaM49e24ewPPI=;
        b=euK6kc768tr+he+eKo5UAymKdHh8Lq8xj5L/TPiDTjoGOdyW7OC61VlJSU1gkifw1t
         ITSaUZTKqTckBriiLgNvAx1PaUzKPldvKm4s7OELrbKi+DWJL0zWe+1UoZF128OLTbnm
         O7WX0biYzQ+fe09Cpa+q21n64QPAx2NjW08woUv/M8P00CghqXzJ4niaGk2GsZjSIifh
         C3TqHEjYYekD4yLOorCEyQK/fmJKRcvLuB74Zx2njYH6hch5+rhQfBn/oA1hcYxwtkDY
         RHU8n62DCTbv0nElgL6rwcCm8sGB9Q7RrhF5BYwPSF+81W41SSZC5l4Bvj4Iodnlb64p
         iwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696604536; x=1697209336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAT19evpcikftTKsU+k+vIv081WV5YPaM49e24ewPPI=;
        b=jL516ewyOtGtY7MNY0ZLQlOuJAoySLiDu8MCvRXat0E1RlWvIIhgjNYZuzogugrAjW
         TjdVTS1BwRHAFyzEXIkjs0bRZbA90sOSp9BJotKtygq+NIjCKqYxwE089bsyUjgQIFBD
         OIodVR9TUC80TJuM/dV/txqA+6sHizpnE03bbq5946E2onKKAViFwRXurIU71fWtOmls
         EIsypWU6B8a219DV+CDnggUtvar2oLHDqoDgc5f/AuQh4ds6vagQBKSYA5cnzuyrzC8N
         cKHKYbPadrs4Ul3ct9ExT8Wdk6V/ZIxrUaIEFODOfX3tQMQSFNc5EkE7AQJR2b4o78Vm
         Ocbw==
X-Gm-Message-State: AOJu0YyRWjOLOc3RdfHr5GQZnJLl6uzyDwrk6LUbj8Xnu7qf440I7ehO
        1tPfn7jWhVQyPSXZ75Qvr/IgC9+pFtYAtR6AZAat1A==
X-Google-Smtp-Source: AGHT+IFc16xhVp7RXBOoHUgUXh2Eel8sH+b1CWij1+SWJckP+B2dpSf1BmXp+gx4YH2/SUifs++/hwpbDGqVTk5PnbI=
X-Received: by 2002:a5b:807:0:b0:d81:6e88:7cb3 with SMTP id
 x7-20020a5b0807000000b00d816e887cb3mr7404835ybp.47.1696604534279; Fri, 06 Oct
 2023 08:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <ZRXHK3hbdjfQvCCp@x1n> <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com>
 <ZRrf8NligMzwqx97@x1n> <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com> <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
 <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
 <ZRx31TKFDGRatoC8@x1n> <c837fc02-3dbd-ba88-dacb-cf150272a4c4@redhat.com>
 <ZRyFnurIgVFVD8hd@x1n> <CAJuCfpFggFpPxJjx9uGe05x0fTNONgoUf=QzkpCHLx43Tbryjg@mail.gmail.com>
 <CA+EESO5UPJrWpUKLg6m=1EmG6P9oXW6ADRkbRKjijVxj641qFQ@mail.gmail.com> <df0ccf08-1bbb-418c-0b3b-57c7288a9871@redhat.com>
In-Reply-To: <df0ccf08-1bbb-418c-0b3b-57c7288a9871@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 6 Oct 2023 08:02:00 -0700
Message-ID: <CAJuCfpHGLUYKHik_qCc2Uwnn6Yk6oMn+HA1t2i1995b1NREFYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 6, 2023 at 5:30=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.10.23 01:39, Lokesh Gidra wrote:
> > On Tue, Oct 3, 2023 at 11:26=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> On Tue, Oct 3, 2023 at 2:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> >>>
> >>> On Tue, Oct 03, 2023 at 11:08:07PM +0200, David Hildenbrand wrote:
> >>>> Sorry I have to ask: has this ever been discussed on the list? I don=
't see
> >>>> any pointers. If not, then probably the number of people that know a=
bout the
> >>>> history can be counted with my two hands and that shouldn't be the b=
asis for
> >>>> making decisions.
> >>>
> >>> For example:
> >>>
> >>> https://lore.kernel.org/all/1425575884-2574-21-git-send-email-aarcang=
e@redhat.com/
>
> Sorry, I had to process a family NMI the last couple of days.
>
> >>
> >> There was another submission in 2019:
> >> https://lore.kernel.org/all/cover.1547251023.git.blake.caldwell@colora=
do.edu/
>
> It would be good to link them in the cover letter and shortly explain
> why that wasn't merged back then (if there was any reason).

Will do. I could not find the reason but will check again.

>
> >>
> >> Though both times it did not generate much discussion. I don't have a
> >> strong preference though MOVE sounds more generic to me TBH (it
> >> specifies the operation rather than REMAP which hints on how that
> >> operation is carried out). But again, I'm fine either way.
> >
> > That's a good point. IMHO, if in future we want to have the fallback
> > implemented, then MOVE would be a more appropriate name than REMAP.
> >
> >> As for UFFDIO_MOVE_ZERO_COPY_ONLY vs UFFDIO_MOVE_MODE_ALLOW_COPY, I
> >> find it weird that the default (the most efficient/desired) mode of
> >> operation needs a flag. I would prefer to have no flag initially and
> >> add UFFDIO_MOVE_MODE_ALLOW_COPY or whatever name is more appropriate
> >> when/if we ever need it. Makes sense?
> >
> > Agreed!
>
> I agree. One could have UFFDIO_MOVE that is best-effort and documented
> like that, and a to-be-named future extension that always works but
> might be more expensive.
>
>
> Ideally we'd have an interface that does not expose and/or rely on such
> low-level information and simply always works, but getting that would
> mean that we'd have to implement the fallback immediately ... so I guess
> we'll have to expose a best-effort interface first.

Sounds good. I'll try to post the next version early next week. Thanks
for the input folks!

>
> --
> Cheers,
>
> David / dhildenb
>
