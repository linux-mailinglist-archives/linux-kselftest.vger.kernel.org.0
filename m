Return-Path: <linux-kselftest+bounces-21958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B519C7A27
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF168B2AB98
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6774201253;
	Wed, 13 Nov 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqzHpRMP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC6200C8B;
	Wed, 13 Nov 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519749; cv=none; b=HQXLSmDvRrgVacoW8OeCgMjQdBA6aq3Y4nK5MBsQnRWCUSRPPeQ3j4f2AAizx0RJ2yP9Qm3VOfPNZjmOsGwB6oElBkn94POcj7xgPwt3yaDB0rb6DWcgc0J6pfI5eb0lVp0zCt2n0/anE9W4IXaefm08PIR31fp5kPwe3rjqACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519749; c=relaxed/simple;
	bh=ObunAKm5W1Dow0Kwt3YYfY+J8m0Z2alvoeRTljirf1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJs2poaSBzWRYvnW3dK54GFNrQbrx70V5DfChb91qNBWdTbDXNKjtGZ90xB2SsO5YlDzv71OFKPS2Xckwj6zqqST+ndF7Gehd9LJR9wjVdhvHkm/QSF9o1s7mszNkFrwLmng/3GfNLEtpVZzkWAS0k7jp+djpavKcQv7hDnw/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqzHpRMP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c77459558so66082685ad.0;
        Wed, 13 Nov 2024 09:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519747; x=1732124547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EkQ3Bc0x2MnJ+quZSzaa7K/N+DrwdsbsHIFuKS+JNB8=;
        b=CqzHpRMPWEAFajkLyWIqygYl0Q4tCoEncloaWFw9GVZ4ZMx4phu/t6OJ0PjbtpSxdf
         lYlJHc3aLBU+peEQwykRo6nJW9hPRlOQVwkfY5gsN5nRm9yp/1/7R/GkINoZlWh134u9
         MhLoUC0uNI8RaFKyKZ+V+h7+q+eYetiKtrRRgBvqYFz2vRL93thE43XP1PaScPcJIIO7
         EHzxE/3mLW1O+IHgujbuEcytBLFNAa7FxgZ+ZOUKsy33wy0GM9oilbX2vzIjMMg5Rhnq
         alAAmYYqwy74pm1oataNgPxMFKGBK6qTyntV4qnpW+nT6BSuodOilOzPvgDhzQL43t4i
         7ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519747; x=1732124547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkQ3Bc0x2MnJ+quZSzaa7K/N+DrwdsbsHIFuKS+JNB8=;
        b=vdo7bvZOH6y9f578KswWJyiXJq4Twy8Vk+iMXsvsN76XCXbEYSzjoSOFlT/32d0psR
         BAu7qXdGV06Z9/S1fltkS56ulVEGLLy5nBNDZkyVMNia91wkt/v9YUOkFZlpCUeT/u8T
         VphsFIm6AIYqN796auzZPzd2DkwDSvhxb3+TjoSN3Px6xpo3Yy8AH0VwzKdFGidiB8Ys
         UIHb1Dbzx5WJB+wlBQL+QR4a31Uul5Tw/yrXAQ5z8LlWdnHLYmKaB8XKuRBriDz4SgKi
         Le6/IS4MhkG/wlxtz/u87wwe9o2xZNzpgn+RZK2lZIHY0VuUIyIzEJFVhKqMziGZxuor
         jejQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBqj69ItDcbXZ9KsMu1HtMKtak9XFZ5isFC/QMQ/2MPPfJrlHfrRuQpZgsbGZcR2BJC/y4AT468Aeo1d7jmc0O@vger.kernel.org, AJvYcCVT0rPmR5SGMSvk8Qt0r+gFaxBbhhvER0QVp2RpqNSTzBTF3HoSy9pDGya0BeGufwCLNbj4mzKl3DKjxesi@vger.kernel.org, AJvYcCXNFvh6XmtXw1grlcf/LabJE2ucLEdsA4yE43Vuu45YlbgeV2OVm77tXbFQMBURB2OytWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6CkORlJENObQLqa3k6zlWYDG2jDmnuQZUL3L4z0eKJJ/v9BN
	Yr8RwpMUThqHTS61kRNQh0UyMcudBuQviVt5e9xZz5Eiw1QQLOM=
X-Google-Smtp-Source: AGHT+IH9L8h4da0i04WU3+G03zV0G1bq0Xu8isL8T8sY10y4geZiB2iNtJ2O6Sub6z0rfSkkTlr8lw==
X-Received: by 2002:a17:902:ea05:b0:20c:f3be:2f8b with SMTP id d9443c01a7336-211abae69b4mr93611095ad.30.1731519747516;
        Wed, 13 Nov 2024 09:42:27 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c368sm113461825ad.240.2024.11.13.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:42:27 -0800 (PST)
Date: Wed, 13 Nov 2024 09:42:26 -0800
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
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 04/10] selftests/bpf: re-split main function
 into dedicated tests
Message-ID: <ZzTlAmxagJmqNRe7@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-4-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-flow_dissector-v1-4-27c4df0592dc@bootlin.com>

On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
> The flow_dissector runs plenty of tests over diffent kind of packets,
> grouped into three categories: skb mode, non-skb mode with direct
> attach, and non-skb with indirect attach.
> 
> Re-split the main function into dedicated tests. Each test now must have
> its own setup/teardown, but for the advantage of being able to run them
> separately.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>  .../selftests/bpf/prog_tests/flow_dissector.c      | 92 ++++++++++++++--------
>  1 file changed, 57 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> index 6fbe8b6dad561aec02db552caea02517ac1e2109..c5dfff333fe31dd55ac152fe9b107828227c8177 100644
> --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> @@ -549,63 +549,101 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
>  	}
>  }
>  
> -static void test_skb_less_prog_attach(struct bpf_flow *skel, int tap_fd)

[..]

> +void serial_test_flow_dissector_skb_less_direct_attach(void)

Any specific reason you keep these as serial? Seems like one of the benefits
of splitting them up is to be able to run them in parallel?

