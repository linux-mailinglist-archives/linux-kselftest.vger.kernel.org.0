Return-Path: <linux-kselftest+bounces-40903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD1B478AD
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 04:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FD93C7F37
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 02:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17958187346;
	Sun,  7 Sep 2025 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu53tzYX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC34A06;
	Sun,  7 Sep 2025 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757211084; cv=none; b=kvT7VHYd9ypuvWtV78fAhWqK7M4EPcoUJQq0kn0rNN+uzfXhUUPCNqhNZ1wOG3ArnfzAiyn4WDcDzcALeWuIVO0zzDhMZK23hbRcY7tuNohNkkF9aDpaMGs9nu7aCUTOyJCfe0YFdVdG9hXsqwPMsdjVwekXhuQIDpi5p4Cg6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757211084; c=relaxed/simple;
	bh=OZCpA0chSjxv3Lgd+uW/ts5asDVyp+uuQl0W9GpliIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2CAZk0aGnBK6KClZOOEJ/b1aotsaSC2juLkU7VRDxtYZnHj/cWeSE7sFKPbOM0o5shVry/st9/bKH5uiKLKBCkoWGWmQR947ICoh6fvoZ/CYLPT93TTiXIcsT+R68JWX8eeqG1KoWZ3cwk9iuQr1Frp2Zu8Eju389n62wkk34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu53tzYX; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-88762f20125so257554839f.0;
        Sat, 06 Sep 2025 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757211080; x=1757815880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kLVhBsN9dhNrlhLxW+XbovzQ/BZ8ochPm1sfsjRFYg=;
        b=Uu53tzYXYjFZWPlASaFuLavLv/1vqrxgCtJuUtcTXWiwU8x0CubXsxxyEeAmHCumf1
         YuBm88DCbyBwkdoILKKSG4UYhd18ZyuQc3uKCloGSY3dW6UWJdiLk4IaV+TmPY9FPG/6
         UH1LaAgn1W9QlKNbx3zhIloIvmzt2691eJNW+pZ9lJTYTtY4zrPcDUJs/jM1RTWGIvXC
         9ujdi0MmTzeOW37XJdg7Z2q+w8VdabMoJyH45+VllwU9x3JFBSXr2TT4MsX8mNlBJvun
         eqO5JUIuIC6Eg0MBV0zaKiVSzePMb6jMYDssxVqnrPjX2JQTYe+1OYJgs2VDWMQKOtJU
         0lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757211080; x=1757815880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kLVhBsN9dhNrlhLxW+XbovzQ/BZ8ochPm1sfsjRFYg=;
        b=O/++AwVo+6UP1Lvyhruu6BU8YmHFi19mJxZ9sNIoYMzzue7FeXxvWo2WKzj1rZpACa
         Q09Ao0jDLCz/sAXuw+mhVlmKl1i7Mws2PBlm8kvWDUpYCpkGaLw+CGKIpsi3NX05wxv4
         radHg3vsvfa1NP1otr3ErqdPZ3ISN6zWW05WJ3MZpX+H74kZUS4ZgUU28ljuvGKgkHkc
         +SP9wbkEJ/ds3nZAs+SjmRSm1qu0eXAvm1gIYPaZLH4/Z00kPdS3baPCdl+z4CQCppKJ
         coZ8tTMapozQpnVYFSMGG9qapjWZemOWhVXQHrWL7SPU7CRbkBSRwI4jI0cOO2cx+LTQ
         CxsA==
X-Forwarded-Encrypted: i=1; AJvYcCXRsCf8fhuXFN+VQ0YCo0Lk9HDRBeOBlpIfZ+NhhWXSUwxJXQjtjUFJdssfaE1zIY4arTPtgXutIUKUx4HW7eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnXkopRW48+dKh/8iFoV2CX4mIzw1TxvyyoFLOJJwKYHNYBSL
	rKlAGgbYwTk3m66b+7mmqVM07C6yyj4pfmNm00607Iwmy5Q215nAichD
X-Gm-Gg: ASbGncvHrhiqT4/JwC37jd/vVwfhagQ1Hg+8Jm9JMauAZ4tr5p5H0GrItfkqo7e2WjH
	2FCt6QW1lcgxJjw2/cM6wx970ZGD8oR7Iij2f779AZS0g9/JzVBOkqp8d/+UDNpMbGtkU7v0mhB
	22wxnR4oM+Gla+Dtli+di5AeCTydNOuNhM0/NVgYw9lg08PgM9GdixdyBxMF9jgdrrg2aLayo59
	xVIGbVokoHgF6DexHVJR9HUDMw6QaSw5rSNyhFG2eah0VRrVrkS7H2GaWOTS2CY10zYA2iBNT7P
	GwVJ24MFnKTuIobV3iQB6c1zwKntdjYcJgfj8M37yM7RkAbTjewBkuwkGBjxXl9DMOMZ+D6Z3hm
	6GzZYAT7Xyy37cZIzdYtBqsrTLLuYUe0H+XtYcgOo+wie0Gbr7rAsrtn2KxXqW5ee+X5i4EBy4e
	9gPUUDxGaV/YxZe7pwQw4=
X-Google-Smtp-Source: AGHT+IGfR179kG7864B43/0SNBFqoAPFytz/8tsks0C7teojneHa6P+vs74igS0RB7CarHog7x4GxA==
X-Received: by 2002:a05:6602:6d11:b0:883:ee95:7266 with SMTP id ca18e2360f4ac-8877768cf57mr557808739f.9.1757211080482;
        Sat, 06 Sep 2025 19:11:20 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:8951:1fac:8f57:51bb? ([2601:282:1e02:1040:8951:1fac:8f57:51bb])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-8872a4f8e38sm646686239f.27.2025.09.06.19.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 19:11:20 -0700 (PDT)
Message-ID: <842ad1ae-6e82-4ffc-8338-da0b1401ea25@gmail.com>
Date: Sat, 6 Sep 2025 20:11:18 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: net: run groups from fcnal-test
 in parallel
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250907012116.3315344-1-kuba@kernel.org>
 <20250907012116.3315344-2-kuba@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250907012116.3315344-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/25 7:21 PM, Jakub Kicinski wrote:
> fcnal-test.sh takes almost hour and a half to finish.
> The tests are already grouped into ipv4, ipv6 and other.
> Run those groups separately.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/Makefile       | 4 +++-
>  tools/testing/selftests/net/fcnal-ipv4.sh  | 2 ++
>  tools/testing/selftests/net/fcnal-ipv6.sh  | 2 ++
>  tools/testing/selftests/net/fcnal-other.sh | 2 ++
>  tools/testing/selftests/net/fcnal-test.sh  | 3 +++
>  5 files changed, 12 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/fcnal-ipv4.sh
>  create mode 100755 tools/testing/selftests/net/fcnal-ipv6.sh
>  create mode 100755 tools/testing/selftests/net/fcnal-other.sh
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



