Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F95A2062
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 07:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiHZFma (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 01:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiHZFm3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 01:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF04FD0201;
        Thu, 25 Aug 2022 22:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FEB2619FD;
        Fri, 26 Aug 2022 05:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046B6C433C1;
        Fri, 26 Aug 2022 05:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661492547;
        bh=+/7bgcM7XCyWZRFiTszQQDAjii7dFnz03LdfZR+j2a8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEDrPfXuEWYVmP7eEh+msDb+GYa8Idz9/kaI3MfF1Q3RfI1sAXJhMvI85+nzf4r5C
         Uge3vmZWoOOw3xTMv9RuRaIejaUZuTF8FEx3AFnAU6PLlKdpF/9qZu2LPc94EBHaea
         cnk43VRd1w0vkqykz4L413jU4pYS28Z16HyKXmoGBtiJvBNkX4L5BwnHUOscmXl3mK
         ZnsQ9JRgyKfE4HHpHjMevW/IkfLBi77MgRPLKy+2NSs1U7hK9cfXwy4TuDmm5EVR9f
         dAZHGqx14AymofhqDu29EHJ2yia6JgZ3rJjowwMwySNWrEMoRbmp3pGbOLjpJCXyfk
         J+DvtrRVaU/EQ==
Date:   Fri, 26 Aug 2022 08:42:20 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     roberto.sassu@huaweicloud.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v12 04/10] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
Message-ID: <YwhTiGOhzvv+CYYq@kernel.org>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
 <20220818152929.402605-5-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818152929.402605-5-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 18, 2022 at 05:29:23PM +0200, roberto.sassu@huaweicloud.com wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
> kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
> validate the kfunc parameters.
> 
> Also, introduce key_lookup_flags_check() directly in include/linux/key.h,
> to reduce the risk that the check is not in sync with currently defined
> flags.

Missing the description what the heck this function even is.

Please, explain that.

Also, the short subject is misleading because this *just*
does not move flags.

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/key.h      | 11 +++++++++++
>  security/keys/internal.h |  2 --
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 7febc4881363..b5bbae77a9e7 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -88,6 +88,17 @@ enum key_need_perm {
>  	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred */
>  };
>  
> +#define KEY_LOOKUP_CREATE	0x01
> +#define KEY_LOOKUP_PARTIAL	0x02
> +

/*
 * Explain what the heck this function is.
 */
> +static inline int key_lookup_flags_check(u64 flags)
> +{
> +	if (flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))
> +		return -EINVAL;
> +
> +	return 0;
> +}

This is essentially a boolean function, right?

I.e. the implementation can be just:

!!(flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))

Not even sure if this is needed in the first place, or
would it be better just to open code it. How many call
sites does it have anyway?

BR, Jarkko
