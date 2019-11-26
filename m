Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9403810A5BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 22:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZVBf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 16:01:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39251 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZVBf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 16:01:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so7297738pga.6
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 13:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n9+15kW1fXPH1gcYh1ndHqY4WDW+ziUzi1CRsMcSLPc=;
        b=EZ7S7WCKFn8c+ujV3klPjacvkVwbJOr7J/xb55cuQOl7tTVm6u5qpPCDztfrXkOVOr
         PtP3sLDm2rq8NCNh92RdGWh+IJ/hj/Ty5fuBwoODzF3GyzKhkWCHiLUJLe4GHvlnkH3n
         1lxZP0GSLO9BNFA6KoA/1d77Fm7ASYOWLJgbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9+15kW1fXPH1gcYh1ndHqY4WDW+ziUzi1CRsMcSLPc=;
        b=A0vgK9DDlkfnugkS1L0w1QcvOSi2JtMsj1/rDzs0ovhNI/izs3v+iqxcY+FrcIUxjC
         diZYpiu1DCp7WChpYSRz1O+KjKZjTDaLP7FIdYBqGZ7W0rZtUDVESb1SstJ0fy961LpH
         nN2BgZReBnC3GVZfrrxNXFxKQTdZ6xJoIcRPAXJsmy8Y/Mt+xpRKNn9YqsmifRTu+osB
         WzYUABqj3bU5u9oZC3IvIy9Wvr8dXjLrPUsacHU+wH+kp1/cfb1h7C3qjnCTRZkusA0j
         nst/xfrGPx17mR2svyp7deIKzYrhTISFacBw0bDIG1urs8ARrOiBtOQFFnZSRZaWsGhI
         3Hxg==
X-Gm-Message-State: APjAAAW7M6KDQuoKTFjGIoH1pcJ4OOEKpajLZCd+4Sfpd/WRJG7DzXCQ
        oENc1eS3MgeHhx5632Z0Ty7ccw==
X-Google-Smtp-Source: APXvYqwpqSfOOzlAA99rsH+xk9rnMdYHVBoqyYHPv4kb3hbVx9TFEfg5Hdh5ltTR6UQsSlnJoZ2/pw==
X-Received: by 2002:a63:fb03:: with SMTP id o3mr565465pgh.378.1574802092568;
        Tue, 26 Nov 2019 13:01:32 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a13sm13464295pfi.187.2019.11.26.13.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 13:01:31 -0800 (PST)
Date:   Tue, 26 Nov 2019 13:01:30 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v4 4/4] PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Message-ID: <20191126210130.GE228856@google.com>
References: <cover.1574781196.git.leonard.crestez@nxp.com>
 <44cfaddb5be6403f687a0e56e57f17925b9a521b.1574781196.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44cfaddb5be6403f687a0e56e57f17925b9a521b.1574781196.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 26, 2019 at 05:17:13PM +0200, Leonard Crestez wrote:
