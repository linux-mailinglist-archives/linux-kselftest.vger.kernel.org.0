Return-Path: <linux-kselftest+bounces-18754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E798C01B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B9A1F2874F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E781C8FAD;
	Tue,  1 Oct 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a0Dx75vm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356781C7B77
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793165; cv=none; b=r+tEuHBmier/HgSMiZ3byxi5y9VCJp3UUD+oyme6mYUhn7S416ZYE0dL4dJ/DIuzxONR/J32bgBTY4i//thI4eg7q4GieM1aq27XGvpSfb5o4oEauwV0eGOWhFNuUcb7HhX927zW7MyU7sMFJ/RN7eRuYxYLGcoLricgj9oHyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793165; c=relaxed/simple;
	bh=bKphyDqbxcvDNK7DjQOMo9DUHjHZKlSov/DO3JrfSGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLFbA3ErgMw2mzv9I0eKnYXcaVQm7Ry9tXKJJmSdKASGIZ+9spLOiSE1zRWrVg+h5Ggfc1J6G/xo7y+1TM1WOX1AlQVKA6dHGwLX4Ziz17+XQjaHhmeBIl/RJdYJwtLpsS0GAlxwj58zECQgyL0t1/CGYJA42YpPLVN9CCKvo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a0Dx75vm; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a363706905so1816005ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727793162; x=1728397962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2BJnWqxMgIze3a83gE1HsmHtrQjsXDn4er45PmFRhs=;
        b=a0Dx75vmbajfK4g+PZnT8/aZnwsZSZVTv0TePIs/BUSnAEju2Zm/XgyBIVRDS18QXR
         HD6eBnFQ90JsNe2czn9aiv9nzy1ziN7B/+Gxqf0fGm5mQbgNnFTOOOjLm8bgFeihGd/B
         bI6mp75FI5qiTTUGtKybDT1BLtZ60Jash98vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793162; x=1728397962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2BJnWqxMgIze3a83gE1HsmHtrQjsXDn4er45PmFRhs=;
        b=dzwFYppLaGk9oQcXsL8vdDfGJB5BLCohPaouugq13PZHnKr9sDOqZ8xzBJ6asWzXFQ
         9Qw4yPRb4HmKQeP/kLC8EjAEPmG1Rrnse5bQgMGnh20cdtW/sD5/iTs7WbXDnw983H0w
         WSBnGDkH2XKATY1pfoU9drPm7Y5pLZCEeUjNbJlfd8Nvm/m27ySi7dEk8Uy4VNZRj7R0
         Fu2nK3V3kaxtB93gTl7H1STy336c2zugyYFQSa1J5uEjcSvnHOiP6PTptT1Bt9si5Cne
         jn7O//vx7kHcp3GHKB98EdoHFwtBbotERFRi55EldwqvYfCvp9ar32Q/pzUyOxPeHcBs
         gTHA==
X-Forwarded-Encrypted: i=1; AJvYcCWX9rzLg9uCF1S49Hj9RL/36k6y+4vFkpII2pmfB0IuHQRo0mT2JyZwJ8SZY3yXLGf+AGeHuOg8DoAzBagbf20=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1jMjbfqz8IVY44LP0p7Z33L1qksGVvsY+N1N/nYm939kH8pU
	4jNEysy7n35XAoHpZ6dfp7WvhUr5ySTopsH8X32vXJkRhP50a35/qkfQ5LJ1SUw=
X-Google-Smtp-Source: AGHT+IG5KxeWzZ0tIRhRP55c4RHb4MyLlhZoobx2pOGK8YlSWMLYQk3lGnj8/yUA+1FWfNBFrrhbEw==
X-Received: by 2002:a05:6e02:12ee:b0:3a0:9244:1916 with SMTP id e9e14a558f8ab-3a3451794a8mr154794535ab.11.1727793162322;
        Tue, 01 Oct 2024 07:32:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d8371dsm30670115ab.21.2024.10.01.07.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:32:41 -0700 (PDT)
Message-ID: <ccee6dd8-7bac-495a-8e76-481cebf88e3b@linuxfoundation.org>
Date: Tue, 1 Oct 2024 08:32:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: align getrandom states to cache line
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kselftest@vger.kernel.org
Cc: Florian Weimer <fweimer@redhat.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240929025620.2056732-1-Jason@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240929025620.2056732-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/24 20:55, Jason A. Donenfeld wrote:
> This prevents false sharing, which makes a large difference on machines
> with several NUMA nodes, such as on a dual socket Intel(R) Xeon(R) Gold
> 6338 CPU @ 2.00GHz, where the "bench-multi" test goes from 2.7s down to
> 1.9s. While this is just test code, it also forms the basis of how folks
> will wind up implementing this in libraries, so we should implement this
> simple cache alignment improvement here.
> 
> Suggested-by: Florian Weimer <fweimer@redhat.com>
> Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---

Thank you. Applied linux-kselftest fixes for next rc.

thanks,
-- Shuah


