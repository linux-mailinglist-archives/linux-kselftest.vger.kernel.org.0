Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13877621E34
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 22:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKHVF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 16:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHVFz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 16:05:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309AC627E7;
        Tue,  8 Nov 2022 13:05:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C381161795;
        Tue,  8 Nov 2022 21:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAA9C433C1;
        Tue,  8 Nov 2022 21:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667941553;
        bh=LUZD7U4AhhxRA2fi04bqMLOfEOHk1HLyWrG2QaS70Gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RzZaFF3nVYdl06DQIW70UTPyDAgnVC4xQWSxIV7uyPHwNya+iZSsy4QrXkFZHFvUE
         Wn2GbYRt84331jU3MMh3xiDbNqXkxeSD1WeCWcd5+Nvs+C3cPrjIaWv11oxaaKI3v+
         MBVHDQIwkS9JZAeCsRqzTh+7rioHQxlawxxf00Ys=
Date:   Tue, 8 Nov 2022 13:05:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Alban Crequy <alban.crequy@gmail.com>,
        Alban Crequy <albancrequy@microsoft.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] maccess: fix writing offset in case of fault
 in strncpy_from_kernel_nofault()
Message-Id: <20221108130551.85ad67b402582e3855418294@linux-foundation.org>
In-Reply-To: <20221108195211.214025-2-flaniel@linux.microsoft.com>
References: <20221108195211.214025-1-flaniel@linux.microsoft.com>
        <20221108195211.214025-2-flaniel@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue,  8 Nov 2022 20:52:06 +0100 Francis Laniel <flaniel@linux.microsoft.com> wrote:

> From: Alban Crequy <albancrequy@microsoft.com>
> 
> If a page fault occurs while copying the first byte, this function resets one
> byte before dst.
> As a consequence, an address could be modified and leaded to kernel crashes if
> case the modified address was accessed later.
> 
> Signed-off-by: Alban Crequy <albancrequy@microsoft.com>
> Tested-by: Francis Laniel <flaniel@linux.microsoft.com>

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

Please merge via the bpf tree.

This looks potentially nasty.  Fortunately only tracing code uses it,
but I'm thinking it should have cc:stable and a Fixes:?

