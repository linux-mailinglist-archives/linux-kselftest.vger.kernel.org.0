Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1775410957C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 23:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfKYWWO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 17:22:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45638 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKYWWO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 17:22:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so7880627pgg.12
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Nov 2019 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lXNGjbAB2c8bZdmv6dV6YWnGoVduWVluKBQ973lB61U=;
        b=G2YsyhJQebcAOqVCRATW2DLiaThjq5gWcdXkckmTwJ9HcWSu691Bfm5EWG+GJagmWT
         WLV1g/tvA5BgufUM12MYGRn3uzFqT7zdH+MSUfg04DPmJwwCsan6C/FYTao8fug/Qzb8
         jIuAUZr9iCdXwvhClq2bJ4KbDThL/Ae6KroCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lXNGjbAB2c8bZdmv6dV6YWnGoVduWVluKBQ973lB61U=;
        b=WmdCIdZ26uw9Mx3S1ID2g/RnGsvkrO9PeXrDIN0qVS2ThWgD3oE1nosVhdYeTUZSQ6
         DATmSkJBoJ+qpz7mrnFRvvejtH59dQ9M+lc4S1HSv3H+PeD3rp8WISoh9ttZvLC+eXD8
         G9AKrFMtS9CZWPSMhIUzfYfr8UJ6ZKOftjALdresoz/4yiJeRuEmh1Op4euyOkXFiL0Q
         tnabfdy2sE9In8uTU51LPizmInpwL5MujcjVBtPCDGMfjh9SSS9P/JKg1hHzZBYg7ADG
         c2BsHRay7rGHXwd6a7qSU7/IqjPkxwTnhZdNudljkjVQQMDyVPcIQG35pxon2Adyo4mk
         SBTA==
X-Gm-Message-State: APjAAAUurngl9iRcBE9FA2kXOSDH6+OTuzFbJY1N2obtdA9A1okrOl2S
        HDs4oDi1bFuxtqDH2nP3X42K9A==
X-Google-Smtp-Source: APXvYqyDE3P4mK8WqGerdRCeEdkWSs9jYIQyozqLj9zZNYVM2eBdaQ/zpD6yJzPUvSjQWnIHUnnSdg==
X-Received: by 2002:a63:5c0c:: with SMTP id q12mr33643431pgb.197.1574720531856;
        Mon, 25 Nov 2019 14:22:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id j4sm9355552pgt.57.2019.11.25.14.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 14:22:11 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:22:10 -0800
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
Subject: Re: [PATCH v3 3/4] PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos
 structs
Message-ID: <20191125222210.GC228856@google.com>
References: <cover.1574699610.git.leonard.crestez@nxp.com>
 <f6d6572ad860d479416108a41f0e20d5cb72ae46.1574699610.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6d6572ad860d479416108a41f0e20d5cb72ae46.1574699610.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 25, 2019 at 06:42:18PM +0200, Leonard Crestez wrote:
> This allows dev_pm_qos to embed freq_qos structs, which is done in the
> next patch. Separate commit to make it easier to review.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  include/linux/pm_qos.h | 74 ++++++++++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 24a6263c9931..678fec6da5b9 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -47,25 +47,10 @@ struct pm_qos_request {
>  struct pm_qos_flags_request {
>  	struct list_head node;
>  	s32 flags;	/* Do not change to 64 bit */
>  };
>  
> -enum dev_pm_qos_req_type {
> -	DEV_PM_QOS_RESUME_LATENCY = 1,
> -	DEV_PM_QOS_LATENCY_TOLERANCE,
> -	DEV_PM_QOS_FLAGS,
> -};
> -
> -struct dev_pm_qos_request {
> -	enum dev_pm_qos_req_type type;
> -	union {
> -		struct plist_node pnode;
> -		struct pm_qos_flags_request flr;
> -	} data;
> -	struct device *dev;
> -};
> -
>  enum pm_qos_type {
>  	PM_QOS_UNITIALIZED,
>  	PM_QOS_MAX,		/* return the largest value */
>  	PM_QOS_MIN,		/* return the smallest value */
>  	PM_QOS_SUM		/* return the sum */
> @@ -88,10 +73,48 @@ struct pm_qos_constraints {
>  struct pm_qos_flags {
>  	struct list_head list;
>  	s32 effective_flags;	/* Do not change to 64 bit */
>  };
>  
> +
> +#define FREQ_QOS_MIN_DEFAULT_VALUE	0
> +#define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX
> +
> +enum freq_qos_req_type {
> +	FREQ_QOS_MIN = 1,
> +	FREQ_QOS_MAX,
> +};
> +
> +struct freq_constraints {
> +	struct pm_qos_constraints min_freq;
> +	struct blocking_notifier_head min_freq_notifiers;
> +	struct pm_qos_constraints max_freq;
> +	struct blocking_notifier_head max_freq_notifiers;
> +};
> +
> +struct freq_qos_request {
> +	enum freq_qos_req_type type;
> +	struct plist_node pnode;
> +	struct freq_constraints *qos;
> +};
> +
> +
> +enum dev_pm_qos_req_type {
> +	DEV_PM_QOS_RESUME_LATENCY = 1,
> +	DEV_PM_QOS_LATENCY_TOLERANCE,
> +	DEV_PM_QOS_FLAGS,
> +};
> +
> +struct dev_pm_qos_request {
> +	enum dev_pm_qos_req_type type;
> +	union {
> +		struct plist_node pnode;
> +		struct pm_qos_flags_request flr;
> +	} data;
> +	struct device *dev;
> +};
> +
>  struct dev_pm_qos {
>  	struct pm_qos_constraints resume_latency;
>  	struct pm_qos_constraints latency_tolerance;
>  	struct pm_qos_flags flags;
>  	struct dev_pm_qos_request *resume_latency_req;
> @@ -253,31 +276,10 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
>  {
>  	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>  }
>  #endif
>  
> -#define FREQ_QOS_MIN_DEFAULT_VALUE	0
> -#define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX
> -
> -enum freq_qos_req_type {
> -	FREQ_QOS_MIN = 1,
> -	FREQ_QOS_MAX,
> -};
> -
> -struct freq_constraints {
> -	struct pm_qos_constraints min_freq;
> -	struct blocking_notifier_head min_freq_notifiers;
> -	struct pm_qos_constraints max_freq;
> -	struct blocking_notifier_head max_freq_notifiers;
> -};
> -
> -struct freq_qos_request {
> -	enum freq_qos_req_type type;
> -	struct plist_node pnode;
> -	struct freq_constraints *qos;
> -};
> -
>  static inline int freq_qos_request_active(struct freq_qos_request *req)
>  {
>  	return !IS_ERR_OR_NULL(req->qos);
>  }
>  
> -- 
> 2.17.1
> 

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
