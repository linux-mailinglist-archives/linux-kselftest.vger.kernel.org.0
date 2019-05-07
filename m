Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE1B16882
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2019 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfEGQ5V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 May 2019 12:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfEGQ5V (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 May 2019 12:57:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA68D2054F;
        Tue,  7 May 2019 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557248240;
        bh=D6MpCQTS8LI1AAzN1OZT+Q/x/AiPwhtV7g7kacQEbx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjgx1GTyMP+8PrB4yhNbdYYUT4PUzjnrXZrXUGgoIXuA1GMtcBVXzbftpqViPkLRf
         Od3fEvQcUMn8gEGQgMi4aq2W81hyvEPRzpOFzYwjYPV58uOgOdz57cUJFqiCQmFdMh
         NM+XkPDA1KAFGGjnkOidL7aoRawFLQCcA14u1/ds=
Date:   Tue, 7 May 2019 18:57:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: Re: [PATCH v2] kheaders: Move from proc to sysfs
Message-ID: <20190507165718.GA1241@kroah.com>
References: <20190504121213.183203-1-joel@joelfernandes.org>
 <20190504122158.GA23535@kroah.com>
 <20190504123650.GA229151@google.com>
 <20190505091030.GA25646@kroah.com>
 <20190505132623.GA3076@localhost>
 <20190505163145.45f77e44@oasis.local.home>
 <20190507163824.GC89248@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507163824.GC89248@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 07, 2019 at 12:38:24PM -0400, Joel Fernandes wrote:
> On Sun, May 05, 2019 at 04:31:45PM -0400, Steven Rostedt wrote:
> > On Sun, 5 May 2019 13:26:23 +0000
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > On Sun, May 05, 2019 at 11:10:30AM +0200, Greg KH wrote:
> > > > On Sat, May 04, 2019 at 08:36:50AM -0400, Joel Fernandes wrote:  
> > > > > > But, you should change S_IRUGO to the correct octal number, checkpatch
> > > > > > should have barfed on this change.  
> > > > > 
> > > > > fixed, below is the updated patch inline, thanks!  
> > > > 
> > > > Please resend as a "real" submission, doing so in this format is a bit
> > > > more difficult to apply.  
> > > 
> > > git am --scissors can do it, but no problem I will send as a formal
> > > submission. Thanks a lot.
> > >
> > 
> > True, but a lot of us depend on scripts to pull in patches from our
> > INBOX. Which is why we like them to stay with the standard format.
> 
> Thanks makes sense. So Greg, I submitted this properly, does it look good to
> you now? Steven, I would appreciate any Acks/Reviews on the patch as well:
> https://lore.kernel.org/patchwork/patch/1070199/

Looks good to me, should get to it in a few days...
