Return-Path: <linux-kselftest+bounces-41987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A2B8C07E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 08:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD81C041B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 06:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8DF2367B0;
	Sat, 20 Sep 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR3NkpNt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF922836C
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Sep 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758348634; cv=none; b=FL/9cI33rIS51NYRbEqatlP8O/cbEZ+IhxhS50eMaXtz+ELo2eSFzHi/W5jtuEudw+oQnlWnomuhZUnYyq212uVWpPFBu1ODO6uvp1G6vzj/0m6OxVS1DDTl+ztQT55Z42To2dOrum13vJsRFaBEPeN4IrS6lCmUeMcgTJOCtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758348634; c=relaxed/simple;
	bh=bo2Ndb5QdjF0C5RExvUQJNNOB01lRnxcWM4euD7xwfM=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=PBxvSc5RZXprr7q+xQpTwmColXd4rNKkBchPLqcNLnpNXh1vwpQz4cEtHoFEU/VPyeER+F74YSDQXW++fZ7OWG03Mf/rsUyc7HD28Lzst5X9ymeKf9fJz0sSZLffzxs94g+RyXiAzxaENpxInlLVlMaTFEIrQE/rk4V2NnisXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR3NkpNt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so3227037a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 23:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758348631; x=1758953431; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hou6AJPM8wejR725iDsnasOHuRSCpfZoVQThJpW/xQI=;
        b=IR3NkpNtQB/0tFFNV7IqLAhjTEeFp4qIW9P/R3awtnebNRXrYR8+hPv0S6wByiRld9
         GwgokRdQbDlHGKnmqmPLeEHe5hKx6lX9axiuiBooVxUUOjg28jwZPkFK4tD6TagCBNgs
         AwbTRsLGauWgz1X+vcRDEfTtpkYaOav8t6cBv/biEqdFb2cpub0JRPe46AwtREeRpBU3
         RlZAMBHiBgYfFzmg/xDjdaZHvEAqwr4ds3cIBM0nk5HrAkUssSdgkE1WOVbcODKRlr2G
         JIbWWjBttrMcyJDGdldhqy8wi7IHArKIPHXvZ1NNEr0UT+TCRNjT0AMmq1+BfpUEJ2/j
         /SLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758348631; x=1758953431;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hou6AJPM8wejR725iDsnasOHuRSCpfZoVQThJpW/xQI=;
        b=TaupKhIr1T0kUW7OBogtkbCwjIcNUG9N1C+ggs2rhTEdRE65HtjpLElSe1lRJ+qHOc
         eUs7PLSXKqvxqqWd4OEWABvKr09OE6FAXi7Dt5KKDuCssuEG+zLkExsXaA2JFd21Hlb2
         5r0rk/MJario+YjywCFLaV2JXNKZINPphSxjuyWYwLl97czPuyrbZu0QEqtNMIiXSWxf
         44HuKeZgxCtnZQDpQ8oBbw4fHHoxZ+53oHVKiU/RSTHoQ9KPkX4XYnEWWP4jOo7VSNXO
         3yXQQAZZIUr9CWtWUUigC9GOQ36mHvheiVkENfiPS6lm8lAh+LMmaWjvHs133IAvdoJW
         d8og==
X-Forwarded-Encrypted: i=1; AJvYcCUPs7xXhg6Y0JqgG2FXPyMx6tA/kMVx7y0wxh73ClNUClznCy1yvyQjqivbZKFPnEnwId8Ohh/tqzwiel/A5Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybCwRhX50/YlTJVt4ToeKNV/eH0pjClg2x7s4Iv3tCUx7a7Vcc
	DBdlGp//dABp2n+sCuTQO9rBSAylpPg+L2F9226NkVOWKspHNmxRYpYY
X-Gm-Gg: ASbGncvNUbS2sHjtDUgTlMzFvf+mobm33mc6gTq3vdqsrg++ghwwBMTODfJs1KJsXY2
	kFtpMVbTv6e6VOGiV6sxIpKzFT9GJtWn+a1yDnRmIfwZImG8ovHoSlpCu/xY6aDhnq9jbO7vRq0
	sUAHYYU/2DeeIAxpMw+kl64SiPJwxfQ5/2S1YdxX3vEoE6JooGqg/TihVgHOBKHCN8+ZsTUOaNg
	l5tOCoOJacTt1l8k8oxoe5cQ3auM9WN73N/l19bIDRpab4m4Lfp9Vcol0TDnd4v71HRhIrLXKrn
	6eyMJZlKoji+rxVrs/2+dCd+N6vC7kwLFx2vj0rtA88rzQwMZrcMCj5QTIMOpubvboC4xl4u1cS
	UdWOOgCKdT+97
