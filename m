Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD355F36F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jun 2022 04:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiF2CmQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jun 2022 22:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiF2CmQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jun 2022 22:42:16 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B3C71FCD9;
        Tue, 28 Jun 2022 19:42:14 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7E9661E80D11;
        Wed, 29 Jun 2022 10:41:05 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KkPVWUOZtBJR; Wed, 29 Jun 2022 10:41:02 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A51DF1E80CDC;
        Wed, 29 Jun 2022 10:41:02 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     skhan@linuxfoundation.org
Cc:     kunyu@nfschina.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] tools: Strong conversion of void type pointer could be removed
Date:   Wed, 29 Jun 2022 10:42:06 +0800
Message-Id: <20220629024207.6523-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <9b587975-db5b-c7bf-eb8f-bd6e5c3d9f54@linuxfoundation.org>
References: <9b587975-db5b-c7bf-eb8f-bd6e5c3d9f54@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hi Shuah, now I can't paste the test code, so I could write a demo and paste it:


-------------source---------------

#include <stdio.h>
#include <stdlib.h>

struct ucontext {
	struct ucontext         *uc_link;
	unsigned long           uc_flags;
	sigset_t                uc_sigmask;
	struct ucontext         *uc_mcontext;
};
typedef struct ucontext ucontext_t;

void sigsegv(void *ctx_void)
{
	ucontext_t *ctx = (ucontext_t*)ctx_void;
	ucontext_t *ctx2 = (int *)ctx_void;
	ucontext_t *ctx3 = ctx_void;
	printf("ctx:%p, ctx2:%p, ctx3:%p.\n", ctx, ctx2, ctx3);
}

int main() {
	ucontext_t *test = malloc(sizeof(ucontext_t));
	sigsegv(test);
	return 0;
}

--------------------------------------

The result is CTX: 0x563D96CE5010, CTX2:0x563D96CE5010, CTx3:0x563D96CE5010.
Now force ucontext_t and int pointers are the same as the addresses obtained without forced conversion.

Now I'll paste the assembly code for them:


|0x700 <sigsegv>         push   %rbp                                                  │
│0x701 <sigsegv+1>       mov    %rsp,%rbp                                             │
│0x704 <sigsegv+4>       sub    $0x30,%rsp                                            │
│0x708 <sigsegv+8>       mov    %rdi,-0x28(%rbp)                                      │
│0x70c <sigsegv+12>      mov    -0x28(%rbp),%rax                                      │
│0x710 <sigsegv+16>      mov    %rax,-0x8(%rbp)                                       │
│0x714 <sigsegv+20>      mov    -0x28(%rbp),%rax                                      │
│0x718 <sigsegv+24>      mov    %rax,-0x10(%rbp)                                      │
│0x71c <sigsegv+28>      mov    -0x28(%rbp),%rax                                      │
│0x720 <sigsegv+32>      mov    %rax,-0x18(%rbp)                                      │
│0x724 <sigsegv+36>      mov    -0x18(%rbp),%rcx                                      │
│0x728 <sigsegv+40>      mov    -0x10(%rbp),%rdx                                      │
│0x72c <sigsegv+44>      mov    -0x8(%rbp),%rax                                       │
│0x730 <sigsegv+48>      mov    %rax,%rsi                                             │
│0x733 <sigsegv+51>      lea    0xba(%rip),%rdi        # 0x7f4                        │
│0x73a <sigsegv+58>      mov    $0x0,%eax                                             │
│0x73f <sigsegv+63>      callq  0x5a0 <printf@plt>                                    │
│0x744 <sigsegv+68>      nop                                                          │
│0x745 <sigsegv+69>      leaveq                                                       │
│0x746 <sigsegv+70>      retq

