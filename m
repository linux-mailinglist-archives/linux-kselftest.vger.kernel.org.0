Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3687BF4FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442607AbjJJH4q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 03:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442514AbjJJH4n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 03:56:43 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF891;
        Tue, 10 Oct 2023 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=F3J7/sD9MnoAxBVvtMX9s8ZlPemFuT1rR2twFtWmelo=; b=lwXgjzTcYUgKc9Ar1zv62glWnE
        qG7MR0438bkr0VRcBxMCsnSqZvm9G2p/2z2aVWyd0tf5TUfgj4bhxNa0qI1vP/coZ4Z09HJJwaKaE
        06nORU4TikE/mHz0g02Y4YFmRXn+vImHUcPcQt+fRo7Z9mtuNYF8UnDoergShTF0mKjrwQxrwPcQf
        Xb5s2ASm8kyW66a/tI+zbQjsTVeXfD8o9smrw1Wfb+lzLr7vbNOAckphy+TnGRMo1sB5pO9EF6qJx
        /3jc8MSL0ZLy6dKaFMJv5aEmOWTxMNQynV2IhU537cDIhjq2/yvSDIwfc7m8KyD013gnr8bGewee7
        cz13/8Qw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qq7bR-000Nq6-OI; Tue, 10 Oct 2023 09:56:30 +0200
Received: from [178.197.249.27] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qq7bR-000UjG-Bk; Tue, 10 Oct 2023 09:56:29 +0200
Subject: Re: [PATCH] selftests: bpf: remove unused variables
To:     zhujun2 <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, andrii@kernel.org
References: <20231010070001.10125-1-zhujun2@cmss.chinamobile.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2e4c17ac-9a61-4901-8f98-c783242eec28@iogearbox.net>
Date:   Tue, 10 Oct 2023 09:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20231010070001.10125-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27056/Mon Oct  9 09:40:11 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/10/23 9:00 AM, zhujun2 wrote:
> These variables are never referenced in the code, just remove them.
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/atomic_bounds.c      | 1 -
>   tools/testing/selftests/bpf/prog_tests/kfree_skb.c          | 2 --
>   tools/testing/selftests/bpf/prog_tests/perf_branches.c      | 6 +-----
>   .../testing/selftests/bpf/prog_tests/probe_read_user_str.c  | 4 ++--
>   tools/testing/selftests/bpf/prog_tests/test_overhead.c      | 4 ++--
>   tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c       | 1 -
>   6 files changed, 5 insertions(+), 13 deletions(-)

You did not even try to compile-test it, otherwise you would have noticed that the
build fails after your patches..
