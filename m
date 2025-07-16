Return-Path: <linux-kselftest+bounces-37432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E63B0781B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA431899F69
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E69253F00;
	Wed, 16 Jul 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CB8+OILg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BB1A238C
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676195; cv=none; b=UVk11CBcm7I9Gykv1LA9f+u1UPXDvt4MXi9WSz3dAhhow0dUX69UbgRvWphCehzhOB1VDjE+69kAYG/jvduB11ZCz98uSKHxqzTE2Od64jQRwPABPqQx/Yg5jeqqr08SrU47f386OcEJmAogA9TAf1MmMVZxKaP1qwis61CkdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676195; c=relaxed/simple;
	bh=01PZ/xKuO5lByV/sYsB5ZFdAMbt7OpQEfhoPNdSub8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NITpgyhQTicQgf67LFPr8SPwX+SVeujGn52/EOoP7CZwGH09e2+mhbBPg59N45RUa8vBijWZrzoeF6bllwFZ72I8E0LNCdDKY3yZhaJnVzDKM6hF5qnWBiPAI9L9d3qaFsigNfqax/d02IZ/gQM7oAxXqAPXXv5xWab+2kh2+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CB8+OILg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab86a29c98so482711cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752676193; x=1753280993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9dJcIYNmFLt97FV6TaWcTMU/S/O8suqtyZyGxaHRnM=;
        b=CB8+OILgwaZ4T539JjNAnDn/MaCIONMJ0tfXFUFpoFMzLhHrZAfbWb/tvBL11Krtv2
         LfZQAoMSDdcwXOoe30pHwRlCkn9vdtmpsjQgiyWTyWGJumzQWpVTbv7qY1GasFOF5eOb
         OBiF/Gc0Y/fjVSQZrEWHOgVgFaBbuMDypNhikVMyMpByS63JFHS99DzeRhJ2j9eCaZni
         PDWNIZu2Byb73uk61duti0xNI6Dv8ydo8mb7g8oWhAeCS+wdiB/0rd7HiecGmgE5655m
         PpGZN236WNDqc5DS5mb5C2rw3J27hXJ3RZvz3M7b5pnVnN9XWe1SkdyYTNzudFPRi42S
         5QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676193; x=1753280993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9dJcIYNmFLt97FV6TaWcTMU/S/O8suqtyZyGxaHRnM=;
        b=i+XAyf+gA5e8MRXiRy9cnIgNwY95geoZ5UdmqDUz4AGf5Kt10Bfnn0R3EQAG3o+BlV
         oIzI6ns4aL72fVG+4T4dWAtGJRgcdQAqTrU53D8JJ1shvaJyF5tdicM2UuoY3PJvyg+6
         gPtOskv8TWjjWqhyEXwSIauS93Ucv+PEpZvY68P8CUosm9mx4Z9LFgb3yllS1oUsgnvI
         PWvyjoEp3fGQ3uVRiVo0Vgr6IjXnI1df22zdZ/87MPtZqSUZaQHLAQV5RjapKsYituaE
         nSRV43ilh8SnqFdVQ2jFmrnEH5o8n+NtIeS/hLY8+IbOA2w88xga+/F/lDFyMBepzgWT
         9loQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnQq3IO9ViJU+tJqTq0CoGcTyB3MAovsbnvXOe9naHdzehlTEYRBvhJA6P3gyK+fKwcB4y+PnzHtpamRl2QbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkOEE6NFWgVEjn1nmpWVLZL04CgFcNh+TE/sCpqviPxk/vJT6
	ffC5SBlGF/fC7+NyAjNKr0O1GeuU5w/j52XpDNIO+JJRjU2qQtGS0Dzj5zfrO9ElbZ8jynY89uD
	zbuELTQp7rJfek8uexWUGmFJZnRSoM65/hkjX/uDj
