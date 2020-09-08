Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02527260B5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Sep 2020 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgIHG5l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Sep 2020 02:57:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58429 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgIHG5k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Sep 2020 02:57:40 -0400
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kFXZQ-0002qT-U1
        for linux-kselftest@vger.kernel.org; Tue, 08 Sep 2020 06:57:37 +0000
Received: by mail-lf1-f70.google.com with SMTP id f13so944147lfs.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Sep 2020 23:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzp7zmy16qSTY1Tj4XpNRu/ljIgkqSbcbe8XDlpXvi4=;
        b=S9Y9Tjq614Oz42DWrNWaS6VUmBFReIo89GIQnKyB1EuUVvP7bh939wAzg/oQlzmiHF
         vrx8w1+OTx8cYgmbluM/hZdBTnobmclF4O26RlUiYwGch+sWbYxjvK9FnId6gOqUFua9
         kO4f8Bs09LVOrvftN5lDI5r6AZmqzi9MPc5byCin7IHO+VpNYz24DSfHw4vn2UxoXI22
         128ZaNxdScfU30iXnMa+yKw9FkYAahQmx/pZBXPaG815rz0zTo6kp/5a6uHfbFDeF4DS
         EMoK/35g60wQK1edEgeGRmgyZZob5v8/954iweukcI9wyUYigxhn7eilJTkpOve70F5C
         xyGw==
X-Gm-Message-State: AOAM532cMu3OPWNQ4R/lTHbG89+qCUW9fnawOwMVe3kj4bSpYzZraZqn
        QdFXiXus/S7dd3G/ypJ2Rgq9pCy2QTfZqOyrNlj5hU+CsdZMuRgAyfgsDToL7NaZu9WvOksujkY
        4dq54KpXT7iT85pcfbxYAtxABoeup4AwWHe2UnUnyfAE0Y63LaKOIinqA6ANo
X-Received: by 2002:a19:a411:: with SMTP id q17mr11860166lfc.203.1599548256274;
        Mon, 07 Sep 2020 23:57:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygp/Cy9i5kwwqPW29UqRHI61VnfUXcFf9tILlkpm11JRKPQHotL77csl2OK1RXodhDbYgfkWa4aatVJw3RBRA=
X-Received: by 2002:a19:a411:: with SMTP id q17mr11860150lfc.203.1599548255889;
 Mon, 07 Sep 2020 23:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200907035010.9154-1-po-hsu.lin@canonical.com> <20200907131217.61643ada@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200907131217.61643ada@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Tue, 8 Sep 2020 14:57:24 +0800
Message-ID: <CAMy_GT-kaqkcdR+0q5eKoW3CJn7dZSCfr+UxRf6e5iRzZMiKTA@mail.gmail.com>
Subject: Re: [PATCHv3] selftests: rtnetlink: load fou module for
 kci_test_encap_fou() test
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 8, 2020 at 4:12 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon,  7 Sep 2020 11:50:10 +0800 Po-Hsu Lin wrote:
> > The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
> > needs the fou module to work. Otherwise it will fail with:
> >
> >   $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
> >   RTNETLINK answers: No such file or directory
> >   Error talking to the kernel
> >
> > Add the CONFIG_NET_FOU into the config file as well. Which needs at
> > least to be set as a loadable module.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> > diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> > index 7c38a90..a711b3e 100755
> > --- a/tools/testing/selftests/net/rtnetlink.sh
> > +++ b/tools/testing/selftests/net/rtnetlink.sh
> > @@ -520,6 +520,11 @@ kci_test_encap_fou()
> >               return $ksft_skip
> >       fi
> >
> > +     if ! /sbin/modprobe -q -n fou; then
> > +             echo "SKIP: module fou is not found"
> > +             return $ksft_skip
> > +     fi
> > +     /sbin/modprobe -q fou
> >       ip -netns "$testns" fou add port 7777 ipproto 47 2>/dev/null
> >       if [ $? -ne 0 ];then
> >               echo "FAIL: can't add fou port 7777, skipping test"
> > @@ -540,6 +545,7 @@ kci_test_encap_fou()
> >               return 1
> >       fi
> >
> > +     /sbin/modprobe -q -r fou
>
> I think the common practice is to not remove the module at the end of
> the test. It may be used by something else than the test itself.
>
Hello Jakub,
Thanks for your feedback.

For this case I think it's safe to remove the module here, as it was
never loaded before and thus causing this test to fail.
If other tests in this rtnetlink.sh need this fou module, we should be
able to spot those failures too, however this is the only failure as I
can see.
(pmtu.sh will need fou module to run as well, but it will be loaded there.)

Shouldn't we insert the required module whenever the test needs it? So
that we can run the test itself directly, without depending on other
tests.
Also, I can see modules for tests were being unloaded in other tests as well.

Thanks

> >       echo "PASS: fou"
> >  }
> >
>
