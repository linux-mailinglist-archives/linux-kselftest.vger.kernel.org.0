Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003C46A24F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 00:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBXXXV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 18:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBXXXT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 18:23:19 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC5D46083
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 15:23:18 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id da10so3564547edb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 15:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nWAcuGbK5S98jhiEfAfFxluyUQmZTTL6shQBcv9fLug=;
        b=eSX5EmziA/DY5rK3tRfiuIorvaZ6oZBxKbLwZa+EzjGi/fWSRJLsF5m4NcoF1QZPXY
         LKtEgrGO8dSaGM6OX+0ChNI+5XIZkqmUXYv7j/15nechIkRWCMnCJvdWnFehFbtLx0AI
         J4ysdYuHIeLti9eALlkmV+fnrr5aRBNIzLSI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWAcuGbK5S98jhiEfAfFxluyUQmZTTL6shQBcv9fLug=;
        b=WCfdQ46itt6bLAA9ZWgTtJTovjwpj2MWydNQPZ6x4e1o7ZFhNOVXvXD/ZecFfVcA/A
         6R/LNmgvM6inAHMAme4cbGM9G/MxZhu+oGvgPL5AFprRejO+k7kozoWs2vtYVfXSRdPv
         +Y1yxsD1kOjKZZMaalXZCnX3dGoTwlEhZse/+YwFw7HwO6bEN+OW5VRkcJHqMG/SNnQ+
         3q7E0htY6GV1C+VigrtJnaHbM5SMAZOVx818s4d6p6d1bWxE+VETUjtHcTamaFyaqDJX
         acAUUylP48HLOW9cS7SDPd199dKeO8vU6T/2/jhNBOsVGms+etmAII/iyKMcrhur73yR
         Qp3A==
X-Gm-Message-State: AO0yUKVknfVGsD0+ZWYg4PxpBqDWfw6EiTz5tz0KxJdMRdPUc9lacsXm
        8G5O+bpiHUTpPatKRWaJkSb5yfw5eIzraZekhciAkA==
X-Google-Smtp-Source: AK7set+qN0kVsh6iKfY4KXLeomxo8q4vCEnN2nA0ObAb/417VF7pLR1koQWGrtyRaQueMhAhAx31iQ==
X-Received: by 2002:a17:906:b2ca:b0:878:673f:5492 with SMTP id cf10-20020a170906b2ca00b00878673f5492mr24682744ejb.40.1677280996501;
        Fri, 24 Feb 2023 15:23:16 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709061e9300b008d83ad86fe8sm121724ejj.59.2023.02.24.15.23.15
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 15:23:15 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id f13so3490818edz.6
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 15:23:15 -0800 (PST)
X-Received: by 2002:a17:906:9f25:b0:8f5:2e0e:6def with SMTP id
 fy37-20020a1709069f2500b008f52e0e6defmr989738ejc.0.1677280995333; Fri, 24 Feb
 2023 15:23:15 -0800 (PST)
MIME-Version: 1.0
References: <02cf36b9-6526-576b-1fd3-a59b67c8c123@linuxfoundation.org>
In-Reply-To: <02cf36b9-6526-576b-1fd3-a59b67c8c123@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 15:22:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEf7irTKwPJ0jTMOF3CS-13UXmF6Fns3wuWpOZ_wGyZQ@mail.gmail.com>
Message-ID: <CAHk-=wiEf7irTKwPJ0jTMOF3CS-13UXmF6Fns3wuWpOZ_wGyZQ@mail.gmail.com>
Subject: Re: [GIT PULL] KUnit next update for Linux 6.3-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 21, 2023 at 5:51 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> This KUnit update for Linux 6.3-rc1 consists of cleanups, new features,
> and documentation updates:

Hmm. I have not actually bisected this or tried to otherwise figure
out exactly what is wrong, but the kunit code ends up being really
annoying for my build testing.

In particular, if I do

     make

repeatedly - ie with no other changes in between - the kunit code ends
up re-building itself for no apparent reason.

Which then causes a re-link and makes it all really slow.

Maybe I'm barking up the wrong tree, but just do

   make allmodconfig

and then do two plain "make"s in succession (feel free to add "-jXYZ"
to make it go much faster ;).

The second build - that shouldn't have to re-build anything - still does this:

  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  CHK     kernel/kheaders_data.tar.xz
  CC      lib/kunit/hooks.o
  AR      lib/built-in.a
  CC      lib/kunit/hooks.o
  AR      lib/kunit/lib.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
  ...

and it all takes much longer than an empty kernel build _should_ take.

               Linus
