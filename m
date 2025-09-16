Return-Path: <linux-kselftest+bounces-41628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC5B7C43B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 13:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11F02A808A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 22:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8D2E92AD;
	Tue, 16 Sep 2025 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fL2sRE+5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2F635
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063431; cv=none; b=jNKjCOGl4Dnp1NNw/AhExnY/9WsAj6f4NDQCNmajnRelrcKWPjoLZMUxZ4bCS4nV8tiRyWjxR7BHbbCBSl3qF2z3nwCOw4zJUdSBtOhMlEeEdphfOkVJ6m4d/Wv/3JfG6MLNizOeSp8RgnexiYlqVroKoPVmla40gxmaGtUkBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063431; c=relaxed/simple;
	bh=j7MO7dLZVJC1bDFPwVC2phRhydPY8BC9zOt+xN2/ZYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKZz+7afzhXq5MyL75OUcTss0VUzCpVxIQDw8u329CaRW1HjyxNvH+J7W2Jspsh8WHwjAh6DnhtQuvHP1d9LJL7PYSVKwzo/Y9U/REmGDLMY4KBDgyik3yNVUrvo+T0UWSw9d/ru2p+GVD8OgnMw9ssONmWY6kgSWvbP5d1tJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fL2sRE+5; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-812bc4ff723so557590485a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758063428; x=1758668228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNVTeFW6hMsZUiSc2Y7TZ5+CQhQCRJybyead8MewVGg=;
        b=fL2sRE+5iQdYqK+ERWT4GG/C/X5tiPWrKtUkRlzQA+C+tb6MzNi8sr7UxR87T/Zp/T
         6Sp/GZAmKxuO/wkXTMSONmUtEW9X5F5ZKkn4XPw/cOc5fX2wXFQ74nRdGOF2P89dl5BD
         WYr+fgZDwvCfyWi3P5Ef1TdR0/hlyqq+GvxU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758063428; x=1758668228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNVTeFW6hMsZUiSc2Y7TZ5+CQhQCRJybyead8MewVGg=;
        b=nrYBW82hsLRuZBcKIldyE2OuFJ1KtsCgTeMrH7HD4G3LANSHNDw13uyzwN2uhJNB6H
         QmzrBKQkeztmZCrRK4/iVtudyxuxRRiZ8D3IXz9hVRds/XLc4o7RZEPTadshLU54/ZIv
         lOI/qu36cnB9wiNofZ6b6N1p6O49cslcrEr1Wh2K5lCellXfu0v6+TLmebyVCl5qPQ8t
         hSFCsjJq53+ccs+WPFIvbTEjxoR+6nifzfxM8Fxd17OwGruDrw8aoayGuLnF+NkiQ5uv
         qZiAU4PGDfjbLWpiq6MTIPxTAjaIFd/2ynuJEPvowE5a3OFSbLLsLN4g8N8hyX6Qj2ex
         wjnQ==
X-Gm-Message-State: AOJu0YwTiHSGxeQ1XsrKh/xnYh+8evvEGNl+YLRHcU+O9h0uO+qFatkp
	lAzvh8hyaAoeXh9+PAZkhnntZ9d/R57cEcT2UinEYPhTa0kfMyx8vRxh3NLY3j8Rdmg=
X-Gm-Gg: ASbGncuyRDAPUOAZt3EoZOTc9bO8Le4rOkaTUlsWU/g9rsJ9525VPDBy9o6Pgl5Kg0p
	meLhGG/M97prKcL4M3tA/tGV5QfnUe+DVGZvuqa13XQ7FWxnSz4peR5H3FkaGj57z11gtc5jfBr
	3igeY9fleL9SOYbcJfdoWpi/H1QpjEoxmf9bO++cceN9i8n2RTUWhlvpA5DXWl2hl9IlG1Z+Wee
	SeVlBy7kYAocy0UyTDVXzZA3M028PJZTjJKKlEEqpmCdNPX3NFTeThfvrlKpww56W8+GpTyeiMw
	Li0/Z/DtkVNuve+HQLmLAKUkmtEuMrLmJWLx7H5U8GEgdbcn4MlkrIm+itEoECbEtZIZVj7JiyS
	e/Jx/4N9TQNkqhm1LoeCwhsmFpfMFyeRjS6aDm+xc1Wuo74LjTFNc0TkssrfFI9kgqgZzSEzfrA
	E8Py5EiNYWfJ0iIf/ytjA0K/7rOjfZo5Q8Svm57SbFlsY=
X-Google-Smtp-Source: AGHT+IFAqOA3hC4ras1yzzTG6/QAgWBIgns8ywXCJ+Yp/o6jmfU6v1kF3w8KmpVF05+P8dD8SLIKUQ==
X-Received: by 2002:a05:620a:172b:b0:82a:5c45:c5ef with SMTP id af79cd13be357-830fded0290mr10034885a.0.1758063428125;
        Tue, 16 Sep 2025 15:57:08 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974c848sm1033440385a.23.2025.09.16.15.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:57:07 -0700 (PDT)
Message-ID: <2a4a101b-fd39-4d0e-a967-ee671fbd9313@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:57:06 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: watchdog: skip ping loop if
 WDIOF_KEEPALIVEPING not supported
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, shuah@kernel.org,
 lizhijian@fujitsu.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 akhileshpatilvnit@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250914152840.GA3047348@bhairav-test.ee.iitb.ac.in>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250914152840.GA3047348@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 09:28, Akhilesh Patil wrote:
> Check if watchdog device supports WDIOF_KEEPALIVEPING option before
> entering keep_alive() ping test loop. Fix watchdog-test silently looping
> if ioctl based ping is not supported by the device. Exit from test in
> such case instead of stucking in loop executing failing keep_alive()
> 
> Fixes: d89d08ffd2c5 ("selftests: watchdog: Fix ioctl SET* error paths to take oneshot exit path")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
> 
>

Applied to linux-kselftest next branch for Linux 6.18-rc1

thanks,
-- Shuah

