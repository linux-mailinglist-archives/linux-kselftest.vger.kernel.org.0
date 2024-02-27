Return-Path: <linux-kselftest+bounces-5463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B9868670
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 02:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED28B24766
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 01:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E33EAD7;
	Tue, 27 Feb 2024 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqrPESQa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3704C61
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998785; cv=none; b=Y/uJCP3s4aFW7OHRxN3DMV14qjgiXPOBWhWBLzQpkOb061tzfBFIOwF9+okhY/h0uJFbjgCJiFjx/MNg+DrVw1xXVeWHJQ6Xb3fgwWG/pi43DH1QHE7GItjNOfrb7h7MrgJhmSjBi0l/zN46fpqkLsYI+YUgREXoX0jRhi/NMro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998785; c=relaxed/simple;
	bh=luGIBaugrTyPpoxK0juMBLUHrmUxq4kEDHzWt5a+NhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS+pXav4mpWt/m88EYwEWABDhW7Gk30b2ptoZqsyTSAkZPOQOIKPwWVtibbOIUgEpP56KtfCC+E5iW7wa1c4j8+54eSU0V/wtewXPQGOUz/f0oi3XTMLX/bI/2GpIVGjMx4mWh5+HjMAWVNT+gy1z3VLRgELZ2ebc3t6CJ3jCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TqrPESQa; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607c5679842so37979747b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 17:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708998781; x=1709603581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWGWJEv4BrNVulJ7dXLkoApOICGicAN+3bV0I2F6xKk=;
        b=TqrPESQaWfH9Vh1SEyA0VWQA6Xwn8aMQugrHR8L7Sh9X9kiwyzQbqzY7dPENPmHaYP
         fU4CmwT/2R8cjSy645yv2qZGGyTqnm0k9Y14d+h+deAryNPzDZbO1GQOFkiDQm1fvyAQ
         olTvtEyF19jTZ0emJK0SO4xSLoZtwRUQBMDxoDN6FBmz5xYtzuuF9gI0cBprT/CODsry
         ul6RHIQU0Vo1w244Cs5Cx3XVBGITFLOO2RW9FrKozAADFoiD4uuP7GVxDTuNz0yO0SD1
         s1ce3bAtVfJJkqorYKmi7H9fRqnwkW0nr4K5KGhxY3jLrka/126zd9GbgK6cCDZF9CHX
         eMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998781; x=1709603581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWGWJEv4BrNVulJ7dXLkoApOICGicAN+3bV0I2F6xKk=;
        b=jyeSZm5V5aRT29lRlweTQlQDRdgxwCR2mo13NgdmKv/wJDwMpzipYQP026rZu6zlcj
         g8E5cFX5Sj9xIlvLOjm4lG6b6lGMrWRuT8Js9kPHD2MCo2IXaQaWHN8lVvOY8aG9eHQn
         p/UmJXGRz6H9mXiB2tqNhvnKAXIm9oy9vGbLHyplZ+0B6s25peJoaVcH6VJgjpcujBQ4
         zZuOxUo2B5XWHKkt39k2bZyBf+3WWqd62Fr+nvoHOQDpnPT3p8XMDKFDPAK8yxReMfl5
         ZayyaWnhHwWNVXO5yiN5gd4HiOTNy/VBFibdLm7YneMcHuJkD8B+07rDmqEZl5JXPNAH
         oICw==
X-Forwarded-Encrypted: i=1; AJvYcCXHANc+/QixAkfY/ls9VoSrftsBlAEahazLxxQh49uQ/jYibyKhA3c11167Gl7Nr/keUEwY4e+poSZeZ5+24GXgpEFE5cJIEH2U9tblri42
X-Gm-Message-State: AOJu0YyeEWGYPCxhNt66u0TsdzWIAGwPgC8oYf2HA7SrNDBMQe+cSr60
	H32ypM9tkO9XSw7bfrM+9HuK1vb2Kth4LJEm2dji9eAfCUUThb8isWTce3VhMO/0UhFYg7IQhyu
	qofLB9VGTJzv8d9hsr5yXP0EejAlXasUjIhYp
X-Google-Smtp-Source: AGHT+IGa+r1vcRT9tTC205JOWJlfZxDakAIa1nGX1ahlDkPXPxO0K/HaI0G6Lm00spuPNhQllNa2T+gF9+8CO3qt5Eg=
X-Received: by 2002:a81:4f48:0:b0:607:8edd:b5f7 with SMTP id
 d69-20020a814f48000000b006078eddb5f7mr918240ywb.49.1708998781347; Mon, 26 Feb
 2024 17:53:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226080003.4094089-1-usama.anjum@collabora.com>
