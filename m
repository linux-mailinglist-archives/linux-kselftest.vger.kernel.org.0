Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE46217C0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 02:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgGHADy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 20:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgGHADy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 20:03:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F318CC08C5E1
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jul 2020 17:03:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k27so4689990pgm.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jul 2020 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XdUaPDr56t2dB8W61mELkwj0Skn6S5S4z+Vsl/tJuD4=;
        b=VTUdIfdQiK5zHvzFtK8tbyfXjd+nD6axR+vPnmGSSkNh1E+1ZiM7M9DC1CsxyMf2wt
         b2v8jrBY52b2jGsd26dV33M2EUP/T2e2Dgnx6h0zwboF2A1izvEz03TmfgImJCv+hVe9
         ZK3sk7xEQSZ9B1SsC6/oLqAPlJT5zW/upU9BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdUaPDr56t2dB8W61mELkwj0Skn6S5S4z+Vsl/tJuD4=;
        b=VFFPQe01haarJt0o7J9h/QD5iHqvLmObOpXv4aXqdm1YuRPomHTq0S7WlIryRxoc1m
         ScJfiaBs6s4Ed9mv9MtIQEXvxn4pSurD7CCAQuA1fr6sAUpQM0vaHS9DRg3oQM3TjFV6
         AB2Z+XrAE+CF7Zi5wqCgPNnQdpLhP1NB8UvJMVgJLAVaKU9x7GoV/1nJHlwEDBVM8yRc
         OIO1OeVaUWiexaD7lgtttxdPZ52Dvx7KTv3aMt2HlG8/w22WdfEaEDA/vNv3OxwmpV1Z
         QND6ZiGI+kTBRddtMKAcHUxw9bec701BW5I0zw/OPe0AazisuVbq5L//VavLhe46+g/b
         cwmA==
X-Gm-Message-State: AOAM5328KRBFdXNV57tw77ZznD2tP8Gc/S5LedtIBCTe+q65E4+JPT/B
        sbsJoOp4ODlW+gJamTrxy191+Q==
X-Google-Smtp-Source: ABdhPJzlB+wnA820KsXyKDpkiqDz27omyRVHEG+75x1JqbwOpWvyP8oemaSGQaQclki+9QkvXKv2uA==
X-Received: by 2002:a62:f202:: with SMTP id m2mr39784579pfh.157.1594166631916;
        Tue, 07 Jul 2020 17:03:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 27sm3417389pjg.19.2020.07.07.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 17:03:51 -0700 (PDT)
Date:   Tue, 7 Jul 2020 17:03:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v10 7/9] misc: bcm-vk: add Broadcom VK driver
Message-ID: <202007071700.C567BA7B@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-8-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706232309.12010-8-scott.branden@broadcom.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 06, 2020 at 04:23:07PM -0700, Scott Branden wrote:
> Add Broadcom VK driver offload engine.
> This driver interfaces to the VK PCIe offload engine to perform
> should offload functions as video transcoding on multiple streams
> in parallel.  VK device is booted from files loaded using
> request_firmware_into_buf mechanism.  After booted card status is updated
> and messages can then be sent to the card.
> Such messages contain scatter gather list of addresses
> to pull data from the host to perform operations on.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>

nit: your S-o-b chain doesn't make sense (I would expect you at the end
since you're sending it and showing as the Author). Is it Co-developed-by?
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> [...]
> +
> +		max_buf = SZ_4M;
> +		bufp = dma_alloc_coherent(dev,
> +					  max_buf,
> +					  &boot_dma_addr, GFP_KERNEL);
> +		if (!bufp) {
> +			dev_err(dev, "Error allocating 0x%zx\n", max_buf);
> +			ret = -ENOMEM;
> +			goto err_buf_out;
> +		}
> +
> +		bcm_vk_buf_notify(vk, bufp, boot_dma_addr, max_buf);
> +	} else {
> +		dev_err(dev, "Error invalid image type 0x%x\n", load_type);
> +		ret = -EINVAL;
> +		goto err_buf_out;
> +	}
> +
> +	ret = request_partial_firmware_into_buf(&fw, filename, dev,
> +						bufp, max_buf, 0);

Unless I don't understand what's happening here, this needs to be
reordered if you're going to keep Mimi happy and disallow the device
being able to see the firmware before it has been verified. (i.e. please
load the firmware before mapping DMA across the buffer.)

-- 
Kees Cook
