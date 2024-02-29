Return-Path: <linux-kselftest+bounces-5661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124B386D0D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 18:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B551C21A45
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F10470AD5;
	Thu, 29 Feb 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zLLSbHuO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB841C77
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228214; cv=none; b=VA1BWdFlKrTUx8LF8nm/wayQb4Ss5x0OiO4F4Ke81dQ3E6wb50OigCfax4LZu3kwFHGJiTHGgBQOBRIvQCmz2X1LZ5t51eL1gmC95hpAg7iGXRhmVG/DjWu1NXGtWtVgHSj8RDoGhKObPbqqMHwLgx/JPF4paKb7JWy13XJ7Lkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228214; c=relaxed/simple;
	bh=nrghaYzqra4sEySrSb2JY+wpeZ8+V9o/igjOah2T9/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHQHOXLJmlOP1uBVuGbAhwt9HwyyeX+M6wRIavOhZsZs+QGz0J3M/bPj0I0YV2TDQzyt9rWdlUEDhlA62h0pMCA3q+Gae5WcmoT5YIGCQQuV9e9giWf8KAGvx5zYQ89kHw0iioJFGSV3TR/BktEXreWzPNbjHwPOKtgO0WnyeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zLLSbHuO; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607cd210962so11666097b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709228211; x=1709833011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fe++mkvpeM1K+1Mu9ayeuTx0SYkTX6Iu/atEPcCgyA=;
        b=zLLSbHuOKLJKt4UhDFZrmy9Q7o0HvXd7lVZ9CnUP1X4sf1llUUWzJoybWkOOq+/S5K
         yNnTjFfqfrEdp2v/BN+VyXbJqhupJxeqqnRmlxIHP5tSir5SobCEAVnhfXEvehKe0L58
         ozq76z1qV9WjNDMCf5GrKl/UdF5qkCbWshUMrFjhd0Z3xqJ7Ff1qFkvdCi5GqAPCYfIP
         jvILiAUxHGU+rZtSU+kZhRzIIfR2clNtXIO+HV/EusHxjG4+B4NbH4qdUbXvLDI4tuAo
         p1oOpaLZcVMhDiNtmEYTdAfYIXCWLaB6tDhb9YnVBClwltOH0X6QyqUjeIXZtlmFnXHM
         bpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228211; x=1709833011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fe++mkvpeM1K+1Mu9ayeuTx0SYkTX6Iu/atEPcCgyA=;
        b=v3wtzf8c9QOXW/aZy981c+T/nMAWYGIqZybX9DF655We6t6S6n6GZc519IiiHI0+8G
         iSJ77/Vb/yOYW+W3Y9alyGXU6j88OPRi9OaeF/RSsyuKTx3LWFeBhRVifh6acLzZJkZF
         aH05h5C3i23Xy8JLwsq5WAPF8eXy6sB9/x3a1YCHxduOba7Hist1+cm/moQ6oJ/uSk7v
         pGmdmDrgQRD5jCVxlnNI4/VKF2QNqJVTBW3ISXiWlv0uKkyK1pXUh2Ntcnd9pe+g/boY
         YCNrlTh/jS5NKByCleeWpxBZvVzRO93oP+RICOHMSgsXLnippEYL4uxCbh7b3aeyrDwF
         ZIXw==
X-Forwarded-Encrypted: i=1; AJvYcCU+X3RKws+jdW989oz8w615nvHIvKcNMLC+9UiWtUstHZoU89HJ9LePgExivYlgzkFlddiWTXB/wJVrmN/hsI1ISkcWSfmUUnSk2TdriSIh
X-Gm-Message-State: AOJu0YxwU8On92PphQ7uqHL0R9vOk77zO5AxRfikO3EkRATjAz03gXZE
	bGULBwr/cWzngSnoH2Fm3kf0lhzdz1w4LvRHG+3QDqDTjRmwtG8yYbWv3Jm9CAESGz6haHdCk44
	9bNL4CQuhzC1AnXxKCLLjvCWvHZ6sN/5r809o
X-Google-Smtp-Source: AGHT+IHbF5HgonTS4R+NrJL8UyHTWAAojzXGNHLFsuq6mVp4nXOXOyTFNssqzrAZ8XdVm/5kPdtAJhp9aQYp5E6q5xk=
X-Received: by 2002:a25:ae59:0:b0:dcc:323e:e1a4 with SMTP id
 g25-20020a25ae59000000b00dcc323ee1a4mr3324276ybe.6.1709228211138; Thu, 29 Feb
 2024 09:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227121920.1905095-1-usama.anjum@collabora.com>
 <CABdmKX3_+G20TB5HJLLLMQQ1-i9g=RV1QU_A00Knd08pyiJWgw@mail.gmail.com>
 <a90a91bd-6182-412f-bfd9-fa3e3f9cc93e@collabora.com> <CABdmKX0d_Q2ishxS_bS7siEOmwDOobnTOyXK-QbdKsn_0Jv1VQ@mail.gmail.com>
 <202d7b66-edc4-4416-a32f-4d702742f44b@collabora.com>
