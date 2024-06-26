Return-Path: <linux-kselftest+bounces-12819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9927918766
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 18:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686801F21CE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A48118F2D7;
	Wed, 26 Jun 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ+vzImA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233E18EFCA;
	Wed, 26 Jun 2024 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419412; cv=none; b=KQdnZMBI3Mw4qzXQ3fIS4u8Z9+bDcuTcva6Sd1H+aRmZynnpO/dCzrhsQBim6LaG5/4xTZN+24Xo5p0M9PJMGzcLY+ynjQWbiPeG/H1nOnLBSKIzlgQzxjlhv6TN5KD3Vjs+mvcUwbUQ+M4nojDIEa/lnZm6vFu4FjweGeMLlyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419412; c=relaxed/simple;
	bh=yVYTETKAskdA/CEyHVZMZB/YT3nD87X+ZkQpK1oY4LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrdD+Gd4mT1EgXWlUFxH1Fyg/hS1udYrBxb6/866OtkoQvqYHJj7qwGEAcUGtNMZP1Kf5RpnrawATzCv7Y6n/8DHXu0VrV9HKHKCEbREHtemdAlwqNKESCTcElBlOBudDU1hKVKmhbiH2DoO/RmFeNsEuk4eyTDdFXW4jXEBcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ+vzImA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d4ee2aaabso659255a12.2;
        Wed, 26 Jun 2024 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719419409; x=1720024209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I4DP0aO9rNRkcVk0FjZDiZ477lq6V7C5TCxegEyCtg=;
        b=mJ+vzImAJpLQ7QOnes9OWe1rNXM7G6V9X0FlGWhbYbYbSvVtgIP/mbxks8jaixS+wj
         /TDJFamyKsSEJfq4f1g5CHr9jOlGNEkBtI2PSKfDqt6DSTN4fLHb+17EXx1ruTCuPxDU
         pok9L3ZswrFJf/bYoisouL8GjXWlxb5g6SuNaPeTS0/+4j2WfDKKsTAHr8f1KMxyXzsy
         M3fEbbjHxZJlDXHeSLmLYeg+SFdM2+gJIvY+ATSJWvofpB7+PtK0m1aLBe0vN4grfF+X
         s4d6CdLeg4HUlhkRs1mxtBXYwjpOpgaLW1EtPzECSOMj+cE2I+E0EaP7NkFhdBsirpqZ
         Hlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719419409; x=1720024209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I4DP0aO9rNRkcVk0FjZDiZ477lq6V7C5TCxegEyCtg=;
        b=BhxLIFKQ5iGT+kp0zSTtBuUdk6lJjI1MnUC5K6ai4rT+Z9YBcvKs+CRNUGDb7ks7+f
         uMRohyQXXEM5kQR/mfxtkqb5H3snRTIItjnsjlYSNjhx+FgHyl4OAaRj6FxNUAeACUFI
         Q1/Es5Pq9JdpLk/OzFsPnpTX4UAwvqu8kfGl+ZmhgvIsCviEUNaqs+GSXgFW3RD0v/Cl
         qrB+s5Fj51oiJriTZGzV7ln9Y/oQcaOIOCj1IN+jNJbZQpfQzYs4flU+pop/BwsFXJVn
         gMMadngp6BY12/NkMKuO8mNs5Fa7m5DlCBvAy9S3FHDyTkR0ocUZAtkwj5uRUryUqyPJ
         KrFA==
