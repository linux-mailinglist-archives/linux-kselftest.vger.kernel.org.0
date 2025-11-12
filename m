Return-Path: <linux-kselftest+bounces-45438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D245C53DDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17C7E4E5B98
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E56D343D6D;
	Wed, 12 Nov 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCuHR/3q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvBBqqqy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED934846A
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970722; cv=none; b=YM6ihxqI9/zRm7YQUFVnf0Z3edqy2GG3EqlvhttZ9EKNMAQgbhPtmaMLga6y1l3aiQRMfVtqXwelg0pK+HAAjCFbajuqBDlTpeRPjaWQQ7nfHm0SSTShcf+AXMuob9ncs9l179FjEjIiUB8TSUI/B6CTT9CPqSZu+sy59wphyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970722; c=relaxed/simple;
	bh=ko5BbGl6a9fQFlBxeoKvlk91k6qFsjA2qTndHaSt7YE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bD4i4GgrcOZ+DyMJ3As4e4/h6NSs0R7wU/Ov9p0u4T0e3hlWDl9L6pn+HlF3Hyf6dATczh0P4MoSyHzAxwayKIimlk7OEWCN5YtP7GAbhgMYookWxL43FUVAFnGz/0FT6Je/QSKYKy0ID3RYTCTT0qgy5PQElPpp/oUZwN7BPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCuHR/3q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvBBqqqy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762970719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Zn2uqlOqkTGm+7Vhf+JluqFYrDljO4Zyy3TKQXkdTw=;
	b=FCuHR/3qXGnLB9pvrp2X3NsKGrGybR8DhnSIuJTocE09BRm+1vZ3SuNUdBfnt1Xy9nsOSL
	p2CMWLCAG24ZRIP0J1hBc6GOnf25gXN0+/ApUFL0Kv3vR/DJ78vO6RXQGT2ylefvox5uZD
	EanRBSdSCxF+JFl6ujNNDocJiDsFniI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-CSFNpUUXPsmn6hixd7xglw-1; Wed, 12 Nov 2025 13:05:18 -0500
X-MC-Unique: CSFNpUUXPsmn6hixd7xglw-1
X-Mimecast-MFC-AGG-ID: CSFNpUUXPsmn6hixd7xglw_1762970718
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b259f0da04so310841385a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762970718; x=1763575518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Zn2uqlOqkTGm+7Vhf+JluqFYrDljO4Zyy3TKQXkdTw=;
        b=fvBBqqqyTlsxOIpJ9UPap7LmW1Xe5fW9YUJV3oCBJ1KX1CFIaX5xqLNBDGrE7gge5Y
         O23qi8y+k/5Okr59fUf/XJ/xTSlxUh2UsmSta2Yzr8xtp33E0JCsZ3Wqjk4402bP3pQa
         N+dmz4M8zr/G0Y2E56IAN9pe3sJkpxUlNJ7hYJIpXEot8BZ6eqO+cfKWL+T3TWNneOwZ
         MaMEXMvUkwX6xO4PPRDYphpIJB7/+2tZhjfJ/bt1IIGUpN2TE4da2+m8Q3WHXkrgoAyZ
         OESEdmlcK0rpnVjrCSdbYp+Rax+vRgEbFheMfR/h1HpG9m3Z9n+jZR3RKTPKhBcxUQOW
         PidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970718; x=1763575518;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Zn2uqlOqkTGm+7Vhf+JluqFYrDljO4Zyy3TKQXkdTw=;
        b=DjKMTziew/p77WteIQtPLijDUd1aiM9ATc1hTT7KmGNwRsOmUG3STbKnMvFk/SB823
         JFBUkE2jpjQ26SfLp2tZlFBuLC7Ya7FJWcRRVjsDK6XwwMhgbgvj3fGd4UPG0XT81ew8
         g5hOdXEapW6EbKslbEBO20fmO3LGVpJNXMGvbn36Qz3Ao8jGOfjIfl7ocPaaorc3vEwf
         EoUI3iOiHjU1sZd5eGhMctAIDDgZ4flEiZifp7bRL2ygc7ovqTPr5y0ODCTRT+BaJwH4
         PThUuTMd8AzXFH5VCIiZPdJsZbDZf+AIkA3nikDwGJ9iDfsTg6jTA47y4VkQPgy+HYer
         04HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTTZvwdtpnTSbpLhvy9AkCtrU0+OiLhrnJG5NcukDOLxUF3YW/CBG5r1AuE5841gNyYiNrQEVrRfKX/oYKD48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXWIbC8sGwvnXxuQTUqHGkZam+dfH6ObHygxBz/zNo7RPfq3n
	lHYF9MN+J7jVi9RljqY96CaoQc4SYBD6MCBfAqhfpXXVtWDK8q7Ng5DaRcMtMk52xEdsr2H+hGD
	3rmP8X/xQ2uDjoMQlC9KS9iHROxnbS5WVL4I9h6j2DjRQqH/gW847dY7kkdY5dJk/0X23Sg==
