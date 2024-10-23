Return-Path: <linux-kselftest+bounces-20517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D639AD756
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41CB1F2408F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660E1FDFA3;
	Wed, 23 Oct 2024 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X9FOsctA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A551FAC36
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721202; cv=none; b=qS1oztzTATpDwxLLAwERw/d8/qD1DGQqUO2/rskB2h3gBXqrZBmgtGLD3G4BBkNPK7sw88HBGsJEkYu65ilAB4To2lNe9fsGNsoeI5UNXsPzk6roTlVsSHHiOP1rzrMSJIppFXmxZqSes76+XD9S6w1rkS7FCN+Z7pvEf/qpbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721202; c=relaxed/simple;
	bh=9o354F/S+aGjYhcwyc7jfdfnzKzchuynSUyj93Y1I68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAxJC1vCanHXuXWTcAgE8h1kbE3EqjtanFvH3IZEQDfMZb/dfKVqXDTCJ1gppyRkNJjD8AQUXdcd4sy+0s4qZ4M2qBAsjskIrRQPbyInvnwXpcGEt8SusfyHNGQebA6AW9SEEmd7ILoGTmL/XHpwsQWkm/tu+Vw6ZG00ZUOtb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X9FOsctA; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a4dacfda3eso1196755ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729721199; x=1730325999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FIv5osE/5E7L52TcWGFW9t+c/c1Dcvw2X671jP6DA4=;
        b=X9FOsctANCtJPLJyC/v8Vb71eLq6h8ti4ddLJzA1SLOTtp4vp+oi9d9GJ69qQYiuS+
         NU2F070W+rW1lxeFmUGVxwk6oUTX8IhuqgR1yF5HDhAVlRI4PAzlF30gH+w06vpis2Qc
         DACJKkV2in9J+pbs5O/z8InRqfOwvvZkCLIK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729721199; x=1730325999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FIv5osE/5E7L52TcWGFW9t+c/c1Dcvw2X671jP6DA4=;
        b=r341iC/Bg6viZFsOgTItfI9XUfLrMsNI6zF0TfsTVhsayc+vbLqkgkuCPiouErMZlN
         86+3Q+Og6YXmYK2ugo1v5ybQ/PE3KlBoucU5dFheSn3jCqFpLnwPY56YFVWt9zK2fPNv
         E3XQKqeGDy0PgNmcdyMgJlo/nov/HlpJJQUkU+H/3iw/67WTnOCDDZ95F8aF9XMPRF+j
         mUqsyqlW9nDCCQboz+dVls/hrj9PUKnter5yWW7va3xe2VLhzCspOleGZxIpSLPJkrzq
         gYU5bx/y5vZzvpZxmPQrf6MHI6TVqs2cApLKeg0VmuQJhCbtNKecL9Q6U3TicuudvVxs
         3j9Q==
X-Gm-Message-State: AOJu0YwevOZ5a0wz7t4heYPkXS/zgLGxy3JDqjEFDGci5FHC/slRKBXY
	1tI/CQcf5lEMBggu1GHgutpQOmgqICx3ePjRbPF2UEw5f4NjS8+EmvabQjYlpeU=
X-Google-Smtp-Source: AGHT+IGapNawIgcnWs1i8F/W37QDXOwfZSRntZ3VGUdss1NgPThJz1m+4ArkuptnYFOiWWENDYp/1A==
X-Received: by 2002:a05:6e02:1a4b:b0:3a0:9a32:dedc with SMTP id e9e14a558f8ab-3a4d594546fmr49606565ab.6.1729721199497;
        Wed, 23 Oct 2024 15:06:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a530140sm2413108173.21.2024.10.23.15.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 15:06:39 -0700 (PDT)
Message-ID: <5ea4792b-c509-4afa-ac80-44194a54eb32@linuxfoundation.org>
Date: Wed, 23 Oct 2024 16:06:38 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add Selftest to test fork() syscall
To: Shivam Chaudhary <cvam0000@gmail.com>, selftests@ellerman.id.au
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241022204215.61256-1-cvam0000@gmail.com>
 <237ef4e1-786a-41d4-919d-9907bc76263f@linuxfoundation.org>
 <c95ada18-e0bd-4df7-b990-3a9bda2efee3@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c95ada18-e0bd-4df7-b990-3a9bda2efee3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/24 15:11, Shivam Chaudhary wrote:
> 
> On 24/10/24 2:15 AM, Shuah Khan wrote:
>> On 10/22/24 14:42, Shivam Chaudhary wrote:
>>> This test verifies the correct behavior of the fork() system call,
>>> which creates a child process by duplicating the parent process.
>>>
>>> The test checks the following:
>>> - The child PID returned by fork() is present in /proc.
>>> - The child PID is different from the parent PID.
>>> - The memory allocated to a variable in the child process is independent
>>>    of the parent process.
>>
>> Short log should incude the subsystem:
>>
>> e.g: selftests: add test for fork() syscall
>>
>> In anycase, I don't see any value to adding this test.
>> fork() is a heavily used system call.
>>
> 
> Thanks for responding Shuah,
> 
> Yes, you are correct that fork() is a heavily used syscall, that is why my concern is that
> 
> it could fail millions of other program that depends on fork() if any error or regression
> 
> occurs in the future. In my opinion, that is why we should test it every way possible.
> 
> 

Sorry. I don't see any value in adding this test.

thanks,
-- Shuah


