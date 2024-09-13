Return-Path: <linux-kselftest+bounces-17965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FED978B8C
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 00:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901741C22ED2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 22:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AAE17C9AA;
	Fri, 13 Sep 2024 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Os1NeXtA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2584A5E
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267919; cv=none; b=j9XTOgh9PWS+MWu4z8PQlTSbvTUa4GW/pxiaChlzDoCu5oPo7M9m+welBNe61i+uCCvnxBXCgum15g1b1bRl4goHjND72n4BQopAxTsowsK2qZ+Hy48ZHVKxN9wp3zFg0Fntpf6KqAakbwknU4+Amxc0n6aXaEd9KUm91rteFbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267919; c=relaxed/simple;
	bh=32wRV+chem63ZgvAyl2vkt+/LacCHa2ndgG4z9Curxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVqn1sJBjYVPAkGa4jmPZrV7XV1f323jge5pCvC82HDZ1ziyf1D0HFmsjJhqF+yQPhryKhWbIN7eHnS2ddWED6AOTC7WccKNFTuY+zlrjlfFTnu1GG85Kn3SgJK68rJH13wbQ63Q91Bf6n29bJ0PGY6Tvm/apfwZcl3MPFzV8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Os1NeXtA; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-27800566bcfso48972fac.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726267914; x=1726872714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJZNhrSAVnVHz2s1xBFnG0yYqPXleuEG0evqkfL+2U0=;
        b=Os1NeXtA8dkf0sMWeDhVZL9YROpQqAfLIO9+cRE67dqxEW0UKZWqc33SE44aUaqA6H
         wuRGf6G+1QdTfIc76Cza4cjI+ICLDavzN2mqyxe/KrATArdD/y/D0q7M36L/FPAGo52G
         ap8yeEFpGTfR54AkMlmz4GlTPwkp5Z25NiS80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726267914; x=1726872714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJZNhrSAVnVHz2s1xBFnG0yYqPXleuEG0evqkfL+2U0=;
        b=u5PtVgyoWkCDmpz89I1c3FPaJY7yl1l5I2B18dxA8FH2VTWKBlQncj6o/IuJnT7UoG
         lTcbJ1chGRvfPwXsxei+ntJi2496fwzcby3ODBUyYZTMQjnXntJcJgdwsa4BSHLTBBCl
         G/Kpt18TrqhpU03YI59QtxwsfyFjWRXQp0trqpgPQyPIBeFes1DjQmBLmVEKa/PT2Isr
         VmMwBYTdsnWnXKBSmIHMT3kpEUW67XhQhirPcxvQrfxd3SwjkggwcJ6g2hplJ9Dm+6l8
         iW69Q+CeRdZ5DDkHTpqnCybMKFkMm4knTz5zMzecH5qbB2JG5SmvRRazKNyJbTvG5WJu
         R+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVRAsYJFfG63DRbc/NiMoACc3WPhCHIw/5wSu8UNNyqz4D9ASDZE/JbdhucT82lE2JPjf+e8cxIoahfb3f/Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01WBGSCDG+1bYt3EMOG7ZCW3DpQ3Rxhcqi/99tjigKsWWaZ6f
	RgBCZ8V1u2Xo5vsQ7MjjAL6oddYrkI51wItOogrM6Tnl1pYefyhRjDjMeaEiezQnSFm3TvuUvne
	9nOP/uGRJarIf//UfWmgXZKaE0OpKJ5bhI1mL
X-Google-Smtp-Source: AGHT+IHluHuurPNGAihiEVsdedjsSPeWnW8wr5gekTndeWINZ4rQhVLEGTRcq6jKtrpFYw2aKQodVf0IIf/ceEcBqLQ=
X-Received: by 2002:a05:6870:1688:b0:260:f1c4:2fdb with SMTP id
 586e51a60fabf-27c3f2d0148mr1462641fac.8.1726267914384; Fri, 13 Sep 2024
 15:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830180237.1220027-1-jeffxu@chromium.org> <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local> <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com> <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
