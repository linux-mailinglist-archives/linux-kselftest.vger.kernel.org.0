Return-Path: <linux-kselftest+bounces-47274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FBFCADA23
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 16:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D3630595AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37812DC77A;
	Mon,  8 Dec 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZMEdh7J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6C2C159C
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Dec 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208698; cv=none; b=UqsDgrIUwC/5EpexlIwr/7hGKoaNUIGhxKmStDzWYVjPzsWyBfqc5j1qRTbPklo7eJ/B4Um8qMYdgXt73ynt3Q9EQc4d+RZbrswPkVDi1E/wejwQnrYgnqa9TaPhWGZGr6vyUksmWiZSBPe9KQNs+Py6ZjXYQXL9ZOMsBg8zYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208698; c=relaxed/simple;
	bh=z6fXEQqvGKi4O2zkZhxy65l+Ky23ibWbRx+dFpzFMb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3NWZLu0lnCyg59CpKqGHgucaa3UNBw/o70LuTfoqQVwKfIza5cKGO3HvmZ3JZcA3Kj355N/rIrFbyQQxM8j/u8x2e531Soxt+k8t19/xroSoVgBEtIIXZFODIpSMBSR9K9uZlcseV2/brZFBQ/+9h8oUvFoP8jnbAltu8gxyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZMEdh7J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765208694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZA8EtJ/Yb3hDRtk61pdFksnnDW88iHKAyV8Vf/m1G0=;
	b=hZMEdh7JeC2yGOR8gelUNXqUcCrOQre/qo1MsdtVT+ASdCxi/beKwM2clf+mSRcFU7BXKE
	MBt7hUaoPcyNvYybNFo1xJRYZOrlmrk/QXspghcgLDM9O95FIQPprAQ+Wd045pg5Jhz3cJ
	dMprupf4r0dqUJHSYp6zk7kqFdYZ3A0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-gRFp1J3FNnSfDYkSJe0bkQ-1; Mon, 08 Dec 2025 10:44:53 -0500
X-MC-Unique: gRFp1J3FNnSfDYkSJe0bkQ-1
X-Mimecast-MFC-AGG-ID: gRFp1J3FNnSfDYkSJe0bkQ_1765208692
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6097ca315bso7394517a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 07:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208692; x=1765813492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZA8EtJ/Yb3hDRtk61pdFksnnDW88iHKAyV8Vf/m1G0=;
        b=MLhixmF5sw9I5pkQMTEkauYBfQvHoK34k8DB1b8tyU2Sf4tBovaD4SDutuEgeJXeFF
         +HecA3vHh+fi2gsN2Vx4F2g4waIcvc0SE8UYZUVduP4TTrKmbtDGROcVHmBZCOcnnATR
         mgEJ0JPhUVXbAHeaCekL8NyDwUKX6fpa4Szg2WLl1Vit/DjUi/8PZ9BLnJsUobwb79vw
         9GCfmhPB04P5YCoH/SReaCOyjX76HE71/qGvCRDOdwOoYRYJHo7vbl+cMUEYwINwkSlH
         QehIWGHz9xcsWkH7em+aGBThta0arw1aWnz9yJbSrIvy0U8W4gyAj6bMoBysB8BfJ1rS
         CONg==
X-Gm-Message-State: AOJu0YzB2A88Eqy0T1vsvlgwN75zyJBLo7BOJjurpDXioDD+6D5HTd6N
	uMYtzIp8bQph/46K0x1YybmCKnzIDW/1vEnZzsaemLS5i8WpRt5s/DkbhZNee15pMlyj7TtMwqj
	jFs4dloZOFU/l7Puoi7UtQlfBrKQ5m11myGjWASM0sHWqrajQ6SaNBQc6TQc9A3LyPSrFIQ==
