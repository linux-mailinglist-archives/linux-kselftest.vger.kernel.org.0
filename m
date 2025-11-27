Return-Path: <linux-kselftest+bounces-46660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5153C8F44F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5F5F4E1C9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688793358AE;
	Thu, 27 Nov 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly4TkZEH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4o19SF0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E027602C
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257400; cv=none; b=VRSQWxhIlQzhKsnnMOIGy0VvVMz7Pp3uknPWj+hXor5p6S4g0ZNTkYFz8KZdFFkiFHJfnqP5d00ldt5EjRJZJj24zIyedx0VFnDwvl/UIzhOW+XWPeYkCxq9w6TuXDhdO6+jkyG7hXv6T3avqh5cOMyHkee8oYnZ44mF9ZAw4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257400; c=relaxed/simple;
	bh=Q+yvDDwFY1D+geMCQr2vNJ4z+lz0BHU2Zk7Ni0x8J78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bpz3QYs2LnOAMpxzoY+/gyHe49aMWzS/V9tDCld70GhllkqMAxpBF3I3Yq7d2W2mQMod1owRXA3Rl/FkCniEq8zBSqMsoVMfPn+XAy0zKEybO2yozh7mZyhRZsR3JKkWUCodWb9+7T5IO6Z1+5/TjgWu4dxEB3yOZOgBrXMGslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ly4TkZEH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4o19SF0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764257397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qr2PgG7xe5f+wEkqXvKcY1v2BMi6s2PMaZnRkPGnt8=;
	b=Ly4TkZEH3fUH3XWr2uQqSPtfpq9jafAFTtLUuq0HHpMAw7ZyWejgHn3fXqxwJDr9GR/BuO
	dgoYKCXzJaybH7V/6RC3llL2ypKK9m0MR5yYNswlBlgIp27Oh0JWjher8QS41Xf5GAwjXD
	03QkwaUQtSXoqg27nQcjn5/lqLD6wvE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-5EYtIOmVOeuOYvAlZcT-6g-1; Thu, 27 Nov 2025 10:29:51 -0500
X-MC-Unique: 5EYtIOmVOeuOYvAlZcT-6g-1
X-Mimecast-MFC-AGG-ID: 5EYtIOmVOeuOYvAlZcT-6g_1764257390
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47799717212so7761085e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764257390; x=1764862190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qr2PgG7xe5f+wEkqXvKcY1v2BMi6s2PMaZnRkPGnt8=;
        b=c4o19SF0FnABCVYBe29uQ3meY7YPWYOFSjLTSAPaw87Kn6BPRf1T2Qw+/lYYb1K10j
         mFxpxqv1DQleHr3baCVrM1Vg1nY/JcBF4A0rfvZbDaO8FW2yD6GcM8LiMs9ZPFUQSXp/
         PJhKmCoGnhD2JWFzF+P8xm0kHYkeAv+aa0kIp/Q2IjNjDrzF8mlOAtmWJQwz13BM+xXZ
         JZYo5zd1HanHB39Q8LMFxP9S+FyPrDi+hNVFzVzW131bj7Sqtpn6R3hnnPsu+QWwfr2P
         ADHJ+XC4eKuC66Ncw+D0Bf59lm2FF8dYEsYwGERD5uFiMBTisVR/GyOQmDRkyEAKAWpD
         G63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257390; x=1764862190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qr2PgG7xe5f+wEkqXvKcY1v2BMi6s2PMaZnRkPGnt8=;
        b=jXyP/Mgx0e5Eq9B1890CpKTBZpgEkcUFzIBw4xoI72SpU21lT4w+Ux74HLio0AGS3h
         8wVID+oTPQND0nLMDBXM3QjJhwNr0LtDWkQejANguZLxGqw3uHpTC+/9sf9HV+adL75c
         yp7xJpK4xfKdOlIeuh0djpBjYVkqpbxyZEJBZxy5ral7Y4r1f1iue+ULg99YvtyfMmLk
         MP7iX4dhNcOX0USkLbGU3MicLyXDNzwC0brPH8cV8R/f0JmJrQqYYJKxhLlLhA3+oF5x
         N0LfJSZSrINmCISZoCcUORbjVp8+SjUL50bN4BUHcbzzir1wBogqLtElelSYwUjBm8kZ
         a/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvVCkXat36Ernax/waJSzzYeVYS/XPNElKOmWZ+Cb49vlkE9102P/mXejFymwJfBRU79RhYFh3aEkn1NHFuTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2gxMGx2Fob1vRoTAuFpVm1vNgwziG5nqWlqoPZokt4dMh9FB3
	WLL9E1LTx1pzAXu4t3b6l0itDaMBii0N/levL8mGo0szlzIY4Aa6HVIfjCbExKo81b3K2HDqhRw
	HQlE48q1mzf57qvHQsdro1WPfo0QgbRkFuph6GiG1VCYLP209H3KdkcrhbrqiQDg9B7Q7PQ==
