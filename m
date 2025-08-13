Return-Path: <linux-kselftest+bounces-38827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9AEB241B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 08:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B537F3BEA3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 06:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768292D3A80;
	Wed, 13 Aug 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl3cCN3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F632D374A
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066994; cv=none; b=riNCbAgnsDcGLKIoabnE7Xd+rBa1yFNZLhYFjV5A9InUzKy+XkxB7JQ/pd3wgR4J2zGN/yWb7H3FcIJomXkWjBT6TIdHaHIIvCmu1/pdosAHTznWLLBP5Hp2BAqlwVA+O4SxPn7a7i43GCCyJ8rjrw19ImX854Ev0/ULIGZwFhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066994; c=relaxed/simple;
	bh=gHVSJzoq1b8jxS14gNfEVJcP5cUxP3DrXnDa5zTDYFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMM7f2kfo8TJGmwZibp/RrpMKedzBBFsmxqAQRD0RlR5aYIoxHaAJliuIvq7rBHFpDBD/myfZKquHpEUd2OAVDs1ahIucnqOmFm0vLeZhywaRksCe6QSWCs4gNZeJ9ecwgJcOPC8vp4vCr2NOFjnFbThsQIXN5IS7WmhPHR2jXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl3cCN3L; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afca41c7d7fso97832866b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755066990; x=1755671790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxlhII7DHQKn60cJIkcE4m0mCEjJ+9mfJXebrB1mqUA=;
        b=Cl3cCN3LUQqsEMiqa/y56v8P1H/rPXV8hwJF6IDjdVcCkJcxstjZhG9sCWPEy1nCLj
         hX5BSPlGp+6egdP6BvgFHsYIIvOpXKhVnEb2SgCleZMlltO4W6iP9CtYzy+kalks65h5
         KP3etMDXcst4WFOfAlnwJ9VbAPKU8W7NwnuKi8NlceoEU2aJltn9euZKmMqFDufDJnJ/
         zA+SO0s0JRMMpxcXPYl79YZN5PIk3J4cK5HMWC+hNLke9AgJCxxo8WcrUvWLXPtAfrUc
         eR0XoWpE6QBdb5V5FeFOQT4v8T6BpVGUWFjWnvK16TLKsCbZpfPOQ+pefuzdJiAv3sN8
         j1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755066990; x=1755671790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxlhII7DHQKn60cJIkcE4m0mCEjJ+9mfJXebrB1mqUA=;
        b=rZaJXNg6y759nI1EwMFwNbCriXYmM598XW95EO3pcff2FfP1n4MhJawy4VqUY7am3/
         g/L8zMaAi2H6bxTB0qaraUjWYttBlnhC2Nw2khSo2NWyMh3CY4DsiNifKjjUV4Gf3pM/
         vxeO2rLKkprTnxzStMCpXksHrrxihZHdtDxuHj9Vle8kTLZNNaB+nJaU9FCiQVxRjLO9
         W5fcc+QvHDRx4Q+3vLUxFApugSfFP8hwB7aRB1OSuZeUKf5UZ3470BuYuC9ojlktBfQz
         DEBZ9G0iNI2JxlfYx3atsMg1A0jUkm7ldb15Cg3q4IkaCQsw3dKLh72LU5BhmJt9FpNk
         EMOQ==
X-Gm-Message-State: AOJu0YyZbCx7GFVtpeW6O4tWFlpmUrx5rznF9r7aefpUhsJyjsFp/4Gz
	ZoZ7x9wByX2tEctSzPr66it49RG6J4oBho4KjYtcTSAZkyhSRcsqH7ELG4UBGOVwCnKajnrI9zF
	lfIrocvQ1pp/lCY9CGodJf0txMH1vuxeK3TkMkUc=
X-Gm-Gg: ASbGnctRTYrWsSqqsoKoLjLgpEMrn9/+zuzN1+4D2qZOpMerrOxaY7Lm0jhU8/N+QaK
	kisv7qcoAOC9UUiLVQ/l+QlxREaC3YIB1u75jmm7vZBOiwW85FW2o7txjnFurEi7HVUzE5rlDNg
	xx25YjHTtKYV+y9j1DmzhJCMaij7o1HlrAIGR/zY0aha9LREam65I86dlvB7q8uwU+YqknuhUBS
	inCdYo=
