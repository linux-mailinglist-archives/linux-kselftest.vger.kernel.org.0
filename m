Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B89713E91
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2019 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEEJKe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 May 2019 05:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEEJKe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 May 2019 05:10:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EDB2082F;
        Sun,  5 May 2019 09:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557047433;
        bh=zBg2pFMN76OQLZ+8aW/TaJ4v4QpsKZHAAe6slSNkSOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0rdPKiSD3hDZaAO2Dle047AelS9XacX0duJjsXcjNgF3P1o2ucrL2vugZYZHpFnPr
         rieeOFFuYmxEthgUnLy+4Oe88iTS610NFs2I2e4tClmQ0KznSo2ykaZ2T0kOqSx8Os
         XtREL1U7LepT9tSyuUBA8d4yrwYYC2EpwgTQbcXo=
Date:   Sun, 5 May 2019 11:10:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20190505091030.GA25646@kroah.com>
References: <20190504121213.183203-1-joel@joelfernandes.org>
 <20190504122158.GA23535@kroah.com>
 <20190504123650.GA229151@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504123650.GA229151@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 04, 2019 at 08:36:50AM -0400, Joel Fernandes wrote:
> > But, you should change S_IRUGO to the correct octal number, checkpatch
> > should have barfed on this change.
> 
> fixed, below is the updated patch inline, thanks!

Please resend as a "real" submission, doing so in this format is a bit
more difficult to apply.

thanks,

greg k-h
