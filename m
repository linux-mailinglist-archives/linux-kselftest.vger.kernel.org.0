Return-Path: <linux-kselftest+bounces-5089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C485CC2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4DAB22F5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 23:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D166154BF4;
	Tue, 20 Feb 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXP+vrFz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8F40BFD
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472640; cv=none; b=pAkwvx9/UviT8uwd6/Id9AwtotbxfPcxbAz7Qo2pnNh74DVs2vo76Anwdthv1IwRSJuAXkhJUY7a3z4I85ZI0DT3n7yZAWUlhxJTPD5o9Ajd5g5BjhJU5CRp0/C7UY78hdOklhfMvoqNERcDra/lbdEDFLEhJ5aIuyFEXy6qiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472640; c=relaxed/simple;
	bh=5Z3jzN8IJbBKivowdE43P6sb/r2SmQzFWMx3R2bUOCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XimEOxwjcu9ldnxJxkQ+y7b7gzH8DG4jTAjjS2sKAroYl3OZuwJwPmQ9oESZ+CbfYSl4sO0Klfxt3piKiLlj657ANX76KRrYw7au4ExcLjw028xRJLVUyv1uKDdfeSYwuBQywoKQOyL5vRK16yWqoV+Gt1nePCjlaq+qMdymc3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXP+vrFz; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso99107939f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 15:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708472638; x=1709077438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IYLDpNhmLiIVmkNr03wZfn6zYQwshujGxYNKgfISfk=;
        b=LXP+vrFzhwpExCNpeTAxZqXlQdHP4SMWAgQdxx/3nC07J0YCdkHzF9OBt5k2JGU/7n
         JKDe9x1YdvzG237jQoFvLBmjXZGRvPHM76yULoDBAauaBf8gC5fC+JexHGnla7ubAqka
         z2I1rY6h1DGBVGU950/3lBaY+l6rAUILqCrWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708472638; x=1709077438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IYLDpNhmLiIVmkNr03wZfn6zYQwshujGxYNKgfISfk=;
        b=DBOYsHukAE6PUfDKl7o+BPtk/1b2TQoh9pdMdFsARIGOjJowaxPhV05+knDX10D9Q4
         /pjBHYxWHy+YWP4J71M7SAD9RDsbdRtFkZph7roMXWINvK/06mLAt4j2WxM4cp5ur1ub
         eV7IClD0QoPvae4x2nZUDIQJhcvjYU1/whzteUoW0f4CdZkh+vAEz7kBXGx/cdYizQvl
         sFNyuBL2rLpXEi8AmY6RUmBqsUYdNVKtk/lmENg8jorQjrjCEQR4SVyX5YZnxjlHfSje
         25y6KWAITp34u9BGCods4KGTJ2mLMvV3cMAc/tviEyOl3ZkOjrAu/j4fWlYYatsFfTRa
         rezQ==
X-Gm-Message-State: AOJu0YwcRrn9Zj6yS0QjAiaa7yNVz0TbMkvbyt4ScFQ5R2dRsNfO4rCu
	01+DbMZfWxKCOU9hLe11B21qYyWMs5yugM3ZCLUjq13LXW5IlqqPbvuSsO/va8Y=
X-Google-Smtp-Source: AGHT+IFsTEfzlF19U0XF+iODGcfrAfPTKp88beXhxjPz99k0PPRsHRCanZRlQHtYvy9GIb2+LOBaiw==
X-Received: by 2002:a05:6602:1d47:b0:7c4:655:6e05 with SMTP id hi7-20020a0566021d4700b007c406556e05mr15416502iob.2.1708472637984;
        Tue, 20 Feb 2024 15:43:57 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m6-20020a02c886000000b0047434f78c7bsm834433jao.157.2024.02.20.15.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:43:57 -0800 (PST)
Message-ID: <28e5b167-8c73-4411-9288-90aa716044b3@linuxfoundation.org>
Date: Tue, 20 Feb 2024 16:43:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests/ftrace: Add test to exercize function
 tracer across cpu hotplug
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Naveen N Rao <naveen@kernel.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240216095626.1234309-1-naveen@kernel.org>
 <20240216092339.49b535d3@gandalf.local.home>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240216092339.49b535d3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 07:23, Steven Rostedt wrote:
> On Fri, 16 Feb 2024 15:26:26 +0530
> Naveen N Rao <naveen@kernel.org> wrote:
> 
>> Add a test to exercize cpu hotplug with the function tracer active to
>> ensure that sensitive functions in idle path are excluded from being
>> traced. This helps catch issues such as the one fixed by commit
>> 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
>>
>> Signed-off-by: Naveen N Rao <naveen@kernel.org>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah, can you take this?
> 

Done. Applied to next for Linux6.9-rc1

thanks,
-- Shuah


