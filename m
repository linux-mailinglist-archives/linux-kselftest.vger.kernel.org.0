Return-Path: <linux-kselftest+bounces-20515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBED9AD665
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 23:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED5828304A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C71D3590;
	Wed, 23 Oct 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJktrmRW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD781E7C10
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717910; cv=none; b=Ryzuf3dPA9o/h3UXRQQtTFA8RDOWyVzG0S4HDlBYPUpmJaaGXyUi0urmyv4waNxPtiG/yBSEvJX3all91x7UdR+20ASDmYvh+K1jVDRshXKjoOAudFqdvqZQ0re2THNSyWUmhmTf/eALco9FVrnxB3Wtja6FA6bL49wqNbQyWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717910; c=relaxed/simple;
	bh=ZBs9KfDDvRKasfpkrX8psiMBMacw9MH1CnGN/uaLYoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFv4OpJI8i+/pJoTzCSz7i1IhciM27YIqmAY4tZwpd4PsNH0A9CEZTwj7EFlgcKr45+nB+g6i7Mh1lqD6v/ntd1R3c7EudHbHeeGvTuq6IHWxPTZgbYsRtF78pInuwzK+I23MiMkb6T1iDRszu/ZTOEgyEI2xdRmaYh+lodLVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJktrmRW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db238d07b3so139099a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729717908; x=1730322708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvUY4IXJpduaJ7boO8hj/c9eJIo6cn+IX5UAuLRqPro=;
        b=kJktrmRWhWY2EbSlgEewvKnmfCI+DoseKEPd7WTJq59t/0Kso6Ekxtv+DeGEcNz72N
         c6ViB0DUqQGBlkzvvn3+7GGzStnNTnKArEZbpfhpNOoOuSd4aCpT9dBzXv7EFZkA3hHD
         d3XXUcQCrsVERi5KPxQxspS5q1VppZRIpDFkKlY/aL/PPfpculbrDwW3sD/K/E7aBDt5
         KgoTZqqQqsdNvJqe7XYyW1wZE58opVSiEBEsmkKkCNtjwBPfGg+DtRiFN7H7jeHt8grE
         gcezGvlzSPzwXOsKsfAKzfQALZSFNU7wg6iUx5q3brr9htl3BNwLqYuNKCJhrZpi3c0f
         1HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717908; x=1730322708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvUY4IXJpduaJ7boO8hj/c9eJIo6cn+IX5UAuLRqPro=;
        b=O0633tgSqGw07meMi7ba1Owr4BAIrXvao89WjixTm69gQwYzxsRT7briNqWV9t4fiB
         Lv2U18ZbprEv97ThGQVvUCOaBydZsL/5ulh2SRgzeaHv8e3l6P2igCRSuVwv4cpstkeI
         hATreVEJxkJQYdefVCDH8B5Boo4JoupwkImhL9/mS/o+euSxnOz2Zd1slh4JgDp1EZLL
         PswL22pW/5CENVxSh5DXQMCr1EYhq1C/L7KVrqse4mfIG6wUlXHa4ajLSo3y30icu0MT
         4C7g5MoGvoBsBmNxBpvZFG4D2VWvWsdTIsM64AjIfBhO2MlwaPbA6cWoFm5yicFh7BVC
         dFYQ==
X-Gm-Message-State: AOJu0Yz7SBnzPsr9tF6DcY+5cwhixIdbrSfcXgqkW+u3VlHVzAAMEx+V
	zmY7UdouEKDVUPhVGXzP84CkhxzqAl8bXoAZ0v/c+R2S24v/TNtSAg4fjlva
X-Google-Smtp-Source: AGHT+IFgpRh7XpCh/aAH3oSCBo/7aYoMZ2fuI9FwSDa+Y/E0gTKW1Mtty0k0HDshidLZ7Nl6vmiikg==
X-Received: by 2002:a05:6a21:390:b0:1d7:8a9:63c with SMTP id adf61e73a8af0-1d978bd54dbmr5003012637.49.1729717908428;
        Wed, 23 Oct 2024 14:11:48 -0700 (PDT)
Received: from [10.25.79.210] ([202.164.25.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafd363sm7253002a12.16.2024.10.23.14.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 14:11:48 -0700 (PDT)
Message-ID: <c95ada18-e0bd-4df7-b990-3a9bda2efee3@gmail.com>
Date: Thu, 24 Oct 2024 02:41:45 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add Selftest to test fork() syscall
To: Shuah Khan <skhan@linuxfoundation.org>, selftests@ellerman.id.au
Cc: linux-kselftest@vger.kernel.org
References: <20241022204215.61256-1-cvam0000@gmail.com>
 <237ef4e1-786a-41d4-919d-9907bc76263f@linuxfoundation.org>
Content-Language: en-US
From: Shivam Chaudhary <cvam0000@gmail.com>
In-Reply-To: <237ef4e1-786a-41d4-919d-9907bc76263f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/10/24 2:15 AM, Shuah Khan wrote:
> On 10/22/24 14:42, Shivam Chaudhary wrote:
>> This test verifies the correct behavior of the fork() system call,
>> which creates a child process by duplicating the parent process.
>>
>> The test checks the following:
>> - The child PID returned by fork() is present in /proc.
>> - The child PID is different from the parent PID.
>> - The memory allocated to a variable in the child process is independent
>>    of the parent process.
>
> Short log should incude the subsystem:
>
> e.g: selftests: add test for fork() syscall
>
> In anycase, I don't see any value to adding this test.
> fork() is a heavily used system call.
>

Thanks for responding Shuah,

Yes, you are correct that fork() is a heavily used syscall, that is why 
my concern is that

it could fail millions of other program that depends on fork() if any 
error or regression

occurs in the future. In my opinion, that is why we should test it every 
way possible.


thanks
Shivam


