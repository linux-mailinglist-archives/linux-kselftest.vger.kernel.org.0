Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C682CCA57
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 00:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgLBXL1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 18:11:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgLBXL1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 18:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606950600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TNiA1EC0PZeSV6z61SrYzEw361aXmtRmDOfY3tQLKM=;
        b=CnpYlCtwMGk/7bog6uN5QdqLZOa06P1cjBXeZDF4s6QsKl2mM7BzLCeHreU/XEyggRYDqa
        1RtvbpKngLrzk8XWnRKi5oStSJa8/Q5mIAsBq2f8CNaKjWvMRK98qvIUCEeJglg+9GtGv9
        cZF+MNSy4okTbSuclccWZO8sI2FLs8U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-SdNjLF0iOuKZUxnf47ziYQ-1; Wed, 02 Dec 2020 18:09:59 -0500
X-MC-Unique: SdNjLF0iOuKZUxnf47ziYQ-1
Received: by mail-qv1-f72.google.com with SMTP id o16so154279qvq.4
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 15:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3TNiA1EC0PZeSV6z61SrYzEw361aXmtRmDOfY3tQLKM=;
        b=i941h5s8+sJLTEycjY7pkkfa4sBhnoQDYPHYZRMLNDN6O1iO+WTEvEpNRvkHUzOkL/
         CP3VOsWeN6OiWb1Lbd0eG4vQVIi+k64IZXgVJmIrIJ6teWy7aCYzdiywnxNMsb+gxWHr
         ucfoCqaJJbi3SmUiT+m4hsdhX+pab2maISRlzgtihGsfFh951O+waOIS0WkgqXr1kSQk
         vO6pwRIAmZbF4gxzuXUBFowouK3/tMYzr/4+McqySJKoB7yzkY4edJkrLjlIOqP40eK4
         Bmo8flB1vaykss80MwJRfcXXM/h16OBmG23dJrNSXhoQYV59RCUOqYSuO5U1+fy+DWa2
         cX/A==
X-Gm-Message-State: AOAM533OlVPKXv2TV+3fxheaPEATQWRr6kP6DKDBk3Kx3DY7soSDSz+v
        GmV/TWKV1q8bDdd8Fnrhibv/ZWSsQtahrCV7hs9hqb9QQ13JO3anZuUQtL6rzVis5Vv6GoBhM6c
        HxI7IQckyOg6CGA09/BSkz4N0O0tL
X-Received: by 2002:a05:6214:29:: with SMTP id b9mr332650qvr.18.1606950597610;
        Wed, 02 Dec 2020 15:09:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwExtlsTU0fsMGHmFJNZJIn0zRNxa83R1RNYHP2U77HnxFqWx3IezzuhvYhYVJqvWn2fWH/Zg==
X-Received: by 2002:a05:6214:29:: with SMTP id b9mr332631qvr.18.1606950597431;
        Wed, 02 Dec 2020 15:09:57 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id t126sm120531qkc.76.2020.12.02.15.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:09:56 -0800 (PST)
Date:   Wed, 2 Dec 2020 18:09:54 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Alan Gilbert <dgilbert@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: selftests: make __{s,u}64 format specifiers
 portable
Message-ID: <20201202230954.GB108496@xz-x1>
References: <20201202211542.1121189-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202211542.1121189-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Axel,

Looks mostly good to me, but a few nitpickings below.

On Wed, Dec 02, 2020 at 01:15:42PM -0800, Axel Rasmussen wrote:

[...]

> +static void uffd_error(const char *message, __s64 code)
> +{
> +	fprintf(stderr, "%s: %" PRId64 "\n", message, (int64_t)code);
> +	exit(1);
> +}

IMHO a macro that can take arbitrary parameters would be nicer, but if it
satisfy our need, definitely ok too.

[...]

> @@ -340,7 +348,8 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
>  	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
>  
>  	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms)) {
> -		fprintf(stderr, "clear WP failed for address 0x%Lx\n", start);
> +		fprintf(stderr, "clear WP failed for address 0x%" PRIx64 "\n",
> +			(uint64_t)start);
>  		exit(1);

Is it intended to not use uffd_error() here?

>  	}
>  }

[...]

> @@ -979,26 +981,20 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
>  	if (ret) {
>  		/* real retval in ufdio_zeropage.zeropage */
>  		if (has_zeropage) {
> -			if (uffdio_zeropage.zeropage == -EEXIST) {
> -				fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n");
> -				exit(1);
> -			} else {
> -				fprintf(stderr, "UFFDIO_ZEROPAGE error %Ld\n",
> -					uffdio_zeropage.zeropage);
> -				exit(1);
> -			}
> +			uffd_error(uffdio_zeropage.zeropage == -EEXIST ?
> +						 "UFFDIO_ZEROPAGE -EEXIST" :
> +						 "UFFDIO_ZEROPAGE error",

Nit: The indents here are a bit odd..

Thanks,

-- 
Peter Xu

