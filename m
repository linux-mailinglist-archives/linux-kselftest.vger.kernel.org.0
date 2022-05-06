Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02FF51CE26
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 May 2022 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388056AbiEFBuI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 May 2022 21:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiEFBuH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 May 2022 21:50:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857475DE7C;
        Thu,  5 May 2022 18:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22B736202A;
        Fri,  6 May 2022 01:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFCFC385A8;
        Fri,  6 May 2022 01:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651801585;
        bh=FJVmyrzscKRwOZCVrazEfpY2ik2lmDilP5a1DeRzKd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MTsu0K+dGhH0R/zaYitWP9NJrB/Tn1awsvkYSVb0pjvuoST3dVnYyMqJhUb935aRT
         gSYNaZF2z2ZsNS2fSeQS9Bp11AMtV2kKPbT68ZUBCMJPtA3bvJo1P8mVP+zf5wmNS0
         79EKid4bED/qX+zXfbxCH4rROqxZxHMKHNPgdELbGNZpxz+u+Hix8Esl3IN9gADavD
         7DAhJq7La0HCzO8pxAhPDl7iYPDBa6iHIRCYbv4fdACM/mdkwzGVZqCt7bh/21g+ZV
         6YGlviZsgju3X1v/RripVcFtkS9AK508BdzkWcs3c4o8NuTD0vsXc9TKEVPXmIm64C
         mqetWcNIGPMzw==
Date:   Fri, 6 May 2022 10:46:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/ftrace: Save kprobe_events to test log
Message-Id: <20220506104621.bbeba7d977cdb5d95c3e7d87@kernel.org>
In-Reply-To: <1651753148-1464-2-git-send-email-yangtiezhu@loongson.cn>
References: <1651753148-1464-1-git-send-email-yangtiezhu@loongson.cn>
        <1651753148-1464-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu,  5 May 2022 20:19:07 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> It may lead to kernel panic when execute the following testcase on mips:
> 
>   # ./ftracetest test.d/kprobe/multiple_kprobes.tc
> 
> A preliminary analysis shows that the issue is related with
> 
>   echo 1 > events/kprobes/enable
> 
> after add the 256 probe points.
> 
> In order to find the root cause, I want to verify which probe point has
> problem, so it is necessary to save kprobe_events to test log.
> 
> With this patch, we can get the 256 probe points in the test log through
> the following command:
> 
>   # ./ftracetest test.d/kprobe/multiple_kprobes.tc -vvv -k

This looks good to me. :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> index 312d237..be754f5 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> @@ -25,6 +25,8 @@ if [ $L -ne 256 ]; then
>    exit_fail
>  fi
>  
> +cat kprobe_events >> $testlog
> +
>  echo 1 > events/kprobes/enable
>  echo 0 > events/kprobes/enable
>  echo > kprobe_events
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
