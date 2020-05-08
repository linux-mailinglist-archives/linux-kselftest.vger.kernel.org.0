Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6DE1CA533
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 09:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEHHaR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgEHHaR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 03:30:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D6C05BD43
        for <linux-kselftest@vger.kernel.org>; Fri,  8 May 2020 00:30:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d22so493544pgk.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 May 2020 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cqpyyb+XnLoj16wQZlLdWBVriL281dJ6+6/0xxtkFF0=;
        b=hZKbAYW33xb+xdQ8lBH9aT3oQXgi4QwV4iyIiZZxmjGdeY2HuZSMuK1Tv0vl5FXkoD
         lpolHB5qaTBvXWNFPcAWHh/cUtiXAyBsQO3w8th6r0E8mu6tSopQy2Qfp+qqBZu01LRn
         nyb7OqEjzsaHtT5Dn1N4KbgZ/UmchV1hf/rl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqpyyb+XnLoj16wQZlLdWBVriL281dJ6+6/0xxtkFF0=;
        b=fsDBRwqxcoRABG9oYRpqND2Oaih6rxjw1nKBTdfBSqZG56LOG3PJ68tKRaNI/U5NH2
         zgTfbpbgVkGe8BwjQlrEUpxNlo5BA4vZzUPPl47KBvlwqSzxIT16zY+pd32QDYTNEspd
         qmzQ/hJlV8h3NuxENp+YcXp3GzabN9k9psBjGSECn6DiWYRq6jZFTVjyW7X2krmIRcft
         Dp/yF/UNoU7E/Awtm0SwLaNe2arY26EgejbMFz0hNWdb1qeXokUh4Z25B9+wbdBB/vsb
         f0quKEWuNazv+g8okMZjB5RVjNnZkD0XSVDlAhSNycEuGPLI4hedfBlzIcu1dFQ0/0Rc
         USZQ==
X-Gm-Message-State: AGi0PuZ6AJAigPnI1MpWa/DCZlHMPbVjHqv6K9+24fgttI8R6pQneBkI
        /SbqQJxBKDFF8IUUOQd7LPlZZs+NgBI=
X-Google-Smtp-Source: APiQypLxKaNbmOsuHu9lpEurBe6lHAKMXWmXDPwAWCdC4ArcRmf7jd0ENIeqyF7Nb5foJhJTNn7u5Q==
X-Received: by 2002:a63:5413:: with SMTP id i19mr1095604pgb.213.1588923015051;
        Fri, 08 May 2020 00:30:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o190sm869295pfb.178.2020.05.08.00.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 00:30:14 -0700 (PDT)
Date:   Fri, 8 May 2020 00:30:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
Message-ID: <202005080029.538E27C@keescook>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508065356.2493343-1-mpe@ellerman.id.au>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 08, 2020 at 04:53:55PM +1000, Michael Ellerman wrote:
> It is Very Rude to clear dmesg in test scripts. That's because the
> script may be part of a larger test run, and clearing dmesg
> potentially destroys the output of other tests.
> 
> We can avoid using dmesg -c by saving the content of dmesg before the
> test, and then using diff to compare that to the dmesg afterward,
> producing a log with just the added lines.

Sounds good to me!

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
