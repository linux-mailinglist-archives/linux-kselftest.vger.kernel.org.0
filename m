Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4A57E4A8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 22:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjKGVXj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 16:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjKGVXi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 16:23:38 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED120D7A
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 13:23:35 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35950819c97so4138435ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 13:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699392215; x=1699997015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtzi+TszAqVWEZJQWIHSFO/HSHZJHi2BvQ12spn5fho=;
        b=ZQb9I1hQiQxV5PND4Ea68bZEmNh19y0Zs+jwJHjplPT3KmtnP+XGBP1M7rivOZYZui
         ibA1Qi3yIQnttKYUxiEv6k+dJZp1AjbQbRVKGEZxSlbnRKdJMWts5O8yt9ei4MPkoM/V
         BLQ+fgde4E7YVbglbSKbuNrbokmReirkwmeQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699392215; x=1699997015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtzi+TszAqVWEZJQWIHSFO/HSHZJHi2BvQ12spn5fho=;
        b=eZpJMAz71u3ctBneUEya7kaVdmMdsfTqxckuTE9jSioPCtig1MLFkbZwf4iU6mWIL1
         tk30wEy6KKseBnPGs8eMRPEYVoIKesY/iDhQTDUY3iDRpb0JDFVN6n75YTue4QkwpD/6
         XLVRNH3yu35GfSiD+kTYXgOn6lY5bdIlBdOtd8ey1jp/7tiLD5E9+1wzDRha0Ngns8Jd
         ZsrnvkCdEErxojB4t+8UB8Zu5D3KejyYs9weSu6cA0D6Uc+Qlobf+owGDaI7Hm5LL4G2
         JjaUOJFRhjV9HtVJN+PtvSvFnxjcw9zqdik7PLZ+Jaq7SGa8lugeS07Zhzew3rIsZVjW
         eijA==
X-Gm-Message-State: AOJu0Yye6EQCU3alI2x6vXOCYEF53riQDXcg4iI2/aNAQVNcNh0RdKyv
        eq0fN4yTSmD3wyuSHUnLyD338Q==
X-Google-Smtp-Source: AGHT+IFUJw2/d40v1RpVWENnkltY7sbFKy+YRt8lL1zimhATc9h6LLV6++VkRY9Dgw1ERsUTIleVdw==
X-Received: by 2002:a5d:8ad7:0:b0:7ad:3ee0:86fc with SMTP id e23-20020a5d8ad7000000b007ad3ee086fcmr80165iot.1.1699392215338;
        Tue, 07 Nov 2023 13:23:35 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id gq10-20020a0566382d0a00b00458edc46632sm2883067jab.156.2023.11.07.13.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 13:23:34 -0800 (PST)
Message-ID: <0f3a63ff-cbf9-4e06-8f4f-fd22bafa26fe@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 14:23:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: capabilities: namespace create varies for root
 and normal user
Content-Language: en-US
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230929125348.13302-1-swarupkotikalapudi@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230929125348.13302-1-swarupkotikalapudi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/23 06:53, Swarup Laxman Kotiaklapudi wrote:
> Change namespace creation for root and non-root
> user differently in create_and_enter_ns() function
> 

Sorry for the delay on reviewing this.

Can you tell me more about why this change is needed and
include it in the change log.

thanks,
-- Shuah
