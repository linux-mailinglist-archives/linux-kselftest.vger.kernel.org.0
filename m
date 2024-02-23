Return-Path: <linux-kselftest+bounces-5340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB68614D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 15:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C1C28425A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D93A81ACE;
	Fri, 23 Feb 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6QLetlo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4DB4687;
	Fri, 23 Feb 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700084; cv=none; b=sHsG5p1+j7GHeN4C6CrOxFEtoWSGN0CnFpKa8TK01R1zHDOUPBm/robngBG30qcKE5RJh6MHKzLKHI1MI5KkNKkkLM2FbnGPIf/i6Elb11fBRU8oOBPzD+iuw9UE/08Sm2c9aIe89FJ3mloGK4EJk4fhFZD6pV2mMyd7kEHG1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700084; c=relaxed/simple;
	bh=0BuK+30SS1xLSBY92/ETM4LxjOwrk4Z1jPGUNUyhBbk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fg/Fv9A5zIkPjW1tEYjbb+j44uE4UCYhOTJ/ymgpL9Xl9NiysqHHTlqfpFaWmwqkOw6mmDOh5owe688KKZNjBPvXHCFwYEGWUghvZ801sNsUFQEImMwAzgxYO9ugbDknOCdZK0z7AJJ7ZnRRhsCpN5EjVU3IlmDNRzAZrmKgyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6QLetlo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso105791566b.0;
        Fri, 23 Feb 2024 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708700081; x=1709304881; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGvtW5d4vN3btwDw+y/lEt12l6jVrI+Rv9XtdL0Ln1M=;
        b=Y6QLetloPAbKMRYObcnsriipmYyfdEobw5AoMs+UwHiZqckzvzV+EU/ZItLc3XNOKD
         QMrjlXzWmVZZ9u7JtxS7AvI3/KSe/QlCq7e7Ayb9KC4FrM6DkaoENy3l/VtqoTlLOYew
         pS/tR/2mRqE0+aTp4WJqNWLL0CEMAZJpi1Ijr5NUfWJUxgZJpDbdWtlhpi0Klv+RtxIi
         jqM3hwmU2/AE0XVGIcYRYnrXAGADIFKyih1CdP2oMkR5JfE1Aku/4CHjvBXcgtNeVlBi
         tXIHPwHS5MqWqZDNpJmun1d0EGq1bExQvX/0z/o+bY+QaICdDmok++yNI0cSmGg1nA0g
         bc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700081; x=1709304881;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGvtW5d4vN3btwDw+y/lEt12l6jVrI+Rv9XtdL0Ln1M=;
        b=TjP7YInJeLCrLs+tzeQHpUmqyW20TIKIveO5IGwxx4JRsDBmb2cx/aTxFK9xX2F3Z3
         5RDTtEJ3Uc76WiQkLrZG4cZ6odk707yAMa7+uNMvviumxuLfMsEHBZ4FxF7fL/nADJZA
         3lN4yX54MkOgREoc/gqGGJuTITNB2hv3TUrz8Reg/GhhBZED/cHaLlJ3hO5S73R4k3N3
         wOFQUeOCcEUI6meS4LWOxnXCfDCO6CtPAFt4r3/JSjLJWDUrl/ZPKXBkQ2cm73ERrkZp
         EbVQGiYql3Uiok3sqUH0xVz5TSWHMpygx2NfUOBkkz5bRkRilkLjvR306ZOlIA9Fc/LY
         ryEA==
X-Forwarded-Encrypted: i=1; AJvYcCVqd1B8lIDISmW/LWMdjldXFZv1p/dXgRygj7GzeendcjyuRO2a1JMMkfxvTf6T9VvyZKKVuxVTV8ptmxUw4hhoNYntUA0xtgMNXe02MnjANtn0hsG9xGBuhploR88F6NgbNVvPDR9ka8+SGlYCzW6MJOgc5i8a536au4pt0V1L61ECgLFMlN2+Pj28sItrDPHMSsBKKfr9Zts3GbnDJld+Y2M8slA=
X-Gm-Message-State: AOJu0Ywh4Eyx08urt2Dgv6cbcDZMVoxWYHd1IfOgFnEVOf14re09FUam
	v8KDJMcFAuNI8JMycOQAAnsVUX7j55wbbC45+X36SpyV0B9/F/sj
X-Google-Smtp-Source: AGHT+IGkwF8s3YRoUYAEUX/NcdoANAHlCfDGkQ40OY6ruFDEjObNcdEGLfPl+GMjWGMNJTvyIybarA==
X-Received: by 2002:a17:906:f9ce:b0:a3e:9ddf:9f68 with SMTP id lj14-20020a170906f9ce00b00a3e9ddf9f68mr30028ejb.43.1708700080466;
        Fri, 23 Feb 2024 06:54:40 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id xh8-20020a170906da8800b00a3d8a76a92esm7030718ejb.175.2024.02.23.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:54:39 -0800 (PST)
Message-ID: <ff7734f456427f4afae9f7096ad5a20f810c446a.camel@gmail.com>
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
Date: Fri, 23 Feb 2024 16:54:38 +0200
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

> @@ -11973,6 +12006,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>  			if (ret)
>  				return ret;
>  			break;
> +		case KF_ARG_PTR_TO_TIMER:
> +			/* FIXME: should we do anything here? */
> +			break;

I think that here it is necessary to enforce that R1
is PTR_TO_MAP_VALUE and that it points to the timer field of the map value.

As is, the following program leads to in-kernel page fault when
printing verifier log:

--- 8< ----------------------------

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
	int array_key =3D 1;

	arr_timer =3D bpf_map_lookup_elem(&array, &array_key);
	if (!arr_timer)
		return 0;
	bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
	bpf_timer_set_sleepable_cb((void *)&arr_timer, // note incorrrect pointer =
type!
				   cb_sleepable);
	bpf_timer_start(arr_timer, 0, 0);
	return 0;
}

---------------------------- >8 ---

I get the page fault when doing:

    $ ./veristat -l7 -vvv -f test_sleepable timer.bpf.o

[   21.014886] BUG: kernel NULL pointer dereference, address: 0000000000000=
060
...
[   21.015780] RIP: 0010:print_reg_state (kernel/bpf/log.c:715)

And here is a relevant fragment of print_reg_state():

713	if (type_is_map_ptr(t)) {
714		if (reg->map_ptr->name[0])
715			verbose_a("map=3D%s", reg->map_ptr->name);
716		verbose_a("ks=3D%d,vs=3D%d",
717			  reg->map_ptr->key_size,
718			  reg->map_ptr->value_size);
719	}

The error is caused by reg->map_ptr being NULL.
The code in check_kfunc_args() allows anything in R1,
including registers for which type is not pointer to map and reg->map_ptr i=
s NULL.
When later the check_kfunc_call() is done it does push_callback_call():

12152		err =3D push_callback_call(env, insn, insn_idx, meta.subprogno,
12153					 set_timer_callback_state);

Which calls set_timer_callback_state(), that sets bogus state for R{1,2,3}:

9683 static int set_timer_callback_state(...)
9684 {
9685	struct bpf_map *map_ptr =3D caller->regs[BPF_REG_1].map_ptr;
9687
9688	/* bpf_timer_set_callback(struct bpf_timer *timer, void *callback_fn);
9689	 * callback_fn(struct bpf_map *map, void *key, void *value);
9690	 */
9691	callee->regs[BPF_REG_1].type =3D CONST_PTR_TO_MAP;
9692	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
9693	callee->regs[BPF_REG_1].map_ptr =3D map_ptr;
                                         ^^^^^^^^^
                                         This is NULL!

