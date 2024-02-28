Return-Path: <linux-kselftest+bounces-5547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC3986B79D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 19:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175A11C23831
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 18:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D271EB9;
	Wed, 28 Feb 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y76otytu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193D40856
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146069; cv=none; b=dqUOZTvoaewyjtrcX0u5bpeQf2Bqh3VwA26qE1n+IcoiX/EjUo/dNWsA3d9HBjeO9DTornZzsDL9H4RUlG/m2S9Qe/Q74j6oXqoX4omD0OO+McqgV7UulUKSn5fYqK27AmlX4U+2zm0+WYnafQHYIw2oCOVDmTDI4rjILSloecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146069; c=relaxed/simple;
	bh=kACIPeXMFMWCU7GnG9NK/hCjVCgSg1xQcIQfziwKajU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlXRAPW/bcao40zEk46P2RsmBauqjcsTfFHndoVi8R0SGOkS1eSiFvFrFPzXGoza1F3Dj5UcefT+QJFlNXSydolaHa4qCIxiZLfLUg2hNDkRb34RIUv26GWQROzetRe7d9PLV/PXapft7oT0zs3hMsJ8l8Ghxej75h+CKqgibbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y76otytu; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so116199276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709146065; x=1709750865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcajkCRmfqbbpXAN8WM0FrK2YDJigmTDPm3x9VRs/Hc=;
        b=y76otytuOywer10kKYp1V7GXKpInG9JaGKunZU9eln5EUVE6LyeWTqTWCY2UYCpzaN
         b0urrpxF32QmUXgZPfUif5XnvmvABZ/0ffVIFkCZk45tFTxHh+hc6W0btPbScsh7Vbux
         uVe7pyVqqzazy5e603yb003Cl344ypaXAUYvWTwj2TZWRe461oIXdxmNE+ZxbBIp0Mgr
         3HGId2JOgLGTv2Bv9aMgLixbc4VwN2qGaDX22UijsYS/cou84DBr547zg8mMv5898xpl
         4S39/xCtdKaZ/MCb6o8K32V/8y5tHTAkcpUXj4QTlwZXNDVGAaJ9KLkfyuMqIYWqnPHq
         UCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146065; x=1709750865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcajkCRmfqbbpXAN8WM0FrK2YDJigmTDPm3x9VRs/Hc=;
        b=VglVWhr4q/VH/8EqxGdHNgW9/qTfaVJNat1FNFE0WIRSfXQnU652OKCr29gi4DiWq4
         /cdbUAPJPlSPNDDtxsICQz2YNuXAHvBxXXZEeAYoEjKQHbIs2bjelaHQPlU+5apd1sn7
         4Pk7x7WngX3LvzL9KfjBNPVdrZcKoIN3wcL+z+pgy+oWaIrumztQoxD2zmS1xXANUyPb
         XuB2Jl4E9pIaW/BKpTHx2585YDuqOt57xa5L51I8eSh9OaFNeQGoa8A4PMVjKZH3/V6X
         6C0MLXuVLEUY8XBHnm4PfLVeyor68sr13F9qfTaTASiS3Qy0A2MQxcpSXV9TBGFkixKq
         dS7w==
X-Forwarded-Encrypted: i=1; AJvYcCUmn/+APCYIgGsrAT9zmyLZj83nCfS9lxUy6MTkMDMmtJAIy3tQpk3hRby1adIlmDrTB0UEQ38M+YC1du666eY10nlaBprdk73puBQFyWLl
X-Gm-Message-State: AOJu0YzhUSZf5gHmmA/PMG6HfOJDRnozuGQAYF6P+h0PmJaajCw4NRHs
	wlbyrdfLKnHNZzmw4c+rGSrX0veIOuuZxbqqnq5BZ2IG0fixV/ddwfTrrceKskgsP1OqRxKEYxq
	VhKN0wAateqIQU0Ewchwm/xxDwpNqx7X+kWUP
X-Google-Smtp-Source: AGHT+IFa1mMMRNfwnKKfAg7bwEbnuCUpZjVrx/NezYsSo7m93fnwkDoPyZzLpLmz0EpNPsLTx4F6UHZXmovc6JFcfnQ=
X-Received: by 2002:a25:9a88:0:b0:dcb:e82c:f7f with SMTP id
 s8-20020a259a88000000b00dcbe82c0f7fmr62293ybo.12.1709146064916; Wed, 28 Feb
 2024 10:47:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227121920.1905095-1-usama.anjum@collabora.com>
 <CABdmKX3_+G20TB5HJLLLMQQ1-i9g=RV1QU_A00Knd08pyiJWgw@mail.gmail.com> <a90a91bd-6182-412f-bfd9-fa3e3f9cc93e@collabora.com>
