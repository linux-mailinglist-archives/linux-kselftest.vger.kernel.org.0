Return-Path: <linux-kselftest+bounces-29828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA4A71ED3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 20:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CA91890976
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D2253B43;
	Wed, 26 Mar 2025 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isPKEazh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F576250C12
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016167; cv=none; b=hkwF3GKwdbQC6qHt4rlFGvGcqVSkHPLb4JtJCt1cuAtaBuDvkiaESZkbUshP1NBecg4T6CBVqljkV7dumlvQfDvRj6hBs6L4Zdepr+vb8r3alG+4IwrDg0j6NAR4SvgcMt/p0zR2ZYqklunH39oR5HzinksS9xTYPH8Po3Vhv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016167; c=relaxed/simple;
	bh=SnxqBHAaltx681NZ6h4C7XLUHuRErqtlcGYrugl0ZpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBrQLNyhXeNUGNa9KnyAj2xQU340ouDYPWVO4KJ+jrozIuXb2cXr6/SJ9TBdQRSox6NQsXAXVQg4b2jMx6s6YmDgMpyPsGGC/iilmo4EUH5gruHgWrDqAAxFVYF+QjzDBWNQmndZoUAtqC36Uzbtj9eGowzvnok7OIHzTxyyqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isPKEazh; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e60b75f87aaso180365276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743016164; x=1743620964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8MnphgMdhV2hzqeZDJ8boc8PiycAb0YUE6JIcjZLIU=;
        b=isPKEazhhKoxTLgIMOojOR3HLVqf9zOtkdSAaCeXsOteWpV2JgFZVZGJH/iKm1sjPv
         hTw48vV9j7HCiZlR+3BCTenYffO0paXQX1+EiA1rzPZRPLF7CNXmMIipHxVst90H5ACC
         oEZ0ZvJ48sgl+HjD6g79LL32QapA3V5x/CXacf30Rl+1lBNkP8UGOipx2pS1jK5K6ppQ
         JWMgnYKqgESL+OzN29s6jijM7GTYTXDiPfHppM6i+1wTMVYWnRgvlFl0gCsGZvHWbv/e
         vesNuauoRJuXnbp1aetXmgOaKal7dUs9ngxEFPcczLexpxcVYzBr+DWE/DMoIfiIu9HR
         g2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743016164; x=1743620964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8MnphgMdhV2hzqeZDJ8boc8PiycAb0YUE6JIcjZLIU=;
        b=VHfRFapg7PPV6/lektmzbRvbdIStwcczNkdV8GPWrbVdqwSS/L+wQA8t3Ize0fpSzz
         ykOVuwGDzynucY1TgkEaiBK0E8qVawBJ4JmxAGxSlNX7b3ZSMs4T6woN1E5qhmOrgmNk
         KdEzxAZU+yDZWKPoaCGlGxmlfuJs2nja20YdQrEJpw+Dox1Cf1iA6ZACoHfhkCjXklPZ
         ELmE6rlwVM37Aun8WSqL6EYqekOwhGUOgfhVOfjsu0UZnLes42LAPr0Uq9xOKjz7ltDR
         gYrRMg8/OhXHz9VgK+ZAa7Hz7QOnrPuB3VO/7pC1cXiFIIP8P4oskLBrojrpIidnz6Mm
         dPGg==
X-Forwarded-Encrypted: i=1; AJvYcCU/l1cTwkER2Tk1fjRiOV3KXk3Cm2VjpHb3Vj/hYnQnWKiDXoIZ/WKMEN7EUiU8yyoGFk1zlws3iHGt7/ztmZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4mzpP0YMnrznCS4oKYP0ygskkLNk9o9iGZcxnkk4fCYAeRQT
	G/EwAAN7zvK2sbw+BB1PeniqJypDUKCnoO8KSW5FzTdImrhelZV6m2J6XcnUZnYo5F4fvyds8pR
	w42shF5qn+QAYsepWancvKVf6NRA3n+n+x529
X-Gm-Gg: ASbGncuMHX1UHqaT/U8jJ6Ya5dC42RfB4FYzgTpvL+BL4WSlhRZxzM3TS7hA6zI/5pW
	UOuluDjc/5zrrzAo+lOxORrLYMLX50a8gN7X7v5PQ3IiRFh0GE9IfwQHwhvH4zI9IUNWpSuZ/hQ
	ffZiLMUxxjRpP1IDO8Rknnut8tJ1VuuUyF7ZYx+E1NVhWz0HxATud4Z/g=
