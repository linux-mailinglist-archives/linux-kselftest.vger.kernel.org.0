Return-Path: <linux-kselftest+bounces-8750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2B8AFED5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881031F24566
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BEB85940;
	Wed, 24 Apr 2024 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvVAMwGQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB5171C4;
	Wed, 24 Apr 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927092; cv=none; b=rdsQcsGyWICYc7l9hT711dxSA+44R6jxAaRYJlCWb8BStSArd3TlRgvGAz/ie8Ki4B7Ju9hXE/I7GG/+EckhKDI9zb3C+EVQkhU5xYg0QO8CRjrKcajtPoSic/hkydM5qr/P7CSL8qE9fPkYcZHGElOJlum1ade0G0kfIGyYxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927092; c=relaxed/simple;
	bh=Yf4JmDI7ok7xHREqNVMiKRlcw6gQNe/K4vnS/jVO+To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tnuq7IbaMce2cEq+VU00iNqyLnU/IR7fNny9Z4DV5E92fdGc/inIZnvQ8G6MScOgAGn9p7zxbvfhyRubZqgC+K+g8/3YNPPpw869oVDmcn2oS8xSu8y4sEqIQJkIplyPh7ufftM3z8FeSesFZePDePAG1VMT+rKu9PNk7AZmvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvVAMwGQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4155819f710so53328975e9.2;
        Tue, 23 Apr 2024 19:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713927089; x=1714531889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD4srwBtJX0KyfwDrMbgM0TFHzRmgGecb0JArSru4mk=;
        b=MvVAMwGQOXpxhVTntMsi1kTsmOjzTDndz1KKjm+v3wDIr6uEOpVm9TJC7G/6cByIXM
         3UU3G7fFwlkVSRszpjmiwIQgJiEW9wGJHFMGlc+U7dezbr/cb6yQNS+JuDOFQyqRsFJw
         VjceMziGfQKuroN4uQ6UTvwLlE4c7AI8UEINGWeOBsLfLqFd87BTZvZHOLkrIiwNXF+5
         8MKviauvF5TyNM+F87KXJSLX3djk9LiA9XTdjIsV5LXyAF88cm241Xpc3BLgJrrbQe+T
         FMZC9m8CXZRrpPGYo/ipNThSKhB/Bp8OcCbXzXTMkynncfLtJttHLGvSTq1W6p5Ude/g
         ppVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713927089; x=1714531889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD4srwBtJX0KyfwDrMbgM0TFHzRmgGecb0JArSru4mk=;
        b=jZ1o4ifz1vf4aUd+sPguyd2kI07sOzqlWRXI08gtMWiFVGCGcF6OnI2iu0OJbuEbzd
         oV+z3lZ7R9ZSDteB1HRlAHI52we8sIIbYG9XDKea2i1pbrBK9XuhvEfE1CAttAmATKQW
         Na9y+MCvvNFUWVjF/gJ0QDLa2ck4Y/NcF5DwMGXXNpzsBsEyeMhjhCB3TZFEkGZxsXgF
         XBgE/nRNIYdGH0ruuHtj0I31AbVPEHb14C4UJm3E9d/wcTWIT7lbJLLxNg0o+tueHsC4
         7UM5ck2D6K5ffXC6DZicABaHFjXa6kblr72XnGvU3ZwJcCM/dnMxR43QjgBR1vEh3C7g
         enpg==
X-Forwarded-Encrypted: i=1; AJvYcCWR+enkz50F52INtKKtFDo42w+HYiih1RCUOnuTkQoWuH6HeCNvjTK17kTH+Fc+GprDMB/06jCHB5fzIHHHAcIP4Ra4uqnmJEEHamfW7xm/N7un8n8qATEQMJP0r9vWJVHvg8GkeqSZ3kZQHdZddCRuY3VwWuZSevLxI3suvc7R/1NE
X-Gm-Message-State: AOJu0YyZQrJTypBKFhz2GmT7IFMjsTHcFkAB5elQlYRg8ToJ8kXldOGT
	LbfhshwM3yfneKx0ZqMEv1WeGAHAsvub91pTydBjYpRlwmMtzJgtgGtQ8O4jJJl1iMlkDB8Q7aP
	Vg/ZYOKxsgadfrntjvAorIb1bRJM=
X-Google-Smtp-Source: AGHT+IFtFFAxjnYdxlzp9CFTsz7mhCLHIvMwZAGqk1XtbcTEV/5Hsr54KKE5rGWRRDKYOrN6Kn63Ae8ERVYBScJVakA=
X-Received: by 2002:adf:a18b:0:b0:34a:25f3:4daf with SMTP id
 u11-20020adfa18b000000b0034a25f34dafmr583918wru.7.1713927089023; Tue, 23 Apr
 2024 19:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org> <20240420-bpf_wq-v2-9-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-9-6c986a5a741f@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Apr 2024 19:51:17 -0700
Message-ID: <CAADnVQLO=QbXnDBKrDdofpkBg2jESC8rDwi_WiLNOahJQcEWSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/16] bpf: allow struct bpf_wq to be embedded
 in arraymaps and hashmaps
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

On Sat, Apr 20, 2024 at 2:09=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
>
> -static void htab_map_free_timers(struct bpf_map *map)
> +static void htab_map_free_timers_and_wq(struct bpf_map *map)
>  {
>         struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
>
> -       /* We only free timer on uref dropping to zero */
> -       if (!btf_record_has_field(htab->map.record, BPF_TIMER))
> -               return;
> -       if (!htab_is_prealloc(htab))
> -               htab_free_malloced_timers(htab);
> -       else
> -               htab_free_prealloced_timers(htab);
> +       /* We only free timer and workqueue on uref dropping to zero */
> +       if (btf_record_has_field(htab->map.record, BPF_TIMER)) {
> +               if (!htab_is_prealloc(htab))
> +                       htab_free_malloced_timers_or_wq(htab, true);
> +               else
> +                       htab_free_prealloced_timers(htab);
> +       }
> +       if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE)) {
> +               if (!htab_is_prealloc(htab))
> +                       htab_free_malloced_timers_or_wq(htab, false);
> +               else
> +                       htab_free_prealloced_wq(htab);
> +       }

I missed this earlier, but pls follow up to improve this part.
Double walk of all elements once for timer and 2nd for wq
is inefficient. Better to handle it in one go in prealloc and malloced case=
s.
Until we have delayed_wq it's quite possible that somebody will
have both timers and wq in map elements.

