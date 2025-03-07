Return-Path: <linux-kselftest+bounces-28529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB1A57513
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 23:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE213ACADF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FEF20CCCD;
	Fri,  7 Mar 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDJSpLdT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF7DDA9;
	Fri,  7 Mar 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387523; cv=none; b=mbYBW9E711zVqXQ0ZvbKfPwNCiyfBR6ECAHD1ScE5O1jR+dUR+I7uf71pwh9eu70wraVuF+6t4849U0WMHaung16xhkiR2oBreRf/nJsgxDw8TWx9Gpl8rBv30T3XX9UKcra8IkQVmMMxAFy0q3BjHHJI2wJawjn8lak2ZLIu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387523; c=relaxed/simple;
	bh=Ful7Xk9ON6JvRTEWnKd81ebh+6gixMHYgI/y3neZVJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fg4dNJPe8Y+6gDfMC+HW/jhbj/dltAxp0selHiKr3zxOIu+J4G5s1KsZb6dUIfWvwYjpo+/cG0iI7xU/CXJqPv6JLEM9o6Wf3Pp1x92lR+n6KNjXGlPMHFReWFTwryE90W568yyqmB98URhpmyw0C0LEg42mRlCKfoJiWlRph4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDJSpLdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6EBC4CEED;
	Fri,  7 Mar 2025 22:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741387523;
	bh=Ful7Xk9ON6JvRTEWnKd81ebh+6gixMHYgI/y3neZVJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WDJSpLdTK85mkaBkHJB/tS+E3xIPP1diutegZlIRAiwDDQZL8UQqoOH+jhEJGCnsO
	 szrsjFDO4UJXvzV+plwCMVFKrGoevD2IF+HAgDljSpKHAznPB8DQ6UALamFSYvkbDg
	 gSqm4Myg1o+NNPwnnWnZ+6gl02pDHOkm5++lHyOvIvFFSIL9xoE1YG+9ei5mCGrU+8
	 GgYRRvMGPeZf4bYZG6S50NVb4JJ9vLNYE5W7Ydlu7o81BjDy0mLEFCFPoSl2HcRafZ
	 /yTqmmZK1MoXPxBs9qRvRFkQkkLuNi6w4lDSqcXsJpLhtu0gtgJcyM2S9NsGujosLQ
	 CPe7VKxVLphdg==
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d3db3b68a7so17266835ab.0;
        Fri, 07 Mar 2025 14:45:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/wFZQd1Y5JKLghCNgjCUoyxUbn1lxmZNK8kGFgzwoM1CoOlTjVH0sj1nQsdXQtngIcfzMky9DWA==@vger.kernel.org, AJvYcCX2mt0F/Y5CXK6t+x73X59+uC++55Rf+kOeu6/Db4UKVXOwgLb4Ylu3JNiGSO11iIjDOSgwVJGcoMH3YBrBfQoq@vger.kernel.org, AJvYcCX3QnZ8rB9jqS1fi+A40TfKILPYd1q9KnCHEMIUq0v+8wcWNvWbg6MgY1eVVORwb9p1Bfw=@vger.kernel.org, AJvYcCX9GqfVb7sibvWmjDLZpP23JrAHEfqLNx/LcmmOpPXI/qdCVBQF3NfNr1VD5HfuXD3ITgAbCrAlQxhbw8ml@vger.kernel.org, AJvYcCXeWdobcCsHOEiyKqhpoFDnsmU62im2T2ClRyJ/5SHOSl70J8rV1FkjKDrcntXH9blg8WtfSvsiBm9cMvgr5mqvw6RCCswd@vger.kernel.org
X-Gm-Message-State: AOJu0YxTftgiFZ052pz980h6VeSWZIHlTQXxH0MfadHAwxFxI7cupnKI
	G4hF4sWNzSYC+HkTNXr+UH2Q1XJZKOA46RhH/4mLWnRInxnMhOQk2avWd0cZXmLrclciFtimI/E
	clfK3h3YwRlSq0QMl6spSps/h6qk=
X-Google-Smtp-Source: AGHT+IFPSXq8oE+oeK2IlApThT9gAy+0EcD7wEODYAQsYr0R2Gfgj0CuHAUa3hGM8rZ5/GgWtkKoS+/i+bjtpfeqa/4=
X-Received: by 2002:a05:6e02:1706:b0:3d3:fdcc:8fb0 with SMTP id
 e9e14a558f8ab-3d44196231bmr61099765ab.20.1741387522337; Fri, 07 Mar 2025
 14:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307213651.3065714-1-bboscaccy@linux.microsoft.com> <20250307213651.3065714-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250307213651.3065714-3-bboscaccy@linux.microsoft.com>
From: Song Liu <song@kernel.org>
Date: Fri, 7 Mar 2025 14:45:11 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7CROcbRnj1OseFHRe+uDDAXDen9yVO8XEDGQGD62FROA@mail.gmail.com>
X-Gm-Features: AQ5f1JoIPeC4HN2stfzX4jC8DCg96aMml6rnNdGlEyOhaaEPvpNw18yoMhlGmRU
Message-ID: <CAPhsuW7CROcbRnj1OseFHRe+uDDAXDen9yVO8XEDGQGD62FROA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/2] selftests/bpf: Add a kernel flag test for
 LSM bpf hook
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xu Kuohai <xukuohai@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:37=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This test exercises the kernel flag added to security_bpf by
> effectively blocking light-skeletons from loading while allowing
> normal skeletons to function as-is. Since this should work with any
> arbitrary BPF program, an existing program from LSKELS_EXTRA was
> used as a test payload.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

This test is failing in CI, for example:

https://github.com/kernel-patches/bpf/actions/runs/13729932033/job/38405051=
864

Thanks,
Song

