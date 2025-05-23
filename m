Return-Path: <linux-kselftest+bounces-33661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82583AC2836
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 19:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F5C1626D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA1429713D;
	Fri, 23 May 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFMIKfcA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB551FBE83
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020128; cv=none; b=aELaDrEi5ezTcu4mLFFoPp2WPZC/TOcdZCRdqpGXLpFQzD8yveoEn0aBgKu1VAsaty/fmr1JpiggXu0IU88gxtewDqTwEA/fwW87ZtkznDssh30Gyw8vTpuBhLsUrEvlFiVlFXB+do3BiDiqobU08Cq2uooQ39Zpuz7TUq9d+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020128; c=relaxed/simple;
	bh=Hm1tGMAS3PPNtzjnDWEzbfiLzrUg9XiJUBFCgHFXZlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeoJCz7HU8tClGMMtXxWCrY+hx3X/PTZtMg9dDCelxfgFJ12l/llCjzelHGYM8ISBklzO81/0bBO/GHiiFPkAi/qV9rSr02WWah6H8ru6Wq83iuTrGfWUHnBmG05XG7P2l5dwJDF41EeT9I8S2rMIWOQToCdEiLnwURQxKUihRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFMIKfcA; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86142446f3fso1790339f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748020125; x=1748624925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TvQKIUZyT1ZR4WNc1oK4VLVb2hGuyqlHiwN2Sazzkw=;
        b=GFMIKfcAtapF0yGMUYd46j6G0spuRjxwZ7F2djpLu1yQBg9eqKe2+Tgqxxyp8yug8b
         EJjCJD+64yw90BwB4v37mYqq9V1CABNu8mLJqAQxCo1tBaGY7IhxsHIyM9UdtdsBO4ux
         UScthVZqB5a3UE/KFDRrPpCVbj1Scxbkb99H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020125; x=1748624925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TvQKIUZyT1ZR4WNc1oK4VLVb2hGuyqlHiwN2Sazzkw=;
        b=shwCr+/wyJ/ieGttYKah9elfMnj0uA+oDWugWhpWSi89YGOOfvLXnrxyayZzltxfLe
         gFHpxYySobV8iJq5ZRSfVJMrovaZV9YpclrUiZmjRRZ1g2iiIWWWKQloy/OS/Iia5EEX
         EdmIN4DPpcWmLjWao3siyJ+H0nzvdGKML/NdiEafN+Kc1XlM2BDt6+SP6o5BlQkj8kNM
         iDq55Y9KwE9kSHAxwkxuLVlekkFHvrDsvwKG5oEzA4k0R3y4ihNmtLiudYDfr8S+FVSW
         sDYIp2LFqxu8Z3WxXokg9cAFo1/VYwBTaghs44OQiTdoyTvnFvR2zY6D12Cef8qS+wfe
         Kblg==
X-Forwarded-Encrypted: i=1; AJvYcCXXzFT6HNvuQoVwXDWQkzKYERK+mak4Aomsyqr3RuKnixB/4sNwB/hFuudlLZ1lhpHci1HFo/w2RUaxrFaLhb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8Ydm4ilMUWhWZaV0rp/KYpO069DgKK+3URHGaPvJntI2yb2+
	Q4+bGYJmyHuDxHm3hV3p3B9U8J6JKRFAKzMzfTeFHEXjog5e0Q80gIDixDf+0TRKsUI=
X-Gm-Gg: ASbGncvJhBL/MT3dQiT0lxAVhhho4L8mqLCTv06t0xJrrXex1sUAKcvkdpq1KXCf+hS
	IvY85lHs5ifntSg4Nd7G5iAeJ9h8jAwR1GLo/ujluK7iPDJLsHZPywy2AL9I4nMIE8+g998L5a7
	B03vAl+FrkMcP2B0ju5o8OmaDanfECIRqyGOlKMYqeuNUbs+cCKhXeGH/Mn9RBi9tijak7O4I0K
	17pneyUGdD48SjRbH1arB3UfCoy2BXJ4p5qiLyBsJEyVgBd9rws1K2eLAlHPNRluJfrqcE7L4Qi
	p7Gy8tl/c+3WCB+SCURhzxZQf/Fr2yEqLJwc6O6IcrIhKg83Zdvx5dUC+nsW3A==
X-Google-Smtp-Source: AGHT+IEuuWNkmw7BtT7vHxd95eHS8JLmv0pSVeN5jtMEWq95lJvQpjD3ML+X+PoouGtHv08OC8gqSA==
X-Received: by 2002:a05:6602:379b:b0:85b:4ad1:70e with SMTP id ca18e2360f4ac-86cbb8706c1mr22358239f.6.1748020124313;
        Fri, 23 May 2025 10:08:44 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a5b2sm3702964173.9.2025.05.23.10.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:08:43 -0700 (PDT)
Message-ID: <d86594f5-c6d0-4692-b1ec-41d76f947b7e@linuxfoundation.org>
Date: Fri, 23 May 2025 11:08:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: timers: valid-adjtimex: fix coding style
 issues
To: Rujra Bhatt <braker.noob.kernel@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <aC_yu6Ll2E-3qRHj@brak3r-Ubuntu>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aC_yu6Ll2E-3qRHj@brak3r-Ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/25 21:59, Rujra Bhatt wrote:
> 
> This patch corrects minor coding style issues to comply with the Linux kernel coding style:
> 
> - Align closing parentheses to match opening ones in printf statements.
> - Break long lines to keep them within the 100-column limit.
> 
> These changes address warnings reported by checkpatch.pl and do not
> affect functionality.
> 
> changes in v2 :
> - Resubmitted the patch with a properly formatted commit message,
> following patch submission guidelines, as suggested by Shuah Khan.
> 
> Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>

Sorry - I didn't realize these are all coding style related
printf - I am no longer concerned about the length of print
statements.

It is too much churn with little benefit.

thanks,
-- Shuah

