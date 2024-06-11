Return-Path: <linux-kselftest+bounces-11648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BCE902FA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 06:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F027283EC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323CE16FF5C;
	Tue, 11 Jun 2024 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mhBihUmp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AF282E2
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081173; cv=none; b=Juy03vwWh846kPwDvUTR6IJj72W26tF9+ZuG8TWvMdGqmVRuv+F9SU1nLwwDjX+lrEvQpNF55PDjJYYjI0c+EdPWqkTMLpJ1Sndn1R7Th+E9cgrK/cg+PNOK+HCKRjoFtguamGMKJ+jrh9XA91MqrkO4yj9ZFZIU6mAN8YT1hBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081173; c=relaxed/simple;
	bh=yuDAWE5/MJ7uLyZqxDy3EYvOR6RL7CZjGGAfPr0n8k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRvDD8B2+UOg3LeRa4ADwwrwP2qiJuyD7lqfjofmInr2oKKhrN5Mtvq0MhhlNjMw8ZngcR6zgmhAvdkvlPJXGmFh5BWWl3LQDobbiW7LcfUWPgf+aUhKkBMys7HfTGZ9vfeccMGQkkPM8dGLVE9sRoVSTIA/FUWllkJjpsEAoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mhBihUmp; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2548c80efc6so1343055fac.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 21:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718081170; x=1718685970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIoabIczz86lr8Q01sQG2GhLk5y0SCRcj0MaX6R+rEA=;
        b=mhBihUmpK9vukRlvoTBZOZfDvNlvUBtHtXWK9SkAE3pUDUxvGyKNQfSP8nACCdaL0Z
         KurGcMladYQSSW8biNt1qpl9a15GSfCTA8Oc3L3tQK+jTrWNODH7TKGbbnGg8QeftddI
         r1igUEEKy5JgfFwJNTedZnXwAAjJVNgp1U6Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718081170; x=1718685970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIoabIczz86lr8Q01sQG2GhLk5y0SCRcj0MaX6R+rEA=;
        b=MY7PqfYihBWAy+XYqZEPG3XB7Mc860UpKRbnBunad4YrEK824ZgqzRe0idReb5t2Kt
         AGnDI9uMIDQn+oIugdRAqX80TxWn67E1ehvuhEOf2eobrRsG0ml0KI1Kt8gryDAT8PKO
         Bly5hj4VwvRP29+/a5hKFVnZeGLxmcJMKs39r/QuGOxmK08sVH6natGW2npOkmKrOHKZ
         v6Di73nx1c/q1wWUK9kWZUwq0E+VZnvCNHNQ/GVdbVdf2winJAqeqDCcNe0KwlL+NkbC
         RJGaxHwwjX9trt7FK53VT3509GUEnYUvyvY9GdLlJfaSYtnkvj2kf0rrzx79lneyDdUu
         c9pA==
X-Forwarded-Encrypted: i=1; AJvYcCXxYHrlGCF46k3BcuCh/o6EpF0VL+i1RwTjUd8t0Zw7ynvXShynhMYo8o0jDZmxbQdkFLSO4ydQ0pF1sFjheq2jw+BS8RBYFEpIRLtRQhG/
X-Gm-Message-State: AOJu0YwRnc9EbKV4BtzxA1ZhxuP8iKT8oAtsNudMlb1qxRWJ5RY/Yn5i
	8uBc90SElkTylpik4zn3QQPR+b6w1ycpRpZSHJF3KMTe1S/YOCtB0MeixVL1+qd0HWLC1u7aElc
	si40tR4W3SGr68IS5bEOr3jbBO7WFw8JTmvyS
