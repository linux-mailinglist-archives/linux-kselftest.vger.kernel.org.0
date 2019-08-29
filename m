Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8BFA21A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfH2RB1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 13:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfH2RB1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 13:01:27 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9FF21726;
        Thu, 29 Aug 2019 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567098084;
        bh=wBHheJcf0m1hNSCx9WaNoXmRMBlMJkFkSTAD62zxQXc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m8iAap6KIvI0VP/V3DIBBy43SPrKlEiKYwcg/DCgjayaEgWAFYCCoU8mgmDKsGRpO
         UXh7/TW4n79p1MN4UVopT+8X09zzYmgf2kjBFwav1qBIQuSf080T50SJnmAtH+H0Pw
         gWHHOWx23iKv4a3Xh1lbqdYF32NPDNgRg9FFRox4=
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joe Perches <joe@perches.com>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        shuah <shuah@kernel.org>
References: <20190828093143.163302-1-brendanhiggins@google.com>
 <20190828094929.GA14038@jagdpanzerIV>
From:   shuah <shuah@kernel.org>
Message-ID: <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
Date:   Thu, 29 Aug 2019 11:01:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828094929.GA14038@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/28/19 3:49 AM, Sergey Senozhatsky wrote:
> On (08/28/19 02:31), Brendan Higgins wrote:
> [..]
>> Previously KUnit assumed that printk would always be present, which is
>> not a valid assumption to make. Fix that by removing call to
>> vprintk_emit, and calling printk directly.
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> 
> [..]
> 
>> -static void kunit_vprintk(const struct kunit *test,
>> -			  const char *level,
>> -			  struct va_format *vaf)
>> -{
>> -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
>> -}
> 
> This patch looks good to me. I like the removal of recursive
> vsprintf() (%pV).
> 
> 	-ss
> 

Hi Sergey,

What are the guidelines for using printk(). I recall some discussion
about not using printk(). I am seeing the following from checkpatch
script:


WARNING: Prefer [subsystem eg: netdev]_level([subsystem]dev, ... then 
dev_level(dev, ... then pr_level(...  to printk(KERN_LEVEL ...
#105: FILE: include/kunit/test.h:343:
+	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)


Is there supposed to be pr_level() - I can find dev_level()

cc'ing Joe Perches for his feedback on this message recommending
pr_level() which isn't in 5.3.

thanks,
-- Shuah

thanks,
-- Shuah
