Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DCD74030C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF0SR0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjF0SRY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 14:17:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F37E8
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 11:17:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69ff54321so41611101fa.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687889835; x=1690481835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6WtgfYTHi6I8JZ4MvciwexJ1Z4h0XfBA5L2+WUJORGE=;
        b=WLYlYkskDVo32palZZF8+iJHKdhcCy43cTuhbh5IR4Zz01SFb6rBNpDiYWLCvU2098
         UMgTl1S4gOzzWkkiexmk0Np/gETb8MPEBgq1zKxW0T+otAhsSacAySaekeOdmbhEqDpB
         RIfklIL36ktyVzB+JWSU5s/O2Sni8diRnHEmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889835; x=1690481835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WtgfYTHi6I8JZ4MvciwexJ1Z4h0XfBA5L2+WUJORGE=;
        b=LZFpmX4AIla/6ZZS2HccshGXg3BFkGbz/qpCwEP6HAYHMnOAWtR3CLbZ6HoBo9qdQL
         umJ/JkROa23BO3mdtldHUg2/xfSdSsg60iDXg6PAs5X1GtNJDbguBLdC0U0H4gHGukRE
         B1+t5FbDIKA9rDvWdyqhe6QG1aU31mf9HVwBUJKO39IouwSShoUtyfVEQAzSMhrK3aRv
         C95EwWPvTJHR5zGo60m3q0Ar+ul6DfaZXq7KeYsSazvsKUddoJWkHif9clCxe9k8tIXW
         ej1yJ6FJvT5M1OUy6Tfnkwo5C52i6ls2y1ZlT3yrWuoH0lhu4fxtB7LUhHtvYRiRoLyS
         pSRw==
X-Gm-Message-State: AC+VfDzzZ0fO3P97UbTSNzSQKy/1/y+9OUoOGXm6LxW5G5IRMfGctdWJ
        tm5RTrjVopEfeblw02QfjTrjFmngQWzAoxwfMskofXS7
X-Google-Smtp-Source: ACHHUZ6YO5GuglLfpOWpfwkoT/mfS3a2PV6Zw91sJqepnDEHvjeW573if0bS5mAMG5//bpCSfWd+hQ==
X-Received: by 2002:a19:9106:0:b0:4f9:54f0:b6db with SMTP id t6-20020a199106000000b004f954f0b6dbmr12763283lfd.13.1687889835209;
        Tue, 27 Jun 2023 11:17:15 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id h4-20020a197004000000b004fae1d35098sm1291622lfc.81.2023.06.27.11.17.14
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 11:17:14 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b69ea3b29fso43174261fa.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 11:17:14 -0700 (PDT)
X-Received: by 2002:a2e:a314:0:b0:2b6:b2bf:ab4d with SMTP id
 l20-20020a2ea314000000b002b6b2bfab4dmr1933019lje.14.1687889834287; Tue, 27
 Jun 2023 11:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <b0bb8387-9216-0fe7-61e9-7e2daceeef20@linuxfoundation.org> <CAHk-=whvD6pq-7vp-cCMEnS+EOp2TmLxFKPS3Nw+Ncqt0XZVGw@mail.gmail.com>
In-Reply-To: <CAHk-=whvD6pq-7vp-cCMEnS+EOp2TmLxFKPS3Nw+Ncqt0XZVGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 11:16:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgB8AOsrje6-bLOt2xHS4MMxnkL=k-Danx17hL=jb3pyQ@mail.gmail.com>
Message-ID: <CAHk-=wgB8AOsrje6-bLOt2xHS4MMxnkL=k-Danx17hL=jb3pyQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 6.5-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 27 Jun 2023 at 11:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 25 Jun 2023 at 08:42, Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> > Please pull the following Kselftest update for Linux 6.5-rc1.
>
> Hmm. I pulled this, but it causes multiple objtool warnings.

Sorry, repliedt op the wrong email. It's the KUnit pull that causes
problems, not the Kselftest one (which is next in my queue)

             Linus