> Support for adding per-device frequency limits was removed in
> commit 2aac8bdf7a0f ("PM: QoS: Drop frequency QoS types from device PM QoS")
> after cpufreq switched to use a new "freq_constraints" construct.
> 
> Restore support for per-device freq limits but base this upon
> freq_constraints. This is primarily meant to be used by the devfreq
> subsystem.
> 
> This removes the "static" marking on freq_qos_apply but does not export
> it for modules.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/base/power/qos.c | 73 ++++++++++++++++++++++++++++++++++++----
>  include/linux/pm_qos.h   | 12 +++++++
>  kernel/power/qos.c       |  4 ++-
>  3 files changed, 82 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 350dcafd751f..8e93167f1783 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -113,14 +113,24 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
>  	unsigned long flags;
>  	s32 ret;
>  
>  	spin_lock_irqsave(&dev->power.lock, flags);
>  
> -	if (type == DEV_PM_QOS_RESUME_LATENCY) {
> +	switch (type) {
> +	case DEV_PM_QOS_RESUME_LATENCY:
>  		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
>  			: pm_qos_read_value(&qos->resume_latency);
> -	} else {
> +		break;
> +	case DEV_PM_QOS_MIN_FREQUENCY:
> +		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE
> +			: freq_qos_read_value(&qos->freq, FREQ_QOS_MIN);
> +		break;
> +	case DEV_PM_QOS_MAX_FREQUENCY:
> +		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE
> +			: freq_qos_read_value(&qos->freq, FREQ_QOS_MAX);
> +		break;
> +	default:
>  		WARN_ON(1);
>  		ret = 0;
>  	}
>  
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
> @@ -157,10 +167,14 @@ static int apply_constraint(struct dev_pm_qos_request *req,
>  		if (ret) {
>  			value = pm_qos_read_value(&qos->latency_tolerance);
>  			req->dev->power.set_latency_tolerance(req->dev, value);
>  		}
>  		break;
> +	case DEV_PM_QOS_MIN_FREQUENCY:
> +	case DEV_PM_QOS_MAX_FREQUENCY:
> +		ret = freq_qos_apply(&req->data.freq, action, value);
> +		break;
>  	case DEV_PM_QOS_FLAGS:
>  		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
>  					  action, value);
>  		break;
>  	default:
> @@ -207,10 +221,12 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>  	c->target_value = PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE;
>  	c->default_value = PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE;
>  	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
>  	c->type = PM_QOS_MIN;
>  
> +	freq_constraints_init(&qos->freq);
> +
>  	INIT_LIST_HEAD(&qos->flags.list);
>  
>  	spin_lock_irq(&dev->power.lock);
>  	dev->power.qos = qos;
>  	spin_unlock_irq(&dev->power.lock);
> @@ -267,10 +283,24 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>  	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
>  		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
>  		memset(req, 0, sizeof(*req));
>  	}
>  
> +	c = &qos->freq.min_freq;
> +	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
> +		apply_constraint(req, PM_QOS_REMOVE_REQ,
> +				 PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
> +		memset(req, 0, sizeof(*req));
> +	}
> +
> +	c = &qos->freq.max_freq;
> +	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
> +		apply_constraint(req, PM_QOS_REMOVE_REQ,
> +				 PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> +		memset(req, 0, sizeof(*req));
> +	}
> +

nit: these loops look a bit redundant, might be worth to encapsulate them in a
macro.

