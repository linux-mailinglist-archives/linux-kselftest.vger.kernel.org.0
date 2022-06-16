Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7466554E6EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 18:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiFPQ0H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 12:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiFPQ0G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 12:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58B872E9FB
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655396763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cq3EZTL12suGQBdO/AxiYch3x1bNx+94IHDi7h+Rhok=;
        b=d9gXLvdu00EYqZtFdIzNu/qXjl6xZT6JlP4rqiShGKxiddvtP/QVT0+v1T1q8Buvq9uK5G
        sK4WgMTViLwlZQrDXxdNMDwDwVgYZikzxwsRbFof5fIBzf6nxdq8al+D7J9nj3xbpGLxDy
        Qn80C5sX+zP2NipfP+HMcoIyv7UpURs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-swKCR6HnNumsQXhLp8fT1g-1; Thu, 16 Jun 2022 12:26:02 -0400
X-MC-Unique: swKCR6HnNumsQXhLp8fT1g-1
Received: by mail-ed1-f69.google.com with SMTP id co13-20020a0564020c0d00b0042dc9ef4f01so1581644edb.16
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 09:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cq3EZTL12suGQBdO/AxiYch3x1bNx+94IHDi7h+Rhok=;
        b=KRasW7lpvaKfzTlTgHAYmGwuf1fN1ZA7C1dSFo/nJ75QNpC2iC+yFuins68duHLZ3L
         z2n0Hv59CRphC1jcN1SMzOYU5eXCfB1LS2c7lf2cDLOHJy45kIACk43wpZ3o+nGncSaK
         oezjIPBfMYAUkFjg6/EIU7iKXIQm7WbfVIh5c2hHMDODvXsvFGCrfI4W0T0WfzfFUso3
         l8dmjasS/2huzIgjX5tVwV+ymmkwiAC663kA6fy6dFq8JK6KnRmEo/bjZAZQEExibao2
         ejLGo1lSUjwpXpTOWlImA1QhV0g/mx1nPXK/oDWlZTf8Qtz59WD9xPTzd6IoIMC+9Hkl
         28eg==
X-Gm-Message-State: AJIora+S07rs3uObuWwyYwFNnyRy82hdrGLo4gYkd9CIpe+jBWXQIPBC
        KF3ftkTGwpMu/Ln2ypDzR8waPTVKfYBkwe1P34fH1D8zUFRGZws210Y5siZdIEaa7nWiZkTJBn9
        RuWXPWiFeg/m94WPQv2dz88PLgakW
X-Received: by 2002:a17:906:ff18:b0:711:d197:b942 with SMTP id zn24-20020a170906ff1800b00711d197b942mr5233781ejb.357.1655396760903;
        Thu, 16 Jun 2022 09:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1snrckDTTS90UbXkNnXz7wC/j3NwBRdfiiLHQ55Yf08Jlwcihk2BkICbCcSqD0NukcTombHSw==
X-Received: by 2002:a17:906:ff18:b0:711:d197:b942 with SMTP id zn24-20020a170906ff1800b00711d197b942mr5233761ejb.357.1655396760732;
        Thu, 16 Jun 2022 09:26:00 -0700 (PDT)
Received: from gator ([194.213.204.253])
        by smtp.gmail.com with ESMTPSA id ep14-20020a1709069b4e00b006febc86b8besm936606ejc.117.2022.06.16.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:26:00 -0700 (PDT)
Date:   Thu, 16 Jun 2022 18:25:57 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Raghavendra Rao Ananta <rananta@google.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests: KVM: Handle compiler optimizations in ucall
Message-ID: <20220616162557.55bopzfa6glusuh5@gator>
References: <20220615185706.1099208-1-rananta@google.com>
 <20220616120232.ctkekviusrozqpru@gator>
 <33ca91aeb5254831a88e187ff8d9a2c2@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ca91aeb5254831a88e187ff8d9a2c2@AcuMS.aculab.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 16, 2022 at 03:58:52PM +0000, David Laight wrote:
> From: Andrew Jones
> > Sent: 16 June 2022 13:03
> > 
> > On Wed, Jun 15, 2022 at 06:57:06PM +0000, Raghavendra Rao Ananta wrote:
> > > The selftests, when built with newer versions of clang, is found
> > > to have over optimized guests' ucall() function, and eliminating
> > > the stores for uc.cmd (perhaps due to no immediate readers). This
> > > resulted in the userspace side always reading a value of '0', and
> > > causing multiple test failures.
> > >
> > > As a result, prevent the compiler from optimizing the stores in
> > > ucall() with WRITE_ONCE().
> > >
> > > Suggested-by: Ricardo Koller <ricarkol@google.com>
> > > Suggested-by: Reiji Watanabe <reijiw@google.com>
> > > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > ---
> > >  tools/testing/selftests/kvm/lib/aarch64/ucall.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > > index e0b0164e9af8..be1d9728c4ce 100644
> > > --- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > > +++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > > @@ -73,20 +73,19 @@ void ucall_uninit(struct kvm_vm *vm)
> > >
> > >  void ucall(uint64_t cmd, int nargs, ...)
> > >  {
> > > -	struct ucall uc = {
> > > -		.cmd = cmd,
> > > -	};
> > > +	struct ucall uc = {};
> > >  	va_list va;
> > >  	int i;
> > >
> > > +	WRITE_ONCE(uc.cmd, cmd);
> > >  	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> > >
> > >  	va_start(va, nargs);
> > >  	for (i = 0; i < nargs; ++i)
> > > -		uc.args[i] = va_arg(va, uint64_t);
> > > +		WRITE_ONCE(uc.args[i], va_arg(va, uint64_t));
> > >  	va_end(va);
> > >
> > > -	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
> > > +	WRITE_ONCE(*ucall_exit_mmio_addr, (vm_vaddr_t)&uc);
> > >  }
> 
> Am I misreading things again?
> That function looks like it writes the address of an on-stack
> item into global data.

The write to the address that the global points at causes a switch
from guest to host context. The guest's stack remains intact while
executing host code and the host can access the uc stack variable
directly by its address. Take a look at lib/aarch64/ucall.c to see
all the details.

Thanks,
drew

