Return-Path: <linux-kselftest+bounces-21412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A219BC0EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030A7B228DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 22:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8FB1FEFB0;
	Mon,  4 Nov 2024 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IK+qHm7v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627F1FE11D
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759299; cv=none; b=hAFr0Z4f/s7RrvzTATCe/acdDI9ERdZ9dozF8xpSml/mNB94NH8JkRjWmC21Ze0V/sD2i8eKiglzU3XRvbrvy54cv5QG7TGIhXsF0eQzTa6iXQ1O+2hrGGx9aR7JG+dzsMq4PbyR9jNezSufkpsr+a7Si4LYGpz40RBjK1k/Gxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759299; c=relaxed/simple;
	bh=dbJRgW5uebXlKtcBol1ClLLvP2/tGNM0XYC93P0716c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZcmIMSg15QmbubSuD781f15TTF4Fl5+ufgqd/YliCcriRtlIXgM6QeR/+6GPlOLU0L4Iu5tDR1/Ire8SFJws4MV0EtoX0tVu9hVuwDdSnhd8tVClg9x+M35VfSBTB7/LGfyIjGd0udmbLIkEdjURLwPC8IHmMagsAfr3wEhQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IK+qHm7v; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83abe7fc77eso198308139f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 14:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730759297; x=1731364097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0PpHaAepvBwCmmRuTSYTtbzJ2tDagh2UIfBmzCGWWKk=;
        b=IK+qHm7voMcNvSYXcERGg25agZY6N2NaJo54JydavwX052wR/Z2x4zoF/o2C492GT+
         dddCGY1TuH3q2yMhlvfizRASR8ZOYUu30XyjdHFtP6fIuhvw3RrrJRSxziQ+N8NZLY2c
         XVQobCJTeVCBUe5505roPTy//dsV0b4LkJTFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759297; x=1731364097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PpHaAepvBwCmmRuTSYTtbzJ2tDagh2UIfBmzCGWWKk=;
        b=psnQcVqRNRvJOmEDxtzb57dIYqzR7/HPXTcNIOX6i5ODa3RiE+z+8BS4C06xYVR+nu
         3uqxl8VPu4wwLHr+9DrCa+weQc8Pk1l24ShWf2admVdud8+t7otvoNKerBJ7/mMNKg64
         s9K9uSxxRdOiQqTEoD/FaiYQCiAq9X7hfk3Hgdt358c4aJpSG1HoboJzb4d5AIVlYqgZ
         p9AOdFyuROXGMgmrYG6vH6Fa2/0h9YmXMthTs6k5KSc5fk6p5y6oTWFMRuY8Z4kc/jB4
         PhP/mT12R4JZ50vnqf1n8MIBO82GnO0XtCIVrdrSDuJ+nDVUKbOxc+slJFPlV4e16G4Y
         y63Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6oUppOi+JBn8oTHpe9TVpb2HbNhQASNTuTW99y/MrNnm0E971QWEF7bl9QWp992ThAtQK5k++RZM4lHDSD8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdodov7GwcbQTFpQl+ZXURfqti+xRPGB9OddeGHn3FaxbpzDs
	L5fJFuay3mvOWYqNOgGzoNVN7RCE6cNBEKUZPyXxUupnlfccX71ZT39Kxr73sFE=
X-Google-Smtp-Source: AGHT+IHvvadZZAWAqd0cl7rveBR/vWFq3SR2vE7sVfhYTUcxMLumTtQzoTJVjt60yl6N+DWew9ZiZQ==
X-Received: by 2002:a05:6602:29c2:b0:83a:71c6:26f4 with SMTP id ca18e2360f4ac-83b1c5ee442mr3519890339f.16.1730759297088;
        Mon, 04 Nov 2024 14:28:17 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04977c73sm2077086173.91.2024.11.04.14.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 14:28:16 -0800 (PST)
Message-ID: <3ba7cd24-a68b-4996-8b36-dbf3164db8f0@linuxfoundation.org>
Date: Mon, 4 Nov 2024 15:28:16 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms
 with MBM and MBA tests
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org, tony.luck@intel.com, peternewman@google.com,
 babu.moger@amd.com, ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729804024.git.reinette.chatre@intel.com>
 <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
 <5b2b54b8-77fa-4ef9-aa08-549cab91eb32@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5b2b54b8-77fa-4ef9-aa08-549cab91eb32@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 15:16, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 10/24/24 3:36 PM, Shuah Khan wrote:
>> On 10/24/24 15:18, Reinette Chatre wrote:
>>
>> Is this patch series ready to be applied?
>>
> 
> It is now ready after receiving anticipated tags. Could you please consider it for inclusion?
> 

yes. I will apply the series for the next release.

thanks,
-- Shuah


