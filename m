Return-Path: <linux-kselftest+bounces-7456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B712089D0D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BED1C22B01
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9D254BC4;
	Tue,  9 Apr 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dko8inHi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879854908;
	Tue,  9 Apr 2024 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632541; cv=none; b=qQx0diNj33gSFF5zdaA0XcRX6ipGCohgFEieYQys4JVHMSXND8fzHl9BdNgR1ehGN1WAXOYikVYlUhkkfsqLyyFv6acR89T/sk9L27JA8NN1pih3Hu1o+++siYoTV//kEw6HaaQPMpsPsFX64zlfU2RXJX3x5mMTJPE5WQ2tkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632541; c=relaxed/simple;
	bh=KA98YP1iZl6X238fZAQoMgButCDvoi6pP5LWfn1U4HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lp5JEvixlW64LbT7V+A6abw6rjPY5qeVmo4xlGHFuknO5PW+s/Mm37LwWNypb9p91yi8ED2bdW6DgOliZ1Pfwz6fYE9Tgaqw9InoIzs5Ja0+A1JcU0g7xN0Wt5oP6ZTE53vGAFrjOnHEEiYhGJRl6qESyfrZZXVUvHCjSgntwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dko8inHi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41639ec6fa4so19391305e9.3;
        Mon, 08 Apr 2024 20:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712632537; x=1713237337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/efIo3qz30HJtdatu0Dwv9KkVcGf0VssIVHCAQ5bGcA=;
        b=dko8inHiqq9Bx5nCYxG4DRYy1XC4XCcyFzd7Fvlm9CLx4SJt9KvNJUV+FQCyy0f09U
         NBUt7d6qcp+FzETwUVMhih8c8o+1DbUADb9/sVKP9FDRKA/QOUeWAf+EJPQETPwXZWKO
         Ghh2PUx0IUhcdhOkAMB7FFOFtZichFQO0gS89O8KJ1kY4O1hy8CFiT2Plbd8Cyl38e8k
         iYBBajl7Zei2ecKV2XYxwTFQ5GmXXExXCPk5MkK6MrW6/lbbZwzzLI92c5iX/4qVifgV
         0F4hEhC6F/mLMPMNIbxQUgau0PMBU4q/XGGgkfFNmBVW59UljYyAn4CETCThPa8SJVP9
         8MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712632537; x=1713237337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/efIo3qz30HJtdatu0Dwv9KkVcGf0VssIVHCAQ5bGcA=;
        b=YsyfI6/bBey4Cbas36nVM6dxzyt9EMUjq2ekmufuL95rve3wUWVjawxR3FFz0TuoTA
         zzYa2Sk36O2C+zFa+tuqhfQrlr2vfdBh9LL0N5NkoQsw/Ubc4BvUbemfIAkWtpE7+Sah
         rC3JDpc8fMTmmdPBR5PGZJ19ITGx4KWVm15qn/VYXjgbeOtqpdfEwVZ4gdc66OoLT3Y8
         onpOmiXOEJEWJaPViPC8UizQ9NkjyTUykM+5TnEe2CEsDN4ws/VsmWoN2AekzhrJzcE6
         wyWDmnlgT89GcnthOjB2yhmACjwoptb4yKTEDH5eRgefcxpJLc/hHW2bZRBvC95ig+P/
         37lA==
X-Forwarded-Encrypted: i=1; AJvYcCU5p1RmOhgM0/z524RvUZa+r/pPQBo0Rlgbjppoq633xMcU9sJC4P4EjtNoxodrJnoGekTG20FbbZeixGKwgblwrYokWYLzywrkXpa17MR4uri7KZ3rhube/JyeGL0DR4sS9JtGlJTHiqRPI97C/PYtVoa3Szsy6t/pYHoSS52GJFCD
X-Gm-Message-State: AOJu0YyMpuxIqljAfs7w5MEG8evPUxViamc4DlpOLhl8juMzsUfuQY5G
	52C0oG+Ntyp6DPny7MM9KAO0KNKOI77zuI1vkKNlStQe7Kf9Iho/UOLMXBHTZId0UKFij47dnhQ
	jdQkQanssjsyVMCEA824zspZg7fI=
X-Google-Smtp-Source: AGHT+IHp13Eyur1BPAqItSeYvnwBUkDqDf+115tBS1MX69pjtJCRbrsIY/4+soTp6BTYoTQIYiuxGHVmOxAXsxB8N64=
X-Received: by 2002:a5d:4b02:0:b0:341:b9dc:eb03 with SMTP id
 v2-20020a5d4b02000000b00341b9dceb03mr8506794wrq.3.1712632537445; Mon, 08 Apr
 2024 20:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org> <20240408-hid-bpf-sleepable-v6-5-0499ddd91b94@kernel.org>
In-Reply-To: <20240408-hid-bpf-sleepable-v6-5-0499ddd91b94@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Apr 2024 20:15:26 -0700
Message-ID: <CAADnVQ+r2hxerOYjQK21ZWpOsccZbrVWm+L0dHh_dRPwm8iK_A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 5/6] tools: sync include/uapi/linux/bpf.h
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 1:10=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> cp include/uapi/linux/bpf.h tools/include/uapi/linux/bpf.h
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> updated in v6
>
> no changes in v5
>
> new in v4
> ---
>  tools/include/uapi/linux/bpf.h | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index bf80b614c4db..f1890eed213a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1662,9 +1662,10 @@ union bpf_attr {
>         } query;
>
>         struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN comm=
and */
> -               __u64 name;
> -               __u32 prog_fd;
> -               __aligned_u64 cookie;
> +               __u64           name;
> +               __u32           prog_fd;
> +               __u32           :32;
> +               __aligned_u64   cookie;
>         } raw_tracepoint;

something wrong with your tree.
there is no such issue in bpf-next.

