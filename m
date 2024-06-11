Return-Path: <linux-kselftest+bounces-11643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E32902F80
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 06:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D956F1F234E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5116FF23;
	Tue, 11 Jun 2024 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XktSqz4x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161712FF65
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079983; cv=none; b=Pm4svLan3X/eoG9EMFaByAIVp4LV/ix/Lr9zjTLYC4Os9cRr+0M9Ldxxop3QpSISrCcdDJwK2+6KxsxWgsyXe60cJJcagbImNyWGgSxfWgDuEcbnnHREc9aIYAY0+vYWYhN/MJRZXFnQg82k1tenzKOHUs8ekH9lKAH94oYuIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079983; c=relaxed/simple;
	bh=uO0RrhHuqyUcZ8FW/DdPkgw2Q1fkZ4XCBhNFadXwJsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhoAvMk0ScqYPySismqyr1dK6ojIkgPTVoImMzk2dDbgd2nBMdTWmYJRwnZPsggSBEYyNoDH70KxUsFsavxs4KheergifJARSHaMROzuAZHR+BYWTUCBX043ippFuzpQhEInDSxY33YgfKt48lSzvItYK01/mIUtcuYnFXeBgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XktSqz4x; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-250ca14422aso2762224fac.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718079981; x=1718684781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyZsNH9Sc1x7yXcWCuPg478ZMDctoHgE18epfdz43V0=;
        b=XktSqz4xmelYHg93JGxvMVTjG4+hK/MtIsfy2LirxpdzlAbqy7smmi58FFKvkJ/1lu
         dPWKGiX3gmdEClWdEvIKuLnFxy7DwIgaeHcDQCZySxdDsXuIp9LNHkkutYmOucuvEEqR
         LEfwAytIRla7u75ACHPC535Hr0h4qCSToy1CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718079981; x=1718684781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyZsNH9Sc1x7yXcWCuPg478ZMDctoHgE18epfdz43V0=;
        b=D7403fAj27/HfTGhVSioePT0j62K1/M/VTATgqqJVVwnEg/xpKSSDxR2GUhDRjoQkD
         T7AWuZOPtfrtc38fQUKud6n7Yc4D+R9n9qhEtQpZcaoqBEj7QmWeOvd42HfFG2GHwSHQ
         pcmJ8G/mx/0bL3tfWBpgBmARzepsBVJpx0mp9T+r1nOUqYlRU44drYJNIDNmFIDdgP1h
         0TXhPDnWwweDNt/1hAysrQdrU34DvRTzX7/nEYXw+SW+A/x0olTi1cJrTwqsWfs+cMa8
         7G/f15nCwmUzOZvLpPUa9R23tMuTjOM069+R79MGiYA8wWrrx8/Qq9I9YMLy+f1SS+hv
         7xDw==
X-Forwarded-Encrypted: i=1; AJvYcCXr/d18oLLxaWDWLGn69tHQSEZInCt91KyjTHcKieWx0SXpHUG9+6hRu/fv9lljc8BJJ3ksgeirfWgGhRU7JQIPn1xbE652UFWu0UgGk+ya
X-Gm-Message-State: AOJu0Yz86DpAJl+QajJ0RGNV0bBRMGNC1a1FbPC1Nc7Peuuw2bQ/B/94
	xiQ6gHxy/if/yoDYh84xlnOOjapf859P8IN1vU8uq7FMVs8YK7foBDe1LGsuiRFeUqOOYG8IKzD
	ApuSjdhXukTfP7zamAHp93UlOklvfcmnuv98/
X-Google-Smtp-Source: AGHT+IFK6lTZPxP5FNiUopooFXMRPUqIKtSzFDv00FIyn1QRlpsxx6oo/JyuSnfToVP5gluNPRqDdITOntAxxf9qVvQ=
X-Received: by 2002:a05:6870:56a4:b0:254:826f:a9d9 with SMTP id
 586e51a60fabf-254827023d3mr11111691fac.39.1718079981520; Mon, 10 Jun 2024
 21:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608021023.176027-1-jhubbard@nvidia.com> <20240608021023.176027-2-jhubbard@nvidia.com>
In-Reply-To: <20240608021023.176027-2-jhubbard@nvidia.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 10 Jun 2024 21:26:10 -0700
Message-ID: <CABi2SkWduvq983tXzsYc-aHQdpazm5K84hre7QtyqSgM3vHRQA@mail.gmail.com>
Subject: Re: [PATCH 1/5] selftests/mm: mseal, self_elf: fix missing __NR_mseal
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, 
	Rich Felker <dalias@libc.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jun 7, 2024 at 7:10=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> The selftests/mm build isn't exactly "broken", according to the current
> documentation, which still claims that one must run "make headers",
> before building the kselftests. However, according to the new plan to
> get rid of that requirement [1], they are future-broken: attempting to
> build selftests/mm *without* first running "make headers" will fail due
> to not finding __NR_mseal.
>
> Therefore, add __NR_mseal, to a new mseal_helpers.h file. That file is
> small right now, but subsequent patches will add a lot more content to
> it.
>
> [1] commit e076eaca5906 ("selftests: break the dependency upon local
> header files")
>
> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
> Cc: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Jeff Xu <jeffxu@chromium.org>
Tested-by: Jeff Xu <jeffxu@chromium.org>

> ---
>  tools/testing/selftests/mm/mseal_helpers.h | 5 +++++
>  tools/testing/selftests/mm/mseal_test.c    | 1 +
>  tools/testing/selftests/mm/seal_elf.c      | 1 +
>  3 files changed, 7 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/mseal_helpers.h
>
> diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/s=
elftests/mm/mseal_helpers.h
> new file mode 100644
> index 000000000000..b922d453a014
> --- /dev/null
> +++ b/tools/testing/selftests/mm/mseal_helpers.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __NR_mseal
> +#define __NR_mseal 462
> +#endif
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index 41998cf1dcf5..20949617a036 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -17,6 +17,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/vfs.h>
>  #include <sys/stat.h>
> +#include "mseal_helpers.h"
>
>  /*
>   * need those definition for manually build using gcc.
> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selfte=
sts/mm/seal_elf.c
> index f2babec79bb6..4053951a535c 100644
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -16,6 +16,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/vfs.h>
>  #include <sys/stat.h>
> +#include "mseal_helpers.h"
>
>  /*
>   * need those definition for manually build using gcc.
> --
> 2.45.2
>

