Return-Path: <linux-kselftest+bounces-33490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6733ABFF77
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 00:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B050F3AA9FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 22:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6A23AE66;
	Wed, 21 May 2025 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dWHtCK+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC8134AC
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866402; cv=none; b=B/eQkHg01TOdk/U0xzdC34Iy4p0JBxVG7YND+kdCUqD1NzzAT9es6tHB/xkB2bI6X5G7yJAIMoUA6Fvx4cMAZRr+WqF+gy9WG2i4l38iPqIBY0DNAK+W8Fmy/P4erb3/kVFzGQrqA0jrZ6e6KDQy19U2V81JPkCFM4rUHKBqwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866402; c=relaxed/simple;
	bh=9Wg6PPoLM9WFD1B0FiNbRv3qnbGj9YtPrQiT2xmvAlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mc8kTUjmwqx5ucwQxUHxMTVqnQFpO+aanH4GUOeiPCebfb4QgHXpc3lbmkQYeF/cmXny27Pqxy/NI/HBWFmtxTlIFSVdarMsygbSa3RC/aK8c+WS5zmtOyfx7RO1C5TgHdxzu7t67/0xUkltxl6w9LAtUApCk3RRIsF0tyyjWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dWHtCK+1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70ccf9a4ab3so42173817b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747866399; x=1748471199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2CpApAzFU/xdWj9L8OzabAbfmuyqqCQstsc9xr7aRs=;
        b=dWHtCK+19LpV/OzjykLmVBgKbhcOVNo6dl8aB0xCje7M0djkO5qz6Brd4Vnj5mcKqI
         1H5BuuIqWkinNZRXPToDvL+blTYOUCFrVj3IOcfW0WG7CAKmRKeOerkq8BF8rEJ8a6yG
         EUdpdr16fxXqbeeTxYuVF/mjkMUUCCHD3JpO1rd/qvaNKZGYcfAZJ51/C0r4rNpFcKY5
         G/WIktsPcA9J9qD7rjRrRBiA7aouCKaKzt/61Sm9K6rkO3kwYUmua+72BVLQXw6gtUty
         0TIj9LWgjczs0LRj6jwoMssNL8YPLfT31FbyxqHBGs5nq6uyxvKzEysyiqfzGNA/JLiX
         AAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747866399; x=1748471199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2CpApAzFU/xdWj9L8OzabAbfmuyqqCQstsc9xr7aRs=;
        b=b0cN754V/0IW7ke2J12FiP+qTD3VDmyahqZbw73L8MJF/QfRct/mNiKtpzelUOleks
         rKicwviTcq/yNRUjk79xp0Ai7oWfjB5Xo+wzsZ0T1gmp9SE0Z8y+Q+SsyQn0SLgyPH3O
         55ISig6/DhY7qE/KPQUQ1LzQzk0ElwgPdKU7azQZWxF2DI0zfRZT4q7CPX/AvrXJ7YBu
         X+dfAatjThXsIsthJhAWWY54MrcZZn1ok1Zyd0ku/P7o1rBleIzjHr1SsPDCTJmojWeR
         iggn3kuWOjEKa3mV6mHlgX6JCDneIpL14sDleiTsSupbTF6vUHHmt1+HuyXoVawpfQpL
         MKrw==
X-Forwarded-Encrypted: i=1; AJvYcCW/zZIg108gjPiuOnXrGQXnHM2y5B2duVJ4XizjQDnhq7Q9H0fMgDgFCTniwsw1vzO/FEkLTOBN2RSq2ky0ePs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxacKX/mTMTEXhvfZHinjR0wswh5SKg0Ny5+eismcwmIt/Fsyw+
	1RxO5QoXeHJhhVjca2EOuUZEX0UKnNh5EY/6iChBJSljSOnJ3yY/fSPfDOyttg9N4NXSncGNn3l
	Vcb7u6L98rdy5VA4PqZprNbaUYA4WSzg8TtIj0C1X
