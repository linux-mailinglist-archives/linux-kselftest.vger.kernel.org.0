Return-Path: <linux-kselftest+bounces-39006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B056B26FBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 21:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6402B1CC7410
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3C2417E6;
	Thu, 14 Aug 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7zzPeVw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641423D7CB;
	Thu, 14 Aug 2025 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755200052; cv=none; b=a40dCST6QqEp4ZY8P5gQ97mtdrN8dUDLBICFq1JTxnUTjDyt9mgp6GkiLMCRoJowR9LLQBmBTWFYpACGRv+yybIbBdR8iL1gRTnUucC93Sxy+zG0NpejQf57IhMt9eZcMNk9jQAvj/LgC/eY1ZTxTdDDLBeNP0RtYtclHnSFHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755200052; c=relaxed/simple;
	bh=Qk3LJxvLrLeL7w90cyKhd7zyf79hwEGsLTIGa7j9CFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NM6vraLxzq30nmsTrKujDl5SNOFpHb6GQAiJySy5jNJrJC24j196WnFMKUMd0cRf31/AqUhixupOa4yzTjuzqZpzSClNibExiR//DhSHpCJ3/MCN9quroQvXdRuPvdz/3osH0EEhGeazeiuCV/nXpwk2PF115RL1dTXtrd7lisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7zzPeVw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so1334985b3a.1;
        Thu, 14 Aug 2025 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755200051; x=1755804851; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ph3lMnf/naqx4kIu+sBrXc4AAuPsDaAu/FwSldVU/DM=;
        b=c7zzPeVwsIW+Za7TxB3Ay2eB+OP8QjqjkCIQy6KuCqQKFX5/5XDL5FG0/WXlewzYKT
         GY2HOrcVngoBe4VKcFz6Lp0V9bL16/R8ERknfXTYr7qYvfQWI1Nm7/HIDlcjUwJDGYDX
         lpbWt2W8q7rEBZZs2j+3q8ZMGTr/lMu+OCxQphcwLy2Q8PgiyllWr5bqbbIpbRiegXHi
         Y2EcxuusvIXuSkiWi7SAou/adKEiQK4w+a9DAy+npYa8rRDTXX00k23jDcFgnqezU9jq
         rthfCurcK1cg0Q8e3iOSvaz1zTJdBPmXwjIfb+NYNUM21JoxfrXm1TLvA4dVhtpnaa4I
         /xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755200051; x=1755804851;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ph3lMnf/naqx4kIu+sBrXc4AAuPsDaAu/FwSldVU/DM=;
        b=F/lQFfPO35wg7+yb13wmPjApl/tC4DoyoSZxHtvkTNLpfAv0WBNRT2u0O+UbK6oynC
         APluG5nQ/ixhduD5FQEO8CHIwE2pp7Ght9KOeQbZdfMWnq5XHyA9qIGSvdyEklt3tPVN
         SEJaSOU80RngTuh4o/lrhqCdPaMzNbVTXnS/PqbiKv/T1PWWzr+UCx/m8+P09fIFgmDZ
         Ci0WzXl7qJr1Ddjq3SftGjPLNUBKZ4EfzW/nccWYj7I47oaZ2PAC4r+l0HJSTnD3XlSu
         Ez9DtyUHq4ZRAF+s/ENfCZySe1l8wCIGGeygLEeK0286vusfwdiIQtLvVNgS3movWeoU
         Rviw==
X-Forwarded-Encrypted: i=1; AJvYcCUN0RO3IGca2+xAzMy0iss8Ph4xdP8S6wt8l54mNpmOiJrbVhqDO/MUh1VMaocDPwCcz0rj8PPDCSP1H8Bdd2QN@vger.kernel.org, AJvYcCWrpPKPgJw6AyzwSKoXXpj/2E+lgYa53GtSOHn5QRZOZu0jABWMJ6LBmVM1OnRa+RzUupsbTAfZjuSPzYDk@vger.kernel.org, AJvYcCWv2jP1AAqDmSRAr7pXt0aRp178QM1DEp7pnFpwBs077YdoCNqOGv7gEgR4Z4F8phJJ3Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJU1NGC5nLsr28M6tWlqN9l+gHrDD0dD95VjBdVdV54OIOPAU
	eGp0laYHtwp4rGKW/Ach1h1RnSFmM7bBgtiR9AcB+5l6lW9behMvgDsA
X-Gm-Gg: ASbGncv/jxB6Jn6VizeVWUSIwwwKOdRTfD04Jk/gRQVDA6EyuX1xiOEKKV7jPyqrAor
	Fyqi/i3HxQt57Jvc8C2rnWjp2NJoN/ubCbHQtisfQZ3JewHgBTIYIuuPFZzyuDS0HP3u7JyMScr
	Elq4vKIe6OGVyGWY5XMsMVrE2O2JoPN7bF8SP60ysgbP6bIMqoydJTQhENWhMKQpAtQmToIsiOV
	zeZSqHFOv10dJFn5FH9WyjPxvw1/yo4OcSrho7XO2PzzvSMfnsXsmwODrqL+ShSiMG2/O5jBdiq
	G+25yV08YYiHF1UmQowZRM8vCPdA4VGGNPtP2TjjjUXbawWKkGMtF1+B0zv7IUTf7LgqRmajESz
	Y1ls0C40Cb+v8NkFVy2c=