In-Reply-To: <20240226080003.4094089-1-usama.anjum@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 26 Feb 2024 17:52:49 -0800
Message-ID: <CABdmKX2YSrvHx3U-q1irvmEf=dDtqTtB38dERKx+4muu77zbfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/dmabuf-heap: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 11:59=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 194 +++++++-----------
>  1 file changed, 77 insertions(+), 117 deletions(-)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 890a8236a8ba7..6e538e346cb8f 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -15,6 +15,7 @@
>  #include <linux/dma-buf.h>
>  #include <linux/dma-heap.h>
>  #include <drm/drm.h>
> +#include "../kselftest.h"
>
>  #define DEVPATH "/dev/dma_heap"
>
> @@ -90,14 +91,13 @@ static int dmabuf_heap_open(char *name)
>         char buf[256];
>
>         ret =3D snprintf(buf, 256, "%s/%s", DEVPATH, name);
> -       if (ret < 0) {
> -               printf("snprintf failed!\n");
> -               return ret;
> -       }
> +       if (ret < 0)
> +               ksft_exit_fail_msg("snprintf failed!\n");
>
>         fd =3D open(buf, O_RDWR);
>         if (fd < 0)
> -               printf("open %s failed!\n", buf);
> +               ksft_exit_fail_msg("open %s failed: %s\n", buf, strerror(=
errno));
> +
>         return fd;
>  }
>
> @@ -140,7 +140,7 @@ static int dmabuf_sync(int fd, int start_stop)
>
>  #define ONE_MEG (1024 * 1024)
>
> -static int test_alloc_and_import(char *heap_name)
> +static void test_alloc_and_import(char *heap_name)
>  {
>         int heap_fd =3D -1, dmabuf_fd =3D -1, importer_fd =3D -1;
>         uint32_t handle =3D 0;
> @@ -148,16 +148,12 @@ static int test_alloc_and_import(char *heap_name)
>         int ret;
>
>         heap_fd =3D dmabuf_heap_open(heap_name);
> -       if (heap_fd < 0)
> -               return -1;
>
> -       printf("  Testing allocation and importing:  ");
> +       ksft_print_msg("Testing allocation and importing:\n");
>         ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> -       if (ret) {
> -               printf("FAIL (Allocation Failed!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> +       if (ret)
> +               ksft_exit_fail_msg("FAIL (Allocation Failed!)\n");
> +
>         /* mmap and write a simple pattern */
>         p =3D mmap(NULL,
>                  ONE_MEG,
> @@ -166,7 +162,7 @@ static int test_alloc_and_import(char *heap_name)
>                  dmabuf_fd,
>                  0);
>         if (p =3D=3D MAP_FAILED) {
> -               printf("FAIL (mmap() failed)\n");
> +               ksft_print_msg("FAIL (mmap() failed)\n");
>                 ret =3D -1;
>                 goto out;
>         }

I think you should just ksft_exit_fail_msg these too and get rid of
out / not bother with manual cleanup if we're going to exit anyway.

> @@ -179,31 +175,28 @@ static int test_alloc_and_import(char *heap_name)
>         importer_fd =3D open_vgem();
>         if (importer_fd < 0) {
>                 ret =3D importer_fd;
> -               printf("(Could not open vgem - skipping):  ");
> +               ksft_test_result_skip("Could not open vgem\n");
>         } else {
>                 ret =3D import_vgem_fd(importer_fd, dmabuf_fd, &handle);
> -               if (ret < 0) {
> -                       printf("FAIL (Failed to import buffer)\n");
> -                       goto out;
> -               }
> +               ksft_test_result(ret >=3D 0, "Import buffer\n");
>         }
>
>         ret =3D dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
>         if (ret < 0) {
> -               printf("FAIL (DMA_BUF_SYNC_START failed!)\n");
> +               ksft_print_msg("FAIL (DMA_BUF_SYNC_START failed!)\n");
>                 goto out;
>         }
>
>         memset(p, 0xff, ONE_MEG);
>         ret =3D dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
>         if (ret < 0) {
> -               printf("FAIL (DMA_BUF_SYNC_END failed!)\n");
> +               ksft_print_msg("FAIL (DMA_BUF_SYNC_END failed!)\n");
>                 goto out;
>         }
>
>         close_handle(importer_fd, handle);
> -       ret =3D 0;
> -       printf(" OK\n");
> +       ksft_test_result_pass("%s\n", __func__);
> +       return;
>  out:
>         if (p)
>                 munmap(p, ONE_MEG);
> @@ -214,32 +207,29 @@ static int test_alloc_and_import(char *heap_name)
>         if (heap_fd >=3D 0)
>                 close(heap_fd);
>
> -       return ret;
> +       ksft_test_result_fail("%s\n", __func__);
>  }
>
> -static int test_alloc_zeroed(char *heap_name, size_t size)
> +static void test_alloc_zeroed(char *heap_name, size_t size)
>  {
>         int heap_fd =3D -1, dmabuf_fd[32];
>         int i, j, ret;
>         void *p =3D NULL;
>         char *c;
>
> -       printf("  Testing alloced %ldk buffers are zeroed:  ", size / 102=
4);
> +       ksft_print_msg("Testing alloced %ldk buffers are zeroed:\n", size=
 / 1024);
>         heap_fd =3D dmabuf_heap_open(heap_name);
> -       if (heap_fd < 0)
> -               return -1;
>
>         /* Allocate and fill a bunch of buffers */
>         for (i =3D 0; i < 32; i++) {
>                 ret =3D dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]=
);
> -               if (ret < 0) {
> -                       printf("FAIL (Allocation (%i) failed)\n", i);
> -                       goto out;
> -               }
> +               if (ret)
> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) failed)=
\n", i);
> +
>                 /* mmap and fill with simple pattern */
>                 p =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED=
, dmabuf_fd[i], 0);
>                 if (p =3D=3D MAP_FAILED) {
> -                       printf("FAIL (mmap() failed!)\n");
> +                       ksft_print_msg("FAIL (mmap() failed!)\n");
>                         ret =3D -1;
>                         goto out;
>                 }
> @@ -255,15 +245,13 @@ static int test_alloc_zeroed(char *heap_name, size_=
t size)
>         /* Allocate and validate all buffers are zeroed */
>         for (i =3D 0; i < 32; i++) {
>                 ret =3D dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]=
);
> -               if (ret < 0) {
> -                       printf("FAIL (Allocation (%i) failed)\n", i);
> -                       goto out;
> -               }
> +               if (ret < 0)
> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) failed)=
\n", i);
>
>                 /* mmap and validate everything is zero */
>                 p =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED=
, dmabuf_fd[i], 0);
>                 if (p =3D=3D MAP_FAILED) {
> -                       printf("FAIL (mmap() failed!)\n");
> +                       ksft_print_msg("FAIL (mmap() failed!)\n");
>                         ret =3D -1;
>                         goto out;
>                 }
> @@ -271,7 +259,7 @@ static int test_alloc_zeroed(char *heap_name, size_t =
size)
>                 c =3D (char *)p;
>                 for (j =3D 0; j < size; j++) {
>                         if (c[j] !=3D 0) {
> -                               printf("FAIL (Allocated buffer not zeroed=
 @ %i)\n", j);
> +                               ksft_print_msg("FAIL (Allocated buffer no=
t zeroed @ %i)\n", j);
>                                 break;
>                         }
>                 }
> @@ -283,8 +271,8 @@ static int test_alloc_zeroed(char *heap_name, size_t =
size)
>                 close(dmabuf_fd[i]);
>
>         close(heap_fd);
> -       printf("OK\n");
> -       return 0;
> +       ksft_test_result_pass("%s\n", __func__);
> +       return;
>
>  out:
>         while (i > 0) {
> @@ -292,7 +280,7 @@ static int test_alloc_zeroed(char *heap_name, size_t =
size)
>                 i--;
>         }
>         close(heap_fd);
> -       return ret;
> +       ksft_test_result_fail("%s\n", __func__);
>  }
>
>  /* Test the ioctl version compatibility w/ a smaller structure then expe=
cted */
> @@ -360,126 +348,98 @@ static int dmabuf_heap_alloc_newer(int fd, size_t =
len, unsigned int flags,
>         return ret;
>  }
>
> -static int test_alloc_compat(char *heap_name)
> +static void test_alloc_compat(char *heap_name)
>  {
> -       int heap_fd =3D -1, dmabuf_fd =3D -1;
> -       int ret;
> +       int ret, heap_fd =3D -1, dmabuf_fd =3D -1;
>
>         heap_fd =3D dmabuf_heap_open(heap_name);
> -       if (heap_fd < 0)
> -               return -1;
>
> -       printf("  Testing (theoretical)older alloc compat:  ");
> +       ksft_print_msg("Testing (theoretical)older alloc compat:\n");
>         ret =3D dmabuf_heap_alloc_older(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> -       if (ret) {
> -               printf("FAIL (Older compat allocation failed!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> -       close(dmabuf_fd);
> -       printf("OK\n");
> +       if (dmabuf_fd >=3D 0)
> +               close(dmabuf_fd);
> +       ksft_test_result(!ret, "dmabuf_heap_alloc_older\n");
>
> -       printf("  Testing (theoretical)newer alloc compat:  ");
> +       ksft_print_msg("Testing (theoretical)newer alloc compat:\n");
>         ret =3D dmabuf_heap_alloc_newer(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> -       if (ret) {
> -               printf("FAIL (Newer compat allocation failed!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> -       printf("OK\n");
> -out:
>         if (dmabuf_fd >=3D 0)
>                 close(dmabuf_fd);
> -       if (heap_fd >=3D 0)
> -               close(heap_fd);
> +       ksft_test_result(!ret, "dmabuf_heap_alloc_newer\n");
>
> -       return ret;
> +       close(heap_fd);
>  }
>
> -static int test_alloc_errors(char *heap_name)
> +static void test_alloc_errors(char *heap_name)
>  {
>         int heap_fd =3D -1, dmabuf_fd =3D -1;
>         int ret;
>
>         heap_fd =3D dmabuf_heap_open(heap_name);
> -       if (heap_fd < 0)
> -               return -1;
>
> -       printf("  Testing expected error cases:  ");
> +       ksft_print_msg("Testing expected error cases:\n");
>         ret =3D dmabuf_heap_alloc(0, ONE_MEG, 0x111111, &dmabuf_fd);
> -       if (!ret) {
> -               printf("FAIL (Did not see expected error (invalid fd)!)\n=
");
> -               ret =3D -1;
> -               goto out;
> -       }
> +       ksft_test_result(ret, "Error expected on invalid fd\n");
>
>         ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0x111111, &dmabuf_fd)=
;
> -       if (!ret) {
> -               printf("FAIL (Did not see expected error (invalid heap fl=
ags)!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> +       ksft_test_result(ret, "Error expected on invalid heap flags\n");
>
>         ret =3D dmabuf_heap_alloc_fdflags(heap_fd, ONE_MEG,
>                                         ~(O_RDWR | O_CLOEXEC), 0, &dmabuf=
_fd);
> -       if (!ret) {
> -               printf("FAIL (Did not see expected error (invalid fd flag=
s)!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> +       ksft_test_result(ret, "Error expected on invalid heap flags\n");
>
> -       printf("OK\n");
> -       ret =3D 0;
> -out:
>         if (dmabuf_fd >=3D 0)
>                 close(dmabuf_fd);
>         if (heap_fd >=3D 0)
>                 close(heap_fd);
> +}
>
> -       return ret;
> +static int numer_of_heaps(void)
> +{
> +       DIR *d =3D opendir(DEVPATH);
> +       struct dirent *dir;
> +       int heaps =3D 0;
> +
> +       while ((dir =3D readdir(d))) {
> +               if (!strncmp(dir->d_name, ".", 2))
> +                       continue;
> +               if (!strncmp(dir->d_name, "..", 3))
> +                       continue;
> +               heaps++;
> +       }
> +
> +       return heaps;
>  }
>
>  int main(void)
>  {
> -       DIR *d;
>         struct dirent *dir;
> -       int ret =3D -1;
> +       DIR *d;
> +
> +       ksft_print_header();
>
>         d =3D opendir(DEVPATH);
>         if (!d) {
> -               printf("No %s directory?\n", DEVPATH);
> -               return -1;
> +               ksft_print_msg("No %s directory?\n", DEVPATH);
> +               return KSFT_SKIP;
>         }
>
> -       while ((dir =3D readdir(d)) !=3D NULL) {
> +       ksft_set_plan(9 * numer_of_heaps());
> +
> +       while ((dir =3D readdir(d))) {
>                 if (!strncmp(dir->d_name, ".", 2))
>                         continue;
>                 if (!strncmp(dir->d_name, "..", 3))
>                         continue;
>
> -               printf("Testing heap: %s\n", dir->d_name);
> -               printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> -               ret =3D test_alloc_and_import(dir->d_name);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_zeroed(dir->d_name, 4 * 1024);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_zeroed(dir->d_name, ONE_MEG);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_compat(dir->d_name);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_errors(dir->d_name);
> -               if (ret)
> -                       break;
> +               ksft_print_msg("Testing heap: %s\n", dir->d_name);
> +               ksft_print_msg("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D\n");
> +               test_alloc_and_import(dir->d_name);
> +               test_alloc_zeroed(dir->d_name, 4 * 1024);
> +               test_alloc_zeroed(dir->d_name, ONE_MEG);
> +               test_alloc_compat(dir->d_name);
> +               test_alloc_errors(dir->d_name);
>         }
>         closedir(d);
>
> -       return ret;
> +       ksft_finished();
>  }
> --
> 2.42.0
>
>

