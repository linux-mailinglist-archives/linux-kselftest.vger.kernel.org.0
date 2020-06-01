Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141AF1EA4BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgFANPy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 09:15:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41371 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFANPx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 09:15:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id r10so3478311pgv.8;
        Mon, 01 Jun 2020 06:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YEjnyiAkBtLgDdKTQ3Q+SeGMmmbQpJXu+XKOdvg7XWQ=;
        b=FYLfpDuMxg065Ks2MBCJbDh/9EUVecsmtgWC7LzPSRB/9tsrmMTK8AFw/2QVTSWGUN
         kfyX/nASBxMxw7cHYcW8Lq9537frjYtXYAK5FtfFdXFoJbISZsO1s9Q/T8OZqVAY7i9E
         oDZl9GfXAdG+G6w6QepK6CYynb07C2fpwcFowiF/zjRENzdzJ6b/Fv/YXUNq7g3g+cKX
         1Do6i9G5wmxR7LxfYUoKXk4afIwDF7KyPe/ThXePnA6fYVWkdGXxmqdKcy5vAxOrjrTm
         8sKc4mZ+SdCbyaTv+Ty7m3Q/pOvT+RLUVBjogHGbw9gWjP/b13ToBwnOUyeHOvpAZkhS
         SWsQ==
X-Gm-Message-State: AOAM531TGgZd6ujSQjeD1glIz64GqSftapIn8gznjvUFZ2OwJholtXXT
        VF2p9IUox0HxEBw7cxW+ycM=
X-Google-Smtp-Source: ABdhPJyGI1Jw//yDHaFra8X80vvfAUvVZa/DPz62//t/kk3t7fRH28Bc4Y9LUOxyGucYf1mdGccIog==
X-Received: by 2002:a62:2bc7:: with SMTP id r190mr19965601pfr.55.1591017351876;
        Mon, 01 Jun 2020 06:15:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r18sm7347730pjz.43.2020.06.01.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:15:50 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D43AB40251; Mon,  1 Jun 2020 13:15:49 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:15:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 4/4] selftests/sysctl: Make sysctl test driver as a module
Message-ID: <20200601131549.GJ11244@42.do-not-panic.com>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067755690.229397.12060049846042042480.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067755690.229397.12060049846042042480.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 11:52:37PM +0900, Masami Hiramatsu wrote:
> Fix config file to require CONFIG_TEST_SYSCTL=m instead of y
> because this driver introduces a test sysctl interfaces which
> are normally not used, and only used for the selftest.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
