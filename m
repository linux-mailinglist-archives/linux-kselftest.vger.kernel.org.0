Return-Path: <linux-kselftest+bounces-42450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA9BBA2DF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 10:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF53C2A53F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 08:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C08F289E07;
	Fri, 26 Sep 2025 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehZazaXU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36121CD1E4
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758873634; cv=none; b=uP1Evk3Ix71D0Y4dpX0J6EIozlpKS1xlghKppi+mu9eUHYUEYvEeeuvP6RdE+sg1oSYVmSH7NnyIg0benMVV5S6a7WLkMXR4+1NZmH0LIB2k05hkzzvGQHOVYIHMs6+ui14lfA97XvyzFOEw8E8RBsLd+QZno3VvrQp1fFFE3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758873634; c=relaxed/simple;
	bh=uKv781t5pHxGX9XHdWBHGON9HVERC0KRbzcEdEyQXDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChF08LTLmN0Vm4KoORc4HwDWXtLZpw/6eTxoYF+QGjgSbDbK8EIVBGfUD0nR31mT+TaYPdcTlIHCtz3CftsqUJpoSB9HEE+UQBOl8v6/X2lGwkWH0qnFN7d5Tih7p9PB1BprAWg4fmx1JxlcT4dr4fCux/6h/qSKTv0GORd/1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehZazaXU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3fbd3d76875so95340f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758873631; x=1759478431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Iu0F1mpJxkFZwruVTis8t8NuagO8uvem8I8R547GH8=;
        b=ehZazaXUgdfxqtOEp3DjAUVmzKXPtmMOGUFz/v9Wx0T6rquzHgEFJ+YSqHmT8ExDSL
         Mu0b62zd0iKycRSDgh+ew3ZQ4tsqcYlG4IoMkyaUNVpSbyAyR7z2ZEQFZ4Us0vzpApnO
         jlo+Zq9azq6fKqpJ1WdiqtezFOawJVJaqU8d8nWPGihIwITmTG4OyMU2FPs84ynMre/J
         J/Ba0y6hHN9hsBnZHAzWUtcIPXrwrMpLz0L1lKcRUVcunNQ4GpOKv1j8FMbVn3VCGdrK
         sSiA144hNBEYukfeFKY0k+TggNXaurZENH/7unCeEwndVXUPPjf5ldiyl82GDLpMRIDF
         l6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758873631; x=1759478431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Iu0F1mpJxkFZwruVTis8t8NuagO8uvem8I8R547GH8=;
        b=KXUfJeb6z9WjD+XjOVE1xOv4WjqLk8M4MvS0i5UfRIBqlDAEHVQA400/a73KNPPRkQ
         I5UXVALQWp+QuQoZF/mKpPM0advEEJiGTo2RSl2MRz0+c4wI+igdO4adG/iIZQAoaaWl
         XMmmNmIsTgCTHyAxAFStFjzPrdwUb5apvNmSF40EllzBgQTw1y0bSlr3yVGXXXwYz6NQ
         esI0wgHNIi/eBLL8ng+7iXjs7hahTsUnK4bpl8yIqrn//2a8Zm9CiOmT/+Hh4zr2Sgvw
         71R/RC1Vwyjjda5rD0p9oSJ77a73Ak+TsiKelVLODEqSYLorMPBH/rJoS6x8i0+JVX5H
         mGBw==
X-Forwarded-Encrypted: i=1; AJvYcCU1lb0eU4ubOZOOrpQaB5DPZE2dLVz6FDnmayi5jyuMZcs8eUgmf/ap08EEvqmTzeoWe4dFV96aCbPd9conJfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrB58rpLaQUUELB3Nk0aqsfa11HceB3f9swiMiaPoQyn09Njkp
	NhyE5Sr2znmvycCU9N2lesI57UOJkaQ2Pr/QH/LFbKkRQ9R3vn2GE69q
X-Gm-Gg: ASbGncvMEjuJy3osKEXqpSZAFXn8LNMrbJ60dWjfdjRNJ5UC32+bktheAr+FfC66WCb
	pAtbWD4jaKiyG/vV8kWx5mVOT3eALxcmWjT58UxggJ742d8lGw0zSthz0NDnpg7kcsZHCZMjOx4
	nYecyi8yOc/Ey3oAMP3YlMSnWX91IimjIGLBgUV6fQnDjJ+ae1hc2vYOPyFKA0isOBU4K25R8Gu
	3Jx7MXfuTbZ87Ev4PsyBXUeCeKoj827aGJln4KnjWcLhldSwMF6xgChaXJjJbnbSywY+nP3M01O
	j/fXsagnTidh7NMqnsZGBKse4QHj+KkDKfCRuN3IOwrA9UyiZTrSWenAS6QuE2VFR2xM9rsFId+
	BRJKqlm+sJngXdJCHIgiByYdDh93pNdoGctTqgSII
X-Google-Smtp-Source: AGHT+IHNpFF3srU1saXcXVO6zTDT4O5u6j9Vyxp4h+sviEeunSEZcOR+GiZEhHwsuD8UAwncJOuzoQ==
X-Received: by 2002:a05:6000:310d:b0:3fc:854:8b84 with SMTP id ffacd0b85a97d-40e455ca678mr3054531f8f.3.1758873630709;
        Fri, 26 Sep 2025 01:00:30 -0700 (PDT)
Received: from [172.16.20.151] ([41.229.125.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1bd14sm6212872f8f.28.2025.09.26.01.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:00:30 -0700 (PDT)
Message-ID: <fcbdfd79-3996-47cb-9d91-ad049147d352@gmail.com>
Date: Fri, 26 Sep 2025 09:00:32 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] selftests/bpf: Prepare to add -Wsign-compare for
 bpf selftests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, daniel@iogearbox.net
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com,
 ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com,
 emil@etsalapatis.com, yatsenko@meta.com, isolodrai@meta.com,
 a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com,
 vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
 <CAEf4Bzaf81OYLTzpN6E4ths_mN2gP29rMYBmbp7P2GqSMj8FbA@mail.gmail.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <CAEf4Bzaf81OYLTzpN6E4ths_mN2gP29rMYBmbp7P2GqSMj8FbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> I see little value in these transformations. Did we catch any real
> issue here? All this type casting and replacement is just churn.
> 
> I certainly don't want such churn in libbpf, and I'd leave BPF
> selftests as is as well. int vs u64 can have subtle and non-obvious
> implications for BPF code generation (for no-alu32 variants
> especially), and I think BPF CI already exposed some of those already.
> 
> I think we can live without -Wsign-compare just fine.
> 

I was convinced by [1] that this needed to be done not just for current 
version of the code but for future code being more robust initially.I 
have already done all the work and I can follow daniel's suggestion for 
the next version.Otherwise,This means then that the TODO comment to add 
that compiler warning in the makefile needs to be removed.

Also I wanted to ask since the CI bot had success with my patch.What 
does this [2] mean exactly.

Thank you for your time reviewing and helping.

Regards,
Mehdi

[1]:https://github.com/kernel-patches/bpf/commit/495d2d8133fd1407519170a5238f455abbd9ec9b
[2]:https://github.com/kernel-patches/bpf/actions/runs/18006172526



