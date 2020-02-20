Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E954166162
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 16:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBTPt1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 10:49:27 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40097 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgBTPtZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 10:49:25 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so5171177iop.7
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2020 07:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TNlV6j5dy2YpzNbMudPK2N6M4tmat+Q7yeBq9QSr2Cc=;
        b=DAkOWfFvuULYeW4zlDdUrSsxfOp2+6i3eNbNfme23q36UoDRNBkz3lGrwWsQARSF/b
         Bhcp7v4C73l4K6NITvym0C/OScIwDVQouN0vfj9CVVGbIxiQwUwfFxyjlbjrB23zO+ye
         ChHirGZ2CzowM+kOAz1UKlh2JTJKtBhGXeduU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNlV6j5dy2YpzNbMudPK2N6M4tmat+Q7yeBq9QSr2Cc=;
        b=X4WaN0uVwOB7z0D6LBT2PzZl1pTLcYnfjzOuyftJUAhN9Nljq6gqfvyHZJTIxo2XGi
         upIT1MCUg4hYnjy+CBPKJS9v2k0SOb8olNzQc0J+z5/i+9cLfH2ibRbnzMTYYASuBcN7
         J6wmDuvwUAWa7QF3sAu0Bg6NFJATAmu0B0AisVdM0zelNtVHnt9Mv4nwi4n+78OSVLCY
         1w0xxWjFDBTv7ReE7EYLup1QHT2OXitU1aT0OcmO9b/NkIEBNEsD2gk/7JOeoABgjoBI
         Uw9b/NybDRSA/YXz1kNuHunkGORePxkEU1OyypjcisXXv1hxdkN+hbUNB2ss9LUPK3k2
         ufYg==
X-Gm-Message-State: APjAAAUwV9TrBdEbU5RLG5j5ugFOOkIAM+Gnw/JLzC107ehhuHdtpMov
        b3DImsxwpnhAgQGA8GqCw2QdtfKk0lk=
X-Google-Smtp-Source: APXvYqwo5E+136MY2CwhDaw8W8F8otbFcd8wGERgcY8BOLwyf/TxO32uWLk0lDAiASLqVmzlDZeraA==
X-Received: by 2002:a05:6602:2113:: with SMTP id x19mr26054792iox.227.1582213763404;
        Thu, 20 Feb 2020 07:49:23 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r18sm1216159ilo.3.2020.02.20.07.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:49:22 -0800 (PST)
Subject: Re: [PATCH] selftest/lkdtm: Don't pollute 'git status'
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <668b6ff463849ceee01f726fbf3e7110687575ec.1580976576.git.christophe.leroy@c-s.fr>
 <ca71e490-b4fa-bf53-7a60-b6954b9dd33e@c-s.fr>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <17ea7ab6-d5c4-cf38-3c3b-9da70b2c35b5@linuxfoundation.org>
Date:   Thu, 20 Feb 2020 08:49:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ca71e490-b4fa-bf53-7a60-b6954b9dd33e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/20/20 7:58 AM, Christophe Leroy wrote:
> ping
> 
> On 02/06/2020 08:11 AM, Christophe Leroy wrote:
>> Commit 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
>> added generation of lkdtm test scripts.
>>
>> Ignore those generated scripts when performing 'git status'
>>
>> Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Without this, 'git status' now reports the following crap and real 
> problems are drowned in the middle, that's annoying.
> 

I will pull this in. Please cc linux-kselftest mailing list in the
future.

thanks,
-- Shuah

