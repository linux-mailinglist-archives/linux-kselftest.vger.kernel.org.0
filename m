Return-Path: <linux-kselftest+bounces-23037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD99E96BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E7D2827D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004C1B041D;
	Mon,  9 Dec 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsNFzrCe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4B1BEF74;
	Mon,  9 Dec 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750776; cv=none; b=idgFhHdW8PAdvBKLZxLX9xVm+rCJdnGyzcWy0enIu9g8NkYQmJ35BZs+htnpTBBFb3bWgCusqB4/JcjP73NIIvGC6Cx9b7aHa1apOLIaNJMxS5QeRZIxxbi5Tbh8fJNRXqslJo3L7rYBDsQnorm2DmvR8aX0YTPngWXJKG1Eh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750776; c=relaxed/simple;
	bh=yqonEcOidFc7YhlSBectpsfSVk5g1I/jJ1loMh5DY3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/WmLClyY3vB11U5XCbLZ83Te32c/SlUkLWUzg3NIhpzvNIKMyvCMeWKsPXDoMRIVCNxt6RhbYX5isfol2Lt2KgKVWQE7NGRe9JgJia4Josp9SddE7N60kBMsEhu+RaCVIYi/TM6wy7afHscarrVSiQNrj2f2uyFUwAdX7ag9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsNFzrCe; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso1532037a12.2;
        Mon, 09 Dec 2024 05:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733750773; x=1734355573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8VP5kOfhoVqus7WQGQY41hMa5PPCwbCqnVQwI5Y/M0=;
        b=AsNFzrCe2hfIHwTl7PN4dUmMqHsgm3Se5xpTTl1sqOZNackaUzyDgHHAKK5R+0WTqk
         H7mpxLYdYPyxuefs+i0wzy/WamHTH1oum0KafqyPRBPEV9bTLWMB2t9TNNiWjLti9DSv
         lL5QSL9YjBZVAzLayXGlGq48ZnDSWEiZkG3jd9R5ZtQAKBnLzKgA7uwyoMSMRkzJXpot
         D7m7fCYVtJiGSQpnE4p1fSLitKy6yhy8y+zNluZ7efU8So44XoUa2hT89VQebD9bmEUN
         hjGftvmHG/c7tFeem76bLgsfKs+RFcnf0zf9CU+CjvGPqSN01I/1Azw4nA8c+8Q3Ar2X
         tU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733750773; x=1734355573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8VP5kOfhoVqus7WQGQY41hMa5PPCwbCqnVQwI5Y/M0=;
        b=oBCRnAAyyw/w3o0tJYSHeqcrKHIV/o7PtqlnLj+QLFEYQeKUplLAY0xaNZLX7Jq9o2
         V8dtJZP3m5tEvAyNaCQZ+r53wlJjXhRaQPySzXprlya3aq0+vQ/aYAlRAB6X2jiqumcl
         R4uEWAE/DmT4yh4iF9/cWOFQZNAUdhECUdPkqTrYHSDFJdTZPgKP15tklc0yk0ccqD3y
         MHyqXSCNFCog4E5huX36bLzU4zEMpo7rRx1hm8hKLV1YC32yyo7xOZ2cY3d9zPaiLzNz
         wasMRGZDFjCPz1n1744b6SwoWLW2QJsOckeJ7RxeJLUXeMW1VMEaoadt3st9lxJaGZlC
         SRDw==
X-Forwarded-Encrypted: i=1; AJvYcCVUhkfCy0SJQt/AGnDJ5Ngsa9C0VVLiRbg/KAL42MKyNQqPuw35MlMP07Wu4K2BG+a8Ny51OPhlZhLg6iB0S/zf@vger.kernel.org, AJvYcCViU8SeYUwuGs5JElkzdQVwC9n8FWP+3/jVSxi8IgveiNquALYyQaunuzlihI0JdDa0clewFZnVbvtooXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBq8Q9KqGwteJXmX9k4o7moAIQ1x7mSJ/mr1ZAXyEqg8AyhKGM
	+lHcTmCDwYeHB1m75KUvBlKUH4wovX/5cH+V/IEnNzXOQB0RF4kOMDMxwhmt6Qg5XLPVj/ewMB4
	HAgb8b+W6P4wTl8IEZNtddp2tYxA=
X-Gm-Gg: ASbGncuPf+b26dFbAxrfleerGAAgm14n2/ChP+8RXTLY2G8WCWqBtwjNHE66Lb3Xs+Q
	P9TNJ3tOF5IHJ5uJj7HA6iV78aPN7z2E=
X-Google-Smtp-Source: AGHT+IF73eped6CD54oRoY4m6IhXLQ3vbzk/j3x0mL97CA8k1E6rPFedbfgYtvlPJSSkPh5QO7xPtyNpDaOSR7n7SkM=
X-Received: by 2002:a05:6402:2550:b0:5d0:bf4a:3dfe with SMTP id
 4fb4d7f45d1cf-5d3be7f01e6mr11120673a12.23.1733750772507; Mon, 09 Dec 2024
 05:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209105237.10498-1-o451686892@gmail.com> <3279e669-1ee2-4792-9e10-8b40928de6b4@sirena.org.uk>
 <CAHk0Hov5k37=MtTBLWTj+Dwm4EXE0xGJS1Uc8xgyLtJxusqsww@mail.gmail.com> <c05f6ad8-2dc1-4ddb-b9c1-b2cddfe78819@sirena.org.uk>
In-Reply-To: <c05f6ad8-2dc1-4ddb-b9c1-b2cddfe78819@sirena.org.uk>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 9 Dec 2024 21:26:01 +0800
Message-ID: <CAHk0HotQ-=s+-FHh8pAOg10ivcRwqChG735qgDvuQd=4B1QQNA@mail.gmail.com>
Subject: Re: [PATCH] kselftest/arm64: abi: fix SVCR detection
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:12=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Dec 09, 2024 at 08:51:28PM +0800, Weizhao Ouyang wrote:
> > On Mon, Dec 9, 2024 at 8:36=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
>
> > > >       // Set SVCR if we're doing SME
> > > > -     cbz     x1, 1f
> > > >       adrp    x2, svcr_in
> > > >       ldr     x2, [x2, :lo12:svcr_in]
> > > > +     cbz     x1, 1f
> > > >       msr     S3_3_C4_C2_2, x2
>
> > > This is against an older verison of the code so wouldn't apply now.
> > > It's not also checking the value of SVCR, this is checking the SME fl=
ag
> > > the check is against x1.
>
> > This patch aims to fix the second check (SVCR_ZA_SHIFT) instead of
> > the first one (the x1 SME flag you're referring to):
>
> If we don't have SME we should be skipping over all the SME code and
> never even looking at the value of SVCR.  Looking at the current version
> of the code it does that, it branches to check_sve_in if SME is not
> enabled.

Hi Mark,

Yes we should skip it, this is just a minor tweak based on the
current implementation, after all, we manually passed its value by
svcr_in.

Which latest code version are you referring to? I think check_sve_in
is in fp testcase, not in the abi testcase. (checked the -next tree)

BR,
Weizhao

