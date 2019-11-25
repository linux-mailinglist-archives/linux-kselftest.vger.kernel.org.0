Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCEFE1094EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 22:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfKYVJl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 16:09:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36769 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKYVJl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 16:09:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so7996174pfd.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Nov 2019 13:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2eOx4ye28sFtzJeeKAL0QyQ7h9oIsvpFy7JAk2W7dYo=;
        b=RJPj2JZ9eVqA0psVzdENDC4T3MwIFETE5xtjBVqccuNL6Fil8AI92rLHwgkK53G7os
         Ryt5ozzJmIxJcj/GZsq8hDxR20zjCz0Fkn4tDpXwjnvn31v7nqri3kTbeVlQEKQa2r5o
         7eADL1xcH9DWcPTFSKsG85UKPWoNFla26ucV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2eOx4ye28sFtzJeeKAL0QyQ7h9oIsvpFy7JAk2W7dYo=;
        b=uOPdCkMsMU9Tua6POcjxc+dRfI1o7SNEqDozPh14vuDDx7zJX6yKEzSuaaKga8Qg0A
         +E5/VMDEce8GkWwWeuR4fe3Kwp1RopdwkYQr0Q5OVPvWRgeW96wsbLB5KE7JLTssNwLs
         6phRUe65oI2Il6E9Qj6+5V539n3Vcnp0+8VS86w4ZLcOe8JERck49kT+J4S7Kzy5c2x1
         HW0rH02vXrPHdub5kdrxz173nLW1iY/qturL/EXVGE3SWdaAk7oiIfSs7tmaBTWzWEc3
         yPpL/zzdpS26XHxaiAgP0gZARuNtcv0KGKH2l+a2w79/qXc84Du3uGJT2deZrr9pkb90
         ifww==
X-Gm-Message-State: APjAAAWRSMe0MaEr+Y+B9PewaBhVeCyAfp327lyE1xTvxvT9eNYSGml9
        /zCOXce0NT+nSyXKTwbC726duQ==
X-Google-Smtp-Source: APXvYqyYC+eaxeL1oOBkSLWNuH+jzXjRsOnySbrO4TcoIBArJr4D1+N9x6uqeAXJEY8DZguVL37QlQ==
X-Received: by 2002:a63:c804:: with SMTP id z4mr35135355pgg.440.1574716179379;
        Mon, 25 Nov 2019 13:09:39 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x186sm9414045pfx.105.2019.11.25.13.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 13:09:38 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:09:37 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v3 2/4] PM / QOS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to
 S32_MAX
Message-ID: <20191125210937.GB228856@google.com>
References: <cover.1574699610.git.leonard.crestez@nxp.com>
 <43ffe25df5e9b268778656a0b9259c2939715681.1574699610.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43ffe25df5e9b268778656a0b9259c2939715681.1574699610.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 25, 2019 at 06:42:17PM +0200, Leonard Crestez wrote:
> QOS requests for DEFAULT_VALUE are supposed to be ignored but this is
> not the case for FREQ_QOS_MAX. Adding one request for MAX_DEFAULT_VALUE
> and one for a real value will cause freq_qos_read_value to unexpectedly
> return MAX_DEFAULT_VALUE (-1).
> 
> This happens because freq_qos max value is aggregated with PM_QOS_MIN
> but FREQ_QOS_MAX_DEFAULT_VALUE is (-1) so it's smaller than other
> values.
> 
> Fix this by redefining FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX.
> 
> Looking at current users for freq_qos it seems that none of them create
> requests for FREQ_QOS_MAX_DEFAULT_VALUE.
> 
> Fixes: 77751a466ebd ("PM: QoS: Introduce frequency QoS")

nit: you could add:

Reported-by: Matthias Kaehlcke <mka@chromium.org>

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  include/linux/pm_qos.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index ebf5ef17cc2a..24a6263c9931 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -254,11 +254,11 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
>  	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>  }
>  #endif
>  
>  #define FREQ_QOS_MIN_DEFAULT_VALUE	0
> -#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)
> +#define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
