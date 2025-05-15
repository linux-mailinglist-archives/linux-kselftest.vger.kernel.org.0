Return-Path: <linux-kselftest+bounces-33069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6177CAB8207
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 11:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED484163F03
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F328C86D;
	Thu, 15 May 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHOKPIFp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5ED221F2A
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300061; cv=none; b=mjVKSdrI1HI7RYVVHRDHoUC8toRSJaactiwEKfwPn0W3moVYXERJzdP6z7LnTggyklm0QcooqHpu6pINEfuCR7lboY0vLGgLzeKyhoDRFY+oeuZ12u2JhS6mzkDLZzL4WSQ8fidvfUvXdBP9ZehgXRG+37z9K3WcIDGB/eEEzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300061; c=relaxed/simple;
	bh=Ik3I2MkzSjLoPITJGS+Lz0I4027rnhcahKmKU0rhTU4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZAoVkFK5ndK/FJnjWHM64mcaofJcO05L27Uqbug4x6HETT3JR65mTMhas669mBFHD9tsAYSL4nAp2S0dVBfBzrIVDe+UdJSzsWNZ4jBEgLBvtNaX+ib/FetSS9Rg6LdxwDYGinIhD9xCqJ8ACVq2qJ7tMuoswOemqnF7l632Etc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHOKPIFp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747300058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7BWWrJviHxFybRk4KEuN/3UoBAdFc9hHZEf43H00c8=;
	b=BHOKPIFp160VUDqy14VCVqc6dQ3MKEBVjB3DuaqI9gY0yRmFbtdKcJgIIw5HVJqZYPtNkN
	LQqkGXJmLiYQDrWOS6+KTYiHQ9GUh98X/dTT+dgCZLBDqzU915tenAwZoLhlvsJtnfjBfz
	apZvnfVC8vesVeP5CA51dsqwbEX+ZYs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-m_e1h7hkPwujlSM3uPoIOQ-1; Thu, 15 May 2025 05:07:37 -0400
X-MC-Unique: m_e1h7hkPwujlSM3uPoIOQ-1
X-Mimecast-MFC-AGG-ID: m_e1h7hkPwujlSM3uPoIOQ_1747300056
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso6183545e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 02:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747300056; x=1747904856;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7BWWrJviHxFybRk4KEuN/3UoBAdFc9hHZEf43H00c8=;
        b=p4Bro5uOqWuUqsbFMOc6XkTlZrcI/6S1rpmUPJdyx+G+rbDUGK6M6Cz8YupGFOpE+t
         w4FAZbnVhvTBI1ssO83nOsLui3D1N6UxpIX2B9HlKjykPZ75VQKOYSuXU0VgyC9qZlql
         Lg3JbYXckB8vejpkyMKkDWlpf03GpYXQhoFwdIL0j29GtjtNdLAQ6aosOo4157PwWgCg
         JqX43RznQ82DTazjCIeJfzW7kAExriHNkI3ymJz0rnvegLmm7xo7STZIdKlmEmPYHa5K
         33nDSD579eemTZucD+0FWslr3ojWbVhKtcxxS+nznf7rduaQRHQjFSHfDcMOo/yys1N7
         1UuA==
X-Forwarded-Encrypted: i=1; AJvYcCU7/LHPFqz2QUFHLTl/EWsz2v3jjyUkgF2rb3sjFcPTMT6O9bN1lUL9+dzbzx6SuoQfpebfIp+P/vm8OOqvvdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZETK9pVAX8zf4T5ZvINigzJzD5pkvpsgPvLu0TqSZHW8uMQU
	HZIqivkzTBhwugGjwihxlgRADqirNHY3dcibeHWFejBtVWX/R94ZYbjzl584pG87r8fhW09XvR1
	kQNyOmCjZ+zALwo+ELeqS/BPkgNnB/J27Ssf6AcKDLH/0FWEaOWI7Kt2z13DLYZBEiA==
X-Gm-Gg: ASbGncsTT8Bzm1b0LjOjdy5zoHHrA9TZD6cGAV/VnU9N/eMXH5vSExuWQkxqCqXtNcC
	EulXhAWmwuORRjg+X9UMJRFPjn9GnS6F+6n70Htxe1Decffdes/TgBZrhUrJTwZhvbtBCLaiITB
	cLcli2tCSm8fMUyaX1oty+uAGCy36MwYuyIAFBSMMUamus1GMZAp9sflwBe9MA7uvlJg+BP9iG0
	NF2oh/Kc+MUvZ7GLsQxC43+Aywvz5EGqHoI7ezznooywJR0MXVAD3LYu3XO40MSNxEKJ5Fe1p6y
	rxwKVp9rAsgivSH56vAhw4SjkljOGZrG5TLN8T5LHsUYB1OVWfF/CiQi6O8=
X-Received: by 2002:a05:600c:1d1c:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-442f2178679mr67983825e9.31.1747300055723;
        Thu, 15 May 2025 02:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtH0OlsI2VyfWjC+w6cgjXFzubp+EuImwpxVv6AW1/4AjSEgQ642Dr+JGZlhFvcEZbUhcT/Q==
X-Received: by 2002:a05:600c:1d1c:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-442f2178679mr67983265e9.31.1747300055273;
        Thu, 15 May 2025 02:07:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f33690a1sm63048215e9.3.2025.05.15.02.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 02:07:34 -0700 (PDT)
Message-ID: <a72ac9ee-941c-4e3c-ad11-8c629ee2f480@redhat.com>
Date: Thu, 15 May 2025 11:07:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 net-next 1/5] sched: Struct definition and parsing of
 dualpi2 qdisc
From: Paolo Abeni <pabeni@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
 <20250509214801.37306-2-chia-yu.chang@nokia-bell-labs.com>
 <44cd376a-8fee-4d82-a465-a0e80e67135c@redhat.com>
Content-Language: en-US
In-Reply-To: <44cd376a-8fee-4d82-a465-a0e80e67135c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 10:51 AM, Paolo Abeni wrote:
> On 5/9/25 11:47 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>> +struct dualpi2_sched_data {
>> +	struct Qdisc *l_queue;	/* The L4S Low latency queue (L-queue) */
>> +	struct Qdisc *sch;	/* The Classic queue (C-queue) */
>> +
>> +	/* Registered tc filters */
>> +	struct tcf_proto __rcu *tcf_filters;
>> +	struct tcf_block *tcf_block;
>> +
>> +	/* PI2 parameters */
>> +	u64	pi2_target;	/* Target delay in nanoseconds */
>> +	u32	pi2_tupdate;	/* Timer frequency in nanoseconds */
> 
> AFAICS this can be written from user-space, without any upper bound,
> causing an integer overflow after converting the frequency from seconds
> to nsec.

Sorry, I misread the time conversion (is nsec to usec). But with
unbounded TCA_DUALPI2_TUPDATE the overflow can still happen.

/P


