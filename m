Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817131CEC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 20:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfENSMk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 14:12:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46628 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfENSMk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 14:12:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id t187so9005858pgb.13
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N4UQ8E37RD8PM/SrG8N/O0bEDGjz00r1+gSc2WyT1f4=;
        b=Do+8Q+pHF8OB+tlzSEbCAlPOY5hObzGGmcvPm0YH3pOm8OWb+2EG6k/+3FX9ODnKET
         HeeejJJzGaiMQRAOmVbGKQQo9GMUp77yZaFJ+oq5A5++UZ2bqGz1eozejMrClIviWLaH
         6NqHaVQChwYnFjxvjCGyJrQCTbtCzP1YDVjWmeDvwiekfu/CIsr1rAo7eeV2cOghCM3s
         jg1XfDoXavpa+8h5sP6zhUgTkyTdA3gv3smrtEjkWIEZtUEMHzNqwHjzR4ACtYGyLA5t
         PjdZhQFtOg524SURCKg00duz4q2SfEaie9Z/aI0bjh6oNPjygJN8c7oYJhw88kmkUhL7
         hq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N4UQ8E37RD8PM/SrG8N/O0bEDGjz00r1+gSc2WyT1f4=;
        b=qkvGUHLK4A8cibkHoRpnNq3nzjLZsrb0lIalQu6ds74Ru4DSrM1HXLIevC1Ni0/SM/
         za2UEvS08kq8F4up8Z/OuSO56FP909jw0t/CUtyRv2ywaiLky+eMA4jMlKMsUT8rwosc
         Q0DPOuJ208cZSBZdpNkpkPrutgE/lly6J/LcxaS842yKdOsUkPn5YigGu0fVTFs5nm+U
         7r7EGNLxqQn71jXqf9AQKudxAfHPVlxhxLxFY1KRwvVEWDWIGiOhJ0KCAU1ANZe8U4S6
         27PPogn5a0b5r1RUF7ERKX9K65S+hF1Fz3RrIxYIyEXURKcYf/qSPNs1GrzwG0NxEBKi
         NaYQ==
X-Gm-Message-State: APjAAAX03dV3v9QIzPBvNMUVaTyiVWSoCnTq36v8Mx167UYDGf51/zIK
        vvFl7OxsDe6kh56h02UxCVJ4Fw==
X-Google-Smtp-Source: APXvYqzF1W3MvAqglRw1f3U3GzCogO4oDzfR+rvBgcAvxH3aiWBoZY2un6t4j9IVvIzAxmzzun0V4w==
X-Received: by 2002:a62:d244:: with SMTP id c65mr3681839pfg.173.1557857559066;
        Tue, 14 May 2019 11:12:39 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id w189sm22611956pfw.147.2019.05.14.11.12.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 11:12:38 -0700 (PDT)
Date:   Tue, 14 May 2019 11:12:33 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 08/18] objtool: add kunit_try_catch_throw to the
 noreturn list
Message-ID: <20190514181233.GB109557@google.com>
References: <20190514054251.186196-1-brendanhiggins@google.com>
 <20190514054251.186196-9-brendanhiggins@google.com>
 <20190514065643.GC2589@hirez.programming.kicks-ass.net>
 <20190514081223.GA230665@google.com>
 <20190514084655.GK2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514084655.GK2589@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 14, 2019 at 10:46:55AM +0200, Peter Zijlstra wrote:
> On Tue, May 14, 2019 at 01:12:23AM -0700, Brendan Higgins wrote:
> > On Tue, May 14, 2019 at 08:56:43AM +0200, Peter Zijlstra wrote:
> > > On Mon, May 13, 2019 at 10:42:42PM -0700, Brendan Higgins wrote:
> > > > This fixes the following warning seen on GCC 7.3:
> > > >   kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()
> > > > 
> > > 
> > > What is that file and function; no kernel tree near me seems to have
> > > that.
> > 
> > Oh, sorry about that. The function is added in the following patch,
> > "[PATCH v3 09/18] kunit: test: add support for test abort"[1].
> > 
> > My apologies if this patch is supposed to come after it in sequence, but
> > I assumed it should come before otherwise objtool would complain about
> > the symbol when it is introduced.
> 
> Or send me all patches such that I have context, or have a sane
> Changelog that gives me context. Just don't give me one patch with a
> crappy changelog.

I will provide more context in the next revision.

Sorry about that!