In-Reply-To: <a90a91bd-6182-412f-bfd9-fa3e3f9cc93e@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Feb 2024 10:47:32 -0800
Message-ID: <CABdmKX0d_Q2ishxS_bS7siEOmwDOobnTOyXK-QbdKsn_0Jv1VQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selftests/dmabuf-heap: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:46=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 2/27/24 10:18 PM, T.J. Mercier wrote:
> > On Tue, Feb 27, 2024 at 4:21=E2=80=AFAM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> Conform the layout, informational and status messages to TAP. No
> >> functional change is intended other than the layout of output messages=
.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >> Changes since v1:
> >> - Update some more error handling code
> >> ---
> >>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 217 +++++++----------=
-
> >>  1 file changed, 81 insertions(+), 136 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tool=
s/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> >> index 890a8236a8ba7..41a8485cad5d0 100644
> >> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> >> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> >> @@ -15,6 +15,7 @@
> >>  #include <linux/dma-buf.h>
> >>  #include <linux/dma-heap.h>
> >>  #include <drm/drm.h>
> >> +#include "../kselftest.h"
> >>
> >>  #define DEVPATH "/dev/dma_heap"
> >>
> >> @@ -90,14 +91,13 @@ static int dmabuf_heap_open(char *name)
> >>         char buf[256];
> >>
> >>         ret =3D snprintf(buf, 256, "%s/%s", DEVPATH, name);
> >> -       if (ret < 0) {
> >> -               printf("snprintf failed!\n");
> >> -               return ret;
> >> -       }
> >> +       if (ret < 0)
> >> +               ksft_exit_fail_msg("snprintf failed!\n");
> >>
> >>         fd =3D open(buf, O_RDWR);
> >>         if (fd < 0)
> >> -               printf("open %s failed!\n", buf);
> >> +               ksft_exit_fail_msg("open %s failed: %s\n", buf, strerr=
or(errno));
> >> +
> >>         return fd;
> >>  }
> >>
> >> @@ -140,7 +140,7 @@ static int dmabuf_sync(int fd, int start_stop)
> >>
> >>  #define ONE_MEG (1024 * 1024)
> >>
> >> -static int test_alloc_and_import(char *heap_name)
> >> +static void test_alloc_and_import(char *heap_name)
> >>  {
> >>         int heap_fd =3D -1, dmabuf_fd =3D -1, importer_fd =3D -1;
> >>         uint32_t handle =3D 0;
> >> @@ -148,16 +148,12 @@ static int test_alloc_and_import(char *heap_name=
)
> >>         int ret;
> >>
> >>         heap_fd =3D dmabuf_heap_open(heap_name);
> >> -       if (heap_fd < 0)
> >> -               return -1;
> >>
> >> -       printf("  Testing allocation and importing:  ");
> >> +       ksft_print_msg("Testing allocation and importing:\n");
> >>         ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> >> -       if (ret) {
> >> -               printf("FAIL (Allocation Failed!)\n");
> >> -               ret =3D -1;
> >> -               goto out;
> >> -       }
> >> +       if (ret)
> >> +               ksft_exit_fail_msg("FAIL (Allocation Failed!)\n");
> >> +
> >>         /* mmap and write a simple pattern */
> >>         p =3D mmap(NULL,
> >>                  ONE_MEG,
> >> @@ -165,11 +161,8 @@ static int test_alloc_and_import(char *heap_name)
> >>                  MAP_SHARED,
> >>                  dmabuf_fd,
> >>                  0);
> >> -       if (p =3D=3D MAP_FAILED) {
> >> -               printf("FAIL (mmap() failed)\n");
> >> -               ret =3D -1;
> >> -               goto out;
> >> -       }
> >> +       if (p =3D=3D MAP_FAILED)
> >> +               ksft_exit_fail_msg("FAIL (mmap() failed)\n");
> >>
> >>         dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
> >>         memset(p, 1, ONE_MEG / 2);
> >> @@ -179,31 +172,28 @@ static int test_alloc_and_import(char *heap_name=
)
> >>         importer_fd =3D open_vgem();
> >>         if (importer_fd < 0) {
> >>                 ret =3D importer_fd;
> >> -               printf("(Could not open vgem - skipping):  ");
> >> +               ksft_test_result_skip("Could not open vgem\n");
> >>         } else {
> >>                 ret =3D import_vgem_fd(importer_fd, dmabuf_fd, &handle=
);
> >> -               if (ret < 0) {
> >> -                       printf("FAIL (Failed to import buffer)\n");
> >> -                       goto out;
> >> -               }
> >> +               ksft_test_result(ret >=3D 0, "Import buffer\n");
> >>         }
> >>
> >>         ret =3D dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
> >>         if (ret < 0) {
> >> -               printf("FAIL (DMA_BUF_SYNC_START failed!)\n");
> >> +               ksft_print_msg("FAIL (DMA_BUF_SYNC_START failed!)\n");
> >>                 goto out;
> >>         }
> >>
> >>         memset(p, 0xff, ONE_MEG);
> >>         ret =3D dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
> >>         if (ret < 0) {
> >> -               printf("FAIL (DMA_BUF_SYNC_END failed!)\n");
> >> +               ksft_print_msg("FAIL (DMA_BUF_SYNC_END failed!)\n");
> >>                 goto out;
> >>         }
> >>
> >>         close_handle(importer_fd, handle);
> >> -       ret =3D 0;
> >> -       printf(" OK\n");
> >> +       ksft_test_result_pass("%s\n", __func__);
> >> +       return;
> >>  out:
> >>         if (p)
> >>                 munmap(p, ONE_MEG);
> >> @@ -214,35 +204,30 @@ static int test_alloc_and_import(char *heap_name=
)
> >>         if (heap_fd >=3D 0)
> >>                 close(heap_fd);
> >>
> >> -       return ret;
> >> +       ksft_test_result_fail("%s\n", __func__);
> >>  }
> >>
> >> -static int test_alloc_zeroed(char *heap_name, size_t size)
> >> +static void test_alloc_zeroed(char *heap_name, size_t size)
> >>  {
> >>         int heap_fd =3D -1, dmabuf_fd[32];
> >>         int i, j, ret;
> >>         void *p =3D NULL;
> >>         char *c;
> >>
> >> -       printf("  Testing alloced %ldk buffers are zeroed:  ", size / =
1024);
> >> +       ksft_print_msg("Testing alloced %ldk buffers are zeroed:\n", s=
ize / 1024);
> >>         heap_fd =3D dmabuf_heap_open(heap_name);
> >> -       if (heap_fd < 0)
> >> -               return -1;
> >>
> >>         /* Allocate and fill a bunch of buffers */
> >>         for (i =3D 0; i < 32; i++) {
> >>                 ret =3D dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd=
[i]);
> >> -               if (ret < 0) {
> >> -                       printf("FAIL (Allocation (%i) failed)\n", i);
> >> -                       goto out;
> >> -               }
> >> +               if (ret)
> >> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) fail=
ed)\n", i);
> >> +
> >>                 /* mmap and fill with simple pattern */
> >>                 p =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHA=
RED, dmabuf_fd[i], 0);
> >> -               if (p =3D=3D MAP_FAILED) {
> >> -                       printf("FAIL (mmap() failed!)\n");
> >> -                       ret =3D -1;
> >> -                       goto out;
> >> -               }
> >> +               if (p =3D=3D MAP_FAILED)
> >> +                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
> >
> > So based on the previous ksft_exit_fail_msg calls I thought your
> > intention was to exit the program and never run subsequent tests when
> > errors occurred. That's what led to my initial comment about switching
> > to ksft_exit_fail_msg from ksft_print_msg here, and I expected to see
> > only ksft_exit_fail_msg for error cases afterwards. But you're still
> > mixing ksft_exit_fail_msg and (ksft_print_msg +
> > ksft_test_result{_pass,_fail,_skip}) so we've got a mix of behaviors
> > where some errors lead to complete program exits and different errors
> > lead to skipped/failed tests followed by further progress.
> >
> > It seems most useful and predictable to me to have all tests run even
> > after encountering an error for a single test, which we don't get when
> > ksft_exit_fail_msg is called from the individual tests. I was fine
> > with switching all error handling to ksft_exit_fail_msg to eliminate
> > cleanup code and reduce maintenance, but I think we should be
> > consistent with the behavior for dealing with errors which this
> > doesn't currently have. So let's either always call ksft_exit_fail_msg
> > for errors, or never call it (my preference).
> The following rules are being used:
> - If a fetal error occurs where initial conditions to perform a test aren=
't
> fulfilled, we exit the entire test by ksft_exit_fail_msg().

