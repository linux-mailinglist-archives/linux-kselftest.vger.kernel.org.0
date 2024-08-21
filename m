Return-Path: <linux-kselftest+bounces-15817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF695948A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A3B283409
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444A415C159;
	Wed, 21 Aug 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aml5LfgC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC758248D
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221859; cv=none; b=jogRzlO8qcGP0wP3h5DS8Fu6Flr5+c7wWmJBDFEkOw+ouQuCnVnUUg+/LjlawDs4LVs70vqVGkmAsLwwZ2BsMLxMMi/gGE3Slp7GXT6QCeRQwyXBSCidx3wqrKZ3vaTvkjAXydvDf6WInmjbStFoPzHIgxH12K6n+HoV3GZ9aBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221859; c=relaxed/simple;
	bh=mZ7cSxfoQmQCj3saPrfeUJA2a4NYfq6piA/iUeVZ7WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSipIPOmKwKRj5rV76ppLXnS8xfdR4nSqg2Ubm3MW1/mARqLvYOs6eur80V/1LQSkGAcIyHSA/VrR4vtXWmIJ34prt9yWmzNKqLDzqmALTv/oMJrl0W9V091aTa7+TM43b8gPaFKKHNF/WrKUEh+bDzTF5wYH8EfQsqRkSbPDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aml5LfgC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-202508cb8ebso22199305ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724221857; x=1724826657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzcqzHSqNE9yip5ED7tWvIVzWmQ91EinUBi740+qVHE=;
        b=aml5LfgCRrzx7LuSFL/wQgM/293b8BAadEgDoHrhj4siR8FAurdqZe8GZabFiRdTKg
         dn6aZZz2tTJxuxD87lbXheGVLBSTwUxI2EuuYZZyOBFk5t9aAQmR1kh7tRzQd9fdKp7A
         3BnNeuTG4zBehbeiyb3BxUCfflV117eoExDdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724221857; x=1724826657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzcqzHSqNE9yip5ED7tWvIVzWmQ91EinUBi740+qVHE=;
        b=kkMVxgQPJraEa7xzxr0/mwB9A4RnDibj0NtdkeDfSIv9/fADxAsnpapHguOzPydaVm
         TRxOEy7+9PgJgZk4ABX0cuWfLCYNtQ2kn938Pq733DbfFafgX/m3r3lNB7tD8C8DGPIA
         4zoHbz6uhFPzzPQ089pdRT4bx6YlkUYI4Ai4fdjHR8B8vw9D/ius+GcDZqO0crUY38Q7
         7l4+5lK6dyS520Mgux3bzTTKaxSMXEKA0Ab0E4hYmedJVQ+lUmDm7UFFh+AfSS+Z3OAy
         VSRfOj9GUdQK9CPvUdgSC3erC+5T5BWnE+lpPMD2JSlod4XMDdh5JiIax2fY2k/cY9GW
         vTNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnGBTPGreS7TewVfSxQ1ZQpTGKrgwPJp3Eb5mwM5EaxY4kpbfTXWPUJcA097PZjtn0X/GPWooPLfykjq2caWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHovnv3NYmTEgaoStzNVXKWQiGCqnqCGHaQ68Y0FB8q707hVC
	aVYLq4qRTSeGkTMd/n/chJ1qA0OeAxN3FiCfuM020h/LJAQVG3fefsRTxZgWtUo=
X-Google-Smtp-Source: AGHT+IEnOoIZoPGx6TQyxJmMjyll5R6KO1MT+r2PvrLNAVJhrjTw3Spm91pOn5tWFC5QIEziQ7p6wA==
X-Received: by 2002:a17:902:c40b:b0:201:db9f:cdde with SMTP id d9443c01a7336-20367d56b58mr15815015ad.34.1724221856606;
        Tue, 20 Aug 2024 23:30:56 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0300522sm87065175ad.6.2024.08.20.23.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 23:30:56 -0700 (PDT)
Message-ID: <88575c79-b6be-42d2-b863-d57f83f8c99c@linuxfoundation.org>
Date: Wed, 21 Aug 2024 00:30:53 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests: Fix cpuid / vendor checking build issues
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/24 04:45, Ilpo Järvinen wrote:
> First, generalize resctrl selftest non-contiguous CAT check to not
> assume non-AMD vendor implies Intel. Second, improve kselftest common
> parts and resctrl selftest such that the use of __cpuid_count() does
> not lead into a build failure (happens at least on ARM).
> 
> The last patch might still require some work on which symbol the
> conditional in kselftest.h is implemented. I could not find any
> pre-existing one that could be used. Perhaps somebody who's more
> familiar with the kselftest build system has a better suggestion on
> which symbol the logic should be based at?
> 
> Ilpo Järvinen (3):
>    selftests/resctrl: Generalize non-contiguous CAT check
>    selftests/resctrl: Always initialize ecx to avoid build warnings
>    [RFC] kselftest: Provide __cpuid_count() stub on non-x86 archs
> 
>   tools/testing/selftests/kselftest.h        |  6 +++++
>   tools/testing/selftests/lib.mk             |  4 ++++
>   tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++---------
>   3 files changed, 27 insertions(+), 11 deletions(-)
> 

These changes look good to me. Can you send the RFC patch without the RFC tag
for me to pull in? I don't apply RFC patches.

Usama, does this fix the problem you are seeing?

Hi Reinette - do these look okay to you? Can you give me an ack if they do?

thanks,
-- Shuah

