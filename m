Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF129F48D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfH0UxY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 16:53:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0UxY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 16:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hWwGWM0xH4rsI/3aRe9UJFvl/Jke/kx6OG9Zrp6S39w=; b=L65GB1uNzeiW2D/geTba4rmo+
        tiAlnyy6KqkQCeehaTYTNs2IMKmRUGuHR26h9co45Nqz/5TGG3onBfCPVwVAaKrT7vIuYu1jt+2mD
        AB4uaEmY9+z7ukO0vwEMf2zIWbuWbHX06+a6zg/2+0gAtR8fIJO+H7/zxHRvWcidQLYO1Ep3qcJ92
        dBeT0O9cSFGjxbxRpKNGq94C+2r/nv+Dvg+TX3IG+8VY+kVy55IqI5gZ0rIoODpb5IlrSTHMdqLiH
        6Biou6h+Lg1Yzm5JJVui8QYd5ahPjLS1c8gjHoryZYsnsOJTpbXmZNq6Wg0SlXYB9me/bWx7vxNR5
        NAOE67+Og==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2iSw-00089s-0N; Tue, 27 Aug 2019 20:53:22 +0000
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20190827174932.44177-1-brendanhiggins@google.com>
 <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5b626f60-8472-a97e-378e-755160e5d948@infradead.org>
Date:   Tue, 27 Aug 2019 13:53:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/27/19 1:21 PM, shuah wrote:
> On 8/27/19 11:49 AM, Brendan Higgins wrote:
>> Previously KUnit assumed that printk would always be present, which is
>> not a valid assumption to make. Fix that by ifdefing out functions which
>> directly depend on printk core functions similar to what dev_printk
>> does.
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> ---
>>   include/kunit/test.h |  7 +++++++
>>   kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
>>   2 files changed, 31 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>> index 8b7eb03d4971..339af5f95c4a 100644
>> --- a/include/kunit/test.h
>> +++ b/include/kunit/test.h
>> @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>>     void kunit_cleanup(struct kunit *test);
>>   +#ifdef CONFIG_PRINTK
> 
> Please make this #if defined(CONFIG_PRINTK)

explain why, please?

thanks.
-- 
~Randy
