Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359923F8A0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbhHZO1Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 10:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbhHZO1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 10:27:22 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49FBC0613C1;
        Thu, 26 Aug 2021 07:26:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GwQBt1DP4z9sWS;
        Fri, 27 Aug 2021 00:26:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629987991;
        bh=8REjizoyXa6lG5/G29mltG5ReN+I4Z6Qc6NDe7l49QM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kNmPLfrBKi04ZkPkGpmV7+/oJadisLEfK1+pFTyhStOvkRxkseTXEN8PdArVzP5Cm
         kRFq1EOMrB1WoWaQM79CrgGuwALLpz0MEZ80j82uHAeJM7KH14mHCJe8RKd5QD59pD
         UwSTK0ac1IZh5fpEewtwXUQqfRCiMgd+3yS5aId8VihS4/jPW17sOR1u+PvmKSd71C
         zDJ82ruv1AKxXlOA9+KYj9lYzK16CK1h6NaLa2QRw9bBx+5ov8BwzUSXR2Xb+fiR6p
         g2Jp0Qbd3DsZAR4wswp/IsCbTULnB48hNjOEMRrnrZolEFW68ftEX+vJ6/Tdpb9SWa
         w/P035zUTKlnQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Shuah Khan <skhan@linuxfoundation.org>, cgel.zte@gmail.com
Cc:     yong.yiran@zte.com.cn, Zeal Robot <zealci@zte.com.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH linux-next] powerpc/tm: remove duplicate include in
 tm-poison.c
In-Reply-To: <4bc97c33-7fc0-ff9d-041b-e773f682c5d2@csgroup.eu>
References: <20210805065255.628170-1-yong.yiran@zte.com.cn>
 <c5e9900b-1c2d-8e72-ad83-a6024b876fd2@linuxfoundation.org>
 <4bc97c33-7fc0-ff9d-041b-e773f682c5d2@csgroup.eu>
Date:   Fri, 27 Aug 2021 00:26:29 +1000
Message-ID: <87wno89t9m.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 24/08/2021 =C3=A0 16:40, Shuah Khan a =C3=A9crit=C2=A0:
>> On 8/5/21 12:52 AM, cgel.zte@gmail.com wrote:
>>> From: yong yiran <yong.yiran@zte.com.cn>
>>>
>>> 'inttypes.h' included in 'tm-poison.c' is duplicated.
>>> Remove all but the first include of inttypes.h from tm-poison.c.
>>>
>>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>>> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
>>> ---
>>> =C2=A0 tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
>>> =C2=A0 1 file changed, 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c=20
>>> b/tools/testing/selftests/powerpc/tm/tm-poison.c
>>> index 29e5f26af7b9..27c083a03d1f 100644
>>> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
>>> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
>>> @@ -20,7 +20,6 @@
>>> =C2=A0 #include <sched.h>
>>> =C2=A0 #include <sys/types.h>
>>> =C2=A0 #include <signal.h>
>>> -#include <inttypes.h>
>>> =C2=A0 #include "tm.h"
>>>
>>=20
>> We can't accept this patch. The from and Signed-off-by don't match.
>>=20
>
> As far as I can see they match. You have:
>
> From: yong yiran <yong.yiran@zte.com.cn>
> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>

Regardless I already have a patch queued to fix this, from a different
CI bot.

cheers