In-Reply-To: <202d7b66-edc4-4416-a32f-4d702742f44b@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 29 Feb 2024 09:36:39 -0800
Message-ID: <CABdmKX1jruzSn0E883xfo_pYOimpTTC2HHw=3JG6NYHAhXZrsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selftests/dmabuf-heap: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:14=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 2/28/24 11:47 PM, T.J. Mercier wrote:
> > On Wed, Feb 28, 2024 at 3:46=E2=80=AFAM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> On 2/27/24 10:18 PM, T.J. Mercier wrote:
> >>> On Tue, Feb 27, 2024 at 4:21=E2=80=AFAM Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
...
> >>>> -static int test_alloc_zeroed(char *heap_name, size_t size)
> >>>> +static void test_alloc_zeroed(char *heap_name, size_t size)
> >>>>  {
> >>>>         int heap_fd =3D -1, dmabuf_fd[32];
> >>>>         int i, j, ret;
> >>>>         void *p =3D NULL;
> >>>>         char *c;
> >>>>
> >>>> -       printf("  Testing alloced %ldk buffers are zeroed:  ", size =
/ 1024);
> >>>> +       ksft_print_msg("Testing alloced %ldk buffers are zeroed:\n",=
 size / 1024);
> >>>>         heap_fd =3D dmabuf_heap_open(heap_name);
> >>>> -       if (heap_fd < 0)
> >>>> -               return -1;
> >>>>
> >>>>         /* Allocate and fill a bunch of buffers */
> >>>>         for (i =3D 0; i < 32; i++) {
> >>>>                 ret =3D dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_=
fd[i]);
> >>>> -               if (ret < 0) {
> >>>> -                       printf("FAIL (Allocation (%i) failed)\n", i)=
;
> >>>> -                       goto out;
> >>>> -               }
> >>>> +               if (ret)
> >>>> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) fa=
iled)\n", i);
> >>>> +
> >>>>                 /* mmap and fill with simple pattern */
> >>>>                 p =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_S=
HARED, dmabuf_fd[i], 0);
> >>>> -               if (p =3D=3D MAP_FAILED) {
> >>>> -                       printf("FAIL (mmap() failed!)\n");
> >>>> -                       ret =3D -1;
> >>>> -                       goto out;
> >>>> -               }
> >>>> +               if (p =3D=3D MAP_FAILED)
> >>>> +                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n"=
);
> >>>
> >>> So based on the previous ksft_exit_fail_msg calls I thought your
> >>> intention was to exit the program and never run subsequent tests when
> >>> errors occurred. That's what led to my initial comment about switchin=
g
> >>> to ksft_exit_fail_msg from ksft_print_msg here, and I expected to see
> >>> only ksft_exit_fail_msg for error cases afterwards. But you're still
> >>> mixing ksft_exit_fail_msg and (ksft_print_msg +
> >>> ksft_test_result{_pass,_fail,_skip}) so we've got a mix of behaviors
> >>> where some errors lead to complete program exits and different errors
> >>> lead to skipped/failed tests followed by further progress.
> >>>
> >>> It seems most useful and predictable to me to have all tests run even
> >>> after encountering an error for a single test, which we don't get whe=
n
> >>> ksft_exit_fail_msg is called from the individual tests. I was fine
> >>> with switching all error handling to ksft_exit_fail_msg to eliminate
> >>> cleanup code and reduce maintenance, but I think we should be
> >>> consistent with the behavior for dealing with errors which this
> >>> doesn't currently have. So let's either always call ksft_exit_fail_ms=
g
> >>> for errors, or never call it (my preference).
> >> The following rules are being used:
> >> - If a fetal error occurs where initial conditions to perform a test a=
ren't
> >> fulfilled, we exit the entire test by ksft_exit_fail_msg().
> >
> > But this doesn't exit just the test, it exits the entire program.
> >
> >> - If some test fails after fulfilling of initial conditions,
> >> ksft_print_msg() + ksft_test_result{_pass,_fail} are used to avoid put=
ting
> >> multiple ksft_test_result_fail() and later ksft_test_result_pass.
> >>
> >> ksft_exit_fail_msg() like behaviour was being followed before this pat=
ch.
> >> On non-zero return value, all of following test weren't being run.
> >> ksft_exit_fail_msg() cannot be used on every failure as it wouldn't ru=
n
> >> following test cases.
> >
> > Yeah this is what I'm saying. I'd prefer to always run remaining test
> > cases for the current heap, and all test cases for subsequent heaps
> > following an error so you can see all the passes/fails at once. (like
> > continue in the while loop in main instead of break w/the current
> > implementation) ksft_exit_fail_msg ends the whole program and that's
> > what was happening before, but that means the number of test results
> > that gets reported is inconsistent (unless everything always passes
> > for all heaps). Failures from one heap mask passes/fails in failures
> > from other heaps, and that's inconvenient for CI which expects to see
> > the same set of reported test results across runs, but will have
> > nothing to report for tests skipped due to premature program exit from
> > ksft_exit_fail_msg that could have been a single test failure. Like
> > you mentioned this would be a behavior change, but IDK if it's worth
> > the churn to exactly duplicate the existing behavior and then go back
> > to retouch many of the same spots in a later patch to get (what I
> > consider) better behavior from the program.
> >
> > The docs mention about calling ksft_exit_* only once after all tests
> > are finished:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/testing/selftests/kselftest.h?h=3Dv6.8-rc6#n29
> >
> > But actual usage seems to be split between ksft_exit_fail_msg for all
> > the things (e.g. fchmodat2_test.c), and ksft_exit_skip/fail for
> > prerequisites + ksft_test_result_skip/pass/fail for individual tests
> > followed by ksft_exit_fail_msg once at the end (e.g.
> > ksm_functional_tests.c).
> >
> > So what you have is fine based on the fact that nobody has fixed it
> > yet, but I think we could do better for not a lot of work here.
> I'll send a v3 by fixing only the other thing you caught.

