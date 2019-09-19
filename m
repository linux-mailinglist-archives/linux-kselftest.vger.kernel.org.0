Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83080B7D0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 16:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbfISOjd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 10:39:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44782 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732579AbfISOjd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 10:39:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so3812786ljj.11;
        Thu, 19 Sep 2019 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qb8wSvIQ4nC55X54/RWJ18Vfsst4KOF/u6y+XHfA/dI=;
        b=oYT2MlDgxVIBlh+OLSBJ4m3Lop7TBaO3jQ+SyVAeuhXATMFGGnLzt1qBS9IdSS+3ob
         gNWOpdwD8ta3IWlNJb4ifMzbpQaujil4oegSphzZ2DolV4EnWfTrg7NzlEgtLbxg+m/M
         g2OQnxKIYIBZKF5kxExB+XU40HQuHGKipV6jDf54mS2CxJR2AFiMzcU/q2EWtE+eVZeU
         4bdX4B92kmC6N22zC2SLxG9Mq2PJyPaoQ7LyIBBH0Rq/wNT1CKGJJc9bPrwFOp6hEfzi
         3u0MEKuiDixNq8pbYVNYb9/B4rstFm3mnC+WC0Z9D9Oj/Amv6GPRzlgbLEvwDxx+ff+N
         GebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qb8wSvIQ4nC55X54/RWJ18Vfsst4KOF/u6y+XHfA/dI=;
        b=Fo+JPDh/kpkwiI0hnetC502NAN8y7E3cNi2MadGrETKoTmzXIB/EdBHpCiFKaUmDZH
         iOKEWQcrcMbNwPh3R/HaeFwSxoAEwxKiAA0pa2DHrsmiuUCqWCHuXcXXdzap9O12kvBm
         MBD00VSpaQQ8maTvxyW3TeyBo+x7EDflFmAaEFxvhxYBBh6Qa9+BgeMPRnllTKX5GBRz
         UJb4wV5c3QjBcjcFJNBua3SsPMFv78CGa2YuwIlO4+q++M2hHMckSXOW03nBQNw3YPZu
         yK5qebf7OSC0u3E8kXJJJfT2GH/TAbpjqQAEnaUwBlQtVXu1ky7+t/f0JqLis4oje6Lw
         1B0w==
X-Gm-Message-State: APjAAAUytwmg2LmzX1fGEA8IX5HTSU8RlXiPrZ8IAroBfrKH/h9o7nGX
        zDzyosVXRtiLTvsixADu86FPKELYhWKlhPDhphU=
X-Google-Smtp-Source: APXvYqwBIPpOQ0YhBy4YmO/A1wzqqtCBNaYvPSrmcyJfMpmmAi6MvcQQzq9pi2y/PMo4xLxzcvzRscJo0f01qTA+Tx0=
X-Received: by 2002:a2e:9708:: with SMTP id r8mr5592899lji.58.1568903970830;
 Thu, 19 Sep 2019 07:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190919082902.GA15755@yogzotot>
In-Reply-To: <20190919082902.GA15755@yogzotot>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 19 Sep 2019 07:39:19 -0700
Message-ID: <CAADnVQK6FjwivxDsmoskH_Zwr+Q730+H9u_5hBBdyzzDP1vyRg@mail.gmail.com>
Subject: Re: [PATCH] selftests: update .gitignore files for selftests/bpf and selftests/zram
To:     Anatoly Pugachev <matorola@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 19, 2019 at 1:35 AM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> selftests: update .gitignore files for selftests/bpf and selftests/zram
>
> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
> ---
>  tools/testing/selftests/bpf/.gitignore  | 4 ++++
>  tools/testing/selftests/zram/.gitignore | 1 +
>  2 files changed, 5 insertions(+)
>  create mode 100644 tools/testing/selftests/zram/.gitignore

could you please split this patch into selftests/bpf/ and the rest?
we'll take bpf bits via bpf tree.
