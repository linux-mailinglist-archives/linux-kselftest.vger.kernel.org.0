Return-Path: <linux-kselftest+bounces-30668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA4BA87E5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A003B5049
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2EE28368C;
	Mon, 14 Apr 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGNaNF5U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D10281529;
	Mon, 14 Apr 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628689; cv=none; b=RNeWwTbcZdlkOSuoFOjWimNBi/YWZN5dWjo78HnJzqcQPbnEjrM9a0VGmRp1o0HO3Z7BHXaQGLbSz+Q4JY1LJFw7JAeLNhCrzEULXEaO5JFun/tmYANkxqWE6h1plHFaeNN0isYrCblR7o8zO0boGb0J7XJEAwVn7Gn8yWPF4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628689; c=relaxed/simple;
	bh=IAENeMhSD6LNx9q+NKZ4mbl9NprCZvlsuBAutNFVpnI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwS/Fz77EMUT20BhV7tcGsmmX9Yy45mkHBwsb9OvV9fWo6X/y166J5UUfYb32gdFrT9ncRVrSNd3zmU0/YkP0cwnyWpLwBbBOLqAWoMD212ICJLX6eH+j9mDI6Qfz4yXSuWiSAFY/8lnBb9vB5+e7p8fbj/9b1lJxGD9ESavVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGNaNF5U; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac56756f6so3624999f8f.2;
        Mon, 14 Apr 2025 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744628685; x=1745233485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sKIv+Ew1hQAFZsKTKMtzV43PXBAkEaoS28OQ89MT8N8=;
        b=BGNaNF5UmFR0Y4+RxE2CSaSRjbgHPdWiyfC2NhHxl00X771C1N8DONvJn+TWy7ugj9
         UAtWhY08vS7i83Bn6KwF+FL9iTUsrEHzXeBI27GIccYTk1y9KHTzwq0gfOuemip/AfNP
         DtQMHl5aOSm0Hf3BtYRQGfpiIsupyjMrbax9da0JBrRZKhq5cdRUXrxZm9XRAXVGxC/8
         idH5NESck9w1spCEK8fKtzjBhMMe6D3c8NAQJ/G0aRfjZwMv3BBFdutg3zx0ZXVlAFnx
         PlyFFGUuXx3UWtSABecUkiw/LAeJVAuKSmumwZ61FP9wLx8Sa9YdWfQIyM7GGEXw2C5D
         Vxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628685; x=1745233485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKIv+Ew1hQAFZsKTKMtzV43PXBAkEaoS28OQ89MT8N8=;
        b=VGkKJOd5XwTngarAessm9CaOtFAd/HtWE9k503k8FY3ETLdmtFLAUuDXJrdtF0pED6
         yqGulqXfxvElWr12uE46rgpr5PQPE/kQ6rwHq3ap0FXVPCBf6c+EJQNRRDFZlYfa/B1+
         bDEziug/qvdyBJ0WU6JtuYqY5r/bagIEPIzmjrB6IaA7qYNeBqTRQGUKhuFgKbh1XKKx
         D1rK0tHEwSpaW5/2/wIqRRX7MkkmmMiA1GMi8AbSuvchLUzWwwax8vko/KkXfjSN8d9f
         eOCZ+I2Z767w6iLbdPQaotBJGc9Ggd5jfD7K4zqs6Hwqv8YaNaETeyPBFYvuzAwU/yRP
         PEPg==
X-Forwarded-Encrypted: i=1; AJvYcCUb0SsVutq+nzDNZZBmLhPPqaa+kpC+MDKMFcRGGc2bcL+fELVOVMIV6N2FQ7KVyCClGAU=@vger.kernel.org, AJvYcCWJsIogQ+GRHW+wl1BJH2ItgaZMY2SG3ZaANHffgZtFsDKkDvYfkvgZJh1rAFlM11mGfQOu7enycdWxtDSA@vger.kernel.org, AJvYcCX4phxHXFZiCPPmdwUan13bGlrVMvnmVKxnfzPlGz5lG3znt7ccxgf/Q47fB/ukE2zyMMw0fwRyaZlss/WYLY6Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8T7uze2z1hQK7j4HttIJCrelvD5babHNvZbiGFyTZyKFc3df
	zyAVtFNgRP2vw095gCONILA61jj+po5pXa3XKsfuIBEIBP2Q07Pi
