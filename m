Return-Path: <linux-kselftest+bounces-30453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6FDA8348F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 01:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E233B76F3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E495821C187;
	Wed,  9 Apr 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYIlRuMX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A47211472;
	Wed,  9 Apr 2025 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241456; cv=none; b=u0dQl7eiZIBTp3ipAaACk7u77VqHOJm7k8UNsiF+0S0S3Dzhn7K5P6uSoj1tsqFJDfUuXhXkhsf+VkmbPlePx2uHWOk669rIjRbvZfv3U50+V/qhVLACgRaGhzhlSu6WrqK0Bq1SHTRKm1dpH9dENPUKrh6k3BdUpPCj1cA/pT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241456; c=relaxed/simple;
	bh=Js7WYNCavCfNAg3EWG/WpBt3xAl7NuuO00YAbDtIIgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpfObJtt/+NF8P8h//b3fChhxXT5Iqw/fDQ1r9EPprcbgMkRA4VonjylVYaI++wqSSFbU4yVoCwJ+3+BOxVB84ccK9bcMc4udugo+NBXpfrQgl/kcbS0Jh9ofKBgR6d4aRxN0MastPX2HdRHckwqW6UX6KU4qZqBZ8vQ2J5cBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYIlRuMX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c266c1389so74174f8f.1;
        Wed, 09 Apr 2025 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744241452; x=1744846252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnJZI0svWc72oGG085tUoRlOM0R2CgLBsn6OTqWEe6o=;
        b=GYIlRuMX9hWqvM3Ypaeajd/GzfZ/CXhg6ndwz0vw3Y+I17+lhwAmNuBgnVc/kNohVc
         EIBMncqb34eyXIfLjql70pK1tSK1VJEMcyfNXjO1b7YA0Rjt9hdTv7z7J6a9wwfWq+ZI
         ze4jGMw8vZOIxpwgLXyjxZ2ivzcUHxX1ajAwCZ+KkzPjxbSoFD7caaOfs+P/ValX1VP+
         2LGX/DENzb25jcMPGFBlzsYCSsTxlTlU8ik6ZR632wUAit9IKsxcOvDIoiMzDgKIvw0v
         EsQB+2ZyG8zHM6W9tynUx1RJmXa1g83n1ETM+GPZL+kbBUaFFDIBifx8a3gbZBRojcgK
         49+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744241452; x=1744846252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnJZI0svWc72oGG085tUoRlOM0R2CgLBsn6OTqWEe6o=;
        b=G542fuvhaLY1Btc94e5P5ANlMzZzIWo3fBzSp455cLdbiwjyTptptlUyMwBwAlsW1M
         nzxSlYC4/RyC6Gc4bi0T6MNQwcwvOoGvtBHI11rVFbvu44xtt6NmnDD5wnTUKvc1qFOz
         +T03tLBComy9ZaHP69KVdUz8KC0Jlt+AuVnhGIfcYUA6CnRzU63sYdVNDTDtojJeQmJQ
         XjtRISnRXBtVl7MzyDd2fD4YSIt3BrQ5/ukawFKJM1OppubbRReJ+h3vy15uPpya8BrU
         8g7CMRywU02ySfowu3uLkKUbG1xgjFgCJy3+T9psQrT6L7jSdGzUtBCSKo5SOoDQiZSb
         IW8w==
X-Forwarded-Encrypted: i=1; AJvYcCVbG45tppceLo9PNofwdlJqzlA6XDC1ps3kAoLUGaVOPaw0q0NB89IQ6m7tJD3m8lQ4JPRL6D1aNFHpCell@vger.kernel.org, AJvYcCVcIIYSLRYfOJ8ZwUWh6jnqQrgFEp8Wh8JR3Be3wlgh3ZFq0KSHulf6soPRskj+yjU/IZbiR0WH9rRGAOdaCQ8Y@vger.kernel.org, AJvYcCWgH1sL0mADFePbYhqQSbyfhe85SQn9ZdBZHwyiW6DU7t7B0rvW2rS3cnkiKsiCHgzB0YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyy0PVZGDzsgRpguWFxtqJpfZgcdHpId6QwLmZ3sZQPYd2LI9T
	18pyS3tclzsvEctC2R2b+1uxFmlwbTDrROSl/DuqxUXGKA81yju5yJHcG3O0ViBk7seNf8VpE+L
	2j2fUjiVFmOjhZyN2sH3JDAogsCY=
X-Gm-Gg: ASbGncvLUbTAOzGyJk1wcua5PbGpbjPb7FaDx5kGhfZDJ3b+0YtJFJGvvtEF/Fw9VTy
	FzG7Xo+8da9NqLhrCbywV/XAClBmutFweMMy50BAj+wPYQPqYvT0TCV0MdB+hQnKBflCnTtMzoK
	nSkNlSVWtxX7vkWr83fn7zxoq6fKyK5JrnkimV6w==
X-Google-Smtp-Source: AGHT+IFPeAq2bn7SKlb9WYQ8zwM/A4ihUIaISS1jRomlBP0AU70OvHzHaNND0vB/zW4BB9dGSdX9jnZiRXVgSR/WGGc=
X-Received: by 2002:a05:6000:1446:b0:39c:2665:2bfc with SMTP id
 ffacd0b85a97d-39d8fda7678mr172748f8f.52.1744241452180; Wed, 09 Apr 2025
 16:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92596c82-4a12-3afc-6cb2-21a11bef3739@huaweicloud.com>
 <20250408183214.6437-1-malayarout91@gmail.com> <CAEf4BzaD63etPL6EYW5Ct2Z_RMEXXc_puLUCm8S9Dth0y6r6SQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaD63etPL6EYW5Ct2Z_RMEXXc_puLUCm8S9Dth0y6r6SQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Apr 2025 16:30:41 -0700
X-Gm-Features: ATxdqUFCeciBa9kIMoHXi9FvDnpgD6HIA4cfTPxrMhBs1oFku6KVvZJ1rlSb6Qg
Message-ID: <CAADnVQJbBOK25Fx3zEG-ZH=zTFRfPNQye673b5TnpdTdMEXAUA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next v2] selftests/bpf: close the file
 descriptor to avoid resource leaks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Malaya Kumar Rout <malayarout91@gmail.com>, Hou Tao <houtao@huaweicloud.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 4:28=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 8, 2025 at 11:33=E2=80=AFAM Malaya Kumar Rout
> <malayarout91@gmail.com> wrote:
> >
> > Static Analyis for bench_htab_mem.c with cppcheck:error
>
> typo: analysis (lower case and typo)
>
> you can also make into a bit more human-readable sentence:
>
> "Static analysis found an issue in bench_htab_mem.c:
>
>
> > tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
> > error: Resource leak: fd [resourceLeak]
> > tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
> > error: Resource leak: tc [resourceLeak]
> >
> > fix the issue  by closing the file descriptor (fd & tc) when
> > read & fgets operation fails.
>
> "Fix the issue by closing" (capitalization, single space between words
>
> >
> > Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
> >  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
>
> For some reason this patch didn't make it into our Patchworks system,
> so we can't easily apply it. Please fix the above commit issues and
> resubmit, hopefully this time it goes through just fine.

I thought it was a maintenance issue with patchwork, but it's probably
something else.
I'm guessing your cc list confuses pw bot.
Pls drop linux-kselftest@vger and lkml@vger and keep bpf@vger only.

