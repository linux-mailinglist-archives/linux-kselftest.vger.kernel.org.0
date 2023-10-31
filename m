Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60207DC946
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 10:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbjJaJT1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 05:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbjJaJT0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 05:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1449F
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Oct 2023 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698743918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bx3whZQGfbNRV1288q3CSKQ568eW0DOq5hrYpiuzhzo=;
        b=CZZx0SyrXa63uazAINn0h/MIZCPhgxjU3MUz5PQT7NTEu75yrQKo9r2vi8exzjfCg4TnFl
        ALX5cEzcCeAxFCi37zJkDufr19HEEiK2I/2e38SLjTwSx+dJMEkuoX8N/m/c6kvt9rCI8q
        Hk6Lao6zS8sHa2UDjasrPxUwRRtQ0yw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-yLneJf0bM3W82emhJzm30g-1; Tue, 31 Oct 2023 05:18:31 -0400
X-MC-Unique: yLneJf0bM3W82emhJzm30g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50798dd775dso1378305e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Oct 2023 02:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698743910; x=1699348710;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bx3whZQGfbNRV1288q3CSKQ568eW0DOq5hrYpiuzhzo=;
        b=DNzIUwlKmR6JbhpQhN0ktM7eRT3OY5IbC1jZChANcCjgDHXwHp0uzsAjWQbHY0z1TP
         vSlIlipyncQprDNGZ15YBlg1bJjSwrHquXM85VffSgo8Z+Y4JbFLc6eFwj1dF/1LxEpI
         i/5Bh+UnSGRiurAF1Y6Rd4mqqBklSln6LLr1OHVJF1BeIZ6PkJ0gPRhjl9i3wZJJmTLG
         UsN6LOjbxtFNaFE8IMR2bVL6wTSHXAhMyc6tShMYZNWcjYqDrBQPRtifl6yx2msQN8GQ
         K9DGKyskNjo23ao90sWQUnyBuGvG1y3UbiuXs4yyAVtbscWrcZqdnyUqJkNZ3aKKFVik
         p12Q==
X-Gm-Message-State: AOJu0Ywts+ySAyYhO7leEH+x9+/S76PnaeBAM4I1SBDPPmOlEb2Ze0n1
        pH2HJbuv/PYDSrXULduFhiXzMCoBbxI54FgWLc5/98pFjKq6E4XXfsbDdpnen0f+w6JlR29jhYg
        XjQyxBr5em1rh6sRp7PhQ1GJD6nCB
X-Received: by 2002:a05:6512:2348:b0:507:b1b8:cf0a with SMTP id p8-20020a056512234800b00507b1b8cf0amr9918143lfu.3.1698743910432;
        Tue, 31 Oct 2023 02:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO5YLpjsXMB2fxpnL44Wu1EYPRjkWRAyiAWVaBJOAR4pKlok5TbBpG/GFH/KhWPx8rjL/B3w==
X-Received: by 2002:a05:6512:2348:b0:507:b1b8:cf0a with SMTP id p8-20020a056512234800b00507b1b8cf0amr9918124lfu.3.1698743910073;
        Tue, 31 Oct 2023 02:18:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600c2e4200b004064e3b94afsm1160179wmf.4.2023.10.31.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:18:29 -0700 (PDT)
Message-ID: <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lucas Karpinski <lkarpins@redhat.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 31 Oct 2023 10:18:28 +0100
In-Reply-To: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
References: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2023-10-30 at 13:40 -0400, Lucas Karpinski wrote:
> The sockets used by udpgso_bench_tx aren't always ready when
> udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
> kernels, but can occur in both. Replace the hacky sleep calls with a
> function that checks whether the ports in the namespace are ready for
> use.
>=20
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> ---
> https://lore.kernel.org/all/t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzr=
zkwtj@toz6mr4ggnyp/
>=20
> Changelog v2:=20
> - applied synchronization method suggested by Pablo
> - changed commit message to code=20
>=20
>  tools/testing/selftests/net/udpgro.sh         | 27 ++++++++++++++-----
>  tools/testing/selftests/net/udpgro_bench.sh   | 19 +++++++++++--
>  tools/testing/selftests/net/udpgro_frglist.sh | 19 +++++++++++--
>  3 files changed, 54 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selfte=
sts/net/udpgro.sh
> index 0c743752669a..04792a315729 100755
> --- a/tools/testing/selftests/net/udpgro.sh
> +++ b/tools/testing/selftests/net/udpgro.sh
> @@ -24,6 +24,22 @@ cleanup() {
>  }
>  trap cleanup EXIT
> =20
> +wait_local_port_listen()
> +{
> +	local port=3D"${1}"
> +
> +	local port_hex
> +	port_hex=3D"$(printf "%04X" "${port}")"
> +
> +	local i

Minor nit: I think the code would be more readable, if you will group
the variable together:

	local port=3D"${1}"
	local port_hex
	local i

	port_hex=3D"$(printf "%04X" "${port}")"
	# ...

> +	for i in $(seq 10); do
> +		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
> +			awk "BEGIN {rc=3D1} {if (\$2 ~ /:${port_hex}\$/) {rc=3D0; exit}} END =
{exit rc}" &&
> +			break
> +		sleep 0.1
> +	done
> +}

Since you wrote the same function verbatim in 3 different files, I
think it would be better place it in separate, new, net_helper.sh file
and include such file from the various callers. Possibly additionally
rename the function as wait_local_udp_port_listen.

Thanks!

Paolo

