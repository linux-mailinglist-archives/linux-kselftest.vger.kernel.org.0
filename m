Return-Path: <linux-kselftest+bounces-47865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D6CD6FC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 20:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E70B030057F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E12FE04D;
	Mon, 22 Dec 2025 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MooInMLg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D871A304A
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432184; cv=none; b=l1rRMb78bhF1rt2UoTl+Tbmct7vnZ8YtAGuP+ZZhX5w59bMzl45Je7oFe52D4VkM9sC4nB6+WTLqF5YmgB6LlqI3YyhasRTG7mx3+o+I9DwBqKW0gA2a1X+EzEEUG5iEOEoQQwbPUFnkf3q/sZzvA2X3HJ4He4fTrgoIYvIjVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432184; c=relaxed/simple;
	bh=MqLniN46ga/T49jfTrH3dp7jmvmuld5OUNS6EMMd26I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeK4ZZmMJWjcBpiqXUhl6sefc2t7mz1T3SLb9+aWNqzZOezOSvSdk4bG9S2gT/hMWPCrAyuNUIWfeO0nl1d320IGHZUMS2rDjdlD4IjnQ6cf+YGyNbMHx2rbeds/InS8EvjZTVN0uRTScf4E/1Hicsy+MSArnH1zVJ+/dD5ZkOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MooInMLg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766432181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWFglRNrhHIkSED0pY4mFYnNdUnj8iod8G1skdCiVi0=;
	b=MooInMLgW7ystPQma5yiCtVBsxjCYLlwBbHJsWZR+NCbTbze0pHuH54yxzEjheC6Yai05k
	VoudBeUmzKZr+TVVrvYkJdqj62A4lcod/iod65SGMqxQrsnMgwmACVP3xqqcp533WAijR8
	DDfPjrjm+LdjvPDrg29YuCjsFKLj3CE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-dsw-0jEKOYyAJTIRRWvKtg-1; Mon, 22 Dec 2025 14:36:20 -0500
X-MC-Unique: dsw-0jEKOYyAJTIRRWvKtg-1
X-Mimecast-MFC-AGG-ID: dsw-0jEKOYyAJTIRRWvKtg_1766432179
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a2cc5b548so120558726d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 11:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766432179; x=1767036979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWFglRNrhHIkSED0pY4mFYnNdUnj8iod8G1skdCiVi0=;
        b=cgfoEuX6cK/JKGt0X9lwLRrUW2MllaqL4a4gDJRg+X3LHeb5HD624DNAQD9T/MPf7d
         E0SCfQcqib0v7NYoy+5D8WxxLZ6JZfWdzNiJgrtfojE2F1pQ5x9gFMDM9NW2QntMXLoM
         j2V+TZUIZyQndFL3Z6+k9cIFscCvHtTeDYbUA4Quq7ljmT+zi8nE4nu1tQzc/LH8S3Pg
         bwndt70VtCk3thYZkHFlcbBb3Lh75r4np2B8ffQt0uPluHUhRQZd0cPiv+9Qtdm1Qnhu
         yszU7tBY0M8gZgIevIfn9+BVszcuk/SN8MX7Cov1OmzKPymhhxMZcPpOn0aUAO27DddD
         u3aw==
X-Gm-Message-State: AOJu0YzrvMqxxaZvUU6JRrAu5hqMs+EvX54HQxpu+zlhRFkoMLfa6TYH
	JZBYgqAhwjwJUTvo+9CP7n8priaio5Tkv6QcTEt30s7qySW6k7adm1X9PI+hgG4rYeJDUqrVba8
	SUHvAU13fT/1FcL4SHvTUWDMxQjpkaDoxQlj1XQSGg5hk/exiYq6PEIKKTz/sKQQzECcLjQ==
X-Gm-Gg: AY/fxX4y5x29CYRbxyx2lstwyZTWyiCczdH8RnW+6qgYCOBFfKV3P8HTAEGpff24/eH
	db+Yvvzp8nFweVyUlZjDIGLyatS6R3tmoca9eZDi5W1jJ5E736TUfXa8UPGPRX6kkfNN9xhSHT6
	oKLAl4fo0JUTEkfDuW/QuIE9aYPhTbgOrByhvYxQ97HBo6wVM3CpYk937yOvq1jRCk11f16EFa4
	EfSuLQ401kUsFLZwTQhWBLSgqJYlGLm+LNyDubQXXk/4OJ87cw5Uzcx//r/N1pNXtyB5oIt0IBv
	va9rKPCyIEDlt0VdcDzJQlYOd9lGCKWH6+k3+a1XA7A7aK5ukj+Nz7YgPx0zdKEQAuqfnq8tDoP
	I5+QD1WEcOoPWPifTOvr5qm6kVuWZn3kw4d4sspwyPLG7fekZhgdCVmoOB1C1FFAY4J7KvLzxLg
	==
X-Received: by 2002:ac8:594e:0:b0:4ee:ce3:6c9c with SMTP id d75a77b69052e-4f4aac5d23bmr164621841cf.2.1766432179688;
        Mon, 22 Dec 2025 11:36:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDk3FjtineRhvc1jPppKJR8ZeFRYgYn64r+f+ezu6FGdQbbfW4MbqUOXuDnwzesgGVYYYTRg==
X-Received: by 2002:ac8:594e:0:b0:4ee:ce3:6c9c with SMTP id d75a77b69052e-4f4aac5d23bmr164621571cf.2.1766432179295;
        Mon, 22 Dec 2025 11:36:19 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-48-76-65-77-217.dsl.bell.ca. [76.65.77.217])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4b1302d44sm79789771cf.29.2025.12.22.11.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 11:36:19 -0800 (PST)
Message-ID: <469acbcf-22f2-4774-8cf3-7f68c7095c0a@redhat.com>
Date: Mon, 22 Dec 2025 14:36:18 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] selftests/mm: va_high_addr_switch return fail when
 either test failed
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 david@kernel.org, shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20251221040025.3159990-1-chuhu@redhat.com>
 <20251221040025.3159990-2-chuhu@redhat.com>
 <20251221040025.3159990-3-chuhu@redhat.com>
 <20251221040025.3159990-4-chuhu@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251221040025.3159990-4-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-20 23:00, Chunyu Hu wrote:
> When the first test failed, and the hugetlb test passed, the result would
> be pass, but we expect a fail. Fix this issue by returning fail if either
> is not KSFT_PASS.
> 
> CC: Luiz Capitulino <luizcap@redhat.com>
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> ---
>   tools/testing/selftests/mm/va_high_addr_switch.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
> index 02f290a69132..51401e081b20 100644
> --- a/tools/testing/selftests/mm/va_high_addr_switch.c
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.c
> @@ -322,7 +322,7 @@ static int supported_arch(void)
>   
>   int main(int argc, char **argv)
>   {
> -	int ret;
> +	int ret, hugetlb_ret = KSFT_PASS;
>   
>   	if (!supported_arch())
>   		return KSFT_SKIP;
> @@ -331,6 +331,10 @@ int main(int argc, char **argv)
>   
>   	ret = run_test(testcases, sz_testcases);
>   	if (argc == 2 && !strcmp(argv[1], "--run-hugetlb"))
> -		ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);

Maybe you could just have used:

		ret |= run_test(hugetlb_testcases, sz_hugetlb_testcases);

But anyways, as this is just testing code:

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>

> -	return ret;
> +		hugetlb_ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);
> +
> +	if (ret == KSFT_PASS && hugetlb_ret == KSFT_PASS)
> +		return KSFT_PASS;
> +	else
> +		return KSFT_FAIL;
>   }


