Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB45132E10
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 19:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgAGSMo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 13:12:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40710 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgAGSMn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 13:12:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so251441pfh.7
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2020 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=otNEfPZRhfkH889yZruDaz8ZPdXQW2OeMKDCutsW3ng=;
        b=EGIHk2y8X43q+dSv8uJDGfXbIXgfrsvaXk3EkCjao8JZyS6xL3yyYa/IPsSxKx7I/8
         OZLFuBfwTr+9/eEGtHS7pPYUOArjVm9BVeCqWXH460W3KfIdq00ZZnwox4+RJdvlEP5X
         pUm+kxpQ6C9u3/4s26HyNZoDVnj1J0J8D05Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=otNEfPZRhfkH889yZruDaz8ZPdXQW2OeMKDCutsW3ng=;
        b=J6l/r6bLeolPUk29Y5R//+ubvWqNx6MTXe+tQR8Sr0y4jkL7JzNXgHv+56sHPZIlx3
         PPTRKv5ttg0IabcXDzNinhD2iFcJSqHw6s0hujgmP36K8FadUinjHx/qLtfiCx3XCZCM
         vS1Sys5IRa/C5zFjwEuJmFCPo7W+q95ZFpQYtGr2qdLUmPPDMxzGEBB3+YS2y9QiLqov
         h+n4+PdDPxR9NykTH6tgPNG8Fw7aIa5IDTnzZ7bTpRnCmlHiugg1V2OKGYb8x0VkgnhK
         9Y16NK75HOQZrJJnNGzroUZ35vjTXMA+n3m1FHY3s+z6k6oCV2MlIh3zrDJFiy8UJ1vg
         EPpQ==
X-Gm-Message-State: APjAAAX3Q7lJvT0qxc7wkaYmZ2atKSV+GTRjT2EWiZFtH2PNBni+zZu6
        J+mu9TP9xLrz5eoyhTXC/ZnPaQ==
X-Google-Smtp-Source: APXvYqwOo+HzjTqist30x982uq+NRP2n7KSTQc6r6187ME5VXodlSE2JU9i1b2bbt/FBtxQZvAtBqw==
X-Received: by 2002:a63:184d:: with SMTP id 13mr790298pgy.132.1578420761599;
        Tue, 07 Jan 2020 10:12:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7sm200377pfh.128.2020.01.07.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:12:40 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:12:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/7] arm64: Implement copy_thread_tls
Message-ID: <202001071011.9517D9C0D@keescook>
References: <20200102172413.654385-1-amanieu@gmail.com>
 <20200102172413.654385-3-amanieu@gmail.com>
 <20200102180130.hmpipoiiu3zsl2d6@wittgenstein>
 <20200106173953.GB9676@willie-the-truck>
 <CA+y5pbSBYLvZ46nJP0pSYZnRohtPxHitOHPEaLXq23-QrPKk2g@mail.gmail.com>
 <20200107090219.jl4py4u2zvofwnbh@wittgenstein>
 <20200107174508.GC32009@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107174508.GC32009@willie-the-truck>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 07, 2020 at 05:45:09PM +0000, Will Deacon wrote:
> On Tue, Jan 07, 2020 at 10:02:27AM +0100, Christian Brauner wrote:
> > [Cc Kees in case he knows something about where arch specific tests live
> >  or whether we have a framework for this]
> > [...]
> > It feels like we must've run into the "this is architecture
> > specific"-and-we-want-to-test-this issue before... Do we have a place
> > where architecture specific selftests live?
> 
> For arch-specific selftests there are tools/testing/selftests/$ARCH
> directories, although in this case maybe it's better to have an #ifdef
> in a header so that architectures with __builtin_thread_pointer can use
> that.

Yup, I agree: that's the current best-practice for arch-specific
selftests.

-- 
Kees Cook
