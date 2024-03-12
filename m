Return-Path: <linux-kselftest+bounces-6238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D938878C7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E601F21794
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 01:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32EB17F7;
	Tue, 12 Mar 2024 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko1oQAoX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B917CD;
	Tue, 12 Mar 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208152; cv=none; b=ZAE72WS4Mfniz98H8CJ8qxsCpy8uG69OZ33c2+t3BxXMyUl/RpTUt+4zsF+ZinfHP6Lzjy+2fcb59q5ReVFx4S8QX5PDmjBpXIElA5YZGQdO6ehJ03/xs8OJKUGHako9K6/q76mXzwQyp+D615n0gm39YPryGHaVZHZZuf00tAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208152; c=relaxed/simple;
	bh=cuvDsgXgbUILr0dVgOqpVbHvqupv04o/3bZe8vZd2P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joSrEue/VqK6QV96mxIAfyiEyM9bC3FfHDCzToPAaQrbvkwjItUWPONARVmBx94mjU59bkkps/FJLLFZhgoTJlUtovjJYyGYx2OX4qrm0Z3hB5bgeRVI6kiHJwch++SFxuwDwTjmXc4d5fVTc558y69GVt4kxNFBy4PZwveIAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ko1oQAoX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e162b1b71so4743527f8f.1;
        Mon, 11 Mar 2024 18:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710208149; x=1710812949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICoXbIzO4I+bZEbVSY6istDZPedE1yOS9/In+VkiPyM=;
        b=Ko1oQAoX31K+7gNy01JfVrjNlT5NKrq6q4s9bkgumiHmFaM8ckMd8SiJ51CQD861v7
         YZxOGki1qol9Or7vQeqo3wjvRoXFIacivXTYgM+GH4HvOFYjThPcC5iaf1wjMovQUbaJ
         WKIULx1N0NGQTS/dDzeW0kyX4twQEhphpGBb1KXxTqDq1QFhy8CPaBwMhTVaFHKHJccZ
         vZlom6H6kENQeKPo/G3JI4yMR/FasiOf8aYlLQfcCJnMepgHPxNCRbVMC9RJG7YNS17f
         HoHsXjwf4fvUJ1ZLWqKTHq2gb4ewYZPwtWENn2kT7R0ToVbOruSmXHdbl2tHA+isBIDC
         wm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710208149; x=1710812949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICoXbIzO4I+bZEbVSY6istDZPedE1yOS9/In+VkiPyM=;
        b=n4nMcMBUokUrG+XGiGFuU948TlU92Y6OYhCZamBGPf318vmWU/y/Qhja38OgJoZkku
         TnludvDXG8o5FmxiWZEWbAkSNuBnPgdCeDWm0kFXHDaJifAVLR/3nZIjjS0115VBIDRA
         Ja/ktQkUgY+1BFk0v5TZrY9lRTIiOBRRmy+8by87MY3QNs/oVmHMnGNcqgomxVEruF6D
         yV84Kf/9L9y39AEHMfSY/BZetQcTD3SYwYbeaDik/QmuiyFgPutEY2wI3F7FtdOYnqO7
         8ut8rrGED/bdWLREsOvR9P9n0BaHybJm41zJHgs0Dze1dFrAGNpsXdibeWc+NwFyHGkG
         lExA==
X-Forwarded-Encrypted: i=1; AJvYcCWCV/irAiwCqR9tKTpDCh2i8m7rSU8zPAyeAZXi3E5h4pg/id8EpqfzJinjfMnOo5dDk1lEE+5XKLnzktlL1jQvBTp8kl35TSDRARekGzsA84TA8WNvXVyme897V5q6KPTmCw6lStZZZ9xSk7gVBrX0+bVJxBAduITqhuVwlS87p0ujO8ZqjZMaEidAWGjCsoYp/wTYGdCms8UOnLDspn6slBNINNMz4xIuhDO9nwvK0gyXwDAAq9RlzlYNREwfRC0Lfik1gMR5FZuZx49AqFRF9bXx0VAKwi9TzQ==
X-Gm-Message-State: AOJu0YyBP8y6DYEYwmmIMQ35n3nPERcqb04oZBB75Q5tZ2Go9ipCbu7J
	neR/fW+Kl15T6neN5fU5WEug8I3QwMzIsQ+SWrZrZjCH9JV6STK8uDVq9svFQZqi/2d1YfhfVYA
	bEuBSnPlrxp1wZ2tImX/Z24vov/s=
