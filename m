Return-Path: <linux-kselftest+bounces-31182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE2A93EA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 22:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961633B8EF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D686522D787;
	Fri, 18 Apr 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6J+k3TH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97ED4A18
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006609; cv=none; b=LcuvYytz3P5IDXNz6TulA7JHoF9bIqDxTJjH9os0jnWOxaczCLzYp5Bh64//BWrrdk/bmFMXYBzX1lyL7eCECjrDF1cIkGmuhUBEpW2mzXKM3/7XjF4WpSelF3w3oWP9r2dqrY2T2dPaH5tw8LWuMvtXXB+XWP5EmFnWWY1lUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006609; c=relaxed/simple;
	bh=yA/T7O4DUU89cahtyYsKA6d+y8ammt9lMcd1G0ztWT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMqmLpHFXlv/o98L9xFoiI1NxwDhWtWt2tpKRAB2FdU0nD4TN0pGjPvb1+gxi0xKbrvi2ZPqbfMdTT4vKJDIT4FQXwReLu2I3TsbYRN1O3GnIb6f1e5MN4SxvZjsy0STq45R4RhDGXiVgE/GkzhjJrTaVaaarpdYUFxqpJvS69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6J+k3TH; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4774611d40bso401401cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745006606; x=1745611406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+oOpqVmU39D7pSdmadeSMDPqu3kAnHCqdURVPU0NY8=;
        b=j6J+k3THLPTYaB5oHWEZ49Yz961fki+268FnpW28n+qUt8b6xySUHxOO0ATBSr2c5Z
         f5Wij4zjZhI2OWTcZPQZsCT1Fu0sFR0Uh2lfhBINvrB8KydNbZGUWgEIWDU6gn3BwLmu
         K+90uwI+xGxaEEfNnTHKDVofjNzE8Bwd3LAFGwwGuSoRK9JopSDX4CmB5x3GbysXcPQe
         VBW4Df3E2kKP2kQSqV1g31rjs5DXj05HIjJ16G6Vv4E8DtsdRbf9bepWs3a4tggzf7Su
         KuHk3yUQWeRcEiGZz6T8Lqurnza+eExd6luZ197I7wGNAMClGYS2qtzIqRKjZRQFHQXp
         sDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006606; x=1745611406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+oOpqVmU39D7pSdmadeSMDPqu3kAnHCqdURVPU0NY8=;
        b=etaCHUo2XM1CT9hEYKu6axQ6rhByrtt8o2KnpzI08JNsTAAhT60Y3eHnuzpDAZHZ71
         r47XzJmeKOWKVvmVPkae16HRfnOh3NrOmAHQqUYk3IWo71zmobeFkZaEekGieQK67vdW
         HIsLDjtBw2WdTvQyp0ZlNEEduDk/hqlbAr+yevI84d7Mu9cTdAhp1Rq3Ch0MTdoZ7dTI
         AiluBovdt/eNmmLLfq+1UD7Tl+0LZeZiKpAsIcCkN4/qGVgSYtpmhzRPbNim189R8AYY
         iFR5oKEYlhh1CRICiy8yuTddHHln450hbRJ8BGWPeBdaPCW+5VCFyuI0Nu/zBIcr+2Fo
         r4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCX2oPxhM4Ah6LuvOgcpiHTV2tglNzP88yRihRvzUqQUz6wtA85n/HjcwXo9T+5BcdfQyWZL3b3ns8Fe8Cc/gs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJp+GueIg4lII716Qzbe7Nz/xcJNaq9ZYGCP2h4PKZNjG2Qib
	pQHKgWOfWME39VZUJiaccs+0sDUECgPqDrGGHZssM/4AIgcKiUbNNWd5ty0AtOlwOb79kwvw3ft
	k6NtRay9QP6E9bbofrkZKBxi9zV/zEqEgf/AL
X-Gm-Gg: ASbGncuN3NVAk3pE8/rrCleJAXHzrSIKyFhzXWF2HbQUR2eAyY45Erh8zZ8N91gAvOb
	M98HVGfmuT0Kblj+aSR6YNTNuexxRYxQm9jNccXmdruF025U7gPTkWaZh2qd9vIjQljiratlCOL
	S8LZfjnTjvERTFZ0EvGVGm
