Return-Path: <linux-kselftest+bounces-33017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAC1AB7CA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 06:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E5F4A75BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 04:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B883F1E47AE;
	Thu, 15 May 2025 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlMZXyCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0ECAD5A;
	Thu, 15 May 2025 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747283364; cv=none; b=W0Sho3Rc5YAqnhQx0mWIiaWY/xRqAT2+oyZVPAfxw21/F4+iQY/AGR3Dux3luFa1miqcaGPDyqGQ9UibI3AySxDHeoopF9uvnIc+bsKoMGZr67IXcvgNC/Z9H/ReOznDR2AUEBKLp3ApBPR2abqS1XOauEHErsZHFD2uRq5lCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747283364; c=relaxed/simple;
	bh=ceq7jlTz1iE0/8gu82QlO29MWem6Atpyjs0RbfCyABk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh2shPgZWWvtq1tOPXgcLqN9dIL5V/yrG9ZVsyx3rkps0mPcyXK+hSnkYgxRs/XeIixRbHu+26ZyKsQ4gw1oBDxpJIzTvXNNODvg0O4IYO79Z+hFjPQ7Fb5h8H3nKDIzcO4MzUClCM0xRx407y1kruRhqg3ySTdhf3hhMCrBKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlMZXyCA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74251cb4a05so774632b3a.3;
        Wed, 14 May 2025 21:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747283362; x=1747888162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDiy6mzhvRS9/Kl5lMX4FwOIAngsCq5rK6D7CwSI/3I=;
        b=XlMZXyCAQVnlsioNtoMB54HzrO1aoZJHpWyfoUrRn4OKk2MGzTv0zFPaNZ+L8aDFUU
         vWEYHYC9UfYJ6MJkgn7x9mjMpT9pm87OKsg94YINk+y2+q0HHYX0z5Am1UgkaP/u0BQe
         +mRphB9ocQ0flW5cK4n35ShlXQQ1QNbSTFc9PmyOIS2HDnSOwI62pAUWP5hxRno8Iw7a
         DLuNqMGxMqo5tF8jvKFQc0NznMRfzeAz9mdxmOhQuPrbzPNz6gPDa6KFgmwM0HNb0krV
         zJ+cqzSKgnGTz3tJeFnPTSo884FDHB/gCHx+4fMiaCR7fFv0bYJRscnBUUf/BkReDvhw
         lZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747283362; x=1747888162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDiy6mzhvRS9/Kl5lMX4FwOIAngsCq5rK6D7CwSI/3I=;
        b=jIR5MzqVLsYWFpK/oghSZ7SQmGx90N2Byux/dPpaOc6/L+cZc2z5UgtLqauK/cpVaf
         wRJnc/2sc6xuuP/7oT39YmwLk+BvrlKxkvZmS3HtQT0zCpyu4rl8Nj9/7k/sM54902yi
         9cutZSG/5RVK5fWo8QeQNUd2piuEZ9X/ACEMylp68zJ7h1FCT6+0ahkk8aF1XCVoo+hU
         8li70XktEvBIrqJTvNv/VhgHOuOTC9XyrYCjbn08znq2M2mld4bmjuhhW0N3Bgp6fF1j
         euSVENl5xCOddIcstLJ7bDhUrpiVlLJkIgOyaR24UgKuvUt3Ngg56w6Ivvuq7DwVRkD9
         wFHw==
X-Forwarded-Encrypted: i=1; AJvYcCUrgA2c9ZzrqfHcNI98Or3gCCZI1bZ8AXa1dA2mA1nOjqvX0matH+Fz4CmEUESSz3cs/s0=@vger.kernel.org, AJvYcCVJkrCAlJkE2rZzsDPtsACqyiTd9IP3zgISDKpRdNsbQn7qjqzkXljQnZQsGuk5YFbqkBtHE8Jn272+EdhXeZrV@vger.kernel.org, AJvYcCVoBIltaqxD5ut1w+0e0I1wx+C1ti6iJ+23CDw8Vyv3DM53UOjUYLFdYUPpJxOqiwVKQiE2tIJP9QBgwQnE@vger.kernel.org
X-Gm-Message-State: AOJu0YxGj9uugidM3gYGzl9JTfXRB2HRGEEcWj4Zs2HHfwAtMiVOSB/a
	frHmQT3rZ/cNBR1VY/ILVT32OJqV756JYsW/0isp6Pbgjnc7oLf/
X-Gm-Gg: ASbGncuVOswBcONCGyRtfh255bTvs0Q4pXqmJVcdSnQ/DLZGTWe4kP7FM/oJytSOVCR
	sLFpMQFHoFbumxnal+nyNtzTATyDDqCDyI5GgRN2oo1SehCg8cBtDtcZjx0OJX2CJj+VS0eFQjb
	FX2nxnfPIKEQwUJKAD9ELVcQmmYMMSGLN1C7deMB5Mw5tzwOvG4UzUWFY0e/x/lZ8hMsmbnumzH
	2TMTeg9KpqPFmAmR9Cj2IqeciVZv+t0CVh8Rgf5llEqBksJjP/+vnoQaRWUYH5L/++IahAOVfhP
	1vqTMluVZOV5avxZK1kNiILDI8aGDse9Sggs4BmLw3ZJKRxqnxQQ
X-Google-Smtp-Source: AGHT+IFvsU3d1q3ICDAz5uhCDRqh14w4phvjuXR/5CPIpKl7kKDPs8vwD+ASThZr6dmR6yUAR88hLw==
X-Received: by 2002:a05:6a20:b40a:b0:1ee:d8c8:4b7f with SMTP id adf61e73a8af0-215ff11a54bmr9417369637.25.1747283362295;
        Wed, 14 May 2025 21:29:22 -0700 (PDT)
Received: from gmail.com ([98.97.45.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423773962asm10638472b3a.68.2025.05.14.21.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 21:29:21 -0700 (PDT)
Date: Wed, 14 May 2025 21:29:16 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <mrpre@163.com>
Subject: Re: [PATCH bpf-next v3 4/8] selftests/bpf: Introduce verdict
 programs for sockmap_redir
Message-ID: <20250515042900.5dox2mozx455tekm@gmail.com>
References: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
 <20250515-selftests-sockmap-redir-v3-4-a1ea723f7e7e@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515-selftests-sockmap-redir-v3-4-a1ea723f7e7e@rbox.co>

On 2025-05-15 00:15:27, Michal Luczaj wrote:
> Instead of piggybacking on test_sockmap_listen, introduce
> test_sockmap_redir especially for sockmap redirection tests.
> 
> Suggested-by: Jiayuan Chen <mrpre@163.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

LGTM, this is a net new patch in v3 though correct? In the future
only carry the Acks into patches that are from the previous version
and not substantially changed.

All the same thanks for doing this. For this patch.

Acked-by: John Fastabend <john.fastabend@gmail.com>

