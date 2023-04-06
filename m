Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005AA6D912E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 10:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjDFIIO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjDFIIM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 04:08:12 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B276A2;
        Thu,  6 Apr 2023 01:08:05 -0700 (PDT)
X-UUID: b4669bca74a7479dadfa37950b52ee1c-20230406
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:ba70d2e6-2463-4a45-b37d-48337af9ce67,IP:15,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:ba70d2e6-2463-4a45-b37d-48337af9ce67,IP:15,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:361462b5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230405224612O8VQCV4R,BulkQuantity:12,Recheck:0,SF:24|17|19|44|102,TC
        :nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b4669bca74a7479dadfa37950b52ee1c-20230406
Received: from node4.com.cn [(39.156.73.12)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 520909029; Thu, 06 Apr 2023 16:08:00 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
        by node4.com.cn (NSMail) with SMTP id C37BB16002C00;
        Thu,  6 Apr 2023 16:07:59 +0800 (CST)
X-ns-mid: postfix-642E7DDF-72898429
Received: from [172.20.12.78] (unknown [172.20.12.78])
        by node4.com.cn (NSMail) with ESMTPA id 9CE4A16002C00;
        Thu,  6 Apr 2023 08:07:58 +0000 (UTC)
Message-ID: <67e08770-7f58-159d-437c-5d3432bf6847@kylinos.cn>
Date:   Thu, 6 Apr 2023 16:07:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RESEND PATCH] kvm/selftests: Close opened file descriptor in
 stable_tsc_check_supported()
From:   Hao Ge <gehao@kylinos.cn>
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, shuah@kernel.org, dmatlack@google.com,
        coltonlewis@google.com, vipinsh@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        gehao618@163.com
References: <20230405101350.259000-1-gehao@kylinos.cn>
 <ZC2JrJwKM3KrgNgm@google.com>
 <c9db67ee-4a0b-dc62-f507-c4a654fc9656@kylinos.cn>
In-Reply-To: <c9db67ee-4a0b-dc62-f507-c4a654fc9656@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry for bother yours, the computer has updated some configurations,

causing an issue with the email name,so correct it.


On 4/6/23 10:56, gehao@kylinos.cn wrote:
> 在 4/5/23 22:46, Sean Christopherson 写道:
>
>> This is not a RESEND, it is a new version.  From 
>> Documentation/process/submitting-patches.rst:
>>
>>    Don't add "RESEND" when you are submitting a modified version of your
>>    patch or patch series - "RESEND" only applies to resubmission of a
>>    patch or patch series which have not been modified in any way from 
>> the
>>    previous submission.
>>
>> And the "in any way" really does mean in _any_ way.  E.g. if a patch 
>> is rebased,
>> the version needs to be bumped.  RESEND should only ever be used when 
>> sending
>> literally the same patch/email file, e.g. if something went awry in 
>> the delivery
>> of the email, or you forgot to Cc the right people, tec.
>>
>> On Wed, Apr 05, 2023, Hao Ge wrote:
>>> Close the "current_clocksource" file descriptor before
>> Wrap closer to ~75 chars, wrapping at ~55 is too aggressive.
>>
>>> returning or exiting from stable_tsc_check_supported()
>>> in vmx_nested_tsc_scaling_test
>>
>> Vipin provided his Reviewed-by, that should have been captured here.  
>> Please read
>> through Documentation/process/submitting-patches.rst, guidance on 
>> "using" the
>> various tags is also provided there.  And if you have time, pretty 
>> much all of
>> Documentation/process/ is worth reading.
>>
>> No need to send a new version, all of this is easy to fixup when 
>> applying.
>
> Thank you for your guidance,this has been very helpful to me for 
> submitting
>
> patches.
>
>
Thanks

Best Regards

Hao

