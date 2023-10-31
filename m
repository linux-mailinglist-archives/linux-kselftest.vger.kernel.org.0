Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99827DC96C
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 10:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbjJaJXz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbjJaJXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 05:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363610F3
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Oct 2023 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698744149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dmd8h3KmMTuLMQdZh3MBzTGUulf/MEu6C/sdxdxaqVw=;
        b=T9nUQSiFmKT75V3vEfmPTXpsBYSlm9w76cK7QkYvE8Gfb0KM7mR2mwesgWBHXM14CZWu0G
        M5SLaFJDcfqZUH9mdOSkpqwayB+biB+5tMoNRcKczwrcLYvdk1vIO+yoB2fM6H7clDY/KF
        a+0bLM3bVYXiIBAIVdTWFV4trxRJWBs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-GynbJF9bOfmrKfyAK0XgEQ-1; Tue, 31 Oct 2023 05:22:27 -0400
X-MC-Unique: GynbJF9bOfmrKfyAK0XgEQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f78dc3fcbso232913f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Oct 2023 02:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698744145; x=1699348945;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dmd8h3KmMTuLMQdZh3MBzTGUulf/MEu6C/sdxdxaqVw=;
        b=IEq9UZD/zcQxTqhyEU7ot3lcdvqmXbfrzV30gcfy44c20zUVY+PvbuRpKLGTNyXRz6
         vbRy5GZ+1avm3kj6M3MaQUBIxN5rmWt+1tooBqZ5Kg59XnnKC/2PP6selm+Oj2J8t0g3
         8PwXMe3EjvxFW41ZgykrNErh3NUAtpxti2ak38geNB+UWDPV3Nmcpq4MBZeNNMlarXLM
         EKY1nBQGhAQpWcTAASVP4UxfmPSIBoPWGhTBRa39jMx8Uhn819fU6w7tY7l5sPK2xDec
         RLmj10wD7Ni3Mu04LL1Z2eHhCPCyKNfLS0Wvns1/UUQ8vq+vsPm/AQfZNvZH+GrlCID4
         bpgg==
X-Gm-Message-State: AOJu0Yx/9ZNdlxXpZBQk2tMu34H+BPv96CJXVP9ee6iPKSH0vGnqWKFE
        bpm46KPzxTC34BpCiGMnddf4zukOGMiFf1RT7x9Kepo4AiuamVvQvY/1wV3x/OBi9hcTbWeJrca
        sohgGkGK2nNLqP5RJ9acClEPwyPRH
X-Received: by 2002:a5d:6984:0:b0:32f:76bb:a851 with SMTP id g4-20020a5d6984000000b0032f76bba851mr6653853wru.1.1698744145731;
        Tue, 31 Oct 2023 02:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3YPSSkH5TbNjuvw0t3bHYUKojT0tYZOUPP9YmmH3AfQTF5JOqLokssO3dUvLJ6/Z8k05axg==
X-Received: by 2002:a5d:6984:0:b0:32f:76bb:a851 with SMTP id g4-20020a5d6984000000b0032f76bba851mr6653837wru.1.1698744145407;
        Tue, 31 Oct 2023 02:22:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d67c6000000b00323293bd023sm1030605wrw.6.2023.10.31.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:22:25 -0700 (PDT)
Message-ID: <90def1f008a5c343ad6b0b2151c8ff972d2f468f.camel@redhat.com>
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lucas Karpinski <lkarpins@redhat.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 31 Oct 2023 10:22:23 +0100
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
I almost forgot ...
> Changelog v2:=20
> - applied synchronization method suggested by Pablo
                                                ^^^^^ most common typo
since match 2022 ;)

Less irrelevant, please include the target tree in the next submission,
in this case 'net-next'.

Thanks,

Paolo

