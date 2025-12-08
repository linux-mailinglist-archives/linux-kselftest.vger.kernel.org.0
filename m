Return-Path: <linux-kselftest+bounces-47276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA76CADA4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD9B30136EF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B51DA60D;
	Mon,  8 Dec 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXSu19+P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4301DE3B7
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Dec 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208948; cv=none; b=eChNkzXblaz7ntL5H273Amv/RKx2wbz/MinwRi6ZmyT7MwZHkGdNnAB30hVnJ7KIgiZ8VAwY0ocXHXPkJhzT4KdWGTAYqgYmziycv+ruiwdU6pl2hj70GV0G3nT4ui7KrsNfXvT3/SnrNu5Y3FI3yMyDHP4A4husmOWGecXAy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208948; c=relaxed/simple;
	bh=lZKT4ZLOit7vD2jIF65c8Sdfo43EtScwRoyP0UL7FGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSPwI6mE4zPBJjV2JQAtFneOUHo4h3AVWTLCUFItF+S1rslMm/v2gqkkLicL4shkcf6lY88uw9IZC0J/pgaHFOufK251RgEH4raUlRp7lluOq9QoM3dX/4Vixo3tIf8bHHwUwhhY+ugO3GaSLLE1lHr/+W5Rquj1RpGWomyMfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXSu19+P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765208944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhyQmCNeRAwE6U6BA2EWgkizTxmpe6QSDSUOhKlflR4=;
	b=NXSu19+PEyA/FJJgfGc3/pzliAvkhn9lqrQIpI0zZ12a9a0b/cQDgB2yQnMNKQh03NMOrn
	YgSHLCjfZ7lO5vKHRYpha32r1xqFKtqNcgBi0iPlqGHgxbgR8MPDR5JIlI+0woec3eJk8T
	lM1eUQap4WkWPfPi9iX1pzFm8yXL2jU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-vZUw9Fb1PlS4fiQJJzNhrQ-1; Mon, 08 Dec 2025 10:48:57 -0500
X-MC-Unique: vZUw9Fb1PlS4fiQJJzNhrQ-1
X-Mimecast-MFC-AGG-ID: vZUw9Fb1PlS4fiQJJzNhrQ_1765208937
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34943d156e4so12314698a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 07:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208936; x=1765813736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhyQmCNeRAwE6U6BA2EWgkizTxmpe6QSDSUOhKlflR4=;
        b=orMPHKptTTCCqC9n/xdM0XRPcLxYtjCBNiqSS4U3naAVSFE2HOR4jBNU5uUKfT1Zui
         s9IXv7RZUz5n9fozBImELaqvEyzkWWEPzkIEG6oJewTidx5Jlxzh3GgRrTHWAjxQo+ZM
         MaDlmiafL3AGzynJnMwwLf8pm1h/7N6QHM5NesMryfO598ffLxrEg29bRhG/UIcV4fty
         p4nA+noLXrbd7a05xOakFVz89GKq4Q76vN50SZ4aiJwDITEZHt/trST2RtXFPTZPyjye
         dxcZw+ncw4kBX1h5bmgcxBDSaXYuTrnbhiGTVvTHEj8JO7PBYhCFJA2ToK8XYFqKC47a
         YDbQ==
X-Gm-Message-State: AOJu0YyixT9FN3kskKMKj5ebxXkKVNOUJuLWxpIZRaH1APGNB0Pm9xAH
	69rNfmJ9kQHYO9t0ZUc0CAxCS6+SLaxNoFbXYwsq0pv/DjiyuZG5CjZrRyOqRf0y/oEPYo9UJIm
	RuEjBbaTtYTaxVVO4RDEjr6NzdVxIl0LuHSZQcJGjq/b1eKEgpAatYHOCpVXAWxgqLXnkMQ==
X-Gm-Gg: ASbGncuo/vjagZuwdDPdzixe8X3v76zq6+glhK9AXUAS4OeNhpS/d0MCpJF5LWjlJtd
	aF0KWazbUO4fbqsREE1OwVWUdyVFO4YAjZRLRO7AwiZYh6N/oE3Gje4fyusSrSzP/ix8vZmI0bG
	LiKRJrKmZOh/VRbmTDVsqWB6tmlfC3yngmSg4DH6P1mFbQ2vXGo4rFJbQJ6ZgvN9bbOtu8KHbOr
	rZcjebAztatRyf9n0xpp7PVY+ETlamskWTZ4PsegmKl1omlCa9FpnmhEDNSSmxRr8d8wze6aT17
	Vw0/zDLtZ6vLMvFnMxrZJxT4NnauvW+OUMyxqYX7Qw4AEWpNPbFgwm8zCzKdt9S/8iQLcl0htCh
	ZNN1/z1yN3EFuKD3hrvtVomWT9Llflw1MfHJzNSiXCkyCqVwC2lyqxpK8z9l5Hl+DdExMUknySw
	==
X-Received: by 2002:a05:7022:3885:b0:119:e56b:c749 with SMTP id a92af1059eb24-11e0315a389mr5832012c88.14.1765208936636;
        Mon, 08 Dec 2025 07:48:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2lGw6J4rXoBC0qYrZWnyNE9vY/xTzaJH9ksV8ZOu8KN7rKkS8AprfXcNKR4rpLa/DSIhIfw==
X-Received: by 2002:a05:7022:3885:b0:119:e56b:c749 with SMTP id a92af1059eb24-11e0315a389mr5831983c88.14.1765208936210;
        Mon, 08 Dec 2025 07:48:56 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-48-76-65-77-217.dsl.bell.ca. [76.65.77.217])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76edd4fsm54746101c88.8.2025.12.08.07.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 07:48:55 -0800 (PST)
Message-ID: <8b67305a-9057-49fd-92b2-343d237890cb@redhat.com>
Date: Mon, 8 Dec 2025 10:48:50 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] selftests/mm: remove arm64 nr_hugepages setup for
 va_high_addr_switch test
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 david@kernel.org, shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20251207122239.3228920-1-chuhu@redhat.com>
 <20251207122239.3228920-2-chuhu@redhat.com>
 <20251207122239.3228920-3-chuhu@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251207122239.3228920-3-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-07 07:22, Chunyu Hu wrote:
> arm64 and x86_64 has the same nr_hugepages requriement for running the
> va_high_addr_switch test. Since commit d9d957bd7b61 ("selftests/mm: alloc
> hugepages in va_high_addr_switch test"), the setup can be done in
> va_high_addr_switch.sh. So remove the duplicated setup.
> 
> CC: Luiz Capitulino <luizcap@redhat.com>
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   tools/testing/selftests/mm/run_vmtests.sh | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index d9173f2312b7..2dadbfc6e535 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -412,15 +412,7 @@ if [ $VADDR64 -ne 0 ]; then
>   	fi
>   
>   	# va high address boundary switch test
> -	ARCH_ARM64="arm64"
> -	prev_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
> -	if [ "$ARCH" == "$ARCH_ARM64" ]; then
> -		echo 6 > /proc/sys/vm/nr_hugepages
> -	fi
>   	CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
> -	if [ "$ARCH" == "$ARCH_ARM64" ]; then
> -		echo $prev_nr_hugepages > /proc/sys/vm/nr_hugepages
> -	fi
>   fi # VADDR64
>   
>   # vmalloc stability smoke test


