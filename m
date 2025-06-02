Return-Path: <linux-kselftest+bounces-34172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399F5ACBC45
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 22:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71791189299F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 20:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A706210184;
	Mon,  2 Jun 2025 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIzoSI9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C41C1F02
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896001; cv=none; b=jn/V9QH6r6zDPI7DmY9CF8LcfrdE1mYDWQlslCvuSGJOyE3GJT5/8dBCSxxZM4sA/UBoAwqIQ9i5/FG/5gWB2s5EbDTsIGlwHv7RnDHjpXfD8PgAVo08wM9p7V+/oWLlIN7vpTjyi/FfpyUG4UI2n7odCzMYie9ZSh8W2v40Spg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896001; c=relaxed/simple;
	bh=yy6FlNOUYO7QcVohlDl63YNljgD7fgJqb1/vYLpHNbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASeLdkN/kl6CKB46pCBa8ICacIf+Z9NLYyApbvU0keoPt3blU4Ho0Nll5w/VjINQGmIK3u2yYtFTjWW76j52guOJv47C1v+hJcSbTLm6f3s6YIgIDem6fuecKhmz2EMFzE7ZSqtKVX/lXqxXEjQlLGvYEGh64UfIIOJlaWSt8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIzoSI9a; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-87e37ab3c70so2434413241.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748895999; x=1749500799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy6FlNOUYO7QcVohlDl63YNljgD7fgJqb1/vYLpHNbc=;
        b=SIzoSI9arx77Bd5NUipcjN+TBznDBDve/hCpg/rxAQnhlnxXpx/v6apG8NA30CWk5a
         UiIwg2pDXu1dn7n/hKB038zMr2J0vFBsn8ZhvlYc2RBZcsOIXfhWMsLGjtTLqBGu5qgZ
         DkHjOITZOpFnXgFGk2C8QrSIt7XgNTHqQVfyP8dbyxnF8ujDQvN4dJMLKXyHMd2p59Xx
         5p+tPNYNPABIvS6BaiJnsHWP35mGY1kChB9Rp0vhUBLjZt+RhlaJ3gXBuBnyVY4DYtaj
         wNp4Sv3Zh/OWSxvpyj+3tgtSHqFESc6imAUtkyz51vfSOhcMhiQuMnhXSQQeASYLQctK
         KDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748895999; x=1749500799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy6FlNOUYO7QcVohlDl63YNljgD7fgJqb1/vYLpHNbc=;
        b=frSDt7gJlGEs/EoDXuaek7yxYPnx3Mt5qZSVAHD5m8+hVOIyqYfibp1VXw1n00Ep5h
         h76OSM56Bi/yG7YVLeFXJ8VFh7dwdc5SD7I8D54tdIV4ChZNHq2dNojhj5tqjbyax56J
         jUtfvLMP/74BUSOKSoQQ0wj7SGS8MHJTzAmNp784bUl65vATPbIzziZ4qI1ZAELHicYZ
         oZQu+Ik+/VYnqQENYPTtHRlZIO/YElrVctvduU+79w0XRVSRbyCsiW8jXNsVkJrNPEpM
         kFTt8hlThFepHyqe5uPhJNwvq5KulMtWPj2YwnmACbVIiecIrwBmUzT+R8kKCnarRpgY
         83pg==
X-Forwarded-Encrypted: i=1; AJvYcCVuZqx8oT9h5tzvRlQcUJV2ksgdZ3ttVueiytwbe8jmHVPuiFy/Q8fh1Oq6lyeaor8Nm8pjVQ8b3BGSOpKW/7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7p0J7u3/B2LlSgaxwhQB1042PJl+f1n1X2ztXPhuMoRfttQ9o
	POTuqbBNq4vZHhdTzJxX0hL+82KGJp/Cpk+HRVhCJyVi4zbb9g/PJgURck578Ls/jVhvMTopNKw
	LfnfnjjNC4lPURIbhc51xPk8wgjOYJMdDv0apneFf
X-Gm-Gg: ASbGncspLvv8kYk03eYHQiWYv6m4num2i3EZd1J+hB2juxOXZ36rcup3MCcvJtE1ia3
	uGXV/Zzz542EXxxS1EbI6FBPtVIzrOp9uq3bZFZjQrNA9fWni/FLKw3coNlXv4mel2iZc/KF7OH
	BkqRSWPnOX2ipdqWm7f/bQnlBfFMZIpw0CNUvnzOR/N4o=
X-Google-Smtp-Source: AGHT+IGWzCL964d3NZSve0TxcZHhGFSpPRKvBMtmB7owRY1nMGw6YLoDv2x/qshMKaW9Ilmep03btfWt0apKbdl0NnU=
X-Received: by 2002:a67:c996:0:b0:4e5:8d83:c50e with SMTP id
 ada2fe7eead31-4e7323d69camr1055701137.10.1748895998531; Mon, 02 Jun 2025
 13:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531072031.2263491-1-blakejones@google.com>
 <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com>
 <CAP-5=fWADfh9WNXgUOhXYW5hZWk-FZL1oJTdaDgq8Hqr8_Fd0g@mail.gmail.com> <CAADnVQKeJUdvJ7tKhpdatL-A5zDi9DXKFun8fwM2e7Bynd5FDg@mail.gmail.com>
In-Reply-To: <CAADnVQKeJUdvJ7tKhpdatL-A5zDi9DXKFun8fwM2e7Bynd5FDg@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Mon, 2 Jun 2025 13:26:27 -0700
X-Gm-Features: AX0GCFsv3gLe9smTQKIVsHtNCsx9xZ7FvMOlC239kYUGSq4OKs22Zv_ih_8j8Os
Message-ID: <CAP_z_CheNtGsrC0Rfuj=uPZUBjjNU2+3Hp4uXHmeMnfPhyMk7g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support for printing BTF character arrays as strings
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 11:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > If no suitable libbpf is detected then the build will error out. I
> > guess if feature-libbpf is present but not feature-libbpf-strings then
> > we'll need a perf #define so that the string feature won't cause
> > perf's build to fail.
>
> Yes. Something like this.
> It will also allow libbpf and perf patches to land in parallel.

Ah, so I could test the perf changes using this libbpf, even though
it wouldn't be present in the same source tree until they're merged?
That's great - if I have to do a bit more work to reduce the overall
merge latency I'm happy to do that.

Blake

