Return-Path: <linux-kselftest+bounces-13403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D192C3B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 21:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E3F281CA6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F9180053;
	Tue,  9 Jul 2024 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NlB/DIDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FB1DFCF
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552083; cv=none; b=aImYJ03CxOETMNnlQJE6i7hQKKRDNXCcX6TjGn/dSw7FE+F1gYuDK/neSd3UlhtHPch1KD1218r0idPPv2DEY0G+bg/FEpDKwaA+c9q0E4ryZD08+b6S9gBH+Rzph5WWBMP9yz2e3ECaCXkGY6+1uQADRXUk2vrtlMgEJPRjrDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552083; c=relaxed/simple;
	bh=rei3Y/rflO0sJmcsABr6+fL4nBcc3PsxXOHV5anzNqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePNFng9xmlKmZPGRnkEC+C1DqsXGBGFPeDPIBcc4KGQsrfaxGe06a8FXg4J2KXke0eHA9zdfU1UcAWcmddo+4hI+EASnBPiK+hcuEnk82z+NRwSv9lEkZfinTYkcikb3mg5cKkVLYWI3yf9oQAgbFY43APAHgy9D1EIcXF4wnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NlB/DIDI; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f7e24bac14so11401339f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720552081; x=1721156881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsWYO+mO6pfybl6hF359Rm3V5NZHRQbanLk3Net/gWY=;
        b=NlB/DIDIm6sGiYm4PchAK2PMdQADJpdXywtztRhH2UG3O+pK+gqylMrg08kCaO37xZ
         GD86n0gt/2SRcascFJOIYaKm5tQSDZy+j0GAbYLbJpAqC5yTu9FnAfN1bKYWI/humPfX
         q6NAcQCus6d1/C+ICDqKTWcnjg6TQussa0YYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720552081; x=1721156881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsWYO+mO6pfybl6hF359Rm3V5NZHRQbanLk3Net/gWY=;
        b=tFFIpg1qrtMZhVHz9ViIHv33Uih2F+KwB/Xdjh11J94mbxgGge4aUiQN1rd6+lC3gB
         rGHCuf9aC+CXpjdzMQvAZdab7fb97RzNzUGpnrR5NltCewC2Z6yuLx/2tnz31io6Uj0w
         6w4Rt6T+CjekvXoS4q93sM7dJ3n9Mc0R9qJ6ocf9+FJ4jDvV1TTeyubOpgLyj4mTbFpf
         XxZQRYbJEBb5rw6olV3ZaiNSS8u3vJjFRhPyYvDBIy2yYBp8qZ/4+thCpllecCjlulDC
         PFHf8bXUTvADygIGeUG/uTjOHsYDvh6Ph3LjTAhWyIjw2nnzMOXIm8rCfKGgNxxGylwt
         iAzA==
X-Forwarded-Encrypted: i=1; AJvYcCWbT+kHhPWO5VzK3lr2bxL7g2YVy0LwcFcWYYWLOLwmr4RmEKgO9PLUonZvmx51+tWSln0EJzpsLiDfd7k4XoNgXArgucepXBnzgA1seIho
X-Gm-Message-State: AOJu0YxwZcAAaaQxaxhvQP/ysb5CMM53UBGE9FHhe8rVhkSylQEWEp3q
	6YrXwD3H3VfAI9ablqv6CJQiNm8ivlbD4poMFcCzkVKc+xpfWs21qU9Cr90luNQ=
X-Google-Smtp-Source: AGHT+IFjWd0i1e1pvCH0fJ8NRj1l2jwsPnsIwaAX38VUhDk9gD1dgXXMmZOlDTIebBSbKJo4kQ3swA==
X-Received: by 2002:a05:6602:42d3:b0:7f9:89a2:b846 with SMTP id ca18e2360f4ac-80002696c0fmr312703539f.2.1720552080855;
        Tue, 09 Jul 2024 12:08:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1b0d3d5sm637695173.42.2024.07.09.12.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 12:08:00 -0700 (PDT)
Message-ID: <73fa271d-c607-4880-b796-7d6be31d9085@linuxfoundation.org>
Date: Tue, 9 Jul 2024 13:07:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] selftests/breakpoints:Add return value in main function
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: angquan21@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240709095109.3813-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240709095109.3813-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 03:51, Zhu Jun wrote:
> Main function return value is int type, so add return
> value in the end
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Please add information on how this problem was found. If you used a
tool, include which tool and warning from the tool.

thanks,
-- Shuah