X-Gm-Gg: ASbGncvDN5ifzjFXPV6+FTxp6Drvw+P6bNeVZYBK3rauuDlh7scX/2P74ZrKolCSpjC
	hco1l5t4Q8saXvV7sYbVYSg/5OwvlBsjmkngs2V9X0e7nXXw/exZxWGhhFojtCZ3WCZcsci3PTL
	u5Q7mgA5H3ZK29qHqnirW9JiZYIwwcl07kPhHCefRPbZd/CD0bkMSzeE7J/D2/zyR0DfVTMFsW1
	344aXwhzsSU1ulyFtlyMW+/uV3HpEd5XsfSYngijERJ3zWZhKnyiNACg3nk2DazutiLzn9B1atk
	gkPF95vjaxY7iy2+R38qb99Zb/YoGws=
X-Google-Smtp-Source: AGHT+IGrvwgLQedKQvifH2Jvu4TYIj9/pf5+d/bwg1/VjkLHL4cwxQAuHsTjKrrtJbJPnThtPqVuQg==
X-Received: by 2002:a05:6000:144b:b0:399:6dc0:f134 with SMTP id ffacd0b85a97d-39eaaed20c4mr9243328f8f.51.1744628685126;
        Mon, 14 Apr 2025 04:04:45 -0700 (PDT)
Received: from krava ([2a00:102a:4007:73e1:1681:405:90b2:869b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9777a0sm10625743f8f.43.2025.04.14.04.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 04:04:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 14 Apr 2025 13:04:41 +0200
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Florent Revest <revest@chromium.org>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
Message-ID: <Z_zryQkfmrSXYN4k@krava>
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>

On Fri, Apr 11, 2025 at 10:32:10PM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> In order to properly JIT the trampolines needed to attach BPF programs
> to functions, some architectures like ARM64 need to know about the
> alignment needed for the function arguments. Such alignment can
> generally be deduced from the argument size, but that's not completely
> true for composite types. In the specific case of ARM64, the AAPCS64 ABI
> defines that a composite type which needs to be passed through stack
> must be aligned on the maximum between 8 and the largest alignment
> constraint of its first-level members. So the JIT compiler needs more
> information about the arguments to make sure to generate code that
> respects those alignment constraints.
> 
> For struct arguments, add information about the size of the largest
> first-level member in the struct btf_func_model to allow the JIT
> compiler to guess the needed alignment. The information is quite
> specific, but it allows to keep arch-specific concerns (ie: guessing the
> final needed alignment for an argument) isolated in each JIT compiler.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>  include/linux/bpf.h |  1 +
>  kernel/bpf/btf.c    | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3f0cc89c0622cb1a097999afb78c17102593b6bb..8b34dcf60a0ce09228ff761b962ab67b6a3e2263 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1106,6 +1106,7 @@ struct btf_func_model {
>  	u8 nr_args;
>  	u8 arg_size[MAX_BPF_FUNC_ARGS];
>  	u8 arg_flags[MAX_BPF_FUNC_ARGS];
> +	u8 arg_largest_member_size[MAX_BPF_FUNC_ARGS];
>  };
>  
>  /* Restore arguments before returning from trampoline to let original function
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 16ba36f34dfab7531babf5753cab9f368cddefa3..5d40911ec90210086a6175d569abb6e52d75ad17 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7318,6 +7318,29 @@ static int __get_type_size(struct btf *btf, u32 btf_id,
>  	return -EINVAL;
>  }
>  
> +static u8 __get_largest_member_size(struct btf *btf, const struct btf_type *t)
> +{
> +	const struct btf_member *member;
> +	const struct btf_type *mtype;
> +	u8 largest_member_size = 0;
> +	int i;
> +
> +	if (!__btf_type_is_struct(t))
> +		return largest_member_size;
> +
> +	for_each_member(i, t, member) {
> +		mtype = btf_type_by_id(btf, member->type);
> +		while (mtype && btf_type_is_modifier(mtype))
> +			mtype = btf_type_by_id(btf, mtype->type);
> +		if (!mtype)
> +			return -EINVAL;

should we use __get_type_size for member->type instead ?

jirka

> +		if (mtype->size > largest_member_size)
> +			largest_member_size = mtype->size;
> +	}
> +
> +	return largest_member_size;
> +}
> +
>  static u8 __get_type_fmodel_flags(const struct btf_type *t)
>  {
>  	u8 flags = 0;
> @@ -7396,6 +7419,8 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>  		}
>  		m->arg_size[i] = ret;
>  		m->arg_flags[i] = __get_type_fmodel_flags(t);
> +		m->arg_largest_member_size[i] =
> +			__get_largest_member_size(btf, t);
>  	}
>  	m->nr_args = nargs;
>  	return 0;
> 
> -- 
> 2.49.0
> 

