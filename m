Return-Path: <linux-kselftest+bounces-21955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6069C7A6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75282B2BFD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367C20101B;
	Wed, 13 Nov 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1ULK3OI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6E1F80C8;
	Wed, 13 Nov 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519067; cv=none; b=bUkYhxA94VgXKS5ajPPNPXvciObCy8r16OxlJs7hnzxk+I4b0Mm01ob6Gbx+ySxSfuF8LKmwsknnDonctYw5Ync49X4fb8L0PNf7aN3n9NGZrx4+UlwyrZou9PZyy4KR0P7Y+rLFm1EwWZu9XT8CjW2hmXe0VZVlUkEQ1muHBTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519067; c=relaxed/simple;
	bh=wM2LIeZuwho5MTyajMgsnq+6TqtS6xgt18ptAgYsbK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDpbV4EzaAdZP5jWvrvMAMlwnCPd/6zIO/Z70nHQOJX4hlMvIV9mOBckbcgdfI49cEUQfTVHfaaINujeFPQU6cCUvPqL1ruXNOK+8jnWsmNCnjC59f08K31cfcRzhoZ3wojydjqy9VCizQ2QZCiQEela0s7MQbnQhkT4xkjl4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1ULK3OI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7eae96e6624so4995675a12.2;
        Wed, 13 Nov 2024 09:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519065; x=1732123865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2SnJeBCneJsNVP3wKudY4HbBDGuh/E7PxPQpfhhhdww=;
        b=j1ULK3OIEIztYmlek6g1rr9STWSI+Wm1dZnWpmo1aNinNK9kvQ5S3TymP5MUVaMEeY
         n4DkR24sJ2s5vmbUWefGB3XzGM32vDdgwtMyuxv0iY4JVsf323m+YcXJZ1+ePX8vWYKp
         kryKX62rQXULCZu2bH2JeshSa8PpponEdZsii1AbRmddPEYEcnQQCsUaLfOl2PJQFNF2
         rGaYk6zIGZprLn3X/wGFgPpTDjVPabsXF2z3XfpYJbwKUj9yXV0JyJP1nNdZvHcKtJqN
         iNi2fHrZluIhj9xKd6XSvY0c3oiAvzNht2Ib0WBgFBADnQSMkgoCy+nn1Qvg7Kp0ejcw
         A9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519065; x=1732123865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SnJeBCneJsNVP3wKudY4HbBDGuh/E7PxPQpfhhhdww=;
        b=Czs4Gkx3XYnM5SS8KnfEEet+o2Wv1O2fc/Tt1Xc29SGDc36X5g8ko6AVP1yMBwfCBZ
         ph/ou5hwNtYWvo2l6UTFxfnov4jRTowva4HvSTMt6nvi2baVQkwr0f56cycqiCYJMKDl
         DRFeJEnrFeorGoMrGQW8dDREyjMMLHNzUck42XW4rZEAVb3gBS9WUmzQ3SJaLBpAEDIp
         Pxm62L+peM3XdZXY1xGipYT4U6xyZsFF7vmNvEaU3s3MZ4zxQDbu0naGywW7dGMzt3XU
         KWBjEexA0xR1c6hgFjrFP4VLaFr77IJg1AqujzyNRofHmrWk3shdwXU+vn7acc/twLMX
         YvJA==
X-Forwarded-Encrypted: i=1; AJvYcCWzvK8uJKMM8YsLttSgtBt4qGvjmp6ImfKm4W5frvjpifv0iDvAGsRMzgMG1KmLbl5SBJM=@vger.kernel.org, AJvYcCXTI9NMjicnJXJUSmA74n8TWfg/KLS5nxzqUe0+0s37rYMjZYMmyvsZhcN3VbPX8HuvCDiwOVUbauTLkO52Juje@vger.kernel.org, AJvYcCXx3Tc3mapMg7h5L3gb5zBEtuJDgOek+bbnRWtYV/75T4uc2xzo8+B38rZCZlGcKIfLxJkAXttfwYEXe56I@vger.kernel.org
X-Gm-Message-State: AOJu0YzD1oOBXZ8oopGfi7g5lpTZS27qe/GEDBbdIV82H0nmpiQz0y5m
	okw/QqrbL0xODa2zo5F8F9rYWALYipE9fNe9sAxu4qGhuROlSNU=
X-Google-Smtp-Source: AGHT+IG9PteFS9WiKoGXgKwgDAw8HaSTb1BxroQtjfOr0tK6g0cn2Yzke9177Wjn0cpTZ7sCdN3xng==
X-Received: by 2002:a05:6a21:7886:b0:1dc:5e5:ea65 with SMTP id adf61e73a8af0-1dc22b60950mr30420141637.34.1731519065222;
        Wed, 13 Nov 2024 09:31:05 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5df334sm12738452a12.34.2024.11.13.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:31:04 -0800 (PST)
Date: Wed, 13 Nov 2024 09:31:04 -0800
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
Subject: Re: [PATCH bpf-next 01/10] selftests/bpf: add a macro to compare raw
 memory
Message-ID: <ZzTiWBLaUDex4ieA@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-1-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-flow_dissector-v1-1-27c4df0592dc@bootlin.com>

On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
> We sometimes need to compare whole structures in an assert. It is
> possible to use the existing macros on each field, but when the whole
> structure has to be checked, it is more convenient to simply compare the
> whole structure memory
> 
> Add a dedicated assert macro, ASSERT_MEMEQ, to allow bare memory
> comparision
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>  tools/testing/selftests/bpf/test_progs.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 74de33ae37e56c90646cd1e0bb58ed7e3f345ec0..bdde741543836991398daacfe5423e6af8ef9151 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -186,6 +186,19 @@ void test__skip(void);
>  void test__fail(void);
>  int test__join_cgroup(const char *path);

[..]
 
> +#define DUMP_BUFFER(name, buf, len)						\
> +	({									\
> +		fprintf(stdout, "%s:\n", name);					\
> +		for (int i = 0; i < len; i++) {					\
> +			if (i && !(i % 16))					\
> +				fprintf(stdout, "\n");				\
> +			if (i && !(i % 8) && (i % 16))				\
> +				fprintf(stdout, "\t");				\
> +			fprintf(stdout, "%02X ", ((uint8_t *)(buf))[i]);	\
> +		}								\
> +		fprintf(stdout, "\n");						\
> +	})

nit: should we rewrite this as a real function?

void hexdump(const char *prefix, void *buf, size_t len)
{
..
}

