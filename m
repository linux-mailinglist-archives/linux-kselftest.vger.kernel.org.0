Return-Path: <linux-kselftest+bounces-16862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C18DC966D0C
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 01:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BEF1F2450B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 23:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F9818F2D3;
	Fri, 30 Aug 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VlniHyU4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF317B510
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725062261; cv=none; b=e0bW/iwNt2Y9cEKpcIJZztGnP8t0AMIqTmE5v7So++HlFf6F/QuemQ5cTY+A2x9GwZYMRP0KmyALxYT7ni5B+hzNAw832QZP7vMhKFBrMuJRpKmks0Bh9sHLlhBBdcniujFk7HuMFp//9F3m4KDaqY5QW+lk1V9sh5fUsGDighs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725062261; c=relaxed/simple;
	bh=dCKdUGjicATV4rkdkvomgbNd8TuLGBpl3gUg9RLVAPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A20wHjdGGFh1nu5ayP3CHKic2mzMbfig8Fj6Vbuw4KszuBdq3dn83iC4z5g5GBgaB0pZsUL3+vYAOsmsi3/nUv5iyRFout7MLmmIS69i8UTNjK5UDs0jT3KlsGlvhKN/pHqBwHnsi4UJDJydA4wMGlUBjf1au0t2OAWgvTALBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VlniHyU4; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-26110765976so198544fac.1
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725062259; x=1725667059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvEfYKOVVxE8dkrUColYKOziuScNHjuMeSwgzin4M+4=;
        b=VlniHyU4CHxwQmk3shD/r56HkwIAE2YgZgtQOmxCfxilQhmKyJk1V7daHLKgel4SR6
         V/i6vQ9KkKScAA7cdv/VW2k5nbY/Sx/ORT9Xo1QKYRA3QS/qg6NIhX2N2qcB/plafc1T
         uNBkf4eLvRLnwI7Komr9wn2q/PXRsv94zQpDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725062259; x=1725667059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvEfYKOVVxE8dkrUColYKOziuScNHjuMeSwgzin4M+4=;
        b=Wv++Ci0J6uVm2JPXqaEH9P1v1AWBUJE/Dw2161MgWz0SP0zKopsJksPNIiMn9NYf+B
         p0/Ip/MExsq0QYNZDSEUhzrj80OpPsmxBQKd81C9YXVCuXf3hiPnlBsVTC7A7/rpb3iQ
         BiCUaLbkWNThiezGHaX2wfXXUc4gvLiOfPSvcENxzL3tFPbe8wAyUGtGoDeSg7wbFDnE
         XoO4S8x4dtuPBA20804T0LDZ8xVBSHSegTkCqktJXe0+nOOMfU+P/30sdbjy1cDW9mn7
         MyfZM5wzIStS5HY/No0bv+2s+U8hwDbcN0s+cXtaN0QyrIWPMldOwuXUC9kfWXwi3ePr
         yqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6I6YhVWieTw4kzxm4dT0wRFdVzHLfG91QG0glz162dvIYgYu4zQbON6A6TtksDGSPtAfrqfcTDuw+Wi0XfLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2dgdYcRW4xxpok1KeFKlWOO4u3wpt6bma+L1N3Y8AWYe5Hbu
	aYaL4FytCQaiCtQhY34l1WAJuoeOQJpGay5MsMiohpVyX2x0MT7qjHxqpUt9WggegkWhwspRX32
	3MIXZCuFIgUGTr9+x2DaGoQnlIzWxJHFgmuvN
X-Google-Smtp-Source: AGHT+IGjMwvg2UrGjfLtNCLSGM6nxH1ui5UjTCg13Enlj4QaUBaQ5TbLUJTqV1S+O33PHEODxv9SrU2l5S/YzS1NHlE=
X-Received: by 2002:a05:6870:218c:b0:277:6b90:1915 with SMTP id
 586e51a60fabf-277b0e4fcc6mr2021449fac.9.1725062258617; Fri, 30 Aug 2024
 16:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830180237.1220027-1-jeffxu@chromium.org> <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local> <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
