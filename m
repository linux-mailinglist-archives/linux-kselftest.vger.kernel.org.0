Return-Path: <linux-kselftest+bounces-18433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0661E987CE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 04:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871B7B22609
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 02:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38A16E895;
	Fri, 27 Sep 2024 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="R3IQC8x6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B25166F0C
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727403086; cv=none; b=F566O6l7lmS1nU9Bd0Ejegx6Gj/XD8Jb+041wyX/R/qUKFV2JPVMw/yW2SbJFPW/F18IJ3QVzKPl+J9R68qepGsmKbKPBus/x/M59Mda4URCL+EfBmlHn6qGAYmLJDlcXQQrM1TdsoTpl17nsWOyT8bgMdSjNYYkcDGdLouvvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727403086; c=relaxed/simple;
	bh=z2u3XIUIO6fq3zsKBJpUIQZilOD/xOQQm7u9WYiUdWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICBW0l52njywxz66+/YvSvXUQMAO7keFWpk9BlfFbjxQYB4jdIMoeneE0rDOuTlUvLGPDHcdCRLQy0A5lfqXtc854GpKMAo24KyNxHS+IK6E6RC1TUmNHodtPx0f9HvzkC4asrOdVS5+EAinaGbwM/ci6JEYtVMDpexRDqORNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=R3IQC8x6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso1314885a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727403080; x=1728007880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uf2tPCUdEA01GCYGd4noA0WD0ijkHEkhZlFEu8nmNFY=;
        b=R3IQC8x6Bcu4TPK3yCuQKMEcOAruWM0FQDmDaOnAyXyNaU1iZVkTGtIJfZpD/JFTkF
         gSZzR5nnZ2m+JXiSNYh8mnFSqOsvMctpT+4qV+uCeVc1DJEoeuVVaNQzqmQgZi/B5vco
         9IjRUqU0iytNbdwo2awIXQjF5DMBWG+i1Tle8Q1T3K90SwjqBybFfNU7f+z3AJu9LwoW
         MhWhh4ZXuygLFjzHpWlfFbKnsjazY11p5yc6/5SJdX9OQrmTlUOvUOAgovnck4km9WdJ
         R+2yQonls0SBjqxWZJBI7a8Y9zRbRL0xzxaHS2/UJjbevJ2o6yUD7CJ/gh55QPg2975+
         zYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727403080; x=1728007880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf2tPCUdEA01GCYGd4noA0WD0ijkHEkhZlFEu8nmNFY=;
        b=Ocfkn1UtAcNpMR9kMZKuzwa5ZjLmkU2uJ7E0argLsIrPmrLFJ8XL2BPHYwG6lrt1gW
         tw8tthN4vpn6t9/ZEBxDt0FZDhVtCD9uEtWhAwbccKz80jrgzaN6byHSFbAEcQBxAXqz
         eAygqli7o5IlhsmWs0YkDisUiSYtJ8ULE0njIFLlvhKVT+6VFtJ7dWnrMycYpJt/+V1h
         XiHSEptJwrVJwmCJlsDNCJ5ocPB3C3+yM/vFkH6Z0bLkCDZD99LJrFPiuFtF3E404m8R
         gRlsq3Q4oAjdkBKhnWnMWkfZZxZkf2iEfaHRTi3LZoDXRtnzBkUDdLjchv49c0A87WC2
         uYcA==
X-Forwarded-Encrypted: i=1; AJvYcCUe9S0VCI3ePk9sMHXxfITjT3UPEwjodKiG+QlcCeU2NctIk548W6pNVoTgppUk6y7/Rfu6ZDTxDLCGwXGF/7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi88OJMRH31eyq5dwctN6sFU9HNtfiQ7A4OGPmqeTi8wT8Tku7
	Jxcwzcj7yANLYiOxzxpsAwg6QRijjY0qVFQNFqXU2dmFW0mR9twn1tjsQl27mDI=
X-Google-Smtp-Source: AGHT+IE7cjRrb25dzMXmo+VfgnfSpwEWOl/UW7HQEnq4EHsE9dGMvjEK+lxgfFogzB4DCdWpnrgmFQ==
X-Received: by 2002:a05:6a20:4ca6:b0:1d4:fcfe:e1ee with SMTP id adf61e73a8af0-1d4fcfeee5fmr1089565637.9.1727403080438;
        Thu, 26 Sep 2024 19:11:20 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc1a3sm559085b3a.75.2024.09.26.19.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 19:11:19 -0700 (PDT)
Message-ID: <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
Date: Fri, 27 Sep 2024 11:11:15 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
 <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/09/25 12:30, Jason Wang wrote:
> On Tue, Sep 24, 2024 at 5:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> virtio-net have two usage of hashes: one is RSS and another is hash
>> reporting. Conventionally the hash calculation was done by the VMM.
>> However, computing the hash after the queue was chosen defeats the
>> purpose of RSS.
>>
>> Another approach is to use eBPF steering program. This approach has
>> another downside: it cannot report the calculated hash due to the
>> restrictive nature of eBPF.
>>
>> Introduce the code to compute hashes to the kernel in order to overcome
>> thse challenges.
>>
>> An alternative solution is to extend the eBPF steering program so that it
>> will be able to report to the userspace, but it is based on context
>> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
>> and vhost_net).
>>
> 
> I wonder if we could clone the skb and reuse some to store the hash,
> then the steering eBPF program can access these fields without
> introducing full RSS in the kernel?

I don't get how cloning the skb can solve the issue.

We can certainly implement Toeplitz function in the kernel or even with 
tc-bpf to store a hash value that can be used for eBPF steering program 
and virtio hash reporting. However we don't have a means of storing a 
hash type, which is specific to virtio hash reporting and lacks a 
corresponding skb field.

Regards,
Akihiko Odaki

