Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E471CB9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfENPQs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 11:16:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38663 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENPQs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 11:16:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so1837878wru.5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ldoasDQ7UppVRifjaSRw3DpwTvd/jIO8STWlnJPAxfE=;
        b=NCuQ5Dx09mZmmtzR1xCLl1TJ1ZNRcWelTVn+oju+wnaLyYL57pGcqbSf7uqmQ27/U/
         5C/BnuK8H8cKtgNxm4+qMSgZGu5zC/Ty4xgBLY54/Bax9I596zMvA2KcYHFsjgMWKCnM
         VCr8aK+l/CQmDm4t0z6sG4/3SPJKapBhU03Nu5g3CNGu7EH0Uf/FXjQUrJPkxx0JMYmg
         F22T146IzA5zKetOzh2IVhJsE4wK//Kc19vlMAyfYMbOK0HxTshJ6lXBvXu5FgXVzT//
         qfTWUMIf3MRB34wG3t+rO8zACW7VpxaHFrTTPo3OS2wbYrwSkXALxZtRVt1314LhtseC
         +V9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ldoasDQ7UppVRifjaSRw3DpwTvd/jIO8STWlnJPAxfE=;
        b=IdT4Sis+6hraOKQ37l5DqcERXxSUeCeXZrCuwzvyQaLGAf/h06brToIzT309zLQj/k
         ElRJd4YfVv32v1zfdgXu/skTP3FmyIvY+So6cUfgukrTX8Mk2KMT3cVrqWDqoWCbY/f3
         FglBRcpNPEy1ysxmN2kAhEN6r5bMRxfzfu4I417ha7RzcM05O+HuDifEEwrV+0wcDIHA
         K+sTR28ZwdDXkvEn3GklFZjhmbGKLJKnQRvE1OI+Ew/ay+GAtb+ngowl7/Dz+9IalE3P
         kPCtseIl3zMZw501kMginSUY2GcEy68ZMrLA7UpP/ns60PQu8qlcHD3/EAmYprdb/PvJ
         LPuA==
X-Gm-Message-State: APjAAAURqKa4f1+SSuSfQPau/y3ZcrRQaswGOc4ZyH9Tt6nL/q+lxzRo
        nVfyy1MOvZc+DYpXwg/QGxtY+A==
X-Google-Smtp-Source: APXvYqxIfmglfSdFhF5NGPO1mepeasVBqjYZcAsJqS+2XU0UT5lyfQrgwd3nc3CRa0ONcFJ/HM4hTA==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr14648596wrw.274.1557847006476;
        Tue, 14 May 2019 08:16:46 -0700 (PDT)
Received: from brauner.io ([81.92.17.132])
        by smtp.gmail.com with ESMTPSA id i25sm5169501wmb.46.2019.05.14.08.16.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 08:16:45 -0700 (PDT)
Date:   Tue, 14 May 2019 17:16:42 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <20190514151605.7aadxh6owlk42bwr@brauner.io>
References: <20190430162154.61314-1-joel@joelfernandes.org>
 <20190501151312.GA30235@redhat.com>
 <20190502151320.cvc6uc3b4bmww23k@brauner.io>
 <20190502160247.GD7323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190502160247.GD7323@redhat.com>
User-Agent: NeoMutt/20180716
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
> 
> Yes, feel free to add
> 
> 	Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Applied to 

https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next

and targeted for the 5.3 merge window.

Thank you all!
Christian