X-Gm-Gg: ASbGnct6awOd8LGZoL7QU+JLX17TjEQchYfBOoEUNEovnzP/GX/Ucle6jU86QZHyJU1
	h9/K02mw0Zye5qxJsgMVcTUAPnRsTtC2fjABXAV9/iGTNrsJ59ARTzlahGW55sf0sr1E+t9Vj4d
	W160Lr4FWgBVywdnxTaVrGsiZYOHULDa5A3JAXQyJG2ZRPD+ZbF9JPYPkt9GAyOJAM/wyJFhEQz
	g/ALNK0xVHISdmDB1IN4x/YMxtbhiqMJ8WV
X-Google-Smtp-Source: AGHT+IF1jgIoyk5R1Kif1z4ud/Iv9ltObgmGNfl91kkWVCZZHs4vDHtmbDAOFhVoWxeWru8tTtLk2fMmer7cvrmEICE=
X-Received: by 2002:a05:622a:1aa0:b0:4a9:d263:dbc5 with SMTP id
 d75a77b69052e-4ab954da1cfmr2945571cf.20.1752676192219; Wed, 16 Jul 2025
 07:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716030557.1547501-8-surenb@google.com>
 <dd88b2fc-6963-454b-8cc0-7bd3360a562e@suse.cz>
In-Reply-To: <dd88b2fc-6963-454b-8cc0-7bd3360a562e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 07:29:41 -0700
X-Gm-Features: Ac12FXzno4zj4-9Yms3LsC7vLEmlFKsL-np6yaN8ehs9Whc_WjCHA4V2guD--iU
Message-ID: <CAJuCfpGRAL6YPqTR9SpPPuTamGJLdg4OEGmPUMERYDgjQCHAiA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/16/25 05:05, Suren Baghdasaryan wrote:
> > With maple_tree supporting vma tree traversal under RCU and per-vma
> > locks, /proc/pid/maps can be read while holding individual vma locks
> > instead of locking the entire address space.
> > A completely lockless approach (walking vma tree under RCU) would be
> > quite complex with the main issue being get_vma_name() using callbacks
> > which might not work correctly with a stable vma copy, requiring
> > original (unstable) vma - see special_mapping_name() for example.
> >
> > When per-vma lock acquisition fails, we take the mmap_lock for reading,
> > lock the vma, release the mmap_lock and continue. This fallback to mmap
> > read lock guarantees the reader to make forward progress even during
> > lock contention. This will interfere with the writer but for a very
> > short time while we are acquiring the per-vma lock and only when there
> > was contention on the vma reader is interested in.
> >
> > We shouldn't see a repeated fallback to mmap read locks in practice, as
> > this require a very unlikely series of lock contentions (for instance
> > due to repeated vma split operations). However even if this did somehow
> > happen, we would still progress.
> >
> > One case requiring special handling is when a vma changes between the
> > time it was found and the time it got locked. A problematic case would
> > be if a vma got shrunk so that its vm_start moved higher in the address
> > space and a new vma was installed at the beginning:
> >
> > reader found:               |--------VMA A--------|
> > VMA is modified:            |-VMA B-|----VMA A----|
> > reader locks modified VMA A
> > reader reports VMA A:       |  gap  |----VMA A----|
> >
> > This would result in reporting a gap in the address space that does not
> > exist. To prevent this we retry the lookup after locking the vma, howev=
er
> > we do that only when we identify a gap and detect that the address spac=
e
> > was changed after we found the vma.
> >
> > This change is designed to reduce mmap_lock contention and prevent a
> > process reading /proc/pid/maps files (often a low priority task, such
> > as monitoring/data collection services) from blocking address space
> > updates. Note that this change has a userspace visible disadvantage:
> > it allows for sub-page data tearing as opposed to the previous mechanis=
m
> > where data tearing could happen only between pages of generated output
> > data. Since current userspace considers data tearing between pages to b=
e
> > acceptable, we assume is will be able to handle sub-page data tearing
> > as well.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Nit: the previous patch changed lines with e.g. -2UL to -2 and this seems
> changing the same lines to add a comment e.g. *ppos =3D -2; /* -2 indicat=
es
> gate vma */
>
> That comment could have been added in the previous patch already. Also if
> you feel the need to add the comments, maybe it's time to just name those
> special values with a #define or something :)

Good point. I'll see if I can fit that into the next version.

>

