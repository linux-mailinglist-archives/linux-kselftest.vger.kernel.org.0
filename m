Return-Path: <linux-kselftest+bounces-18394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7059870BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591BC281D2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B31AB6E3;
	Thu, 26 Sep 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfdoMWOO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D4189509;
	Thu, 26 Sep 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344345; cv=none; b=JWsS7dWbdcWcYzQDbboY/CpA6HNv88lAm83/Iw4S9hBoVs/23j3cTISscMeLPBjM5EUewUyyj776QHeAfXMOS4zu3equscym+jrd/8iiG2Iavrlv4gncJa0Bcj4dokNRjQK7jR4/dG+xoFoPSn81fr0LBvaw0vDCe3uthwOlrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344345; c=relaxed/simple;
	bh=yZFc2DYfsGluZTXNOiYfeHuR6VWhgbRBOI4olWxsvis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di94c1qSELPpGqtaSfaCKJVmV1d+1CwcwWiyscW8S1Hf0udHv6tdHKDnDBfq3YMeolDlwmJ+j+X+McLnoC2GzXVTUO5oCjG7edkqbuMgSTYDyjglkZwZZEPX3efIfNUcd4xFLUpGVTSwFkrBs6DZyFQax199nySwYHEpD77iX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfdoMWOO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1447101a12.0;
        Thu, 26 Sep 2024 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727344342; x=1727949142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEypOx7pACJ1pldoAKbaM/8U6Ia3BeCPrlCZA3BPX2U=;
        b=jfdoMWOOOCYbjGMso5uZbd6IOutRwb5LS9J1iUKzEjyq8NIMC2hCX1AQ7Hv3RGevyP
         u4Ono83r8p19BPt81bCcuoBS+dY4bEp0eQEortozqCB2PFYdOVHg1LX4mkIeRkAKIc21
         oMuocZlq465M1DXoe3x79WsvcAc9xpvfU+Pu5AGIUoRqCA1oGgfhcg51E6Wv1koXZtm0
         D6U331vBKCnS7XLjxAV2Ul4pFP5BhVf0qoo2QPpcrDknLYAbr8XFwZDfsJvbFFz4LYBm
         S9lrthvuudaaputP2eHX3vvLbl4OePBi9SwCSHJfCLIIF6y9qTqsGUdfAEsduCbjaqMn
         PDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727344342; x=1727949142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEypOx7pACJ1pldoAKbaM/8U6Ia3BeCPrlCZA3BPX2U=;
        b=KUlGm1dyiCrvMjcBC3umueyDsPaUZxIT0fWPFmJPwpvKKpschnpG66kcPIHPLon5Q0
         3yF4IPVr5T07wSJ+9TDwsP+i2Eu3qlRGOu6+qlCd76EsgZ8vlarfwsNEaoNVC3CTSdh1
         fx0xG1bI2jTJ3Nn9+abxqHJa9S/wTMXxSPsfZJkvfJFs28TBngWo9oEfhSyelL7+vksj
         VRYpR9HlBfDG7HUZxHBSCkmUzNMOQYdBN3ZyiO/igrVvMNWynq5+efQPysQfa8LqHcu8
         v28SYZvf5H7dIzDCIZHqZXqcWbgp3EfYZMWRxARidQOuUb5yLHWBCgdmLZXWB2IVKdVW
         TtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF1BCFa9wUw/RGgWVuHAV13nOdDMnZSxVd6+078ZFxnGAsPzVlLag2k+0iQbrs5Xuftw9ccLr05+KOWQ==@vger.kernel.org, AJvYcCXa8Rp//D84ar3cM0xgKtSq0T5yH5y9a8txanfaEH54aZmgp/vm0QNSmaRLdSKY19QmQPoC0XosaEHHeV8=@vger.kernel.org, AJvYcCXmaE5fcSEIW/rD0J0x9lTZm5l0cRVG8W7Fd+SJZRIWlb6mi94D3qYq7mVIslSjZg755F2ybwLJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBFU2+ZsqBVF0PgKZb87NheTW2vEoWlQPPAIww05PYSk3qBWi
	lQ2uKvUOy50wogJejpqRADuwp8ymAgRo/7C4RVKTeeJTA654Gn7B
X-Google-Smtp-Source: AGHT+IFBa8H7U+B09fxkkx/DjtN54sGUPrDgiy0rQT/q65a9PuxkPQXWu9PINaowt/5DqsNbXKkzfQ==
X-Received: by 2002:a05:6402:230e:b0:5c3:cc1c:4d9c with SMTP id 4fb4d7f45d1cf-5c8777eae4amr2213065a12.18.1727344341797;
        Thu, 26 Sep 2024 02:52:21 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:4e5f:6907:8e4:4ed? (2a02-8389-41cf-e200-4e5f-6907-08e4-04ed.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4e5f:6907:8e4:4ed])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf49d23asm2956451a12.41.2024.09.26.02.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 02:52:20 -0700 (PDT)
Message-ID: <f54a53f9-e2e7-488d-b69d-250251719c7e@gmail.com>
Date: Thu, 26 Sep 2024 11:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] selftests: add unshare_test and msg_oob to
 gitignore
To: Paolo Abeni <pabeni@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>,
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
 <327e2020-4cb6-469d-87a4-dddc0bcf7ecb@redhat.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <327e2020-4cb6-469d-87a4-dddc0bcf7ecb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/09/2024 11:32, Paolo Abeni wrote:
> On 9/25/24 18:41, Shuah Khan wrote:
>> On 9/25/24 06:23, Javier Carrasco wrote:
>>> These executables are missing from their corresponding gitignore files.
>>> Add them to the lists.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> ---
>>>    tools/testing/selftests/core/.gitignore | 1 +
>>>    tools/testing/selftests/net/.gitignore  | 1 +
>>>    2 files changed, 2 insertions(+)
>>>
>>
>> Can you split these into two patches. It will be easier
>> for the net patch to go through the net tree.
>>
>> I take the core changes through my tree. net changes go
>> through net tree.
> 
> @Javier, while at the above, please split the changes in two separate
> series: one for core and one for net. It will additionally simplify the
> patch handling, thanks!
> 
> Paolo
> 

Hi Paolo,

as I have already sent a v3 where I split this patch, I will send a new
series with the patches under selftests/net from that v3:

selftests: net: add msg_oob to gitignore
selftests: net: rds: add include.sh to EXTRA_CLEAN
selftests: net: rds: add gitignore file for include.sh

Best regards,
Javier Carrasco

