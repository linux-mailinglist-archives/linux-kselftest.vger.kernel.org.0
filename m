Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80D686923
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Feb 2023 15:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBAO4W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Feb 2023 09:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjBAO4U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Feb 2023 09:56:20 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB896AC96
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Feb 2023 06:56:19 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g2so1571154ybk.8
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Feb 2023 06:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYdj0ILPpMedwbtUGABQIEM0n6F/k6nMPhbqeDqBAa4=;
        b=GwOzyQ6/wV/wUCf4bpGgaONXoq/C3OoXugJbdwTvTju13aVvN3dxuGc7+FZvpVdpKT
         jfoGGPLxTTvSIY3HgOk1RqlDY+24+OD/up1cvLv2Io/uBXiM+fiwbpqGwMiNFXy6D3I7
         CUAkoHuPbUR3h0cm76K5hSAE8MrS+E3rNwFnCtzzPOc13fooRRPcoTkfMFM7S8esZ0WN
         6TC5v3BBUVJ+wcxL+KFRJsvPIwoWr3XqQILKOulaQPNPLKFgB8sgoAiEvh+NOZGFV/K1
         kk96vi8wDU03c7T9WB+HER/IT5YR0rJ+Z1uSs0hYUyUtZBlaj1+W7eekV7P5pOgUAXRi
         NuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYdj0ILPpMedwbtUGABQIEM0n6F/k6nMPhbqeDqBAa4=;
        b=PK9zVH+TdzrEkZjNgX9X/O4Qe97P9PDBS5PMGy7BEDVbKI0dZnfzgPs+XQU5EtQVV8
         O0kvud+u/iBoP6RdwxCN4cT1YH1Sz5Cmy7PHsDbSQ7V7wNgre+ZoSFJMkMVxrUSKgauP
         /BnPQRxJgj12+ZnGoocMlaxxB6+5pXEdxRi24/AdhOXKtJrwI7PM1DmYgm8nXMFZYyGm
         uMojUl/ewzDN0CRkWSfgMcT7ycFqlcpcK4/GB55fo4gamcyG74kFW0SryjPddo5wpvyO
         wscoJHSfKrSodNemM+9YVQvdco3JMxcVhM5JdG4DAnV9SUlGFJYxyZtGkiYK+CN1dvge
         Tryg==
X-Gm-Message-State: AO0yUKWFSi+8+Y1+Fs9MxOmRGRKFUWAjjRyTaCuQdylONAXH97ifLWRo
        1p2UPwxniOpvjLuL/W9Ho67AQPeXL9nWKaFv6reqiw==
X-Google-Smtp-Source: AK7set8IMK4aEihsTu1bOqtwwwkrq/v0ps1tZwl9PjUSiW9IOEB2A5spS8nZWmc2y8Lraf/n+Q9eORUYxOJI/tcXa8Q=
X-Received: by 2002:a5b:d02:0:b0:7b7:c7ed:eee9 with SMTP id
 y2-20020a5b0d02000000b007b7c7edeee9mr317233ybp.334.1675263378595; Wed, 01 Feb
 2023 06:56:18 -0800 (PST)
MIME-Version: 1.0
References: <20230201001612.515730-1-andrei.gherzan@canonical.com>
In-Reply-To: <20230201001612.515730-1-andrei.gherzan@canonical.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Wed, 1 Feb 2023 09:55:42 -0500
Message-ID: <CA+FuTSc_v+SiHsQdQA6b1J+-_ws=0F-6817O6wWadVpbHTWg9g@mail.gmail.com>
Subject: Re: [PATCH net v4 1/4] selftests: net: udpgso_bench_rx: Fix 'used
 uninitialized' compiler warning
To:     Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jan 31, 2023 at 7:18 PM Andrei Gherzan
<andrei.gherzan@canonical.com> wrote:
>
> This change fixes the following compiler warning:
>
> /usr/include/x86_64-linux-gnu/bits/error.h:40:5: warning: =E2=80=98gso_si=
ze=E2=80=99 may
> be used uninitialized [-Wmaybe-uninitialized]
>    40 |     __error_noreturn (__status, __errnum, __format,
>    __va_arg_pack ());
>          |
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>          udpgso_bench_rx.c: In function =E2=80=98main=E2=80=99:
>          udpgso_bench_rx.c:253:23: note: =E2=80=98gso_size=E2=80=99 was d=
eclared here
>            253 |         int ret, len, gso_size, budget =3D 256;
>
> Fixes: 3327a9c46352 ("selftests: add functionals test for UDP GRO")
> Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
