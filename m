Return-Path: <linux-kselftest+bounces-14381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B881493F6D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5AD1C2160E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F7149DFF;
	Mon, 29 Jul 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="FlpIE8aw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E2148FF9
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260270; cv=none; b=kb4KLGG9ie84EJ4jBejEzjo/c0SPZBYareuaqlBp+/0InqXsaGcrGLTaK+iUpDTCvPo8DYCylSYJUQfnrqQtgaVNsYXWstGb7b3Yt4UXjOwUVg+4ifYxQCNvKbiZB6buVaylS4mnCEqXzmKbZcqyD1ZBjHqR+TztM32deFBOi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260270; c=relaxed/simple;
	bh=yG95b8+bC4kOE+uaI8opD8vDKWLRODfkFzlGoBvrT+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QB3n3MYZhHFtr868psjk82iFx79j/UXIu+tU0KY7FnxVJxLe2qN3bfFfpyWhmisaLtEFUhdkikvqwZyDv8aDS12GesK9XzLpbXgE8Iml2CGcNEZjYZXpEVceHnBbvEkkzfJexSSB8ulh2o188yr7BIiX4RXxEFpXWfPBqLPnNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=FlpIE8aw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d1c8d7d95so1903801b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1722260268; x=1722865068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVlA1fdRbUzGUAt+y6uU46luMcytNgyhT35LNSCEVFI=;
        b=FlpIE8awr0cTwKExXUN4iBYmqWqHwMJfgkTsUPn3rZoChr+1ZTfybqcEcHMBBgNrCA
         UfWYShJ/dKI+3SfRhH/KQmuM1Xfluw/U7s0AJnZNA54MrNVGCaBVHb4C8RZkebG4agNB
         1Sp2VyRup8IFSC9jKmYyAii/ykANZ72Are/I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722260268; x=1722865068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVlA1fdRbUzGUAt+y6uU46luMcytNgyhT35LNSCEVFI=;
        b=Rda2y95ZxhFp7qGnCAJwdWSzo9boji2LnjmT0x6FQdfPWZqxSu1Sm9agZ/ElDZxTyG
         XkjijbgWgGa46wrdelQ+HzvLne2GD40nTPJQLfn2uUa3y6y3jC1LEBc/aITNq6K/xHvw
         UOZ67VMBRQb40ZPH9yj/JWH2YgqnGnVA8PgWpCuu/pnVu180wctWUDefPcig4BTD0mWY
         Fvr/J+6pn/2hO2EB4MCkCplzcYNfpnZqO1r1qFguMumbw6pnqht11M09njoL+OlH/3Le
         7X39Du7MBnzAc9sPIQimfjhLzMwNwvCBIpiZ/NRnPC/m+n5q4I81KtmIi+PUTrfJ3Yhy
         Ipqw==
X-Forwarded-Encrypted: i=1; AJvYcCVigAvoFaQLLSu4HU9fs8ldqbaYLgr24mGxm2lW6Y6cnbgZTDOfwho1ZCVHIHZOB8PipZnxcC8gnbc30bvdeYaGT05w2dD+s1hn5znYRzag
X-Gm-Message-State: AOJu0YwH0m1m6upG9PgxFOmWW1AErFOSJ63VPce5l6qBAg9g5m2rt4+3
	09o3e5BEGtfkISxolP/0UFdPkORu3DQt/FqmYfSaejjKIrMeqmmksz/gGVnxm30kxClWqAb7oZI
	fDPUAPrB2ppzVUT14ZdKc4SMkaizKCgGOjUxCGw==
X-Google-Smtp-Source: AGHT+IF61PUOxYopexvONqf7EeqGxcofDSZYfNicSgd0cvdI1gdvPurED0XAgonezp6ozKF6WcHIo+B+gfQ7euXDvTg=
X-Received: by 2002:aa7:88c5:0:b0:70d:262e:7279 with SMTP id
 d2e1a72fcca58-70ecea01412mr6938042b3a.3.1722260268207; Mon, 29 Jul 2024
 06:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723233149.3226636-1-davidf@vimeo.com> <20240723233149.3226636-2-davidf@vimeo.com>
 <ZqQFaz07jIg4ZKib@slm.duckdns.org>
In-Reply-To: <ZqQFaz07jIg4ZKib@slm.duckdns.org>
From: David Finkel <davidf@vimeo.com>
Date: Mon, 29 Jul 2024 09:37:37 -0400
Message-ID: <CAFUnj5Op_SZ0sx7wCii=EWgx-nXycpMe1=961Z8ayOeAFSb2yA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Tejun Heo <tj@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Fri, Jul 26, 2024 at 4:22=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, David.
>
> On Tue, Jul 23, 2024 at 07:31:48PM -0400, David Finkel wrote:
> ...
> > +     A write of the string "reset" to this file resets it to the
> > +     current memory usage for subsequent reads through the same
> > +     file descriptor.
> > +     Attempts to write any other non-empty string will return EINVAL
> > +     (modulo leading and trailing whitespace).
>
> Let's just please do any write. We don't want to add complex write semant=
ics
> to these files. Writing anything to reset these files is an established
> pattern and I don't think we gain anything by making this more complicate=
d.

I still think something more limited is right here, but it seems that
there's consensus
that accepting all non-empty writes is the right option here, so I've
removed the check.
The next patchset will accept any (non-empty) write.

>
> Thanks.
>
> --
> tejun


Thanks,
--=20
David Finkel
Senior Principal Software Engineer, Core Services

