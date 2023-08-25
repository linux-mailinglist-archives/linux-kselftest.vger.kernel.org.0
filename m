Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9B78852F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjHYKqn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 06:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbjHYKqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 06:46:21 -0400
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606BE54;
        Fri, 25 Aug 2023 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692960375;
        bh=O9VbDsjRgMANqFTThKdY7QAEcZNVKzTA4JvoFBBWP1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gHZaaYa5GLhnGYv9QzSeLBCqj94JsQrdoUW5G8diCo1+JnH5FSN4eJK+VtOh8Dje1
         DSv2phOd87m4pC0cefJuNTgtzaZz+ByeXou7fw68gVzH1HNxL0Nk09i6PxQ8CD/I4k
         ygPxq/281FVK6SN487J6m8+o8txXgCiDRevVywvI=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id A05B86B3; Fri, 25 Aug 2023 18:40:05 +0800
X-QQ-mid: xmsmtpt1692960005tpqavecy8
Message-ID: <tencent_FD258319A1DF2CCECB7095A3D7A65102C407@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjkQVDc0WwmzqTIzVTk/scWCjrbKeXJ1AV9BrNOG8a6qEUx5tUjx
         FFbptZExJKxkgtxwDBKvW1frZb9+5kFZCttqSkhnJd7/HFbYcst5HPeKtnstNVhCgEo0uA9r7sUC
         ygpepn9z5fUcDs3yJPp7tv3934JQRvU46c0Gaq09P1TR2w3X4/bOvajh5eqQD+ZdLfRA2+BId7FQ
         Zm4roydqdSqgmLq6W76OQ6mNp/MABWCZn64vNGxpckRQwc66mOLSfOf2nz2oqc7E3BjzEfvEH1fJ
         rqzKZKtK1R3KnGaDQSQnoGJGiT/q2vjjcNRlbq9xa+/iJex6ObUt9o4Z7L1X1wr5s+H71dWOGzwY
         9+lttY7g6hVkMgf02OLeMhPbifZZCx75IxtxIwQ9e5nkKzZ3rpqwXgCIyK03fZxcmk42omzQo/zG
         g6/CNGIO8cTytsG3Pk4nEUMq/DoHzs8Z+VXQXbQch4A5/VGoNcbwRW77vnbJyvF5XrVHQGbVk+fX
         Gtm83XV7s3dzPhuUos/QbHqmDFEsojRprLVczuAM/hg68yV01qnUmigjHDgOkppAcPq6MjD5Q39b
         81DASjz3Fr3IlbVna8RIKr2Wrldw7iW8ZHNlP7QwyqQ5yiHA9jU8ZpNOXR2Q4X6SrLn/nfpHuKiF
         lcfUgq9eBx+8Y4rZ2jDk/seI1QzLKtpwi8uoA48V+mFHL+Vg15EWesDm6v+UBm6lJRLUXC2R7wCj
         2Gn1+XUY2g5Rebt733F/A6Z4ltHxiQ4SkJjjeuICpMFfMIE4A7/seAeWPJE19uDunLI4yHqS9wXe
         SD3QnqnHIf0yP8aSrPo4QJu3zSTlZ7MsZx24CTamQqNKjuW/3zV8KD3rAW6QbrXOu8iM+0SSZIA0
         yREpg3pp2CivzvIsKqQxFjUHAkRnGXoBzYFpJtIMgLgYNv0J2TPpkuuO1Xqt/xp+P21zk+Iox9ni
         6ChRcxp9VSba5FcQRHIe6MfPKvyQIXGljDGEurbiA26dY9yqBgs4gRzOHeZQu9Qh0nmo9q6wgpn0
         vj0uRaxj4O+0+NcjiM
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Rong Tao <rtoax@foxmail.com>
To:     olsajiri@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Fri, 25 Aug 2023 18:40:04 +0800
X-OQ-MSGID: <20230825104004.34674-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZOhvhnUTxtD6YYzl@krava>
References: <ZOhvhnUTxtD6YYzl@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks a lot, jirka. I just submit v7 [0], please review.

Rong Tao.

[0] https://lore.kernel.org/lkml/tencent_BD6E19C00BF565CD5C36A9A0BD828CFA210A@qq.com/

