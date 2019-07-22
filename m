Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6104706A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2019 19:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfGVRUC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jul 2019 13:20:02 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:39516 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfGVRUB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jul 2019 13:20:01 -0400
Received: by mail-pf1-f176.google.com with SMTP id f17so13698457pfn.6
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2019 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZFzmrFxlJCsKQ/EIWo1d50mEnJFKTQ2jf1g0wmDxqVE=;
        b=P893UYqXyzhGAaSEaMv4qbjybFuWP6zaQE6byqvrImts5QoYFvmY4em/AU2qFtm6Ea
         mCNiTSS/feq3pnBv7+oZPYlQMRpT742lE8Ik2663MdwtveihlZA4Z5yIeIBEC5ISkCfQ
         6FFXV1cRZnekU32GPhIbSSZdavtPBxAudqDBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZFzmrFxlJCsKQ/EIWo1d50mEnJFKTQ2jf1g0wmDxqVE=;
        b=XWGhAQiXG4OSfjyr/UwUIjc+MF3bZa01XTwVBax9OcRF2AAnw8UQtBo5Bsq4vhlqHp
         7iI7JVmlKIA3qUsa9ldHtglk6HlrQRbpLgQndCMmfXtNaf0M3OHwYH+QeyJnmSaLlMA4
         1twbX4EdzFSw8if4FU9PzGGboSOaDwge/e79rc902koz+VVU4Qh9pd4atLu965jwVJGF
         qKotrehqLlE5PIQfB+RVbl9X6dFW0cpz+deAChNga0bUmsC0zOctXxFfQlGZQvJaVjXF
         HgaKw0eza1PHmMtBBGVCKhsl7AQRNJ5077XMsqumzXkEhFkrYf3/9M1YCQyXilC6PBHy
         xsJw==
X-Gm-Message-State: APjAAAWa0kfwsc9Ou8h4lu6bikFqILzcCgPMlRA+tLYuRK4LreSU9NnT
        zPPh2YKHbf8VrFHwU2jogwSbKw==
X-Google-Smtp-Source: APXvYqzFUfFF5J/cWc7DTpFBxtO5tXX5mFJrbv38Gh2SOVV9hgc2anwc5aSpyKz4iyjXxIfstGyArQ==
X-Received: by 2002:aa7:81ca:: with SMTP id c10mr1305000pfn.185.1563816001315;
        Mon, 22 Jul 2019 10:20:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g2sm30576805pfi.26.2019.07.22.10.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 10:20:00 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:19:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: "make" vs "$(MAKE)" in tools/testing/selftests/Makefile
Message-ID: <201907221019.DC708E775@keescook>
References: <AE9B539F-DEBE-4CE2-91DB-9EA2DA2A9DEA@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AE9B539F-DEBE-4CE2-91DB-9EA2DA2A9DEA@linux.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 18, 2019 at 05:48:30PM +0200, Ilya Leoshkevich wrote:
> Hello,
> 
> Is there a reason why kselftest Makefile uses plain "make" instead of
> "$(MAKE)"?
> 
> Because of this, "make kselftest TARGETS=bpf -j12" ends up building all
> bpf tests sequentially, since the top make's jobserver is not shared
> with its children. Replacing "make" with "$(MAKE)" helps, but since
> other Makefiles use "$(MAKE)", it looks as if this has been done
> intentionally.

I suspect it's just an oversight. Can you send a patch to fix this?

-- 
Kees Cook