X-Google-Smtp-Source: AGHT+IEp1qePU0PupxqAwvljmN3koti1+LUS4DXKxAoFbiSXRYU93X8EtDbhsmQD9vTQaLe5ynHWCwoNQz4TkmLkIk8=
X-Received: by 2002:a05:622a:491:b0:476:f4e9:314e with SMTP id
 d75a77b69052e-47aecc92a27mr4420151cf.25.1745006605364; Fri, 18 Apr 2025
 13:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-4-surenb@google.com>
 <5958fb2d-a2ac-4a24-8595-222d7e298951@lucifer.local> <CAJuCfpEwnbKA1y-iMs+ky465-Ok5j_f4ojaZV60yap2QGbfpmQ@mail.gmail.com>
 <361e32be-7faa-41e5-a64f-fa95317abdb8@lucifer.local>
In-Reply-To: <361e32be-7faa-41e5-a64f-fa95317abdb8@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 18 Apr 2025 13:03:14 -0700
X-Gm-Features: ATxdqUEenzbjQtOpE6Q6rVXg11gqNC0rtlK0DuSQk3YtHt5FbZ3QGSYLe-E2TGU
Message-ID: <CAJuCfpHLMErQTwfZyLRVn+Rg5zYEHQK34dbX-QxavqUJYek=OQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] selftests/proc: extend /proc/pid/maps tearing test
 to include vma remapping
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 12:56=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Apr 18, 2025 at 12:31:29PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Apr 18, 2025 at 11:30=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Fri, Apr 18, 2025 at 10:49:54AM -0700, Suren Baghdasaryan wrote:
> > > > Test that /proc/pid/maps does not report unexpected holes in the ad=
dress
> > > > space when we concurrently remap a part of a vma into the middle of
> > > > another vma. This remapping results in the destination vma being sp=
lit
> > > > into three parts and the part in the middle being patched back from=
,
> > > > all done concurrently from under the reader. We should always see e=
ither
> > > > original vma or the split one with no holes.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Umm, but we haven't fixed this in the mremap code right? :) So isn't =
this test
> > > failing right now? :P
> > >
> > > My understanding from meeting was you'd drop this commit/mark it skip=
ped
> > > for now or something like this?
> >
> > After you pointed out the issue in mremap_to() I spent some time
> > investigating that code. IIUC the fact that mremap_to() does
> > do_munmap() and move_vma() as two separate operations should not
> > affect lockless reading because both those operations are done under
> > mmap_write_lock() without dropping it in between. Since my lockless
> > mechanism uses mmap_lock_speculate_xxx API to detect address space
> > modifications and retry if concurrent update happen, it should be able
> > to handle this case. The vma it reports should be either the version
> > before mmap_write_lock was taken (before the mremap()) or after it got
> > dropped (after mremap() is complete). Did I miss something more
> > subtle?
>
> Speaking to Liam, seems perhaps the implementation has changed since we f=
irst
> started looking at this?
>
> I guess it's this speculation stuff that keeps you safe then, yeah we hol=
d the
> write lock over both.
>
> So actually ideal if we can avoid having to fix up the mremap implementat=
ion!
>
> If you're sure that the speculation combined with mmap write lock keeps u=
s safe
> then we should be ok I'd say.

Yeah, I tested that quite rigorously and confirmed (using the
mm->mm_lock_seq) that mmap_write_lock is not dropped somewhere in the
middle of those operations. I think we should be safe.

