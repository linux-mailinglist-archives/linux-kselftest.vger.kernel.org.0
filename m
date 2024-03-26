Return-Path: <linux-kselftest+bounces-6663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F9F88CDB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFB41C2E1BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 20:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7813D282;
	Tue, 26 Mar 2024 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eGygfekZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8213D265
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483326; cv=none; b=jrcreFHW0lBGsoT/NZDU1TvOYGzvEkKzniFCCcRCTOSHLqKwXlCZ3CWlMSrRRWRMcyBYuikf9fsiMrVjuiGbhc6R47gPHIeSq5mjZ9tKuyzYx0m7Qxksezb06pGZ2vS1HFDHBjQfXvGas1Qrh29HKpRSVb30JxtmIFugFvUfgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483326; c=relaxed/simple;
	bh=NVyT1rZ5Z09EkRaYcg04Xz5VJbpOngmHOVufF0GzCuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNcie7dtMxhFziiSVJ1Quz6X1VMIE07cmYdJzTo9JrLTyzZoA/zooxjjzKOikkiudF2gr2tBjQMyXE/Mlc+WQADQMPZwuTdPiCXf3joZ7MKT145jcYug0qr1nqZssoN+XwUEDk3A9zzh4rBS88KGjcT6YdFVHP0Zp5++49yJR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eGygfekZ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso3062439f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711483323; x=1712088123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ceDt7l40yS8ehWwNFlDZMvkF/pov5VQ5j/XeBU2FK4=;
        b=eGygfekZ9sfpLWPv+anX+TmCJmDUB2gE5DLHrRf49+KxwQVguF7BvgtHDAzBefZ98G
         CufybqAhb37t/gQAY7bR6wuWYp7fv7pH/QVAcFJ70KNvO5zAu0jFWPWBXZXKYSwL6I8z
         WrLuTWgJ7EoYa9FDsadkOorGIER5grsq68jBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483323; x=1712088123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ceDt7l40yS8ehWwNFlDZMvkF/pov5VQ5j/XeBU2FK4=;
        b=fVDE8zWdT5K8FJyUpiogTLqHw5f/r93kf5Bp0Nz7Nl4HyQK22FHVSJxWrOY0SEOLRp
         W9d4AdNUWlODR74fcWce0HE11rEmhzjyrz2tM1lAz5HbrUt62DiXA6CqBl+B43E8Itzk
         fQWPie0/CgHJnHscbwuzcpmIAd3XAokvL7ZxMiVV/ANznYlCl+fE9b+aOjHMcT/OggF7
         n2JZqwvZmrA7Tl/m0TOigCQMMZI2CNBXC6o95w3arvACCYhvT4g6J6yxFUiF1KjFHrOL
         LSSBI1YK9w9AI1sp6mSqUMaqeUTgOl0Nsz8vP0xmPCMWxzdcJ5rVmeyk/mFK8gkoIpVf
         3l1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1c4FQRrwkUk+TuACR5K8UlALaIkib/FaQJ62uZcJzuUxSNEg8BH97QvAF+9q1V6RZssGxxtIQJiTWla6KFxt9+7j7rAlsLv278nN06+NU
X-Gm-Message-State: AOJu0Yzga8iQCqbS/U2/JSL5WSatYCjj2y/cmfdPzpnxevlG5pziuDXw
	QpxF0rJ421R+qT08M7SMziGJeS7QIOahzqT5JHkdsR4cb1eKclT3JGGJXgifI50=
X-Google-Smtp-Source: AGHT+IHTtc/I5Tza5E6NUgf+B527aT1caT0ldXqAFDQVLsHVo6+FXPjzT+mhcV5alzJgv4Wbcs+fgA==
X-Received: by 2002:a92:de11:0:b0:368:4839:9b0a with SMTP id x17-20020a92de11000000b0036848399b0amr9316779ilm.0.1711483318537;
        Tue, 26 Mar 2024 13:01:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j12-20020a926e0c000000b00366a3016a30sm3105612ilc.70.2024.03.26.13.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:01:58 -0700 (PDT)
Message-ID: <19beb37a-932d-4777-86de-c2c415ea56a6@linuxfoundation.org>
Date: Tue, 26 Mar 2024 14:01:57 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: x86: test_mremap_vdso: conform test to TAP
 format output
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240314103216.286603-1-usama.anjum@collabora.com>
 <20240314103216.286603-2-usama.anjum@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240314103216.286603-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 04:32, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

This one looks okay. Please address the problems on patch 1/2
and send v2 for both.

thanks,
-- Shuah

