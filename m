Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A221647B23
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 02:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLIBJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 20:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLIBI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 20:08:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50A80A12
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 17:08:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so3334233pjo.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 17:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0W5fcABi4X+T/jYwfg3acG+mAXpKXLqoOLMcVDvb94=;
        b=YriPTaeIiA+dLmTSSSXERGxZoMyfxJhoF2Q8RM1j7icfTqEwdCfNmwHRywZVksID9N
         yt3L9g633vwLWxIZEY1PievSOwRoolVjFuC2ekFqhXWDrbAgmSyOG8E61xcBei/0WmkD
         n3zTXHfaLve5+vNvZO0l7Nq5ja3MPhbw/Zy0/wgqCgHFNdKS3cxS/4qNYhNLqDue4ooc
         J5EXd9M3CGckvr5AeCg01H05bHqrWl9oIldXxZyKGqNhqjj4kHaNhCQp1c7egMM531/g
         0N6aof8FoDZ0/n1nLpXmasPJ3LYaX/UAhpwEXGBjpWrXiOyYtqQVHTcsdM7gm/cVbdTY
         W13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0W5fcABi4X+T/jYwfg3acG+mAXpKXLqoOLMcVDvb94=;
        b=TyQKeWE4cW6k08IBpvUxDA3CqxvDpntErIoZOzlzK04E2G4Xe1q1BLge/fS6Af2vV+
         5yaUtNgZvLQjRt7vhN+aplT/kodtrfI6ip72cvl9l8/HDv/cUtIVXQHMKByvjz4eMyAN
         qelns9jFk+zyjx5LO1DozfaK5LBbHFlWPj8c5/gC7KB5+SXzB7YOLAt4bSTGqkiE1utG
         d43nFLoAIb8rhC+pUBEuK/XfymZKk7XsRKJG0w+lTsssNUvcfCAvYDNjaEDvAaVa7dbY
         zbWi+v+RDxNn4OhGwSI0IscBh69KiFcI5Zxr6RKYnHj+kHo8hU+4H71458EzEjsbjbrw
         8uCw==
X-Gm-Message-State: ANoB5plrbAooHGBNCYKtPGy31eO0Swd913ORefHysA6tSYwnHxnXMiGM
        C5zkIotgo8KqSU/BhqKlLBrf+A==
X-Google-Smtp-Source: AA0mqf7592VdpFGEsXHXafhoIIzr0OlDlMvX/sxUwlVGqoBDiQgVEZPiR3YzSXTZCX1tcoMfJ2vdoQ==
X-Received: by 2002:a17:902:d491:b0:189:858f:b5c0 with SMTP id c17-20020a170902d49100b00189858fb5c0mr1689887plg.0.1670548137442;
        Thu, 08 Dec 2022 17:08:57 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b00189e1522982sm51067plc.168.2022.12.08.17.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:08:57 -0800 (PST)
Date:   Fri, 9 Dec 2022 01:08:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ricardo Koller <ricarkol@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: selftests: Setup ucall after loading program
 into guest memory
Message-ID: <Y5KKpQSd8H88vDoH@google.com>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-3-oliver.upton@linux.dev>
 <Y5EoZ5uwrTF3eSKw@google.com>
 <Y5EtMWuTaJk9I3Bd@google.com>
 <Y5EutGSjkRmdItQb@google.com>
 <Y5Exwzr6Ibmmthl0@google.com>
 <Y5IxNTKRnacfSsLt@google.com>
 <Y5I0paok+dvTtrkt@google.com>
 <Y5I/xiFMLVbpAZj+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5I/xiFMLVbpAZj+@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 08, 2022, Ricardo Koller wrote:
> On Thu, Dec 08, 2022 at 07:01:57PM +0000, Sean Christopherson wrote:
> > On Thu, Dec 08, 2022, Ricardo Koller wrote:
> > > On Thu, Dec 08, 2022 at 12:37:23AM +0000, Oliver Upton wrote:
> > > > On Thu, Dec 08, 2022 at 12:24:20AM +0000, Sean Christopherson wrote:
> > > > > > Even still, that's just a kludge to make ucalls work. We have other
> > > > > > MMIO devices (GIC distributor, for example) that work by chance since
> > > > > > nothing conflicts with the constant GPAs we've selected in the tests.
> > > > > > 
> > > > > > I'd rather we go down the route of having an address allocator for the
> > > > > > for both the VA and PA spaces to provide carveouts at runtime.
> > > > > 
> > > > > Aren't those two separate issues?  The PA, a.k.a. memslots space, can be solved
> > > > > by allocating a dedicated memslot, i.e. doesn't need a carve.  At worst, collisions
> > > > > will yield very explicit asserts, which IMO is better than whatever might go wrong
> > > > > with a carve out.
> > > > 
> > > > Perhaps the use of the term 'carveout' wasn't right here.
> > > > 
> > > > What I'm suggesting is we cannot rely on KVM memslots alone to act as an
> > > > allocator for the PA space. KVM can provide devices to the guest that
> > > > aren't represented as memslots. If we're trying to fix PA allocations
> > > > anyway, why not make it generic enough to suit the needs of things
> > > > beyond ucalls?
> > > 
> > > One extra bit of information: in arm, IO is any access to an address (within
> > > bounds) not backed by a memslot. Not the same as x86 where MMIO are writes to
> > > read-only memslots.  No idea what other arches do.
> > 
> > I don't think that's correct, doesn't this code turn write abort on a RO memslot
> > into an io_mem_abort()?  Specifically, the "(write_fault && !writable)" check will
> > match, and assuming none the the edge cases in the if-statement fire, KVM will
> > send the write down io_mem_abort().
> 
> You are right. In fact, page_fault_test checks precisely that: writes on
> RO memslots are sent to userspace as an mmio exit. I was just referring
> to the MMIO done for ucall.

To clarify for others, Ricardo thought that x86 selftests were already using a
read-only memslot for ucalls, hence the confusion.

> Having said that, we could use ucall as writes on read-only memslots
> like what x86 does.

+1.  x86 currently uses I/O with a hardcoded port, but theoretically that's just
as error prone as hardcoding a GPA, it just works because x86 doesn't have any
port I/O tests.

Ugh, and that made me look at sync_regs_test.c, which does its own open coded
ucall.  That thing is probably working by dumb luck at this point.
