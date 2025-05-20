Return-Path: <linux-kselftest+bounces-33404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662ACABD9A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2553AEABF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB0E242D6C;
	Tue, 20 May 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhEoCF+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D47242D8E
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748270; cv=none; b=ZlFSC/i9ey1iS/byjfd4Ty3MhxsKD3PZOx5gOjImVMMbNHJP5kJ7VLu8AUneZ2nXPcPsQtnN2sqLd/dqXeWkSD8fMiGd850geM49hyoNIqdIsnSsQdjSJzKUE34qPSBAJUkBVZdH7YpqJS3xBwAG7Pw1fNcDQXbeZGqjMMLN2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748270; c=relaxed/simple;
	bh=U5YZUOHnFba3YEEPRb4B8MFish1XcE6mlQd58Sc0Ulo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nccZEjDIGIzX2Z3nk4yAAKisLmzPLRXQCVo+LnYd4SeNqW/RiydOPYpFKWZ2/fhMtjhSLXlnn4IugrMbdVoZ0bkjTkB963mlyvt0wD2atZWZGeOJsxYqJnQEQtOSk4Dh3BVCskiM0IzRwgZhuTs9L0KWD40bs/VFt2tYhpk+ciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhEoCF+c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747748267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMsyQ7VNnN2qO1o186LSTMN+Ccv8Zs0ud4b/iPJ/c0Y=;
	b=OhEoCF+cAg/8Eet7xs0aA56Uu3s1M1zyZ6erI4kH2gsKxCmCALRRw8Qw0aO9dfMoLu3gP/
	kXhZPhqRPiCC+ia5uf/urq4SRDIYSOklEqjab1xY4I9lV85efszJlIKRg5D0q3nec7z2qc
	X4JAk1K7vss/6fJFlhenBSS+cGJB32I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-WkSz7QIxO1Gm3U0yeUU_Xw-1; Tue, 20 May 2025 09:37:46 -0400
X-MC-Unique: WkSz7QIxO1Gm3U0yeUU_Xw-1
X-Mimecast-MFC-AGG-ID: WkSz7QIxO1Gm3U0yeUU_Xw_1747748264
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so37674135e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 06:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747748264; x=1748353064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMsyQ7VNnN2qO1o186LSTMN+Ccv8Zs0ud4b/iPJ/c0Y=;
        b=KLIpb9s6IA9on0EIw4KdD1ZzqOl98uzrkAf86EGsKbj+Dl3zM5jR4Tb9QdsixKdJto
         inXMtJcX+mMfBd/2GbOMkv1Wwz6HZt432HDt3W7hNX8c57433MzsOHBka4iTs2AgEHEH
         jtcjOUkEYcUAOUGEzviirCep93zfoY8NpisatXeQjWvFrf84ZKFuA3eWl4ddDjLb1D4U
         amsnYASAigMWgbdjA3fIvn+qjxqejCJsuX4wnYtfULOFxVuukJisukOLiDuP4QZ3dgNK
         wZxq932Yhhsv6H2ff7KoBWCF/KurhjjZASxu5TG0fOf/eFlO4ggNq5l+2sdXVWQJzi7B
         4Oow==
X-Forwarded-Encrypted: i=1; AJvYcCWAjWX6j//WAJASR+BND8NVHV9eSxkghFwwFZbIcH0vuuIjp5FxhQ2fUgG6215MLaCvWQ6+sE/jA9upsUCIoXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrm1XUMMtt/PyKFG8A435Epa4G22+RDEBXrKpi2TZE0yAPPUz
	/R66pGrgBnUafLPWu13H7Us1S555/+ClExanLkV6OD5ZGezcd9Sdm0Hd7tf0j5oCZyZ3F5Ld/vH
	jFqeN6dAIwFrubjQDn9ChPur26ePv5JQ9HQQ+hOiveNM9uoNpay0gx5OOXdJXQo6kyst+ww==
X-Gm-Gg: ASbGncu7Q1oWyi14tJGhscd9xabAcuk1gVzIAo7T0DTfCFkracJ1lSnEWcsTpIerRRF
	MLUQAt0Mv+hpiMDhp4KxcmXf1ZUc05lRn1wX5bMAEsytJQq0QepxOYHMbqZ1U+0mYTj++dWrYuQ
	KG+Y0Ll0mxsQzalUgtJtAoQwRhEl6DUvecM3lV/XTn5bDdCXaMi9vfmN9rd0fUmnm8vJgPwrx8d
	hh2ajCSSAlHouVJW1yAVQV11Mvs6NGj3WgqBF7B6xZTYM00zRbMLQEpj1RVQM+3zbJBr+f0R0bp
	4FiVYEUYOy3ATRNEGb8=
X-Received: by 2002:a5d:5f8d:0:b0:3a0:8492:e493 with SMTP id ffacd0b85a97d-3a35c834f91mr16986012f8f.6.1747748264380;
        Tue, 20 May 2025 06:37:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2IgQR6pfl4f9JZX+mTcQQJIcZJQqSQkpv9zrll3ynmvnMB9+rl/8mcTBCpK5VIAeoxVyW1Q==
X-Received: by 2002:a5d:5f8d:0:b0:3a0:8492:e493 with SMTP id ffacd0b85a97d-3a35c834f91mr16985962f8f.6.1747748264000;
        Tue, 20 May 2025 06:37:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f23bfdd9sm31041385e9.18.2025.05.20.06.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 06:37:43 -0700 (PDT)
Message-ID: <c9465324-b2df-4507-8d17-7cdda55a60f0@redhat.com>
Date: Tue, 20 May 2025 15:37:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 09/15] tcp: accecn: AccECN option
To: Eric Dumazet <edumazet@google.com>, chia-yu.chang@nokia-bell-labs.com
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-10-chia-yu.chang@nokia-bell-labs.com>
 <ba1b1b36-cd7f-4b36-9cee-7444c219b4f5@redhat.com>
 <CANn89iLkyC-MfGUTvcV=zr+LYKzMsyv1im1Oft6EAXYb2x0jGw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLkyC-MfGUTvcV=zr+LYKzMsyv1im1Oft6EAXYb2x0jGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/20/25 12:32 PM, Eric Dumazet wrote:
> On Tue, May 20, 2025 at 2:31 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
>>> group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
>>> group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
>>> group size of tcp_sock_write_rx is increased from 96 to 112.
>>
>> Note that I'm still concerned by the relevant increase of the cacheline
>> groups size. My fear is that this change could defeat some/most of the
>> benefist from the cacheline reorg for all tcp users.
>>
>> Some additional feedback from Eric and/or Neal more than welcome!
> 
> I have been trapped lately with production issues, sorry for the delay.
> 
> I am still working on an idpf bug, hopefully done today.
> 
> Then, I am OOO tomorrow, and can have a look at the whole series on Thursday.

Thanks Eric!

@Chia-Yu: please consider the above timeline before posting a new
revision. i.e. it would be likely wise to wait for the additional review.

/P