X-Google-Smtp-Source: AGHT+IHByfiAPO14fNnx4REFTehCbJqqMb4IdmeoDY4CQXPTK8vbG/tux2eHQk3D4fZ3pX6WwvizBlreo/EtSzC41/M=
X-Received: by 2002:a05:6870:350c:b0:254:ba68:a6d2 with SMTP id
 586e51a60fabf-254ecf7b04emr745965fac.25.1718081169944; Mon, 10 Jun 2024
 21:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608021023.176027-1-jhubbard@nvidia.com> <CABi2SkVoNyXLrfU71gnv1qVUAADpUmFXiDoKKPc54MLb5JpB+Q@mail.gmail.com>
 <a8f9d4e2-8a12-4e5d-bd22-9c92955135f4@nvidia.com>
In-Reply-To: <a8f9d4e2-8a12-4e5d-bd22-9c92955135f4@nvidia.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 10 Jun 2024 21:45:58 -0700
Message-ID: <CABi2SkU8=tjWhD-e=OdiVr+YeU+BZZLB_vMfkNb-VWpbP2xcng@mail.gmail.com>
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make headers"
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

On Mon, Jun 10, 2024 at 9:34=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> On 6/10/24 9:21 PM, Jeff Xu wrote:
> > Hi
> >
> >
> > On Fri, Jun 7, 2024 at 7:10=E2=80=AFPM John Hubbard <jhubbard@nvidia.co=
m> wrote:
> >>
> >> Eventually, once the build succeeds on a sufficiently old distro, the
> >> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and th=
en
> >> after that, from selftests/lib.mk and all of the other selftest builds=
.
> >>
> >> For now, this series merely achieves a clean build of selftests/mm on =
a
> >> not-so-old distro: Ubuntu 23.04:
> >>
> >> 1. Add __NR_mseal.
> >>
> >> 2. Add fs.h, taken as usual from a snapshot of ./usr/include/linux/fs.=
h
> >> after running "make headers". This is how we have agreed to do this so=
rt
> >> of thing, see [1].
> >>
> > What is the "official" way to build selftests/mm ?
>
>  From Documentation/dev-tools/kselftest.rst, it is:
>
>    $ make headers
>    $ make -C tools/testing/selftests
>
> > I tried a few ways, but it never worked, i.e. due to head missing.
>
> You are correct. Today's rules require "make headers" first. But
> I'm working on getting rid of that requirement, because it causes
> problems for some people and situations.
>
> (Even worse is the follow-up rule, in today's documentation,
> that tells us to *run* the selftests from within Make! This
> is just madness.

That is hilarious! :)

>  Because the tests need to run as root in
> many cases. And Make will try to rebuild if necessary...thus
> filling your tree full of root-owned files...but that's for
> another time.)
>
> >
> > 1>
> > cd tools/testing/selftests/mm
> > make
> >
> > migration.c:10:10: fatal error: numa.h: No such file or directory
> >     10 | #include <numa.h>
> >        |          ^~~~~~~~
> > compilation terminated.
> >
> > 2>
> > make headers
> > make -C tools/testing/selftests
> >
> > make[1]: Entering directory
> > '/usr/local/google/home/jeffxu/mm/tools/testing/selftests/mm'
> >    CC       migration
> > migration.c:10:10: fatal error: numa.h: No such file or directory
> >     10 | #include <numa.h>
> >
>
> Well, actually, for these, one should install libnuma-dev and
> numactl (those are Ubuntu package names. Arch Linux would be:
> numactl).
>
> I think. The idea is: use system headers if they are there, and
> local kernel tree header files if the items are so new that they
> haven't made it to $OLDEST_DISTO_REASONABLE.
>
> Something like that.
>
But I don't want to install random packages if possible.

Can makefile rule continue to the next target in case of failure though ?
right now it stopped  at migration.c , if it continues to the next target, =
then
I don't  need to use gcc to manually build mseal_test.

> So if you systematically install various packages on your machine,
> then apply the various patches that I have floating around, then
> you will be able to build selftests/mm without "make headers", at
> this point. Or so I claim.
>
> thanks,
> --
> John Hubbard
> NVIDIA
>

Thanks
-Jeff

