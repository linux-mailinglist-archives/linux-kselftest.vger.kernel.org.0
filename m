Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBC1174459
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Feb 2020 02:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgB2Bxx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 20:53:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37012 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgB2Bxx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 20:53:53 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so4448700otp.4;
        Fri, 28 Feb 2020 17:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=crY7I29q65NogjvIQrh/RfmKj4YUeYhp8OQxxv1sYQo=;
        b=dMwE0kW6OYkhYYb1kvh8xuHnI7MMI1xEq2IhGEuypdcG53NLEeV8VNLuSxNPURuCDw
         RNAMj/cYKpOZVpTOB4eFiRqQAsjjvht3NKxg7KjQa6tP2tqjfEwbdvV6NV9A/q5TXvhi
         gT+lZ0RIO/8deRWGv+RDHV5ZRGBZnV6qcNtfQLsHvhKJ7JnCeOmHoo4LTnsFmoAN8XmK
         Z0pBJ+MisKcbDwsH5mRpjN4vuQjio4B1MUpMWgOGdoU9soztiNR899gtmLRhz4DCVP5U
         0t5Oep2Q1GkUqf31c9RpceV09j9mT7q/mD9pgtcVtUCUp9GyTwLlSInPX4S3h7J+zkza
         qUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=crY7I29q65NogjvIQrh/RfmKj4YUeYhp8OQxxv1sYQo=;
        b=QCgdhCMgLkq1mhA9keUVfbNZG7H95DrCYKCCQeE3t7xPFyLsoJrNdBtX1MHNvAkW5I
         6CeUnI4z97YwoEvGouJss5qLbbNjm9XMJEsKM7pYxULe47MO0lXPC1VQGkOUp54HMsAH
         cFNMqvydq2bmTaWLoPWemnx4oTUW+MbQg/FM4bt9YSWQ1FEPbXN83w+/j3etfL0C7imy
         Iu6Ma5gTwLhB8L/y1S+L3JJVmaSYafFb4Kuh9sYoCIHiYVvPPuaWqRTGoQdKkWrvpiAK
         LlKsEaEB2yED/d1FPD7KY90pcLhxrtkHTPX5Fdc/gxZnhCdwN9kFWLrHkKxj7l56tmsA
         tGPQ==
X-Gm-Message-State: APjAAAXLJEImHUK9jAOJLMLm5Tb3QsABdz4mGNoiX12ZMrbjRGfSbI79
        L840WLaRdmUCS+ZBXn87EQDFdVMW
X-Google-Smtp-Source: APXvYqyPGUCcZeY1kzfK90vnLLGeOaFY3yUFr0KaG6KZBh/XpTd/6XjvG1Ei1gJeVm/He5mxaw3kzg==
X-Received: by 2002:a05:6830:1284:: with SMTP id z4mr543547otp.291.1582941232393;
        Fri, 28 Feb 2020 17:53:52 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id u3sm3782265ote.50.2020.02.28.17.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 17:53:51 -0800 (PST)
Date:   Fri, 28 Feb 2020 18:53:50 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Thelen <gthelen@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kunit: add --make_options
Message-ID: <20200229015350.GA26612@ubuntu-m2-xlarge-x86>
References: <20200227063134.261636-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227063134.261636-1-gthelen@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 26, 2020 at 10:31:34PM -0800, 'Greg Thelen' via Clang Built Linux wrote:
> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
> optional --make_options flag to kunit.py allowing for the operator to
> specify extra build options.
> 
> This allows use of the clang compiler for kunit:
>   tools/testing/kunit/kunit.py run --defconfig \
>     --make_options CC=clang --make_options HOSTCC=clang
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
