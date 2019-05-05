Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1DB13FAE
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2019 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfEEN01 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 May 2019 09:26:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46034 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfEEN01 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 May 2019 09:26:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id j1so500348qkk.12
        for <linux-kselftest@vger.kernel.org>; Sun, 05 May 2019 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMs3ZDG4UTtB7mWeq9fogx8Im6FYMW4NfffNVZ0T6g0=;
        b=Wx8/Qn4lhOzjepZEXkLBZ+w8/WHG8jhLCLZePQswk3nuOkWjV3N5eH3aZKCgdybogp
         7/TReM/N6U6Lw8RYN3lD4pnUWUG8h7F81NJCRUMPZDWBZMOfV4oc9MoHAgMWetH1nZpI
         OHyXUY0uszNgLft1e5rlQxJbPefuA34AZXXgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMs3ZDG4UTtB7mWeq9fogx8Im6FYMW4NfffNVZ0T6g0=;
        b=dXyjL4EvEYwsOY+xkEORmY7tmbAv6z47Tmxdk28MAVTUguV0nKCvcUr4K4eyx18vMI
         utvZFPDYhgoMszPB0napPzpIHwUlIAFqtgxFTueTh8z5AiiUA9gjzeGCXnlbiGKJGicn
         LEROjXRWtwZVAQbHhWvFcffZO6RGmdaT2Y7sln/1I3sN5VZLqvHAyiOBUMcDq92BTYap
         tIOrLERGIL8qT4gbkG5TWGbk0IjBVW090Aw5uGgsScgHgKlC7Kdz9QpHj+3WsmS0VYIN
         talHw9D2yE7ek4KvufYpGKdJiEA33RvYpY/BvmTcT5TXfJZPbKH19Ta2qXOx3LVn2xGT
         EOLQ==
X-Gm-Message-State: APjAAAVC9Qi3GvBnhNHTCnwcxMe5bnQVnpb2hWT6iJOOefnHllo8OoRU
        qaBl2DfS5UINzZFbU/lOj17dhA==
X-Google-Smtp-Source: APXvYqzN3LNC9F4r23JL3m1ARyAewSM1naLPRx+StaQtVcEsebbIkaf5I9yTOOJzVD+6xM/cfuUBLQ==
X-Received: by 2002:ae9:df43:: with SMTP id t64mr15613710qkf.250.1557062786462;
        Sun, 05 May 2019 06:26:26 -0700 (PDT)
Received: from localhost (c-73-216-90-110.hsd1.va.comcast.net. [73.216.90.110])
        by smtp.gmail.com with ESMTPSA id k127sm4921838qkb.96.2019.05.05.06.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 06:26:25 -0700 (PDT)
Date:   Sun, 5 May 2019 13:26:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20190505132623.GA3076@localhost>
References: <20190504121213.183203-1-joel@joelfernandes.org>
 <20190504122158.GA23535@kroah.com>
 <20190504123650.GA229151@google.com>
 <20190505091030.GA25646@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505091030.GA25646@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, May 05, 2019 at 11:10:30AM +0200, Greg KH wrote:
> On Sat, May 04, 2019 at 08:36:50AM -0400, Joel Fernandes wrote:
> > > But, you should change S_IRUGO to the correct octal number, checkpatch
> > > should have barfed on this change.
> > 
> > fixed, below is the updated patch inline, thanks!
> 
> Please resend as a "real" submission, doing so in this format is a bit
> more difficult to apply.

git am --scissors can do it, but no problem I will send as a formal
submission. Thanks a lot.


> 
> thanks,
> 
> greg k-h
