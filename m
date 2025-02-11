Return-Path: <linux-kselftest+bounces-26432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 830ADA31948
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 00:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079BB1886740
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 23:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC23268C5A;
	Tue, 11 Feb 2025 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI0FrjFE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E41FDA94;
	Tue, 11 Feb 2025 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315115; cv=none; b=ulkfZSb40vJrDDRXMPK4TzzZqll/bbtgS46amO2tcCw99mH25Vk6uXTuFSxsOOOv4voXmT2BQhKJc2qOZ4BgwcF1iRV4MKHYHNmdPOx+0db4DWTm5dDgstr4NQ1U1xYEt43JC7ZxO3ooVSWawK6OMwjP1+PwdKR6i43isCOcWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315115; c=relaxed/simple;
	bh=k+T1Cs27K17K8DiALVzIePS2OhqhZ0GNl7kWqwBuYbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5ILfQcPhdxJDczNeDvzFn1wqWU8CApcT5zwx/sBI0HCNjs7zrCDKt9CSppQLBiuLbGtBvB4lWKJZcQh27oQdnokNc1yhCvP6FBuaw4T978vxMthmR/vIqkaGZTYVOPANJLqpa3oJG3v+oPYzcxiHZPNb18kP5vB2lm8l/NGj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI0FrjFE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7c6fc35b3so436067866b.2;
        Tue, 11 Feb 2025 15:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739315112; x=1739919912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=au4tYyjUaE3dthpQOAcr25Z/Ua2/0kq4cGxPjFpOCoo=;
        b=XI0FrjFEJ3LK2bUpfFqr9cmC4NRppGyFmy4EuhLhTmxOPw1FccuUivz7DWVzfGURB4
         xan9dyDsVvpeaHTSY6xDO9cgwzx/H3cb5bVRRMWHBKs9wmGDppQ/0l5baUerq97Tr9lJ
         JlfDK6blozhazvq4zVjwtFPg1Wj+LB+4qsQQaBOAd8IS0GtjlITBXHm8f+Fodl3zGBWS
         LuVzY83aLoORhBjjpFAjSC2drFODotlNy/j8dkDhibZBDHrZnkmTVCafDA8QszW0BVMb
         yip8zRug1Hsi21TVdh45SIasZB0MvHJWv5RTuRIfasYMaSQGPfjVxU//euEM4tuFnD1y
         gjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739315112; x=1739919912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au4tYyjUaE3dthpQOAcr25Z/Ua2/0kq4cGxPjFpOCoo=;
        b=Ff0yfOEPTA4XYQCMWWciM0wlBj2eW3tWj/B3cWLUlWNFX3xF7fTMSgI777+9k6kJ0t
         uPhJThlTHVr5st710W/XVliH9taqNvA67uDTVCUjCdBIgbFzX9Ld+98MRGtNOAuYCeDO
         dUXyjRpsTFyFeu/RzTHYWXxG6pEazuFpl6Jmcv5PWBfTbQE5hLVoPsjyhM+ZrElKvxLB
         ffOPGeWSqkGCWOvu+lE+RMW+Nfrh6pXZa2ipvi7ogJLRvdV7W1hGqqJiksx4hj2W1FAU
         W2krhK1mE6ZZHJoQhADX0NoBzIQNYFmNl07xd0WEur9TYdDeatkaHwMMHwyG4erhw1MC
         Yz3g==
