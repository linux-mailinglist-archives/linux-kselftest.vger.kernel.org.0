Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67077DAD65
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Oct 2023 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjJ2RHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Oct 2023 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjJ2RHJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Oct 2023 13:07:09 -0400
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1D2BF;
        Sun, 29 Oct 2023 10:07:02 -0700 (PDT)
Message-ID: <60109bfb-1850-4b5b-87fd-c47a1e41bc2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698599220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSJtfAzcywTSN0h2+pbhBByrfU8Kesmbq2MGXuuxqmA=;
        b=QqvrHR6EfAO/l9ZobJKx78tUZG0j7a7hKp+5+RNA08JP8g4KGQDF1MaIf8MELXrrjBQK00
        PGkc0Uqw4f1t+v3eafFpPIuKOoNbuiecRfjrHt9PZCxX7MDEQsWbmucFMh5fiGSoFuZIbc
        1slJiryqwRKrPyNbZKd+7olkwCkyu8E=
Date:   Sun, 29 Oct 2023 10:06:46 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Convert CHECK macros to
 ASSERT_* macros in bpf_iter
Content-Language: en-GB
To:     Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc:     sinquersw@gmail.com, ast@kernel.org, brauner@kernel.org,
        daniel@iogearbox.net, haoluo@google.com, iii@linux.ibm.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        kuifeng@meta.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mykolal@fb.com, sdf@google.com,
        shuah@kernel.org, song@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <cover.1698461732.git.yuran.pereira@hotmail.com>
 <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/27/23 10:24 PM, Yuran Pereira wrote:
> As it was pointed out by Yonghong Song [1], in the bpf selftests the use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
> This patch replaces all CHECK calls in bpf_iter with the appropriate
> ASSERT_* macros.
>
> [1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev
>
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

