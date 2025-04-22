Return-Path: <linux-kselftest+bounces-31286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48202A96577
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360BF16C75E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEE6212B18;
	Tue, 22 Apr 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgTjI+I2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FD202F79;
	Tue, 22 Apr 2025 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316520; cv=none; b=VvTMPgawnVTGyi0Xu/ipUzQ1C29d5jpV/JkdCBSLawsdrOSQXuC0OQxL1qG4iSFiJaDsINhETFQJl7newnR7YGkJnatHEgExudu+RjEaPXtbGSGTpMMPA9xKrCzbyu6z/rh4OyUBIsxtRGjDTzwLoVVkAkehdlGk9VUpWPqSRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316520; c=relaxed/simple;
	bh=cmE8YOSD3nfPKU0R/K5fUCUrCwHtSNRvccoHPupB8EY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq5tNB1JOqsk+LUuyab3g6JHGTuJtLeqQdG6nCLznK3mnjFfohUQuKRtY986XOMvbln/WhxlS2ZTO/BqimMSEL8LlWaPH0zYwdpfMj0P/LJM4BMeJAimcOVzmVa9r3MY39QvgfMgTsOESJ/m9xxbheFzzAZQ1COxBnglLbe9xVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgTjI+I2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so849782366b.2;
        Tue, 22 Apr 2025 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745316516; x=1745921316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02mF3Rq0/qOkVGAo4rt0MUzwR2m/OHZu+4wbFsIWOQg=;
        b=JgTjI+I2c5CQ/HeRE58HjqBUZE+UIf8XeEYybuI22o6Q709E7c8SKPNTeCh4p6DGB6
         yzc1KaObj5t/5SGC5V1qhtd0iIUY03xe/LBIQCriXHj31b0vbNg9oKguJS8QTlQ40nGT
         8IOBoK0r4+jHHl091CaeVcFizyzEqwVEoZvP4RTBr/Rdp97tRXGZxONG6UA+kZ9HBE5E
         qZGazvZ4M002KSs5n9QEN6LDZ0PixRmTfs7nO5dQI20dqCZdgJnK/6BSAr9S/ToqN++9
         Op9uuBDPkNE+dDfgUzxXCNAANm67Eg1GNvbPf2l9pozAHVozzCpESptilEgzrJKs1rnd
         XlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316516; x=1745921316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02mF3Rq0/qOkVGAo4rt0MUzwR2m/OHZu+4wbFsIWOQg=;
        b=sTl1TmH4ikaRQqc9SFIKUw96ukp4FijtyOUGg9MKnGA8F+zhQqaa674WsowndCW0yX
         A4UBUzGEDr9W9ZX8TPjTX3fQ6i3WF0XrJZ2TWfKYngCObSovhOO9RB89cxFV0/HVFPtv
         PfUZaFQehbtAwRVsnJAalJyk8IJJ5skHbqDevtKxqBA84aCjG5Q/kAQFZZ0BF8Ji3pwt
         0aVmaJ6rlsdE6AsFa/zLt6iwnjt45mnN6p0TJyUetrlm00qAX/yKPWbxrZfDuPVVbskF
         nDUWI76VLrKO0UD4/dQDEZzY8fAcDP47iuYoBnU8MOPIAx6SeIUoo87aQci8CyzAsoNO
         vOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX04DPxssDrqmTvD4ks1FS/A/FBKcwTl8+G2Py45fGOvccA/tfocZHzXy1fVLVmdbJA0uw=@vger.kernel.org, AJvYcCXEsNqSsKnh5gSPOLZz7KA8QXSW02uS+5daL4GmI2op5P5ADOkLBLKLTMzHAXG7ZBSQIfLQT/wKG6XF56jC1SO+@vger.kernel.org, AJvYcCXdnK/GGv5QoCoZ0BOyw4syANCWya1jGpdgwrlxOBFvueEtAT3dWViRUkBcUXTi8fBUr07+a7YAAzelaatl@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhPQgmSR1+qv92teTbIFhhUXv6K2v0kvzzeR8t/lmKxXGlSlt
	70u4LAwDWh9SRiaEMHoZExnCRVHjpIWtF5xgO3ipLAeg2I0xD1hw
X-Gm-Gg: ASbGncsCCaZttHSVD00KHPftx3CviAfnFWuF0xBixAuXgDNpfByJQOqUdyjGG0qXC0L
	Pg7ZZRba9p0opV/nHnxcRMqJKL3JWmCusM1voFWy1B/BKHUfrj91OJghnwdCbFJDkIW+Z2xRmec
	OL/qqGftrt2FrBw5CTLstlSVbIcnruMvzfOb9FDhgtGpN8a9WjGeQ+X7gkQTNui7/tBhxOZADue
	T1TOgnpHU3zEvbFDn5bEuLVJluABILXWySZf6W8gmNHSLUYS67TTOi6/3uA+RmuKQebQejt0jjF
	9kkyhu/Q2oYPqd5ZTb2EqgPIlHk0fXwTyMF6qESDbRg7T4cu16pm37G2Dg==
X-Google-Smtp-Source: AGHT+IFnCAYlkq3Gsut6BPvsW7FS9GPw2LCxU0ujmgViSKToqZ4BWTh8QSqWECU7TAzy9pEgX1rIiQ==
X-Received: by 2002:a17:906:c113:b0:ac4:2ae:c970 with SMTP id a640c23a62f3a-acb74b38723mr1444597166b.21.1745316516183;
        Tue, 22 Apr 2025 03:08:36 -0700 (PDT)
Received: from krava (85-193-35-57.rib.o2.cz. [85.193.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc685sm644632266b.96.2025.04.22.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:08:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 22 Apr 2025 12:08:34 +0200
To: KaFai Wan <mannkafai@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, mykolal@fb.com,
	shuah@kernel.org, memxor@gmail.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kafai.wan@hotmail.com, leon.hwang@linux.dev
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Allow access to const void pointer
 arguments in tracing programs
Message-ID: <aAdqorjuW68ld6ps@krava>
References: <20250417151548.1276279-1-kafai.wan@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417151548.1276279-1-kafai.wan@hotmail.com>

On Thu, Apr 17, 2025 at 11:15:46PM +0800, KaFai Wan wrote:
> If we try to access argument which is pointer to const void, it's an 
> UNKNOWN type, verifier will fail to load.
> 
> Use is_void_or_int_ptr to check if type is void or int pointer. 
> Add a selftest to check it.
> 
> ---
> KaFai Wan (2):
>   bpf: Allow access to const void pointer arguments in tracing programs
>   selftests/bpf: Add test to access const void pointer argument in
>     tracing program
> 
>  kernel/bpf/btf.c                                    | 13 +++----------
>  net/bpf/test_run.c                                  |  8 +++++++-
>  .../selftests/bpf/progs/verifier_btf_ctx_access.c   | 12 ++++++++++++
>  3 files changed, 22 insertions(+), 11 deletions(-)
> 
> Changelog:
> v2->v3: Addressed comments from jirka
> - remove duplicate checks for void pointer
> Details in here:
> https://lore.kernel.org/bpf/20250416161756.1079178-1-kafai.wan@hotmail.com/

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
> v1->v2: Addressed comments from jirka
> - use btf_type_is_void to check if type is void
> - merge is_void_ptr and is_int_ptr to is_void_or_int_ptr
> - fix selftests
> Details in here:
> https://lore.kernel.org/all/20250412170626.3638516-1-kafai.wan@hotmail.com/
> 
> -- 
> 2.43.0
> 