X-Forwarded-Encrypted: i=1; AJvYcCWDa4ki6Y2dh+4F6Pq1o7g9lUe4us8zniICw+dDCTop+3AsWviNH6XceYzyeRMXKoCOb1rrfUafh72N1Fge@vger.kernel.org, AJvYcCWRkeU7eMXciu1xXRuKls4p/FPxGnu9MliLLRycqEofgPGcGQcVcrO5dNhP35QuOhoBJd4huldeCjIBSGHI3d0=@vger.kernel.org, AJvYcCXQL3+HZNVjTI9fKVArx1o8Ia4pKb4T9P5wss6vJGOeGCD7h3hOkF8mJYOEt/VXBO9JOufFJOTnnO1f8K3prH5V@vger.kernel.org
X-Gm-Message-State: AOJu0YwczumM1JtgFeDuSF3eA/kmnwRMEMP5Hlq7r3HTMGrh4HS55YOL
	2KTnrnicLTts4PeyZyx6uEvvxNPJwLsRlN9753HX15E+jVq01wtRZWfASP4WbkRITg==
X-Gm-Gg: ASbGnctEUIMtzdmqYxAG+vbRbl93AAxPNg/RgMV6YAfSkj/gyEDGa/ufZ7jf27NxGSE
	L0a5Yg14RWCsQBX4G4Ciop5EgRm1MxqcrVWgMpfEuegxDx1I0smQQrsPtaEi2UEyVO7UFJ6ok90
	gFOWF3H/gT1sglfCayH+LLp4B3ef2hEGp2gtv9cXIki/FmizjLFgxcf05SuAyS4HjS/1NEzgwMl
	nscsrG5o8W+Tz/NjIA6d8BHQxAdBFwbZC4D9MS5qe4Ib8pfGxCxwl4yiN1AQCRoUPVonD6+0zVj
	c/IG0RUIAelh1wPlkoQMhF7+uSP75OAbBDEUe82HCJGSSmrPycJhVxwQmGNawHv9L7A=
X-Google-Smtp-Source: AGHT+IGI+JyaHzqreyWTgHAya6OyyTJbR8tyC+vcwIictYrMaQF1JoXigt4HXYn+Qxu+GTO5WrJXxw==
X-Received: by 2002:a17:907:971e:b0:ab6:ed8a:8a90 with SMTP id a640c23a62f3a-ab7f377cf46mr53391966b.24.1739315111434;
        Tue, 11 Feb 2025 15:05:11 -0800 (PST)
Received: from localhost (tor-exit-60.for-privacy.net. [185.220.101.60])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7a58abd76sm766729466b.26.2025.02.11.15.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:05:10 -0800 (PST)
Date: Wed, 12 Feb 2025 01:05:02 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, shuah@kernel.org, 
	skhan@linuxfoundation.org, linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3] selftests: tpm2: test_smoke: use POSIX-conformant
 expression operator
Message-ID: <x4dtkjgxwy7vyjg7rryvqqu3lwhiqm6jmhr4ph2fexa7m2m2mv@dbefieqhx6x6>
References: <nyskb7mbqk2dvlwhez4sua7ryz5gyi73yker6y3qhd4chyyeaw@x6nhqgtxcyvl>
 <D7PTH0ZUAH5L.VVEECLR4VEWH@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7PTH0ZUAH5L.VVEECLR4VEWH@kernel.org>

On 25/02/11 08:10PM, Jarkko Sakkinen wrote:
> On Tue Feb 11, 2025 at 5:00 AM EET, Ahmed Salem wrote:
> > Use POSIX-conformant operator symbol '='.
> >
> > Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
> > ---
> >
> > Apologies for my previous mistakes.
> >
> > Changes in v3:
> >  - Reword mistaken commit message
> >
> > Changes in v2:
> >  - Remove snippets pinpointing the issue 
> >    from commit message
> 
> OK I read what I wrote and I guess it could have been misinterpreted.
> 
> What I meant was to take the relevant part of the transcript that shows
> the issue (and possibly also how it works when fixed).
> 
> Sorry about that.
> 
> [1] https://lore.kernel.org/linux-integrity/D7OY3ZVGJOV5.R3SL9SBFT2DF@kernel.org/
> 
> BR, Jarkko

Understood. Thank you so much for your review and continued guidance!

I will be sending the revised patch shortly with the proposed changes.

-- 
Best regards,
Ahmed Salem <x0rw3ll@gmail.com>

