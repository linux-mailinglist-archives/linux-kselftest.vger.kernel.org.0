Return-Path: <linux-kselftest+bounces-17324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF396E406
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D6C1F246DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42D81A2572;
	Thu,  5 Sep 2024 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxv3xHFf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855B1A2570;
	Thu,  5 Sep 2024 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567886; cv=none; b=dN1Ty88hEyX7C3RdyjVsmhHg52tirdyRrV4mweGe+SlM1vw2SeDG+S2vP2mvjBDzhQ9TpmBah+Y3Ks4AdjGJfNpTU7aRuS88vqeJK1pGDoHc6YLumzRTrpP9Xf/PN5/1REyX4mea2br2WVDG3d3K7kkkM8/Jnsm7Qg1Yno/XNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567886; c=relaxed/simple;
	bh=NGrGPC9AVmfunJ8pKBfuV1Bxb+MuSbLY2pWcUM2wSGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYb1aAoJGsjqfP53edR5/oCfaC88KQj0MDnsNuRDp1Cb7HB8pQwhC20fOsOuV5hZj+XpTGwq2O8OWAYc6ebueeANtHKwwtXe4Ph/u+epOUr1WiQ4W4njkBwzheSiDIHIujLgVUTAVQgWqn2HD2bQZevqNGG6/aXFGL+dAUUJDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxv3xHFf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so966339a91.1;
        Thu, 05 Sep 2024 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567884; x=1726172684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4pnjKyhCClrvRPv4sgZ/czxqPIQCouh8o4w6WwCf+E=;
        b=fxv3xHFfGiyiwlVmDhTYvS2LsGCaxh5Em7PKOh3KrlSBLz0NP5PPkys1+0khi7VsOD
         AAChy03/6kSA5Z6asg4N0bCmN2SVwQ+SA+3/i/gs6A4FjKqH++LkM/odJBmYs4ACjaF2
         tH3Jw1IF3Mh+sJVVqf5pJrp5I0ARyrqCiJlDm+veu1rLuNwYS/3ZCPMFoSybocKpHxk7
         UHWCs0yRI92uPYuIkOrLkRMkbNOyLyToJtrewlYTDooJivt4Xh4PJhFf/kQKwRAS+QBf
         hx5hxGqaVQ1nGoVbR/HvJFB99o3pI1S1PH5tLiGd0D/YLjGXyUplESJQW4nAp7Ks0RRU
         iIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567884; x=1726172684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4pnjKyhCClrvRPv4sgZ/czxqPIQCouh8o4w6WwCf+E=;
        b=nKGN/uhKmR+3a/NHMGv4q2Yh+Lb7WR/xBbqEYd6NMnfUv1kLfg320tYaowirpdHCe7
         hRu5lWkuN7eyYlBy/372gshbXBNAgV+E86wH41FrxMmVkb159py0QzCYQlMdnPSpHTRE
         1YHsLDGpXy6rmtgbZ3BHZiPFFxl1veY2IeXCaQiGSqr4/DrVNmdDFTWWqSkuBSkoV+cF
         RlzDEzmaZkk3z/oC7PlE2JiIhIEds97+HpBnIE4+F0UeKM8lwW0kDtwbalmbSrMl7Md7
         qa1PvFFalzDVZQABZoLZ//CvzV24zJ91wSMr/B4awvURKjn5RXcey60cuFC4AB7RdFg/
         7erA==
X-Forwarded-Encrypted: i=1; AJvYcCWRJ1YRiDfdB11ylBh72oCqEyMP9JaMLnEQYut1xHhJ5eMqyPQVKwJLWP5Pc3LPuFRekSk=@vger.kernel.org, AJvYcCXh7HCk/RxNQmS06LG6gYnAxF/9rJiOJKLoILj2nTtCXSCoII7R+BpH6LdWuhKP3HkVpcUJiDbZ2zKBfpeOyB6s@vger.kernel.org, AJvYcCXov13Ybg6Xa9IbkV9iziSJqKdXuh2j7ivw5KBsTG/KqMKjxnCLqamTe9UPDsgk4Xzf5XT44IeidZoVGvG4@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpsoxw+gx8jFS7F+B+aWFf2nvQjz/6440FJxW68Xu3tN+x2ud
	iDWENYOF0mRyBseU+CviVsKmXliKlTyCmb8KYWxrxDawo1NWColWg++xLBzcpXw9zgCfnuYEB3r
	QO12fRda21Xd7atvg8Xy4xFZcp4k=
X-Google-Smtp-Source: AGHT+IFaowFZoH0YDD5Pt3eVuHrWmY+KINCZryxJVws2NSDg8A8Teh1D20XPO+Kc8YrkA2CTKXroThwMfgJOetYAr9c=
X-Received: by 2002:a17:90a:8a15:b0:2d8:99c4:3cd9 with SMTP id
 98e67ed59e1d1-2dad4de1392mr593624a91.3.1725567884435; Thu, 05 Sep 2024
 13:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828121706.1721287-1-yikai.lin@vivo.com>
In-Reply-To: <20240828121706.1721287-1-yikai.lin@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Sep 2024 13:24:31 -0700
Message-ID: <CAEf4BzbfBQZqy2w4TiTBR9mi4AMQkWKk8Un8Lp21ELQBgsgcvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: Enable vmtest for
 cross-compile arm64 on x86_64 host, and fix some issues.
To: Lin Yikai <yikai.lin@vivo.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, terrelln@fb.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:17=E2=80=AFAM Lin Yikai <yikai.lin@vivo.com> wrot=
e:
>
> These two patch enable the use of "vmtest.sh" for cross-compile arm64 on =
x86_64 host.
> This is essential for utilizing BPF on Android (arm64),
> as the compilation server is running on Ubuntu (x86).
>
> Following previous guidance from V1, the two changes are as follow:
>
> V2:
> - patch 2:
>    - [1/2] In Makefile, use $(SRCARCH) to get target arch's uapi.
>            Therefore, there is no longer a need to compile "make headers_=
install".
>    - [2/2] Regard "LDLIBS +=3D -lzstd" as a separate patch for static com=
pile.
>
> v1:
>    Link: https://lore.kernel.org/bpf/20240827133959.1269178-1-yikai.lin@v=
ivo.com/
> - patch 2:
>    - [1/2] Update "vmtest.sh" for cross-compile arm64 on x86_64 host.
>    - [2/2] Fix cross-compile issue for some files and a static compile is=
sue for "-lzstd"
>
> Lin Yikai (2):
>   selftests/bpf: Enable vmtest for cross-compile arm64 on x86_64 host,
>     and fix some related issues.
>   selftests/bpf: fix static cross-compile error for liblstd.a linking.
>
>  tools/testing/selftests/bpf/Makefile   |  8 +++++-
>  tools/testing/selftests/bpf/README.rst | 11 +++++++-
>  tools/testing/selftests/bpf/vmtest.sh  | 37 +++++++++++++++++++++-----
>  3 files changed, 48 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>
>

Given that [0] series was just applied and it also has some bits that
address cross-compilation, can you please rebase and re-check what
sort of changes you still need on top of that?

  [0] https://lore.kernel.org/all/20240905081401.1894789-1-pulehui@huaweicl=
oud.com/

