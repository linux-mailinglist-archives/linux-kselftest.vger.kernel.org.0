Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33434A082
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Mar 2021 05:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCZEay (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Mar 2021 00:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhCZEa2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Mar 2021 00:30:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B89C0613D7
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Mar 2021 21:30:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ha17so1981925pjb.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Mar 2021 21:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BOYVi/+atNY4w5a1Eu4AFIfXG1/kriVH66pesNImX2Q=;
        b=Gt0kpo1iHDKszZFpT+Ko0aQvJV+MsUOHDLUaIYJ1Q9zDa/TrEbIi78eqXX6WSu6GX7
         pfRyJz2XC0x5LcOpkmHrIji2a8gZ0UyaNJuQmQkFZtr1MsmTrWXI9hJ4wj7KlwhwdP8r
         3TujOSNdRk4l0XyOTFl+8w69IEFt6kj94zI3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BOYVi/+atNY4w5a1Eu4AFIfXG1/kriVH66pesNImX2Q=;
        b=VXKfvqJbBtBTC8WTZ5A2V6WiPigOypKdwgsBbLv2sMfmy6nJmGBLThLOrHT3KxidOD
         8wH5mH5kNoGEKogDzjYjqVQZcdrYDRis/0kyIR2nIIkQ4hkZsjsEseeumzYGUFw8TL2R
         y4nkmU9vrnQ47pa58g2J8DGk9Ls9r2ZFzR7XQ+dwzLYQkhgbKsuY4EfL9ohyzpEniq9s
         l90uyOr/lVymHV16CRTzuuvfVeCs355aOjRbsSqhmg5vO9NZMC2SO1YqwfSPj5uPHfNt
         84jOk6jGNLDIUNeNBVAWOj/ehnbPZqB5AXiWpc/q6J2qFeibegs02i2rKjmSVhC76WLb
         T61w==
X-Gm-Message-State: AOAM532CbHjlvE+84wcEYPfHxbYxwVDyQav6RL98kgAvSuyNUy6tBtvZ
        nnvjqRHRuSnYU9XsALoFyw+aYA==
X-Google-Smtp-Source: ABdhPJxORFz8+uxcEeMqmif00hsBXABZprC7wNExOBK8tI1Vw3fwRZI2qlUPU6jEh98HY5uxsdvogA==
X-Received: by 2002:a17:90a:cc0b:: with SMTP id b11mr12101951pju.216.1616733027910;
        Thu, 25 Mar 2021 21:30:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q14sm7482326pff.94.2021.03.25.21.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 21:30:27 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:30:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v31 12/12] landlock: Add user and kernel documentation
Message-ID: <202103252130.C629319B86@keescook>
References: <20210324191520.125779-1-mic@digikod.net>
 <20210324191520.125779-13-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324191520.125779-13-mic@digikod.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 24, 2021 at 08:15:20PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add a first document describing userspace API: how to define and enforce
> a Landlock security policy.  This is explained with a simple example.
> The Landlock system calls are described with their expected behavior and
> current limitations.
> 
> Another document is dedicated to kernel developers, describing guiding
> principles and some important kernel structures.
> 
> This documentation can be built with the Sphinx framework.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Thanks for the changes!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
