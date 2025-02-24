Return-Path: <linux-kselftest+bounces-27366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76EA42932
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 18:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CF1188720D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36092263F4B;
	Mon, 24 Feb 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X40eBgM0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E023263C72;
	Mon, 24 Feb 2025 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417249; cv=none; b=ogegyzvW3epTI1MjnEJ5EZdsJdloN9smFdeuSqNjAzymRLAXi/ogPJH9kW1/J5RMAFfmLjz6I7z8Lb3Iw+zMtJzDu/LVuajM/omIZDTJiU6s/uKrN4+Af334O4q6ABOienvlJY/S5GQMDBsV3Ir8gPtK3JOd8+WHs8oiNmuY+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417249; c=relaxed/simple;
	bh=vgv2L1XM0VItTqS2y29EnL1yRFDsRL1SRD8nHEhksHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE7CyV/VdgJKYNe2vQOK76wMuTUNgVT4uMeqtY+BpHJpYrpDyPlnlcZ+7DkYUn8t5786RIxTwUKGCvYGf498nRLTRFwf8iB2D63IMlzerVlqdeQn3YIVAGIIgc2mGMj7D/uNB5Cgnp8Ar2AnDrnjz6Z4D9R5m6Bz8wLKpxxxtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X40eBgM0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220d28c215eso72104285ad.1;
        Mon, 24 Feb 2025 09:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740417247; x=1741022047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzHQZGUN2fiNxujdzGVV5v8tk/eLdGbSbAneE7HkW1s=;
        b=X40eBgM0HJym2XKcjN6EVJ+k9B6/+B8wTt/GUvNjIXAEog85nm5460s8PLFw358sYd
         bAD1ZmSWmfEP/puQW0O1G7aW4Oc3nQqX3YAmYa2kQp65G0D6wIjYnM8wMnjaJbShVq1Q
         TeYHbMWKXUXQ6jR/beNTuQA0OGjyBM3sqd1oAF3jlwDysOdx23rP030Ypi5wilLW4Qks
         EAFqPusPGrULnHe6SF4/7HnjIvQo/VIeBk8d7HTFskA4xGbctBb/ZLLtb2r82izr/Y4W
         3Mi28JRdV06iPVJI1yLjDlzQWczwBuwhDVBsAF3jTGmRAW/8LAstMJN82u47DEXWXYPY
         S3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417247; x=1741022047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzHQZGUN2fiNxujdzGVV5v8tk/eLdGbSbAneE7HkW1s=;
        b=WExzHYPDYyLecp75qbE2d7yqfnmR+xRN3dotpqvXzNArNPHDpESMFkS9wb6x4dzJX5
         AGeprPSchTcX54LgoN7B/M6EBM/PiiZvHAn1lWfIEKFXT6G+rmpJWASJUJIz/Q7gDT5D
         UmzmWD8vFJaMpNkaZ/AJ5hUOKQGUNVyZUZZqMTuziH/OgDTvbF+77HIb6o0dBarRfexK
         Cp60TtK7Yv26lnjX2Xp0TWugicAwUy3U2OoFNsLGMSSnLdsq0KMjgOixpUEAvsxT0dki
         xd4tb+eJ7x3HBh5n+EGML2bmOmnHETTibFghWVDGyqXoXpI7VV3vwOCx6EccySX9dLCX
         j5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUyJncXL2m1+nbq57Y7OC/uXu7yzzGeviYU/fcOACTXd8XeBaQ+67Eku57N/1UwP0KrQdszyfANZXwOIIW0P4bX@vger.kernel.org, AJvYcCVyook9Gw7TAe0PW4bKUnzbh2UOWcK7u+MSklcxEGP8k+8ONfwFwlN54WChlm9rG/QtLIc=@vger.kernel.org, AJvYcCXm6j9CIcDnX7RIgZOndiaKcGnsy23+xObSWcHmhdHFmxIqfoCrULD5bLuTiEuu02EjSHBCxo9yDpgk1Qlp@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4nNNPEOTIxrmE7DBWlA13fx8RieuBVwEPjZYXYRh9CD38ILs
	WWvPkJuhGSNbTvZaZEWkBaN8MiM7msaKak/HF2CsjsXeQ3RcQq4=
X-Gm-Gg: ASbGnctyZrYyzuLn4NmD2n8GmhQkA6obtaBI5k/oLgLGb63WcGsEgdh1R5Qj7fMwjKy
	X9lHXoc9lxiYecpt1m6Hp6kU8sA1Wo/v7RdLh583lPe45aLyAmQ20VIdIYl8YU4w8Hjvnz7VULB
	EvZOkMTU9nGb5w0RFSkJZ40ZfE7dXBGnZsMpq3sCfjnBMSI/KGDz4CIqwa2gCRyUQnSr/9lxhID
	UNcFtM9A+SvwdDVw2cOzB2w7hLIBSoISj6antzER51afE0F7KvDV7qR0hVyNr44/OzQw7dW+NdE
	hM9HKYyf5dPImmtW+MeeR/V7xg==
X-Google-Smtp-Source: AGHT+IGdVW9Fy1iMbTYlSp8BZQCLFel4XTMelcidD8YM5VWNEbAMfbnpTrSJwlcjAULZeJNJTuiTeQ==
X-Received: by 2002:a05:6a00:228c:b0:730:8ad5:90c1 with SMTP id d2e1a72fcca58-73479101286mr6595b3a.14.1740417246712;
        Mon, 24 Feb 2025 09:14:06 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242568146sm20955384b3a.47.2025.02.24.09.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:14:06 -0800 (PST)
Date: Mon, 24 Feb 2025 09:14:05 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, hawk@kernel.org
Subject: Re: [PATCH bpf-next v3 5/6] selftests/bpf: add test for XDP metadata
 support in tun driver
Message-ID: <Z7yo3VfHofK-W7EY@mini-arch>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <20250224152909.3911544-6-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224152909.3911544-6-marcus.wichelmann@hetzner-cloud.de>

On 02/24, Marcus Wichelmann wrote:
> Add a selftest that creates a tap device, attaches XDP and TC programs,
> writes a packet with a test payload into the tap device and checks the
> test result. This test ensures that the XDP metadata support in the tun
> driver is enabled and that the metadata size is correctly passed to the
> skb.
> 
> See the previous commit ("selftests/bpf: refactor xdp_context_functional
> test and bpf program") for details about the test design.
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> ---
>  .../bpf/prog_tests/xdp_context_test_run.c     | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 4043f220d7c0..60aad6bd8882 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -8,6 +8,7 @@
>  #define TX_NAME "veth1"
>  #define TX_NETNS "xdp_context_tx"
>  #define RX_NETNS "xdp_context_rx"
> +#define TAP_NAME "tap0"
>  
>  #define TEST_PAYLOAD_LEN 32
>  static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
> @@ -251,3 +252,66 @@ void test_xdp_context_veth(void)
>  	netns_free(tx_ns);
>  }
>  
> +void test_xdp_context_tuntap(void)

tap0 is already used by lwt tests, so there is a chance this new test
will clash with it? Should we run your new test in a net namespace
to be safe? Bastien recently added a change where you can make
your test run in a net ns by naming the function test_ns_xxx.