X-Google-Smtp-Source: AGHT+IHd+JKqTe6wQTP57evjen6vMGzLWINWMYBfSTx6Gzx8mFOweK+FIENemt3Fnp06/uI4qDONNfszYQbMd3eeKRg=
X-Received: by 2002:a17:906:f583:b0:af8:fded:6b7a with SMTP id
 a640c23a62f3a-afca8489667mr121949266b.17.1755066989633; Tue, 12 Aug 2025
 23:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813031647.96411-1-higuoxing@gmail.com>
In-Reply-To: <20250813031647.96411-1-higuoxing@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Aug 2025 08:36:18 +0200
X-Gm-Features: Ac12FXx-dP427diVJzgtKf1PPntx9LO-HYQA4iY3IVeDTSYrcVGk__hd-5UhmRk
Message-ID: <CAOQ4uxg0OvDW5yJiseEOHBB2sH6Nw1iWo+CvvZ0COTGo=oYmfg@mail.gmail.com>
Subject: Re: [PATCH] selftests/fs/mount-notify: Fix compilation failure.
To: Xing Guo <higuoxing@gmail.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org, jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:17=E2=80=AFAM Xing Guo <higuoxing@gmail.com> wrot=
e:
>
> Commit c6d9775c2066 ("selftests/fs/mount-notify: build with tools include
> dir") introduces the struct __kernel_fsid_t to decouple dependency with
> headers_install.  The commit forgets to define a macro for __kernel_fsid_=
t
> and it will cause type re-definition issue.
>
> Signed-off-by: Xing Guo <higuoxing@gmail.com>

Thank you for fixing this!

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../mount-notify/mount-notify_test.c           | 17 ++++++++---------
>  .../mount-notify/mount-notify_test_ns.c        | 18 ++++++++----------
>  2 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notif=
y_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_te=
st.c
> index 63ce708d93ed..e4b7c2b457ee 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.=
c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.=
c
> @@ -2,6 +2,13 @@
>  // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
>
>  #define _GNU_SOURCE
> +
> +// Needed for linux/fanotify.h
> +typedef struct {
> +       int     val[2];
> +} __kernel_fsid_t;
> +#define __kernel_fsid_t __kernel_fsid_t
> +
>  #include <fcntl.h>
>  #include <sched.h>
>  #include <stdio.h>
> @@ -10,20 +17,12 @@
>  #include <sys/mount.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
> +#include <sys/fanotify.h>
>
>  #include "../../kselftest_harness.h"
>  #include "../statmount/statmount.h"
>  #include "../utils.h"
>
> -// Needed for linux/fanotify.h
> -#ifndef __kernel_fsid_t
> -typedef struct {
> -       int     val[2];
> -} __kernel_fsid_t;
> -#endif
> -
> -#include <sys/fanotify.h>
> -
>  static const char root_mntpoint_templ[] =3D "/tmp/mount-notify_test_root=
.XXXXXX";
>
>  static const int mark_cmds[] =3D {
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notif=
y_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify=
_test_ns.c
> index 090a5ca65004..9f57ca46e3af 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> @@ -2,6 +2,13 @@
>  // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
>
>  #define _GNU_SOURCE
> +
> +// Needed for linux/fanotify.h
> +typedef struct {
> +       int     val[2];
> +} __kernel_fsid_t;
> +#define __kernel_fsid_t __kernel_fsid_t
> +
>  #include <fcntl.h>
>  #include <sched.h>
>  #include <stdio.h>
> @@ -10,21 +17,12 @@
>  #include <sys/mount.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
> +#include <sys/fanotify.h>
>
>  #include "../../kselftest_harness.h"
> -#include "../../pidfd/pidfd.h"
>  #include "../statmount/statmount.h"
>  #include "../utils.h"
>
> -// Needed for linux/fanotify.h
> -#ifndef __kernel_fsid_t
> -typedef struct {
> -       int     val[2];
> -} __kernel_fsid_t;
> -#endif
> -
> -#include <sys/fanotify.h>
> -
>  static const char root_mntpoint_templ[] =3D "/tmp/mount-notify_test_root=
.XXXXXX";
>
>  static const int mark_types[] =3D {
> --
> 2.50.1
>

