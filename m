Return-Path: <linux-kselftest+bounces-36052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D992AEC78E
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D455C1BC2BE6
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3F324888A;
	Sat, 28 Jun 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSXY2xzJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6287245006;
	Sat, 28 Jun 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751120103; cv=none; b=hnXvP3BkmJGTir3ACgaTDPpLRy5xmxHNZ5VtRPFUHHDnjUoHzHzvYDUo2sibBtcsZNkaj/NEWBtQ5h8plItB8n2yim1nLiKTNR78exVDIUQIrVhb1WoxG0H5F4anAFcMW4/kjMvAAs+QbDcLsfOzUbUTtsHQJUiPjF7CvrY3wkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751120103; c=relaxed/simple;
	bh=Ig5METp6TLlVulWx3CtXwo+PGIrd2VeWcYuzRua1aaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeRFb+tLNkxupHDwN7aWqnjtKoTfyIjxQul44Q5pFZWQMn2jNrh1HxpfblZ+wawf1g1BJDuATHx40ynh9mqBxyzpEplXEUoxMdNHBecgGARqxmBsX0xgpL6NKZI5XfO9DVwRfa8eE2VK7Ioz20i2xtBg401ToFCXA8V7B2Pl4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSXY2xzJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234a45e69c8so2554535ad.2;
        Sat, 28 Jun 2025 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751120101; x=1751724901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig5METp6TLlVulWx3CtXwo+PGIrd2VeWcYuzRua1aaY=;
        b=nSXY2xzJCF4FPTmtbL4n6PpQFEWk0CEYuK5CzPWzLIU9RXQBSo1amS3a4udbPup8pm
         eRTqg8TefzSWkiP6A5GhikiXw0dQL6tUAZEYrrTMzeIlKxjmf2Tj26o1+OHvraLoThjo
         l6M7j3/qz+P52W+Ym1RqYOxYQiWRI+hvlnq4NMnaWLXWVZFVhffpuJSrEfiWSEXS/F4t
         xCBPxNfxrCb8oxv6xss9Ta9j+5LdOQ5ABENTirBXl7pJUXCappYqbOEbvaPgzP5sqI1E
         N6E7bvfDsrUdi1vwaJ8zQhcjo1It3HMM+9NBqnaqc3B1Ae6uzwJ6NhofP3FRrxw/Bctg
         o+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751120101; x=1751724901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ig5METp6TLlVulWx3CtXwo+PGIrd2VeWcYuzRua1aaY=;
        b=Fdb8h+bwuH4dIUcw1wIvk+dRk4MPWBFgTApSaquYiqtDOXPHkMbRn68f6YLvUPM/Lb
         1ELgw/mk5rW/HO4t+dc/FxV1oAzGkI7PTW43hDCtYcuBBiweOetyh8f017rzgG/wqyMD
         bTmRGrUJKsGRLwXds3Ux8G9WRiIPlPUbk+JuE9jBHnVQbVqtd4ChiN6Dj0ZuxKndx5iA
         Cc70zE4R6z7ENU9aRoNx6E5xZy8OeRyQZy1UjeWkkZrQPGAHR6tOZt9WcWK1wTvYKejd
         ceEWo31gRKkOuLeBpWysOW/BFFARPx9I2OqVOL0JCiqWKi8RPXqUZpr6BR/61RZweUqh
         gaTg==
X-Forwarded-Encrypted: i=1; AJvYcCVF+smaci3L8RlqhiffzkzQ8oGscJydN3jdqPZVo/Qx/WR24jaz1QytS4GjVavc7jt/M4ahRqlBgBxzVvIRvkjA@vger.kernel.org, AJvYcCVNziealHrXwgOSB454lU9ZtwyuOr2V0jtgctJaoRG1Gg1NcH7iboHcfdUAqBylYx6FhSkQ4S1wlOpyRCpTF58=@vger.kernel.org, AJvYcCWIl+xwZILcXDw5A70kxysTMDE3/ZzCBiDwgliXS4kwmSvZpGkM2qH+fUiaM2ARCucuxoK0BTwMIXwHm9E=@vger.kernel.org, AJvYcCWu6hDio765OMtMQPED2gaaBeoymLMYxnAayGmkBT6GxW9xk4/hfE9uh6sGt5y225JqvO0Rulpv/Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLqm0Jj4weXIgxcqBHE1rKzdsNUBT8hr08I+nr5A6cpOEQbKS
	kriHwEuCXNEQgvYerBO/Sgy5dwj8KHP/m9KUXR2ka3+3MKgHNuB6Bv07SCOe6vZND7TrFyCYVV7
	2kEVlc1woMW3KlvRnP4IBwsSlvM+NcFE=
X-Gm-Gg: ASbGncuhc0Zs2/JZYZw8hNfeeSyZnGBp9eKtmH8+jOnX/9UNjs6s+ZOp+iRNgrqWcJa
	HX+GGH7IPByiMvgxRNAiMlWmx7B6WK0+stSO7nPkaJgabeQ9cAYi8G5qSs4tVyxzmkitdIPc8Kv
	RKY26TH+QVRDP2oPmPzVRYIZu38sxIapOgs+bsq/fQ2ps=
X-Google-Smtp-Source: AGHT+IEeO+2x4VJdgjbtK/gaI11KSmV/Kxyz5u7U5iNwi1yHjJ8OK31D1ZkQM3+AggaPiGZLAw7Rr4YtZsOk0T6d48A=
X-Received: by 2002:a17:902:e84e:b0:231:c9bb:6105 with SMTP id
 d9443c01a7336-23ae92220e3mr16180895ad.0.1751120100996; Sat, 28 Jun 2025
 07:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628040956.2181-1-work@onurozkan.dev> <20250628040956.2181-4-work@onurozkan.dev>
 <CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
 <20250628133013.703461c8@nimda.home> <CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
 <20250628154237.0f367cee@nimda.home> <CANiq72mxJM-7WAP8xVDukmiXq=ntThyFESFLs1+dmZJSS2q60Q@mail.gmail.com>
 <20250628161117.7786b3a4@nimda.home> <CANiq72kgB6gQ3+etQOYLLDqWt4EQhiDfN3dcwHBOpZh9USt3iA@mail.gmail.com>
 <20250628164235.1376ab5f@nimda.home>
In-Reply-To: <20250628164235.1376ab5f@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Jun 2025 16:14:48 +0200
X-Gm-Features: Ac12FXzI6pvWYheMTVSFPNn1sp8egQG7kNlGhWGI4BCR4Pl6Atn6Fc3iffJxg6M
Message-ID: <CANiq72kJbyMmRqhdgqFsNyYb_eJFNZQXy4k7bkRNw0-kZURaHg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
To: Onur <work@onurozkan.dev>
Cc: viresh.kumar@linaro.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, rafael@kernel.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 3:42=E2=80=AFPM Onur <work@onurozkan.dev> wrote:
>
> I don't have enough time to do it right now, but I would be happy
> to do it in ~3 days during the week (assuming it's still not being
> reviewed by the maintainers by then).

No worries, there is no rush on these cleanups. Even if it gets
reviewed, you can still split, keeping their tag. Thanks!

Cheers,
Miguel

