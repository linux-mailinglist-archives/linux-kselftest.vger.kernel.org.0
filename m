Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3C228DE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 04:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgGVCMm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 22:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbgGVCMl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 22:12:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA76CC0619DB
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 19:12:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so370558pgm.11
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9rx2ICY1n/mQSkvQxm3DqiqKMym6DrzmjM7s6SFLwEo=;
        b=atGnOu7xHD1d7gov5LcXUyObLmqvtY+NKSNPa6d6jiajFGLijXYs76qCGG2MyxBXpt
         B4bCLJke54FioXB7TsLyXbctIuODAyg16qUDhNP9VyX7cVOdVgazx2VRtEkJCvESrShA
         D5FCyYUeM4oFS5jlVeUgWWTs6v7LIjj7XbbAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9rx2ICY1n/mQSkvQxm3DqiqKMym6DrzmjM7s6SFLwEo=;
        b=LcQmURw9JHseeAShPzhJ3XHJQd29zEFS6AGaEMnK6SJb3k2uuaC46RLWqZvBdkPrvn
         l5cgKQWgkEj46g+/kb2fj6iCO50eyxZ0nOO9XkKgj74gQPiLRRFPPjWCKDVwAtDc5Jjp
         +15Ut20QbCjKdfyD57TXw6H8xAxW3qV4ks5r4ElS6gNamZZa2x8pAaxKiTtzinAcimge
         qTafwpau+zqbFiZtVTKWS4cdYxma7nVGTigi2+3ahCJ+P1vmyBgD+EcrDKiTPYrV7UaY
         wGeVTjm0YhDInvpSaEnSYHxF6aF9nD2lx0XeSfIaUC6TAYLFYufEYhcPpzNAf5fUQXP/
         hauQ==
X-Gm-Message-State: AOAM5326sb3a4AZoDheYEIr4jgd/fXy3tkZd5enF3hNiKgs0ecRw88MD
        ZzruUDN3P8hNZoKspb6uxJoDjw==
X-Google-Smtp-Source: ABdhPJxqnoNNPu7Gh1zJCb1n8eFvBd5/4XYBGHD0TD6QA8KDFgS1fU3XMMQqJud4CqpFOVMOBEqe9Q==
X-Received: by 2002:a62:cd89:: with SMTP id o131mr26386979pfg.195.1595383961041;
        Tue, 21 Jul 2020 19:12:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i67sm22574975pfg.13.2020.07.21.19.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:12:40 -0700 (PDT)
Date:   Tue, 21 Jul 2020 19:12:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: Convert test_user_copy to KUnit test
Message-ID: <202007211911.666E080@keescook>
References: <20200721174654.72132-1-vitor@massaru.org>
 <202007211207.5BAA9D8D@keescook>
 <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 21, 2020 at 07:19:12PM -0300, Vitor Massaru Iha wrote:
> When you talk about end-of-test summary, is it what is written in
> dmesg and not the kunit-tool?

Right, if I build this as a module and do "modprobe user_copy_kunit",
what will show up in dmesg?

-- 
Kees Cook
