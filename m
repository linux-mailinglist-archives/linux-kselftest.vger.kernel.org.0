Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8938573DC0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 12:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFZKLV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 06:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFZKLU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 06:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E668122;
        Mon, 26 Jun 2023 03:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157D560DCE;
        Mon, 26 Jun 2023 10:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209DCC433C0;
        Mon, 26 Jun 2023 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687774277;
        bh=4YHpkBG4aA7i8xH4eshQAQ4K0/sv3v75SdKGjPD5YWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S33wlwGpZhRxup9sYTndZS+gQIg/YMmwCJ5ywIAAr0v7i/3XU8hvh3ft+G6IAKG+v
         NmVDStCVHrg9zsheT6044AT0nqGUPBU8DxpVrQV7jVfOdKS1kP14Sf4Lcda4Scy1v5
         0xBcWDjQybSFycxMRPBUv0jO2hZb77QGY8cT9Xf5YqIT6qHhnts4J7arrUc6wDFKYF
         72ZDCnTQs+dDdor1MKacc6IzNHsAYzimBWMTz74a2WoApq9hAZHPq2D4i6ilsW0Img
         9kLtmVSir+pNsRd0zi2Ad0YxqGsGc/2SQ/WHzHZY6+HWRZ+p4USmGYp/ktEdoNMOAl
         kngCNkLWRQvRw==
Date:   Mon, 26 Jun 2023 19:11:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <rostedt@goodmis.org>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc
Message-Id: <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
In-Reply-To: <20230626001144.2635956-1-zhengyejian1@huawei.com>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 26 Jun 2023 08:11:44 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Function instance_set() expects to enable event 'sched_switch', so we
> should set 1 to its 'enable' file.
> 
> Testcase passed after this patch:
>   # ./ftracetest test.d/instances/instance-event.tc
>   === Ftrace unit tests ===
>   [1] Test creation and deletion of trace instances while setting an event
>   [PASS]
> 
>   # of passed:  1
>   # of failed:  0
>   # of unresolved:  0
>   # of untested:  0
>   # of unsupported:  0
>   # of xfailed:  0
>   # of undefined(test bug):  0
> 

Good catch!

Fixes: 91e6f1ce8657 ("ftracetest: Add instance created, delete, read and enable event test")

It seems this tests internally broken but the result is same because this disabled
error checking ('set +e').


> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  .../testing/selftests/ftrace/test.d/instances/instance-event.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> index 0eb47fbb3f44..42422e425107 100644
> --- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> +++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> @@ -39,7 +39,7 @@ instance_read() {
>  
>  instance_set() {
>          while :; do
> -                echo 1 > foo/events/sched/sched_switch
> +                echo 1 > foo/events/sched/sched_switch/enable
>          done 2> /dev/null
>  }
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
