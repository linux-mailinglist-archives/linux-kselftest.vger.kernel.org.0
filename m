Return-Path: <linux-kselftest+bounces-47574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 721BBCBC958
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 06:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34D5A300ACEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 05:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404331CA4A;
	Mon, 15 Dec 2025 05:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3x8+/gM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="llyf8lpW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B28634F
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778104; cv=none; b=GFJIHWR31J+gCOa1t0gmAnqC1XbEzZ0c9IC2Ioi74GZigc1nPoXRU4A3JNXneH6hnlmRErP2TqwKVIKfx2q/mhTic+Z+//u2KJLzj8Pf6jF96+FK1a1jC2b2f1p7M4Y2yKVTFxZ2DXZ2xrSFduCDe6TB67RH+YRGuGRhmERVEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778104; c=relaxed/simple;
	bh=l+eRO9cUwdOLQGXpGCxkU0xWlzqvEtT06h1zGGZRF8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHeUi+rvVSvVjO2ME3WGaOKyZCfvm5wPtilv1cBo/WDN6WULw8xSrsXVVrfoM2gUWx4mNz/Gaq0+Etm02Gy2j9LTV6PFv89kssIj9SE4xbAsz39V9vmA/aZE5/nhRl/MXj1gXi0ErK7othSqE8Nz7tTk62YNa84AuIP+1imdDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3x8+/gM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=llyf8lpW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765778101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d05K16DKQiEd3StceTnrw6JfNIHdbpDM1WqXFgxTmJw=;
	b=R3x8+/gMh1Ms6+b15CYoV+2FtxwH5dz+FmOM4uYTZn8pfkQlcrMA+ohOpHnCzCHut9ovfn
	/CWLhsHV+bLbJZt1+RRiJMyYtwmNOIVlPisWzhc/y5J+OXdT8wRggtwQT++d5n6pTBaClo
	aLawGvnzvQnoPi/ykcj2Abj6/jFdnmc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-XXmccILUOfiqIn0ossM99A-1; Mon, 15 Dec 2025 00:54:59 -0500
X-MC-Unique: XXmccILUOfiqIn0ossM99A-1
X-Mimecast-MFC-AGG-ID: XXmccILUOfiqIn0ossM99A_1765778099
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so5179087b3a.3
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 21:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765778098; x=1766382898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d05K16DKQiEd3StceTnrw6JfNIHdbpDM1WqXFgxTmJw=;
        b=llyf8lpWaAf7kc7qY50jLqXNH1Wra9TleJdzU0Yr2B3nlcukJ+zJqDdqj1rZ8LAZLa
         9lVIIYFM2V7yZ30Ol/XsTwqxaN7z4rcLo5UUIgi8KlJdn5OFKIXlLdB9697t472avCaU
         eSxxnTtOA1KMsx3tYETazJs6aMFu/3Go2glFJ2OmizPOcQXuaqXt491oRdQzbxAUTT8k
         9XD2U9igQOtrhGtQqqT5s0yLm4rmoUKR9r8yw02i9/LDBjrqwOWcuL6vmMgCcxo4HvEi
         /W39i75a/xDiyMFKfEX6LSiM0EoHw9Micm37R8zZDdbBrCRWr1wi/5mLPbmPKxkhVpbI
         kWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765778098; x=1766382898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d05K16DKQiEd3StceTnrw6JfNIHdbpDM1WqXFgxTmJw=;
        b=kBj1sQU6TehqRYsEm+MdWhMPkn2nN0iBluEErGj4AHnmhS9Fa+HaZRq7yUAdCY3TK0
         +wO/2qqwM+OrQN9VGBgfMJv3FwiJSEGXK5fU4yEZqZ9vJ1+XxOwKxrbF5UIIe63F58RI
         dtc/Quqt49DInQtE6jv0zujTdHuCLx1lQfHni165XAAJSheeoBDMx5QRGLPcyhEmVnh+
         mYO+sItBQGx6rjFHa0ICMG75S0Pq3VTJ9ZR1JdgSDMSJhQQw3wHUlvKXw3vcWhfDsX/L
         ugrgNgVgz4SSDPvvkGQcGfZozJVNvIVeWtK8rMBuZzyO27xYFMJdFJmZzYefHhBKqTOu
         6AIg==
X-Forwarded-Encrypted: i=1; AJvYcCUx2yUBNrOQ0geueQgnxPrys5Omr82EAS/fPR/x487GKMhP5GSBFxvtXPguPlDFr+76/CYOc/BYyjnOZo1hnhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgQKuDGSLsdc3CAeg6YQF3zBhJtL3iH65dl2VEX1AdyUMurKs
	my8FOjtyUsd1OmBhnOLtxPmRgvmmklkCp8eI5STNwxSD568hPSswbT6kPY8Ua7pTmlPQs5FHFuI
	+skflsgSvxF13neVDXIC7lioR8bHzW1DQ0CMZdqwcQBSfR2yduPFWj4JGUIejaY0JJ5AnXg==
