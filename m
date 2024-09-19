Return-Path: <linux-kselftest+bounces-18124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E798A97C56D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 09:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FB41F23A3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645841990BC;
	Thu, 19 Sep 2024 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXRP77Lv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759A198E6F
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732673; cv=none; b=CiLiTKR1Za3ht1k2LRDdxVeJO5IzJwtXNExKYP3G2OW3tEuxNPslT3dRZVYXCVknZz2mFAXpJMs8z5uBlEeXJkUcTqxnbVEWLtGkMv6i13oFsUlLS0MIh4EKeQjktPVH9xoo7FkAVBcfBwEL5K7tDQfDbMFANDrCy6q0BwFpBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732673; c=relaxed/simple;
	bh=WjTR5Fl9rB5SyxIdjvbDVCUkIESWrZgHawZRIoKkHas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLsZqR3wE6WWwth3bOcGxyibplCPrMKLJfLSUxZfLDpJD+kLysrUtmW7sMBktw4cQpdWkOlvVG5NhwqOWIao2tKu4c1Fm0QA4LBR8xP1eN0Vaf7vmrvJFLVSB9cW0VL20cIUP8wTcHE4zMtdHuGErnoPVf1/ujE1joVgIPKWh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXRP77Lv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726732670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BveYqjoEFbQN7A9EhNP5LD7TmPQnn8rjTb0WXfJDJ+s=;
	b=eXRP77Lvs5hRHL9a930oqUoetSVZ+qVpFq2WFn21OtvqwBIbpWvg80XP0gLDenh8OMSzJi
	DnmVi4gHD6RoJeEA6aip/iCHb9YUAFFF9MGOrXr1JTQ2KwiN05kNBRzQ6kaEwkDPvTb20d
	Ra3FAk0klK0DQfHh3YSv9SJgcBQwRqg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-9W2QTpflOU6fuS79tNY1xA-1; Thu, 19 Sep 2024 03:57:49 -0400
X-MC-Unique: 9W2QTpflOU6fuS79tNY1xA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374ba33b2d2so185279f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 00:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726732668; x=1727337468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BveYqjoEFbQN7A9EhNP5LD7TmPQnn8rjTb0WXfJDJ+s=;
        b=kHf6e6z2NFAruCRL7fJaDbZRFui+q6xB5H9BYt6II4qwZTH3dfbN0E7nw3LqOOwGKy
         yo2YI55ZKQf1JtcCRDMS7+F9aNgrmWsQ5wOPAgrVPpgLEl+3Iw/szd6onKNtLNprTjps
         D6sCVvFIkxl1kwnpwdyphHrsbOGwwG8N7SKRvuWaQbnXS8NWzbUL1tAb7wM/+nXjCBeW
         vO9zy7mUzmtAhrp52hPYBehW1QkTOaFDrCUsyFx5EkodcMINosVyXsa/2qkydOhybCMc
         nJJotqNtuC8rBWtvgCmSFFIdLqSsm9RJbwTZBuEfrxdjo93ocS4wYqy5C8KFvzxLiPtW
         dW4g==
X-Forwarded-Encrypted: i=1; AJvYcCU6SOv/DGxoUzs6UGAuh0ZpdxvphX9jhpVAmq/WZZFsCphgAEJSQGrtPi0eUYeb83iLEh1dVlboYaUVz+S8Lzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwKDlobHXCTflsutWzWieQDIsiaoQKV6PIJRuXbqaRv88V6TR
	OILkIg2fKxIL4WsXzELUR3WnkrsbiXvPrD3YQX5BvW97gQWMATtwcJOEXWDyjKMbgGWjOhn5Inb
	akGEQe8+cfDbSoa1O9ExvzbydodeYwW2XDZ/h4vYBrlZiv42k7EYtTumKVSYKtHOBwA==
X-Received: by 2002:a05:6000:18c2:b0:374:ce15:998c with SMTP id ffacd0b85a97d-378c2d1345dmr12838605f8f.30.1726732668060;
        Thu, 19 Sep 2024 00:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjcuNBkqYHoctjpvy9L9izSMqtg504D/BPyWJE0SJlP13gf5PTW3zCH/yMLyXpqgIpClOBOg==
X-Received: by 2002:a05:6000:18c2:b0:374:ce15:998c with SMTP id ffacd0b85a97d-378c2d1345dmr12838590f8f.30.1726732667646;
        Thu, 19 Sep 2024 00:57:47 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f0529sm14653556f8f.6.2024.09.19.00.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 00:57:47 -0700 (PDT)
Message-ID: <bbeb8c77-1772-45a2-8626-a4e064ab7c54@redhat.com>
Date: Thu, 19 Sep 2024 09:57:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: ioam: add tunsrc support
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240907164245.89627-1-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240907164245.89627-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/24 18:42, Justin Iurman wrote:
> TL;DR This patch comes from a discussion we had with Jakub and Paolo.
> 
> This patch updates the IOAM selftests to support the new "tunsrc"
> feature of IOAM. As a consequence, some changes were required. For
> example, the IPv6 header must be accessed to check some fields (i.e.,
> the source address for the "tunsrc" feature), which is not possible
> AFAIK with IPv6 raw sockets. The latter is currently used with
> IPV6_RECVHOPOPTS and was introduced by commit 187bbb6968af ("selftests:
> ioam: refactoring to align with the fix") to fix an issue. But, we
> really need packet sockets actually... which is one of the changes in
> this patch (see the description of the topology at the top of ioam6.sh
> for explanations). Another change is that all IPv6 addresses used in the
> topology are now based on the documentation prefix (2001:db8::/32).
> Also, the tests have been improved and there are now many more of them.
> Overall, the script is more robust.
> 
> The diff is kind of a mess. Since it's "just" a selftests patch, I
> didn't bother having a series of two patches (one to remove it, one to
> add the new one back). Let me know if you think it's necessary for
> readability.
> 
> Note: this patch needs this [1] iproute2-next patch to be merged
> (waiting for David to do so, should be done soon).
> 
>    [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=884653
> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>

Unfortunatelly we was unable to process this patch before the merge 
window and net-next is currently closed. You will need to repost it is ~2w.

Strictly speaking about the patch contents, any chance you could 
refactor the change in a more 'incremental' way?
The current format is very hard to review, and even self-tests patches 
deserve some love ;)

Thanks,

Paolo


