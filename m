Return-Path: <linux-kselftest+bounces-1628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D980DE1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 23:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD56B1C214AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514855790;
	Mon, 11 Dec 2023 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LH5EeGXf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A498F
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 14:24:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so22565e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 14:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702333491; x=1702938291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuQhIspD6JR77pVxf75RvkVh4XrOwhOgI88fQHyFirk=;
        b=LH5EeGXfZ7RLz9iWo8xeyim+HtNCofdi73PH3S4IeeNSxU6G/goNu0/gtcNk6qFrCk
         73R5DaGDra5ziw0Juf9YQi6jH9QGgiitfre9wUPwMlKoi1E4Re1HRXtcVqCTSyIdw2n0
         M5EMZWc/o9kLkJgGGiuY1Ad9xvf32ArQ6Knv/zWTfSIR74XQ+MVls4o9jQ2cROOL0OmC
         3TjIxeD0BtK95RTGRwa0k7+nYHy3PW/0BZ5jVu+kwDpdVFKLe/QjFN8ICj8UIdZrvJoo
         Fl6q+IPYR8nridsBq9kZODh1cCe7rp9h2Y5IrtvEVmvawUsDt+Rux9EAZDOp1yrq7c4D
         Oisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702333491; x=1702938291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuQhIspD6JR77pVxf75RvkVh4XrOwhOgI88fQHyFirk=;
        b=qFUpVc0f0oVhAZFgN1wTrOmlsjtEV3W5RXyWfpnP/n5Ug8tu+LAZbqczC4Bu/rKza1
         IMGMFrO2bdK/N9ki5f5KIXvUqKLZY6CDGdWy4xTpHuLcmBGNNxIB+wJWDMESsy/97/NB
         qm/huTOAqv2bYn6HmY/35yYhTyPTUJlr550lovk2ikGf/yBdR6yqaZxemNKYANMRuyHu
         LqQnBDDl3jTrdw3i6wHFpEl9jwWeBz4cmQ2ujZBLU8uiRSHKOSnsd4FZePqmC0Z2AvGb
         wxLbn8BzYMXkDaFgqIz0n0bh/E4qDhPsnPt/UazMC9GL0CZUSWJBS41za19Q4MQJZ1ky
         yZBQ==
X-Gm-Message-State: AOJu0YyNrnANllfuHAUQqrD8Tln2h2HLit4F/zFfb+88pwgj05f3Azik
	fj8799XU+tn+CC/xrhZuesXFdgghAkRfzwzpWcu7KQ==
X-Google-Smtp-Source: AGHT+IFj+gQqjsQ9tZwqQ54imOTiWUHQxRdBbgfw67rUBLpxq2CY7ZuT/sJpYMBLtvRJ0bbqhxLMjQeCf8fVYSPRJtk=
X-Received: by 2002:a05:600c:4f4b:b0:40c:4ed3:8d1f with SMTP id
 m11-20020a05600c4f4b00b0040c4ed38d1fmr29228wmq.7.1702333490714; Mon, 11 Dec
 2023 14:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com> <20231204221932.1465004-4-rmoar@google.com>
 <CABVgOSmbbAyckSvKREmUDBrZJtErQpxaNjXH0vaH1oZjkVt3JA@mail.gmail.com>
In-Reply-To: <CABVgOSmbbAyckSvKREmUDBrZJtErQpxaNjXH0vaH1oZjkVt3JA@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 11 Dec 2023 17:24:38 -0500
Message-ID: <CA+GJov7yKzWPfKGWaJwaHR4kJkotXdOXJ3yeewUhL4gTe2jVhw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] kunit: add is_init test attribute
To: David Gow <davidgow@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 2:57=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Tue, 5 Dec 2023 at 06:19, Rae Moar <rmoar@google.com> wrote:
> >
> > Add is_init test attribute of type bool. Add to_string, get, and filter
> > methods to lib/kunit/attributes.c.
> >
> > Mark each of the tests in the init section with the is_init=3Dtrue attr=
ibute.
> >
> > Add is_init to the attributes documentation.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> Would it be possible to not have this in kunit_attributes? I know it's
> required for the run-after-boot stuff later, but I'd love this to be
> (a) just generated at runtime, or (b) stored only at a suite or
> suite-set level. It seems like a bit of a waste to store this
> per-test-case, and to have it potentially accessible or overwritable
> by users.
>
> Otherwise, this looks good (and I appreciate the automatic setting of
> this when merging the suite sets.
>
> Maybe if we always kept the init suites in a separate set, we could
> just use pointer comparisons to generate this; otherwise let's make
> this a suite-level-only attribute (inherited by tests).
>
>
> -- David

Hello!

I did consider making is_init a field within a suite object instead
and then pointing to that in the kunit_attributes framework during
filtering, printing, etc... I will change that out in the next
version.

Thanks!
-Rae

