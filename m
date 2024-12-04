Return-Path: <linux-kselftest+bounces-22846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFAD9E4873
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 00:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E759918805C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 23:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6530202C23;
	Wed,  4 Dec 2024 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DwDr+qJu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109A199FA4
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353778; cv=none; b=fqSQ3W5n/31/d8j6XaDabQ8NH8/joe6EOLJFTEZ4mXg/LJ1CBhSIO4LpnLtm174E1V4pADVr+RrD247qSmq2IN7+CvMY9K/UJBTrGtptKVAzz8HSzJVMOkidlbidAdoFQibDEcK51AUT70y7QaTzXqw4RA7P6pM/6X5y09SRlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353778; c=relaxed/simple;
	bh=mX5Dpi9lci8fk0roEtn2l+quUiwC4km4vuseSGgZMzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nz0U9C4Hvl9UDSq3OvZk8KL1rYUo1g/9Q0xwiADWVR8vPoqVW9Lf3xwWjZcDCarBF+4R7I7Yr/bRDcUj0MexFBFoJnYNxhOJjVzEqF031CT4VVP/44jgbTG2oZHQwtudzi82C0sgWij368yo/uJMqzoViWLw4J1SegZm0ynI+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DwDr+qJu; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-84197c469cfso9244339f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733353775; x=1733958575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zG9sPFZ3lc53iEuZRNZuzndtXvQfaZ5rgBE1zYogWs0=;
        b=DwDr+qJuYh22yg9i+hDj26JWGjguQsGnjZmEZj1HBXmNqDTvURRl/dny4VF2P5NRrm
         zW7Y3V895NtUlpQ36+jr4CSeV82g2EtgNdMH8YLRySthKkfpGdsqpyH7MNrQJoEJSOR/
         q4i528dmX5qBdR7ykMFq7O5kkNkelc7qFdh84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353775; x=1733958575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zG9sPFZ3lc53iEuZRNZuzndtXvQfaZ5rgBE1zYogWs0=;
        b=is9S/+yOsC/+P18e8hngfrAXHee6/VSe8vt6VqZWYuSal6JQXGCj4l9t5xQhW+XFQj
         Hj0TW5dddJrsnUZ+ONGh/yPZJFTUzw/9HnqfnRqA4mf/VfPa7jS9PhDJlaAw1XrrUQXa
         5QmH0nhGQjdrTI3AX5VrAhA7j/n2dJzc5si2zaZwU6qalPuG1A7Zhu4Qqy4uv0IbFS7q
         6NIO4dJGACzKL06OEL0UraUntr1gBZjiX3biEl1V9nVaSHH/g7KClb+SalvnxOHr05k/
         Wu/46NVfy+Iegy10c70YjXAeDMneZFCwpUuB8oWtIMw7X+gt44CKexh5DIsVwaT+bqt9
         /5mg==
X-Gm-Message-State: AOJu0Yy1TMiEaTeohU/n4KgG0hJVPIrG3zP+qfXt25ohv0tLtCsfF0ms
	UQQb2upiYS7qByG7kp7rQ06TKqwbw7woMbdYF3VNnhPU2Y6IzpM2PqQIOCwE5sk=
X-Gm-Gg: ASbGncuwNtX3rQFCKcLfsQRn9MPyF7EN59gRaLrn75eHn/uK5UCcZQU0w8c9m21SriY
	ZcYHvn8VtUw64oDd6jkExIGtsnc7YK9NSAHt39BVbF6G0dPJ+hf/GJws2jvxcrnQPxuuEX57Xde
	tlcauXYG9RPE7//Qb9CsUCQlGr2WQSFjoE8fe66KvLxkyToaxTM2xc2hDW+cRwgrmkihp7r87sg
	KLeIUAdAX+g1OBNxn/woxfjoPWJrz8KFfsEtTMZExUbcm+xBW7uDApHyvkITQ==
X-Google-Smtp-Source: AGHT+IGepD83OM2bcq0bSlzzdW/jDr4a/qekrJmRwydDd1klNStH8Eh76Da2OCqAz2I8Fb3YfBXABw==
X-Received: by 2002:a05:6602:29c8:b0:842:ff2d:c3d2 with SMTP id ca18e2360f4ac-8445b5745fbmr998050039f.9.1733353774975;
        Wed, 04 Dec 2024 15:09:34 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844738d70e1sm2354039f.20.2024.12.04.15.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 15:09:34 -0800 (PST)
Message-ID: <ec142501-1459-4fcb-94d6-b26290ce107c@linuxfoundation.org>
Date: Wed, 4 Dec 2024 16:09:33 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/timens: Add fclose(proc) to prevent memory
 leaks
To: liujing <liujing@cmss.chinamobile.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241128060512.3948-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241128060512.3948-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 23:05, liujing wrote:
> If fopen succeeds, the fscanf function is called to read the data.
> Regardless of whether fscanf is successful, you need to run
> fclose(proc) to prevent memory leaks.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
> index 1833ca97eb24..e47844a73c31 100644
> --- a/tools/testing/selftests/timens/procfs.c
> +++ b/tools/testing/selftests/timens/procfs.c
> @@ -79,9 +79,11 @@ static int read_proc_uptime(struct timespec *uptime)
>   	if (fscanf(proc, "%lu.%02lu", &up_sec, &up_nsec) != 2) {
>   		if (errno) {
>   			pr_perror("fscanf");
> +			fclose(proc);
>   			return -errno;
>   		}
>   		pr_err("failed to parse /proc/uptime");
> +		fclose(proc);
>   		return -1;
>   	}
>   	fclose(proc);

How did you find this problem? This file will be closed when
test exits? What does strace show you?

thanks,
-- Shuah



