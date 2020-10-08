Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E25287CE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 22:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgJHUGf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 16:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbgJHUGf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 16:06:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C57C0613D3
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Oct 2020 13:06:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d6so3284397plo.13
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Oct 2020 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IcbhrWsYAuVUulfDMTbYq/YLCWQUkON2gvNGZ7mgp58=;
        b=J/RdF2uUoB7b1oF/MYm7U3aKk0CwR0dskwGjaR9GO/2ngbiAgu2fHeYRhMImin+7QS
         nEGm9Hrc5IuBOp0HUZIMs7946/cCgh0+sOqAmmTrvw4KKHFOcmQSrKQGs7KjqL65bV5J
         370ahFYXPknsihmy8hTDGPxZrqX84UEMmdB3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcbhrWsYAuVUulfDMTbYq/YLCWQUkON2gvNGZ7mgp58=;
        b=hDM8n9/VFpZwFHa5OgOVDyzsXHQxnPk6faJBww37J/12PUqRJHkkdZWerElaG7ka/a
         jov+kQhQT1uZeob15q+bk+AdlCRuD5/XaN14jGflSrG0nYhGB/F/Y4uQownZB4uKUK61
         ZXFyOxlvDCi42RpQBou52qQ7tCKYej9bu4A5oJmWz1SKVTu91IpPcpjJ5UbA4xMPO2eR
         eouyS62DBVB4GS7cM78QJcjMMnH9COnLtz9gXUAeCnS16DGXNdFA1VS+sr51Nv56trz4
         SI7c59MUhJP8PCO73MtHluYJEV4RxGERGqVSRPh1efM5VQfpKh3nfZHgfYk04EbiCr0K
         0anQ==
X-Gm-Message-State: AOAM531EFyj+cx89IybxDfi7BeFHQO6QcV3At3jyAM80eRbqfJLZa0VA
        uBA9l6BSHon5SsWNtZFTeUiVOQ==
X-Google-Smtp-Source: ABdhPJw4w0PUx+/4kHjnytsAXqS8EQn014tH78UWeCG2OSBpCSkMcF5VTowqJDnjhcFh4mnd5Dr1MA==
X-Received: by 2002:a17:902:7d8d:b029:d3:95b9:68ed with SMTP id a13-20020a1709027d8db02900d395b968edmr9006705plm.28.1602187594761;
        Thu, 08 Oct 2020 13:06:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e5sm9164460pjd.0.2020.10.08.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:06:33 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:06:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 13/13] selftests: binderfs: use SKIP instead of XFAIL
Message-ID: <202010081306.0EB0DBA47@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-14-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-14-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:33PM +0300, Tommi Rantala wrote:
> XFAIL is gone since 9847d24af95c ("selftests/harness: Refactor XFAIL
> into SKIP"), use SKIP instead.
> 
> Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
