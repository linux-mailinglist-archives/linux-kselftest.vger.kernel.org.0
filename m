Return-Path: <linux-kselftest+bounces-15320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5C951CEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE181F22D3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FC31B3747;
	Wed, 14 Aug 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crr3vMVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10F1B32D0;
	Wed, 14 Aug 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645262; cv=none; b=WflRQXW19qHJE3h30V1V5N7w0dB27pCjC4kX0CWnO4NehhjM/XtZOrzyp32+YaieMktLeEXTlFQ1JXXYo/dv+a3TegsSCGbtIIgd0m3PnYd2yMuKnXS+XKTCjDdZoyvQnQkLF3sYQiF5zf/JJ85+zGR5W64M1QLwMWUcwikYn6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645262; c=relaxed/simple;
	bh=Rbf2r7gkdSBN57GxPNoWM5G+iY1VMXIn8CcKWqRiKZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3V+SEkwWs4JsM45U9nQZb/ycw9WxpFpfHVRTpb1uWBUQZZgYEofuJOf/oeB+ajfCpxSdUo1cDVpp2ncPKsvQLJcY+KeH+cUe5Lty2uVS03T5tJvvrbWu9A4RS+oC9gQWbX+4CEU5H84tQ3a2PjjfPc7ZTT3lHxoXZPpSMLTOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crr3vMVW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70ea2f25bfaso4919837b3a.1;
        Wed, 14 Aug 2024 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723645260; x=1724250060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XM5LnCrV3sawMv8P9iIjCEP1Et2llY0KSS75mGK/oMY=;
        b=crr3vMVWD0TcBNC5cfM8PJc5s3iTOEHpfYd9EAkfHcKLimVtxSJ5zolA7P+gQCIFy8
         9xxmJSbeW3uFxUO8QPH2oOzHiIIZmhu4YMqmPJh3esYZXH/w6WtN0oJcaX7wQdiSs8hN
         37g6HOkKaH9MZP5LQ/kfidb5bQA2XM5IY48Hhmg6a0y2g0YjFFxnauhBM7yQ9Ys1Vjuv
         EEHMs6WPmlTKeqDkwPSZ4WGf1P4/ajWUppBhNwMOys8y62+zh0h0bmQJpx9XvR6y+URk
         +krI80MwXH89ff0mItxNUDVez6A7SbzecGClqvZkZPf/q1VEA8ZJKTaqDPRrJi3EVKHn
         UQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723645260; x=1724250060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM5LnCrV3sawMv8P9iIjCEP1Et2llY0KSS75mGK/oMY=;
        b=tYE1Ck5YS87ntyweG5cXGit9+rdGY+rHwZaN8DUptwxRZyOoKMTorMtJt2vv/96SYJ
         +ZiPYo6uvt4agyEexdd24+sLR1uTCX2KuJwVvd7jAuF1jJVHUslgBSHReU39roEL+Xs6
         84XAxR/4rxiR/7YCNwKOr9i7148jvFOAWETIIVI9Mswq6Xzh2q+nhYAYOLtpb7cZz6OV
         oShyi4j4bfd9fSMqcNF8sw9irg0EGCCGqmTe3XwXmQ0JRNFeu6gTN3u290yMsd++9udX
         eWWerycIK5NVUULWoY9y2i4rBY7rw3tnwsc4DbzHo/WRb7s2x0QRNZ1av0f4R1Oq7ZUL
         WfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnluZnHDNR/vMzEHRyOuwrZfR1Qf90sdtJ7mTey07YmztdaRaS9Q/hoVQCumZONOB4R7hz2sRCE4FA5oN4DxboPXjdXk7Dea3rNSwNTjXmoO6/sjWPbBzZk+JXKrwFqw9g51e9
X-Gm-Message-State: AOJu0Yx6ReT2Ria7/BadWxE/xwadRh1L+dUPqYJr0zYSbJCIQ+5CWRoa
	kRJc7tH+GCSowUZgTMbr2yljML/MEaVp2Tw1NNCAQ/c2UXC5bYZM
X-Google-Smtp-Source: AGHT+IEQC+VcFtd2Tcf5ELw44ZDJYAZbnQbHv+17wmuZ8Ssr1MP5rdOnipcMidt5UdHoPUqogMG7rw==
X-Received: by 2002:a05:6a00:8d2:b0:705:9a28:aa04 with SMTP id d2e1a72fcca58-7126739c567mr3375732b3a.23.1723645259832;
        Wed, 14 Aug 2024 07:20:59 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a438a4sm7394564b3a.108.2024.08.14.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:20:59 -0700 (PDT)
Date: Wed, 14 Aug 2024 22:20:52 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 1/2] selftests: udpgro: report error when receive
 failed
Message-ID: <Zry9RKcdRbJZ_rxn@Laptop-X1>
References: <20240814075758.163065-1-liuhangbin@gmail.com>
 <20240814075758.163065-2-liuhangbin@gmail.com>
 <244ef3bd-2f2b-4820-9fe0-a10641c0829b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <244ef3bd-2f2b-4820-9fe0-a10641c0829b@redhat.com>

On Wed, Aug 14, 2024 at 12:19:22PM +0200, Paolo Abeni wrote:
> > --- a/tools/testing/selftests/net/udpgro.sh
> > +++ b/tools/testing/selftests/net/udpgro.sh
> > @@ -49,14 +49,15 @@ run_one() {
> >   	cfg_veth
> > -	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} && \
> > -		echo "ok" || \
> > -		echo "failed" &
> > +	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} &
> > +	local PID1=$!
> >   	wait_local_port_listen ${PEER_NS} 8000 udp
> >   	./udpgso_bench_tx ${tx_args}
> > -	ret=$?
> > -	wait $(jobs -p)
> > +	check_err $?
> > +	wait ${PID1}
> > +	check_err $?
> > +	[ "$ret" -eq 0 ] && echo "ok" || echo "failed"
> 
> I think that with the above, in case of a failure, every test after the
> failing one will should fail, regardless of the actual results, am I
> correct?

No, only the failed test echo "failed". The passed tests still
report "ok". The "check_err $?" in run_all function only record none 0
ret as return value.

Thanks
Hangbin

