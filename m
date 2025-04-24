Return-Path: <linux-kselftest+bounces-31560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209C6A9B003
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 16:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02BC3AB313
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581CA17D346;
	Thu, 24 Apr 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0ithJRE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4DE143895
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503314; cv=none; b=oUXcaBaWoxL7w198L3+EEopGqs4JbPnPgiz4Ydp7IQ7LmLoWIPsW7HbWZ0OwAuwmwiO7PwyOqHacxV1UwA6ie/ryHtkYgxRg8PXjd8mkvJNN2Qt86tigyUHyID+P0ucjxeCWN0p+L6FjvLUDDOxKUCmqSlzHtY0T3ftYIEw8GxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503314; c=relaxed/simple;
	bh=iHaWxkVe1jcDxmKjyeB9B0qxKJcGSLsOrxx7NcTKk5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTvcDnRQ7hrEW3jzyoDxnSvzqpfRGlwu9q+lwSUJdh3Nw7Z5iTFbSuBg7BZPT4I93Vuw0lf2FxfLMW/Z9yTiN9T/lp1YwzVXcILQq9UFSFqefjivsE++Zm9i8D7NRuTpMtPO3V+eSW2P9cnzk8YVpOQiEyN1Th+zY3WHaL8/gio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0ithJRE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745503311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOKnMgaGWgwdR2hpccH9xono9NECksAJCZVK7cynoA0=;
	b=R0ithJREy+tv6dd8NQbVOK63megnEVsDNn3yXJV0WCmw0IFDjUHAG3WPGXbMJJHmYKsvUn
	DIYunwNXce4HYKkydmv9l0B5xpeKq+DrU1WJvinZMsNXKS5zTibT3iA6s10XWLnLoAuqwd
	vG6cOvPtIXXukE9HbobjfMqkocoAclM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-mmcEKMOPPm2mpEYOXpxrpQ-1; Thu, 24 Apr 2025 10:01:49 -0400
X-MC-Unique: mmcEKMOPPm2mpEYOXpxrpQ-1
X-Mimecast-MFC-AGG-ID: mmcEKMOPPm2mpEYOXpxrpQ_1745503309
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39123912ff0so351014f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503308; x=1746108108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOKnMgaGWgwdR2hpccH9xono9NECksAJCZVK7cynoA0=;
        b=d7yItu0Vvuf67Vkchh0uP4TwqjSjQCECJzSzi4AkR/fYjwhyhST3QHcJemcvaxMlD9
         pS5eUtcA2m+PcwzN//xzSnVB+TCIsw//aaFNJIxsib9cwsMe4mA6PiLJgmNbAFu3trt1
         SDw2VAv1XMc26n9bGJcMdiKM0u3EANkJUK0Xa0H1HbdifCr01Jr7LvuaDVStBj3iYB5X
         4pvu78gEYqm0QOUgJKs9FOYOdFvvNcRza2vBtOfQ8PpP0kqmJhcd2m8NRv0Kz7a3N0jU
         4vWT4pIB+Gvs9D0A27Q3/ReB3qvqiHUya/+ycbn+WjtHsXucfvGRvSQ0Z6XfvtoHk9B3
         6xaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEr8MQLZ4fo4cEKHnpQV5Ajq3ApDYZu0E3/oRKyy8eSvLxhOUaxAXEvZyt9G+MFsLCjd3o6rpHiGRGCEmBwRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Fftictwm+lzJ+wPQbo56CCZ1IcOUUQiSaiTkVIpBqr4MXuvV
	R23MnedZHfCmHbsZCsTNN8UookSCaBUj/C4Co+dIQ15SEI04tLWxYeRVV75Tpaq3w9VOX4O20dS
	IAclZ28jJGN/n/FwS2joGSUq1699/Y2G3qoa769MhpjeLgsbaTN8M+qNgKp+jm3jt2w==
X-Gm-Gg: ASbGncsVhsFclKittXkZsHb08vQfgEAf/mO9hYtWdjlMfaQ4F7gviLdhKERoQaRYumz
	26ESrXSAV1DcGh9zPJMrszUM+qNlz+noGpQYv7cTRuAfLK2QXIsaHUITp3MVY2BZQO8wUrO+775
	VDspGFyWlyA7Y6RlTnDvdptmDecOuj1JtqUASaQzHnBKk3gvLQg221FQIP6sHYswULvPPlD6ztG
	dmVKOh6bUSsLrnpap06+ZcltP5vAkbXo19JQQrKYgBXrgHCKOpOybdbwDTdSBN7qraDysu5oxOP
	Yy/y9bOBmfR1wPE96q9MKjmaxxNOmCdmUQlqCqSqBAhI
X-Received: by 2002:a05:6000:2913:b0:391:4674:b136 with SMTP id ffacd0b85a97d-3a06cf6372amr2063588f8f.29.1745503308321;
        Thu, 24 Apr 2025 07:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAR4VGYC0YQuh2Q6vs1FL6y3b/l/flUzkaCaAOT3x6mMafccI1LU527lzjQS8Ouuqipao9Iw==
X-Received: by 2002:a05:6000:2913:b0:391:4674:b136 with SMTP id ffacd0b85a97d-3a06cf6372amr2063535f8f.29.1745503307570;
        Thu, 24 Apr 2025 07:01:47 -0700 (PDT)
Received: from [172.16.17.99] (pd9ed5a70.dip0.t-ipconnect.de. [217.237.90.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d5328ecsm2193910f8f.71.2025.04.24.07.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:01:47 -0700 (PDT)
Message-ID: <c2729303-8ee9-4fe3-9755-2b6d0d0d7b97@redhat.com>
Date: Thu, 24 Apr 2025 16:01:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftest: can: Start importing selftests from
 can-tests
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqK8TdzzMW645OLq5tbkyQdYW+tGGVcr7vsRBE81_u4W4Q@mail.gmail.com>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <CAMZ6RqK8TdzzMW645OLq5tbkyQdYW+tGGVcr7vsRBE81_u4W4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.04.25 09:45, Vincent Mailhol wrote:
[...]
>> Felix Maurer (4):
>>   selftests: can: Import tst-filter from can-tests
>>   selftests: can: use kselftest harness in test_raw_filter
>>   selftests: can: Use fixtures in test_raw_filter
>>   selftests: can: Document test_raw_filter test cases
> 
> You are doing a lot of change to the original to the point that this
> is more a full rewrite. I have no intent of reviewing the first patch
> which is just the copy paste from the original. If no one else has a
> strong opinion on this, I would rather prefer if you just squash
> everything and send a single patch with the final result. This will
> also save you some effort when migrating the other tests.
> 
> I have a few comments on the individual patches, but overall very
> good. Thanks a lot!

Thank you very much for your feedback! I'll silently include most of it
and will only reply where I think discussions are necessary.

For squashing / keeping this as individual patches: I usually like to
have some kind of history available, but here it might not provide a lot
of value. I would be fine with squashing as well. If there are any
stronger opinions on this, keep them coming.

Thanks,
   Felix


