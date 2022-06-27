Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8652C55D20F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiF0HGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 03:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiF0HGp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 03:06:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF3E5F7E;
        Mon, 27 Jun 2022 00:06:44 -0700 (PDT)
Received: from [192.168.10.6] (unknown [39.45.206.71])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D09D6601826;
        Mon, 27 Jun 2022 08:06:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656313603;
        bh=Z/LXL4E5/3LOVmaswq+5SAltlEypjsxTl3skxq9i7gI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=eMJ5PcCF0uV60I848qRMPOi+VmW3JuLmS63Epy69cjv3OWF14upH354lTVs046V9C
         o9ToL3nClu6KJ+G9SSLQ7kwdW0K86+jLdOnf+6bW2xcA3+ik9E9vLoSImSCtl312+6
         hdi83Sz+wmSVnRNG+7l88lGQc1pb2l5h/VTpFuxkAmIrLx0QHfBBu1oMNdsyg3pWai
         TEQOQJ7jplQQNmV9tT6iUJl6dR6gdJSDM1nSb11n0XFuaF1/r2WATa87aIy9B5lPtZ
         KVi5wXp1QMimHKzY00Uac+lVTIvtM+l9If14+Lyq3xTHGGoNXf/d7DbAcNrEN5786g
         im95gOg+BLH/A==
Message-ID: <519c813b-0bf1-636b-df90-890e07d2ea4d@collabora.com>
Date:   Mon, 27 Jun 2022 12:06:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     usama.anjum@collabora.com, Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>
Subject: Re: [Bug Report] - kselftest build fails if output directory is first
 level sub-directory
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <c25d7ea7-4f72-4a2b-d8c3-d317e64fcbbb@collabora.com>
 <CAK7LNATL4nMmKgrjS8meavnpn=HisD30QxuPUKDqtWWgbGcSZw@mail.gmail.com>
 <a9470bfc-bddc-6aa6-0043-d49eb57611fe@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <a9470bfc-bddc-6aa6-0043-d49eb57611fe@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>> This problem starts from the bad design of the kselftest framework.
>> I did some research before. I think I can fix the root cause but
>> currently I do not have enough time to do it.
>>
>>
>> KBUILD_ABS_SRCTREE is a user-interface to request
>> Kbuild to use the absolute path.
>> If it is forced in the top Makefile, users have no way to
>> negate it.
>> It is true that using the absolute path is a quick work-around
>> because you do not need to care about the current working directory.
>>
>> If you insist on it,  just go ahead.  It is just two line changes.
>> Once the issue is fixed in a better way, your patch can be reverted
>> easily.
>>
> Why don't we work on fixing it the wright way? I would rather go that
> route than using short rem fixes.
> 
> Usama, would you be interested in working on a proper fix as recommended
> by Masahiro?
I've made another attempt:
https://lore.kernel.org/lkml/20220627070214.432390-1-usama.anjum@collabora.com/

> 
> thanks,
> -- Shuah

-- 
Muhammad Usama Anjum