>
> >
> > >
> > > > ---
> > > >  tools/testing/selftests/proc/proc-pid-vm.c | 92 ++++++++++++++++++=
++++
> > > >  1 file changed, 92 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/tes=
ting/selftests/proc/proc-pid-vm.c
> > > > index 39842e4ec45f..1aef2db7e893 100644
> > > > --- a/tools/testing/selftests/proc/proc-pid-vm.c
> > > > +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> > > > @@ -663,6 +663,95 @@ static void test_maps_tearing_from_resize(int =
maps_fd,
> > > >       signal_state(mod_info, TEST_DONE);
> > > >  }
> > > >
> > > > +static inline void remap_vma(const struct vma_modifier_info *mod_i=
nfo)
> > > > +{
> > > > +     /*
> > > > +      * Remap the last page of the next vma into the middle of the=
 vma.
> > > > +      * This splits the current vma and the first and middle parts=
 (the
> > > > +      * parts at lower addresses) become the last vma objserved in=
 the
> > > > +      * first page and the first vma observed in the last page.
> > > > +      */
> > > > +     assert(mremap(mod_info->next_addr + page_size * 2, page_size,
> > > > +                   page_size, MREMAP_FIXED | MREMAP_MAYMOVE | MREM=
AP_DONTUNMAP,
> > > > +                   mod_info->addr + page_size) !=3D MAP_FAILED);
> > > > +}
> > > > +
> > > > +static inline void patch_vma(const struct vma_modifier_info *mod_i=
nfo)
> > > > +{
> > > > +     assert(!mprotect(mod_info->addr + page_size, page_size,
> > > > +                      mod_info->prot));
> > > > +}
> > > > +
> > > > +static inline void check_remap_result(struct line_content *mod_las=
t_line,
> > > > +                                   struct line_content *mod_first_=
line,
> > > > +                                   struct line_content *restored_l=
ast_line,
> > > > +                                   struct line_content *restored_f=
irst_line)
> > > > +{
> > > > +     /* Make sure vmas at the boundaries are changing */
> > > > +     assert(strcmp(mod_last_line->text, restored_last_line->text) =
!=3D 0);
> > > > +     assert(strcmp(mod_first_line->text, restored_first_line->text=
) !=3D 0);
> > > > +}
> > > > +
> > > > +static void test_maps_tearing_from_remap(int maps_fd,
> > > > +                             struct vma_modifier_info *mod_info,
> > > > +                             struct page_content *page1,
> > > > +                             struct page_content *page2,
> > > > +                             struct line_content *last_line,
> > > > +                             struct line_content *first_line)
> > > > +{
> > > > +     struct line_content remapped_last_line;
> > > > +     struct line_content remapped_first_line;
> > > > +     struct line_content restored_last_line;
> > > > +     struct line_content restored_first_line;
> > > > +
> > > > +     wait_for_state(mod_info, SETUP_READY);
> > > > +
> > > > +     /* re-read the file to avoid using stale data from previous t=
est */
> > > > +     read_boundary_lines(maps_fd, page1, page2, last_line, first_l=
ine);
> > > > +
> > > > +     mod_info->vma_modify =3D remap_vma;
> > > > +     mod_info->vma_restore =3D patch_vma;
> > > > +     mod_info->vma_mod_check =3D check_remap_result;
> > > > +
> > > > +     capture_mod_pattern(maps_fd, mod_info, page1, page2, last_lin=
e, first_line,
> > > > +                         &remapped_last_line, &remapped_first_line=
,
> > > > +                         &restored_last_line, &restored_first_line=
);
> > > > +
> > > > +     /* Now start concurrent modifications for test_duration_sec *=
/
> > > > +     signal_state(mod_info, TEST_READY);
> > > > +
> > > > +     struct line_content new_last_line;
> > > > +     struct line_content new_first_line;
> > > > +     struct timespec start_ts, end_ts;
> > > > +
> > > > +     clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
> > > > +     do {
> > > > +             read_boundary_lines(maps_fd, page1, page2, &new_last_=
line, &new_first_line);
> > > > +
> > > > +             /* Check if we read vmas after remapping it */
> > > > +             if (!strcmp(new_last_line.text, remapped_last_line.te=
xt)) {
> > > > +                     /*
> > > > +                      * The vmas should be consistent with remap r=
esults,
> > > > +                      * however if the vma was concurrently restor=
ed, it
> > > > +                      * can be reported twice (first as split one,=
 then
> > > > +                      * as restored one) because we found it as th=
e next vma
> > > > +                      * again. In that case new first line will be=
 the same
> > > > +                      * as the last restored line.
> > > > +                      */
> > > > +                     assert(!strcmp(new_first_line.text, remapped_=
first_line.text) ||
> > > > +                            !strcmp(new_first_line.text, restored_=
last_line.text));
> > > > +             } else {
> > > > +                     /* The vmas should be consistent with the ori=
ginal/resored state */
> > > > +                     assert(!strcmp(new_last_line.text, restored_l=
ast_line.text) &&
> > > > +                            !strcmp(new_first_line.text, restored_=
first_line.text));
> > > > +             }
> > > > +             clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> > > > +     } while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec)=
;
> > > > +
> > > > +     /* Signal the modifyer thread to stop and wait until it exits=
 */
> > > > +     signal_state(mod_info, TEST_DONE);
> > > > +}
> > > > +
> > > >  static int test_maps_tearing(void)
> > > >  {
> > > >       struct vma_modifier_info *mod_info;
> > > > @@ -757,6 +846,9 @@ static int test_maps_tearing(void)
> > > >       test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &pag=
e2,
> > > >                                     &last_line, &first_line);
> > > >
> > > > +     test_maps_tearing_from_remap(maps_fd, mod_info, &page1, &page=
2,
> > > > +                                  &last_line, &first_line);
> > > > +
> > > >       stop_vma_modifier(mod_info);
> > > >
> > > >       free(page2.data);
> > > > --
> > > > 2.49.0.805.g082f7c87e0-goog
> > > >