X-Google-Smtp-Source: AGHT+IFUEIY9vORrpt4ExifIxwW7E2UMP0tvZ0JoTmokdM7c0a4ZOgc7aGTVAzSPq1YqpkBgsbMT0g==
X-Received: by 2002:a05:6a00:4650:b0:76b:ef69:1543 with SMTP id d2e1a72fcca58-76e2fc0c9b8mr7490600b3a.8.1755200050754;
        Thu, 14 Aug 2025 12:34:10 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e16df3a2dsm7038314b3a.33.2025.08.14.12.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 12:34:10 -0700 (PDT)
Message-ID: <8d9cdce252162519c7679132a5e3235d03ac97c0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: ringbuf: Add overwrite ring buffer
 process
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, Song Liu	
 <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh	
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>,  Jason Xing
 <kerneljasonxing@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>, Tao
 Chen	 <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin Kelly <martin.kelly@crowdstrike.com>
Date: Thu, 14 Aug 2025 12:34:05 -0700
In-Reply-To: <20250804022101.2171981-3-xukuohai@huaweicloud.com>
References: <20250804022101.2171981-1-xukuohai@huaweicloud.com>
	 <20250804022101.2171981-3-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-04 at 10:20 +0800, Xu Kuohai wrote:

[...]

> @@ -278,6 +293,92 @@ static int64_t ringbuf_process_ring(struct ring *r, =
size_t n)
>  	return cnt;
>  }
> =20
> +static int64_t ringbuf_process_overwrite_ring(struct ring *r, size_t n)
> +{
> +
> +	int err;
> +	uint32_t *len_ptr, len;
> +	/* 64-bit to avoid overflow in case of extreme application behavior */
> +	int64_t cnt =3D 0;
> +	size_t size, offset;
> +	unsigned long cons_pos, prod_pos, over_pos, tmp_pos;
> +	bool got_new_data;
> +	void *sample;
> +	bool copied;
> +
> +	size =3D r->mask + 1;
> +
> +	cons_pos =3D smp_load_acquire(r->consumer_pos);
> +	do {
> +		got_new_data =3D false;
> +
> +		/* grab a copy of data */
> +		prod_pos =3D smp_load_acquire(r->producer_pos);
> +		do {
> +			over_pos =3D READ_ONCE(*r->overwrite_pos);
> +			/* prod_pos may be outdated now */
> +			if (over_pos < prod_pos) {
> +				tmp_pos =3D max(cons_pos, over_pos);
> +				/* smp_load_acquire(r->producer_pos) before
> +				 * READ_ONCE(*r->overwrite_pos) ensures that
> +				 * over_pos + r->mask < prod_pos never occurs,
> +				 * so size is never larger than r->mask
> +				 */
> +				size =3D prod_pos - tmp_pos;
> +				if (!size)
> +					goto done;
> +				memcpy(r->read_buffer,
> +				       r->data + (tmp_pos & r->mask), size);
> +				copied =3D true;
> +			} else {
> +				copied =3D false;
> +			}
> +			prod_pos =3D smp_load_acquire(r->producer_pos);
> +		/* retry if data is overwritten by producer */
> +		} while (!copied || prod_pos - tmp_pos > r->mask);

Could you please elaborate a bit, why this condition is sufficient to
guarantee that r->overwrite_pos had not changed while memcpy() was
executing?

> +
> +		cons_pos =3D tmp_pos;
> +
> +		for (offset =3D 0; offset < size; offset +=3D roundup_len(len)) {
> +			len_ptr =3D r->read_buffer + (offset & r->mask);
> +			len =3D *len_ptr;
> +
> +			if (len & BPF_RINGBUF_BUSY_BIT)
> +				goto done;
> +
> +			got_new_data =3D true;
> +			cons_pos +=3D roundup_len(len);
> +
> +			if ((len & BPF_RINGBUF_DISCARD_BIT) =3D=3D 0) {
> +				sample =3D (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
> +				err =3D r->sample_cb(r->ctx, sample, len);
> +				if (err < 0) {
> +					/* update consumer pos and bail out */
> +					smp_store_release(r->consumer_pos,
> +							  cons_pos);
> +					return err;
> +				}
> +				cnt++;
> +			}
> +
> +			if (cnt >=3D n)
> +				goto done;
> +		}
> +	} while (got_new_data);
> +
> +done:
> +	smp_store_release(r->consumer_pos, cons_pos);
> +	return cnt;
> +}

[...]

