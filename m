Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F786D8DC4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 04:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjDFC4e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 22:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjDFC41 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 22:56:27 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE9901C;
        Wed,  5 Apr 2023 19:56:19 -0700 (PDT)
X-UUID: 32b5679ea29a46e2b3ae33c45019d556-20230406
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:bd588a92-644b-4af4-b40a-d669e9594a81,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:bd588a92-644b-4af4-b40a-d669e9594a81,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:72b4762a-564d-42d9-9875-7c868ee415ec,B
        ulkID:230405224612O8VQCV4R,BulkQuantity:9,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 32b5679ea29a46e2b3ae33c45019d556-20230406
Received: from node4.com.cn [(39.156.73.12)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2031316453; Thu, 06 Apr 2023 10:56:12 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
        by node4.com.cn (NSMail) with SMTP id DAD7016002C00;
        Thu,  6 Apr 2023 10:56:11 +0800 (CST)
X-ns-mid: postfix-642E34CB-82845141
Received: from [172.20.12.78] (unknown [172.20.12.78])
        by node4.com.cn (NSMail) with ESMTPA id C092416002C00;
        Thu,  6 Apr 2023 02:56:10 +0000 (UTC)
Message-ID: <c9db67ee-4a0b-dc62-f507-c4a654fc9656@kylinos.cn>
Date:   Thu, 6 Apr 2023 10:56:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RESEND PATCH] kvm/selftests: Close opened file descriptor in
 stable_tsc_check_supported()
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, shuah@kernel.org, dmatlack@google.com,
        coltonlewis@google.com, vipinsh@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        gehao618@163.com
References: <20230405101350.259000-1-gehao@kylinos.cn>
 <ZC2JrJwKM3KrgNgm@google.com>
From:   "gehao@kylinos.cn" <gehao@kylinos.cn>
In-Reply-To: <ZC2JrJwKM3KrgNgm@google.com>
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

在 4/5/23 22:46, Sean Christopherson 写道:

> This is not a RESEND, it is a new version.  From Documentation/process/submitting-patches.rst:
>
>    Don't add "RESEND" when you are submitting a modified version of your
>    patch or patch series - "RESEND" only applies to resubmission of a
>    patch or patch series which have not been modified in any way from the
>    previous submission.
>
> And the "in any way" really does mean in _any_ way.  E.g. if a patch is rebased,
> the version needs to be bumped.  RESEND should only ever be used when sending
> literally the same patch/email file, e.g. if something went awry in the delivery
> of the email, or you forgot to Cc the right people, tec.
>
> On Wed, Apr 05, 2023, Hao Ge wrote:
>> Close the "current_clocksource" file descriptor before
> Wrap closer to ~75 chars, wrapping at ~55 is too aggressive.
>
>> returning or exiting from stable_tsc_check_supported()
>> in vmx_nested_tsc_scaling_test
>
> Vipin provided his Reviewed-by, that should have been captured here.  Please read
> through Documentation/process/submitting-patches.rst, guidance on "using" the
> various tags is also provided there.  And if you have time, pretty much all of
> Documentation/process/ is worth reading.
>
> No need to send a new version, all of this is easy to fixup when applying.

Thank you for your guidance,this has been very helpful to me for sunmitting

patches.


