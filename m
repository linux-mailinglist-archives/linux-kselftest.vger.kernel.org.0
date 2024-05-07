Return-Path: <linux-kselftest+bounces-9599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CF08BE573
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CF31F2227D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C0C16D33D;
	Tue,  7 May 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qqcv7LlC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD01635B3
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091190; cv=none; b=BxC7yNJUD1xxw4AA3SNbtc7CG6QK8RbhIwE3PdDW+J/+Fx/DYfjMO6c/YMJch91uOg7JoqPi8zUGjCe3E54kg/ZvuF+5PB0fWIIW0hsv/gS7imJl6NV3zljx79wODpBhfwuhKKa/U9bhUR0FUbYPJ42yIytelYzmZTlfgL+ciFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091190; c=relaxed/simple;
	bh=zchA9qCZkbTbiKP4dWASuNmwzS8UpJKwMcrmBhDATqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pdCPyXIJyGYRQjDMK3srp4qyONzaZw7+dELtp8kJwxS9UbK494/whdFkrSBfF5sYtpTdXsWbvuTVYkzaTxy8vCc4mIxLXOvG3ABHZOlNcoKeYoPTsHXi26+1BD3COkrfOvskemhJLDjJGAxjJxAPgZ5HcPKEPz6s6JpOquDpavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qqcv7LlC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de6054876efso6476647276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2024 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715091173; x=1715695973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WETraqwVUAnZYIOXp5ZtLEEE1VYRO8MGNkm01fdovIk=;
        b=Qqcv7LlCIOJvBe8ClD5U2l4Vj91uUJ1zIUjEjaKr6vohBi/GFK/kCBkhW9qZZdGHpC
         nxwyf2tAeD9my0a/qM1hJuFLQ5WLbt9BIL0qxKTsdW5atZMtIoDfpEumiMKhONL+q6GC
         72o1+zEuLefO3WFSRbvMdj98ysyUkJMpfe7bhvl6A005A3nsrGayxqodnVvhsMT20pAt
         yNYTWrA21yYGzTAFWGKYYldNzy6HfLhHLr9P8AMYSNlf/aDrueIH/wUsf3uXieIgzDX+
         O5JA/bxh+xBYg6hbKTMR+zx9CtluRtqSpv7bEPdFtCNAqD41I+kZK/yYDSFaH5tcnybA
         cKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091173; x=1715695973;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WETraqwVUAnZYIOXp5ZtLEEE1VYRO8MGNkm01fdovIk=;
        b=NsdGBEFcKIemvEMZRxUihupSBjYxHm94WlgCJCGLzwalwgJguM/ForQQ03k1MC9wb9
         xOufA6mYcV+Ze+uwDv+4vEf+NY1MPcslBr5av4ZFoDqr5TnFXm/5E83azCNv8JFkPE/i
         pxl/gOAUtJkpPllbitwzP4DmV+9ol1fHIk0NM+vw7xyxnGpWxLcK8aWwM9DBDds0vQL8
         EomwkMOwjtIXZZJRvGcEY1hLPZFcFCx+/1XbTR8E/TfE6rwG8edokmnd8WCZ2oJ/t54w
         btpbScgLOD5tZcJkSqYZW2w6+upNNZYG/fWhJlf5nj1KUN2j/3Msa6EjfgCPtQffD6If
         BuJg==
X-Forwarded-Encrypted: i=1; AJvYcCUN1h9g7LTepp/mc5vUbJGGB31nJOTKLtc/hMNXQIleFivNDC3sAGmt44sm3qPDXJm1M/9oILlV7+Cek63hvgR03bWUHVDgkjN38ObbIvMy
X-Gm-Message-State: AOJu0Yy2XWTLtjbpPuWsG1jV6jXlTZTYMcGy7RC1eSe20mw2GsazN8uz
	RllAyVr6hOmIrVL3siEAFuKNHQzoUtG6kCGBx8RW0cGpA/Mxf+xlx4HjQsHl5Cv3yjuDbpqUU3x
	SUg==
X-Google-Smtp-Source: AGHT+IGplKwNSTSkBTAvhdXpqfJnr+yrgmgSEfcIAM5opFxBtA3BpCgSqdbY3obOQsQH1wjTlAweJ+rLPgI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:69cc:0:b0:de5:5225:c3a4 with SMTP id
 e195-20020a2569cc000000b00de55225c3a4mr3998230ybc.7.1715091172929; Tue, 07
 May 2024 07:12:52 -0700 (PDT)
Date: Tue, 7 May 2024 07:12:51 -0700
In-Reply-To: <202405061002.01D399877A@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506165518.474504-1-mic@digikod.net> <202405061002.01D399877A@keescook>
Message-ID: <Zjo1xyhjmehsRhZ2@google.com>
Subject: Re: [PATCH v6 00/10] Fix Kselftest's vfork() side effects
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Shengyu Li <shengyu.li.evgeny@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	"=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, Jon Hunter <jonathanh@nvidia.com>, Ron Economos <re@w6rz.net>, 
	Ronald Warsow <rwarsow@gmx.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Will Drewry <wad@chromium.org>, 
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024, Kees Cook wrote:
> On Mon, May 06, 2024 at 06:55:08PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > Shuah, I think this should be in -next really soon to make sure
> > everything works fine for the v6.9 release, which is not currently the
> > case.  I cannot test against all kselftests though.  I would prefer to
> > let you handle this, but I guess you're not able to do so and I'll push
> > it on my branch without reply from you.  Even if I push it on my branch=
,
> > please push it on yours too as soon as you see this and I'll remove it
> > from mine.
>=20
> Yes, please. Getting this into v6.9 is preferred,

Very strongly prefered for KVM selftests.  The negative impact on KVM isn't=
 that
the bugs cause failures, it's that they cause false passes, which is far wo=
rse
(and why the bugs went unnoticed for most of the cycle).

