Return-Path: <linux-kselftest+bounces-1574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3980D0DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC94EB213C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310044C624;
	Mon, 11 Dec 2023 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WL1ZZUAi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5526A10B
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 08:15:26 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5c08c47c055so45001087b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 08:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702311325; x=1702916125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnRSD+sBsefYYvzn3oBRGskx6xnKDW8P+HTWAzvULNU=;
        b=WL1ZZUAiHI3jgra1bD3B0ZPJ4M8B2vD6DgLOkWeDTst2+Vp15GKXhSfBYuhwURIoJe
         hSnt9KjWm5kY4+iJZml9qKbwHnM1vVJZhKTi8zzlYcifMGm5NSm/nU/Ba3JjbQoRIfel
         dpYl5avD1kTMoB5uQXrJ01mclOCcDTRmCkW02YA5WI7POdKbO3oigZhr8tarQEyBT+/e
         On7qNyOj0csaOO5VnIF+Loe57thEXJuzC0lvWd9vvO0SH3906PQiLICfrOrOh36jUW4a
         kwJMiyoHgQassjGvZ4SXcpY/kssjMkKC4xn1VumguyK+eqvZo3gQ38OwfTOXeJP8tJPK
         rNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311325; x=1702916125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnRSD+sBsefYYvzn3oBRGskx6xnKDW8P+HTWAzvULNU=;
        b=eA0Q4twZ8QrLCa2OQpZ9bQnVVpJvlqRYOfug4DOqH+Mn+3/rhTJoW3cosIcf/43Hrr
         EOcl6+hrNKpyh+4AC3kksCpxe8lt2AQboaWd36m4i1jg4bcnCV/nZTV7ia3zgboh2RDA
         y81z4cmVUz23gf/kfNnZW+I83Atk9jrJop+nwCmmLBDqCL6c+HxraAe915ThKzaZUSGo
         QMK3+ziYWH9LJanyFQqsgjjmfWR1LK6VZ/azv2t1XZOT6HT57IQeqyuHFxVmnMGfRrze
         1KiL1d6hNc41V85/TOj12zwVRahSe3Z8zgsolminVYxD7RsbSNDwQ1iNL8x1CLlxlO/5
         i53w==
X-Gm-Message-State: AOJu0YzrgA10XnqdszDalZ5ZKfkNxuetK3zOXkbGkKTNShEvSFDToOGI
	zyky1Ig+1oI4Oi6rvXKXL7SZUWEDXEgNX+f24Z7M3w==
X-Google-Smtp-Source: AGHT+IFtvdYDtV18pDROt//QGcMAArJtde9LSDLbsQOqNXlre7oPEzwTXObS2vRBaJiNoebZprMpaahUpj+4Qgxz+Yw=
X-Received: by 2002:a05:690c:3749:b0:5e1:8875:7cc2 with SMTP id
 fw9-20020a05690c374900b005e188757cc2mr464939ywb.15.1702311325143; Mon, 11 Dec
 2023 08:15:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk> <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk> <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
In-Reply-To: <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Dec 2023 08:15:11 -0800
Message-ID: <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: Mark Brown <broonie@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com, 
	lokeshgidra@google.com, peterx@redhat.com, ryan.roberts@arm.com, 
	hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, 
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com, 
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 4:24=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Dec 11, 2023 at 01:03:27PM +0100, David Hildenbrand wrote:
> > On 11.12.23 12:15, Mark Brown wrote:
>
> > > This is linux-next.  I pasted the commands used to build and sent lin=
ks
> > > to a full build log in the original report.
>
> > Probably also related to "make headers-install":
>
> > https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com
>
> > The general problem is that some mm selftests are currently not written=
 in
> > way that allows them to compile with old linux headers. That's why the =
build
> > fails if "make headers-install" was not executed, but it does not fail =
if
> > "make headers-install" was once upon a time executed, but the headers a=
re
> > outdated.
>
> Oh, it's obviously the new headers not being installed.  The builds
> where I'm seeing the problem (my own and KernelCI's) are all fresh
> containers so there shouldn't be any stale headers lying around.

Ok, I was updating my headers and that's why I could not reproduce it.
David, should the test be modified to handle old linux headers
(disable the new tests #ifndef _UFFDIO_MOVE or some other way)?

