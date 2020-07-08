Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DBD218667
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 13:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgGHLx2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jul 2020 07:53:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36433 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbgGHLx2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jul 2020 07:53:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id d10so6052130pll.3;
        Wed, 08 Jul 2020 04:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sa8n1TRJl8q0W3/65oG3rXoiqfk7+dLp1Myv9f9hyk0=;
        b=LF063OQiMTO+ZVsKMRzbLjt9c3j1UWV0rQsv47aQCNGSdiXlDknth9QJUmCJplkFwv
         OkI140aryqPgV27evGkx0AztsrtgeS13gKL2keKT2nYYHBj8ILY73ORSPeNwKZah9qtI
         PRchJZS8NPVXvafslx+ml+09d80aKoYUucr02dH8V1xFqyV4DdZK9ucSGKmf583Q4x0w
         YtpI23l5oPGqsGG/pv4EmMAPPis4yLhtLBEJfwiAS20szsMjG4rqVYz/qBUwYom8z/eu
         6VdOfnZEBwOjq2V6q4Eo0BwkKxjaGM1y2r8PT610LCes7u4b8EEdF7X0HhEULIJIHYyx
         N2Jw==
X-Gm-Message-State: AOAM5324kSu97CGNX9KLBGyvh2QTdnNzd+Ba1walutANR0Mb3afegAhO
        d66e5vslkRKpgtB+oOx4SG4=
X-Google-Smtp-Source: ABdhPJxjHXf1yB+wkqMfjw38cNqjbu5cvN3h2X2giW8Tg6UVZvLPEsbiaOISZ/qPNmEY+x69Z7lFLw==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr49774517plk.47.1594209207638;
        Wed, 08 Jul 2020 04:53:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j2sm6092410pjy.1.2020.07.08.04.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:53:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F151D401AE; Wed,  8 Jul 2020 11:53:24 +0000 (UTC)
Date:   Wed, 8 Jul 2020 11:53:24 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: KMOD KERNEL MODULE
 LOADER - USERMODE HELPER
Message-ID: <20200708115324.GE4332@42.do-not-panic.com>
References: <20200708071337.13108-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708071337.13108-1-grandmaster@al2klimov.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 08, 2020 at 09:13:37AM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Shuah, can this go through your tree?

  Luis

> ---
>  tools/testing/selftests/kmod/kmod.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
> index 3702dbcc90a7..84409020a40f 100755
> --- a/tools/testing/selftests/kmod/kmod.sh
> +++ b/tools/testing/selftests/kmod/kmod.sh
> @@ -128,7 +128,7 @@ test_reqs()
>  	if [[ $KMOD_VERSION  -le 19 ]]; then
>  		echo "$0: You need at least kmod 20" >&2
>  		echo "kmod <= 19 is buggy, for details see:" >&2
> -		echo "http://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/libkmod/libkmod-module.c?id=fd44a98ae2eb5eb32161088954ab21e58e19dfc4" >&2
> +		echo "https://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/libkmod/libkmod-module.c?id=fd44a98ae2eb5eb32161088954ab21e58e19dfc4" >&2
>  		exit $ksft_skip
>  	fi
>  
> -- 
> 2.27.0
> 
