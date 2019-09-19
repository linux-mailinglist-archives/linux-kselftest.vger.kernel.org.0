Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A3BB830B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 22:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbfISU64 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 16:58:56 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:46577 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732595AbfISU64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 16:58:56 -0400
Received: by mail-pf1-f172.google.com with SMTP id q5so3049952pfg.13
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2019 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CUgsbf/jB2T41BbAqv3yJJ6qnY+emEeWTF8GouW0W7k=;
        b=Skg8FBDYI3SI80OiRaZsajZIS+mB/ws1Benp96vjZIICX5FQ+h9kfoOXJI3HVESzW+
         GK+aessLoKXzNbE0qDzjfAAkxFLtfNQTm/gGUDRHm1zFBR+P6Gi2NLWI+G0ABr0jhmwy
         qWUOkMVTLwXp2lAvy82OQuTS8G5C4Pwp9SWq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CUgsbf/jB2T41BbAqv3yJJ6qnY+emEeWTF8GouW0W7k=;
        b=mlobppMPIXcyovS/MvFfboERJXXJ5qYG0kQpCT9oqMc5O7qryno7r1ierm0SFyqEsi
         SVnQwwtXa5safcEaJcO6TqOqln65tvI3aoRWy4Xtlezj7S54iSqHWWc/q/KWbrqREujW
         aIuFpHGj//gevqaOXtEe6dMhqdb+LUde7WmzuTTod9wJud1b+p9FzA+eUKqbRUJl0aNx
         H/eqe05S5Xeks78JdX1YgcNuRXTvamwg+7fY2X1ctzLNWUZdraYPi+usJ4bjgi8brcLs
         +XyXCiOTUFZ+m3vLpm77AE+wlXb+P128gdko3sQ8jQXEsxtWPYOvd6S8DnQQfk2t2NNk
         IsKA==
X-Gm-Message-State: APjAAAVs4r4HWnafEtpCtK8+865HgbYo7gonkChhs+WAJrEjxHsv+HHA
        1pZ8v+DJdiF6e1lEZs8j0S6xog==
X-Google-Smtp-Source: APXvYqxxK218iueQ1y1JKMl7jjQZnPgxxYGDjjTCbDmU0HJIUVzwPt4wc4a+8kSux480STH1xOWYKA==
X-Received: by 2002:aa7:93b7:: with SMTP id x23mr12589265pff.250.1568926735403;
        Thu, 19 Sep 2019 13:58:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f18sm3666342pgf.58.2019.09.19.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 13:58:54 -0700 (PDT)
Date:   Thu, 19 Sep 2019 13:58:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tim.Bird@sony.com
Cc:     shuah@kernel.org, anders.roxell@linaro.org,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout per
 test
Message-ID: <201909191357.7B79D5D427@keescook>
References: <201909191102.97FA56072@keescook>
 <ECADFF3FD767C149AD96A924E7EA6EAF977BA636@USCULXMSG01.am.sony.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977BA66E@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977BA66E@USCULXMSG01.am.sony.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 19, 2019 at 08:49:14PM +0000, Tim.Bird@sony.com wrote:
> > > +export timeout_rc=124
> > what are the units here?  I presume seconds?
> 
> Nevermind.  I misread this.  This is the return code from the 'timeout' program, right?

Correct -- given the skip_rc usage, it felt weird to hard-code it in the
if/else statements.

As for the "45" I chose, that was just to be "more than 30" which was
the per-sub-test for tests built using kselftest_harness.h.

-- 
Kees Cook
