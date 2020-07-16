Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96D522284D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 18:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgGPQcG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 12:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGPQcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 12:32:06 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6129C061755
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:32:05 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id e3so2965342qvo.10
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IqaV5FL0PECxrzqMcMpsU9VUXbw3Oykiac0eOEM8xRk=;
        b=coWa0ly+THdkxmgAczU5j9YW2aZldQ+LrSFhlaBEd4BmZx6OP9QCpUiKKmkMvikvTv
         IwNqFmD13zSYGJ3Zh7enFVghVnftWaN+vSKRmGVHLgBNDWC/5gRlvJEcLujqB7jjJPez
         J8r97Xsji3+8GEr8De5QUMMLxi6z8XIa1O5rbljptJtjo4bSVC8BThwDxIZqVJ+CwCNz
         LxKJBFDtUsvXAahhlyCvHcl29Jj6xMg2otzTkGUaRf2+a8KBB1kjm/cfokdzDoRlgHOh
         QnZ/Y4+Q7jYPfBVVRjfJshnYWt+DVDWaHsZSbgfktyYMoAE0KKfvyXxXj81fg+t5dTeZ
         X3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IqaV5FL0PECxrzqMcMpsU9VUXbw3Oykiac0eOEM8xRk=;
        b=LjiOICTNqnixtjqZoh95vPzmMwRkjSoimrhZMqyJP1FKRx+zKWqENBC98xm6mx83AW
         bLGaVqgB9ZMwtdcKn3pQ7l1YwFDHe96kFXAM103oaqVO2z6RU5U6qJG+hurzLdCaR4nK
         gF9/PxwZl71Tbf/FYNqOplgpAWCRQiKGSgm0dFtcod4nQ9PQUHPLNcZksg6i1zC13Q9W
         WzC5JEtTbb4z/n6pR9CWryD0RGst02t93JTB0GoXFO/AQzcG27dx3qJ5z+aLU2XFKYof
         Qv2OCYPD+GvtUu21LgOlQoWeSwHdqKrWmiy2YNC1Uf4+JI5IkMYO+uqb5dYfdckpTPAP
         PrHg==
X-Gm-Message-State: AOAM532MmCwGR4YU/tiN1K70Pfo+40ccVYO60MlQWJqqi9bcylkqAfkQ
        DwKhYY8cKfA0i7y7PG21OMs1kA==
X-Google-Smtp-Source: ABdhPJy97JfulwTIX38u7Qbd97AVcE4dFHFkx2zvVbbPhDUKKWpZv/FUnRVMqlX0T+/IfOSfVGDcuQ==
X-Received: by 2002:a05:6214:8f4:: with SMTP id dr20mr4872867qvb.228.1594917124969;
        Thu, 16 Jul 2020 09:32:04 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id f15sm7083485qka.120.2020.07.16.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 09:32:04 -0700 (PDT)
Message-ID: <196eed159aa0e4c94f7481b148a458a465050dc7.camel@massaru.org>
Subject: Re: [RFC 0/3] kunit: add support to use modules
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 16 Jul 2020 13:32:01 -0300
In-Reply-To: <202007151939.62EFE6F@keescook>
References: <20200715031120.1002016-1-vitor@massaru.org>
         <CABVgOSkBAiMSMzCx62_CRo_0e2SGdvRWZ0dSC4t628YJBw-3Aw@mail.gmail.com>
         <202007151939.62EFE6F@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-07-15 at 19:41 -0700, Kees Cook wrote:
> On Wed, Jul 15, 2020 at 11:47:11AM +0800, David Gow wrote:
> > - The inheriting of the mm stuff still means that
> > copy_{from,to}_user() will only work if loaded as a module. This
> > really needs to be documented. (Ideally, we'd find a way of having
> > this work even for built-in tests, but I don't have any real ideas
> > as
> > to how that could be done).
> 
> I'd like to better understand this ... are there conditions where
> vm_mmap() doesn't work? I thought this would either use current()
> (e.g.
> how LKDTM uses it when getting triggered from debugfs), or use
> init_mm.
> 
> I'd really like to see the mm patch more well described/justified.
> 

Sure, I'll describe the patch better.

Thanks for the review.

