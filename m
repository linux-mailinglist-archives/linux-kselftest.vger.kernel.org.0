Return-Path: <linux-kselftest+bounces-32826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B6FAB262D
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 May 2025 04:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE833B0A6A
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 May 2025 02:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F970145B25;
	Sun, 11 May 2025 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1IW0YD1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968FC8DC
	for <linux-kselftest@vger.kernel.org>; Sun, 11 May 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746929672; cv=none; b=e9cr9c03LzAEH0epbif2bOmRSvBYpt8kMzS2ciHBxcPVQcXYe3dHxtjTCCK4wsT9oFeeqe0I1CNu+qVpnXLAircRjv5vlpmud09lm6jWlDYx/d2bWOR80lyqHhGN3myypr0E2/PBET5TXcFR7OrmMAZWpespxXbG2orDrfISu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746929672; c=relaxed/simple;
	bh=ErdE1KVMfWPkKsMxBdbzTAnSvWDLWI4LLjWjznFIFAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Is7yoIyGvarogT+mTOfdpZArla+MG67YeTwrF/P01nhTfzGCSOadJLT9QaocM9jzPEGuLB1OXOxTb91x73zEpaZgl68XUyyFvmhmvTir802doOD7laxmTQuZpBf07sTUIU3EEghkwfJVNe96iAjLc9HyfRi/8TIppnrEgu6ulEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1IW0YD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA9BC4CEF9
	for <linux-kselftest@vger.kernel.org>; Sun, 11 May 2025 02:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746929672;
	bh=ErdE1KVMfWPkKsMxBdbzTAnSvWDLWI4LLjWjznFIFAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D1IW0YD1PWiJE7OexRFET8O5OoDdN/n+H+arvcGWRYzDPMBLnLwS7wBDNnB5yAxhL
	 ylfsP9uxJzMd0NTxXPAeXHqq1kycZyDThZpY7qV0bJNBtaByGa3Gi+w6CUcx4TvJ7Q
	 DN5kneaArqhcJFZ9EFuoR9zWEkxh2laX1LhLrZ5PTtbMKgWbdR5vO4pvI4rU0Cljeh
	 SoL6hb+EFl+I94+/CrjFVOzvQPhkXkl5ucRcMwjXldZ4a8UuCqNzktPwx7j3xeUKyl
	 96YqxHULEPy323MNYOsLGWDN0jh2e+XwlPuC93HfCvn4PTjDwQeLQ9yMvJcVAulu+4
	 7bUct8jdLE4fQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fcab0243b5so2887210a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 May 2025 19:14:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWd1sHvwp9bQbDyPiMQmLbFnz5eKZ4TIXwVHO6VKz21dKlf8LtrB033+PhnPlnin8zz72mbvM+aVOzdUKLcXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRBUcc2YIg3MG7+PrjLts3iiGZxPz+06/RkO7Ea9YO9EESsI6
	04WCTBlHyiRnMOYbgU74yk6kjLIvvnMwU156LsbahalChGf6LmqbbZrwN2T5aNif+6NOjGtEhuK
	wG1AshnKplTWg+BuIICKRYnytPdau4xg4mVD7
X-Google-Smtp-Source: AGHT+IExXmbIf+BhGVnj7doD3WnX7s+dvlTY3FdrciBuDVwzwOxxJvaT9GkVsNX9nEvSMBd0KFEz7jYxBN5tsLhkF2M=
X-Received: by 2002:a05:6402:2396:b0:5fc:a51a:9c03 with SMTP id
 4fb4d7f45d1cf-5fca51a9f9fmr4891240a12.0.1746929670732; Sat, 10 May 2025
 19:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <87o6w7ge3o.fsf@microsoft.com>
 <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com>
 <5dbc2a55a655f57a30be3ff7c6faa1d272e9b579.camel@HansenPartnership.com>
 <CAHC9VhSPLsi+GBtjJsQ8LUqPQW4aHtOL6gOqr9jfpR0i1izVZA@mail.gmail.com>
 <CAADnVQ+C2KNR1ryRtBGOZTNk961pF+30FnU9n3dt3QjaQu_N6Q@mail.gmail.com> <CAHC9VhRjKV4AbSgqb4J_-xhkWAp_VAcKDfLJ4GwhBNPOr+cvpg@mail.gmail.com>
In-Reply-To: <CAHC9VhRjKV4AbSgqb4J_-xhkWAp_VAcKDfLJ4GwhBNPOr+cvpg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sun, 11 May 2025 04:14:20 +0200
X-Gmail-Original-Message-ID: <CACYkzJ528JBKbhiw1HNfv1kDBYv_C76cFB8a_Wa6DSqZp5_XuA@mail.gmail.com>
X-Gm-Features: AX0GCFtRm2U2Z08Q-5iN5TPSVkChFMpfYbeWxPh5iWXOgSo5pdg9_y4ozgwfcPs
Message-ID: <CACYkzJ528JBKbhiw1HNfv1kDBYv_C76cFB8a_Wa6DSqZp5_XuA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, code@tyhicks.com, 
	Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	David Howells <dhowells@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>, 
	James Morris <jmorris@namei.org>, Jan Stancek <jstancek@redhat.com>, 
	Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas@fjasle.eu>, nkapron@google.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Shuah Khan <shuah@kernel.org>, Matteo Croce <teknoraver@meta.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, kysrinivasan@gmail.com
Content-Type: text/plain; charset="UTF-8"

[...]

> Blaise started this most recent effort by attempting to address the
> concerns brought up in previous efforts, you and others rejected this
> first attempt and directed Blaise towards a light skeleton and LSM
> based approach, which is where he is at with Hornet.  Once again, you
> reject this approach with minimal guidance on what would be
> acceptable, and our response is to ask for clarification on your
> preferred design.  We're not asking for a full working solution,
> simply a couple of paragraphs outlining the design with enough detail
> to put forward a working solution that isn't immediately NACK'd.
> We've made this request multiple times in the past, most recently this
> past weekend, where KP replied that he would be "happy" to share

Here's the proposed design:

https://lore.kernel.org/bpf/CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com/#t


> designs/code.  Unfortunately, since then all we've received from
> either you or KP since then has been effectively just a list of your
> objections on repeat; surely typing out a couple of paragraphs
> outlining a design would have been quicker, easier, and more
> constructive then your latest reply?

