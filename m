Return-Path: <linux-kselftest+bounces-30632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DEA869ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 02:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A91B665EF
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 00:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604477104;
	Sat, 12 Apr 2025 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9V++UnV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C682EAE5;
	Sat, 12 Apr 2025 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744419484; cv=none; b=sL1/3Oi2J1uq7HdilwQ/koC3ojKxg/S4Z4dwhTLD2yTYCala8NkGWece1hCiLGjcR8yvJwrdcq+fSaDcwnVAUMHy59fQ1YMB9FWg6rksT4+kZ9vogs+OrYbeLZEkcAYD/Y3Vj7ne5dLkVTaeTUdX10AUtM3NwfsunPn+PGHFVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744419484; c=relaxed/simple;
	bh=4tcELd13teizB6G1R71cLt4/wC29H1yVOSMkrjYkSLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYNw1U8kj8dNyUTgxhquEPXc2W2F1n+802wPznNH+JYFhijcXiMd0OEOL7xgeiUlf4EQCo7i4QvvHJIfbevENcLG8V2ND+htGauKzDkjC/ppZX95oUoXoGbu/U/EiRiiel/lRaIiq0+cadZ85NscbRCOCNdpsTJH8qaCPig+Uu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9V++UnV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ede096d73so19134595e9.2;
        Fri, 11 Apr 2025 17:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744419481; x=1745024281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=offdqmvkFJfHM6QzgUBHAoAKLM8GIhKmAd/u+Vakz+Y=;
        b=m9V++UnV0d6exalspwmeSGn5rI9W8UEfGp1XhionmNfBGrjidxb6pp/QiE0M7CVTNV
         lsWrKcFrnmXz9qPIeQ7w5jRRjhY4o/Jgk4Qm5y3MgBj1z1D7GPAqPgtgUH3bW5AmHo70
         YzANO94R7/MjuzKGOIlh6YBm+3Y+7ff4XgEvwa60mFey1wlaT0HDCFxm69cCu4+YT84+
         Lrln4u6/0Ps2ZydTUYMhspjJUHKOs4Jm3wMuMoeA/P8e/r3ETL8XnNsEPDy/vcQn1j3W
         DXcz/qwW4+1S5XxeYrA875tPCUnQp/LWcZCFvHa0hWRmWaPZP7fJq6PpylZqoPXgXoy5
         CH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744419481; x=1745024281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=offdqmvkFJfHM6QzgUBHAoAKLM8GIhKmAd/u+Vakz+Y=;
        b=lTNV+4Rr6u7YUg+ii4ydaI7RxVcUTznH6SDmjQhvuyTc4uznh7oLdCgIUoBCCKpSb/
         LXDTyxNUkYtfUlaqijhDJVZ4679q6fYDKnojU1jDuLXKem7zjZvD5T9SA++acrX3ZCvN
         TiRnFde9j7Gisw73n4u0IlTUqu/9gDapF81QJ8GKYnDwPFRXeZ0Ayat3btUvSZ53iVah
         3MLmVHMTSRcRnvKZr4gl8QoF1YuH7cOArPqAbxW1skm+SO8mw2snQpSe6vx1gzkcNMLd
         ijsuudnf6SzlUJAxY8tkJ7+nuDcN75aY7OpEzTw4wuSl0CNhW9LprODaMwrcWQ8+TOUh
         tIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA4L7zbTHDGLrjVhRzC5yj4erAViHkdUYGBMxUpBkaXRJMzvjoa3wuc3VzxzYRN3Uiw4dQESYxxN6Kbr78@vger.kernel.org, AJvYcCUc6kInfCX8yn70o3/Dc0E0pWC2lvyVafxNtXT9WLtxD3ihwm23/0UVOnXA6U1vOTz2zTMAZlPpJNiuhN6eKr3k@vger.kernel.org, AJvYcCV9MbHEFIiDQVzmRlWQcyDwijGUOgylxE3xYSDetq6GOTVCZXiv+UjtVrDTg62YzX4p/SgPVb7DYCjMOsLh@vger.kernel.org, AJvYcCVWIasjuPwrLhBbUOIZ91IKv7tCEX9lQsU2FZHJNdYUqA6PYNzhP9EWetfl1Y6B3uiecIZKwfLWYg+v@vger.kernel.org, AJvYcCWOoOV/Yg0LbIrMJG1ydhG0W8TyfzVbasjwnqIPgJHfVdWyN+vmJjGSbFPmUegq2nkEzGY=@vger.kernel.org, AJvYcCWYBfTRRch/Tg4g/NCbeXuWSl2b323EB/4p6e3Vc+jAWZ9cOhwbr+o+QuQPTUN7qgkf8sjJ9ggRnc3ZfQX9k9qPiPl79aUj@vger.kernel.org, AJvYcCWgw5vmFxvn1vbU2TdOyZsKaAD7+cqxM4NrYZzOoSQzwD76uFFBU+CuaBhs7jEF/YGAxbx/GdYnu0u9mbvs@vger.kernel.org, AJvYcCWqlcEQ9SXEZy7jhExldk8IhbCqPowRlusV83CXHSL6qhLvQ7M8N/Sy4FbBS7ODoEBGLap+i7STFDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasBTqZkfY1sUkh2kDwpO9ml+qd6bPIxV7g1YdSJS0dlVThufn
	fHTeBwaHo724BmtRR1AFId+SrrJ8G4SrB93IfJ1Cf5uTqIXlPJ+1sElDq0Ze8N0hVissoVz0zcp
	/bInix5oBmzNi6gMCh0tNsY4/EsA=