X-Gm-Gg: ASbGncsdrawUVNV/JR555De3dR8wy+P6B63QZ3bBRhLuuVphlcGU3NnSCu2wAVgATnl
	Q8z4Fj81EAb58Q//eKv3sQY1x9ho1pblaa9XIF079J/LEBITysh9O9X1zbOcU8ZkhuHNoSdBuGC
	Lh3e/Ev1kDtEoN0cy7LO+1tpRcBNn5yoBw3Vhi3+FajACb9B5zBesGYHnHtYOaTX463592Wq39G
	tMEY2+MpP107VjmGEnOu7JWi7PTeTgWU8ywNyp5YysHPOmw6nQMLaWpcIBhUS55BMHdw/mWXlv5
	Xz73Qy1ExiXYgR8AS+7gD7hkH0vHDAgHpCsuy3/xrIRsOcQcZQPKuPCoyQ3cRtrwaXaQP7U4nyA
	I1lV7a2NbIeqfzr1+vqqmXzB4JnNaq+Z9ofCCJY2onUmDng==
X-Received: by 2002:ad4:5f49:0:b0:882:4f53:ed41 with SMTP id 6a1803df08f44-882719e6978mr55688786d6.39.1762970717963;
        Wed, 12 Nov 2025 10:05:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4IiIw+N1Z2Q8t2UVNI42KNkJKyBdYBTSzcbCJ42RBQAZsdIZ+JdFm9V5TA71Qksd6vDNtIw==
X-Received: by 2002:ad4:5f49:0:b0:882:4f53:ed41 with SMTP id 6a1803df08f44-882719e6978mr55688206d6.39.1762970717419;
        Wed, 12 Nov 2025 10:05:17 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b293a6sm95893676d6.37.2025.11.12.10.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:05:16 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <85f438b2-5131-4794-bb2d-09ca611fb246@redhat.com>
Date: Wed, 12 Nov 2025 13:05:15 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
 <20251112094610.386299-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251112094610.386299-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 4:46 AM, Sun Shaojie wrote:
> Hi Ridong,
>
> Thank you for your response.
>
>  From your reply "in case 1, A1 can also be converted to a partition," I
> realize there might be a misunderstanding. The scenario I'm addressing
> involves two sibling cgroups where one is an effective partition root and
> the other is not, and both have empty cpuset.cpus.exclusive. Let me
> explain the intention behind case 1 in detail, which will also illustrate
> why this has negative impacts on our product.
>
> In case 1, after #3 completes, A1 is already a valid partition root - this
> is correct.After #4, B1 was generated, and B1 is no-exclusive. After #5,
> A1 changes from "root" to "root invalid". But A1 becoming "root invalid"
> could be unnecessary because having A1 remain as "root" might be more
> acceptable. Here's the analysis:
>
> As documented in cgroup-v2.rst regarding cpuset.cpus: "The actual list of
> CPUs to be granted, however, is subjected to constraints imposed by its
> parent and can differ from the requested CPUs". This means that although
> we're requesting CPUs 0-3 for B1, we can accept that the actual available
> CPUs in B1 might not be 0-3.
>
> Based on this characteristic, in our product's implementation for case 1,
> before writing to B1's cpuset.cpus in #5, we check B1's parent
> cpuset.cpus.effective and know that the CPUs available for B1 don't include
> 0-1 (since 0-1 are exclusively used by A1). However, we still want to set
> B1's cpuset.cpus to 0-3 because we hope that when 0-1 become available in
> the future, B1 can use them without affecting the normal operation of other
> cgroups.
>
> The reality is that because B1's requested cpuset.cpus (0-3) conflicts with
> A1's exclusive CPUs (0-1) at that moment, it destroys the validity of A1's
> partition root. So why must the current rule sacrifice A1's validity to
> accommodate B1's CPU request? In this situation, B1 can clearly use 2-3
> while A1 exclusively uses 0-1 - they don't need to conflict.
>
> This patch narrows the exclusivity conflict check scope to only between
> partitions. Moreover, user-specified CPUs (including cpuset.cpus and
> cpuset.cpus.exclusive) only have true exclusive meaning within effective
> partitions. So why should the current rule perform exclusivity conflict
> checks between an exclusive partition and a non-exclusive member? This is
> clearly unnecessary.

As I have said in the other thread, v2 exclusive cpuset checking follows 
the v1 rule. However, the behavior of setting cpuset.cpus differs 
between v1 and v2. In v1, setting cpuset.cpus can fail if there is some 
conflict. In v2, users are allow to set whatever value they want without 
failure, but the effective CPUs granted will be subjected to constraints 
and differ from cpuset.cpus. So in that sense, I think it makes sense to 
relax the exclusive cpuset check for v2, but we still need to keep the 
current v1 behavior. Please update your patch to do that.

Cheers,
Longman


