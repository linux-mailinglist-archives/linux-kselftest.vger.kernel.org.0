Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855884FE699
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Apr 2022 19:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiDLRO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Apr 2022 13:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbiDLRO5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Apr 2022 13:14:57 -0400
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 10:12:39 PDT
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572F60AB3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Apr 2022 10:12:39 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KdBtj1VTxzMqLVJ;
        Tue, 12 Apr 2022 19:05:33 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KdBth2cV3zlhMBP;
        Tue, 12 Apr 2022 19:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1649783133;
        bh=WIAqrTnf62NAS0tQGLe8JoQbbvgbUmacFvHp891JW6g=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=DWeNvZZDbPHmTCU+9PS7yiMNtuL8zaK+RZuoWGZjGUtOH8YoFj1gspSKJa5STgn/F
         PxF7DDMrIHUTeYcm1arziMgGg0ELlv58gJWKuZk4iz5C/OkD6FqY7SW/PN7qlBEDeU
         FstuiSvjT6tLhSKKFm+MzEXz1OcHnz0+qZDvtVeQ=
Message-ID: <acdf5af3-f256-8d53-ec44-fcef4022ec62@digikod.net>
Date:   Tue, 12 Apr 2022 19:05:49 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf <bpf@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20220412153906.428179-1-mic@digikod.net>
 <CANiq72=ogSxwz8iJLZaYD4nSkE71sBhT4dZyDv1HYyo5R43=pw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1] clang-format: Update and extend the for_each list with
 tools/
In-Reply-To: <CANiq72=ogSxwz8iJLZaYD4nSkE71sBhT4dZyDv1HYyo5R43=pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I'm wondering about the ASSERT_* and EXPECT_* macros from 
tools/testing/selftests/kselftest_harness.h
Do you think we should treat them as "for macros" as well? They can 
either be used with or without a following code block.


On 12/04/2022 17:58, Miguel Ojeda wrote:
> Hi Mickaël,
> 
> On Tue, Apr 12, 2022 at 5:39 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> Add tools/ to the shell fragment generating the for_each list and update
>> it.  This is useful to format files in the tools directory (e.g.
>> selftests) with the same coding style as the kernel.
> 
> Sounds good to me. There have been discussions about doing it for the
> entire tree too, so we can start with this.
> 
> Cheers,
> Miguel
