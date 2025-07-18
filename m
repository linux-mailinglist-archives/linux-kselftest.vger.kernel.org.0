Return-Path: <linux-kselftest+bounces-37609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E590B0AC73
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 01:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00D43A2DDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E01DF75D;
	Fri, 18 Jul 2025 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BX13/PNQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EA7D098
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879996; cv=none; b=GllrvfVN4s86UGrg/axA5UOWeOgBsncOyA28H/eiAPnzGq163mjse6ASRVJOde/TUZu+MBS67WDH/OeHeXbOarnhQouPdNYTtx/aHIs27m9i7p4/wrbXOqY5Wl6ImrF7VdCuVE9NasONRxZvP/KbTlu0xIjNf6MMTT/zqva/V6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879996; c=relaxed/simple;
	bh=H40tep0Rv0U6gqMR0evT7Pj2Me2Gk77w4/2xIDdHb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0QSyVZbOdVNCe3oJ4ctgaW76pAEQ6QXJtRbIX9gckkJ2YTN3IQfoyhWTyY+W17QEZeZfCS7CCCOU/nIr9+9lfMqf87Ope6gONKLTRA5bjeX5nTSrKNXi5zFGF045VcHujRspmGzaYOUbu9YQFEN4S/CbfbLvWQTP9A+Yi7okbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BX13/PNQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adfb562266cso425602566b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752879993; x=1753484793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=BX13/PNQkWn5rJGVCuPYBUX6MSP4oWLa+NhBDqXCcE865S9EscwPPtIPwibldzRyfW
         01MNBhtc1ampiSvgJKn2SJ9LcGcNwLtEE0U+zmx9CEIpqpbcv2ABgEkQCDi+O7aqDN+k
         emIBqKacbgw3f91Rwx1/XcIvIIFd6tp4Rkk4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879993; x=1753484793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=ogRVxhSUOipSgrvZ02oY1l8A0pzd63CuqShPmZLKHOflufzD+8nnrUb5oaYGee0Pev
         3Md8ZpbIRuC/kpsoFcp9xjOZV++hKLTz6dmu7utiwPihgywRZQDLPfNlq8cs1nuAkKyc
         xJz57rnhTJsO+DwsuF6cTVYkqXGP/04WiI5w5u9+WLf/BQRXkqR8QgUrQx+uPq1QQaNY
         DUJAAIEHisz3nCzbRolJA8veg5R8oKrU2E0rrbmki0E+zwS78nmkTPoICVNx6FfQB7cS
         hNehA+juCTeKn7t8RimokQrOMH0lTqtjiOlo6u6mIDgP6ggaZPRCAmAJC7LL9B6E84G2
         ubyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8R33f6O/7pekS8HDoDk7UuSdz0pJGZRO8QnpRC+wvKs4maHOBDfXjwMAccZh+58GzIm7VdEVwBVguiKorjGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNKSA1LI3v+WweMCUAOmiT/tZ/p/Q8Kox/BBLPT/Frr1rlIi/
	X8h/Ro665MmrsSyQ1muIT/4J+a842rxshdedRA49ITjaV9DV5UJ+qV6UaS8UMyJ30mPcDYT0Enp
	39dwYQodiWQ==
X-Gm-Gg: ASbGncuQhsBEwiN0aCJXAlUo8YClZdwD7ACF84vquuiPNiOwp5PhunA02NtRe9TG8o9
	diMco0tGs2UTMLded8lSCtyE3ky9MUHlEejL0sAicvYeOmJjqpoPO81SSQ3H7963ETtcpDRM9qS
	jX2cTz4k8ntPHSOsm15TWlVJtF55kwd/HwUuFY9JfdTJEtNxZKTzXFYKaaLjFE3MBYY+yYb6erJ
	UcF0HY9V0TI1+QIPrHTCDMJZOWcJvJHW19Ngk9n2OI/qOZHiALtcoHKrMzAzYpJ1/X0x5ETzhHZ
	H5BylUKMOFAk2VNU1apwfq16uCbzCYVnBzC3JulqqCKS0oOtLsK1o0cndjJrmw+L4NOP+KrfbDp
	2TuUHpPgsx51ba+k5lice6glurWoiOTTIkQcGnGJRmTyEK4nefffwMedUhopXs9Ql9Tg06uth
X-Google-Smtp-Source: AGHT+IHcyZSICYTzt5acVYZ6IhaLc+yzHMKP7JTHlbn6pypCKPRVBcJzTcqcQY1vo5f9Eu1OMuIT2g==
X-Received: by 2002:a17:907:f1e5:b0:ae3:f294:2b3c with SMTP id a640c23a62f3a-ae9c9ac15ebmr1273770066b.28.1752879992707;
        Fri, 18 Jul 2025 16:06:32 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca3226asm197595566b.73.2025.07.18.16.06.32
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 16:06:32 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b45edf2303so2379807f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 16:06:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWudRh6A5t8vRab3xljylwixgNdv1kLaYdRi7s9+PtQj+99VWhn3ITFhn+gexrzPtLvAcmk2u59tj3CsczkcZQ=@vger.kernel.org
X-Received: by 2002:a05:6402:510f:b0:607:6097:2faa with SMTP id
 4fb4d7f45d1cf-61281ebe074mr11282976a12.8.1752879516873; Fri, 18 Jul 2025
 15:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com> <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
In-Reply-To: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:58:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
X-Gm-Features: Ac12FXzEvcUEKGC31NKbtJTOHrioow4MaXx8l9_sG1eUWxP_1nSQ3xv-ujuWcb8
Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 15:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And while looking at this, I think we have a similar mis-feature / bug
> on x86 too: the unsafe_put_user() macro does exactly that cast:
>
>   #define unsafe_put_user(x, ptr, label)  \
>         __put_user_size((__typeof__(*(ptr)))(x), ..
>
> and I think that cast is wrong.
>
> I wonder if it's actively hiding some issue with unsafe_put_user(), or
> if I'm just missing something.

... and I decided to try to look into it by just removing the cast.

And yes indeed, there's a reason for the cast - or at least it's
hiding problems:

arch/x86/kernel/signal_64.c:128:
        unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);

arch/x86/kernel/signal_64.c:188:
        unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);

arch/x86/kernel/signal_64.c:332:
        unsafe_put_user(restorer, (unsigned long __user
*)&frame->pretcode, Efault);

The one on line 188 at least makes some sense. The other ones are
literally hiding the fact that we explicitly cast things to the wrong
pointer.

I suspect it's just very old historical "we have been lazy and mixing
'unsigned long' and 'pointer value'" issues.

Oh well. None of these are actual *bugs*, they are more just ugly. And
the cast that is hiding this ugliness might be hiding other things.

Not worth the churn at least late in the release cycle, but one of
those "this might be worth cleaning up some day" issues.

              Linus

