Return-Path: <linux-kselftest+bounces-9137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30C8B7652
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAF61C22859
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9E6171648;
	Tue, 30 Apr 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxgB5xaA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436417109A;
	Tue, 30 Apr 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481595; cv=none; b=WZ1Yqrr2tl9NAyxZwcOkvY5ZVJpG2OfFP8Gr2KOqxr3noPctJTjcTLjZ0dT6/6kMdePtnWB+xN40Fnt6jqQmbZUU2VJpE9tHrdzJlfioJ3O4ZxMw/6crbt4s89EA+bVahdnLLb81glFRFOajEEylsjT1xd6M0NlAcQb+K7MVcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481595; c=relaxed/simple;
	bh=oWqL3ZY85KNjhD8aSZZTQArTMiUJ1o11X6J2QIlGdww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxaIvuU3fnlHOoBufTPJdDAXWd8D/XWgempR/VxL1kZ2T61k6mfNjj6j250Gc5YDW1at0ZRy1mQojKUTH4kdb9rIhHuZMIJm2hTuh84kaf+mPb+DaLL0adBF7iRslYP6lMqxF6iz8b9BCVCHoUYKRAja5hRsUOSarfymaGI+89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxgB5xaA; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-518a56cdc03so6347550e87.1;
        Tue, 30 Apr 2024 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481592; x=1715086392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWqL3ZY85KNjhD8aSZZTQArTMiUJ1o11X6J2QIlGdww=;
        b=MxgB5xaARnx7GEi6IaJBRF7aGUdBMLLCYoBLr1l0M6bL6tk6IVktY4wFGdaL0glY/4
         hZWn6s107pEqWiLzPIGErMmeSTxqhcZUGLsjvGxlu4RbfUN/URLu3u5alGYMBfeOANKc
         FDtrqUBuyl7WOaM1OjkDQp8IS+iUap+XLDJD1XOQM3xfQuhF/JhoVzwp8QmSYKCtGJIG
         sWrWdCij6DMBVhazmM6GLlfjfY5kPN/pBGEiaAZ76Jso8vt223Q4WCKpEkzuR6UG0Gmx
         FXbDkV2EmNa94rqul7/NMXoWhVKBMUYeaZuYjNwQdWmlX/Y5ME1M2l3DuojNSR8P++0V
         c0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481592; x=1715086392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWqL3ZY85KNjhD8aSZZTQArTMiUJ1o11X6J2QIlGdww=;
        b=oP5A51U6C++eDQ+DI8BgPyPY1Evw6dIywGBxJ6F3LBIDNrBEI6KgD/QlqM7XHUGwAM
         WTETcZBo0g6HxpT/Vy/8gH7doyPEAtvb3hoXybauFaO4c+J/yR4gNqvpKQZj3kwra+/h
         gWwQQ9NLwQT7BtC4B6WBWDfF6Wk8lizP40r6VcmWCLClRtzBJNrpgw+8XMo/4u/BtJjs
         9vdfGOqxjpxAVwL0zNxdzi9yzdorU8LzMtkhC4re+s4KqYF5vCJruNTe4gHT4q5JQAtS
         EvFwmjrD2zdIhVH6BZL7WfoX+WxsahorT+dAju4d5UOfvwtRT9yqhZ0qxlaiJraOIYvM
         XUrg==
X-Forwarded-Encrypted: i=1; AJvYcCUtfAk5OUKY/KSy6CIOySOeVwAOUlA0Zv6lipO038PG+h2CHS+YSGFuqbEa2ikDjAyPNZ/gdVXSRf2CZaS72DjOz871qdm1cpuDiRW6Sy2DtjTE5eQ5FN3ubkU7MsOTSlwH+jk3TBB3RVUlOHyhtGGjWIcpxPasLqNH+C/RFbkA0ldX
X-Gm-Message-State: AOJu0YyuHjfRwv5ENj+oZkiYvxj4yWjlle4p+iqyPFruNK2mdsNR0bSH
	sCa6QPKM99hq1tEJntQzhhGxBaI1/Zbkkc+/eMlko+nAEvuNfQjILhfhPHOAeKWW0wmcqG4JSB8
	V66ub3j3e6iyIDVhJjv2iYEfOzwM=
X-Google-Smtp-Source: AGHT+IEeNsmeI9uM1owNWyT0b3Zfvz+dHi/sMUsi0aBKdjayxoENcsgxyoEpXD/x/7tF4V10wXTofSlFpfxGo5KyeVY=
X-Received: by 2002:a19:9157:0:b0:516:d33a:7571 with SMTP id
 y23-20020a199157000000b00516d33a7571mr9167898lfj.8.1714481591989; Tue, 30 Apr
 2024 05:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org> <20240430-bpf-next-v3-2-27afe7f3b17c@kernel.org>
In-Reply-To: <20240430-bpf-next-v3-2-27afe7f3b17c@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 30 Apr 2024 14:52:35 +0200
Message-ID: <CAP01T76NyoYc4Y6k_ArbjfUn1tVjxSa0SpqVzEtM0h9jdRvgDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: do not walk twice the hash map on free
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
> If someone stores both a timer and a workqueue in a hash map, on free, we
> would walk it twice.
> Add a check in htab_free_malloced_timers_or_wq and free the timers
> and workqueues if they are present.
>
> Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---

I had forgotten how the extra_elems logic is working, turns out
everything is in the preallocated elems array and per-cpu extra_elems
stores the *pointer* to them for recycling without hitting the pcpu
allocator, so should be fine (just in case this confuses anyone else).

>
> changes in v3:
> - fix unloading of bpf_wq, again
>
> changes in v2:
> - fix wq being not freed (and static call not used)
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