Ok, but this is all that's needed:

@@ -152,8 +152,10 @@ static void test_alloc_and_import(char *heap_name)

        ksft_print_msg("Testing allocation and importing:\n");
        ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
-       if (ret)
-               ksft_exit_fail_msg("FAIL (Allocation Failed!)\n");
+       if (ret) {
+               ksft_test_result_fail("FAIL (Allocation Failed!)\n");
+               return;
+       }

        /* mmap and write a simple pattern */
        p =3D mmap(NULL,
@@ -162,8 +164,10 @@ static void test_alloc_and_import(char *heap_name)
                 MAP_SHARED,
                 dmabuf_fd,
                 0);
-       if (p =3D=3D MAP_FAILED)
-               ksft_exit_fail_msg("FAIL (mmap() failed)\n");
+       if (p =3D=3D MAP_FAILED) {
+               ksft_test_result_fail("FAIL (mmap() failed)\n");
+               return;
+       }

        dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
        memset(p, 1, ONE_MEG / 2);
@@ -217,13 +221,17 @@ static void test_alloc_zeroed(char *heap_name,
size_t size)
        /* Allocate and fill a bunch of buffers */
        for (i =3D 0; i < 32; i++) {
                ret =3D dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
-               if (ret)
-                       ksft_exit_fail_msg("FAIL (Allocation (%i)
failed)\n", i);
+               if (ret) {
+                       ksft_test_result_fail("FAIL (Allocation (%i)
failed)\n", i);
+                       return;
+               }

                /* mmap and fill with simple pattern */
                p =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
MAP_SHARED, dmabuf_fd[i], 0);
-               if (p =3D=3D MAP_FAILED)
-                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
+               if (p =3D=3D MAP_FAILED) {
+                       ksft_test_result_fail("FAIL (mmap() failed!)\n");
+                       return;
+               }

                dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
                memset(p, 0xff, size);
@@ -238,13 +246,17 @@ static void test_alloc_zeroed(char *heap_name,
size_t size)
        /* Allocate and validate all buffers are zeroed */
        for (i =3D 0; i < 32; i++) {
                ret =3D dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
-               if (ret < 0)
-                       ksft_exit_fail_msg("FAIL (Allocation (%i)
failed)\n", i);
+               if (ret < 0) {
+                       ksft_test_result_fail("FAIL (Allocation (%i)
failed)\n", i);
+                       return;
+               }

                /* mmap and validate everything is zero */
                p =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
MAP_SHARED, dmabuf_fd[i], 0);
-               if (p =3D=3D MAP_FAILED)
-                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
+               if (p =3D=3D MAP_FAILED) {
+                       ksft_test_result_fail("FAIL (mmap() failed!)\n");
+                       return;
+               }

Otherwise, on a Pixel 6 I get just:

TAP version 13
1..176
# Testing heap: aaudio_capture_heap
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# Testing allocation and importing:
Bail out! FAIL (Allocation Failed!)
# Planned tests !=3D run tests (176 !=3D 0)
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0

and none of the other 15 heaps are ever tested.

