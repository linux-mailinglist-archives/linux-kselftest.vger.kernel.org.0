Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED01227F
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2019 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfEBTOm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 May 2019 15:14:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44249 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfEBTOl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 May 2019 15:14:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so1479814pgv.11
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T87TJAQEItZ/8IKuRT/VOsqnktTnyrxp/uVvFEniYMA=;
        b=vBv6PoK0WcmYtiIfYiYRttaKU6sySuqlp2bz5MAKrEwpGt1gue3gzyHG11PiGfzpcw
         3MNNE7KR0yeU4+4xNbx9fp+4t1kJJWsSD3Bd3y2xlf2o948io5GNWybzWlXv1qF6rMqO
         W1SENeUpDnopBUPQi4IYCnMgIeGn5O8Gv2YK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T87TJAQEItZ/8IKuRT/VOsqnktTnyrxp/uVvFEniYMA=;
        b=F9JQXeGQ8Ybv1F3WNq/GYaupphZoP9ASac2TXh+GCx65JH0i3C5AWgjt91sgA5Ctm6
         W25Fr9RiXsIrIQdQuvkKu2QXX54HnX94KXuApRX4gt7EOB98CRMBbLUq6ve4TQ03wUX3
         KTIMoZNJwZ8VEU3wzNlW59IbtZ3CGYhWArmzMnxY+Y0VHnqimsFtlb6FGudv5U6YWUX3
         M7Pz1M43ZpUoLWClb3YPrLGqzzCUngcRW6iNZ2p2VKg6TZdQzRDMTYIQD0ZUf9UPeQ5S
         d09hrEF66gatGa2ZOoT90M9OfxYhvmA9eJ7YjcSXSGTljSYzCpdfuvF9Xfghle87SfCu
         g6vg==
X-Gm-Message-State: APjAAAWQn74S07j/aSOGoOkI1XqZdr4+17+rE5IkR7cPtasWJILZkTX2
        Lz6/5GqnKP3eg8HtcUj/DehlFw==
X-Google-Smtp-Source: APXvYqzA5/HIyej28h0lLtHCsm2clDFlAORBWM0decWBelSise8oK0pTjZR+reURwiFiGKrXF2W/2w==
X-Received: by 2002:a63:fa46:: with SMTP id g6mr5766362pgk.382.1556824480553;
        Thu, 02 May 2019 12:14:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z124sm48008758pfz.116.2019.05.02.12.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 12:14:39 -0700 (PDT)
Date:   Thu, 2 May 2019 15:14:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Tim Murray <timmurray@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v2 1/2] Add polling support to pidfd
Message-ID: <20190502191437.GA103213@google.com>
References: <20190430162154.61314-1-joel@joelfernandes.org>
 <20190501151312.GA30235@redhat.com>
 <20190502151320.cvc6uc3b4bmww23k@brauner.io>
 <20190502160247.GD7323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502160247.GD7323@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 02, 2019 at 06:02:48PM +0200, Oleg Nesterov wrote:
> On 05/02, Christian Brauner wrote:
> >
> > On Wed, May 01, 2019 at 05:13:12PM +0200, Oleg Nesterov wrote:
> > >
> > > Otherwise I see no problems.
> >
> > I'll remove the WARN_ON() check when applying this. Can I get your
> > Acked/Review, Oleg?

Oh, ok. Good point about the de_thread race. Agreed with you.

> Yes, feel free to add
> 
> 	Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> Hmm. Somehow I didn't read the changelog before, I just noticed
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Please remove ;) Thanks Joel, I appreciate it, but it is not my idea.

Ok no problem. You have been very helpful so thank you for that!

Also thanks Christian for removing the warning and adding Oleg's Reviewed-by.

 - Joel

