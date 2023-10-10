Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF87BF8A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 12:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjJJKaF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 06:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjJJKaD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 06:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBB39D
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696933756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJzuP/A/bgFUoe/uV4FgEOUmqz0biBzCtHevaK0fOw4=;
        b=WvaY5AcLQPQb6y/dwWBHc3dgAIGAzV8Rj/m3fKZA0dtYub9zSF7taG0eUvTFmLYynK7T8n
        MKMQ7U3RiNdNC0WJ62STg+f8wgfWRo6ghlTnvxsXfjhHy0Wd9/StcD8GRQ0VrWKK0tOgCa
        6N9x3wY2bNLPlAvbSqQrqI5Q79WBWUo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-C7IwCvD6P_u3vkGCGsjlAQ-1; Tue, 10 Oct 2023 06:29:05 -0400
X-MC-Unique: C7IwCvD6P_u3vkGCGsjlAQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae56805c41so134638066b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 03:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696933744; x=1697538544;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJzuP/A/bgFUoe/uV4FgEOUmqz0biBzCtHevaK0fOw4=;
        b=mQUPF+jA+fIpF2R7LlfLGASe1x47J3ORDduAV1EExPDjazEcegLEAyPGAbdqgP0jrS
         7mEwyxuF/hc+giRJQFGOf+A3PiQolnpvVvHCgHB6Qiw0qTYYh4b1U1HHPk1hT/Dq3WUs
         Ap244+35CCunAUQJVAbHJQw/LhoAeYl+dNbCYDmyboF2jzfT17fxK9nv3EjyfKY6l19x
         s0rUhAxBmR0d7Fl3rz4OLmI0ZjjBk/XwUvgYuzw1kThKZdFAEAcwsBJ31TMFjCWhP2Ln
         O9vDwwuRlQTbw1tlsR+5q4N9P49bQ4kUSuUBuhyfEN3m3z/FvIQ47KAmWx5vAs1vt4d8
         h/Xw==
X-Gm-Message-State: AOJu0YyT9vgvyp0YavTSvuiaZ1ESFgzTzi1M+11WgkFOZ21nTEzIuLQX
        3voe1xVKFiTHJW5RywuBf/zRDMHqAfDE61iJyk11uOMpy58HaeIdSUaH6uBmKan55blKB20yQBr
        dn95Rceu7qLNbEJOZaef6PWXTf2KF
X-Received: by 2002:a17:907:6d1d:b0:9b9:e641:a978 with SMTP id sa29-20020a1709076d1d00b009b9e641a978mr14820634ejc.2.1696933743924;
        Tue, 10 Oct 2023 03:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8HfWaJOeH6Nh0P9k0lFK1hWlbSTQAqhc5rATKQ4TBHmB5waU8bEDQP4QKKK6bkaoktpmWyg==
X-Received: by 2002:a17:907:6d1d:b0:9b9:e641:a978 with SMTP id sa29-20020a1709076d1d00b009b9e641a978mr14820617ejc.2.1696933743609;
        Tue, 10 Oct 2023 03:29:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009a2235ed496sm8347645ejb.141.2023.10.10.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:29:03 -0700 (PDT)
Message-ID: <2e7ee087b33fba7e907c76e60d9eaed1807714e2.camel@redhat.com>
Subject: Re: [PATCH net 3/4] selftests: openvswitch: Skip drop testing on
 older kernels
From:   Paolo Abeni <pabeni@redhat.com>
To:     Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Adrian Moreno <amorenoz@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>
Date:   Tue, 10 Oct 2023 12:29:01 +0200
In-Reply-To: <20231006151258.983906-4-aconole@redhat.com>
References: <20231006151258.983906-1-aconole@redhat.com>
         <20231006151258.983906-4-aconole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
> Kernels that don't have support for openvswitch drop reasons also
> won't have the drop counter reasons, so we should skip the test
> completely.  It previously wasn't possible to build a test case
> for this without polluting the datapath, so we introduce a mechanism
> to clear all the flows from a datapath allowing us to test for
> explicit drop actions, and then clear the flows to build the
> original test case.
>=20
> Fixes: 4242029164d6 ("selftests: openvswitch: add explicit drop testcase"=
)
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  .../selftests/net/openvswitch/openvswitch.sh  | 17 ++++++++++
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 34 +++++++++++++++++++
>  2 files changed, 51 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/too=
ls/testing/selftests/net/openvswitch/openvswitch.sh
> index 2a0112be7ead5..ca7090e71bff2 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -144,6 +144,12 @@ ovs_add_flow () {
>  	return 0
>  }
> =20
> +ovs_del_flows () {
> +	info "Deleting all flows from DP: sbx:$1 br:$2"
> +	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py del-flows "$2"
> +        return 0

The chunk above mixes whitespaces and tabs for indenting, please be
consistent.


Thanks!

Paolo

