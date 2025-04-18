Return-Path: <linux-kselftest+bounces-31179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BBCA93E46
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 21:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBD83AE8F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330422B8D9;
	Fri, 18 Apr 2025 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFq4Efj/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CE154457
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745004704; cv=none; b=cMV0+nJCFyEz34HIy+b1b5zV7tnufacnMw9truV1qQu5lE5rkR/7qkmYxbjziKZdp4tpUvlMYAPv6sVNEbHe25sldPP2XlAjiiJcoorw97TsfnCj0Y0oAmH4VofFamSe+knm/1WGF/0FSEbXCpTkxWBgaOtZ7Nbzpmc8PUx9Y/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745004704; c=relaxed/simple;
	bh=BCL6pqN2wfd4pZVp4ZtfV4Akx9xssXJ6jKXp4vbmjFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgC3HnyQMfUPlbYOlF0c31FK/AbDJqfAonWnIFb58/u8974/6dXdGH5MT+kn9fq8IyDbk36UgcMRdTStpWx93XGZB0+NByM44O4uUjYkNjUgrmbhzV6mGmKpNcf8jTnCN2m53n1tP6fVhc6u89h33iRdpjCOvKfghIfyhHKwfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFq4Efj/; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47681dba807so347531cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Apr 2025 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745004700; x=1745609500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWNK5ZwuejE7tXwmDLQZRJ8XpCbjqSeVlDw7EZQYS7E=;
        b=jFq4Efj/miqM+pNkIFD7wySP2NR9P4Ze9OvUJHugWXS4Bo6S3zgCQmvGMxXtWt+3vJ
         iiWpodQa+WAw8na3g/TMFIe2oMqtN6GMstvt9oDHn6I8S/2rScMQsXWYOLzdL583AECr
         BIrQiJxRSbwp4lgzORS66bvCxfhtwS13a2pUajfKXh7wQZau5YS962UNVZT4Q/RxQuyn
         +Rejs1TzhOdWGMyp17+kKVLcn4gcd64XOq6Niq9V2YBwtaMPxZFXft22JgP7laMnNiAq
         w4R3/9dbKL8sFT9gylLRjlEMzDvWijg79Zcmihe1XHlRDvaQPuYmZpY5Tcezj6Ez3TY7
         Tskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745004700; x=1745609500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWNK5ZwuejE7tXwmDLQZRJ8XpCbjqSeVlDw7EZQYS7E=;
        b=nlerwZKE9QyCQHC59zxdzSJmOCGMzUlhbz3aRFLfWfzsiN6mBZ60lUv+AOM0Njym8C
         jTiILX2Vk8ynVht+7kT4eG2L0g8jzSqWAUkZbQUahXWJeIP0Uu8etzZZTcXISc6gEOHr
         kdW38jgjzeMubIah1pE8YenOk4C+cHbnUQGsLXXQMogIYAAcuT7otBqpQKZnru3XjBih
         fT/yQ9n6wC7ovvEHSOdHGDFB2sgfXJb5ZIX/Nkz6ZROACnMfm2+I3nqI59L6/DrRHVxO
         a/CmY/bZ0aXnZFp8N7yl2i9Z4VoHYXkYFjYOTrrGd5KwycwkKAU8DxfyYgBcH23OcgOa
         u1zw==
X-Forwarded-Encrypted: i=1; AJvYcCVubIvwDbtljFjShZyn/LY99v5q4x9btIQRRn0YIsjba2RYqbI/g70Ba8F+9vi2qpvh+kGJJHquVyIbRN+jlYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyL82hEeSHdKrcKfYFo1x+EUXW2Fdkb5oNPhtmnkzNZ5P2aVp
	/Ysun5QnQv3xthptbWc+gFMQLptYRWN/2UxhgFGvoiFhpDq6T9QbBk9riQ6UiM0an+kLjcDxrzs
	oEwUe3vmFTQZIASAJDLrNF3DzBp3UOUKjmvtV
