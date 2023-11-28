Return-Path: <linux-kselftest+bounces-729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA107FBFBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 17:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27CDB21504
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF372E647;
	Tue, 28 Nov 2023 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1csWw9Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15033D51;
	Tue, 28 Nov 2023 08:54:08 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b389399dfdso133526339f.2;
        Tue, 28 Nov 2023 08:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190447; x=1701795247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r85ydUJh41VHrUAuuHTOjnQ7J8TNkgJ1y7qjmCMSTu8=;
        b=c1csWw9ZHwTNRyZ1Cf739uEAA/rE3GFkeHYDXFBlk+AMOgvY+IRBV6q8bb8eSYhwD2
         RCIQEZf/PcKj/0SdILO4J1eMZqW42d9kDY0P5PP5JgKbVmZm8gq7DIhYS0Iyo1E0SjMY
         i3pu7ouHtbMyb5C4wvqtkRUEMCRWifL9QAxYQB9gmmCeua1VarKvcjoyo4j4dhhdaLez
         2PMhFQrAAYjXtAGc+xWAlCQcyyLPCAvRRtNHQ73mbNbjFK+wpi/6oimer+tesQUqsqoD
         Gi8Fxl6q+u/QZidszp8MeNhY6OZHTt7NXnmISm4n42RB+X4hY4YQ1kltZ0BgCY5/m/bP
         6m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190447; x=1701795247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r85ydUJh41VHrUAuuHTOjnQ7J8TNkgJ1y7qjmCMSTu8=;
        b=VtaD63cLFaC+uZNGdh81O2iDArlzTsQ4Up7lEVA1g8EkNNgbCNzUQcBb7YiMrwkVJM
         8xn+uvC2bcJFAvfVbqJ12D1HaWRqsoqORwcgbZXdF9sMgnJcKFL1CtJgDDXV4s1I1Oqn
         MTdSt/cqkLUow/sfEEZORJgpLEnCxyPA0K5fnQsLWwj79J6P42G3eOIv2grUbVMGomqw
         qXQT4GBTGL6cJdX2HmbiMnl7cEUuUg2Vee9OmPHgGj9C2bFw86pqf/HYIGZa5Q4S3mw5
         WaKyxduVB6CpxYlbfA4YfGCkiOEu27X53RtganEMOhCBGWBzJ8KTbyTSKrPdut7h1UNm
         n3Pg==
X-Gm-Message-State: AOJu0YyajVmdDgAlCd2+XNjTEbEsANaO6WviLqlLjBXDdefFwyMrXoho
	N/PV/8fgwk+8N23t2LOnKSNu7G8HRc3nocd4PoU=
X-Google-Smtp-Source: AGHT+IFb7aDwTf03bZeLB0LqchAfMqNlPpSgWV8SqzBEtOOj8il9iQK8ry85o7b804gzWK+PQJN1JfAhCluvV7Dli6w=
X-Received: by 2002:a6b:3fc3:0:b0:79f:96db:f33d with SMTP id
 m186-20020a6b3fc3000000b0079f96dbf33dmr12580697ioa.9.1701190447244; Tue, 28
 Nov 2023 08:54:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127193703.1980089-1-nphamcs@gmail.com> <20231127193703.1980089-3-nphamcs@gmail.com>
 <ZWW1IG0Mv3r0m4mp@tiehlicka>
In-Reply-To: <ZWW1IG0Mv3r0m4mp@tiehlicka>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 Nov 2023 08:53:56 -0800
Message-ID: <CAKEwX=OGtkqWys9VM9EBScoCdAjSdfPjEkvoY7_u9udDZBFFpw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] memcontrol: allows mem_cgroup_iter() to check for onlineness
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 1:38=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 27-11-23 11:36:59, Nhat Pham wrote:
> > The new zswap writeback scheme requires an online-only memcg hierarchy
> > traversal. Add a new parameter to mem_cgroup_iter() to check for
> > onlineness before returning.
>
> Why is this needed?

For context, in patch 3 of this series, Domenico and I are adding
cgroup-aware LRU to zswap, so that we can perform workload-specific
zswap writeback. When the reclaim happens due to the global zswap
limit being hit, a cgroup is selected by the mem_cgroup_iter(), and
the last one selected is saved in the zswap pool (so that the
iteration can follow from there next time the limit is hit).

However, one problem with this scheme is we will be pinning the
reference to that saved memcg until the next global reclaim attempt,
which could prevent it from being killed for quite some time after it
has been offlined. Johannes, Yosry, and I discussed a couple of
approaches for a while, and decided to add a callback that would
release the reference held by the zswap pool when the memcg is
offlined, and the zswap pool will obtain the reference to the next
online memcg in the traversal (or at least one that has not had the
zswap-memcg-release-callback run on it yet).

> --
> Michal Hocko
> SUSE Labs