In-Reply-To: <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 13 Sep 2024 15:50:00 -0700
Message-ID: <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pedro.falcato@gmail.com, willy@infradead.org, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Sat, Sep 7, 2024 at 12:28=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Aug 30, 2024 at 04:57:26PM GMT, Jeff Xu wrote:
> > On Fri, Aug 30, 2024 at 12:23=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Fri, Aug 30, 2024 at 07:43:12PM GMT, Lorenzo Stoakes wrote:
> > > > On Fri, Aug 30, 2024 at 06:02:36PM GMT, jeffxu@chromium.org wrote:
> > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > >
> > > > > Add sealing test to cover mmap for
> > > > > Expand/shrink across sealed vmas (MAP_FIXED)
> > > > > Reuse the same address in !MAP_FIXED case.
>
> Hi Jeff, I really want to find a constructive way forward, but you've
> basically ignored more or less everything I've said here.
>
> I could respond again to each of your points here, but - from my point of
> view - if your response to 'what is this even testing?' is to just repeat
> in effect the name of the test - we will be stuck in a loop, which will b=
e
> exited with a NACK. I don't want this.
>
> The majority of these tests, from a VMA/mmap point of view, appear to me =
to
> be essentially testing 'does basic mmap functionality work correctly',
> which isn't testing mseal.
>
> Look - I appreciate your commitment to testing (see my work on mm/vma.c -=
 I
> care passionately about testing) - but we must make sure we are actually
> testing what we mean to.
>
I'm also passionate about testing :-)

Maybe there is a mis-understanding ? I explained the purpose of this
patch set in various responses, maybe not directly to your email though.

Even though the number of lines is large in these patches, its main
intention is to test Pedro's in-place change (from can_modify_mm to
can_modify_vma). Before this patch,  the test had a common pattern:
setup memory layout, seal the memory, perform a few mm-api steps, verify
return code (not zero).  Because of the nature of out-of-loop,  it is
sufficient to just verify the error code in a few cases.

With Pedro's in-loop change, the sealing check happens later in the
stack, thus there are more things and scenarios to verify. And there were
feedback to me during in-loop change that selftest should be extensive
enough to discover all regressions.  Even though this viewpoint is subject
to debate. Since none would want to do it, I thought I would just do it.

So the Patch V3 1/5 is dedicated entirely to increasing the verification
for existing scenarios, this including checking return code code, vma-size,
etc after mm api return.

Patch V3 3/5 are for unmap(), during review of V2 of Pedro's in-loop
change, we discovered a bug in unmap(), and unmap() is not atomic.
This leads to 4/5(mmap), 5/5(mremap), which calls munmap().
In addition, I add scenarios to cover cross-multiple-vma cases.

The  high-level goal of mseal test are two folds:
1> make sure sealing is working correctly under different scenarios,
i.e. sealed mapping are not modified.
2> For unsealed memory, added mseal code  doesn't regress on regular mm API=
.

The goal 2 is as important as 1, that is why tests usually are done in
two phases, one with sealing, the other without.

> So I suggest as a constructive way forward - firstly, submit a regression
> test for the change Liam wrapped into his series regarding the -EPERM
> thing.
>
I could work on this (to split the patch further) if this helps
acceptance of the patch series.

However, since the merge window is closer, everyone is busy, and it
is not really urgent to get it merged.  the added tests  already
passed in the linux-next branch,  we could wait till after
merge-window to review/perfect those tests.

> This should go in uncontroversially, I will take the time to review it an=
d
> I don't see why that shouldn't be relatively straight forward. I will dro=
p
> the concerns about things like test macros etc. for that.
>
> Then after that, I suggest we have a discussion about - at a higher level=
 -
> what it is you want to test. And then between me, you, Liam and Pedro -
> ahead of time, list out the tests that we want, with all of us reaching
> consensus.
>
> I also suggest we figure out this FAIL_TEST_IF_FALSE() thing at this poin=
t
> too - I may be missing something, but I cannot for the life me understand
> why we have to assert negations only, and other self tests do not do this=
.
>
My most test-infra related comments comes from Muhammad Usama Anjum
(added into this email), e.g. assert is not recommended.[1] ,

