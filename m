Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3275D228310
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 17:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgGUPEq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 11:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgGUPEq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 11:04:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF34C061794
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 08:04:45 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b25so16395698qto.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcBXfL/2ghXmfWUhIUFmjDIyiJHk+JdIwC3C6WYMhpA=;
        b=nkEVU9ZU87N0ifRBVfB1q8YCi1RxVxmEu5RdvsDBXhFiPEL0+m0yusDrGS/FPQ3rV4
         xIvv4ogoqcsmhBb2zKHlT8evZyfcSrjlNRIDagEWf2bZJ+APn9ZNgdOWqtt3jSVKMQjc
         8jA9M3khDvpJ/TEVAbWFQNwBkiJyvtzM7IUzy0BA1NgrC9LRk93FKRVqtD9AEsVn6viX
         kgsPnKKqECnJc6sBS4aeiSeBZeS7SKdsRVwoyZ5zVYFPPkcY7RARcI5IxXIJT+kqyJKJ
         /9YzVuyStefKMLITBThkojKd8PUiTeZAmOJfUyw230YDsecfXsxPQHpsqj579b/xhvBO
         TQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcBXfL/2ghXmfWUhIUFmjDIyiJHk+JdIwC3C6WYMhpA=;
        b=ebkucxtZQOFFChsppatRXaRVrzDHcdJwmWKOvVCS1QW1NayjzJ16OYMCJWCRE0cJHr
         vTvRi4Mqt6CMZvbmb5+Z8MELpA7lcNUGwhL8Bg8WTE231c/i5mT8taDFD1wNKJ9eXrQM
         UIInJ7NxMw5EAzxQg6bfsWeimBJ+EVtBahvAhy/d2X/XhnM2sLwHYA6/GYQyJb5GHnIr
         BE5F5U9no02JQlbZ1vqEbM4EtY0LZzfHOr1SOw2d+C1lIzay967Bj38skXWxOVKgavDm
         R8NJsO8gdDn1Jwkb5GQukoaJGEUN3uByWiGt6kmkExtlTxw2pcii9nhn8Ba9yIVj9S1s
         Julw==
X-Gm-Message-State: AOAM531V2LmkN0HtxaUrt+YV8LTyX5W+rtvsMT1Ll2rY6ojuLO41FHHb
        EWl3EbkOkKUzw2Am4XzS84uIE0uC
X-Google-Smtp-Source: ABdhPJw2cGA0OCO47lKCD6fzitWwTW1tPKdWipRIaeHcX7IsGBQMAmorDDPM9gHuQx3e4uFQyDur/g==
X-Received: by 2002:ac8:4b47:: with SMTP id e7mr30148971qts.242.1595343884498;
        Tue, 21 Jul 2020 08:04:44 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id b125sm2687596qkf.71.2020.07.21.08.04.43
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 08:04:43 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id e13so19554172qkg.5
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 08:04:43 -0700 (PDT)
X-Received: by 2002:a25:4886:: with SMTP id v128mr40285167yba.53.1595343882471;
 Tue, 21 Jul 2020 08:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200721145249.72153-1-paolo.pisati@canonical.com>
In-Reply-To: <20200721145249.72153-1-paolo.pisati@canonical.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 21 Jul 2020 11:04:06 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
Message-ID: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
Subject: Re: [PATCH] selftests: txtimestamp: tear down setup() 'tc' and 'ip'
 env on EXIT
To:     Paolo Pisati <paolo.pisati@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jian Yang <jianyang@google.com>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 21, 2020 at 10:52 AM Paolo Pisati
<paolo.pisati@canonical.com> wrote:
>
> Add a cleanup() path upon exit, making it possible to run the test twice in a
> row:
>
> $ sudo bash -x ./txtimestamp.sh
> + set -e
> ++ ip netns identify
> + [[ '' == \r\o\o\t ]]
> + main
> + [[ 0 -eq 0 ]]
> + run_test_all
> + setup
> + tc qdisc add dev lo root netem delay 1ms
> Error: Exclusivity flag on, cannot modify.
>
> Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>

The test should already clean up after itself, by being run inside a
network namespace. That is a more robust method to ensure that all
state is reset.

The issue here is that the else branch is taken in

  if [[ "$(ip netns identify)" == "root" ]]; then
          ./in_netns.sh $0 $@
  else
          main $@
  fi

because the ip netns identify usually returns an empty string, not
"root". If we fix that, no need to add additional cleanup.
