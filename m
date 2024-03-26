Return-Path: <linux-kselftest+bounces-6659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EDE88CD32
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 20:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E362E7EC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 19:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5127A13D246;
	Tue, 26 Mar 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e51ozD30"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33BD13CFB7
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481325; cv=none; b=nwBZdQA+hJ1v/9r9YLXb0WJwp28LEkV2rrcc5ZFbAXBXVcUEF2CbRYw8zAzejsH2C1gr3ROiaqUJTO3brOwX9GMtt/Bj6iJMKs9ty4QXxePICumoSTw5/G6UcWHBL3WEqVVrKX3iy9xqCn/JSMN46/PZ2zn83MG71vJ3x5mSjcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481325; c=relaxed/simple;
	bh=bZkcMY6/zNJLzXlN29HNPDWIoq+t5jSFu1zf0pMsBL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ojzu5C8yQHRBU7JlUHOvNYF5WWBVmcPCVAKFWnXFhJ3XIJ3IxE+QXar9LkSuViNfdhjO5ytaUh1smiTO/H6vfubY/njsN3M7TwRqB0GNW/22SAo7iZ+8EllDxHHLvorneJP89sXM7EuZviodOW+Evss9Xrkf1JT7WFVYewsCoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e51ozD30; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3688f1b7848so631005ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711481322; x=1712086122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMhhYxPXIMzKgR+yyLw0jVFOM6anKrGN9I2uAN6d+Fk=;
        b=e51ozD30OJfZCovJ6HgSscFQR/Y98KmDYpnKPbAxBusX+pBBH0jkj4axA8XW2iEMjj
         xy02YHeVnwgEmNOdKABpU3szi3W6hQ/ro61Nrg3GSZvVTmPqss7wbhqWVZ8UbuVmg2D0
         5fLXjbOk4WCjWjisKaHgGY1lfah5w4mJqE6Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711481322; x=1712086122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMhhYxPXIMzKgR+yyLw0jVFOM6anKrGN9I2uAN6d+Fk=;
        b=G9ibyhF7du/ZnFcp065LQIDJQtek9si3aQ5jWKjfV8AcPUbKMuAijck2jooIVpzb8z
         SO/sfHt7XTkTXeanDS4sg2KQtNzG1Hu8hBLXGaTCGw0KbkxcSbwwAW7QCjFLzy9Pn10/
         cjkl8RrtwzBmnwfxC5gtqcIdUQMu602JkfN3ohHtc+qYbN+0WghvANE5IdBrhliLZCcx
         MP3NQ/FRtnNWNi7p9MLKr13yWk62O6EaRSDCE5Cgp9u5XTtS8YOoGa19uwUKJn4SB4n8
         pr1KIYCkxqsn7BUOkW61BC46qDs73752VVFAodplULpaZnJznZsMPWByiVX1RxmOi++2
         5R/w==
X-Forwarded-Encrypted: i=1; AJvYcCVmhwk3sCceN4Mup/7ivr4NLgP/gZwu3oL2dcHvbckbZ4KasLwbvrhLSXztV+EDIXyqUd8KRVBiG6hyohllCxNbMGybdF+SZDmu2Rezjeki
X-Gm-Message-State: AOJu0Yz7yVy4E3mshyzPlOYLU5gbkeFW45cTS4oBp7WIq6oEPBp7fZF8
	eIxVpCvcvr9PsLxaxj9ORdSDgp5/ql/XZOXUnNg6VciQm1MSv4elWLhNgK5k41s=
X-Google-Smtp-Source: AGHT+IEnyweuPRPm5PTb5ibsPxuqFVolV7nuFkGFDV/A3IfSmaiOQDULXIB6KmJR5FFVRYU9w2vC4w==
X-Received: by 2002:a05:6602:88:b0:7d0:2e1b:3135 with SMTP id h8-20020a056602008800b007d02e1b3135mr10946531iob.2.1711481322581;
        Tue, 26 Mar 2024 12:28:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g19-20020a056638061300b0047530552d85sm2890801jar.141.2024.03.26.12.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 12:28:42 -0700 (PDT)
Message-ID: <0dbe701a-99c1-4606-915e-1f1c67802f64@linuxfoundation.org>
Date: Tue, 26 Mar 2024 13:28:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/harness: Prevent infinite loop due to Assert in
 FIXTURE_TEARDOWN
Content-Language: en-US
To: Shengyu Li <shengyu.li.evgeny@gmail.com>, shuah@kernel.org
Cc: luto@amacapital.net, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, wad@chromium.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240314224323.23201-1-shengyu.li.evgeny@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240314224323.23201-1-shengyu.li.evgeny@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 16:43, Shengyu Li wrote:
> This patch addresses an issue in the selftests/harness where an assertion within FIXTURE_TEARDOWN could trigger an infinite loop. The problem arises because the teardown procedure is meant to execute once, but the presence of failing assertions (ASSERT_EQ(0, 1)) leads to repeated attempts to execute teardown due to the long jump mechanism used by the harness for handling assertions.
> 
> To resolve this, the patch ensures that the teardown process runs only once, regardless of assertion outcomes, preventing the infinite loop and allowing tests to fail.
> 

Please make sure change log is formatted with 70-75 character
long lines.

Please include information on how you found this problem.

Send v2 with that change.

> Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
> ---
>   tools/testing/selftests/kselftest_harness.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 4fd735e48ee7..230d62884885 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -383,6 +383,7 @@
>   		FIXTURE_DATA(fixture_name) self; \
>   		pid_t child = 1; \
>   		int status = 0; \
> +		bool jmp = false; \
>   		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
>   		if (setjmp(_metadata->env) == 0) { \
>   			/* Use the same _metadata. */ \
> @@ -399,8 +400,10 @@
>   				_metadata->exit_code = KSFT_FAIL; \
>   			} \
>   		} \
> +		else \
> +			jmp = true; \
>   		if (child == 0) { \
> -			if (_metadata->setup_completed && !_metadata->teardown_parent) \
> +			if (_metadata->setup_completed && !_metadata->teardown_parent && !jmp) \
>   				fixture_name##_teardown(_metadata, &self, variant->data); \
>   			_exit(0); \
>   		} \

thanks,
-- Shuah

