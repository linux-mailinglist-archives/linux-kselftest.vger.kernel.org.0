Return-Path: <linux-kselftest+bounces-47805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BBCD457F
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 21:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BFBD3003527
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 20:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FDD2C029D;
	Sun, 21 Dec 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wn/3iHGK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8yVAtJh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CF1FC0EF
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766348612; cv=none; b=goGEKJCgp/F4ciQqcnfXOfJtX8KVmBs3E3lTU+Y7pxXbXVWTQNlaR2pWM6umdkqsmxg9oXDbkrxYag8njQeQ49AJCY7KH5imwpzvdD9fG7S1ZEsKiHxZJahVsyjodnYg7JAGLCRH643Hv7RuyKxrG1K4R4gDAFf/V+JibfQC2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766348612; c=relaxed/simple;
	bh=Jar0q80a0PsFmUWYb4ox2BJrEcSjMWCIdxHrtPWEDr4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m759QFtP3v/fByf3ubOODfGj7KAwi4HUXl6seqDitzObWxYyGEetvC2M/dgYOe7gVrZ1CUT1YfTBS6d+vFULd34pxXoFlZoFAfywPjwuk8yB5t0QQY6MrlxGdnepJvnVDPPMtx62izehRvLmUltqWndupfvFeC/Kg5wlNAk2EqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wn/3iHGK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8yVAtJh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766348609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4osTBFq4Gt0hw66CGVoVJKRG+p6FOpxRLfdhZSqIwF8=;
	b=Wn/3iHGKHn/eQWSMxHoLplPzG96aYmTyEDoDBTeZxm+lb4kMga2CJD5dWhySG8Zaeoccg1
	OD7mhYBWnyMSom2gCW2DlCOg5luDz0zdBHPgXSQjJ0uWvoQo7vzG4Ew7MOwik8RUGd67qe
	GlmibbdpnhiSw6ARAZVQ3cpGjIdD/q8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-3cuMVirAPka_EeGTaZ0X2A-1; Sun, 21 Dec 2025 15:23:27 -0500
X-MC-Unique: 3cuMVirAPka_EeGTaZ0X2A-1
X-Mimecast-MFC-AGG-ID: 3cuMVirAPka_EeGTaZ0X2A_1766348607
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8888447ffebso84389396d6.1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766348607; x=1766953407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4osTBFq4Gt0hw66CGVoVJKRG+p6FOpxRLfdhZSqIwF8=;
        b=g8yVAtJhMKDs96SWpQ+oJ2EBPJu065hNbx2zO38NkhKSbE3JRSDm/xhYCru2nq46EB
         WjXbOlaOPiaJdHeX2sF1envsxSy2vUFlckUn1li/HHAiwca/Cyu3S2JBbLRbpSlqh2NU
         VWkSsNWVvVQfO9Gay+CLqRLnwE4QQjvZJQqvWFKs8pt86yeT1c+HxbS//gVIsaTADACI
         8RkYZ0aPRN1nhj9qeh964J+cnEfJeShLqkmi8eI/y4Q3Him7Cw7SIPCe8uCOcSbxltV3
         fvAqBz2YARDWkqVbG6NCs1rbsCrFE1D4evXXD0VVgBJ7FO4VxQtp40pMpL5Pj+JHoxOg
         ybBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766348607; x=1766953407;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4osTBFq4Gt0hw66CGVoVJKRG+p6FOpxRLfdhZSqIwF8=;
        b=awR/TnkeaiZSEzVCeq/3UZVfe083LgeedPvvuL+Y9aTgIgUgF7gvpeSR9+LfwamxuT
         BEOVSafi9ATqC83lLTwKh2xjWuYq1Y+WEtvn1aA5p0DDKPXh8WkGUmIu2dwOzcP1lbkf
         d3F/FvaciCmWT2BllOSQ/lkFItijEJJkplTfpKeBeVGlvr1ngtj9zQlw/OJ9QMbeZqtX
         hzwjAlaUkh5VR0aojC6P9mb9Ts+gBQa7dRsd8yr8ijT3XQF44Gba5iR+72NxpfM1XPBc
         8JKhqgDd8d+KU6SRXL5VASkeQCVUwdreEvYeuOSTuaS7ctODs+IqdtPN9fZvfnmf2twr
         N9qg==
X-Forwarded-Encrypted: i=1; AJvYcCXxTA79yShaA819/p6rBa+d9149MTyTkBoBtZCcNT2aGDtlO+qWu0EdZm8yo9pknVhQHLyJQp8FWdm2bWonZAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29J0sUwu566+QwkhVId2Z9yPKqTsjBu2TL7Zg2QY9/5iaoPeh
	6swYlGlbzhUhDuMLgNNYaSahXvShKO+Djx4CYqs6+FZ1CJ3QWuzlFYu1Vwm4OrHmexlfc4BStLh
	i980aOUObGLkO5GEKPm5frFews8l6e/v1+r2hv2F2ETenqJiSnynzVFFak6lZyHXJWDNttw==
