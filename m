Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB0546C260
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhLGSMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 13:12:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:42956 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhLGSM3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 13:12:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="217668646"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="217668646"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:36:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="657784068"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:36:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mueNf-003J9g-0y;
        Tue, 07 Dec 2021 19:35:55 +0200
Date:   Tue, 7 Dec 2021 19:35:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, srinivas.pandruvada@intel.com,
        shuah@kernel.org, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <Ya+beiuKrqFjNkEH@smile.fi.intel.com>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207171448.799376-3-david.e.box@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 07, 2021 at 09:14:44AM -0800, David E. Box wrote:
> Adds get/set driver data helpers for auxiliary devices.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>
> ---
> V2
>   - No changes
> 
>  include/linux/auxiliary_bus.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index fc51d45f106b..a8338d456e81 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -28,6 +28,16 @@ struct auxiliary_driver {
>  	const struct auxiliary_device_id *id_table;
>  };
>  
> +static inline void *auxiliary_get_drvdata(struct auxiliary_device *auxdev)
> +{
> +	return dev_get_drvdata(&auxdev->dev);
> +}
> +
> +static inline void auxiliary_set_drvdata(struct auxiliary_device *auxdev, void *data)
> +{
> +	dev_set_drvdata(&auxdev->dev, data);
> +}
> +
>  static inline struct auxiliary_device *to_auxiliary_dev(struct device *dev)
>  {
>  	return container_of(dev, struct auxiliary_device, dev);
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


