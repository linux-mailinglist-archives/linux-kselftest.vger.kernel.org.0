Return-Path: <linux-kselftest+bounces-6389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F217887EB39
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 15:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4162C282DEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADCE4E1B5;
	Mon, 18 Mar 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1pi4l/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C64DA0D;
	Mon, 18 Mar 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772971; cv=none; b=qUbHLMk22IZx+asU/Twf6priq7WTMd1BYA7lHGJPybRs5jbI099+IVjk8ZgFIfi6LZXveaftK1qkUTAQjp8iQb1nqZFUberBU0V84rtuNDKrEGZF1F5lx20m/j42rGLyHIBIqOkNvOw2k0oeVCtMF8P7nMH8vSCqWuIZVtcF3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772971; c=relaxed/simple;
	bh=6jZUOrSarj0xwQwHkR92kQfr7ZCM72vokHH8mZ8RfRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esnuGyPJU1p+ooLAxIpONxIk5otoesdW37xpWgqdw20ugEOaO9Q8tOu7fn4VklmYkqSKSm+yErw0ATJMy9Jen5qAPsgBFA/SzxU46nlM9sE7pc/6n3bG8SwVU3G1JLw3ui76WxrkAsxziWsM4mRBf5TX9TUc5YMXgXamGvTDW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1pi4l/t; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7beda6a274bso135324639f.2;
        Mon, 18 Mar 2024 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710772969; x=1711377769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jZUOrSarj0xwQwHkR92kQfr7ZCM72vokHH8mZ8RfRg=;
        b=V1pi4l/tp5H4dFLW+XuvtwUlL6BfL6SKI2u+QPwx82Zeq1EQjmeyzA1xZUbAvPHfTk
         vwzW1YGpRfRo9CBIFihM+McDJwyO3k5s8DDKi1Q7EO0EruswZGvpgFlDHk74qVCt5lpm
         xQS8fhYJyw8vYjHH7mZwnvKIZL9y66UlAS1LtKoZmA+CKzotUchM1F8DTfd/+VN2EnxS
         Mod0JKwYwg8o7Zgm2ZabTUUGJQIE3D4t4DSAKsTIr8MA5+YL9q2r5O9aO364KtHbJVGC
         DlVAXXJbl1a6XAz/aC5ycqsKp/pnF15YCxRGsJqljE45R1jlMoV0a0vxAjemeuUjzFqD
         q7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772969; x=1711377769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jZUOrSarj0xwQwHkR92kQfr7ZCM72vokHH8mZ8RfRg=;
        b=iJw5O9rY+cBPqFpGtYWm1GqR3euA/MPsa9YhqeCIRTmWwX3cVk7wm5I3i6OqJA1Czf
         Y/pii5eyZEEXwhfJMHoZVX8p6IROxJHw02b3IlKleZZXp+96vp6pTnaynKocLVOqNwOW
         fm0fih9uF/6jdoDiOK4wcOp8FMkurcmlYUlwQnbqaCLOBUMnyFzr7FkbEEbDLePWmtbW
         nn7+ZQ3wMchmbPRSKUPO4S4zOI4h1pqFu7uCaJWSswg7jEdQtt9CdVXhkzstf3/1o1v/
         PK67O8P8Li29ezT6kkv9Cc11Ql1E+gcIb113ljGpYZab3R8F8jIQtdOpSE0dIefyDGpD
         HgPw==
X-Forwarded-Encrypted: i=1; AJvYcCVCUJ3714lfg6Jz7NmIkuUC/G/5/aWOUfsxVoGkqbMUX/aa+alb3utaqM1HkuiUjxUH0Y4ZwIqEY5T9SUnszS6Z4WfLl9L2WW7KnpN2bMun12n48nAJt4+RDi+v0KLIglp1FSnNh+Xqcy/XGw4g
X-Gm-Message-State: AOJu0YzwtN0S10wyeDKJHrMvnxzWmFFknE+RM+Zf2qQtV2RBmYU3H5Fa
	uk3rPKRXoRJH+i6Hr77/6/tnN7VboxZ+e1InCi9CZXwcC7LRPOAb
X-Google-Smtp-Source: AGHT+IF0uNwYEaBz8AnexP5ENUY+lLOK4IZZdV2iGj2PTo9PbF1OMggRiBoWCrlFZUCVvWkeE+p3nQ==
X-Received: by 2002:a05:6e02:d41:b0:364:279c:4a08 with SMTP id h1-20020a056e020d4100b00364279c4a08mr10977168ilj.23.1710772968895;
        Mon, 18 Mar 2024 07:42:48 -0700 (PDT)
Received: from ?IPV6:2601:284:8200:b700:a4f8:d880:24:bcbe? ([2601:284:8200:b700:a4f8:d880:24:bcbe])
        by smtp.googlemail.com with ESMTPSA id y14-20020a92c98e000000b00366776dcc88sm2363725iln.79.2024.03.18.07.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 07:42:48 -0700 (PDT)
Message-ID: <2b5e831b-baf1-4681-b3b1-b223df07ab83@gmail.com>
Date: Mon, 18 Mar 2024 08:42:46 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] selftests/net: icmp_redirect.sh: 12 out of 40 test result
 with [FAIL]
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Po-Hsu Lin <po-hsu.lin@canonical.com>
References: <dfb4b2fa-1728-43f2-ad73-f06145399fc9@alu.unizg.hr>
 <ZfepK3xItcv3ARVV@Laptop-X1>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZfepK3xItcv3ARVV@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/24 8:38 PM, Hangbin Liu wrote:
> Wild guess, the last change of icmp_redirect is my netns update. Maybe
> there are something default sysctl settings in netns cause the error?

It is most likely sysctl settings. It would be good to chase those down
and make sure we have the script setting them.

Mirsad: What OS are you testing with? That script has a verbose option
(-v) to get more output like the commands run and pause-on-fail (-p) to
manually debug at that point.

