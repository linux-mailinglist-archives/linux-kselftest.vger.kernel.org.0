Return-Path: <linux-kselftest+bounces-30154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C955A7C7C6
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 08:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE793B66FE
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 05:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF331C3C04;
	Sat,  5 Apr 2025 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrSKivsW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE925569;
	Sat,  5 Apr 2025 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743832802; cv=none; b=Z6TXhqaWMeGWEpkN6z8bgi9/OzHwIHNpiWzaeFu0ZFWEBFDlHAwWz4WmrON3KCpzX6AEylN9cw4KBcwmhp1sEUukC9hivnWe9z7hmVwQRmJiVaHNv+Bnaz3N6zTUpUSWTs5S8OzRa2JKIB+09NInyOLcH6ejJM1ZIYY8hsqSv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743832802; c=relaxed/simple;
	bh=FXKswitWL8pGh7AXLWw7Y/+Gu9zaQV0t/C3KcdBRwkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vE/uHPPVTfJJziiuhhNj8C/uBJvsNbtTvEIJjKDxfqjvYt6y7alfQawzQW4gvs80BugK+baihnRR+xK2qGBxjjtfeaCo5ZK0/AbK7PNRoGiwGoUM0cotDXhqrMy1lL72lBFPiRvSA94Sj1ZkKTY9WuE7SkPh+Szo0fInwR9STcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrSKivsW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso488461066b.1;
        Fri, 04 Apr 2025 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743832799; x=1744437599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4I6lkE4MBJ+2RjskTnudiDh0Y26BC1z7LHd2waUKGM=;
        b=mrSKivsWRIPCeQ8KCrGEEWlN2mVcnkEdWmgpzYk+0yA8lxbV+iNMsW/80TFQqyNnMA
         75Gw5WbxovP57lLRGxPefxLsA9y6qyCdLv3EsunHL90y4oY0ug8K+urGUzYg2ABmRD7V
         vGVQbSrVlGJz+ltRT4hQ4E39t9JbBW1eshcQgrPQU6dtQndPpjzMwUxQArYOnfoQQnRs
         AFT9syWFYAkO9K6dBe2wI2tOYBh2J5VGw/htIxhvhuU01WwmJ5GmsudPEg/I47s9wGC9
         Vcw0LV487zP/CWfkDQfC0UC7hkyvWA7TkF0/hcr0VN5t1v4kge2OmQi+p2+29Pj1CPSq
         YH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743832799; x=1744437599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4I6lkE4MBJ+2RjskTnudiDh0Y26BC1z7LHd2waUKGM=;
        b=hxZRdfp4v6P2wHfs2FJqxTDE8gPsiAjsxd/7UJlGabV9jL4yDClSpPB7a+l4Zj3cHp
         p45FioHTte54Hjoww8W8oONdF24UBJ3YHOl48fOfv2ESIlt+x8DxmmAa4R1oUBYydjyL
         QM7cLA1H2qJYVaS+RDItkHTUYSo9sXkvdz07xIasAyo6D3vrP045vbvw8ouyiVLN1p0v
         JUay2TpVXJ+RYVFXDXNS9sCnENKLeud3SdlcKEPq3hgUoHQRkvQ34PAj7tZ79u8UbgSQ
         lvavHUMXuvP/AAJ8vVDu8k3pE6xyIjgjt7cb7f09pkXoGFbbcCVPt3rBDN3UVFoDysnb
         2NDw==
X-Forwarded-Encrypted: i=1; AJvYcCWtlfb2wvWxb3Sl1b1YF06PXm0dkQEKwMnrYgU1vs1J+1SZq68hU4QgsWT61CU5DW7cH3d66RIwSCFMBbmO@vger.kernel.org, AJvYcCXPMFowgja98XTrVzSHyn75anJQxyrWm4rN9YZmc2+015dxs2FjbhFDTrC/4k8eDi1fD+Q2ZleXz9zQNyuLzuPB@vger.kernel.org, AJvYcCXtRdmUZH9LbPhM6A8v48/ZWeQogndrzWk2LulFeXVC6d8bV+lnfaskeE+SSFH5R4rTIOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVgle57sdxYupUbRbG2XdkK3epj2H1wMKIK38CeTXHsTLW8Rp
	ffE/F8U37vSirfFGURnYhcWNlW/peaH6n5fLhCt4igGXesjYcHRuds2GiurhRRUAIMaaKCoGPZU
	trbHcruBd4478EP3jqbiXq90+lyw=