X-Google-Smtp-Source: AGHT+IH2YsbIL9bmM2wkE8sVKgdbADyeo6xeBPeiRV0b4d2jfA5VE26z/kBsRCKoBlEJw3bJUDuezg==
X-Received: by 2002:a17:90b:52d0:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-33097ffd1b2mr8090816a91.15.1758348630860;
        Fri, 19 Sep 2025 23:10:30 -0700 (PDT)
Received: from 1337 ([136.159.213.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5531d90d1asm1179569a12.18.2025.09.19.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 23:10:30 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org,
 skhan@linuxfoundation.org, keescook@chromium.org,
 akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
 dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, jannh@google.com, linux-hardening@vger.kernel.org,
 linux-security-module@vger.kernel.org, kernel test robot <lkp@intel.com>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BC?=
 =?utf-8?Q?nther?= Noack <gnoack@google.com>, Fan
 Wu <wufan@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
Date: Fri, 19 Sep 2025 23:54:06 -0600
References: <20221209160453.3246150-1-jeffxu@google.com>
 <20221209160453.3246150-7-jeffxu@google.com>
 <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
 <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
 <CAHC9VhQKsjiGv3Af0iqg_TLNzCvdTaLnhw+BRTF9OEtJg1hX7g@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 30.2
In-reply-to: <CAHC9VhQKsjiGv3Af0iqg_TLNzCvdTaLnhw+BRTF9OEtJg1hX7g@mail.gmail.com>
Message-ID: <87o6r5ac2z.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Paul Moore <paul@paul-moore.com> writes:

> On Tue, Dec 13, 2022 at 10:00 AM Jeff Xu <jeffxu@google.com> wrote:
>> On Fri, Dec 9, 2022 at 10:29 AM Paul Moore <paul@paul-moore.com> wrote:
>> > On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
>> > >
>> > > From: Jeff Xu <jeffxu@google.com>
>> > >
>> > > The new security_memfd_create allows lsm to check flags of
>> > > memfd_create.
>> > >
>> > > The security by default system (such as chromeos) can use this
>> > > to implement system wide lsm to allow only non-executable memfd
>> > > being created.
>> > >
>> > > Signed-off-by: Jeff Xu <jeffxu@google.com>
>> > > Reported-by: kernel test robot <lkp@intel.com>
>> > > =E2=80=94
>> > >  include/linux/lsm_hook_defs.h | 1 +
>> > >  include/linux/lsm_hooks.h     | 4 ++++
>> > >  include/linux/security.h      | 6 ++++++
>> > >  mm/memfd.c                    | 5 +++++
>> > >  security/security.c           | 5 +++++
>> > >  5 files changed, 21 insertions(+)
>> >
>> > We typically require at least one in-tree LSM implementation to
>> > accompany a new LSM hook.  Beyond simply providing proof that the hook
>> > has value, it helps provide a functional example both for reviewers as
>> > well as future LSM implementations.  Also, while the BPF LSM is
>> > definitely =E2=80=9Cin-tree=E2=80=9D, its nature is such that the actu=
al
>> > implementation lives out-of-tree; something like SELinux, AppArmor,
>> > Smack, etc. are much more desirable from an in-tree example
>> > perspective.
>>
>> Thanks for the comments.
>> Would that be OK if I add a new LSM in the kernel  to block executable
>> memfd creation ?
>
> If you would be proposing the LSM only to meet the requirement of
> providing an in-tree LSM example, no that would definitely *not* be
> okay.
>
> Proposing a new LSM involves documenting a meaningful security model,
> implementing it, developing tests, going through a (likely multi-step)
> review process, and finally accepting the long term maintenance
> responsibilities of this new LSM.  If you are proposing a new LSM
> because you feel the current LSMs do not provide a security model
> which meets your needs, then yes, proposing a new LSM might be a good
> idea.  However, if you are proposing a new LSM because you don=E2=80=99t =
want
> to learn how to add a new hook to an existing LSM, then I suspect you
> are misguided/misinformed with the amount of work involved in
> submitting a new LSM.
>
>> Alternatively,  it might be possible to add this into SELinux or
>> landlock, it will be a larger change.
>
> It will be a much smaller change than submitting a new LSM, and it
> would have infinitely more value to the community than a throw-away
> LSM where the only use-case is getting your code merged upstream.

Hi Paul/everyone!

I am not sure what is the latest here. But it seems both landlock[1] and
IPE[2] have a use case for memfd_create(2) LSM hook.

I would be happy to work on the use case for such a hook for landlock.

CC=E2=80=99ing maintainers for both LSMs.

-Abhinav

[1] - <https://lore.kernel.org/all/20250719-memfd-exec-v1-0-0ef7feba5821@gm=
ail.com/>
[2] - <https://lore.kernel.org/linux-security-module/20250129203932.22165-1=
-wufan@kernel.org/>

--=-=-=--

