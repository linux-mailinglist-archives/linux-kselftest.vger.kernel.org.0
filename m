Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190ED1A85A
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2019 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEKQRT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 May 2019 12:17:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45990 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfEKQRT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 May 2019 12:17:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so4506583pgi.12
        for <linux-kselftest@vger.kernel.org>; Sat, 11 May 2019 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Odh+YMUmXqxxn2pUwWEKZYqwhsM/e7BZh99KpQUKonM=;
        b=qLq/xi5VaOmk5QBHpCipGArPVi3NegYyBubZ0l23k5Meagl/axkdmV0pJLKMnaBK6x
         719v6LAMXaMXcOXzRKnSMK9Cse4PTZxL4W79PAR6oqtFAKiPyR4GJfPIg8Xf7+4STwCO
         7DzTlF98i4slQDIv6HVl4kUQlCuvXNgpq5WCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Odh+YMUmXqxxn2pUwWEKZYqwhsM/e7BZh99KpQUKonM=;
        b=Oy4VUXHDf1qSGxvN40DfXxtFKuRPCYu77Td3vkDHkSgc1YIbM2jKnRnepC6MRHfXZ1
         vDuWc1dt6ZRBPBn8zD2V+DTVkly55FrtyOl+9FyR6EMFnbES6pUhDnHV/ra1toEQLPCv
         ZJQSUJoCIIRmC/foe0Moe1ZfyLqOiXec7vc8iVwZPa0OMQeQQuO0crn5Y0PNhZmyKp7U
         e7gi/DirHn8xTNJESCMAeRp27vrIIWgH7wSnbNGj7b+k7IpWbLWnPc7RK3+//H0eGfu6
         2ZKoWxgeG+u/IN7ZLRwFI1BBhw0kcGtZhHLcOSxnRho5ZnwBWESxTdu+iwAXJCNvp18c
         nx1Q==
X-Gm-Message-State: APjAAAWxNNnNPb3kh4QkunQ6W++qS2U+n1KwcW1fnLhOGkh8EGXFtYgr
        XuerwOw9zo7bxgrPsMF5ImsXTQ==
X-Google-Smtp-Source: APXvYqxTiJcEcmzT7eLWCLJAaF3JSIaR+WNDPlhbqHsPuJXlNFt0am0ojnsERLBSkb1Ve0uNPXHBVg==
X-Received: by 2002:a65:62c4:: with SMTP id m4mr21634116pgv.308.1557591438309;
        Sat, 11 May 2019 09:17:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z187sm12253685pfb.132.2019.05.11.09.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 May 2019 09:17:16 -0700 (PDT)
Date:   Sat, 11 May 2019 12:17:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        atish patra <atishp04@gmail.com>, bpf@vger.kernel.org,
        Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        duyuchao <yuchao.du@unisoc.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 3/3] kheaders: Make it depend on sysfs
Message-ID: <20190511161714.GA179270@google.com>
References: <20190510210243.152808-1-joel@joelfernandes.org>
 <20190510210243.152808-4-joel@joelfernandes.org>
 <CAK7LNATeJqmE29M=Y1Vexg8nnRdr3qUDkq1BejN7t2_106PgVg@mail.gmail.com>
 <20190511060203.GA18650@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511060203.GA18650@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 11, 2019 at 08:02:03AM +0200, Greg Kroah-Hartman wrote:
> On Sat, May 11, 2019 at 09:52:04AM +0900, Masahiro Yamada wrote:
> > On Sat, May 11, 2019 at 6:05 AM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > The kheaders archive is exposed through SYSFS in /sys/kernel/. Make it
> > > depend on SYSFS as it makes no sense to enable this feature without it.
> > 
> > 
> > And, it also makes no sense to break the feature by 1/3,
> > then fix it by 3/3.
> > 
> > 
> > Why don't you squash this?
> 
> I agree, this belongs in patch 1/3.

Fine with me. The reason I split it this way is I already had posted 1/3
recently for the driver tree [1], and I did not want to confuse Greg since he
was in the process of picking it up [2].

Anyway, I can resend the series soon with 1/3 and 3/3 squashed unless anyone
applying this is Ok with squashing it in their trees. thanks!

[1] https://lore.kernel.org/patchwork/patch/1070005/
[2] https://lore.kernel.org/patchwork/patch/1070005/#1267273

thanks,

 - Joel

