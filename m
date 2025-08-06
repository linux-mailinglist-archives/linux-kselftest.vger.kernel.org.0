Return-Path: <linux-kselftest+bounces-38382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385E4B1C829
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDDA3A292D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B81290BD5;
	Wed,  6 Aug 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/skAZHI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872928A3EF;
	Wed,  6 Aug 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492636; cv=none; b=i0aedQFfSWhjbjbQh+lsb70kehhH8uxY/G9s888+2fNXeYedw6PZ9jaIjPpQMTnPXSlSStARoVhMLvP6vFbm85DFR1J62fms3IPXjvQqCJGEH4FODrSzs9/NKro1F5GGIwRC3STTytAic/5LuhsHF4ioJawundqkuUNjbFxbCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492636; c=relaxed/simple;
	bh=584uXeN9jsBXBHMuwddffGCP8OVlQsZ+Xp3CN2antyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQTQUuMbvfGj5neVRKH0hWXr6NYGAZa1wCc5jlw/7V3v9s7eYEbrk+oLHR96VtOkm6lEy+vIi2sEwXfWjhreL0/qvSJ0Mm/cTktGTCL99Ch2CxCeKUMIdTbF1i9N6UXwtwOMUBRhy00iEEJbuOWyGQHUCPTV/w6aoXMjBPAvD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/skAZHI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af958127df5so707805066b.2;
        Wed, 06 Aug 2025 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754492631; x=1755097431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck5YtWxsbH5j6ULV7+hpajLj2ON81F2VLpNH+npiJkQ=;
        b=l/skAZHIE23xFtzgeuxwjRsUw3049bR/2j5qSvrkbT5bvbIWsSP/1JUc3UcwhzHaz4
         AuazwYtg+YBJfbg7bZcaLcQQ7A8Iezl4RTefwdEgGudnozM19cImMMcr7haTsbYeAohB
         NPtpzZX0G9LsziSB6S5wRgcjbJkkDaPuaX8haEfzeD+3OSM2fjWuA3uXTUv0nat4titu
         vCQU4mI59biakGYPb2glAuF8NdbNvFKwX5r06sjclcMyHX1wjPTX2olsVNbG80g5P/El
         bl7mNDPGwGU1Dr3F0oq12PHIVwGEwe+2EeSDL3MPrHXuxYLgDFcr/OwXwcLh2k3ftBab
         1b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754492631; x=1755097431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck5YtWxsbH5j6ULV7+hpajLj2ON81F2VLpNH+npiJkQ=;
        b=MbvMRKHZWYAXkOzSuiBPgzHB8pMlEhmqlrNZXxCqWdqT12NVi4KvekHPkGeDNudNr+
         yBDBemSiLB/fGJVErMQm302TPhPcGOyL0ZLe8reRcJA55bGqlc/k1jTpK0nQvqdmOxIy
         v0cGBQiF2xOnjeRGOPp8Z0qjFT7rvBjjz8g4tZzG0pbf9i6jhr2Aqgf5JT9GS0O0Hds/
         AzjBYouL74oxTrjTgo5aco/+monC31SyxeS2GT5pf31uTpEx5hAeqcJUh6ok1yymkX2K
         HZqf5eVUJb0vqwfEt6a3+GsxysYTJ5pCGcsyOvLRaNT2SW+RLx/M5W8FhBtpgVwg3mDX
         +l0g==
X-Forwarded-Encrypted: i=1; AJvYcCUJWge8uxNxb4BvrpSgtjE+5IfkxyVMIiH6NYey0d+3AxR3VG1REEKYG0agIo4W2AtlWf0=@vger.kernel.org, AJvYcCUbwHbIEFH3Zfxcl48EkhanE81tAFWhDSbhvqDh4C5M3ujWhAszMriwWXLiAHb0NZOt+E17WctmptVv7fBu@vger.kernel.org, AJvYcCVerr6ipjFY03mv74YskNliLitNegssSZHUD5uaQ7DkIdqCBgoDeYo/ZGO+lMthlw836MWP8D9asQil+7E39CP+@vger.kernel.org, AJvYcCWlbEy+39J3r9tuYs9DgE6THwEi67Pcex/DU5jintHDnxanLv+1ZtWWI1P+WN6g+Qxl9P1i3imK@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwUAWHZihAKr+ueRrLD5e7K06q4du8B8hpE1Zt67JC4TtjKyD
	uSu7rCuGCNxpfnKOnZUUTinqAurIwfA+rtomt1ASVxvMtqV48eUY8vCImT67AEXdNgcPE8bj0l0
	q9QXEpVhn0B3MbB/yWWobjAVQJV9Pn+s=
X-Gm-Gg: ASbGncvuw/8kBRLCTLdvRBvqo+z5ft+zyzPtzZMX2R5eG0cG+Nlt7uINET4cozlGPDN
	G8ZQnSRzQqOc1O06/fMncXsWWb8B0RBwAgdyondxnCp8U1rIF4eDAfaqLTRaYu7l8B0k9mHAvgr
	yIE2ECCgLPhSQXrpD8UY2cr6fCgKsTxmrV9lPAGLRs/+4bnzU9ZthRrQShMOD2JFVBmj5dW+Npl
	S0x5O2wtXO2aMjlsmmtlj9pxbmVudO27MR1
X-Google-Smtp-Source: AGHT+IFz4XsMafOE7B2cRECu6PsWWMxUp0yBdUzi6JtgASelC8/9mtyaERSLeB8R2LFMi4+R+vaDYy1LHdKJjr/ADtI=
X-Received: by 2002:a17:906:f58d:b0:af2:b9b5:1c06 with SMTP id
 a640c23a62f3a-af992aa4a38mr252953366b.14.1754492630424; Wed, 06 Aug 2025
 08:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806110230.23949-1-pranav.tyagi03@gmail.com>
In-Reply-To: <20250806110230.23949-1-pranav.tyagi03@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Aug 2025 08:03:15 -0700
X-Gm-Features: Ac12FXwMSvnTnW4mpFr34H5Rcz9AOXGEYUwrsVyBOhRLZUjpNGcPOgXLwZWKDDM
Message-ID: <CAADnVQJQV5Z_LsrBCa2=UwQ9NhPbkpNvZ9N7nf1sv-QunEj1FQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf/progs: use __auto_type in swap() macro
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Mykola Lysenko <mykolal@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 4:02=E2=80=AFAM Pranav Tyagi <pranav.tyagi03@gmail.c=
om> wrote:
>
> Replace typeof() with __auto_type in xdp_synproxy_kern.c.
> __auto_type was introduced in GCC 4.9 and reduces the compile time for
> all compilers. No functional changes intended.
>
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tool=
s/testing/selftests/bpf/progs/xdp_synproxy_kern.c
> index 62b8e29ced9f..b08738f9a0e6 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
> @@ -58,7 +58,7 @@
>  #define MAX_PACKET_OFF 0xffff
>
>  #define swap(a, b) \
> -       do { typeof(a) __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } while=
 (0)
> +       do { __auto_type __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } whi=
le (0)

Sorry, not doing this churn. The code is fine as-is.

--
pw-bot: cr

