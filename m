Return-Path: <linux-kselftest+bounces-46134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 905A4C75CA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2937034B23E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0DC2FB62A;
	Thu, 20 Nov 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0/0qUQR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752F2F3C07
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660561; cv=none; b=bnzi1FIu3KJ+7Xo/VVAbJjiz66Fa8gI187Mdp2oIwZPHi/AQFzprsW0en/dSeFJmY9+tfQHu0WTPeMilTAmhOIIIdogIAYToJPitLYxF2jEy3Rti3SZtKEAtMx0qC0vvFpi/ZhzjsYwU6wvWpNJ2RXY8Al0dVo38BLeE0skBrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660561; c=relaxed/simple;
	bh=+mu4EH1hbZ7kiUj2EyeHf0i8XxDsygeKu//pdbEwJ7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpODccnk878AEr40+roANcQKSVP6YEcyS2A/xOH2L47moCCFq4vYxs0usQm0C39ZNHxn59qycBrKtmlNRY1+zl1Bzqq5j5JogGvHUfS5evIxloYH5ur4cFxxfPogKCORMUnemJUK46gOgJstB5N+35hsOsUzHPUVsJm5Qw5kj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0/0qUQR; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55960aa131dso327558e0c.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763660558; x=1764265358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QdLCAH+kCAfdpyxSZwwmC18Jf4bNx9TJK2O4io7fI4=;
        b=E0/0qUQRDNlyIopsvylGZjp9cQ0cOh/q2vgw78arzMSoREKXAaQSYEGy4ASTJRY4gl
         bCP3hXXXOyLl2p+/KV9vtFxkypU5nfrQQf66X6SK+V7Z7G/za63rQAwntPpoK9g3eE8g
         rRuoYi3Ue6VXMR3MMy28R/LdH0Ap12M/VOJd4I3Wt2eP11fqQTfVGihG4VdH2qXxeg3K
         TMQrQG4fm6F0Nn7IX2DCE5Mm1xO0c2OkZptboAQvaXczCkCYX8CF5WKhtP0iZcQO+BCD
         fuvQbEYR0xohzHwrt/02ik0B21p7XneT2qmn+yV5qFI/Kf/0AdIyzTm8VhXFL4WF444W
         0khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763660558; x=1764265358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8QdLCAH+kCAfdpyxSZwwmC18Jf4bNx9TJK2O4io7fI4=;
        b=nI8uAw9TTtrkAHND7HdoNecIeMe31ToU9mQ9Bz1fYn4FCceClUnxVloiqrtARmJtVu
         9jFAV7cehoeUdfel/jRH41QGvdSeqYboJmpl5T+ZxogVEQQv0eawFXUZRYIDgfpkbmIN
         tOHb/px7srixxPNrF5WvkZNfebAtDwYf/QqkskQmE/Hj2DSfuNcjeeAE9o+JKdPEyuUE
         ssFuPLNRPDD4/2XXqUWTqVuawhYxBpnOgTxOlLkZKJY1sAmMxp8O7a0BMwkDZwkOrrps
         cPhDSlFo67e6Z51+jPK3JqHKYZDZwcQZWkz3W+nJtGaLkWeiFXWDMM9kPrll81LGN5MP
         dOnw==
X-Forwarded-Encrypted: i=1; AJvYcCXnXTfXewv5IMyKp6Cpbl6q6DCCyNX1yiBPlQUHSDeOAJn9iIgk5hynNchcdYqG9PvkidJC9BjSU3AN7ertReI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3BmbipBpFnbcN69GuRP1Qv3M+V7xpyoXqOtW+IY9zZJWmKZH
	2PPgq+CWOaK8lpnGu1S6mmY0goLCMzhZIMVaNYiOv05eKvh37QS+qK5gabTu1GnirdIFox8y9Gp
	UrG+YsBoG7iZ2NgwQASWySiwhYcwRXrs=
X-Gm-Gg: ASbGncvzNSWXAiPLHoCFjVZsPeVRsyNIdEtyBqwbngI0bZ6/uOftFvXl5eQEN8B7cmC
	LWmuA5rzCar7xCBM8+EKdE9OPYwYoa/BpryW+uxxmaud5/mMukX2khhv4H1h8yOk4TutUb8Anml
	1Mfr2g0n2wjC2ZLMdgD4w6VommaruhZif5qah0/qr5u5v47y3+v/kMmpAq7OfJ4bjV6BrBLW7lS
	r/jVEt2Ku7I0NxlL3Vf0eVs9K9BuaBjKycioHvq4SCGOWkVUaDIsVknTAYLkTBaa7vWZh5j