>  	f = &qos->flags;
>  	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
>  		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
>  		memset(req, 0, sizeof(*req));
>  	}
> @@ -312,15 +342,26 @@ static int __dev_pm_qos_add_request(struct device *dev,
>  		ret = -ENODEV;
>  	else if (!dev->power.qos)
>  		ret = dev_pm_qos_constraints_allocate(dev);
>  
>  	trace_dev_pm_qos_add_request(dev_name(dev), type, value);
> -	if (!ret) {
> -		req->dev = dev;
> -		req->type = type;
> +	if (ret)
> +		return ret;
> +
> +	req->dev = dev;
> +	req->type = type;
> +	if (req->type == DEV_PM_QOS_MIN_FREQUENCY)
> +		ret = freq_qos_add_request(&dev->power.qos->freq,
> +					   &req->data.freq,
> +					   FREQ_QOS_MIN, value);
> +	else if (req->type == DEV_PM_QOS_MAX_FREQUENCY)
> +		ret = freq_qos_add_request(&dev->power.qos->freq,
> +					   &req->data.freq,
> +					   FREQ_QOS_MAX, value);
> +	else
>  		ret = apply_constraint(req, PM_QOS_ADD_REQ, value);
> -	}
> +
>  	return ret;
>  }
>  
>  /**
>   * dev_pm_qos_add_request - inserts new qos request into the list
> @@ -380,10 +421,14 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>  	switch(req->type) {
>  	case DEV_PM_QOS_RESUME_LATENCY:
>  	case DEV_PM_QOS_LATENCY_TOLERANCE:
>  		curr_value = req->data.pnode.prio;
>  		break;
> +	case DEV_PM_QOS_MIN_FREQUENCY:
> +	case DEV_PM_QOS_MAX_FREQUENCY:
> +		curr_value = req->data.freq.pnode.prio;
> +		break;
>  	case DEV_PM_QOS_FLAGS:
>  		curr_value = req->data.flr.flags;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -505,10 +550,18 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
>  	switch (type) {
>  	case DEV_PM_QOS_RESUME_LATENCY:
>  		ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
>  						       notifier);
>  		break;
> +	case DEV_PM_QOS_MIN_FREQUENCY:
> +		ret = freq_qos_add_notifier(&dev->power.qos->freq,
> +					    FREQ_QOS_MIN, notifier);
> +		break;
> +	case DEV_PM_QOS_MAX_FREQUENCY:
> +		ret = freq_qos_add_notifier(&dev->power.qos->freq,
> +					    FREQ_QOS_MAX, notifier);
> +		break;
>  	default:
>  		WARN_ON(1);
>  		ret = -EINVAL;
>  	}
>  
> @@ -544,10 +597,18 @@ int dev_pm_qos_remove_notifier(struct device *dev,
>  	switch (type) {
>  	case DEV_PM_QOS_RESUME_LATENCY:
>  		ret = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
>  							 notifier);
>  		break;
> +	case DEV_PM_QOS_MIN_FREQUENCY:
> +		ret = freq_qos_remove_notifier(&dev->power.qos->freq,
> +					       FREQ_QOS_MIN, notifier);
> +		break;
> +	case DEV_PM_QOS_MAX_FREQUENCY:
> +		ret = freq_qos_remove_notifier(&dev->power.qos->freq,
> +					       FREQ_QOS_MAX, notifier);
> +		break;
>  	default:
>  		WARN_ON(1);
>  		ret = -EINVAL;
>  	}
>  
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 678fec6da5b9..19eafca5680e 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -32,10 +32,12 @@ enum pm_qos_flags_status {
>  #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
>  #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE	PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
>  #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
> +#define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE	0
> +#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE	FREQ_QOS_MAX_DEFAULT_VALUE
>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
>  
>  #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
>  
>  struct pm_qos_request {
> @@ -99,25 +101,29 @@ struct freq_qos_request {
>  
>  
>  enum dev_pm_qos_req_type {
>  	DEV_PM_QOS_RESUME_LATENCY = 1,
>  	DEV_PM_QOS_LATENCY_TOLERANCE,
> +	DEV_PM_QOS_MIN_FREQUENCY,
> +	DEV_PM_QOS_MAX_FREQUENCY,
>  	DEV_PM_QOS_FLAGS,
>  };
>  
>  struct dev_pm_qos_request {
>  	enum dev_pm_qos_req_type type;
>  	union {
>  		struct plist_node pnode;
>  		struct pm_qos_flags_request flr;
> +		struct freq_qos_request freq;
>  	} data;
>  	struct device *dev;
>  };
>  
>  struct dev_pm_qos {
>  	struct pm_qos_constraints resume_latency;
>  	struct pm_qos_constraints latency_tolerance;
> +	struct freq_constraints freq;
>  	struct pm_qos_flags flags;
>  	struct dev_pm_qos_request *resume_latency_req;
>  	struct dev_pm_qos_request *latency_tolerance_req;
>  	struct dev_pm_qos_request *flags_req;
>  };
> @@ -212,10 +218,14 @@ static inline s32 dev_pm_qos_read_value(struct device *dev,
>  					enum dev_pm_qos_req_type type)
>  {
>  	switch (type) {
>  	case DEV_PM_QOS_RESUME_LATENCY:
>  		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +	case DEV_PM_QOS_MIN_FREQUENCY:
> +		return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
> +	case DEV_PM_QOS_MAX_FREQUENCY:
> +		return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
>  	default:
>  		WARN_ON(1);
>  		return 0;
>  	}
>  }
> @@ -291,10 +301,12 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
>  int freq_qos_add_request(struct freq_constraints *qos,
>  			 struct freq_qos_request *req,
>  			 enum freq_qos_req_type type, s32 value);
>  int freq_qos_update_request(struct freq_qos_request *req, s32 new_value);
>  int freq_qos_remove_request(struct freq_qos_request *req);
> +int freq_qos_apply(struct freq_qos_request *req,
> +		   enum pm_qos_req_action action, s32 value);
>  
>  int freq_qos_add_notifier(struct freq_constraints *qos,
>  			  enum freq_qos_req_type type,
>  			  struct notifier_block *notifier);
>  int freq_qos_remove_notifier(struct freq_constraints *qos,
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index a45cba7df0ae..83edf8698118 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -712,12 +712,14 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
>  /**
>   * freq_qos_apply - Add/modify/remove frequency QoS request.
>   * @req: Constraint request to apply.
>   * @action: Action to perform (add/update/remove).
>   * @value: Value to assign to the QoS request.
> + *
> + * This is only meant to be called from inside pm_qos, not drivers.
>   */
> -static int freq_qos_apply(struct freq_qos_request *req,
> +int freq_qos_apply(struct freq_qos_request *req,
>  			  enum pm_qos_req_action action, s32 value)
>  {
>  	int ret;
>  
>  	switch(req->type) {

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
