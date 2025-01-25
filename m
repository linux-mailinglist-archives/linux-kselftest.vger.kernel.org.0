Return-Path: <linux-kselftest+bounces-25175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26426A1C46B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 17:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F71A3A61F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31B3FBA5;
	Sat, 25 Jan 2025 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAelecxK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7715D1;
	Sat, 25 Jan 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737824341; cv=none; b=SESQkciZSFUu8tWCVhv2DRVyCDBTJzdP6cSw/JUJHzokDtvuwA4lC0EJwfI78QU1bKA9yalbtHufS1OrDRuYewMAg+eV24VdMZlxcnLaXYMuo+WhIOwmw0G28cS0BXOe3z4IDDW2afydWXB4YCMGa2W+6ISCfgW03xBDtQiFN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737824341; c=relaxed/simple;
	bh=gZDB8AUYvz2NWqBs39AQ3n4LHwO1pGN/uqSdAtBPE3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOpuC7U7wfKb14POclsRtib8zZFjhOEWvqoOsuGnILsTAIvRR44QNC/1NvuVSs05cQIzixH//brzIvAmpOGxip4qmS+PgHUwSBwZfc/a+kfgz9jDvAw779g+YUyoLc67kwXl4qnnfUrgQSSiD+UupylAgxg6ro6iDVyaCUAN0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAelecxK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436345cc17bso21965455e9.0;
        Sat, 25 Jan 2025 08:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737824338; x=1738429138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnTgKL7srd9wCTgYtGcIWl4m4JCcvhenFFhIMXUTrPo=;
        b=jAelecxKn8Lc4nYidt/BQbXTRsO5cEdLkoTp4FfeUL4VfD5T0BPwnp4z3oSk0zjIsQ
         a0UqKA1WiQ+8maOTBiMni3vUUYP6V1jASZYWFeeiw7np9dJF6pl3J2kbEpUTuj39a2hw
         absWZCEPpKqEuKLXNCb8ZQ4F0KFNxzhaPAkno5mlVSpG7MotnTpoSzuiwR2NE+AxusCR
         yap9fvqP+oKI+QDEyrzTERhDVtHbMy+6TTFwooyX3+kZ8p3wJ9jKhZFmAGdB6LTNUclT
         9/BKH2fJotVHYCgaTSbEa22k1WQ7dil9UsjK2U7KtrWXeVrcONr0VyBu5nR7qBLpoajN
         ohQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737824338; x=1738429138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnTgKL7srd9wCTgYtGcIWl4m4JCcvhenFFhIMXUTrPo=;
        b=VNWXM3ZuyhxA73S5txYXdiQW3xA4T04PwtBPzPtf4ZvP76fk2Idftq15D4dpbOmRNW
         bJ9PlR4b3xcJP+3ODtbf9fKZD3A8YYIXaQPgnAA8tEPr3ZHsj1bwWtHduMP0CwlltKGx
         7oSU5zjLLKRBaCwxIxGXStwboKOh4VAstfaCnZtSJAHsgUGThBnIZisRnF/ZieWl3Wdz
         ZDewQHzaexif+DCyJVLBHCWtgIxQ3pXXkxUq8ApyOhvzvy5FIYOVkr3w7CsxRKX9Q+Sh
         e/ifGNOF3ATkmHngxNqmRGbyclACZ1cGOoY3oMfffAN17XwJ+Dx7zwueSu12ImMi+qso
         Hx+w==
X-Forwarded-Encrypted: i=1; AJvYcCUJirQczjUIfTingvigc5ymQVbnPUraTH9f6rzBKmsTHG0Y+ykEsh3a+ef/NlA2RUn6C7PIQasupyH/ycnZeFy3@vger.kernel.org, AJvYcCWOiq6sUzLbX5guGvx7zWkWbGi+DY1XJB6w10nnC9ZYwuMjjPYSRm+WAtWlAPOedIQR8lE=@vger.kernel.org, AJvYcCWkNgXBEYtz7SyZXgUII9bAGgpyeQdQu5zlnCIsaqd87sJdDCMrWU+iiEu3yYHaIIXMUV78BiN4F/XMtIrNhZwu0qyQ@vger.kernel.org, AJvYcCXJmIGAB6l9e2JSlkXWuQ6drpO81dlxRp5ZDgj6Cx2PyaYdVAv3xGXAQlpMaaulMGvSl9wg7VZwD+g7/0ht@vger.kernel.org
X-Gm-Message-State: AOJu0YxMi/TTy42yQNyr+edg60ROKrZx3M4U6EF1/qSiEQveel6GvMLI
	N9EEN7TlW0EQ/T2vueDOJGBlSn2Mr/deC0sFWk1ZMb+ow3Mgwn8LJMAdNp4OlE+0At6E/qEY54U
	Ep/+Pn+ro0/mwjBlLXmsLLBMgPx0=
X-Gm-Gg: ASbGncs3dDBjeQeKEeEE+SeB+O6DIqGoKZ34f+4Z2cbH+DSkS9Jv7B9HAyMMPVhIaWL
	pVZ4lHn2W2B5/6wiYY1BxFB3IHsKSEP20FJC2I/fHxT0/PkC92jS14eeX+YARd+EltfgT6sSAXH
	cJudxIUcoyeIVozR2BRA==
X-Google-Smtp-Source: AGHT+IFovdUW+g52glJFzGKxIkyLafJVtD6B4xRKToOlzvfr/FPVc8u6gBvL8a3ba619fjVlNDEWN76CbJvMpDlTsaA=
X-Received: by 2002:a05:600c:1c84:b0:436:1b08:4c78 with SMTP id
 5b1f17b1804b1-4389144fd70mr377983535e9.31.1737824336082; Sat, 25 Jan 2025
 08:58:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com> <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com>
In-Reply-To: <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 25 Jan 2025 08:58:45 -0800
X-Gm-Features: AWEUYZlPRO0oW0oJVlk6cBsw5KhTsGMqm3LYS7HvvoE8ARetkOn46zzaB5HOblc
Message-ID: <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement bpf_probe_read_kernel_dynptr
 helper
To: rsworktech@outlook.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 12:30=E2=80=AFAM Levi Zim via B4 Relay
<devnull+rsworktech.outlook.com@kernel.org> wrote:
>
> From: Levi Zim <rsworktech@outlook.com>
>
> This patch add a helper function bpf_probe_read_kernel_dynptr:
>
> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
>         u32 offset, u32 size, const void *unsafe_ptr, u64 flags);

We stopped adding helpers years ago.
Only new kfuncs are allowed.

This particular one doesn't look useful as-is.
The same logic can be expressed with
- create dynptr
- dynptr_slice
- copy_from_kernel

pw-bot: cr

