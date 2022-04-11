Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91CC4FB332
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 07:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiDKF0C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 01:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiDKF0C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 01:26:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6202BEA;
        Sun, 10 Apr 2022 22:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F2CAB81012;
        Mon, 11 Apr 2022 05:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461A1C385AA;
        Mon, 11 Apr 2022 05:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649654627;
        bh=pr8LIFJBfDlqZSzs9FKX/Dtrgbkn8j+k3ZzoXqE0LYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AKNv/FAZI2pxE8kfTlRdtPCqWq2k6vuOhhuejKmCBjFKRKoVlFHaNq6FtWHAnuCjI
         SYacYGRf6rq3GUGtNxQWJI7LNoylgDwM7qpMfT2V+fx338GeYY1uMEW5tVNjVFB8QM
         26WYvsYczABHGlwLzETV+VB+7XR/FeMVzIDhPpPBjXFHc5lkXO62y9slO2pAnNHIY8
         ouTPeMpqLwEZP2QOSeg5fYpyfw93+oIgVmvYTcoToMkopJgXmiv8Swu4ZwUJZDFD2s
         uryl4ho4BKuvYmhIfugFZXIRvgxoUInX6rufiK7pxZBFRerdYolJy3mzsFG4xduwkD
         29Zcl1lpbAsFQ==
Received: by mail-yb1-f172.google.com with SMTP id x200so1776437ybe.13;
        Sun, 10 Apr 2022 22:23:47 -0700 (PDT)
X-Gm-Message-State: AOAM530A8fW6C4lb8mK+VgSuDE7YMuPoDpvo5TEZPAcmLL2lAI7oU5ye
        pXflNlHnu5FLTFwqNNtAeaJQn5iuBQU+N9/Z/94=
X-Google-Smtp-Source: ABdhPJw5k4m9H6BUc33aufBVsM8nqwXnL8QCyXdT2rkfjgV68RRIr8Q4GPuAqwH8ZfG5LFo2IjDQoyLAOaaASNob7QE=
X-Received: by 2002:a25:8b81:0:b0:629:17d5:68c1 with SMTP id
 j1-20020a258b81000000b0062917d568c1mr19947812ybl.449.1649654626376; Sun, 10
 Apr 2022 22:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649462033.git.geliang.tang@suse.com> <1ae276da9925c2de59b5bdc93b693b4c243e692e.1649462033.git.geliang.tang@suse.com>
In-Reply-To: <1ae276da9925c2de59b5bdc93b693b4c243e692e.1649462033.git.geliang.tang@suse.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 10 Apr 2022 22:23:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7iQhJUyEUW_OKzo+_-DN=1EbrGawSigbJjGvihP-wX=w@mail.gmail.com>
Message-ID: <CAPhsuW7iQhJUyEUW_OKzo+_-DN=1EbrGawSigbJjGvihP-wX=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selftests: bpf: drop duplicate max/min definitions
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 8, 2022 at 4:58 PM Geliang Tang <geliang.tang@suse.com> wrote:
>
> Drop duplicate macros min() and MAX() definitions in prog_tests, use MIN()
> or MAX() in sys/param.h instead.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Acked-by: Song Liu <songliubraving@fb.com>
