Return-Path: <linux-kselftest+bounces-4871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3653858329
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 17:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B401C22F4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8EA130AFE;
	Fri, 16 Feb 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7vq49DO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D01E86B;
	Fri, 16 Feb 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102718; cv=none; b=PmciqTp8c2cE2Hm9GXy7L1kw1pNYZ1+TasQIJDeVwnsXjHzK6FdydXSP/Hyw0ZYRqyjA+Kb7aysBg9IIV37EcliFFpHQA4MP0emXOvF6TiaT43H1Q0u7mJvuUoY0D3pumzpaEJpRwbRZtw2PamTH6y06x0d63Xc8Sz/QeVuNaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102718; c=relaxed/simple;
	bh=5+/OALfWeGla2oIoNvZlD1Lmsrn4u5yZITZBsot76aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qu+c8uCJECK/YzQ+Lszph31NoPCUXyyIO88Ti+S6mPdJR9eYVzW93Jy3IGnC6aGWpKcyObZ9pb6PtHyeDQG3RGL1T8pZzjWoEfTKDyg5Bn20EucRsZopRpJd3rKpCYSamPhdfqd6PDLmASSOGW81RX6hi5C81sBAcjsNEXZ7iFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7vq49DO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6080a19ea1cso1355687b3.1;
        Fri, 16 Feb 2024 08:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708102716; x=1708707516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8H6TMdxbH3gjPcLATt0FrG9vNldFLghzgP5wmvBiIh8=;
        b=S7vq49DOS9MmNmCsn09F0Nbb9mPTtadpeu0vFbwDsMZY+qhWKS5E4ZyXHuXB91jCuZ
         bKdSdZzqG65Q57GrFeODpbt6iyew31V4IQKIDaPvzdC0KqrNTRylXgKVLVIFliewHi1m
         aoYeySrHDzTqddhHbMYetqb8wc+MPNWQTL3WIGJa4tmY32LCAHIpdr7qkTo4cxvsZg7F
         6RRN17jSdaQQ2haRTPtMz5uSsIYRkrcqlzuNe4cXVXi0aKB5weH0adMMc6l2ctOH48KO
         /f4HnSHmr21RrlyE3CSgUz1RpTQcrIv39KV9hAgfRF4UJaxuHgAla7mmqgIJU3LJZt1C
         KIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102716; x=1708707516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8H6TMdxbH3gjPcLATt0FrG9vNldFLghzgP5wmvBiIh8=;
        b=tT0rnBFBp1amTQSDdudu5WGfCIO5Si3rP2tOAoAAIZvh5TrPB/hXImkY3lS9Cxfnta
         0jB1hbvjed1NZWIWQCDEuc9qOLkr7+ww3lmhTAH6moQSF2NzOe7FEc8MlBSZQYwh9qrh
         6fKgXM2wdcGRxLuJM8FiZK7vwpZA8koODUHlo9yTA9Vc2lgzZFitg39dWps2ehAgx2/r
         rGhlxn7/3rQUYO9UBalDHU1TZOM6sHbN9mEoHtpQ5nCJz0fDFVZtSFFNvL3kqejmpCvO
         8sED0qcp96KCn1qTiU6UfX3DDSQFppo9ODUiw1SIdxIUP2nE73tg3C6xDNBynnpjz4J1
         ISIw==
X-Forwarded-Encrypted: i=1; AJvYcCULHm/mVBH7i+JAMwcfTp27/8f1hvjIXh3n2wvwo5/kuIwSoF7hAVP1AYwCEz6BMVxx7RE9AELvLl7hVdsFBdawy2oppnjTCpJPScD4pRwMJLLudl8EWcmDk7T/aqOgDnv80J85S5FTZflbC3zrQ/l6p4Mqnz8VfGuqQl+SfQ8rx+IdGVNymi8He/XJz1f2xiv6wjRgSL/tYNwhpVNoHMJECboujLs=
X-Gm-Message-State: AOJu0YxeS4lVEfO2Jyktx+8qWfzkx95jXgak1HiincdxTakMoyOqbYip
	+sy/sgxvCYP4DjKa01VlPAi7Q+jh9CRQ6E1CKfHmGTYqs5zhYpTM
X-Google-Smtp-Source: AGHT+IHsZLlv0bnvl1IPIWJwHKXapZEQIGK/QbfI4G4e+bag5U0aBYv91MatrSQU/R1DWMpQB2G3Bg==
X-Received: by 2002:a81:6cc1:0:b0:607:d048:bd23 with SMTP id h184-20020a816cc1000000b00607d048bd23mr5474345ywc.20.1708102715908;
        Fri, 16 Feb 2024 08:58:35 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:6477:3a7d:9823:f253? ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id n1-20020a819e41000000b00604d60609d9sm400781ywj.121.2024.02.16.08.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 08:58:35 -0800 (PST)
Message-ID: <51b1ae50-161f-435e-afe0-6d11f2cfbfc6@gmail.com>
Date: Fri, 16 Feb 2024 08:58:33 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
Content-Language: en-US
To: Benjamin Tissoires <bentiss@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/24 09:18, Benjamin Tissoires wrote:
> +static void bpf_timer_work_cb(struct work_struct *work)
> +{
> + struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
> + struct bpf_map *map = t->map;
> + void *value = t->value;
> + bpf_callback_t callback_fn;
> + void *key;
> + u32 idx;
> +
> + BTF_TYPE_EMIT(struct bpf_timer);
> +
> + rcu_read_lock();
> + callback_fn = rcu_dereference(t->sleepable_cb_fn);
> + rcu_read_unlock();
> + if (!callback_fn)
> + return;
> +
> + /* FIXME: do we need any locking? */
> + if (map->map_type == BPF_MAP_TYPE_ARRAY) {
> + struct bpf_array *array = container_of(map, struct bpf_array, map);
> +
> + /* compute the key */
> + idx = ((char *)value - array->value) / array->elem_size;
> + key = &idx;
> + } else { /* hash or lru */
> + key = value - round_up(map->key_size, 8);
> + }
> +
> + /* FIXME: this crashes the system with
> + * BUG: kernel NULL pointer dereference, address: 000000000000000b
> + */
> + /* callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0); */
> + /* The verifier checked that return value is zero. */
> +}
> +
>   static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
>   
>   static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>   {
>   	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
> + bpf_callback_t callback_fn, sleepable_cb_fn;
>   	struct bpf_map *map = t->map;
>   	void *value = t->value;
> - bpf_callback_t callback_fn;
>   	void *key;
>   	u32 idx;
>   
>   	BTF_TYPE_EMIT(struct bpf_timer);
> + sleepable_cb_fn = rcu_dereference_check(t->sleepable_cb_fn, 
> rcu_read_lock_bh_held());
> + if (sleepable_cb_fn) {
> + schedule_work(&t->work);
It seems nothing to stop the timer from being free here, right?

You should have a way to make sure the timer & programs here is
still alive when the work is running. For example, it can be flags
to indicate the work is scheduled to prevent the timer from releasing,
and indicate the timer should be free when returning from the callback.

> + goto out;
> + }
> +
>   	callback_fn = rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_held());
>   	if (!callback_fn)

