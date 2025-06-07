Return-Path: <linux-kselftest+bounces-34433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1EFAD0E45
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jun 2025 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4F87A5990
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jun 2025 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11E1DB551;
	Sat,  7 Jun 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdjpQFn+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB87184F;
	Sat,  7 Jun 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311683; cv=none; b=EUpX/RWzeOirY83/CVbAlQgmF//io5sGnPIVhZaLxIkAX9olrPQ8J45xBoo1GRjdr+XKyphN4SIroJg7Fhdimds1sNyhZMIEDvntASJkYJiKajZjx05ckiySLAnghU8N0McjcjVamjwvI0NbeTIANGbo/AkJXeEf07b7zwOZt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311683; c=relaxed/simple;
	bh=zfykvpMngPxERXvgbmGh1aOInPV3P9Tuipgcpog/1Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEjjoQs3Vqlg1RqKhbdxNyyJjeWmxMdUCvrGZaGKvdhTXdFSrkslCPUW4EAnuZHfeUbY1/mJLafdQOn+w/AXkZuvfY2ikwWSafyuQpmn7oiOaRjqztLJYseNOUwfUmz7W62Q0T+InC7j9CPHyc1u5junK/Mi88XQcQmBOgbZl88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdjpQFn+; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60d63174f05so775028eaf.0;
        Sat, 07 Jun 2025 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749311681; x=1749916481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zfykvpMngPxERXvgbmGh1aOInPV3P9Tuipgcpog/1Ag=;
        b=SdjpQFn+5OqtKApN76/HOG6LnW8UisrAZFdFnRb774fzxwthXYTFJVBcuQsve8HIQE
         /LNhGie/KZHQlBS0Cx1YY/7nV51csVOtAv+oX8TTZxdJy6iIWpY68qXImoU6RcTK9P5i
         +c1s2wpSH9Dhoz1jHTH02McYZ+t6+7M55jffvkKkQ9ejWUsg0wELe3s8t5W6ZPnukeZc
         MFDRAAkekA/0QOqMt9lnUog2RMNvd+eYExsEY1P8KufeHUEGKfXHNiAaKJZvpgEbth4k
         wbaI6d//o8cJHyFoJro+Jb1Lf1mNdQUvI2ANs9yRTXhK05VSds230e8aqEi6yvspLYh8
         5l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749311681; x=1749916481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfykvpMngPxERXvgbmGh1aOInPV3P9Tuipgcpog/1Ag=;
        b=DqkOmRCkAEH+sruN8EO+C9YPfikz3Ks/Hh6cjpukvnUBnLXcpb+ElKr9yjkVSQzIIP
         K9vD5z16aqn0XLpzPB9coyQ4qMVxmXq9oupsYop+P68gwA4VAO9vKsCVo+beudZHTTbO
         7qfa1jAuIgtrDZNf6HydONHSuSv5ISnIBs2YdeOC0QqURoVYvKmF/G47xhbtVVN+/fEm
         LkEBAfp9JkVF062azItnjyOOSWn1Ame7NgttZrJqSCztfAqFp5tXas8k4m0lYVpPFYhZ
         sP3NGk0CzDKrtDogahx6/wuHHHfh/AJZcB00HbsXeR+Nr7JeugFty+fkuTTM8qc4kDt3
         Hg4A==
X-Forwarded-Encrypted: i=1; AJvYcCUA87UOmWSp6UFtau7KZITj2iiEna75JAFTsEm8LzVF9IrCpD/NC1TPo94b3ToHHP5ONC0=@vger.kernel.org, AJvYcCV+ictDOJ945LYX3T5+op0F8ACFJWijGpRmjWN+W3FlO+DhL+a8QQrGtjVQE0LS3Tc6oTMrQIY+J9LFigNx4RrU@vger.kernel.org, AJvYcCVBXVveo2H82wbL7kjs4r6r4wlM+B6vL7H0fYeUdhHNEm7COKfpCpwdzzuuZGMLemdGQNbcGgDdAYi5FG/c@vger.kernel.org
X-Gm-Message-State: AOJu0YyraYJHXCG/kSGPxyf7dQ9BdY67xkIDlcBK2lB7rm07lrT8ZD9h
	J9IvCfBwMubVZh23J5Y4djvd7DVVqSiBTgvOtbEjPtXh6nt+YK+iTuq8KoZAtqnhyMN680IjjHv
	spBDsQDP9pWlOutN8ZHL/VzRBXnW/4lk=
X-Gm-Gg: ASbGnctqw/OS+HcfanGxEbDJXL9w8ZB0cqGDwpX/G/0NhsCAJEw9iXR7eetNMji2NP4
	b5MT1Hzf1ysJKvT193qoCAcBdNN7lg0m9fsQ6O5FgFgmJtRHBndtLFjOjRLgoGoylwxWxA0N4iv
	iyDU6z37cEiVzwLgpJVDrjKXsMKXEo/o3J0Q==
X-Google-Smtp-Source: AGHT+IFnKp0VXJf/rBSao1U7G6SxKZTqlBJPeVgihuYwzNmmCKlMEaU4PqJ3xlR/v4BEjO/tqUS7sZk3fPyWXYsVLUw=
X-Received: by 2002:a05:6820:c94:b0:60b:d6f1:7c50 with SMTP id
 006d021491bc7-60f3cb5abeemr4799443eaf.0.1749311680696; Sat, 07 Jun 2025
 08:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603052805.13042-1-suchitkarunakaran@gmail.com> <CAADnVQLUpRqP73gJ4+PM57jofFp-jPU_xj4eKwMT6mpeKxMu0Q@mail.gmail.com>
In-Reply-To: <CAADnVQLUpRqP73gJ4+PM57jofFp-jPU_xj4eKwMT6mpeKxMu0Q@mail.gmail.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Sat, 7 Jun 2025 21:24:29 +0530
X-Gm-Features: AX0GCFvWxEmGFaNj_7Yaqix-OUEbNf9vC3401pxQLWXjIWJKe1XXL4ppRt2k_wY
Message-ID: <CAO9wTFgxO8XxhFRQoSTSCcYGhLFRLX6VNrjYj-Z4VNBypMd0hQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Validate UDP length in cls_redirect test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> I don't quite see the point.
> This is a test prog. It's not supposed to be used as production code.

It was marked as a TODO and so I sent a patch for it. I'm sorry I
didn't think of the practical implications of it.

