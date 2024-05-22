Return-Path: <linux-kselftest+bounces-10594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D528CC9BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 01:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F84D1F223CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 23:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1567E14C5B5;
	Wed, 22 May 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQNtH6Rh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC001824B1
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420989; cv=none; b=tHcv0hbDdXJs2jQldY0mLwwo6MhCqHIBlTZ9tZqnXFxMi5muy1cz+htt1QKjgh5DmK+MiZuKvxVl/4G5CoD7Ik4Yyh65zK1wg5qdyQu5mus6R06AQeKy8sCMXR0V+C+QoyPEp/xN/N5ApmOWsxmxXe22b832pWUUkQXj/lc+RQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420989; c=relaxed/simple;
	bh=eeVd8qPeHXjlun57Uzuk+SFjdiM2OMztLQecXhO4QnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT9loFYz1NBZexEIYY+7zq40ISSwVENtcPCbqpGcBLbcLHE+OXQTiUr6Mf6BB3QpzV37drO5dPHkmAfLsQvn2h5Mp5+uMXYqNePYR56E7hermAePsTE8ed7OIu3eXqlEOmmAE+GO/WuDakKkn+ATRnVUSrWOYNKaU2pRwkXl4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQNtH6Rh; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so3931235ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716420986; x=1717025786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxGBy+OPXkVQsg70GHc4dBA7DwixWSOZ/j8bxRcEzyM=;
        b=EQNtH6RhnMQVt95nW44fyUQeLAbbyRMzrgtdxNF1oPLCn5OY2JtxCKbfI7X/GG6BlP
         YJ4yP2oVCEzmh0CgSBzZD2mKzLr/W3eQLC7XEKhWxA8zNjGMEMZoKDbGducOwzS+2dpF
         svnTF26JxyaTrvhcwLZp/bWyEDC8VAYSIBCjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716420986; x=1717025786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxGBy+OPXkVQsg70GHc4dBA7DwixWSOZ/j8bxRcEzyM=;
        b=aECXggi2GuDS1JMAExu5DkQF5vNwGhD0dMgcOwt7JdBcNV6fQvtrz9n9+eMGG9wcZD
         tVq8pDgWfUb5lyi3LJJam+5E5ABNx/98yqXl6/TEClIuc0Bo0GNBMTHy4i9HIwFOOPQH
         d8ZQsSaAHUKhatTIMmY1a2kJp0ctvD53VC6ab+J1opf57wZ2MstrlDq/i4o+Tw4AAMCG
         pB7MTIlG6E0U2uLHte2dyfnqQ0qDI5QZ2MXWLBIboZTcevyKKSsUyXGZRJvpebpIFCSS
         3ATJ5OoEdxeAPMckEB6RTcPHc0oeyFqINRplPOFkagdWNEpeCv2t1Hb7r7dBRPzf3AmT
         JyUg==
X-Forwarded-Encrypted: i=1; AJvYcCWlXF4VLQGmV+PUwbG7m/BLjdn6o5rYdMvB626a0ms8qoXYGVk1ogWApgrpa4T8jKwvkBKSu0jeKGEu4iahGsb1f1ajE4jPTzYJg72Eedol
X-Gm-Message-State: AOJu0YyZA1039IrDIvjrIjmSf44UU8R7uX2wJGFWQewAvLE+JXKSkqFp
	FjpKmbuwYcMExd2Skrv80YDJKhAs1hXgHIkFZnOkW3YtLInhQ740SfJaXdRLebI=
X-Google-Smtp-Source: AGHT+IEtjCdVroZaUVcNGRtUK5AuBGREUnts03x3VGGBxpKu0QVXWygNx3tOfnTDzg2xubxhKgFDyA==
X-Received: by 2002:a05:6e02:20c2:b0:36d:9ec4:54fb with SMTP id e9e14a558f8ab-371f674c2fbmr37234675ab.0.1716420986020;
        Wed, 22 May 2024 16:36:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36dc81b6747sm32595975ab.11.2024.05.22.16.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 16:36:25 -0700 (PDT)
Message-ID: <29c1f444-6c58-48b2-90b7-a17ca22ad309@linuxfoundation.org>
Date: Wed, 22 May 2024 17:36:24 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
To: patchwork-bot+linux-riscv@kernel.org, Edward Liaw <edliaw@google.com>
Cc: linux-riscv@lists.infradead.org, shuah@kernel.org, mic@digikod.net,
 gnoack@google.com, brauner@kernel.org, richardcochran@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
 <171642074340.9409.18366005588959820799.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <171642074340.9409.18366005588959820799.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 17:32, patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
> 
> This series was applied to riscv/linux.git (fixes)
> by Tejun Heo <tj@kernel.org>:
> 
> On Wed, 22 May 2024 00:56:46 +0000 you wrote:
>> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
>> redefinitions of _GNU_SOURCE from source code.
>>
>> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
>> asprintf into kselftest_harness.h, which is a GNU extension and needs
>> _GNU_SOURCE to either be defined prior to including headers or with the
>> -D_GNU_SOURCE flag passed to the compiler.

Hi Tejun,

Please don't. We determined this series is no longer necessary.

With the patch that Andrew applied:
https://lore.kernel.org/all/20240519213733.2AE81C32781@smtp.kernel.org/
make its way to Linus? As you say that's a much simpler fix.

thanks,
-- Shuah



