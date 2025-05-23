Return-Path: <linux-kselftest+bounces-33681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57170AC2B39
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690669E0CE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 21:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303F31DB124;
	Fri, 23 May 2025 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iTc2mQ0+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8C7482
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748034545; cv=none; b=PX82kn31imx2xqRUN3sAyJzYm/91D3b/Ox1zsmh9ly47MUBLMRmIoNOkm2rwppq2YAW388nHpn5+kosdVARe9ZYvq4bFSjjphPJJiPRLCSWpcjQxdImrwUsfim1ibYtgg6qgcQzeEVyPbHKgWQ976b9Z+v/v4E7vmHcm8VWl4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748034545; c=relaxed/simple;
	bh=Ug/0cek0liAmIOALkolnnoBQY2EBqu8WIDEwQsDxrN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WY4sZTr6NGTQ8CkZsph1o/7MiYjotVOoRIhXel+q2JM4Rvqlz/gokn/yuLOq9SFAKzWCX8mxM8YSYo3XNVzrH05J47dj+ddooPdVlha2F4bTqI+sMyx6CzllwE28nbLVtwm+og3egt8Ao4tBpK7rxohFJVHYcjdTHv+hcDpQ/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iTc2mQ0+; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so23852939f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748034542; x=1748639342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHsikEp0hoaPHHq7HEUUN56dIOFIBGPuhUpxjcOnZLo=;
        b=iTc2mQ0+hzDpeE7wmS00+/+bh3MlPwFklfRNOUcXNSZfeRxQou4ReQeARrNEZWq6K6
         G59zFlrjDipTeJ2MYGsvd8ShjmO1p7ApLFwQHK1OW5RHTRraLobi0cxAiG8iXFrFNGgy
         JzyP3TnsGBtznU0JFwDNpzLY1dgsWPTYDKcTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748034542; x=1748639342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHsikEp0hoaPHHq7HEUUN56dIOFIBGPuhUpxjcOnZLo=;
        b=GJE6mxhcTo0KLhSISIojnmce1tZEpdPFKILjbEoQZZwTaogbbOurl4C4eTfOQ6YYhu
         iucACDL93AEAfmsm4vIttb1q4dhuQwtFhEGuc8XvSDsuUGISMV2NC7ojztCLeVnm7pox
         5cPHn0H2/B/+jZgBDFFH+wm41xJz45bAWPZy6Bu/+z8wQBRJJXuVzpfeusFL2+hUuFHw
         72f7lCWlZeVufAIHTnUEQQDt8YsryANzEtb++FOzjogmbK7TB3YscN7ZqH+0fYOynzSs
         vznaO0dpro2WIU6mxra+B+SagRwu4JGhIaoHTGsKb6dSyYee0bzYsUes7GQtrcn72coR
         eOIg==
X-Forwarded-Encrypted: i=1; AJvYcCXoPpRtCR92TKTFfzke55YJTVG7W+L8jN55168AV7ZJRjkXYW2crrJbIlBo2zjbVP8aOayaeJZymfxA6b26J3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ82sz5SM6MQEEhO+euy/LZdwTA4Vh+M5QlEv5CHoNvg8Q6+4z
	YMJedKwn4lbsg2+Dahg2W/Yd9sP+Vsy6OigZ3qFTPPFdUg5ofSTcoJttPM2viS2Wrbw=
X-Gm-Gg: ASbGncuTOtkfgBXTjmG085uvi4AHpHNya7xWyGbGBz9dULtlHaxc0SXme8aFigspRLs
	5qbWQIoob0j6PrHC2c+GUb3HvflDEPxlfCpBeZGz1C3/r4wZYE/IC454WPoEe44wjXsKg4RNXs2
	9KyiCsHLre9x29ciCsr+2Hf4Ooc5svl6PkMJwnJXGVvxtzJ7L/UABP9/NFlr+JH8FsGL9SHIpC9
	3DTPEI3x67ZEjMEMCWL9s++5v1J8klp00m6u1WK6fBVvNMVgnXnr3rHNvqi6XfhTxNo6Na/+5zO
	mOkaCR4xhN5BRy2laWgGvVWF7YtqcM5IxZkgRSGdS5XoOXyI339eu/jHwB9xIg==
X-Google-Smtp-Source: AGHT+IGBmLj6tWLPVP17kacCv1bkeh5vDkEH9/sWNCuGqF6TfQj4uoU0k1NisoF3nK/aBveUbZIr8w==
X-Received: by 2002:a05:6602:399c:b0:869:d4df:c2a6 with SMTP id ca18e2360f4ac-86cbb8cd7fbmr116734339f.14.1748034542354;
        Fri, 23 May 2025 14:09:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a236e800esm359673339f.29.2025.05.23.14.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 14:09:01 -0700 (PDT)
Message-ID: <41d3b11b-d269-4ee5-a118-6608c804e068@linuxfoundation.org>
Date: Fri, 23 May 2025 15:09:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] selftests/mm: Skip tests dependent on a binary not built
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel-mentees@lists.linux.dev, akpm@linux-foundation.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250523184312.2647781-1-khaledelnaggarlinux@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250523184312.2647781-1-khaledelnaggarlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/25 12:43, Khaled Elnaggar wrote:
> Hello.
> 

The above doesn't belong in change log. Refer to a few change logs
in the repo to learn  how to write them.

You can also check the kernel documentation - this change log
is way too long. It doesn't clearly state what is being fixed.

In this case, "write_to_hugetlbfs" is missing because the right
config isn't enabled. Test stalls waiting for write_to_hugetlbfs
to run.

You are fixing this by checking if write_to_hugetlbfs exixts
from /mm/run_vmtests.sh

Summarize this in short description so people can understand
the change.

thanks,
-- Shuah