In-Reply-To: <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 30 Aug 2024 16:57:26 -0700
Message-ID: <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pedro.falcato@gmail.com, willy@infradead.org, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:23=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Aug 30, 2024 at 07:43:12PM GMT, Lorenzo Stoakes wrote:
> > On Fri, Aug 30, 2024 at 06:02:36PM GMT, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Add sealing test to cover mmap for
> > > Expand/shrink across sealed vmas (MAP_FIXED)
> > > Reuse the same address in !MAP_FIXED case.
> >
> > This commit message is woefully small. I told you on v1 to improve the
> > commit messages. Linus has told you to do this before.
> >
> > Please actually respond to feedback. Thanks.
> >
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  tools/testing/selftests/mm/mseal_test.c | 126 ++++++++++++++++++++++=
+-
> > >  1 file changed, 125 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/=
selftests/mm/mseal_test.c
> > > index e855c8ccefc3..3516389034a7 100644
> > > --- a/tools/testing/selftests/mm/mseal_test.c
> > > +++ b/tools/testing/selftests/mm/mseal_test.c
> > > @@ -2222,6 +2222,123 @@ static void test_munmap_free_multiple_ranges(=
bool seal)
> > >     REPORT_TEST_PASS();
> > >  }
> > >
> > > +static void test_seal_mmap_expand_seal_middle(bool seal)
> >
> > This test doesn't expand, doesn't do anything in the middle. It does mm=
ap()
> > though and relates to mseal, so that's something... this is compeltely
> > misnamed and needs to be rethought.
> >
>
> OK correction - it _seals_ in the middle. The remained of the criticism r=
emains,
> and this is rather confusing... and I continue to wonder what the purpose=
 of
> this is?
>
It expands the size (start from ptr).

