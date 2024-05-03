Return-Path: <linux-kselftest+bounces-9427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA0D8BB44A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C98D1F22110
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DEA158A1B;
	Fri,  3 May 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+2VW4/8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022C158A07
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765409; cv=none; b=IHGGDazBb0VIYlLZ+FTp5igkDFilgSI2j971iCtdml+bshrjT40Ujj39hsA+nOLw9RdD7Xq8D8xceDiLkG57q9G0+wluKSgXHYzxTWPnJ45RekKuYXDXsJJJvCVGL5bcB8AwDpD9xdJDN3QyBN98/TKpUPByEl64hoTmLaKz2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765409; c=relaxed/simple;
	bh=tRo3l+NY6pKlyguTf4ZErUgbx5G9G0vJfh3NkwVHbv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiwTS8FsYWEm9nS5xVTQRc1a1m11A526Yu+FvOKuetsX++JbMTb3sw8KhAKq0ayVqBKHjtlYvaRtUNKWdjKaNmzfRcK7NCqYtEU5onBJITgC02BntfngvCBStDedILdodWj7w/8og4vXjkaF3NLzD1UPGeIiOLQoSAurnij/Ddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L+2VW4/8; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7dec804bd19so132939f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714765407; x=1715370207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CoehBqnXPQ17o2dkVZhBr+IIq52xBLa/0bscC+2UHww=;
        b=L+2VW4/8OZAOrSx0eMkiW0V69snecqC2GOVIpcwZnFkBgdOsXDuQz1diIyA74mhATG
         tPEvYtUpD7c+blT7ZftG9fIE5/lolPotHzijLuVq5VVXtcam0ozxoPItCI1EmRN5BQU3
         VvK/PXTx+vFb5iQme2Wks4CQAVYYBRmw6piKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765407; x=1715370207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CoehBqnXPQ17o2dkVZhBr+IIq52xBLa/0bscC+2UHww=;
        b=epKCYobYre2qO5DA5+dgyRRN/cz/r2ACFPbOzYksnlQs4L5JzGL7DjyZ1UK+h1zO5R
         gjDjpslxbeCPhUb4VU63lkhEqWKfEeQ5EIDYCUMm6OG7K0kXjj/iCS9w/z6FlkoVQbrg
         Wcr4+uoWGKBQ1xSmlQtJhjQQnOmu5l/36FGfrzsRIzURDvWnkFPobera1oCY0thqpbdH
         4exgAEmCiNom4tXP76+Ow69pcNkFgGIvEfzifHIFlYMUhJPH9b/1KoQHDoBtsM1u4nv9
         CNOhPYmv/ZZo+Y7th+6mFx8pHleqrpy/TAMP0SgV8KRe5LcSTK2x38BrhE+7XA00lQ2e
         jlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX40yeMU61cX0wLnKXqIY3g/reopL4ieOBb/LNL0B+9s+GTvgJ/Pq7CyMXlX8AyFraEdTY1MNJcgH9dxASI2Am5FNKV4UBeG21KFzkQX5SF
X-Gm-Message-State: AOJu0YxQmNB27JtNX87TCBXQ+0rze2OS/ag/vh+Rf9x7/EICDdi63lSU
	NouwYlFUlmvq9Mh/+IBMAniiDaUGCtU7S4xShIZV52iUET5CcixGiYVX0KxY/q4=
X-Google-Smtp-Source: AGHT+IG9sDNLiicfk/AlMxI0Uk0RAKTyF0DWx5qbaxCi1rjdOmrTdOLWZifYuj1bIkRUBQrj+qo5HQ==
X-Received: by 2002:a5d:8909:0:b0:7de:b279:fb3e with SMTP id b9-20020a5d8909000000b007deb279fb3emr3636654ion.1.1714765407144;
        Fri, 03 May 2024 12:43:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u9-20020a05663825c900b00487bcf58da9sm943699jat.90.2024.05.03.12.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:43:26 -0700 (PDT)
Message-ID: <a4e28fb2-6dc2-49f5-831f-95c9fc60570b@linuxfoundation.org>
Date: Fri, 3 May 2024 13:43:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftest/tty: Use harness framework in tty
To: Shengyu Li <shengyu.li.evgeny@gmail.com>, shuah@kernel.org,
 msekleta@redhat.com, gregkh@linuxfoundation.org, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430161807.96050-1-shengyu.li.evgeny@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430161807.96050-1-shengyu.li.evgeny@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 10:18, Shengyu Li wrote:
> Similarly, this one is based on automated tools and a very
> small percentage of manual modifications to automatically refactor
> the version that uses kselftest_harness.h, which is logically clearer.
> 
> Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
> ---
> 
> v2: Fixed the last Assert

See feedback on your v1. Same comments apply here.
Explain why this refactor is necessary.

thanks,
-- Shuah

