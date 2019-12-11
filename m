Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C636611BA16
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2019 18:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfLKRWd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 12:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbfLKRWc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 12:22:32 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7FDE2073D;
        Wed, 11 Dec 2019 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576084952;
        bh=blRDe7wePNVUYF8Hd3R542m3C/FPDD2ilH2QaX+bjyo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L64EWBcjjo4OJ1p1RzxSJ5utBPTdahUXUI9u0B3vQmbd3cgmOvf4IXPGgzuBT6DM/
         9KXeacauPdER3voehg/2CnMMQg4j7At9D5nlTE6ST3q7w8ymZXIvVfd5BnbGRRFz0T
         yPkSf+2b03Pj5RYai/EXZLHm8qArhAQHLr262lC8=
Subject: Re: [PATCH v5 0/6] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sjpark@amazon.de,
        shuah <shuah@kernel.org>
References: <20191211163310.4788-1-sj38.park@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3dab421e-6aa5-90e4-791e-53482f5c1fe8@kernel.org>
Date:   Wed, 11 Dec 2019 10:22:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211163310.4788-1-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/11/19 9:33 AM, SeongJae Park wrote:
> May I ask some comments?
> 
> 
> Thanks,
> SeongJae Park
> 

+ Brendan

> On Thu, 5 Dec 2019 10:34:34 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> 
>>
>> This patchset contains trivial fixes for the kunit documentations and
>> the wrapper python scripts.
>>
>> This patchset is based on 'kselftest/test' branch of linux-kselftest[1]
>> and depends on Heidi's patch[2].  A complete tree is available at my repo:
>> https://github.com/sjp38/linux/tree/kunit_fix/20191205_v5
>>
>> Changes from v4
>> (https://lore.kernel.org/linux-doc/1575490683-13015-1-git-send-email-sj38.park@gmail.com/):
>>   - Rebased on Heidi Fahim's patch[2]
>>   - Fix failing kunit_tool_test test
>>   - Add 'build_dir' option test in 'kunit_tool_test.py'
>>

Please include Brendana Higgins on kunit patches.

thanks,
-- Shuah
