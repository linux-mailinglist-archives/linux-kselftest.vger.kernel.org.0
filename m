Return-Path: <linux-kselftest+bounces-28380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDBDA54551
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 09:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341C518849E7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08BF20551C;
	Thu,  6 Mar 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1n/7bGar"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14852E3369
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250982; cv=none; b=Br/Y6pGUEkLszrGbXy0+EiZFiOgchjPuu0sO7WOHTzhlatJH3xafkV1XflmzrrqZr/miObcKe7N9xoYeHvWxfS27mxsZDNM5NoBdrJdP4r/ifBA3yAnwXgav+Q368BfIRdy/hpdF3mzqgZm4f06SKc+xSzZSzypc/2ThEzYc5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250982; c=relaxed/simple;
	bh=+JMIF5nv1JW6AAUeomgberOu7YOgUGgzWRtym6vZ8jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rggMXV0MpmJCNszF/OW7214eaqxzKTf7+tetAckLZG7SvAPYj29uezmuTvCyi7VUQ7EGZ3J4tOuMz3OhQzYuYjOubPgefq+Poaxw5mxcmw8lQGVMLq6xEDYUuKQwMCgozFfct/dZRXZo1L6nfnNFHiVcTsO8N5guEwSnWa1noCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1n/7bGar; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2234e5347e2so5671155ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 00:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741250980; x=1741855780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOTsx+ET2udwRwOl4LMvTIaV72hOacAVf21e+cPMpSk=;
        b=1n/7bGar67f7nv7s2bsctXJIjPlBnjDFsBuskeuLyasftc+5aQC04T+ga68F+rzSqe
         N8f1pYgF+sbmsy71wPEmpy3ahw8DkhsGIUd2zWV/qnVZ8tDxylG5A3zfNsPRLk6ZR1rD
         VPwkEGUIrCkAQ2cRzg3y17ydHocL265Y+h3c9VbiArQrO+FdZcTYVuw00/Ebw6pAgwqh
         DlRp1Sp05j0b8HoxBjDJF/r1RbXjhb5dbhezIxPsDlMoYNLqx/wMLh/BhGvagQJslwbz
         Ua8bOk2HThV0WtzaodfmaK9pnJAag0UjXxqgpAxmjoZBwVnkjRmFOh5hLuCTfp8vmXDo
         184Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741250980; x=1741855780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOTsx+ET2udwRwOl4LMvTIaV72hOacAVf21e+cPMpSk=;
        b=JJu510BGGPGQer5uwVXhHfV24oPdNtdHJ/eIGpfleisAgoXBwNj6rffErlHdqC9vrC
         3uxsLILPAxDflqw2R7Qr+MfSg8xNkDrJBFR6/k6EdHWzwgzNpKsLR+hid8f2z9AQcE++
         sCYTcBVPPuMhPhH4R+A5BL5oTBMfrsYlByE4EPaScdLOpzSQsISHCFAbtgLWRy1s5lV4
         hAljcHuqfxRMEi+j5Y+9X13IHaZ6e3a+Iidq+kucDyL8mFp/c3lXISdQeN9n5FqOarJA
         Kas+NEO8m9zQeRellSiO6cv0vCGWAByuReUyPNEmWqhC8PwOCegRblXSyuT0whMdTgvC
         tNGg==
X-Forwarded-Encrypted: i=1; AJvYcCWoHGRIzWDXo+D5cDClqT5EU9Wu1hoPYtUsAxuUBeWn5CtzNFyt51DE8BzI4T5g+jHYFercqOZ0kyZkZYsOAtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxciTmmfoRCJ7wQm49uVQhjSYMz87HoukGqbF55rpJDkZxhC6Ia
	IJPdbcd1FJlxxjefARC13bx8YOgYEzYduv5a5Us+C03MxnScgL4LrHdvLdxItEY=
X-Gm-Gg: ASbGncuuF9cspOWah53IYYiRfa4kmnJacG3AhkdEGKCtjxLSTyTc167MIU9FThq5HvB
	htPlVFYOUBFz9Y4A5z/9Mpgc+Mr4MqXyCmJf4OKALhmhz+HdXeFwX3w6fBKg2hWff9/Utt4cwER
	sPj1oI6HKytx69KESvrxa10C5sVD4NdUPABSxTUEzLdecJlg4IPJDYZVu6oKJKmzNCZ214UUEav
	EeX32AnjzIcz/RYECcZGiDd+vqS++lIAftG0xKK60+p6F21xGdi24GWwPVxYIcZilGTzQdGu6VO
	D66bg4ZSEBc3vsrVP7kK8yDVyA0pC0xIocX8OzJA
X-Google-Smtp-Source: AGHT+IH1GEQtPc3doXxTnYpQvOe64EMdhiCow6f81zGlmJXK3+o6BGbwtqTdcVYdbtsYbbFP1fY7vQ==
X-Received: by 2002:a05:6a00:148a:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-73682beac25mr8907211b3a.13.1741250980111;
        Thu, 06 Mar 2025 00:49:40 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:2536:10cf:d064:60bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736982077dfsm799045b3a.35.2025.03.06.00.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:49:39 -0800 (PST)
Date: Thu, 6 Mar 2025 00:49:37 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ignacio Encinas Rubio <ignacio@iencinas.com>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: riscv: fix v_exec_initval_nolibc.c
Message-ID: <Z8lhoTd3BwPWQ0f_@ghost>
References: <20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com>
 <Z8jG1ViOUbw79cEN@ghost>
 <f3bde84d-b53e-4b81-b995-3b81d614b789@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3bde84d-b53e-4b81-b995-3b81d614b789@iencinas.com>

On Thu, Mar 06, 2025 at 07:31:22AM +0100, Ignacio Encinas Rubio wrote:
> 
> 
> On 5/3/25 22:49, Charlie Jenkins wrote:
> > On Wed, Mar 05, 2025 at 05:39:28PM +0100, Ignacio Encinas wrote:
> >> Vector registers are zero initialized by the kernel. Stop accepting
> >> "all ones" as a clean value.
> >>
> >> Note that this was not working as expected given that
> >> 	value == 0xff
> >> can be assumed to be always false by the compiler as value's range is
> >> [-128, 127]. Both GCC (-Wtype-limits) and clang
> >> (-Wtautological-constant-out-of-range-compare) warn about this.
> > 
> > This check was included because the "dirty" value is an implementation
> > detail that I believe is not strongly defined in the ABI. Since linux
> > does always set this value to zero (currently) we can safely remove this
> > check. 
> 
> Thanks for the review. Just after sending the patch I noticed it should
> also remove some code that becomes useless after this change: 
> _prev_value_ and _first_ variables were only needed because two "clean" 
> values were supported.
> 
> I'll send a v2 tomorrow. I'm guessing keeping your "Reviewed-by" and
> "Tested-by" is the appropriate thing to do as the changes are very
> simple. Let me know if that's not the case.
> 
> Thanks again!

Yes, those changes seem small so you can keep the tags :)

- Charlie