But this doesn't exit just the test, it exits the entire program.

> - If some test fails after fulfilling of initial conditions,
> ksft_print_msg() + ksft_test_result{_pass,_fail} are used to avoid puttin=
g
> multiple ksft_test_result_fail() and later ksft_test_result_pass.
>
> ksft_exit_fail_msg() like behaviour was being followed before this patch.
> On non-zero return value, all of following test weren't being run.
> ksft_exit_fail_msg() cannot be used on every failure as it wouldn't run
> following test cases.

Yeah this is what I'm saying. I'd prefer to always run remaining test
cases for the current heap, and all test cases for subsequent heaps
following an error so you can see all the passes/fails at once. (like
continue in the while loop in main instead of break w/the current
implementation) ksft_exit_fail_msg ends the whole program and that's
what was happening before, but that means the number of test results
that gets reported is inconsistent (unless everything always passes
for all heaps). Failures from one heap mask passes/fails in failures
from other heaps, and that's inconvenient for CI which expects to see
the same set of reported test results across runs, but will have
nothing to report for tests skipped due to premature program exit from
ksft_exit_fail_msg that could have been a single test failure. Like
you mentioned this would be a behavior change, but IDK if it's worth
the churn to exactly duplicate the existing behavior and then go back
to retouch many of the same spots in a later patch to get (what I
consider) better behavior from the program.

