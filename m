Return-Path: <linux-kselftest+bounces-24298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE8A0A562
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 19:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3593A6F67
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7041B5823;
	Sat, 11 Jan 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cF8Pl9uL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE71AB6FF
	for <linux-kselftest@vger.kernel.org>; Sat, 11 Jan 2025 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736621275; cv=none; b=ZluhA2CaWYByiqo5YGTJ6lka7b0wL4HEGi+HBRZ8ItZdRbByykgnkzhDMMx8Pm25WZ5TiIGl0XG+PhVMGewB2BZ9uIuPoT+e90eABEzFfXYncRznaCDaGBgvh+KYJXhr0MjgWZIcSJEaAtBTpz01n1y9krTlMZhEF+ZV4w7dHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736621275; c=relaxed/simple;
	bh=ZWAKyj00T8TijV5rEAQHOMx8MOnLE5MvVnhZKGuLwzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/0P25vJJMoZV1s7JOZxEp3q7DupZDVzmHCbOXIb4Gw2kBu+/jUWQS3iEXuRS3EAeiIxvuSZ17bwU0qCjRkthBIm+drXRln3SyxTMlz75/wter/d7ocv8h4ONISZ9N2p2q7c5+C2Yyi4GeEhsmeHNIrHm2ltm9bQJZabtuuULZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cF8Pl9uL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1576419f8f.0
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Jan 2025 10:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736621271; x=1737226071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ANmr11cRLBqi4SS62Fb0tVKeKCJrg8dPP238NA50z10=;
        b=cF8Pl9uLGLg3OvGdMVmN3h/PAMp5xp99b6VE1yntgfocopCEQPIwPUeJFvqBrFVvPH
         N6h2gzoiJ15ixE/96+lrZ0Dp6qmOX7YCTpoJAn6tNc6/SS+vvhutnm+2deJ6VF3H6Hdy
         mgg0HiTSihhkuBDidWBsqLECZLs6O+s9XyEBZE6HVbGs75vgbQkQyFh4GNq9A+cWSv1A
         0vHhHp6DmSKJpUV1TRecljmZViT6l5ac2DK0E0oN5piOpEDQxrBcyqXiRLUrKNuZgLMz
         mM7AP0EBFI1hAVVj8SG2tJDUrE/fd+pCoy6S4lhI/WPNCthXbdtb1dZQNIC9GOPqQ0Xk
         oEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736621271; x=1737226071;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANmr11cRLBqi4SS62Fb0tVKeKCJrg8dPP238NA50z10=;
        b=CvxeVlsgpRQtcu+EpM/aa+sVrqSjHba+P4DZihgMYnIJpv58shuKKLYVneJ7UbYmPX
         iThF/ozh2wboHbb3QB7HEkcbPp/WWRMZRAnqX42yhJBKc7XK3dfjk4lREwp2eYdRo7xg
         tep5I0k7jFOrxWPWWQqKYeO33OKIfWiZp+E//lns18LeGtIAGDeH8tpM4nXtN2Wj3+Hp
         80aAwo2bRhcwI72BxwWyCeqcuTdKdkwuaEPDw7J11jAQRgPxRBfkh/hWyYFChyev2RED
         e9mNbMNhzH/2YzcmM5AjC7tmUNCUHopaQcXHUMpkAN7HE5Uavvkq7jNPplcaFQILt66k
         PeJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkVNdy/dYf3TKQP55d8qrsqf6HtkWBk2t4l24IbCPti5yZ9KCR4Tm0azKziiwiDbWMdnZeWb+1nCvZKqkQz08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3d8EIG099khPug7y9A40UOpLY6vBzFESc0YbSLx8mCP/ND4a
	2XxsiAwS/c72ZD/DPZQzq1iHswp1mcP0UQyNy7FSfqA8XCUlHInBMeRqqNKTZQ0=
X-Gm-Gg: ASbGncvvF2JC+dmIzfsHZq1EcPGsa8TcVS1eJE0W3WLoH4P1k01e1tQiFCL0P3pl17H
	TFAAc12o5qmbEIbMkGz+ZQO5oL7gv+Fiu07IOgNghEqTt0K21pPtR3wCMrLpPQWHb78aBA6Znrb
	GZEWdvqY4VoOT/xPaFV0a+3njFQLTjPnFLDcbUAnVlPAeCQPlbssCi+OY2xtOjZtaHIRK50B8ZK
	BOqfSGCRHz0gnzbU6LyvRI5QZReBffnRsUreBM2JQapmLIKOF3725M7o6xVYVDfA5Ywm+qZYxPy
	o1UDRwz7f7Zhm0E80mI=
X-Google-Smtp-Source: AGHT+IE096+ozhxD6WgMhTSunNjZzt4wQ/N/cd4TxFbRqTlqF/XMkU+O7aXUkT5CYlua3ex3DsDlQg==
X-Received: by 2002:a05:6000:18a7:b0:385:f220:f798 with SMTP id ffacd0b85a97d-38a872c93eemr11877006f8f.6.1736621271554;
        Sat, 11 Jan 2025 10:47:51 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:9001:bc26:643c:1b67? ([2001:67c:2fbc:1:9001:bc26:643c:1b67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b7ff0sm7899684f8f.77.2025.01.11.10.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 10:47:50 -0800 (PST)
Message-ID: <08b1e117-b6a3-49be-999a-885a8bbfa0f9@openvpn.net>
Date: Sat, 11 Jan 2025 19:48:38 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 25/25] testing/selftests: add test tool and
 scripts for ovpn module
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
 <20250110-b4-ovpn-v17-25-47b2377e5613@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250110-b4-ovpn-v17-25-47b2377e5613@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Jakub,

I just realized that I forgot to fix the nla_get_uint clash triggered on 
Fedora.

However, I'd rather not send a new patchset right away...

Maybe we will be happy with this version and then I will just resend 
this patch alone.

Best Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


