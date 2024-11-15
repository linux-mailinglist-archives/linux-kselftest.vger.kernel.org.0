Return-Path: <linux-kselftest+bounces-22106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F39CF045
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86381F298B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71901F81B7;
	Fri, 15 Nov 2024 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEafp7xh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12A1D5CEA;
	Fri, 15 Nov 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684732; cv=none; b=ta8hwlHXgYBdbPsUUIarvS1VUGiZOKf5vqUnZK3WeOD6F4oDQbNGs5BSiSlmVQKRzPeqkD3U5LRc6l3Xbbu/irUYuSg02Bu6htBL+l7LBsmg+ZWimiVCEWtXvzd6RX6QmWinLGY690FuTJKcjKhyM47Xr9kz3E9S30NEBis5eGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684732; c=relaxed/simple;
	bh=RN9Jj7cHogNrffiEZA8NFS52iMspRx44QQcFduM5dms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVK2C3tABR3rCadjwXHPGkpmr34L2xFUQKCJP4/Op817g5GoSZQIYxnDd2J6E+RL0f7Hy0pSpSSMzAbYwPqyERy/XMez0kGKPWLiscou260Flp5vaDtD14+4zJ1Q3e5TKfLFuNDyNoxIU1MCNDmVIZuE/SRWCV39nrw5o0B5Isk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEafp7xh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cf3e36a76so9927115ad.0;
        Fri, 15 Nov 2024 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731684730; x=1732289530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3mL9zxHm0hXSKqka75HzWuRbkoD06vFkDW9uQg2MYc=;
        b=eEafp7xho7mW/TqWwIm3E9+O8bxECQQvyFVwUbroSysVMLDmxVefETVyMYuNq4Luxn
         rE/PSydY6fToZ9tNPYr3DcyI4EmBvHio0g0+fyp0fTTIymf11jQE6+J+Kpj/zzvFtc3s
         B682m6NBk7U5Ptnm9f/aoLekeVmwwhVFVQ7gh+Nx1dW1dDR0T1GGInBAKdFqSqLPSfSb
         ggf+yA2wql1pLNRlm9oCd1jojUJSjhuwP4BZDqhVSQFWLCBrAneM+xezP40e7y/8xLEC
         x2DtSFdXYrkscPyZge4s6Ak8v7eIvjEBgXubHP34ML+SmX6Tj7GJq6/3n/VDGtW7U3dK
         QATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684730; x=1732289530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3mL9zxHm0hXSKqka75HzWuRbkoD06vFkDW9uQg2MYc=;
        b=djDQqWeLOLjQFR45vl45nXt0rjeWPAtMFJiSU7dKhLobj+GbBei+dhCW0J2oGIXRgt
         fYGR0uSY+A5L9iPmifs3nTLtK6oVwLP8+hcNV3xutpbT4JFRLCmR3FTmE9vGpzAMhOBs
         77eBHTRX5HywHIRBllIaxEXAJD14aVUU3qoYIC4wZLAE/RzPQEBdW66f+8hUFxMNk7it
         RRhO/KLIhKUkUcgqVqxI7thptfSZP6vl/ZMLLjPIcTxtlbsPRy8XuqgEOlQB8U5w2Y7T
         wMypI9/aLb3lXjzIU8ESZKRk779Rh6p4Q4D/VPJympmidNhoE+kHg7IMECtSFRIjF7Lf
         R+qw==
X-Forwarded-Encrypted: i=1; AJvYcCVFspe4MReIPGRbfe/wivX/uaUJZuX7/bTPeQnOuG8DfGzOETzblMoZ75yAfEnlDdgST/ShefI9@vger.kernel.org, AJvYcCVPKXm5kpk+QyYpR29yJuK3vRJ5HLSukcMUbico36uYnDOT57SZUBKnW1cf1xUEbon9vaaoc/kNEa9tSR/g@vger.kernel.org, AJvYcCVUjP7HjbeA2yzudtGKoe+XOIS5HkuFHzzQjCANkem57kRwp4pieGZeYfhLV7kSbs61vAU=@vger.kernel.org, AJvYcCVbUVAbEHpfhiQZvpOOCMBs5uHOh7HpaX4Uu1ecHob87/CAQiS2TH7Iky8OhG1tEJk3Y40XJ32NUUwQCByGb8pa@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRI4MkVx3PZcEdubOzdqnv+tMqBF7+VcIZjdAzbgIiM/3pbIB
	2lP/Ar7k/uM0EJK3XBUHxCOvMQgIaHPMI4hIx+Fi1bjiNLZfoJ4=
X-Google-Smtp-Source: AGHT+IFu+wWBbSvilK2OnzkPoK8R5vT66fi/p1DGzyvRqcs8PA0GgHoXEk/ABVqi78aUUYcKl9It+w==
X-Received: by 2002:a17:903:22c5:b0:207:6fb:b04f with SMTP id d9443c01a7336-211d0d7f99amr39921495ad.17.1731684729575;
        Fri, 15 Nov 2024 07:32:09 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f1a634sm2983489a91.14.2024.11.15.07.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:32:09 -0800 (PST)
Date: Fri, 15 Nov 2024 07:32:08 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 09/13] selftests/bpf: move ip checksum helper
 to network helpers
Message-ID: <ZzdpeMsHGh1zCZei@mini-arch>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
 <20241114-flow_dissector-v2-9-ee4a3be3de65@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114-flow_dissector-v2-9-ee4a3be3de65@bootlin.com>

On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
> xdp_metadata test has a small helper computing ipv checksums to allow
> manually building packets.
> 
> Move this helper to network_helpers to share it with other tests.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - new patch
> ---
>  tools/testing/selftests/bpf/network_helpers.h      | 23 ++++++++++++++++++++++
>  .../selftests/bpf/prog_tests/xdp_metadata.c        | 19 +-----------------
>  2 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index c72c16e1aff825439896b38e59962ffafe92dc71..c9b72960c651ab9fb249f6eb9e153b8416b7a488 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -104,6 +104,29 @@ static __u16 csum_fold(__u32 csum)
>  	return (__u16)~csum;
>  }
>  

[..]

> +static unsigned long add_csum_hword(const __u16 *start, int num_u16)
> +{
> +	unsigned long sum = 0;
> +	int i;
> +
> +	for (i = 0; i < num_u16; i++)
> +		sum += start[i];
> +
> +	return sum;
> +}

Sorry for nitpicking, but can we call it csum_partial? And match
kernel's prototype with extra sum argument? Should be more greppable
for the future test cases that might want to use it...

