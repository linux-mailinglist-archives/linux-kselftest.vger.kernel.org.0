Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86522282E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgGPQVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgGPQVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 12:21:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8BC08C5C0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:21:23 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z63so6048661qkb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eVyKsGqcnTfmfgMXI8u61q0DyoLaoA7ADBPKDJXxDGI=;
        b=Sid+fUx7JJp9lDCQ/ip2Q7z8EKoEUuhmbS8Y/EAimMtaVJ5FieLYEELLhGMAMiQWkx
         HfDVTNkMwVvg4hvfQ19BuYQ2OQ4X71iMeVw0iyriGM/1aiedV1f0eyAzjNocWufgP6IY
         zOf8DiqwN/IyuOzMKXGuLMV626s18HFSUSVfCFIAdDfZ64NSz70wh8nAC6Hxt70bimg1
         LqZtmP+xzip5LMLtZgwigc9G5xSJMChtVzcFwfBHlwh3pJCcVx1HLOIqU3y8P9cwOcIq
         FtTwr6ur5rj8lGXOZ3cQEhSWkfcXHGn/00jmHeSrYG3iRX8SuQqU8W+bLmVya7t8kI9A
         CDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eVyKsGqcnTfmfgMXI8u61q0DyoLaoA7ADBPKDJXxDGI=;
        b=sL0OUxYdbQiUVQUWSpzppUw2tlc8kNdBVpcaQTGHiaAvU2GAitU8NVdf3RiUjQybq+
         7bO5ZIUHSu0YO8M2SX/0c4aI5MN3aTckRyf5lWxnu22u/su64+h/bshsy3I1bNZMEL0Z
         4jgZeRKyaF4eMHWEYOU9xhFa8g+R/V+vESaHHzR0WAojg5rnk6qyrQusFRZ6ncGIvj2l
         9wbug/fx5kxgpRpRzjAHyL6p8ZamxMqKW/rxfa/IqUlgiJ/qoHZhNhC8Wl71dshRGBUE
         ilu6mrVLU/mJp4n6c67I9MZR0Wc/df4fPizes7G1EqVW1hNA1gzpq1SKTEUmehgXrt0I
         KmXQ==
X-Gm-Message-State: AOAM532tVVtruPvGcIME+u1aC5Nj5A8pj0I5FClqOXRtRaHh5FHRvPHr
        6W1HCHvQ1xb9JUxCt5OhaJzIyA==
X-Google-Smtp-Source: ABdhPJy6UOE3dKvVsKdH0AG9WQWTlh/rT4QaVC1wbblF8tnnqUsGB01aIihBqAVTYeBfYD8X663HVQ==
X-Received: by 2002:a37:bd84:: with SMTP id n126mr4883951qkf.310.1594916482698;
        Thu, 16 Jul 2020 09:21:22 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id o184sm8118760qkd.41.2020.07.16.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 09:21:21 -0700 (PDT)
Message-ID: <b89947c3216d1e59374672931edc2b14763fd81f.camel@massaru.org>
Subject: Re: [RFC 0/3] kunit: add support to use modules
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     David Gow <davidgow@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 16 Jul 2020 13:21:17 -0300
In-Reply-To: <CABVgOSkBAiMSMzCx62_CRo_0e2SGdvRWZ0dSC4t628YJBw-3Aw@mail.gmail.com>
References: <20200715031120.1002016-1-vitor@massaru.org>
         <CABVgOSkBAiMSMzCx62_CRo_0e2SGdvRWZ0dSC4t628YJBw-3Aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-07-15 at 11:47 +0800, David Gow wrote:
> On Wed, Jul 15, 2020 at 11:11 AM Vitor Massaru Iha <vitor@massaru.org
> > wrote:
> > Currently, KUnit does not allow the use of tests as a module.
> > This prevents the implementation of tests that require userspace.
> 
> If this is what I think it is, thanks! I'll hopefully get a chance to
> play with it over the next few days.
> 
> Can we clarify what this means: the current description is a little
> misleading, as KUnit tests can already be built and run as modules,
> and "tests that require userspace" is a bit broad.
> 
> As I understand it, this patchset does three things:
> - Let kunit_tool install modules to a root filesystem and boot UML
> with that filesystem.
> - Have tests inherit the mm of the process that started them, which
> (if the test is in a module), provides a user-space memory context so
> that copy_{from,to}_user() works.
> - Port the test_user_copy.c tests to KUnit, using this new feature.
> 
> A few comments from my quick glance over it:
> - The rootfs support is useful: I'm curious how it'll interact with
> non-UML architectures in [1]. It'd be nice for this to be extensible
> and to not explicitly state UML where possible.

Hm, I didn't think about other architectures. Which ones are you
thinking ?

> - The inheriting of the mm stuff still means that
> copy_{from,to}_user() will only work if loaded as a module. This
> really needs to be documented. (Ideally, we'd find a way of having
> this work even for built-in tests, but I don't have any real ideas as
> to how that could be done).

Sure, I'll write the documentation.

> - It'd be nice to split the test_user_copy.c test port into a
> separate
> commit. In fact, it may make sense to also split the kunit_tool
> changes and the mm changes into separate series, as they're both
> quite
> useful independently.
> 

I'll do it.

Thanks for the review.

