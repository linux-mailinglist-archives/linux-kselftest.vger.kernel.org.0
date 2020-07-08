Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447A2218B14
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgGHPVA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jul 2020 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbgGHPVA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jul 2020 11:21:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37DBC061A0B
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Jul 2020 08:20:59 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k23so47327443iom.10
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jul 2020 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upDvnN501B9Woeqk+Gky2vENWRjvgbK/EAznbDWi4SM=;
        b=KEE4SSYMIk+VDfx6X1TKQL0jHgyQkHOnmPVgf7+HEmk5QlJla2qUI3gJryg2iZECXG
         IoJvrJ5L0zCUZD/Iglwd4maNeH8u1rQRXJs4KEusTBBUpMKP/QH3HiJGVEbMisCMwdWT
         aC+vhLm+xzn1blAlWBSrotPv+Z7af2OBAbzqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upDvnN501B9Woeqk+Gky2vENWRjvgbK/EAznbDWi4SM=;
        b=G/cw+Vlevcf52Ypb2lQDlcskYQJ9fZnM7BKEbU49p3YiD599QDYbXhmcMcHpqtYgW6
         do51h/ECpgEDRzME+SCkaPZNo4hqGs/jp5L9ZuUHeiFfdofazcVThOGhHwIvQ+SSrwFI
         8CMebZYnmMaCS6RpAIBrzZofxuYY0ant2xsMOkUk0ilXaQC07Rm113tsKqWFqrVPrFeJ
         GJbUOZx9eJfjhHf1WsOP3V/uQN0GHbVuC1ZLUYPB3/QGiNcpXDwJxnItLvAN85FXSOqi
         sD2tgX2YdGchjohe+MHa66+VAX9NjSk6FeEZxvrSF/A5m61umW+FP2fOYVnUUm10KcuN
         U+1w==
X-Gm-Message-State: AOAM532bVum6XzD4uxofTS532edGhMe8++1ryocbgsjAgoRY7Fr8GPa2
        mQUHlEOvdW075m1bseF8rU3VwQ==
X-Google-Smtp-Source: ABdhPJwMZ6MEMXRL9JUI8ZQMhMu+CbM7A/4K6TZOo9a7aDORzDTJqzFB3b5Zeule8UGW4xdgW8uDmQ==
X-Received: by 2002:a02:ccb3:: with SMTP id t19mr66889054jap.122.1594221659242;
        Wed, 08 Jul 2020 08:20:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j17sm28425ilq.7.2020.07.08.08.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:20:58 -0700 (PDT)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: KMOD KERNEL MODULE
 LOADER - USERMODE HELPER
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200708071337.13108-1-grandmaster@al2klimov.de>
 <20200708115324.GE4332@42.do-not-panic.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <57601e00-d351-fa06-0fe0-1a0238f68912@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 09:20:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708115324.GE4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/8/20 5:53 AM, Luis Chamberlain wrote:
> On Wed, Jul 08, 2020 at 09:13:37AM +0200, Alexander A. Klimov wrote:
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
>>
>> Deterministic algorithm:
>> For each file:
>>    If not .svg:
>>      For each line:
>>        If doesn't contain `\bxmlns\b`:
>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>              If both the HTTP and HTTPS versions
>>              return 200 OK and serve the same content:
>>                Replace HTTP with HTTPS.
>>
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Shuah, can this go through your tree?
> 

Yes. I can take this through.

thanks,
-- Shuah

