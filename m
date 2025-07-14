Return-Path: <linux-kselftest+bounces-37273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6154B0455B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 18:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74AA1A641B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243B25F98A;
	Mon, 14 Jul 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLleniQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684C1DE4E1;
	Mon, 14 Jul 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509867; cv=none; b=I3lcA0h9WbFpmZFnK9R5oF1ej+yTXQxWhPg7mxQ6m4on2/FhQtZNMVT47wccqM5gPbWdVDUPsCqykniT00IbZ4D1BbnG+UG78qtDiG+ja+WmmBgojkIhJ3NViCnlEAznNczrf8M8ywaOwcCSEGTisxgycW99rN73SxqrmyCQKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509867; c=relaxed/simple;
	bh=VgOAVJdh0mPlo3j6MglPtse4vJgYOB+5e63dn1DdYVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2jdsAB0u9WZrC0kJJgKK86LvAVjbr7rpjqbT7IoDAn2I3Hw9B2KQiG49gQN0jWJqSZXXYvgbysXgbbwFz01elqGTaPGTSEXbEPb3A9JNwvbPmmFMVep+7CDQNswVkbqgkGlrJaQiDAdTyts6pCtijJtJTo72zwYSC127+dPbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLleniQE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31308f52248so823014a91.2;
        Mon, 14 Jul 2025 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752509865; x=1753114665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgOAVJdh0mPlo3j6MglPtse4vJgYOB+5e63dn1DdYVk=;
        b=JLleniQEBR7+nZ/QjyiFh8UAatyPt4jHT8XulgW/OF3SMLAZZi9ADOjcuBj0aTPw0g
         uQNH5kwgqHg20YZg60CHZP8KG2+IapyQAW3aTNOjYyJDamotyB0ZDQFr5iAs9wQmm9Xx
         eJYV2nhp75wUqy87rIQBBhJQa6FMzh/7YhaRRTxce5Dhl3kgXbM3vqV4f7zR1BB5SYnL
         q7oovtM3y4PAMffeiSux8esRQYJEzoRWmO66Kh9BxTkCCTy69oOg6VBVh5azCk+leCqC
         DYotJ7hxXb09U1EMifjfvy1bMlqGDsU9WV0CqhKs4iK/X3CExbucDy0dCYL9P3Xi4Ps+
         9iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509865; x=1753114665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgOAVJdh0mPlo3j6MglPtse4vJgYOB+5e63dn1DdYVk=;
        b=w2MphnyYJqpoJVIFMX6P5kua66ixysn+rWbufYu8uI8HEItAAf4lFUexeBl05/erQo
         pVLK35dSEg8PBHncvEWTuvvGnzm66UEZGZJ3uMZ1guo4JVYr67fcoWQi5gEoBZi05jJh
         QKiTdccHYGmrrA+xiHA06/urXl/gKp4tkvhEAzQFtsgN9iVzT7cTDMqKpeX+7pvHcVY6
         xeA/P7pavM5BGX5CIO72u20JJo94GvBEiPpDxgaCdIWBYwRXb7loAE/0KBgBKaJwt1xu
         P1B7ZKH/SHTAyhIaDhflF3dxd7FYEHVYu4PAvXF/Cm00TULIa4FA6tzn/95O4njMnpTL
         AzOA==
X-Forwarded-Encrypted: i=1; AJvYcCUErB3AJUM1xATCrVdVp/OrBjpaZ/jIG0pY8n+WcPjlZPYHrTSVL1i0UKU/AqEQRq4BwLLY7DV7w72yUkin@vger.kernel.org, AJvYcCUVOYcmX5jjSlnSckjYpsCcKhVLjeEPXoutHq8fkI8d9UvgrGdmM9d6wL4z9ea5/tuAqbivH1jKxscKcUuiqts=@vger.kernel.org, AJvYcCV+GgalBdmh33P7C05fpWwWRDZKuWE360I3FUy3UoNe1eZt6iY0TW8P4v3dmlp7Kk+9P5KEFum40we6@vger.kernel.org, AJvYcCVuQAA/Zb0SUViYTm1Nk8HWcFDNJ0x1tt6jT92QpOr96twJeOY7D1WoTHM2ggxwTJF606dOViNTSCM2SXianRyP@vger.kernel.org, AJvYcCWMnDm9KWaoijN+srPg/PWNsFnywLmtjY/NYYuXlJHldXeXOQW5R8kfq5RmqB6vTXYLnyI9LJ23V2Q=@vger.kernel.org, AJvYcCXhIFCyPh1BQiUvjFg+O45IkB2ttCv4Q8s+dUAat7gxppD/seTnehwZ8gM+ZUF9BSfQKV1Y+doa@vger.kernel.org
X-Gm-Message-State: AOJu0YzIImNOPzTSQVQhUthALhdlWTuKp7Z+C2cmalJ+UMg/SI4vkU+u
	ZyMvbBRVtClVqYZOiD6+VtPHKuI+KrfiwoKsDgLx42mex/M8oc7mkckgk0T3NHBWlxYTDIF4zO/
	ArNHWCzCpwv9BIeyU3xiiOgwKCc7WuXw=
X-Gm-Gg: ASbGncuTjwTSSev6myW3rZfAQuoxz8ek14JtxzXaetQwaW85jYTpcc/Ku2OCjBFOSkK
	Y/jPrhWJd09UJPAAkZV1FDVtZ0kTdx2/c+0Fy9S3XBeZ073yhO3CJ+gr6J90gFfSVETSKkPzPjF
	Tlnqwkjy6lEWs3yXc0rSJd+S5DTF+TTtx5T/YD5F+zQIEGU45oDi1Z0Ya6FWCTN2T5dZrU16Ufs
	oHP6l3o
X-Google-Smtp-Source: AGHT+IGRQOu48QZ3mSOJsBHbjURxIkyxYFERFZsWKzgGSlimLJJQz2LvTrTHmfQM/LmM3Tkm9Qh/bL9/Pra9XmQbDxI=
X-Received: by 2002:a17:90b:2541:b0:313:14b5:2521 with SMTP id
 98e67ed59e1d1-31c4cd0e25dmr8267765a91.5.1752509865051; Mon, 14 Jul 2025
 09:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
 <20250709-core-cstr-fanout-1-v1-1-fd793b3e58a2@gmail.com> <DBBQE3GJ0CHT.5PEF7RLS6C33@kernel.org>
 <CAJ-ks9=ZHtzeyyFSZaVuA1t-3C8-hc40n6r8qFWxn628qT-OeA@mail.gmail.com>
 <CANiq72kyQQMutGDkHH=McRQens+V+wkHLpiSfivmnAwwgXE62w@mail.gmail.com> <CAJ-ks9kzrihJ7Jb8kAp0LpbPCfdouDQdFK06AHN3xi9pXNWZ9w@mail.gmail.com>
In-Reply-To: <CAJ-ks9kzrihJ7Jb8kAp0LpbPCfdouDQdFK06AHN3xi9pXNWZ9w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Jul 2025 18:17:31 +0200
X-Gm-Features: Ac12FXx-lgQiOZYDq083Q8BlSadihlGOqb-DL3tgO7LiWlt3h_pXYA1OcdWdN3A
Message-ID: <CANiq72mgKqm+Dq98R6Tf99GWPE-n7vKOzKSTiYQR6UdddEboEA@mail.gmail.com>
Subject: Re: [PATCH 01/10] gpu: nova-core: use `core::ffi::CStr` method names
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 5:28=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Yep, that's what I was going to do - but do I resend the whole series,
> or somehow just this patch?

Whole series is simpler, I think.

Cheers,
Miguel

