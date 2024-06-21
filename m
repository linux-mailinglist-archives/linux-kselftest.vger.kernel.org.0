Return-Path: <linux-kselftest+bounces-12453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56639912A61
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B10F28865D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 15:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C980605;
	Fri, 21 Jun 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqKpB09a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E536FBED;
	Fri, 21 Jun 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984250; cv=none; b=oG5PrY56bWrFmlKfWyhKrZ+c3k3AcaUFQLgDvWOJncvvy5sxPnZRMULsF/BIVov4yauVW0nhvCrEYEUFT8NWCHz3ONHmgZMuAsGv4CmoSJ6GvmzsEDllRwaCe36UrAtI/KjzKYPCk2D5X/LAW6sxI+3clENcXqYceMOm18xedMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984250; c=relaxed/simple;
	bh=Y2saANydyVcnYI9e5RxEPCFuU2P+k+wVTvRnss0jXX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGJt9qKkGgOSJHI52WW9gk907XNseOYx2WgXHSalMtepzx4mPblAhOLY9Jxo15Ocbhmqk0y7M12n/KyEwAcYwZN+jG2ldNtcQzp7JeOYgUbgf3nDgK83lLC06i0O4U3OychTXtIY+vXwui6Lg2Tp8ZcqM83rimCPeqvYNZ1kYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqKpB09a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4217990f8baso20237525e9.2;
        Fri, 21 Jun 2024 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718984247; x=1719589047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEzPUxJosE4Dv4tMtApiYXkD+OE7D7/mwDL1O48YzwQ=;
        b=JqKpB09amApmCgb/sxRsuehauoQBW90e7pwoXl9SArnlUGoErNvIydBfiEcHfXppt2
         h7Tlqcxn+ShP6I2v73ZZCnFAJubAWyahmVfwdIQ5uBeTL+LnMfyyJb7G95PDVe6OUwce
         B4omms4ndTHluTfSl/+zAlMbOeQitrYVwVlCU7mTDnp7ZZunbQmD0rniVsXmCuvnmRNg
         8+CBoPLE+Bd6AL+pUbhBMGR1xSor2cqfONoEboim1OfC/3U13oj1osshryR/LzcBrpqf
         wko1Iv/fIIJAYhQoguhAjtK6HX5YyClz3OIbVVKfEZwe5IE3sReHTCyb26Xo7gKCHHUW
         CHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984247; x=1719589047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEzPUxJosE4Dv4tMtApiYXkD+OE7D7/mwDL1O48YzwQ=;
        b=IuptSIQPAtp6FcVK64eHI84rzpkuqWEYL4CJEWqpEf0dmDESD0BBOiZIwetnqoGKSL
         3831MWnAxgJJNvjNwCPKujKCYnceixYbvEeJuwO80VS0mI86inzmnp37xENKVRiYpUJf
         h050pXt/h21FlevPgflTtN3WDsRnJThT/Fhitzb9Ni6ct9/Bek5ENU3y6ivxgF6HfcGH
         hZwgAzet61TBF+iwgqJfz9sjruGGctJiLKnags3HKudQKH8neidFNiwaHSTxP/x/zpSy
         J0ELPFhk4QRswUpoJhdSy3Y7Z2qt0Qjg8cmtnMuRzPcl8LO17VV/9961c8zdYiJRlhUK
         UeyA==
X-Forwarded-Encrypted: i=1; AJvYcCVf0pl1JzC1PsMmaiEwx3p2UsZ6P2Gi/5L5IzBr1HhsQcCfFCRXeZKSJMHAayo6ZOLSHQI2YlWHVcBP51YjrK5sZper1cVFDjo5irjj0O8MPldz26ryiOJbt+zek3yRbVjoKJu2oqY1IVtn2TaJXdJOf23ywpRIfqDHIlwd3My4/utouYoiEEvKBAmsujFQvu8/kL9V19L8tx8udTqm73ZWsj5bKoD87ZkN4uR4IaS/Wep7vb6PuJPKzHE=
X-Gm-Message-State: AOJu0YwY491NX1vAqCodTjabYJlnrMKyTFIE4UYzj26AIvvwZXm7ZWSN
	9IWhlHF0EGoLbC5WliTUvTqszlu2z9pID4C9azfQTTbpYR1knHw3wCwGVsGBSxlMoWGVGn24v7Q
	Iz5KBvhJPspn55+cqg1PambHxKX8=
X-Google-Smtp-Source: AGHT+IFKLBM5mFnVwBQaLpG8mi4nu03QYb8IeKwotTRo4us7hJs+0DIW7+segniYBbyuCbW83a3oehpQCy2SXGOBBI4=
X-Received: by 2002:a05:600c:41c9:b0:422:7391:1be1 with SMTP id
 5b1f17b1804b1-4247529e1a3mr66980315e9.35.1718984246497; Fri, 21 Jun 2024
 08:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org> <20240621-hid_hw_req_bpf-v1-6-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-6-d7ab8b885a0b@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Jun 2024 08:37:15 -0700
Message-ID: <CAADnVQ+us6cQepSGWbOB4K1bb_0Wh43Cpo4zXJxB2d+SVpYinQ@mail.gmail.com>
Subject: Re: [PATCH HID 06/12] HID: bpf: add HID-BPF hooks for hid_hw_output_report
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
> Same story than hid_hw_raw_requests:
>
> This allows to intercept and prevent or change the behavior of
> hid_hw_output_report() from a bpf program.
>
> The intent is to solve a couple of use case:
>   - firewalling a HID device: a firewall can monitor who opens the hidraw
>     nodes and then prevent or allow access to write operations on that
>     hidraw node.
>   - change the behavior of a device and emulate a new HID feature request
>
> The hook is allowed to be run as sleepable so it can itself call
> hid_hw_output_report(), which allows to "convert" one feature request int=
o
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
>  drivers/hid/bpf/hid_bpf_dispatch.c   | 37 ++++++++++++++++++++++++++++++=
++----
>  drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
>  drivers/hid/hid-core.c               | 10 ++++++++--
>  drivers/hid/hidraw.c                 |  2 +-
>  include/linux/hid.h                  |  3 ++-
>  include/linux/hid_bpf.h              | 24 ++++++++++++++++++++++-
>  6 files changed, 68 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 8d6e08b7c42f..2a29a0625a3b 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -111,6 +111,38 @@ int dispatch_hid_bpf_raw_requests(struct hid_device =
*hdev,
>  }
>  EXPORT_SYMBOL_GPL(dispatch_hid_bpf_raw_requests);
>
> +int dispatch_hid_bpf_output_report(struct hid_device *hdev,
> +                                  __u8 *buf, u32 size, __u64 source,
> +                                  bool from_bpf)
> +{
> +       struct hid_bpf_ctx_kern ctx_kern =3D {
> +               .ctx =3D {
> +                       .hid =3D hdev,
> +                       .allocated_size =3D size,
> +                       .size =3D size,
> +               },
> +               .data =3D buf,
> +               .from_bpf =3D from_bpf,
> +       };
> +       struct hid_bpf_ops *e;
> +       int ret;
> +
> +       rcu_read_lock_trace();
> +       list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
> +               if (e->hid_hw_output_report) {
> +                       ret =3D e->hid_hw_output_report(&ctx_kern.ctx, so=
urce);
> +                       if (ret)
> +                               goto out;
> +               }
> +       }
> +       ret =3D 0;
> +
> +out:
> +       rcu_read_unlock_trace();

same question.
What protects prog_list ?
list_for_each_entry_rcu() should be used within RCU CS
if elements of that list are freed via call_rcu().
rcu_read_lock_trace() looks wrong here.

