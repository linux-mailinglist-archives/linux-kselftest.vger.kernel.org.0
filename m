Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542D71B81F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Apr 2020 00:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDXWTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 18:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDXWTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 18:19:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B53BC09B049
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 15:19:53 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 20so11871721qkl.10
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGOMinoRPcnlI70rPdJ5CxQD7Vp6ODKBRmVseNmsuZY=;
        b=tG5V04JQRs9MpyavBTUEu6SJzTMe9vU3VMJ88lR+6ZUrYoEqlmpp12m/Ya+4OpN8u2
         uB3gz7ZlNbKXsn3/cfP5EslZpanIoo8KSPBfDGhlwhGt5rH7VyNrdLHUCb7jkpNofmwf
         zfCQu6BdxVM/q/sdAu7qFrec/Roka2/QYGGfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGOMinoRPcnlI70rPdJ5CxQD7Vp6ODKBRmVseNmsuZY=;
        b=JvHncHmOdjiim1OG4o/jwpAsrXnGNCpfInM0s7jYPca9kSM3T4uid2YBYR7sZBa+4k
         CASET245n4f7F6zWTiucAf6yO831mLsJjYc+BlBjiEPfPofsmk3pFOsB1BwRwJn6g7y9
         ExM+V9hARdFOsaxCEp1ACdm6tlQfByOieljgwCUVQQpqbg1Gmj+seUcIkzJ7xbQwbHzV
         P7g/VUnIG+wwqOfLwfGfIBnKBHPRwhzgnK6XMEaBzwljb5n98ZhKjmc+SdVxo7fljl0W
         j0j5UX+PkQ0iACpuzrKEDnbEeT/zIl2ZQ3gtJNw5AFPk6VE2qcTfzkUEA9AHgGVgtTc4
         gsVg==
X-Gm-Message-State: AGi0PuZ0qt0Rd7ZXToTKcIjh9UdGznVFMrHcGRstVUfBBuMWN6JLQeA5
        lR4SHtaBgBCNWh/4/UFraHlXBg==
X-Google-Smtp-Source: APiQypLrsrtO4O72DH1Yx6UZ82q7oUEWtaHTFWLkrOx2rtCxCGH5VGuzmIkMVfpYIUxUGnDOzMH8VQ==
X-Received: by 2002:ae9:f507:: with SMTP id o7mr10862620qkg.262.1587766791699;
        Fri, 24 Apr 2020 15:19:51 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j8sm4977784qtk.85.2020.04.24.15.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:19:51 -0700 (PDT)
Date:   Fri, 24 Apr 2020 18:19:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        linux-kselftest@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Xiao Yang <ice_yangxiao@163.com>
Subject: Re: preemptirq_delay_test module can trigger crash on arm64 vm
Message-ID: <20200424221950.GA162750@google.com>
References: <5EA2B0C8.2080706@cn.fujitsu.com>
 <20200424100146.786bcd7f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424100146.786bcd7f@gandalf.local.home>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 24, 2020 at 10:01:46AM -0400, Steven Rostedt wrote:
> On Fri, 24 Apr 2020 17:26:32 +0800
> Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> 
> > Hi Steve, Joel
> > 
> > Sorry to bother you.
> > 
> > On my slow arm64 vm, inserting and removing preemptirq_delay_test module
> > in loops triggers kernel panic sometimes.
> > 
> > Reproduce steps:
> > Do the following steps in loops(more than 10 times):
> > [root@CentOS81-aarch64 ]# modprobe preemptirq_delay_test
> > test_mode=preempt delay=500000; rmmod preemptirq_delay_test
> > 
> >
> 
> Joel,
> 
> I never did really look at that module, but doing a quick scan, I see you
> never clean up the task you start.
> 
> Which means, you can remove the module and the task still exists, and when
> it runs, it will execute code that has been freed.
> 
> The module exit should still do a kthread_stop() on it. If anything, it
> will prevent the task existing after the module is removed.

Thanks Steve for taking a look, I will submit a fix for it ASAP and send it to you
for -rc cycle. Thanks Xiao for the report.

 - Joel

