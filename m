Return-Path: <linux-kselftest+bounces-6657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A3A88CCE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 20:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9682EB243CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224A013CF8A;
	Tue, 26 Mar 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFKwvYbt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276E13CC6F
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480630; cv=none; b=eKomicvJM0+HdiEGgjuApx7+tUDGKYl0kfrvj0qz2vAP98nfZwTI3TdqsTYlIkiZn/4bYzvcG/h4lvAkhx17X6KW3ISs1rlVhTyntnsCGWjW503/9Jayxc53gGRUUhkBhc6C1rOIJDmI3XzvtCErx3cgg3S/Q4RRvNj7qL1nw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480630; c=relaxed/simple;
	bh=d5oiFHuXdlxBu9o91T6TmgxwTU7ItEYzvBVBFxokMdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1+MVxhvhehu9xHt5+e7vacRDs94/eqB+L9tpH+gEvgpAfheDROOlKDhVZ4fe4M2z8x/tCiLOZPzyhshvpG226c4Gh2XlEU8g2ohF24PCB76wupa9R7khsAEAgCPqtkAgw+Fzavkya++GzGh9NBrdVoJUzpo+8ycgIWe+Ou4M4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFKwvYbt; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3688dcc5055so419985ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711480627; x=1712085427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAgAdxoAWBggRCLmNhHzURpQUXyex1VS2og6I0eJHg4=;
        b=SFKwvYbtiHIg9dmQJc36AJa97p5dNiJUIsXe5/J5phY0QkI7AJnz8O3z5wd+tvllSi
         N32lGwd03I0cGdX+rcHl5v8303HpKd3q6eNfB8cYd9S5FMEesU9Gz//SnBjj8fGgsn+g
         5gkU+fqUlbk2BUeZ1kqbkW1AfNjWyqIqfUFno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480627; x=1712085427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAgAdxoAWBggRCLmNhHzURpQUXyex1VS2og6I0eJHg4=;
        b=GkEIKLQ78AcT/bLbyIitojGDdH+DYpzzswTUa47dZkLvOfn1eZkdWfDcaBI/OkirTy
         2hT6u7lEm7ytM4GzzNt+YwJlLScEhq20jlM+ACizATgutZ5aZeRmYmmIf8K1BL7WiM0Q
         jboFpDLCX9gL15HkXpGNMnYLlEUSb6L68yXr5GDKEiOJzh3ZwyFaDKHmjsAlOug1Uy2t
         IL1SqcJXYhwUABrw42eohaUte+H+qINQ7Gf1WJo6VtRouK0j3r5JIus3ueOKzbHtiSHo
         gp5XoMbCUIg6jSQABYC7skM6oK122mAIbGn2kWsvLKOvPWFqa671KyBEORRMVYKKmg8u
         D8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWozPOBexwPPUpsz3w7DV/yXjxjMMfRYr8Idb9N8iDoie3bICsNPlPWfqyyb4r09A241dEZUsfF/TI2XbaOvbGS4jRgfwP0sMUkgvVmJFXU
X-Gm-Message-State: AOJu0YyabKu/Up7vKJzmlcTUvRGNAm+aKMO18FUKnBYMuChYtEEr31pF
	WVkLtMKpSvttPdQlYcJ0fWJwkLtYhqYS7kqfMbNHnnNcw26uzoimsC3Fyzv7lJw=
X-Google-Smtp-Source: AGHT+IERj3hrIyDnCZJ5UcMAXz2os4t+ojmXAKvLHG/6knoGZCHVaoWkXymnVBqCdt4RsIW8XSrQPw==
X-Received: by 2002:a92:c9c6:0:b0:368:80b8:36fa with SMTP id k6-20020a92c9c6000000b0036880b836famr8573443ilq.2.1711480627401;
        Tue, 26 Mar 2024 12:17:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m18-20020a92c532000000b00368984422e1sm927267ili.23.2024.03.26.12.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 12:17:07 -0700 (PDT)
Message-ID: <0cee99af-f058-47a0-9119-94cc9a37e88b@linuxfoundation.org>
Date: Tue, 26 Mar 2024 13:17:06 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest/clone3: Make test names for set_tid test
 stable
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325-kselftest-clone3-set-tid-v3-1-6fdd91506e53@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325-kselftest-clone3-set-tid-v3-1-6fdd91506e53@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 08:29, Mark Brown wrote:
> The test results reported for the clone3_set_tid tests interact poorly with
> automation for running kselftest since the reported test names include TIDs
> dynamically allocated at runtime. A lot of automation for running kselftest
> will compare runs by looking at the test name to identify if the same test
> is being run so changing names make it look like the testsuite has been
> updated to include new tests. This makes the results display less clearly
> and breaks cases like bisection.
> 
> Address this by providing a brief description of the tests and logging that
> along with the stable parameters for the test currently logged. The TIDs
> are already logged separately in existing logging except for the final test
> which has a new log message added. We also tweak the formatting of the
> logging of expected/actual values for clarity.
> 
> There are still issues with the logging of skipped tests (many are simply
> not logged at all when skipped and all are logged with different names) but
> these are less disruptive since the skips are all based on not being run as
> root, a condition likely to be stable for a given test system.
> 
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v3:
> - Rebase onto v6.9-rc1.
> - This is the second release I've posted this for with no changes or
>    review comments.
> - Link to v2: https://lore.kernel.org/r/20240122-kselftest-clone3-set-tid-v2-1-72af5d7dbae8@kernel.org
> 

Thank you for patience. Applied now to linux-kselftest fixes for
next rc.

thanks,
-- Shuah


