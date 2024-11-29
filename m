Return-Path: <linux-kselftest+bounces-22196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EE49D19A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 21:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301BC1F20F32
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ACC1E6DDE;
	Mon, 18 Nov 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="B/G1UJ6J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536C13E8AE
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961661; cv=none; b=rq2TBhIPn02pqEO2f4OJTDt07F5tWQB2igeVPze32RUzdr/IWvQVkQqpgIhZkJfLXEKnyr4VMTWDPL8kraQoDgftv59gO7XYpEfi2r1YvlYp8m0DVNTZCW3mT9yoHy2JIXItx2mSYORSONK0hFE7dXBbU96eYLZEZGYXqCAsr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961661; c=relaxed/simple;
	bh=a3QVwlKH8NJSHaPzE4WZjNX233TZpQNVSY/HX3mH8+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTTiQhWo+7al7DJ497H1EOdVGnfi3H0EnYGIHowC+BIEDSnf1+4hIh+hY6Iv8rE1sAxMV0L50ILH9w0XrNmwvoLkVXjXojDgazyDLgUwYKXKVyqAko6FOq9hYfKnw0gLTqyIweT0fj/xeg9I4l/m/gfk3+8pAdZQUXnRsTQwflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=B/G1UJ6J; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4635760725cso43872651cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731961658; x=1732566458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3nxx+7qrTCUTgF8wRPbLSF+iqg1a4HrwDqR95ENSuQ=;
        b=B/G1UJ6JpLfkHNgTDh16udNu/k0klQPnRsX1gkuYuueecFF5cXnpo4Vkox1CnCKoIZ
         dJEPRctptZB6URlXdXLgDUSrAdbC/Jp6hyC55R85DO7ngBq5L16igBUCLohVM9CPxvYn
         9KAJrRjRwmJ5U5r9GH7YxfnQo/FHSAOrAuF3MnszELVBZOa3Nt2B60iuadyFmx15mn99
         TYzJuvvfnj8reiJAzVsqHy9HAlGdv86HUtRDKco0E3llKuOdwKP9yt93XxktQSLmr38b
         C0NCgbc5ZjsNGA8s0LoQHVa2v33zdv0+WaGcNphoaoKRA9XrwvQRhsx4RH/EEkNCN0ve
         Y7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731961658; x=1732566458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3nxx+7qrTCUTgF8wRPbLSF+iqg1a4HrwDqR95ENSuQ=;
        b=Y9svRNxQ11sFeGqfIE+1FRsh78CqbefgYWWvzCrEOi0cM0U7kzdSlSoHopY7gS/m9A
         +YgN6NzOtYgT5pJ3eZZgH5js87pXRvAp3wwNokkNi3k3dOUli3uYCVfnryt45J3Bi2gZ
         l6BaKGSaCJPPPzC3ga+q8GTPklcR8+OgQGOaz75XEdNaEwDyGP1N4vBXjU0g9NpiJLDA
         Ci3qphl/y2XLfpugquGeaa7ixURRSwPINDi/XgBXuMIAvrR/gtjOaAz+SgvNrAejxO+B
         dmN3c04KaBTAMtbPuNOd6paH/MA5Je3Wa503Yu3HLcKCFmWwUZHGSLCLPDB8I+cpqpsR
         2jBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOz1aR5ElePBtkVXnSBBNZ5BQkuPVWaoazv+erUHQy0Uk483ahX/TYIBeyh8bjjgeIkWpf+WlRzfd0+nkWPl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysrxHnuZQWChHCkij5Pa0BNvbGbqWtUP7U3qO56uoLoM84My/r
	huya1VVqFonQvz+/+ywd4tRxw9EcUphZebXOzu/ePH6KMf9RxpWaaw8k7qQ6pQ2mDMkkvb8MMjg
	KWSBywMANsvdr+i6TaH9bTmtzAyzDGr23H4DJNg==
X-Google-Smtp-Source: AGHT+IEVnem2aUWUfWPU86vXVaI52L5T1uqMRPM6WN6TPqoknhSkQ2b3QpTvZt2EMklkAGUIuUVQ4/bXMBR3sUHYFxI=
X-Received: by 2002:a05:622a:4c8c:b0:463:4be4:b03f with SMTP id
 d75a77b69052e-46392d6cbffmr14403641cf.11.1731961658470; Mon, 18 Nov 2024
 12:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-7-pasha.tatashin@soleen.com> <9868242c-ce91-421c-8f55-1185a66657ce@collabora.com>
In-Reply-To: <9868242c-ce91-421c-8f55-1185a66657ce@collabora.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 15:27:01 -0500
Message-ID: <CA+CK2bBfi5pgkVbdTDw-r7xym3FDsb66LL3qiMpujHTsbN8KXg@mail.gmail.com>
Subject: Re: [RFCv1 6/6] selftests/page_detective: Introduce self tests for
 Page Detective
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com, 
	schalla@marvell.com, david@redhat.com, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 1:25=E2=80=AFAM Muhammad Usama Anjum
<Usama.Anjum@collabora.com> wrote:
>
> On 11/16/24 10:59 PM, Pasha Tatashin wrote:
> > Add self tests for Page Detective, it contains testing of several memor=
y
> > types, and also some negative/bad input tests.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  MAINTAINERS                                   |   1 +
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../selftests/page_detective/.gitignore       |   1 +
> No need to add a new directory. Please just add the tests in
> selftests/mm/ directory.

Thanks, I will move this to selftests/mm/ directory in the next version.

>
> >  .../testing/selftests/page_detective/Makefile |   7 +
> >  tools/testing/selftests/page_detective/config |   4 +
> >  .../page_detective/page_detective_test.c      | 727 ++++++++++++++++++
> >  6 files changed, 741 insertions(+)
> >  create mode 100644 tools/testing/selftests/page_detective/.gitignore
> >  create mode 100644 tools/testing/selftests/page_detective/Makefile
> >  create mode 100644 tools/testing/selftests/page_detective/config
> >  create mode 100644 tools/testing/selftests/page_detective/page_detecti=
ve_test.c
>
> --
> BR,
> Muhammad Usama Anjum
>
>