X-Gm-Gg: ASbGncswiTBfrn3OBlkN3NIBnQSND0L2kQ+DkRA5FN8NZvN5j7TLoSwwjqF5EDnKTav
	7ouXHMXY25ia/BDoGT+w8N6zOJ8mdcCbDQ9M+KsjaD/wa6GFcy9tmnnAwlsIiWfSMEvGNEfdLHa
	7G52dCV2He6/Xn4eMwhQs1Vf6OQFrsIfDv
X-Google-Smtp-Source: AGHT+IHWrEn3lGbj54WMbP1QWqKgIGqbS12jw/F6NygMZdWDXAhufhQc4tMWD/kGAI3Getozp0LttKjpfQRDZM9iHFA=
X-Received: by 2002:a05:690c:4883:b0:70d:f35d:4d26 with SMTP id
 00721157ae682-70df35d4d9fmr60596797b3.21.1747866399572; Wed, 21 May 2025
 15:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
 <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
 <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com>
 <CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com>
 <CAHC9VhTeFBhdagvw4cT3EvA72EYCfAn6ToptpE9PWipG9YLrFw@mail.gmail.com>
 <CAADnVQJ4GDKvLSWuAMdwajA0V2DEw5m-O228QknW8Eo9jxhyig@mail.gmail.com>
 <CAHC9VhTJcV1mqBpxVUtpLhrN4Y9W_BGgB_La5QCqObGheK28Ug@mail.gmail.com>
 <CAADnVQ+wE5cGhy6tgmWgUwkNutueEsrhh6UR8N2fzrZjt-vb4g@mail.gmail.com>
 <196e1f03128.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAADnVQ+=2PnYHui2L0g0brNc+NqV8MtaRaU-XXpoXfJoghXpww@mail.gmail.com>
 <CAHC9VhRKZdEia0XUMs2+hRVC7oDzkBfkk5FPMD+Fq5V7mAk=Vg@mail.gmail.com>
 <CACYkzJ7oxFA3u9eKDpKgCsZsYsBojVJPHVeHZnVaYQ5e9DavmQ@mail.gmail.com> <CAHC9VhQ7Rr1jJm=HY2ixUWpsRuwCxjOq5OTMfn5k5hRzxTCz-Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ7Rr1jJm=HY2ixUWpsRuwCxjOq5OTMfn5k5hRzxTCz-Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 May 2025 18:26:27 -0400
X-Gm-Features: AX0GCFvZaSST-PWkU4_ibBxMlaa0A91pXSzh3ZzCdqeIU3YX4GLRRjzs5eOILBs
Message-ID: <CAHC9VhTj3=ZXgrYMNA+G64zsOyZO+78uDs1g=kh91=GR5KypYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: KP Singh <kpsingh@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	code@tyhicks.com, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	David Howells <dhowells@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>, 
	James Morris <jmorris@namei.org>, Jan Stancek <jstancek@redhat.com>, 
	Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas@fjasle.eu>, nkapron@google.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Shuah Khan <shuah@kernel.org>, Matteo Croce <teknoraver@meta.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, kysrinivasan@gmail.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 6:58=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> When the kernel performs a security relevant operation, such as
> verifying the signature on a BPF program, where the result of the
> operation serves as input to a policy decision, system measurement,
> audit event, etc. the LSM hook needs to be located after the security
> relevant operation takes place so that the hook is able to properly
> take into account the state of the event/system and record the actual
> result as opposed to an implied result (this is critical for auditing,
> measurement, attestation, etc.).
>
> You explained why you believe the field/hook is not required, but I'm
> asking for your *technical*objections*.  I understand that you believe
> these changes are not required, but as described above, I happen to
> disagree and therefore it would be helpful to understand the technical
> reasons why you can't accept the field/hook changes.  Is there a
> technical reason which would prevent such changes, or is it simply a
> rejection of the use case and requirements above?

Bubbling this back up to the top of your inbox ...

--=20
paul-moore.com

