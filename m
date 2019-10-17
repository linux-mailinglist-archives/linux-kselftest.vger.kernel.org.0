Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DADDDBA44
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 01:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438671AbfJQXm6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 19:42:58 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46682 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438582AbfJQXm6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 19:42:58 -0400
Received: by mail-il1-f196.google.com with SMTP id c4so3794591ilq.13
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vw4ldBye3TR94WtUSfGYR0rQPaoBVOS5utrqGwpOO0A=;
        b=Na0+GRKMnASQ+fxY5uh4yM7YZn8rKC+8PSHM8MqwP5mrtYoa3dOn12Jl1Tjf0qnGvE
         sAIbMX4gwrnggmxqUbnQ0efeRW/+j5tpC6o47KB5GkrUcGKSGLYGEE3ompQnEKMzr2Be
         g8r2/Lo6ncZNYolD4Q9dpiZc4ZOeL3d4S3+U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vw4ldBye3TR94WtUSfGYR0rQPaoBVOS5utrqGwpOO0A=;
        b=blnMx2oDITBAnFCY5zj284Aj+/o0y+HqbEjE7h3czqwIUCRHOcSXnMtBKRQsg55I2x
         dVbaUgo8xT3kFx9EbZsMH3ucnyu0pjDECkPAdW0YM3c6o6oP+qBHNxs2kSb9STPs5qaJ
         zVd2+Y8qdzK2n04x+LD64IcuQXjZjH3F+Hb/Wd9aAHv+cxrokfh6pJM+JCBR9TlAcFsM
         Vh6/VfV//z65reZd5787Hxue3feTzRi9pDIk5EpdsJvt8qb0XlHCP73Q7r4EDwNXtr77
         3cyRzl9fXwGcGCIjCcV6iQ1ZaOdykyQHbs8mYeYCkOLe0L+sr2X+59S/gu5MkICvOaXW
         wCbQ==
X-Gm-Message-State: APjAAAXk6tUMiM+f6Mb+9bt12YT+blWfVswYhoX/0sbI37QWMgylnXhc
        dyCSMvqJ6vLm4IMDWcNTEimv6w==
X-Google-Smtp-Source: APXvYqx1xB7DQxPw+YObD9tYUUmTob1HabrBcMc5TkE8UNGX5zqbAV6hW7f7YAt7gNi1LvnHi8jU8g==
X-Received: by 2002:a92:bb81:: with SMTP id x1mr7038124ilk.299.1571355777298;
        Thu, 17 Oct 2019 16:42:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 6sm1261929ion.66.2019.10.17.16.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 16:42:56 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
 <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
 <40073fc9-1de1-9253-e2f9-9cf9ee4308d4@linuxfoundation.org>
 <CAAXuY3r7QKSuwVYDQhF8-zC75ZRVHr+4pzpGXeNbPaEdbM3h4Q@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <56189643-af2b-f754-bc95-60ab4f126c32@linuxfoundation.org>
Date:   Thu, 17 Oct 2019 17:42:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAXuY3r7QKSuwVYDQhF8-zC75ZRVHr+4pzpGXeNbPaEdbM3h4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/19 5:27 PM, Iurii Zaikin wrote:
>> You can do all of this and allow users to supply another set of data.
>> It doesn't gave to be one or the other.
>>
> What is the use case for running a unit test on a different data set than
> what it comes with?
> 

Let me ask the question in a different way. I would like to see the
ability supply test data at run-time. It can be the same data every
single time the test runs.

I am not seeing the reasons to embed the test data in the test itself.

thanks,
-- Shuah