[1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f336b6@collab=
ora.com/

> I have replied to a few sample points below.
>
> All of us simply want to help make sure mseal works as well as it can, th=
is
> is the only motivation at play here.
>
> Hope you have a great weekend!
>

Thanks
Hope a great weekend too !
-Jeff


-Jeff

> Cheers, Lorenzo
>
> > > >
> > > > This commit message is woefully small. I told you on v1 to improve =
the
> > > > commit messages. Linus has told you to do this before.
> > > >
> > > > Please actually respond to feedback. Thanks.
> > > >
> > > > >
> > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > > ---
> > > > >  tools/testing/selftests/mm/mseal_test.c | 126 ++++++++++++++++++=
+++++-
> > > > >  1 file changed, 125 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/test=
ing/selftests/mm/mseal_test.c
> > > > > index e855c8ccefc3..3516389034a7 100644
> > > > > --- a/tools/testing/selftests/mm/mseal_test.c
> > > > > +++ b/tools/testing/selftests/mm/mseal_test.c
> > > > > @@ -2222,6 +2222,123 @@ static void test_munmap_free_multiple_ran=
ges(bool seal)
> > > > >     REPORT_TEST_PASS();
> > > > >  }
> > > > >
> > > > > +static void test_seal_mmap_expand_seal_middle(bool seal)
> > > >
> > > > This test doesn't expand, doesn't do anything in the middle. It doe=
s mmap()
> > > > though and relates to mseal, so that's something... this is compelt=
ely
> > > > misnamed and needs to be rethought.
> > > >
> > >
> > > OK correction - it _seals_ in the middle. The remained of the critici=
sm remains,
> > > and this is rather confusing... and I continue to wonder what the pur=
pose of
> > > this is?
> > >
> > It expands the size (start from ptr).
> >
> > > > > +{
> > > > > +   void *ptr;
> > > > > +   unsigned long page_size =3D getpagesize();
> > > > > +   unsigned long size =3D 12 * page_size;
> > > > > +   int ret;
> > > > > +   void *ret2;
> > > > > +   int prot;
> > > > > +
> > > > > +   setup_single_address(size, &ptr);
> > > >
> > > > Please replace every single instance of this with an mmap(). There'=
s
> > > > literally no reason to abstract it. And munmap() what you map.
> > > >
> > No, we need to abstract it.  In addition to the mmap, it also
> > allocates an additional two blocks before and after the allocated
> > memory, to avoid auto-merging, so we can use get_vma_size.
>
> It doesn't?
>
> static void setup_single_address(int size, void **ptrOut)
> {
>         void *ptr;
>
>         ptr =3D mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, =
-1, 0);
>         *ptrOut =3D ptr;
> }
>
> >
> > > > > +   FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > >
> > > > Pretty sure Pedro pointed out you should be checking against MAP_FA=
ILED
> > > > here. I really don't understand why the rest of your test is full o=
f
> > > > mmap()'s but for some reason you choose to abstract this one call? =
What?
> > > >
> > > > > +   /* ummap last 4 pages. */
> > > > > +   ret =3D sys_munmap(ptr + 8 * page_size, 4 * page_size);
> > > >
> > > > sys_munmap()? What's wrong with munmap()?
> > > >
> > > > > +   FAIL_TEST_IF_FALSE(!ret);
> > > >
> > > > Why do we not have a FAIL_TEST_IF_TRUE()? This is crazy.
> > > >
> > > > Would be nice to have something human-readable like ASSERT_EQ() or
> > > > ASSERT_TRUE() or ASSERT_FALSE().
> > > >
> > ASSERT_EQ and ASSERT_TURE are not recommended by the self-test. The
> > FAIL_TEST_IF_FAIL wrap will take care of some of the admin tasks
> > related to self-test infra, such as count how many tests are failing.
>
> Can you please point me to where it says you should implement your own
> macro that only tests the negation of an expression?
>
> I have found other self tests that do.
>
> >
> > > > > +
> > > > > +   size =3D get_vma_size(ptr, &prot);
> > > > > +   FAIL_TEST_IF_FALSE(size =3D=3D 8 * page_size);
> > > > > +   FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > > > +
> > > > > +   if (seal) {
> > > > > +           ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size)=
;
> > > > > +           FAIL_TEST_IF_FALSE(!ret);
> > > > > +   }
> > > > > +
> > > > > +   /* use mmap to expand and overwrite (MAP_FIXED)  */
> > > >
> > > > You don't really need to say MAP_FIXED, it's below.
> > > >
> > Adding a comment here to help reviewers.
> >
> > > > > +   ret2 =3D mmap(ptr, 12 * page_size, PROT_READ,
> > > > > +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, =
0);
> > > >
> > > > Why read-only?
> > > >
> > > > You're not expanding you're overwriting. You're not doing anything =
in the
> > > > middle.
> > > >
> > The MAP_FIXED is overwriting.  It also expands the address range
> > (start from ptr) from 8 to 12 pages.
> >
> > > > I'm again confused about what you think you're testing here. I don'=
t think
> > > > we need an arbitrary MAP_FIXED mmap() at a size larger than the ove=
rwritten
> > > > VMA?
> > > >
> > > > You just need a single instance of a MAP_FIXED mmap() over a sealed=
 mmap()
