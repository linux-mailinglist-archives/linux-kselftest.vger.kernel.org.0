Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03B222DD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 23:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgGPV0d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 17:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgGPV0c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 17:26:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9303EC08C5C0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 14:26:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f16so5287699pjt.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S4tbpXgCt+LdJ7QuTPeRA+fObQgUcTw9DSUS/65F4MU=;
        b=Q+l7XoBw5f2LK3rM1sQJQWnlL3rB9WlWIlGX8wcJliWkCXL7b/An6ORKoVML1/iblt
         rN/fJIeuSz/JvolvEkoVoW8pY5n3Vr8gKwzIkpHcWsy+TOAgfExnstbA35+Oq042eszL
         svBipPMeqYFFQ3ZXDRC+lwf74Ck1bA1CuSV4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S4tbpXgCt+LdJ7QuTPeRA+fObQgUcTw9DSUS/65F4MU=;
        b=lXBNYiYkjQ6xgoxWhaxsVf05mEjGIXlDnRnuRTLc3w/RL2vKI4HOCDwfsvXd8l1pzf
         11v0lbBlsdo5L+EMXAOZKSyWlvFgh4OsXjjFtaLaBwLu8FdXOWOA0FvvZXA1Jtl5R+c9
         qYfS7tHpXiA2gvcMO+T/TczRzIZMVeXXMCsvBDMOZHHSaXnvZ7K5L+hr1K5GQA/4iD3h
         S3xJZCgr1P3lKa+N2hIsCorNT+fMvCRef92/GcnQj4Mi7c3Lp5QKdK7LzR4pz2+qYRZJ
         IsQObTH3WbquOUQKnvH7t7QkTtq4qO6XmsRrfZ8shkodFQwTEDia8bBxrN/mzf1+JmA3
         F/EQ==
X-Gm-Message-State: AOAM532TcD8tP4JJ2p9WpjurQqNFn9iCOsxUmC0y7A+ozmkel/z2tdCR
        z4jVlOOR4+0i1RNPDi2tnHVfcA==
X-Google-Smtp-Source: ABdhPJzrR0RdcBtZJSJRLiBbFdf7dfQKH7/AVbiFSUYlX6SFDScxPUr+kPCMIrhmfNQXH2Ai6JS71w==
X-Received: by 2002:a17:902:9692:: with SMTP id n18mr5018526plp.86.1594934792122;
        Thu, 16 Jul 2020 14:26:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u26sm5700644pfn.54.2020.07.16.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 14:26:31 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:26:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, luto@kernel.org, gofmanp@gmail.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace
 redirection
Message-ID: <202007161425.3D9B91DB6@keescook>
References: <20200716193141.4068476-1-krisman@collabora.com>
 <20200716193141.4068476-2-krisman@collabora.com>
 <20200716210601.GN12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716210601.GN12769@casper.infradead.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 10:06:01PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 16, 2020 at 03:31:40PM -0400, Gabriel Krisman Bertazi wrote:
> > selector is an optional pointer to a char-sized userspace memory region
> > that has a key switch for the mechanism. This key switch is set to
> > either PR_SYS_DISPATCH_ON, PR_SYS_DISPATCH_OFF to enable and disable the
> > redirection without calling the kernel.
> > 
> > The feature is meant to be set per-thread and it is disabled on
> > fork/clone/execv.
> 
> Disabled on exec.  Disabled in the child on clone/fork (and vfork, I
> think).
> 
> That means we don't need to worry about it interacting badly with
> a setuid program, right?

Right, that's the intention.

-- 
Kees Cook
