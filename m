Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0EA2CC67E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgLBTWu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 14:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgLBTWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 14:22:50 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC48C0613D6
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 11:22:10 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so1695880pge.6
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 11:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lco0DNINSJGCQ5gz1Wd3KwpB8K+/NQbPQIeZ40wYkCw=;
        b=Wy0VvcbNtqLND79KrDefD9/V/OLUYIZMVAvegDWaWpdoDQR6TlJjpoa3k6XlzHjexr
         mWlby7ZaJu+1oKDm5/AfkJp4PREEEqe50qDN/4buQ2mMCfr4kF0BQ31XobFU7lE73LG4
         0VxWF6/ytrBbdPGcRct/QUJBSHC7jH7Kj1ZE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lco0DNINSJGCQ5gz1Wd3KwpB8K+/NQbPQIeZ40wYkCw=;
        b=p9ImwCh2staYBfST0q9fQr0wLvInY6RBn1rkTVe4VWc8QYYp3oje0cS98r0426Mo9A
         TRV6491f0YYobAM1sZbxyBBi92LIp2nsIhWYxquXN8LFcCZIkVSwoj9GMXrNZfxArzYb
         ozhDLA69qx0WWcx/38Lwb8y43+azSHU7jgpP8qfXqe1yBFtx4eEMpYqF+1MlRBLP+nFE
         Y1b7A0X/ucSdGUGhaUnwZl9b0vetjBYtGEUWlbEH8pQ2WEOHFSOwF2Pbe+efRAItE6k0
         B8Sw4LKZsCEo96OLuOwwguvK+kUutyTjn6/rh4/6g3tpW0lxIRqrObLBsF8R9wT739bN
         onwQ==
X-Gm-Message-State: AOAM530gg4FgUtNF9ZMYW/gcJTLhR7rvOXr81UIZ8a1tnvZcmBWyLJrL
        AAmWwGrkwkjw3x4UQvnKYWnM+A==
X-Google-Smtp-Source: ABdhPJw4hfo3kX936t+nd257OgXcpWmVtUgDAoXoz+9XRIsSbiZu6wmJ9NWC/BEKJPb+u6DZlwkZQw==
X-Received: by 2002:a63:ca0a:: with SMTP id n10mr1257583pgi.326.1606936930001;
        Wed, 02 Dec 2020 11:22:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gz2sm392210pjb.2.2020.12.02.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:22:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH] selftests/seccomp: Update kernel config
Date:   Wed,  2 Dec 2020 11:22:01 -0800
Message-Id: <160693691416.385374.12450510623933031006.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202162643.249276-1-mic@digikod.net>
References: <20201202162643.249276-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2 Dec 2020 17:26:43 +0100, Mickaël Salaün wrote:
> seccomp_bpf.c uses unshare(CLONE_NEWPID), which requires CONFIG_PID_NS
> to be set.

Applied to for-next/seccomp, thanks!

[1/1] selftests/seccomp: Update kernel config
      https://git.kernel.org/kees/c/2c07343abd89

-- 
Kees Cook