> > > > if that's what you want.
> > > >
> > > > > +   if (seal) {
> > > > > +           FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > > > > +           FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > > > > +
> > > > > +           size =3D get_vma_size(ptr, &prot);
> > > > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > > > +
> > > > > +           size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > > > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > > > +   } else
> > > > > +           FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> > > >
> > > > Don't do dangling else's after a big block.
> > > >
> > patch passed the checkpatch.pl for style check.
> >
> > > > > +
> > > > > +   REPORT_TEST_PASS();
> > > > > +}
> > > > > +
> > > > > +static void test_seal_mmap_shrink_seal_middle(bool seal)
> > > >
> > > > What's going on in the 'middle'? This test doesn't shrink, it overw=
rites
> > > > the beginning of a sealed VMA?
> > >
> > > Correction - the middle is sealed. Other points remain.
> > >
> > The mmap attempts to shrink the address range from 12 pages to 8 pages.
> >
> > > > > +{
> > > > > +   void *ptr;
> > > > > +   unsigned long page_size =3D getpagesize();
> > > > > +   unsigned long size =3D 12 * page_size;
> > > > > +   int ret;
> > > > > +   void *ret2;
> > > > > +   int prot;
> > > > > +
> > > > > +   setup_single_address(size, &ptr);
> > > > > +   FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > > > +
> > > > > +   if (seal) {
> > > > > +           ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size)=
;
> > > > > +           FAIL_TEST_IF_FALSE(!ret);
> > > > > +   }
> > > > > +
> > > > > +   /* use mmap to shrink and overwrite (MAP_FIXED)  */
> > > >
> > > > What exactly are you shrinking? You're overwriting the start of the=
 vma?
> > > >
> > > > What is this testing that is different from the previous test? This=
 seems
