Return-Path: <linux-kselftest+bounces-5612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3163286C4A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5541E1C226BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A358107;
	Thu, 29 Feb 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YURPlVFS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FAF57894;
	Thu, 29 Feb 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198042; cv=none; b=dXN5CIRzFVUmBD+Eunv+tj7ztTZHHCL6LW/dUFseeiSy8fQCVwZvboZ/xz2VEn4VFmwWU4CH0gycTAh2Hl1k7vARMHMvnKveQ8ygDeEGEawHigDXG8ka/+VhNLejrf66kDcJnc1W6sABEXeOVfj7VjK/m0+N6hahJMaGkTlZbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198042; c=relaxed/simple;
	bh=XzBYBRZonO3qAmE6Yr/R3lWoRxWnzo3XwlapB2YkqcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emE0bPIOCsooghMGEEtL1Kgub1Tb7lwt7D4NeAb6fdS8kkpjvNAPA56YxuaVQX1xDe4bkR2iaOgw4pwCwOx7p6oPVnvBUpLr7fHh49zwzhpUKDmaGOSh4HujgV9C8eG/VBwenue0HACvY9WVINQ8NldCaceM8y97SsSDF3kcq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YURPlVFS; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c48e13e0d7so30763039f.1;
        Thu, 29 Feb 2024 01:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709198040; x=1709802840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2wj+Qt+CclRDmPbSU7W2tEkkChut/lDG1Rj9C81Tl3c=;
        b=YURPlVFSx+/Gwxn6IqTsmOFPocyDc3yaz7BqNN7K/dTp/jYtIffN0UdrFmfMYWPqG4
         BqdGD8KF6GcHWbGdagybmEhOySa7ACroYo64WlTbW4tEsF+VcD1yu5lNqAfgSQNNElw1
         LSvmuL9ALxb6d+bb+iESrc/C+jIMvLcRSFiYw9XtV+Tcgkvw2Q7hmov98R9PLE5jtcop
         ahEH5n8JpurP6FNAVOUHN/nvFZ1b5n2nUP1e28DxBUJVXyal72UsQHRujz/JmcGjb5X9
         i628uNjErW7c5wYTm9geUDbP1xYRvFqVm/mnfratgnSxc7flpNCENYaRB5da2EiPCq0n
         qzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198040; x=1709802840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wj+Qt+CclRDmPbSU7W2tEkkChut/lDG1Rj9C81Tl3c=;
        b=OHN8TaQxycBUrGPCfXtc/3fh8UUgjYEZtXUfbxRMDH1HtbmH5YEnZVEveUmigcp7Ss
         TP+mCZwxZcSmmDIfgjNDJxTfijgaKVuvBgtJiloK5gbY18X7bPhw13n4OGcSxao1NDm5
         U1RSgMfPbNaYeAhGNcRQB9MIfY3Iv8BWmitnMUyCdlDtSss7XDnLQlLd0ROdV5Xwudfo
         5BAbz7FEGZrT2+DGWw8t1yD7qtCggiDB6t3dIuSRea/kUb4SGGi4G5RrdM8366t5jqxI
         19OJfP9v4Z6U7EDBTq7SHkJE28aKvKaJYydlmUsG2hiyJXISlQrNUxHMuQAgLjNrlIqG
         OuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE1ZWb5l7yNpdg+ohanukCtCT5Nf13mIeHXl11hZJ8fAEHEFJzXVqIaTkKSFbhvQ8zGOGXWpWBYbIiCXeXfYF70L362qOdXfcWj7+TG3dyC86KTn7CAOf8Ln6A848m2LY9d5NQbDe8bTJnjDo64WBq+zUbKF2RdcddhaekvyCXyGdvWRGC
X-Gm-Message-State: AOJu0YzucaCSoPsiTHfxdH9p7fDQ3XjVgVpo2ajH613R9JzC75aEh2SJ
	B8qERDZmIp4SEx04999I49IRVpp8HwToAxgjShAWgZctppvqwDGp
X-Google-Smtp-Source: AGHT+IFCJFuaySZLdHwnAAcpQqle/JCPkzmdlshfwOWY1M0GxDlQ69lymxn38aCI2qUnRvs0s4Pa4A==
X-Received: by 2002:a6b:c997:0:b0:7c7:fe27:643b with SMTP id z145-20020a6bc997000000b007c7fe27643bmr1726331iof.1.1709198040016;
        Thu, 29 Feb 2024 01:14:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s10-20020a5e980a000000b007c7e67c5942sm212645ioj.39.2024.02.29.01.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:13:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2b4ff7f9-2610-4c33-a4e9-a1fa30891edb@roeck-us.net>
Date: Thu, 29 Feb 2024 01:13:56 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lock warnings in dev_addr_lists test
To: David Gow <davidgow@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendanhiggins@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <48c4d3db-66d5-4a9a-ab9e-9036db7222dc@roeck-us.net>
 <CABVgOSnpOzOr3VuKZc3okhJqf1yvsEe56YPdWn15Ag_RDEZi8Q@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABVgOSnpOzOr3VuKZc3okhJqf1yvsEe56YPdWn15Ag_RDEZi8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 00:10, David Gow wrote:
> On Thu, 29 Feb 2024 at 03:45, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> when running the dev_addr_lists unit test with lock debugging enabled,
>> I always get the following lockdep warning.
>>
>> [    7.031327] ====================================
>> [    7.031393] WARNING: kunit_try_catch/1886 still has locks held!
>> [    7.031478] 6.8.0-rc6-00053-g0fec7343edb5-dirty #1 Tainted: G        W        N
>> [    7.031728] ------------------------------------
>> [    7.031816] 1 lock held by kunit_try_catch/1886:
>> [    7.031896]  #0: ffffffff8ed35008 (rtnl_mutex){+.+.}-{3:3}, at: dev_addr_test_init+0x6a/0x100
>>
>> Instrumentation shows that dev_addr_test_exit() is called, but only
>> after the warning fires.
>>
>> Is this a problem with kunit tests or a problem with this specific test ?
> 
> A bit of both, I think. KUnit test cleanup is not guaranteed to run in
> the same thread as the test, so that definitely is triggering lockdep
> warnings.
> 
> On the other hand, we really should make this particular case work in
> KUnit. Ideally test cleanup will happen on the test thread first, and
> only fall back to another test if the test thread otherwise aborted.
> 
> So, this is probably something we won't be able to fix if the test
> fails, but it definitely shouldn't be happening here where it passes.
> I'll look into fixing that.
> 

Here is a different warning, from the same test:

[   10.622270] =====================================
[   10.622346] WARNING: bad unlock balance detected!
[   10.622481] 6.8.0-rc6 #1 Tainted: G                 N
[   10.622624] -------------------------------------
[   10.622698] kunit_try_catch/1354 is trying to release lock (rtnl_mutex) at:
[   10.623123] [<ffffd7c5cbdb75cc>] __rtnl_unlock+0x3c/0x84
[   10.623538] but there are no more locks to release!

That seems to be kind of the opposite problem. I noticed this only
once in my tests, so it is much rarer than the other warning.

Guenter


