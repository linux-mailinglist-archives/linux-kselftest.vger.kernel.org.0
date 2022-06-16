Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF354E821
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiFPQxb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378441AbiFPQs3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 12:48:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49E8236E25
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 09:48:08 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-90-KsoYMlcUM_yKluVn1AzPOw-1; Thu, 16 Jun 2022 17:48:06 +0100
X-MC-Unique: KsoYMlcUM_yKluVn1AzPOw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 16 Jun 2022 17:48:04 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 16 Jun 2022 17:48:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Jones' <drjones@redhat.com>
CC:     Raghavendra Rao Ananta <rananta@google.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        "Ricardo Koller" <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        "Reiji Watanabe" <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        "Colton Lewis" <coltonlewis@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] selftests: KVM: Handle compiler optimizations in ucall
Thread-Topic: [PATCH] selftests: KVM: Handle compiler optimizations in ucall
Thread-Index: AQHYgXkNkdHi2edO0UOJoWwOrv/ni61SMGPg///3a4CAABX/cA==
Date:   Thu, 16 Jun 2022 16:48:04 +0000
Message-ID: <3e73cb07968d4c92b797781b037c2d45@AcuMS.aculab.com>
References: <20220615185706.1099208-1-rananta@google.com>
 <20220616120232.ctkekviusrozqpru@gator>
 <33ca91aeb5254831a88e187ff8d9a2c2@AcuMS.aculab.com>
 <20220616162557.55bopzfa6glusuh5@gator>
In-Reply-To: <20220616162557.55bopzfa6glusuh5@gator>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrew Jones
> Sent: 16 June 2022 17:26
> 
> On Thu, Jun 16, 2022 at 03:58:52PM +0000, David Laight wrote:
> > From: Andrew Jones
> > > Sent: 16 June 2022 13:03
> > >
> > > On Wed, Jun 15, 2022 at 06:57:06PM +0000, Raghavendra Rao Ananta wrote:
> > > > The selftests, when built with newer versions of clang, is found
> > > > to have over optimized guests' ucall() function, and eliminating
> > > > the stores for uc.cmd (perhaps due to no immediate readers). This
> > > > resulted in the userspace side always reading a value of '0', and
> > > > causing multiple test failures.
> > > >
> > > > As a result, prevent the compiler from optimizing the stores in
> > > > ucall() with WRITE_ONCE().
> > > >
> > > > Suggested-by: Ricardo Koller <ricarkol@google.com>
> > > > Suggested-by: Reiji Watanabe <reijiw@google.com>
> > > > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > > ---
> > > >  tools/testing/selftests/kvm/lib/aarch64/ucall.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > > b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > > > index e0b0164e9af8..be1d9728c4ce 100644
> > > > --- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > > > +++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > > > @@ -73,20 +73,19 @@ void ucall_uninit(struct kvm_vm *vm)
> > > >
> > > >  void ucall(uint64_t cmd, int nargs, ...)
> > > >  {
> > > > -	struct ucall uc = {
> > > > -		.cmd = cmd,
> > > > -	};
> > > > +	struct ucall uc = {};
> > > >  	va_list va;
> > > >  	int i;
> > > >
> > > > +	WRITE_ONCE(uc.cmd, cmd);
> > > >  	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> > > >
> > > >  	va_start(va, nargs);
> > > >  	for (i = 0; i < nargs; ++i)
> > > > -		uc.args[i] = va_arg(va, uint64_t);
> > > > +		WRITE_ONCE(uc.args[i], va_arg(va, uint64_t));
> > > >  	va_end(va);
> > > >
> > > > -	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
> > > > +	WRITE_ONCE(*ucall_exit_mmio_addr, (vm_vaddr_t)&uc);
> > > >  }
> >
> > Am I misreading things again?
> > That function looks like it writes the address of an on-stack
> > item into global data.
> 
> The write to the address that the global points at causes a switch
> from guest to host context. The guest's stack remains intact while
> executing host code and the host can access the uc stack variable
> directly by its address. Take a look at lib/aarch64/ucall.c to see
> all the details.

No wonder I was confused.
It's not surprising the compiler optimises it all away.

It doesn't seem right to be 'abusing' WRITE_ONCE() here.
Just adding barrier() should be enough and much more descriptive.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

