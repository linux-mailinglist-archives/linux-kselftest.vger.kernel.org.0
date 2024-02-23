Return-Path: <linux-kselftest+bounces-5323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F6860795
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 01:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F752863FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 00:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF754683;
	Fri, 23 Feb 2024 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYQACHTF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0E1FA4;
	Fri, 23 Feb 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647782; cv=none; b=caKa4FIkTBMIRE8Vbf0mBolEMSmYm3baeCWRfYkDQPFla8AQnCRn5yGKwpHiQEIxSHsSTlZrdFL6ywOhnhBG2xeSsTfwM7n6sMz2xQqfYh2IkZ1PmRjxo+PCMPbPopiRikt4UDInjUObXCL252wzAQM47s3Ch4/2fHD3zogIKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647782; c=relaxed/simple;
	bh=7tX1GAocEd07ccqjfKWiuvIAsJ+N5l5BrHfQk6hx/s8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HC/n6nOuRtizvPfZV2N8tgi3MtIV+cHr5lYOOMWIf3xmMpnofFoalh7z0KpBPK+NaL6RqSmTi2GyioxEUASP1kh2eosFcYliFj5xbuI1PK8kRQE+mwirN/tTsLzljnZQcPBBZi3f7LYUIWrOKEL90S3lZNVi+tjpFzkZnqIzQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYQACHTF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3f1bf03722so35706666b.1;
        Thu, 22 Feb 2024 16:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708647779; x=1709252579; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bgheOTtd3F8Gn9k02jHCqfN2g9V2/oV0hVwXAXgwknA=;
        b=ZYQACHTFJFVSrnakR+F2tYjLBapaKVc271UnuZAiYG5nb2j6Xre9xOqctsvPhGFSiR
         44RbewyqAywSiWMBGcySvrcagz5hGWdJ3mFdoE3eM0KYQT53v6tEvxKGcU2VUuEd3AYR
         Bq0W21KU9iIUjg1LiGPPHUdADjBOs/hehayQysLgUDqYK33RoryRUXOA2VTjvWDyKin+
         Ex21ZTIddKm09spkAs37MDuOo5nghcKGpwmJw4rPonKK7EKekSyqhYZHXKVMK+/EyHXf
         s53pam7wKnH7JpPWS6nxE5oWuXwxNMYL86RS3vSiKPfK8g+kIdem2MiYKtqxK3tPEFFK
         8u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708647779; x=1709252579;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgheOTtd3F8Gn9k02jHCqfN2g9V2/oV0hVwXAXgwknA=;
        b=EKTZQQswpMdMN3kJfcudJHN47wKsZCnsPiloOGicnV36L07UXzR9tzhf1ppk91W1F+
         sl/5WZ1mWymZDFfn4dDVCv4OtjeMyhxOrbz60TPj8d9OIpkO/DgWnj28KLvszWI8G6r7
         gLarP4K0lVeNRbdYeNH5hCI0TnBaJ79HkL6wPdCKVf8foTn+19EG2wZzPbbrf13R4daw
         cfnYHkG/pwbJVk1r4KZA4nUsgn/YWxk5rtqaPPt/2ZG2fRpP5/wFWHe5LNQAzt0xdZT1
         Oxa8kzjFCrpa9ra1BZUt/3Xf1s9txJWxoz22lM5rfFif5708F6oI1vuX2HrSHqW+z5Xi
         x3vg==
X-Forwarded-Encrypted: i=1; AJvYcCVGTLysQOpdbPKwZzmwe5sbuF4gq3aNNW/LzhA1vIlT9T6VhutheRyoGylswhFa2issEibdF/318ZOcNejxDHjhFScotSqlxCUjyRlbHkohB3NuVtpntESSWwU46Dh6484froEm+6y0oAk2YB+I8H63tHwcSrJ5bO+3bRE5wxWaNJy2aDsbn4iqIYCJLP5nL2Ugl56GfHcXVrY1/mW1gv4N3Rd/eoY=
X-Gm-Message-State: AOJu0Yw24O9g4DWuiJ9iF01XYYp0IgJtlpu/9v4DYsuFsOLYU6SzLqYm
	lDyGzMliMvzl5Mbb8Hsgq+HU8WG+kMP4S3IZ9c42iujB10FeyXOo
