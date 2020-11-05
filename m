Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D672A848A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 18:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgKERPA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 12:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbgKERPA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 12:15:00 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D636AC0613CF
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 09:14:58 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 9so2428904oir.5
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RXtyLeNDFuRDqnpcqt6pb4ylWjUgE0/Ib+KjlVuBXqE=;
        b=g0wFBccrkYCSKXtrUi4mFAVl1sBMUEF3Lg525W88ykFuyy3aef9xbZYBSZ+Ia3uOMo
         tmpQRRVPX+mJK5HrGD3NaW8o2fqtdOR6pCSl72eHGjHsVQfr10+xzQ2Om5I/gs/jeEgK
         HBLnTX5zUThEeSdyGwNs7ODngz6MQ09QAG7dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RXtyLeNDFuRDqnpcqt6pb4ylWjUgE0/Ib+KjlVuBXqE=;
        b=dXN4lh9oXOy6Dt8GcZEKtwctZLIIPQ1IdJ7nQCMKJbJp+XrzNFv+mmOJ5SiYVHOoGf
         GwHZfstHa2uq+j8BVBOMbQ1Mk7zLlcAaYQHp3zwQ1Os0we/8D+OAIn2AaZ3HuN6KQZNY
         KrL5mbh2aMCIp+01YabP+l9AiTUf+CUqyRuQ9D4q/boq048SW1o8pjQ5aotHnsyZ4KXe
         8WcNj/4PjzMi6dFkiHzLhifATWtOhCtPvXX2rvF9hYTnojZoO7gwMdMdtzoTup5HHmi/
         oOJZZU9bTE+fb35QqizhJVoW42VXlwdYmbD6PR6c+iLzXK/LZ+JuQBe37tXww/93gJ29
         aqNg==
X-Gm-Message-State: AOAM530R/d2tPhy+thXRVC5O/pwEnScYiAdYOaelrTrWv/p+ExJNFMts
        5Es/P3NO83M/I9nSd/fv5a7NJQ==
X-Google-Smtp-Source: ABdhPJyPTuj7UbQcutxVyj3OIQJLYo8G1acVwWKF7+YQ+EewEqrFVqSnAzFIcAnmX2ExNF7uRib7gQ==
X-Received: by 2002:aca:44d7:: with SMTP id r206mr282559oia.24.1604596498202;
        Thu, 05 Nov 2020 09:14:58 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c21sm474397oos.30.2020.11.05.09.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 09:14:57 -0800 (PST)
Subject: Re: [PATCH 09/13] selftests: android: fix multiple definition of
 sock_name
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-10-tommi.t.rantala@nokia.com>
 <20201009120538.45uspbezh5tqtin6@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3d46cf84-b987-d138-c6cb-e9679687ce0f@linuxfoundation.org>
Date:   Thu, 5 Nov 2020 10:14:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009120538.45uspbezh5tqtin6@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/9/20 6:05 AM, Christian Brauner wrote:
> On Thu, Oct 08, 2020 at 03:26:29PM +0300, Tommi Rantala wrote:
>> Fix multiple definition of sock_name compilation error:
>>
>>    tools/testing/selftests/android/ion/ipcsocket.h:8: multiple definition of `sock_name'
>>
>> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
>> ---
> 
> Ion will be removed from the kernel soon but this seems like an ok
> bugfix.
> Thanks!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 

ion is already gone. I am dropping this from linux-kselftest fixes
now. This is also causing conflict with ion removal commit

thanks,
-- Shuah

