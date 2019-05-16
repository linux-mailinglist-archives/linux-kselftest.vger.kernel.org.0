Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDE720079
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2019 09:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEPHno (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 May 2019 03:43:44 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51987 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfEPHno (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 May 2019 03:43:44 -0400
Received: by mail-it1-f196.google.com with SMTP id m3so801919itl.1;
        Thu, 16 May 2019 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WX7yELkhCk/Xz3OYn00m0kQOVWLKHq966GGVv+YHK8Q=;
        b=RNQR9zjSvvtvRK/v9QisZZS943j40S4riO8HEWNxRprDh+wPszMYM+AMwLJYCkxGgg
         Q0HBrwaklA4Xi1oafck3QfihI+np9fpDX5tnxZO5xnlBy1RFFcy4wJWikuFmHkiB8FlG
         JhwEDYRX8F4iBBgqwgojdKgUUnLMHRwYOjDFj8qmHpqrv2ft9LFF9Yf4qzPwyaFBZuWD
         YdmZC+re/cYJQYxNjJL27Zk1TXoML4Mxo0GNr1MXkE9NSgBrIrd1fQUOFMa4p5lBVbJq
         5z15oFlxr+LDM8Oj2ZnCzGe4Zk9GJA3+F2oVJ4NRAeJtFojljfiJsvmbQpPmrdBv6ZOM
         Yv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WX7yELkhCk/Xz3OYn00m0kQOVWLKHq966GGVv+YHK8Q=;
        b=Uc/FAbEgjMy/pIre03eYKggWJX2GsUe6qv4BDfRorWvppPHu6ToOQWKFBgFdodGJl7
         g1N/l/EWcx6F7C6EOOuN7bH1tx+27mhKf0L4yaHi8bedIhaOHbmcIF1c19F/ciyaA2to
         bD0yswtoZInggfnnmgI/R3/mxWAVyVfa8ofz0NP987jTySrbfFGszO8dZ4J64A1H0sQ/
         b87z5FlJ3NJp7iaCpyBdKFmxAkK/p5SCSdJJDlJP1O9ZCWspO6ibTm+ygsosnKvTA0vx
         N2tvuqi25P6YrQWHZHRwTsYUjvYlaN0NwFqKmHG2vb5YcGCm45X7VWBtH5ZAfXA4JVTf
         vxdA==
X-Gm-Message-State: APjAAAWOkIC3oLnD1wpyLRvlgbeModODAsw/yDxAc6KRS7XAYOxe01hJ
        GumPmoaW4OPBzhOzl1kzhMZUmjT69nhAog==
X-Google-Smtp-Source: APXvYqzjLr0Vm6NPaoAWTAxljovveyvL14w+OiIL6Biy9VFGsyCHWjhQxhXy+xzWAXm2eelpXz12nw==
X-Received: by 2002:a24:d241:: with SMTP id z62mr11183950itf.141.1557992623249;
        Thu, 16 May 2019 00:43:43 -0700 (PDT)
Received: from asus (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id i8sm1442743ioj.26.2019.05.16.00.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 00:43:42 -0700 (PDT)
Date:   Thu, 16 May 2019 01:43:41 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests: pidfd: Create .gitignore to include pidfd_test
Message-ID: <20190516074340.GA12505@asus>
References: <20190512045711.4507-1-skunberg.kelsey@gmail.com>
 <f0f3c65d-2b1f-3633-ee18-7d49d18eb7a5@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f3c65d-2b1f-3633-ee18-7d49d18eb7a5@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 14, 2019 at 05:26:25PM -0600, Shuah Khan wrote:
> Hi Kelsey,
> 
> On 5/11/19 10:57 PM, Kelsey Skunberg wrote:
> > Create /selftests/pidfd/.gitignore which holds the following file name
> > created after compiling:
> 
> This patch generates the following checkpatch warning.
> 
> WARNING: use relative pathname instead of absolute in changelog text
> #85:
> Create /selftests/drivers/.gitignore which holds the following file name
> 
> 
> I fixed it and applied the patch. Please make sure to run checkpatch
> before sending patches in the future.
> 
> thanks,
> -- Shuah

Thank you for catching and fixing this! I'll make sure to remember to
run checkpatch in the future.

Thanks again!

-Kelsey
