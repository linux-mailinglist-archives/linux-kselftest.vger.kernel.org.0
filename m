Return-Path: <linux-kselftest+bounces-25653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88645A26F44
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA67164DAB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F047208989;
	Tue,  4 Feb 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7ecg8lc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82824207A1D;
	Tue,  4 Feb 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664707; cv=none; b=N7wua0cYgtpPzsdl/JzmPWUZriyKTUZSDII2UW+7sRCHNr66JX5U0To0Soy2DH7yL1uVBWparU5FGC7OWJrSuMM7Fkdl+xq2oFkvTxEEhB50vnMyOcPheh+bx/lpp0AikVUNSZwG0eLl4Av33wkkevBFeTEz2k5yWQa/t7YAPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664707; c=relaxed/simple;
	bh=eryuKIRqQtiSVHSkazE0gytJJmllCjama66g0dDkS1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tS4XHopiEl5QKYmDUoaQB2Raj0785mA38QPzSn8Os/pNK8714Sm34akNaWV9o858wzRb1Fr+gtQIHoUvGGSnZzoaLFTs9w6x0ZPR+IlNsNCNUqqfJhkAClXFM8/wvbOjl2UNazwrgO0+uVIXH7QlpTKd3H/j/OhuRVF7Zz60Uxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7ecg8lc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30795988ebeso51573781fa.3;
        Tue, 04 Feb 2025 02:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738664703; x=1739269503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUWwvV/2Marls8zbp1dn+2aJPgKTAhu5Cjo7d/M8uUY=;
        b=K7ecg8lcqp8iJ4L/wwU5ydo0FQxWry2GeZ9bZDLvyHwsXAXu759WwWp6yIftuNcfJA
         N8FRcH6BPH+u5/smKQErSnUsVRtCOwWgwt1MpSOfDCqryzDRi+FrKI2vIhpQRj6hkIcl
         ZsQeOyA+6sBMEYAqgMpH/o7cbDJuBdujNbyhXt+jZ9NKkOFwBlCgooxCOhuMcbbitLWk
         n9llCMwbyJVDCCyVGUuC+0CSmRGfzhokUyzfE27A3ReZ6V8haBvLfzKyT8A+tJoA6Jp6
         U/RxyD4xiEnYL+H7veKsTwixzSPG1LDbJ7P17BAsmkrBajGrhgKNmM69n8KRH8t21TUE
         AyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738664703; x=1739269503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUWwvV/2Marls8zbp1dn+2aJPgKTAhu5Cjo7d/M8uUY=;
        b=HUmrGGyjIvC+nI70K9wlhQaZDuKFru6vvVMe3RV7Auzc0p8G8oZX9UY12A6ILnk96u
         8gy8oSXnhvO7AOoBTgbChekYivfkOaw1Xd6xV/IGIU61XCPvCaPnQNajZ8m/IKb/L+Fu
         Qd0KdauipcdEy1f+j3zpJSgd1Ay0Epnds/p371UeVLaaL90tvyNt9c4gJNK55c28B1Um
         qa4DTHwKsXW4bUWOTTJhMUfQcU18XY266F/FLrrhKFTZ1ErOROkX9MX+0dvIE66jxhvk
         JueAy5qMjgdrTVzZtg9+Fm2oMrTCqAV8kW02l78mSBOv2t8EfcLxyAwnzFnvmmS6ihnE
         qSjg==
X-Forwarded-Encrypted: i=1; AJvYcCU6bpYQBm4QsZAJRh9qGAyUBFceuIjNgQVE8HCjBJo56YbAsSVoAyFQfeak0+uN71xbCT6Zk079dkh+hyY=@vger.kernel.org, AJvYcCWlJwWMb132hTl+7GJty0KFAicVlPRiHiskhL6qjDv7UyAWnwKRCxjktac0rL85+QuWerglUWGkqyrXAi4s9/sw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnqw0Kb17vRpd9eec/qHcvSnQRhunb6zOaRPh1rwF7TqImt7Dn
	xvtHA2fMN3cu88IIxSX7yU2uO5f3k3Ony7uY+5U2wkKe+/rU0DLyYdgANXgLP2gUVuu+XP1D7Y0
	7uWCVqWgbnBExUiA1Blpod0yZL/0=
