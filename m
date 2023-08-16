Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9427477D7DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 03:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbjHPBry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 21:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241130AbjHPBrZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 21:47:25 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB99710D1;
        Tue, 15 Aug 2023 18:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692150439;
        bh=BK6RrXMOHnq0creOrmIb5agZk8D1dC+Yg1U4t9PQcsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GDh/4YMZnxK/Cz3qAcKS2/RF8d4jZOlXI0gYngHX75TVtlFkQkaKvo3wxG1Co4hHZ
         +YcGnN4H1v989A8lz6gBXL1Od5GQ8mymicBZVVNwlqW+KISiQXmKIDe6a4Nj6SYGW5
         g9TFGsT2U6hv4O4Nz7830kBl7EXofkhbVtg3Q3WE=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id BCDB1A5D; Wed, 16 Aug 2023 09:47:13 +0800
X-QQ-mid: xmsmtpt1692150433t9zall2if
Message-ID: <tencent_E3B23E2EC954865F61474B10790C7C84E009@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtJSFYZFoLP8e8CGwpg7mImHiK9fNuvkAhFSbOT7+93QomZINSAF
         +C5r1S270qqBegrcIjOtLUh2+Lyg8dmk40DQ+ElmcxLn1J70681aU2cf8bc40hxyrFq9SoQj4T1K
         FOA54pM7Z4SoJ2CLNI9DRgvxCU+KW2yE3pXN0ARAUS6ILsCZ/MBc9bdCA1LSRgvETqOSNNglTEiL
         niKTumRtUsAwmSwgrgjPssWqJaFMjrwRUk36azP9fRdoDifDSvwGjQtjZiDYMKqcchYb8225V5dt
         OASlFEhwXQQnY2yyPqsXG+1VozjiucSftpQjNRke8i4PKn+mbYgn+9M5OGNlGXkCNDsLXXBEL9TI
         /NHRIyeFgbT2Ujzfevw2qbfWRKzgqnz1p2kQfV5lFqjQPB8tsjpWKteCO9qMYKz9wKx2wrUvGBwh
         HPURcyFR8wHwTrEqp5tpY0I3RNVJmWb8KK669X/4Ce9LA5t0tHZD+6WT18hK01NuP2QVzTPz0vSX
         /j0Ap8nsMA6tsvTHKSvD7L/QzvkmDgSfIGx3E3pXk5aWOsxqvy0J3/l5b2t3MAzAgMAEKOAjiUcS
         +QpgaN10rogbraKqBOnvt7+8P3WsltKWlqQnJYSN37M95yb1kqgyxjhRkbH0GYMydA11kScXQzmB
         UGJkC81IMIZZvs4rqjbaVU4t1OMy2wPO00a/3s1AXotGVMMyqAech04ol0WACjkx8WXChPCgpT7m
         ICeUtfYnKw8RUMzxHIdeQyYhNuwZSWQvE/Ccpns1mnyIgQShoX5yy0daNMQ/gYvZ40UhSySQ5lsS
         59nf43saW6uTBnI8GQVq4PH/xS8a0hc2LSPRm+O75uXWn+5h8loxb3gmqqLyFXLT40L2ruGPAPwH
         JN5hWUCl4i/nYxrJmE5CIojqloJvkQk4iTYxrdPaQnoFKQSz7P8QdAGPLeyldMdJZLw9ksJRcLd2
         DaGYjQfmvjpa5tYwpXbzKC1/yHxkFjKlijgfobogJ9wykFobagM+ic6Dnr4hJMXy1Mq4ifMoHRWN
         quhZiE7wQBVprkgJit
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Rong Tao <rtoax@foxmail.com>
To:     daniel@iogearbox.net
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next v3] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Wed, 16 Aug 2023 09:47:13 +0800
X-OQ-MSGID: <20230816014713.27759-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <d1ad0b4d-574c-15e5-928f-2d9acc30dfe1@iogearbox.net>
References: <d1ad0b4d-574c-15e5-928f-2d9acc30dfe1@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks, Daniel.

I just submit v4[0], make sure most cases we don't need the realloc() path to
begin with, and check strdup() return value.

[0] https://lore.kernel.org/lkml/tencent_59C74613113F0C728524B2A82FE5540A5E09@qq.com/

Rong Tao

