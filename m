Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004E87D02E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjJST6e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJST6d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 15:58:33 -0400
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 12:58:31 PDT
Received: from out-209.mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009ECCA
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 12:58:31 -0700 (PDT)
Message-ID: <16e8546f-9da6-8bac-ad9e-5d38918d0783@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697745069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2J4Oasusyhp2LFkadlAimpdKLPnFnJeRghNdrohws88=;
        b=CqTNJDoo/g34rriKps/fD8ErECUtOj6Xrq/jQDMyhCrYa72Hpi8zKa3WL4MScM4/G9Y1Sj
        HF4kGzlskoVdmhUkgBBWm2kfHDLtdouadrDyGZfB7GdQ0DH+GGDQpCkGlMCFtJnLUh38+I
        onKyOcWJRp2MHnxp2VPK/5+082OseQo=
Date:   Thu, 19 Oct 2023 12:51:02 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v7 11/11] selftests/bpf/sockopt: Add io_uring support
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, io-uring@vger.kernel.org,
        =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, sdf@google.com, axboe@kernel.dk,
        asml.silence@gmail.com, willemdebruijn.kernel@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, krisman@suse.de,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>
References: <20231016134750.1381153-1-leitao@debian.org>
 <20231016134750.1381153-12-leitao@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231016134750.1381153-12-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/23 6:47 AM, Breno Leitao wrote:
> Expand the sockopt test to use also check for io_uring {g,s}etsockopt
> commands operations.
> 
> This patch starts by marking each test if they support io_uring support
> or not.
> 
> Right now, io_uring cmd getsockopt() has a limitation of only
> accepting level == SOL_SOCKET, otherwise it returns -EOPNOTSUPP. Since
> there aren't any test exercising getsockopt(level == SOL_SOCKET), this
> patch changes two tests to use level == SOL_SOCKET, they are
> "getsockopt: support smaller ctx->optlen" and "getsockopt: read
> ctx->optlen".
> There is no limitation for the setsockopt() part.
> 
> Later, each test runs using regular {g,s}etsockopt systemcalls, and, if
> liburing is supported, execute the same test (again), but calling
> liburing {g,s}setsockopt commands.
> 
> This patch also changes the level of two tests to use SOL_SOCKET for the
> following two tests. This is going to help to exercise the io_uring
> subsystem:
>   * getsockopt: read ctx->optlen
>   * getsockopt: support smaller ctx->optlen

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

