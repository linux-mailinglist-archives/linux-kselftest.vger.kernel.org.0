Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5918DB9A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438356AbfJQWVL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 18:21:11 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46182 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403959AbfJQWVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 18:21:10 -0400
Received: by mail-il1-f195.google.com with SMTP id c4so3644428ilq.13
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e9mJqFmkKcS9XIL9gBV6QeNQddoYFUGCj5AcbMh6xfo=;
        b=NIl4EDoBg5nZL0DLvTvp6iKppen+x7wAJXDcesdcUgGrLOWS/PPGDqcVPS/evWHeem
         Slx/Dtjf7LwQYKZQ0zCMjidkHOj1IuwxeXKE0YYQAIrs78n7z444nyfoLzjthNNGE8+C
         ibtJRf2GFK+OJUzL9qe45Q7ApHoPYvUbn50pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e9mJqFmkKcS9XIL9gBV6QeNQddoYFUGCj5AcbMh6xfo=;
        b=A5JHaiezsttv7f3LKjoevgGq4wMzEjLHsoIytCyZLXFL1+VnrM6ITjwAnZWwiDTYYk
         plOB3UPDmHtqWu1i7aCn7ENSGyvpyBVqVQ89jThXGBgqztghclxwAgVqMHpqDdctLczc
         KqZwafdS/vKmL5x08TLRV/JWkRurS0PJ3D21vT91I5vwRQ//dAmPg8bOCM0/NDdv/FdA
         8tFEg68Rtby/K7ssTbaKfI0hS+JVBIaxGWiu710ioxoQsDaKv9bUlx1JW3nwacMFlOHn
         Q+mjffpvi1FvUX+sT0A7AuJRRSTL+bCYapK1a4oFy437IqvaVKFwxYB9uJQC08afPDRA
         3Fug==
X-Gm-Message-State: APjAAAWDPyHBhl9b6hYA/zZJTwcyYw+IDNnTXOSL0IT7t8aHaXTEEYAj
        SriNJFZDlx4eYXh6EP/SXR6MTA==
X-Google-Smtp-Source: APXvYqwsWRk9Tq2IpeCr052LXWfAbmti6M3i/BA4FXJRAY8/V4bKn4HcapWbWbd559alFcXDii9LcA==
X-Received: by 2002:a92:ba0a:: with SMTP id o10mr6283057ili.150.1571350870036;
        Thu, 17 Oct 2019 15:21:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 9sm1326264ilt.16.2019.10.17.15.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 15:21:09 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v6] ext4: add kunit test for decoding
 extended timestamps
To:     Iurii Zaikin <yzaikin@google.com>, linux-kselftest@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Tim.Bird@sony.com
Cc:     kunit-dev@googlegroups.com, brendanhiggins@google.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191017221233.154848-1-yzaikin@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <73ef528c-6424-351c-c07c-d0d5b4ebb02e@linuxfoundation.org>
Date:   Thu, 17 Oct 2019 16:21:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017221233.154848-1-yzaikin@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/19 4:12 PM, Iurii Zaikin wrote:
> KUnit tests for decoding extended 64 bit timestamps that verify the
> seconds part of [a/c/m] timestamps in ext4 inode structs are decoded
> correctly.
> 
> Test data is derived from the table in the Inode Timestamps section of
> Documentation/filesystems/ext4/inodes.rst.
> 
> KUnit tests run during boot and output the results to the debug log
> in TAP format (http://testanything.org/). Only useful for kernel devs
> running KUnit test harness and are not for inclusion into a production
> build.
> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>

Looks good.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

I plan to apply this to linux-kselftest/test

thanks,
-- Shuah

