Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEFC64F1D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiLPTb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 14:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiLPTb5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 14:31:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEB62251C;
        Fri, 16 Dec 2022 11:31:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C891621E4;
        Fri, 16 Dec 2022 19:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA32C433D2;
        Fri, 16 Dec 2022 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671219115;
        bh=UiZJecR1KEdfUqt0tb4Uui5jnE7dFBjPmP37ANDfxHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqbCtdEz4pPvHAdzQkgmcvSyDiIqQ9xJuHDYkWFTwPUzLNdMzwQznaKrNZJxP3Ctx
         ubqmqZnGMPkRHbWg/u/VvYx1utnBO3IJ3oC0ittHfV6cyJhjbBsuWt7yrfOqgkmkHz
         o2t/Le1aBw9FtYhTAE/GcSr90/8AfSG5PrJcLLPo7qCzY9awrpF5ReZe2TB9I6uxJl
         BiGFRBPFdqsglWuX6u5X79f1mc/jF2L/3zIEvtY1EJkhZ908QejqTcbT045oE8z0CG
         KJFg/R2I0XzeHigYkc13ooUkOu1DhOhgSkpjFfh0aDGUwGkvO1w5RMvfvO9GSSZv2z
         IfpjE/1vdBlNA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jeff Xu <jeffxu@google.com>, SeongJae Park <sj@kernel.org>,
        skhan@linuxfoundation.org, keescook@chromium.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Date:   Fri, 16 Dec 2022 19:31:53 +0000
Message-Id: <20221216193153.100849-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216112102.8eec617257eb90fccb9ff503@linux-foundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jeff and Andrew,

On Fri, 16 Dec 2022 11:21:02 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Dec 2022 11:03:06 -0800 Jeff Xu <jeffxu@google.com> wrote:
> 
> > >
> > > I just posted a patch for that:
> > > https://lore.kernel.org/linux-mm/20221216183314.169707-1-sj@kernel.org/
> > >
> > > Could you please check?
> > >
> > Hi SeongJae,
> > Thanks for the patch ! I responded to the other thread.

Thank you for the quick and nice response, Jeff :)

> > 
> > Andrew,
> > >From a process point of view, should I update this patch to V9 to
> > include the fix ?
> > or add a patch directly on top in the mm-unstable branch.
> 
> A little fixup patch wouild be preferable.
> 
> But I added the below yesterday, so I think we're all good?

Good, thank you.  I should be more patient until you push it, but I was unable
to resist ;)


Thanks,
SJ

> 
> --- a/kernel/pid_sysctl.h~mm-memfd-add-mfd_noexec_seal-and-mfd_exec-fix
> +++ a/kernel/pid_sysctl.h
> @@ -52,8 +52,10 @@ static inline void register_pid_ns_sysct
>  	register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
>  }
>  #else
> +static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns) {}
>  static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
>  static inline void register_pid_ns_ctl_table_vm(void) {}
> +static inline void register_pid_ns_sysctl_table_vm(void) {}
>  #endif
>  
>  #endif /* LINUX_PID_SYSCTL_H */
> _
