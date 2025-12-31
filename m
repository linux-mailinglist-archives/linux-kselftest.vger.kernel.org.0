Return-Path: <linux-kselftest+bounces-48034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94618CEC822
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4134B3003FE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF130C378;
	Wed, 31 Dec 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAQN1tr7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14532FFDCA
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210614; cv=none; b=nAaCBXen9k3r/4fhKxywWxPKRBFFIHsu145xAvEIEjKiWHnCMv+t0pRCMUnXefuO+7Ukc5z4DkEhNAfzDzw5AMzHYUoRElyOzoKFMSSab2SMLeUiExbyv4V1uQPSn5leIJ34R6itIni02+Qo+uke4gOQ/VYKFXd/JyV6D9Q2O9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210614; c=relaxed/simple;
	bh=1nTG02+cFhCSgRt+ehKjArzMkG1sm5NflheH5nhNZqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BW9ov1MLqzEU5nmPU5VA/MaFknbUJFNWUnq2/B8O62mAFUcddyymKDDdUxvcn9W4rHXH3uCJ0Hv9BtzDChTGKUi3Q460AzWxuT7Aiy9RrnbySx54lJMrFd6dClzhnxfHsCRdyJf7uCo1Tj9rBgAiv1q66wEnxbgl2KJHWvgF2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAQN1tr7; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78fccbc683bso78910677b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 11:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767210612; x=1767815412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maEYF369L0uPYuEDq459k1fu2OdLy1XBNdtHglonY9Y=;
        b=NAQN1tr7iwB4Xaj7bLBF0XQzvcsZPDgUxVtMCkgEFhs18Bk44cTniy7MumycCK39LW
         2H0y2c5L626Uk2vYjMhOUfGLPoD23OYf0+TYFYVZexskgH7fUO3mlvjDMESTKc4wjKRz
         p9+mkfdu/9a1qgBHHH4+LPALCjLkd+CyM3GJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210612; x=1767815412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maEYF369L0uPYuEDq459k1fu2OdLy1XBNdtHglonY9Y=;
        b=DYWgDabHnAQaEgBGEOMUjHERZlEoLzwEw95znAsxKjp7tCNzmKJB+B3Y0Nn+5QBsaQ
         Znj0xCVjDZVIJaOiNobBh4VFj6ebbGAjge0o0IxQzCjjM5uYWiI9W+A0nTE63mTntIuB
         TqPun1HwynZmITIGVz30mc7V0PqsXzvFuUsr2j+LxD2F+vIpGEcW4V3s/meqHVvjGgMn
         Iyw/Hb5g4xG36rjSePjylGY1ulcfpKDxE0RPN5yf3QB3UHNCTAKRA2eT7tcSomWWPl3A
         jEiff5owrkBeFdwUzvannCctmltz3UmMAKhmcb78mcjyWLPB2nignlCsT6gBJp16yARP
         YpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmLL6/BtcrHI7pcvZj4WVmDKfUxBgjF8XhctcSpu3lkTUjrFFaR6p8z+F2tsOP24NI7KqswWAvZ3t6UEcOSko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDHP+OZWiXCKJbNN/ixGsE0CPoIrivyrlCmsEfGwURVnTqOJ3
	oVOtZqa8m9d2XHnyEKG/6jQGI6Py37XwIbV96wfhvrMevggOY/fF6BFnvXNFXHeacOs=
X-Gm-Gg: AY/fxX6pumKSdejx/9vYyoPlrIVI5y65zel/YyqH2KVxqScNYEs9u/ZBVYdi7xWEwbg
	3oXWSiG+xo+mqvoZcwBQctd9hhdCiyx2XO4JQ9Wdov4TjLn1VN7lLOolDj8fQplgMKY4x6nwknn
	HovlTaQ9rTQhZmLXmPZav075rrq55BpL5ekLZ+fZX9zaoNNMWSWpSc/5H1GkCBVUjaGTnR97aiS
	riUHm4zABSWASpWE+Xif6W41sWiMEiwE4l6rywD/ktauMQhEoFPmHsUDfNMVTZ/T+rgP00xlEtK
	yOxkwdNPWg8ZQPHpCGWIro+YBNLEdfs9r7oQzIaiIsPFYbWyi3KiZSN5PLHAphDIHnzc0RNRer1
	P/JbSVdlHJjOqQj0GaoODEk8AuNsZFRxMOSybTqa2dtnWi/7Rb4kr62rIwEFAjRzUgRSFaFVPfQ
	evXqGUO9jZOw7pqAk8DWvHRT0=
X-Google-Smtp-Source: AGHT+IEHH80RGrTfxuAhiuir8H8nSeW1HDOa1c4Ztm/JyOGbm48G01zOg28illc45JuiROUURZwGtQ==
X-Received: by 2002:a05:690e:1cb:b0:640:caa5:57be with SMTP id 956f58d0204a3-6466a8460aamr25140621d50.28.1767210611707;
        Wed, 31 Dec 2025 11:50:11 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a92c5f6sm17853490d50.21.2025.12.31.11.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 11:50:11 -0800 (PST)
Message-ID: <382c86f1-03b0-40b7-aad6-143bdacd8a6f@linuxfoundation.org>
Date: Wed, 31 Dec 2025 12:50:10 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/ftrace: traceonoff_triggers: strip off names
To: Steven Rostedt <rostedt@goodmis.org>, Yipeng Zou <zouyipeng@huawei.com>
Cc: shuah@kernel.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230818013226.2182299-1-zouyipeng@huawei.com>
 <20230821111358.7540bdc9@gandalf.local.home>
 <33503bb2-6248-426b-a614-9f0f92899d70@huawei.com>
 <20251218182719.34334341@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251218182719.34334341@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/25 16:27, Steven Rostedt wrote:
> On Sat, 13 Apr 2024 10:47:14 +0800
> Yipeng Zou <zouyipeng@huawei.com> wrote:
> 
>> 在 2023/8/21 23:13, Steven Rostedt 写道:
>>> On Fri, 18 Aug 2023 09:32:26 +0800
>>> Yipeng Zou <zouyipeng@huawei.com> wrote:
>>>   
>>>> The func_traceonoff_triggers.tc sometimes goes to fail
>>>> on my board, Kunpeng-920.
>>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>
>>> Shuah, can you take this through your tree?
>>>
>>> -- Steve
>>
>> Hi:
>>
>>       I just notice that it haven't been picked in Linux-next.
>>
>>       It's there other issue about this patch?
> 
> Wow, this is a couple of years old (noticed while looking at the archived
> patches in patchwork).
> 
> Shuah, I believe this is still needed.
> 

Thanks for digging these up and others. It got buried deep
in my Inbox.

Applied to linux-kselftest fixes for the next rc

thanks,
-- Shuah


