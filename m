Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE2139F6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgANCTJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 21:19:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34513 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbgANCTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 21:19:08 -0500
Received: by mail-pj1-f68.google.com with SMTP id s94so429102pjc.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2020 18:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7aN7Y1nzik1KbsNshiwY6nugyBpWzW8lv7vF97PZQM=;
        b=C5RRpqXMfZpMtG14RRkraQFn1Sb5pbDBSB3Cb3uaNQfi/0xa0jM56TSKBtGYYLNo6n
         tWVPwTFEsCdF+47l7vtn4Fr1RnA6OJhuyLBDUrjWxQQ45xqZS4KPsPekcWf7md5BWqqN
         y4mtINZx/zEAi+nLD+ji9BLOfL2uI46y8ZAOK7cfFJuLd4mjK04x4Ln4RILVBD7LUPxu
         67aj+1E82N427JNXgL467Ozglj20XYvWOSxrkp7QD/dF1/C6tlpKrtB0oay4HWoY6h1l
         6powEnAq0H5y3mvCQXt1bNGGmpkQwichArkoOF08BCpu76t8xY9MMH04iAcDzbD1ZFQ0
         +4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7aN7Y1nzik1KbsNshiwY6nugyBpWzW8lv7vF97PZQM=;
        b=SuQJq7deyafgXN4SAiFykfIBnsF00rr4BvZMMuAyoWqjBx6VVeoAkqdEky2yarvRan
         XA5tyZFY/zhjUzU6dfN/0dgUP9Fv/kJRz/qfEqZsCBRYlQ/WWxcOs9HNYxCWc+hGSzXT
         WyekEzo4k35HMiC8KRFsKE0TJzNwbBB400NJo9iBAyBS9aDwUqUcPHaWChtB8vgqtbsj
         KxUimLLttKXl46BJkiZzl4gZYaPR84gD81/2kvPimNLls9wfpGb52GmcXYOGDq76bZdE
         3gmbniCbmvTrCas8K4lyOf9X1KJ0grnEvC2S4rpRa7yVYz0lSWC1gcvr7/I2mkR8/u2a
         3xFQ==
X-Gm-Message-State: APjAAAVCLrQzmwzi84T8LsCYSH63dherfPIEBzfkhTk9oYa2z/C6FnC0
        0nJ83ZcRISabverbUT6ONoMCyDqlDhc033Twws9vhg==
X-Google-Smtp-Source: APXvYqz+9AZOJJpTU34QiSXSYDhA2HUFGP93xod3rAKylUqbvfH/Pmt8P197RInxMERv7NI/gqMqrsXBuTOaZAiTkLM=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr17804616plm.232.1578968347761;
 Mon, 13 Jan 2020 18:19:07 -0800 (PST)
MIME-Version: 1.0
References: <1578656965-2993-1-git-send-email-alan.maguire@oracle.com> <bb27a03b-1c3d-567b-caf3-7b0e4a039f6d@linuxfoundation.org>
In-Reply-To: <bb27a03b-1c3d-567b-caf3-7b0e4a039f6d@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 13 Jan 2020 18:18:56 -0800
Message-ID: <CAFd5g45qfWtB9yp=MZ=79hR7Z+c7r7nsfMeofxzF0WAbzkvxag@mail.gmail.com>
Subject: Re: [PATCH kunit] kunit: building kunit as a module breaks allmodconfig
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        jmorris@namei.org, serge@hallyn.com,
        Knut Omang <knut.omang@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 10, 2020 at 1:39 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Alan,
>
> On 1/10/20 4:49 AM, Alan Maguire wrote:
> > kunit tests that do not support module build should depend
> > on KUNIT=y rather than just KUNIT in Kconfig, otherwise
> > they will trigger compilation errors for "make allmodconfig"
> > builds.
> >
> > Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> Thanks for fixing this quickly. For future reference, Signed-off-by
> should be last. I fixed it and applied the patch.

Thanks everyone for taking care of this so quickly in my absence!

Cheers
