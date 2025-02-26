Return-Path: <linux-kselftest+bounces-27657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2810A46CC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2063AFA23
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055942505B0;
	Wed, 26 Feb 2025 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cv3MOR7P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0A244E8C
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603361; cv=none; b=W1nPOnzgXvJZzgjHt8WARr50gT/7botARNmSzlGb7f56bbxWx2RFjQiHUnekJzAXJujKFRMDc0pi13CdJERXIz/NM0nHilWOHrok6VX2YLnMZzz75HbG4tsMJRp5KPISOZtJj4UWH53A3zWw/gjyyguNlyyWkWxE4WY7z5vk1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603361; c=relaxed/simple;
	bh=mqYzICldJl61KdyHfxq8I6OeV9x311OW0csxdK20FtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH09v5x2Fr4luvs67nBHDmYCLLW0CS3mTNYvnm1QtpXNDOEZyLvBAIbOvS025OnpGnW7im1PVzbJRRwPgVM4FGP1B4JxndxBpQPU82b6lqA/2/ZPglinG4VH+sLXDnCV+sVplM8vSx5kGcrbPmcIzMo8Dd1hLUaZhnVa2I8Ndj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cv3MOR7P; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-855c122b3e7so16414939f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 12:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740603359; x=1741208159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACXceot6so0qEECSDnrDchyxYrTH5BMNjPgKlk4vqYE=;
        b=Cv3MOR7PfOlBCHo3kE3GZlSf4noqQpj3XAbOflR+DpQjGZAZrsPbajaNp1sPREKfny
         nUZ2l84GiLiptGORPyxWvYXwF5dNwWBzSYPRkWK6QGrhCVvkNYgylNZCLT87d30Fi+Mm
         Uat7XL9Lmj/mu2/22Ekg4F3oV8EcinwsAt7gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740603359; x=1741208159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACXceot6so0qEECSDnrDchyxYrTH5BMNjPgKlk4vqYE=;
        b=PfozIM2cGwMSQyhBB5ba3a6hh/Hqjhze/sCwlWkX9zY71kwWwgSGorCKkMfndscF5s
         ZAZp0uz87Tg0YGo2A3eu+WjYrolvioP2mcW36PV+sPKwCe6QIEtV1ZOEIvK8+UsDyXAS
         06IhuqbJ4HOnnMRjjGTGW1Vtjom9N1fbDAVdiAdPla4FsF8p1i8g1+nBV8EWjGboYRzA
         9wyovmxgxKRjyIGYXtI/6wi60eLii77IdSb55RN8dhrQ6CMOuq4gyuUNa58i8vK6ZKnX
         v80l0r9arYFUOUX7cr9p93EvM0pnfayUezc+ptw59xxweRl310lyS1sz4r+tWi7yMqu+
         DuVA==
X-Forwarded-Encrypted: i=1; AJvYcCWNE0umg4qSU28Sx31QvwdXIDrG6QFuiydCgU0YHHl67iTm7fpcwgwrPcOZMfEuzeIoobw+nf0DZhmXHfdIYPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqm+ZVRBzDfcgrpM+mfMN2d1ulOD0I7eXkKgH/1ANRrLPF6N5+
	UVgGfIVygJlEOFq0RqIWYhUpKiXYcrUeBU3ooTggnUxPh0P4gQfOeNaIc26PwlU=
X-Gm-Gg: ASbGnctILrKWbI2ID/zexAQ+/y4RgACvbbG4ARxcscBRXHg7j2ubjs6fOv9d3HqWpn7
	VEoF2qAapGX92QWuo0PD/TXf/tU1Jisj+ClaIvIaDj8MAIrx44P94RxaOcsFQGfUcOS/DW51za0
	+YWQqJQxKmX9pZ1lDWGxC+tykTsFuzxVJm37kgq7kaOINzaAzo8SBCL+YXpeF7v1mPRNTVV/K5k
	oRosVag1soFqNUpbBK6O0+DUO8Y7ZFQkNr9ffFJi+ZWXX2lDvjaXnSRniQztXRQtTV/ZQ9+SQB6
	VqkhGEx9Tahn576XyBU2cr8AgU+qpqBQVjE/
X-Google-Smtp-Source: AGHT+IEdrq2nDcrlokLWu5B99Vt7XXGUTSjVaYnvuG/TeLYt4skaR2JoYGjFSX/j14RH9VpA4xleeA==
X-Received: by 2002:a05:6602:3d0:b0:855:c980:6eb4 with SMTP id ca18e2360f4ac-855dabd790cmr2360259239f.1.1740603359298;
        Wed, 26 Feb 2025 12:55:59 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f3905fsm21244173.88.2025.02.26.12.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 12:55:58 -0800 (PST)
Message-ID: <04c7f895-d587-4023-9fdf-60085c329ff3@linuxfoundation.org>
Date: Wed, 26 Feb 2025 13:55:58 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Use readelf to find entry point in
 uprobe test
To: Steven Rostedt <rostedt@goodmis.org>, Heiko Carstens <hca@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250220130102.2079179-1-hca@linux.ibm.com>
 <20250226121316.7653ae38@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250226121316.7653ae38@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 10:13, Steven Rostedt wrote:
> On Thu, 20 Feb 2025 14:01:02 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
>> The uprobe events test fails on s390, but also on x86 (Fedora 41). The
>> problem appears to be that there is an assumption that adding a uprobe to
>> the beginning of the executable mapping of /bin/sh is sufficient to trigger
>> a uprobe event when /bin/sh is executed.
>>
>> This assumption is not necessarily true. Therefore use "readelf -h" to find
>> the entry point address of /bin/sh and use this address when adding the
>> uprobe event.
>>
>> This adds a dependency to readelf which is not always installed. Therefore
>> add a check and exit with exit_unresolved if it is not installed.
>>
>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Can you take this in your tree?
> 
> -- Steve

Applied to linux_kselftest next for Linux 6.15-rc1.

thanks,
-- Shuah

