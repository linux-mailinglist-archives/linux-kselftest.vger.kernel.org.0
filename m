Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1FD0041
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJHR7V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 13:59:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55332 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJHR7V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 13:59:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so4124774wma.5;
        Tue, 08 Oct 2019 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=de/h/+CZqrrnC1bJlNTMniZfSzB6FHNGFGPPpwsaq7Q=;
        b=CD3PDvXHvPqaQA+NWxzdIBr9gEtKMWzC7kNysSHLMFWQ9B2PEUUS+BkiohrEuNrm0S
         ojYhC4kmNjgXy3yeRz6IOlTd5kEKb022VYzxMea6dqo2pmb+G4kO2X5lUHmbUn1PG8lY
         oiaV0mL9oIMh9ADeBIGQifBuhU7Su8Rg+dq+NQX00u3b8zQoB/g0web0ISe5aPTAeaSY
         zs0ljEZxI+vJppQaWXQA7SDC4n4zUvUBKfO5Wpdqr4C5vVQAkazhO7ZaFCkjEGgUDOO4
         Jx+ndVm1G2sDFS7WdQkXEAjiiEo/geDpLusi5IhKC6AI1qdfgPAcklDEMpTdB/QqqjGu
         Bd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=de/h/+CZqrrnC1bJlNTMniZfSzB6FHNGFGPPpwsaq7Q=;
        b=ehHCkNMaw+u2zyS9DMRONCo5PvOfIgknjYdpaiWd2fjJ6Sy/XvejmoO6jWGm2hSDv0
         o76sW3e0pPlq2QemIkIGQbpgMuSly6VJjpziJSbUjQ6G7C7gne+Ny9bxqzLuZROBC4Dc
         20IQWzoMF3Xp/GMTYrKj6CM5KS6nHxKftFnaGrQEQCirLT9+/36PkJCsnh+1E84qmdm7
         HU+xiAd6FTjfEAD8/5MHy90/hSJsycaQoAp7sw3WUvABKAD4Ce9Bva7ElBnX2lm610gH
         GVsHAf5aARWfSoABzjDZ+uD5OZto96enjj6q1iDZ5D6CvCtlGxSQAL7mgBWBqyBIuX2W
         +0Hw==
X-Gm-Message-State: APjAAAUxTVCz82Vblv6kQFwLFqug+ctj5X2n47kvETcqfpvRQsAHlHER
        zNvZyd5ONlPLhjIeK0U6kg==
X-Google-Smtp-Source: APXvYqxeUUSPQhJ79Xf8sAszWDyBD/coVq+bBBubV/Yh6l5sN7oLJT+vL4GQBpGUyn/D5O/P40r4EQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr4736768wmc.42.1570557559484;
        Tue, 08 Oct 2019 10:59:19 -0700 (PDT)
Received: from avx2 ([46.53.253.157])
        by smtp.gmail.com with ESMTPSA id u68sm5643087wmu.12.2019.10.08.10.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 10:59:18 -0700 (PDT)
Date:   Tue, 8 Oct 2019 20:59:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH 1/5] selftests: proc: Make va_max 3GB on 32bit arch
Message-ID: <20191008175916.GA20780@avx2>
References: <157046101671.20724.9561877942986463668.stgit@devnote2>
 <157046102656.20724.3358140818300189230.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157046102656.20724.3358140818300189230.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 08, 2019 at 12:10:26AM +0900, Masami Hiramatsu wrote:
> Currently proc-self-map-files-002.c sets va_max (max test address
> of user virtual address) to 4GB, but it is too big for 32bit
> arch and 1UL << 32 is overflow on 32bit long.
> 
> Make va_max 3GB on 32bit arch like i386 and arm.

IIRC i386 had 1G/3G split, so 3GB would be too much still.

> --- a/tools/testing/selftests/proc/proc-self-map-files-002.c
> +++ b/tools/testing/selftests/proc/proc-self-map-files-002.c

> +#if __BITS_PER_LONG == 32
> +# define VA_MAX (3UL << 30)
> +#elif __BITS_PER_LONG == 64
> +# define VA_MAX (1UL << 32)
> +#else
> +# define VA_MAX 0
> +#endif
> +
>  int main(void)
>  {
>  	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
> -	const unsigned long va_max = 1UL << 32;
> +	const unsigned long va_max = VA_MAX;

This limit doesn't need to be precise, 1GB is "big enough".
