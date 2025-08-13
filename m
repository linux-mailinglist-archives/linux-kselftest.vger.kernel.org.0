Return-Path: <linux-kselftest+bounces-38908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B8B252F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 20:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907C47A156F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A219F424;
	Wed, 13 Aug 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="ibzqRE0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BE281368
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109313; cv=none; b=rxvhYMXNy7hamEOCl9YlA2VeprPkBa7MJVVNgtOCVHBrytozCboUMED1PZZRzpSXkK/1Em3SzUoIIsCKubLAa/ly5dezrKrV4D9rjfZ4b9R5scEgjfkrSqWjMdqHddoXITe1uheX3PWolU6asTZN+LnZh5W6J3cO3xXVoqhbPmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109313; c=relaxed/simple;
	bh=H7Aok+8AsCNXUKSJni83EqB4Qm6rA3DYVwzZH5/eAj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFQTD0ShZu1HfLjE9yy+BXm2LOSFM/7t1PcjsdeB2z4cf08dmoh4xgEQRYU3a6vJhxcQiItqzA8yjJpKnLZVRiQVkBwFHZwpYyTVyjRBz7HbJvXzUsorNuA3EVZup0xF9ca1EI+eXNrUMkRIHY3+IJ302r/0q1FXJK8hdbS+J+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=ibzqRE0D; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2e8e54f8so189388b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1755109312; x=1755714112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7Aok+8AsCNXUKSJni83EqB4Qm6rA3DYVwzZH5/eAj0=;
        b=ibzqRE0DDjzt16d2wt2NLHbHfReKnm93lrY+oYwY4n0wSUwz3ntidB9bq/vkLwoHwX
         ix3vFqJkdBxldPO+I1JhtoanWBMVQpxoHC5yOPTFbRXlvr7gxlt0eQTBmM6Gsox3Ja/O
         VAzNdvTOM4uM9rp/AACmuXOZz6uRjfpIMkDsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755109312; x=1755714112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7Aok+8AsCNXUKSJni83EqB4Qm6rA3DYVwzZH5/eAj0=;
        b=I/DvHb/f01x+2tKOKBekA/uSjmimv243AsQPriVgaSIiFmbP5HoYWBjdqB2oggZgrV
         lKNwDs6AbzbYZOKG6M3SxTc8UJumpSNQcwNqXEQiubnHbhVavJmPoL7wfvlT0gi4ZcrJ
         0V9KTiF7UNP80pCYpqGareS78CZFgL+mLTN3iKRnF1hs2uJy+60qV3agBp74OemkYajV
         pZgremJImkArydBPEYMZN73Z0gmvahyAXHazsIxzCMeD8dvftUVhzAtHOt7CDPWS1N2n
         Ksolnl5+8HsXgJfXqkHtzAcz6PVqmy2aTrrQuO/2nUXUGXWdRbB+51l8QtuknkUX/oI8
         dq7g==
X-Forwarded-Encrypted: i=1; AJvYcCV/8wtEkCOx9fmd4lHF9+fA+ubGqW9zfORB2wlEkDbjfl+faVmpa9Tu0DjeNO33V/jhJaoYAMWUmV1AOsC/XT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV1qMtK0Jk5LIYQ50X9ddiaBeeVTRb+X77Q7DOOY8lFicDcCQT
	fXQyg9dovzoTdF87+0hiU6Jc07yMMhT8tR3rKWCp95I0EWtj26xULZrZEXvJrDdIAacGsnDLo4f
	MbKHus69l50+68wCBdfk8xigG+rucHB4kMCoTJCZzMA==
X-Gm-Gg: ASbGncvHN3gLlpxuDz2WpHBn3ulq6q1Prw2/dfejxtOl85sA+25X0cgY2KAJczcOOxc
	sz+2YcVUX5tnlLv3beetDc0uDWWtgSJPzwJD5uSgf3i2yworzZYXx3g84j6vYVUNN/Qd3tcOP4v
	QAW/UXXnx2TAV6SsM0AFpuiCUBpSj7amZ1D07asX6lUeqku495ypoqQIDZYq0/dChcfHaeEdoke
	lqjppLRwMFPmVoF
X-Google-Smtp-Source: AGHT+IH1tY6NdVEiDiIOsXh+Mk2DqBPeX3M9xSd8qZwtHHdAHFsFYmz3eY2hG8dt2+kqapTm/ssv5tGMAlMvrUmANCk=
X-Received: by 2002:a17:903:3c46:b0:240:7247:f738 with SMTP id
 d9443c01a7336-244584af6b0mr1439195ad.1.1755109311644; Wed, 13 Aug 2025
 11:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804022101.2171981-1-xukuohai@huaweicloud.com> <20250804022101.2171981-3-xukuohai@huaweicloud.com>
