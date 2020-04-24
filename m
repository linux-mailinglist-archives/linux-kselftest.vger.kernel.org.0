Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0C1B7787
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgDXNv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726707AbgDXNv0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 09:51:26 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFAC09B047
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 06:51:24 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id x2so9306772ilp.13
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H+CTATUY43QUl8bEZDT4/FwObgvLqI92c3iLY3Q0w14=;
        b=OorVP0iSjGLd1uPapODQNsplj1Gqmm+THths8W6ixLi97RC1HqPzC+yrHHWSUiy5gI
         xxywWUtpL8xY0askqqQCyYo/9yYh3difefwizlJXSrLaXSoi2MlFjXeFtim4v1MBZmhb
         cL9WD+5t/4pm+RWs/73JhkQkGVcOnXySGMiDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+CTATUY43QUl8bEZDT4/FwObgvLqI92c3iLY3Q0w14=;
        b=nw8QmeX6Yi1TXWoi44DNXXNqrWbBm1BcKAkmRrd5wcL1cJeNz0acNz3nqLuqM/0pr5
         qAAfzzGJ6YLUKSD5j3AddOGg8nkTJPmgjUl+5XIcPRUHKYqF5zTWI/qOBTvn0VVr4ZDg
         rZNybJgSVm8BxlVqlIHXShrQFwdndPpY8bej0Kd+sUwadfzk8yEVs92wsw9huF4N1pkK
         ka637mmqVupEJ7aXi9JWM8DccxHLaHIQCxinxrYFf7u7f8T8I+GxhUxCs3X+gZ7VP2dD
         imkOcDyo/9AjoZimxC141pfn6C4GZ371A1/6C6DD3whSMcsL9KKZZEOlS42gWK6IcAUB
         PRNA==
X-Gm-Message-State: AGi0Pubs3OaWx35BeH8ijJGok5wanbC0F+GGW2SHM031Qd8fsDKjqCLY
        s2PzUUbGdGrZvUs7ZmbAimtKqnxFEc4=
X-Google-Smtp-Source: APiQypLTkc2GkWL/T3rx0fb+9zJAX28z3GYjexeUDoq25xwzohe8uX2ewDoXKCyKUWlZ8oR3mAf0aw==
X-Received: by 2002:a92:d744:: with SMTP id e4mr8832181ilq.174.1587736284020;
        Fri, 24 Apr 2020 06:51:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h82sm2101809ila.14.2020.04.24.06.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:51:23 -0700 (PDT)
Subject: Re: [PATCH] selftests: add build/cross-build dependency check script
To:     Randy Dunlap <rdunlap@infradead.org>, shuah@kernel.org,
        bamv2005@gmail.com, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200414212208.21667-1-skhan@linuxfoundation.org>
 <374866ac-4519-f367-bdc6-ec8d0c1b6347@infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <734b0bac-ace3-13fc-b8d1-e317a8512c08@linuxfoundation.org>
Date:   Fri, 24 Apr 2020 07:51:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <374866ac-4519-f367-bdc6-ec8d0c1b6347@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/23/20 9:25 PM, Randy Dunlap wrote:
> Hi,
> 
> On 4/14/20 2:22 PM, Shuah Khan wrote:
>> -CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(MOUNT_CFLAGS)
>> -LDLIBS += $(MOUNT_LDLIBS)
>> +CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(VAR_CFLAGS)
>> +LDLIBS += $(VAR_LDLIBS)
> 
> 
> (1) Can that series of ../../../.. be replaced by $(objtree)?
> If so, that would be much cleaner IMO.
> 

Agreed. It can be done in a separate patch. We have other tests that
do similar hard coded header paths.

> (2) I can't find anything that checks that ../../../../usr/include exists
> (or has been installed via 'make headers_install').  Or anything that
> requires that CONFIG_HEADERS_INSTALL be set/enabled.  Well, other than
> a Makefile error, but that's not a nice way to find out.
> 

At the moment no. When this Makefile is fixed, that is another check
to add. It is addressed by headers install during selftest make.

Headers are installed as part of selftests make since selftests are
often dependent on recent headers and headers install is a necessary
step.

You are right. There are several tests that need cleanup for such
hard coded values and this dependency check script in this patch
currently does libs check. My plan is to extend this to check for
headers installed or not and flag headers as missing dependency.

I can do that in my next version of this dependency check script.

thanks,
-- Shuah