X-Gm-Gg: ASbGncvg73XTxjwF+cdDhMu34DLv5geKAa/q7x0RQqwQd0TZW917QXsDNIeYKU7ZX1W
	WHndklICfkmpOV4pcEPUZoPV9lkS/Kiy3fHRIiZCUjWhTa4UJw92xn5WtMozd9mHseqPuhJeRQJ
	D06SZx2zC9ycT41gX8uY8D29XoWBUwxLiDEnSbXJ9/cKnDqct/
X-Google-Smtp-Source: AGHT+IEFrfwIhf1dnPGv0cjHH5i2aO5ebUNrMZZQ/ewydMhNLm+WsR+aOi4a8v0IlIUg+wUzUz/zyHgd2Dl4JnAcXUM=
X-Received: by 2002:a05:600c:5494:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43f3a93d850mr43211925e9.11.1744419481051; Fri, 11 Apr 2025
 17:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <CAFnufp1erGboUtRaqLoKC48c+9jmqzEfFW8W46xt77JMC0PFpQ@mail.gmail.com>
In-Reply-To: <CAFnufp1erGboUtRaqLoKC48c+9jmqzEfFW8W46xt77JMC0PFpQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Apr 2025 17:57:49 -0700
X-Gm-Features: ATxdqUE8eJ3t2XNtv61JfqDn3ir3RXF5bRaDRxRoOmmkz_xcdixjr5poHk-cOzk
Message-ID: <CAADnVQJ5VaXVN=L+0ygEWJkMtPZnqAVEoeFiLBvikntX0zD49w@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Matteo Croce <technoboy85@gmail.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 5:30=E2=80=AFPM Matteo Croce <technoboy85@gmail.com=
> wrote:
>
> Il giorno sab 12 apr 2025 alle ore 02:19 Alexei Starovoitov
> <alexei.starovoitov@gmail.com> ha scritto:
>
> Similar to what I proposed here?
>
> https://lore.kernel.org/bpf/20211203191844.69709-2-mcroce@linux.microsoft=
.com/
...
> @@ -1346,6 +1346,8 @@ union bpf_attr {
>   __aligned_u64 fd_array; /* array of FDs */
>   __aligned_u64 core_relos;
>   __u32 core_relo_rec_size; /* sizeof(struct bpf_core_relo) */
> + __aligned_u64 signature; /* instruction's signature */
> + __u32 sig_len; /* signature size */

Well, yeah, two fields are obvious.
But not like that link from 2021.
KP proposed them a year later in 2022 on top of lskel
which was much closer to be acceptable.
We need to think it through and complete the work,
since there are various ways to do it.
For example, lskel has a map and a prog.
A signature in a prog may cover both, but
not necessary it's a good design.
A signature for the map plus a signature for the prog
that is tied to a map might be a better option.
At map creation time the contents can be checked,
the map is frozen, and then the verifier can proceed
with prog's signature checking.
lskel doesn't support all the bpf feature yet, so we need
to make sure that the signature verification process
is extensible when lskel gains new features.

Attaching was also brought up at lsfmm.
Without checking the attach point the whole thing is quite
questionable from security pov.

