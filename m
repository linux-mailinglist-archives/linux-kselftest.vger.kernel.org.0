Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B19682F92
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 15:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjAaOp4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 09:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjAaOp4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 09:45:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5B737579
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675176312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xn8TtSD/AsRILC72eNaykv7ZyTuVxpBZIKtdo2DAH1A=;
        b=gEU/x9Qk0nTqRgCWLGJpREmzt3vmBDMEnqa955ocTkklLDrmHQVZgtiuhoXgWwm+jf5ggH
        9obXMuCbS6BWUkw16zk7KZbj500Y9mQBZzjvL1EfqlSXLLw6+pK7diDFOuM1u4GXBNT2OS
        J4sHUfsDZ0TQkLAKoYfSCsKv3pId4fs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-385-2pmQmo2nOxuhHufrW_UQNQ-1; Tue, 31 Jan 2023 09:45:09 -0500
X-MC-Unique: 2pmQmo2nOxuhHufrW_UQNQ-1
Received: by mail-qk1-f200.google.com with SMTP id x12-20020a05620a258c00b007051ae500a2so9210390qko.15
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 06:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xn8TtSD/AsRILC72eNaykv7ZyTuVxpBZIKtdo2DAH1A=;
        b=1MNLhjLhB8MxT8gOQ3JS2I6CHAdqltB1pwXxXkWmJxCpR9Tyq53LYt5oMHWU2Qgw41
         YvD9BU0NdRXM3220NIj0RKEmAiei2Psb3aaIL8iWHJTGK5jVeYbSoNvU+pa1T0Ru4tif
         rvqHkY3qRXvjzAYMqeumPZjDJMd6KLaC4DtHcLJAzPSSqbsXgDcNY6Mnf2hr6nKMx4qU
         vKxf1iN42j0ebyTFz5ONwIIzUEy74rhZpG7cp0QJ3W8cMXqmVuKaQKeJ82eJkYnAaFqN
         qp3MIR8fuBaLXxqxzPtx0pO6NxD6meKWHbgP9yoclAPlJ2IJsjN/4PNZHjcIK8PCgam9
         7Sqw==
X-Gm-Message-State: AO0yUKWl3uz4WOs/h9u79Vnmox34knncMZGCWpe8hXKq2fb/Z5W3MAE7
        /C2gaLXqY1WyTDmk7nQYJfWQirwY0bw0XwMTPDpVrN6DJKUZlXxUUaImyD2pyQGzkZC93sNi1+x
        BjV4HXd5cVIqbB3vI6JNdyeOZTltD
X-Received: by 2002:a0c:c484:0:b0:537:7e81:73ec with SMTP id u4-20020a0cc484000000b005377e8173ecmr10038055qvi.3.1675176308458;
        Tue, 31 Jan 2023 06:45:08 -0800 (PST)
X-Google-Smtp-Source: AK7set8/6AUEXMvGYSP/0m29hp2+J2HOrCZjUA3ETettzdz1KyQPZ9G2hmwb7tu/ki9YzwSEWJftrg==
X-Received: by 2002:a0c:c484:0:b0:537:7e81:73ec with SMTP id u4-20020a0cc484000000b005377e8173ecmr10038022qvi.3.1675176308174;
        Tue, 31 Jan 2023 06:45:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id o62-20020a37be41000000b006fcaa1eab0esm10147005qkf.123.2023.01.31.06.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:45:07 -0800 (PST)
Message-ID: <ede0b4ea92187ca7b6303f3c1c98c26f513a3ce9.camel@redhat.com>
Subject: Re: [PATCH v2 3/4] selftests: net: udpgso_bench: Fix racing bug
 between the rx/tx programs
From:   Paolo Abeni <pabeni@redhat.com>
To:     Willem de Bruijn <willemb@google.com>,
        Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 31 Jan 2023 15:45:04 +0100
In-Reply-To: <CA+FuTSdtzFXWWDLk=LOdrkS00oH4HGvtoYYQh7YQd2ADsp0UbA@mail.gmail.com>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
         <20230131130412.432549-3-andrei.gherzan@canonical.com>
         <CA+FuTSdtzFXWWDLk=LOdrkS00oH4HGvtoYYQh7YQd2ADsp0UbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2023-01-31 at 08:33 -0500, Willem de Bruijn wrote:
> On Tue, Jan 31, 2023 at 8:06 AM Andrei Gherzan
> <andrei.gherzan@canonical.com> wrote:
> >=20
> > "udpgro_bench.sh" invokes udpgso_bench_rx/udpgso_bench_tx programs
> > subsequently and while doing so, there is a chance that the rx one is n=
ot
> > ready to accept socket connections. This racing bug could fail the test
> > with at least one of the following:
> >=20
> > ./udpgso_bench_tx: connect: Connection refused
> > ./udpgso_bench_tx: sendmsg: Connection refused
> > ./udpgso_bench_tx: write: Connection refused
> >=20
> > This change addresses this by making udpgro_bench.sh wait for the rx
> > program to be ready before firing off the tx one - with an exponential =
back
> > off algorithm from 1s to 10s.
> >=20
> > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
>=20
> please CC: reviewers of previous revisions on new revisions
>=20
> also for upcoming patches: please clearly mark net or net-next.
> > ---
> >  tools/testing/selftests/net/udpgso_bench.sh | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testin=
g/selftests/net/udpgso_bench.sh
> > index dc932fd65363..20b5db8fcbde 100755
> > --- a/tools/testing/selftests/net/udpgso_bench.sh
> > +++ b/tools/testing/selftests/net/udpgso_bench.sh
> > @@ -7,6 +7,7 @@ readonly GREEN=3D'\033[0;92m'
> >  readonly YELLOW=3D'\033[0;33m'
> >  readonly RED=3D'\033[0;31m'
> >  readonly NC=3D'\033[0m' # No Color
> > +readonly TESTPORT=3D8000 # Keep this in sync with udpgso_bench_rx/tx
>=20
> then also pass explicit -p argument to the processes to keep all three
> consistent
>=20
> >=20
> >  readonly KSFT_PASS=3D0
> >  readonly KSFT_FAIL=3D1
> > @@ -56,10 +57,27 @@ trap wake_children EXIT
> >=20
> >  run_one() {
> >         local -r args=3D$@
> > +       local -r init_delay_s=3D1
> > +       local -r max_delay_s=3D10
> > +       local delay_s=3D0
> > +       local nr_socks=3D0
> >=20
> >         ./udpgso_bench_rx &
> >         ./udpgso_bench_rx -t &
> >=20
> > +       # Wait for the above test program to get ready to receive conne=
ctions.
> > +       delay_s=3D"${init_delay_s}"
> > +       while [ "$delay_s" -lt "$max_delay_s" ]; do
> > +               nr_socks=3D"$(ss -lnHi | grep -c "\*:${TESTPORT}")"
> > +               [ "$nr_socks" -eq 2 ] && break
> > +               sleep "$delay_s"
> > +               delay=3D"$((delay*2))"
>=20
> I don't think we need exponential back-off for something this simple

Agreed. Additionally you could use constant, sub-second delay (say 0.1)
to keep the runtime delta relatively low.

Cheers,

Paolo

