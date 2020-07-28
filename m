Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE12312EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 21:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbgG1Tlq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732917AbgG1Tlp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 15:41:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D041C0619D4
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jul 2020 12:41:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t15so523392pjq.5
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jul 2020 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W/yJD4WINhIYjHDSpnZ6fTxiwzLWXNf1PH2+o88F2eI=;
        b=k5XgwmE9tcOSmpNhY4WIUOwltfP1nOlJSUDS0n99vkcl8B8YnMUbPDxe7YGTs1mMQr
         76iSMntY5i+fw5H/RDUwlQ0I8nd8NuTI/QS+tkBn1s8zi+fMQktc83D3xj8tuEDdbWc1
         SPGIc7GDjQULMKCEbKzwKWRabOT0dDEOWSj6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W/yJD4WINhIYjHDSpnZ6fTxiwzLWXNf1PH2+o88F2eI=;
        b=Zzc01sBBj9CPFw3WMVpd85jBM9C8WaSaee5h7onHQJN+VoiDQwBsx0rwWsi6JuJ6Wh
         6Q+f31YuYa3yRXTZbc7DGkb7Z/hnmbTAf+2qsZjIYpmj0LNPRZNmk9IhUi0+TlBtP1ha
         BHysECGtI3gqcj/dg9hAiJIFelGafIfLC16PbfY9Ou2+zE2qvAzfrto7FwNzuRbOVpci
         UI/P8zvjqmhl/EhxOIxAQYi50qSECPgEDuq69BjG4ETi14AJYauoS8V3rSMqS+EfKuah
         tBK6r9b9JZSPO8j6svmDTAOsOSyZMsPYOYZO7ooePaboD/vBOgGrfFCd/1mr3UQXPe2C
         opVw==
X-Gm-Message-State: AOAM531hbyQVlDZcYfIwwK4SyP7AT0FBjDDI2nPtr6DRN0RcwiQPKWoL
        W+EZVKWuoQSYFDfLL4PdXmeo5w==
X-Google-Smtp-Source: ABdhPJwA0Ct0Nh8rwlpqpca69OHRybL5jNVCYyJwjUessWHEG/MKS2+KIDWm6SaEJTBcGdmRE084Kg==
X-Received: by 2002:a17:902:7244:: with SMTP id c4mr2350434pll.277.1595965304901;
        Tue, 28 Jul 2020 12:41:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j36sm19509082pgj.39.2020.07.28.12.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:41:43 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:41:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/19] LSM: Introduce kernel_post_load_data() hook
Message-ID: <202007281240.4EDD6D2E7B@keescook>
References: <20200724213640.389191-1-keescook@chromium.org>
 <20200724213640.389191-12-keescook@chromium.org>
 <1595846951.4841.61.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595846951.4841.61.camel@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 27, 2020 at 06:49:11AM -0400, Mimi Zohar wrote:
> On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> > There are a few places in the kernel where LSMs would like to have
> > visibility into the contents of a kernel buffer that has been loaded or
> > read. While security_kernel_post_read_file() (which includes the
> > buffer) exists as a pairing for security_kernel_read_file(), no such
> > hook exists to pair with security_kernel_load_data().
> > 
> > Earlier proposals for just using security_kernel_post_read_file() with a
> > NULL file argument were rejected (i.e. "file" should always be valid for
> > the security_..._file hooks, but it appears at least one case was
> > left in the kernel during earlier refactoring. (This will be fixed in
> > a subsequent patch.)
> > 
> > Since not all cases of security_kernel_load_data() can have a single
> > contiguous buffer made available to the LSM hook (e.g. kexec image
> > segments are separately loaded), there needs to be a way for the LSM to
> > reason about its expectations of the hook coverage. In order to handle
> > this, add a "contents" argument to the "kernel_load_data" hook that
> > indicates if the newly added "kernel_post_load_data" hook will be called
> > with the full contents once loaded. That way, LSMs requiring full contents
> > can choose to unilaterally reject "kernel_load_data" with contents=false
> > (which is effectively the existing hook coverage), but when contents=true
> > they can allow it and later evaluate the "kernel_post_load_data" hook
> > once the buffer is loaded.
> > 
> > With this change, LSMs can gain coverage over non-file-backed data loads
> > (e.g. init_module(2) and firmware userspace helper), which will happen
> > in subsequent patches.
> > 
> > Additionally prepare IMA to start processing these cases.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> At least from an IMA perspective, the original
> security_kernel_load_data() hook was defined in order to prevent
> certain syscalls - init_module, kexec_load - and loading firmware via
> sysfs.  The resulting error messages were generic.
>   
> Unlike security_kernel_load_data(), security_kernel_post_load_data()
> is meant to be used, but without a file desciptor specific
> information, like the filename associated with the buffer, is missing.
>  Having the filename isn't actually necessary for verifying the
> appended signature, but it is needed for auditing signature
> verification failures and including in the IMA measurement list.

Right -- I'm open to ideas on this, but as it stands, other LSMs (e.g.
BPF LSM) can benefit from the security_kernel_post_load_data() to
examine the contents, etc.

Is there anything that needs to change in this patch?

-- 
Kees Cook
