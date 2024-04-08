Return-Path: <linux-kselftest+bounces-7428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93BA89CA67
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 19:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6663F1F2320F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096A142E99;
	Mon,  8 Apr 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1tlSgsr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151ED142E85;
	Mon,  8 Apr 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596082; cv=none; b=ZxMRnFfYWcZag0C5UubHtTLeA+CMG4dcqVgvgCmbEDHM1RklPPxtrNmMmlRKKq9KDXT0QyEMV6NPeaS8oQXqLu6O5fnqlQ3/fsErp9G6m15E5IGB4hFjXky/dzERk7I1E/aZ85OrwOB3iZELKyhlqGkIj5mjF9jhcuACPBSZtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596082; c=relaxed/simple;
	bh=8AXBpkc9DmcdVZTxpjLc5ajKXA0N+5NVVl+9uENqQ1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WO7AuzpMd9QhZUqO7+Csoe7AIo/kI0JVj/ZJ/Y4u7t+mJyc1TFkZNd7R+csHynUcjZo2So/PDP8tDq0hnq4xVRTVxA2cBbwvcd615zeRV9Rz0mwn4bVgNxiZJld+rVZsanDy6oj30gc4PCtIytjF0nl2PehN83UOZ1Zg1i9PQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1tlSgsr; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so1839872a12.0;
        Mon, 08 Apr 2024 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712596079; x=1713200879; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3rblefnzDeUpBGRU9KzMwI/WwyErcHXFjWyidNir4MI=;
        b=N1tlSgsrvISy6khV/A+21P8mYaij+xiIVejUn+VuAgT4fO5NfccHuj/p8qv++bwuZZ
         J7DGJTbUV0dfpDowDMfbuJjVPDOV+vZr8PTAPXmr4u5eN1lodwSMh2fACQgtk+CI5fCW
         auTDjHAhCechFJWnrg4nQMriCIVcqlqDnX+/Mu0B9hFGp31rbAwRPI9PazxMkXqSknQ3
         HnLPvwVPAv7D12mhdC8btGUiIwi86PRSR/e/PUIr8NrWfN0uRJYcDE7r1/f3ecQahhRN
         UeiuRv8kCaK9WWeJ71jvz8qGKr6T6/TU7dAX4Mpq08kNM45rRiV5h2gmwCfepcE1YxNq
         NhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596079; x=1713200879;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rblefnzDeUpBGRU9KzMwI/WwyErcHXFjWyidNir4MI=;
        b=qjkMQpPTP5By10/c38x3Zz2ANi2RkcTgsfMAKymWkU8L3BhgRoI+882MPew2y9pvuC
         LWtCakw/ckcXZSYwF3ZrqGppHYlUcK0Jqjm7P06DHD7xP5Q01zdmBdJfbqI3LXNsGyQ/
         y3z2g4KVwY8J+1KCLo5F4Z7cbFfRJ3T95pwil5VGD+qILn7NdgERHfyAyGWkb0Ztr57+
         xkV0yiabokP9I9K8C5Foah9dIpr0wEClHvNx8+4OuRcH9Xwx9naoI1xUBYferTHcf2T6
         jZUwxSaoSLt6HpmtqRarPNjlCi7POuFtkifM20PYibtbc2/b2Z4imecFmzii1MODzVrI
         LtCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0DAvWsDay1mZYx1rj81IAUZPr+y0fyvs72sSmvbbiPIR2uiHaIo9bOo8j5HReyEXsfYZx4wfqUyn1ChOI0KguFkxfCCIxr0fcwd0uzN4VMShxN4t+fBCM1olfg0eQqRNY9AzS4Gfr79exvtJF
X-Gm-Message-State: AOJu0YwEDjBw7Kp/9dbU5hyt0SmCyI9Tzv+8eObw4eYXb16P9531jSLh
	S3vZwqMK9yBiKWHiyOsY4XtNam8BP6j3G5pACA4/zMC22Y1S2ux8
X-Google-Smtp-Source: AGHT+IG1DEEuzoXCClJookqK62YxLMOh4p3ScRQPHvmWZ4rPoV3Kwit6nDIzL2HlBDLLsBO1e1CDFw==
X-Received: by 2002:a50:c04c:0:b0:56d:c40d:b921 with SMTP id u12-20020a50c04c000000b0056dc40db921mr6356885edd.20.1712596079128;
        Mon, 08 Apr 2024 10:07:59 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id h1-20020a0564020e8100b005682a0e915fsm4280069eda.76.2024.04.08.10.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:07:58 -0700 (PDT)
Message-ID: <65c249a6af45bfa5fe0f6c2331dcc1771a6f0b05.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 1/6] bpf/helpers: introduce sleepable
 bpf_timers
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
Date: Mon, 08 Apr 2024 20:07:56 +0300
In-Reply-To: <20240408-hid-bpf-sleepable-v6-1-0499ddd91b94@kernel.org>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
	 <20240408-hid-bpf-sleepable-v6-1-0499ddd91b94@kernel.org>
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

[...]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9234174ccb21..fd05d4358b31 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1096,12 +1096,19 @@ const struct bpf_func_proto bpf_snprintf_proto =
=3D {
>   * freeing the timers when inner map is replaced or deleted by user spac=
e.
>   */
>  struct bpf_hrtimer {
> -	struct hrtimer timer;
> +	union {
> +		struct hrtimer timer;
> +		struct work_struct work;
> +	};
>  	struct bpf_map *map;
>  	struct bpf_prog *prog;
>  	void __rcu *callback_fn;
>  	void *value;
> -	struct rcu_head rcu;
> +	union {
> +		struct rcu_head rcu;
> +		struct work_struct sync_work;

Nit:
I find this name very confusing, the field is used to cancel timer
execution, is it a convention to call such things '...sync...'?

> +	};
> +	u64 flags;
>  };
> =20

[...]

> +static void bpf_timer_sync_work_cb(struct work_struct *work)
> +{
> +	struct bpf_hrtimer *t =3D container_of(work, struct bpf_hrtimer, sync_w=
ork);
> +
> +	cancel_work_sync(&t->work);
> +
> +	kfree_rcu(t, rcu);

Sorry, I might be wrong, but this looks suspicious.
The 'rcu' field of 'bpf_hrtimer' is defined as follows:

struct bpf_hrtimer {
	...
	union {
		struct rcu_head rcu;
		struct work_struct sync_work;
	};
	...
};

And for sleepable timers the 'sync_work' field is set as follows:

BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *=
, map,
	   u64, flags)
{
	...
	INIT_WORK(&t->sync_work, bpf_timer_sync_work_cb);
	...
}

So, it looks like 'kfree_rcu' would be called for a non-rcu pointer.

> +}
> +



