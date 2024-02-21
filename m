Return-Path: <linux-kselftest+bounces-5121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2768A85CE4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F5A1F22A03
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D19C282EE;
	Wed, 21 Feb 2024 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbOUNgYO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DE46A4;
	Wed, 21 Feb 2024 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483791; cv=none; b=Gf3AQ8qDu/tDtF8jp4HDlDeWmnzdTFU5tv5+/ixdxajL+Gi0oFpOR+KthSUq+yBo2bt/qmM9JTSoTawK9yF+MvK4X0QO8AA+9XY1nZgrsG7uCSZcyBhZaRNRNibhkDLaI8o4BsfF8qU+ef+wXKpp6rHQZF9lyheSVmlYmOGCwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483791; c=relaxed/simple;
	bh=0YzZT7AtbEwGuMMGVGesQNVHt+oEog5zyqr5o4Zt9Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBIlea5RbTFbYYLs9zXWTrBFl4IXk1DBJChp1CjXG2/RzJ2NUSA+pP7LAWRwLx6jSQaWKjVR+eCVFvPNw5vpJKSWg++5pmrAQGVVdkcGqEZUUWrUBQmLkw5nnYb2tKE5BuD6QKOKA3ogK3BFY/7tl72XSEy+MfYkt65FRROHL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbOUNgYO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d932f6ccfaso50963765ad.1;
        Tue, 20 Feb 2024 18:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708483789; x=1709088589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pAyzYBVOxuKmn5DITDD4392qCfsQwduisHaKiAl1r0=;
        b=kbOUNgYO4FYVFsIlbbIwiCACHrAKvq67lO7iZMFehwKzmw063yVUk55XH/tbIrih1Y
         sDWqMvGMzFj1j90DBcTPWFI1oibrwBrFsW+vq2unHn+lX6SRh9tbn1DGvn0lD0P++73m
         wZeszZsy41PKqCyEvDJTDGGfvCRJE6bUE0+IL7eybs/WO4EJNP4S0dZyr0tLvuD/z1u/
         m5lvmKwzgnlATE58nKLgXqbmdRjOQ8T4P77F3ujyUL5tGRAi1ElfVWzM10NtrpeJH2mn
         4H6O4Q2lPgwKHvLrL0vopNpZjwNDc3PkVuSIIEXUQ8r40eLCTZCpc1slA373LzQuHABS
         LMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708483789; x=1709088589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pAyzYBVOxuKmn5DITDD4392qCfsQwduisHaKiAl1r0=;
        b=ehFmfz7uG5roagIClQ1iZwj0Vk69+I0BkTpT/aY+yantu+flqXpL5uxoM4tQJoIlpv
         nE2uLC95M+e6wyRQ192WUfrTK4lZEFkpBMYAeUzXxb2DF0YVCQZrZTkcf1GkgRWqK2FH
         rXK1ENDsNI/QcDaOGahx+XmmzGomFNbtjzNa6ojP/iU1ZVhdweM9VpAdAGSbPGwrNoC6
         IGRAulL7xYWeXR4Tjgfaf/QNacoloajHT3V/M0M3FVreWAEa8zrY88kVrTwhPJAjYanG
         zSF+fBaVB2XBAzTcybUOMmrmHlxK+ZU2qbS4JUIhHAOpXuoB5f9iaP6U+1jZv508TeYV
         9XOA==
X-Forwarded-Encrypted: i=1; AJvYcCXqJ5UYVeFqC3hi8i1yAmSThuP5DlB+RnhR2nfL6dWAVvzoD7Wqvzkn+t9vBMOoc9uRzzrphlxe86EY81U7cDXLzuQvYMg6M6ofsSq2l9cUKBis1OaddOt4ez5OZcxR1DnUVYP20l2T4D35ipgSwKDemuyCivl4vArMpiZK2zyTo3INegKc7CVsA8B7vHs7om2aatfPDY7pSjtEknWH2wzr/crMH+7gFoD3uh5YGeMs5O/cseGNU7yrlsE=
X-Gm-Message-State: AOJu0Yzl1PLxuqR+EvmELKqZnBDg+jMK85/uagNheWLznWxx203QuO+V
	k544I/HUNhtxAjCQyEIFBpCH6lwvxf9Al3zqzbjp3uNs3nW5WGRw
X-Google-Smtp-Source: AGHT+IGpD6WpkCgaR7lYoHcPIeliL0+6EyMXy2eFgCQmG/Odbul0rh0nTvlpvUfl9z5wmC4riV6UVw==
X-Received: by 2002:a17:902:6847:b0:1db:9fef:b996 with SMTP id f7-20020a170902684700b001db9fefb996mr13328524pln.33.1708483789202;
        Tue, 20 Feb 2024 18:49:49 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:b11c])
        by smtp.gmail.com with ESMTPSA id kq13-20020a170903284d00b001db5c8202a4sm7005042plb.59.2024.02.20.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:49:48 -0800 (PST)
Date: Tue, 20 Feb 2024 18:49:44 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
Message-ID: <rgjy2bzsugnm7eyye25sx4b4os3lenfpzncdy5x4jog7qqkycb@6z4ybeniikvc>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
 <a72147f5-2b7d-4267-9881-6a645c575838@linux.dev>
 <r3yhu4h23tdg2dqj7eq3lhevsigvvb3qkge3icxmaqpgkayvoi@gxfxstkr2pxl>
 <87eddccx1q.fsf@toke.dk>
 <fckhc367l6eha2gpftixhzjdsmo2jts5p6ir6ukx2q5xndsbhf@btzjwvuamcv4>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fckhc367l6eha2gpftixhzjdsmo2jts5p6ir6ukx2q5xndsbhf@btzjwvuamcv4>

On Fri, Feb 16, 2024 at 03:58:20PM +0100, Benjamin Tissoires wrote:
> 
> So (and this also answers your second email today) I'm thinking at:
> - have multiple flags to control the timer (with dedicated timer_cb
>   kernel functions):
>   - BPF_F_TIMER_HRTIMER (default)
>   - BPF_F_TIMER_WORKER (no timer, just workqueue)

These two make sense, but

>   - BPF_F_TIMER_DELAYED_WORKER (hrtimer + workqueue, or actual
>     delayed_work, but that's re-implementing stuffs)

This one doesn't.
Unlike hrtimer the workqueue is non deterministic.
Requesting a callback after a specific delay only to be randomized
by the workqueue is a confusing UX to give to bpf progs.
If bpf author really want to do something like that they can implement
such anti-feature manually with two bpf_timers.

Later we'll add a selector for WQ. At that time we'd need to decide
whether to use a dedicated kthread or any of system_*_wq or WQ_BH.
For now I'd only expose 'sleepable' as a guarantee in bpf api.
Hence BPF_F_TIMER_SLEEPABLE is the only extra bit in flags for bpf_timer_start().
Not sure whether it's needed in bpf_timer_init() too.

