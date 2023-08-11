Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04C977846F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 02:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHKABj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 20:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKABi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 20:01:38 -0400
X-Greylist: delayed 428 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 17:01:37 PDT
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7C2D4F;
        Thu, 10 Aug 2023 17:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1691712095;
        bh=Dw7XtY4SevyEQWP/R3km8lwVfji8O5oF8nQ61Ju8lII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fPgoqTGhW84AbF8oFHVhFBR65ge9CkjUUxSCPgTQngOz1jIdCsPxVRb/bfxxNicLr
         08qMFDqTZFVMtKrHilrO05kM76G4vjeC4vP7EM7M6088MKk5PamdJDrcuGWm7qVONn
         AnXKwP9r0F05LjceNc3Spq3KeeMXotBDLtl4RVW0=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 5C93239; Fri, 11 Aug 2023 08:01:28 +0800
X-QQ-mid: xmsmtpt1691712088tsfdmiii9
Message-ID: <tencent_9C20DA1AB80A0564315EF2A91CBF7A8C260A@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS7ayxzI94vsOZqKVqzudryzUCgm2P/WZtV5OQZSk4thPDk4eEea
         aOAs2ToOp0ryzFXZFmC5//FrsUCvlph1kCqtBy17GTWj5v06gIDvPYoQPUAm3eXXgwY+8YZcn7wH
         nZ5Bv033LLS2gs6ZbFTeZOMZbGPBooqpR1kVEX8oUbEGLAQqFDyrVgCdphpUsnGtDFCjH1G9RKYd
         JQIYkqSvxZPkF0QUpRYPQjsJTW+WESgkevpos0ZrUv1JE2pBY+LufkvpE7iDJRFLh+uslBk1H+Xc
         vM3p+r4h/oz9x+mDl2UcnjveZnz//TyMkAx2s9tuECDg0I9xxr8htuMrnBWBvG2itJOIgU1nNx5a
         ihlL0pc2XKwPjmHyOj8rHX3E2rNLbpYYhoceF94vtR8XaoY+At/u1fQEV3OiykDtZg7ZBTXeLbWN
         SCHBBCDoBTct28+Eq4HrXH9o1hVl8h5MGy7NSzZcuv6q5RwdpeQ0uWHW/AIcuCw9Tto+w/lrlu+b
         EadIcOJW7lATigJ8z7ITNUkSQeWtiuYTXmgkOXXW9+gajSAwIUdIfiavia2zLSCJQE2eadhn+tG0
         Pbzy5+KuLpcV1MCGF1GOxkHvf0YwUUtY5caEQpeHrupbrQBPm6GQAOTzNppjpGQSBH/WaDyNopv4
         OaFd1ALlwVZhbbuaSXRa/4/TYldXvISgNPCvc4OgWUx2e0/rR6wh7w0cOHYxNP9HdKrfTXjphFH7
         psBmTEBCjRRMO4RxHMeZ+5CKTkwmVhO65hHeSuAutrUujDm73PERC3mmza6exk2f/z9rt4v4EKIr
         T2K8MkaXdR1hX1ezbY8mT34Sazzt0qGeXOL7xj5DU7iRQepKbj+BahIhiHvrzItdlrqY9NYvnqkG
         CvPQCxjmB6TOSOp09g5b7xGoNFeB3PQuQr7p+pGjdx6elLQW7QCaEwTN0B37dkjt/i+ZWex7/RdC
         FvUpfn5YT7dHIdykWUVks76hC5OA2M4AnIJDLTxXWrMmfNYz7KOA+QtVZDcRaQ
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Rong Tao <rtoax@foxmail.com>
To:     sdf@google.com
Cc:     alexandre.torgue@foss.st.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, chantr4@gmail.com, daniel@iogearbox.net,
        deso@posteo.net, eddyz87@gmail.com, haoluo@google.com,
        iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, martin.lau@linux.dev,
        mcoquelin.stm32@gmail.com, mykolal@fb.com, rongtao@cestc.cn,
        rostedt@goodmis.org, rtoax@foxmail.com, shuah@kernel.org,
        song@kernel.org, xukuohai@huawei.com, yonghong.song@linux.dev,
        zwisler@google.com
Subject: Re: [PATCH bpf-next] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Fri, 11 Aug 2023 08:01:28 +0800
X-OQ-MSGID: <20230811000128.298569-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZNUnxJ26/4QfvoC+@google.com>
References: <ZNUnxJ26/4QfvoC+@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for your advise, you are right, i just submit v2 [0].

I just found that, because of the modified patch, your email address was not
obtained through scripts/get_maintainer.pl, so the v2 [0] email was not sent
to you, sorry.

Rong Tao,
Good day.

[0] v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/