X-Gm-Gg: ASbGnctwxpteGO0+W/t5hWKG8jn8nRPOspb1v0wApQjFsGYlcdBloyX+B2miW/JYNXN
	MXgZhvF2mKUxwL4wWblgwWja7ETRT1D2l6eGJLgQ5AsZQjX1cubdp2oCzHPl1YZhiCCkss/+Udb
	qCmx4HKHGI/XU5yfs+9lgMn5TqN8UGvTq7uyMH5TzHY289KH/J2ojJC5GlJKObCNvqUKq/vhMoI
	tbl2xhH2wz05D1Dj2Bki4quU/GJjarVJGhfg3TfzKE5tai6UelNY7C/2y5pNxAmB6zOIuOMiRvP
	qzQThteDiVW0gl/8BYMvSg5Chvgm1yo8Af1EjW83CYF4RX9nxEXd7gEBz78EFxN+YXJLOFSXfn1
	/ExLFxOZGHRkzvSDW9PFnnmGIUVppW0DSJbvE0e07NPZrvqathBpOhImQCM3LqZFeg1aY627iKQ
	==
X-Received: by 2002:a05:7022:ec0c:b0:11d:f44d:1863 with SMTP id a92af1059eb24-11e0326b11fmr5785270c88.11.1765208692259;
        Mon, 08 Dec 2025 07:44:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAjO/iQcpglYWmyAUY5NhlLp8TjzTsbzOXCBjpFZBwT6DwAEkwKSVISxY8b2i+m6RPHCfxhQ==
X-Received: by 2002:a05:7022:ec0c:b0:11d:f44d:1863 with SMTP id a92af1059eb24-11e0326b11fmr5785242c88.11.1765208691771;
        Mon, 08 Dec 2025 07:44:51 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-48-76-65-77-217.dsl.bell.ca. [76.65.77.217])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm56860378c88.2.2025.12.08.07.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 07:44:51 -0800 (PST)
Message-ID: <f8d1e504-2009-4bd6-b1b7-c98c1f49374a@redhat.com>
Date: Mon, 8 Dec 2025 10:44:45 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] selftests/mm: fix va_high_addr_switch.sh return
 value
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 david@kernel.org, shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20251207122239.3228920-1-chuhu@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251207122239.3228920-1-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-07 07:22, Chunyu Hu wrote:
> Patch series "Fix va_high_addr_switch.sh test failure - again", v1.
> 
> There are two issues exist for the  va_high_addr_switch test. One issue is
> the test return value is ignored in va_high_addr_switch.sh. The second is
> the va_high_addr_switch requires 6 hugepages but it requires 5.
> 
> Besides that, the nr_hugepages setup in run_vmtests.sh for arm64 can be
> done in va_high_addr_switch.sh too.
> 
> This patch: (of 3)
> 
> The return value should be return value of va_high_addr_switch, otherwise
> a test failure would be silently ignored.
> 
> Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
> CC: Luiz Capitulino <luizcap@redhat.com>
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>

This fix is good, but there are two additional issues that need fixing
(maybe in separate patches):

1. In main() we do:

"""
         ret = run_test(testcases, sz_testcases);
         if (argc == 2 && !strcmp(argv[1], "--run-hugetlb"))
                 ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);
"""

The second run_test() overwrites the return code of the first one, so if
the first fails and the second one succeeds, the test will report
success.

2. The following comment in va_high_addr_switch.sh is wrong in two
counts: there's an eligibility check for powerpc64 and the test doesn't
reject other architectures as it runs on arm64 as well.

"""
     # The test supports x86_64 and powerpc64. We currently have no useful
     # eligibility check for powerpc64, and the test itself will reject other
     # architectures.
"""

For this fix:

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   tools/testing/selftests/mm/va_high_addr_switch.sh | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
> index a7d4b02b21dd..f89fe078a8e6 100755
> --- a/tools/testing/selftests/mm/va_high_addr_switch.sh
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
> @@ -114,4 +114,6 @@ save_nr_hugepages
>   # 4 keep_mapped pages, and one for tmp usage
>   setup_nr_hugepages 5
>   ./va_high_addr_switch --run-hugetlb
> +retcode=$?
>   restore_nr_hugepages
> +exit $retcode










