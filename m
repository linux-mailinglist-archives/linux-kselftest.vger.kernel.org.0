Return-Path: <linux-kselftest+bounces-9074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 931968B635A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 22:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC607B21629
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337CA141999;
	Mon, 29 Apr 2024 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W+TFK+y6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42491419BC
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421718; cv=none; b=t99v6aQKoK9l361ZMbO5QozGNelFY7DCQ0wmIs5J9xftzDWpWVJpw7u1mGbeAAOLivNPnQFLYHVJ8a8DYxXewZgSwQn3YGoDVelyVOrcnxXlYTZpDZqs0Iv1ABkHSkaOVbALayfrtEvil1hsL8J3nGpiRV2q3w1arwQ3Sl4IAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421718; c=relaxed/simple;
	bh=5lIm1eGtHM4PV56m4aPsCpHzpWdPQKBG54afaQAvc4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHUIQKxhbHUvhuv8rzEnX4Ec22QJyzxDBlBbS9yuTKZT9C9tMOA9mhUeXkyKuSRyvviAVZzbr83ysM5P+lMcDx2b0biTCXg55P7jV539z2Zofb0NpZYyHDCLI/bOP2GlZMhBNPf3hq8Sdxe4ruwBDmrB3h0F74H31MQTs42gG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W+TFK+y6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57225322312so6609331a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1714421714; x=1715026514; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hNIl2k7bcjopXDurl21nUe10hqHAJ/W6XMO+7gYbZw=;
        b=W+TFK+y6jzm4Zy3kavYgQEYxs0c6e7ehSSSP1t+dRGz42hGGveiTJD0Y+x7Hjh58VN
         HrOEC517Xkq5q/bY65EPa+A1sdsfM7yB5YxPvEG388pBvmq23zMGNpZ4DA2KYIy/8ybx
         Twc7PnSoeWqJ5MTA2/7uMRyk4tQ0cJgIs3o09UWMHWwUHY0qpOlLA0FoTHYXhC4QjM8e
         PwWEWPEmd8zDtkfV+DHX3INFC98rFne2gRxJKDxQNu/cUy/CJILdl51Z1j245rB5q1Jn
         HJnukH9Iw+xafkhCmpM1k5UnirgFuzlMtrjro9PjgWJoYAP5BJTKWIS+FhKulz53WcEe
         gWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421714; x=1715026514;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hNIl2k7bcjopXDurl21nUe10hqHAJ/W6XMO+7gYbZw=;
        b=jtS/qO56gz9DOF7e0KedvdtE2rFZdu4rFsiSHg5eLbKPrna9m65XITJ7gjQ4Wlilg+
         43Lz0YjZT0V2eW0zY/PdWRQCAzK4sCaztChvs/AxG9hdCOm3y+rvFnk3etfvJtYFYFio
         AFv3FGfT5W/Xg2TewDo9kZF5gaZWMS/4CeQh9muYxs8t7oHg3cIq86radwfPb1bLGHNt
         rap33nxK6OAxUt3SU1ckiACokg+13pRwuDQM5h2mVRMlmYNt3QvQ3HIRVKzcXYMZIvnX
         vIfQl7lowPg0Uy6qyVBiyMdeJArejlnMPy1vXvuNDdxuzkrAdk9AS8gBu1+DDfySvDhY
         t5xw==
X-Forwarded-Encrypted: i=1; AJvYcCVwtZlwOFKGogC65GmjDnyLRDErSP4forYRvP+ssEJbPmR8bJqKhLy7r1JQdvaA0WcMEgybIgBplg8BSJ3iSnNMKDDYn1UomW2iu2jul4Bt
X-Gm-Message-State: AOJu0YwhkuKeRw9cvy4FuXIb/4pWqfpu20Rv6AP09r4xmkc63Xr/Gu3x
	Hyf52BrIpOjQib91d2IHnboLkG8JPwxviFpsZZrAp0YC9QZidl1AgWkTJxk1LQ8=
X-Google-Smtp-Source: AGHT+IEYp6PrEor/rRFc0AvlZl9FY32fdI1sHcQqXd81K8C/WOL3RGcjPL+2CvSbMsQBan6olswboA==
X-Received: by 2002:a50:cd0e:0:b0:570:5b71:4859 with SMTP id z14-20020a50cd0e000000b005705b714859mr6505696edi.41.1714421713909;
        Mon, 29 Apr 2024 13:15:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:1ce])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b005721b7bfea2sm7844691edb.22.2024.04.29.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:15:13 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@google.com>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Geliang Tang <tanggeliang@kylinos.cn>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/2] selftests/bpf: Check recv lengths in
 test_sockmap
In-Reply-To: <0de8cc53c7b797fbb8d8a12748b30353ca99d98d.1713867615.git.tanggeliang@kylinos.cn>
	(Geliang Tang's message of "Tue, 23 Apr 2024 18:26:14 +0800")
References: <cover.1713867615.git.tanggeliang@kylinos.cn>
	<0de8cc53c7b797fbb8d8a12748b30353ca99d98d.1713867615.git.tanggeliang@kylinos.cn>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 29 Apr 2024 22:15:12 +0200
Message-ID: <87y18whqnj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 23, 2024 at 06:26 PM +08, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> The values of recv and recvp in msg_loop may be negative, so it's necessary
> to check if they are positive before using them.
>
> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> Fixes: 753fb2ee0934 ("bpf: sockmap, add msg_peek tests to test_sockmap")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 43612de44fbf..24b55da9d4af 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -680,7 +680,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>  				}
>  			}
>  
> -			s->bytes_recvd += recv;
> +			if (recv > 0)
> +				s->bytes_recvd += recv;
>  
>  			if (opt->check_recved_len && s->bytes_recvd > total_bytes) {
>  				errno = EMSGSIZE;

I'm concerned why are we getting false-positives from select() here?
This is what leads to test failures once socket is non-blocking.

[pid   544] pselect6(29, [28], NULL, NULL, {tv_sec=3, tv_nsec=0}, NULL) = 1 (in [28], left {tv_sec=2, tv_nsec=999997014})
[pid   544] recvmsg(28,  <unfinished ...>
[pid   545] +++ exited with 0 +++
[pid   544] <... recvmsg resumed>{msg_namelen=0}, MSG_NOSIGNAL) = -1 EAGAIN (Resource temporarily unavailable)

Is there an explanation? Or are we ignoring an issue in sockmap code by
"skipping" over EAGAIN errors from recvmsg() in the test?

Didn't have time to dig deeper yet.

