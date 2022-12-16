Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1A64F1A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 20:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLPTVK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 14:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLPTVI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 14:21:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D97656B;
        Fri, 16 Dec 2022 11:21:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0694B621B4;
        Fri, 16 Dec 2022 19:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7564C433D2;
        Fri, 16 Dec 2022 19:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671218463;
        bh=7V2x1Qhn0q8oBUckNQ44lIULP5uyurI4gqWQQ5JRHuI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IESvI4ULHOkIMzln29SQ2UHfmxQYyYK60NX/zgWPXEQgtI6Qm2GX6Z4ccGJovhoQV
         YAzVqaROyQdg/2C22txXuS1I1pOf+GpniQCXoW6BeWHrFX+K6qqQKscHU2xcoRwOlu
         +ZjYwQu0q+xSGj/mbsoUHEIGsxl3oR4OyMyW0jnY=
Date:   Fri, 16 Dec 2022 11:21:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     SeongJae Park <sj@kernel.org>, skhan@linuxfoundation.org,
        keescook@chromium.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-Id: <20221216112102.8eec617257eb90fccb9ff503@linux-foundation.org>
In-Reply-To: <CALmYWFtfdL=1Nrwyj7je+o8dciDL76CCoga5aE3hZPOh-SFUpA@mail.gmail.com>
References: <20221209160453.3246150-4-jeffxu@google.com>
        <20221216183949.169779-1-sj@kernel.org>
        <CALmYWFtfdL=1Nrwyj7je+o8dciDL76CCoga5aE3hZPOh-SFUpA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Fri, 16 Dec 2022 11:03:06 -0800 Jeff Xu <jeffxu@google.com> wrote:

> >
> > I just posted a patch for that:
> > https://lore.kernel.org/linux-mm/20221216183314.169707-1-sj@kernel.org/
> >
> > Could you please check?
> >
> Hi SeongJae,
> Thanks for the patch ! I responded to the other thread.
> 
> Andrew,
> >From a process point of view, should I update this patch to V9 to
> include the fix ?
> or add a patch directly on top in the mm-unstable branch.

A little fixup patch wouild be preferable.

But I added the below yesterday, so I think we're all good?

--- a/kernel/pid_sysctl.h~mm-memfd-add-mfd_noexec_seal-and-mfd_exec-fix
+++ a/kernel/pid_sysctl.h
@@ -52,8 +52,10 @@ static inline void register_pid_ns_sysct
 	register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
 }
 #else
+static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns) {}
 static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
 static inline void register_pid_ns_ctl_table_vm(void) {}
+static inline void register_pid_ns_sysctl_table_vm(void) {}
 #endif
 
 #endif /* LINUX_PID_SYSCTL_H */
_

