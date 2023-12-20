Return-Path: <linux-kselftest+bounces-2253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1451819B0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 10:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB01D1C22156
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1911CAB9;
	Wed, 20 Dec 2023 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF+fgMS9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6DF1D6B1;
	Wed, 20 Dec 2023 09:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D58C433C7;
	Wed, 20 Dec 2023 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703062851;
	bh=aP+or2O2Amx3o066NoYjmEoMeqgvW6u+ehSxtWedg58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KF+fgMS9J85VBtFxE6C+CCleuJv2Zec2Xe4q/rr8qCPuNT4X6BnizX1N/UkQkN0Uj
	 nE3rnBnfP8GJp5JDIKnUtJT1EOslUeIc9Kz5N69A2/7m1+FIVrf69/71oD5mrDBFxI
	 booZixCOostTgj5lokin2FLDaIOi2WdnoU8GbPtNSt+sF2yj7AclNl2tQftWrRBS7l
	 JJyJBvH61E1GgPgIUr0Ld2sEUG0nbwpR+ldnI5O8jY1BRUmblOm5PXaKXgqHhgnQVW
	 mA1nuVNA29MagVh7YGOQLOafINsTUpneKa1N6i2cXp2CD1Sm33c1/4UTrwQyw4bBKL
	 qt8myFyRPxaTQ==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rFsRc-005chY-Hw;
	Wed, 20 Dec 2023 09:00:48 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Dec 2023 09:00:48 +0000
From: Marc Zyngier <maz@kernel.org>
To: Haibo Xu <xiaobo55x@gmail.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, James Morse
 <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, Mayuresh Chitale
 <mchitale@ventanamicro.com>, Greentime Hu <greentime.hu@sifive.com>, wchen
 <waylingii@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, Heiko
 Stuebner <heiko@sntech.de>, Minda Chen <minda.chen@starfivetech.com>, Samuel
 Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>, Sean
 Christopherson <seanjc@google.com>, Peter Xu <peterx@redhat.com>, Like Xu
 <likexu@tencent.com>, Vipin Sharma <vipinsh@google.com>, Maciej
 Wieczor-Retman <maciej.wieczor-retman@intel.com>, Aaron Lewis
 <aaronlewis@google.com>, Thomas Huth <thuth@redhat.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v4 11/11] KVM: selftests: Enable tunning of err_margin_us
 in arch timer test
In-Reply-To: <CAJve8onc0WN5g98aOVBmJx15wFBAqfBKJ+ufoLY+oqYyVL+=3A@mail.gmail.com>
References: <cover.1702371136.git.haibo1.xu@intel.com>
 <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
 <8734vy832j.wl-maz@kernel.org>
 <CAJve8onc0WN5g98aOVBmJx15wFBAqfBKJ+ufoLY+oqYyVL+=3A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <f98879dc24f948f7a8a7b5374a32bc04@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, pbonzini@redhat.com, shuah@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, anup@brainfault.org, atishp@atishpatra.org, guoren@kernel.org, mchitale@ventanamicro.com, greentime.hu@sifive.com, waylingii@gmail.com, conor.dooley@microchip.com, heiko@sntech.de, minda.chen@starfivetech.com, samuel@sholland.org, jszhang@kernel.org, seanjc@google.com, peterx@redhat.com, likexu@tencent.com, vipinsh@google.com, maciej.wieczor-retman@intel.com, aaronlewis@google.com, thuth@redhat.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2023-12-20 06:50, Haibo Xu wrote:
> On Wed, Dec 20, 2023 at 2:22 AM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On Tue, 12 Dec 2023 09:31:20 +0000,
>> Haibo Xu <haibo1.xu@intel.com> wrote:
>> > > @@ -216,6 +221,9 @@ static bool parse_args(int argc, char *argv[])
>> >               case 'm':
>> >                       test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
>> >                       break;
>> > +             case 'e':
>> > +                     test_args.timer_err_margin_us = atoi_non_negative("Error Margin", optarg);
>> > +                     break;
>> 
>> So your error margin is always unsigned...
>> 
> 
> The error margin was supposed to be a non-negative [0, INT_MAX].
> (May be need to define a Max for the input, instead of INT_MAX)
> 
>> >               case 'o':
>> >                       test_args.counter_offset = strtol(optarg, NULL, 0);
>> >                       test_args.reserved = 0;
>> > diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
>> > index 968257b893a7..b1d405e7157d 100644
>> > --- a/tools/testing/selftests/kvm/include/timer_test.h
>> > +++ b/tools/testing/selftests/kvm/include/timer_test.h
>> > @@ -22,6 +22,7 @@ struct test_args {
>> >       int nr_iter;
>> >       int timer_period_ms;
>> >       int migration_freq_ms;
>> > +     int timer_err_margin_us;
>> 
>> ... except that you are storing it as a signed value. Some consistency
>> wouldn't hurt, really, and would avoid issues when passing large
>> values.
>> 
> 
> Yes, it's more proper to use an unsigned int for the non-negative error 
> margin.
> Storing as signed here is just to keep the type consistent with that
> of timer_period_ms
> since there will be '+' operation in other places.
> 
>         tools/testing/selftests/kvm/aarch64/arch_timer.c
>         /* Setup a timeout for the interrupt to arrive */
>          udelay(msecs_to_usecs(test_args.timer_period_ms) +
>              test_args.timer_err_margin_us);

But that's exactly why using a signed quantity is wrong.
What does it mean to have a huge *negative* margin?

I don't see how you can justify this.

         M.
-- 
Jazz is not dead. It just smells funny...

