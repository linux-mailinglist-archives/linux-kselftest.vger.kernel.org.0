Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9145928EFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 04:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfEXCKJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 22:10:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42492 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731726AbfEXCKI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 22:10:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id 33so1159018pgv.9
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2019 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r8aR7hYQG+ubgZWmIyHO8z2MgnIQ/QsQT2Ue4fje7os=;
        b=rF/c4EZ8c3QOZMdL+RJCZhR79P0PB+UO/3P9pS47gYj6fG0TNXB9sIyNUYrxLSYbbE
         Vqf74VN+TN/R1V5tWM0jX3W/4fJOy37GCogiOKVydMill6Qotfiut3jywy58ReSv0Yl6
         tdn8gTiMRDrMoStFUJM6JGjBCgY43E9vrv62o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r8aR7hYQG+ubgZWmIyHO8z2MgnIQ/QsQT2Ue4fje7os=;
        b=Skc6sBaP0jIkjSKB2VLLVJkiWIPWnj5TVHq6AfqEQKZ27MHqCsLmKM/+NrDOH3D2mM
         W6rUf9tFSuDXd0zW/FK1UFbT8SdkVa6Ea9TxTZYKoyb/weciV/D7rwImO9ibMb2plSvT
         OIK+E8hdiz+lA2hS9lUspEJgsL/ExQbTxbQHT3bwKKxy1j1IKY9in8Abhv/6GyNmC7rw
         55IdJCJa+vz9JaD2FsIl2KX/f0jrdT5plDD4J01esm9BADw2qbAHU4UiQ3pCcLlH0G8U
         SMRVNZaOVcIl0rh6qwraID5n6TlHEuHoa2gAOSw9Xn6zlxcDhmXRTSMKlDm6m+XNQ9Jt
         zChg==
X-Gm-Message-State: APjAAAV2RuP+USAEchkCLcRsRIORou4FTfKgbz/Ku93elYTEbPROoSJc
        eJmcT69VG+ICIJmIAjY8CDypJQ==
X-Google-Smtp-Source: APXvYqzpLMGgRoPIpMdu2vTVvILTyJ/GmRZUoOY2DKkOgL3PRqdmfMmZtuVofLdgdW3OqFBzbbJFUA==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr102378028pgl.103.1558663807475;
        Thu, 23 May 2019 19:10:07 -0700 (PDT)
Received: from [10.0.1.19] (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.gmail.com with ESMTPSA id m11sm537865pjv.21.2019.05.23.19.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:10:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH net 2/4] net/udpgso_bench_tx: options to exercise TX CMSG
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-JBf6k7VLa6FQowuD5xDFbq5cB4ScTi7kb1hieQFDKnbg@mail.gmail.com>
Date:   Thu, 23 May 2019 19:10:05 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5061E2A7-EF7A-4C3C-9819-34AA8DE2CD0F@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
 <20190523210651.80902-3-fklassen@appneta.com>
 <CAF=yD-JBf6k7VLa6FQowuD5xDFbq5cB4ScTi7kb1hieQFDKnbg@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>=20
> To ensure that we do not regress, when adding options, please consider
> (just a general suggestion, not a strong request for this patch set)
> updating the kselftest to run a variant of the test with the new code
> coverage. In this case, make the code pass/fail instead of only user
> interpretable and add variants to udpgso.sh.

I had a look at how kselftest works, and I absolutely want to see this
work with these changes. I=E2=80=99ll investigate and implement in v2 =
patch.

I will most likely do a 5 second test. This seems to be sufficient to =
get
meaningful results

> can use more precise CMSG_SPACE based on worst case expectations, like
> in udp_sendmmsg
>=20
>> +       char buf[1500];
>=20
> no need for payload
>=20
>> +static void flush_errqueue(int fd)
>> +{
>> +       if (cfg_poll) {
>> +               struct pollfd fds =3D { 0 };
>> +               int ret;
>> +
>> +               fds.fd =3D fd;
>> +               fds.events =3D POLLERR;
>=20
> no need to pass POLLERR, it is always returned in revents.