The docs mention about calling ksft_exit_* only once after all tests
are finished:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/testing/selftests/kselftest.h?h=3Dv6.8-rc6#n29

But actual usage seems to be split between ksft_exit_fail_msg for all
the things (e.g. fchmodat2_test.c), and ksft_exit_skip/fail for
prerequisites + ksft_test_result_skip/pass/fail for individual tests
followed by ksft_exit_fail_msg once at the end (e.g.
ksm_functional_tests.c).

So what you have is fine based on the fact that nobody has fixed it
yet, but I think we could do better for not a lot of work here.





> >
> > Slight tangent:
> > For this specific MAP_FAILED error, I don't actually think it should
> > be considered a test failure because the mmap operation is optional
> > for dma-buf: https://docs.kernel.org/driver-api/dma-buf.html#c.dma_buf_=
ops.
> > It would be pretty unusual to get a buffer like that, and skipping
> > instead of failing when that happens would differ from the original
> > behavior of the test so that could go in another patch, but I wanted
> > to point this out.
> I see. This can be done in another patch after this one.
>
> >
> >> +
> >>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
> >>                 memset(p, 0xff, size);
> >>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
> >> @@ -255,23 +240,19 @@ static int test_alloc_zeroed(char *heap_name, si=
ze_t size)
> >>         /* Allocate and validate all buffers are zeroed */
> >>         for (i =3D 0; i < 32; i++) {
> >>                 ret =3D dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd=
[i]);
> >> -               if (ret < 0) {
> >> -                       printf("FAIL (Allocation (%i) failed)\n", i);
> >> -                       goto out;
> >> -               }
> >> +               if (ret < 0)
> >> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) fail=
ed)\n", i);
> >>
> >>                 /* mmap and validate everything is zero */
> >>                 p =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHA=
RED, dmabuf_fd[i], 0);
> >> -               if (p =3D=3D MAP_FAILED) {
> >> -                       printf("FAIL (mmap() failed!)\n");
> >> -                       ret =3D -1;
> >> -                       goto out;
> >> -               }
> >> +               if (p =3D=3D MAP_FAILED)
> >> +                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
> >> +
> >>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
> >>                 c =3D (char *)p;
> >>                 for (j =3D 0; j < size; j++) {
> >>                         if (c[j] !=3D 0) {
> >> -                               printf("FAIL (Allocated buffer not zer=
oed @ %i)\n", j);
> >> +                               ksft_print_msg("FAIL (Allocated buffer=
 not zeroed @ %i)\n", j);
> >>                                 break;
> >>                         }
> >>                 }
> >> @@ -283,16 +264,8 @@ static int test_alloc_zeroed(char *heap_name, siz=
e_t size)
> >>                 close(dmabuf_fd[i]);
> >>
> >>         close(heap_fd);
> >> -       printf("OK\n");
> >> -       return 0;
> >> -
> >> -out:
> >> -       while (i > 0) {
> >> -               close(dmabuf_fd[i]);
> >> -               i--;
> >> -       }
> >> -       close(heap_fd);
> >> -       return ret;
> >> +       ksft_test_result_pass("%s\n", __func__);
> >
> > Don't we need ksft_test_result based on whether we ever see a non-zero
> > value so that we get ksft_cnt.ksft_fail++ for the failure case?
> > Otherwise we could have all non-zero values and the test would still
> > pass with a bunch of "FAIL (Allocated buffer not zeroed"
> > ksft_print_msg.
> Yeah, I'll fix it.
>
> >
> >> +       return;
> >>  }
> >>
> >>  /* Test the ioctl version compatibility w/ a smaller structure then e=
xpected */
> >> @@ -360,126 +333,98 @@ static int dmabuf_heap_alloc_newer(int fd, size=
_t len, unsigned int flags,
> >>         return ret;
> >>  }
> >>
> >> -static int test_alloc_compat(char *heap_name)
> >> +static void test_alloc_compat(char *heap_name)
> >>  {
> >> -       int heap_fd =3D -1, dmabuf_fd =3D -1;
> >> -       int ret;
> >> +       int ret, heap_fd =3D -1, dmabuf_fd =3D -1;
> >>
> >>         heap_fd =3D dmabuf_heap_open(heap_name);
> >> -       if (heap_fd < 0)
> >> -               return -1;
> >>
> >> -       printf("  Testing (theoretical)older alloc compat:  ");
> >> +       ksft_print_msg("Testing (theoretical) older alloc compat:\n");
> >>         ret =3D dmabuf_heap_alloc_older(heap_fd, ONE_MEG, 0, &dmabuf_f=
d);
> >> -       if (ret) {
> >> -               printf("FAIL (Older compat allocation failed!)\n");
> >> -               ret =3D -1;
> >> -               goto out;
> >> -       }
> >> -       close(dmabuf_fd);
> >> -       printf("OK\n");
> >> +       if (dmabuf_fd >=3D 0)
> >> +               close(dmabuf_fd);
> >> +       ksft_test_result(!ret, "dmabuf_heap_alloc_older\n");
> >>
> >> -       printf("  Testing (theoretical)newer alloc compat:  ");
> >> +       ksft_print_msg("Testing (theoretical) newer alloc compat:\n");
> >>         ret =3D dmabuf_heap_alloc_newer(heap_fd, ONE_MEG, 0, &dmabuf_f=
d);
> >> -       if (ret) {
> >> -               printf("FAIL (Newer compat allocation failed!)\n");
> >> -               ret =3D -1;
> >> -               goto out;
> >> -       }
> >> -       printf("OK\n");
> >> -out:
> >>         if (dmabuf_fd >=3D 0)
> >>                 close(dmabuf_fd);
> >> -       if (heap_fd >=3D 0)
> >> -               close(heap_fd);
> >> +       ksft_test_result(!ret, "dmabuf_heap_alloc_newer\n");
> >>
> >> -       return ret;
> >> +       close(heap_fd);
> >>  }
> >>
> >> -static int test_alloc_errors(char *heap_name)
> >> +static void test_alloc_errors(char *heap_name)
> >>  {
> >>         int heap_fd =3D -1, dmabuf_fd =3D -1;
> >>         int ret;
> >>
> >>         heap_fd =3D dmabuf_heap_open(heap_name);
> >> -       if (heap_fd < 0)
> >> -               return -1;
> >>
> >> -       printf("  Testing expected error cases:  ");
> >> +       ksft_print_msg("Testing expected error cases:\n");
> >>         ret =3D dmabuf_heap_alloc(0, ONE_MEG, 0x111111, &dmabuf_fd);
> >> -       if (!ret) {
> >> -               printf("FAIL (Did not see expected error (invalid fd)!=
)\n");
> >> -               ret =3D -1;
> >> -               goto out;
> >> -       }
> >> +       ksft_test_result(ret, "Error expected on invalid fd\n");
> >>
> >>         ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0x111111, &dmabuf_=
fd);
> >> -       if (!ret) {
> >> -               printf("FAIL (Did not see expected error (invalid heap=
 flags)!)\n");