X-Gm-Gg: ASbGncuQVOpCqY0XdZoiUjR3Mr2etGTrZNi1ZMJhnntdP79Ysa8COJ0wXMbJLuK4Fwm
	KpJk2EWBO07kDY0eOImp5uZVICwkgw1hhn1FE5sriVvRNH7lJ7jCElbRFP6mmzGeMMa1K7/POJh
	STZ8LqGz7QI96GOKwa/N6wWyG0zNq9ihMtQ8tOukPgYsfdNWm2h+w=
X-Google-Smtp-Source: AGHT+IGv7KDN4Lh/PcDOZZy0o9zxti5r+f9e4oyoOA8u8LUMboIW11yYiLi+ycBx4Ubd8zWM06bhkMxGNcQoP3RZ7DU=
X-Received: by 2002:a05:622a:118d:b0:476:f4e9:3152 with SMTP id
 d75a77b69052e-47aecc8978amr4180221cf.25.1745004700221; Fri, 18 Apr 2025
 12:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-4-surenb@google.com>
 <5958fb2d-a2ac-4a24-8595-222d7e298951@lucifer.local>
In-Reply-To: <5958fb2d-a2ac-4a24-8595-222d7e298951@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 18 Apr 2025 12:31:29 -0700
X-Gm-Features: ATxdqUHq0cj3b-wClcFL4LSAdvNKcZinahLl1OzjF_qAlRbobWNpAJquGdnFx-U
Message-ID: <CAJuCfpEwnbKA1y-iMs+ky465-Ok5j_f4ojaZV60yap2QGbfpmQ@mail.gmail.com>
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

On Fri, Apr 18, 2025 at 11:30=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Apr 18, 2025 at 10:49:54AM -0700, Suren Baghdasaryan wrote:
> > Test that /proc/pid/maps does not report unexpected holes in the addres=
s
> > space when we concurrently remap a part of a vma into the middle of
> > another vma. This remapping results in the destination vma being split
> > into three parts and the part in the middle being patched back from,
> > all done concurrently from under the reader. We should always see eithe=
r
> > original vma or the split one with no holes.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Umm, but we haven't fixed this in the mremap code right? :) So isn't this=
 test
> failing right now? :P
>
> My understanding from meeting was you'd drop this commit/mark it skipped
> for now or something like this?

After you pointed out the issue in mremap_to() I spent some time
investigating that code. IIUC the fact that mremap_to() does
do_munmap() and move_vma() as two separate operations should not
affect lockless reading because both those operations are done under
mmap_write_lock() without dropping it in between. Since my lockless
mechanism uses mmap_lock_speculate_xxx API to detect address space
modifications and retry if concurrent update happen, it should be able
to handle this case. The vma it reports should be either the version
before mmap_write_lock was taken (before the mremap()) or after it got
dropped (after mremap() is complete). Did I miss something more
subtle?

