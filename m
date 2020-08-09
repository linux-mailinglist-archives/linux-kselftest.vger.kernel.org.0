Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88A923FEFC
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Aug 2020 17:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHIPLb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Aug 2020 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgHIPLa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Aug 2020 11:11:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2A4C061756;
        Sun,  9 Aug 2020 08:11:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d22so3799557pfn.5;
        Sun, 09 Aug 2020 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3U1YVfZ3/r+GTB6gjCpbjGoBmp0JEystLJz/+YctVAQ=;
        b=P3+JpB+WUDWhDsCjxZF/OtdUOVzHJ2RM0GUjGZgEfAuODBqdcetEXFytsyhvGwl6iG
         7jpquCJudc/UWaMo2r5UmytWUIad6p4gl3MgSZ76uY6+ZLepknpkIuMk05vC5NXY8bPB
         aC51eq5rPnX+oKQxQH9bBrJ7br6kkKvzPrY1zrguhbxJBaCCzEOxZhf+TL2ai/FxeTej
         lkQtf9a6iELZuOC21MKzCS3UaPmm8sopmJRzp1OwN//Bvrzol9XQfo6i7epSZuTZhZrZ
         utgbV1GnmdNimoiQ9LjVflso8qd9fYitfT2WG8XjtGrF4f97ADt1xHf0swQ9yDq+clP3
         4FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3U1YVfZ3/r+GTB6gjCpbjGoBmp0JEystLJz/+YctVAQ=;
        b=O18pH8w2GBQEJCIUj27eDROwtu001Z+ylN7rbHPHtrZAidqD2e+Bpe9qMulxZ0Ja9g
         FyDRJSrDbegnQCJkjqOC+Q8ZkQUDoNh3mn6o6lSnQsJEwWSInlpku8KPHBNKXqJwzUf2
         zypBuhMFLwH3P4YKVEEEVUlixEygMSg0uV7XkUj5fBjMXPptEv1QYbMMlIUFnnCJaeyF
         xgvYihScRTwQ3nLKxbtmV3NKHCfTXVmQ3d75fOx2DAMYEES2uKQijyfMVehiU2M8xnzz
         0W2aQQDPhCwqHqpu+dlED203A0vLZN+kNV1shkk5qimsjzNtY7rzTGumhn4N+6QCegBD
         xABg==
X-Gm-Message-State: AOAM531lTs5P6SKiSfzgdfVDc/2jin97FV3Zxx9Wxp+DrYk4rvN4a2KW
        HINFMa5DWXxsu5wAybotd9s=
X-Google-Smtp-Source: ABdhPJz/uaoGAS5YWNepVNhd+qI9FEZQoovPOeRinCilOF8oTvZhXjcN0GCoq4mHzXqPeYQENoyadA==
X-Received: by 2002:a62:2e45:: with SMTP id u66mr22488619pfu.121.1596985889720;
        Sun, 09 Aug 2020 08:11:29 -0700 (PDT)
Received: from [192.168.86.81] ([49.206.15.28])
        by smtp.gmail.com with ESMTPSA id w82sm19869911pff.7.2020.08.09.08.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 08:11:29 -0700 (PDT)
Subject: Re: [PATCH] lib: Convert test_hexdump.c to KUnit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200806094440.14962-1-98.arpi@gmail.com>
 <20200806100540.GE3703480@smile.fi.intel.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <caf314b0-c090-26e6-3593-cb23aab1cbe3@gmail.com>
Date:   Sun, 9 Aug 2020 20:41:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806100540.GE3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/08/20 3:35 pm, Andy Shevchenko wrote:
> On Thu, Aug 06, 2020 at 03:14:40PM +0530, Arpitha Raghunandan wrote:
>> Converts test lib/test_hexdump.c to KUnit.
>> More information about KUnit can be found at
>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
>> KUnit provides a common framework for unit tests in the kernel.
> 
> ...
> 
>> -	if (memcmp(test, real, TEST_HEXDUMP_BUF_SIZE)) {
>> -		pr_err("Len: %zu row: %d group: %d\n", len, rowsize, groupsize);
>> -		pr_err("Result: '%s'\n", real);
>> -		pr_err("Expect: '%s'\n", test);
>> -		failed_tests++;
>> -	}
>> +	KUNIT_EXPECT_EQ(kunittest, 0, memcmp(test, real, TEST_HEXDUMP_BUF_SIZE));
> 
> 
> Ah, can you explain how user will see now what is being expected and what is in
> reality in the buffer? I'm not gonna accept such changes without showing in
> explicitly that user is not going to suffer of this change.
> 
I have sent another patch replacing KUNIT_EXPECT_EQ() with KUNIT_EXPECT_EQ_MSG() and KUNIT_EXPECT_NE() with KUNIT_EXPECT_NE_MSG(). These methods log what is being expected and what is in reality in the buffer in case of test failure similar to the original test.