X-Gm-Gg: ASbGncu/j4bpkX55bgmNtA8cYb2V1PQ2ObL3eFJ9bqhn1E1xj5gjbhbwonhkWbcY8m4
	wU0jcK6aSZecWbaoKaKbrLTuC7LYsaZPT3nO3Jyt5HmoAsNflo9T/h8p/xJGW6QiEvLUJQeEKCi
	dFwbBLHHoeRJPhSt11yLpnfg2fZSsKN2z1AHuIMZZTTOxFlBh1UpyO/euMl/p5AxEtoKr9s6+sa
	H5q5VfuOvyfyemaC1aIQa3sEDNgnbdH99tj0PLW1UUbJBxQvJI8fSHdXcte2KVBrlghDHp3xtOu
	xjFF3uqMONWPH2JtQy/QDhjgS4LS9KgUW7uI1aSjeEwj6HZSu5I+o1CUe1aElqKfVfO+kAumYBW
	4qQO4iHk6WIAFxw==
X-Received: by 2002:a05:600c:19d4:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-477c112635amr208634575e9.27.1764257390209;
        Thu, 27 Nov 2025 07:29:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6EjJopCbjI/4LJUJi5H8NRT2Y1f3vZt8QNHKaMLuh5wJZtyqrpT4xy5o+MTv2JVA9T3EZvA==
X-Received: by 2002:a05:600c:19d4:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-477c112635amr208634365e9.27.1764257389834;
        Thu, 27 Nov 2025 07:29:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052def4bsm67904185e9.13.2025.11.27.07.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:29:49 -0800 (PST)
Message-ID: <7f7238d8-bf0d-43f3-8474-7798e8b18090@redhat.com>
Date: Thu, 27 Nov 2025 16:29:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] bonding: restructure ad_churn_machine
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
 <20251124043310.34073-3-liuhangbin@gmail.com>
 <75349e9f-3851-48de-9f7e-757f65d67f56@redhat.com> <aShbAp7RZo8sfq2C@fedora>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aShbAp7RZo8sfq2C@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 3:06 PM, Hangbin Liu wrote:
> On Thu, Nov 27, 2025 at 11:36:43AM +0100, Paolo Abeni wrote:
>> On 11/24/25 5:33 AM, Hangbin Liu wrote:
>>>  static void ad_churn_machine(struct port *port)
>>>  {
>>> -	if (port->sm_vars & AD_PORT_CHURNED) {
>>> +	bool partner_synced = port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION;
>>> +	bool actor_synced = port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION;
>>> +	bool partner_churned = port->sm_vars & AD_PORT_PARTNER_CHURN;
>>> +	bool actor_churned = port->sm_vars & AD_PORT_ACTOR_CHURN;
>>> +
>>> +	/* ---- 1. begin or port not enabled ---- */
>>> +	if ((port->sm_vars & AD_PORT_BEGIN) || !port->is_enabled) {
>>>  		port->sm_vars &= ~AD_PORT_CHURNED;
>>> +
>>>  		port->sm_churn_actor_state = AD_CHURN_MONITOR;
>>>  		port->sm_churn_partner_state = AD_CHURN_MONITOR;
>>> +
>>>  		port->sm_churn_actor_timer_counter =
>>>  			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
>>>  		port->sm_churn_partner_timer_counter =
>>> -			 __ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
>>> +			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
>>> +
>>
>> Please avoid white-space changes only, or if you are going to target
>> net-next, move them to a pre-req patch.
> 
> OK, what's pre-req patch?

I mean: a separate patch, earlier in the series, to keep cosmetic and
functional changes separated and more easily reviewable.
>>> +		if (actor_synced) {
>>> +			port->sm_vars &= ~AD_PORT_ACTOR_CHURN;
>>>  			port->sm_churn_actor_state = AD_NO_CHURN;
>>> -		} else {
>>> -			port->churn_actor_count++;
>>> -			port->sm_churn_actor_state = AD_CHURN;
>>> +			actor_churned = false;
>>>  		}
>>
>> I think this part is not described by the state diagram above?!?
> 
> This part is about path (3), port in monitor or churn, and actor is in sync.
> Then move to state no_churn.
> 
> Do you mean port->sm_vars &= ~AD_PORT_ACTOR_CHURN is not described?
> Hmm, maybe we don't need this after re-organise.

I mean the state change in the else part, I can't map them in the state
machine diagram.

>>>  	}
>>> +
>>> +	/* ---- 4. NO_CHURN + !sync -> MONITOR ---- */
>>> +	if (port->sm_churn_actor_state == AD_NO_CHURN && !actor_churned && !actor_synced) {
>>> +		port->sm_churn_actor_state = AD_CHURN_MONITOR;
>>> +		port->sm_churn_actor_timer_counter =
>>> +			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
>>
>> Should this clear sm_vars & AD_PORT_ACTOR_CHURN, too?
> 
> Yes, or we can just remove AD_PORT_ACTOR_CHURN as I said above.
Generally speaking less state sounds simpler and better.

/P


