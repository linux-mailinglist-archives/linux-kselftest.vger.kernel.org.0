Return-Path: <linux-kselftest+bounces-26597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BBA35151
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 23:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FCD7A4A56
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1623A9BB;
	Thu, 13 Feb 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uu5fYrlt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2C28A2BF
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485960; cv=none; b=NY/TltzWtG6GpXZg88ucwg9Bmj9qTFPDhzLPcRA7XkKnk/mEaTbm9xkRKfFm5I7JWc9pz5uVeqP3wRNzlYWuSaMme71WaXhvyso+glnaE9z1aUF5FYmHvYMkxNd9QfZuOLzGVc1oLXlZvNFEE646O4q0ygigYLTyb3OeqFMxw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485960; c=relaxed/simple;
	bh=3nmRFiQ7uT3udcLq+A3quQ3bTH5Y6oSwIuTOQBLYsb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGJm33fomVcX6sjnGal03EABOvDchZHKO0t2HQBYl5vRbaaNb4eRfoN1nFQuPK/nGlrAoS3iw2flYPkpydXV3QjKNvGMFU+jyhLAVkVlRmLv1Df265vFNmPPcy8uMpLndtPY4xqH2yWnByV4mD0baxaY3zx8wKJ+g5VjQRPK+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uu5fYrlt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166db59927so3067475ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 14:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739485958; x=1740090758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8EXaFBxLNwE01bf56vbVzMOssj4GtKhR3eMZAm/1Sk=;
        b=Uu5fYrltx50/XblOSIRWeraTGPQg7P7w1LNxOZEP+sk5qEafFV6ABsod24hvqV1uw+
         4VT7At71D4DVe2IlVutI0iHChr7SYSiZl33FN4gMFxQe7NWmlvXF8amUrKUg1WgTxesp
         VP8BvCUtFHL+tiJ9p9AycPgLd/4iUadZhYGOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485958; x=1740090758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8EXaFBxLNwE01bf56vbVzMOssj4GtKhR3eMZAm/1Sk=;
        b=KMGC7QMPLvW9oTEmNP5ncVR2+0e6FJnx7p2jwVnm5v1kek34ynaZ1o7A9f55Kx6xhn
         OwvAOIGt5awGLjPJCHbiXlhPNcUXWCH8cXGpLvWZsIluuMzUCR0xyyNIsrGzgTTgMuM9
         PyaRD1pNJ436fJ1XxJQ5nCiRNVg0kpkSvhKEQiQqfDLX/kli7uOeEzrEN4hSKBDuN8FL
         8wFNZ+xhwxHzxxQkAYuO7splD69ztBHBWRIPth/1U5uZoVTnfOhFZ/7N5tDnx75BCxNY
         4mO2zUjOvUi8+WtacFmsOsaIvFEco831GfmC4kAk32BcQ3ZBVBCuWeQAQEtfZ7WuT6lp
         +Gaw==
X-Forwarded-Encrypted: i=1; AJvYcCXaPbooM4O5yE7AdLkQac0qbyxMc+uPpSFxTyP9zdQ/W1W9KkbSjHIxjZhBbBqHilI64eHwUo0VGql1qsLwZjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj3j8SHopq3rLTlykzCKJbMZ2fMq2lKh2/dBgw4avRTP0Efky4
	/tjwoJvn/4LUZcOmN28E+NFCJxKTgKgZ5AZbeAOsKgkLbB6oL2g5FZ/ltzoWzVnz9jRj2PZ20SF
	oQnBxOPO/TLxba7a5OvUb0iVy7C8/8athUy0t
X-Gm-Gg: ASbGncudmlKHcSxLkxIVfD5wy3hwldD6zzx+5ppGy7pRZwXxHJanZVF2AaXiygdC9AG
	y+Unv1tXoNxFh4NEINl+qWTvB1vMlRVx8q3fIZi/lj+sY+GzErE/MVCpSUX60rMdBEpMnGUT6u2
	i+aShHMzty3TbYJmiqcWgLxbIubA==
X-Google-Smtp-Source: AGHT+IF1OsZN6y8LH5UFbbLgIRQzGQDhYmY9iWe1VIWAc/mhKTx2qLrVd/uziGv/I7jl7tP3DIW1vJlEqePyBZ4ldYU=
X-Received: by 2002:a17:902:e842:b0:21f:1365:8bcf with SMTP id
 d9443c01a7336-220ecd267bamr4086825ad.10.1739485957623; Thu, 13 Feb 2025
 14:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211132531.1625566-1-mic@digikod.net>
In-Reply-To: <20250211132531.1625566-1-mic@digikod.net>
From: Florent Revest <revest@chromium.org>
Date: Thu, 13 Feb 2025 23:32:26 +0100
X-Gm-Features: AWEUYZlJRhpZB56_aH4q9zf3m-yAA_hSq9j-t_OOEGxjuX863x3ZmA-WZyxJpVA
Message-ID: <CABRcYmJzKdU0H0zXA5QSwD=qF_dnPyGTaXGFFyqiYMF6HZ0OeA@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/landlock: Enable the new CONFIG_AF_UNIX_OOB
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:26=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Since commit 5155cbcdbf03 ("af_unix: Add a prompt to
> CONFIG_AF_UNIX_OOB"), the Landlock selftests's configuration is not
> enough to build a minimal kernel.  Because scoped_signal_test checks
> with the MSG_OOB flag, we need to enable CONFIG_AF_UNIX_OOB for tests:

Makes sense. Thank you!

Acked-by: Florent Revest <revest@chromium.org>

>  #  RUN           fown.no_sandbox.sigurg_socket ...
>  # scoped_signal_test.c:420:sigurg_socket:Expected 1 (1) =3D=3D send(clie=
nt_socket, ".", 1, MSG_OOB) (-1)
>  # sigurg_socket: Test terminated by assertion
>  #          FAIL  fown.no_sandbox.sigurg_socket
>  ...
>
> Cc: Florent Revest <revest@chromium.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/landlock/config b/tools/testing/self=
tests/landlock/config
> index 29af19c4e9f9..361f94f8cb0d 100644
> --- a/tools/testing/selftests/landlock/config
> +++ b/tools/testing/selftests/landlock/config
> @@ -1,3 +1,4 @@
> +CONFIG_AF_UNIX_OOB=3Dy
>  CONFIG_CGROUPS=3Dy
>  CONFIG_CGROUP_SCHED=3Dy
>  CONFIG_INET=3Dy
> --
> 2.48.1
>

