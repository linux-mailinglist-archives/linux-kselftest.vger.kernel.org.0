Return-Path: <linux-kselftest+bounces-38066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEC7B15451
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 22:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111D116B3F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340EB2528FC;
	Tue, 29 Jul 2025 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCWPFKpS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F952235BEE
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753820797; cv=none; b=G0o0yNhc/3vV43xTfhrjUFinBmfqnJQTTSL9yZqBN+nm6gAT85Zy5Jy/LUyTH9NPIvmzXCtIT5zq3TBn4CbOWb37bKRgYXCRHzM5sn4XYNTgEql0W3dq0MxQ4Ut4ULgy20J8f1EAoAEf/cWgwATR4S2zD/cVtA7oaKz6Hnbtugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753820797; c=relaxed/simple;
	bh=9lBVZl3WYk2iwpWOmsQMO49FUsSJGgxVIyk7MdG8Wew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHhky45g/kYkAUWs0XRJu+fG6iwn8GPM0Y5zyigYiCqRoC8bUlflsHX1yW7uUVZcRk61IoKwooaGqVfGM3CZ4gd19cFCw5EzzOMymrnucPaF97z7qgoXKd45DA+/KTe74WIpfBjw9FI93+aBONq3kfb8WvvkY059CAKPQWtsFp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCWPFKpS; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7075bcdbb0fso6313706d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753820794; x=1754425594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUba6K8jqFTo7PyTbrkud2zkkQZs/3cD7l8HjP/HFnw=;
        b=qCWPFKpScbJBMilFstQtP+1OYL0LxpxQvO9TBnyxO4+QtR4JwgLPv3WsThcXXXgi61
         kkspiCAUdQRVdxofnG6QcIuzVHWRKynfi58LqcTrPk/2SIFBc9SYVgPibvZT3EfhS8Fu
         wHVgWmWnQcTTDkSzTpfzYiAodbdMZBRzfZXDFBCGB39NBHr4qrrBiTTPK2JFIPiO+Ozz
         aDqtcJ0DXWyss1HyPMf50/6LMRr8jLxgge31XKT7YuFZnRrE0sZ0x+JuNa5VWb0Fg1Fe
         NImtfraHbqFwJGGZAVl/90GjhbmeAzR1vM4UZJarYEpPOIcCsGr+kZdfrvW9NRY9ecUV
         nRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753820794; x=1754425594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUba6K8jqFTo7PyTbrkud2zkkQZs/3cD7l8HjP/HFnw=;
        b=NZu2FlHYH85guBZiBfyF9n/yr5sMo75gqFxIvVNFe4nPtpM2mTWtnvJSFS5yTHdOi0
         PvSe6hRnBuPAlxfzrgJ5qjiY+sr7PBLm38O1nT2yyUj8wyHnuPailJOyyRB1wh8CKCwn
         IEcx2nASTs3vGAJIw9saw/R9XYCJPCX+f3VHawDZi3MuwP+f0X7CG8jONaIJEV1Atpdx
         Weewj9Zl7CBvrnz7NbTtATMmHaGCCzD6l3wPVaKmP6pVTm7Ok4Xo21libV5RqXGP/58a
         LUInzF3q8trFnUoROakIyCW6NgKmRv6XdargCZLFlJosTipFrAo+yyQn100B1Xn124hl
         rDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIoWz0QGXXyAdaw8cV6SD+D+Za4KdcpVcnJxE78fHVcoejsrXAyrBrbzBwD5s9hirvAtk+QLyBWBnDjfmqRsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLM9ussRmuonzjkg3lAzqk87VfMHFYip5O7dEOqSSFZ/k46CiG
	Y0wLwS0yJodTPo5RcMaBbbUctI/+Jgm8OlsMbEXFaQiocNU8wgC9rze5LVW24UtkDYAvek6PAYA
	fRG2HCrjae73UWgWSptqA2urFR6hFpb3sgZaztLNH
X-Gm-Gg: ASbGncuviWKy8hq0Nhso4iQb+9loCtLl/PluhoAzy2DpOkLbjx24c7tej7kkAWpDEx6
	zbHeVfh8fCWTpwzVGqsA6k55mw1IK6tlHOODNgztnAtYX13p6QQt0DwYXA4vEsGTlX1up8nl7sD
	cSGsVyqTtmrxDnDBxdtLo5wi4GCaGbvhM24pRKPDKeaUF+LQYT2uhh2/F15i8LTuneQYdyBu6zG
	mfm011eVBb2RyM/0MOmkMFoIctRr456KGsjHAnPHIaCXXSO
X-Google-Smtp-Source: AGHT+IHoSfElkKizKaXlQQgKR9Fdix12qjTHreY1H8nuY0EMlwcbbT54Mr8lFpVSBewenvXBiMSWypGRxD5hgW6FI5k=
X-Received: by 2002:ad4:5c8d:0:b0:702:d655:f4e9 with SMTP id
 6a1803df08f44-70766e3f302mr12378566d6.18.1753820793697; Tue, 29 Jul 2025
 13:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-7-marievic@google.com>
 <CA+GJov7gQMughx7wR5J_BGqo7FaPhEPF-OHaCg3OuuL17X5vpA@mail.gmail.com>
In-Reply-To: <CA+GJov7gQMughx7wR5J_BGqo7FaPhEPF-OHaCg3OuuL17X5vpA@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 29 Jul 2025 16:26:22 -0400
X-Gm-Features: Ac12FXwMXtoJETJwjrpeWEppK8R5hxomMaIXf4G-i3r5Ati6QR7pZQsQ7V97C04
Message-ID: <CA+GJov4SneU9XeKLiACAcO-q5EVe=jo-AfYH4cs87o92MpQ00g@mail.gmail.com>
Subject: Re: [PATCH 6/9] kunit: Enable direct registration of parameter arrays
 to a KUnit test
