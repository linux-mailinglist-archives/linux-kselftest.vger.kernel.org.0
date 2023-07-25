Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2CA76193C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjGYNFw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 09:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGYNFw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 09:05:52 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C750E5C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 06:05:50 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so4727423276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690290349; x=1690895149;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5tJzMlchMGvZ+T9JwV3tPym5EeZdFxlI9guvrrUmmhk=;
        b=jCFQ6Y4bYcEDzy/p6qgLw90rtdZ3Hh30FW2hjrlxQUImuaJ3Y26BClVajbvGVC5aEu
         em4SfOLA8oRLm9cAhXGV13PZnVwZB/Xzk9vBfyG6BiKsLPemx0S5PGa9jEqhJ5lLEpKZ
         Bgkqc0rAYTVXrwV+KOFqM7TqNWZMoT+hkq5y2eChtoxpwGFnwF0h74dfVzzfrM74Alvx
         zNqS+aVvR2eJsv85h8Y1S6sJWlYDfkyONrzU7R2OHOTaFrdp62n5a8gO5h27PuDDm8x6
         BXytROdQsd1QkhdtMEkePC2HhqZmmrWm+VALKrIRGZpg8iyHWxKMVyRuskWl6jU4geS4
         gaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690290349; x=1690895149;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tJzMlchMGvZ+T9JwV3tPym5EeZdFxlI9guvrrUmmhk=;
        b=k53A19MPgRI8cql9LB7cljOyBAjfck4FaleMNXtWzM6zRv0p32Yai53NcjZiD+Bwvx
         wUizMkuPPCi8bEIHfei9PpaLvx2JNcLbdpXLsnPzo8tBljBqwme7eEJIxm2iRvz0E6sG
         GfLFBtch7BiESt9OAOAsoN7sNj8gMpbjHVVHeS5OHIOMibdJhx58eWAK+qI0/OAja7IJ
         dSWYa43Kv1vKZUQzyu96jhjcCyj3nZKkrZBas8Y5HXxiIF93+qLXzdCN1XxPIEjpIOLW
         PRH1uv09Ziskbffgl6/QH42C0Zyi5yJS9bk3cJMv7MxNrbXQ/xdtth+VyOw4kgqkBxV1
         tv4w==
X-Gm-Message-State: ABy/qLaTakRANAWXHa1eB81q/oDaiEgO/A6DGxaCqxtKNOZUW+tiq393
        iKV6a7CYXCurcSE6o21GxrHfLLQHPb4VVLimmjRxaByYy9H/EzSruB8=
X-Google-Smtp-Source: APBJJlHP4Y3P++g+2unMwlOMB60A5WtMws0pr+cPcYoFFKwMaorlYfI3QPWuUf7oTXPSwxNZn3JVr03TK2rithbw4j8=
X-Received: by 2002:a25:7489:0:b0:d10:493:f6e7 with SMTP id
 p131-20020a257489000000b00d100493f6e7mr5172136ybc.24.1690290349182; Tue, 25
 Jul 2023 06:05:49 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jul 2023 18:35:34 +0530
Message-ID: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
Subject: selftests: connector: proc_filter.c:48:20: error: invalid application
 of 'sizeof' to an incomplete type 'struct proc_input'
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Netdev <netdev@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Cc:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests: connector: proc_filter build failed with clang-16 due to below
warnings / errors on Linux next-20230725.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

clang --target=aarch64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-Werror=option-ignored -Werror=unused-command-line-argument
--target=aarch64-linux-gnu -fintegrated-as -Wall     proc_filter.c  -o
/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/connector/proc_filter
proc_filter.c:42:12: error: invalid application of 'sizeof' to an
incomplete type 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^~~~~~~~~~~~~~~
proc_filter.c:22:5: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                         ^     ~~~~~~~~~~~~~~~~~~~
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:48:20: error: invalid application of 'sizeof' to an
incomplete type 'struct proc_input'
                hdr->nlmsg_len = NL_MESSAGE_SIZE;
                                 ^~~~~~~~~~~~~~~
proc_filter.c:22:5: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                         ^     ~~~~~~~~~~~~~~~~~~~
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:64:14: error: invalid application of 'sizeof' to an
incomplete type 'struct proc_input'
                msg->len = sizeof(struct proc_input);
                           ^     ~~~~~~~~~~~~~~~~~~~
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:65:35: error: incomplete definition of type 'struct proc_input'
                ((struct proc_input *)msg->data)->mcast_op =
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:66:31: error: incomplete definition of type 'struct proc_input'
                        ((struct proc_input *)pinp)->mcast_op;
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:67:35: error: incomplete definition of type 'struct proc_input'
                ((struct proc_input *)msg->data)->event_type =
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:68:31: error: incomplete definition of type 'struct proc_input'
                        ((struct proc_input *)pinp)->event_type;
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:245:20: error: variable has incomplete type 'struct proc_input'
        struct proc_input input;
                          ^
proc_filter.c:245:9: note: forward declaration of 'struct proc_input'
        struct proc_input input;
               ^
proc_filter.c:264:22: error: use of undeclared identifier
'PROC_EVENT_NONZERO_EXIT'
                input.event_type = PROC_EVENT_NONZERO_EXIT;
                                   ^
9 errors generated.
make[4]: Leaving directory '/builds/linux/tools/testing/selftests/connector'



Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMBLYJCp4OXDmWl/

steps to reproduce:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMBLYJCp4OXDmWl/tuxmake_reproducer.sh
--
Linaro LKFT
https://lkft.linaro.org
