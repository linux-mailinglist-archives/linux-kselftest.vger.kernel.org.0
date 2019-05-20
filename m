Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72A223FA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2019 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfETR4q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 13:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfETR4p (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 13:56:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C16F206B6;
        Mon, 20 May 2019 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558375004;
        bh=vcJUwKueu3F2uwVm18g8UcTZp0tXVBXVM4e5zvCz3Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLnYbJ/k9saVg+oNGkcODh4Aicjj8nC9e8UFtYjKy5RJlYtIHZ7VzozwEMhcQ9WOR
         OHffZAJ5XVEYyChLiCCFBddKrw7q9vBYGYnKZzQEjTnhw1OoBCCXY/nsLTo0G/UdH8
         9NBihMUROvwJP0JSi0ZueO7/fuL//+L582whwNII=
Date:   Mon, 20 May 2019 19:56:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Rue <dan.rue@linaro.org>
Cc:     linux-kselftest@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: teach kselftest-merge to find nested config files
Message-ID: <20190520175641.GA14339@kroah.com>
References: <20190520151614.19188-1-dan.rue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520151614.19188-1-dan.rue@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 20, 2019 at 10:16:14AM -0500, Dan Rue wrote:
> Current implementation of kselftest-merge only finds config files that
> are one level deep using `$(srctree)/tools/testing/selftests/*/config`.
> 
> Often, config files are added in nested directories, and do not get
> picked up by kselftest-merge.
> 
> Use `find` to catch all config files under
> `$(srctree)/tools/testing/selftests` instead.
> 
> Signed-off-by: Dan Rue <dan.rue@linaro.org>
> ---
>  Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

To be more specific here, the binderfs test is not catching the config
entry, so it would be nice to get this into the stable trees as well :)

> diff --git a/Makefile b/Makefile
> index a45f84a7e811..e99e7f9484af 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1228,9 +1228,8 @@ kselftest-clean:
>  PHONY += kselftest-merge
>  kselftest-merge:
>  	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
> -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> -		-m $(objtree)/.config \
> -		$(srctree)/tools/testing/selftests/*/config
> +	$(Q)find $(srctree)/tools/testing/selftests -name config | \
> +		xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
>  	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>  
>  # ---------------------------------------------------------------------------

is find run with $(Q)?  It isn't with other instances in the Makefile.

thanks,

greg k-h
