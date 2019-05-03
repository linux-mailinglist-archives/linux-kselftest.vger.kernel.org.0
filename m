Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA91B12910
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2019 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfECHtM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 May 2019 03:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfECHtL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 May 2019 03:49:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906E9205F4;
        Fri,  3 May 2019 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556869751;
        bh=ZgniHRv8E+BcrQYu8PwEidskt0uLyw99bsJIfZ4hwNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cr7rRBaG88jGIikiLUaYEenv9V2UUDkhtXNE8mzQAA31d5RS4+md4UwuxPXADK4gJ
         idpvQXfxU2wFw8wERCHdSJ2Ta2LAZDkrgxs2sGyogiHfaG/7z/enK4AsqH1VyeScnz
         oUAsitHrQUVMDR36HP9INpQfYbiifOjI/WkcAUTE=
Date:   Fri, 3 May 2019 09:49:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, Yonghong Song <yhs@fb.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v7 resend 1/2] Provide in-kernel headers to make
 extending kernel easier
Message-ID: <20190503074908.GB27088@kroah.com>
References: <20190426190430.172543-1-joel@joelfernandes.org>
 <20190427133844.GA29366@kroah.com>
 <20190429132602.GA165075@google.com>
 <20190429135455.GA2412@kroah.com>
 <CAK7LNARkGLQ_P4LSuC69QN8XPN47W5ujkDE3EauLrwnBgygsSA@mail.gmail.com>
 <20190429142425.GB29007@kroah.com>
 <20190503073007.GA5834@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503073007.GA5834@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 03, 2019 at 09:30:07AM +0200, Pavel Machek wrote:
> > > > As you say, either is fine with me.
> > > >
> > > > > 2. Who is going to pull this patch: This seems a matter of where the header
> > > > > archive resides. If it is in /sys/kernel/ then I am assuming Greg will pull
> > > > > it.  Masahiro has given his Reviewed-by tag, is he the one to pull it?
> > > >
> > > > I can take it, but it probably should just go through the kbuild tree,
> > > > as that makes more sense to me.
> > > 
> > > 
> > > I do not want to take responsibility for this.
> > 
> > Hah, ok, I'll be glad to queue this up in my tree.  I'll take it now,
> > and if people who really object to this being in /proc/ and want it in
> > /sys/, we can add a follow-on patch before 5.2-final is out to move the
> > file to that location.
> 
> People really object to having it in kernel in the first place.

Then do not select that .config option, and all is good :)