X-Gm-Gg: AY/fxX4aYpYTX8PBwGN+G8GKBtd96wCmUgZRJGy3QlXqTCQKgZsPYU4LCfPZ6W5edwu
	Om1qkcJ2Lu8ja3rif3PiK42U3cgQPpZCVu5yycVBDcji+veKKN4kOMnhpa4iVywIxKSTswVjjc3
	ys9I6VwjpFT66tBH+y3/T6njmVS6dZFiaSaThDQwpSRcQ3xosUVkXKGd/9c/W3qLhefdmVK1ys5
	z7vZnsF/HJl9NlDSkmxOhqws2JQsjCFe3dJ93482iUuGp1q/E4dSQYaOg33ZLDdbOh5/EpPr3fU
	76NZUxRqv86e08JjZM1uHSA/10m/JBzKf/xOBTSj0CJ6QyL0VgyNCrVK1Y09dul9Rtl6eD4oetb
	tTTrqALdm/Gir5dS3czGz6wvil43b8tqFEfz36iiS3ddoL2yy9h9TmKK9
X-Received: by 2002:a05:620a:2945:b0:8a6:ee41:1b48 with SMTP id af79cd13be357-8c08fc0ebb3mr1494135785a.26.1766348607252;
        Sun, 21 Dec 2025 12:23:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH1hKRiYLU7cK0Wkvqmr52oHSn2x4SgTCG2kximSipAI6VB4lbhPeQOdZR7L7ni/aX63l7iQ==
X-Received: by 2002:a05:620a:2945:b0:8a6:ee41:1b48 with SMTP id af79cd13be357-8c08fc0ebb3mr1494133585a.26.1766348606764;
        Sun, 21 Dec 2025 12:23:26 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96bec1d3sm66333926d6.17.2025.12.21.12.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 12:23:25 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <39c9af10-d66f-4bcc-93a6-9e2d33827938@redhat.com>
Date: Sun, 21 Dec 2025 15:23:22 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as
 size_t
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20251221122639.3168038-1-liwang@redhat.com>
 <20251221122639.3168038-2-liwang@redhat.com>
Content-Language: en-US
In-Reply-To: <20251221122639.3168038-2-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 7:26 AM, Li Wang wrote:
> write_to_hugetlbfs currently parses the -s size argument with atoi()
> into an int. This silently accepts malformed input, cannot report overflow,
> and can truncate large sizes.
>
> --- Error log ---
>   # uname -r
>   6.12.0-xxx.el10.aarch64+64k
>
>   # ls /sys/kernel/mm/hugepages/hugepages-*
>   hugepages-16777216kB/  hugepages-2048kB/  hugepages-524288kB/
>
>   #./charge_reserved_hugetlb.sh -cgroup-v2
>   # -----------------------------------------
>   ...
>   # nr hugepages = 10
>   # writing cgroup limit: 5368709120
>   # writing reseravation limit: 5368709120
>   ...
>   # Writing to this path: /mnt/huge/test
>   # Writing this size: -1610612736        <--------
>
> Switch the size variable to size_t and parse -s with sscanf("%zu", ...).
> Also print the size using %zu.
>
> This avoids incorrect behavior with large -s values and makes the utility
> more robust.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---
>   tools/testing/selftests/mm/write_to_hugetlbfs.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> index 34c91f7e6128..ecb5f7619960 100644
> --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> @@ -68,7 +68,7 @@ int main(int argc, char **argv)
>   	int key = 0;
>   	int *ptr = NULL;
>   	int c = 0;
> -	int size = 0;
> +	size_t size = 0;
>   	char path[256] = "";
>   	enum method method = MAX_METHOD;
>   	int want_sleep = 0, private = 0;
> @@ -86,7 +86,10 @@ int main(int argc, char **argv)
>   	while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
>   		switch (c) {
>   		case 's':
> -			size = atoi(optarg);
> +			if (sscanf(optarg, "%zu", &size) != 1) {
> +				perror("Invalid -s.");
> +				exit_usage();
> +			}
>   			break;
>   		case 'p':
>   			strncpy(path, optarg, sizeof(path) - 1);
> @@ -131,7 +134,7 @@ int main(int argc, char **argv)
>   	}
>   
>   	if (size != 0) {
> -		printf("Writing this size: %d\n", size);
> +		printf("Writing this size: %zu\n", size);
>   	} else {
>   		errno = EINVAL;
>   		perror("size not found");

LGTM

Acked-by: Waiman Long <longman@redhat.com>