X-Google-Smtp-Source: AGHT+IF7ITolOWV3qwakaKGLXFoZRE02kzTWXxIVtRLzEz3bKtClCz8M92y76pv2zOMyQo+5pa3H7g==
X-Received: by 2002:a17:906:c346:b0:a3e:d890:3756 with SMTP id ci6-20020a170906c34600b00a3ed8903756mr219392ejb.36.1708647778854;
        Thu, 22 Feb 2024 16:22:58 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id wg4-20020a17090705c400b00a3d99415705sm6356776ejb.73.2024.02.22.16.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 16:22:58 -0800 (PST)
Message-ID: <dfbb1464e99e057d77f78395d985208d6510040d.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 05/16] bpf/verifier: add bpf_timer as a
 kfunc capable type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 23 Feb 2024 02:22:55 +0200
In-Reply-To: <20240221-hid-bpf-sleepable-v3-5-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
	 <20240221-hid-bpf-sleepable-v3-5-1fb378ca6301@kernel.org>
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

On Wed, 2024-02-21 at 17:25 +0100, Benjamin Tissoires wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f81c799b2c80..2b11687063ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5444,6 +5444,26 @@ static int check_map_access(struct bpf_verifier_en=
v *env, u32 regno,
>  					return -EACCES;
>  				}
>  				break;
> +			case BPF_TIMER:
> +				/* FIXME: kptr does the above, should we use the same? */

I don't think so.
Basically this allows double word reads / writes from timer address,
which probably should not be allowed.

The ACCESS_DIRECT is passed to check_map_access() from
check_mem_access() and I don't see points where check_mem_access()
call would be triggered for pointer parameter of kfunc
(unless it is accompanied by a size parameter).

I tried the following simple program and it verifies fine:

    struct elem {
    	struct bpf_timer t;
    };

    struct {
    	__uint(type, BPF_MAP_TYPE_ARRAY);
    	__uint(max_entries, 2);
    	__type(key, int);
    	__type(value, struct elem);
    } array SEC(".maps");

    int bpf_timer_set_sleepable_cb
      (struct bpf_timer *timer,
       int (callback_fn)(void *map, int *key, struct bpf_timer *timer))
      __ksym __weak;

    static int cb_sleepable(void *map, int *key, struct bpf_timer *timer)
    {
    	return 0;
    }

    SEC("fentry/bpf_fentry_test5")
    int BPF_PROG2(test_sleepable, int, a)
    {
    	struct bpf_timer *arr_timer;
    	int array_key =3D ARRAY;

    	arr_timer =3D bpf_map_lookup_elem(&array, &array_key);
    	if (!arr_timer)
    		return 0;
    	bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);

    	bpf_timer_set_sleepable_cb(arr_timer, cb_sleepable);
    	bpf_timer_start(arr_timer, 0, 0);

    	return 0;
    }

(in general, it would be easier to review if there were some test
 cases to play with).

> +				if (src !=3D ACCESS_DIRECT) {
> +					verbose(env, "bpf_timer cannot be accessed indirectly by helper\n")=
;
> +					return -EACCES;
> +				}
> +				if (!tnum_is_const(reg->var_off)) {
> +					verbose(env, "bpf_timer access cannot have variable offset\n");
> +					return -EACCES;
> +				}
> +				if (p !=3D off + reg->var_off.value) {
> +					verbose(env, "bpf_timer access misaligned expected=3D%u off=3D%llu\=
n",
> +						p, off + reg->var_off.value);
> +					return -EACCES;
> +				}
> +				if (size !=3D bpf_size_to_bytes(BPF_DW)) {
> +					verbose(env, "bpf_timer access size must be BPF_DW\n");
> +					return -EACCES;
> +				}
> +				break;
>  			default:
>  				verbose(env, "%s cannot be accessed directly by load/store\n",
>  					btf_field_type_name(field->type));

[...]

