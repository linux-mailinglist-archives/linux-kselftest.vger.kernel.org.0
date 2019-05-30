Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58CE2FFF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2019 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfE3QLP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 May 2019 12:11:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39456 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfE3QLP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 May 2019 12:11:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so2752068plm.6
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2019 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7NIWzxSI2i32jksEcwiThAzQv3nZEjjgmFvnWB9qDgQ=;
        b=bqOSU3rAMqbD+D1GfqSd7x+VFyAbTHS6NQpkPq4OmPSRCAWh/h/diWYE7y65kWIttr
         PH6EEGCFAuERq97jVGWnOIRyNm5hJYY5M9H8NjkCm3jvCi9heMEpPj9QEENUVZFiK3sI
         5ZtwVidj1v2OHT0hN82y0pW87hJV2seYtGHZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7NIWzxSI2i32jksEcwiThAzQv3nZEjjgmFvnWB9qDgQ=;
        b=WQ7yUV89k4BPbTZETrJfok+xvtQU1+/8zbBjQ2JYMNSMsBnnxjPXFy9Ig9CAMzZXJp
         /6cshnlTsh7j+MHi3jtXJasaTMn23xPu8hRiGDK2Q9TnlwLlhqpiR5Tf/JGCxQAKWxtu
         CpmOOOOIPky24ZAVU5JSk0zWBwJjagOxIMA4jj3d24TiBtYkA7uajxVuCqDQRZA8xQh/
         Hcl01Ch9QFadX5UsNIPurRORTWRpezGs0j92c9pgNJNv+P+tuG2I8rcZHq23KXRdGbWd
         Vj+9g4vg4oeuhriDvS+lNZ0JNpnwVy7Xy/EcybWGmGEhv8o54wwIE/ztrDy15za/JTNv
         oKCA==
X-Gm-Message-State: APjAAAUL6M3dx317c2Tpts6H123U2YnGXpDm8kenIYFH0Sn62lWUfmwg
        zcwoMwf086CYLJE8O1F47wF/ag==
X-Google-Smtp-Source: APXvYqzmFBN433OHUpv1tSsoY60vYjjHj2GUaOLBlNorXpL8AnM134mqCPuPkFnP0qLQSAhFApdZYw==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89mr4449857pld.332.1559232674031;
        Thu, 30 May 2019 09:11:14 -0700 (PDT)
Received: from jltm109.jaalam.net ([209.139.228.33])
        by smtp.gmail.com with ESMTPSA id h8sm582062pgq.85.2019.05.30.09.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 09:11:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH net-next v3 1/1] net/udp_gso: Allow TX timestamp with UDP
 GSO
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-JvNFdWCBJ6w1_XWSHu1CDiG_QimrUT8ZCxw=U+OVvBMA@mail.gmail.com>
Date:   Thu, 30 May 2019 09:11:11 -0700
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A1636C9-7476-43B2-BAE0-B03675B3920E@appneta.com>
References: <20190528184415.16020-1-fklassen@appneta.com>
 <20190528184415.16020-2-fklassen@appneta.com>
 <CAF=yD-JvNFdWCBJ6w1_XWSHu1CDiG_QimrUT8ZCxw=U+OVvBMA@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On May 28, 2019, at 2:44 PM, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>> It also appears that other TX CMSG types cause similar issues, for
>> example trying to set SOL_IP/IP_TOS.
>=20
> See previous comment in v2
>=20
> http://patchwork.ozlabs.org/patch/1105564/
>=20

Sorry, missed those updates. I am still relying too much on my emails.
Will fix for next version, and will scrub through messages on patchwork.

> FYI, no need for a cover letter for a single patch. Also, I think the
> cc list can be more concise. Mainly netdev.

Fixed.

> Same as above. This is not about zerocopy.
>=20

Will fix next patchset.


> Asked elsewhere, but best answered here: given that xmit_more delays
> delivery to the NIC until the last segment in a train, is the first
> segment in your opinion still the best to attach the timestamp request
> to?
>=20
> To reiterate, we do not want to need a follow-up patch to disable
> xmit_more when timestamps are requested.
>=20

I think it would be worthwhile. I was playing with this patch =E2=80=A6

+               /* software TX timeststamps are sent immediately */
+               if (tsflags & SKBTX_SW_TSTAMP)
+                       seg->xmit_more =3D 0;

=E2=80=A6 which attempts to address this issue. I believe that the patch
should be applied for software timestamps only. However when
I applied in net-next I got the following compile error, which suggests
there is more investigation needed, and therefore requires a separate
patch.

net/ipv4/udp_offload.c: In function =E2=80=98__udp_gso_segment=E2=80=99:
net/ipv4/udp_offload.c:251:7: error: =E2=80=98struct sk_buff=E2=80=99 =
has no member named =E2=80=98xmit_more=E2=80=99
    seg->xmit_more =3D 0;

