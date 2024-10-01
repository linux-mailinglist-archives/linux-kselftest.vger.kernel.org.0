Return-Path: <linux-kselftest+bounces-18757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD798C154
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF4B1F233D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A02A1C9EB3;
	Tue,  1 Oct 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P9RaiR6X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C541C9EA3
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795694; cv=none; b=LdMrr3JNWderzf6rBnFIcKyCJurQA5q4e6GRPoIjqG612lT23Bgnl0bISDYjvs2ShQkiLj4ryV3UDZ1sQBM2ztwaOwKYdrujJ6Y/SV5tLh3KNgUrJu52Xtw2eQeMU4DfkvEIDTuWWOqpEYOR4hoZqfsLi9dbRffj0ht9foPN8ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795694; c=relaxed/simple;
	bh=vGfztZfGRFWc4NBs1quyq8Qr4M8gtUs6U3u8lP4FNeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbSdhRYUyoHYBmEdR7mbMSo1bEfQzeMf/vS/njL6u/kxRBA+k9Kbo26LoiO9+nNUCeOwOpDIGToDqHX953lbwsJ/UfjudWE1xWvQSxepfzBhUOcg1dcJ4jcQEB+2c+4jX4HaL1cRBKUgdH9IlKmbkNli71lzB8JPR+sLaBPGuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P9RaiR6X; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3525ba6aaso8902435ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727795691; x=1728400491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKqi6XAaCDK4ylDvOJNyWgR8U3btYX9UaPK/lnzXIXY=;
        b=P9RaiR6XixRGUHqE6aOSlXaS0ZB5mEnnE2GTOxtd8U+rKL5soSEa7lX/xsCNo0LDXy
         SZEfWWzq9mNYElr/OJL0RgRAHyPZZ/gfNmcv0Kq7uyZrYTTa1MRSPapbeeq0LCpCViXq
         gnGudGV/92wN0o0E6qwuz3Ae37xazpz1nXk7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795691; x=1728400491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKqi6XAaCDK4ylDvOJNyWgR8U3btYX9UaPK/lnzXIXY=;
        b=VGvpk1pOGbvCieere2oaJXRDhphh7qmRS6X7CJ4UZQHNiEgLROJaGHQ27vGmKi9DOD
         LUcHyo37gu1Sq/1i8gOCqojJFb3SZg2tAQvH0eYIILOuMwOluFHtJqy5Bd22wCHmIBmn
         BQx5Z92gX99rIXwzR/C/FRoKbERfz0u+aRpIfQ25ENUuLM4/P/kk6HS4eWMBbIR4dG2Z
         S0mKrnO9QTo+d2AmCdAxLB1P7U1D9OfSP+yOiL/MSLR7ZEcBQqtIz4qy9ZtjfRz3vPYL
         zcDKDl0dnPJTDwIziKz028FOFj/vu7OGGfWLFHnqf8odYePW0Cn2u3IAZc9OlKcdQ1u6
         owow==
X-Forwarded-Encrypted: i=1; AJvYcCWhi2CKanlCHQmQ0bK2ylJjbFyCeboNkcKQaZLip/nzkYsmIqpMY/PXBXzOggsYaRz2FhfL2bRMgXFq0ZkK1KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jrWLFP5MPbIILVHIbNWw5KaSwyF/Fddc+3DI2fE2nrnWGe5x
	ZWmP2c873VH/O8Yxu3w3RILzEjLreJ4c/KEryLlFj3szCF8NNCcheVmbsFcf3Ig=
X-Google-Smtp-Source: AGHT+IHPRaDLHh5NNr+7xNJ7xQp3GFEDDjA2gli79iP+lkT3RW37GJzP/Nly6ScHDzliGfN1hpNRrg==
X-Received: by 2002:a05:6e02:1d10:b0:3a0:4db0:ddbf with SMTP id e9e14a558f8ab-3a34515d316mr128132985ab.8.1727795691507;
        Tue, 01 Oct 2024 08:14:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c2c51sm2677358173.102.2024.10.01.08.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 08:14:51 -0700 (PDT)
Message-ID: <7ad58665-ed3f-4b20-b7ee-5d8314de3cc2@linuxfoundation.org>
Date: Tue, 1 Oct 2024 09:14:49 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/exec: add a test to enforce execveat()'s
 comm
To: Tycho Andersen <tycho@tycho.pizza>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Tycho Andersen <tandersen@netflix.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241001134945.798662-1-tycho@tycho.pizza>
 <20241001134945.798662-2-tycho@tycho.pizza>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241001134945.798662-2-tycho@tycho.pizza>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 07:49, Tycho Andersen wrote:
> From: Tycho Andersen <tandersen@netflix.com>
> 
> We want to ensure that /proc/self/comm stays useful for execveat() callers.

This commit message is vague? What does staying useful mean?
Elaborate on the staying useful and the tests added to ensure.
Add test results as well.

> 
> Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> ---
>   tools/testing/selftests/exec/execveat.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
> index 071e03532cba..091029f4ca9b 100644
> --- a/tools/testing/selftests/exec/execveat.c
> +++ b/tools/testing/selftests/exec/execveat.c
> @@ -419,6 +419,9 @@ int main(int argc, char **argv)
>   	if (argc >= 2) {
>   		/* If we are invoked with an argument, don't run tests. */
>   		const char *in_test = getenv("IN_TEST");
> +		/* TASK_COMM_LEN == 16 */
> +		char buf[32];
> +		int fd;
>   
>   		if (verbose) {
>   			ksft_print_msg("invoked with:\n");
> @@ -432,6 +435,28 @@ int main(int argc, char **argv)
>   			return 1;
>   		}
>   
> +		fd = open("/proc/self/comm", O_RDONLY);
> +		if (fd < 0) {
> +			perror("open comm");

The existing code in this file uses ksft_perror() - please keep
the new code consistent with the existing code.

> +			return 1;
> +		}
> +
> +		if (read(fd, buf, sizeof(buf)) < 0) {
> +			close(fd);
> +			perror("read comm");

Same comment as above.

> +			return 1;
> +		}
> +		close(fd);
> +
> +		/*
> +		 * /proc/self/comm should fail to convert to an integer, i.e.
> +		 * atoi() should return 0.
> +		 */
> +		if (atoi(buf) != 0) {
> +			ksft_print_msg("bad /proc/self/comm: %s", buf);
> +			return 1;
> +		}
> +
>   		/* Use the final argument as an exit code. */
>   		rc = atoi(argv[argc - 1]);
>   		exit(rc);

thanks,
-- Shuah