X-Google-Smtp-Source: AGHT+IGMj/MnYE+d7H2+zYVj3Bj0Tce8hkBUUFJhdk3M26qxeAz0lDP7fu7jhLIoEdjL+mhczTy8wN8UEXxeZS0sQ9Y=
X-Received: by 2002:a05:6902:e09:b0:e61:1c18:3f36 with SMTP id
 3f1490d57ef6-e69437b140emr1046333276.44.1743016163664; Wed, 26 Mar 2025
 12:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325015741.2478906-1-mlevitsk@redhat.com> <20250325015741.2478906-3-mlevitsk@redhat.com>
 <CADrL8HWrgbV+coEod_EUnvG27HX3WtJDMua3FPiReCRCtXaNhw@mail.gmail.com> <Z-RKZsQngjEgcfVU@google.com>
In-Reply-To: <Z-RKZsQngjEgcfVU@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 26 Mar 2025 12:08:47 -0700
X-Gm-Features: AQ5f1Jok2UyoVjwN5Xfj4AvvUukl9Vy59LiBy7m0vyaov2dDIAzXM7qt0VVIOd8
Message-ID: <CADrL8HV=ERo3dB7u-24VhjVQ6muBHEXeAfZYY7cuE7cxALRRRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: access_tracking_perf_test: add
 option to skip the sanity check
