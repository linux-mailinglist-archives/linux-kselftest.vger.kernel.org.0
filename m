Return-Path: <linux-kselftest+bounces-47737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B685CD0C3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 17:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714783095A90
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7A35E525;
	Fri, 19 Dec 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbPajm/x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3635CBDC
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159513; cv=none; b=sPe8L845QdWO1D8tY3Qc56AxWmDSEeSgYpbEauWSHYjYk83G+uahkLnFkdeXihL54sG19BAlQNj8doeNO22mXueT8mV2AI+mvPaI49jN2aMQOe0B/FT6eXTLmqSHT+pxgtueKOIm5tUdVIg/B+/rV+px+PvfzFaRkMrBwl+J/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159513; c=relaxed/simple;
	bh=H1DGvNKavVFSaMlR7k6trOQD4lVqVB0vpDde4vwQGHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7stGYsEcFgxksw5FwxvqUdaMSuH/Rii937kHaDK+pLrkgi9kZJrUOXcdyinyzQ84CqbeBnD/OsNBFtV1+P5FUfFMxKkoRzL+sWd1hwePLoZHthDCUXphoNezcryLcPeL4ccH89FZjl1tKb2bcc+QfyXSbCeedszwpJ4Nk2DO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbPajm/x; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c730af8d69so1342041a34.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 07:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766159510; x=1766764310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7rvgR3BHjJsiVCaqAbiFlB2IFLuSzLeMku7n757ahs=;
        b=VbPajm/xVh4kIHDYmd+8iOFdIQa8Waa0LbTnOWUE4zGi4rbnm9GCNNkG1JpW0SKk4R
         bM9tB7a8J90MMdMIhOi8H7MVNDh0BjhU0huOXgwtwUedOef6AJTgfR7gshTkAU68l6M+
         KjyUBlX3C+rNdz4vJPZOLepdnNz08eCowkcvPDDWRYslvURq0zYqzm9sjHRSCZzGVDIY
         gRMfdqXqulL+jnnHNHKPvmleW097zOHAlFrC8oclMq9HlR0GFJzbLioBQCk7nYLcNGIM
         oHtpsiAwwN6groRO+oCbDU2Y+MowxWTvgR6kc/uk0vcdIMoOOtXC83kverekvf6zqB/k
         6cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159510; x=1766764310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7rvgR3BHjJsiVCaqAbiFlB2IFLuSzLeMku7n757ahs=;
        b=bgzEltoG3m/C4JROU/MyvAqFcRygr0Nc12lm98iXsgJCzv+/O7xwMgp2OG7KDmIFVK
         4YbceHaqqcPJ5ERvFDhdr9VIRLTDyIV/biWJhORVcelWWreAM34reyRJpqgRNUgeN/4s
         +sPCbMuTZ/OrTOvhUuC6/+hwdJlpDDNXc5PQPAIPhVO6drkkZNQl019h+bhLKaN+vRb8
         JZ/Xy0rhFbOjS4Salykh2+ENhcw3TGU6st2luOjXnFDYav5diGnqjzWPilufOWO2WIkx
         ld9sAn2wGfeqhYhx3oVDI14IQRZuoChQGZeudhL+yPeukRtMCvaftJo+/ygUKOduYzh6
         F6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0jfZ4ImBOYoQJu3VX8UmDDLG4PB3jXtHedgsiS9+FakDW0ZxDGotb3PEjNvfp5rlVeYTkdq4GbaTi1KL7tzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoZDEk7LI6YlrASIoQSYYM/1XsuUsw5tj0Y/iZjVq6GNYiKXy
	2v/1QSIwfHBMs1VMethmVwxsJDnk4FzTH6vXIMXAui9Zjdkpvs4rsB7c
X-Gm-Gg: AY/fxX4VaRDhQvGitL0XEbOcc9cELU2EdOjYRMXZbKRyVOxsSiiolrKA8sEXu8aenBX
	UZlqM+NKMAr0h980oZcsY6/fOslx47ru83AGk6wb5sJEqNkExjXcRlcmdSbd7tarCXcVlgKDhhD
	AtZ1Ffs9lZ5asorefTz23X+UXpVwAe8+DJSxGaFq9pB5FptXO1FFUoI688w1OD4ob9cddoUpK8E
	y2oGG8ZAcWN6B8/i4hS1vY3zn/nhhwNqLFjCiaJTZjXJ1Kk0e+Zf1OFZ+K5atubdc/H1iWyGre8
	5C6wmy2be/eUBO0vxjYAlKnoNK4vJhBbK5Wrl+0XoBc3nKr4hfzyfw71iVF438DWrnuMYrmOYHn
	smhYU3tVz7l8/NqPS8dmUntjnWXBgOo/8MYSdZeDzKwbqy9PL3Qx4raaCFHaAUOFby3Cg2Ky8pk
	QswfkVnMS71ND2yCDBAmvQRKL6/xJo7IbRJxvibVvfme7leVes/aTzc5PoVLI12z0en36rDyHtR
	BQ=
X-Google-Smtp-Source: AGHT+IGxFY3tfqqGfgJVdwGc/vPdanLzBV40RdPc8BmZ6UNg9XtCVHM9Rf4nvTrlnrW+kkmbF9rlpQ==
X-Received: by 2002:a05:6830:2e05:b0:79c:f9ff:43e with SMTP id 46e09a7af769-7cc66adcd8bmr1753958a34.28.1766159510450;
        Fri, 19 Dec 2025 07:51:50 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:29f4:6cbb:646:9589? ([2601:282:1e02:1040:29f4:6cbb:646:9589])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7cc66645494sm1936347a34.0.2025.12.19.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 07:51:50 -0800 (PST)
Message-ID: <9c979662-cdd9-4733-911d-b1071b7c2912@gmail.com>
Date: Fri, 19 Dec 2025 08:51:48 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: fib-onlink-tests: Set high metric for
 default IPv6 route
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
 <9a3f7b60-37e3-470e-b9f7-8cda5ddccb59@suse.de>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <9a3f7b60-37e3-470e-b9f7-8cda5ddccb59@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 7:51 AM, Fernando Fernandez Mancera wrote:
> It would probably require some work on the test but I think it could
> benefit from using two different network namespaces. Currently it is
> using PEER_NS and the default. I think avoiding the default one is
> beneficial for everyone as it ensures the state is clean and that the
> test won't interrupt the system connectivity.
> 
> Other tests already do that, e.g some tests in fib_tests.sh use ns1 and
> ns2 namespaces.
> 
> What do you all think?

agreed.


