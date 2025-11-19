Return-Path: <linux-kselftest+bounces-46027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EFAC7164E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 23:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88496349193
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF0307AD3;
	Wed, 19 Nov 2025 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S92gXX6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47E2512FF
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593021; cv=none; b=RicpF+nmcBKvyoW7Kw4ZxCsc8GrFx3E8o4EKfxhqTgwqGug93MyXe5AjugLWvuRaxy+Zu0i/+UdiM6DKdFAHQTb7Vmnbt61PzJLGHZ8A3ZS5kUCsIr20kAmHBjhncG+elQg6tleB9mtlL8WBk6HHotGhZqkIQnO+4L91UHVjv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593021; c=relaxed/simple;
	bh=yOCbSOXUcf42hI7Et0TY2otuu3AGTL7xxB5sc17Aou8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMNbLMmE7dhfugW7eolbde9FVOdgbcLRsbmNx1z90MlODEJzIOgiso8V8ve6K2DTulkNXqB6gP9jrxvdPr9Co+wbJQcoPAO3XUwFb1OY7IsNHcNzjE58a/jhRXdEVCHwwbkRU8wS2Vw3vaPAg8gNIDjRbrn9XMdZGIU67CGb8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S92gXX6p; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-43376624a8fso1847715ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 14:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763593018; x=1764197818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9Cihjz4mIMaTQdMejOmpXxdqpfNp4ZNHdlB1PDzoK8=;
        b=S92gXX6pxAQBeagLbG3zFH8hEM2F5YtHeVvGCQT13Ri+OdtVfNlS67Wo1mgTHsY8iQ
         OPEjX6pVj1bTMjH4xZnx3XYXHCIrwYvbLXoDEzMWZVJe2U5ugqjBj9gn2N4hnLz0Gc+S
         mtjAM0A1q4Zqi2RMw6I3/yI0LIgEunrYnljb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593018; x=1764197818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9Cihjz4mIMaTQdMejOmpXxdqpfNp4ZNHdlB1PDzoK8=;
        b=r2VcBEspoD0v3gSpu/K8tBTLkHWHmpV9IlZhuNhxDDFFCEjQpJUjZ1n5V+GlZNZ1aB
         DI7BwOfdrg1zZuBDiBX5rKVbX+iyPpcUnXpj8ahICtsFugYq/SVyQ1EKtO+FfKALHg73
         SyRS777hj6PueAg69wgT8iym/60v/MYXjNGrNwPNTxj0Fth957DRH/dA4pnZxFCA410m
         ey6dKU70D9aLlGKleVJSW/ijVo9Dsy7cdhJBnItBOmqLa3uWRaoFf52x2jPVskzl+91g
         Xtm+wK9OUstRGPYGnETsNYmY44c8FpszT4TVnJ+0TQMA4IvQnV0Lg8cfdP8Rj6uDnmMw
         81MA==
X-Forwarded-Encrypted: i=1; AJvYcCUadPUVUo+J2aqpd8jpAvXZgOdEwAky1Pkw/cNQ6YGr+LErZWDxTW/T8Ep9Pt6/KVAQLDpBwInI30Y5VWKQcXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3YMdAvulK4wQ8Nw+pUvIrZpVMhYLfwoMBq/XyY00Y7K3iLdG
	DVEJeN7irce7TvJ9epy6vh026WQQfTHjWBK49W7PGuaJhmQzLpuv4k6235G/CgT4jnY=
X-Gm-Gg: ASbGncuTURnwa7ELZ2wqMdH9T2e0bbQ1iOW1pwFAr85sRTgO9dbvsS5U7BGB1nfoaBw
	WFHG9ysN8XdZDNwzp8uGW6qWcS6es/HTOOJ3c+36ipxG7pcF2zpYNK7TQPLCTZg6xuFcvfSK+d7
	aoqF7uiY9PBQvidYs7eZWXWUhmoBDq/ufEg3YkmjcPG3R6yLPJSGuxYkuAjGFzyB3VRrp66a5ES
	qZTqT1DtWa/LyEJ/lg++ETpBwJ9hv+Pj6MkVZMY6/C+GHw6GAQGpZOTw5/8vRN1T+mV35qcRiUA
	vmL5oM+cx0U53XniuUnlQJXcdYsbN5jCfGJ4KC5ifge33SOpJB4r0qgMhY6PqH/zcIqIFRGt4Iz
	dEvOYZ6K1QpkKsHNKUyuXGDjgdgAttJdwdvDUCVF8+Z5R+Rd6Y0//tC/o+u5kXoDCgsImqPbjuB
	C9g5eBbEDdTHb5Sudr3MyIEaU=
X-Google-Smtp-Source: AGHT+IF0n9luN6uLPUD0+qtd91vv8ozpZWFR5sEp2+lnlFuJPZGmT1NL1+Q7O5k6hfud7//ALyWKHw==
X-Received: by 2002:a05:6e02:156d:b0:433:7310:f5bf with SMTP id e9e14a558f8ab-435a9077da8mr13911545ab.22.1763593018248;
        Wed, 19 Nov 2025 14:56:58 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90e707dsm3627275ab.30.2025.11.19.14.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:56:57 -0800 (PST)
Message-ID: <b61a339e-f80f-4ecd-861e-e9bb834d5101@linuxfoundation.org>
Date: Wed, 19 Nov 2025 15:56:57 -0700
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251119170611.6eff8df7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 15:06, Steven Rostedt wrote:
> On Wed, 19 Nov 2025 14:44:22 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 11/7/25 07:35, Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Commit 2867495dea86 ("tracing: tprobe-events: Register tracepoint when
>>> enable tprobe event") caused regression bug and tprobe did not work.
>>> To prevent similar problems, add a testcase which enables/disables a
>>> tprobe and check the results.
>>>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Steve, do you want me to take this through my tree?
> 
> Yes please. Masami's an official maintainer and mostly handles all things
> "probe" related. This is his domain ;-)
> 
> Thanks,
> 
> -- Steve
Applied to linux-kselftest next for Linux 6.19-rc1.

thanks,
-- Shuah

