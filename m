Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C95881FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiHBSns (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHBSnr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 14:43:47 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1992613F97;
        Tue,  2 Aug 2022 11:43:42 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Ly3mF5RKFzDqJt;
        Tue,  2 Aug 2022 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659465822; bh=UbIIdBEmCjXhtev1nV/F9xDLpTHPjYwNl7kFZr7GgJ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gOBxP/ijRpYAtMio6iB8PFC/AbctDlA1arteJx4ZbAROp712SZbx20/NXgMS4EY7h
         Cdzx0NKH0sDK/GJii8ZjaXvzGToeu5PL5obI1WC8NDDDSJHB5OGuQxulCHWCJjBxeV
         UhqrFes59GPZfpkYkXV1uaqG2IWRU2AAjLqPbWss=
X-Riseup-User-ID: 106D2563DDDD0F2AF87EAB6C43C3657D9B56FB6F7A490E4DA7ED6059369E1132
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ly3m73rX4z5vMX;
        Tue,  2 Aug 2022 18:43:35 +0000 (UTC)
Message-ID: <2a0dcd75-5461-5266-2749-808f638f4c50@riseup.net>
Date:   Tue, 2 Aug 2022 15:43:32 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Introduce KUNIT_EXPECT_ARREQ and KUNIT_EXPECT_ARRNEQ
 macros
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        airlied@linux.ie, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20220802161206.228707-1-mairacanal@riseup.net>
 <CAGS_qxoAc934AwB7SZ34PpoVxvF3Eua-g+aO77kjJf6d1m0+Qw@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <CAGS_qxoAc934AwB7SZ34PpoVxvF3Eua-g+aO77kjJf6d1m0+Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/2/22 13:59, 'Daniel Latypov' via KUnit Development wrote:
> On Tue, Aug 2, 2022 at 9:12 AM Maíra Canal <mairacanal@riseup.net> wrote:
>>
>> Currently, in order to compare arrays in KUnit, the KUNIT_EXPECT_EQ or
>> KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp function,
>> such as:
>>   KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
>>
>> Although this usage produces correct results for the test cases, if the
>> expectation fails the error message is not very helpful, indicating only the
>> return of the memcmp function.
>>
>> Therefore, create a new set of macros KUNIT_EXPECT_ARREQ and
>> KUNIT_EXPECT_ARRNEQ that compare memory blocks until a determined size. In
>> case of expectation failure, those macros print the hex dump of the memory
>> blocks, making it easier to debug test failures for arrays.
> 
> I totally agree with this.
> 
> The only reason I hadn't sent an RFC out for this so far is
> * we didn't have enough use cases quite yet (now resolved)
> * I wasn't sure how we'd want to format the failure message.
> 
> For the latter, right now this series produces
> dst ==
> 00000000: 33 0a 60 12 00 a8 00 00 00 00 8e 6b 33 0a 60 12
> 00000010: 00 00 00 00 00 a8 8e 6b 33 0a 00 00 00 00
> result->expected ==
> 00000000: 31 0a 60 12 00 a8 00 00 00 00 81 6b 33 0a 60 12
> 00000010: 00 00 00 00 01 a8 8e 6b 33 0a 00 00 00 00
> 
> I was thinking something like what KASAN produces would be nice, e.g.
> from https://www.kernel.org/doc/html/v5.19/dev-tools/kasan.html#error-reports
> (I'll paste the bit here, but my email client doesn't support
> monospaced fonts, so it won't look nice on my end)
> 
> Memory state around the buggy address:
>  ffff8801f44ec200: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>  ffff8801f44ec280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>> ffff8801f44ec300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03
>                                                                 ^
> I just wasn't quite sure how to do it for a diff, since this only
> really works well when showing one bad byte.
> If we blindly followed that approach, we get
> 
> dst ==
>> 00000000: 33 0a 60 12 00 a8 00 00 00 00 8e 6b 33 0a 60 12
>                                           ^
>> 00000010: 00 00 00 00 00 a8 8e 6b 33 0a 00 00 00 00
>                         ^
> result->expected ==
>> 00000000: 31 0a 60 12 00 a8 00 00 00 00 81 6b 33 0a 60 12
>                                           ^
>> 00000010: 00 00 00 00 01 a8 8e 6b 33 0a 00 00 00 00
>                         ^
> 
> But perhaps we could instead highlight the bad bytes with something like
> dst ==
> 00000000: 33 0a 60 12 00 a8 00 00 00 00 <8e> 6b 33 0a 60 12
> 00000010: 00 00 00 00 <00> a8 8e 6b 33 0a 00 00 00 00
> result->expected ==
> 00000000: 31 0a 60 12 00 a8 00 00 00 00 <81> 6b 33 0a 60 12
> 00000010: 00 00 00 00 <01> a8 8e 6b 33 0a 00 00 00 00

My problem with this approach is that the bytes get slightly misaligned
when adding the <>. Maybe if we aligned as:

dst:
00000000: <33> 0a 60 12  00  a8 00 00 00 00 <8e> 6b 33 0a 60 12
00000010:  00  00 00 00 <00> a8 8e 6b 33 0a  00  00 00 00
result->expected:
00000000: <31> 0a 60 12  00  a8 00 00 00 00 <81> 6b 33 0a 60 12
00000010:  00  00 00 00 <01> a8 8e 6b 33 0a  00  00 00 00

Although I don't know exactly how we can produce this output. I was
using hex_dump_to_buffer to produce the hexdump, so maybe I need to
change the strategy to generate the hexdump.

I guess the KASAN approach could be easier to implement. But I guess it
can turn out to be a little polluted if many bytes differ. For example:

dst:
00000000: 33 31 31 31 31 31 31 31 31 31 8e 31 33 0a 60 12
           ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^
00000010: 00 00 00 00 00 a8 8e 6b 33 0a 00 00 00 00
                       ^
result->expected:
00000000: 31 0a 60 12 00 a8 00 00 00 00 81 6b 33 0a 60 12
           ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^
00000010: 00 00 00 00 01 a8 8e 6b 33 0a 00 00 00 00
                       ^

I don't know exactly with option I lean.


Thank you for your inputs, Daniel!

- Maíra Canal

> 
> Thoughts, suggestions?
> 
