Return-Path: <linux-kselftest+bounces-18137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3F097CBA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 17:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FDC1F242EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8780719F408;
	Thu, 19 Sep 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TIkJRVU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C6190477
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760226; cv=none; b=ZELcSE3tA0QHfx/lnHI8COcW6Gu7t0HY9aactUPqhvDDWe6GtT3SKIMh3hTSRNAY0trdINOml2Gt2J87IdRVZIaZF+nRd5QbEpzrkKCuMRCT0Na/6npM8tedwuF8NcDyyxUt1X+LrljUatE8wCsZ1nAA4tcm2FAf4itNaZ/twvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760226; c=relaxed/simple;
	bh=YYLtJpBM6YAItg6khmzBuREZLtA5kmVCxAx3WUuW4Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqviG1wEz0ikrbhzKrL2UI5ZOGU0XFriIlqswkOaVYyRUX1zkc/lDVYtx3l6up36f+rRef0FEktIHKsn0hB8tMaykCI8u52HWCAyoAg9m0ZqogqS7vY0olc3b+exLNxptASUGDOLnCftBJlgcEqylMGvqPluzd+NrlKDjvHBRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TIkJRVU7; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82aad6c83ecso42850739f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726760224; x=1727365024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qr9CFL6+Oph0ffMGoCXsVCaiSQKS0JdtRc9XXB0JbJg=;
        b=TIkJRVU7Y7gDjOmhIZMrvpOaC2WNbr1e+F7CRvMLJZ3qaJKzaPROrf/23CewhHsjPy
         X7LqcP+xtIAKaKiSkfngcDKQNQykvlIjoAXprcq+Py7nnO6qVK6FE3imn2ZSI4wLPEBm
         huVkeFIowEe6uyZFFAY6/GVf/0oKXNUGXvKNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726760224; x=1727365024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qr9CFL6+Oph0ffMGoCXsVCaiSQKS0JdtRc9XXB0JbJg=;
        b=EdQcUBcGZjCvNw6ql/gi9PDcX31T6oNJCuJpGExxs4XfWJ7N6dBWvynjV6e8xEe/+n
         ajSXHWfyzTQP4gD8JSIuQotWUI+Yv3PSRWlY7sAC5z4wka04uhOMNhXZ6DBS46CxFrdN
         85AdftXDRVYdVHIEQ7QxPWtVNVwxDuWFcbC/lXFwrttFQf7BA1Pz1L84YPX6RTv/58bH
         WWDJJoxwrtIdLwDIBQ9iMeJXCLdbkUY7s+F/6zZw7W3v/RgyL1QvGaUWt7ezW1L55LVV
         i/BJoAmwiT0o4p/6thmaX3HckyINIROs3e067Q8DMvV0FYpigGkKQHUfFMT1aHZaoS6j
         J4QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzpc0ubUqZ4egTfF4p5EWDs7RisCxMOcX7+JEb7Kq+7CRx2zhG7CF7sy1sklrhuhqH8Oe7PzSsXCbWWDpUtak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUfc9lSFcP+zQmHO2VTZZruW+LdV4BsV+O51Afh75u2MxSBfS
	2s1J1o6cK/6T0lckK0kAV5t4xygQ0YPFIeA8vsoLomiYO8e+6w83BaHqCU0k+4c=
X-Google-Smtp-Source: AGHT+IHxAxPUAawM0ZALbnCA7+8vHIBZzxx0rPjHoGnk2o8G+KXuP0F/zG2tdHt6cXT25xmuCv8ECQ==
X-Received: by 2002:a05:6602:2dc5:b0:82c:eb18:ea53 with SMTP id ca18e2360f4ac-82d1faa20d7mr2739091139f.16.1726760223846;
        Thu, 19 Sep 2024 08:37:03 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf484asm3088178173.33.2024.09.19.08.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 08:37:03 -0700 (PDT)
Message-ID: <f229fbad-731c-4dd4-8c66-ff8829c2c958@linuxfoundation.org>
Date: Thu, 19 Sep 2024 09:37:02 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: support DT_GNU_HASH
To: Fangrui Song <maskray@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240915064944.2044066-1-maskray@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240915064944.2044066-1-maskray@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/24 00:49, Fangrui Song wrote:
> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
> obsoleted for more than one decade in many Linux distributions.
> 
> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
> 
> Signed-off-by: Fangrui Song <maskray@google.com>
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> --
> Changes from v1:
> * fix style of a multi-line comment. ignore false positive suggestions from checkpath.pl: `ELF(Word) *`
> ---
>   tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++------
>   1 file changed, 79 insertions(+), 26 deletions(-)
> 

Quick note that this will be picked up after the merge window closes.

thanks,
-- Shuah


