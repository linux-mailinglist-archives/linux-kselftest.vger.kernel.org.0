Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE62E47E073
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Dec 2021 09:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347139AbhLWIgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Dec 2021 03:36:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49796 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhLWIgA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Dec 2021 03:36:00 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 63EA91F38A;
        Thu, 23 Dec 2021 08:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640248559;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MV/5K9zmhuw4wh4GeKO1RwxfharP8GGckwYEIlHrrJs=;
        b=I1mUbTlQhKbIjakUkJDnAqJ8ux/WptWSs6mhucuFKxa3m3xOnIJHU7K6sBKacyOqwsAyer
        H24Zl9qygEDtc1AqBpwybII8+Ya9yQ1TrS24rUT+LXYTD9/+zk4ZiNEg2s/oEcdyG9b+18
        qN0sAQc6NdstxsXco0E9K0u34OBsAwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640248559;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MV/5K9zmhuw4wh4GeKO1RwxfharP8GGckwYEIlHrrJs=;
        b=C0A1smGAleYucDeFJ93gCVnGl/89pYnGeaKSwPQxbYppxBnR6M9mrcNLVC3DkiFUoPPEpN
        aJvgvGjLw82nfoDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E974913E82;
        Thu, 23 Dec 2021 08:35:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jQ5wNu40xGEGZwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 23 Dec 2021 08:35:58 +0000
Date:   Thu, 23 Dec 2021 09:35:57 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Takashi Iwai <tiwai@suse.de>, Joey Lee <jlee@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftests/kexec: update searching for the Kconfig
Message-ID: <YcQ07bX74r/qbkPD@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211222213052.6771-1-zohar@linux.ibm.com>
 <20211222213052.6771-3-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222213052.6771-3-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> First check /lib/modules/`uname -r`/config, before using the IKCONFIG.
> In addition, the configs.ko might be compressed.  Fix the configs.ko
> name.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Distros: is storing the Kconfig in /lib/modules/`uname -r`/config common?

>  tools/testing/selftests/kexec/kexec_common_lib.sh | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

> diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
> index 43017cfe88f7..5a1b8ae04c64 100755
> --- a/tools/testing/selftests/kexec/kexec_common_lib.sh
> +++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
> @@ -138,15 +138,20 @@ kconfig_enabled()
>  	return 0
>  }

> -# Attempt to get the kernel config first via proc, and then by
> -# extracting it from the kernel image or the configs.ko using
> -# scripts/extract-ikconfig.
> +# Attempt to get the kernel config first by checking the modules directory
> +# then via proc, and finally by extracting it from the kernel image or the
> +# configs.ko using scripts/extract-ikconfig.
>  # Return 1 for found.
>  get_kconfig()
>  {
>  	local proc_config="/proc/config.gz"
>  	local module_dir="/lib/modules/`uname -r`"
> -	local configs_module="$module_dir/kernel/kernel/configs.ko"
> +	local configs_module="$module_dir/kernel/kernel/configs.ko*"
I wonder if * will later work:

if [ ! -f $configs_module ]; then

But there should be just one variant: either configs.ko or configs.ko.xz
(or something other), so it should work, right?

Thus
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
> +	if [ -f $module_dir/config ]; then
> +		IKCONFIG=$module_dir/config
> +		return 1
> +	fi

>  	if [ ! -f $proc_config ]; then
>  		modprobe configs > /dev/null 2>&1
