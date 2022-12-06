Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3E6448DA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 17:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiLFQK0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 11:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiLFQKB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 11:10:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C7F3AC33;
        Tue,  6 Dec 2022 08:04:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DDDD617A0;
        Tue,  6 Dec 2022 16:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BE8C433C1;
        Tue,  6 Dec 2022 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670342691;
        bh=gLpDTa+rhIH8NgaAcvNWyhQOtMSJQxHMPFZgL9hpIWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UF60dVUP/aF9XqgJKVxVlccO8WHFfVB+F8TBKwO1Ir+7+A95I+cWjyQ/89GNogrrJ
         VjewJijvOODIWPYGIFOs0lvI2Xjz9XWsL/cq/ERPHHWGhU2LzvwfIVFdbj69IdQTl4
         Fwr55ea12m70z4dZfL7YmtW0+dTRXkv3sN2AlY4A=
Date:   Tue, 6 Dec 2022 17:04:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <Y49oIR6/ULTqlcwL@kroah.com>
References: <20221206152358.1966099-1-jeffxu@google.com>
 <20221206152358.1966099-4-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206152358.1966099-4-jeffxu@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 06, 2022 at 03:23:55PM +0000, jeffxu@chromium.org wrote:
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -110,6 +110,11 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	ns->ucounts = ucounts;
>  	ns->pid_allocated = PIDNS_ADDING;
>  
> +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> +	ns->memfd_noexec_scope =
> +		task_active_pid_ns(current)->memfd_noexec_scope;
> +#endif

.c files should never have #if in them.  Can't you put this in a .h file
properly so that this does not get really messy over time?



> +
>  	return ns;
>  
>  out_free_idr:
> @@ -255,6 +260,45 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	return;
>  }
>  
> +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)

Same here.

thanks,

greg k-h
