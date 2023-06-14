Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11167303C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjFNPZU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjFNPZT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 11:25:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF441E62
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 08:25:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso11582591a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686756316; x=1689348316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOPI4+FdP6c+pbHdmF1mgRUm1mjT/+SOyoMeudGxAt0=;
        b=C/LX4RTvuGO41N3P772wjntFEQtptNI11H8QkvAgareBqx433nUAWW/9h9+8eK+VwI
         CHjCgX6oHwLFVXRRUOvoLz0ET2SRS19iZuIi1rPMNUP3bfglYu1tgZ3weK2GYwSFgNbz
         Xwout/nlIcbg0jDLGypHc+W2YNH8BGl+m46HndMvolJdGQ/4XHtK2vNO4DBINYjNcLiC
         0ouXYlmRdhv8xyJPM2r3CEslnJMQxdpGfFI1hWz7sIfMXV9PNm+wtd9HYgxztCZCYj7a
         9xVQASMgzgd8HNqFNAeKnB691QpFsRKDj19i6hLt0RG28jZH7WeKyodn57GWVPx58Mis
         J52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756316; x=1689348316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOPI4+FdP6c+pbHdmF1mgRUm1mjT/+SOyoMeudGxAt0=;
        b=aTg85DblDKc1yFms27YlovF5FjLRdArirxRmm5sXFwcWyuLW8mRDJz6FHvFFc3wvI7
         AC9EFFSmNw+iiQoNySWYbad9YPi+V8qjRDzQuxPiUwmmO5rkxo1hjiWYYqQSj+6SjBgT
         32ty1MXjYDhFHrrAYsN8Vxcz072ureL8kRVIOi3HEhGWbGqKz39JRbW4zss91dxKrMqX
         o5+thyv5qXpaHE8Zj1aYlzEf7kAo5xL69DKECDHt32Ifz8euJMuEUGVW4XplrG+OifTm
         K1brEdB3PoDkDqrW96SGPOBpVt3eFyRPCUG58QAO1UAujr3QDAIJjssqWHx6yKJQip2Y
         NVLg==
X-Gm-Message-State: AC+VfDwOEYIsDJOJR8DAgisST5bzyX80DlQOoOsVwo/8A8+Oyi4WTupd
        ZxuV5ptFYLXZt0tmN9uM+sx6eHkO4Bsw1iwFn4uYHw==
X-Google-Smtp-Source: ACHHUZ7ajRf6auHav1YRoKpK8kR0w+ASMylABKUZwDbhh/NRogyZVfFdUSWP70YmRJeyYXuhJ0UtfmmQcjL//Ktv9x8=
X-Received: by 2002:a17:907:1c1f:b0:982:21a1:c4e0 with SMTP id
 nc31-20020a1709071c1f00b0098221a1c4e0mr8460578ejc.56.1686756316270; Wed, 14
 Jun 2023 08:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230613-so-reuseport-v2-3-b7c69a342613@isovalent.com> <20230613185647.64531-1-kuniyu@amazon.com>
In-Reply-To: <20230613185647.64531-1-kuniyu@amazon.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 14 Jun 2023 16:25:05 +0100
Message-ID: <CAN+4W8ijtoew8ouaN3i1NXtg0_G_HHmZyAtf5LsCBb6shCAx2Q@mail.gmail.com>
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

On Tue, Jun 13, 2023 at 7:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
>                         else {
>                                 result =3D sk;
>                         }
>
> The assignment to result below is buggy.  Let's say SO_REUSEPROT group
> have TCP_CLOSE and TCP_ESTABLISHED sockets.

I'm not very familiar with SO_REUSEPORT, I assumed (incorrectly
probably) that such a group would only ever have TCP_CLOSE in UDP case
and TCP_LISTENING in TCP case. Can you explain how I could end up in
this situation?