> > > +{
> > > +   void *ptr;
> > > +   unsigned long page_size =3D getpagesize();
> > > +   unsigned long size =3D 12 * page_size;
> > > +   int ret;
> > > +   void *ret2;
> > > +   int prot;
> > > +
> > > +   setup_single_address(size, &ptr);
> >
> > Please replace every single instance of this with an mmap(). There's
> > literally no reason to abstract it. And munmap() what you map.
> >
No, we need to abstract it.  In addition to the mmap, it also
allocates an additional two blocks before and after the allocated
memory, to avoid auto-merging, so we can use get_vma_size.

> > > +   FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> >
> > Pretty sure Pedro pointed out you should be checking against MAP_FAILED
> > here. I really don't understand why the rest of your test is full of
> > mmap()'s but for some reason you choose to abstract this one call? What=
?
> >
> > > +   /* ummap last 4 pages. */
> > > +   ret =3D sys_munmap(ptr + 8 * page_size, 4 * page_size);
> >
> > sys_munmap()? What's wrong with munmap()?
> >
> > > +   FAIL_TEST_IF_FALSE(!ret);
> >
> > Why do we not have a FAIL_TEST_IF_TRUE()? This is crazy.
> >
> > Would be nice to have something human-readable like ASSERT_EQ() or
> > ASSERT_TRUE() or ASSERT_FALSE().
> >
ASSERT_EQ and ASSERT_TURE are not recommended by the self-test. The
FAIL_TEST_IF_FAIL wrap will take care of some of the admin tasks
related to self-test infra, such as count how many tests are failing.

> > > +
> > > +   size =3D get_vma_size(ptr, &prot);
> > > +   FAIL_TEST_IF_FALSE(size =3D=3D 8 * page_size);
> > > +   FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > +
> > > +   if (seal) {
> > > +           ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > > +           FAIL_TEST_IF_FALSE(!ret);
> > > +   }
> > > +
> > > +   /* use mmap to expand and overwrite (MAP_FIXED)  */
> >
> > You don't really need to say MAP_FIXED, it's below.
> >
Adding a comment here to help reviewers.

> > > +   ret2 =3D mmap(ptr, 12 * page_size, PROT_READ,
> > > +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> >
> > Why read-only?
> >
> > You're not expanding you're overwriting. You're not doing anything in t=
he
> > middle.
> >
The MAP_FIXED is overwriting.  It also expands the address range
(start from ptr) from 8 to 12 pages.

> > I'm again confused about what you think you're testing here. I don't th=
ink
> > we need an arbitrary MAP_FIXED mmap() at a size larger than the overwri=
tten
> > VMA?
> >
> > You just need a single instance of a MAP_FIXED mmap() over a sealed mma=
p()
> > if that's what you want.
> >
> > > +   if (seal) {
> > > +           FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > > +           FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > > +
> > > +           size =3D get_vma_size(ptr, &prot);
> > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > +
> > > +           size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > +   } else
> > > +           FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> >
> > Don't do dangling else's after a big block.
> >
patch passed the checkpatch.pl for style check.

> > > +
> > > +   REPORT_TEST_PASS();
> > > +}
> > > +
> > > +static void test_seal_mmap_shrink_seal_middle(bool seal)
> >
> > What's going on in the 'middle'? This test doesn't shrink, it overwrite=
s
> > the beginning of a sealed VMA?
>
> Correction - the middle is sealed. Other points remain.
>
The mmap attempts to shrink the address range from 12 pages to 8 pages.

> > > +{
> > > +   void *ptr;
> > > +   unsigned long page_size =3D getpagesize();
> > > +   unsigned long size =3D 12 * page_size;
> > > +   int ret;
> > > +   void *ret2;
> > > +   int prot;
> > > +
> > > +   setup_single_address(size, &ptr);
> > > +   FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > +
> > > +   if (seal) {
> > > +           ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > > +           FAIL_TEST_IF_FALSE(!ret);
> > > +   }
> > > +
> > > +   /* use mmap to shrink and overwrite (MAP_FIXED)  */
> >
> > What exactly are you shrinking? You're overwriting the start of the vma=
?
> >
> > What is this testing that is different from the previous test? This see=
ms
> > useless honestly.
> >
Again, as above, one test is expanding, the other test is shrinking.
Please take a look at mmap parameters and steps before mmap call.


> > > +   ret2 =3D mmap(ptr, 7 * page_size, PROT_READ,
> > > +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > > +   if (seal) {
> > > +           FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > > +           FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > > +
> > > +           size =3D get_vma_size(ptr, &prot);
> > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >
> > What the hell is this comparison to magic numbers? This is
> > ridiculous. What's wrong with PROT_xxx??
> >
The PROT_xxx can't be used here.
get_vma_size doesn't return PROT_ type, i.e. the bit sequence is different.

> > > +
> > > +           size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > +
> > > +           size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >
> > Err dude, you're doing this twice?
> >
The second get_vma_size should be (ptr + 8 * page_size)
I will update that.

> > So what are we testing here exactly? That we got a VMA split? This is
> > err... why are we asserting this?
>
> I guess, that we can't overwrite a sealed bit of a VMA at the end. But ag=
ain
> this feels entirely redundant. For this kind of thing to fail would mean =
the
> whole VMA machinery is broken.
>
The test is testing mmap(MAP_FIXED), since it can be used to overwrite
the sealed memory range (without sealing), then there is a variant of
expand/shrink.


> >
> > > +   } else
> > > +           FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> > > +
> > > +   REPORT_TEST_PASS();
> > > +}
> > > +
> > > +static void test_seal_mmap_reuse_addr(bool seal)
> >
> > This is wrong, you're not reusing anything. This test is useless.
> >
The ptr is reused as a hint.

> > > +{
> > > +   void *ptr;
> > > +   unsigned long page_size =3D getpagesize();
> > > +   unsigned long size =3D page_size;
> > > +   int ret;
> > > +   void *ret2;
> > > +   int prot;
> > > +
> > > +   setup_single_address(size, &ptr);
> > > +   FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > +
> > > +   if (seal) {
> > > +           ret =3D sys_mseal(ptr, size);
> > > +           FAIL_TEST_IF_FALSE(!ret);
> >
> > We could avoid this horrid ret, ret2 naming if you just did:
> >
> >       FAIL_TEST_IF_FALSE(sys_mseal(ptr, size));
> >
> > > +   }
> > > +
> > > +   /* use mmap to change protection. */
> > > +   ret2 =3D mmap(ptr, size, PROT_NONE,
> > > +                   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> >
> > How are you using mmap to change the protection when you're providing a
> > hint to the address to use? You're not changing any protection at all!
> >
It is necessary to add the this tests to make sure mseal is behave as
it should be, which is !MAP_FIXED case, new address will be allocated,
instead of fail of mmap()


> > You're allocating an entirely new VMA hinting that you want it near
> > ptr. Please read the man page for mmap():
> >
> >        If addr is NULL, then the kernel chooses the (page-aligned) addr=
ess
> >        at which to create the mapping; this is the most portable method=
 of
> >        creating a new mapping.  If addr is not NULL, then the kernel ta=
kes
> >        it as a hint about where to place the mapping; on Linux, the ker=
nel
> >        will pick a nearby page boundary (but always above or equal to t=
he
> >        value specified by /proc/sys/vm/mmap_min_addr) and attempt to cr=
eate
> >        the mapping there.  If another mapping already exists there, the
> >        kernel picks a new address that may or may not depend on the hin=
t.
> >        The address of the new mapping is returned as the result of the
> >        call.
> >
> > > +
> > > +   /* MAP_FIXED is not used, expect new addr */
> > > +   FAIL_TEST_IF_FALSE(!(ret2 =3D=3D MAP_FAILED));
> >
> > This is beyond horrible. You really have to add more asserts.
> >
Again assert is not recommended by self_test

> > Also you're expecting a new address here, so again, what on earth are y=
ou
> > asserting? That we can mmap()?
> >
> > > +   FAIL_TEST_IF_FALSE(ret2 !=3D ptr);
> > > +
> > > +   size =3D get_vma_size(ptr, &prot);
> > > +   FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > > +   FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > +
> > > +   REPORT_TEST_PASS();
> > > +}
> > > +
> > >  int main(int argc, char **argv)
> > >  {
> > >     bool test_seal =3D seal_support();
> > > @@ -2243,7 +2360,7 @@ int main(int argc, char **argv)
> > >     if (!get_vma_size_supported())
> > >             ksft_exit_skip("get_vma_size not supported\n");
> > >
> > > -   ksft_set_plan(91);
> > > +   ksft_set_plan(97);
> >
> > I'm guessing this is the number of tests, but I mean this is horrible. =
Is
> > there not a better way of doing this?
> >
Again, this is recommended by self-test.



> > >
> > >     test_seal_addseal();
> > >     test_seal_unmapped_start();
> > > @@ -2357,5 +2474,12 @@ int main(int argc, char **argv)
> > >     test_munmap_free_multiple_ranges(false);
> > >     test_munmap_free_multiple_ranges(true);
> > >
> > > +   test_seal_mmap_expand_seal_middle(false);
> > > +   test_seal_mmap_expand_seal_middle(true);
> > > +   test_seal_mmap_shrink_seal_middle(false);
> > > +   test_seal_mmap_shrink_seal_middle(true);
> > > +   test_seal_mmap_reuse_addr(false);
> > > +   test_seal_mmap_reuse_addr(true);
> > > +
> > >     ksft_finished();
> > >  }
> > > --
> > > 2.46.0.469.g59c65b2a67-goog
> > >

