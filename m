Return-Path: <linux-kselftest+bounces-21021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3953A9B559A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C1B283F80
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AE206E61;
	Tue, 29 Oct 2024 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG8ieoL4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157A17B402;
	Tue, 29 Oct 2024 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240148; cv=none; b=g4ehovhZ+RWwdnnCTzBpG9+EhgAzhmK5+cCg1g2yrxvu4oGXmttM8x8huFBGOlMGKx750/x4J6Xfwh2JVJGFrF/z04BKOs1h1uKJqGUz74fcF7hi8c/47bzCTo6+gRbw/Px7ofsr9QLzkXSzPa2FM5atj5Yy518xArV5pcoKSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240148; c=relaxed/simple;
	bh=Th+710hwtg36aggD8zdCEOkhdsQiBq5+/t8XJyHhUo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcdTzClQLe2+PvkZuMm/NCXRwKw5OGNNdMCqzvw3YWy3pkZzldA5EeuXRJRYnlmqK/ecgE1gPWbcqA+p+DUjso7xQ6Gc/3dv331VjrZTWGcmjKtRmK/osF/3CSL/XRfc75RdkRW76YZEDyJyCM8JmjKdiRCqsPwr2qKoIOfkDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG8ieoL4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71ec997ad06so4346414b3a.3;
        Tue, 29 Oct 2024 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730240146; x=1730844946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9jFPar4//KYidNuqJMmCaLzKhmHHPRoEdXdNp1U9G0=;
        b=gG8ieoL4VXlqlzUzp/n/wn69bzxyUeYrrjDRb7kyHPjEMcM2PY5b5Izc0uoj+1VvsD
         k4kQkSkFOCXKrR65oMLvLTW9g2rxN0Wx5JV9wkwN+mCSgxzpXTrc1u3A+sDIYWXL60wt
         a7+ULryC+vRXGlY7UgJ5AzgXRGWgrKeEXQ9mkNvLJ83mp+AhvYjjpD2osfyBO/dVeSGy
         UySuu+YmcLyyBJrCYFqCAkFROFCd1A/rncNucd0vd9f70aKpRhYeDdPpED+yvhEAe3n2
         MpPqC+WONU98eaaHpYWDCrVmq3nTt8Y+FSwoELyQTVgTqSBOSlVnr6dXB09UAxBm9i7c
         zdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730240146; x=1730844946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9jFPar4//KYidNuqJMmCaLzKhmHHPRoEdXdNp1U9G0=;
        b=hldhc/bi8Jl/H7K82H46JaV0/OEQiia3UG9plC0g+vZIoQykSp1iS9r0rBpV6W/cTc
         qpiScZP12OLmIbkNALs6yqcJVWDcqxmK0XrzXuiGEFpMokyqTJhy4ied/JKZv1kfid9x
         wrFP0/0Crnf0A98ZIXqB/L+IOKpePahvkVa2LDfsHn5nnjCUdft5xlOeuNHjFCOCW+/n
         GKiwfFU1boASXsSo1lOg++vUwuZdqQRqyPar133C6Vxj2CRSlkLGGj0V/vZhgIh0K8Ie
         xTXgtxhxetUmrvUQFGQfOQ+kVfBxIl/bFJSi+gRU+ymA4OTi/RE5BR687o36Jmx4VGN/
         VNaw==
X-Forwarded-Encrypted: i=1; AJvYcCVUDeaJa2RQUfO9CeaNZ+z5FOwsae/jJnzgIP/SukZPwKwmxlDXa9d9ZqO883zld8BSgEs=@vger.kernel.org, AJvYcCVUxXH6Kdp7JU1a+aJmVFdvO7Wk1O4nX9QDEDzI/lE3KlbwNv+GVyTZ2sHA5f6y/KtyhrhndRhZBRaLx5dHeIHl@vger.kernel.org, AJvYcCWzCI4ylYIIthYgkecKtwZApKUOnS+IrzxBoARbSN0EAyR3LXEoWf4L8OqjwdzKZLrX+3OSHKDNuTHzZxv3@vger.kernel.org, AJvYcCXrGs4cZGG4VFqQ/vob4ojhf3Sig9/f7t904SQm+MJ1t40eOr8oN6X0ZjiwyK4Sq88j3BpmCYgQKk0ElT3Y74JsWfpt@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQJYgSSraJNILC4e1TsKkDz4csLiZWVJTElewvg1CG6ZvHhGu
	AgJyqVVvbZlRfxfyrDmc34ceyC/boBzXaULTHZSGo5fpaTtIPNOgKkNHOtMoPc7/7ngteK/SnWY
	1rvZq6EeJX2LLqzy0k9mX3UiS/Rz4zw==
X-Google-Smtp-Source: AGHT+IHIcBdcUIT64eaEoLPTSkMsy/XL70V2JIoS9czd33AEXLuKHyp+llKf1eQ2Ir7iyZLAi3oYVTHpVffsUQscmgQ=
X-Received: by 2002:a05:6a00:1809:b0:71e:6bf1:158f with SMTP id
 d2e1a72fcca58-720ab492bf1mr1533945b3a.21.1730240146088; Tue, 29 Oct 2024
 15:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029002208.1947947-1-dolinux.peng@gmail.com> <20241029002208.1947947-4-dolinux.peng@gmail.com>
In-Reply-To: <20241029002208.1947947-4-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 15:15:34 -0700
Message-ID: <CAEf4BzYZgAPZSQTTk20s8vUwDMipe+0HRyKNnQchM+C10-1qOQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] libbpf: Using binary search to improve the
 performance of btf__find_by_name_kind
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:22=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> Currently, we are only using the linear search method to find the type id
> by the name, which has a time complexity of O(n). This change involves
> sorting the names of btf types in ascending order and using binary search=
,
> which has a time complexity of O(log(n)).
>
> Another change is the search direction, where we search the BTF first and
> then its base.
>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 159 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 140 insertions(+), 19 deletions(-)
>

same complaints as with kernel-side implementation

I'm not sure if this is the right approach, overall. I can see how
pre-sorting might be useful if done by pahole. But then I'd say we
should record some bit somewhere in btf_header claiming that this is
sorted BTF, and then if that bit is set and we confirmed (on the
kernel side) that sorting is indeed correct (and if not, reject, don't
silently ignore), then we can use that sorting to our advantage.

I don't think libbpf should unconditionally sort or check sorting in
the way that you implemented.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 5290e9d59997..cbf88a6b92e5 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -94,6 +94,10 @@ struct btf {
>          *   - for split BTF counts number of types added on top of base =
BTF.
>          */
>         __u32 nr_types;
> +       /* number of types in this BTF instance which are sorted by name:
> +        *   - doesn't include special [0] void type;
> +        */
> +       __u32 nr_types_sorted;
>         /* if not NULL, points to the base BTF on top of which the curren=
t
>          * split BTF is based
>          */

[...]

