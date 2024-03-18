Return-Path: <linux-kselftest+bounces-6403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D076087F2A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 22:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E7A1C20365
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 21:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246B59B59;
	Mon, 18 Mar 2024 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE3VREp5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1994659B53;
	Mon, 18 Mar 2024 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798824; cv=none; b=cAxLZ4EbDDA6/94DnhGCa2doxfDJVnxHya8G0LnmW067Wr5GdiHXc45soBUgdmExtJxDb15uCWyzzSIn7GunG9kmK0zh5EIKNmGn+HvicOVELBaOOHxDzuDVg4lnIp/6UstI9ucBiUGGdK2oVlaFZYBjn6kZgYVQF21e4fo7HnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798824; c=relaxed/simple;
	bh=TMVNZBnuky+xlmSCjV7x5xWLbLKK7AsrIZ3eQuj1Enw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XgRc8dK3XCYtbf1ywrTw1uwjUZJZ4HzlWmt10VhfcIsjdBR31NoKHNz1hOWItZWSi5EzIlma9VN7GhVuYAG6Ma/SOd0egHy18t/AjHpHonrxV8FdICkXDEIucUJ2F+f98XmtIwGOiLQnf3y8qi58IqzCaXDQpoZ5yV15w97mvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE3VREp5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46d9fbb5a5so19022666b.2;
        Mon, 18 Mar 2024 14:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710798821; x=1711403621; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NnQYQBcAPykINWSewEXD0u4daVYuhsM4radIRFdbYFs=;
        b=NE3VREp5sFde6bCi6ihQ4EaSsMb3UxSib5eJNwzdE3yqGBcZubcMNtZLp0M+w8YwrX
         wHYGSP2Cuh9xTX2Cosv9AqEAO9G4/vGEEi8sW27FG62WlgUOCchm8I5c28uHXaKK8gs5
         TpSupcdZChjyHKkQGHERfMo2YDl048RlB7ZDXGJ2ErADNhd1GLdJ8TEZcZ5PjA0W8onB
         m1JE6rNhN13+PJ2jBcH/z4pd+v9QfRpDL1/4zAym3Dq2ougoqH3gT7jwDA5H3CNvS3ml
         I0yOB5PuhZUnBzMlNtDZ9cqH1kxriVBUX4xbeaanY+/lT1TqhR9O0tISWbJ7JrKTAIC6
         8ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710798821; x=1711403621;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnQYQBcAPykINWSewEXD0u4daVYuhsM4radIRFdbYFs=;
        b=h9mBb0ZcyPZARwiV7aMAvnkA5MAaypgxV3ohKS+Zc8/1YMYCDLv/sF/XnOlbJ/x+n3
         KuGfuXXhOEDEnTZBuSupjj4dLNNYiVrSGxwpgVfrQU3YzcgOPGzI+JhcwXSZzf1+S1tp
         mDOnjqaFtxw9XoRjAKVYdcQPNfMX0ErpxuAuBUvaFDheHVrBYgLPEguYGenKa3Bw4EDW
         SsaHI1pl8iWVKy2znRBW9aYjBCE3IMOdC3eD0rkHEF4l8QRCLGesIbQb3wb2e+KhhI1A
         dflFxANTdlxLRCSG5M/UwwqrtTeORfj4TCtiHHNkPkJLyeAqumW914K7UXrYHxQReIvs
         oiMA==
X-Forwarded-Encrypted: i=1; AJvYcCX7VGf2NCP5nzB8DAbtsKHSna2asFEZxZ6fQvl7RbuQ2rpqMS7DRZSil1edHFpQZWLDdrfjyloPRSeMHBJKC6OY/Jm0JjseRUAS8PnnSna4jkEwp1r8inMavSNczVV85P9IMTJhwWLu7rEgUPLM
X-Gm-Message-State: AOJu0YzGEFFKruzlxQ+OhJgg6vNlLaLvLS5bpaoyzn2Rw4b1v5UQBnAf
	LEtDqon58u1FqMVwvC6BOSPaG07h7fz47vYvik4yaNuLAUtfLkmh
X-Google-Smtp-Source: AGHT+IHF2D27pWU94tlJuR1p3Y0pw03GvY7HKfdSE7KhKCAUaVeAWnCINmbgB/pbW1P007iDUUmS/g==
X-Received: by 2002:a17:906:6957:b0:a46:cee9:e412 with SMTP id c23-20020a170906695700b00a46cee9e412mr359010ejs.15.1710798821193;
        Mon, 18 Mar 2024 14:53:41 -0700 (PDT)
Received: from [192.168.6.255] ([5.1.5.0])
        by smtp.gmail.com with ESMTPSA id hz13-20020a1709072ced00b00a46a9cdcfa5sm2969787ejc.162.2024.03.18.14.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:53:40 -0700 (PDT)
Message-ID: <88fde9a0bb55c74fe34667e891572d8af9eec21d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
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
Date: Mon, 18 Mar 2024 23:53:39 +0200
In-Reply-To: <20240315-hid-bpf-sleepable-v4-2-5658f2540564@kernel.org>
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
	 <20240315-hid-bpf-sleepable-v4-2-5658f2540564@kernel.org>
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

On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
[...]

> @@ -12021,6 +12034,12 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  			if (ret)
>  				return ret;
>  			break;
> +		case KF_ARG_PTR_TO_TIMER:
> +			if (reg->type !=3D PTR_TO_MAP_VALUE) {
> +				verbose(env, "arg#%d doesn't point to a map value\n", i);
> +				return -EINVAL;
> +			}
> +			break;

I think that pointer offset has to be checked as well,
otherwise the following program verifies w/o error:

--- 8< ----------------------------

#include <linux/bpf.h>
#include <time.h>
#include <errno.h>
#include <bpf/bpf_helpers.h>
#include "bpf_tcp_helpers.h"

extern int bpf_timer_set_sleepable_cb_impl(struct bpf_timer *timer,
		int (callback_fn)(void *map, int *key, struct bpf_timer *timer), void *au=
x__ign) __ksym;

#define bpf_timer_set_sleepable_cb(timer, cb) \
	bpf_timer_set_sleepable_cb_impl(timer, cb, NULL)

struct elem {
	struct bpf_timer t;
};

struct {
	__uint(type, BPF_MAP_TYPE_ARRAY);
	__uint(max_entries, 2);
	__type(key, int);
	__type(value, struct elem);
} array SEC(".maps");

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
	bpf_timer_set_sleepable_cb((void *)arr_timer + 1, // <-- note incorrect of=
fset
				   cb_sleepable);
	bpf_timer_start(arr_timer, 0, 0);
	return 0;
}

char _license[] SEC("license") =3D "GPL";

---------------------------- >8 ---

