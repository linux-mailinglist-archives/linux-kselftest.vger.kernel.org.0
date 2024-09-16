Return-Path: <linux-kselftest+bounces-18025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBDA979CA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027C0286831
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412713B5B3;
	Mon, 16 Sep 2024 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ/f+xX4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C54E1CA;
	Mon, 16 Sep 2024 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474826; cv=none; b=WVHJ93dIEbPsM7WrXm2JsrqTyLKYfQDrH/w3Tvfkw0heza8jU7duLJFYeTAXehBnCL2PQO/UBcT9UZV4m10ypQd8OP97UxRuwQm2ON/l2rW1lWcrhXSAAxTFymarx143MsgjBSIzui1TZLAXl/gCZhb8pkvhgjgy44qumvKDnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474826; c=relaxed/simple;
	bh=Afq5Wg+dRfLwucLBVd0tMG3KSk48F/ws33p0aFtotUw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqnTY5mAVoVxzObIG7sdHEKzJA7mZv7XpmRldBGsyC7jKdq2rEaklw4r6VJRvWz4MqseZGwaiATPhHgTuE3cAUkRzKYp9P4UvLbvl4e6YFqw4BcwmNIa9WfXSC7ZjV1zDfvoUEu950xAlMLJn49OU5E+sHSo0cw+hXC4xPt94WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ/f+xX4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so1627670a12.0;
        Mon, 16 Sep 2024 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726474824; x=1727079624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6MCfJTZwbuVEkiCx3X1OjG9E2fKonsSp9C5lzZkD7U=;
        b=GQ/f+xX4w/w1UbX/XiN9zsg1Ik3g4CL3Fz+GqDFJdAEz/VOXxuyczvDRaPCK0Z3yIO
         yA08VQVIrc4H3CvweeMr8W5T2xnMPJlCc924F3mkanU0JNVK9i71POKTkxm0caYaPvEr
         B1tyU9LWJP1AW+Eo/OUdZ6GcxNhjO3pmnLz7gqHh7v2jaBDd0En1QmvDQd7ujLyHvPII
         zWdvmES0qprFpM2BoRiYjQUDaqivEoYmk2O9hCdSP8lNHOsWE94UWx+68L/Yh3/RtLQ1
         EGoJi8GPu8V74k+J5aQ0Mpy2SpHz8C7//E8DispHR699wTLMiPws1jWy0903E3f1EOBD
         KfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474824; x=1727079624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6MCfJTZwbuVEkiCx3X1OjG9E2fKonsSp9C5lzZkD7U=;
        b=UWSIwJbQumbjfyeWQgac4K5KLyDr8wwNMkxhuMIcH6ZHIYr4+kwGdyoR7mZPmpZk83
         bTKE/+pPq/C2IYBh/MiJMbTi5sEUhXVzUAfq6+VwEFP0y2R5BTV6kyCqFTI0BG+jkB3D
         J+PQpCPMLKibxnwM3aj/gV1I4Vbw12BgUj6Y1VAJh6omuRule0wIfqjBTDqfUGDY7rDf
         RHkxUS+CJ0l+DrvMv85LueyxL4RNsiOIlHLbCn8t84D2KgNtBrx9xBxdHTcq/A19W4h0
         uxQDf89G6Be3XznIRr5DRFqolOLfL0eg/8g+xuCmm+9fqaNf8GyD6I4mrCDznfYHAWF1
         makA==
X-Forwarded-Encrypted: i=1; AJvYcCUO6S5l/yW2ZeLbNzF4UixsW/aieX2tepgQ+Aw4jjubeLD5WRclv59Wf0GGyxiY2TLvczR9wbIF3EcDREvh/V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+f5MPhazHTNj2cK8GgZMxEjuJ7WJ4slJPTjg+Zoteq2b8xsdr
	IDtcJLGbska7KtN5hEaHcvScqD0N43WvdJmSdILzmxx7AkeI7gjj
X-Google-Smtp-Source: AGHT+IGDGR/6GKe6BiiOquzaX7smhPL5tBaFCluv4HT1ahYK1e0EnjRhfWVNR78s15u3Bs2yCh1RTA==
X-Received: by 2002:a05:6a21:6711:b0:1d0:7df3:25cf with SMTP id adf61e73a8af0-1d112b68b6amr18154807637.19.1726474823700;
        Mon, 16 Sep 2024 01:20:23 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49939970sm3768581a12.56.2024.09.16.01.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:20:23 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 16 Sep 2024 01:20:20 -0700
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v4 4/8] libbpf: Support BTF.ext loading and
 output in either endianness
