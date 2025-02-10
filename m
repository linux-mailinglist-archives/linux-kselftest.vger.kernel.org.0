Return-Path: <linux-kselftest+bounces-26191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D39A2F329
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2552E18850BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EB42580EA;
	Mon, 10 Feb 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Spyl11ur"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5672580C8
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204512; cv=none; b=qWDlg4NBz7J62ZxS5f1iVJQTM/wX+oTdysr0F8V7KQo2fN86zcf+n+XYB240JfVUbJHdLqtpE1nv13yEm3QSXJ+yrnxZUtujab1HPbhUcjZZPqFxdR+7iTJeUlghV9uv1IBqpp8zePAUbcQqe2KZLy0SIWAlpgnwRCnfP+R8a40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204512; c=relaxed/simple;
	bh=KIqBkUSyhCVeVPELNP6ISV0HCnomhljLgtcM2pOAoUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1/bBYrLwqgWdG7cNSQNb78YXcSkHkr5IEL+kJXI7o+23ApQjZ+gbP/qJTKuOsUvtgOmVrnMUUqevUwt9el+BLxJ85dgXfGO6wTdj7h9J3dpb4KUF7UEHXl+B7ewb2D/muxPN6c45ULrPK92qVTMuzcSr1Inxo5SxDAiSHcwCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Spyl11ur; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de51a735acso5840653a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1739204509; x=1739809309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIqBkUSyhCVeVPELNP6ISV0HCnomhljLgtcM2pOAoUg=;
        b=Spyl11urk48vjBb63Eiqe68b5dQQq6kwPba4Aww0qcYBhgagSi0EPHuHxnciOeTC5L
         dzooTKDnsUyYYh04/vSp/9RjLK5ptplUHlvc+v5uctevsHfuinmlIkmnkD/uak4Elcjr
         3oKPGFa2R4bt6cs033p786DCzVIJnM+JZfvSOG+GBBh+m1nG3bmNzGTSkw4H8fNDPg4n
         61D42Wcxw4QV+x6/KEnodlLdXVtU3uv+8usJlMntfuUhdHBaXlKTL9d3YmYaHN/LTkJB
         qUwuWRi6kEg5mJcxYBfvaVKsiUs5QYm+ckWfotS+yGiiQzUG1pF0c7EiqraFGyL/KPU5
         0aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204509; x=1739809309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIqBkUSyhCVeVPELNP6ISV0HCnomhljLgtcM2pOAoUg=;
        b=NO+gXh1bO9K7I01hJQOACEMkKUtOZC1omJ2rRKl2uJELAX4z8Cfjy9vCImI5F2rnYp
         9z0ztzAeYh78ZrWT90bS+qfMRPri/WBjZHdcvYpiF3g4J/Ybk0Jx5/W3Ly/I3nxe+Cn2
         1QGJ+kTQ+aiECDkUmxfWTfxZ5zkV0S+mnUjgUU1+oczJnEhKZuQ8wQbV1Ffe2opypvLX
         Goj/PNGOREZYwRgABkXmjBys1W/v9lHnIjJRua7Es6QeOGmNXVt6+8NU3VRhzyRZAUeH
         1qUNftgDVNuem5pmfkGE/HDTA+dJmQbyhB8LiF/hzFsBrulRuWr8XlqytJskwoXrorty
         qVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU+ACddxDlDoi3Ap2IthT2aD5ahw03LmGt1c1OE7qOt8dGIvPpXXG4ukQGMu05/xtB257ecbesKVQBD2eG4m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAkVtraxlWtk+MqZHjR+EJ9u8U8mwrsNpVRioMK50QgRs4Ely
	9qPc8rY78A2a9xhgTFNW4JSPpkDhHFpgrWJZ5dDMtxPM0ntfUv0iro6jX/Tt5rZ0+vDwU1ZyQzD
	8T0F/wfz24Qd3FrRtMYN+Rk7hH5geHxKYBsF0ig==
