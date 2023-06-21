Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1753D7385A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjFUNta (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjFUNt3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:49:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0943E1730
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 06:49:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-982a0232bdcso911452566b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687355366; x=1689947366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z46fWp/ZFzR66ZI77ViYtnd4W5sSAIMQYJ6XeMShdXc=;
        b=RnQDgBUIZIeh/eH8flO6rDIOuAIaj69zWbov9wRKw42vZy56/UxN4oFhDpiwKwX2IM
         KjV/cONpJS5cTtkDgOPCwW+thL6qz2ef7Ng1rKp11bIuaxSZKE9DNHiWw47McYeaOSnc
         OWR6mytmFEM6u3cT7VVtD3og5mcMqeQvFY/l0zV9ZVK+Iowa1UPZMwiDl3oyvjF5oiRD
         B2l54eSfbvlPVYrZSDs17W751IA8fH2CL9aAOEDPgM7ix9+O7oGCS3f36OgGsOh/7AGS
         AWI8O1HYSvASt0jQ5Rc2yi67FXSsamlYCOrr1v0i6kxycvfcKwzE0X8Y0IxG7FmbgJqx
         Ageg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355366; x=1689947366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z46fWp/ZFzR66ZI77ViYtnd4W5sSAIMQYJ6XeMShdXc=;
        b=HChUbqvNpX3HJbYatHbNs1LJVGg54kS98rjeEx9NqQfxac5PYgbfgOcDsFclQuJAj2
         X4WAuQNdHoB6EmMC4BZ/nenYMoIEVyzr59kfHUsd1I7KxRNee4aazqSYbFQThY+MF0es
         DbmQUoqv5KR0DE/IjQlw45VUsmoJhYVuUKvLJMMCPVPThPmH4naHeEbfyuh6ho/8R5dU
         i3Xt8VzLY3mEed4TpKswVWFPNGLluxgJEhh/etsVrBGDs7j3ro3MiWcGdWS5oKhzJv5J
         pC1zc4JIZXaM2twTYbQBm9RhcNo9iUO3l4Q3gVULpXPbeDqnFviWfCXiwqE2XV5b9kvB
         hTcA==
X-Gm-Message-State: AC+VfDx9nfjyl0KJyYZWq7eHAcP5SgjN7W0hYKX8D8nTzY7KeCEiYjyJ
        MCXCWKOHMR1ccvmyzVuxGwi1rYXXI7zBp4XWkgr9nQ==
X-Google-Smtp-Source: ACHHUZ6AzbWc8T+/nD8hQVp/W0B+gPpyf1xElqvN9xTarmoytSSoSkjhswKGvFcecfAhLkjmMYuB/ajCxgDMJAR4eVI=
X-Received: by 2002:a17:907:6088:b0:988:dc8e:2fec with SMTP id
 ht8-20020a170907608800b00988dc8e2fecmr7310743ejc.36.1687355366467; Wed, 21
 Jun 2023 06:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+4W8ge-ZQjins-E1=GHDnsi9myFqt7pwNqMkUQHZOPHQhFvQ@mail.gmail.com>
 <20230620183123.74585-1-kuniyu@amazon.com>
In-Reply-To: <20230620183123.74585-1-kuniyu@amazon.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 21 Jun 2023 14:49:15 +0100
Message-ID: <CAN+4W8gYuW5P3t5881YdMq1pYnG9DsQJFiJWPoLFsKVsZiLLQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup functions
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com,
        joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 20, 2023 at 7:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Good point.  This is based on an assumption that all SO_REUSEPORT
> sockets have the same score, which is wrong for two corner cases [...]

I did some more digging. I think this was introduced by commit
efc6b6f6c311 ("udp: Improve load balancing for SO_REUSEPORT.") which
unfortunately ran into a merge conflict. That resulted in Dave Miller
moving the bug around in commit a57066b1a019 ("Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"). Can you
take a look and let me know if you think that is correct?

Best
Lorenz
