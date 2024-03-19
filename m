Return-Path: <linux-kselftest+bounces-6410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C871187F468
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 01:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBBC1C21589
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064E193;
	Tue, 19 Mar 2024 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWIKtc9+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2E7EB;
	Tue, 19 Mar 2024 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710807302; cv=none; b=HGXgOLsghnxipFqw2dujGRDNrwqpFLbrivGvGdPHDrnVHxwsfwbp5MznhF11r67CQ5ITFbIMu0y+nHN9wXMC801vIXhZGy882lP6/VFBvvZtQima6Tu0lNdDRB30RvfmmHxtU33KgP9+hZ/YNrNsA5FpMxmfbFhUFOSFK2cP2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710807302; c=relaxed/simple;
	bh=Xml8UrA+/N9DI1sriDiEA3m1U8/jThWp7kGRn7KX/W8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oHnS+OcSI1S4YiFUXzxDvsyvA7Id3xutcwGW7SfTkuiDyG4KL1bGjCoqSAdLrNs7iFu0SgQQXQzqlYLlopjddzH+/Qcngmxpy8hrSho+wa9y/tIQ00+LFj3+zJ3aY5Hd152MSUcpDruS3BmljosKb1Z7ubU1Y32ZmE88LBzdvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWIKtc9+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46cf8f649dso140536566b.3;
        Mon, 18 Mar 2024 17:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710807299; x=1711412099; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5g8p3IqxgARfKYTGktm7aut6cdCT60gi+hlyJV5ViYE=;
        b=JWIKtc9+v6qs5pn6mlGt2C0b9Tp7fXAUPJzrYiS54FQjXvSph6RsVubdYRN3kSa67h
         XsJphIWilsfbb0shYONdC9MwJNO1ne/bXXJSoL1PrhtMCQiOfCifN5jFqLQXm7xaC03p
         FDoIZLv7Y7NTTbhOVUcijalnJ69yXE/yuK3FqAhbWTUfGDN5qF5ymZp+YDNueFa8bQBM
         0+hwcHPz9nl7HpqpEYlAy0Jm0y2IdVFpFX0KfQr3YpdQxFsuijlGSggDIzhAvF13bpsO
         8VB/u4rqZrC48dgXTDi+1vJJJk5hqw5r9cXWQcuQpPSskznNhTGVnZ67d7yveZNsYrV5
         1wOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710807299; x=1711412099;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5g8p3IqxgARfKYTGktm7aut6cdCT60gi+hlyJV5ViYE=;
        b=QoZVeVTxYswgfuEFHhILjdNoKGYdPMN01V7pJBg8FU9it7otZ54SlAPe/YatYhOtXX
         4C8nYpc8HmrXe4dvv3Nnl9XzTloLU209R7z5cVqnmCKswPcfNqodDmA4ih+tCSj5dbc4
         RkOMc71Cu4ZvdQiWbWRf38X7r1jn7QCzQs4URucy5bpJ64FX4FtQ+eg8cDwr3GlBb28D
         PwlCsE27fplLN/52kFaN5YuZkA4Rxfc2SNk584eVpRDI3CAh+kThiyt58uUNCZn/SVvH
         ahl+Njqm0Kn+FybDiNnBOVXfjkYoTNgYxuAt91GzQAlL9sTJr75UZxHuElZ/hAoEjghk
         WiBg==
X-Forwarded-Encrypted: i=1; AJvYcCVtpf0Gsv5kf25X3QTuWJs6B5UYEedqU76byYrY15wSEwnhK41UN03JZpyC7lEFOmpjyGR/75xsErJlsUQk1bHaMQzClN8OzjG1SOVOAOMrsMZmUCb18hdYSwBtBfx4R5eXVtK9UwRQrBhWD+OC
X-Gm-Message-State: AOJu0YwWntR9lQkQhIuBpWXVqU48nPxq6a0txkYrfBQYZ2czZl4zkT7v
	zZEZbN7lJZo91SnvYYvuMR1+SMuXawuSxMXqH4B9h1Gr6u1K9skr
X-Google-Smtp-Source: AGHT+IEqaXjurhuhSHzFitnnwvEJbQxx8vRt7Mfz+RXSuN+q4PXsUtc9PE6WTppBGjFIoLgo8rTQeA==
X-Received: by 2002:a17:907:7886:b0:a46:aaaa:4220 with SMTP id ku6-20020a170907788600b00a46aaaa4220mr572354ejc.32.1710807298480;
        Mon, 18 Mar 2024 17:14:58 -0700 (PDT)
Received: from [192.168.6.255] ([5.1.5.0])
        by smtp.gmail.com with ESMTPSA id o12-20020a170906358c00b00a46cffe6d06sm802577ejb.42.2024.03.18.17.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 17:14:57 -0700 (PDT)
Message-ID: <89e76fa5834bd34ef94761bcbc987a1be245b261.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: add sleepable timer tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Tue, 19 Mar 2024 02:14:56 +0200
In-Reply-To: <20240315-hid-bpf-sleepable-v4-6-5658f2540564@kernel.org>
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
	 <20240315-hid-bpf-sleepable-v4-6-5658f2540564@kernel.org>
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

On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
> bpf_experimental.h and ../bpf_testmod/bpf_testmod_kfunc.h are both
> including vmlinux.h, which is not compatible with including time.h
> or bpf_tcp_helpers.h.
>=20
> So prevent vmlinux.h to be included, and override the few missing
> types.
>=20
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

[...]

> @@ -6,6 +6,14 @@
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_tcp_helpers.h"
> =20
> +#define __VMLINUX_H__
> +#define u32 __u32
> +#define u64 __u64
> +#include "bpf_experimental.h"
> +struct prog_test_member1;
> +#include "../bpf_testmod/bpf_testmod_kfunc.h"
> +#undef __VMLINUX_H__

Tbh, this looks very ugly.
Would it be possible to create a new tests file sleepable_timer.c
and include bpf_experimental.h there, skipping time.h?
It appears that for the new tests the only necessary definition from
time.h is CLOCK_MONOTONIC.