X-Gm-Gg: ASbGncvnR3A+85HDEpw08odPLyr98Ke2REhugk8VP3SovYZTliMyv9bVWAMfrkMgl/P
	bvAVRx7L/zsy6FmOjrSIFjU+enbjFzFg5k7ILk+a3JCzaeJkpWnyHEiKFImohTDEo62ruLmx+8L
	RiyiLLxW6sF1a7GGg=
X-Google-Smtp-Source: AGHT+IHy71NYgSP/cCvRFmJ3G6I8GQkkK8vW2MV7RYTmiEkeOtYPIG8dZEldxTbMHipBtrY+5n8UQFrBgYq2RkcMjZw=
X-Received: by 2002:a05:6402:13c5:b0:5db:e7eb:1b4a with SMTP id
 4fb4d7f45d1cf-5de45005a3bmr15164299a12.10.1739204509076; Mon, 10 Feb 2025
 08:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739171594.git.yan@cloudflare.com> <85618439eea75930630685c467ccefeac0942e2b.1739171594.git.yan@cloudflare.com>
 <Z6nEsGSbWqCSaVp3@krava> <CAMzD94QZQjpwOA8Os3khG32d2zgH8i=Sy1VoudRCGqZudyHkag@mail.gmail.com>
In-Reply-To: <CAMzD94QZQjpwOA8Os3khG32d2zgH8i=Sy1VoudRCGqZudyHkag@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 10 Feb 2025 10:21:38 -0600
X-Gm-Features: AWEUYZlnLuiCJjRJtIJZwpaZNOpATxR3bl3tZuwbBXDssS0d0dx6XXBf-mXpTzk
Message-ID: <CAO3-Pbqa_oOm-u318mTwqPfuRJ2_kdk+ou99BOu53A3O_wEyZg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: skip non exist keys in generic_map_lookup_batch
To: Brian Vazquez <brianvv@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, 
	Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian, Jiri

thanks for the comments.

On Mon, Feb 10, 2025 at 8:47=E2=80=AFAM Brian Vazquez <brianvv@google.com> =
wrote:
>
> On Mon, Feb 10, 2025 at 4:19=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Sun, Feb 09, 2025 at 11:22:35PM -0800, Yan Zhai wrote:
> > > The generic_map_lookup_batch currently returns EINTR if it fails with
> > > ENOENT and retries several times on bpf_map_copy_value. The next batc=
h
> > > would start from the same location, presuming it's a transient issue.
> > > This is incorrect if a map can actually have "holes", i.e.
> > > "get_next_key" can return a key that does not point to a valid value.=
 At
> > > least the array of maps type may contain such holes legitly. Right no=
w
> > > these holes show up, generic batch lookup cannot proceed any more. It
> > > will always fail with EINTR errors.
> > >
> > > Rather, do not retry in generic_map_lookup_batch. If it finds a non
> > > existing element, skip to the next key. This simple solution comes wi=
th
> > > a price that transient errors may not be recovered, and the iteration
> > > might cycle back to the first key under parallel deletion. For exampl=
e,
> >
> > probably stupid question, but why not keep the retry logic and when
> > it fails then instead of returning EINTR just jump to the next key
> >
> > jirka
>
> +1, keeping the retry logic but moving to the next key on error sounds
> like a sensible approach.
>
I made the trade off since retry would consistently fail for the array
of maps, so it is merely wasting cycles to ever do so. It is already
pretty slow to read these maps today from userspace (for us we read
them for accounting/monitoring purposes), so it is nice to save a few
cycles especially for sparse maps. E.g. We use inner maps to store
protocol specific actions in an array of maps with 256 slots, but
usually only a few common protocols like TCP/UDP/ICMP are populated,
leaving most "holes". On the other hand, I personally feel it is
really "fragile" if users rely heavily on this logic to survive
concurrent lookup and deletion. Would it make more sense to provide
concurrency guarantee with map specific ops like hash map?

best
Yan

