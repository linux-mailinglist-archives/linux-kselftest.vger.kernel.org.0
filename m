Return-Path: <linux-kselftest+bounces-24296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8CCA0A527
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 19:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA0F3A662C
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE71B424A;
	Sat, 11 Jan 2025 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzB8vYm8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D21B0F23
	for <linux-kselftest@vger.kernel.org>; Sat, 11 Jan 2025 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736618440; cv=none; b=m6dxm9E/TKqHjicl3PpkM5Z+92PNf2UbJC3ffCltfcz5XoRqziLQ5FEEhXACvEMk89cs9/8MEc4pWbOK6PGolOxZNwpnnR8BeNtWK9be3YDx/YO7fzTLLjqUq5kmGsno2xJMdRAeoQ+o3c1FK36wfUZdTnd3myeEyzvA9Kf5/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736618440; c=relaxed/simple;
	bh=rl4tzMbjTVPrZL8vIZg0CsU+U4RCupZ142ByB8y5vNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMdq8MU7s8q5u9YiyMfgwyr889HuI3gXM9sndmTk4bwV8Cap3QPelFzvrfF42jPrXREfsQW2uCepSZFQJvr6AzcJmrRh15Qz2Fm7vxiC06IUPIxqD6sLtD+lIXAfOpoe7YR6PG+chSsEg12Mkb+61pS50CdnrkhIvNGwfgDBPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzB8vYm8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736618437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65m01HXSlqOBQF0X6QUSrEpGfIBoOq9A2r6WX82xrgk=;
	b=AzB8vYm8cdmWtbGHKFds9On9i3pwXYtAQGR46EywRC48ogFZICdX1FL6jn765G2AVtZ9lv
	21CpJovhi7gd6M8euEA6kW/69MNAhM8ezNW/mpPEBJP3w7NqZPRJVFk4wkvLm7gLHrKX9i
	9mVm6jBj1PohHX3FNa0MCZRSBNzsPDY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-KleSDxVGPuW1dqEw7TWN7Q-1; Sat, 11 Jan 2025 13:00:36 -0500
X-MC-Unique: KleSDxVGPuW1dqEw7TWN7Q-1
X-Mimecast-MFC-AGG-ID: KleSDxVGPuW1dqEw7TWN7Q
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e5c9ef38so509510885a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Jan 2025 10:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736618435; x=1737223235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65m01HXSlqOBQF0X6QUSrEpGfIBoOq9A2r6WX82xrgk=;
        b=ODTUcdKI8SwsTcpe1+XmsKQovtF1TvEk2eNMN42S56yz1IWqnXt0PeBSQuNWln2WD7
         K3BPLTog5YyPBqY9g2bg7DMOG7C108z7JBl8AY9f0zDn+tBXuYGbeOm1kghrbiwTMVI1
         04DT3odbjF0v3fnyrrW++RXLHBzMXTmXnCurDPn/30eTo/89moRUZBH8WULTqUG/44JF
         26dTjYqJ0msVWmx5BE0ck+7slAQRWFCHpq3god4QrZziSohA9Udgi5ZArFYqRWdPN5e6
         YYhw6bkA0DfzoRKU+PfWRPeLZPAEfRWEc3jUXEeRGlhNfh745dXGHIyEhLeHYp2SyU9R
         2Wqg==
X-Forwarded-Encrypted: i=1; AJvYcCXy9Wozq8Gc6pdBWagXnl8624KoXnahx2dxGlO0fUPvHmUvVApNuf+3T+8s55MXtl5h4SXSBTxXPUbBsOBXpBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00Yxl6u3Et1T11lDWGRXwEwNbam/szK4/Dh3k9W8HbhCB4uyD
	Ne0AsT5TqSan7pD2+pv3KHXL5n0YcxkuzvYcRR5cgPHuN16d5Ox+o2rFEr8K6sfOBiAyePoFZWj
	VgpecuVLaeRAxAOKmcec7JOXQz5iiqAUiRYCAEWgZYsvBOZpcdyiQdcLboPl/ShM7uA==
X-Gm-Gg: ASbGnctZEdr23zHwspFkq8OuJ21yO+j3gGJYHUjGve+Oa9XDoOrH9zRpECT6TaDVvA2
	48WZMfO540N+RDSWI+9SsIriWVi5Jl2ygcvFh5B3m0M2eD+regfgpYBXz1zyrIyQtKKS8Vg4Kdq
	rcisp2i5QDw72K9sMWk9aDb5F9QYpbBEaXpgTA3r2GTXdsy5lP+utSXZ5btbT4Ftjj5VH3X8P0/
	GJMoQv4NXYdNZto0yyhzJKa72ZI0bdDboN7BIjhiStUcI9QYawBBuuNrNXyDn3sZgsvaJ9/Et9U
	S3pxgUTzev7pPSBfYs6/oAe8krKaCoNFdLSNaIk=
X-Received: by 2002:a05:620a:4e50:b0:7b6:d237:abfa with SMTP id af79cd13be357-7bcf3670440mr376712485a.21.1736618435657;
        Sat, 11 Jan 2025 10:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUdu/RdQiy62AcFdeOz8EqMSt9UG6Qp5/L1AaHX+TMZ/CBG16QzRl866a0rluy1MJWs1zVjw==
X-Received: by 2002:a05:620a:4e50:b0:7b6:d237:abfa with SMTP id af79cd13be357-7bcf3670440mr376708085a.21.1736618435329;
        Sat, 11 Jan 2025 10:00:35 -0800 (PST)
Received: from [192.168.1.45] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3238003sm303883985a.2.2025.01.11.10.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 10:00:33 -0800 (PST)
Message-ID: <20867ce3-901c-7821-fe02-ccd223fdcf17@redhat.com>
Date: Sat, 11 Jan 2025 13:00:31 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests: livepatch: test if ftrace can trace a
 livepatched function
Content-Language: en-US
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Felipe Xavier <felipe_life@live.com>
References: <20250102-ftrace-selftest-livepatch-v1-1-84880baefc1b@gmail.com>
 <Z31VBN3zo47Ohr27@redhat.com>
 <9edd671a-be5e-41c9-a8dc-b1fd1d5e3375@gmail.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <9edd671a-be5e-41c9-a8dc-b1fd1d5e3375@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/10/25 12:13, Filipe Xavier wrote:
> Em 07/01/2025 13:23, Joe Lawrence escreveu:
> 
>> On Thu, Jan 02, 2025 at 03:42:10PM -0300, Filipe Xavier wrote:
>>> This new test makes sure that ftrace can trace a
>>> function that was introduced by a livepatch.
>>>
>> Hi Filipe,
>>
>> Thanks for adding a test!
>>
>> Aside: another similar test could verify that the original function, in
>> this case cmdline_proc_show(), can still be traced despite it being
>> livepatched.  That may be non-intuitive but it demonstrates how the
>> ftrace handler works.
> 
> Thanks for the review Joe!
> 
> I have fixed all points mentioned below,
> 
> and have a patch ready to submit.
> 
> Do you believe that this other similar test could be sent later,
> 
> or is it required in this patch?
> 

The second test could be added later if you like, either way is fine w/me.

Thanks,

-- 
Joe


