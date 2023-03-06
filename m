Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37506AB7E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 09:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCFIEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 03:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCFIEG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 03:04:06 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ACB4C18;
        Mon,  6 Mar 2023 00:03:43 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id a25so35068892edb.0;
        Mon, 06 Mar 2023 00:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83wzMZDza94KzRdG9ihv12wmiVlHYRIDlbhLRowmSAw=;
        b=NoYiJejnzoloQ2z2TSC/wM21iRq2BlaSq4X93repMOHXD+DcK1FjLBLHOuEHZrvUq2
         KIKvYFaOyQV8voJ90yvboEgLA9IJB0lbZCkeeVZ4xYtTdHywKKIkwn0u/CmFXX7w4wFL
         rdICuzvHofJrRe/OYcjoJYrcoh68EDK2BLcjDa3fNk5WgZbco3RRBHiBS9W3yBVVw3fz
         JgW9iiBGzQeAVd5KSJT74jTQit3kiat/yVx7WdGogRJ2HOjmg217MaIbmRL/jtBhMRLu
         1dWrxOzXCmDhyeK01vCUQ7BZuMSnLYPLEc0oLU6L7dncInRykai4k60vhBbnmtLYyE1d
         eG3g==
X-Gm-Message-State: AO0yUKUKiV2+k8DIXyjxq46xwNw5uC8Ta00F2oYxHI8Nw6hS/BKS2m4w
        Xi4FjYT0Ejj5Tmoprzrz81/xLCuEB2xKlw==
X-Google-Smtp-Source: AK7set+KX0I+SESEOXUeE7xIsnVvh8ozH7/v3/FI16dEFBlyuDwrxD5H4VuQj/OzQtB3gGVxkV/1xg==
X-Received: by 2002:a17:907:a0d5:b0:8b1:319c:c29e with SMTP id hw21-20020a170907a0d500b008b1319cc29emr12397792ejc.74.1678089817808;
        Mon, 06 Mar 2023 00:03:37 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906c00700b008cff300cf47sm4184241ejz.72.2023.03.06.00.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:03:37 -0800 (PST)
Message-ID: <c91c458e-58d0-f13a-9adb-a48a19f82107@kernel.org>
Date:   Mon, 6 Mar 2023 09:03:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Michal Sekletar <msekleta@redhat.com>, gregkh@linuxfoundation.org
Cc:     arozansk@redhat.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230303133606.227934-1-msekleta@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] tty: tty_io: update timestamps on all device nodes
In-Reply-To: <20230303133606.227934-1-msekleta@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03. 03. 23, 14:36, Michal Sekletar wrote:
> User space applications watch for timestamp changes on character device
> files in order to determine idle time of a given terminal session. For
> example, "w" program uses this information to populate the IDLE column
> of its output [1]. Similarly, systemd-logind has optional feature where
> it uses atime of the tty character device to determine if there was
> activity on the terminal associated with the logind's session object. If
> there was no activity for a configured period of time then logind will
> terminate such session [2].
> 
> Now, usually (e.g. bash running on the terminal) the use of the terminal
> will update timestamps (atime and mtime) on the corresponding terminal
> character device. However, if access to the terminal, e.g. /dev/pts/0,
> is performed through magic character device /dev/tty then such access
> obviously changes the state of the terminal, however timestamps on the
> device that correspond to the terminal (/dev/pts/0) are not updated.
> 
> This patch makes sure that we update timestamps on *all* character
> devices that correspond to the given tty, because outside observers (w,
> systemd-logind) are maybe checking these timestamps. Obviously, they can
> not check timestamps on /dev/tty as that has per-process meaning.
> 
> [1] https://gitlab.com/procps-ng/procps/-/blob/v4.0.0/w.c#L286
> [2] https://github.com/systemd/systemd/blob/v252/NEWS#L477
> 
> Signed-off-by: Michal Sekletar <msekleta@redhat.com>
> ---
>   drivers/tty/tty_io.c | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 36fb945fdad4..48e0148b0f3e 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -101,6 +101,7 @@
>   #include <linux/compat.h>
>   #include <linux/uaccess.h>
>   #include <linux/termios_internal.h>
> +#include <linux/fs.h>
>   
>   #include <linux/kbd_kern.h>
>   #include <linux/vt_kern.h>
> @@ -811,18 +812,27 @@ void start_tty(struct tty_struct *tty)
>   }
>   EXPORT_SYMBOL(start_tty);
>   
> -static void tty_update_time(struct timespec64 *time)
> +static void tty_update_time(struct tty_struct *tty, int tstamp)

Why not enum file_time_flags then?

And "tstamp" sounds weird for what it is. It should be something like 
"time" or "time_flag". Or make it simply "bool mtime". And call it with 
true/false.

>   {
> +	struct tty_file_private *priv;
>   	time64_t sec = ktime_get_real_seconds();

Likely should be switched to have a reverse xmas tree.

>   
> -	/*
> -	 * We only care if the two values differ in anything other than the
> -	 * lower three bits (i.e every 8 seconds).  If so, then we can update
> -	 * the time of the tty device, otherwise it could be construded as a
> -	 * security leak to let userspace know the exact timing of the tty.
> -	 */
> -	if ((sec ^ time->tv_sec) & ~7)
> -		time->tv_sec = sec;
> +	spin_lock(&tty->files_lock);

Note: this should be fine wrt write lock. Have you tried running w/ 
lockdep enabled?

> +	list_for_each_entry(priv, &tty->tty_files, list) {
> +		struct file *filp = priv->file;

I think you can inline the above ^^ to the bellow vv.

> +		struct inode *inode = file_inode(filp);
> +		struct timespec64 *time = tstamp == S_MTIME ? &inode->i_mtime : &inode->i_atime;

So you'd have:
struct inode *inode = file_inode(priv->file);
struct timespec64 *time = mtime ? &inode->i_mtime : &inode->i_atime;

> +
> +		/*
> +		 * We only care if the two values differ in anything other than the
> +		 * lower three bits (i.e every 8 seconds).  If so, then we can update
> +		 * the time of the tty device, otherwise it could be construded as a
> +		 * security leak to let userspace know the exact timing of the tty.
> +		 */
> +		if ((sec ^ time->tv_sec) & ~7)
> +			time->tv_sec = sec;
> +	}
> +	spin_unlock(&tty->files_lock);
>   }
>   
>   /*
> @@ -928,7 +938,7 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
>   	tty_ldisc_deref(ld);
>   
>   	if (i > 0)
> -		tty_update_time(&inode->i_atime);
> +		tty_update_time(tty, S_ATIME);
>   
>   	return i;
>   }
> @@ -1036,7 +1046,7 @@ static inline ssize_t do_tty_write(
>   		cond_resched();
>   	}
>   	if (written) {
> -		tty_update_time(&file_inode(file)->i_mtime);
> +		tty_update_time(tty, S_MTIME);
>   		ret = written;
>   	}
>   out:

-- 
js
suse labs

