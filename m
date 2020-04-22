Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497F01B3A20
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 10:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVIcE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 04:32:04 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53447 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgDVIcE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 04:32:04 -0400
Received: by mail-pj1-f66.google.com with SMTP id hi11so590961pjb.3;
        Wed, 22 Apr 2020 01:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0gSGsaK7XNGM0f9HDP2FEWrV5igIwJYSE4SoUHkiEQE=;
        b=Fpknl+15UdpLXGZVoCBoZmQUhLqSKK4w5jVeb/RFFMYKz/d5w3a/FvqUiS9ENWDosq
         VcnnBgpYFMrFfIZsGDxQ31xMyyCIthsmB0ZJORgoQiKWChzWA/5k8fPgy9BjjYaNcq/Z
         DFy+v7On047hR+A1yCocDD7IVT1rxEpGqKwmarDbw84oKRGyaI+AdYpXn5eNyC34Wjgj
         RFZSJTP6VPLVWxc/Gwr6YNqcFitChNR8HtMBXR+gbJ4ruu9MCVOh6ItR079N9ZcP62KE
         oeUTzvDzxnwIjW+Izf6CVKPwCWdOgvgiv4xmPxWLLBvLeZcyWIPam8Vuq89K2GyJyEVl
         AkmA==
X-Gm-Message-State: AGi0PuakUSXHtg6LAET1I9nyNYPbadcPYW5lo5B8iDTjCkdiNwlYz4f3
        HbuGu/s2M0NmqpfEiZsgqtbIcHRy7mg=
X-Google-Smtp-Source: APiQypJMpziGX0I45rHBByRzSAK3vgl8jDXWg3bYi5JbvKA5u/6i3jZ989V6n+t3+mj6WDchxznsuw==
X-Received: by 2002:a17:902:8542:: with SMTP id d2mr24815804plo.273.1587544323870;
        Wed, 22 Apr 2020 01:32:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x193sm2035933pfd.54.2020.04.22.01.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 01:32:02 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EEB93402A1; Wed, 22 Apr 2020 08:32:01 +0000 (UTC)
Date:   Wed, 22 Apr 2020 08:32:01 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v4 3/4] kmod: Return directly if module name is empty in
 request_module()
Message-ID: <20200422083201.GV11244@42.do-not-panic.com>
References: <1587452704-1299-1-git-send-email-yangtiezhu@loongson.cn>
 <1587452704-1299-4-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587452704-1299-4-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 21, 2020 at 03:05:03PM +0800, Tiezhu Yang wrote:
> The exit status of child process is wrote to the address of variable
> "status" after call waitpid() in the user space that corresponds with
> kernel_wait4() in the kernel space.

NACK, the issue is in umh, I'll send a fix.

  Luis
