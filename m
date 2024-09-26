Return-Path: <linux-kselftest+bounces-18393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47098704C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A55B26E25
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D5A1AC435;
	Thu, 26 Sep 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIhWGNmw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7E224D6
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343177; cv=none; b=omulIliM2VHdWogr/gRXqTIyIExb6m9MBpNF8y8wNjcoq/2oG5vasvTqV4s6ps74FjkUe2CKI5tkfRcUbp2ZHrb5tcYf5FlThnD1hUl76/3lWT/zvnKM7o5SJcWr58w6IIBcVydto8P3vTyr2jdllbSquplueFADIwalZzFv6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343177; c=relaxed/simple;
	bh=9KLITEozZMuMw31UlUJPPVtzDHJ+Iw2+blshL/EsAUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFm3pA3KnblXzt94EQuVJOKu8l4UFt6L271G9r6f5gFCqjiTZhj20QDnOPIcza0hNr0Hk/Uze4sKg4SjwLPbLjj1sCug+64bsYGsf1vcaKaatn6eRdUqCHxxQnI176ilFiBlNt1YJU03I6iRLUOzc6qeREibz0Wk/Gj9BsYBKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIhWGNmw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727343175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viiv1R7Qk2EGD2osRa2/tRj2PEh5xjR8v8WEQ+l48h8=;
	b=ZIhWGNmwjW25nltg1CUm4P3NZzMD/z0M+R2FNc59E97OBxg3/SY2yxqThMPv9jc+2ALpBg
	8u1z5vZ6mNKEQl9YzTfn3d9x7LLN0Njn7s/q5Otbyom+WYdZHGGDhxiLs47AuDsUpdoDAE
	fSghQVWqlr+O3Izuo6xLBfedZ4jvKkY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-WncCzIgvOUKm9l0NAx-ETA-1; Thu, 26 Sep 2024 05:32:53 -0400
X-MC-Unique: WncCzIgvOUKm9l0NAx-ETA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb236ad4aso4333795e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 02:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727343172; x=1727947972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viiv1R7Qk2EGD2osRa2/tRj2PEh5xjR8v8WEQ+l48h8=;
        b=PBBaK9MHMeCwK885DnupbReN6a1mSPuSdpGIBTx8Tff3SEMRHs23ra3QFh+RqajAsJ
         YFRviXhtb43Dgjng+tngLn8YVJLOlkkmg1pmBEyTxVH9hsJjzWqMkzUzySVJKR0QkQJ8
         ABRZNR6RLJQdRLBhOSHdK2oD1S0vEOXhTGZ4qOgWNx7FrqjnCLOC7z4sD8f6Vuwmtp6+
         I3f8L1aABSs+WEu8OzRKgCkJVS024GNlStwyZVS/tNRViGYvlwKVzHONvSdUYY1GHdPk
         7Jh0jHLwYnI+FjSB936hW7aBzywJNd3fA8KrXpDil/z07hHJXP6Ndra1cxa700Nv9xjG
         WslQ==
X-Gm-Message-State: AOJu0Yw950pGFMi7JeboH1srTf9EeAbpnqNjeMFvULmwMnlxhdQWezsN
	O0r++2bhmG7p9uY8vqNmI4Ae0NKrw1R6izTaap5+XMmrEBVXXmpvjjsSTBBEqWWJB7QqvEVQ7hq
	E8H532DSvqGv0ZUZHc2m95voTT8Fzz3XRpLBTvEdYXHxxsjTaDAu4dAyeoE6k8JLv+Z4OefvKGM
	pF
X-Received: by 2002:a05:600c:190e:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42e9610c1bamr38128365e9.10.1727343171711;
        Thu, 26 Sep 2024 02:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENw/jaKF0ZTS+WW9dNaP+bfiB9Y+GVOoQJHXRbTb9+ASAmfl4wzmxgU8LlvJ332t4eckoI7A==
X-Received: by 2002:a05:600c:190e:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42e9610c1bamr38128215e9.10.1727343171327;
        Thu, 26 Sep 2024 02:32:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a168bdsm41800565e9.37.2024.09.26.02.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 02:32:50 -0700 (PDT)
Message-ID: <327e2020-4cb6-469d-87a4-dddc0bcf7ecb@redhat.com>
Date: Thu, 26 Sep 2024 11:32:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] selftests: add unshare_test and msg_oob to
 gitignore
To: Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org
References: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
 <20240925-selftests-gitignore-v2-1-bbbbdef21959@gmail.com>
 <62f52cb9-1173-46aa-96a0-d48de011fdc2@linuxfoundation.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <62f52cb9-1173-46aa-96a0-d48de011fdc2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 18:41, Shuah Khan wrote:
> On 9/25/24 06:23, Javier Carrasco wrote:
>> These executables are missing from their corresponding gitignore files.
>> Add them to the lists.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>    tools/testing/selftests/core/.gitignore | 1 +
>>    tools/testing/selftests/net/.gitignore  | 1 +
>>    2 files changed, 2 insertions(+)
>>
> 
> Can you split these into two patches. It will be easier
> for the net patch to go through the net tree.
> 
> I take the core changes through my tree. net changes go
> through net tree.

@Javier, while at the above, please split the changes in two separate 
series: one for core and one for net. It will additionally simplify the 
patch handling, thanks!

Paolo


