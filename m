Return-Path: <linux-kselftest+bounces-3860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBDB844675
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 18:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A581C25341
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2112DDAD;
	Wed, 31 Jan 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K7UFPQwu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738FB12DD8E
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723369; cv=none; b=hkd7dIrwyGZ2/oAamg2Z+uJuTnMn3ycUZUmuy2wmKS9WUAWgG0HYkPsd0tTWwnF00YyuEkOd3VLnIHUa8zQ1LCGa5TFSKVLo2qLAiPkZuLUq6tQWVpxM9lL0MeIAUsprL8QkzWSHfq62wLMPT7K9c9TTczf/MCJsKDCPM5211+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723369; c=relaxed/simple;
	bh=5BE3rI48gPKiRyCIeJRFwhcAnE7+fiHlRXlKvQEgPZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrzLirlWFJKxUTwhzqvCeLdMJdEOhuzKtiX0qWlz64pLxEzxlIRCI5wuNy7kdzGWAwu5DaCZtLx2EljZ7JFiQ99oydpYdR0OHdCS2Od6wFDE330yko8hnvr7I4AXU9UyHrfBqr1ABqp42dFNkY8VIR0WiJwPxflC7PG9Fr8glsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K7UFPQwu; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd5c4cffefso56568b6e.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 09:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706723367; x=1707328167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6RF6oHOyisdh7IJgSnB/tHRIU7aiX32oELeK+JlnUw=;
        b=K7UFPQwuK50txT0dyMiEMKTKgx7Z2zsoZ3NiO6iV/EN3kd+/vKdZ+ziyQ4Lf946SOm
         +cUFQPivS5eYEdOCeA00F1Lh+dAqi+8cDfMhoYJE6cqYE9NFBSD5jx4gPXFTcZ4CR85A
         eSv8249ppndhm33Si39J9tt2ingE3m0vCuFJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723367; x=1707328167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6RF6oHOyisdh7IJgSnB/tHRIU7aiX32oELeK+JlnUw=;
        b=feny9lL61dOvdRZ6IS+stowZ8evqi5GRVjCulViVKvYV13Zi8R/+Fg4cBQJJsb+b4w
         fjzGdh6s8Naet//JLhaLkMoxeqZYaZ37Z1jQn7XawdloXwOj/CHAGUXsO2LOlydH5t8K
         12Tfu5u7/8IZQbqtlavOyTH7gfr6t79jSnfi7+gxjDOHfyb7FuMd6qfZx+BZD1aD9XN+
         LzVdLXq+gzgVj5F+6BPsf4O1EWT6nEnjet5keQV1Aht9amqRZtfvd9WjVTJiAuC1aEQl
         pdpTMEYJt1rNLBcHonuG6LX8MBE60zvW4POjQP+7s8gu3i86H9tUXMyGM8dmoQ0yr8wY
         0FCQ==
X-Gm-Message-State: AOJu0YxGpQVuYl55Vq5JrK7RUfYyFVilFaCEHL/hmqz20ppUsd32LjyC
	dQzcRZS8ZiIDfur6Fx0iRfp1JQ0RsjQUynCP02bBxNcPOhXDdSYu3xU2VCA4isYacaqDz6BK0+/
	r6wB4+Dps6hbT5HjKiA6DiGzi6txMD0juCBoI
X-Google-Smtp-Source: AGHT+IHnJRdqnxvCutvLC4CPZ65xhd3+S1jtMi5yO+DNT4ZqNiGF46C9Z/p9lddl/TYEn8l461KQ37DNu63A69cIhuY=
X-Received: by 2002:a05:6871:5a9a:b0:218:888f:54c7 with SMTP id
 oo26-20020a0568715a9a00b00218888f54c7mr2620332oac.47.1706723367499; Wed, 31
 Jan 2024 09:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122152905.2220849-1-jeffxu@chromium.org> <87a5ong41h.fsf@meer.lwn.net>
In-Reply-To: <87a5ong41h.fsf@meer.lwn.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 31 Jan 2024 09:49:15 -0800
Message-ID: <CABi2SkV4Q9CY+vb+t_+7RN_EtFB+FUi4ObHaZWo_+KMt7u4yDA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce mseal()
To: Jonathan Corbet <corbet@lwn.net>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:37=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> jeffxu@chromium.org writes:
>
> > Although the initial version of this patch series is targeting the
> > Chrome browser as its first user, it became evident during upstream
> > discussions that we would also want to ensure that the patch set
> > eventually is a complete solution for memory sealing and compatible
> > with other use cases. The specific scenario currently in mind is
> > glibc's use case of loading and sealing ELF executables. To this end,
> > Stephen is working on a change to glibc to add sealing support to the
> > dynamic linker, which will seal all non-writable segments at startup.
> > Once this work is completed, all applications will be able to
> > automatically benefit from these new protections.
>
> Is this work posted somewhere?  Having a second - and more generally
> useful - user for this API would do a lot to show that the design is, in
> fact, right and useful beyond the Chrome browser.
>
Stephen conducted a PoC last year, it will be published once it is complete=
.
We're super excited about introducing this as a general safety measure
for all of Linux!

Thanks
-Jeff

> Thanks,
>
> jon

