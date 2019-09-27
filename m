Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABDBC05F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfI0NGi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 09:06:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37722 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0NGi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 09:06:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4so2277363edy.4;
        Fri, 27 Sep 2019 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfddVZ+BXRM3AZXqv+ZT0fTLNYdGcpGyrxWu4D92uZE=;
        b=GXS1LbBmD64+zLp5u1YnxdYeQ8PrVxKHTGIY9o7mMl0x2b9Kbktua72wlNmpRk41F0
         gEfcX5YdImGN42x6nLhqWZ/OSZfTKKk3qjj/AY1ANbARrSbIdA9a922XYEKuBsompZBU
         vh2VX1ugpRxCvXH2QZHDwXKJOcFSQ0qTbRYxQVe3NLRHUJJGaaj27kQBmF598JFdp/vI
         Ap0KUCazl3OlpNq1zBUTHISC5rv/CDO7KE6ZuQUfQZF5pLYQZR9C+ANHJ0GuRZ35TUDx
         4PqHbt0HSLeYVmk4iqNtyY65tI4hRYU1Gswxg++xxKM/6KaRw1XZs8ldsp22sgNBWLgO
         xbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfddVZ+BXRM3AZXqv+ZT0fTLNYdGcpGyrxWu4D92uZE=;
        b=i8gwM3yAjv4KEGHPAi3DnEtkM6Hg5i6u2vGHt6EO+9phUq9o6kO0yZQsfRzj4SpCvh
         1xErhK9AJYZkkBqDlsAsxRgIFCpBcN13hfA/cj2n94fYP41N2z2/wg3A8tPA+jXZ1r9M
         TUvqyosV3nVrNvi+yQeD0+G/WE0AH07ZpRlWtjkZYsuTAwd+9RHeQk6gkwXsXHx6HH+5
         5lIkuKFELbTP/JwJ9t4+f6DJ9GA4Q2M0K1m8NovWrNgB2YbJ0JvKCe+rfen6bKhKlKkw
         KI6nzceiMQeICrSXfENtD+xAIymviURhLezYUGmK1H7OZsJ0xb9bjGvS+w0hzaF6ZM0K
         TPBQ==
X-Gm-Message-State: APjAAAWxz/62agqC4PfaM7bno8zfd//eQVS3H514G8zkol9DBac2AYyO
        jR5MhjfPfcDGqsI5Sv2sU4nS3fDic+wyCKCg2Sc=
X-Google-Smtp-Source: APXvYqz6jHSQsa3IMSkr7eTUjAru2YBYnHAlMN5XRDfFnNXyoEYJaovgiUnurVtV4xx3I5tSSmmCz536FsHxleUSAIM=
X-Received: by 2002:a05:6402:1858:: with SMTP id v24mr4395130edy.130.1569589596288;
 Fri, 27 Sep 2019 06:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190919082902.GA15755@yogzotot> <CAADnVQK6FjwivxDsmoskH_Zwr+Q730+H9u_5hBBdyzzDP1vyRg@mail.gmail.com>
 <56fb689c-428b-ad1a-6f25-48422420e4c5@kernel.org>
In-Reply-To: <56fb689c-428b-ad1a-6f25-48422420e4c5@kernel.org>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 27 Sep 2019 16:06:24 +0300
Message-ID: <CADxRZqwzXc1-bFFHx1_LUw-95+f+1cYnHZp7RKqycwfcsF28OA@mail.gmail.com>
Subject: Re: [PATCH] selftests: update .gitignore files for selftests/bpf and selftests/zram
To:     shuah <shuah@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 19, 2019 at 8:09 PM shuah <shuah@kernel.org> wrote:
>
> On 9/19/19 8:39 AM, Alexei Starovoitov wrote:
> > On Thu, Sep 19, 2019 at 1:35 AM Anatoly Pugachev <matorola@gmail.com> wrote:
> >>
> >> selftests: update .gitignore files for selftests/bpf and selftests/zram
> >>
> >> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
> >> ---
> >>   tools/testing/selftests/bpf/.gitignore  | 4 ++++
> >>   tools/testing/selftests/zram/.gitignore | 1 +
> >>   2 files changed, 5 insertions(+)
> >>   create mode 100644 tools/testing/selftests/zram/.gitignore
> >
> > could you please split this patch into selftests/bpf/ and the rest?
> > we'll take bpf bits via bpf tree.
>
> Yes. Please split them. .gitignore changes for each test need to be
> in separate patches.

I wonder does it still make sense to post patch for .gitignore if my
current git kernel does not show this extra compiled binaries any more
(probably after make clean) ?
