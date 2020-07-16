Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B40C221A30
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 04:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGPClo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jul 2020 22:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgGPCln (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jul 2020 22:41:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9EEC08C5CE
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jul 2020 19:41:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so4094325pgk.4
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jul 2020 19:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jqVUIDpGCAipRS+ecPG15XM7TieBrIaHAd9mloEKAfg=;
        b=JHxuqay54G74N6vgudi5DVmCfb4LywmFRGcKR/VpugHM8EUk43/s0CR2VP3/5kLIdx
         UvyJZpGYeun6i18sh6eYGHmfAvaouR2XxCQugfkAC5YUal7+JFzkKqNxJm/QVlqbFxeq
         Z/OHtPeZEPIIoWCPsB5YvZ+H78MRYn8SrV2cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jqVUIDpGCAipRS+ecPG15XM7TieBrIaHAd9mloEKAfg=;
        b=iRvXHayorzRYt0j0CYgdOJ9G9iCDyPBaF7tswad2gRI73U5FQj1MaKgvXEiE0C/2ad
         SgX+mZUqsxjDrhQu8OjAEnR+Nj7CSzvKCxSqtG2YxRbNn74jxh5m1Iv9US89hwWbiTse
         FzjG1rnoGJvg/hZCTYUWp6pFZq8+EF58EHI3iLT4YlIMnZvzX6+3FGg1uozyRChKd64d
         S2AH7UK2H7gjmW0nd7jWRSLEcYx9t/3xfBq0eSlG/H0Aks4TXtHpXyfhUBygTsr+IbrZ
         iE5AFTLmPosmLqm/+z7MK5Apa7MVouZcXUz/udWXHjos6cOMND/gTcboG9A9BCdH4To4
         83vw==
X-Gm-Message-State: AOAM530ushf1OCKZ9Alx3b2gxlnrPu7RYd3OcWfEhYoWL/6xYFY28Q8W
        4vNzLrmm65eZmZk0zsWm5OOz8Q==
X-Google-Smtp-Source: ABdhPJzMM1zSFnYR3x2DnMDjCvyMLDkK5b+zSz4ErPk651/nIfO+yLt/HL7ZZk7cQTCfVqxRQyJNQw==
X-Received: by 2002:a65:6883:: with SMTP id e3mr2401712pgt.5.1594867303051;
        Wed, 15 Jul 2020 19:41:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2sm3271605pff.36.2020.07.15.19.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:41:42 -0700 (PDT)
Date:   Wed, 15 Jul 2020 19:41:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC 0/3] kunit: add support to use modules
Message-ID: <202007151939.62EFE6F@keescook>
References: <20200715031120.1002016-1-vitor@massaru.org>
 <CABVgOSkBAiMSMzCx62_CRo_0e2SGdvRWZ0dSC4t628YJBw-3Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkBAiMSMzCx62_CRo_0e2SGdvRWZ0dSC4t628YJBw-3Aw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 15, 2020 at 11:47:11AM +0800, David Gow wrote:
> - The inheriting of the mm stuff still means that
> copy_{from,to}_user() will only work if loaded as a module. This
> really needs to be documented. (Ideally, we'd find a way of having
> this work even for built-in tests, but I don't have any real ideas as
> to how that could be done).

I'd like to better understand this ... are there conditions where
vm_mmap() doesn't work? I thought this would either use current() (e.g.
how LKDTM uses it when getting triggered from debugfs), or use init_mm.

I'd really like to see the mm patch more well described/justified.

-- 
Kees Cook
