Return-Path: <linux-kselftest+bounces-11423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2037900AC5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF91285369
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2D19AA5B;
	Fri,  7 Jun 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYIY/KbL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2E18059;
	Fri,  7 Jun 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779109; cv=none; b=Jo4HEzeOKyz+BCuM32R2lljja8X6oEiD2wPqAfCYGFgMpr0iwA9tJEGAFi00kz7CCYs1KHCWSg+5uimeWwFH8uMyDjUVc6Y9kw19KO58BiLf++S4h/3RhfAgDrQ9taN2MLSgGtu/uiFMPyp+4F5QQeUjIR8Z4jDPLOQITA2/ahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779109; c=relaxed/simple;
	bh=1bJjhIo+skwf0sz4/9yRR4Oy///FQ4QnkOz9x3xs0W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDDH3Q9aznlwl8nvYoMfnM8rAqNchpv/6wGptXXlzWIuHpFEA+t0SHoom1784V70oxB0p6DXJ3oKagrOLJUb0UMu5butGyNvgHL1JwZ/wDjENkEZwYQkq6FsqGH24jFZrRpqks1t2ZkHNAboPjAIjbDjiJhQ3jh3xNQ7Ns6bUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYIY/KbL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217926991fso2202045e9.3;
        Fri, 07 Jun 2024 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717779106; x=1718383906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMxkWvAB89M9V9iTWfyILXsU7ZFICeIaKzWoaQWGLXg=;
        b=iYIY/KbLE0cGYut2x9p1MDydEElrra8mGEnNBLXQsOuCX4SscFrVTzAPLsxxwxBQw9
         IMfDqVb9kXYaCn7CCMi/VNkaA4DJrCLetwCzugrNfudVolr/YQvY8gNWFieYb5YEBt4G
         gINHGn2uCCK2idUr/m2Oj2Qt0BgsrvQxjeIAkSj2CX/gIMJ5geeXoQbut6R2FMC5XDtD
         nCop0If3qMkpkDjyPi4tIVjqh6wPtwgCQvviQpZNgXKmt5EyIHNgAK1wHhywoLlH86l5
         zl5L8yMj2HoIGQnkknhkuBLoe4QPNbotxMphC6nmx1z8gc7VIFxz7OGEQRT4maRJNFHa
         Aoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717779106; x=1718383906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMxkWvAB89M9V9iTWfyILXsU7ZFICeIaKzWoaQWGLXg=;
        b=r+p8zjajLpjf02uD0IDS0IZp0halm/AjFZ3NnjKmLXnLeMOrqbY8Es0HEEOY7tfCVk
         3Ff9GVfpbVQqrT5t36ydBtE1xWcXe5OQp95EkhTIv3B3lDnPWaZTqRk6smJTCJL/VvOI
         I5PEfCwNmgO4L8j9VQVyXfJvEbMK4+h93yROdFFtdZbGKcQIABXlaSrZkxTK7185G1Ty
         mjtADS2q8ZEMlAKiihGn6YGVGdxZSyyw88ngobh4x2pssdJn1zwf8Qh8x29DPAu6cl2Z
         o6pvQljS4Ukku7YN5PUTQyIJAqrexbXYtDyls4QMr3DD6GOVsulAiwy5gGHIAJ6eLtA/
         s8xA==
X-Forwarded-Encrypted: i=1; AJvYcCUPhk6/aK/wFPr/AXGQQkMLRVSma8he3pezNSf3SXdix8tLuHI6d4c+AEveVFg2PD9t5us0B6SZbqfTGpt8dgbsJUjXlwIbDEgxmZG5TyfvWwkvODvEBqH/lKznBQSWPUvuFRPXKrRNKTVY7Ftu3e6U0vr4dk1O3+CKHU1na5tU/wvgJgycoq4iMJzt9vmbmJhdfPyvHrufHEnbc1Zf4zxjs/9srtcY/EyrwY4XVMiySHP5DoSQHOprWC0=
X-Gm-Message-State: AOJu0YwjsVBoDzyXGBERxwb/7oKsJ6ZsCpqBfJIWG0D82PNlJNNlPL6W
	e/3d7hMEb7dOqJ1xG5qhb4L432DZJcVSlPUkqlP/7Q3mJWRyhDCMhs0qUydv3iVKhXVA2TMWKwj
	MQ0znys8VqAXtoA+ks2QmG68RxG0=
