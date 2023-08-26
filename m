Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCFF78978E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Aug 2023 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjHZOwT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Aug 2023 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHZOwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Aug 2023 10:52:09 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B321092;
        Sat, 26 Aug 2023 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693061525;
        bh=LtEsY7G+HK6wC6cDd51WmwCpbEwB5LJYRhRultDraXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZoqA5hxnBz77pf2NzrOBYwGlEBrQQqOBcA9IAeYgrd1xPljipgdvueKVPcY22rOKx
         MnidC5whHhAKGmRiGYWs+WWUO8N1EaIOvBkHO4WaD9LbPP8DE4dkz15JDuW3i/WogH
         88vuDTJa7WOEfiWZGwh7dBcMtQDpXyJQch2cfH30=
Received: from rtoax.. ([124.126.138.8])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id D0123010; Sat, 26 Aug 2023 22:52:01 +0800
X-QQ-mid: xmsmtpt1693061521tq4y0dkrs
Message-ID: <tencent_9E8059C821CBE9125DC5F57561341511CA05@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneoU5mjlQNfywpteIHCsz+H4gc1J+Wc0I9Zuq9s6SanHKiKp3SDD
         j9AG4ti5TbJJ5DKCsdnK1O869f1/ut3KmA6b8vWYs6Ni6d+Zx9gjrAkbjl4F4LF5JcohoBTLgwcX
         lJ+giyB6CDTdKsQSSiuFWjISt9zZMdzNDf3t8dqeo5fExvnauPGtDbSOwZVao0i7j3kOCNQTyGj4
         JKCFl4aN044txp3GCbejq0rNmIK2InrLzKVa0ErN60lpba2+hZtNmqx51uGyvb9ju3Efq0pXQBCT
         jTze/lsDTtaGzxuwoxeCko7DjXPxMYKfRsRLa+6avUMvtl26EbitNhP7RiIUgnKr5A2rmfWqYsOl
         W3WAkn5eE1VU+HtPiDrLPpWEyoL6Iw2F1vbZu+alhDDV5JNwZW75HLkhG+6lTTZtxMME4rPqTwls
         IMV4Uhz9IgMfWK8KQadHppOYIzl1wQJ9ucV9OkDxE4Bv9BRPx+dI/sXiWMgBhoAz+UsVMW/BlhbL
         lTNCUTiaRM9qUdP2mqbh6uRdSjKEUFWG5K9iIOguDB5j3vzI5JeKk6mLHj2oywWPq2nxR6e+rmbS
         bXkljS0w4JT2nQzIJ34jSZ9R/vQkt5bO6ttXkGKrEl8QrO+jGLmdTqoJruVexqK6ArZYLdeICSpH
         ydD3jLCpwiy7sOC/DDwaId83Afy7f/VM6EwzZI/nmb/tLpCtZWCifpb/TRtZ8BltiguICoGaY6Ws
         5QKbX9aNl3lTOtlaqIbJdlqKPM0KQYkqmtKXT/20uS4dM6JFPqheDwAIj2FmE7tg7MbHn1LjyJ4b
         Iiow55fAFN6nsJVPWgQ2jFPVBKoMm8bo8jKxYVOWdww0PQEQVLMUBCbgPBUMkHuEKsBGY5wtDJVD
         vfRCqZmJHeHaactVtKMzgZT3GQpnpWq6LatKzHts+WK9PRPuMVPniZxVs4QsoOXN4d4oa6i7ISIW
         qMXqzGFvovJBYesm0ZJlbjHK/F3FPrCkX1zLY+cClZdZBSO4UlJuWjHmM50SDoAK261XQ/m5kzFN
         bq67q1KqIOIOPjCuXPVBbwZqjL05c=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From:   Rong Tao <rtoax@foxmail.com>
To:     olsajiri@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v7] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Sat, 26 Aug 2023 22:52:00 +0800
X-OQ-MSGID: <20230826145200.117062-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZOjUpt16gcTSGkdl@krava>
References: <ZOjUpt16gcTSGkdl@krava>
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

> perhaps we could fix that with 2 sets of functions:
> 
>   - load_kallsyms
>     ksym_search
>     ksym_get_addr
> 
>     that work like now on global syms pointer, perhaps we should
>     initialize it before we run tests or use mutex for init
> 
>   - struct ksym *load_kallsyms_local()
>     ksym_search_local(struct ksym *syms, ...)
>     ksym_get_addr_local(struct ksym *syms, ...)
> 
>     that work on local ksyms cache and the test frees it at the end,
>     it would be used in all tests that need updated kallsyms data and
>     use load_kallsyms_refresh for that

Hi, jirka

How about keeping only one type of interface to avoid confusion about use
and mutex locks. Like:

	struct ksyms *load_kallsyms(void);
	struct ksyms *load_kallsyms_refresh(struct ksyms *ksyms);
	void free_kallsyms(struct ksyms *ksyms);

	struct ksym *ksym_search(struct ksyms *ksyms, long key);
	long ksym_get_addr(struct ksyms *ksyms, const char *name);

I just submit v8 [0], please review.

[0] https://lore.kernel.org/lkml/tencent_6D23FE187408D965E95DFAA858BC7E8C760A@qq.com/

