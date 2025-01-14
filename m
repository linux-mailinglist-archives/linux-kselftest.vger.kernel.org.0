Return-Path: <linux-kselftest+bounces-24437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F7FA1038A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 11:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619DD1621DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F81ADC8E;
	Tue, 14 Jan 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtoW7U5Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6A1ADC84
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848920; cv=none; b=IPYBt4fCp+jDuG7oRuF1vGcx6wBuPijNW9Ap3ZccOeu1TditwAZNFE+JoLgDHL/hCf9matTdKASb702rJr3XpArqkQOajpSJlI1ZulijN8xbuPRPgtwYTky7RNw8InULBrXs94nyWQDtBEZVMGEqKmD7T8XyQFZnN+FMSrjUwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848920; c=relaxed/simple;
	bh=dX6o8MVnu7hHH5mzHRWTbY7Q5cZNVuSHHr5APtT7xWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEWfUQNOtc4C2ZJcXfMBTu/D8uWb4Fs0eRMHFB15zQsXbQRC+np5iNbbCnisUTRupqR8cE5jklSiCrQUm63+WyT1SyKErAuLhxTPs+6INYgVu+Q3hQYxKKUya5trLnCZkN+S2nLjj/nJWXoMHyXEoUZ/5vdNRAazgBJRIDhHlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtoW7U5Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736848918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ISTJvNY/yuUbjJURhevN2PidXwlioNt1jGja0wDB6kw=;
	b=AtoW7U5ZNl2Bd9vf0t2BYxo7sYAXh5wbProgG42ibBafJxVJh0S22zZvWfYWpNvDPhBi+N
	usNYhyvfkyFOkiiEsyigShJuRujTmUrWmBVflPONmuTwCR0HcXsW+aoogVJp0pxYaehn5Z
	8lOgKGQMyU/2/SPKmzkMKXyQwX0kpFk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-Q6wO1BqNOfqLS3W-0lxYGA-1; Tue, 14 Jan 2025 05:01:55 -0500
X-MC-Unique: Q6wO1BqNOfqLS3W-0lxYGA-1
X-Mimecast-MFC-AGG-ID: Q6wO1BqNOfqLS3W-0lxYGA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so40836435e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 02:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736848914; x=1737453714;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ISTJvNY/yuUbjJURhevN2PidXwlioNt1jGja0wDB6kw=;
        b=aC9qtaGDdxQpN81RDQ761HNxR8G5v4DiL4wu9BzVmH3awUJAB4pP4ZDEPE87vAYcvJ
         EVETAhbCFggv1dbgr0twey9bWKtWfaYS0O9XtMW8Ll/ALUIBV5JFTyH3jLg2B8CVNvER
         m5r3BhdGFPpPaqzs3JXZnsBuMQ7rky4+9QWWyTuiiJ6Pt3ofz47Sb/4P3a1LSWCGsiua
         zcgCKCaKCxgkCKAh/74SX/J1cj0oDVl6GTxQKWNUr0qwbFo9+8qSSJYu8RqynmOuRE01
         wVTQAWODP3pmcz0ADTWNxnRavWavoQxXBrrlB/IyQnsVkX+HbtlmYlg2DXRU+36NNU+p
         4kWA==
X-Forwarded-Encrypted: i=1; AJvYcCVSpoPpaH10hB1HtvtuEwBGJKqDrX2pr5YM5uNwLcZa4TouMnMVxmn1JIGuPgMzX9E2WGMhxaaD2K0iQ29+dXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NsTieXzfkmhuH9SjOldyRtHi0hhsZ2QZel4KGwbBlLD9O+Tn
	+4vKmIvcZ3lq9Tn6aPKD+7HSMh7ZLqpgccDz3r67Lsue+uEUGtGbPh04AK19l3vDgbVbzvwPbIb
	zgzt0VySSK2Aog6Hk+GqjrbC2z31j/VXiw9Ze3+DB3JjZNTVkr4EftL8/QqWKWFb7QA==
