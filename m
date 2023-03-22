Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26D6C408A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 03:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCVCxl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 22:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCVCxk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 22:53:40 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4714A51CA4
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 19:53:39 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id r7so11719604uaj.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Mar 2023 19:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679453618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx/OpxV6VOoLDtUhC9fECZmWcMTho0USpZSQQL+Q51k=;
        b=daLZBrDc7aBxr4Pb2qto79H9KLnVze3M6lHlbs8qBYPbr7Xvq1Y/qtk1Zcj04wxn2C
         NXGXkIAiebBOdQAn09EqOr9eSIouvGRxlxKolsg3+iGutpyCdEZtfh36lfUqvEA9/Ipv
         /HhIPjS9hFr9WHG35YkEpIY9wtoVPVVNQdtXo5F3Oui6KU+KJE+lWhQczT8X+xKp0kEh
         tLrrmJ29NPtI0/b0HThHyBS5KJdjgGnxMDYv7n2O3yC+2rw7sJ9KNwhijs+gGHQ/oO1E
         05TVFmjvkdczA++nubjU6a1ngQ0gKVbdSYQav8LSBSGayJCGHwYp0oTDfDDQW2HIeFOK
         CHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679453618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kx/OpxV6VOoLDtUhC9fECZmWcMTho0USpZSQQL+Q51k=;
        b=vFdFbIinWFbTEdh8N4reDozZsJ3PLxu+MEq6QKzXIPZf5LqsOvgMOp9/Gx3MXtdGFt
         H2wBibL1t1tLjil8AqscN2ZX3Bh3KPA8MsZR59Ne5eyhqb53UGcUz7f3uKW2kueClPIV
         e8Y83q+fEwMSMVaO8grl0Lqj6mIX3/fPzzetIDRCw7P2gCkk61XycjYGk+QuYvJ/Jty7
         BtqfabUqUVFfZf7ksIei9+juEQ2cQKd66zxxlL3Z6FaNhoOLGHvSDEkVChqvMqyyqHgs
         d8PGFQoGK5JdiTRzq8Uoa3Ie18VZlW0QW9zLtL5AFWH384GMTJTSN+lfrZj4gVkqFcSh
         3xDQ==
X-Gm-Message-State: AO0yUKXevCK0+eboR/FLW4634/mIayyXmoYap8mpwDnQf7OJD5KuzIJv
        as1iULybElJ/vTDw5qDtAgJhIq2iHb+QMTxJQwxOa9HZJr7VdSDbzFuEtg==
X-Google-Smtp-Source: AK7set9tZiZ39YazK6WtbzwhehVwcqHUfPMgMZ0lFWwuSuyWA0rQRGsz+4yinB712DA+fRYfk2Pp/YO2XWusIcHeEMQ=
X-Received: by 2002:a1f:aa15:0:b0:432:6b9b:bbd8 with SMTP id
 t21-20020a1faa15000000b004326b9bbbd8mr2607394vke.1.1679453618156; Tue, 21 Mar
 2023 19:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230321081202.2370275-1-lixiaoyan@google.com>
In-Reply-To: <20230321081202.2370275-1-lixiaoyan@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Mar 2023 19:53:26 -0700
Message-ID: <CANn89i+S9T9+s+_Gdnkz18d9rkKT6bZsK9DhB86zj4ec1qWzdg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net-zerocopy: Reduce compound page head access
To:     Coco Li <lixiaoyan@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
        inux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 21, 2023 at 1:12=E2=80=AFAM Coco Li <lixiaoyan@google.com> wrot=
e:
>
> From: Xiaoyan Li <lixiaoyan@google.com>
>
> When compound pages are enabled, although the mm layer still
> returns an array of page pointers, a subset (or all) of them
> may have the same page head since a max 180kb skb can span 2
> hugepages if it is on the boundary, be a mix of pages and 1 hugepage,
> or fit completely in a hugepage. Instead of referencing page head
> on all page pointers, use page length arithmetic to only call page
> head when referencing a known different page head to avoid touching
> a cold cacheline.


Reviewed-by: Eric Dumazet <edumazet@google.com>
