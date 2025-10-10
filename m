Return-Path: <linux-kselftest+bounces-42964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7ABCDA33
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 16:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0E1E4F016D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445592F747B;
	Fri, 10 Oct 2025 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnHU/lEU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A321A95D
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108198; cv=none; b=ZQ0bFmo7CeLMH6AU7kYE8uc1Fy7CdcmQ799Vf3LJtueqSKQfQ75YnTUWsthN9+sNrqFgQOzRmIooI+7qdpjbTJn2qEcIe9IznhPvvQothIGAHQQczeIfsLQNQyi41ywnGg1l/f+hirYLhhf/r1/YdSipAuykANo199wAnUhAYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108198; c=relaxed/simple;
	bh=1Jhcg0xv8VWaEgihjzPeUziID4oG3ExKtqP9zC0KWCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9SzwZxPfwm+FftTd9fWlq+DN/+6mk3CyFKC5Sl6jqWrDp1JuZY1+pE3eyBUcO2b9bmjzAMDOyzxn6NHaJFM+eIdo/7O1Q0oWqmQ7wf9NwQ8ilBuUyb1Dj4McBekoIBQAs2gA1Ru1LoTKCEWbtHgxPqlxf4n/8AVIa0hCFW2EQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnHU/lEU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760108194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1P5X+NGWefQQJqZl15++e1LnM8GbiR8ChaM6QOBRs6E=;
	b=VnHU/lEUMarqMKZGXISFJSNs2O9utbb6/GGG4sc5Ki79q0NxyDtacUfTW1bcGJLZxAZ8Md
	efwJ4EjDVs66JreqLFc1uggKTJBDiWB9CfO/uKJbRopTZZyIQKRpIaIH/LCCK3ClHiie1s
	u9zbFUbl7fPGd6qfgQQJwosp3h37rTo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-uxu8UESzOMKR2XOeboTnkg-1; Fri, 10 Oct 2025 10:56:32 -0400
X-MC-Unique: uxu8UESzOMKR2XOeboTnkg-1
X-Mimecast-MFC-AGG-ID: uxu8UESzOMKR2XOeboTnkg_1760108192
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b3cb0f2b217so410252566b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 07:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108192; x=1760712992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P5X+NGWefQQJqZl15++e1LnM8GbiR8ChaM6QOBRs6E=;
        b=IP5+Ajq5oOMobq4HfO/MlF1RugSra4B2YZIJFErjfpO3Lt9YPXVri7ZvThl99wuXib
         /Lfg7ym0c1pMgu+dOAflFfqu15yXY2mpeZgdfwR71JFPZ+wOvr1tjGu52Ylu33S8YTyw
         AAqzg3BK7IszGcrzfqQdvttGKlhehdz5xtNhM/R09OnjxUIpdwDWKKYr7mQ68/ir9RF4
         rsNDrNkuvoak+ztgjh5vXDNWA+YW0/zsf8wy0JoVI5WAv0UVgsupYgIR+Y7tP0ZbGKrL
         9Od2rrb/1n5E+XAc6oRkcmhcYYX/Lq/R7T2w7WVbuI2VP9DCBWrMxQVa4j31aC3CDqoN
         gtUw==
X-Forwarded-Encrypted: i=1; AJvYcCXRDCZWPmApDtvxSlHLWGZHtlUmqFJfQcIMHZtdEKF9UctelGvm99FCO9vKWJ/CZOEVcVqrW/6wSeBHPihkmjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRmYk5s/Fv8CYHg9C9sqkhAKgGBC396r3DwqJELKXF+62oTxA
	j81UOJg3PJKWqrrKYUFopesUY9SL0Qq450/gDB/A8ugIKkaq4HOgx6fTXkVFfVy3ryjDmHLhH7e
	qGTwxObn7aNH2EYq2eTmuRAB/begjMxpWTKzkTTZbKAuOAh0vyihYDr6PGAt5VGhrgWQVdA==
X-Gm-Gg: ASbGncsI+NYqbWRUEuOcZn9IiQAvxqal8VXi4NgAYtlOITbTvnkdgW72rCVnsrLYl/6
	0vjvVspl+KCD36245EE/Vgczjc+AMtNNWJXKljiWPKt+Be/OUn3tjFY8lPN2kxYaBvlTyGUg4tO
	7i0qG9Ej+xCB1pvqi7Q5/0SfuZEuTlh4/PDeJ9YYS+dvTOb6ScjCbhTTkuHzZ+1cpycUZVz5cDN
	uuCmkot8cpKh7WDA1ylWTkL6/TjirEoFgDbmzFVIYAde6lulnd/G6ybB+f0+fgQukxKQXNEhVrG
	Uj0VWVXQ5pfRU5JaXDHREqp88O+RH4COkWmfsajFiy3xurL8yDKFiqaMCpAkxCDnJdsOHav0WiJ
	N6CGOmBEExJFy
X-Received: by 2002:a17:907:ea5:b0:b3f:f822:2db2 with SMTP id a640c23a62f3a-b50a9c5b35emr1276357066b.11.1760108191606;
        Fri, 10 Oct 2025 07:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9U3OHPHv03/njQrGc9l3W5M5GCK0ZytbxV4E62A/ghGcguoBHcO5uBfWotYvFJEwS98Ry+Q==
X-Received: by 2002:a17:907:ea5:b0:b3f:f822:2db2 with SMTP id a640c23a62f3a-b50a9c5b35emr1276355066b.11.1760108191199;
        Fri, 10 Oct 2025 07:56:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacbeesm240224566b.15.2025.10.10.07.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:56:30 -0700 (PDT)
Message-ID: <bd3149e8-e213-48b0-8f8a-0888d1837b84@redhat.com>
Date: Fri, 10 Oct 2025 16:56:29 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: check jq command is supported
To: Wang Liang <wangliang74@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20251010033043.140501-1-wangliang74@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251010033043.140501-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 5:30 AM, Wang Liang wrote:
> The jq command is used in vlan_bridge_binding.sh, if it is not supported,
> the test will spam the following log.
> 
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # TEST: Test bridge_binding on->off when lower down                   [FAIL]
>   #       Got operstate of , expected 0
> 
> The rtnetlink.sh has the same problem. It makes sense to check if jq is
> installed before running these tests. After this patch, the
> vlan_bridge_binding.sh skipped if jq is not supported:
> 
>   # timeout set to 3600
>   # selftests: net: vlan_bridge_binding.sh
>   # TEST: jq not installed                                              [SKIP]
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

This looks more a fix than net-next material (and net-next is currently
closed for the merge window).

Please re-post for net including suitable fixes tag(s). You can retain
Hangbin's ack.

Thanks,

Paolo


