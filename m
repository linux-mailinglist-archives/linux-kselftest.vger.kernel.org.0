Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E03D0295
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfJHVAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 17:00:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32873 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfJHVAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 17:00:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so119687pfl.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yVnzPJdyV7FO5xyMUaSFRF4krY7Ebw999D+CIkWoW0w=;
        b=UpvrHmSJ/o+tlZQnZJuF15+KjkFId+6b4Q2KvX1rKHIIDaaANFqOMHtMh9wUwoJJA4
         l5sHvJXl36ZzYlT0XHBRM84LqagMRcmhB+hZChxp4EJAfSlMxl4+UANL7820E8TBKDuA
         /gcNgOFC7PJ/K+H8YuEBHNQFHccLAeMflbfMB9dgdEs5UZn2LbKBI18s231W2zzfI1Wg
         LqGxONrJ1xKwgmNi6R0r4jRN9I2de0NJZUB1mEMjAWbs3Zn4jRcVQsid59hpsFazzZBV
         2DsbQ2BuBJQyPSJ0odZeb1CuMnND0nHWCDJFjSdqqC34D7YNlimqBfCWJzmEsNFpFInE
         N7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVnzPJdyV7FO5xyMUaSFRF4krY7Ebw999D+CIkWoW0w=;
        b=YigcadL+Og4Mp/HaMr2utSO+bxSA5YSPbfSO3Im0S0xwD6+HteeFX0PPfrj4ZuwmpR
         4mt1PU62w8FAU61Ex9ZziGGCiFv6cwzkYsE+RQKDjQoGS00CxpmB5zbsLLodvoVAhTRe
         OHoDPk3aynVtf/zcWg+eN7vMmLCJ80Sr+Sgsj7wmEhkkHSDyHFFk+B/8y7k40yyGkl4N
         DBc2PnhEoOoL0jKI4fS2EvXezL2UHeYNkoZMhZ/xAhKaKj2pUJwJQoNtWgLSaD1wMwe6
         4+fGsFsW4JAut8zqjFsqhfVtvcIE03uxeMZCgXmrnq6B4ROrRkZdsIdoXn29G+60rJPi
         c6kw==
X-Gm-Message-State: APjAAAWc81CIkdCXuETN1wxwKNtrtvoUHmX5plDYxD3Qkf//HH8QLx3q
        GtqxRduEYbFrCT90xKF5eIkLQg==
X-Google-Smtp-Source: APXvYqwyxzllxF/LoBLa/x1iOZGL35rS0gTiTaUEVADayCbzUtTbP0axdqTlfofHfTzaGT8lgKDz/A==
X-Received: by 2002:a17:90a:6509:: with SMTP id i9mr6821226pjj.82.1570568428738;
        Tue, 08 Oct 2019 14:00:28 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id q15sm90399pgl.12.2019.10.08.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 14:00:27 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:00:22 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 linux-kselftest-test 0/3] kunit: support building
 core/tests as modules
Message-ID: <20191008210022.GA186342@google.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 08, 2019 at 03:55:43PM +0100, Alan Maguire wrote:
> The current kunit execution model is to provide base kunit functionality
> and tests built-in to the kernel.  The aim of this series is to allow
> building kunit itself and tests as modules.  This in turn allows a

Cool! I had plans for supporting this eventually, so I am more than
happy to accept support for this!

> simple form of selective execution; load the module you wish to test.
> In doing so, kunit itself (if also built as a module) will be loaded as
> an implicit dependency.

Seems like a reasonable initial approach. I had some plans for a
centralized test executor, but I don't think that this should be a
problem.

> Because this requires a core API modification - if a module delivers
> multiple suites, they must be declared with the kunit_test_suites()
> macro - we're proposing this patch as a candidate to be applied to the
> test tree before too many kunit consumers appear.  We attempt to deal
> with existing consumers in patch 1.

Makese sense.
