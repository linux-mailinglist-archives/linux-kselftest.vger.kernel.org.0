Return-Path: <linux-kselftest+bounces-31833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A96A9FE2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 02:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3317F4801C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4E8BEE;
	Tue, 29 Apr 2025 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsjdrRzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4453A7;
	Tue, 29 Apr 2025 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745885698; cv=none; b=tqBX48ovm/WeZqfKG9yyhMSTzAgSNtRGwattU1NfnUg4cs+aNyhKCpngJRSR+OKxA55wXjrvGXqyPVrSupukB5xZ+DoaR+gdKWogFJEdQtAHQZ5Bym/4j70lj4WLeE1uVLXGCg8XISAkJJyDxmC4inCVE6Bfra14PkVijtR2tmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745885698; c=relaxed/simple;
	bh=ukG9HeqpcQ+1GO6qYLdY8Pxl1AdcJwX98/G0xfA2dkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn4w17VDvupYQGSCShR+jNzTKqPzCAfEVUq+8A428bls4gbVg+h3mOtdD1Aj/kWPz20Fuq+aY0IBEnwL29ZXmNu6DebLBUXvkVcmO3UF2MEoIOI6Gb3oLAzLayDhpLAV6hmjeWjWGpmumrW4duV80zWsr2f/HbM5GOxtJMzqdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsjdrRzn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so5012151a91.2;
        Mon, 28 Apr 2025 17:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745885696; x=1746490496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD79ds3YCjQTyKFTrJ7hlnaJAXSCiy4KXLJc1qdVPa8=;
        b=AsjdrRznVidM3fI/ZwtXFNhEd1iR4EL8U7fRANn3usS30jS88/3JuVilo4ymAWx+4T
         ECEO7Do78pKmQ3bx8PfVE9u2TkS39qwiWpTG8Bz3dSw/WaOm+3M/EXhqCtk2D29HxW4l
         wzt+LQ/XOJPgy1w8SkV1Iv8OMmtJn8/vSh04H+Ru1ZIBmOBmQzRX8iNMJV2KUOdYpJ41
         JfMXUW1m8WWVZnavtRq98CYGbc4MRetlYJ7Fj8MaodWwltAMzKue9PdpRpKR7gkBZ00G
         soDnMS/0GmJ2PnbS5xxFk7UCBJGJ90vKaL3zlFG9s9z3Mqyk6GYyGTRPvqHtXVc9C3AK
         2iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745885696; x=1746490496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD79ds3YCjQTyKFTrJ7hlnaJAXSCiy4KXLJc1qdVPa8=;
        b=Pog2IMpC1thJ/sZmfo12VsOE3hHwoHRYP38iocpSUgz4VUfSTDOBvhpPKcKSg5qo3c
         Ov+5kGZw62KwNm4kDUxBft2J7xsOi7oWnVUjZ9rh5U3phH1c6K9W8i6pw56z35C2CafI
         iKidN5M462uLEEBZHHMuX4FMWXYw0RCxbnuJsCpvVXGh8CcCJfgMNzrnAgMKTjrTWk/R
         m7UN1jLaSPKWlb6SXq3WtbhZXlsdmFvqMmkOJ2G5QT1nEhVk8ZLjLUcfO10jDDUk9kOc
         YBHT0uH09tUiHpapq24kKK6/AxFFvbUKcvUu5w1V3ZlaEkGYxgPzDOuqcm6drp13/8dt
         x3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUruiYl0EcuXeqbY/9LOIYBmh+FpSdkxHx0Df0u6AEwk8WGXuhHinni74TUs9yNGmn+wiHrlwg4@vger.kernel.org, AJvYcCVBS8VlwpSN2SSMTaJaQCs2OLK1HTpoGhSFCegilPCJE7wma4OwD5iTjfXGpebLcbh/AhSMGVEQcepQ8Y4aQ92j@vger.kernel.org, AJvYcCXt2oNG27junXcWbdyebOk3RsgsZrBYLC7mvpSUOMaZEqwfwM9tUEAoCCMJe5Cam3g9issZqliWsEnQAF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoe0xSIdSBzWcc3kzpD5dvDf69yq6wamS4fsa+kJ1ZwTmZ65iM
	bPWfHs4SJtPWCSmrIgyemOHQBaovhFyJx1gwonKBF7vP3IW45yszz22xW31e58M=
X-Gm-Gg: ASbGncsA+jvTaudXka+Af3HN8tZo3SFIblmWvt850Jq/ywqsOAOdo0hodDRVTUvjIwa
	jF5hXQqY0+iYqsNqVfdiuyQhzrAkTcCLvkrjAUJH9USBl3b+2AfsOYm4WAwLe9XRN2ML+wkLhow
	G12OqQmIFF4ts+zGlZqgUFD2e84tnVcxCxi2NU/n0xYl5tV8bsAn3allNG1t6ipRkQ2IJFZW7un
	P4bCr3/NAfbXEQy7ODJtRLzUvWDpQ1yzn/K5RZq8wnc7pY2W1LcGKRtE0nNR+j0l70bsFFXDBVB
	04w9+5pa7aaBx8Ey2dTGIziw4VXKahevUWCXONFHb8f9
X-Google-Smtp-Source: AGHT+IG/2mzZD80DHP89sQ6Y2zaVIFRO+ETZ75/jeNGjxU9eTucg5K13V9/nU2vFcH5nwlMBV93DYA==
X-Received: by 2002:a17:90b:3a44:b0:309:f67c:aa8a with SMTP id 98e67ed59e1d1-30a21546738mr2487091a91.5.1745885695819;
        Mon, 28 Apr 2025 17:14:55 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef061a39sm9713333a91.13.2025.04.28.17.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 17:14:55 -0700 (PDT)
Date: Mon, 28 Apr 2025 17:14:54 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] ktls, sockmap: Fix missing uncharge
 operation
Message-ID: <aBAZ/p0Yj2kFGHhg@pop-os.localdomain>
References: <20250425060015.6968-1-jiayuan.chen@linux.dev>
 <20250425060015.6968-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425060015.6968-2-jiayuan.chen@linux.dev>

On Fri, Apr 25, 2025 at 01:59:57PM +0800, Jiayuan Chen wrote:
>  net/tls/tls_sw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index f3d7d19482da..fc88e34b7f33 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -908,6 +908,13 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
>  					    &msg_redir, send, flags);
>  		lock_sock(sk);
>  		if (err < 0) {
> +			/* Regardless of whether the data represented by
> +			 * msg_redir is sent successfully, we have already
> +			 * uncharged it via sk_msg_return_zero(). The
> +			 * msg->sg.size represents the remaining unprocessed
> +			 * data, which needs to be uncharged here.
> +			 */
> +			sk_mem_uncharge(sk, msg->sg.size);
>  			*copied -= sk_msg_free_nocharge(sk, &msg_redir);

Equivalent to sk_msg_free() ?

Thanks.