To: Marie Zhussupova <marievic@google.com>
Cc: davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 4:14=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
>
> On Tue, Jul 29, 2025 at 3:37=E2=80=AFPM Marie Zhussupova <marievic@google=
.com> wrote:
> >
> > KUnit parameterized tests currently support two
> > primary methods for getting parameters:
> > 1.  Defining custom logic within a `generate_params`
> >     function.
> > 2.  Using the KUNIT_ARRAY_PARAM and KUNIT_ARRAY_PARAM_DESC
> >     macros with pre-defined static arrays.
> >
> > These methods present limitations when dealing with
> > dynamically generated parameter arrays, or in scenarios
> > where populating parameters sequentially via
> > `generate_params` is inefficient or overly complex.
> >
> > This patch addresses these limitations by adding a new
> > `params_data` field to `struct kunit`, of the type
> > `kunit_params`. The struct `kunit_params` is designed to
> > store the parameter array itself, along with essential metadata
> > including the parameter count, parameter size, and a
> > `get_description` function for providing custom descriptions
> > for individual parameters.
> >
> > The `params_data` field can be populated by calling the new
> > `kunit_register_params_array` macro from within a
> > `param_init` function. By attaching the parameter array
> > directly to the parent kunit test instance, these parameters
> > can be iterated over in kunit_run_tests() behind the scenes.
> >
> > This modification provides greater flexibility to the
> > KUnit framework, allowing testers to easily register and
> > utilize both dynamic and static parameter arrays.
> >
> > Signed-off-by: Marie Zhussupova <marievic@google.com>
> > ---
> >  include/kunit/test.h | 54 ++++++++++++++++++++++++++++++++++++++++----
> >  lib/kunit/test.c     | 26 ++++++++++++++++++++-
> >  2 files changed, 75 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 4ba65dc35710..9143f0e22323 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -245,7 +245,8 @@ static inline char *kunit_status_to_ok_not_ok(enum =
kunit_status status)
> >   */
> >  #define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit) =
         \
> >                 { .run_case =3D test_name, .name =3D #test_name,       =
             \
> > -                 .generate_params =3D gen_params,                     =
           \
> > +                 .generate_params =3D (gen_params)                    =
           \
> > +                  ?: kunit_get_next_param_and_desc,                   =
         \
> >                   .param_init =3D init, .param_exit =3D exit,          =
             \
> >                   .module_name =3D KBUILD_MODNAME}
> >
> > @@ -294,6 +295,21 @@ struct kunit_suite_set {
> >         struct kunit_suite * const *end;
> >  };
> >
> > +/* Stores the pointer to the parameter array and its metadata. */
> > +struct kunit_params {
> > +       /*
> > +        * Reference to the parameter array for the parameterized tests=
. This
> > +        * is NULL if a parameter array wasn't directly passed to the
> > +        * parent kunit struct via the kunit_register_params_array macr=
o.
> > +        */
> > +       const void *params;
> > +       /* Reference to a function that gets the description of a param=
eter. */
> > +       void (*get_description)(const void *param, char *desc);
> > +
> > +       int num_params;
> > +       size_t elem_size;
> > +};
> > +
> >  /**
> >   * struct kunit - represents a running instance of a test.
> >   *
> > @@ -302,12 +318,14 @@ struct kunit_suite_set {
> >   * @parent: for user to store data that they want to shared across
> >   *         parameterized tests. Typically, the data is provided in
> >   *         the param_init function (see &struct kunit_case).
> > + * @params_data: for users to directly store the parameter array.
> >   *
> >   * Used to store information about the current context under which the=
 test
> >   * is running. Most of this data is private and should only be accesse=
d
> > - * indirectly via public functions; the two exceptions are @priv and @=
parent
> > - * which can be used by the test writer to store arbitrary data or dat=
a that is
> > - * available to all parameter test executions, respectively.
> > + * indirectly via public functions. There are three exceptions to this=
: @priv,
> > + * @parent, and @params_data. These members can be used by the test wr=
iter to
> > + * store arbitrary data, data available to all parameter test executio=
ns, and
> > + * the parameter array, respectively.
> >   */
> >  struct kunit {
> >         void *priv;
> > @@ -316,6 +334,8 @@ struct kunit {
> >          * during parameterized testing.
> >          */
> >         struct kunit *parent;
> > +       /* Stores the params array and all data related to it. */
> > +       struct kunit_params params_data;
> >
> >         /* private: internal use only. */
> >         const char *name; /* Read only after initialization! */
> > @@ -386,6 +406,8 @@ void kunit_exec_list_tests(struct kunit_suite_set *=
suite_set, bool include_attr)
> >  struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set i=
nit_suite_set,
> >                 struct kunit_suite_set suite_set);
> >
> > +const void *kunit_get_next_param_and_desc(struct kunit *test, const vo=
id *prev, char *desc);
>
> Hello!
>
> Thanks for sending out this series! I will do a full review of it. For
> now, I noticed that I get an error when I try to run KUnit tests as
> modules. I get the following error: "ERROR: modpost:
> "kunit_get_next_param_and_desc" [lib/kunit/kunit-example-test.ko]
> undefined!". As a possible fix, I suggest moving the function
> definition into the header file and making it a static inline
> function.
>
> Thanks!
> -Rae
>

Hello! Feel free to also use EXPORT_SYMBOL_GPL(). Either solution
should work here. Thanks!

