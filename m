Return-Path: <linux-kselftest+bounces-28496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A66A56D94
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC90B189056A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAE923BD0D;
	Fri,  7 Mar 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehQP7odr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700D23BD04;
	Fri,  7 Mar 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364716; cv=none; b=BZmZDVLaB3hNEOysoJsUTKYcrSwWiXHUOnr+YWwLJI9lfFevCjaiVM0TMw/R1ZI0PgLMs9BJ+lz39KigiXXplCwmsf4d8IBP5Ca1yrHcw1POd+3RthA/2hSfqEEmglY6R4vFJe4r9QHeMf+YJi0ka522MojcLdHhePqlLvpWi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364716; c=relaxed/simple;
	bh=pIN7bvF1ojgXVeTSfCcjU3c2uUORnFTlgctHnNFCycU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5uE1KZMGIxWSc7OVj/qFqhYE2pih75Wxh+csV9834QHxllrLbw52erlaoS7fGAmt7tpJbds69w3d42zuUI4xEIEHVlurDrAEKTCSAmmDmNQiPQTKPE1pSEtUmUkuNoPKY1FwUaM05IidwK93ps3lrN8QVoIINLfLC52GmVXeeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehQP7odr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so21375891fa.1;
        Fri, 07 Mar 2025 08:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364712; x=1741969512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2CFQJbmHziqfZ1WlA8nTaS4u+SIYAl6KppF5R5h+0M=;
        b=ehQP7odrmXCIpLnx1F3Czmtmtkz4cacGIPdXgdvr5wpIYyP3ymS1AMy8UvqgE+5/R8
         uiXpu9E1AD9JtRyb1DNiTIr9Wvqt9WnKbfBsqg4wZ11vmsYm/L5Zv40JEDDsLBaGtRkE
         R5CCuSspvfrJ32aKJVcvDyee5/tGxYjzfFpw6nao8E/PYgwlc2R3Fd4ekpW74Z+uTiqY
         aNq9iw7XInNHFMa4Rs4jlGvwWgJwgAemInBZ/B41rmh+lPSxHoao3CDfUkOlYckhxbcZ
         IUkwFG30TJmW+6O2v9vbMBR90FHbl5pESeiqmg6ss3O2vPDmyzA0qjvie/x1xneb/Nza
         Kebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364712; x=1741969512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2CFQJbmHziqfZ1WlA8nTaS4u+SIYAl6KppF5R5h+0M=;
        b=D0uaRYzoBReBiY4c/f205Wa+FYuA1ONCQ1VE15uwcnDjlO+ol2VKxKw7NFpOZZzZwN
         7zMRdL82SynzRD/a/N/60TMOxfLin1SRUHxGT4fAdUJtRtBYBJwjUallHvHbnFiBWSco
         MVc+92GPBheGKfS9uUvGhszqZGn/8WAmPY/Q8IPbVCVUR37sQZ6F0MVqpXnU6LRtHa/I
         iz4ptqFOrP4nNXHEUr2su8TbNtAoHchr15HafJC4mwwhQhPqkrsk7HsuUMRugIRpvXSF
         OamqA215+m9Ud1+1K7zWFow5SC9S9elmWZvzqJHuEqfh0wnxBKG7GCSZWA1oGeouxYAF
         3NpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSCIwFZJoRd598a0X/YrGaNMQHkejzjM1+rVcdxIyxZlmdbLovqBIUU9sGRtrwi9bbldZzSUoEVnk=@vger.kernel.org, AJvYcCWhP/M9whmVit66QVepn0Y2dDBlIuMgfW7nlJluysj1LQh+rMoe8fxcUQCtpe6L93E2uUVkrlVFe4e9NLom@vger.kernel.org, AJvYcCWvqFrtURDlIiwvPs0wR3edjltNKnTEo3qDvZwE6+P8ge9EtVqX72YwHfY/ayfmy3XWyu6/WDEJl4XEz/NrMhpy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+2W1MJ+L35i6hrrJxh56iKbxlBE51igpmlYgeYHX+0Gmuf1qO
	SBaIpRu6mqHoik7mfsdIYIQc8GT3XI+eQUixPmO86G24QJxw6ggjHD+mTaoEqJulobV9qZqDbg8
	sTAghkDN7I31/Fyx6XDU2+c1kr3Q=
X-Gm-Gg: ASbGncuQ+6MrHAAoZL6qr6MPGundOk2xPNUEonGlfPY+7IgVC1P/cx1ZMGGPxjvH62U
	ERtiiLtTR0IQCX9D8unsQBMQGwT3dMOZs3ljdoYjJ9JPeT4WIQA78hcWLyLk5Jz0yjO3LiWJax1
	4YbPksvbLVLZhxwNezw33Uu3TpvqczhKiGANHy/DLxwbDxGsSMD6wTwXvWOgup
X-Google-Smtp-Source: AGHT+IGqyL09z7u4Xuju8syY9+78OKZgCCJj4/AtHOZWHMIXhvltnjRbnmZl42z4OZBt1oV5UKnpsTKVfQtr+7NbeCg=
X-Received: by 2002:a2e:7207:0:b0:302:48fd:6922 with SMTP id
 38308e7fff4ca-30bf461caecmr13567401fa.37.1741364710717; Fri, 07 Mar 2025
 08:25:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-3-5db840301730@gmail.com> <Z8sdm7Nhk4h3hoUq@pathway.suse.cz>
In-Reply-To: <Z8sdm7Nhk4h3hoUq@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 11:24:34 -0500
X-Gm-Features: AQ5f1Jo_IFcC3B8zSbUncIFkWnLYFACfJ9QNhhH044lkvIrDkmW2XRTqrixiWvY
Message-ID: <CAJ-ks9nA-393OaE8SbttaoQz9s8MUKqED5GNoh8tQyaJm-0GxQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] printf: implicate test line in failure messages
To: Petr Mladek <pmladek@suse.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 11:23=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2025-02-21 15:34:32, Tamir Duberstein wrote:
> > This improves the failure output by pointing to the failing line at the
> > top level of the test, e.g.:
> >       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:103
> >   lib/printf_kunit.c:167: vsnprintf(buf, 256, "%#-12x", ...) wrote '0x1=
234abcd  ', expected '0x1234abce  '
> >       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:142
> >   lib/printf_kunit.c:167: kvasprintf(..., "%#-12x", ...) returned '0x12=
34abcd  ', expected '0x1234abce  '
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Just for record. I like this improvement. But  I am going to wait for the
> next version of the patchset which is going to add back the trailing '\n'=
.

=F0=9F=91=8D

