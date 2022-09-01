Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F05A8EF2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiIAG7j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 02:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiIAG7g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 02:59:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBEF122058
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 23:59:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso1586821pjk.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SVF6PLCQYqQfDJ1mbN1yYxWEY7a8snySanblxKa0G2g=;
        b=EQ/HtONlIP3lRAqKj+jLTa8iFP06eGdSTaZLe5lHLgIDfq9K7upKcsMHo7HNyzsSkF
         0ZLJjdRLAFIchTJ6/V08SQ7BFOgs+yr6wqZgVTTZbPc60qYf6bUBktAdTV0xCmLO8+rb
         TYtDclkULIsMF+oVCmKnFv6cIQg8YhK8pUZys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SVF6PLCQYqQfDJ1mbN1yYxWEY7a8snySanblxKa0G2g=;
        b=A1/A3MdBag12A2CumXRSd6rTWr19X8v2GkPcSDIiLPEBHlczLWIysSR555iOORhXDf
         y3rnYvcKLdjuVFO0ncoT9sL/bYRjXyWvL1LL4H+cZae9uvWQLK4mwF/W98O28C0A2MpM
         FoXVa6f59vixAQ52kXPFjQgNjS30NZe71mAz66yt8KKYqxmm6TmXspP+hTy52oZueywi
         4lkjCe4rppOU6gG3vQHncJORdL+vEsE7hePJcdtzrQZOgUFmCGzsDFwQeZy2AYuOgnIa
         Pv8WFIRTYM0Uarm6JfK6BGUUDyCXgIVVxl6gyYCumbA9FMnOY4ZcU/Wje41ZUup1rL1C
         vLAg==
X-Gm-Message-State: ACgBeo3jGjID0LI5qUHdA8YI5MrX0gesSbRVA3V4YPcHzj/dHpbjJg26
        KbCRVNdOzhCBRfqivXHkSYGY6g==
X-Google-Smtp-Source: AA6agR5ZHgeSnW5XK+mgnShl1BdOSPwjqbKb94qG4dgHKo3KiQskBMRdrJtDtsttOZ30SOZ9HrF0LA==
X-Received: by 2002:a17:90b:1b0d:b0:1fe:3993:2a82 with SMTP id nu13-20020a17090b1b0d00b001fe39932a82mr5096208pjb.155.1662015559648;
        Wed, 31 Aug 2022 23:59:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d65-20020a623644000000b0052d40c4c06esm12497770pfa.39.2022.08.31.23.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:59:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 0/2] fortify: Add run-time WARN for cross-field memcpy()
Date:   Wed, 31 Aug 2022 23:59:12 -0700
Message-Id: <20220901065914.1417829-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=713; h=from:subject; bh=LeTil4IEruxaVe7mWfrPpEi0Vfjy7lWn1LjQi8mvjkw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEFhCZb05sz6D+GQp3RqFe9s96Vb19uXf8nu3+B/3 K+EZyvaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxBYQgAKCRCJcvTf3G3AJi02D/ 9A5CVWpB/R+rtBo9Hz69xc6KVgu9rGAbBRmVMjtYWVn4jtOxiPSLL8QvW0t+F8vkIgPS+RUnSfjZ/0 hAU1oLluzNcqNPSj+L+o3ZE3lT5Xiyqcr8goXd36TwOHZWUaEmUTsNqpOyacfC2URgDVGGv3f81HXC m5U4bxfDPCb5BT8oEEhXs+EnMqs5M71OKC4aVhtwv9NPX9Ah4fm2tSgVrp56GMEu+7maQGY0qwBxhB dW7MjQ4glVMJHiL+cIr1k4cv8G6rbH5Gim5R1TBsLDoalZws0NMeanliOh2uEJVju/0SPCvE/48Opw t/00snJqhXKOz5vO1+BvO58eGBDmkPVMKt9wNfagz81UM8FIZ00SJJdt4bHPvKyFFBJF4MbBUOLZTI cjc9glqVRIUaXO3FKCtPshmj8y8mIyieEWgi6QjZfK71EmSGyLVJK98BR5QnRZL08xI+iVEy0oqVSV HwoOnj8kFFns7arwq/q0lqlZhNBcVyS0WEI/gJ89LxMimKXuzoPesmuYtiHxx2HhJH+k2TRQpQpLE3 LbkkMEsGVvNwFnbEAFH/vrV+nAv7gFgoI/ncQT3bBwBjeZRSG12fXhXZrpT+j66OTFoxqr5kh09A1F 4ckTG6O2Wm6QL3oG/QSk+zkNQMRReyyLNpOsiB4/UEAF9Bmss0e2PtJ6+GBQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

I'm hoping to at least get this into -next to see how noisy it ends up
being. I've tracked down several false positives that are getting fixed,
but I'd like to see this get wider testing. For details, see patch 1,
but this is the run-time half of the recent FORTIFY_SOURCE memcpy()
bounds checking work.

-Kees

Kees Cook (2):
  fortify: Add run-time WARN for cross-field memcpy()
  lkdtm: Update tests for memcpy() run-time warnings

 drivers/misc/lkdtm/fortify.c            | 96 +++++++++++++++++++++----
 include/linux/fortify-string.h          | 70 +++++++++++++++++-
 tools/testing/selftests/lkdtm/tests.txt |  8 ++-
 3 files changed, 155 insertions(+), 19 deletions(-)

-- 
2.34.1

