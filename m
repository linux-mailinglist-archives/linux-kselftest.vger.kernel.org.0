Return-Path: <linux-kselftest+bounces-30955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A52DA905F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 16:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B348E6842
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB611FF5EC;
	Wed, 16 Apr 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="w1gCc6/U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B571DB37B
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812051; cv=none; b=PZMrmp3zZYE5Yl22rw94x3xFsV3nx9bD3llHQZ1w53gBe3U2My4ncn1Ky0YzpDyVGUP0wazlMR+o33eJrIrdYk/Ayef9UOseX+Mn8BCtHW5pA69tpXXoooMnn8FKb9LnmwduKt5Tsm541PBPC7SvvgXAp0alyxcQ71Vr40zqe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812051; c=relaxed/simple;
	bh=oraib7zOH3boZOyNP2NfBNntBUxMqQyjHvBjd3k1yD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW63iyPfBtYGPVnL6jnEi64YiUSjIn25oqmwG3ted3ivKUPZbySAc9LiK+/f6ROZeVg9+3wgFWr20iS1oF7kQNfrJnkBra59IF3pzrAjwnCdtv1Z+Ip9K7wv88TrK/kODpuDXgPhdec83ktUeowrajiNxBPrGNElfJc8aMJ2SK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=w1gCc6/U; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fcd61e9bcdso3249132eaf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744812048; x=1745416848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Q+VK6lwMdiK2HjCiZaR6gJ7FPBmf+K3pu4U+CKGrnE=;
        b=w1gCc6/U2h/yrWWJRHTJ6Z2ks8qcNTTcblhULrxT7c5wizXcgLpSt9Tdb2PqrZ6RQd
         cHVc9VBDkiFF61iRYlUIcOhIaHL5vrFmxiENNiDHZOtNUbix9kSI0uBuhBcPnPSMBdNj
         6Ois+PEvSPyjCf1JCpou+jwGgD5C9CKEk6ecbmJBGsiGCFQaiMVkQmXzLu01hJ2ImGN7
         49gDtHOCnNy4ANo+fuWBFoKad9HFv+gYsPOTK2ERabEiRIyeiICidml6RjpEMzlgx9hH
         vx5myo8GOwvi/wIO6a2yBIuQ/cywYZiVeG9gRWghgbLGpUAV0+GkEdrfhVYY6E8Ik5/+
         ZR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744812048; x=1745416848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q+VK6lwMdiK2HjCiZaR6gJ7FPBmf+K3pu4U+CKGrnE=;
        b=NH+WyyyZWam+XiAyjowu93fCNVPR76Hg5MJrFyf3qQCVMVXKDlL3/r71xXA1OI26fi
         GqK8Tmccpba9HfPicSEsHrHrRD+0pKgvg84/SXzsJ+n6F9d4XYfLa/j2GRYGmWb46aDI
         ZZTeyvbuJ5cUA6oYHz5W3bkRLx2WDLiha27Re3MnV3pZvSO2S2ENuDXyVWC5GjLEcrqA
         w+mkIX0p2iC5PMvpho9p+NPUCI9l2FgZvtbWcDGopmx2EElF8MKkFxT7GV0h2JPDkYpo
         GFQ72gOzFlWnoBbrG6OLk181mIb8lLJFrOYKqLE25Ueag1ukUUwRKDTyrXxo4ptElsLI
         NxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWba+9OR9R+fyYkXqWv+URg/FdO9bXiPbuTMaFQibcz3Ul+i245aqPQPDJrEfvNnpNYr6Wc36qYB8c1dJt2Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2YmphWOIoFPzEXZFM3shOZ7spJeO3Ot2LBVm3Kt9RCc4vLEI
	5bp2ajVQet5PNkfDfF6oNYSQamNvDHNKfvOQtx4R8UC25SGM5K06YRYo4jEJTw==
X-Gm-Gg: ASbGncvelPv9eLxaUJJhFQV5bADhE9ja/CR1dPsHR7+VDBJ6CS9sVhykakGPivSEYSW
	chijadzvKujhcD57cWmtamOeDCsisZrxLclwWo/Bz3wXrImeDFAptTXKvG1eZaK46F/nsBdU8dW
	jikiHpbK/aJmwHUaIHagVFR8eMFSCVeIZDMGlS5UY++p9fVIdZD8fpDFS1d+axRVJXoJNn8dUF9
	pzBT2HuQoMMb+CedEGzTLv4pmOrRy0guZwaBjHivBfIEt23eBTXkJ2+lr3XsA0b3JNFUpz1kGsC
	VjcTUEsBm26aaK4FnW2RWfabFht52BNkXlygyYM1amAPK62h3XEGzqaDjZ1DtEbNyLuBWDFnO0Z
	igjta5tN6fuI=
X-Google-Smtp-Source: AGHT+IFQ3LNuBEeENP6A6Anhn9u1qTz/q6X7tw3M5Uh4kB5k5N0rlo6OPU1WKAj+SEWvfKT946CJJw==
X-Received: by 2002:a05:6820:c90:b0:603:f1b5:ca02 with SMTP id 006d021491bc7-604a92b004cmr1088895eaf.6.1744812046420;
        Wed, 16 Apr 2025 07:00:46 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:dc7b:da12:1e53:d800:3508? ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-604a5b6379dsm347281eaf.2.2025.04.16.07.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 07:00:45 -0700 (PDT)
Message-ID: <8272f999-fe55-4afb-894a-57a7cc161473@mojatatu.com>
Date: Wed, 16 Apr 2025 11:00:35 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 2/5] selftests/tc-testing: Add selftests for
 qdisc DualPI2
To: Jakub Kicinski <kuba@kernel.org>, chia-yu.chang@nokia-bell-labs.com
Cc: xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 pabeni@redhat.com, jhs@mojatatu.com, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
 <20250416065223.4e4c4379@kernel.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250416065223.4e4c4379@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/25 10:52, Jakub Kicinski wrote:
> On Tue, 15 Apr 2025 14:43:14 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>
>> Update configuration of tc-tests and preload DualPI2 module for self-tests,
>> and add folloiwng self-test cases for DualPI2:
>>
>>    Test a4c7: Create DualPI2 with default setting
>>    Test 2130: Create DualPI2 with typical_rtt and max_rtt
>>    Test 90c1: Create DualPI2 with max_rtt
>>    Test 7b3c: Create DualPI2 with any_ect option
>>    Test 49a3: Create DualPI2 with overflow option
>>    Test d0a1: Create DualPI2 with drop_enqueue option
>>    Test f051: Create DualPI2 with no_split_gso option
> 
> it appears applying this causes the tdc test runner to break,
> could you take a look?
> 
> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/79725/1-tdc-sh/stdout

It seems like the breakage happens because the iproute2 patch
is not in yet. I applied the iproute2 patch locally and the
tests succeeded. The next iteration should run with it applied
so the breakage should stop.

cheers,
Victor