X-Gm-Gg: ASbGnctLGeqYsFoNPTT+YG8mpvz+Ae41ft3xCbRsctHfspi7EO6to04Gu+uD3dgJCAK
	mfKhPSsDwuuL1IxrYw/FUNfVKX+HvEWrhQn9Bze/mRUthcXiQ1faH2rueOJol/Pva64yWcO7XHz
	+wHNIAjejzjQm5n36yA2hVyeow0hth
X-Google-Smtp-Source: AGHT+IHxbXwFZRwhjL4+35MMRvltBeoPQ5AJrjqgpmvMvZjFZ4JS9/zwBlhGHwZG7uR51OR9yaipTdFEiruAzGgc49A=
X-Received: by 2002:a17:907:6d0f:b0:ac7:b8d3:df9c with SMTP id
 a640c23a62f3a-ac7d2d85eb8mr353399966b.1.1743832798766; Fri, 04 Apr 2025
 22:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <malayarout91@gmail.com> <20250324064234.853591-1-malayarout91@gmail.com>
 <CAEf4BzagSxO-fNeeWfFPu2vpnbEUBnS7Y2P=ODGks_zVEg1mkg@mail.gmail.com>
In-Reply-To: <CAEf4BzagSxO-fNeeWfFPu2vpnbEUBnS7Y2P=ODGks_zVEg1mkg@mail.gmail.com>
From: malaya kumar rout <malayarout91@gmail.com>
Date: Sat, 5 Apr 2025 11:29:44 +0530
X-Gm-Features: ATxdqUFk_e0oBjZcLoboSguatZkSXBMa6QLz1qHPNjitlpaZ-6NXXNaB8KhmYcs
Message-ID: <CAE2+fR83Y8ZKk8fqM0WgZeK4Zm4PZjBzoPMyMptVHfk81eXEtw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: close the file descriptor to avoid
 resource leaks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 9:22=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Mar 23, 2025 at 11:43=E2=80=AFPM Malaya Kumar Rout
> <malayarout91@gmail.com> wrote:
> >
> > Static Analyis for bench_htab_mem.c with cppcheck:error
> > tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
> > error: Resource leak: fd [resourceLeak]
> > tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
> > error: Resource leak: tc [resourceLeak]
> >
> > fix the issue  by closing the file descriptor (fd & tc) when
> > read & fgets operation fails.
> >
> > Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 1 +
> >  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tool=
s/testing/selftests/bpf/benchs/bench_htab_mem.c
> > index 926ee822143e..59746fd2c23a 100644
> > --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> > +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> > @@ -281,6 +281,7 @@ static void htab_mem_read_mem_cgrp_file(const char =
*name, unsigned long *value)
> >         got =3D read(fd, buf, sizeof(buf) - 1);
>
> It could be a bit cleaner to add close(fd) here and drop the one we
> have at the end of the function.
>
Here, close(fd)  is now positioned within the error handling block,
guaranteeing that
the file descriptor will be closed prior to returning from the
function in the event of a read error.
Meanwhile, the final close(fd) at the end of the function is retained
for successful execution,
thereby avoiding any potential resource leaks.
Hence, It is essential to add the close(fd) in both locations to
prevent resource leakage.

> pw-bot: cr
>
> >         if (got <=3D 0) {
> >                 *value =3D 0;
> > +               close(fd);
> >                 return;
> >         }
> >         buf[got] =3D 0;
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools=
/testing/selftests/bpf/prog_tests/sk_assign.c
> > index 0b9bd1d6f7cc..10a0ab954b8a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> > @@ -37,8 +37,10 @@ configure_stack(void)
> >         tc =3D popen("tc -V", "r");
> >         if (CHECK_FAIL(!tc))
> >                 return false;
> > -       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> > +       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
> > +               pclose(tc);
>
> this one looks good
>
> >                 return false;
> > +       }
> >         if (strstr(tc_version, ", libbpf "))
> >                 prog =3D "test_sk_assign_libbpf.bpf.o";
> >         else
> > --
> > 2.43.0
> >

