Return-Path: <linux-kselftest+bounces-37600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9399FB0ABC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 23:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A9E7AEF2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 21:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6D21FF4A;
	Fri, 18 Jul 2025 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DuMPprS9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834121C9F4
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875715; cv=none; b=ekb7xRZACe+4k5H1AsZHJThJ7eipLfTr27Y//msgT+qsWPNLUpK/z7mmOb3qbAbfQ82jl1Feo9gp4SqqTS21ACypGN5k7Jw5ByvPnkHMe1aZHnUP0WbVho7t0t3QNoKxSrj04N6zvqigEhC3C+hUDnWRU20Bacea1SSwN1nfI0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875715; c=relaxed/simple;
	bh=ltKlX/6V8eiGzqwSGoa5gPUbAJICZza9LmiBT1RB0UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hz1UgS8htqvuzqP5Fa6duVSW9iUUq6+FZWpR7w15sLN0AyS8S53IpKnhv7UOBO/Yb8ly5rqZvwybQMDo2iQ/pYtMzFTNAdUUf4oTRnMOhRVWx7BWET+OMKWOHv6BPlwZzZpUgzHGSxFSc9fU3GkWhSnSmn3eGeroakBc2IYG4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DuMPprS9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso664690966b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752875710; x=1753480510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=DuMPprS92WuM9jIL3aTI7f1x4H8SCac6kRDJWF9u1eEspz/FgxxHrgxjPqa+/QmTa/
         CvXh4bmpdQeYhAnh0jt2WUMMN8E56slg3HDcibn0IhhUbzQ4dIUO2/wCZSAVPPSt9pGK
         h7of0zU0DPGRTxQlpbKzA7ne+a5+CrKTZf1ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875710; x=1753480510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=pOtUEv1vnjjkf4+y5V9X+0GZVnNVBIBOYX70X8ZuUWhHI/VJv6YTkTaPae8aIKE1Rm
         LglmPmx16ujznZTencaojfKJ6zO38CINhdeHLR9uiE55A4DhHnbR/rqS8sJwViolVQws
         MsABt/8J6gTFYA622OeVwdsddE5kTAYuZcKyJXDAAEViVhSHhlFOmswGkgXBBQlmVVFF
         GWjtq7y64cVsU0C4sn3RR6+CiYiaKf/ucxMf+uQf6I1K69qXWYX+8qpvy3CkGsjaVpH8
         ugoqUxI/LuLZTVve2YCMwJelSeWmmoWpkDIQSNO7dvT5z0R5mB18pePy214hTqEXSB+6
         ezDA==
X-Forwarded-Encrypted: i=1; AJvYcCW2jo3lw2xXE9jfWWlLDSB5vxnQTo70h+OtAHH+2/i496fio7FnciM33Zx/CLTjPMzNXNpPsmC+nEYUZoVWjwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWgLNsZJqemgvjxVV5yOcDwBUjbIGv2dNz2xWLYnG/90bTazJ
	a+G0o4Fkr9UMzhiaPtGehZka79Gs02Jy7NPX+v12IqwK9wGHSPz7SocxafZ5omA3UdD4n/iv7X2
	R3k0DvjA=
X-Gm-Gg: ASbGncuBrVd8/6mvqFE9qmjVt1C8r61shYoAhFNMq2RqV+16IUA4NcJntcholTmoHNg
	+ioXwfpCok3vObay96/zg6oKUm/YWE2UIr7wU5wsjr4qJfJOgsQrfIIj0XZ6G/oS2N5OzsFFqLm
	+TMmQoA7+5VGmwa6O/mD3GYrOSVeQaZk5SaObRB4c+fW0lz5Z5uEFjVBKl5nbhSocYBOv+lDW6N
	bX1gFVBUS0Yqp8HOQcDGDqxEkQX5Wo0r2kn1LGEKNeeYXxNPBKL1A965mM8Kx5hTZnYru0E3duH
	J16FhKwJuVQ41FFB7T2+SorcssaFmHVLdJqGbKnISjk7AnOxxpTpKPtYngdN1qpdKIzLAfnPDNO
	/AnFxdEroO7nvhYdBZSAtSq0D6zOuqX5Wi8tYQSOC9lcoCq27YBGAkT8TNCZ7I9LTR2pYtpDx
X-Google-Smtp-Source: AGHT+IFEJIvfHK97RIFRsXaX4X1NngFLNTSvBT+vSyacN39BUz43YQ7oQX0Auho7I995KkLEDU10Ig==
X-Received: by 2002:a17:906:6a18:b0:ae2:3544:8121 with SMTP id a640c23a62f3a-aec4de005fbmr783090666b.9.1752875710323;
        Fri, 18 Jul 2025 14:55:10 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7bca4sm188370866b.107.2025.07.18.14.55.09
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:55:10 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so5566850a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 14:55:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwKIoExC/jbNwI/QVsm2V+6ZndoABTGOO/vm+Xex/LrOsWn/bFWqVftNOky9O53KD5b3t7zprwfQnY/lspOOQ=@vger.kernel.org
X-Received: by 2002:a05:6402:13c2:b0:60c:3ecd:5140 with SMTP id
 4fb4d7f45d1cf-612c0091a9amr4324302a12.0.1752875399525; Fri, 18 Jul 2025
 14:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
In-Reply-To: <20250718213252.2384177-5-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 14:49:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Gm-Features: Ac12FXwcle_QXTMWRdj0MWMkwuJCKrti8An2oscUa99HJ5SDjVBQa7FesoFMBkk
Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
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

On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
>
> -       __auto_type __pu_ptr = (ptr);                                   \
> +       auto __pu_ptr = (ptr);                                  \
>         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \

Side note: I think some coccinelle (or sed) script that replaces that
older form of

       typeof(x) Y = (typeof(x))(Z);

or

        typeof(Z) Y = Z;


with just

        auto Y = Z;

is also worthwhile at some point.

We have more of those, because that's the really traditional gcc way
to do things that predates __auto_type.

And the patterns are a bit more complicated, so they need care: not
all of the "typeof (x) Z = Y" patterns have the same type in the
assignment.

So it's not the universal case, but it's the _common_ case, I think.

For example, it's obviously the case in the above, where we use the
exact same "typeof" on both sides, but in other uaccess.h files we
also have patterns like

        __typeof__(*(ptr)) __x = (x); /* eval x once */
        __typeof__(ptr) __ptr = (ptr); /* eval ptr once */

where that *first* case very much needs to use that "__typeof__"
model, because 'x' typically does not necessarily have the same type
as '*(ptr)' (and we absolutely do not want to use a cast: we want
integer types to convert naturally, but we very much want warnings if
somebody were to mix types wrong).

But that second case obviously is exactly the "auto type" case, just
written using __typeof__.

               Linus

