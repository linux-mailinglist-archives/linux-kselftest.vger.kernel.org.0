Return-Path: <linux-kselftest+bounces-5487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93740869C4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CBE28C3C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA2208AD;
	Tue, 27 Feb 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C56muvyF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AA200D5;
	Tue, 27 Feb 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051803; cv=none; b=IP/Riqy29R0vHvSuLUw2TTSOsNFfcSilGcaGlBRU0OZl7VWC0iw9jUzMfYbQvIao6x9opTdytFfk8lJwhokyAkCqshg/GuLPwHkifJjGC8epayyQ68cyXu3zKZtZN595eYkdqsYpPyGKzhapiIAQpglm4pnBniLZKH+PED9hXxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051803; c=relaxed/simple;
	bh=hXwL4660+XM+wMrQMkOFCB0IGRMCfdbE0pfYHgN8LDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k3eyq5Z5hX0wkoGBj1Wilu1aPIgFNyOCtWHI0eGaz+JV9GV40FF3P2KwfBzBsPI8Xx5wtZ9MLs55GcQTra1JWL5cQZSCjzvboOHpHong50A4kytoJ81gP3aohsnX2b3bV6pw3vkEPS5gAjM/eNc2cVKw+3Z1/R0hqLkDN3KfcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C56muvyF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso807728066b.0;
        Tue, 27 Feb 2024 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051800; x=1709656600; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XTzJpS7X9XEoV4xvNdFIuJu4pysu7KWGugmJiXpsQsY=;
        b=C56muvyFgnDMKaVPLpn71owu0IHf0H6YI75i1YxDE850MmWoIyeclDs9DDGap/r2yJ
         jkbv9SiBsVwkstzxyyK48Ofg7uz3lAunM0ICKxHEgP3HX55zW/ibBGv5dB7rbqiRn17W
         s6njdZ7xbDVX4OatctqKbdeSQPEcq7PO6DS/qlbWinGeayOr6sRyoUxhx4rJm+HNfb1d
         jOgL7CapHtXyS5/5IEACNvJXrQepGrT9tgDWOK5bcWNA1LdqExSnUrJXkifTmqxihyFZ
         0/yCaPC/DXHCho0zJB3QQXuRIHlBE+xcmMzkYTw7suEER/zf6cD9AzLPNKTinyuDtPgu
         0n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051800; x=1709656600;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTzJpS7X9XEoV4xvNdFIuJu4pysu7KWGugmJiXpsQsY=;
        b=PKyeHu3KLGgl1QNpJlq3blB4jSf41d+SPlvvhfJdIhSnaOAU2RGX/NgCekHukvCa8K
         A72VzYx8Pr8UOaqaxzeWn3NGNq3PaXFRxp07vVV4+9j98xLg8TEpH5CwSHWwoUSIl3+z
         YfpWH52Pocj5gdfjfQ5oSySkOWEnH8U9KT26LnOPLOmU3ZJ5hRM9N99vXXm/JjMOi+ve
         9VhyRcCRHpkuqfg18NQUivsQ6mVvvsId3/k3so+c5d+BmAvZaJ4lmA8AiqbPvwCo0GDA
         jinc4K9oxgmhkIjUmlQ7BvaxcJd2rUgrJraGcztchn2uTE3QxYv0DX/1h/xdVmx4JPob
         Khww==
X-Forwarded-Encrypted: i=1; AJvYcCV+DgtwTyDTkaMDcwjl/8omOX2C4HoVfAUqB2451PbezjQYKdzyMvukmTN2oL1skCKhyrh5IlZpF7ihwaBYFPe+Y1J/2b9zK0HS3QDyqIWOvi/WqMrHTacqMdoIwY2v+tA5f8LzIcxSiLu6tR6MART4cGFbDdRlSi1JH4ROXzNT+cVtrfmxM3Hnm8/qLPfiLuMWV8LuN0f/c5CmJUm+ytNuv0VD3/Cwanc2g527HmAHGbumm5pVR3xT+XY=
X-Gm-Message-State: AOJu0YwEMwTvy5VXBjUIi8tH92EeFePHdWm6hMZMxHyHyWyO5SawfhNM
	VamgJ79OBgRGBwCb00HFqdK9pWAY1KKxUUkHCQob6JrkmmK6V5PZ
X-Google-Smtp-Source: AGHT+IHTThC0untfFuCzhNiu9UcWocSFSzEw+xein1v3vrNBcEIfO/H/gNfMVPOXdUv4kGjwHs9jNQ==
X-Received: by 2002:a17:906:408d:b0:a3c:5e17:1635 with SMTP id u13-20020a170906408d00b00a3c5e171635mr9143240ejj.30.1709051799951;
        Tue, 27 Feb 2024 08:36:39 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lh11-20020a170906f8cb00b00a3fb62260e3sm919913ejb.72.2024.02.27.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:36:39 -0800 (PST)
Message-ID: <9a35a53a1887fb664fd540ec7e272cb3ea63f799.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 08/16] bpf/verifier: do_misc_fixups for
 is_bpf_timer_set_sleepable_cb_kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Tue, 27 Feb 2024 18:36:37 +0200
In-Reply-To: <pocfd5n6lxriqg7r6usyhrlprgslclxs44jqoq63lw734fjl2g@5kv4hjaux2fp>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
	 <20240221-hid-bpf-sleepable-v3-8-1fb378ca6301@kernel.org>
	 <55177311ccdc24a74811d4a291ee1880044a5227.camel@gmail.com>
	 <pocfd5n6lxriqg7r6usyhrlprgslclxs44jqoq63lw734fjl2g@5kv4hjaux2fp>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 17:18 +0100, Benjamin Tissoires wrote:
[...]

> Hmm, I must still be missing a piece of the puzzle:
> if I declare bpf_timer_set_sleepable_cb() to take a third "aux"
> argument, given that it is declared as kfunc, I also must declare it in
> my bpf program, or I get the following:
>=20
> # libbpf: extern (func ksym) 'bpf_timer_set_sleepable_cb': func_proto [26=
4] incompatible with vmlinux [18151]
>=20
> And if I declare it, then I don't know what to pass, given that this is
> purely added by the verifier:
>=20
> 43: (85) call bpf_timer_set_sleepable_cb#18152
> arg#2 pointer type STRUCT bpf_prog_aux must point to scalar, or struct wi=
th scalar

Right, something has to be done about number of arguments and we don't
have a convenient mechanism for this afaik.

The simplest way would be to have two kfuncs:
- one with 2 arguments, used form bpf program;
- another with 3 arguments, used at runtime;
- replace former by latter during rewrite.

> Maybe I should teach the verifier that this kfunc only takes 2
> arguments, and the third one is virtual, but that also means that when
> the kfunc definitions are to be included in vmlinux.h, they would also
> have this special case.

It might be a somewhat generic mechanism, e.g. btf_decl_tag("hidden")
for kfunc parameter.

imho, having two kfuncs is less hacky.

> (I just tried with a blank u64 instead of the struct bpf_prog_aux*, but
>  it crashes with KASAN complaining).

For my understanding:
- you added a 3rd param (void *) to kfunc;
- passed it as zero in BPF program;
- applied the above rewrite, so that r3 equals to prog->aux;
- and now KASAN complains, right?

Could you please provide more details on what exactly it complains about?