X-Gm-Gg: AY/fxX75SPZNRxPq0iOl2IodcHxXTKXwwXKqsfuUu29vfcVLDwN6hWMPGhvIzj6N96A
	VFzPeQnzVO5+K3ANmB83mA9/XNthEh02t451SnA9U9Tr8Z5TqWnnc+eAPeA5MvFn324gzOMZj6t
	Cn2bAq/yCcVOiENaVLscLDS/7+bEKdiqjnhMlyUC/HZcDdTA+gbjBHzi+BZ/C1CdhXW+T3ypd7O
	XjLp4U2y6Zw8gJoLm+astFSMzHVwtuQCtxx8u1ctEHr3zVJIL0zf0sk3Z8ZNtKmk1jjQj6xJdmP
	yBWT19spamlbaBOazKq2uBFewz2Fm42kIC8p7/uJ9OZbUGOLnl/0nV9mT45r9qdr6FLALcBJrt6
	rUegjDZufRiYq/owWIeDmX2nxvM39NJm/LbYH2HgDxuf3bbjnlQ==
X-Received: by 2002:a05:6a00:4909:b0:7f7:1fcf:689c with SMTP id d2e1a72fcca58-7f71fcf69d3mr4683893b3a.9.1765778098680;
        Sun, 14 Dec 2025 21:54:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE966N7Oe3FYB9Ygha15iCWE5PrCNEQSbD/T0JrM44KTdQUsyD3mTxS9KuJWZ4khGMwT3U8QA==
X-Received: by 2002:a05:6a00:4909:b0:7f7:1fcf:689c with SMTP id d2e1a72fcca58-7f71fcf69d3mr4683888b3a.9.1765778098358;
        Sun, 14 Dec 2025 21:54:58 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c5093a4bsm11405855b3a.50.2025.12.14.21.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 21:54:57 -0800 (PST)
Message-ID: <c41a18ed-f282-449c-949c-17ced2e92790@redhat.com>
Date: Mon, 15 Dec 2025 15:54:52 +1000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sea_to_user sefltest failure
To: Sebastian Ott <sebott@redhat.com>, Jiaqi Yan <jiaqiyan@google.com>
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Shuah Khan <shuah@kernel.org>, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <1478ac09-8134-5551-13b6-c7be096262af@redhat.com>
 <CACw3F52i_Yr+8Gd1=H=EMi7NnVJ8WCgMkaG1dSe8FD7PvOsW8w@mail.gmail.com>
 <c44b75bd-bf54-0aab-78a2-89f448cf126c@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <c44b75bd-bf54-0aab-78a2-89f448cf126c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/25 4:11 AM, Sebastian Ott wrote:
> On Thu, 11 Dec 2025, Jiaqi Yan wrote:
>> CONFIGs seem alright to me. Do you boot kernel with cmdline options like "default_hugepagesz=1G hugepagesz=1G hugepages=64", or dynamically set up
>> huge pages via "echo 64 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages"?
> 
> Neither of these. When I do the test is skipped:
> # echo 64 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

The backing memory is tied to 1GB hugetlb pages which are available on 4KB
and 16KB host, but not on 64KB host. So I guess 512MB hugetlb pages shall
be used on 64KB host?

> # ./arm64/sea_to_user
> Random seed: 0x6b8b4567
> # Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
> # Before EINJect: data=0xbaadcafe
> # EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad, einj_hpa=0x80241234bad
> ok 1 # SKIP EINJ module probably not loaded?sh: line 1: /sys/kernel/debug/apei/einj/error_type: No such file or directory
> Bail out! Failed to write EINJ entry: No such file or directory (2)
> # 1 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
> # Planned tests != run tests (0 != 1)
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 

On one of my machines where RAS feature used to work, the test case passed
on 4KB host.

host$ cat /proc/1/smaps | grep KernelPageSize | head -n 1
KernelPageSize:        4 kB
host$ modprobe einj
host$ echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

host$ ./sea_to_user
Random seed: 0x6b8b4567
# Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
# Before EINJect: data=0xbaadcafe
# EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad, einj_hpa=0x400081234bad
# echo 0x10 > /sys/kernel/debug/apei/einj/error_type - done
# echo 0x2 > /sys/kernel/debug/apei/einj/flags - done
# echo 0x400081234bad > /sys/kernel/debug/apei/einj/param1 - done
# echo 0xffffffffffffffff > /sys/kernel/debug/apei/einj/param2 - done
# echo 0x1 > /sys/kernel/debug/apei/einj/notrigger - done
# echo 0x1 > /sys/kernel/debug/apei/einj/error_inject - done
# Memory UER EINJected
# SIGBUS (7) received, dumping siginfo...
# si_signo=7, si_errno=0, si_code=4, si_addr=0xffff41234000
ok 1 # SKIP SEA is claimed by host APEI

Thanks,
Gavin


