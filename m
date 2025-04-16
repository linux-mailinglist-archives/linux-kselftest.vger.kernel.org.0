Return-Path: <linux-kselftest+bounces-30986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28736A90F2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 01:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FD919066AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3CD2475C3;
	Wed, 16 Apr 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw8p+6vc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8728E3F;
	Wed, 16 Apr 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744844938; cv=none; b=g8ri2cq2HtURU7pXK1vs4YLo9GBZoVVK0yZvYW9wEOg7ORYGwMkLi1gZQXNUzl8Hc8YsnWRT/lz89hYU03SOC2Y3vOKJiRWT1SqvmOS3XtW67kf3V7KASNrrduW+6hMDMCng0dGHoBGSKLOSJ40KiDocRQkiEhj2aJ2CLXYelAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744844938; c=relaxed/simple;
	bh=wd1IBgg6IH1wIFugFyWcIertHrlNLO32GnVoMQLkSk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPRXCBEi7+EEdt9s9KkWfvW6uCEesoZF10v73BzeQ0kiUkFiz4jzKZAbObraHecsvhlWcNeatwFQgKLRhRxdFnq0dImg8dUBfUP4eUb9bCfSZZreNMbEFwROQ7CPr/9uTXJ4Bu4r+WDN9WjWlH5R3KlAFzD8TciOnLro+iPvFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw8p+6vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DD3C4CEF5;
	Wed, 16 Apr 2025 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744844938;
	bh=wd1IBgg6IH1wIFugFyWcIertHrlNLO32GnVoMQLkSk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kw8p+6vclJXjKXxiCYPIes9gZX3alA8uhiel69rMMv+GIP+qz+uJTt5h1SgUpzzDE
	 o7An4BOKQClkv1yIYhAi7sVmo2XMblJ4q6wu7uE3ivEWi+CX6SIdvHdxB65DlPXQDk
	 VpqeY2ynSVg78TUJoOFWnTjb/xHq1MSbqpys2KKa5BU9NFBkPDDO2+zgdWkBHrmSaR
	 YlAMGVTKOx/QlJFLoqu18jznc1DGcxaMpbWo7UH4ubjKBKNeT7xBACZ3qnlTLskbq2
	 Q9GObPOGy0i2B+1WWaF02e8ZBLVsJUgZ+8nT7CU6jVtEClGJXJtkxQsH8ZdxBZ2EMW
	 xjo2xWeHH3SdA==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5e1b40f68so14203185a.1;
        Wed, 16 Apr 2025 16:08:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGd5oHw4QZfZp5snvqnm2fQlfLVzXuIGh8uTIdfCHdOPAGhxHGRvL7rZ4AlvbT90urvIEQwb+lDw7kOWJV@vger.kernel.org, AJvYcCVe2AuG0p0zt/h8ryQwBvaDmwQG76eWOaAF+Ozdy5rTFaaij3mWbnfyCLa0R6z4Sc76pqAjytUZHu6Lj34=@vger.kernel.org, AJvYcCW10WDFbCC5BjBXmdHHVJQUDRhRlK18FAPKW4mbHE9djcYcAoBZrzv1SYdH4JL5pI7ENb93YNgny2szVkYhk9fF@vger.kernel.org, AJvYcCXNftlYnvdjnVY2ApmdmgcGtG3dmlAsIi0CuIFwPItWGfXCjPT5KTFK5P5moQZ3y6EOLHE=@vger.kernel.org, AJvYcCXdZPr1G2LP0+U5/UvQ5sryzK7IK3doZOZOeg3EGQlnLFxM9IUYMtYdK8vPd+R8a2MtUMdtIl13GflS@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrh4G2eucfIcIJaXdiiJdweIJhDIdAwetkW36vu503PHzcR7v
	Bp9J1eVBn1enFCHxKqwDB9m0jreQYCkOkuX6VlE3152SZy6UXWGuGMHhWm0NzyWRwi9t9Js4igM
	mBvMU/PiPxjl8jmjSgCXGfAVC3pg=
X-Google-Smtp-Source: AGHT+IHWgsmg0r3kgSF5MEKuJ5L71ycj0wBS7HloLVITIcp/00ImA6inZqQ+8pwrlQqjny2Dy1k8gWo3S+omu6vD/NU=
X-Received: by 2002:a05:620a:2585:b0:7c7:a606:5983 with SMTP id
 af79cd13be357-7c918fce4bdmr546964585a.1.1744844937231; Wed, 16 Apr 2025
 16:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
 <CABdmKX0bgxZFYuvQvQPK0AnAHEE3FebY_eA1+Vo=ScH1MbfzMg@mail.gmail.com>
In-Reply-To: <CABdmKX0bgxZFYuvQvQPK0AnAHEE3FebY_eA1+Vo=ScH1MbfzMg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Apr 2025 16:08:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW72Q2--E9tQQY8xADghTV6bYy9vHpFQoCWNh0V_QBWafA@mail.gmail.com>
X-Gm-Features: ATxdqUGXvprakmHZkoWk7DGzVzqbToydQxzYVEiON_q8fHz2r4Qn3y9LJI3zuo8
Message-ID: <CAPhsuW72Q2--E9tQQY8xADghTV6bYy9vHpFQoCWNh0V_QBWafA@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:51=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
[...]
> >
> > IIUC, the iterator simply traverses elements in a linked list. I feel i=
t is
> > an overkill to implement a new BPF iterator for it.
>
> Like other BPF iterators such as kmem_cache_iter or task_iter.
> Cgroup_iter iterates trees instead of lists. This is iterating over
> kernel objects just like the docs say, "A BPF iterator is a type of
> BPF program that allows users to iterate over specific types of kernel
> objects". More complicated iteration should not be a requirement here.
>
> > Maybe we simply
> > use debugging tools like crash or drgn for this? The access with
> > these tools will not be protected by the mutex. But from my personal
> > experience, this is not a big issue for user space debugging tools.
>
> drgn is *way* too slow, and even if it weren't the dependencies for
> running it aren't available. crash needs debug symbols which also
> aren't available on user builds. This is not just for manual
> debugging, it's for reporting memory use in production. Or anything
> else someone might care to extract like attachment info or refcounts.

Could you please share more information about the use cases and
the time constraint here, and why drgn is too slow. Is most of the delay
comes from parsing DWARF? This is mostly for my curiosity, because
I have been thinking about using drgn to do some monitoring in
production.

Thanks,
Song

