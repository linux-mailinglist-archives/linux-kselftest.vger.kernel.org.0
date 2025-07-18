Return-Path: <linux-kselftest+bounces-37608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15BB0AC5C
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 00:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4225567645
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 22:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BD221CC5A;
	Fri, 18 Jul 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q+NoIop9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4401799F
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879269; cv=none; b=nccEzSc15KPK+/65TnFDvuo7hwPJrQFW0DUkmyLtKsg88lOa0RgkmTyOJsVrVntl8mP1yPI7iGNPXI9Vok1Z3eFDDjDsnqXVIRhWZ1LDIhTc2XUbTscD9EC6u3LyckAchw9w7Eo/GJw3KG7CX4Ho90cH3QvNfUNZbK+sYglDV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879269; c=relaxed/simple;
	bh=qo67utYF/ovAn2X4y/cKDIWgVFy2L9OSLb/CZy1qQmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7ptmtGChhqYhhD04/eWSWZVbKL3jQb8GKNr+mB2bAGNK18ElrUbVD3lYJFSwBJSp4FcKwM40Z16B/czjOWVusy/mUvIsZ5KYebWBcmQw8VDWXbGJsRrjfFN8JBU5gBC9T5nAaGL3THXi2qcQRRspyw0C9JQ3IrkezfWJ1LXAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q+NoIop9; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32f1df58f21so26546371fa.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752879265; x=1753484065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=Q+NoIop9E4ou3xNqtTYpyFp9sSMjfEC35GGDi9+NEoEIeW+tH+LVRQqhCaA7pce+vg
         8ujkhIoeWS2Jct/rOPGUJ0NQlQf948iiwu8iDv7Qw4lTg/I9pN7YIwvg06VZhjd/hT24
         cGFiQk+cA6Az5eaIRkTK96n6IEskFrvpj1YsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879265; x=1753484065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=r4Fy+9cytZ0NYKnHIvV1peclWckYuVM6z8Nw1HgsZ2991MI5ob+02t5XsGRl642UL1
         xlnPG2OuQJNrhA8WWvV7LQILf2RjB7uQyDQtOSVFb30pgMh+5pSAma4cNRfq05VuiYSU
         BxMQxRpLeRfFkkx2o+6si7PW7RlvPIar4g/63LuC1bRcIRjcSk8U3Y5NXmNDrGjxQVom
         Pw7vO0vpJhSoy6+PN+HWSXA+wUa1DaN+uy0swoRvBL97WWnxKdnu5kjR4KVmvla1x6hn
         kCtZbpBoquis/9Z5ICKBUE9r0/IBrpXnyvuYCDEd2rcP+EtptUeI8HO7/qemCr+eQmo1
         y2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCX/3wsC7EXKHuMx/OjDE8HAV1qJAizKvd/uBAo7yedHkKiFF2DpKfUvS2yqnMAK2H7Cpy7pyuHNooiGQ8paOYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTuY1bwTL/rtW/WRTCgRVM6iQMGk5JI8ZISWczChsm7eKYpc+
	rz6sVG+aXJ+YjdiNolyxy+qDgbNMbO/L15jSDT1j5Q3qN32aY4OyzI5vBWEkPYIjWWCtIUfknBf
	nsWVoc8W+Lw==
X-Gm-Gg: ASbGncttnDtC+QglJdNeM3yh8I7z7D2dff5po3wI108i9PJkGGW/zL72sXmcdM5kBQj
	CW6TrjIMjbu1mqVqALy6MVZA8dojdYJtYZOWD7Si5h/XPeFYNfqmDzEjTlez5MvsSj8YbljhDyu
	oFsaoJckbiVTyjevDrFgRbx3dxOLnch8Dt8z82aXMaEUFCHJa6bPAM8HhRK++rh5nEfDxuXMOIE
	rsl3F0JulR6QK7mY5P/vd+FniNSihrl9BHFlrP1aGJUpUFksGvF3YPIZbugNuaUYkvomeLlrawQ
	oM/2af7v8iOI4lFeQ5RFMDezv7+l/NVxy4qxwKOIRx4V8BJuyEg4iDZPe02Zu0faS7uwUjyExWH
	WxPT7cC2kdx7a1wvN0MOq7jkNJ1kWrZNBGYxdKo5F95G1RawOrbQQiyIEvEVQDcrTrhBbAf8F
X-Google-Smtp-Source: AGHT+IEmtGVrglqAZs/rxU3W/nm+/BTsg9HtmwmC5jJeemgxQ6i3RmrbkSdW52DVSN0y2944q7fzbQ==
X-Received: by 2002:a05:651c:1109:20b0:30b:ba06:b6f9 with SMTP id 38308e7fff4ca-3308f5e1ebemr30504061fa.26.1752879264674;
        Fri, 18 Jul 2025 15:54:24 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a90d4ffasm3494291fa.6.2025.07.18.15.54.23
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:54:23 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55502821bd2so3249681e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 15:54:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMyy2b5HFowsttg/iw0VzSBwTPYgEf6AzmTM+cI5OwXdNbYFNut01zua0pGyHbUKPHgUzmbEI4wkOO+AoZQt8=@vger.kernel.org
X-Received: by 2002:a05:6402:84d:b0:60c:3f77:3f44 with SMTP id
 4fb4d7f45d1cf-61285ba5366mr11281504a12.17.1752878941898; Fri, 18 Jul 2025
 15:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:48:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
X-Gm-Features: Ac12FXwPQm0wFuMqO4T5e7rkg71dcrU60Bx64WOT68AUbiGf34w2BtStF_AEh5c
Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
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

On Fri, 18 Jul 2025 at 14:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > -       __auto_type __pu_ptr = (ptr);                                   \
> > +       auto __pu_ptr = (ptr);                                  \
> >         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \
>
> But that second case obviously is exactly the "auto type" case, just
> written using __typeof__.

Actually, looking at it, I actually think the NIOS2 header is a bit
buggy here, exactly because it should *not* have that cast to force
the types the same.

It's the exact same situation that on x86 is inside
do_put_user_call(), and on x86 uses that

        __typeof__(*(ptr)) __x = (x); /* eval x once */

pattern instead: we don't want a cast, because we actually want just
the implicit type conversions, and a warning if the types aren't
compatible. Writing things to user space is still supposed to catch
type safety issues.

So having that '(typeof(*__pu_ptr))' cast of the value of '(x)' is
actually wrong, because it will silently (for example) convert a
pointer into a 'unsigned long' or vice versa, and __put_user() just
shouldn't do that.

If the user access is to a 'unsigned long __user *' location, the
kernel shouldn't be writing pointers into it.

Do we care? No. This is obviously nios2-specific, and the x86 version
will catch any generic mis-uses where somebody would try to
'put_user()' the wrong type.

And any "auto" conversion wouldn't change the bug anyway. But I
thought I'd mention it since it started bothering me and I went and
looked closer at that case I quoted.

And while looking at this, I think we have a similar mis-feature / bug
on x86 too: the unsafe_put_user() macro does exactly that cast:

  #define unsafe_put_user(x, ptr, label)  \
        __put_user_size((__typeof__(*(ptr)))(x), ..

and I think that cast is wrong.

I wonder if it's actively hiding some issue with unsafe_put_user(), or
if I'm just missing something.

            Linus

