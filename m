Return-Path: <linux-kselftest+bounces-5122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5185CE59
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062F91C21986
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73271282F7;
	Wed, 21 Feb 2024 02:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de2Uzn9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53692F36;
	Wed, 21 Feb 2024 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483922; cv=none; b=nEGSBE/cbRHCXporb0GKMQR1mUF8MUBt6y2m21Y7OZIGvFv0pFleMjJBx57FSBAQwBnREFZp0es7EJ7mD4zYXLy7hpof19Li98RviiJRtXqkNBGwYRqXQaaKsSbzdYYi9xh6I9QhxlRPLVcLeTQxaiDXbbe+2TsbHYXGscq2J80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483922; c=relaxed/simple;
	bh=M9LyLUnYSF7X179XZ54TkHDA6KFvwvPJ7sm2M1C37Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci5Hg0PYGLSXJZCRqK3+LIH2Nd9z2GreJOawiD5XEWLmrv8S84UDcSpN5Cjafp8nTX7aQ0svs4++IGNemE8yTqb7AI/rS4md5XNQUJqIBCEtgyCLY05w9Z3nn9i1zPOfNToL0whiLMq9YyKiHcwIe5BRDaVckTV9t0griv2Gcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de2Uzn9F; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c02b993a5aso3742293b6e.1;
        Tue, 20 Feb 2024 18:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708483920; x=1709088720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cCcoJFfJlagmSzWB96IS3kVZKplb56dGjkjAGigbOY=;
        b=de2Uzn9FHdeqzhpXGQIx0OrlAcm0/BkFqSN2IEuapIDmov3HtJwFEmmKBGtU+PF/AH
         TC19lYLSMn90B2kzM1mz23Nh85qrcvo4RvxQnSZRhpXzWYj4f1/0iKKkCPprGDhRrMsc
         8a0S4pc2irWdDs9LMGjFlaeOwbfoeZjoP72e7ZMP3gxp6IUNPyh4xben0CsRHQkfQ1fE
         Lc4nY61lpDojgzlpZuogpWLpN9JeExNB9uJa4JWH6kxW/x1bPwyZB5pBp5s9aPqfKnHM
         dmO4E3JL7w1HPg1n3nVqrV8bywMldeHyx5Npcrore3yA4EXiWArmGx0EzYTNmIphXL27
         PUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708483920; x=1709088720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cCcoJFfJlagmSzWB96IS3kVZKplb56dGjkjAGigbOY=;
        b=r69QsT/9Qo4VHL95zFpd5WJlf2Ca7b0gLwMrGloXYH++esvrYW/Acke7kNz/Ch7upl
         OFIAecf13IguC0CnfNXtc/0Nv9oLVCaw2sh56aPg0qHarnyALRfKtYo9oYf+R5BXXX1Q
         qU0Zg9sacoQUG1Hl9fSPOGPZMzmI2ZImLs+cxBGCOAGxTF6oCQ/AASVnISXLZKg5Jq6O
         aLcRzMomYHPHFMIgPimMFAUj9He6FGUjbtD2frtX4MTxQVvhie2nsAMsQTIBXCRfSBfc
         NIKXj4No41tytbuPUL1O3Jx30RxcE6fvitpq2KD776rIAmqnZ8yywD/7cr1Pwt6WOz8I
         76Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUhHRLL2Hz5zkOrfVHgLZ3+uY97Os5iOWnY197HdE8scCu3vwzSo3hgj21bUkTpi+D+LJb5dPGKyNN5RZy/GLElyItJ5cGG6RH1fC3q12/vFK2FC4eSoq7Hy6ztKNoaaDqZz27vQEfum6PYmuCrq6NUNK2tnPwXJHjL8CjMG/fjcoG51YcQFywLXOkCtfM9LSEzbmCrV7S+zOqKNimsf1erfzl3VBRWDAgoGJg2fBwrgycb+CJl5lhnzyQ=
X-Gm-Message-State: AOJu0YzJfch1GoUSniZ6OPHUziANPwfptn1Qm2cF6bxUcenSBSJ+b+tT
	cT82yT4mQu4vnga6Ob80/stXHyBCoETA/WX6l0UV/THoCViS0Tio
X-Google-Smtp-Source: AGHT+IE7orEkJIiIoLoo9uUilOiSIrkDIWd9YJNRBvQsEKS+qFHHzkz+CxBRMkhvQvzm4V/UGCkKOA==
X-Received: by 2002:a05:6808:4498:b0:3c1:4526:7533 with SMTP id eq24-20020a056808449800b003c145267533mr17061192oib.14.1708483919989;
        Tue, 20 Feb 2024 18:51:59 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:b11c])
        by smtp.gmail.com with ESMTPSA id r11-20020a056a00216b00b006e4766d31bcsm2786546pff.184.2024.02.20.18.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:51:59 -0800 (PST)
Date: Tue, 20 Feb 2024 18:51:56 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 03/10] bpf/verifier: allow more maps in
 sleepable bpf programs
Message-ID: <ezfl6x3wxdnjhv7e5hyatneprtqvapbu7xckdejxmcdb6qejaj@5wn67k7rmtxz>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-3-5756b054724d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-hid-bpf-sleepable-v2-3-5756b054724d@kernel.org>

On Wed, Feb 14, 2024 at 06:18:32PM +0100, Benjamin Tissoires wrote:
> These 2 maps types are required for HID-BPF when a user wants to do
> IO with a device from a sleepable tracing point.
> 
> Allowing BPF_MAP_TYPE_QUEUE (and therefore BPF_MAP_TYPE_STACK) allows
> for a BPF program to prepare from an IRQ the list of HID commands to send
> back to the device and then these commands can be retrieved from the
> sleepable trace point.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> ---
> 
> changes in v2:
> - dropped BPF_MAP_TYPE_PROG_ARRAY from the list
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 67da3f7bddb5..cb1266566b69 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18094,6 +18094,8 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>  		case BPF_MAP_TYPE_SK_STORAGE:
>  		case BPF_MAP_TYPE_TASK_STORAGE:
>  		case BPF_MAP_TYPE_CGRP_STORAGE:
> +		case BPF_MAP_TYPE_QUEUE:
> +		case BPF_MAP_TYPE_STACK:
>  			break;

Maybe resend this one and patch 1 without RFC, so we can start landing them?

