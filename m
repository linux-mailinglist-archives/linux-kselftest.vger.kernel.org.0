Return-Path: <linux-kselftest+bounces-29831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E54A71F24
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 20:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9515C3A1DD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E92561C4;
	Wed, 26 Mar 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U78CtHDd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC9253F38
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017234; cv=none; b=itSd4elv5lS8mbGOtR0Xbl5twIfUCSZJHcZ/Z5YiU/q7dbdh2ubpId05hx5GSRw2Qe6cjzTNnaP1yoJJEeXzFfSvATtyoRjllcrtgmpiRmzmDl2qy86H9mLEKBAjhwgv7IhgsHT6tRa8sRVsY3hATR/E0DjQzBY2p5+WWI9nLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017234; c=relaxed/simple;
	bh=+U1O+GCFM+kfSFm0eIkLWeuXl8Ro1RJubQKh9PZzrw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJyCGtWnvepXGiPDKESH+AaKGCx2cN9ZBEU0z/VbwMOL/5eJjuikj6AQwLP7sL/LWxYA495KKFBqsHptJDno+PLttzu/clQ8zm14fQbC6m3AFWUY2jS3g99oRp1O3s/6fq/9RxOfBgaTBQcgif6bki1PtYdpScl2SWgxDH8PcMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U78CtHDd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff69646218so376828a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743017231; x=1743622031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IohNF223XL3lH0XqoriWRvDMNHxugR0378pliy8M2k8=;
        b=U78CtHDdwIdCTpa2wHy/8e4yaF4RxhQhQb7qa7IBsJhwt+QqBhXDMZ/l77HOHFGwJM
         WVwURBQ0UD9LR4a82f7/kJcagYlIOrTsEgvrTHGumTMk/KPD56FVJAkUpu/NRaHNn+GX
         qH3q+2yCBX5bkQj1NhmJ80Pox2MiKyEyWC1LdQE3jjnAEwOUmzusDRq8rfVRANgAUPPb
         zfaZi2rL4EvelavbDTSqcDnt4CA6natUdMKVkQUxOJOmtdUpZns+5Gr40G631VnXwRXB
         ttpA4bRNOVM98raGI32DvBIGEAWxcTEmF70v8mdE0P0pBzrajFl4EbRTMbUCuglCKWWN
         AvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017231; x=1743622031;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IohNF223XL3lH0XqoriWRvDMNHxugR0378pliy8M2k8=;
        b=pzleCwobw+AXGYin/xlx8+S54Elz1pY8M4uSjcNiuFy4jRDVYXgj3o/e/Djvk6drmv
         AXFu3SgDSdVnAcv1XdWLDodMSWO7TXJ+S47GHTgq1/FOvUcfEJlk5f6Q6pGk65FLsWuk
         ARBSdSpg+eBmoSHsMNoW8i8bl912HTjpJrNjkBt9Ty1gx4j0tr+h6KyH/sp8y1y7M76Q
         /pMsmr1IFUv9+RI1v0oqVL07G9cN+rfeShM2IepGqxuSHDbTwzl5y/wpFzRh6V+YbN0e
         vGV1TcJQmN1LWIXOG0UH2zPlpj0pUNHqh4IxS2X8ug6+KBlVo1oJh7bDIFBUWymHPQUE
         xEvA==
X-Forwarded-Encrypted: i=1; AJvYcCUepWFc6pddgSq5EDmEX2XnkNyvXG9iV+6ojCNT+D8bEuugu6/Whg2dHyo+UZZ67Ki+EeyKtveiSdBTW3QySiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUGHlQuszsQ5CWzxidUnBTE2J3pYLZjXXTe2IbFlaH+0SZeE+
	zPkrambkBIpP5vynEIuxaSiGlDyZherf0OUdmafUiBd8p2M8YAcqeFcuQS2wA2e9bTtuEtY3nsg
	93w==
