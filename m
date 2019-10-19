Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334BEDDA1F
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2019 20:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfJSSgr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Oct 2019 14:36:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42838 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfJSSgr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Oct 2019 14:36:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so5811858pff.9;
        Sat, 19 Oct 2019 11:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diC5OhcgPAQon4MoTk8oBGJIDhBSL5N3IWATCx4/9pA=;
        b=fPzpyISqGRrzhG3UjcuuoLYaIWtp+frAaLeP6a6dfGgX/cLKXk+T9NFIDUtYY8oPGG
         4KYgmWPdyz5bbiBKd0DnLXt1lVV02TSCMB/oGkGKqBl1BcoAQ13vKI3Mh3j1nwwUcLSR
         w0ciXPA6NjD5BbhhT2B5pHfd9iAySV0pbzPut53QAPVKvIafm+B6odLaeMzb8qd9ZQ+b
         hI/7pmc/NdMRZpioE30XcpiaGGGQxunwG6ZjH01FIo6xRQoSFL5gXwoa+DAeYS3m0xx/
         L8u9i0KTn2vTAHbRz/bsLlfJMT+tp9hkHpQtE7T/s3NZ6g9rO0o9QxjezZntUHgC5Rwq
         M5zw==
X-Gm-Message-State: APjAAAXxbk1au8JZEnFgCwO5OJwP27r9DQX7fV4mc8NKB/eJ0xM+lMgX
        0TTRJHXV0jR3vWNCcmpPFL4=
X-Google-Smtp-Source: APXvYqzcpP34+frn1/CdUknue2M5Tq2aDYuthXzjQKvIYfvhH7DL4POvzlf4Nw6JCIodII+YDGkI6Q==
X-Received: by 2002:a63:1e04:: with SMTP id e4mr16626950pge.4.1571510205979;
        Sat, 19 Oct 2019 11:36:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e192sm10404393pfh.83.2019.10.19.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 11:36:44 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8F7D440256; Sat, 19 Oct 2019 18:36:43 +0000 (UTC)
Date:   Sat, 19 Oct 2019 18:36:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Matthias Maennich <maennich@google.com>, shuah@kernel.org,
        john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, yzaikin@google.com, davidgow@google.com,
        tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <20191019183643.GG11244@42.do-not-panic.com>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com>
 <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 19, 2019 at 01:56:01PM +0100, Alan Maguire wrote:
> On Fri, 18 Oct 2019, Luis Chamberlain wrote:
> 
> > On Thu, Oct 17, 2019 at 05:18:16PM -0700, Brendan Higgins wrote:
> > > From: Mike Salvatore <mike.salvatore@canonical.com>
> > > 
> > > In order to write the tests against the policy unpacking code, some
> > > static functions needed to be exposed for testing purposes. One of the
> > > goals of this patch is to establish a pattern for which testing these
> > > kinds of functions should be done in the future.
> > 
> > And you'd run into the same situation expressed elsewhere with kunit of
> > an issue of the kunit test as built-in working but if built as a module
> > then it would not work, given the lack of exports. Symbols namespaces
> > should resolve this [0], and we'd be careful where a driver imports this
> > namespace.
> > 
> > [0] https://lwn.net/Articles/798254/
> >
> 
> Thanks for the link! Looks interesting for us definitely!
> 
> WRT adding tests, I think what we're aiming at is a set of best practices 
> to advise test developers using KUnit, while attempting to minimize 
> side-effects of any changes we need to make to support testability.
> 
> One aspect of this we probably have to consider is inlining of code. 

Sure. Makes sense.

  Luis
