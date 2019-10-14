Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8CD6073
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfJNKmq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 06:42:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41384 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbfJNKmq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 06:42:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so7840257plr.8
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2019 03:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SXpcg/H0jtW5vgbpwS+CM1RYOydqdouPj1mZ1ztIGuY=;
        b=A+tdDjwDmKMqBiZW6Fv0j6PY4SAxBcwdsPHx4wAKCSXSL7q269ZOFSCzucgMTZGIRs
         HksKD7ywE6kf64fnMICxS565G82NXXoYtRccvvVd6zAu7wR2WCeesLks9BC7NQsiIgIF
         wuthlicDp/lt+tCImIKwjczsKLG132sJvkGZDfpiPCnwMOdNmBoidB9nQ3zzNHm1tx3T
         BlM149TNeFTv2mos+TQaSHQiyB5PfryX2aqFjcm2qXdHHuHV+c6gNKLXE0C0Ldi0c0JC
         pBYtJXKvArgSDHLHPcpBgNes0qXQRTq18sKi7zfe14u6gv14N+LjPIcA0KjoCaBTLOYz
         /3cQ==
X-Gm-Message-State: APjAAAVrvkP0vGcVnk7TCafgZTU8gcNBJhWu+1D5F2OUgXDbgNaeiLG+
        EYRtnpvgr/Dn4WH9K6zN1J7vqeVWlWE=
X-Google-Smtp-Source: APXvYqxO855Qdm1a04+it7b5etTGII3OX7nvYwqUWRUW/VTFErVvOYC+kPSCixpSKHVqwx/ks2b2tw==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr20553736plr.298.1571049765837;
        Mon, 14 Oct 2019 03:42:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d5sm27907460pfa.180.2019.10.14.03.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 03:42:44 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C26834021A; Mon, 14 Oct 2019 10:42:43 +0000 (UTC)
Date:   Mon, 14 Oct 2019 10:42:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Knut Omang <knut.omang@oracle.com>, Shuah Khan <shuah@kernel.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Subject: Re: Plan for hybrid testing
Message-ID: <20191014104243.GD16384@42.do-not-panic.com>
References: <20190913210247.GA86838@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913210247.GA86838@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
> Hey Knut and Shuah,
> 
> Following up on our offline discussion on Wednesday night:
> 
> We decided that it would make sense for Knut to try to implement Hybrid
> Testing (testing that crosses the kernel userspace boundary) that he
> introduced here[1] on top of the existing KUnit infrastructure.
> 
> We discussed several possible things in the kernel that Knut could test
> with the new Hybrid Testing feature as an initial example. Those were
> (in reverse order of expected difficulty):
> 
> 1. RDS (Reliable Datagram Sockets) - We decided that, although this was
>    one of the more complicated subsystems to work with, it was probably
>    the best candidate for Knut to start with because it was in desperate
>    need of better testing, much of the testing would require crossing
>    the kernel userspace boundary to be effective, and Knut has access to
>    RDS (since he works at Oracle).
> 
> 2. KMOD - Probably much simpler than RDS, and the maintainer, Luis
>    Chamberlain (CC'ed) would like to see better testing here, but
>    probably still not as good as RDS because it is in less dire need of
>    testing, collaboration on this would be more difficult, and Luis is
>    currently on an extended vacation. Luis and I had already been
>    discussing testing KMOD here[2].

I'm back!

I'm also happy and thrilled to help review the infrastructure in great
detail given I have lofty future objectives with testing in the kernel.
Also, kmod is a bit more complex to test, if Knut wants a simpler *easy*
target I think test_sysctl.c would be a good target. I think the goal
there would be to add probes for a few of the sysctl callers, and then
test them through userspace somehow, for instance?

The complexities with testing kmod is the threading aspect. So that is
more of a challenge for a test infrastructure as a whole. However kmod
also already has a pretty sound kthread solution which could be used
as basis for any sound kernel multithread test solution.

Curious, what was decided with the regards to the generic netlink approach?

  Luis
