Return-Path: <linux-kselftest+bounces-5341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC46861542
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A8285EA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F848003B;
	Fri, 23 Feb 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfvFfg+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8A7175E;
	Fri, 23 Feb 2024 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701063; cv=none; b=AzFz2J4O1IugRvPmcqM2r9gQvlAJwXT050FazOhURkkmIwPDkgfltQWK5tb7bx1BLsa5IcZoV2QG+g3av88sqVzb69Kh5bfvOLS3gfOT+lG2matPJapsYs+CDEtfWWQkNNFvMrwl3s78ibakDAJbhGfN3dnSNynOwF6p8geADTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701063; c=relaxed/simple;
	bh=BWAULHbLWbB+KkcDJOQb/hJls2wOgcOql7I2hoBa8CY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d054YfJTmzIIk+f0QY/T0ThiTYiNXSWyMHkt1kFktOD6u45Q/m9Mb78h34J9WoYAK8BNcVYzODZLCIUnuQzrDg/3siJXqmFv7uISqT2Rhuy0romMoNhVUv3Grq2hxnnl8mVpEqnnoPsNyWxHOLQK7BOUA91+ISRtgfbUaHND3Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfvFfg+q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso549241a12.3;
        Fri, 23 Feb 2024 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701059; x=1709305859; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7PyhNTzfUf4bqC8Lb6m5EtnwVPS+NUJXwDTRzK1tIj4=;
        b=bfvFfg+qm9/WyLsNg0AozEVm8DZDf/VnPZXjH0DJhnrqkM/15DlQShuwg7cGMrlArO
         qS6fRPmrClLboCIU7mOK0StBkARV3pRglNtgf4xGT4oDn2PMjOwAS7P5eXFbIplTgoxm
         Tx/fcGGs9kmUXKlff63m44Qj9u4xzV7gx3b7PaZeIJhVcXGCPjnv9r7Dc9b+zFhOg5nL
         wgtN+wxR8MHqd05lJgk6WAVI3b6bCRjnMm5RIOPBMomIOysZjPaBn3EaxmqoZFkbyYaz
         1emKEt+2zT0Q4hwixNgtNKvnFcL0k3s6IzkCdumEuqu1KOuYLcVzrY6dmmlWQph1GuTP
         fprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701059; x=1709305859;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PyhNTzfUf4bqC8Lb6m5EtnwVPS+NUJXwDTRzK1tIj4=;
        b=cLDz0Jd9EWa20YqwNfZuTwPxxXq04jqcTaCLRlSgCNFD6fsUybXbHwY+s/7fjagIbr
         5aUiV+eQe50AB3lOwHGPgiSF3JFaqqIwNe2QaEFCynBWriL02G8k8fDgtw/DoJiI3XXU
         HiOlolDK4azCP/Ol/4xp69Q5Hb6Qhvqp80326MgZRCoL7X4/pF3o8se8y+YcNf7WvsEe
         KHllkdJQqLBmL3fOXuh74d5PlcGZP1vMtzwes1o7OH8q285vJRs6iRH6/gHMVAdvHpNi
         Zx/RGWh2ojIOIztE1B3K4WdQeZt46bttSeLnuqsb35AfqzczmZVWxSfDW3T2oyBMF21L
         iu4A==
X-Forwarded-Encrypted: i=1; AJvYcCUIAoCFSQnu6PtoNcBUTP1TEdz7eB9/r0fwv8IEk45vPDdULGwOun1YqHJeBlf0WRmTFS7hMdKc/c4u70I0b/sRRZ6nJ5g6iFE30ej3+XfuWEF437Se5LLCyaIWtJ4jRM3wXCyKqxxdVgFtM60ndt9iezkkK8XgfDaB0NVTM+UaHIXQinHl8RBlN8MzG/XdO8z8CLjruS59aEXo91WlTjYorGtIclk=
X-Gm-Message-State: AOJu0Yxy4EY1+2CDFuoKzL0UP6PQkZga/J2iL+c5iaknekZ8PKUazuO8
	xldLqidFEIN1OVS4mslAcMo+XFSutLkq8hHUg6GxJGdGoImvjDHR
X-Google-Smtp-Source: AGHT+IFHLlIjxbqlKvU05Hbq8irfng+ngnvAOtkfFot1E7lqzD44FsrcJtCQceim+cA+lqe+mCkKJQ==
X-Received: by 2002:a17:906:a1d3:b0:a3e:b523:90b with SMTP id bx19-20020a170906a1d300b00a3eb523090bmr45439ejb.14.1708701059522;
        Fri, 23 Feb 2024 07:10:59 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lj7-20020a170907188700b00a3daf530fd8sm6970346ejc.210.2024.02.23.07.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:10:59 -0800 (PST)
Message-ID: <de6b04bdb2627a7decfd6b6c98c1093631a6a87b.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 06/16] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
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
Date: Fri, 23 Feb 2024 17:10:52 +0200
In-Reply-To: <20240221-hid-bpf-sleepable-v3-6-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
	 <20240221-hid-bpf-sleepable-v3-6-1fb378ca6301@kernel.org>
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

> @@ -12120,6 +12137,16 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		}
>  	}
> =20
> +	if (is_async_callback_calling_kfunc(meta.func_id)) {

I think that it's better to check specific kfunc id here:

  meta.func_id =3D=3D special_kfunc_list[KF_bpf_timer_set_sleepable_cb_impl=
]

In case if some new async callback calling kfunc would be added,
for which set_timer_callback_state() won't be correct.

> +		err =3D push_callback_call(env, insn, insn_idx, meta.subprogno,
> +					 set_timer_callback_state);
> +		if (err) {
> +			verbose(env, "kfunc %s#%d failed callback verification\n",
> +				func_name, meta.func_id);
> +			return err;
> +		}
> +	}
> +
>  	rcu_lock =3D is_kfunc_bpf_rcu_read_lock(&meta);
>  	rcu_unlock =3D is_kfunc_bpf_rcu_read_unlock(&meta);
> =20
>=20


