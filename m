Return-Path: <linux-kselftest+bounces-7848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B18A34CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948D1284BF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DE914D44F;
	Fri, 12 Apr 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qvNcdshZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAC14B08C
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943273; cv=none; b=PnnmViS1m56nnoF9f5bFWZfHfDPRAVrv5rKfcOmnmrwvqLnt/4QZHsxbte/1bJz0E1x3uqxgandqNb1gYKZeLOdIr12RtOefwSV4t1sIF7VENLHu+eNA1pntIa/Ml7Tq++tFSgAnt3KkPf/0vX4tA3RXONF1o4VF4QAWbadzTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943273; c=relaxed/simple;
	bh=trPSWbts0qeWRZx2qyrUZFaFTVVwg7Cc9kvkrHlL3Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8mhiujJGYMhDzISmLL16eUqwQA+gdfhVTAf+OsTsAHpLg4NVCLYJV0Qj1e3957qjQzqwe1TSgyZudvplWkT7LYts4VQfFb9yfB0y4mx+41Ss8jeTJV/cyAV9mrY4CN2BDSYz99hV+smrUYDboL7nN/EiebKbiydOI2Kwca6qvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qvNcdshZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso859882a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712943271; x=1713548071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEydYnVIUiV6lB5t0xe0YqzJX4OVoeUrqtT1X9ALVoM=;
        b=qvNcdshZoOmLKcj6Hxhn8syXlCyDMdQAZ4X+m5c3xG9coLzT5HEFz7Du7HhJBELiUZ
         hhPsSnNxlEmbkrtle+3SGyxhiqahYZCu9IfHaqIffV1CBaoogmyG2NJKQVDx/avQN/Yq
         RcB+RORJSbaTyyAgNkaBGxP4VepCLYccBJZoQhB2i9Nn9ZTyIMBuaaUMImVXPYiGlDXR
         8JzSJjyZk/QareLUU0t6AtNAZNBYFWTYS8j5y/LR68DJNPUhTpUy8ZUbWBZzNmCVnhzI
         bbWSfsfTr+ua76Bcx4wiWxQeHhr6cQmXb26YFW5n3dMFbKpaYbAkC/thhM149Bg9ffN/
         LBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712943271; x=1713548071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEydYnVIUiV6lB5t0xe0YqzJX4OVoeUrqtT1X9ALVoM=;
        b=OElND9+fAaHjHzN/Lq27xFpExWkVBxIwfLR6nfepJ2s0qUMO58GQtFVHlZgQmnGCi8
         6/MF7tJ+xFZ/HX7Bz+fSDXtb6awfAeqxr4kzQe3F+maq/cateXNqxZ5yiEXX8UVE1zax
         Z8lKGl5SmAwiaSRxjXBGvHc+F7Fuh6DddUHwxUJqWYIpmhxSaV058kF4bSBCWktMSyW/
         R0qy1rNaLy2Qdj+ZRnTPZJnCVZL7wKu7GmHntQUBVV3JDNfr3/NjAFCidxqezwCXxzim
         zU9mNihNyXYVN3yLjcVlb26AGXJVcbsQYMSWpQDswwM+IyX1oVZdrdn9DjtyUadegySd
         BDvg==
X-Forwarded-Encrypted: i=1; AJvYcCWB2pyZG3Jbe6u6rXt2hiV9f1hrU1qlI+vQx0HWUGnm1M6kBrnxEsqbCRk9a5yvaiCzG6FJShZraDSmfWirvhABsf6f6U8rWUjcBh49tH5p
X-Gm-Message-State: AOJu0Yy1KQeh+rFhIAzpYk/s1R+/VyuYg3iohIV2wT0sQLR1c3asRBL1
	YL6jSrd2G/mPOubZa/Bp0tBFpFY+Ep6bdDISxtvXoLPEbyApt9nAF32PUxzVdbw=
X-Google-Smtp-Source: AGHT+IGecMdCX/L7b/b4jRRmemcxcjENo5rWeeIe8AMz+k5W0w7mlpSYqVctJhJ2M4+aY/mVz0JUCQ==
X-Received: by 2002:a17:90a:2cf:b0:2a5:733c:3105 with SMTP id d15-20020a17090a02cf00b002a5733c3105mr3650134pjd.26.1712943271582;
        Fri, 12 Apr 2024 10:34:31 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:121b:da6b:94f1:304])
        by smtp.gmail.com with ESMTPSA id fs6-20020a17090af28600b002a4e331cc69sm4732571pjb.20.2024.04.12.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:34:31 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:34:28 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/19] riscv: Optimize
 riscv_cpu_isa_extension_(un)likely()
Message-ID: <ZhlwpKuqVkQCr6u+@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-7-4af9815ec746@rivosinc.com>
 <20240412-aerosol-heritage-cec1eca172fb@wendy>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-aerosol-heritage-cec1eca172fb@wendy>

On Fri, Apr 12, 2024 at 11:40:38AM +0100, Conor Dooley wrote:
> On Thu, Apr 11, 2024 at 09:11:13PM -0700, Charlie Jenkins wrote:
> > When alternatives are disabled, riscv_cpu_isa_extension_(un)likely()
> > checks if the current cpu supports the selected extension if not all
> > cpus support the extension. It is sufficient to only check if the
> > current cpu supports the extension.
> > 
> > The alternatives code to handle if all cpus support an extension is
> > factored out into a new function to support this.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> 
> >  static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsigned long ext)
> >  {
> > -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikely(ext))
> > -		return true;
> > +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> > +			   "ext must be < RISCV_ISA_EXT_MAX");
> >  
> > -	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && __riscv_has_extension_unlikely_alternatives(ext))
> > +		return true;
> > +	else
> > +		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> >  }
> 
> static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
> {
> 	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(ext))
> 		return true;
> 
> 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> }
> 
> This is the code as things stand. If alternatives are disabled, the if
> statement becomes if (0 && foo) which will lead to the function call
> getting constant folded away and all you end up with is the call to
> __riscv_isa_extension_available(). Unless I am missing something, I don't
> think this patch has any affect?

Yeah I fumbled this one it appears. I got thrown off by the nested
IS_ENABLED(CONFIG_RISCV_ALTERNATIVE). This patch eliminates the need for
this and maybe can avoid avoid confusion in the future.

- Charlie

> 
> Thanks,
> Conor.
> 



