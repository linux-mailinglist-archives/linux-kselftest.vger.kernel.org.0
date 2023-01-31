Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CDC6838DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 22:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjAaVry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 16:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAaVrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 16:47:53 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7B55AA48
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:47:50 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4ff1fa82bbbso221536747b3.10
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EvA04MAVbr1UuAjYFXOV/pgoyn0pjItg1LdvvQcMI8c=;
        b=H0BHVeKa4qEFSSRzJElwMZ4GewmdUx3WiPFixCTp+9kb6GH0ec4EOCufp1bGBVJoaU
         0vzBHCsXLtM7wxZ2o+duBMw3vgJs3cLrYgZ9KViPKlw8qA+8b7pncYkWLM8wXM4EMiLT
         Wz+vm9YD0dgqaYLnmlzQ2uD+fjZwC8EBuadn+BREBwfGPH1E2O+YTq8b/FRKugSEH02k
         ljvVLMI9/GzzEOgqq9Fz4PdOk0kVlQvITmFVxUjPOo1bhNIw+qHhlRNO7vo5qmE5gZrM
         aTNiq7MdRlWqfHXXQoQI45iks7npKbF0tcjRA0fCzl4nVZWRo/5HVY88Y6EJAatig2CY
         X5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvA04MAVbr1UuAjYFXOV/pgoyn0pjItg1LdvvQcMI8c=;
        b=0BbeF5akWeh/OpdSj/PzGUkuAKamSzuEa9yQ+Tt6EItqbMREIGJIRGFOCOG3F2oWa8
         M9/AdFbOmSFZV8ZweeeB3EBIfdLa9kpMRtk4zvlA1dQgy3koSp8BySnXkiomkqFnSQ/U
         YnvGerJlLl8tNYPT2zQfl4UEWFGjbAEX2AewN7MAsxWXNXhFEVWlyCSdjgz0HDM2xvwD
         eO/93GsOckcrnXQjz+miTNXhj0ZmmteOQTrt5Zw0F19KetiEl+sdpiLnQn7ddoFJ/CyD
         tZi2hiyILLrj2KSESGDg29jAApf3aKqFmi9I9AW1kp7LlwL7773Aj8FbXnhmhyt3tJIa
         nZyg==
X-Gm-Message-State: AFqh2krbl31tsVCBNfCXIB2mZdcQ9s66yQYv31QrgJUtmXHFOcW0jSOA
        O/ljYzToiL09hmzZ1KfiSxvYmRjYhFTn2rJLtsrd5Q==
X-Google-Smtp-Source: AMrXdXvxUzexZvvtDOoB1xHI01ESP1152UTaWhUHhWH0zrdl0HhwlkoUzxS9ShAH3OIgN7jOLAH+IeIK7nYk3bvnCVk=
X-Received: by 2002:a81:4006:0:b0:46b:c07c:c1d9 with SMTP id
 l6-20020a814006000000b0046bc07cc1d9mr4380896ywn.56.1675201668950; Tue, 31 Jan
 2023 13:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20230131210051.475983-4-andrei.gherzan@canonical.com>
In-Reply-To: <20230131210051.475983-4-andrei.gherzan@canonical.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Tue, 31 Jan 2023 16:47:13 -0500
Message-ID: <CA+FuTSfeehkZMZonHA-nFDK37=eNdG6E-7xkcixn1Hs_s44_EQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] selftests: net: udpgso_bench_tx: Cater
 for pending datagrams zerocopy benchmarking
To:     Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Fred Klassen <fklassen@appneta.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 31, 2023 at 4:01 PM Andrei Gherzan
<andrei.gherzan@canonical.com> wrote:
>
> The test tool can check that the zerocopy number of completions value is
> valid taking into consideration the number of datagram send calls. This can
> catch the system into a state where the datagrams are still in the system
> (for example in a qdisk, waiting for the network interface to return a
> completion notification, etc).
>
> This change adds a retry logic of computing the number of completions up to
> a configurable (via CLI) timeout (default: 2 seconds).
>
> Fixes: 79ebc3c26010 ("net/udpgso_bench_tx: options to exercise TX CMSG")
> Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>

Fixes should go to net, instead of net-next.

But the code itself looks good to me.

Reviewed-by: Willem de Bruijn <willemb@google.com>
