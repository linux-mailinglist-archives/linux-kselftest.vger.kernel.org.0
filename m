Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A74287CDF
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgJHUGb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 16:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbgJHUGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 16:06:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC3C0613D3
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Oct 2020 13:06:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c6so3297413plr.9
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Oct 2020 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oUInPcwtGy5Ct6pbllZKb0rez/Dyj/+rPa7J9BGJxPY=;
        b=BngZz8LWCbVMu64lKdY00Sx0OV6IFMblOSW+8/8g46Xh1wLdrTqDW6/LW0Wi0Wr4bs
         QkJzcF3s6obM7wBWGfh+86SQIk/PdOBmpcQyKVO7EBGDe8cX3hIypxqiCU1KKPPjuUrJ
         hsJq/99dNqViUac14R7Ks3d9NmLuTNKirhq1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oUInPcwtGy5Ct6pbllZKb0rez/Dyj/+rPa7J9BGJxPY=;
        b=ZMlTVZ7NDKBlPKiyQ3gVxRcsUXgWdOBhc1D3GM308/HrDxPMfzqP1aK/fDc5fKd/6V
         jrdch6eOLW4JRqHwUfCzyJdHH0RO4OjSH/ad8eYmv3bAFOlKwqrR88dwrlA4wdiLtZ3m
         w+VRS9FCfnOf0U8bOCOejUrbkA6ANa53gCxNVyKxF8CaF49AtlaL7uc4+rAvbvVF2st/
         8A/Ix5X9pL7plpAdt3tMSXTJd8NNlWXBQXSdrukEHV5upi/7pUKL/MAhZPAZ24wOKmK6
         8p/Wsxg41D2GAN1teB1sbnkkobqrzzUa3Vgo7FXFRJNjw/xe5nU4zZ0LFTtaxvyj92F5
         dlSQ==
X-Gm-Message-State: AOAM5316H9H40lqX2sOQE/nD1aXUmoa1dEqD7t66P+X46iTwAmwjiPV6
        JxeGsrUkWc3FjV5SoiTO0zjcnA==
X-Google-Smtp-Source: ABdhPJxLuPJ9CeDXkFzlHjIKMRf546wX1GezHZdhCa4fot0JJqltMLCwGyhfa61WdgLbzQ1pUSVgQw==
X-Received: by 2002:a17:902:14f:b029:d2:562d:e84 with SMTP id 73-20020a170902014fb02900d2562d0e84mr8932205plb.64.1602187590353;
        Thu, 08 Oct 2020 13:06:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d6sm8121989pjz.12.2020.10.08.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:06:29 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:06:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 12/13] selftests: clone3: use SKIP instead of XFAIL
Message-ID: <202010081306.A3F3F19A5@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-13-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-13-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:32PM +0300, Tommi Rantala wrote:
> XFAIL is gone since 9847d24af95c ("selftests/harness: Refactor XFAIL
> into SKIP"), use SKIP instead.
> 
> Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