In-Reply-To: <20250804022101.2171981-3-xukuohai@huaweicloud.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Wed, 13 Aug 2025 11:21:40 -0700
X-Gm-Features: Ac12FXz9SYBFn_O1HZA19Q6nLQJmBqaWIiON5vvZTvzhr0qNIx5-gxQZM7Ri3GI
Message-ID: <CAC1LvL2AiNpN86+fz+30ap0Pm5W9C1MtV5sPvupU2uFGoJ94ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: ringbuf: Add overwrite ring buffer process
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 7:27=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> In overwrite mode, the producer does not wait for the consumer, so the
> consumer is responsible for handling conflicts. An optimistic method
> is used to resolve the conflicts: the consumer first reads consumer_pos,
> producer_pos and overwrite_pos, then calculates a read window and copies
> data in the window from the ring buffer. After copying, it checks the
> positions to decide if the data in the copy window have been overwritten
> by be the producer. If so, it discards the copy and tries again. Once
> success, the consumer processes the events in the copy.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
> tools/lib/bpf/ringbuf.c | 103 +++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 102 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 9702b70da444..9c072af675ff 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -27,10 +27,13 @@ struct ring {
> ring_buffer_sample_fn sample_cb;
> void *ctx;
> void *data;
> + void *read_buffer;
> unsigned long *consumer_pos;
> unsigned long *producer_pos;
> + unsigned long *overwrite_pos;
> unsigned long mask;
> int map_fd;
> + bool overwrite_mode;
> };
>
> struct ring_buffer {
> @@ -69,6 +72,9 @@ static void ringbuf_free_ring(struct ring_buffer *rb, s=
truct ring *r)
> r->producer_pos =3D NULL;
> }
>
> + if (r->read_buffer)
> + free(r->read_buffer);
> +
> free(r);
> }
>
> @@ -119,6 +125,14 @@ int ring_buffer__add(struct ring_buffer *rb, int map=
_fd,
> r->sample_cb =3D sample_cb;
> r->ctx =3D ctx;
> r->mask =3D info.max_entries - 1;
> + r->overwrite_mode =3D info.map_flags & BPF_F_OVERWRITE;
> + if (unlikely(r->overwrite_mode)) {
> + r->read_buffer =3D malloc(info.max_entries);
> + if (!r->read_buffer) {
> + err =3D -ENOMEM;
> + goto err_out;
> + }
> + }
>
> /* Map writable consumer page */
> tmp =3D mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map=
_fd, 0);
> @@ -148,6 +162,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_=
fd,
> goto err_out;
> }
> r->producer_pos =3D tmp;
> + r->overwrite_pos =3D r->producer_pos + 1; /* overwrite_pos is next to p=
roducer_pos */
> r->data =3D tmp + rb->page_size;
>
> e =3D &rb->events[rb->ring_cnt];
> @@ -232,7 +247,7 @@ static inline int roundup_len(__u32 len)
> return (len + 7) / 8 * 8;
> }
>
> -static int64_t ringbuf_process_ring(struct ring *r, size_t n)
> +static int64_t ringbuf_process_normal_ring(struct ring *r, size_t n)
> {
> int *len_ptr, len, err;
> /* 64-bit to avoid overflow in case of extreme application behavior */
> @@ -278,6 +293,92 @@ static int64_t ringbuf_process_ring(struct ring *r, =
size_t n)
> return cnt;
> }
>
> +static int64_t ringbuf_process_overwrite_ring(struct ring *r, size_t n)
> +{
> +
> + int err;
> + uint32_t *len_ptr, len;
> + /* 64-bit to avoid overflow in case of extreme application behavior */
> + int64_t cnt =3D 0;
> + size_t size, offset;
> + unsigned long cons_pos, prod_pos, over_pos, tmp_pos;
> + bool got_new_data;
> + void *sample;
> + bool copied;
> +
> + size =3D r->mask + 1;
> +
> + cons_pos =3D smp_load_acquire(r->consumer_pos);
> + do {
> + got_new_data =3D false;
> +
> + /* grab a copy of data */
> + prod_pos =3D smp_load_acquire(r->producer_pos);
> + do {
> + over_pos =3D READ_ONCE(*r->overwrite_pos);
> + /* prod_pos may be outdated now */
> + if (over_pos < prod_pos) {
> + tmp_pos =3D max(cons_pos, over_pos);
> + /* smp_load_acquire(r->producer_pos) before
> + * READ_ONCE(*r->overwrite_pos) ensures that
> + * over_pos + r->mask < prod_pos never occurs,
> + * so size is never larger than r->mask
> + */
> + size =3D prod_pos - tmp_pos;
> + if (!size)
> + goto done;
> + memcpy(r->read_buffer,
> + r->data + (tmp_pos & r->mask), size);
> + copied =3D true;
> + } else {
> + copied =3D false;
> + }
> + prod_pos =3D smp_load_acquire(r->producer_pos);
> + /* retry if data is overwritten by producer */
> + } while (!copied || prod_pos - tmp_pos > r->mask);

This seems to allow for a situation where a call to process the ring can
infinite loop if the producers are producing and overwriting fast enough. T=
hat
seems suboptimal to me?

Should there be a timeout or maximum number of attempts or something that
returns -EBUSY or another error to the user?

> +
> + cons_pos =3D tmp_pos;
> +
> + for (offset =3D 0; offset < size; offset +=3D roundup_len(len)) {
> + len_ptr =3D r->read_buffer + (offset & r->mask);
> + len =3D *len_ptr;
> +
> + if (len & BPF_RINGBUF_BUSY_BIT)
> + goto done;
> +
> + got_new_data =3D true;
> + cons_pos +=3D roundup_len(len);
> +
> + if ((len & BPF_RINGBUF_DISCARD_BIT) =3D=3D 0) {
> + sample =3D (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
> + err =3D r->sample_cb(r->ctx, sample, len);
> + if (err < 0) {
> + /* update consumer pos and bail out */
> + smp_store_release(r->consumer_pos,
> + cons_pos);
> + return err;
> + }
> + cnt++;
> + }
> +
> + if (cnt >=3D n)
> + goto done;
> + }
> + } while (got_new_data);
> +
> +done:
> + smp_store_release(r->consumer_pos, cons_pos);
> + return cnt;
> +}
> +
> +static int64_t ringbuf_process_ring(struct ring *r, size_t n)
> +{
> + if (likely(!r->overwrite_mode))
> + return ringbuf_process_normal_ring(r, n);
> + else
> + return ringbuf_process_overwrite_ring(r, n);
> +}
> +
> /* Consume available ring buffer(s) data without event polling, up to n
> * records.
> *
> --
> 2.43.0
>
>

