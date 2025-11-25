Return-Path: <linux-kselftest+bounces-46405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E7C82F18
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 01:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8540F4E15D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 00:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCF46BF;
	Tue, 25 Nov 2025 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XCuWywgm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7211F5E6
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764030876; cv=none; b=XhtQSIHA0fj7+RLghxBF6yzCPy7f8UAI/QPwzd62SrxzAHVX827jGFGKIRcUS+u/oGCEzrw0qnljlKHUvhjXGA/rBhqg9foif/5LH3Qgp3LWDv7mIiVQsyqISXFkxcgRzGpojHlDQ8K/0YNoQPG+o29rv7DCNSVlix9xKkshyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764030876; c=relaxed/simple;
	bh=yFw7GSoA7js572MPjYiS3vwK+FkoXdACgw47nXbfQBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDHWTyuOr0PAa61iiKH80N1O8laixZ6g05oLsvCYQeskN/g4tbQ3WTEgMbbG7/0voKbGJwvSJTeCmoQHPB4g5XwjcJMFHbU1tsIBn5NIxlYUG29if1zRXE7ZbWlZVx2/aOOV5QZf6dqLdmc8dStIoF1dFChjk1+PaDmyt16eW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XCuWywgm; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2dec4d115so500094985a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 16:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764030873; x=1764635673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQU+EAlNyeAvvUQ4yLH9CM8/BO69UfCU0DNxzC57JlM=;
        b=XCuWywgmgsGPfaTXxTnyKTnVj3v2TwGvzVwigJSN+SqgOCswnjvTgdgVoTvyZrdDZq
         eVY3MCiVUUZjlJVBqvRynZbv6Z2UUlq655e2LUhqfBqPxfc5p+8ba7zqyR7gBb0rJvWG
         pM0o/Oe0aXp1bjAf3gVm7nFpU2IxLZ8Mfi9tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764030873; x=1764635673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQU+EAlNyeAvvUQ4yLH9CM8/BO69UfCU0DNxzC57JlM=;
        b=dkm9adqoxdYVLA+BkYS3ltHMrp82cfl965X0igXcLTpn4ffDn9kI7bpIxRmI059+Zy
         UJXM5thY4aCpZHhbJo1t2Gmm3Q94o4YsSWyk6zbo07NMATkMD3T5svgHRnyPiawpcema
         i0+3v3kwbSFKgoHjkm7u3PFPEob/dXOjVjJE6zEEkc8f9aldkE+qmUu9/hJlEakuEwGs
         7dXfF39fW7Zm38vuvDjFbeddMgdyjVAv6jPQpNqI9W5b0CUJ4umBAPkFg9J1WaLpQqa8
         /SY/0UC0D7+sBISl4riQAbD9w79aWMr1uWB2psLZd2QGUmsdPvQzHHA4nTT5oSRAsRaT
         Igxw==
X-Forwarded-Encrypted: i=1; AJvYcCUwjj6Pr7O3JgHUSqpvnUraj/1Q9HUvUB9+v7LAH0XRxCwvmmErEvwhEpj+imfWwup87gH1267QxfwO+dKo4Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO93HszLnHzOznGct6y7QQsVKNrmnd8YmxpWC3hqK63HqKN/qA
	aBIBII6c5p3z/fx/lxOsMt5gqvYDv4bHNXgfgOgkPtkVUOtRhRK+64dLzK6S25HCKKEl8FSpmCr
	RkpLN
X-Gm-Gg: ASbGnct4cYLJbStijmCUQ3dkkKTy1+HNiA7p91GBGeAa93QsUDOXagdD7Ywmvhl3NAn
	3TjQggPVFgO8yeiU+PU5ymENSzzG0e7Xsk8YfwqEU27ixPqWpesUHW+ReFLdLF6dsSpH/O4dRwR
	+w3sesxljgUiMD3fzLld+qCOq7M0OfzNN1UG3MHzPC2iyuUwn/ra1FFU/4F1kQSA1bKh9lJ6O05
	O2UCvSg7Or5XopMFSC6aKjb+6ds7Vee1Eccs9TG42teuMLoEGO8LQwubYs6PszNaTT7t4ALP+Zo
	jNkC5+J1dLs1nRIrGn197NOUFA+DDT17gcVKTEdApBzudwSxqUGPIrIkxlFeGJtBTt1e1dUcF/0
	vyVVYSZbv6j/kgNO1qsKHC3GAD9pVApTRUHyJaGUAku8Xf0f72/7Z/WNcf6Ne8qOWcOEHiRnyj2
	9Eak1KmEMEiEjIENTquH5mX2xdN6lfg+iHRoYnhdVdr2puvJEBnpbRgH4m7Ng6TCJ1jxp3b5KpG
	3lHhA3JxvtyZQCU7maN9hCSfDwJ3ABYhg==
X-Google-Smtp-Source: AGHT+IHWHAZ7qDxEqKri3FtLO3ksIMx/Wmys5wAWDjD2N8qAC3PnbTH6fESzeDs+xdcM6vdqcb7uAQ==
X-Received: by 2002:a05:620a:372a:b0:8b2:eab0:629e with SMTP id af79cd13be357-8b33d60e24amr1764104185a.90.1764030873523;
        Mon, 24 Nov 2025 16:34:33 -0800 (PST)
Received: from [192.168.1.239] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295de540sm1055974285a.42.2025.11.24.16.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 16:34:33 -0800 (PST)
Message-ID: <9ec09081-28b6-4eb9-bbc0-3e48309cf063@linuxfoundation.org>
Date: Mon, 24 Nov 2025 17:34:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
 <f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
 <20251119170611.6eff8df7@gandalf.local.home>
 <b61a339e-f80f-4ecd-861e-e9bb834d5101@linuxfoundation.org>
 <20251120102526.e5e9332fcab1db3ce18c6d15@kernel.org>
 <f0774852-fe3c-4236-91b1-f38045ea26f7@linuxfoundation.org>
 <20251124153930.336ef162@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251124153930.336ef162@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 13:39, Steven Rostedt wrote:
> On Thu, 20 Nov 2025 09:40:28 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>> Thanks Shuah! This and other regression fixes is better to go
>>> through selftests tree because those are checking existing
>>> features. Maybe better to add [PATCH -selftests] or something
>>> like that?
>>>    
>>
>> Let me know which ones you would like to pick up and apply to my tree.
> 
> This one and I believe this one:
> 
>    https://lore.kernel.org/linux-trace-kernel/176295318112.431538.11780280333728368327.stgit@devnote2
> 

Both these patches are in linux-kselftest next.

thanks,
-- Shuah


