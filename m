Return-Path: <linux-kselftest+bounces-7438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD389CE7D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 00:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFC51C21C80
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 22:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446EF17745;
	Mon,  8 Apr 2024 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH145i7H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF01A5A2;
	Mon,  8 Apr 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615761; cv=none; b=DwFLerX3ZBn5/4xunAB+6kloDfOMjANgY8xMvFHP4Ihd0qAayPZe0fVFCwnCnysxBP5iwDiuJKQKgL0I/pJ6GvP/WNn7sGqrGcoHxyU14W+lYnGKvGnhZcik6F99OXm2eK/lKPmfcaaOQkCUrNSQxexZBIimX2k7zZcnaQVfMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615761; c=relaxed/simple;
	bh=3cPal0PcyBF+aiN/zwbK05iiWVn1zNZFAKQzLfq3x8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPNo9onvc0HgXqsTZ2cQGZaPUsYBXPOr7O8Nw8lmohiwLfQC9ls9KEtAPeHV/yUmJnlxmoqVhymRX9a4C0L4Ul2WV4ywDSnP+fejnkDNpVB6qdhvj0aRP+xVCkZ61iQyOmFfhKmYwkgUztq4BYxZprp0zEdDSvIcIXzjarFYFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH145i7H; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaa6so63890291fa.2;
        Mon, 08 Apr 2024 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712615758; x=1713220558; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QzaOLKxDboX4yOy570vjmU1pifeDoG6kHY2U+WBIbU8=;
        b=SH145i7H7u3jMlfuRViGkC3qVhnfzU6dMU67780b0vMT/VI03e4bdhG/uasohW+lfh
         5E54Y8IxlmRrRZhx+NFmZbSOZtiKgbwHnHtda9gRfVlsJv6jEWKQNlHlS3NL1AuC14RW
         NlXx30rm7zPjHqX6+J4hInEO7H1IVUE7EzH6A0ZT6+k8uwyJST9hMdFaeUSLykppupnv
         C4ZsaGbtgzfgYE4OzGrLLQGZyHUoJsAvCKVHoIac8XdPydlT6Yu7XkchJlga5j9V2kV9
         3PenCoCzkknqXqGxbE90N8b8iZkMmreKbfWcnCPYHnW2gjFcugFcUA8t0BrKWZKNV6bK
         TQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712615758; x=1713220558;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzaOLKxDboX4yOy570vjmU1pifeDoG6kHY2U+WBIbU8=;
        b=InNFDKxDzCYh1QAlX+cOmjb6wD7dbZRDLQhpNEj8Bd+qN+vSR7fFYgXrS5l9eOuXMO
         vLaOmJeDe2iADvboKujpGFaM7EXHIG7D9mDrRIv6U8tzP0O2f0vg9v/cr5L9D+wGdyGO
         m44CH1OUqSYijd+5tdaZOuWteb80xZ5KxuJ9aWmXADeLMRagIwoWI6RYtPKMeoyaCTUf
         hftcOgavHr539zDcistY4P1PjZlxwKrZDgjBkgDEut2/YWVKcm7NhQPPpbuJIZnOaOlQ
         hv08YDS17AE4BXR4zDTbLz19jqnXqV0yFuB+C1ODftnlMif5UvEmiokOoVhwRqWqtbVM
         l//Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6yIv7Gm3hcpCxHrfy3BG0MYv23jRiYK2ssskH5V0oq+TYBqBql4OOgvekqyhWg/m7pM1Q2B4dMTBlKRGhLyRAo9bRGtYASzXwf6wvQkwzmhodqq4A4QoEaqBxDeYSuAB4Sd9Mz9+BXv6tizdI
X-Gm-Message-State: AOJu0YyF5pMpp5FhEK41HiU0mfHPuPIA40nq/M4Nxcth03rXb4gW7pZn
	z8sY/dYNcI3w2/WUH4evV8wQ7ZEQkBUduoxRQyQZlCiiZMcJw+t0
X-Google-Smtp-Source: AGHT+IGabQPjHusP4qbbSVnEnDijSEaS8p5kQFlyVxZmC1rm5CusvbY7EOQoWozQ0qabJMQARqfekQ==
X-Received: by 2002:a05:651c:1422:b0:2d8:6467:1a13 with SMTP id u34-20020a05651c142200b002d864671a13mr5848323lje.30.1712615757343;
        Mon, 08 Apr 2024 15:35:57 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id y13-20020a056402358d00b0056e031bb5efsm4544308edc.47.2024.04.08.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 15:35:56 -0700 (PDT)
Message-ID: <db1f8413ef4ebc57b9ddc586e48acf3fad19ebf2.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 4/6] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
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
Date: Tue, 09 Apr 2024 01:35:55 +0300
In-Reply-To: <20240408-hid-bpf-sleepable-v6-4-0499ddd91b94@kernel.org>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
	 <20240408-hid-bpf-sleepable-v6-4-0499ddd91b94@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 10:09 +0200, Benjamin Tissoires wrote:
> Now that we have bpf_timer_set_sleepable_cb() available and working, we
> can tag the attached callback as sleepable, and let the verifier check
> in the correct context the calls and kfuncs.
>=20
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>=20
> ---

I think this patch is fine with one nit regarding in_sleepable().
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -5279,7 +5281,8 @@ static int map_kptr_match_type(struct bpf_verifier_=
env *env,
> =20
>  static bool in_sleepable(struct bpf_verifier_env *env)
>  {
> -	return env->prog->sleepable;
> +	return env->prog->sleepable ||
> +	       (env->cur_state && env->cur_state->in_sleepable);
>  }

Sorry, I already raised this before.
As far as I understand the 'env->cur_state' check is needed because
this function is used from do_misc_fixups():

		if (is_storage_get_function(insn->imm)) {
			if (!in_sleepable(env) ||
			    env->insn_aux_data[i + delta].storage_get_func_atomic)
				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
			else
				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
			insn_buf[1] =3D *insn;
			cnt =3D 2;
			...
		}

For a timer callback function 'env->prog->sleepable' would be false.
Which means that inside sleepable callback function GFP_ATOMIC would
be used in cases where GFP_KERNEL would be sufficient.
An alternative would be to check (and set) sleepable flag not for a
full program but for a subprogram.

Whether or not this is something worth addressing I don't know.

[...]

