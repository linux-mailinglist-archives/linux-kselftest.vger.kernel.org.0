Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E461468075E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 09:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjA3I1H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 03:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA3I1G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 03:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AAF2411C
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 00:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675067179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AGVQkEQGPmbyUHabR74dVCVn0EngYdjpKD75ZNVK50=;
        b=Du2WNA+JPNRB8MSwPIcWHXmJHPFzaykryIycdOWSZVnUQvhUdX5gXVwlvU2c2iQHwbQObZ
        YhhlXVt46BMV5ksflkJ/H1uy+BUFOq7sjTi4Vw0hvZnyAxhVRnWQ7B6SBzW/2kQ2DYgb5b
        fDzIypl/kmC1n79jMvPyeFLYDhGZx18=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-IVhocnGRNYCPge_t0nvv5A-1; Mon, 30 Jan 2023 03:26:10 -0500
X-MC-Unique: IVhocnGRNYCPge_t0nvv5A-1
Received: by mail-qk1-f200.google.com with SMTP id j11-20020a05620a410b00b007066f45a99aso6734202qko.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 00:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AGVQkEQGPmbyUHabR74dVCVn0EngYdjpKD75ZNVK50=;
        b=QMnldRstk0+enzUJ80aWzBKDxON5dx6dkgd9QNQqi7QmVCs71o9mx+l/i921dcKzYc
         l06hBskdW/MPvk9VH932IOuzd1RPOItI0c8nfR/RsZsFFKn9R3fRNOhY+v3pgtjm3dmc
         /g9BiHsIfaJSnJbeVKmvg8WaHej5pRicxnwMedCAUZLCWsRDQxjHb3D7RSb+mEQsVVqs
         g6j/bwZbyIjygZQkN2s6axgNM6wQS2HbBX+n05m58LMcdU9cV5UBHo4I60t6Y6JD1ACi
         0FENoxceOM5AuxsqAEPq9+3UXf1APsoP6GgzrgU7uUts6c+HdNCpqpf3QTjLPBq5Nl6B
         BNTA==
X-Gm-Message-State: AO0yUKVYC5QGxPtV0les9MFAyXFLJulfg2XhUPEZBothg2Saaxoyf1Zf
        G+BYoZd8k2GGEMIi2NyhfhSnJmO2fxwvHTirVjDYTai0Hgoz1eYZknOz821jS4RzqUiJ80k9RwD
        lDbNO7Zq2q8YFAIoPRdwrpl2W4d0h
X-Received: by 2002:ac8:5dd0:0:b0:3b6:425d:d5ca with SMTP id e16-20020ac85dd0000000b003b6425dd5camr12051178qtx.24.1675067168816;
        Mon, 30 Jan 2023 00:26:08 -0800 (PST)
X-Google-Smtp-Source: AK7set9MV6u8uT0jvPDJaSJ5nfhgUrilLWyrJYf9jx8nwDH/LcG7AI2rY5/eK1DiWBX55qVSUYdn6A==
X-Received: by 2002:ac8:5dd0:0:b0:3b6:425d:d5ca with SMTP id e16-20020ac85dd0000000b003b6425dd5camr12051162qtx.24.1675067168560;
        Mon, 30 Jan 2023 00:26:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id h6-20020a375306000000b006fa4ac86bfbsm7612982qkb.55.2023.01.30.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 00:26:08 -0800 (PST)
Message-ID: <a762638b06684cd63d212d1ce9f65236a08b78b1.camel@redhat.com>
Subject: Re: [PATCH] selftests: net: udpgso_bench_tx: Introduce exponential
 back-off retries
From:   Paolo Abeni <pabeni@redhat.com>
To:     Willem de Bruijn <willemb@google.com>,
        Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Jan 2023 09:26:05 +0100
In-Reply-To: <CA+FuTSewU6bjYLsyLzZ1Yne=6YBPDJZ=U1mZc+6cJVdr06BhiQ@mail.gmail.com>
References: <20230127181625.286546-1-andrei.gherzan@canonical.com>
         <CA+FuTSewU6bjYLsyLzZ1Yne=6YBPDJZ=U1mZc+6cJVdr06BhiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-01-27 at 17:03 -0500, Willem de Bruijn wrote:
> On Fri, Jan 27, 2023 at 1:16 PM Andrei Gherzan
> <andrei.gherzan@canonical.com> wrote:
> >=20
> > The tx and rx test programs are used in a couple of test scripts includ=
ing
> > "udpgro_bench.sh". Taking this as an example, when the rx/tx programs
> > are invoked subsequently, there is a chance that the rx one is not read=
y to
> > accept socket connections. This racing bug could fail the test with at
> > least one of the following:
> >=20
> > ./udpgso_bench_tx: connect: Connection refused
> > ./udpgso_bench_tx: sendmsg: Connection refused
> > ./udpgso_bench_tx: write: Connection refused
> >=20
> > This change addresses this by adding routines that retry the socket
> > operations with an exponential back off algorithm from 100ms to 2s.
> >=20
> > Fixes: 3a687bef148d ("selftests: udp gso benchmark")
> > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
>=20
> Synchronizing the two processes is indeed tricky.
>=20
> Perhaps more robust is opening an initial TCP connection, with
> SO_RCVTIMEO to bound the waiting time. That covers all tests in one
> go.

Another option would be waiting for the listener(tcp)/receiver(udp)
socket to show up in 'ss' output before firing-up the client - quite
alike what mptcp self-tests are doing.

Cheers,

Paolo

