Return-Path: <linux-kselftest+bounces-4151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A02849DA2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCCDB29373
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BBE2C84F;
	Mon,  5 Feb 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXv6nVK/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DC339BD
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Feb 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145256; cv=none; b=XBzEiIoT5rlgqOMu8zVNleOM4HJ+b8FSPyBbt8yxqWWc/Yr6JUz/UBNmLcXtMzvCW7nW2PB7ypjCJfVe92sVAKamMYwM2FPIzoU0ag0zBLHgmg9MXSnJogsX+MQMdC76vCF97njqEzAUcdQcEHDaYrfgcuLC/Z2Yq3JI8ME43kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145256; c=relaxed/simple;
	bh=4x/pL/LexyK+4wqZZH/6gBXshFnDy2QZXDAbJnIwUqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RW9YQRDwOL/TSFJmM4Luq/Lu9xzqbUWxUTaj+S9yyH2OGXuGxB5uH8DoNT4AZfY84M0cv7DFt8uDJUTa2TKwgaZFXKlT2wi9lcP6/otX8hHqzEwn0p5aMtjO91uf+oTzL/H0aUde3FNVszbnBna/xiVmeW+tid0gMpSJclqwlT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXv6nVK/; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-46d30f6789fso182654137.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Feb 2024 07:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707145254; x=1707750054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdJNeue2Wv0xiehiEald+OUh21W9eFlv7KMsoDs8oU8=;
        b=CXv6nVK/NtQ0TRotQaF8GyMgdPby6UPMK7Y0wkjW56Lx1IpFExmMB4zm2fmO6d2R6B
         8rCbxnjOsCrQffUh3EZKZh3hHyFUbMV/AvyiuVyhY/JKhEhTQQopu5JgGds2ZPkULBLv
         Kxfz8GKvQx2SwMTEfPPjuqDft9/toFNQCSy/sBWdX+2+saRIyCtAWEfCN6eWUeIiudwD
         KIRge7BNSL+AScZd1gh5ZCr/vgCLw8M3H38i+tSfX4KIugGt0h/tGMnlcgJFwqKPzHHO
         kxhhb3ZdokFnoSUoJ1hSrAoQEWC1L530eaDADN9U1U9opeZv01BJQIPE9wytblQgoGyv
         PZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707145254; x=1707750054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdJNeue2Wv0xiehiEald+OUh21W9eFlv7KMsoDs8oU8=;
        b=V3Fk4wbd2kc5UN1PB2GChtDIPO0j6JdN4KP95Zl5RuSjJ4bbg58tM7MHmeSmy4tviL
         vWEbzO+HWxDXh6pn8t1hENyBa0KYeGPTqvt+Qq/OUGdHH+VDHkj4p6SqyO6XbfkM/Co7
         IizyHGg7SinnvJnic6VwSdBP9Ww7DmjnLGGDsvhuSGVTDoRheimZaroBWNdIcGbIRpwI
         OLggl7vDWQG4o2c+CwFsqeL6ntpqCx6+CUTiCZEapgkq2zqH6tuowOXDuP3OYVfIKq1+
         d3hGKkXLHTNhoNtJtK+FHsMvj9Kev9znzGVrdmY9mPR3KX5m7OxzyRwDDrZ0HVTOXdZx
         +Xgg==
X-Gm-Message-State: AOJu0YwYdp8e34U4XM7OMxEzUu2aTcEbtpcnN6gSlUvzsEE3x8/foSoy
	kBVnR++H3f1WF3IDpYIKwH5v0sk7lDQgBRmcrJTvDWiZIiy2o9Dl17c/ou3AR5nW29EcHy0bb/W
	KaAqc5a5KY/UT+rsTTa/qC82BS0wTzuR4nbQc
X-Google-Smtp-Source: AGHT+IGyGdxgsP9UcWiEJx0V/pq8uMBpCddwlbwcThZVJXxE7PBJjn7CzGAgysVY689BVIMKpe8Rx7vH/upebwniUjA=
X-Received: by 2002:a67:cf8c:0:b0:46d:27ba:526b with SMTP id
 g12-20020a67cf8c000000b0046d27ba526bmr22209vsm.34.1707145252109; Mon, 05 Feb
 2024 07:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131141858.1149719-1-elver@google.com> <b500bb70-aa3f-41d3-b058-2b634471ffef@linux.dev>
In-Reply-To: <b500bb70-aa3f-41d3-b058-2b634471ffef@linux.dev>
From: Marco Elver <elver@google.com>
Date: Mon, 5 Feb 2024 16:00:15 +0100
Message-ID: <CANpmjNPKACDwXMnZRw9=CAgWNaMWAyFZ2W7KY2s4ck0s_ue1ag@mail.gmail.com>
Subject: Re: [PATCH] bpf: Separate bpf_local_storage_lookup() fast and slow paths
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 at 20:52, Martin KaFai Lau <martin.lau@linux.dev> wrote=
:
[...]
> > | num_maps: 1000
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           0.357 =C2=B1 0.005 M ops/s   | 0.325 =C2=
=B1 0.005 M ops/s        (-9.0%)
> > |   hits latency:              2803.738 ns/op          | 3076.923 ns/op=
               (+9.7%)
>
> Is it understood why the slow down here? The same goes for the "num_maps:=
 32"
> case above but not as bad as here.

It turned out that there's a real slowdown due to the outlined
slowpath. If I inline everything except for inserting the entry into
the cache (cacheit_lockit codepath is still outlined), the results
look much better even for the case where it always misses the cache.

[...]
> > diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/to=
ols/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> > index a043d8fefdac..9895087a9235 100644
> > --- a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> > +++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> > @@ -21,7 +21,7 @@ struct {
> >       __type(value, long);
> >   } map_b SEC(".maps");
> >
> > -SEC("fentry/bpf_local_storage_lookup")
> > +SEC("fentry/bpf_local_storage_lookup_slowpath")
>
> The selftest is trying to catch recursion. The change here cannot test th=
e same
> thing because the slowpath will never be hit in the test_progs.  I don't =
have a
> better idea for now also.

Trying to prepare a v2, and for the test, the only option I see is to
introduce a tracepoint ("bpf_local_storage_lookup"). If unused, should
be a no-op due to static branch.

Or can you suggest different functions to hook to for the recursion test?

Preferences?

