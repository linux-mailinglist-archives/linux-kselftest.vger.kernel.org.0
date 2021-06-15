Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FF13A8A05
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFOURC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 16:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhFOURC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 16:17:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BEAC061767
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:14:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e20so62901pgg.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6x/2GwutOF+cCs/K9U5IUpxpHm0I/Ihy652D4Lbb0EA=;
        b=bTvMiXfEMzM/5F4KNTPhmZHK1ryKaAF6DfW0alLbXPjPtQw12+e9uUDSVsYYlYTyMY
         Fl2JCPA+VnYNgwKRvuWk2P+8ZAbfQrEo+4mT35vCM6lLdKHPrx6B8XlvBWUaRYktCRDB
         K4JQ9GSnIeZA3dz0StmBBV1kHBlDTrX7nq9XRfMUNiRRg1gg4bBEp0Q2D5+UAwof0hmf
         0LBOPxdCAuY+F43olvuPjth/cjCaBcqSwfGZgFAmbfD4Rbk1V/LQBbNd4R0nFO1gZ58f
         pbnNzfDmrwZYqTel0WLCfogys0/tMkiLBnujvRrE1FLpA737Ec7a7Xe1rCV7r2wZOjeu
         ofdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6x/2GwutOF+cCs/K9U5IUpxpHm0I/Ihy652D4Lbb0EA=;
        b=VAcTMWHdtq6tT00IZMVWW4fmlLsPo3rAJL9jiU4t1OnPkuVZB88Pj4euzjcvaectDA
         JLbmT8+5Y7zkC+AF8K5gEnlxIhH08enGG68YGfXDSg0nJplCznvbJnoukrNQbapsbSnt
         aybjl/7h6KUQ2utxOU1POWLBgO/lqlHiaOdF+GazH1uVhEGS7HIqAJFXftLkgz+7pavY
         f43vJjKcoN+/OL3An+dPGJzC3btbqpUmbyb4HtVx+VPk9G1tb4e5HFlWeF806hcqqx3K
         lGr63DttCMCasbtmEO0coasixtRAADnBWlOQ09aKMiUXWSLIpiU25xAXU3EqG42sXR0c
         +niA==
X-Gm-Message-State: AOAM531YkeT8FbYPko20nZWxt2KYyWCqNmC4of+QoWxQNz550WUWZPg5
        E6Eogm8td7oCzcGYzKlpy6PLlKL/rx0bWU02rhN65g==
X-Google-Smtp-Source: ABdhPJxbuae4N74/LSTRMH7o9AyYS5+s5RELbJLwHUNpMkKeRHm+LaKVUW95YJoWm6ikcpny78Ho7SSGEfGl21czGk4=
X-Received: by 2002:aa7:8e18:0:b029:2ec:a754:570e with SMTP id
 c24-20020aa78e180000b02902eca754570emr5999116pfr.38.1623788095729; Tue, 15
 Jun 2021 13:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-5-davidgow@google.com>
In-Reply-To: <20210513193204.816681-5-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:14:44 -0700
Message-ID: <CAFd5g44Eboz-=6LFQJ93sPVt53GQ60MGBUPyacKUj=0cFTJr0A@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] iio: Remove a cast in iio-test-format which is
 no longer required
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> KUnit's EXPECT macros no longer typecheck as stringently, so casting the
> result of strcmp() is now unnecessary.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