X-Forwarded-Encrypted: i=1; AJvYcCUPfmhXTtkM66S0ib0Cb0rlrR7XW3uoSTJAQ5dTkRQofB3ZUh/fq5u+CjLAIv+pWQyONBZ1NBn9kQu6bsXFJS+0Uzkl4KVKwrl2OqgbsOAW2bgNZZQakqaNmSnXOFEquRsSxtJ8C1unlb7TmsHXKJVvqI0kJs7aJLhUdAAFqR2kzeuB38x2gCGUSL0ndxLqPdmMsksceY95ZnYgBCm+J5hhI0Yr/BFGkGez0lbo95WI+igWu2cABAOU3dc=
X-Gm-Message-State: AOJu0YwkxYumv8WhBero8qZalrCWDBTyCflp4l09GuvUK+R0F7YcymB0
	0IuQIbfGE+IASZAhasieNNwzZUxlPuQssbgKnjw02mFz6WfQN+N2MdpDqun2vfYLy8Ac3hfWICW
	GlHu0tuLPi4nFsOsp+UYNW2U8q+0=
X-Google-Smtp-Source: AGHT+IGv/GYDO4u+mhEGsQrt+U650ZI8J+/sSOwwWzvWvNQSsFz4d/hdYgWzhvAjXSELu95408I+N/FzkbBdpH9oj0w=
X-Received: by 2002:a17:907:a4c1:b0:a72:7e5f:a0c4 with SMTP id
 a640c23a62f3a-a727e5fa2a9mr356995766b.56.1719419408774; Wed, 26 Jun 2024
 09:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org> <20240626-hid_hw_req_bpf-v2-4-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-4-cfd60fb6c79f@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Jun 2024 09:29:57 -0700
Message-ID: <CAADnVQLZRE_QxuEaqbTpKNQt+0VUB=DK37FqScaxtqwbn9UorA@mail.gmail.com>
Subject: Re: [PATCH HID v2 04/13] HID: bpf: add HID-BPF hooks for hid_hw_raw_requests
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 6:46=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> This allows to intercept and prevent or change the behavior of
> hid_hw_raw_request() from a bpf program.
>
> The intent is to solve a couple of use case:
> - firewalling a HID device: a firewall can monitor who opens the hidraw
>   nodes and then prevent or allow access to write operations on that
>   hidraw node.
> - change the behavior of a device and emulate a new HID feature request
>
> The hook is allowed to be run as sleepable so it can itself call
> hid_bpf_hw_request(), which allows to "convert" one feature request into
> another or even call the feature request on a different HID device on the
> same physical device.
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> changes in v2:
> - make use of SRCU
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c   | 37 ++++++++++++++++++++++++++++++=
++++++
>  drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
>  drivers/hid/hid-core.c               |  6 ++++++
>  include/linux/hid_bpf.h              | 35 ++++++++++++++++++++++++++++++=
++++
>  4 files changed, 79 insertions(+)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index c026248e3d73..ac98bab4c96d 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -74,6 +74,43 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev,=
 enum hid_report_type type
>  }
>  EXPORT_SYMBOL_GPL(dispatch_hid_bpf_device_event);
>
> +int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
> +                                 unsigned char reportnum, u8 *buf,
> +                                 u32 size, enum hid_report_type rtype,
> +                                 enum hid_class_request reqtype,
> +                                 u64 source)
> +{
> +       struct hid_bpf_ctx_kern ctx_kern =3D {
> +               .ctx =3D {
> +                       .hid =3D hdev,
> +                       .allocated_size =3D size,
> +                       .size =3D size,
> +               },
> +               .data =3D buf,
> +       };
> +       struct hid_bpf_ops *e;
> +       int ret, idx;
> +
> +       if (rtype >=3D HID_REPORT_TYPES)
> +               return -EINVAL;
> +
> +       idx =3D srcu_read_lock(&hdev->bpf.srcu);
> +       list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
> +                                srcu_read_lock_held(&hdev->bpf.srcu)) {
> +               if (e->hid_hw_request) {
> +                       ret =3D e->hid_hw_request(&ctx_kern.ctx, reportnu=
m, rtype, reqtype, source);
> +                       if (ret)
> +                               goto out;
> +               }
> +       }

here and in patch 7 I would reduce indent by doing:
if (!e->hid_hw_request)
   continue;
ret =3D e->hid_hw_request(...);

otherwise lgtm