X-Gm-Gg: ASbGnctKmKgZhDXnvwKy/VhE+Sk8FvqwG1lci+VLNdo0vOJHkvtkln0YvRdpbPFfL3j
	R80BxgKDzPEFrJvzYlqb2VzQATH6wlfLwWR+fvMpg7bTg4yiZgYA+ZGsjlzxukmEO79JUwXgnQX
	Wk2HcoT+C75SJv/P6sPFuo9iWaxnR4sEo=
X-Google-Smtp-Source: AGHT+IHnxZygRH1/mqKfetKXbq96AD4BKTj6koI06qUQXIaatO/4caanaFo/sj862Fy42peOUZSzMPxlkixC8ZWEd5w=
X-Received: by 2002:a2e:bea3:0:b0:2fb:cc0:2a05 with SMTP id
 38308e7fff4ca-307969840a5mr77755361fa.37.1738664703163; Tue, 04 Feb 2025
 02:25:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-scanf-kunit-convert-v2-1-277a618d804e@gmail.com> <Z6HSFvvgxFVGDQeI@pathway.suse.cz>
In-Reply-To: <Z6HSFvvgxFVGDQeI@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 4 Feb 2025 05:24:27 -0500
X-Gm-Features: AWEUYZnzEOKsYjf0hICzTylugNYEjzZkQzE7ZiA0EfMqoXNLdPAarAahIOJ-nzY
Message-ID: <CAJ-ks9k0uahYnGMij-j13BEq0KtWMV5n_wxyWrj9RnErHeMpnQ@mail.gmail.com>
Subject: Re: [PATCH v2] scanf: convert self-test to KUnit
To: Petr Mladek <pmladek@suse.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 3:39=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Mon 2025-02-03 06:48:05, Tamir Duberstein wrote:

[...]

> > diff --git a/lib/Makefile b/lib/Makefile
> > index d5cfc7afbbb8..a53cf6dd1505 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -85,7 +85,6 @@ obj-$(CONFIG_TEST_STATIC_KEYS) +=3D test_static_keys.=
o
> >  obj-$(CONFIG_TEST_STATIC_KEYS) +=3D test_static_key_base.o
> >  obj-$(CONFIG_TEST_DYNAMIC_DEBUG) +=3D test_dynamic_debug.o
> >  obj-$(CONFIG_TEST_PRINTF) +=3D test_printf.o
> > -obj-$(CONFIG_TEST_SCANF) +=3D test_scanf.o
> >
> >  obj-$(CONFIG_TEST_BITMAP) +=3D test_bitmap.o
> >  ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
> > @@ -373,8 +372,9 @@ CFLAGS_bitfield_kunit.o :=3D $(DISABLE_STRUCTLEAK_P=
LUGIN)
> >  obj-$(CONFIG_BITFIELD_KUNIT) +=3D bitfield_kunit.o
> >  obj-$(CONFIG_CHECKSUM_KUNIT) +=3D checksum_kunit.o
> >  obj-$(CONFIG_UTIL_MACROS_KUNIT) +=3D util_macros_kunit.o
> > -obj-$(CONFIG_LIST_KUNIT_TEST) +=3D list-test.o
> >  obj-$(CONFIG_HASHTABLE_KUNIT_TEST) +=3D hashtable_test.o
> > +obj-$(CONFIG_LIST_KUNIT_TEST) +=3D list-test.o
>
> This looks like an unrelated change.

You're right. I was trying to keep this bit alphabetized but there's
no pattern here. I'll also move the scanf entry back to where it was.

> > +obj-$(CONFIG_SCANF_KUNIT_TEST) +=3D scanf_kunit.o
> >  obj-$(CONFIG_LINEAR_RANGES_TEST) +=3D test_linear_ranges.o
> >  obj-$(CONFIG_BITS_TEST) +=3D test_bits.o
> >  obj-$(CONFIG_CMDLINE_KUNIT_TEST) +=3D cmdline_kunit.o
>
> Best Regards,
> Petr

Thanks.
Tamir