X-Google-Smtp-Source: AGHT+IH0ci03Wi0rl7FcYFahEcFUmauqEvWpxNG5kQwx4t0HGO1FQxQnKW46ZdilMOOTy/X9M79z6M4R5QoZlsdJz5M=
X-Received: by 2002:adf:f045:0:b0:33e:a5e1:eccc with SMTP id
 t5-20020adff045000000b0033ea5e1ecccmr214107wro.68.1710208149304; Mon, 11 Mar
 2024 18:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com> <20240311093526.1010158-3-dongmenglong.8@bytedance.com>
In-Reply-To: <20240311093526.1010158-3-dongmenglong.8@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 18:48:58 -0700
Message-ID: <CAADnVQK57PziY+xdzW=d3HaG-bn87E3p9zf7thvmqV1t0iR4Yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/9] bpf: refactor the modules_array to ptr_array
To: Menglong Dong <dongmenglong.8@bytedance.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:34=E2=80=AFAM Menglong Dong
<dongmenglong.8@bytedance.com> wrote:
>
> Refactor the struct modules_array to more general struct ptr_array, which
> is used to store the pointers.
>
> Meanwhiles, introduce the bpf_try_add_ptr(), which checks the existing of
> the ptr before adding it to the array.
>
> Seems it should be moved to another files in "lib", and I'm not sure wher=
e
> to add it now, and let's move it to kernel/bpf/syscall.c for now.
>
> Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> ---
>  include/linux/bpf.h      | 10 +++++++++
>  kernel/bpf/syscall.c     | 37 +++++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 48 ++++++----------------------------------
>  3 files changed, 54 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0f677fdcfcc7..997765cdf474 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -304,6 +304,16 @@ struct bpf_map {
>         s64 __percpu *elem_count;
>  };
>
> +struct ptr_array {
> +       void **ptrs;
> +       int cnt;
> +       int cap;
> +};
> +
> +int bpf_add_ptr(struct ptr_array *arr, void *ptr);
> +bool bpf_has_ptr(struct ptr_array *arr, struct module *mod);
> +int bpf_try_add_ptr(struct ptr_array *arr, void *ptr);
> +
>  static inline const char *btf_field_type_name(enum btf_field_type type)
>  {
>         switch (type) {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index f63f4da4db5e..4f230fd1f8e4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -479,6 +479,43 @@ static void bpf_map_release_memcg(struct bpf_map *ma=
p)
>  }
>  #endif
>
> +int bpf_add_ptr(struct ptr_array *arr, void *ptr)
> +{
> +       void **ptrs;
> +
> +       if (arr->cnt =3D=3D arr->cap) {
> +               arr->cap =3D max(16, arr->cap * 3 / 2);
> +               ptrs =3D krealloc_array(arr->ptrs, arr->cap, sizeof(*ptrs=
), GFP_KERNEL);
> +               if (!ptrs)
> +                       return -ENOMEM;
> +               arr->ptrs =3D ptrs;
> +       }
> +
> +       arr->ptrs[arr->cnt] =3D ptr;
> +       arr->cnt++;
> +       return 0;
> +}
> +
> +bool bpf_has_ptr(struct ptr_array *arr, struct module *mod)

Don't you need 'void *mod' here?

> +{
> +       int i;
> +
> +       for (i =3D arr->cnt - 1; i >=3D 0; i--) {
> +               if (arr->ptrs[i] =3D=3D mod)
> +                       return true;
> +       }
> +       return false;
> +}

...

> -               kprobe_multi_put_modules(arr.mods, arr.mods_cnt);
> -               kfree(arr.mods);
> +               kprobe_multi_put_modules((struct module **)arr.ptrs, arr.=
cnt);

Do you really need to type cast? Compiler doesn't convert void**
automatically?