To: Sean Christopherson <seanjc@google.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kselftest@vger.kernel.org, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 11:41=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Tue, Mar 25, 2025, James Houghton wrote:
> > On Mon, Mar 24, 2025 at 6:57=E2=80=AFPM Maxim Levitsky <mlevitsk@redhat=
.com> wrote:
> > >
> > > Add an option to skip sanity check of number of still idle pages,
> > > and set it by default to skip, in case hypervisor or NUMA balancing
> > > is detected.
> > >
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> >
> > Thanks Maxim! I'm still working on a respin of this test with MGLRU
> > integration, like [1]. Sorry it's taking me so long. I'll apply my
> > changes on top of yours.
> >
> > [1]: https://lore.kernel.org/kvm/20241105184333.2305744-12-jthoughton@g=
oogle.com/
> >
> > > ---
> > >  .../selftests/kvm/access_tracking_perf_test.c | 33 ++++++++++++++++-=
--
> > >  .../testing/selftests/kvm/include/test_util.h |  1 +
> > >  tools/testing/selftests/kvm/lib/test_util.c   |  7 ++++
> > >  3 files changed, 37 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c =
b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> > > index 3c7defd34f56..6d50c829f00c 100644
> > > --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> > > +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> > > @@ -65,6 +65,8 @@ static int vcpu_last_completed_iteration[KVM_MAX_VC=
PUS];
> > >  /* Whether to overlap the regions of memory vCPUs access. */
> > >  static bool overlap_memory_access;
> > >
> > > +static int warn_on_too_many_idle_pages =3D -1;
> > > +
> > >  struct test_params {
> > >         /* The backing source for the region of memory. */
> > >         enum vm_mem_backing_src_type backing_src;
> > > @@ -184,11 +186,10 @@ static void mark_vcpu_memory_idle(struct kvm_vm=
 *vm,
> > >          * are cached and the guest won't see the "idle" bit cleared.
> > >          */
> > >         if (still_idle >=3D pages / 10) {
> > > -#ifdef __x86_64__
> > > -               TEST_ASSERT(this_cpu_has(X86_FEATURE_HYPERVISOR),
> > > +               TEST_ASSERT(warn_on_too_many_idle_pages,
> >
> > I think this assertion is flipped (or how warn_on_too_many_idle_pages
> > is being set is flipped, see below).
> >
> > >                             "vCPU%d: Too many pages still idle (%lu o=
ut of %lu)",
> > >                             vcpu_idx, still_idle, pages);
> > > -#endif
> > > +
> > >                 printf("WARNING: vCPU%d: Too many pages still idle (%=
lu out of %lu), "
> > >                        "this will affect performance results.\n",
> > >                        vcpu_idx, still_idle, pages);
> > > @@ -342,6 +343,8 @@ static void help(char *name)
> > >         printf(" -v: specify the number of vCPUs to run.\n");
> > >         printf(" -o: Overlap guest memory accesses instead of partiti=
oning\n"
> > >                "     them into a separate region of memory for each v=
CPU.\n");
> > > +       printf(" -w: Skip or force enable the check that after dirtyi=
ng the guest memory, most (90%%) of \n"
> > > +              "it is reported as dirty again (0/1)");
> > >         backing_src_help("-s");
> > >         puts("");
> > >         exit(0);
> > > @@ -359,7 +362,7 @@ int main(int argc, char *argv[])
> > >
> > >         guest_modes_append_default();
> > >
> > > -       while ((opt =3D getopt(argc, argv, "hm:b:v:os:")) !=3D -1) {
> > > +       while ((opt =3D getopt(argc, argv, "hm:b:v:os:w:")) !=3D -1) =
{
> > >                 switch (opt) {
> > >                 case 'm':
> > >                         guest_modes_cmdline(optarg);
> > > @@ -376,6 +379,11 @@ int main(int argc, char *argv[])
> > >                 case 's':
> > >                         params.backing_src =3D parse_backing_src_type=
(optarg);
> > >                         break;
> > > +               case 'w':
> > > +                       warn_on_too_many_idle_pages =3D
> > > +                               atoi_non_negative("1 - enable warning=
, 0 - disable",
> > > +                                                 optarg);
> >
> > We still get a "warning" either way, right? Maybe this should be
> > called "fail_on_too_many_idle_pages" (in which case the above
> > assertion is indeed flipped). Or "warn_on_too_many_idle_pages" should
> > mean *only* warn, i.e., *don't* fail, in which case, below we need to
> > flip how we set it below.
>
>
> Agreed.  I like the "warn" terminology,  Maybe this?
>
>         printf(" -w: Control whether the test warns or fails if more than=
 10%\n"
>                "     of pages are still seen as idle/old after accessing =
guest\n"
>                "     memory.  >0 =3D=3D warn only, 0 =3D=3D fail, <0 =3D=
=3D auto.  For auto\n"
>                "     mode, the test fails by default, but switches to war=
n only\n"
>                "     if NUMA balancing is enabled or the test detects it'=
s running\n"
>                "     in a VM.");

LGTM.

>
> And let the user explicitly select auto:
>
>                 case 'w':
>                         warn_only =3D atoi_paranoid(optarg);
>                         break;
>
> Then the auto resolving works as below, and as James pointed out, the ass=
ert
> becomes
>
>                 TEST_ASSERT(!warn_only, ....);

I think the auto-resolving below needs to be flipped, and the
TEST_ASSERT should be for `warn_only`, not `!warn_only`.

If warn_only =3D=3D 1, the assert should pass.

>
> >
> > > +                       break;
> > >                 case 'h':
> > >                 default:
> > >                         help(argv[0]);
> > > @@ -386,6 +394,23 @@ int main(int argc, char *argv[])
> > >         page_idle_fd =3D open("/sys/kernel/mm/page_idle/bitmap", O_RD=
WR);
> > >         __TEST_REQUIRE(page_idle_fd >=3D 0,
> > >                        "CONFIG_IDLE_PAGE_TRACKING is not enabled");
> > > +       if (warn_on_too_many_idle_pages =3D=3D -1) {
> > > +#ifdef __x86_64__
> > > +               if (this_cpu_has(X86_FEATURE_HYPERVISOR)) {
> > > +                       printf("Skipping idle page count sanity check=
, because the test is run nested\n");
> > > +                       warn_on_too_many_idle_pages =3D 0;
> > > +               } else
> > > +#endif
> > > +               if (is_numa_balancing_enabled()) {
> > > +                       printf("Skipping idle page count sanity check=
, because NUMA balance is enabled\n");
> > > +                       warn_on_too_many_idle_pages =3D 0;
> > > +               } else {
> > > +                       warn_on_too_many_idle_pages =3D 1;
> > > +               }
> > > +       } else if (!warn_on_too_many_idle_pages) {
> > > +               printf("Skipping idle page count sanity check, becaus=
e this was requested by the user\n");
>
> Eh, I vote to omit this.  The sanity check is still there, it's just degr=
aded to
> a warn.  I'm not totally against it, just seems superfluous and potential=
ly confusing.

I agree, it's not adding much.

Separately: I've finished the MGLRU version of this test. It uses
MGLRU if it is available, and marking pages as idle is much faster
when using it. If MGLRU is enabled but otherwise not usable, the test
fails, as the idle page bitmap is no longer usable for this test.

I'm happy to post a new version of Maxim's patch with the MGLRU
patches too, Maxim, if you're okay with that.

