Return-Path: <linux-kselftest+bounces-1584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5580D287
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7320A1F215B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEBA2574D;
	Mon, 11 Dec 2023 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hk4xrQvH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A026FB4
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 08:43:17 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db5e692d4e0so4864586276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702312997; x=1702917797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N+ZFziXjdSw2YHfmDnkRoyHHr1qlwBSocqQcY1TWQM=;
        b=Hk4xrQvHZbaQQa2Q9/6ImbEhqs5RE4Ju+k7KdVg4jueISZpjBws/Vuh0zUQsGU/aKR
         nOuq+eBuCnnYEW5R8hHzdYO6Vm1NhnByXq6wCF5DclLPRxjTPwDdhnEP0luvow3Lo+8K
         CTXw4nfNFTXUQLiAqZ5BJnCUpSfXdavk1XKe2s5ORzv1Cc4vwxCBlJ7s2GZeeaXJqcsT
         qNWN0gKI7j74/sfXbqT9GRmvs9Sy2zGS+nGah/UvGx2XoNaDSScyOpYSavyFScuRaXmd
         gH4xh0KWSVV4uxk4KQldLBILL/22N2K5f4JPrX3rfLfe6n/ftm+iEd7syqK7XVKs/Y4F
         XJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312997; x=1702917797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N+ZFziXjdSw2YHfmDnkRoyHHr1qlwBSocqQcY1TWQM=;
        b=X1JvHAripF7KU2xW7WTYTlmEHK7+UMKxd6WllnoekAme+DcufAgfornfrPNVw+Seq3
         tHGuVEHm3sF9bcZjS5bJRtYDzYFYejuDfL6RJ5URyFLQEu5pwpcoS1265cLEMFf3GQXS
         AaCZqFKRGmQ6uFLJ/YtWaUVLr3K97maTyDrmVqf5SYrd76mTfQoR/0WScrPGifxogMcA
         NCJoXuQzGYX4EKnMOUtF8lIaVjUpVlv2MPQggWmbShfv5PfR+gfBUS/NJiecxSjllyQB
         7rrDTy7yLNfMuShIgYtgcHlO7S3OzEOmzSzOmJ8e60lW89yJSR3/+bcvyeBtS8TZCvXp
         lYZQ==
X-Gm-Message-State: AOJu0Yxf75zYNrTMhJQNBz77BF6mI4P3I56xO8GrglNo02wfTuj4s5ty
	dEaGYnUtt4wZQJq9xBkrIrrkMxhbzMjIi4RTjCo9ug==
X-Google-Smtp-Source: AGHT+IH64hTzUfqokLkrmNt8XUgUbnYPQ5guBW2a+l70MLnxJeOCxxtEc/KpviRLotGVrRItTmgjhx1XKWmww9qpojI=
X-Received: by 2002:a25:7690:0:b0:dbc:ae1e:a987 with SMTP id
 r138-20020a257690000000b00dbcae1ea987mr583642ybc.129.1702312996550; Mon, 11
 Dec 2023 08:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206103702.3873743-6-surenb@google.com> <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk> <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk> <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <9d06d7c1-24ae-4495-803d-5aec28058e68@sirena.org.uk> <CAJuCfpGEbGQh=VZbXtuOnvB6yyVJFjJ9bhwc7BaoL4wr1XLAfQ@mail.gmail.com>
 <915d2f82-0bcd-4992-9261-81687ca16e9f@sirena.org.uk>
In-Reply-To: <915d2f82-0bcd-4992-9261-81687ca16e9f@sirena.org.uk>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Dec 2023 08:43:05 -0800
Message-ID: <CAJuCfpENZF3mMNuwVaff00hRnazTFbE4A5kaYuUiZCpuHr06Cw@mail.gmail.com>
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

On Mon, Dec 11, 2023 at 8:34=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Dec 11, 2023 at 08:29:06AM -0800, Suren Baghdasaryan wrote:
>
> > Just to rule out this possibility, linux-next was broken on Friday
> > (see https://lore.kernel.org/all/CAJuCfpFiEqRO4qkFZbUCmGZy-n_ucqgR5Neyv=
nwXqYh+RU4C6w@mail.gmail.com/).
> > I just checked and it's fixed now. Could you confirm that with the
> > latest linux-next you still see the issue?
>
> Yes, it looks like it's fixed today - thanks!  (The fix was getting
> masked by the ongoing KVM breakage.)

Very good. Thanks for confirming!

