Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1903F6DA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 05:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbhHYDWH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 23:22:07 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45986
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237739AbhHYDWG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 23:22:06 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 86464407A0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629861674;
        bh=bubKe1V2wVnyhV9MMzcO3LsuU+2HkzzeQ/usUihXRL4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pNK5/VUbe8Zo5NVmRDNXnLvbxS6+TDoeocuhytiPuOPSTnH+EtAC+l4dMQ+6uBahA
         d6mgRGg6g0KzUhJsmyXt/+mi07hDCvElqnSYRgcuDDe/0F18G4jUKYeQxzHACrS0nm
         ItwPsP+cyOXbAJhd5bn22PB4mYrVwmO9gdW8wr3zpBmiWsNI0dX/oieLFDCeQonKoZ
         HZ17s66ylUNCu4JUbjdlRMQA+Mong1/e69m4IRUFhEpEsk0+dOm6KiEEA4AP8xPwgK
         2e2TBROrye5c+F8TyYROZ7sIB8PtXrpzdxT+o061zpps6MIpHU0vIziYp3Pny9VHBh
         dGuoRmTCHy7Bw==
Received: by mail-pf1-f197.google.com with SMTP id b10-20020a056a0002ca00b003e1bfef6c57so11109587pft.13
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 20:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bubKe1V2wVnyhV9MMzcO3LsuU+2HkzzeQ/usUihXRL4=;
        b=CoN+5rp2X+a0E3Ngzx71KBSkii/CH4RpdMhO8ECdo4nyhBxMuizkYsQKp10KdsTXVa
         YAFpZmYhUJUJujyjq4jg17YTkiuVhhLIuFVTGVbvh651mWvPMXR82a0B4g/0bya9OCsh
         vmN/KYGuewAFdhyFMDzsHnP/lKhK1uetcdDDC9N5TWAWMiw04BcATsqrg1fDc++G8bfo
         W38GpJpOuQajdJ0hdDHcmKoLeuSdTkQwRffichIJhJRgdRPf84X8jCSTrVglgYv0LwpA
         QzdT/akAF0cUMvKz//c3UMTOyXRm5cZMJWaLMc6r17f7+dZ/o+dwZ6//s7qEyDKKFaZJ
         /t3Q==
X-Gm-Message-State: AOAM533UO+djspW5vm1SOPxqVHpsD1uUpNIJaW4C3mGZjHJD/qf3l27c
        BidMcI4PUe7odISgO9xD3ukdbLBt0FlJYqLtv4Iq187f8sQRycCO2YUyQ3AiQ4N819g4M6iZhCi
        epOMomXFN3HpbePj2Sk+zgOT6/qNx3NbnJ7mWluHvd/N8DYtniOAsBBHE2dEK
X-Received: by 2002:a65:494e:: with SMTP id q14mr40030659pgs.314.1629861672698;
        Tue, 24 Aug 2021 20:21:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhWn0jS2YhuUhIxgZx+PjfbGWTVTBIIjMe7EFktPXwyVRjO7xHttqYBJgkFKlGl1VfvTS2JVhsyO4eOepp7Jw=
X-Received: by 2002:a65:494e:: with SMTP id q14mr40030623pgs.314.1629861672376;
 Tue, 24 Aug 2021 20:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210823085854.40216-1-po-hsu.lin@canonical.com> <YSSemxg1JQRdqxsP@shredder>
In-Reply-To: <YSSemxg1JQRdqxsP@shredder>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Wed, 25 Aug 2021 11:21:13 +0800
Message-ID: <CAMy_GT9xMGsX2dqDRhq=2LPf4OZLc3j1YLCYKOVZACKhPyTu8Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: Use kselftest skip code for skipped tests
To:     Ido Schimmel <idosch@idosch.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, petrm@nvidia.co,
        oleksandr.mazur@plvision.eu, idosch@nvidia.com, jiri@nvidia.com,
        nikolay@nvidia.com, gnault@redhat.com, simon.horman@netronome.com,
        baowen.zheng@corigine.com, danieller@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 24, 2021 at 3:24 PM Ido Schimmel <idosch@idosch.org> wrote:
>
> On Mon, Aug 23, 2021 at 04:58:54PM +0800, Po-Hsu Lin wrote:
> > There are several test cases in the net directory are still using
> > exit 0 or exit 1 when they need to be skipped. Use kselftest
> > framework skip code instead so it can help us to distinguish the
> > return status.
> >
> > Criterion to filter out what should be fixed in net directory:
> >   grep -r "exit [01]" -B1 | grep -i skip
> >
> > This change might cause some false-positives if people are running
> > these test scripts directly and only checking their return codes,
> > which will change from 0 to 4. However I think the impact should be
> > small as most of our scripts here are already using this skip code.
> > And there will be no such issue if running them with the kselftest
> > framework.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Thank you for the test and the review!
PHLin
