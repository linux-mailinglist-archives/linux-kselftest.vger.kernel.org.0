Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF75B217BF5
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 01:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgGGX7C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgGGX7C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 19:59:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1327BC08C5E1
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jul 2020 16:59:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so8871199pfh.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jul 2020 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rdv9aWYxdWzi7YuZEHxXGYFHP62AjpgpR6iHCVdleuI=;
        b=E5Bv52U3XPTKQk/JUCHmdsxbrjEBV7kFdiIQaCyIgOqHSS133VrkT0uweCNwnEouhB
         D6ChoBGorNNXQRd5vuzzcx1j8GUi9ZQpXJ/p70YeFpe/j26iafcL6ByrwDGUqHuT5A/I
         RFDzv7/AV7eJ4KbBcjAjcMhpYwiZT3d6/TEnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdv9aWYxdWzi7YuZEHxXGYFHP62AjpgpR6iHCVdleuI=;
        b=pO/YNX6XvthnyxWwYYf2FOj5frOt63OFCD41/Ws/T+8s6eMKXUpIjYeUHnSJC9Li0x
         sM7Ow8rHR7reXwDAqO5aqC2S3iebNIKYSWe7VzeKEt5Gv73lulk1sHKCvXtHknm9+z1m
         IT4S0VkPxCxjGRwoI1zh0n/18DFnqa/pPN+vmBUW1OAiKqWF5wEIVVt8TWZ7QPfzgCDD
         /zQ4TaJfJy8xo0Nr3gXkvrwZnpllmkC5QeMRqgA1JSEa9hURPibxMfRIzJNe8ofHPo0L
         awOzoZhBCYK7ikS8OPgxmMuIyQAoqk1Ea6haMoAkRoDDvX4cLykH/nSoRo3xIlcaP976
         G9ZA==
X-Gm-Message-State: AOAM533PJ73AfP+EJt9wCsRROH1U5h5kNu/UmtdGVLDssgM8yVXaQ4wX
        9zbXxkoOMgy8ATF3YywMtbtWzA==
X-Google-Smtp-Source: ABdhPJzYvJrtZ8JwyO03TQIq0tpFYVl2WHcKj9p5wk7nKZXNGQu8Fct93qp7eRhs4GS/cWugEjuxmw==
X-Received: by 2002:a62:404:: with SMTP id 4mr53377463pfe.133.1594166341548;
        Tue, 07 Jul 2020 16:59:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w123sm15793025pfd.2.2020.07.07.16.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:59:00 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:58:59 -0700
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
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 3/9] firmware: add request_partial_firmware_into_buf
Message-ID: <202007071657.55C2CFA57@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-4-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706232309.12010-4-scott.branden@broadcom.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 06, 2020 at 04:23:03PM -0700, Scott Branden wrote:
> Add request_partial_firmware_into_buf to allow for portions
> of firmware file to be read into a buffer.  Necessary where firmware
> needs to be loaded in portions from file in memory constrained systems.

Just tear out the differing "id" and just use FW_OPT_PARTIAL and I think
if Luis is happy, you're all set.

-- 
Kees Cook
