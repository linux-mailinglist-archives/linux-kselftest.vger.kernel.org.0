Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33218614696
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 10:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKAJ0g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKAJ0f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 05:26:35 -0400
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122CC1209B
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667294792;
        bh=Cekqkql9v7On2C1zdmpgOoDkbQP/R/pNGmTtgQ5uif0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GIeehut11us5bmxIvrkJuzS7FbAdKkk8hTuOtrxUdQWz4aTuHPlp2KCGd6QSo2N30
         0j+OFBLsbN9u6KOLyHQZZTUaSg+kqvPpUgv/HrCy4RX21rjtPb6N2Gs2h15+BLKMVw
         28TkQ8r9nRzNd7aN7zsafofj3pG0uYunnGxDz1fw=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 64D19628; Tue, 01 Nov 2022 17:25:13 +0800
X-QQ-mid: xmsmtpt1667294713txcwf9uwb
Message-ID: <tencent_5523542A5E3F46AD119B0C0A8588B27E2E09@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeiek3W8slCJTZFHrgnJETeGs8BX0f9qVDeX7DqIu+xrAEOO5FK82P
         7ujuFcOpLFVn/h844lF1OpEV6TRAFPWm56qRHWGZvccHYRKgN4bIN6UNkJmPt3sxZRmCAV7p2r05
         5wa9g9yPzEEVl0M3/W9cBCN1kHM1e6YeHcvPlW0p+qvLCYiSMPnfhBh2YNL+JIFsnoEDTzVUCRp4
         s5NkeX0kINWQG85UtaaEWuKN9BWtvr2h+EY70pVqb1fmMJVcBfTH19VqwrJLrasr8QuJgVqCUooj
         jXDsD1pCAR7FWtmnDJbCuVjAOHFiQSExFovBCVWz/bH4DazIhBc8j6m2TyuyLbjzHN8Fgof2JE2m
         Y7QCGZdkdrxdm9jxtfn0k7dSd19PEmBFFah/bSzl8kLZiB2jnO4yuovj42IDOk82lNJJx7v/noNQ
         i/XPcJ/FjbHEryveNrdSQb26T07BqDO9jrLPzxN1gxHjN6h+Xm6DEK4XrhRAZm7vyyexFg3NEMBl
         E/Asf5Y3X+FBabSu1w+fCn4ujJbxxy22LJ8n6LCyVI1soid5MHOwxTgSqW1mi+B3+vMJXkhNpa+v
         7quhN2a8jA9Mclhic6gJ2hF6+mgMYSFARW6K1g/5GQ/1jWXjsWvtRONOMa8ZxOW5XKMv3aom1ZH0
         MuYCCnbdbRzoV50TjjSs2TjmRxL4NQ76TJ4YKOk3RIjAr0Xu+y3frSRha943pBN00StDZL6wWpf4
         sNLvJ7O9WjlFoScAJzwjtHJRozOTlq+SjlXPDAmt6REg4uM6osf8uS5e3j3xhKGbHnOoMQQpXF5n
         vNEbWd4XHLGhZDub4atl3NNfmurAP7yOpgMdL6sU0KFf+G8bltk2uL3Z5geyPSghilzIFIM9yjHC
         nV9+r7dYXuBPOWUHrSfqa7hQpvLZ9YoLDiYgpnHM64BnKxzlL9+wARZaU/ElC0wbdI3tTJ0qE6Mc
         k/akOASXEBXDEGk3D2iBiviI8dQXq2txCGa1bgQj0TQi3BDCPqYeUVfn6yS0Ts
From:   Rong Tao <rtoax@foxmail.com>
To:     david.laight@aculab.com
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Subject: Re: RE: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
Date:   Tue,  1 Nov 2022 17:25:12 +0800
X-OQ-MSGID: <20221101092512.33174-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1611fe67d311461aa5f820836318bacc@AcuMS.aculab.com>
References: <1611fe67d311461aa5f820836318bacc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Can we just use the first patch?
https://lore.kernel.org/lkml/tencent_EE3E19F80ACD66955D26A878BC768CFA210A@qq.com/

