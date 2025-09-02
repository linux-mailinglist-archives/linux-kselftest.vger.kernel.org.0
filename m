Return-Path: <linux-kselftest+bounces-40659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB0B40FF5
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 00:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236EA1A82D76
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 22:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E512765DC;
	Tue,  2 Sep 2025 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YZXeCm/7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486F275AE9
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851680; cv=none; b=BDVpxn2bvIhhkapQKu06z/j/57v6nKsonTnJP5+FrB5niC10I1ZsB7jRIFaAgcwPvrCCZ8fp3YtLv/45szrvhD7+SJOLGyap5ArErypDMnUdCWLzXHoEvkbkxMP33GoqZIN03vuJTtPEi2yy6UdBtZ2Gl7/FFRrvCRYL1zW4F0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851680; c=relaxed/simple;
	bh=uhrGdUwtX0TRrHmzp18ffizdjSUfmH13xn/mmFzf3K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scbQzWKQPdp7FfXsMNw3B6xhfagQPxcI/vM+8Ijdd2Mz3NlUk8vpIyd8bWSN8wfYoEMa6VSZ79muSyiDqBhmMSf16URZH06ggf2WF8ZzQCWYObukscLlCqFFdCMjmOkBPUqo9RK9cD5Nh435e0pMa6UcjTDrF4AYQ2V7L4zY31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YZXeCm/7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso2726468e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756851677; x=1757456477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhrGdUwtX0TRrHmzp18ffizdjSUfmH13xn/mmFzf3K0=;
        b=YZXeCm/7GBFRBljfCnajK0LOK+eFyDX8BLB+D9ZwyBVU55xyJcMli4pnmsUrRsloty
         +ZZGtCu3Y6cU/UpJOWsMDRssPDdMbAEQrnGixIZG6ApzEZfIhJVMJMv47pyAM6luug30
         QmpihjkjU80vv3XeIYuGlLUITmjutbOw34LBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851677; x=1757456477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhrGdUwtX0TRrHmzp18ffizdjSUfmH13xn/mmFzf3K0=;
        b=j7oUw8uT591J85XQcH/N6PUBPlCzW696BuJgf9HB02EkH3x/LOhqCN3tfMX30OwUCw
         Kd9DwtYqkaYr1/gcv1VRAtjjk5DxJ75gtb7NzVRBaxAe40XwYv3vrb2rjsje+bbPcjNu
         1hFtJhffgbJ6BTr6IuAgUgFbjfMTFIlgXFEZoE89lX3fbSGIxotz4hynN7U8m3Jh60Ps
         Ao+4QAIXSUxVJim4hPOz1GFm2KxmeEOAJSkBXheOngRmwAAarM2NOL6BU7dBDfGF6AbB
         X+xN+ZpVVi6hqLtjqvnPkKVQw9Pu56vVeAF0GOy2L1zxJDOty9d2DR2pyVpaFZSrH/f1
         SeCg==
X-Forwarded-Encrypted: i=1; AJvYcCVSA24Jdhb2Kzucnmd2OhSdxtFOmChsDWUN1Mte40U/Z4Lx09Iw3med1J1PW6P640wFrH9lsSoql+G28S90bE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOD4xtFt6NqjxBMDu0Q/FeAZguz92i5/OW4P23fwU9EC96j0a
	MTf9ecvdM+3KovwVajwzKQBCC3O996TGoGHk2+BkUbJXcGjU9/TCSqDdxj4ANqcl/YtUUFKzHDw
	O0l5AOzoLWvU3ae/CO/SpyTAEjS2wMveNC9JKoFOdbw==
X-Gm-Gg: ASbGnct5b37pWIF6jgRkQg56Dt7oGAVzKnUgv4uZrMHnCxCRVfXQRIPosJqA+jc4dK/
	GvPqvsCstMCP/o6HL6UmcDOAWRTKLK0cLQkgCBUh0uNkJV65+si60iApjMq7qtM8gYl+sX/44DS
	T48qpY4+9pQLLFJ82zc1N+FgfkHz6oeM5tVZ+k9JaqEojd5qFuIat/z2GOGqc+8x9Q6ayJViXZ8
	sZK/q752iiMqY0Lrbx5Uog0hqw8YPSUHPBqzoVN2exvFYCdUu/1bzI=