X-Google-Smtp-Source: AGHT+IE5Hdgn7lpFW/BYm5FgIJ7g8krR9dNw6nTJik/5sfDEsCLktm4cUX/acXQbvJutTyM0DLHyRarLCbyrLyl873s=
X-Received: by 2002:a05:6122:3c43:b0:556:e951:b544 with SMTP id
 71dfb90a1353d-55b7f0dc0a0mr1620163e0c.9.1763660557928; Thu, 20 Nov 2025
 09:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117014721.3142490-1-alex.t.tran@gmail.com> <awbmhna3hkra2eoc7lcl23d3mzfsk7qty5t4zl3m7s6hau3v4u@uzqkqudwttlp>
In-Reply-To: <awbmhna3hkra2eoc7lcl23d3mzfsk7qty5t4zl3m7s6hau3v4u@uzqkqudwttlp>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Thu, 20 Nov 2025 09:42:26 -0800
X-Gm-Features: AWmQ_blDi8ctcvusjc3FMZK8SNONs1eXiZlA9dmRVRNszGSaGXn-9CKKan_IU5w
Message-ID: <CA+hkOd6b9LhN4jRFjDiQQ3DxdBLD2xRrrGXnhO-YsTO1cEGJyQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftests: hid: tests: test_wacom_generic: add base
 test for display devices and opaque devices
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, shuah@kernel.org, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:53=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> Hi Alex,
>
> On Nov 16 2025, Alex Tran wrote:
> > Verify Wacom devices set INPUT_PROP_DIRECT appropriately on display dev=
ices
> > and INPUT_PROP_POINTER appropriately on opaque devices. Tests are defin=
ed
> > in the base class and disabled for inapplicable device types.
> >
> > Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> > ---
> >  .../selftests/hid/tests/test_wacom_generic.py       | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/=
tools/testing/selftests/hid/tests/test_wacom_generic.py
> > index 2d6d04f0f..aa2a175f2 100644
> > --- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
> > +++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
> > @@ -600,15 +600,17 @@ class BaseTest:
> >
> >          def test_prop_direct(self):
> >              """
> > -            Todo: Verify that INPUT_PROP_DIRECT is set on display devi=
ces.
> > +            Verify that INPUT_PROP_DIRECT is set on display devices.
> >              """
> > -            pass
> > +            evdev =3D self.uhdev.get_evdev()
> > +            assert libevdev.INPUT_PROP_DIRECT in evdev.properties
> >
> >          def test_prop_pointer(self):
> >              """
> > -            Todo: Verify that INPUT_PROP_POINTER is set on opaque devi=
ces.
> > +            Verify that INPUT_PROP_POINTER is set on opaque devices.
> >              """
> > -            pass
> > +            evdev =3D self.uhdev.get_evdev()
> > +            assert libevdev.INPUT_PROP_POINTER in evdev.properties
> >
> >
> >  class PenTabletTest(BaseTest.TestTablet):
> > @@ -622,6 +624,8 @@ class TouchTabletTest(BaseTest.TestTablet):
> >
> >
> >  class TestOpaqueTablet(PenTabletTest):
> > +    test_prop_direct =3D None
>
> That seems very awkward to do.
>
> Why not drop the 2 tests from the TestTablet class, move
> `test_prop_direct()` in that subclass (TestOpaqueTablet), and add a new
> TestDirectTablet class that TestDTH2452Tablet will be a subclass of?
>
> Basically try to make better use of subclassing instead of adding the
> tests at the top level class and selectively remove them in the
> subclasses.
>
> Cheers,
> Benjamin
>
> > +
> >      def create_device(self):
> >          return OpaqueTablet()
> >
> > @@ -864,6 +868,7 @@ class TestPTHX60_Pen(TestOpaqueCTLTablet):
> >
> >  class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, Touch=
TabletTest):
> >      ContactIds =3D namedtuple("ContactIds", "contact_id, tracking_id, =
slot_num")
> > +    test_prop_pointer =3D None
> >
> >      def create_device(self):
> >          return test_multitouch.Digitizer(
> > --
> > 2.51.0
> >

Thanks for the review. Yes, it seems like a good idea to restructure
the class hierarchy instead of disabling the
tests like this. I'll send in a v2 with the changes soon.

Regards,
--=20
Alex Tran

