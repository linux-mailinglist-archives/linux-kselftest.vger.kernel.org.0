Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A3221D45
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 09:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgGPHX1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 03:23:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47492 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgGPHX0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 03:23:26 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <paolo.pisati@canonical.com>)
        id 1jvyEm-00048y-Er
        for linux-kselftest@vger.kernel.org; Thu, 16 Jul 2020 07:23:24 +0000
Received: by mail-vs1-f69.google.com with SMTP id q10so836256vsg.18
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 00:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VmvjZDsnQSCsnAdrtuni5GNCSEbuCmNLcMY3wa2Le0=;
        b=Arft/4LVRtZxjZvQT1Ev8ebIV4gkwv8ZQeMMgY+0Vn/aY5nynA8G/5da+us3QnS0aS
         wVCIbYW6Fntqyhjk0BZaows+oloq4UUAobnF7cpIock6pBpqi43g7T5PWHzJeyQo0KVN
         ChADMRy41XMYdCCtmdKAT4VGUV6NJrQdBdOkc2TrzATG6RQEjOiGQHrdedSt+9Gc8Eqk
         yKVvpXaRt6QZi1NXCNK7d1kI10/4XRNLh7ypqabC0oqb6SSAnfDNcquIJfnP4Vl2huGI
         5wQZ9A6QpyFftZ2UBugRRp1ISGLnFaQTfu+Wt+V8Tju3je38vcDbzBYPvHt5SbwQNdPp
         yOHw==
X-Gm-Message-State: AOAM533nLMm8zL0xVtlBt0uxjMY3IABn7MDiS6sXSnWrmiWSuv2pu3vC
        VP8XLX63HiZzRzkFxMpeFjbclAmYbrJFnQNgv2KizBHcYArsm7x6KxacCKxTZH3Mt3+nVwzM15e
        oQ+7XQvFXr/wD7ngEQUaoLNI6qgCba/LUsQBJ5BVZVFGt1tT3atwM+++wOCZZ6g==
X-Received: by 2002:a67:ea92:: with SMTP id f18mr2022728vso.223.1594884203579;
        Thu, 16 Jul 2020 00:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS+5S514mTPFzXqUXVOTEZkeMuUy2FYfT9xaHwmafmZRwQscM2lA1wpLggKg5Y3dTj0KuOtDWJMMfXoNs0idk=
X-Received: by 2002:a67:ea92:: with SMTP id f18mr2022712vso.223.1594884203322;
 Thu, 16 Jul 2020 00:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200714124032.49133-1-paolo.pisati@canonical.com> <20200715180144.02b83ed5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200715180144.02b83ed5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Paolo Pisati <paolo.pisati@canonical.com>
Date:   Thu, 16 Jul 2020 09:23:12 +0200
Message-ID: <CAMsH0TQLKba_6G5CDpY4pDpr_PWVu0yE_c+LKoa+2fm2f4bjBQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: ip_defrag: modprobe missing
 nf_defrag_ipv6 support
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 3:01 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Any reason you add this command before set -e ?
>
> It seems we want the script to fail if module can't be loaded.

Cause if CONFIG_NF_DEFRAG_IPV6=y, the script would unnecessarily fail.

-- 
bye,
p.
