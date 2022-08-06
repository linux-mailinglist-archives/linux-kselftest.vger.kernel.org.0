Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB9858B34D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 04:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbiHFCAV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbiHFCAU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 22:00:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B710E9;
        Fri,  5 Aug 2022 19:00:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso9788131pjq.0;
        Fri, 05 Aug 2022 19:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RZ+kY6ncCLgC0CWqLOPBv3tOAKB3iTjTvNGIOrkB62w=;
        b=OE1chYPNcYuWYMuLrhg335Ahdslo1LBEsl3zQ/cLr/N/1i6OVaLsRT7N2jTmWjB12y
         O64iMrrUMEXuaJDzaYtMfnx1+LBINnOj+eAkQScRDG9ViYAzRpSLlEBM1Xa8mCdzb1mp
         gDbD9h5GklRbvHD5qTxUqvMv+q9xmG/FKHLpPi6wOi5pEdiuXQPqHmoexnWZOH92BWj1
         /6nDZ55cy0e+sbeV8ArJPN54YONzQWI4RFuXAUj8q5P09Q2dPgdlpqUNzwE4st3b8gsh
         0PIpiIjy+6fhhDX5cUa2Lga6+UTxphEGOPQxWMV7up2bZ9DRRALgIMplgc935oESbjVy
         Q3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RZ+kY6ncCLgC0CWqLOPBv3tOAKB3iTjTvNGIOrkB62w=;
        b=2PYsU7prK9Y5G8oFtibIWsBmoOf/fdNVs1DvpOLYo5mvSI2pZzNh+nd/IePdLb+E7m
         5ftVoeqONtoWM9rgu+u9FIAXgi4I69eONRC8Qfl7B7LI7UDrQGvSq5T9cjhrGjRp0img
         1KjHBKAX+MAlTJwBBeilArGC/V96wPPmKdN3lWRcB8Dc12RvZd+vgIgGicMCLqZSwEgr
         g9doK1Z5R7xYbGVS2zEmLHm1jg5dTD+nTiChib9O4D+WIilZiTjZdADTBLQsv6bjgER0
         vQ3ZQFXl2yUDN7J/eSpbC9ll78ELB6USEm17hS2cRHwEXjZ+4qXW9UBvcPYVFOr0EsCW
         PMbw==
X-Gm-Message-State: ACgBeo0ndRruGn16BWkfQ4oYFTs/w1YeBrd2rOq0yfc0EWAQK8y9LiH0
        iPmqjnDWL9jxGUpMIsO2ME4Z19phh0Iz8Q==
X-Google-Smtp-Source: AA6agR4p6ignj+/3bx3bxkQuSxfmu4xl1qkEzCE0Ow2ynn+TyiSxn6zdNnZt88uJHryiaTMkd4xpKw==
X-Received: by 2002:a17:902:b20d:b0:16d:aefa:8ef6 with SMTP id t13-20020a170902b20d00b0016daefa8ef6mr9490038plr.90.1659751216202;
        Fri, 05 Aug 2022 19:00:16 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id b128-20020a621b86000000b0052d4dd41a1asm3730765pfb.81.2022.08.05.19.00.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Aug 2022 19:00:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [kvm-unit-tests PATCH 2/4] x86: emulator.c cleanup: Use ASM_TRY
 for the UD_VECTOR cases
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <Yu12o0mKMUdnQ8Ol@google.com>
Date:   Fri, 5 Aug 2022 19:00:12 -0700
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA0EBF68-648D-483F-B629-7C1B70D1E73C@gmail.com>
References: <ae0a0049-8db0-501b-79e4-cd32758156fb@redhat.com>
 <E1oK2U0-0000qn-CI@rmmprod05.runbox> <Yu12o0mKMUdnQ8Ol@google.com>
To:     Michal Luczaj <mhal@rbox.co>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Aug 5, 2022, at 12:59 PM, Sean Christopherson <seanjc@google.com> =
wrote:

> On Fri, Aug 05, 2022, Michal Luczaj wrote:
>> On Fri, 5 Aug 2022 13:42:40 +0200, Paolo Bonzini =
<pbonzini@redhat.com> wrote:
>>> On 8/3/22 20:21, Sean Christopherson wrote:
>>>>> I've noticed test_illegal_movbe() does not execute with KVM_FEP.
>>>>> Just making sure: is it intentional?
>>>> It's intentional.  FEP isn't needed because KVM emulates MOVBE on =
#UD when it's
>>>> not supported by the host, e.g. to allow migrating to an older =
host.
>>>>=20
>>>> 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f0),
>>>> 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f1),
>>>=20
>>> *puts historian hat on*
>>>=20
>>> The original reason was to test Linux using MOVBE even on non-Atom=20=

>>> machines, when MOVBE was only on Atoms. :)
>>=20
>> So the emulator's logic for MOVBE is meant to be tested only when the
>> guest supports MOVBE while the host does not?
>=20
> Ah, I see what you're asking.  No, it's perfectly legal to test MOVBE =
emulation
> on hosts that support MOVBE, i.e. using FEP is allowed.  But because =
KVM emulates
> MOVBE on #UD and the KUT testcase is guaranteed to generate a #UD =
(barring a
> hardware bug), there's no need to use FEP.  And not using FEP is =
advantageous
> because it avoids depending on an opt-in non-production module param.

If history is discussed, the test was created long before FEP. Without =
FEP,
the way to force the emulator to emulate an instruction was to set the
instruction in memory that is not mapped to the guest. But, as Sean =
stated,
this test always triggers #UD, so it was not necessary.

The purpose of this test was to check a KVM fix for a bug that was found
during fuzzing:

=
https://lore.kernel.org/all/5475DC42.6000201@redhat.com/T/#m3a0da02d7c750c=
28816b08c43cf2ca03252b8bad