> > > > useless honestly.
> > > >
> > Again, as above, one test is expanding, the other test is shrinking.
> > Please take a look at mmap parameters and steps before mmap call.
> >
> >
> > > > > +   ret2 =3D mmap(ptr, 7 * page_size, PROT_READ,
> > > > > +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, =
0);
> > > > > +   if (seal) {
> > > > > +           FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > > > > +           FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > > > > +
> > > > > +           size =3D get_vma_size(ptr, &prot);
> > > > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > >
> > > > What the hell is this comparison to magic numbers? This is
> > > > ridiculous. What's wrong with PROT_xxx??
> > > >
> > The PROT_xxx can't be used here.
> > get_vma_size doesn't return PROT_ type, i.e. the bit sequence is differ=
ent.
> >
> > > > > +
> > > > > +           size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > > > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > > > +
> > > > > +           size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > > > > +           FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > > > > +           FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > >
> > > > Err dude, you're doing this twice?
> > > >
> > The second get_vma_size should be (ptr + 8 * page_size)
> > I will update that.
> >
> > > > So what are we testing here exactly? That we got a VMA split? This =
is
> > > > err... why are we asserting this?
> > >
> > > I guess, that we can't overwrite a sealed bit of a VMA at the end. Bu=
t again
> > > this feels entirely redundant. For this kind of thing to fail would m=
ean the
> > > whole VMA machinery is broken.
> > >
> > The test is testing mmap(MAP_FIXED), since it can be used to overwrite
> > the sealed memory range (without sealing), then there is a variant of
> > expand/shrink.
> >
> >
> > > >
> > > > > +   } else
> > > > > +           FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> > > > > +
> > > > > +   REPORT_TEST_PASS();
> > > > > +}
> > > > > +
> > > > > +static void test_seal_mmap_reuse_addr(bool seal)
> > > >
> > > > This is wrong, you're not reusing anything. This test is useless.
> > > >
> > The ptr is reused as a hint.
> >
> > > > > +{
> > > > > +   void *ptr;
> > > > > +   unsigned long page_size =3D getpagesize();
> > > > > +   unsigned long size =3D page_size;
> > > > > +   int ret;
> > > > > +   void *ret2;
> > > > > +   int prot;
> > > > > +
> > > > > +   setup_single_address(size, &ptr);
> > > > > +   FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > > > +
> > > > > +   if (seal) {
> > > > > +           ret =3D sys_mseal(ptr, size);
> > > > > +           FAIL_TEST_IF_FALSE(!ret);
> > > >
> > > > We could avoid this horrid ret, ret2 naming if you just did:
> > > >
> > > >       FAIL_TEST_IF_FALSE(sys_mseal(ptr, size));
> > > >
> > > > > +   }
> > > > > +
> > > > > +   /* use mmap to change protection. */
> > > > > +   ret2 =3D mmap(ptr, size, PROT_NONE,
> > > > > +                   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > > >
> > > > How are you using mmap to change the protection when you're providi=
ng a
> > > > hint to the address to use? You're not changing any protection at a=
ll!
> > > >
> > It is necessary to add the this tests to make sure mseal is behave as
> > it should be, which is !MAP_FIXED case, new address will be allocated,
> > instead of fail of mmap()
> >
> >
> > > > You're allocating an entirely new VMA hinting that you want it near
> > > > ptr. Please read the man page for mmap():
> > > >
> > > >        If addr is NULL, then the kernel chooses the (page-aligned) =
address
> > > >        at which to create the mapping; this is the most portable me=
thod of
> > > >        creating a new mapping.  If addr is not NULL, then the kerne=
l takes
> > > >        it as a hint about where to place the mapping; on Linux, the=
 kernel
> > > >        will pick a nearby page boundary (but always above or equal =
to the
> > > >        value specified by /proc/sys/vm/mmap_min_addr) and attempt t=
o create
> > > >        the mapping there.  If another mapping already exists there,=
 the
> > > >        kernel picks a new address that may or may not depend on the=
 hint.
> > > >        The address of the new mapping is returned as the result of =
the
> > > >        call.
> > > >
> > > > > +
> > > > > +   /* MAP_FIXED is not used, expect new addr */
> > > > > +   FAIL_TEST_IF_FALSE(!(ret2 =3D=3D MAP_FAILED));
> > > >
> > > > This is beyond horrible. You really have to add more asserts.
> > > >
> > Again assert is not recommended by self_test
> >
> > > > Also you're expecting a new address here, so again, what on earth a=
re you
> > > > asserting? That we can mmap()?
> > > >
> > > > > +   FAIL_TEST_IF_FALSE(ret2 !=3D ptr);
> > > > > +
> > > > > +   size =3D get_vma_size(ptr, &prot);
> > > > > +   FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > > > > +   FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > > > +
> > > > > +   REPORT_TEST_PASS();
> > > > > +}
> > > > > +
> > > > >  int main(int argc, char **argv)
> > > > >  {
> > > > >     bool test_seal =3D seal_support();
> > > > > @@ -2243,7 +2360,7 @@ int main(int argc, char **argv)
> > > > >     if (!get_vma_size_supported())
> > > > >             ksft_exit_skip("get_vma_size not supported\n");
> > > > >
> > > > > -   ksft_set_plan(91);
> > > > > +   ksft_set_plan(97);
> > > >
> > > > I'm guessing this is the number of tests, but I mean this is horrib=
le. Is
> > > > there not a better way of doing this?
> > > >
> > Again, this is recommended by self-test.
> >
> >
> >
> > > > >
> > > > >     test_seal_addseal();
> > > > >     test_seal_unmapped_start();
> > > > > @@ -2357,5 +2474,12 @@ int main(int argc, char **argv)
> > > > >     test_munmap_free_multiple_ranges(false);
> > > > >     test_munmap_free_multiple_ranges(true);
> > > > >
> > > > > +   test_seal_mmap_expand_seal_middle(false);
> > > > > +   test_seal_mmap_expand_seal_middle(true);
> > > > > +   test_seal_mmap_shrink_seal_middle(false);
> > > > > +   test_seal_mmap_shrink_seal_middle(true);
> > > > > +   test_seal_mmap_reuse_addr(false);
> > > > > +   test_seal_mmap_reuse_addr(true);
> > > > > +
> > > > >     ksft_finished();
> > > > >  }
> > > > > --
> > > > > 2.46.0.469.g59c65b2a67-goog
> > > > >