X-Google-Smtp-Source: AGHT+IHHae77jPsMRuAMp85p7UQJ8UtEsFv+8X6HMvb/PiDrhcFw4+Xw/LR9J2hf5nG4gO8ySMa1c1vDnWV9tCzVeHA=
X-Received: by 2002:a5d:6483:0:b0:354:df59:c9a4 with SMTP id
 ffacd0b85a97d-35efed08bd4mr2933676f8f.9.1717779105887; Fri, 07 Jun 2024
 09:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org> <20240607-hid_bpf_struct_ops-v2-3-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-3-3f95f4d02292@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Jun 2024 09:51:34 -0700
Message-ID: <CAADnVQJo71xGQKLTW6Z1xsTLjtikN8bfemPUF4zj2c2Uvi5JMw@mail.gmail.com>
Subject: Re: [PATCH HID v2 03/16] HID: bpf: implement HID-BPF through bpf_struct_ops
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:28=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
> +struct hid_bpf_ops {
> +       /* hid_id needs to stay first so we can easily change it
> +        * from userspace.
> +        */
> +       int                     hid_id;
> +       u32                     flags;
> +
> +       /* private: internal use only */
> +       struct list_head        list;
> +
> +       /* public: rest is public */

Didn't notice it before, but the above comments are misleading.
The whole struct is private to the kernel and bpf prog, while
registering, can only touch a handful.
I'd drop "internal use" and "is public". It's not an uapi.

> +
> +/* fast path fields are put first to fill one cache line */

Also misleading. The whole struct fits one cache line.

> +
> +       /**
> +        * @hid_device_event: called whenever an event is coming in from =
the device
> +        *
> +        * It has the following arguments:
> +        *
> +        * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
> +        *
> +        * Return: %0 on success and keep processing; a positive
> +        * value to change the incoming size buffer; a negative
> +        * error code to interrupt the processing of this event
> +        *
> +        * Context: Interrupt context.
> +        */
> +       int (*hid_device_event)(struct hid_bpf_ctx *ctx, enum hid_report_=
type report_type);
> +
> +/* control/slow paths put last */
> +
> +       /**
> +        * @hid_rdesc_fixup: called when the probe function parses the re=
port descriptor
> +        * of the HID device
> +        *
> +        * It has the following arguments:
> +        *
> +        * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
> +        *
> +        * Return: %0 on success and keep processing; a positive
> +        * value to change the incoming size buffer; a negative
> +        * error code to interrupt the processing of this device
> +        */
> +       int (*hid_rdesc_fixup)(struct hid_bpf_ctx *ctx);
> +
> +       /* private: internal use only */
> +       struct hid_device *hdev;
> +} ____cacheline_aligned_in_smp;

Such alignment is an overkill.
I don't think you can measure the difference.

> +
>  struct hid_bpf_prog_list {
>         u16 prog_idx[HID_BPF_MAX_PROGS_PER_DEV];
>         u8 prog_cnt;
> @@ -129,6 +188,10 @@ struct hid_bpf {
>         bool destroyed;                 /* prevents the assignment of any=
 progs */
>
>         spinlock_t progs_lock;          /* protects RCU update of progs *=
/
> +
> +       struct hid_bpf_ops *rdesc_ops;
> +       struct list_head prog_list;
> +       struct mutex prog_list_lock;    /* protects RCU update of prog_li=
st */

mutex protects rcu update... sounds very odd.
Just say that mutex protects prog_list update, because "RCU update"
has a different meaning. RCU logic itself is what protects Update part of r=
cU.

The rest looks good.