Message-ID: <ZufqRH47gxTSVqMR@kodidev-ubuntu>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
 <8eaba4b675cba9035121121bba6618c9f8f65610.1724976539.git.tony.ambardar@gmail.com>
 <d407fa343213b4bc5990de24e0f322add91a874e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d407fa343213b4bc5990de24e0f322add91a874e.camel@gmail.com>

On Fri, Aug 30, 2024 at 05:15:06PM -0700, Eduard Zingerman wrote:
> On Fri, 2024-08-30 at 00:29 -0700, Tony Ambardar wrote:
> 
> [...]
> 
> > @@ -3050,11 +3127,42 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
> >  		return -ENOTSUP;
> >  	}
> >  
> > -	if (data_size == hdr->hdr_len) {
> > +	if (data_size < hdr_len) {
> > +		pr_debug("BTF.ext header not found\n");
> > +		return -EINVAL;
> > +	} else if (data_size == hdr_len) {
> >  		pr_debug("BTF.ext has no data\n");
> >  		return -EINVAL;
> >  	}
> >  
> > +	/* Verify mandatory hdr info details present */
> > +	if (hdr_len < offsetofend(struct btf_ext_header, line_info_len)) {
> > +		pr_warn("BTF.ext header missing func_info, line_info\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Keep hdr native byte-order in memory for introspection */
> > +	if (btf_ext->swapped_endian)
> > +		btf_ext_bswap_hdr(btf_ext, hdr_len);
> > +
> > +	/* Basic info section consistency checks*/
> > +	info_size = btf_ext->data_size - hdr_len;
> > +	if (info_size & 0x03) {
> > +		pr_warn("BTF.ext info size not 4-byte multiple\n");
> > +		return -EINVAL;
> > +	}
> > +	info_size -= hdr->func_info_len + hdr->line_info_len;
> > +	if (hdr_len >= offsetofend(struct btf_ext_header, core_relo_len))
> > +		info_size -= hdr->core_relo_len;
> 
> nit: Since we are checking this, maybe also check that sections do not overlap?
>      Also, why disallowing gaps between sections?
> 
> > +	if (info_size) {
> > +		pr_warn("BTF.ext info size mismatch with header data\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Keep infos native byte-order in memory for introspection */
> > +	if (btf_ext->swapped_endian)
> > +		btf_ext_bswap_info(btf_ext, !btf_ext->swapped_endian);
> > +
> >  	return 0;
> >  }
> 
> [...]
> 
> > @@ -3119,15 +3223,71 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
> >  	return btf_ext;
> >  }
> >  
> > +static void *btf_ext_raw_data(const struct btf_ext *btf_ext_ro, __u32 *size,
> > +			      bool swap_endian)
> > +{
> > +	struct btf_ext *btf_ext = (struct btf_ext *)btf_ext_ro;
> > +	const __u32 data_sz = btf_ext->data_size;
> > +	void *data;
> > +
> > +	data = swap_endian ? btf_ext->data_swapped : btf_ext->data;
> > +	if (data) {
> > +		*size = data_sz;
> > +		return data;
> > +	}
> > +
> > +	data = calloc(1, data_sz);
> > +	if (!data)
> > +		return NULL;
> > +	memcpy(data, btf_ext->data, data_sz);
> > +
> > +	if (swap_endian) {
> > +		btf_ext_bswap_info(btf_ext, true);
> > +		btf_ext_bswap_hdr(btf_ext, btf_ext->hdr->hdr_len);
> > +		btf_ext->data_swapped = data;
> > +	}
> 
> Nit: I don't like how this function is organized:
>      - if btf_ext->data can't be NULL swap_endian == true at this point;
>      - if btf_ext->data can be NULL and swap_endian == false
>        pointer to `data` would be lost.
> 
>      I assume that btf_ext->data can't be null, basing on the
>      btf_ext__new(), but function body is a bit confusing.

Hi Eduard,

Sorry, I saw this earlier but dropped my reply by mistake I think. You're
right that btf_ext->data can't be null, and the awkwardness above is a
holdover from trying to use the btf_raw_data() code, where it _can_ be
null. I've rewritten it to be clearer for the next v6 series, which also
reuses existing info sec validation and drops the extra code you referred
to further above.

Thanks,
Tony

> 
> > +
> > +	*size = data_sz;
> > +	return data;
> > +}
> > +
> 
> [...]
> 

