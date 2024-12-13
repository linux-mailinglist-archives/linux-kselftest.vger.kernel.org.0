Return-Path: <linux-kselftest+bounces-23378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED69F19B7
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 00:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF46F164F31
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4191B4155;
	Fri, 13 Dec 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky2aUSRC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162E11A8F98;
	Fri, 13 Dec 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131660; cv=none; b=AYC4+xkSmlCTclZFtTXN22JsWHVZphQlVUnXrcUMy8fpzvRQ7ZJJfVFurbmggr/6W+q/LPbAHrgfyln5iJ2HCeWVDhLh8kwPwrJviVO1X/Bx2QT4XqyafzqnXk3cZXwSLjB/slFsxdq99QtFYZymh+ndUMbQmWDrW5IDnUFC3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131660; c=relaxed/simple;
	bh=hKezC6/2ZW5cF63eVPLSBC2xpLBXRK7xHDpxFYYE5ao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHc73wTHvSmi7MW/9lrlk0b7ie69q60MA+9zHgKO0YvvGMK7efAQYs1wMwraXNtXoEVnOsKRnl7LdMQjBKAwJ0p4W10uyzeYtdyMZQNBvIzVU6WPnxfHCLHvA82FDlk9/u6g/vIVbf+j5nlaNt4i1iqmjuuDESMnqAQAtcyZL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky2aUSRC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd4998b0dbso1949532a12.0;
        Fri, 13 Dec 2024 15:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734131658; x=1734736458; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zCvik0BFfR3REMeSDvH2UBjzyVcZ3NxdX9i+fk5iEQA=;
        b=ky2aUSRC4KvneoJuX7nDYQf9buitvRnG1O9O3RjNsTay8G0YppSz/t8j6H6Q6zE3qM
         vSeo3+dY/r/zyxJNUSucDSjRzmOEnO/xuQSW8qwKcPsjIl96h8oH2f5BCGiCok53aYuj
         atyXDuPgcMEsPwSYNU6jD+9VDxHGjpWBVEKggria93wLEyvja57hpOA3QARZ5plzNW6e
         8fDP1NUDgdeAdu8r0rzwszajgruZN+zK80Kfp8zWj3CLOBDwQc9jMUo02t/q9NBERled
         dDdxRO+NVFZTWAWQX8mrr0ns5n+OZamVNklfvDInAXkqMGcjz1g4a1nJocRa3R9QMp3n
         aVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131658; x=1734736458;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCvik0BFfR3REMeSDvH2UBjzyVcZ3NxdX9i+fk5iEQA=;
        b=uswULYwehHLAXN7w7KSBpRl4VCC2c8TUq1gvH2J1AMhnVyviAttT4O6JUaLuI3sEql
         B3AJ+JkwRPBr2a7Zd67M1DUrW86+DrvgCH1cYtHzBDlIE2Vbyvrd6TZFcE/U9A1keHLW
         P05EBD0Oce3CP7CTx74e68KtHlhXD/Kc/iuP1HJy3ufgwZ9TrWRtaVYu5+adxpSUAgMo
         lnEz6YIhH81s12LirpbpuVelI1OoQtMG/WYsrTXlaUsxjx/4YTo4weNnQVFKw2OyhzDt
         qTx8WEXLhuiEZ8qaeFIeq3ndAqXq4tyPhW4t5umQnm4J3pSsd7b9psFAdYEXJviKhOAe
         tnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV26jZABjXxxz+We6oXOHffdnJM7+rx2Ui6kDuxVpp3y37JHa3HSF2WMNA1cY3T5+wlZzp4xHrp@vger.kernel.org, AJvYcCVkOJqux3Vs1JlADQesf9c2RlFDK2fFx7KkEeffKX4K9M4MBZZqkiI+NZBkm4IQLGiUQL1SYiXhr62YgaOJ@vger.kernel.org, AJvYcCWPkHTHp9EIFOTziquKvPGBvr93oMnT9M4fIVU/dAMWDd09j4SjS1cB95xTG+kjcoxEd5hJmzyy/rParYfwuI4W@vger.kernel.org, AJvYcCXlRDuuhJju3jK29CkxIPPCmoD1uhKKbL7ueRFNKqGjy7SMt+04IgVzJzV1c9OMhPyj6ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDxmkn0twnGE/n5tthfbpKeC5RAI+Il1+s0u5LifLn4te145A
	DfEKl+LM+CLFU4epvdrdeqfrEudXASWRH5IIoIsfd17lvxakTJ0O
X-Gm-Gg: ASbGnct3X1Ac8c8BLsHxNFtoy0zzCdDkNGTDb6FaOsxa1lL9OZHPr85kH4uVxeNUscO
	UBkUdWPH/4VkRlLb1siAq18AiJwyWR+fduoH6mi1u/vUJg4AIgt7LC3pX6JVW7SF36SFBN4TMtl
	1zLAh6CliGBizKMbMFfFl0im5vQPpyEqvcF3jEqx4yxEKTmwbp5pVjrp7KCx5It3692XQDLaoIV
	dmxsRBxhYYqdeQA2PqNMWUA1BiVIpUJ957AtD7AhKsHP9D6bnjOOg==
X-Google-Smtp-Source: AGHT+IHjJ0tA7hlbFBWwcdUeow1JGLtUtYIpcg7PJHyofYRIKLhzpNxpSDao8x/5m7VBpr3f9FXyGw==
X-Received: by 2002:a17:90b:1e05:b0:2ee:f1e3:fd21 with SMTP id 98e67ed59e1d1-2f2900ad7acmr6240686a91.25.1734131658255;
        Fri, 13 Dec 2024 15:14:18 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5aa8dd2sm258259a12.20.2024.12.13.15.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:14:17 -0800 (PST)
Message-ID: <f99a31f62c19262fcad7debf10ede0bb0b970af4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: andrii@kernel.org, ast@kernel.org, shuah@kernel.org,
 daniel@iogearbox.net, 	john.fastabend@gmail.com, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	netdev@vger.kernel.org
Date: Fri, 13 Dec 2024 15:14:12 -0800
In-Reply-To: <CAP01T76UQgb=Y0kh6bKPABt=p8=JRmDHsFc31rsijXSrK+5+8A@mail.gmail.com>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
	 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
	 <CAP01T76UQgb=Y0kh6bKPABt=p8=JRmDHsFc31rsijXSrK+5+8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-12-14 at 00:10 +0100, Kumar Kartikeya Dwivedi wrote:

[...]

> > @@ -11199,10 +11266,17 @@ static int check_helper_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn
> >                                 "kernel subsystem misconfigured verifie=
r\n");
> >                         return -EINVAL;
> >                 }
> > +
> > +               if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
> > +                   can_elide_value_nullness(meta.map_ptr->map_type) &&
> > +                   meta.const_map_key >=3D 0 &&
> > +                   meta.const_map_key < meta.map_ptr->max_entries)
> > +                       ret_flag &=3D ~PTR_MAYBE_NULL;
>=20
> I think we probably need mark_chain_precision applied on the constant
> key since its concrete value is made use of here to prevent pruning on
> it. If it's already happening and I missed it, I think we should
> atleast add a comment.
>=20
> For context of a similar case with tail calls, see commit
> cc52d9140aa9 ("bpf: Fix record_func_key to perform backtracking on r3")
> for what happens when it is missed.

Great point, I'm sure this does not happen.

[...]