X-Google-Smtp-Source: AGHT+IF5Vq2DzJpQNzldBZKP+C7bbGIGWzkK3jj6QX/Dtg84AwGkvpnqQi8XzN9QF/JkIytLyWzgiVzVlO4=
X-Received: from pjl13.prod.google.com ([2002:a17:90b:2f8d:b0:2fc:2e92:6cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c85:b0:2ea:a25d:3baa
 with SMTP id 98e67ed59e1d1-303a7c5d2e8mr953814a91.5.1743017231491; Wed, 26
 Mar 2025 12:27:11 -0700 (PDT)
Date: Wed, 26 Mar 2025 12:27:09 -0700
In-Reply-To: <CADrL8HV=ERo3dB7u-24VhjVQ6muBHEXeAfZYY7cuE7cxALRRRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325015741.2478906-1-mlevitsk@redhat.com> <20250325015741.2478906-3-mlevitsk@redhat.com>
 <CADrL8HWrgbV+coEod_EUnvG27HX3WtJDMua3FPiReCRCtXaNhw@mail.gmail.com>
 <Z-RKZsQngjEgcfVU@google.com> <CADrL8HV=ERo3dB7u-24VhjVQ6muBHEXeAfZYY7cuE7cxALRRRA@mail.gmail.com>
Message-ID: <Z-RVDQC4HNxrD-pI@google.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: access_tracking_perf_test: add
 option to skip the sanity check
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kselftest@vger.kernel.org, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025, James Houghton wrote:
> On Wed, Mar 26, 2025 at 11:41=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > Then the auto resolving works as below, and as James pointed out, the a=
ssert
> > becomes
> >
> >                 TEST_ASSERT(!warn_only, ....);
>=20
> I think the auto-resolving below needs to be flipped, and the
> TEST_ASSERT should be for `warn_only`, not `!warn_only`.
>=20
> If warn_only =3D=3D 1, the assert should pass.

/facepalm, yep

> > > > +                       break;
> > > >                 case 'h':
> > > >                 default:
> > > >                         help(argv[0]);
> > > > @@ -386,6 +394,23 @@ int main(int argc, char *argv[])
> > > >         page_idle_fd =3D open("/sys/kernel/mm/page_idle/bitmap", O_=
RDWR);
> > > >         __TEST_REQUIRE(page_idle_fd >=3D 0,
> > > >                        "CONFIG_IDLE_PAGE_TRACKING is not enabled");
> > > > +       if (warn_on_too_many_idle_pages =3D=3D -1) {
> > > > +#ifdef __x86_64__
> > > > +               if (this_cpu_has(X86_FEATURE_HYPERVISOR)) {
> > > > +                       printf("Skipping idle page count sanity che=
ck, because the test is run nested\n");
> > > > +                       warn_on_too_many_idle_pages =3D 0;
> > > > +               } else
> > > > +#endif
> > > > +               if (is_numa_balancing_enabled()) {
> > > > +                       printf("Skipping idle page count sanity che=
ck, because NUMA balance is enabled\n");
> > > > +                       warn_on_too_many_idle_pages =3D 0;
> > > > +               } else {
> > > > +                       warn_on_too_many_idle_pages =3D 1;
> > > > +               }
> > > > +       } else if (!warn_on_too_many_idle_pages) {
> > > > +               printf("Skipping idle page count sanity check, beca=
use this was requested by the user\n");
> >
> > Eh, I vote to omit this.  The sanity check is still there, it's just de=
graded to
> > a warn.  I'm not totally against it, just seems superfluous and potenti=
ally confusing.
>=20
> I agree, it's not adding much.
>=20
> Separately: I've finished the MGLRU version of this test. It uses
> MGLRU if it is available, and marking pages as idle is much faster
> when using it. If MGLRU is enabled but otherwise not usable, the test
> fails, as the idle page bitmap is no longer usable for this test.
>=20
> I'm happy to post a new version of Maxim's patch with the MGLRU
> patches too, Maxim, if you're okay with that.

