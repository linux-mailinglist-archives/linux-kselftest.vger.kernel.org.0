Return-Path: <linux-kselftest+bounces-46018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9DC712D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4967029709
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B829301719;
	Wed, 19 Nov 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaZObKwT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED63002BD
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588667; cv=none; b=Bdqtopqz7RXxeVDeaZn9JTex4Q1vdpYDWT45FFV4pD/PsqMoOy6M/brZPrtMulNe1dgY3H7g9vTG3+jFlS7crlRYLOdiAem35M7aIjFLfI/QqHMUnQ8LRacEHu62DAWRkOnNepWjWjwU4aYTupjZlrlLeyJc0M81uXYaSKgOOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588667; c=relaxed/simple;
	bh=wAWPerYA174M4j9byJCSFLMsKyW5NX85WcFSUMI8ETk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJUFGCoNZLZ/wLxVa1aY6dwfyVhWmbKKVO/NpfQp4LKuzIHiVq9DSZWZPvNEhNuPMn3Q+q94zahSy0IIPtgxJRUnrxL53T9UbKLzNCPGzq5Er+PBT6bhpoVnyzwTdFdPXu0ZrNNINUJXkkjLBK2HooemG5WFj95aLE7dvcLTtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaZObKwT; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-9491ba846b2so8121539f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763588664; x=1764193464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzlXhKld4nT0xL82yzn50M+W55+QbiWaolCWYFDzktY=;
        b=PaZObKwTabxWASocyEhxxg7gUxqtsZEf+i64JBSFw/dMY9LCheCySmew+ECflQxTBZ
         +S+h6uWFaPB6YZfUhs3FthI0bdqku3e+uJkVnxKnLaWGa5vxXVTCOPG3HkXO5dqIMcIM
         bG0kdhX8NdA4vkaz/CDke3L6kXRnRcro85e7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588664; x=1764193464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzlXhKld4nT0xL82yzn50M+W55+QbiWaolCWYFDzktY=;
        b=CoQet9iM+tuYzIfYh8wi0T1EwKy9G9eklqv+Cgu+QxvbgeFDt2rgCjyn5N3KOwYQ7Y
         LLTo7qsolW+WlDBhreoxyaBlALEslz0wp5VNj6XKuPAqvkKmOJFLgyvuT68cD6g/YEDq
         7pMzK4AaLHnfCDHHruv7APB4hEuh1rnmc4tUa92Y5ktXDXhhjpKoRm+3BoA33zAt1g0a
         IGb8jeOtqg5McCh5HBCZSCquOzSOMgcRUOOdLBfqYgjVijRIPO1t6z9P1+jT+tC2RlPH
         oXYDqYWn2HJJ1YOFYVhcCdg8nb7bRUinZ77zHSPzt6yDzH8GXnwQ37vxPB29LIsz1ZN2
         sbFg==
X-Forwarded-Encrypted: i=1; AJvYcCXEsBZTBq3Ab1Fcir80ZAIk0EyfXXb2im6IckSjrXwWLMZDBxXCoPkjjwFm5RO2nHW68tMDqbcnjASKmG9vZq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCFLJq7J/jULG0LzbTT1MoCK8yuSs0sSoQmNJoB5M/CCVMEHb
	f9BfiF93OwAgIhrd7dN1kMO20i/vTjRmI7QhdIwSJzu1mtoiwkhQuPIAMh/cQROZMwM=
X-Gm-Gg: ASbGncsBl+TNUu8YVbSl6Dv9y4ww3hQov61MjmzP+dfDbVXOUCWWCDF2EB3qEJAYim0
	0tWBRkVThIPn48HuSbmJEitne3VV6jEtLIXXQyv/frZO3N7P6HZFxDUAobrJ1qgdfi52igLtV7L
	hqb7LsSjWnrUc1I12WLOMwGYl8jZVuUl5nh7KEtoHlj9XBDGBFdCj7IBq2KYOtz1b7tNv2RUpYB
	WCpEbIk/gJpVEBsEeT0N9M3xznk//EYhiXZ12Zu2/B/yLvJrUG/zpuBKbpX5H0nGD5pkKOWbBzG
	qeuVAVGHd3RXy4yu13UbIqXR5knPpVnmbXJ9SngRXsQvRQrJUrHK9fDHwASnbjUZFtn96qYepjK
	8jr0wQ+kybX1ZQ2AW7lRTkKzbU61DDw0bUpd3om8w47DkGZihm7gjvXyxDMvmej/I8R1Ti0r0PO
	ol5l/AEmKUocejAcut6A4xFX0+OQKopJ14Dg==
X-Google-Smtp-Source: AGHT+IEYqeylwrGRDCIwfcCgECknaWrcBPocfi4nhpOHNSC1ufLbnIci76b9Bf4WGIE5CVi73ijqlw==
X-Received: by 2002:a05:6638:292a:b0:5b7:b997:ffce with SMTP id 8926c6da1cb9f-5b954043c72mr566133173.10.1763588664058;
        Wed, 19 Nov 2025 13:44:24 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b207d7sm172340173.33.2025.11.19.13.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 13:44:23 -0800 (PST)
Message-ID: <f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
Date: Wed, 19 Nov 2025 14:44:22 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <176252610176.214996.3978515319000806265.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 07:35, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Commit 2867495dea86 ("tracing: tprobe-events: Register tracepoint when
> enable tprobe event") caused regression bug and tprobe did not work.
> To prevent similar problems, add a testcase which enables/disables a
> tprobe and check the results.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Steve, do you want me to take this through my tree?

thanks,
-- Shuah

