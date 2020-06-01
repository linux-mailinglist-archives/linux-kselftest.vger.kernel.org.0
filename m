Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2599D1EA4BC
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgFANPg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 09:15:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41350 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFANPf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 09:15:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id r10so3478035pgv.8;
        Mon, 01 Jun 2020 06:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+gDMWa+OGAKx46k7Cvh7kPbyjXS9KSSt0bfGnT+J5sY=;
        b=bfY6hGpdYKVzyY7QA6OCAukgzvBSy0pmtesmOYTb8F0dmtIwvdB4uz2+FyUfX/I+jb
         mct6x/4L33Bk4s010uuDOMGPwMDxNq17YvdL4cQ/gR7KP0ONbeyFirTrroHlyy6b6ZI9
         1dVMoLG+6iad6WvnmZDK8icnhQfK43Rx1zBzBW8fYZd1+5r4nzarLum6SIT2G7n5rlpS
         RL1/ATqMANT/nn0cPdkOaX+zpOkNCWzLJUlKFm1Krfrm2+v80veELRnBKNXQxFU28k4J
         7wTCOt+8Xgzu3ezNxXHWiwAsWnvp+BJLJLN6eZVBPdf9TD8gKoVye8mobs2u85/5gxwt
         14pQ==
X-Gm-Message-State: AOAM531AG3dQjc3YjXjEExYlANQBGDPXdsESY2j1LaSyVj0VX7F8zD7+
        nenz7/6TQcUde3/6wTx4Qo0=
X-Google-Smtp-Source: ABdhPJwWk/s5F4iwXHiVM9TgwWJgxm2fDnJu8jVLBQzoRLnqQx/zowwSN/CtZM419Rgp80gQFZEpqg==
X-Received: by 2002:a05:6a00:80a:: with SMTP id m10mr20480731pfk.174.1591017334969;
        Mon, 01 Jun 2020 06:15:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w192sm14601238pff.126.2020.06.01.06.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:15:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4726440251; Mon,  1 Jun 2020 13:15:33 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:15:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 3/4] selftests/sysctl: Fix to load test_sysctl module
Message-ID: <20200601131533.GI11244@42.do-not-panic.com>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067754657.229397.15961438722058766667.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067754657.229397.15961438722058766667.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 11:52:26PM +0900, Masami Hiramatsu wrote:
> Fix to load test_sysctl.ko module correctly.
> 
> sysctl.sh checks whether the test module is embedded (or loaded
> already) or not at first, and if not, it returns skip error
> instead of trying modprobe. Thus, there is no chance to load the
> test_sysctl test module.
> 
> Instead, this removes that module embedded check and returns
> skip error only if it ensures that there is no embedded test
> module *and* no loadable test module.
> 
> This also avoid referring config file since that is not
> installed.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
