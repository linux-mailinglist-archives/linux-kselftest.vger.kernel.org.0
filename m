Return-Path: <linux-kselftest+bounces-26099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428E6A2D610
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 13:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E153A7A46FE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021812451EE;
	Sat,  8 Feb 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsdJXP/5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3041E4A9;
	Sat,  8 Feb 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739018055; cv=none; b=ndmfGclyh76qBPQaebse3i38MqUFpVHkXmiTBZPSRyImkiguZ8EMBNMq69XJLe3a0MUX2br1TVUVUq1diiqlJatbfOpcVlEUkYprUoyBgDcgWRBby4qog1ES5YLArYYCsxE6hUS+1/78ev3Hi5B5eMmcvQsEsm3SKyptWC6VQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739018055; c=relaxed/simple;
	bh=7NtmFEV6HVkwd/iCjaBhvbggj+/ki/A/XgNsktxy7yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFh1gHngBT2QRs7sA9nr+pYOUBZx7BX1hGdRWIAkVIweLsxrVkndrsUxeuSwmPoOUXQxON3cB07WF24W8C6HMZTf4TaJww95ZQ1umadjv34SdM1+jSPPEXdGiXMukXQyzr8VG0nGQisQDbdui+oLh+VCdPEksjMal6bco/wvWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsdJXP/5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30795988ebeso27864121fa.3;
        Sat, 08 Feb 2025 04:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739018052; x=1739622852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NtmFEV6HVkwd/iCjaBhvbggj+/ki/A/XgNsktxy7yA=;
        b=MsdJXP/5PaPsFlQE3nwuMrgPVfy+OEvzLFIqH9vJzWbNtSI8IXsPGWClr6cB1C5FGo
         8OTVfMxIoE7hTQJedzcuXe14vCfmYI3Ojy+8jTwUV0gOz/sBX5Ef1zD0u3Kdg/2qZKEQ
         c0H0eQ5M42qQua6kyMViUEf754AOoyaMdHTdHqWor7S67PPhHQrjC9j4FLJyOp8wczqh
         JUlVBCUbp9XGmCgGP6toG7oWih9Qf8UkKEowknysXJz4cgCWrPhQsamEkoaHaEsheWZ0
         4qjeH+kNwd5McCwTbuqFceOPWuS4nweGfqq1Wo5OCs0/gwMq52MFcCLzLN/G5g8mfrg4
         g7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739018052; x=1739622852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NtmFEV6HVkwd/iCjaBhvbggj+/ki/A/XgNsktxy7yA=;
        b=sWJwrzvicFFXM4Db8OIXNcBXkkLdV7efNxeOSe+Md9+DyO4lhFh5ToaLhN5WWO6xeu
         86zVoVzRAjZRPFokwMS9qHIIPqoq5sNtDFxaWCN6Uhy6eUJlr0Q4jikrIPN0DhXJSWDP
         +803wIuaSA6VQ2EA/nGPghfqDsD7+DTXkKFAyHALi1C0B7JIIkdCgZXhSgjTHGZb3W2g
         7tyKVD8M1aOE5vepTIp8QAzN1h2FA//33f3h522KdfkWxj2mec4jzZ3xEUcXOP60EpBF
         WtoUwtFbgcNbmCBE+Dt3EOPPUgYjpy7X7JL8yl368Hhilk/oxAgOyhM42aVf3+d6Fylc
         wFTg==
X-Forwarded-Encrypted: i=1; AJvYcCWSev5cpUxj62mRVSTSwNU4ML31/+b8nXcVBfRpJHqI/3z1nCThtNzss8SSNR1v97tKpyLw7d8Qx/Ysl3s=@vger.kernel.org, AJvYcCWhJP8m4oHptyNUvKtnKdx1gtWySCs68eWg+F+MTWOqtQCW8gBI+YIy+1eegMrxXgvK1J4XYGlAmFEGOISWYw2K@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWvOaVIhmdfvi3HaGuZZb41OuA0G2mfCWB+saELoMPPBeG2C2
	KYVkLn0bq8NBFT1HtgjuJKEhtVEnfMqZ+VaqbP1oSdVg4vqeVyQwZA61fUXVYlsYv6Xf7sSRY3f
	vyl954lkmUe9kzmNQoyfL8ZNfLrQ=
X-Gm-Gg: ASbGncsx4Q6uPWONByGE+YioRCjSh3Gus3wMkkV/f6dXnFUbKvFj/mIROUIfSRoLdWm
	19qQVXWKOc0yJBl6xxYTNW6ZYxedWOsfQa7/e3eGf7/MVm5kXlbFl/If7lr4OpmUJ0+iLfzGd7C
	l3Q4YTK7a6V4y0TVaurJi/slW+kCz6QC0=
X-Google-Smtp-Source: AGHT+IHOVYZ6119BddUktzA6djJrY16tcFrgFxUAy4xskpPIrBDV/cXo8QbRQDOfCKTZHGOjX8eg/TALGJvaLhNy1Bo=
X-Received: by 2002:a05:651c:199f:b0:307:dc1f:e469 with SMTP id
 38308e7fff4ca-307e580c5d1mr23625221fa.20.1739018051928; Sat, 08 Feb 2025
 04:34:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <20250207-bitmap-kunit-convert-v1-3-c520675343b6@gmail.com> <CABVgOS=W3Wny0q-Kpj6P1ZXyG1R_HYCrPLtnHiuruW9FxoHrfA@mail.gmail.com>
In-Reply-To: <CABVgOS=W3Wny0q-Kpj6P1ZXyG1R_HYCrPLtnHiuruW9FxoHrfA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 8 Feb 2025 07:33:35 -0500
X-Gm-Features: AWEUYZnxmpKkzSNj_ExYRdu7y-yKEMYavEZgdMaiYXQTRBuM3t00g7LqepmE3D0
Message-ID: <CAJ-ks9mTAp0UwRViKHYqfFV+qkgi89=pNxiQOZYmHdYzkJ6Wcw@mail.gmail.com>
Subject: Re: [PATCH 3/3] bitmap: break kunit into test cases
To: David Gow <davidgow@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 4:07=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Sat, 8 Feb 2025 at 04:14, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > Move some tests into `bitmap_test_cases` and parameterize
> > `test_bitmap_print_buf`. This gives us nicer output in the event of a
> > failure.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
>
> I very much like this cleanup: the static global 'kunittest' was annoying=
 me.
>
> I think there's an argument to get rid of tc_err() entirely, and just
> use KUNIT_FAIL directly, but I'm happy either way: it is a lot of
> churn.

I'm happy to do that. Pulling on that thread ended up producing a nice
cleanup. There's no way to add a patch to the series without sending
it all again, is there?

> Reviewed-by: David Gow <davidgow@google.com>

Thanks for the review!

