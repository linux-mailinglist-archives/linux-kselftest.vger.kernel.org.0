Return-Path: <linux-kselftest+bounces-19568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8714599AEC6
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 00:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9649A1C21684
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 22:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48151D31AE;
	Fri, 11 Oct 2024 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GrB5jdd+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9651CF5E9
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686880; cv=none; b=geRaPTnDAA+P+UP7m4/wF5y51MfdRgbEJQVooHmgOuThwcW1f8iE2rgQVSxotbEtR87sYY+dQNcYY+q5/3250v0DtQxmn3Wy30lwphvByUHLVFEdcneNGa/iRe6ICFPZWXKx+EPPKhXtLk5bV+KXeWW798Ke9RbgYUhgL9iF4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686880; c=relaxed/simple;
	bh=8Wi3JDBUsjlWjnvtJ7Q5guyK217Mdacnj2mhUbIEHjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X27LVB1S46FoeWHRN7nM9cljcIJltZkLq/WGTdtAUxTmJs8u7LV+YrGdZxWLz+DoXUK35pCYBbX2QuORkWOcuv9V5DIWnOL3AqcCtLAP3SV9dLOOlN2UpWE69xiGcUwluT+x0lJPMGJFgaO9+wcUVtedd9+j33mG8rGC3kHvGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GrB5jdd+; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8377fd76112so67042039f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728686878; x=1729291678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mzp/hzrig+fA9YNT0bwYNz6N6cWFF5q15o65QRPQI4E=;
        b=GrB5jdd+qgnOo36dol5rh2/mE79EVumz1oA77KDdChc+c+ecIhVf/pnuRv9/iPSVwg
         aXht0bAdX0iNvn+dD3z0hjbgGFSaAVVpKh2lLtIB+MW4yiy2YIYAPNr64dY8Bhgfx/Rs
         qtRhDKaCepQRY8bfzTFE8UWEALiTDWXC2rVDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728686878; x=1729291678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzp/hzrig+fA9YNT0bwYNz6N6cWFF5q15o65QRPQI4E=;
        b=T/+xeFKoqknbO9BJqb7CxnhOIHw7iWVMqSeAET/KooC1V1MMWcjt5FwTpSIrzXB1q+
         jHnZqC0XkQHeTDfdSS16iNZ/GKH3gQwe+XrGpsKGZ4MIAoh64bcfLfcbfa6i+Oqvsp3B
         vPC2Q8JGZAYNPLWDPJLs+8pidpAwUviMZn70TxQIqFRsQyiJDkaoih+loSTD5M2vKEuA
         rA/HPwAtee2OP/s+TtDxrWcJb6TR3bEjR2oH3mUZQRYx0WLtqHqLALj+KO3vuu0IHG0d
         dLOriE7UEpwsbQ7WH1fcwwIOU/txCVlxQXHmQQiLuK+RjUOvEEk88bdQ8G0ap+iPJGXE
         CKfA==
X-Forwarded-Encrypted: i=1; AJvYcCVyY+nHSgxVTy3518qP5eUDbzGrM8+E68WWvlsnDOn6KuO1R6U1ZQ1azRflWPuOME6CTCryM0uCxdh6+LCMROs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR78EoYghZ7NaE4Xb/2K0hWX3H0BS4HqtUJ/1gAzzutrKddM5S
	U2TllHlvosrGpcebgysoO8ekwShreDeexhEyEEX2iZfxXe5pSkUpCUY/7ed0rjs=
X-Google-Smtp-Source: AGHT+IG0dUmfLDdjMZKEXCHE2/Ff048pzK4ndO/RCt5YWkpFQDA+iNmvFMCE0kNqO61/TE+gAbZIZA==
X-Received: by 2002:a05:6e02:2181:b0:3a0:c88c:e674 with SMTP id e9e14a558f8ab-3a3b5f1de0bmr37302095ab.1.1728686878155;
        Fri, 11 Oct 2024 15:47:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdbcd1dsm8935795ab.43.2024.10.11.15.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 15:47:57 -0700 (PDT)
Message-ID: <e1e59650-0c9d-4100-8e6a-be640caea281@linuxfoundation.org>
Date: Fri, 11 Oct 2024 16:47:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Fix check of return value in
 fgraph-retval.tc test
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241011132042.435f43cc@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241011132042.435f43cc@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 11:20, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The addition of recording both the function name and return address to the
> function graph tracer updated the selftest to check for "=-5" from "= -5".
> But this causes the test to fail on certain configs, as "= -5" is still a
> value that can be returned if function addresses are not enabled (older kernels).
> 
> Check for both "=-5" and " -5" as a success value.
> 
> Fixes: 21e92806d39c6 ("function_graph: Support recording and printing the function return address")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
> Shuah, this update is only for changes in my tree, so you do not need to add it.

Noted. Thank you.

thanks,
-- Shuah

