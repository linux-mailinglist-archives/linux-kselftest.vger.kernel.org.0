Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45A9244646
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Aug 2020 10:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHNIPT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Aug 2020 04:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgHNIPT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Aug 2020 04:15:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA292068E;
        Fri, 14 Aug 2020 08:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597392918;
        bh=O/CKn70poXMC1eVo5v8wL30+8uUO0oPYHL7wCqph7yE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K+zev1q6hZX5b62eLIKBQ5eJ4ayAbwZwLoTFP2d7lJZyOtRgaQCG6IA5wQ53RyI5F
         O6QoK0BbfFr0YQoHNTDyXRcPHGFbaiVWEf5hP9Gc4t4vglCqz3ev9X5ewZdYHtuaj0
         iUkee5DVG4dzrUTIoGjzK7ruGyR8Ym7nNmg8Z0sI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k6Urt-0026tv-Ac; Fri, 14 Aug 2020 09:15:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Aug 2020 09:15:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: Restore EACCES of S_ISDIR execve()
In-Reply-To: <20200813231723.2725102-2-keescook@chromium.org>
References: <20200813231723.2725102-1-keescook@chromium.org>
 <20200813231723.2725102-2-keescook@chromium.org>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <5ea68dd13fc8d5568b69f42fa384b8d3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: keescook@chromium.org, akpm@linux-foundation.org, shuah@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-08-14 00:17, Kees Cook wrote:
> The return code for attempting to execute a directory has always been
> EACCES. Adjust the S_ISDIR exec test to reflect the old errno instead
> of the general EISDIR for other kinds of "open" attempts on 
> directories.
> 
> Reported-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/lkml/20200813151305.6191993b@why
> Fixes: 633fb6ac3980 ("exec: move S_ISREG() check earlier")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/namei.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 2112e578dccc..e99e2a9da0f7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2849,8 +2849,10 @@ static int may_open(const struct path *path,
> int acc_mode, int flag)
>  	case S_IFLNK:
>  		return -ELOOP;
>  	case S_IFDIR:
> -		if (acc_mode & (MAY_WRITE | MAY_EXEC))
> +		if (acc_mode & MAY_WRITE)
>  			return -EISDIR;
> +		if (acc_mode & MAY_EXEC)
> +			return -EACCES;
>  		break;
>  	case S_IFBLK:
>  	case S_IFCHR:

Reviewed-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
