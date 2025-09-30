Return-Path: <linux-kselftest+bounces-42631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD27BACD00
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F173ADD93
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D968C2FB61D;
	Tue, 30 Sep 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="K/PQQRGa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D42FB0BA
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235114; cv=none; b=JcKTQKCfxGqlW65I3safJmeWEl5nMkEJkBeC60WY/vVL+Nex9OG3MaruY3sjj0jwLV9yO5wxexnIkym4M3a0CCc+/Tz/Neh5j5j0u/+Py297RULj3sGdjvh0zfzlX1Td/hok+lsE0iq6FDsiICBky/i0B/bv4DP+JZSwd+UBlV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235114; c=relaxed/simple;
	bh=QKDUayNXOzOOMtKL90Ar8gIilWI2F1XfDcDNm6l/qas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSskGqFgem7dI4b4hPeRAGVkqZfocwvEQgd8YK1I/gVlhaQdgcoK6Q3OILnYak9S69aNtXoHMNpWZ+Vc1qhSIfVxJX4ll0kWgro4ihdameiCw7C7C1CbPwJEgIYTj68OwSNjGjyS0BNH1YfXwm8fQWuShjP0km+gO11NdBn40KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=K/PQQRGa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bcb25so1131926f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1759235110; x=1759839910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p+Vv7moa0Oy84aRbbzj5eC4jA/JL5ZO57KP416IAkbw=;
        b=K/PQQRGag4+Fz0CCDWIN0gsHu4Phwq3263THM+7zdShPQZlkPvWV7a0BZx9i3dG4ea
         i+EjSEFYRMPvVVXKdlFMv46Y9q7NHg/L8vDZKehrt7RNkwzPjrWkybpIKilb9XXVrweW
         b/snmJluQI+i09yaofBWKAZBzfFbr4lz5YFqOrtVbMP9e3AqLKp8mgzbmUDCYQzCM5mI
         5dpQ1dLuvpxWffr/Kq21mv9zZQdiAh631znxwcTp77pyOG3AkYfcrqXheXWLBWwupFvJ
         BMcd/9T4pgb+xcB4ukcCZbpOsSdJUTHtegDkj+Vd5QV+F5tmyq8vjAZyQX7wjISFdJRn
         rg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235110; x=1759839910;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+Vv7moa0Oy84aRbbzj5eC4jA/JL5ZO57KP416IAkbw=;
        b=beSUtZDs0CwcHHdmFG7DwmYJjwwcUIyOyAGjMr8lPAY7/nsnqjqwti4rGFw/nE7hh6
         BqTT0PZBF+GpFxiFiVc3gTBLYDspy7PzLUk6wb/QMVz5CQd9kAFhmD3X9yFaduIj4jfo
         +ClYzXcUhuwIUTxdol3/i2OYNMwPwcIIymApC4a0bunvohZb7/1VinSG4+Uqw75oAW7w
         vmxBDdozyF9J51kbGsV899ctD9VQBOgn45g4nbJzA/fwNsTjmxr5UUv9mWYLJ54mb5eK
         sYsFfFZCinsXZZusqcI/hXq/xkRx8dAn99gR8etJX3Jvcs1xdZ9tii9aj4WCsxL6AllY
         DYzA==
X-Forwarded-Encrypted: i=1; AJvYcCXAVwNEBYxWKCpUmnqBS56nesrZRWrXD5So+Sa3M9ckHTY5sLIox0v/Nm6fqIVolEUz3/QSfMNJ4epqOLVfa4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJudaoxrE55+ACxB2XoQcC7zvFVPih+M5ViDISPnl/vtzrFcjP
	ZmcVFf5q55CFs2zjmwIQZk1u8Kr6NbPIBgNyV20/bS162cdUs2yV4CppjFidkK7fBGd4y4wzHNF
	d1ViXlbChQF0PlAEP6V8V4dkSqecJK1CYvkROKf6bcmBDXoHITIMpbKsEURlxUME=
X-Gm-Gg: ASbGnctpcrEKrlIUmGPkgHl2yBgrGffq7jjdSp/5uWd5YZQnwMrUvuBJFAoEiwrAuY9
	GOkLg4YAUkq7Ofw29gK+IWFS02EbfTyw+XwpjZUNxTgD96lkIGAycq5hPihcfFowIg5xJ/5UUcN
	CW4Dvd4/oWW1op0rwnu7quyZ2UT+N6ZJanjpKWrNRmE2ZudDfjOJR9HCmLHSLnbZLLUPzES1pOd
	YNHsY1t2kZvKbyFLYJePSSJGFZX8HqRpqMSnMxs3mEUJGBBppRY6U6bblYcxxkwnTY+srop8KgP
	c3SLgHy0ocGiKjBrdptLCqUCXtVNouL95jtxjwAr73BmJ8ukKhgjNKntfPFJrrjlD/iHjgPM6PJ
	IZqgXUTUDm4sqHSbmy2xD/34+reuAhNlnRejP4WLw/chNo0hl+WE4FULpCZewvcxwPC+zkOvAVj
	pjqIrdDwA=
X-Google-Smtp-Source: AGHT+IFoY6TKItJNzGEEwi7h0krjRzVGjyFsy0vk44BWxFxzF1vlg+Lc++e5Dw5n9ZwKS/ZZqoDXyQ==
X-Received: by 2002:a05:6000:2385:b0:405:8ef9:ee6e with SMTP id ffacd0b85a97d-40e4a8f9b38mr19809866f8f.25.1759235110064;
        Tue, 30 Sep 2025 05:25:10 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8f94:27ec:8b3:19cd? ([2001:67c:2fbc:1:8f94:27ec:8b3:19cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72facf9sm23164461f8f.13.2025.09.30.05.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 05:25:09 -0700 (PDT)
Message-ID: <9de2bdf7-b246-40e1-ba56-37a6a1e49826@openvpn.net>
Date: Tue, 30 Sep 2025 14:25:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] selftest:net: Fix uninit return values
To: Sidharth Seela <sidharthseela@gmail.com>, sd@queasysnail.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 david.hunter.linux@gmail.com
References: <20250930120028.390405-1-sidharthseela@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250930120028.390405-1-sidharthseela@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 30/09/2025 14:00, Sidharth Seela wrote:
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> ovpn module")
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

Acked-by: Antonio Quartulli <antonio@openvpn.net>

Jakub, if it's fine with you, you can pull this one directly in your tree.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


