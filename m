Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BDE533CBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 14:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiEYMf2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiEYMf1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 08:35:27 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD06D86D
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 05:35:26 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c1so17137173qkf.13
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/A2wyDaNzDKlw/qvtJ6FS1LUC1S3cZ+h0mgvejXLlQ=;
        b=Xu0TlTNRdwdUzPc+JG7TdjcIcmHQVTnDdMtn2/xYgcHTdk79peQrh9W0ndYk8aiTtu
         4jdxFmD5UknvI88YVoWg8gKAOx8ED/n1yiBVPLl43W305r3CnALPVFcDqADWto0L3Z4O
         aWqLKq9rOV6xa2J/4s1V5lbBpOG02aXz3/f57Ch6VJLrXXbqf1t0p9XHjLdBBQ9Jg7Ww
         M9atpVK4WiZ5ELkuZyUTjaJ6v31f6uQs931T6ty9sbmfHjStLPGrh8+UvmrwLeI5QSwi
         p5gQvyw7udp0gDXeVIG7Myk1P2ccWwzOaLCU5YBChIs//ogjtKU9CAwb3Zan4xgLgpb+
         NCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/A2wyDaNzDKlw/qvtJ6FS1LUC1S3cZ+h0mgvejXLlQ=;
        b=YtD2+uUsiRl/oWo599K4r6ulpES/o2g25UMuk45oGgM7MJBUvEqfcJmZGlKc5AOyfr
         vyzxNfbtViBrzMIccaBQOvNnfQZp3XXIdeJQ1k4yn0bbNShZmNF3i+lK1N89pXMsr1R5
         Sidj6J/gp4P0BWDgx7QZgGOrufEBA6k68JNmFVczLtxp6tEwkBirDBRKalO6ztxINYj+
         m6Rz3U862zP312vs3OHw3jgHZ7w5HYYn75hI9q62Zw62qzg5Ppz118KRwSxcSqUagDz2
         j/8yDeQOS20tBwjfH1KlIxF1jIEo9/MeTyFCTvOuWCsVWU1o80m6OebVRYNuG6w7NP9+
         umgA==
X-Gm-Message-State: AOAM5335T5+heRyf6WxM8qhN7cSSZnPeFNS5Rvec1Gwka4r9lmJBXqHU
        RIJ89rAMiREAX4faRFUpx+KhoOqFdO8=
X-Google-Smtp-Source: ABdhPJzM8IRaJ0qBJoByGGmWQC9EPVKTMEMRKdiswCbouX4XRJGtbuNVfAyM/Q1+mySBaXkCxK0EgA==
X-Received: by 2002:a37:8e02:0:b0:6a3:76d8:ed7a with SMTP id q2-20020a378e02000000b006a376d8ed7amr10969998qkd.162.1653482125604;
        Wed, 25 May 2022 05:35:25 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 128-20020a370c86000000b0069fc13ce23dsm1167836qkm.110.2022.05.25.05.35.25
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 05:35:25 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ff7b90e635so147178027b3.5
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 05:35:25 -0700 (PDT)
X-Received: by 2002:a0d:db12:0:b0:300:55ea:66cc with SMTP id
 d18-20020a0ddb12000000b0030055ea66ccmr2046488ywe.348.1653482124711; Wed, 25
 May 2022 05:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220525031819.866684-1-luyun_611@163.com> <Yo3YoZWRkygFyqUc@Laptop-X1>
In-Reply-To: <Yo3YoZWRkygFyqUc@Laptop-X1>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 25 May 2022 08:34:48 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeoy9v9omBOMyL=3NY8ayEz6gPaTcZXStCuTdmHWQtYHQ@mail.gmail.com>
Message-ID: <CA+FuTSeoy9v9omBOMyL=3NY8ayEz6gPaTcZXStCuTdmHWQtYHQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/net: enable lo.accept_local in psock_snd test
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     Yun Lu <luyun_611@163.com>, davem@davemloft.net,
        edumazet@google.com, willemdebruijn.kernel@gmail.com,
        liuyun01@kylinos.cn, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 25, 2022 at 3:20 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> On Wed, May 25, 2022 at 11:18:19AM +0800, Yun Lu wrote:
> > From: luyun <luyun@kylinos.cn>
> >
> > The psock_snd test sends and recieves packets over loopback, and
> > the test results depend on parameter settings:
> > Set rp_filter=0,
> > or set rp_filter=1 and accept_local=1
> > so that the test will pass. Otherwise, this test will fail with
> > Resource temporarily unavailable:
> > sudo ./psock_snd.sh
> > dgram
> > tx: 128
> > rx: 142
> > ./psock_snd: recv: Resource temporarily unavailable
> >
> > For most distro kernel releases(like Ubuntu or Centos), the parameter
> > rp_filter is enabled by default, so it's necessary to enable the
> > parameter lo.accept_local in psock_snd test. And this test runs
> > inside a netns, changing a sysctl is fine.
> >
> > v2: add detailed description.
> >
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: luyun <luyun@kylinos.cn>
> > Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>

Acked-by: Willem de Bruijn <willemb@google.com>

ps: I did not really suggest this fix, but no need to respin just to remove that
