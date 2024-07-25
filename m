Return-Path: <linux-kselftest+bounces-14238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B284293C4FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 16:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0E9B25EA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2164C199EA5;
	Thu, 25 Jul 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FA9/85m+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951BC8468
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918751; cv=none; b=Jx81JGGISk5ZryI2nYXkkerCKTaWLkm6HGJrSP74bo5MAc5PnDhqdkglHj/Qw5mwa77lUfM0zawGyPvdRIV+GGgZT8BQMe/DIKGom/zIpP0jKW7PB2erPbFrmffY6p3iYRisNF/2bJDqWlKNeO7dpU9zOH8BIxP0WPqMSmozdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918751; c=relaxed/simple;
	bh=HNpY12jj4QLeaUYSmrnBsn/6c/SDnsMCihydOP0VV84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q33c+Z9sQncAMeZ3BSwXh+Lpo4+8VbYv3fcoKKW6hYwpc1DzX7caw3+xBL0OHSwMTyT5huaAGEJ6cHIGUFiyoUd14//yPIR7C0I817hRIWKXwI7iWPb4Fap/ILTWlA7oxI5LKro6hyZ8pvep+YxB8JzPLRjmPXX8NJf2DO8jneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FA9/85m+; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8084f783737so1549039f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721918749; x=1722523549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tV9Ff2+s1v7f6qx4CAWym2ax1C/xlwD3BYRxTZaNSbo=;
        b=FA9/85m+mhAw/AHNb3oV5YvJXxn5qgkUtV2nP9fkSC2YY5nLjCDXBaGhx14MvFAHue
         P1H3KG4/JiVfMFOL0yr2+P4F8BB0t8w71xO/gZ9DRr4ZghunGnSUG/vhKpUpn4njcxe5
         i3Iu3x3GSDZixb8v2s1hHywq1cNm78HalJBb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918749; x=1722523549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tV9Ff2+s1v7f6qx4CAWym2ax1C/xlwD3BYRxTZaNSbo=;
        b=RTTJ1zRrGQcYMumh79tqBnj2yLynnci95Za5Y7Har9RJqA005mFJTwELuyma2v9xwH
         VBOqH3lUgFUqwbnzOaMBCAFGBuaCe7BsVWdw1RB3fcpq+Gn5/jSTl+i1XQYmw4eChMvR
         zXH0QI1uBj5cc5dvwL92J0TjgfZnyN4cbGu02fC+XHRMk0qKI7NxVL1U1wbaEBi+uDDl
         D2BE8Q55fL0dF8I1uLlQp/uxlyNjpVYPg75g9iD2MzZWdQZe/FSdyMJH7FY+I2lIHBlt
         yx93BFTxpLvX/YAmLynDlm2kaVy1kQ10ENpCNLTcBLfNIhBq11AwwrVDPydu5/bM+ekn
         IHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkyC9SCELg6z8xIo4l7LmrmUzOizAlD5UVPDjVlyLQKtlcVMbDFf6dCbbgB/FHDBQ+4MyDqAbjESAjZowosjB4IfCUrFPWMwZ1EQc3jX/r
X-Gm-Message-State: AOJu0YwTWXYJ2CmRctLR0wx2xmVd44Mquo9cZIfUEjT7rGXvF685t3t7
	Gk/brNoKaK7fPvbqidqHEdw0/YiN4eEcX8QS4DAz3rFAFJqU4ik+UISvFujsyj4=
X-Google-Smtp-Source: AGHT+IFAR2Fptni/HLPp1bBC/jZNTR5cC4aNUfqTa598sJH5Fx/l0WNYz7GcIhUtqhb7DPF1I+Oikw==
X-Received: by 2002:a5e:c105:0:b0:7f9:3fd9:cbd with SMTP id ca18e2360f4ac-81f7cf3f757mr203391839f.0.1721918748887;
        Thu, 25 Jul 2024 07:45:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29faeeec4sm344591173.77.2024.07.25.07.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 07:45:48 -0700 (PDT)
Message-ID: <2bdd359e-037c-4b7c-84e6-db381a619dcd@linuxfoundation.org>
Date: Thu, 25 Jul 2024 08:45:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: lib: remove strscpy test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725121212.808206-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725121212.808206-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 06:11, Muhammad Usama Anjum wrote:
> The strscpy test loads test_strscpy module for testing. But test_strscpy
> was converted to Kunit (see fixes). Hence remove strscpy.
> 
> Fixes: 41eefc46a3a4 ("string: Convert strscpy() self-test to KUnit")

Remove fixes tag - this isn't a fix and we don't want this propagating
to stable releases without kunit test for this.

It appears fixes tag is being used too generously for things that
aren't fixes. Let's use it only when it is a real fix.
  
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

thanks,
-- Shuah


