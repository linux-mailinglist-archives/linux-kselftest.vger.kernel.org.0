Return-Path: <linux-kselftest+bounces-20883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B789B3F48
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 01:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB87E2835DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9132F2D;
	Tue, 29 Oct 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVYMVSX+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E5017543;
	Tue, 29 Oct 2024 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730162602; cv=none; b=XjzZkmWMB256uDiHCOStUAfR2lhgY3y5QdXblaK48JHQeUYVzwiakubEMGnBDYrnQjxZ67nOvaHwe+GyzuYfnOVrdrdV0DZpWvnEgl1rhPx+3TgmKnQtPuhWogj3G441MeUg14KY6lAcwiyyfoFSwkPheriC/Kxcq8MLDr6czMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730162602; c=relaxed/simple;
	bh=0NY61fB4vDB/yQa2MSMdPWA/HlVG0D1XwySlF+O3AZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5wjGAnhEk9P+REmXBgW5vDZq8wj71ZjUveca7Y1CpESXQnJpqkKHUC+18iNHoxlBXUuAjwdXHRWA8NeVGfHRnh9Il8NZveHqaRpM8khm6g0foYeFZiYFCnjT27yuonI3qfIeakksQXU5Vdpbf5jPlsMXcAHnIvDqinHRB+y+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVYMVSX+; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a4dc2fff04so16510245ab.0;
        Mon, 28 Oct 2024 17:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730162600; x=1730767400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4biQQ8ZiepW98FIN5ue9OFoOVdlUzL9MRapb20ph2Y=;
        b=SVYMVSX+2xv2idVQ0CtzlalP7l0jXMTHNb53VU45x9zquQSVBvoUKrK4dmEvoZoK1P
         9HcfFcOTEAFJV8bWA5rDr6Nel8h91qZePPaoa8o5Grr7tnL6hPF7pJKKzjnZKy63AnBo
         FnBCnPXBDI4ltis3OhNkL/A98oQR7YZ2wROifAWu9o/miAHca2O50ePl9hVL4H9jYvLN
         Up3lPK3VI40nxG7b7vwPKv/4+ld6d7T8KfnIV3C2bjCOLQxNRU9eTDd4IB51ayGAD4Qs
         ZAiTACe8N87vKH8/Ic1rL9HC6vl8XltJPmYekg/QF9tA9ge9PxWzQwyz+NWmkuInao7x
         oV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730162600; x=1730767400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4biQQ8ZiepW98FIN5ue9OFoOVdlUzL9MRapb20ph2Y=;
        b=ur+GgPrgDDVb11pFD4jlGs+lj//7PhW7gYUcNyilSCJdXQno54dbwPedFMoXbzB4HG
         Ypn1jCX9e2aUBa0jgBvkB9dUcdrLcCBzKjEZw90ZpFWAvRzRe9J/xQk7klFiewUhvGSK
         7VGcJOKnqg9CEKtCfmhvMSAfQTUgOp5CkEI/52R1Zhdf10TKKirRcxeemiOrSYZp7gue
         MzVbVddswBuml4VN12Ov8hU8SvcTLyZqJGEmSixVt+liZAdvbhKSZP2vBMnu4YJcs77w
         HzgJYdVXsdmCkfTIbXTR7DYFE+92uWpRMndGVH6ImYHyHx+KVNkYlpfjfesiOIVVukCn
         OdfA==
X-Forwarded-Encrypted: i=1; AJvYcCX4G+3NDqrAZ1dEc2OlBl2M2baH9xb8HDErcNaiMLO2l++DFXsxQbJKBu6oQyeMWhymwMU=@vger.kernel.org, AJvYcCXnnOhRZCfy0w6hgQ7t7NrT3v3igbPyF8TmiJ1aPWQmZX2IIKY+5/6fNn96slSHIt+fIzQlhARWTlq+iS2vwm0j@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQpA21nhFCronqeWpblH11cSgJ1tG3YESUFp78gfFSmdM7dzF
	9FvqeQBHb2zTLxtPGRFmHe1lpfkbGORNfiOGUz/8cAAnoaB+n0qffxYmPzP83jnvaXVEssB6VfW
	5Wku4XyB6cbXZavXuz2dCpFGeHMs=
X-Google-Smtp-Source: AGHT+IFVhQbWRu+HVVXzfHOIE/IjNPMR00kY9j/vD3BR4ocmkq2/nXMDWJRwM9EYn6oA+hDWUiFxvp3L228VgxJaeno=
X-Received: by 2002:a92:c544:0:b0:3a4:e62b:4e20 with SMTP id
 e9e14a558f8ab-3a4ed2e1ce8mr76069135ab.9.1730162599967; Mon, 28 Oct 2024
 17:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028034143.14675-1-kerneljasonxing@gmail.com> <CAEf4BzYsTPTOMWyNcA1zRmOUhko9KYhWT8VNabZwz4S9_79_eA@mail.gmail.com>
In-Reply-To: <CAEf4BzYsTPTOMWyNcA1zRmOUhko9KYhWT8VNabZwz4S9_79_eA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 08:42:43 +0800
Message-ID: <CAL+tcoCMiK6ifxuPv3+rF9jcch8yYTH8tbSJNmBbYUKZWJi5_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: handle implicit declaration of function
 gettid in bpf_iter.c
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:20=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Oct 27, 2024 at 8:41=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > As we can see from the title, when I compiled the selftests/bpf, I
> > saw the error:
> > implicit declaration of function =E2=80=98gettid=E2=80=99 ; did you mea=
n =E2=80=98getgid=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >   skel->bss->tid =3D gettid();
> >                    ^~~~~~
> >                    getgid
> >
> > Adding a define to fix it (referring to
> > tools/perf/tests/shell/coresight/thread_loop/thread_loop.c file.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_iter.c
> > index f0a3a9c18e9e..a105759f3dcf 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > @@ -34,6 +34,8 @@
> >  #include "bpf_iter_ksym.skel.h"
> >  #include "bpf_iter_sockmap.skel.h"
> >
> > +#define gettid() syscall(SYS_gettid)
> > +
>
> We just call syscall(SYS_gettid) directly in all other tests, so let's
> do just that?

I got it and will adjust the bpf_iter.c in the next version.

Thanks,
Jason

