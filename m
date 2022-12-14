Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE61564CFC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Dec 2022 19:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbiLNSyq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 13:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbiLNSyn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 13:54:43 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952002A733
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 10:54:42 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 17so4374689pll.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 10:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o2e1a6vpAxQHzaMqe1Zz1YgsBuyNkLZSUPq8vet5Q+E=;
        b=ljRXDQoz8d06UpaHKC+SuGt8xrjQEfQSizAAs+M7Oa0UFCOyc+ZVFVtSu/m47RyC0P
         WJux7UP4wXmjSPCsUwuDwIDa9H/CfAsZyqgqoA57G2Fm50pMq3dHqVuXQUKJBj9giDuO
         9zDWG2mb8TECeq3VFaiiXxcz6/WlWRjsZr/D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2e1a6vpAxQHzaMqe1Zz1YgsBuyNkLZSUPq8vet5Q+E=;
        b=z0CNLBAeGVU4HkJOqFIf4de15VPhHuXOX233ubmy3azwR0b9aQ2hLOST8bMc4AUyt1
         mv7wZPU2k1WJQk/zJGX2W6nOXRq17Q7xYbVoTfVCGmc/yPLKV48ojDKFdbHz05D8NU11
         l3FZ6ifNhffxsV1XCOxonEvsKiXaTKWoG+vKzM9OcpLB+w0qu+y0kFn2RNQZGBiUG2Lf
         DsR0v677GYEZtae+zLM2RlohZYO4/q9bH5PK95i0A1sHJ6dzlJDPf3V6YXq0h/gWAn+0
         lGmNMrwmTQ8P2toyUoe/FnKl2bE32l+haAkVSjYj/A8ubqEEbd2FiXEJm+iiGo0wn/De
         VgMQ==
X-Gm-Message-State: ANoB5pmoeZohFgBxkRRM0yYu9ggYbYsuQgDfrqBhRqstZawQwi20LWki
        WR+TpJRkw7zPbliOAcFLE63hAg==
X-Google-Smtp-Source: AA0mqf5EzxQYQAX02yhiiZgN1ZRrh5wT7FRtFv9+LhYZc4owjG2hoCS8v2lD4r8dZcTHO5Rdw9SJhw==
X-Received: by 2002:a17:90a:6506:b0:214:222:6ed3 with SMTP id i6-20020a17090a650600b0021402226ed3mr27015223pjj.43.1671044082079;
        Wed, 14 Dec 2022 10:54:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090a9d8700b00218f9bd50c7sm1710962pjp.50.2022.12.14.10.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 10:54:41 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:54:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212141053.7F5D1F6@keescook>
References: <20221209160453.3246150-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221209160453.3246150-1-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 09, 2022 at 04:04:47PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Since Linux introduced the memfd feature, memfd have always had their
> execute bit set, and the memfd_create() syscall doesn't allow setting
> it differently.
> 
> However, in a secure by default system, such as ChromeOS, (where all
> executables should come from the rootfs, which is protected by Verified
> boot), this executable nature of memfd opens a door for NoExec bypass
> and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
> process created a memfd to share the content with an external process,
> however the memfd is overwritten and used for executing arbitrary code
> and root escalation. [2] lists more VRP in this kind.
> 
> On the other hand, executable memfd has its legit use, runc uses memfd’s
> seal and executable feature to copy the contents of the binary then
> execute them, for such system, we need a solution to differentiate runc's
> use of  executable memfds and an attacker's [3].
> 
> To address those above, this set of patches add following:
> 1> Let memfd_create() set X bit at creation time.
> 2> Let memfd to be sealed for modifying X bit.
> 3> A new pid namespace sysctl: vm.memfd_noexec to control the behavior of
>    X bit.For example, if a container has vm.memfd_noexec=2, then
>    memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> 4> A new security hook in memfd_create(). This make it possible to a new
> LSM, which rejects or allows executable memfd based on its security policy.

I think patch 1-5 look good to land. The LSM hook seems separable, and
could continue on its own. Thoughts?

(Which tree should memfd change go through?)

-Kees

-- 
Kees Cook
