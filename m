Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF264D465
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 01:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiLOANN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 19:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLOAMm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 19:12:42 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA9E0F9
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:08:29 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a9so5119051pld.7
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4/QZI1b9BuX09J6n+wRULrAcCHBLRMc57Wa6cWYocm8=;
        b=Wzg4FSPkMKRRRymHOhnFtx/uU+954Ka/2q+TGUz8LCNuqKtyxXNza/SUzgyRSht8Yu
         pYECEzcWeYbJFvm5+Mskz4amT5qYPptMoWlmBw6QHeEPYgXGSUOcC4B5nmigD5eI/bLr
         hH8153HNw5wyiNl3Xoe4FZOUUFmeU83Q+zrLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/QZI1b9BuX09J6n+wRULrAcCHBLRMc57Wa6cWYocm8=;
        b=Cwaxz4p1GgHx2QEP2F2KdXVrdJ1MuT6+nYaqC4kVrPVObDwVVCcDVwZAo+bFN+cWp8
         6FFeq4oJWsH1OHf+r2/70xuH2BzrXzDz4wPD8EcOma6vtxie9UD5p/CiOvYRFuqpwjlJ
         fCvNpd904rC25d1R8jKESBMu5COXvys2IcPwRPibDcCffW8shpzFMMzUgwZkfcCr62L+
         ZALWuBFsEhdixzZKlaP/6FoZ0fFkrisj5ubfHHSV8dB6LhtGJzVLZ89n+S86Zpl0gHVV
         TrxaWmBiZXCFV/tLtzfBICFOUsgZajh3drY5io4TjZKe9r6LL2e87EGj351oX7nHhoec
         49hQ==
X-Gm-Message-State: ANoB5pn1NiSz73a2+rS47TpkbWJ2+zpknwJFhB2nRrFxCCYxNa/cYsmW
        MBWgZrjmtpWgT5vN1PgK643FzQ==
X-Google-Smtp-Source: AA0mqf5mW27dLgxQNaTm44+KabAsGNHUSGUXlQnLRIn9jXbgYMKGtUuoV8/lZ1AmsVgq54rAF6sJEA==
X-Received: by 2002:a17:90a:788f:b0:218:7744:72f9 with SMTP id x15-20020a17090a788f00b00218774472f9mr27145347pjk.26.1671062908706;
        Wed, 14 Dec 2022 16:08:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oa9-20020a17090b1bc900b0020a81cf4a9asm1921231pjb.14.2022.12.14.16.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:08:28 -0800 (PST)
Date:   Wed, 14 Dec 2022 16:08:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212141607.D2D986C076@keescook>
References: <20221209160453.3246150-1-jeffxu@google.com>
 <202212141053.7F5D1F6@keescook>
 <CALmYWFss4hGOgJaeah8p7q86xmE7AOwOazxggGCuY=A+ZUVWhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFss4hGOgJaeah8p7q86xmE7AOwOazxggGCuY=A+ZUVWhQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 14, 2022 at 03:32:16PM -0800, Jeff Xu wrote:
> On Wed, Dec 14, 2022 at 10:54 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Dec 09, 2022 at 04:04:47PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@google.com>
> > >
> > > Since Linux introduced the memfd feature, memfd have always had their
> > > execute bit set, and the memfd_create() syscall doesn't allow setting
> > > it differently.
> > >
> > > However, in a secure by default system, such as ChromeOS, (where all
> > > executables should come from the rootfs, which is protected by Verified
> > > boot), this executable nature of memfd opens a door for NoExec bypass
> > > and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
> > > process created a memfd to share the content with an external process,
> > > however the memfd is overwritten and used for executing arbitrary code
> > > and root escalation. [2] lists more VRP in this kind.
> > >
> > > On the other hand, executable memfd has its legit use, runc uses memfd’s
> > > seal and executable feature to copy the contents of the binary then
> > > execute them, for such system, we need a solution to differentiate runc's
> > > use of  executable memfds and an attacker's [3].
> > >
> > > To address those above, this set of patches add following:
> > > 1> Let memfd_create() set X bit at creation time.
> > > 2> Let memfd to be sealed for modifying X bit.
> > > 3> A new pid namespace sysctl: vm.memfd_noexec to control the behavior of
> > >    X bit.For example, if a container has vm.memfd_noexec=2, then
> > >    memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> > > 4> A new security hook in memfd_create(). This make it possible to a new
> > > LSM, which rejects or allows executable memfd based on its security policy.
> >
> > I think patch 1-5 look good to land. The LSM hook seems separable, and
> > could continue on its own. Thoughts?
> >
> Agreed.
> 
> > (Which tree should memfd change go through?)
> >
> I'm not sure, is there a recommendation ?

It looks like it's traditionally through akpm's tree. Andrew, will you
carry patches 1-5?

Thanks!

-- 
Kees Cook
