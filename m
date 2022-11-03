Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081476180C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 16:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKCPMb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiKCPMK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 11:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458B1C412
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 08:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ECBB61F1C
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 15:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85532C433B5
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 15:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667488296;
        bh=bniCAy1g4sGfzDEIIDctFfu6afFtYgYFG63GSJYI7jg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ty4jSO6dweprRzTPGJGxewMFwuRFrzzxyf0w2uw/EMl7Z9ZEwfoJ7nRMDnHEg2Fcq
         oW6B/0YLc4uyqCRZHBrOFPyJ3eW8+FbWl6k8spucu2sZUKAjI5TcfQcsReqe3yH/1y
         D18v0+HDoazgmy4eFWCKE2o0/9DXX+a2p2FKtJSHwSSnQqpOa0+ReYEuwPbI+vTwDD
         1JmmZp6LzKF3Ju90/yxdVtJZ8T8cR6RlUHTrMwiujtDNLlwe5npjvD/7+DK6FJ2a7k
         g17RqZ24v+rY6E+AU76z3RMXv/fGyBH9ENTu/uS+4twJ8/vVpc27nj8Tidf5RBv+jD
         fmWrjIJY6xzlA==
Received: by mail-ej1-f52.google.com with SMTP id n12so6022628eja.11
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 08:11:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf2cJ8B/5JMqPkLw+is5pQ/DIj3XoW487x1EK2NjBQf6iq/kQsnn
        ftEkt4oBbGZ0puV9LuL+tek+k5/c8OwLkhlXzSwRNw==
X-Google-Smtp-Source: AMsMyM4jINPb7umoaCKz8QypKSvBgLTh17Ae+KPTbRb/nAdAKOwn5WPfjW+jlk9lO3Lkc4w8ci1HePaoAiinWI+o8WY=
X-Received: by 2002:a05:6512:36c3:b0:4a4:7627:c57 with SMTP id
 e3-20020a05651236c300b004a476270c57mr12204530lfs.398.1667488284062; Thu, 03
 Nov 2022 08:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165423.386151-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221028165423.386151-1-roberto.sassu@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 3 Nov 2022 16:11:13 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5nwsdaG57HHkNubPptkB=_Mz68TVzmX8+Tg=ZFjMX3pw@mail.gmail.com>
Message-ID: <CACYkzJ5nwsdaG57HHkNubPptkB=_Mz68TVzmX8+Tg=ZFjMX3pw@mail.gmail.com>
Subject: Re: [RESEND][RFC][PATCH 1/3] lsm: Clarify documentation of
 vm_enough_memory hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, revest@chromium.org,
        jackmanb@chromium.org, shuah@kernel.org, paul@paul-moore.com,
        casey@schaufler-ca.com, zohar@linux.ibm.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.bouchinet@clip-os.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 28, 2022 at 6:55 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> include/linux/lsm_hooks.h reports the result of the LSM infrastructure to
> the callers, not what LSMs should return to the LSM infrastructure.
>
> Clarify that and add that returning 1 from the LSMs means calling
> __vm_enough_memory() with cap_sys_admin set, 0 without.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: KP Singh <kpsingh@kernel.org>

> ---
>  include/linux/lsm_hooks.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..f40b82ca91e7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1411,7 +1411,9 @@
>   *     Check permissions for allocating a new virtual mapping.
>   *     @mm contains the mm struct it is being added to.
>   *     @pages contains the number of pages.
> - *     Return 0 if permission is granted.
> + *     Return 0 if permission is granted by LSMs to the caller. LSMs should
> + *     return 1 if __vm_enough_memory() should be called with
> + *     cap_sys_admin set, 0 if not.
>   *
>   * @ismaclabel:
>   *     Check if the extended attribute specified by @name
> --
> 2.25.1
>
