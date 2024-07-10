Return-Path: <linux-kselftest+bounces-13480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E81A92D622
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 18:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9582885F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A3B194AC7;
	Wed, 10 Jul 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MEzdOVbB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74332194A6C
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628219; cv=none; b=GZUZJRHpLYFMmVbqj9U+nSr8JcHpEPLEkuHGQw38IZYM/8wh3YHRi3vpAcdcoBDb3rwXTeZrWNJCBXc9B3Jj/YbKyK34z+U2KiZQDh8Zxdy9vqblWcbXzxlaMkNqpH+mEz+Aa3xUR4qNo06jJpX53gW17dc1d0MfMGSRrEj9kpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628219; c=relaxed/simple;
	bh=b1jCzpljv294jZ54BFzSlA1N/lX/gcP5LuBmaj4Ng+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4jTq2tPQrnpP+0Tk3IUbc4i7ZSCL/P4oMgj7DcNg3lCq7DNgg/ounqjoYnW+im/cbSsqnZzhkgoLeUIOJjelSGUgwduOK10qXnZCR7UeN5UjdfMhfEu5/+S3q4p4OkSWdDpfduxYhRdPXVZqbOGljR+Y76WLpxR1aT7me1eszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MEzdOVbB; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-804cba4c8a8so4868939f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720628216; x=1721233016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcVXn2c1HJMrHq2kPiVMITG/JkIH8gyHy72G2+XXsv0=;
        b=MEzdOVbBIIdgY9DLH+zvsihkBmaOsfg2IzQwf6vdcG2xXdyZBPH8sEFccOW0DNGnm6
         S091vAGAH160VaPQXUX8Tlrn1Y0DF7jbMvudQ43zTmwg5XUgRiV3MZLACGDB2uosZexM
         d0dJX6wsh9B0l2a7lqj2ld67fjRyATj6Mpt0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628216; x=1721233016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcVXn2c1HJMrHq2kPiVMITG/JkIH8gyHy72G2+XXsv0=;
        b=QbIFqaTNmxgLMfJ/mxDUltRlFyOUDPzOo3aZN7Ef7PgFMPuvdBQTpH6hI9x96/eHQ1
         KbQjYfy9rGkyqiKmSgnGSSaBQHUpEcnr/9rx0BNfQJsWKQh7vSx/1FC0u+Bk726JBgeB
         WFp6TYhtKlZjB220dHB9uwcxyByWzrB3nsM7mbMkKZpkrvGf9RYu+3I7E/HDzM5D3xCJ
         wTX1LZYs+dIQWGMYpjWiB4Uaz9WAYpvuubYIGQ4kQ0KwEZ+B0CPjZ2Z6qDanQigNLw9+
         GD0zWY984yK+FZNGxpucfsQyzQ9HhLMEI9jCucrzmnclD27wG3CgJ3LL5mLEazyXUE/J
         6lZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJtXsJOcCzEI9MR8CgO4b79SI2KHNJxljrMz+REdvQbv6qLSR9Q9WXFaP4L3CssqvVDqt1/b17khiy7PxvYS7/KLHO020mRbr/qEk3Ho7y
X-Gm-Message-State: AOJu0YwzqUKXZoD1LYWuTweG75KlwJItye1zPYAdUQpnxuWE/mC45zmV
	RP/9/rDPBg+FkCn04EKf5hREkwNjJUBox338dXAh/uA8Ww5soA+lxWL2PHGG4pQ=
X-Google-Smtp-Source: AGHT+IFLNAXjuVHO+RsZXCAHzp+2VhQVXm+gi17DFvsPlXeiTnPye6ujudJmxfOdyHv0WAe03xGAaA==
X-Received: by 2002:a92:c092:0:b0:376:4224:7611 with SMTP id e9e14a558f8ab-38a59e8a8a6mr55991525ab.3.1720628216546;
        Wed, 10 Jul 2024 09:16:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38b5a638875sm6812865ab.41.2024.07.10.09.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 09:16:56 -0700 (PDT)
Message-ID: <0333bafc-295a-4fd8-8099-8fa8c6b0ae23@linuxfoundation.org>
Date: Wed, 10 Jul 2024 10:16:55 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240426101824.2894574-1-usama.anjum@collabora.com>
 <da0f535d-b970-4de5-9dfb-e2cbf62c816b@collabora.com>
 <890460a3-fd09-4f59-ab21-4f5b16256175@collabora.com>
 <f929b8c4-fb66-4724-b2ee-d012a5c20324@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f929b8c4-fb66-4724-b2ee-d012a5c20324@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 03:37, Muhammad Usama Anjum wrote:
> This patch brings just readability implements by using kselftests wrappers
> instead of manual pass/fail test cases counting. It has been on mailing
> list from several months now. Please can someone ack or nack?
> 

Okay. I think I responded to your other patches that are adding TAP
to individual tests when kselftest wrapped does it for you based on
return values.

The reason I don't want to take this patch is if you run the test
using the recommended method:

make -C tools/testing/selftests/vDSO/ run_tests you will get the
TAP output because lib.mk runtests framework takes care of this.

or

make kselftest TARGETS=vDSO will do the same.

Please don't send TAP conversions for individual runs. You will
start seeing duplicate TAP output which will make it unreadable.

Run the test using make -C or make kselftest TARGETS before
investing time to concert to TAP. I am not going to take TAP
conversions patches if make -C or make kselftest TARGETS
shows TAP.

thanks,
-- Shuah