X-Gm-Gg: ASbGncvJsF0r/v5/J1mE6FNRvJLlLWdOIM2ZIjLpqn6D3JJa5+6Gv3YU1XWXMVtoowj
	rNU20+mkv0dLEyhWjhJjLSigBCROjev8VNyO0VyW9DAX88bhbXQcsw/fOcUws12ChZnlElr06uz
	j0Jz1Xza66WdhuQ6L1hjn5P4+58tZN5B22P1C5EzYAtjd5lV9mzyQXlmnfaQz5HNpRAD78+0sO5
	osV0gEuIyMnUiDMg4UwNPm/TPMSYOTImtLSLCx2XZ/LJbAmyqucdsa4HNuPom7vzTLRsHfG14ay
	0mXFy1aqdiIrZHnER9ExMphtZJWdTLfAE7bTVT0nw66akaHH9iulmZ0FAhkzRYuvLVa7U573tnP
	c9068xybi
X-Received: by 2002:a05:600c:1d0c:b0:436:1bbe:f686 with SMTP id 5b1f17b1804b1-436e2707c59mr183355325e9.21.1736848914526;
        Tue, 14 Jan 2025 02:01:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRY6+qucxJhLZExA9LpgdhtKCettG1AwaZVPfGO1DmZyF0yWGxruw/LcgTVeSaJlA0lezfmQ==
X-Received: by 2002:a05:600c:1d0c:b0:436:1bbe:f686 with SMTP id 5b1f17b1804b1-436e2707c59mr183354965e9.21.1736848914123;
        Tue, 14 Jan 2025 02:01:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436f9bc6b9bsm79963645e9.22.2025.01.14.02.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 02:01:52 -0800 (PST)
Message-ID: <0a34b3f5-fe67-498e-a648-27524b50abc7@redhat.com>
Date: Tue, 14 Jan 2025 11:01:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] selftests/mm: vm_util: Split up /proc/self/smaps
 parsing
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
 <20250113-virtual_address_range-tests-v3-3-f4a8e6b7feed@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113-virtual_address_range-tests-v3-3-f4a8e6b7feed@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.01.25 14:15, Thomas Weißschuh wrote:
> Upcoming changes want to reuse the /proc/self/smaps parsing logic to
> parse the VmFlags field.
> As that works differently from the currently parsed HugePage counters,
> split up the logic so common functionality can be shared.
> 
> While reworking this code, also use the correct sscanf placeholder for
> the "uint64_t thp" variable.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/mm/vm_util.c | 42 +++++++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index d8d0cf04bb57fd22bd7748fffec6a23c3103e35c..8468a19d6acca10c7e9228c03a935cdeb2402b5d 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -2,6 +2,7 @@
>   #include <string.h>
>   #include <fcntl.h>
>   #include <dirent.h>
> +#include <inttypes.h>
>   #include <sys/ioctl.h>
>   #include <linux/userfaultfd.h>
>   #include <linux/fs.h>
> @@ -193,13 +194,11 @@ unsigned long rss_anon(void)
>   	return rss_anon;
>   }
>   
> -bool __check_huge(void *addr, char *pattern, int nr_hpages,
> -		  uint64_t hpage_size)
> +char *__get_smap_entry(void *addr, const char *pattern, char *buf, size_t len)
>   {
> -	uint64_t thp = -1;
>   	int ret;
>   	FILE *fp;
> -	char buffer[MAX_LINE_LENGTH];
> +	char *entry;
>   	char addr_pattern[MAX_LINE_LENGTH];
>   
>   	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
> @@ -211,23 +210,40 @@ bool __check_huge(void *addr, char *pattern, int nr_hpages,
>   	if (!fp)
>   		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, SMAP_FILE_PATH);
>   
> -	if (!check_for_pattern(fp, addr_pattern, buffer, sizeof(buffer)))
> +	if (!check_for_pattern(fp, addr_pattern, buf, len))
>   		goto err_out;
>   
> -	/*
> -	 * Fetch the pattern in the same block and check the number of
> -	 * hugepages.
> -	 */
> -	if (!check_for_pattern(fp, pattern, buffer, sizeof(buffer)))
> +	/* Fetch the pattern in the same block */
> +	if (!check_for_pattern(fp, pattern, buf, len))
>   		goto err_out;
>   
> -	snprintf(addr_pattern, MAX_LINE_LENGTH, "%s%%9ld kB", pattern);
> +	/* Trim trailing newline */
> +	entry = strchr(buf, '\n');
> +	if (entry)
> +		*entry = '\0';
>   
> -	if (sscanf(buffer, addr_pattern, &thp) != 1)
> -		ksft_exit_fail_msg("Reading smap error\n");
> +	entry = buf + strlen(pattern);
>   
>   err_out:
>   	fclose(fp);
> +	return entry;
> +}

Yes, LGTM!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