X-Google-Smtp-Source: AGHT+IFBza3hqagc0puDleD+Unkl9olkJ3klet94+JtsC9LdhtggFejId/AtdG7cn9nz3QYINpZRSm2wOlqELxCKl/Q=
X-Received: by 2002:a05:6512:1389:b0:55f:6fcc:6f4e with SMTP id
 2adb3069b0e04-55f7089c3a6mr4162223e87.7.1756851677166; Tue, 02 Sep 2025
 15:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
 <20250902072600.2a9be439@kernel.org> <834238b4-3549-4062-a29b-bf9c5aefa30f@kernel.org>
 <20250902082759.1e7813b8@kernel.org> <aLc2hyFAH9kxlNEg@arm.com>
 <d4205818-e283-4862-946d-4e51bf180158@kernel.org> <aLdfOrQ4O4rnD5M9@arm.com> <739c86b1-5cf5-4525-919f-1ca13683b77f@kernel.org>
In-Reply-To: <739c86b1-5cf5-4525-919f-1ca13683b77f@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 2 Sep 2025 15:21:06 -0700
X-Gm-Features: Ac12FXxOi9AsViKZtjtWxiVRlAl5eHnNmsfESqGUjGTMg6KF47joBlOhH8IUoMY
Message-ID: <CADg4-L-5f3a=3XCv5UaZG+47DHaO3NTk5+4mp-nWJ2rFXx-5WQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Gang Yan <yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:38=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> 2 Sept 2025 23:18:56 Catalin Marinas <catalin.marinas@arm.com>:
>
> > On Tue, Sep 02, 2025 at 08:50:19PM +0200, Matthieu Baerts wrote:
> >> Hi Catalin,
> >>
> >> 2 Sept 2025 20:25:19 Catalin Marinas <catalin.marinas@arm.com>:
> >>
> >>> On Tue, Sep 02, 2025 at 08:27:59AM -0700, Jakub Kicinski wrote:
> >>>> On Tue, 2 Sep 2025 16:51:47 +0200 Matthieu Baerts wrote:
> >>>>> It is unclear why a second scan is needed and only the second one c=
aught
> >>>>> something. Was it the same with the strange issues you mentioned in
> >>>>> driver tests? Do you think I should re-add the second scan + cat?
> >>>>
> >>>> Not sure, cc: Catalin, from experience it seems like second scan oft=
en
> >>>> surfaces issues the first scan missed.
> >>>
> >>> It's some of the kmemleak heuristics to reduce false positives. It do=
es
> >>> a checksum of the object during scanning and only reports a leak if t=
he
> >>> checksum is the same in two consecutive scans.
> >>
> >> Thank you for the explanation!
> >>
> >> Does that mean a scan should be triggered at the end of the tests,
> >> then wait 5 second for the grace period, then trigger another scan
> >> and check the results?
> >>
> >> Or wait 5 seconds, then trigger two consecutive scans?
> >
> > The 5 seconds is the minimum age of an object before it gets reported a=
s
> > a leak. It's not related to the scanning process. So you could do two
> > scans in succession and wait 5 seconds before checking for leaks.
> >
> > However, I'd go with the first option - do a scan, wait 5 seconds and d=
o
> > another. That's mostly because at the end of the scan kmemleak prints i=
f
> > it found new unreferenced objects. It might not print the message if a
> > leaked object is younger than 5 seconds. In practice, though, the scan
> > may take longer, depending on how loaded your system is.
> >
> > The second option works as well but waiting between them has a better
> > chance of removing false positives if, say, some objects are moved
> > between lists and two consecutive scans do not detect the list_head
> > change (and update the object's checksum).
>
> Thank you for this very nice reply, that's very clear!
>
> I will then adapt our CI having CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF
> to do a manual scan at the very end, wait 5 seconds and do another.

FWIW - I am able to pretty reliably reproduce the kmemleak. However, I
also tried adding an inline kmemleak scan to the test harness (did it
once with, once without a sleep). When I do that the kmemleak
disappears :-)

(not saying that adding the scan isn't useful, just pointing out that
this particular leak seems to be related to how quickly we iterate
over the testcases)


Christoph

