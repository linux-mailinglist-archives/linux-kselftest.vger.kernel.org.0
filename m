Return-Path: <linux-kselftest+bounces-9136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657018B75DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 14:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7194C1C21F94
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F217107F;
	Tue, 30 Apr 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msr+qTsQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6212D214;
	Tue, 30 Apr 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480692; cv=none; b=ayQF/uWzX75K8h2KFDvfuZlafOJdBVI12J9CF70TdwZB84m6VbucB9RrMG/kXYJaQcbtMCuASK1Llv/3G7X37knRzakQ6/8l65eRaUN5zkSTiBTnGaBDHKH2UZyr9dhceZ4LbTk3XzGAk5IZ0UYdebtPpl3u9ZzBoM69mLDFLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480692; c=relaxed/simple;
	bh=UxkGHkyOV2QivS5ID0u+KA+og8PhR5pbstf9U27sdBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxRQP8Er34s61Qf7/HbmVlZ/ThF/R2XDLTgcchVh8nfxSV8v872/aEY8M/q0UfFIbktG1YsRzWKtgAWnECn0CSsLULXNkOXKpAsr1pHKigC/Iw2SdKJbdIgEILBVVnBMgp3KFKLdNvf6snxGltJYjraaHBQEsPgy5ybrgun47Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msr+qTsQ; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a55bf737cecso667462966b.0;
        Tue, 30 Apr 2024 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714480689; x=1715085489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UxkGHkyOV2QivS5ID0u+KA+og8PhR5pbstf9U27sdBk=;
        b=msr+qTsQbSq2YbUnRrG3UixUxW0BILDkm5/M0fzbPXNcpnoz1RxWIdy5v2MjcemIap
         EsoB1DIiIa2IfQvw5Yejwg2RdtqC/kU4VQ2HFOm2mmnwPd4mUP9s+KMDJx1uOvG/6WHH
         P8ECnVlxjRq11BQAg7EgJJ39JOk7I+JnTHOXjfLBzHsVEF/DKBtvsLodQEyLN6kvPR+D
         ZZZm9GKoBjnsb2ROAAiHweknYJ7Ff+wcWxyzPnjLLFpa7Qy0o8XK75k6/hBrY7BavWgn
         Xa+WN1so4W4UTcl558L1QY0BvxjX/1ayG2c9es7JhfH64yiToNiuvi41YBihapxLq1bf
         k3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714480689; x=1715085489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxkGHkyOV2QivS5ID0u+KA+og8PhR5pbstf9U27sdBk=;
        b=xJB4mYyGVTqRkjCZjSNA6GZL/Bxu7HAolYiMK1WHGgF3YRuUn44Rh+zx5lBbTNHbQw
         XH+V6ebnYtiBnjMCVRVOqIbeuBAAzOloDE+6XJVERBe4OMcqSu/Ixk4gfGF4MZhKpNg4
         SVoou4GrsMC++YjrPAKQxKt28ZEnnHRdOlUx5NcsHIpFTKkgV5v/j0Pw3Sv0nVi3lHfj
         rwxhEGKmKV45q54EaVbwu+6XuRo49rcZ0VKka5JUQNZ5Nm6INnAYgxSpgOLmyPuvnfXi
         VbKrodXanYUSbJpWo/W+EybMGeQg0kU+vuHTYJeDbhiJ1dzzpQ5VqquAQ0ixwBhgViL6
         t4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWKacGA7AkoLIsiiHtrYyAaVFQ4l2E0deLvpvzNzc97e5p9iRZn/bfjSWonaK3tieUNx8UArszJjojqJxtL1BteBMX2lepg6QaA/cveVyuStdYx+8Z2kGidJMbT8LBmffMX2RaoByTO+kLnmSN+/E8ABVMjO/3uW6QUC5xxdtFoznQ6
X-Gm-Message-State: AOJu0Yw3Vnugf20/wF71mXqWAlR9+id9GAcUxqFG2MPHMjgLYGp+13Yk
	4Ce4CT/EchvwlYFygmocGcflB4p2LTFigATz8pBgDXpTCNCJo85fSeefi9VCZj6Jcn2iYa3GOiJ
	TEIJJ8Tbb1ROW4LrHuiQ6ZrN055E=
X-Google-Smtp-Source: AGHT+IH27RdWC5FSjhJY1OjL9ydhwSJgYHblvsxBFlka0WMmUZVYC+Xsw4NlWhQFVJQq1AKM2GpwEwM3xszNOJjFhnU=
X-Received: by 2002:a17:906:f292:b0:a55:90c8:774f with SMTP id
 gu18-20020a170906f29200b00a5590c8774fmr9271117ejb.16.1714480689062; Tue, 30
 Apr 2024 05:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org> <20240430-bpf-next-v3-3-27afe7f3b17c@kernel.org>
In-Reply-To: <20240430-bpf-next-v3-3-27afe7f3b17c@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 30 Apr 2024 14:37:32 +0200
Message-ID: <CAP01T74gBChGdVWXKWro_vJ_B5jwEtstUMx41U+y+wbXy8VBXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: drop an unused local variable
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 12:44, Benjamin Tissoires <bentiss@kernel.org> wrote:
>
> Some copy/paste leftover, this is never used
>
> Fixes: e3d9eac99afd ("selftests/bpf: wq: add bpf_wq_init() checks")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> no changes in v3
>
> no changes in v2
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

