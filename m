Return-Path: <linux-kselftest+bounces-12487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2FC9130F4
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245BA1F2295C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 23:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1416F85F;
	Fri, 21 Jun 2024 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJYmpbzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FD16E86A
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014039; cv=none; b=QcjD3PrQT4ZmwSI6789yPXfWh8ftPp7W1tTm6DTa3T09FUPy+NgPOAcdLmAGCYeevTR9AeTmwZUHa3rq9tthu01o94ANQb9/d+8swOUE2SEIuxkHAQUijjKakE9J+i6Z1Ep/H8MOqCHoDvf0jikx2Jc6QS6gSuHewoLHzOMNhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014039; c=relaxed/simple;
	bh=Wv9IJwfLBg9/0U/JTkEwyP7N8Hf4US/FVyAw3Wa/a8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBsHSjZZPlb/3Phm8m8Sxfi6IKZy87h5+06CaBvLPLb759wm/F6AiOlpEXysCak1/1QSROmiiZSkOkzUFlULmR22zxJGNIKXqIYjI4S+YzDOUqaa9jGMCVapRWF6C6SbeQXkL42wvw9eu+UySO6umyiszlgcQtgNo2FmSLw1PaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJYmpbzy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso29276585e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 16:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719014036; x=1719618836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6xesaMacZace3FQ+zqQcgYnav9DuFBRmm+vK92q3yQ=;
        b=WJYmpbzy4IRekytBtjX3ihMxhT3jZar4sCQ0kEOmlPxeGbCyMRHc7++B2AGXeJPnBh
         mRH1JOBblasOf+kAdeR9qIoFX/nei2iE15r/kHvfrh7Z6cJhUui5xEkXUQZ8bBDj2NwL
         98klbN3clmkT2SP7jLS7h/u1YsgmNz0bRXsCht6XMmjbgRL9djK1PWNtmB5yoq5iN1ys
         wdF88PdxCP6v4WkudH7WMKIlhu6M8W3WImCUBe/EIt6hQ+lyp4q6StXUM0cn+RvPBSxW
         WPuwy5x20U3nvAdDOBKjcWk5mjQRQ6dl9p5hGlX0bO6wDR6lbEKDcLPotdBRgEHOMy3i
         kx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719014036; x=1719618836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6xesaMacZace3FQ+zqQcgYnav9DuFBRmm+vK92q3yQ=;
        b=jJcf44HS/4xrxqudIAFpy2eckjZIiLoyNFP7a3Ywb3bCAmT7NvDLzdy3BxO3DHXSGF
         uvFRvf7Yb5bBifdqQ9bBzE6CxWumtJkk1DTsXmyQ+A454ZX4hmQ2veGIE7FKJyC+WFmg
         sVkNqgXrlqDVWAseojDqqqR60T+Ei99XrCqPVOKT4aLhHf72TjvuN2lXxF3psvwxcKxU
         9ywHkRADVekZgsWWIi/SNxHZx8bv6pH93XFHB8GJjhN5aQomnTL4ss3vMYZ2SSycojqz
         rdhL55zwv++cjrVeb70V6JwAtVjR7FdKMgpXS8l7Qx+J6kTo3xMpgFzHQ+ouZ4H92yXQ
         5I6A==
X-Forwarded-Encrypted: i=1; AJvYcCWfx8PdWCTwIqrByyz5wLNb386v5R3BX068Rie2Z/O7SIHBe1fsSlbENMyvygmIot1AKz852FF65B756NqBRFSIZy1/tlSFQlizvViKnCmS
X-Gm-Message-State: AOJu0YycXuGm8ZlBjCur+X5Y+R5S0nliuqzKAxtFv6LYs029XbVcahPL
	i8ZBEFY4olgqvou5BVNoWoS4Pw7gpgXoeNQxQ/xQQdCEmrRin8yLg3kvemTUcjV+xXZQpRKC80e
	eB5iEmUxvoTD2jHZwYJhcmfE3y5IG1m36CqGR
X-Google-Smtp-Source: AGHT+IEbWjWelzpZFY63Cou53ZgSpdbbIsCKPdXNcVkLJoDwJ5in2IsqHIXIjhgjpWdIZEdefuzVToe3fpWD1sP9vtQ=
X-Received: by 2002:a05:600c:4f4e:b0:424:80c8:dc08 with SMTP id
 5b1f17b1804b1-42480c8dda6mr38434615e9.12.1719014035702; Fri, 21 Jun 2024
 16:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620184856.600717-1-jiaqiyan@google.com> <87msnfusyw.fsf@linux.intel.com>
In-Reply-To: <87msnfusyw.fsf@linux.intel.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 21 Jun 2024 16:53:41 -0700
Message-ID: <CACw3F51QadqESg2a8Lb_A+PCH7TH0W8BqwNKCyOX4nyeeP1wAw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Userspace controls soft-offline pages
To: Andi Kleen <ak@linux.intel.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	osalvador@suse.de, muchun.song@linux.dev, akpm@linux-foundation.org, 
	shuah@kernel.org, corbet@lwn.net, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your comment, Andi.

On Thu, Jun 20, 2024 at 3:53=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> Jiaqi Yan <jiaqiyan@google.com> writes:
>
> > Correctable memory errors are very common on servers with large
> > amount of memory, and are corrected by ECC, but with two
> > pain points to users:
> > 1. Correction usually happens on the fly and adds latency overhead
> > 2. Not-fully-proved theory states excessive correctable memory
> >    errors can develop into uncorrectable memory error.
>
> This patchkit is amusing (or maybe sad) because it basically tries to
> reconstruct the original soft offline design using a user space daemon
> instead of doing policy badly in the kernel.

Some clarifications. I don't intend to reconstruct. I think this
patchset can also be treated as "patch some missing places so that
kernel doesn't soft offline behind the back of userspace daemon".
I agree with you (IIUC) that the policy for corrected memory errors
should exist in userspace. But the situation is that some behaviors in
the kernel don't respect that (they either have a reason to not
respect, or just forget to respect). enable_soft_offline is basically
the big button in userspace to block these kernel violators.

>
> You can still have it by enabling CONFIG_X86_MCELOG_LEGACY and
> use http://www.mcelog.org or an equivalent daemon of your chosing
> that listens to /dev/mcelog.

If I didn't miss anything important in
https://github.com/andikleen/mcelog and
arch/x86/kernel/cpu/mce/dev-mcelog.c, I don't think /dev/mcelog works
on ARM platforms where CPER is used to convey hw errors from platform
to OS.

In addition, again taking an ARM platform as an example, I don't think
any userspace daemon has the way to stop the GHES driver from soft
offlining memory pages:
https://github.com/torvalds/linux/blob/master/drivers/acpi/apei/ghes.c#L521=
.
But of course it is not a problem if userspace always wants soft
offline to happen.

>
> -Andi
>
>

