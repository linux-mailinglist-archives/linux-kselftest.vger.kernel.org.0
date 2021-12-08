Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3946CE05
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 08:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhLHHG4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 02:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhLHHG4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 02:06:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFC9C061574;
        Tue,  7 Dec 2021 23:03:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCBB7B8168C;
        Wed,  8 Dec 2021 07:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A29C00446;
        Wed,  8 Dec 2021 07:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638947001;
        bh=61BDRbqt72/j21ziiTqfJ4Zxtxfeh5eTASuLWQWiX9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBLQ9znpA6Vsm3QxkJ7FTcBcO+mwm7o09IppTNlj6AKHyU3uQ9X/9RQ8ZhdUK/iox
         cxzsdGTxQ3hwwGFDxNsUgzbzZWBSMlAwupBsLSxhRNQzJImMI+RMe+KTpZP0KyGrUo
         HM4QvZelLppsRlja/K7oKXFGLL6Z/6Wu9PZX66eCtvxlHLvD+3nGfObCcX9kxhmLXg
         3LxWM6KYr7DRGDMEEOCbo3TBVs+9I7+O2jEXiG/q1mtsLk7z43TJyu3NUuE1xd7uBu
         co3Uv55lA+LBt7frm/uVLj9sFzYnTMrIIi/5eU9zqSCI9DI5dnZS2rYg+9KKU1t6aF
         5L6/JkRJ2bGCQ==
Date:   Wed, 8 Dec 2021 09:03:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbBYtJFQ47UH2h/k@unreal>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207171448.799376-3-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 07, 2021 at 09:14:44AM -0800, David E. Box wrote:
> Adds get/set driver data helpers for auxiliary devices.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>
> ---
> V2
>   - No changes
> 
>  include/linux/auxiliary_bus.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I would really like to see an explanation why such obfuscation is really
needed. dev_*_drvdata() is a standard way to access driver data.

Thanks

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
