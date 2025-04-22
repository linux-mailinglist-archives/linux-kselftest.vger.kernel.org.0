Return-Path: <linux-kselftest+bounces-31338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE00A97330
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FE94402B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A27296167;
	Tue, 22 Apr 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="He1CgaJi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5308284B3E
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341147; cv=none; b=nt9MXyKVnA/mmAA8zrqXLlU3TE72CJiKD/YgXiBQbqi9CpZNxSAOsGsD7fiJbw1UhYZ0RjsaWZUuerPoJL5mwOuXllnXb9JXUZ6SBa5JenbudkrVUf/y5lGSBQGGYXSwvAfRFYFV+6yma8NY9Gvs3xw/GCR+oYsYWJNQp6BnmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341147; c=relaxed/simple;
	bh=XtM19fp6llQW0I7FSfQu/I/iDTjKjadmXVKD8lRQnqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jul/5vAUeqDoE7BzST3Z0R++Wff297YBkj4IDUS1fV/+yNR1Gtl7/yPt2z5Gxcy47H+Wxstn5FcR9rGihXicV1Q4+o8r8GyoOqz/tSX+FL9Yd+I7q5cu/lYOha1XToPvC1V5ClJt5sd+ISraU4WHYu99IQ267LdrdZlIEFB33bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=He1CgaJi; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b5e49615aso481805339f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745341145; x=1745945945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jy5TPkMpiqRKsqQU6VOgWl7+8BuUE5e/MNZHqkVmKvk=;
        b=He1CgaJiwOmbHxvK0q/o+gua1ALmOGVg8Bd49bIDyzzDI0widbOzOja0JmfQX8K75S
         u/BsIoVycC00owUKLjCumkPdlRwFIiJYquERs+2CBRXuWQXzN6avgcHI3MV8DsGo5gpI
         2ebh42wrnNY1V0ve1kvtyUq4tfMIUbug+7/cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745341145; x=1745945945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jy5TPkMpiqRKsqQU6VOgWl7+8BuUE5e/MNZHqkVmKvk=;
        b=eyp+xJJTTypgt6QzTJG24BuRIFbww9Qhxvos4VZsTwbvh/WhIC0sjDL+Ln1lTxwnNH
         u5fGZensdk/GhvgH/s8cQ8sgPxdD8Su9NT69ltuEG0kot0UQAXkXkvJEf8F+Ya3D4I0c
         0LhTAFi7Wgjbk/fGiZI2UyXu1xjMZOjN/2ZvRQe8IUJbnxgCyqteZDq3PIx4McIevYmN
         pGkApYde3IeeaGaHMljKK1ZFmX4sWcNjFnzwzDc4IrIO5AjD2UJx5E2Xj2GgYPSCBx27
         D+RozFFbwuujBnTIuuehwwZB9uyKvMcfN140D39tuJbB5AkZeabeED2iK9tE4945xtaP
         soug==
X-Forwarded-Encrypted: i=1; AJvYcCXhV60M2HRL/GTJ6ZOMZbYkKmC2+Ls3hAJL4zFO5Gec82YsZ4/JWCC2SoRRAe5n23NLphH3IrzGghn4G6FBzhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYZJfZl5Jjq+wgg9zWaeTVMl6JwOirhqfeKWz1keNlOa0SWYgJ
	jpx2NifoUIXs8Djknuj9s/1p4FNzIfidtTmc3Y2TU+UTwgcvwYZKWZjaQzMnHoE=
X-Gm-Gg: ASbGncsPbrq4d3GJhvIrCuPID2rGWt3YPR/+vXimZiwF8X1yU7d3TQhiQor2iyCBvAF
	abxgEeLp13W8kcCSql/y2CSZ3BI5c74LwtW/lkL0R0kI2LzWgYJJkLO6iy6b9W8Fdy8ihhL1/2E
	x63Tr2ILEef2CDnhYg0peyLeZLb0Igtpmpoh8Od6Y7fIm0eiBQn7rGpvbgntaSJZszfLtLuMaEf
	4gDiEqrjtqugor6xEjCRYehMePOX++SFXthC8QInlkWK/CrqNow2bfgkX5kdpNchrfWxRg0Btxw
	c/AQcwxAAbd7n2ppMGiozcghjWfQOu7cOFYxypu0TgVW8ETrDqw=
X-Google-Smtp-Source: AGHT+IEWkZs6CedJNt2KE1miQGjqJBAptodtv2M35SklMJZz7zNwT8QqCf/45+jwRTedwK7cIsTwaw==
X-Received: by 2002:a92:c24f:0:b0:3d0:19c6:c9e1 with SMTP id e9e14a558f8ab-3d88ee00454mr153841585ab.13.1745341144724;
        Tue, 22 Apr 2025 09:59:04 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3957613sm2412786173.120.2025.04.22.09.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:59:04 -0700 (PDT)
Message-ID: <de2a5e52-8061-4907-bd48-0d6d28b83b75@linuxfoundation.org>
Date: Tue, 22 Apr 2025 10:59:03 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: selftests: Add testing a user string to
 filters
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250418101208.38dc81f5@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250418101208.38dc81f5@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/25 08:12, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Running the following commands was broken:
> 
>    # cd /sys/kernel/tracing
>    # echo "filename.ustring ~ \"/proc*\"" > events/syscalls/sys_enter_openat/filter
>    # echo 1 > events/syscalls/sys_enter_openat/enable
>    # ls /proc/$$/maps
>    # cat trace
> 
> And would produce nothing when it should have produced something like:
> 
>        ls-1192    [007] .....  8169.828333: sys_openat(dfd: ffffffffffffff9c, filename: 7efc18359904, flags: 80000, mode: 0)
> 
> Add a test to check this case so that it will be caught if it breaks
> again.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20250417183003.505835fb@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20250417223323.3edb4f6c@batman.local.home
> 
> - Use $TMPDIR instead of $TESTDIR as test file (Masami Hiramatsu)
> 

Steve, Masami

Do you want me to take this for rc4?

thanks,
-- Shuah

