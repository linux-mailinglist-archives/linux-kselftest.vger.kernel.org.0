Return-Path: <linux-kselftest+bounces-12452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6D2912A4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 17:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0D2284F05
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762327D095;
	Fri, 21 Jun 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCbjIHYn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD9C122;
	Fri, 21 Jun 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984135; cv=none; b=l+iKWPuXk62hmyyqoM9c3qHAg5p0LXCxwhYcu3omw0Amu3ACnoIeo/Y4eLUBf/UuYp51lCGQZNdWLjDpoIyTbyypP1HCug4gGnzmdH9KZzHYF52o+ljItDnTqmmnmCXsNhPJdI5Ry3XHH26sIy0Qx7TybHcAEVJwFCAxmAlajMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984135; c=relaxed/simple;
	bh=xL004FPcIDymhrO3CLW72TG5nnHRR+dk6NIipF17mhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7oSvHvKur0XvgVUAVpfcRtynOfDWVzQbS73vcst5ZiHDseW8SNAVs3DEHHep6FTDSV7oqctZWRPWvColsbpPOGO8zkeQEH6M/hy1azpjbF7Z915ZBk0U9iEXw1EdOHOCPFgiju+B67P6WFGXpW7co8VDocTc70QuuPIAh3nNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCbjIHYn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cc14815c3so2273550e87.0;
        Fri, 21 Jun 2024 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718984132; x=1719588932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdhmVdccPuxwXrDDM4FgPvImngyAwKoznDiroJAAKZ8=;
        b=LCbjIHYnqMJcCad53EEaqSHWiFSbylo71XSEJMii1+BdLTaYV9Rs8zSgmMioN+KJjU
         BCNbn2OX3Y0hWMKwOCETXJEtUWrRcSGPWCLMnh8z2b/7332MUqIbjSk4wLAXBB48jNi8
         zrNy/c+Yu17qoiFRO/bYRxjqfAy9e9tGFeQcib3tVp4IuphgJ3nsMXpcHcsfPYo2lbOg
         45yba3lN2apRspCZDE7hfGXJskMRY0x6rF5nWfIoUbGyNyNuYCZc20wOI+I5AbLimaiX
         naHakk770Bp5IBnlpg3VnTfZe3dWcwJVo4PdO8KFZvxxyEh8gr4kZILFq9GhiQLOsqUp
         WsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984132; x=1719588932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdhmVdccPuxwXrDDM4FgPvImngyAwKoznDiroJAAKZ8=;
        b=TfxEXXNNpxFpVR2Ue36+TdsoxaWblMIHmlnNK+/DZYdyTGBlj8G8pBDCPrPpCJwG63
         wXEllgPn4Y+Njaf1V6hvyc2W9wv8+UuIfRb+qVW6JugtId5lQNitljeI23gKMrBxvnZ4
         4UgKpjhI7RuIS0B61rK9IH8PWeCSPBvbjsEAKLT5qbGL8L+qKzcWZ3QVu2oe+E6TEBVV
         EMKBhygcUFIL9zsLk1+Mjv0Nr6q5IRe4kF9ElmEpAWZsQbBPdS/0cbEcoOt2vaotoufi
         PgNUGbqwrZdpzUToaNPpA526Os9eqw3oexeAuyvl5G1R8oSGzmDEueh/QHirLzsDx6pp
         KDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7rvBnR5PA+xP2Dgd1SUNPZj54SijXSE2oixi/XXt2rlTpyKswxyvl9LVdXxMe8SgTbChNaOagDaY5afyvcB50coGmlvGCa3fKVxVtRaniHce2H9MDW0bcWj3ADVgEmd+9qG9D3ZkU8laR+eGvp78NFTTnl7p09exXOaCw5xlM53cpl26MPOMoXAtbUvIV9QO9kuQkyPBzBueE2D/JWNEdF2n+xsD96h2e0MaPm/C/q6ECaLjwgrfKurY=
X-Gm-Message-State: AOJu0YzrRJDaVkhbupccU6jAa/8nLpWQivtRK/cIETZ+U2DBag64mAFe
	cbtY/o1MYw901GTEhYMnawF2RUOeCwMg6bzmbs7ZuYwxb27JOBWSf7GFKVP6cncNeBla3GUsXfL
	kQ6YC7/xChHaii91PNHnx6AyGRz1QaQ==
X-Google-Smtp-Source: AGHT+IH4nr2s0/s8AZGehFPKwGznBhVoJXWjyAfGfU6ODxiz0sMvrik5MmHzGxpzTgjC2Sr0MSoTBe/4R8GE5V1YOyE=
X-Received: by 2002:ac2:5b4c:0:b0:52c:9d61:271f with SMTP id
 2adb3069b0e04-52ccaa33e61mr4705513e87.27.1718984131452; Fri, 21 Jun 2024
 08:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org> <20240621-hid_hw_req_bpf-v1-3-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-3-d7ab8b885a0b@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Jun 2024 08:35:19 -0700
Message-ID: <CAADnVQ+0YdjNxv0dFDPbFxT7F4_TBKTFjntfvLqAPwVadZUm5Q@mail.gmail.com>
Subject: Re: [PATCH HID 03/12] HID: bpf: add HID-BPF hooks for hid_hw_raw_requests
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:56=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
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
> Here checkpatch complains about:
> WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU code
>
> However, we are jumping in BPF code, so I think this is correct, but I'd
> like to have the opinion on the BPF folks.
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c   | 36 ++++++++++++++++++++++++++++++=
++++++
>  drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
>  drivers/hid/hid-core.c               |  6 ++++++
>  include/linux/hid_bpf.h              | 35 ++++++++++++++++++++++++++++++=
+++++
>  4 files changed, 78 insertions(+)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 2df31decaac3..813b53119b85 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -74,6 +74,42 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev,=
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
> +       int ret;
> +
> +       if (rtype >=3D HID_REPORT_TYPES)
> +               return -EINVAL;
> +
> +       rcu_read_lock_trace();

checkpatch is correct.
What is this for?

