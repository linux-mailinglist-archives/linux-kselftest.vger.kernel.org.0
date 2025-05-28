Return-Path: <linux-kselftest+bounces-33968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2E7AC739B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 00:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4A91C02E49
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080DF225A2C;
	Wed, 28 May 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaFce4TR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2FB21CC55;
	Wed, 28 May 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469598; cv=none; b=c/9o8ini4R4qmHu24NpW7YtmiHyaQQe5VlKLYqsa3o+yZryLiBWXwfTHVFL4YcND/KyaZB/wg+Sc5dZ7eL96bQ/UJNrTKCHwkDT6AuiKIXpQRR5M20deBMKTLlWTEH1rTB9kIeEnu4McV//7G13TY3NNkLXiKiXR/I7xl5jm/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469598; c=relaxed/simple;
	bh=OzlMvIbiohOoLs56UeBAFtAj7HJNg/35ummiJqNtWx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRRmqrf8aoTqwVFUHCfso7IKcvsDu5pK5chEILiLGJjW5zZu5V7j7zKj/Ls2+BK+sd51+gVf2zMqlNzLZ4LNrkkF6IQP1h7a35m39hRRFwVlveiqOaghgzOkw+a/HAZtKUaQwouyxU7GNxZXi+MNQIGTAjCcnaDuPsCCttZpiD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaFce4TR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234b440afa7so3217945ad.0;
        Wed, 28 May 2025 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748469597; x=1749074397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/4crBomm0+SrpuljINsV+oVaqgrypatf4MeU4yhXkg=;
        b=AaFce4TRA6YfQEyZ0kjBpaxXlESm53mi0ZdQjbIqupYIE1M3ebCuylDEHFOHVeex+f
         qw0b6kbHaV6SZt3+U8oPTPtw8YBtRvvrwvEiz0qZw8+XOJghfVsKCm4ngysFYmhM0h8i
         NnL+eA/Xn3XfBladUi1wgYSx+OnMnjn/7NIMCD8RuedEljOR6fCP+pjjrjo1RLt4vIpO
         8/1xG34RKsiQXSeVtkT7JE8/JA7aatwKE/CZoxh6xnpBI7BX4Z6YSLGv83AreNsUQgzq
         cNELo5G32B/rIa8QIyEDR6l7AwGVZHYTY1g4u8/pjNDEsISx9FEy9jgEnQhZ24HXw7Gx
         gf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748469597; x=1749074397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/4crBomm0+SrpuljINsV+oVaqgrypatf4MeU4yhXkg=;
        b=m6pWxrbcVjS9BT+7d53DBDWry+YUh4PZtYGFERd72lJYTOlAfSao5ZlUsx129sMWuX
         sus/5igdeZj07KysYKPHax9PUTrdPsY5dSkcylx4bMCiV726gh9ozHpN7YZzmcr4JrKX
         bWjVxV6UyUADXMf2ECw1YuO9df3Tm91uvn3TjwSGEBg4BzVcNTCLalrV+j/R1F22IhP5
         iV3qVcGptFdGQsVrtlRTdUMdhUBkyDsHBHK+iV3SKe8p+VgoN5k7+vyA0MbpznGPMfXf
         pdxtkxmE005l9HpVOrkJWzME/vgRnh/NKSsdYhxMpr7YXl88EbW46jg0Doje8UElPmlq
         QWXg==
X-Forwarded-Encrypted: i=1; AJvYcCUjQly7Ks6Gxd5LPvUyl5H+3QILjFx4LGJLip+Ny2EG9InXRA1ffSWQ3aDspF2kaXh6uvu6pLL7@vger.kernel.org, AJvYcCVGULs8e1+eN6jUr19lICV17VIeTxOE1lzZEw5/B1GgfvECT7krwndskAWjetzJTrBsLYzkJZPADytdOlQ=@vger.kernel.org, AJvYcCVuyuVyYk3GTgdKCM6iATS8ouDoKT6mqT5we/JyNk2aHwpq99zO6fMHzU147uYeYJ2K8aME/LhBAHjy6zyxQLZ7@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6ntoAfjKcBjaFNok7OTeswaZc0RuknOqAMYL6Aq3RxfITdm7
	Low1PvViPUiVWOCFmpRYXOBD4HSbRDxL+nB+c7+yPIR4vxAVp4qx1SZr
X-Gm-Gg: ASbGncvK2jbSOYryTd21XYKiwbp83QVNt331d/uuQ2oLoI81ZcErRDyBbV9CjDc1WCN
	eA8ciJMTrjgrKFyUHrYJZQnzYXXFEAFiADXkBPlJ+FLP9XHUlHsfHEr7zpbcAwrRh7MBf1eRaff
	9IM7CmcS6w0f1Mll5Z+j4+I25TCC9KLppBQalkFCe+FDKZV1u4MWZ35xafxP7UwtwqEJCPrViaQ
	qhWvRwY0L/FNWY67Bn3+xxi8IGwESeJL4SE6+O950Qj1xzkRCw82ZeNNLLDCPDXUGNA5vmfjGqD
	5VodVM1UHLZxQJw7uwK79u7Zg+IcyOlDU8XNnZ8hcNv1HORJr0BG
X-Google-Smtp-Source: AGHT+IFh9EkIMO+rVAe9YE+Edi9ItDRM+sVz3sMoi6xmhMnamNRC0/zSVn852LkiltAiR/15FKawFg==
X-Received: by 2002:a17:902:f610:b0:235:737:7bd with SMTP id d9443c01a7336-23507370971mr471445ad.27.1748469590047;
        Wed, 28 May 2025 14:59:50 -0700 (PDT)
Received: from gmail.com ([98.97.34.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf50b3sm591735ad.174.2025.05.28.14.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 14:59:49 -0700 (PDT)
Date: Wed, 28 May 2025 14:59:45 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Ihor Solodrai <isolodrai@meta.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf,ktls: Fix data corruption when using
 bpf_msg_pop_data() in ktls
Message-ID: <20250528215945.wtfadyr7lvzyqzzc@gmail.com>
References: <20250523131915.19349-1-jiayuan.chen@linux.dev>
 <20250523131915.19349-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523131915.19349-2-jiayuan.chen@linux.dev>

On 2025-05-23 21:18:58, Jiayuan Chen wrote:
> When sending plaintext data, we initially calculated the corresponding
> ciphertext length. However, if we later reduced the plaintext data length
> via socket policy, we failed to recalculate the ciphertext length.
> 
> This results in transmitting buffers containing uninitialized data during
> ciphertext transmission.
> 
> This causes uninitialized bytes to be appended after a complete
> "Application Data" packet, leading to errors on the receiving end when
> parsing TLS record.
> 
> Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

LGTM thanks.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

