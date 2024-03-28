Return-Path: <linux-kselftest+bounces-6768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9EA89086B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 19:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8EA286D32
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C269136E30;
	Thu, 28 Mar 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7/6KMub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935A36AF5
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651204; cv=none; b=F8x4x0B81dHM+0yNGVNT7lAJQ0MWpSzT6iLtbq+gWuhyhS9WDZxeHFZ2dxrfF32z5jPUZ3ZARj/NHATQMHcvm9BlPekX9Q2c3MwHqAGIxRqca7NgReBqXP7bmv1oAb09U7U1JPzpxoPPIspJf8n8NwSD4wcVvcZwwltcJJw1TTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651204; c=relaxed/simple;
	bh=5ORy6hh6Pj4sj97rnaLda12WtwInrQlYkxhTjSS2hnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgZ3J6/dXmlXeOyvPLIBvxN+JkYOeXrR9tcma1AG/Pq6fFwcbVxlX3Ddlx8OOuIaBbCo0ZEoQiGcmryKpQ7qmNpqz+7D4msH6ybIHF3OX/frfVgi3yQMlQ7TCAr1L/VPD0i5GWhyL0VpDo+u6ZQyrQ/bkKSXOedcvPSt4s4rQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7/6KMub; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3686ab64840so1829135ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711651201; x=1712256001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2g0kgrksduzPpTAzBEbZB+YDBF3iH1wIPE3J9n7lWg=;
        b=f7/6KMubQtVrgCfHgLqx3nCdD2twAmAdO+hj+kA2Um1mhlo8Y7tcsDRLNYyEBj6RkW
         wcZugbwgl/Wmpc5vqrMpv0u3JuECmlBzG+YTAVCee/K2EoVB/n5KRXL6y+rq5J4sLvUz
         ee8cucL9m9vNZ8a2M7rowPlnQ8gfBWgWsE7oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651201; x=1712256001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2g0kgrksduzPpTAzBEbZB+YDBF3iH1wIPE3J9n7lWg=;
        b=Q7vq5MamciTbTen52eKWNUkLzDqbwgfCeC3hSmJswBcJGl++Rka1/09DW+F6bPT394
         aPu1xi2FufVwuCzUNyCAViXQapEm/2l2ZF+lYX8Bz4X92Zht8s019HLhYWz1sHQErmtb
         9lkVgB+H7beVHIlMb8kloFwzwgpw/ctxAQUwV7gLUx+cbtVTJW1JyM52s4PXhldgGjuN
         moqks9WMDHMR6WLCpjFNBSPPNERsYsO+c1pXeLKg/5wQJ2M0l416uoaCfqg28II8epXB
         uYEKK3dHE1yQ07t7agU9oDhY5zaQPAF3USf5p/pY7wUWz33F35RuQkCggkc5aNEZORBV
         5o6A==
X-Forwarded-Encrypted: i=1; AJvYcCX802neyCOY63/OKG/raPBkNvOXG/4P30PURuzCQKdpSrtKVklteCDOWeGvhYpWmcWBD27g4S3eEEvWqZ1belQb/CocXiF0iFKyn2Kr2FTA
X-Gm-Message-State: AOJu0Yzi90nq2JMf6TKcaSmgJL1uuc55OOodS/8p4gkPiNot5a9sI1V4
	tYsK8d3m1jjsuxoYuJVEY1hfC3dQR+wREwqcoW6lb2kJht4/E006+1sOiubyWLE=
X-Google-Smtp-Source: AGHT+IGd+gyzScz2N+XqO9Cc1NJsPFjnzA8T8an4jUaf7fymquIzGI6WsTJTBaMFXavIcNu3vQNLGg==
X-Received: by 2002:a05:6602:2bc6:b0:7d0:8985:827 with SMTP id s6-20020a0566022bc600b007d089850827mr52930iov.0.1711651201099;
        Thu, 28 Mar 2024 11:40:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e12-20020a6b730c000000b007d057e4a970sm531652ioh.48.2024.03.28.11.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:40:00 -0700 (PDT)
Message-ID: <b06db8aa-9548-4b92-af7e-61fbd8a654c2@linuxfoundation.org>
Date: Thu, 28 Mar 2024 12:39:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests: x86: test_vsyscall: reorder code to
 reduce #ifdef blocks
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240327184637.3915969-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240327184637.3915969-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 12:46, Muhammad Usama Anjum wrote:
> There are multiple #ifdef blocks inside functions where they return just
> 0 if #ifdef is false. This makes number of tests counting difficult.
> Move those functions inside one #ifdef block and move all of them
> together. This is preparatory patch for next patch to convert this into
> TAP format. So in this patch, we are just moving functions around
> without any changes.
> 
> With and without this patch, the output of this patch is same.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Pulled all three patches in this series. In the future, please
add a cover-letter when you send patch series.

thanks,
-- Shuah


