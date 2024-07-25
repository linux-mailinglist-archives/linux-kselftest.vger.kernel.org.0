Return-Path: <linux-kselftest+bounces-14237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E293C4DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEAD282C71
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24D19D085;
	Thu, 25 Jul 2024 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WgRpXLqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348919D068
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918661; cv=none; b=iziPzVr0HQNPJ69/jTwEWA6xTiQQpc/iI7GipTwdgF7hvxnEEmt09De43jXGquyWQgr/q5OtinzNmFYs1HyjOnRsrlCHLCEEkeFjFKh3zOy8UZljtpW/UbN20TG45eqfHhPbP/P3burHUZcp7rM7GwpAsctlAnvgxnVRpb2qXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918661; c=relaxed/simple;
	bh=CYeY74nWbiLhuVILJd9ZAeMxNX9FnpbfsLSv7nfzCrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXXHkNAFi1Z4UZfOZm9aiqWr8ugSo5R1In/J2VaQy8w9j3p4KncLDO/N2EiuLK4owfBrkvkPSmjRgditQIoCzYeM3B2ePDoi62fKe1ymygK1C5SFwzx5zxN1SIFo0lV+1FzMeT1yLjvaxftUX8+swpjOPl8fHp2PX85i0EGDt80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WgRpXLqn; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8084f783737so1535239f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721918657; x=1722523457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggkJi9vdNqiqOHEKpWi9ZwmYybDVc4cKNgErtinhby0=;
        b=WgRpXLqnShuOeNutwgAQj4WgKX8ib2xJJRlK/Gw/ufkO0sevkKyTkm16wvpOq4psNF
         /cr+SWC8rrqlL05R4ZObkl9qO3KQyEOpzHZQ8sSjrVKnNhzx+xnpYP0Y6MCPI8uSBlJw
         5WXyGjuurCCwGrjtePZNWSFMTqs+lSKN9G4ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918657; x=1722523457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggkJi9vdNqiqOHEKpWi9ZwmYybDVc4cKNgErtinhby0=;
        b=r5qOHT+dFud7ylfPUU1oh1KY5OfiltGXIXR/KZ8e1HBKYz//Kg9NGFzkrfTOETLyDy
         yuPnmBcLfg4l8bbhYXEWMruqoL8aZHOSF/bxA8mbNSs5LjejLb2jIbP05ljcsKlKtpIs
         57gS/vQguPqy37wVMdIKHWkNzokZ9mvKYmrRpFHDw0hBulzQsTjBQqjp2UGmxAwJa+Dh
         xNnnfdhKjnlIcNEpopXjFIWLwBotpRZtPFY3XVlZ88GFoPJB7CatPzJ7jtyKLrBsKuFc
         7z204x/l+9LmdRLEfYxc33zM5q+/P6ZJZLGOtzeYVlQ2wQtRRBRSGwY6WLwVebSyYqGr
         BeWA==
X-Forwarded-Encrypted: i=1; AJvYcCUwwvtDERM8G7gjzu+L0fjXzjRf2RRfdjH3dxZ53q8eLRAkfWf3w+qPxJNbHkcPf6L/DL/Fid/BLtBHrvxz4UlfuQan5ogaY1hqCiVWIllh
X-Gm-Message-State: AOJu0YwVO6//TI+DJ+4oXy0mRBT6YU1MqlxYmTQyb4lQDO9jO5gcBnur
	6BURaf/7pDYFhi05mHCcucZ+lyAYsyR+YL+HCnm07rliHLX1x6RPJPwHUO/mwrU=
X-Google-Smtp-Source: AGHT+IHnyggLyOMRhFjvc0+DU90oiUQyBNvbh4Tj/hi+1HeGK0HdT/fKi4bxgPXBR+sh404slpQsfA==
X-Received: by 2002:a6b:f702:0:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-81f7cfbf361mr193935339f.1.1721918657567;
        Thu, 25 Jul 2024 07:44:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d7243eesm47480039f.18.2024.07.25.07.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 07:44:17 -0700 (PDT)
Message-ID: <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
Date: Thu, 25 Jul 2024 08:44:16 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: user: remove user suite
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 David Gow <davidgow@google.com>, Vitor Massaru Iha <vitor@massaru.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725110817.659099-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 05:08, Muhammad Usama Anjum wrote:
> The user test suite has only one test, test_user_copy which loads
> test_user_copy module for testing. But test_user_copy module has already
> been converted to kunit (see fixes). Hence remove the entire suite.
> 
> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")

Remove fixes tag - this isn't a fix and we don't want this propagating
to stable releases without kunit test for this.

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Thanks,
-- Shuah


