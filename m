Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614EC390330
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 May 2021 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhEYN63 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 May 2021 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbhEYN6Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 May 2021 09:58:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250AC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 25 May 2021 06:56:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb17so29446787ejc.8
        for <linux-kselftest@vger.kernel.org>; Tue, 25 May 2021 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGPyF9cLnTz2QZ4yWAoBXLvmWhnOB2cEFuUlKJPyncE=;
        b=RiFgZo3qUq9fklWiwHZyfsLfVJtuLmU14pHsogMjVV26Ww02bWIHblvr4b9vSMeNjW
         0Hc9yHVVAMVnUhYn4LRBh6dC61eeKUPbPvk5XM00SvQJgyZ+e6bnu5epyzAh55EP4fZ2
         ntpJizTq7iKKadc9OtbXDV64guNh9/6aaOpDoZyLrte96zSaVWeeqacLWTpyGmCS/DKa
         amMSCT20XSbqgLWoRlz3cQnVBsbRGi9WSnHykFdmqjUgVEQCGAjbtNV1A0iKvkY6rE/d
         gXGsN45x6VA6T0xY3A37rC6lBzOalYog2z8SyWV2jIe+JHG1zkeK/Z7e/3SJHBa1h5pu
         Dxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGPyF9cLnTz2QZ4yWAoBXLvmWhnOB2cEFuUlKJPyncE=;
        b=jeNhtpIOGpCWxVCOw2MMO7O0e4I3p0oVtTBOpoUWXJrCKF2i82bedEZGeaJwwgnfJR
         zENaZdaIuNgaDiorkGYA2Kv+4PIEIpYGGf/b3mFnn5Tc8d6kcbbgEKFLkjIJ/HU7eujP
         hMazhHqeRcagGzm1MgBCMDoMKiuV2RPxYve537PnLrBorVL9P6c+0GY7kFyyatWWMRH/
         X56ibkjuOaq3iivDnYe1VTec1fA0wB0YcLXbtwu9NWXlIcC84DXRkWZrHMTHdyesibqP
         8wW9KIZJO8CkfGhfDWffbB6t3MAU94+YNUFOCWoYUA8gVta4mbbDFK4VKnnu0tefUTsq
         +8jg==
X-Gm-Message-State: AOAM532kg37LrjytsnibGLBHom4CGJkQcXJhSWgU7p9iv3No3WbZFbj6
        Ry2qYka1/AfEkJ2FyFqf6ALSHEiitHY50Q==
X-Google-Smtp-Source: ABdhPJzW0NYagNhq6Yk0c3c+F6ZlDG2I0bgYutSzvWWCEh3GOqS93YccZ4p/KEtNiVqiR/PzfDl0tA==
X-Received: by 2002:a17:907:1ca1:: with SMTP id nb33mr28635480ejc.75.1621951011670;
        Tue, 25 May 2021 06:56:51 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id bm24sm10842269edb.45.2021.05.25.06.56.50
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 06:56:50 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id p7so28638900wru.10
        for <linux-kselftest@vger.kernel.org>; Tue, 25 May 2021 06:56:50 -0700 (PDT)
X-Received: by 2002:adf:fa42:: with SMTP id y2mr27555296wrr.12.1621951009929;
 Tue, 25 May 2021 06:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210525061724.13526-1-po-hsu.lin@canonical.com>
In-Reply-To: <20210525061724.13526-1-po-hsu.lin@canonical.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 25 May 2021 09:56:12 -0400
X-Gmail-Original-Message-ID: <CA+FuTSc19dDYaRyJZV5qqwz7rFy+5KXHzX_0OkwAFFyJH6aU6Q@mail.gmail.com>
Message-ID: <CA+FuTSc19dDYaRyJZV5qqwz7rFy+5KXHzX_0OkwAFFyJH6aU6Q@mail.gmail.com>
Subject: Re: [PATCH] selftests: Use kselftest skip code for skipped tests
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, skhan@linuxfoundation.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>, nikolay@nvidia.com,
        Guillaume Nault <gnault@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>, idosch@nvidia.com,
        baowen.zheng@corigine.com, danieller@nvidia.com, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 25, 2021 at 2:17 AM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> There are several test cases still using exit 0 when they need to be
> skipped. Use kselftest framework skip code instead so it can help us
> to distinguish the proper return status.
>
> Criterion to filter out what should be fixed in selftests directory:
>   grep -r "exit 0" -B1 | grep -i skip
>
> This change might cause some false-positives if people are running
> these test scripts directly and only checking their return codes,
> which will change from 0 to 4. However I think the impact should be
> small as most of our scripts here are already using this skip code.
> And there will be no such issue if running them with the kselftest
> framework.
>
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

Perhaps it's a good time to mention this patch to add a kselftest
helper library for shell tests again:

[PATCH] tools/testing: add kselftest shell helper library
https://lore.kernel.org/linux-kselftest/20201123162508.585279-1-willemdebruijn.kernel@gmail.com/

That can avoid redefining this constant in every file.
