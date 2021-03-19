Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45329342533
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 19:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhCSSqa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhCSSpp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 14:45:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5C3C06175F
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 11:45:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v3so4297407pgq.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JGY/EqeMUGC+Bt0wZ3nGVTDLepgM3WlnAUKZmdbmQ04=;
        b=BMblp60iEXVdjovxUp1rExGL91YRwQuPg7ex7JypQ4I7GzGU459rL4//OWZYwwYXk1
         vbD6FWRxEj3FEA+nwCLdGAE01jhnkk9hWRSGjaS5U+/niv+lnudUwa5wXNK4WXp8Sc+8
         K5+rT+YUekesYA4H7ZEzBPFgjWkvH2RjmvCE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JGY/EqeMUGC+Bt0wZ3nGVTDLepgM3WlnAUKZmdbmQ04=;
        b=jj5QDP0+SDAiJtFNh3HGiw9k63C/VHqOAjN5wlXLSFM62nePt3D4MYoK9OySUrZZRa
         WuW8utdAeqiNz3rPWI4QOQa4SH/WFiuUQ1ouaR+4jbDxRU+ygbxM2+myrJ5PO/qmlWlW
         mLC0/GTgKatOce5Pou4R3ZlGxOX24m3gdpn9ybriFaMy2Mjo7/vGcZRgzh7mFFAoxhWZ
         PMQ7a2psglKvbL5rhZBDSUhSQYysjoHPzgJwuVo1oyckYNB6AUhAqWOrGPpv2SbhkJ9q
         Bjy0iFnp9JiYu+OS16KAXbXhGayhOptbzfin1ugXTyJDPwvEaRvV927NNYtcoi6hwM8Q
         uAyA==
X-Gm-Message-State: AOAM533MJ2fsBV+lpNpl5J16aNcX5FipXJgPRRSKVcmNG7lUxJldqs3I
        fsewGoQ14QXLrExQiOOVq2DI7g==
X-Google-Smtp-Source: ABdhPJxnvtZMI8WcSLqJP4CQU2LP1bacblL/FkbqVKRmPz2mN29hO8eLj66oHnTAGfPb6/ukaMAz3Q==
X-Received: by 2002:a63:ff21:: with SMTP id k33mr12313273pgi.379.1616179539760;
        Fri, 19 Mar 2021 11:45:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l10sm5888859pfc.125.2021.03.19.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:45:39 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:45:38 -0700
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
Subject: Re: [PATCH v30 04/12] landlock: Add ptrace restrictions
Message-ID: <202103191145.C8BA4DC@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-5-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204252.427806-5-mic@digikod.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:44PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Using ptrace(2) and related debug features on a target process can lead
> to a privilege escalation.  Indeed, ptrace(2) can be used by an attacker
> to impersonate another task and to remain undetected while performing
> malicious activities.  Thanks to  ptrace_may_access(), various part of
> the kernel can check if a tracer is more privileged than a tracee.
> 
> A landlocked process has fewer privileges than a non-landlocked process
> and must then be subject to additional restrictions when manipulating
> processes. To be allowed to use ptrace(2) and related syscalls on a
> target process, a landlocked process must have a subset of the target
> process's rules (i.e. the tracee must be in a sub-domain of the tracer).
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
