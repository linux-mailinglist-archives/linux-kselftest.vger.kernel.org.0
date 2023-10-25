Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5C7D60DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 06:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjJYE1i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 00:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYE1h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 00:27:37 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [IPv6:2001:41d0:1004:224b::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC800128
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Oct 2023 21:27:32 -0700 (PDT)
Message-ID: <3531360b-c933-4c5f-a84c-17edf0592519@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698207262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVWBTARo8cq+R3Ng5Lcm32h8xYKlBt6CDeCwOgGSDiQ=;
        b=LODpajge9ggoDbuMX3fUqAvjStmmmQ/q9caGfL7kPHwrIBrYpabp0pMr+NYCG7H441jpr6
        feAIqOOptuRqSEYyNa/W/0uqT+PW5c0vaSU/Q++8yNq2KU3FBSgtbeSy8TNAuNlSrUpvmb
        pgnm/G1gNQiasISboLW4qxRhil0G6Fc=
Date:   Tue, 24 Oct 2023 21:14:13 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Convert CHECK macros to ASSERT_*
 macros in bpf_iter
Content-Language: en-GB
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        brauner@kernel.org, iii@linux.ibm.com, kuifeng@meta.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
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


On 10/24/23 3:43 PM, Yuran Pereira wrote:
> As it was pointed out by Yonghong Song [1], in the bpf selftests the use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
> This patch replaces all CHECK calls in bpf_iter with the appropriate
> ASSERT_* macros.
>
> [1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev
>
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 80 +++++++++----------
>   1 file changed, 39 insertions(+), 41 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 1f02168103dd..526ac4e741ee 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -64,7 +64,7 @@ static void do_dummy_read_opts(struct bpf_program *prog, struct bpf_iter_attach_
>   	/* not check contents, but ensure read() ends without error */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
> +	ASSERT_GE(len, 0, "read");
>   
>   	close(iter_fd);


After converting CHECK to ASSERT_*, 'static int duration' is not needed any more. Otherwise,
you will hit the following compilation error with latest clang:

/home/yhs/work/bpf-next/tools/testing/selftests/bpf/prog_tests/bpf_iter.c:37:12: error: unused variable 'duration' [-Werror,-Wunused-variable]
    37 | static int duration;
       |            ^~~~~~~~
1 error generated.

Please remove 'static int duration'.

>   
> [...]
