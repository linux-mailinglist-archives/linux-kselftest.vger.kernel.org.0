Return-Path: <linux-kselftest+bounces-15314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57728951A55
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 13:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181072854A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C521AED48;
	Wed, 14 Aug 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YS7Fsndh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B16513D881
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635819; cv=none; b=LcyRTqwaBOu3yb89W3mpLuspHG0R8ph8prkb37AMksetzBu4nhSHwM2tHb9uI6HwGgOMaoxM849bPDhrpUsf26oZM6ks3BYW5nY3SS4slLPq9hZ/RmJpf8QPYx54o81NCRxav0L49sj6NpAAZ4v/anpeRhboT+YZ3odQAYYra5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635819; c=relaxed/simple;
	bh=TB/0oHN5F5NutnVQ1VWFaykvrUJTjk/6Yb5WW2uT8gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6EHXovdmKFkxP/P8rDftfLWEAC9Z85Yqlm5vZA7Yh1a8r4uoMQophNr7KwcNMQeKth9SSd/rFgEU0BaI5zhfDCy+ozbHxlcZx56dks4kLog/cpfOKUgelGuLug00wQMrv6Pxf1RBi7hnhrpfIMAWp6EIAUjEZ7Y2cNbxLrques=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YS7Fsndh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc71a8a340so3197235ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723635817; x=1724240617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u39ng7G3Zk1YPobD4C5U+D2PWpoaCE9N8Zqv41C64w4=;
        b=YS7FsndhK3EA4mr8eYrQXKght7/mm7PlXOgK65uRhsCrJTwqvThQpT0NLfWZqq8bAM
         lAL02hd4nhN+xCoYFsMeJO+4H8qyd4uB9ao62kda0Om6X9bn3Prw2zQItOBB2cWq1wEZ
         MzFba5s4CVBm/fjDxz/kWKl41EMoM/bX3jcdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635817; x=1724240617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u39ng7G3Zk1YPobD4C5U+D2PWpoaCE9N8Zqv41C64w4=;
        b=T/RKVjw+M4sYTTJNQr9jBcgIawch6SHZN6lvRZjId6wgoNiU9I/kLugZA94zO5llCk
         yq5gC1rN0aV7iWKZ7MYYl+GR72tLqUPtsNHxGXMZ1XZjIwUlLv13mmrY1EMie5nxU/+Z
         /kMCOzoSCzcyTUKq4j2reky2HQJs3vN3IRAGkljracI4EviwQlO7EQjO6Io0Ku1kOmMx
         DUl+mGxgsPNMsteEmwTe1P++bImVP+xHh2gB2MoAxNY3fB3ZHz0yCtg5XPVUsu+mLfWr
         hxIh5FLfaAs4DLh3qYhUhRO0E6OXvgKYniN9H4zR0secOKykhNlcLljq5gJ6pFp/07sW
         xVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUagAe+LdjmLvRVaSu3hve1Sn50Dh3ALPwpaHnpO6XcZHsytHojiMhOmybxYWnJrAzKgzBT6bEaJQxKsXUJ3B5f+1sXoRLHN6Z8i1TH2Kss
X-Gm-Message-State: AOJu0YwPsBE+IPD8g/i6BpP0tsmNihx5pj7wwp9qJo+e0gwQTIGgN9bA
	AOo9wXR33hMB8nBTTj5k5IVbTEitcyY6ziIZVDYkb/Kn4VPqYnTJ1EiNsOWcnIg=
X-Google-Smtp-Source: AGHT+IEz4zBtaa0fPbf9nGtUh5Q7nwM6G4j1+p2RsMPWqPZhHyGalhtvg6CVchZywIYfMtCQ354e6w==
X-Received: by 2002:a17:902:f0cc:b0:1fb:1ff1:89d2 with SMTP id d9443c01a7336-201d647f0f5mr17105525ad.6.1723635816658;
        Wed, 14 Aug 2024 04:43:36 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.51.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a93e2sm28176755ad.141.2024.08.14.04.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 04:43:36 -0700 (PDT)
Message-ID: <9016df04-041b-4837-9590-1c5159609826@linuxfoundation.org>
Date: Wed, 14 Aug 2024 05:43:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Add required dependency for kprobe
 tests
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <171823033048.152840.662759412433336839.stgit@devnote2>
 <20240814095323.c8458e2cb6031c3014a7b7e0@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240814095323.c8458e2cb6031c3014a7b7e0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 18:53, Masami Hiramatsu (Google) wrote:
> Hi Shuah,
> 
> Can you pick this? I confirmed this can be applied on v6.11-rc3.
> 
> 
> 
> On Thu, 13 Jun 2024 07:12:10 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> kprobe_args_{char,string}.tc are using available_filter_functions file
>> which is provided by function tracer. Thus if function tracer is disabled,
>> these tests are failed on recent kernels because tracefs_create_dir is
>> not raised events by adding a dynamic event.
>> Add available_filter_functions to requires line.
>>
>> Fixes: 7c1130ea5cae ("test: ftrace: Fix kprobe test for eventfs")
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah

