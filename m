Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D217A342343
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 18:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCSR0c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 13:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhCSR00 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 13:26:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84FAC06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 10:26:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso7016448pji.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G2ciI+8gLo1fSwlXD2q75g0c52yk/hMrZ0yweTlh3Wk=;
        b=VcZIRP1tPwWzWYflvDs2QtRdxoWgthJmMjpQFcvI0cw/Oi8U3fDykMwMJHUCRgLwLN
         IHz3cdgeMpGlUNdsWBkf889IaBIr31ob91+6VjKlBUZbqbRwigbvyhVbfasbWmvR5lSa
         t3CWNSy3svupvHUJAS0mJ7ozPSUoiXCBicW70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G2ciI+8gLo1fSwlXD2q75g0c52yk/hMrZ0yweTlh3Wk=;
        b=egoepJumdrIDItSlMYexSfSvSAlAfUKTzv0FAcOZaoNMuWQpMcSkWyLAwscZ/jDClD
         yNWszrMRDQRKC90kVKPbceqYCkUWKkdzHMhBh/NRuVbVINpW2Pzk2ezdDwqPvGXZ3Tl7
         /8CjU5ZS+m9t5NJOM8IJug7H3ksSm7SaKxlI6M68cJ2++no8fj9bYnuJh5FjwXKImzTV
         SPcU4AYgdH99k0VEivwz1kWtmwaA9aAhcv4tgAkpdrM+TJzvl+nA3yHPyoZveFSEocvK
         lspxd+ANH+aC8wMBN1cHMXegtR8dnzgdgkbeaUiXdxpPiEBkVbkYiMjzze4P17QjZb7f
         colg==
X-Gm-Message-State: AOAM533vAxIQq8KpvRG9g/SG+fen8RZX1Fau0fSlTZqLbtQpg40AgEwh
        bPuUlMMmuU2c4/hu7A+5gDWwWw==
X-Google-Smtp-Source: ABdhPJzOKA9F+yXMnxyRNFmJt9DfXWSRK0fZPjEUoInFJxIRVNA3uwgGEl8gbZRw8mSeGT/QAF3Jqw==
X-Received: by 2002:a17:90a:a403:: with SMTP id y3mr10703577pjp.227.1616174786403;
        Fri, 19 Mar 2021 10:26:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r23sm6188880pje.38.2021.03.19.10.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:26:25 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:26:25 -0700
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
Subject: Re: [PATCH v30 11/12] samples/landlock: Add a sandbox manager example
Message-ID: <202103191026.E2F74F8D9@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-12-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204252.427806-12-mic@digikod.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:51PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add a basic sandbox tool to launch a command which can only access a
> list of file hierarchies in a read-only or read-write way.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

I'm very happy to see any example!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
