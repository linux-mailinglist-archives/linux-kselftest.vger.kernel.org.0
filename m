Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B56B9A8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjCNQD3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCNQDN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 12:03:13 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F4BB3710
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 09:03:09 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-540cb2fb5b9so209176237b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678809788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6YTlXkTcSY/lOWk5MFxXiktxYqqn/77NC3wi3iPQ7o=;
        b=iwOEnLdh8l5o8+zMmWNefw2TcVAWJdZwkuXbSuGVsf6Yii3dnuiV+X/BUGk4yIB73g
         UCMiJclXfbUq97SAbV71ro6OTPniDZDDz8GCCXe/P9iaQsbI/KUvlVWQ+fCJ7hnDAEcM
         ja/TuBSmFn+I4YHGxz93yxzaII9HiotlYnZRmatsGYbrO0xtuIYwiszim7pIDZIumQF6
         cNc/PjvKorq6a3zJyqK0oJI+F/cEGsdk9KyTgt9JJ7t/8Uca/vj3oA3JW9o/XUxRFOw9
         yAj6w39bk9lTPPUFbd3st6rm+ZyjJJgSBYYZ663+eNAPiJFQ0vCXzhYMyHm13RB06/C1
         +Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678809788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6YTlXkTcSY/lOWk5MFxXiktxYqqn/77NC3wi3iPQ7o=;
        b=hLFuTVv9PbBBrZtGSwWhsaSiiohX4jON68aZQdfDkuulVXFF8A5um6UVDZKsYezSIJ
         HmtJ3L0/xsMJHJyTOSixCapSjOpjFYHHFGO0VBxxNQSa5peCHdoX7RcTKA81iKQiZpnj
         s9c0aQ4hmJo8OZwarS3g5ekUO86CbhmTJWn05nzd/zTkT+tAi5Q6GF9cFV0LvvqExyvd
         9etTQwnX1BkQ43D6HrOJtzgIL+twPThk4y5IKl6llcdnCygB7gyad9KWJ7RzKW3ID4Mc
         Ux2fAuK04AsBxthZkOz2hc6sP0r5mv+d29M10jrhxTo6KyYluTRUe9RTBZSfMBcUxHBJ
         1b3A==
X-Gm-Message-State: AO0yUKU2z7jkfUL2QWEdemWYIGscNZL3G4aTfC8bSv1q++g35Aszjirv
        gW3JXY3Vcdu3xARp5N+89myafEhv19QEGjniDHc26g==
X-Google-Smtp-Source: AK7set/FG4sRkcaSN3cSyLA5qL/1YpZ76JsEPYBQAEKJ5H0umEU4hT1QCqnSbDDR6G0qYWJzGbGYrMexvBc3G0S3MxQ=
X-Received: by 2002:a81:a946:0:b0:52b:fd10:4809 with SMTP id
 g67-20020a81a946000000b0052bfd104809mr26140095ywh.0.1678809788468; Tue, 14
 Mar 2023 09:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <a0734a6b-9491-b43a-6dff-4d3498faee2e@alu.unizg.hr>
 <d7a64812-73db-feb2-e6d6-e1d8c09a6fed@alu.unizg.hr> <27769d34-521c-f0ef-b6c2-6bd452e4f9bf@alu.unizg.hr>
In-Reply-To: <27769d34-521c-f0ef-b6c2-6bd452e4f9bf@alu.unizg.hr>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 14 Mar 2023 09:02:56 -0700
Message-ID: <CANn89iKi67YScgt5R0nHNAobjnSubBK6KsR9Ryoqu5ai4Opyrw@mail.gmail.com>
Subject: Re: BUG: selftest/net/tun: Hang in unregister_netdevice
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 14, 2023 at 9:01=E2=80=AFAM Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:

> After a while, kernel message start looping:
>
>   kernel:unregister_netdevice: waiting for tap0 to become free. Usage cou=
nt =3D 3
>
> Message from syslogd@pc-mtodorov at Mar 14 16:57:15 ...
>   kernel:unregister_netdevice: waiting for tap0 to become free. Usage cou=
nt =3D 3
>
> Message from syslogd@pc-mtodorov at Mar 14 16:57:24 ...
>   kernel:unregister_netdevice: waiting for tap0 to become free. Usage cou=
nt =3D 3
>
> Message from syslogd@pc-mtodorov at Mar 14 16:57:26 ...
>   kernel:unregister_netdevice: waiting for tap0 to become free. Usage cou=
nt =3D 3
>
> This hangs processes until very late stage of shutdown.
>
> I can confirm that CONFIG_DEBUG_{KOBJECT,KOBJECT_RELEASE}=3Dy were the on=
ly changes
> to .config in between builds.
>
> Best regards,
> Mirsad
>

Try adding in your config

CONFIG_NET_DEV_REFCNT_TRACKER=3Dy
CONFIG_NET_NS_REFCNT_TRACKER=3Dy

Thanks.
