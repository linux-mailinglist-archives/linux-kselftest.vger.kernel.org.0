Return-Path: <linux-kselftest+bounces-39133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5FDB289AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 03:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7004AB62AB4
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 01:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF38145B3E;
	Sat, 16 Aug 2025 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTGa3531"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D6BA34;
	Sat, 16 Aug 2025 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755308502; cv=none; b=sxoVJYwgmBzbUzypD6TTPmayRURRaxV52JzOHWybd/WuYafo0kKX+VeqzoCPwgoGer+jzpMRx10b9G8o3teNV8lH8uCaSBgVT5IYJBWLvyJShVLK25VR27GYB5toHreWach4dsLEwDFuNINemh4ORntgaCqi2yaJnTvfWAnUEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755308502; c=relaxed/simple;
	bh=v5ifsMi8+9H0cgpX4GEoVXK9lhl4qFfMtmGhbpmT9mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBQZDQHP8wN7twx3YX57ieFGQPvvmV+ESkjOLPDqmloqNPG/xvhZZox5H2RzNZXVpYSvh5szuPyoYxQyoaNQ6cnatKuxa11kbmCOXz8jcSPFsTIXOkzVQTk5ZAhrvhtY40fYmVoyWo5tGA+1UPpQD8O8L9FSMPgcmgBl6t+eFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTGa3531; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e87061d120so256864985a.2;
        Fri, 15 Aug 2025 18:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755308500; x=1755913300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVQiyzYdeG7isqy0t1kLYbMlzghp39/658mBHIqJbJA=;
        b=kTGa3531vpDnA9e3pUItSS1nKOgxau1AlQK3L4jZ48gtlHOQYySRRN3+WthvNUHdwN
         LiBa04uTvymDi1La6fFuUq/xsaOFx7wpbLjgwBFQ17H1LW9YhNxFAMMyNUcNOMfcjWkL
         ntYh2HAi5achsCtCyioFuUAgs4onNAaWb8CiwphjiYpWqLjPXHwZTZaU4zTsKwrQ+9Fo
         Syeihpe2wWQTGsI5aGeoThVTUVwvaxdApoFsQNegOzY7CfhEKnAGgovKW6rOgMDt9wq7
         4+hAbuC8U3EWSEsVOvPx/WMnNlthmFKFjjINyAFMSUMJfhtQqDeKP6h0pSQk2aWUrnA1
         tjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755308500; x=1755913300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVQiyzYdeG7isqy0t1kLYbMlzghp39/658mBHIqJbJA=;
        b=fTtlf3tMFQZYTDnpRGGQwm2TMMZb7d+5VfFvYhGR/tfyiW3WnuH4s7+eEgGpvbQsRJ
         9aXNCAUKK2AepwzBR1Ej87skfrpOnuS6x2mTOt3v7aJeOe5I2kT9jJHLepuarnJmXdJU
         N5EG3Zq/mlhOgjZwd0sEcoWjKGaenp8Cq35KxxK4knPvEv2RCPf4K8ahsrm6i9oc4OaR
         f4lHrrWdDTa3yIjwVg66Cho2XwjCs4Q5HETsRpBu3g39MaFSBQVu5gesTua4LeCbzLu4
         WXUuu09r5H3RwSI4M5ZNqfOwtCdwsXvk6deA9mAWP8S8kQfsbiyiorvdFwmJ+nwrDkSG
         SsOA==
X-Forwarded-Encrypted: i=1; AJvYcCXFCnYTAjUGQ2WfrxaCeL1fcxHTV7VdDhGz2DS8fI3SRymHwoNyZzUdTi0vLwfeO1oScfpjUDAmTDE8R4SBfzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5Fqo9PokorYgligzLn1kMRmnAbWiXlZ4YOWQShSKJ8BVBzh3
	eDAZUajdqO1qt0VvfwRThGDJEgKe1Oxi3gUII18c/J/nMSoxVgm2Q84n
X-Gm-Gg: ASbGncv53YZDbreDSIbBivifVUNentc9yW7HMRmreRP0RsksBDlBIfle9j4sXchS5eJ
	lUAj+Ap68pAjKRa2/RId2gMQXmvexW+DhbeXsvcgb9m3mQ5ZxUy3gt6ahv77dg4HhjQwERmGFgs
	557A4vniR/NW8bPrY1E1/KwZbl6FzUXeTqt6fC48bsmun4wq8+pzQlT1iI9f96mnT3uUSAX+kdV
	qdt3pCi/cdCuTs8CxSf1dzVBs6xkl5MLi7cAwKnizcWK6lj3LVAvs896l+NcpaIr3ktlELhoeso
	FWyB6RxZBvRi2ix9JKD/eIP2o0iQ0rWrUanyjfXqKCOGTYCYGQZNhHcIKknsE3/UpN1SwkXMctL
	twO7hp+hlgXg74r9DIMIYSUCe6Er02YnpOifXeX78sMOUTdgJNARfMA+CcnLbDWGRIdUr8lRNYS
	H2/s5vqVK/twI=
X-Google-Smtp-Source: AGHT+IHsUf9wekMLBTl0UwVwPR1DOLy7N8pnDAXN8ZRxjTyVYgMIuUzfRxU+F4zQKpgIO4mDewPvOw==
X-Received: by 2002:a05:620a:2993:b0:7e8:1312:b6f3 with SMTP id af79cd13be357-7e87e0ba6e8mr655002185a.55.1755308500340;
        Fri, 15 Aug 2025 18:41:40 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e020b30sm198767085a.16.2025.08.15.18.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 18:41:39 -0700 (PDT)
Message-ID: <f30a1b37-fa50-4b23-a9d1-841b91bf9806@gmail.com>
Date: Fri, 15 Aug 2025 21:41:37 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: tso: increase the retransmit
 threshold
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org
References: <20250815224100.363438-1-kuba@kernel.org>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20250815224100.363438-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/15/25 6:41 PM, Jakub Kicinski wrote:
> We see quite a few flakes during the TSO test against virtualized
> devices in NIPA. There's often 10-30 retransmissions during the
> test. Sometimes as many as 100. Set the retransmission threshold
> at 1/4th of the wire frame target.

Did this issue preexist these commits:
b25b44cd178c ("selftests: drv-net: tso: fix non-tunneled tso6 test case 
name")
2cfbcc5d8af9 ("selftests: drv-net: tso: fix vxlan tunnel flags to get 
correct gso_type")
266b835e5e84 ("selftests: drv-net: tso: enable test cases based on 
hw_features")

or is this a possible regression?

