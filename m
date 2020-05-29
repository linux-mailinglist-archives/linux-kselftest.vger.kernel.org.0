Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F2A1E7F54
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgE2Nzp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 09:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2Nzo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 09:55:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13ABF206A1;
        Fri, 29 May 2020 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590760544;
        bh=jOv0qS356kE0m/6mt8bso0uLLXNcVx8d9Px/o34RV14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T9crmTAqB25c3tRbF8UxvfvCtZnE1cNJiYV1PHDe7H2kIGejy09b9Ha8kXcmE4+ak
         py2wLTu5eSfCsaed76Bdl0cbKkyPTAbX9ils/5yvbZaUNuiJYQSNF+0ukDY48Y2Z/R
         P7ws3/NrVdN8hbayjYcWqxbh6wuntnAEjp6uE5vk=
Date:   Fri, 29 May 2020 22:55:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 1/4] lib: Make prime number generator independently
 selectable
Message-Id: <20200529225539.e9b939b1f3f57c0da1acc698@kernel.org>
In-Reply-To: <202005282255.63F6EFE55D@keescook>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
        <159067752610.229397.10253900294111245982.stgit@devnote2>
        <202005282255.63F6EFE55D@keescook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 28 May 2020 22:56:59 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Thu, May 28, 2020 at 11:52:06PM +0900, Masami Hiramatsu wrote:
> > Make prime number generator independently selectable from
> > kconfig. This allows us to enable CONFIG_PRIME_NUMBERS=m
> > and run the tools/testing/selftests/lib/prime_numbers.sh
> > without other DRM selftest modules.
> 
> Nice catch! I see that tools/testing/selftests/lib/config already has
> CONFIG_PRIME_NUMBERS=m (based on this commit log I was expecting to see
> it added in the diff, but I see it's not needed).

Yes, that is the reason why I have found this issue, the "make kselftest-merge"
cannot enable CONFIG_PRIME_NUMBERS=m without this fix. 

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you!

> 
> -- 
> Kees Cook


-- 
Masami Hiramatsu <mhiramat@kernel.org>
