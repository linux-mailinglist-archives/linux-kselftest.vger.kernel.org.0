Return-Path: <linux-kselftest+bounces-23698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0279F9954
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 19:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05521963FDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56221D5B0;
	Fri, 20 Dec 2024 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SC/wT12U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD045948
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716036; cv=none; b=P4Y2IQYAF1HoaCYCbXPbQWwvLePN3EgGVe5xIyvmzi+PMpHz6WIsgrhE7Bkgdh4jFSMr4JEb3cW4F0c0mkpYVO9mTJ6WDrTeZkzsxP+bYK86sBJhKSPuW97XTny14ApQCfdwYloNwVBA4/0vU9b5JTTMBQ3ouY1quHqqiak4Ai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716036; c=relaxed/simple;
	bh=EOSgJFqbNzZue8PcEmo8AOIhn9yrJuIFDZjAitrdngA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlzSpSu8ohKvMTKbbBdv398L5nWjiyghcTTxHLgpDD4mzgBFQ0H1V5CBbdDQ08JHIexJpW67wJ4ZqBoPEaDSL6DCl8g6usbmeVgHLhwGGcvPrt0Ope+EW1FiqYX3Ceq1+1CZJ/Ttki3nCvaFYbbhOvICD0qZS/Baoqqxhxo0eAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SC/wT12U; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8442ec2adc7so72174639f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734716033; x=1735320833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3lDWXYieWaSwhCuCMEtUeqlkkHZALzZ6qVm2AYz5YE=;
        b=SC/wT12Uf2ED7mrE5a/zeZQ2TDmilhHWP09B7xOyT9a1pr/q+ehgg6UeVcfbJIISGn
         s/PCLkoZapjuYJKXUvS/HFTWabKwLbLHO6eX2gg/94WGkNn5RwENM0nG1NisuoWkWQ72
         F5e1hOl+5X/8lJtw7GSRm56Z0YWaxm48PMmeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734716033; x=1735320833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3lDWXYieWaSwhCuCMEtUeqlkkHZALzZ6qVm2AYz5YE=;
        b=BfqLJteBEu26GURFIKXvikA4kiVThfAIqu4Q4vBKjRWnWFdg/eSJr6/H4vu5PwD3Zu
         sE2x4eNrxOAaV09DZEXcSk8f+rPQPPCXgYk57Bl3so+njij79d3e4M7fiRkRhOBAT/2p
         Tw12jFHdBUA9EK5HC7SrUAU7CbDZlLc+hYR75SInrlQtmU2uAZn+ZtDkOXsW1uPOt0ba
         aOnaS3zfnbw541ai8hSf1KDEGdPY3hpWITCwOdGrgZ6BeqK0bLy3opN2mhqyXVeG8z41
         EVCvZB7MsGTGd5ZHgQ7L47bBX5CTOKruPyiL8N7HA1IACsrPUqQwto0gc0b5sf464fum
         obng==
X-Forwarded-Encrypted: i=1; AJvYcCV2RxycajWLtO3m3vDoGV4cPFQI7h2NgyjMfSy6hMu6gYA+nKTKRh1hNmcIFSBqFqOOy7HDKiTEbJGDoCF+nnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUR9vvVIKlwVM6GuWfn0ZzxotEJgqiDckfTPAzQnDYDnQmyL8C
	gVwKCd4vT9l22J6Cwx9PHIKpTyKF0EoJgKO0a3Ts1diq4bsxKWw16eeOIrd+UiU=
X-Gm-Gg: ASbGncvjWdiljTZ1OhDQnkJXj9lyI75CjcNtavbdYV5RUnMPdaz556a3s02Ta2qyzPC
	uIGh/Pf2DPZgmiHzc7wgr847OHhXtfc1Y84WrBgRfCRx84OdW7tyrYOsHrmjbEiDOIqbe1V7rj3
	AGSL7tL7rUb11Nc20pfDG47dX7d+0mdMFHa7wvyPXsopur5zKgxj6mOyuVy6W6VDdxOaircwii+
	eFlmuamJsQdGi545ChYcyXfm+ZIQNj5QUIidb0MIEf5HbNTjXVVXU3ec7yWUfOXNn9g
X-Google-Smtp-Source: AGHT+IFxMb2oesh8pBt/S0AGpufvN5zhHv/M30Pf7wTX/edjZ8qrqpLT9QM7STSTrQpfkOUyEB4LOQ==
X-Received: by 2002:a05:6602:2dd5:b0:843:e9c1:930b with SMTP id ca18e2360f4ac-8499e679bddmr394514739f.14.1734716032784;
        Fri, 20 Dec 2024 09:33:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf7ecc6sm877195173.70.2024.12.20.09.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 09:33:52 -0800 (PST)
Message-ID: <c8e232e9-78ff-4051-995b-41454f9c4b51@linuxfoundation.org>
Date: Fri, 20 Dec 2024 10:33:51 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drivers: base: Don't match devices with NULL
 of_node/fwnode/etc
To: David Gow <davidgow@google.com>, Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>, linux-acpi@vger.kernel.org,
 Rae Moar <rmoar@google.com>, Rob Herring <robh@kernel.org>,
 linux-kselftest@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241216201148.535115-1-briannorris@chromium.org>
 <20241216201148.535115-2-briannorris@chromium.org>
 <CABVgOSmZUETNa8OfqTvMuGg8Dim3UjLzvKdeJia6aCV7Ydgzdg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmZUETNa8OfqTvMuGg8Dim3UjLzvKdeJia6aCV7Ydgzdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 22:45, David Gow wrote:
> On Tue, 17 Dec 2024 at 04:12, Brian Norris <briannorris@chromium.org> wrote:
>>
>> of_find_device_by_node(), bus_find_device_by_of_node(),
>> bus_find_device_by_fwnode(), ..., all produce arbitrary results when
>> provided with a NULL of_node, fwnode, ACPI handle, etc. This is
>> counterintuitive, and the source of a few bugs, such as the one fixed by
>> commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if
>> one actually exists").
>>
>> It's hard to imagine a good reason that these device_match_*() APIs
>> should return 'true' for a NULL argument. Augment these to return 0
>> (false).
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> ---
> 
> Seems sensible enough to me.
> 
> Acked-by: David Gow <davidgow@google.com>
> 
> I assume this series (including the KUnit test changes) will go in via Greg.
> 

Works for me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


