Return-Path: <linux-kselftest+bounces-40029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E62B3794C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 06:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B297A3482
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 04:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B91D2D2386;
	Wed, 27 Aug 2025 04:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao5/rIkr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E46726E706;
	Wed, 27 Aug 2025 04:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270130; cv=none; b=IMBoi/TMJ4K/plQAKAHuJ/7P8mJBtdcecRSKIbOWs19v/OiF/zZvhOtWJYA+NCjxBsYROVtyMD1C8i3umXgzqdw9b72ARPXHd10HQt5EkHsAtLxq/myPtNvcNCIiLtO1bZrBEDNnjpIUxJy8UoOthO6KNXI+c67epqy+hNALc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270130; c=relaxed/simple;
	bh=n9iXWg38ZaScmEdTFkS2Fpnd4CBQf6iQ47FIpwxiHE4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q8ENAuRU6werYGBtZeVyX9caajZJtnNZIhSx0A2b6BLeLeKHq+5Gg297e+Dz99AEBmkQM7k1ansQBQPY+6x8TMlPSG78zrNcVOvIpwL3iTKlLfA7IpY2HgSBjwA+eLDOtY4R3/1igopWGENJQ2QyRW6EHjG4qewgjtX4Uozoeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao5/rIkr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77057266cb8so2577673b3a.0;
        Tue, 26 Aug 2025 21:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756270129; x=1756874929; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uM86AKSjc/mfyCmCpvKX7/jvO/X3K+/iBfdvAaEghgU=;
        b=ao5/rIkr3GnARob2BgJtWnuFP8eAKobHRUkIq6pGYdP/t3CkPSlMdF8DvIWCCtCXR6
         qVHD6l+GM7hUPX2Oz8C9qxmOPZ2eIdQZG3LyQUr6jl2SSItoJfYfwTXNQipbRJDqMvVF
         +z+JNLJvZMpK/PvC5UV5PhErFGrES9kAhueL8jEVQLCHuQI3N69rwJ1WYAd1PLi1JayH
         CJjhceo8tm6aF0xiL8ji2uih33OVSVx3TQQtuJbzWsmf5f8fx+/yYwUcd+HeWMMe1N/N
         hiXRLLQqmQ4N9IAp5Xg0qNMEl+RSXKsoL58ucqK42qfXhuYqZBTdT4NIBOe4MNoAofsx
         rcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756270129; x=1756874929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM86AKSjc/mfyCmCpvKX7/jvO/X3K+/iBfdvAaEghgU=;
        b=CFCkg3/VGgsJZ/C6JMuW+Eq4tu7Cm0ykYY+wndADn78cC4q+21P2vrhqHLgTnr8dgg
         Gz1B+aqgBkat78+jdia487pjaG+Xn0yoS5Z6XAatzqcAJE0tBg5opRVuOtUtwMmR3Vv0
         j/Ef3nuIORlHyyzDxRyeJk9Az5536PzTqJYM2f3jXIxnh2h1RHal8is+VM/37xZXwV6w
         1fi6AagONBQOK/+9dvIp1kErOcPlt3ATPalrySfAH+8AImZx52jNKjbelOr0OoAF4FWQ
         8P/5TFIabWcUHLIZVUQEZsB+BJuE+7QWCFQ2oAG8lxSoreezU8J/FBtT90YriEE/vjhD
         YStA==
X-Forwarded-Encrypted: i=1; AJvYcCUjqRZvPLphE6w+nB4JfIV76abhSIQPQi/jqt+8pneXk2czBJBx9syGWXrjZoWGJZRjhoq4uyFrcf9PR5I=@vger.kernel.org, AJvYcCVsvGpJMJEK5FmJfswyNPwRZnFhx2d1ZHhhOlnXqBaj8lEFlMi1oWjrXefoAZT1a+Ww5Yr2V994rupVonH8mAZP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29Ykbs7/2EevU5Hcj0GqYa932U7kUuoYlTbYTp/WkQVg4Xy70
	jny4TRDDUbH/io3WkA4k8JWhk1oqNlZ8VFvHWfk7yw9c+XjH4uY+/EciD2KmSQ==
X-Gm-Gg: ASbGncumXLUMmXR+4DbfzS11xy143llNey7jDKbrl9KIG9riUJY17GExK0Dklzs3spv
	a4hupbwvGFDnn9xWHa74nG8zK1Qs3302xa8P4mgzicEkTjr/y6T1JiqEh2Ljw9L5k9YFLHGSRnn
	wJgBcAZ6xKALwgHNGcnKc9mqt+ALN0jZ6bjeLXWwDEndWbi+gn2y0bS4C7wq10ZWPSBCOocJLFp
	j/a7eaaHn19/H0trdy0Hi1KZl0PzuQDU0RiTW9rBFlWLaFYl5S+ZEc23Ui4rdz30KbJUHRxNzby
	g1tLXVMgY1tk6wTFKoF0+O7XFJ3p4xbpULTLtQUNy3Sh2ewBnVPrFo0XqPJbseUo3x2FFeISAKZ
	zLlA5nGb03Afyp6mHeQ==
X-Google-Smtp-Source: AGHT+IFyFOCy44QMrSl0yaDbGBpVcQSmEmcvQ/OQcUhDh8Uxe77m+aTQYxT5FJA8HUghKnsL+zhGHQ==
X-Received: by 2002:a05:6a00:4b45:b0:76b:e805:30e4 with SMTP id d2e1a72fcca58-7702fad0046mr23669436b3a.24.1756270128610;
        Tue, 26 Aug 2025 21:48:48 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77058df4db4sm8613617b3a.76.2025.08.26.21.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 21:48:48 -0700 (PDT)
Message-ID: <2e20aea407140c22d12f89cdf07605c31c61d0fa.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix the invalid operand for
 instruction issue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Date: Tue, 26 Aug 2025 21:48:43 -0700
In-Reply-To: <20250827031540.461017-1-yangfeng59949@163.com>
References: <20250827031540.461017-1-yangfeng59949@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-27 at 11:15 +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>=20
> The following issue occurs when compiling with clang version 17.0.6,
> but not with version 18.1.8. Add a version restriction to fix this proble=
m.
>=20
> progs/compute_live_registers.c:251:3: error: invalid operand for instruct=
ion
>   251 |                 "r0 =3D 1;"
>       |                 ^
> <inline asm>:1:22: note: instantiated into assembly here
>     1 |         r0 =3D 1;r2 =3D 2;if r1 & 0x7 goto +1;exit;r0 =3D r2;exit=
;
>       |                             ^
> 1 error generated.
>=20
> Fixes: 4a4b84ba9e453 ("selftests/bpf: verify jset handling in CFG computa=
tion")
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/progs/compute_live_registers.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b=
/tools/testing/selftests/bpf/progs/compute_live_registers.c
> index 6884ab99a421..56aec43f206f 100644
> --- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
> +++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> @@ -240,6 +240,7 @@ __naked void if2(void)
>  		::: __clobber_all);
>  }
> =20
> +#if __clang_major__ >=3D 18

Instead of guarding this with compiler version, could you please use
progs/bpf_misc.h:__imm_insn() macro for the jset instruction?

>  /* Verifier misses that r2 is alive if jset is not handled properly */
>  SEC("socket")
>  __log_level(2)
> @@ -255,6 +256,7 @@ __naked void if3_jset_bug(void)
>  		"exit;"
>  		::: __clobber_all);
>  }
> +#endif
> =20
>  SEC("socket")
>  __log_level(2)

