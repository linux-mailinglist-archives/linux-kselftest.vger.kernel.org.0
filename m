Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6591817C99D
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 01:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgCGAT6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 19:19:58 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35117 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgCGAT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 19:19:57 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so3855091iob.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Mar 2020 16:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NSjfSL+QfSTDf8gsw0rEhWcCVhS3ZyC2JHCZZDzLAkk=;
        b=BfHT6MrTqmTvz6StrgNngfhAD9KFspP5YNkvhnAgFKMFrW2HsdtpPY+eM9MTT560bx
         AT5zjLYF75bZYSGUwUaG685a/NdICEkNElbBvzqGy9Cw/ZvVyXV3TE7izOhF/G7kmCjJ
         hYYz4hbVwOuQWTk5fzEc7eXGUZtxXsZnT3e88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NSjfSL+QfSTDf8gsw0rEhWcCVhS3ZyC2JHCZZDzLAkk=;
        b=W+HmzZxLNp/aMGm3DqInPHc+z8mOZae+d9KyuJUkZ2TE9EVrWKv5OOzs8+t1hgNyfg
         LQGb+KvNTaDZokHzhBfosCryp8r8kOeTcpaDoFfyp3zrNczKT/jwN99Kq9A6pdH2El66
         zH/GZsKuQOV0DEyVByEwRBwAAXZaJhFPl7/PTe8zkv6y//UdMrhUBc9lh660dZwhRc6w
         ekr9mvrhDPyTZg8rRE5kKzCxGx+T6KPLT0xNflh24L6JOsEsEb4rQh6Wf1jfAmjJ8fD0
         Bmr1p1sZlJ8lcYL/g5AtjztPzRZJm4AHoLWalRfrOsyTBPniH5lk0+icuLGu5TXtJYER
         jZ/w==
X-Gm-Message-State: ANhLgQ1Nq3jjUs+Rz0zoUQwZytskhRaV2rdpNiRIJeaDzjzSyDlLumee
        Z+F/jk62x+3N3+Lv3nxt/ZuToQ==
X-Google-Smtp-Source: ADFU+vsZcOc+y0H4k1ol3rKOKsW2mSj+/AU6MpZ505QjGYHGgFwSGBxKCxVcY4XqUfBzlAgk7WzLRw==
X-Received: by 2002:a6b:e013:: with SMTP id z19mr5109744iog.103.1583540397178;
        Fri, 06 Mar 2020 16:19:57 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n5sm685109ion.25.2020.03.06.16.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 16:19:56 -0800 (PST)
Subject: Re: kselftest selftest issues and clarifications
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <MWHPR13MB0895B92C9B4807D94E1E6B04FDE30@MWHPR13MB0895.namprd13.prod.outlook.com>
 <f1f991a6-6e05-6ba3-b5c1-174b93029a99@linuxfoundation.org>
 <818d8b84-4ce2-4cbd-d561-293137c5d884@infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6af54eab-a982-dfa9-c6d3-c3e017dd4ed2@linuxfoundation.org>
Date:   Fri, 6 Mar 2020 17:19:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <818d8b84-4ce2-4cbd-d561-293137c5d884@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/6/20 5:18 PM, Randy Dunlap wrote:
> On 3/6/20 3:30 PM, Shuah Khan wrote:
>>>
>>> And I'm using a KBUILD_OUTPUT environment variable, rather than O=.
>>> Let me know if you'd like me to build a matrix of these different build methods.
>>>
>>
>> This is fine. Please note that relative paths don't work in both of
>> these. Something I will tackle once the bugger problems are addressed.
> 
> Please see/test/try this patch:
> 
> https://lore.kernel.org/lkml/158351957799.3363.15269768530697526765.stgit@devnote2/
> 
> 


Will do. Thanks Randy for the pointer.

-- Shuah
