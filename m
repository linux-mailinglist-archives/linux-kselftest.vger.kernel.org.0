Return-Path: <linux-kselftest+bounces-17645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC59742A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7D41C25FFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0231A4B6E;
	Tue, 10 Sep 2024 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Za3Zw2O/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90131A0AFE
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994202; cv=none; b=pAMsuVOYgyu6jHJEiijaVoK/fOTWfevV4E5BajobRw5a9QkcsSnVs84gYPxJ9+gRE8KhIAkkHFw+GGtofYMvvYKY/V3sQ2AsPASWOQbOSjjB02a/Io4tMMiy2VzU/JqMeX1aR170P+CzFe++Z7Kpzzmx/OBJE1aHzTybTQj4fsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994202; c=relaxed/simple;
	bh=1WdMvYdJoPmD9mMn4XDK4ijpAdELRzGHP0yEkPBv5wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BplqmF0j3Vn0EWzw8voAcfYqmIaU8C2+p6YZFBkVE91ZgDU2ZdSKYKvhDRVok1qYIVJjB3uo/oXzJnZU48ibV4cZqNPFNitsiqAqfNCkkPm83m+NiaBR9z6PHvod+PAPT9bC/gz5Fd5d/zeAdbvdfXgMfeoafyjO6lj67kwcKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Za3Zw2O/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d3872e542so24545765ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725994200; x=1726599000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+vWHNEoY3B8gMdhj87TmXWauc6HpmVdxTpzf/fN/+s=;
        b=Za3Zw2O/E5jIz0wAMgerVheBc3eec31Pk03gZP7HxHYJl61Ya0KTkDIlkxIXrtdYvM
         q7INNxAhBFvvCC1kCnP4MQHA6LzOlI6ysHdt3FNqPVNxBihaRGbzmeAQWofwMNV3qEGG
         E0dZsNiMbo4KBJKsfxwSqnJjhviJHQjHwwj8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994200; x=1726599000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+vWHNEoY3B8gMdhj87TmXWauc6HpmVdxTpzf/fN/+s=;
        b=bs0+1kzgppA8Gg8rfhdCPuYrdaz8v4YyCvwsd20Dd+vXDMD1gQYJNg8wWwLgtyTuq4
         PbstZaqWl5m0Z4bbdkXx5H5Cnmod9s8j91DHz7XiYUR63CxEQ6E5YGOEZRXg9MUOg334
         MzLctddOODF4/8EIX3ex1PPhlBaNE9DlOdUkefSRN7jXUvKzkcszxSmVbtAAjL7HGLq4
         PPPHmqu27f6eNG+1sU2m0VHCnBqSJ8DX0V0rfSj8A8MbXiDoIkHvpxfoiYiJEQhNoy5y
         kPMHFt1TvkXdkjEzv5W38gl2ubr7Ioq7RgiQID9wSVmmjfihyk62IpqaTuCGJ9CU4q3q
         QHyg==
X-Forwarded-Encrypted: i=1; AJvYcCWWDn5KKSCrsgn0z3r/9WUrZF54X56oyJ22x3gfqNOUBZ4O9a908N+AcxXAomORtqS9qRwJDOH9rBRIxXZQarY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVswGNDBoNH2OYAKvuGEBvHGZsHh5LwRbt0ft+KTG0e8vqPCg+
	WJFEe8Dm4UWa5ryn3XDXJtgqxW62mlg5wNmcVAcHqJiw8lI8uyZ+f0vrOttgSck=
X-Google-Smtp-Source: AGHT+IFkNN43djyLVohLaa+NqGwq6sV8jRgTpy0ojuQ+SqlTmPROviO2CjKjQ87t96vGQGvibwVnLA==
X-Received: by 2002:a92:cdad:0:b0:3a0:4250:165f with SMTP id e9e14a558f8ab-3a04efe9f61mr180725555ab.0.1725994199798;
        Tue, 10 Sep 2024 11:49:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fe56dasm21533775ab.52.2024.09.10.11.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:49:59 -0700 (PDT)
Message-ID: <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>
Date: Tue, 10 Sep 2024 12:49:58 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-2-vdonnefort@google.com>
 <20240910124541.23426cee@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910124541.23426cee@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 10:45, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your tree?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I can take this through my tree.

> 
> -- Steve
> 
> 
> On Tue, 10 Sep 2024 17:23:34 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> Improve the ring-buffer meta-page test coverage by checking for the
>> entire padding region to be 0 instead of just looking at the first 4
>> bytes.
>>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Vincent,

Can you please rebase these on linux-kselftest next branch and
resend.  This patch doesn't apply.

Also please fix the subject to say:

selfttests/ring-buffer

