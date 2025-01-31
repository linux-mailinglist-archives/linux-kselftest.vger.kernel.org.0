Return-Path: <linux-kselftest+bounces-25490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5124AA241D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 18:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC45188AA32
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805E1F03ED;
	Fri, 31 Jan 2025 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlrXWIKj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C181F0E25;
	Fri, 31 Jan 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738344200; cv=none; b=ALakL4fL0R8xZSi0vuA7/Ar4q9Ok6ZdigSHplp5M7yC+cknJjQOKOE2RNLv2+qkDhu7JD9VWMIQHaaUtt2uPIZkDWUpVbUlAI3WmpZ/euGU3c+64NmjYYKYhC9fNCAtAxe5w/zXK2TVvKQKNR0l3V3buL7MEZfF4NR02FEbMKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738344200; c=relaxed/simple;
	bh=/d8h5Gl0hNG5i7pknYt81MlmBEtBOMwxgWajMjazFGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqg0eWk4uQ7asXavT3MoxS3l9WldbYdY21vpa/51hl7e+Y0bYAt9ZXCeJL9o64AgIIaO8r+LnNY1ZXI5Clkq1MXSoaz6mUbVrvQ7YnlvzXPD1geT78SPIU8Ll+0ifYRwAh+PKEcCE5Bq07FKuZ6BKWDI/n9GauXWj46gy1gIwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlrXWIKj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so17542941fa.1;
        Fri, 31 Jan 2025 09:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738344195; x=1738948995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d8h5Gl0hNG5i7pknYt81MlmBEtBOMwxgWajMjazFGs=;
        b=TlrXWIKj/NFE/udt7SKJ+UMTiPrd77+pmAh/tzhH0N8x5wPt6nSLXQ+z5gx/pJY0LB
         SRZLosgHNQgcsyDOxfvJJMvZ39HfH1ELobUpkk2xYLMdXGmXe2alzktaujOV2yu/6md2
         P0133yLEcNLJCx5COD1nFUollpdz1UblptjXcNd7l11EJ8gVXBd/dagcXt7Gli54R5/H
         eZlnlRLQCuAt9BbGY2cMUUcHoZFI/wzQP8LswFHHpDbUXEwsBXIFj38kipo3sp5yUkgB
         EQ8CgmUmFdhgdyw0yyvQHu4p+u4c+IJh+lZXIv/DNb84OPytNEaen/QRUIie9excylZg
         inzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738344195; x=1738948995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d8h5Gl0hNG5i7pknYt81MlmBEtBOMwxgWajMjazFGs=;
        b=d9nUWmLFIhrdD62Z2sjWzgQayNhA+4tM1xVBlS+g5jaEfWrs1ZurAgsASJyldQ0LaL
         SeMRZw7Mw8IKI1SGuB8iceOjOAHk+ncR+1GIRa/YR4+1Z2Gx87jTUuiFDuc4UeNtJuXX
         Z7WMglECuVYDM46S4UfA7H+YMuXZFLV68egZp42PwlFoPALiR3eEefH393SxxjP+ibTa
         Ttpxwt83Z0d+680Fc5p6CXfwPDClsu6mDxKN/gGiiBkrSqoFnDjCJm3MotewGENtPHKH
         Hamei7Wl3QXHVrrYl+TPbpQicTZxYtcdtSAzYxvEP0gEzLajxsjDmIzlyRzB1WL1E2z+
         9rwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf0U8kC55gAZX1kzTUryIdCNtajp9l5PlUjMFCpquplrpq6T6cWwQ0Obt3hRIHMcjwRK6a7Mx8H1x+/1A=@vger.kernel.org, AJvYcCXqUDI4zHrH3qxy2W5dkkpSKgZx/5s1sczWRkJzds+9SKmbhT/gU4KUhdnoOckslAMGqrno1Q0aAMAVCcrGsRql@vger.kernel.org
X-Gm-Message-State: AOJu0YzuA8gx3Kz/d4u3k34RGO5mnZczZv/4nSPTNTSlIwCWEX0Xh82h
	mBXBwVj51p3W6I05ytbCwMBroJIH0tTU/5hXtTBFd4IHEYGmSCaybljUuAEqygKnF1O2fI/sT4x
	vzi6pM8ceBXLzgj2ILsYoaIyNimU=
X-Gm-Gg: ASbGnctTZuVnzrRkxmaYKbLpMlSHtY583CsBvVpzJBTLi3jM0wW0HdX92z7iR28aPr6
	P/Xjx+6DUd5jlygbxyIiuW4vdKgeI7im8vcHiQr4rXNVL7I67d4FuxkLDW/OBnteD1348Vuzss5
	6UFz9viLp6eJvPCHZXOtIn2mpRwXiMjA==
X-Google-Smtp-Source: AGHT+IGJ4g+sf0NpPzS264NAZZljgPLST/JB33D/WecGv7UtAvpUhYgk44BHmPUcnXImCacN0yhkPnBoRIp8tIo4lwM=
X-Received: by 2002:a05:651c:b29:b0:306:1500:3ec1 with SMTP id
 38308e7fff4ca-3079689e130mr44022781fa.21.1738344195120; Fri, 31 Jan 2025
 09:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com> <Z50EM7gxqyV0Eois@smile.fi.intel.com>
In-Reply-To: <Z50EM7gxqyV0Eois@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 31 Jan 2025 12:22:39 -0500
X-Gm-Features: AWEUYZmov7rwhzQt4L_gubeLR4_rNewiqzj3HS9fkGfKvjnl6oyFIqTuqXce-tk
Message-ID: <CAJ-ks9mMgkdNEHHKELa=5gNz+CzUNno08ZKJwwQDVEb5WvN32A@mail.gmail.com>
Subject: Re: [PATCH] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 12:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jan 31, 2025 at 10:47:49AM -0500, Tamir Duberstein wrote:
> > Convert the scanf() self-test to a KUnit test.
> >
> > In the interest of keeping the patch reasonably-sized this doesn't
> > rename the file in accordance with usual kunit conventions nor does it
> > refactor the tests into proper parameterized tests - it's all one big
> > test case.
>
> Rename of the file may be done, but you need to use -M -C when formatting
> patch, in such a case the diff will be moderate in side and easy to revie=
w.

If you prefer that I rename the file, I can do so in v2.

Can you explain what you mean by using -M -C? The formatting was done
by hand, is there an automated tool? I tried using clang-format but
the result was a change on almost every line.

Note also that though it looks like a lot of formatting has changed,
in reality almost every changed line has non-formatting changes due to
passing `test` around.

> P.S. The test modules in defconfig is something which puzzling me. I woul=
d
> remove all of them at once, if somebody wants debug configuration, they w=
ould
> specify it and use with help of merge_config or alike.

I'm not sure what you mean? I removed instances of CONFIG_TEST_SCANF
from defconfig because that option no longer exists.

Cheers.

Tamir

