Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8710733034F
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 18:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCGRZv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 12:25:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:11751 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhCGRZm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 12:25:42 -0500
IronPort-SDR: 5Q7wxjbnS1+h/UWRldiUIfy+xsdpfJng+ta2IL95h9Lwf5/8Mrve1nj+OetunrEltcm41MyGMg
 LSMwoEqIu7lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="207670084"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="207670084"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 09:25:41 -0800
IronPort-SDR: rSoFigCEmmTYnqnwUTH2pXaCT5FBs+xAJ1e4TvkEBQ41R2+ZebVFnZ6085RExhtLtl5o7mip47
 upLDQWNxvz5w==
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="430081838"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 09:25:41 -0800
Date:   Sun, 7 Mar 2021 09:25:40 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     John Wood <john.wood@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <20210307172540.GS472138@tassilo.jf.intel.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
 <20210307151920.GR472138@tassilo.jf.intel.com>
 <20210307164520.GA16296@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307164520.GA16296@ubuntu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> processes created from it will be killed. If the systemd restart the network
> daemon and it will crash again, then the systemd will be killed. I think this
> way the attack is fully mitigated.

Wouldn't that panic the system? Killing init is usually a panic.

> > Or if it's a interactive login you log in again.
> 
> First the login will be killed (if it fails with a fatal signal) and if it is
> restarted, the process that exec() it again will be killed. In this case I think
> that the threat is also completely mitigated.

Okay so sshd will be killed. And if it gets restarted eventually init,
so panic again.

That's a fairly drastic consequence because even without panic 
it means nobody can fix the system anymore without a console.

So probably the mitigation means that most such attacks eventually lead
to a panic because they will reach init sooner or later.

Another somewhat worrying case is some bug that kills KVM guests.
So if the bug can be triggered frequently you can kill all the
virtualization management infrastructure.

I don't remember seeing a discussion of such drastic consequences in
your description. It might be ok depending on the use case,
but people certainly need to be aware of it.

It's probably not something you want to have enabled by default ever.

-Andi

