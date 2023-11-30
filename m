Return-Path: <linux-kselftest+bounces-854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1537FE51C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 01:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379211C20B1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 00:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FBE628;
	Thu, 30 Nov 2023 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3gDyxeg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AF1C9;
	Wed, 29 Nov 2023 16:47:59 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f9e0e44fecso169052fac.3;
        Wed, 29 Nov 2023 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701305278; x=1701910078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px7lu5nOqajxdLEanLNBtXA+0BLm4pP2tpUPChWnjUo=;
        b=Q3gDyxegKcTCM22dYyiIS3FhVJKlB3JlX5pEtwKlifYACjCod8X2Nzp7Shbm1wUjqZ
         3VQUTWS3p44xgvuKDB+Q5PQ0btMjf62LpnI0+xEi7TMx8oDXolmqF3GzRrPzwhaEQ/EZ
         ELGYT7s/ptGFZMyqO6LiXbECKOe2pp+xrTC4q+17k+tz43kt5payZXz1H76bbzNHtsro
         nCLOrtuAIm3SmWHmBqbBmO/vwAlhPcBLLKWhbiWZWRNGGURUNwfiGP59gnejquWjjFcV
         7aXEJ0C8UMJNTkBtV0NqhlSdZBi3z8WIoh73nJOJzPCdGbG8nePM3naVI+zMK301IyhW
         4veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701305278; x=1701910078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=px7lu5nOqajxdLEanLNBtXA+0BLm4pP2tpUPChWnjUo=;
        b=tJfANXCNtGck1rwWNvT7R4p8sYSNBnu2q0vATepHof9pn1lxNkeK+U7UFL7TuzIDAe
         +PV+XtmL8I/y4RDqP0fM9ws1t+1O/wyVK5E8egpFFt7H0CdVqFFv3on0Yov5dKa49V0Q
         umcDORQYk/FMlo2XHDK1AZ8MoNKzka2R/ihAxeqm0Tpdk3wKKvTLcT8mHknBD9o+ecxW
         WAMF8Cf6+u5AxhI80t9nuBJNrtYSz5yIjCFjkx8UmCMdzW+JYHKCBNpA5GS58ae7/5wC
         V6tW/iTAkSKM+DSm0y3pYSoWP6lArul5rM8meYPHU2URrWd9K4/5UPTjuaDFH6rbr7Yi
         A/2A==
X-Gm-Message-State: AOJu0YwHfCb7qQwHQzcg3pjb3/aDcQcDVUi11MXoPluctd4NXFchffut
	JqpMCnx+pRWgDMumLt5c9qz9GpCot8y3CywG0Po=
X-Google-Smtp-Source: AGHT+IHNybKJyRL115STmke+mJBBLpb72k/nusUuGsqlLJZZnSa/+eziMVVFWzCKHCT3Qez7vepBVUhLO2cGnfNCpUg=
X-Received: by 2002:a05:6870:eca2:b0:1f9:5081:f287 with SMTP id
 eo34-20020a056870eca200b001f95081f287mr26311523oab.27.1701305278396; Wed, 29
 Nov 2023 16:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127193703.1980089-1-nphamcs@gmail.com> <20231127193703.1980089-3-nphamcs@gmail.com>
 <ZWW1IG0Mv3r0m4mp@tiehlicka> <CAKEwX=OGtkqWys9VM9EBScoCdAjSdfPjEkvoY7_u9udDZBFFpw@mail.gmail.com>
 <ZWcB_r8ywytCFR8B@tiehlicka>
In-Reply-To: <ZWcB_r8ywytCFR8B@tiehlicka>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 29 Nov 2023 16:47:47 -0800
Message-ID: <CAKEwX=PgubfJeCVYUzCCqgGzn=KsjOcUbFJ+Y-Jd5pfk7Wrv-A@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 1:18=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 28-11-23 08:53:56, Nhat Pham wrote:
> > On Tue, Nov 28, 2023 at 1:38=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 27-11-23 11:36:59, Nhat Pham wrote:
> > > > The new zswap writeback scheme requires an online-only memcg hierar=
chy
> > > > traversal. Add a new parameter to mem_cgroup_iter() to check for
> > > > onlineness before returning.
> > >
> > > Why is this needed?
> >
> > For context, in patch 3 of this series, Domenico and I are adding
> > cgroup-aware LRU to zswap, so that we can perform workload-specific
> > zswap writeback. When the reclaim happens due to the global zswap
> > limit being hit, a cgroup is selected by the mem_cgroup_iter(), and
> > the last one selected is saved in the zswap pool (so that the
> > iteration can follow from there next time the limit is hit).
> >
> > However, one problem with this scheme is we will be pinning the
> > reference to that saved memcg until the next global reclaim attempt,
> > which could prevent it from being killed for quite some time after it
> > has been offlined. Johannes, Yosry, and I discussed a couple of
> > approaches for a while, and decided to add a callback that would
> > release the reference held by the zswap pool when the memcg is
> > offlined, and the zswap pool will obtain the reference to the next
> > online memcg in the traversal (or at least one that has not had the
> > zswap-memcg-release-callback run on it yet).
>
> This should be a part of the changelog along with an explanation why
> this cannot be handled on the caller level? You have a pin on the memcg,
> you can check it is online and scratch it if not, right? Why do we need
> to make a rather convoluted iterator interface more complex when most
> users simply do not require that?

Ah that's a good point. Hmm then I'll just do an extra online check in
the zswap reclaim callsite - cleaner and less invasive.

Thanks for the suggestion!
>
> --
> Michal Hocko
> SUSE Labs