>
> > ---
> >  tools/testing/selftests/proc/proc-pid-vm.c | 92 ++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >
> > diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing=
/selftests/proc/proc-pid-vm.c
> > index 39842e4ec45f..1aef2db7e893 100644
> > --- a/tools/testing/selftests/proc/proc-pid-vm.c
> > +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> > @@ -663,6 +663,95 @@ static void test_maps_tearing_from_resize(int maps=
_fd,
> >       signal_state(mod_info, TEST_DONE);
> >  }
> >
> > +static inline void remap_vma(const struct vma_modifier_info *mod_info)
> > +{
> > +     /*
> > +      * Remap the last page of the next vma into the middle of the vma=
.
> > +      * This splits the current vma and the first and middle parts (th=
e
> > +      * parts at lower addresses) become the last vma objserved in the
> > +      * first page and the first vma observed in the last page.
> > +      */
> > +     assert(mremap(mod_info->next_addr + page_size * 2, page_size,
> > +                   page_size, MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_D=
ONTUNMAP,
> > +                   mod_info->addr + page_size) !=3D MAP_FAILED);
> > +}
> > +
> > +static inline void patch_vma(const struct vma_modifier_info *mod_info)
> > +{
> > +     assert(!mprotect(mod_info->addr + page_size, page_size,
> > +                      mod_info->prot));
> > +}
> > +
> > +static inline void check_remap_result(struct line_content *mod_last_li=
ne,
> > +                                   struct line_content *mod_first_line=
,
> > +                                   struct line_content *restored_last_=
line,
> > +                                   struct line_content *restored_first=
_line)
> > +{
> > +     /* Make sure vmas at the boundaries are changing */
> > +     assert(strcmp(mod_last_line->text, restored_last_line->text) !=3D=
 0);
> > +     assert(strcmp(mod_first_line->text, restored_first_line->text) !=
=3D 0);
> > +}
> > +
> > +static void test_maps_tearing_from_remap(int maps_fd,
> > +                             struct vma_modifier_info *mod_info,
> > +                             struct page_content *page1,
> > +                             struct page_content *page2,
> > +                             struct line_content *last_line,
> > +                             struct line_content *first_line)
> > +{
> > +     struct line_content remapped_last_line;
> > +     struct line_content remapped_first_line;
> > +     struct line_content restored_last_line;
> > +     struct line_content restored_first_line;
> > +
> > +     wait_for_state(mod_info, SETUP_READY);
> > +
> > +     /* re-read the file to avoid using stale data from previous test =
*/
> > +     read_boundary_lines(maps_fd, page1, page2, last_line, first_line)=
;
> > +
> > +     mod_info->vma_modify =3D remap_vma;
> > +     mod_info->vma_restore =3D patch_vma;
> > +     mod_info->vma_mod_check =3D check_remap_result;
> > +
> > +     capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, f=
irst_line,
> > +                         &remapped_last_line, &remapped_first_line,
> > +                         &restored_last_line, &restored_first_line);
> > +
> > +     /* Now start concurrent modifications for test_duration_sec */
> > +     signal_state(mod_info, TEST_READY);
> > +
> > +     struct line_content new_last_line;
> > +     struct line_content new_first_line;
> > +     struct timespec start_ts, end_ts;
> > +
> > +     clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
> > +     do {
> > +             read_boundary_lines(maps_fd, page1, page2, &new_last_line=
, &new_first_line);
> > +
> > +             /* Check if we read vmas after remapping it */
> > +             if (!strcmp(new_last_line.text, remapped_last_line.text))=
 {
> > +                     /*
> > +                      * The vmas should be consistent with remap resul=
ts,
> > +                      * however if the vma was concurrently restored, =
it
> > +                      * can be reported twice (first as split one, the=
n
> > +                      * as restored one) because we found it as the ne=
xt vma
> > +                      * again. In that case new first line will be the=
 same
> > +                      * as the last restored line.
> > +                      */
> > +                     assert(!strcmp(new_first_line.text, remapped_firs=
t_line.text) ||
> > +                            !strcmp(new_first_line.text, restored_last=
_line.text));
> > +             } else {
> > +                     /* The vmas should be consistent with the origina=
l/resored state */
> > +                     assert(!strcmp(new_last_line.text, restored_last_=
line.text) &&
> > +                            !strcmp(new_first_line.text, restored_firs=
t_line.text));
> > +             }
> > +             clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> > +     } while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
> > +
> > +     /* Signal the modifyer thread to stop and wait until it exits */
> > +     signal_state(mod_info, TEST_DONE);
> > +}
> > +
> >  static int test_maps_tearing(void)
> >  {
> >       struct vma_modifier_info *mod_info;
> > @@ -757,6 +846,9 @@ static int test_maps_tearing(void)
> >       test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
> >                                     &last_line, &first_line);
> >
> > +     test_maps_tearing_from_remap(maps_fd, mod_info, &page1, &page2,
> > +                                  &last_line, &first_line);
> > +
> >       stop_vma_modifier(mod_info);
> >
> >       free(page2.data);
> > --
> > 2.49.0.805.g082f7c87e0-goog
> >

