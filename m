Return-Path: <linux-kselftest+bounces-12181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F190E022
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 01:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9F11C23118
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 23:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB97185E71;
	Tue, 18 Jun 2024 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmyWyxzp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B568185E61
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754273; cv=none; b=ioFxk9G8uNT8MolTb/yeRPZ51ujyPxbOw9yVVsO1F4pgMUQhMmQ9Y3tZ9NmnnDSj7H4b1dQCWp2ft9UtJt0nWJY/8+FHjMgcBMHHcZkWjvy+GgodtjrUAx44HJDSdzhxkArYswTSfOaOVPXw6NUbPF8+lQjiqlAX0OU4VQFvA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754273; c=relaxed/simple;
	bh=AUXRFG06DcwGhrTY3LEDdoAlZ/W9aY/Wgg4qr/4pmDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+2cP/QvWytRapD4gcS8vtzskYoOIbsdTbnqdPpR+V4MlMCLTgSMTz1kbfnivPgIpzQW2IYuMNRCeP5qDSIzqMV6YkFO3zOJ5lswtsbCNG+seuOZg5dlBoaOGqHVVsK6rm120Z7i8cun+cxOSVahl/Q+M7EzAWWTrXC+2SVua/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmyWyxzp; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-375858224b8so3260795ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718754271; x=1719359071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LF6JwX5v6JwcSQfg0sAK1erZy9H9MjS5VLxFNiK67XM=;
        b=cmyWyxzp26RbD08foyDoo5DjA06D8C4KUSg/GbTqKl9qtAK4UD8o0olKgCIzDpbIPq
         ukcgVXKumi6JeViSAQPzpZoRe+ltkVhRSpg0VHCsE4yQLXO+CevmSdCFWe6peqMmxYx3
         KhJU81tiKdoKoHSqYBW/aVcBenRHEP0gcgLvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754271; x=1719359071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LF6JwX5v6JwcSQfg0sAK1erZy9H9MjS5VLxFNiK67XM=;
        b=POrL1dspbR6ESJOXH3OXXqFWv/hPlOkfcDp3jfCdy3kEYQHT9mhpBp4fCQoSAOxz6Y
         1IWjt+Wz7Yeeyu59GpXh34FtiA3KIgbPvI6PDaf7bN3wR7Zh97MDedybYhnbTleaW3Aw
         lVHh58Ot/4lJCxPGWNBsgs4PxEz5Hkb8+0KU56B6thHrzyCFDBoS/gFo+kd5LGD0TrcD
         MeC4XhGWylBd5Jv5K9u9RhJznQJnC7t5F76Zy8f7eexuTXO4/Q3hEVy5WmlyiMmFW82u
         mAwp9pbLcloWjQ+s2OR0njU2t+qBRN53BkMocZZPtZl8CBOSI49qfJ0ctbHOmPcB/BWx
         osXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcxUewoeGv78/I37izfwczwuJcqtpUyD9bq0LH3gVC4E2Vcynz/WXlTEkrJnKnGSF7fPdtZq63Dko4JHFpDKQmgW7Udx1JNAQdj8pvQOW0
X-Gm-Message-State: AOJu0Yx+LiTa+bgSyvYF8Sv/zigDSDnKtRPZSoGoVD2EANEwBhst1iOS
	r8QolYx//SMigobYAfpWQWu+plRePiHcrb2ya82lroKwZ4fezlJo81i4rhSkUns=
X-Google-Smtp-Source: AGHT+IFNozUHLKsr2mQWALzF2PG097Fw+WlGQWqgjuoxKWN84J11NjRK4wqfc3QwlVwBuweVz+LvYQ==
X-Received: by 2002:a92:d24e:0:b0:374:88c6:385b with SMTP id e9e14a558f8ab-3761d6f3b11mr10963895ab.2.1718754270688;
        Tue, 18 Jun 2024 16:44:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37613f7a968sm2603405ab.22.2024.06.18.16.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:44:30 -0700 (PDT)
Message-ID: <e19e3512-6b6d-4c89-9924-d9f6899fff1e@linuxfoundation.org>
Date: Tue, 18 Jun 2024 17:44:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/16] selftests/resctrl: resctrl_val() related
 cleanups & improvements
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger
 <babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
 <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/24 09:14, Ilpo Järvinen wrote:
> Hi all,
> 
> This series does a number of cleanups into resctrl_val() and
> generalizes it by removing test name specific handling from the
> function.
> 
> v7:
> - Truly use "bound to", not bounded to.
> - Fix separator to use 3 dashes
> 

Applied the series to linux-kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah


