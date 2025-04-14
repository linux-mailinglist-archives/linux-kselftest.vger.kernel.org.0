Return-Path: <linux-kselftest+bounces-30665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F42A87DC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE507A8888
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358325FA04;
	Mon, 14 Apr 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akRgTUF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C001AAC9;
	Mon, 14 Apr 2025 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626922; cv=none; b=Ac+saxKc/FQKhiNG2E8W9yP/alRbn4XJcxvJxwiBoNLUFfcy5wQTIXj7QhLBuqUmcKXu4wXpJo3Diti2bCrKyUaocSxr1ukXYcmTiUwkxU0A3oRBdV22M089kQBBRj7ip+Q3v+i6VNba8cBYzeOSX/7f+VsEVb16wmjyxe+ymy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626922; c=relaxed/simple;
	bh=LzFNm7vUuTMwLQdoaai+8RBoRPXVgM0ZaNqT2+v26qw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKqmdfbE503TMDUh7LRgyKMfIvy9skqLhaVmjtbCjYaJPpUb5F3DKvEwwUiHhtcjliKYGokXVVZ3Fbyirnc27dgqdjpO4gMa8tVcXYcLZSm4Y5O+yWa3OLkZiqgVn10v4Odknu4eq/iOKj7NOnd2DoiqO+I120bWGRpTFeR8jzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akRgTUF6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso41750385e9.1;
        Mon, 14 Apr 2025 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744626918; x=1745231718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHZDEc/B6Kb6mtgnIuZFWtkfOPOyK5ZAt1zozERr6RE=;
        b=akRgTUF6UIxRQK5dgirpd6EX1HK57/kXaaDwXoe+SOZcXExlRRKwcFp4tD7itwMc6w
         aPRTxkSCpwKA0Kq6Yz+aNCOPBZwTmIi9fdmDGoqALZ6pfU8WsjoQ6K5weymAlApetOck
         4RMHhc2g9Xc9YOplrcR8q57Uke4brf6A4AaqeTTBBA30E30k3YLNvwpBhLgNJkOEv7jz
         MaU98ZXjHhuabAlKnWN7HQAfgImfDhIWVXGL+liPWEiUWTtnS/YhhEX4coYqExtu2TdM
         OLqWE04iqhx90bEKbVWKvoX6txemFdmeCMRTEuvVZ/yN2SLSUvs1YstTUcKEkz/IKToW
         zQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744626918; x=1745231718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHZDEc/B6Kb6mtgnIuZFWtkfOPOyK5ZAt1zozERr6RE=;
        b=WiiuRgsYJhgqKd6zifIEpS7Li8mV8nblAjf+Rz6LmsfK6jLDKNS731uEhufes8xZBj
         5LXjm5S5jVTyHU+5tQraUZzFCv7kFbXWRNjL0xgLTiFf0EmdCl5V9dRLR1r6Sa+mIke8
         +Vi72YVC5JLX9F3KUBDQv4prOn2zGes/JRS0xEBpBSOOvyJu4E+42NzDXzC0cKgtlYwK
         xbj9xAQu8+fl+53L4I1L5LaFHr/csMyZAAbTCArTKdZQh/FUYvlJ+FXYmYpUSP7H5eAe
         KnLYQadaXPzJ8cQe5E+aeai0P2VP9Mg5E35SRuNKD/MmtptORnopIIe2cHgEtFhZc6dP
         gIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMnndgmYdLWlzE+rtQ87KwqmHEspzIhpLBJJ4z47pB+NvOzxAcIYHrB5Zf0eqqkxKAf71rm13fMJ1EobjXBcN0@vger.kernel.org, AJvYcCUUN1npG49i0bSOvW3bku3UBPlS3/yTHhGeZDLJfutjp+SCd6TXJ3fiwqpr8GH43ZE589A=@vger.kernel.org, AJvYcCWaEfCCyVEba9bTFrmEbPUrrkfMuNoeRSPCh5m0c6PZ2LHvSmzsC+WQqF84HTmJiWBw5UlxSmeL4Nvw7jmR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ihyDM6eWH70OzJfQ7wrytElxBXzUFUNbSaFLK3zG6Co2BEJA
	VbKpyp5hRqXyc2lIOCTieXGMFvaKI/g4gq5EYec7wq+sFff7BN5i
X-Gm-Gg: ASbGncsCBLW82nQhpzrFd7PXgmMOqEmEmkFfuNuC7UYLIjUaDVuslfHlhyU0jbkP3YC
	XdfJst20pP/3eOHr5zJW2n2Nirj1Bj3DY9xbty0NnmetoKHvrgKVzc7/Tnb3EDKueIR8kgJAsy9
	Xf6dZqCUrmsru7CeRNYGksE1MBllR08jI45PYjAGJwblLtBRL0vibVz4/Ujk5o2wkRHE5D2nqF/
	OiftT00GDjZ8P3DzmdSMVfF/tcap+tBqdBFC8gTjlmNq+eQt50BIJyYGTr2kqBGcPlSdvn7Vzb4
	sc993j4J/gTvKFT7fOp9z8802HKdlts=
X-Google-Smtp-Source: AGHT+IGKgbDkOBsgyieL1ngIJMsRTaNiQCZVtd8adA6qZtmNI2oATQF04wrT4zcBBmJiHXuXLlIKlg==
X-Received: by 2002:a05:6000:4285:b0:39c:16a0:feef with SMTP id ffacd0b85a97d-39eaaec76bemr8253781f8f.38.1744626917733;
        Mon, 14 Apr 2025 03:35:17 -0700 (PDT)
Received: from krava ([2a00:102a:4007:73e1:1681:405:90b2:869b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96403dsm10400456f8f.4.2025.04.14.03.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 03:35:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 14 Apr 2025 12:35:14 +0200
To: KaFai Wan <mannkafai@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mykolal@fb.com, shuah@kernel.org, memxor@gmail.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kafai.wan@hotmail.com,
	leon.hwang@linux.dev
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test to access const
 void pointer argument in tracing program
Message-ID: <Z_zk4kg_qQviauLE@krava>
References: <20250412170626.3638516-1-kafai.wan@hotmail.com>
 <20250412170626.3638516-3-kafai.wan@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412170626.3638516-3-kafai.wan@hotmail.com>

On Sun, Apr 13, 2025 at 01:06:26AM +0800, KaFai Wan wrote:
> Adding verifier test for accessing const void pointer argument in
> tracing programs.
> 
> The test program loads 2nd argument of kfree tp_btf which is
> const void pointer and checks that verifier allows that.
> 
> Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>
> ---
>  .../selftests/bpf/progs/verifier_btf_ctx_access.c        | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
> index 28b939572cda..a6cec7f73dcd 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
> @@ -65,4 +65,13 @@ __naked void ctx_access_u32_pointer_reject_8(void)
>  "	::: __clobber_all);
>  }
>  
> +SEC("tp_btf/kfree")
> +__description("btf_ctx_access const void pointer accept")
> +int ctx_access_const_void_pointer_accept(void)
> +{
> +	/* load 2nd argument value (const void pointer) */
> +	asm volatile ("r2 = *(u64 *)(r1 + 8); ");

I think we should follow formatting of other tests in the file,
a do smth like:

	asm volatile ("				\
	r2 = *(u64 *)(r1 + 8); ");   /* load 2nd argument value (const void pointer) */\
	...

thanks,
jirka


> +	return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> -- 
> 2.43.0
> 