> >> -               ret =3D -1;
> >> -               goto out;
> >> -       }
> >> +       ksft_test_result(ret, "Error expected on invalid heap flags\n"=
);
> >>
> >>         ret =3D dmabuf_heap_alloc_fdflags(heap_fd, ONE_MEG,
> >>                                         ~(O_RDWR | O_CLOEXEC), 0, &dma=
buf_fd);
> >> -       if (!ret) {
> >> -               printf("FAIL (Did not see expected error (invalid fd f=
lags)!)\n");
> >> -               ret =3D -1;
> >> -               goto out;
> >> -       }
> >> +       ksft_test_result(ret, "Error expected on invalid heap flags\n"=
);
> >>
> >> -       printf("OK\n");
> >> -       ret =3D 0;
> >> -out:
> >>         if (dmabuf_fd >=3D 0)
> >>                 close(dmabuf_fd);
> >>         if (heap_fd >=3D 0)
> >>                 close(heap_fd);
> >> +}
> >>
> >> -       return ret;
> >> +static int numer_of_heaps(void)
> >> +{
> >> +       DIR *d =3D opendir(DEVPATH);
> >> +       struct dirent *dir;
> >> +       int heaps =3D 0;
> >> +
> >> +       while ((dir =3D readdir(d))) {
> >> +               if (!strncmp(dir->d_name, ".", 2))
> >> +                       continue;
> >> +               if (!strncmp(dir->d_name, "..", 3))
> >> +                       continue;
> >> +               heaps++;
> >> +       }
> >> +
> >> +       return heaps;
> >>  }
> >>
> >>  int main(void)
> >>  {
> >> -       DIR *d;
> >>         struct dirent *dir;
> >> -       int ret =3D -1;
> >> +       DIR *d;
> >> +
> >> +       ksft_print_header();
> >>
> >>         d =3D opendir(DEVPATH);
> >>         if (!d) {
> >> -               printf("No %s directory?\n", DEVPATH);
> >> -               return -1;
> >> +               ksft_print_msg("No %s directory?\n", DEVPATH);
> >> +               return KSFT_SKIP;
> >>         }
> >>
> >> -       while ((dir =3D readdir(d)) !=3D NULL) {
> >> +       ksft_set_plan(9 * numer_of_heaps());
> >> +
> >> +       while ((dir =3D readdir(d))) {
> >>                 if (!strncmp(dir->d_name, ".", 2))
> >>                         continue;
> >>                 if (!strncmp(dir->d_name, "..", 3))
> >>                         continue;
> >>
> >> -               printf("Testing heap: %s\n", dir->d_name);
> >> -               printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n"=
);
> >> -               ret =3D test_alloc_and_import(dir->d_name);
> >> -               if (ret)
> >> -                       break;
> >> -
> >> -               ret =3D test_alloc_zeroed(dir->d_name, 4 * 1024);
> >> -               if (ret)
> >> -                       break;
> >> -
> >> -               ret =3D test_alloc_zeroed(dir->d_name, ONE_MEG);
> >> -               if (ret)
> >> -                       break;
> >> -
> >> -               ret =3D test_alloc_compat(dir->d_name);
> >> -               if (ret)
> >> -                       break;
> >> -
> >> -               ret =3D test_alloc_errors(dir->d_name);
> >> -               if (ret)
> >> -                       break;
> >> +               ksft_print_msg("Testing heap: %s\n", dir->d_name);
> >> +               ksft_print_msg("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D\n");
> >> +               test_alloc_and_import(dir->d_name);
> >> +               test_alloc_zeroed(dir->d_name, 4 * 1024);
> >> +               test_alloc_zeroed(dir->d_name, ONE_MEG);
> >> +               test_alloc_compat(dir->d_name);
> >> +               test_alloc_errors(dir->d_name);
> >>         }
> >>         closedir(d);
> >>
> >> -       return ret;
> >> +       ksft_finished();
> >>  }
> >> --
> >> 2.42.0
> >>
> >>
> >
>
> --
> BR,
> Muhammad Usama Anjum

