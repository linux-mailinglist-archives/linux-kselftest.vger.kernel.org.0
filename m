Return-Path: <linux-kselftest+bounces-17408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6896F9F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7596DB2357D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2C4779F;
	Fri,  6 Sep 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMWdjS11"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6EF56458;
	Fri,  6 Sep 2024 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643932; cv=none; b=hIGY/6/89eczCYie6fNEYrE5zTNJtf1WvzKZrF8pVe40JVJQAe6ZJ77aMrMMrOD+q4zNTl7cfyIwBWJmV4zXA69SGWPwz4l0Un+BnKLn1jNiaT9DcAPE+s8+vwZECfU2D3OVUI163I5YaAIJ9yJexkdlWUuYxYb/m2KGsWyKAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643932; c=relaxed/simple;
	bh=0+20AmNLdeVbPeTb9ad16XElWY4Rwn6eN5NElsSEdQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSOim5x+xHOYHpiA8dtafgV8wa51/G1E59t82cWCDyFghsbLEeBdALC9nRb2p5QZvm92uic97GaqmZEJ6LxzxcbgW95s8/WLkudUJhRm6Y5M7nOD9cOOcDsYvW4wZk3wEcK6jUMJ+72GgGKGkk8YqPOM+ESwClaVpAgLWVCY/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMWdjS11; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d8b96c18f0so1756652a91.2;
        Fri, 06 Sep 2024 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725643930; x=1726248730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+20AmNLdeVbPeTb9ad16XElWY4Rwn6eN5NElsSEdQM=;
        b=ZMWdjS11MSkOKZtXU81gUBXfxcIBku3u0dggnFlpY3Gy/WAYfqcGek++KXj9QoOV+e
         1b3DU5yrGIMAPkcof6sOy0NPJGkODa26FaB7NX+Wv4F6gwgu6SgHnasXkZwn5F9I9r5l
         bAUUpUxZgJpB8Bl9G/W5aOdGNjbfCnY84UXxPvR63SrztGhYdYQfmgAehCRdj6vhsES5
         ePeNu7Xax8iR442lol0OmkhzmRdD84ckUTFID+z++SLwZpeF3tVZdDWx3YgCCMt3mkM6
         rG+8CDJsqH/XW6487wjEYKJO1kAifx9a9zoFgIOy5TMbU0xQGS1Q3pJKu3XaGRPDIpxR
         QuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725643930; x=1726248730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+20AmNLdeVbPeTb9ad16XElWY4Rwn6eN5NElsSEdQM=;
        b=D85/hRtJgEwsH9pc0Ed6y+LidWxasphdrRd9YFwhU40iPadBfTDmOLhKJZcLONb36O
         q0TRUByEXBbcZ/XmeCVgwMeLffAjKUjQigYYLzDej0az3IkbAqlcbxdNnDf8CN7gg/Vx
         iITyvUnaggbkj3BdVHIWhY2sqby0959m1UkmZFE7FEIxKNQno1XxnTynnZ8UtGwJ2lAc
         A0GEQewW+nCVau+7Ey2TSM2/6eIfxOHOZT8h4q9LTFozxJAPNko/f5ThD2QZNF8OubwA
         JMuy1I89SEhzDVr/T/kcjeSiQAWBLQedx6RGgp8aK99KB8x9f7X0XJVAHLzkz1+CfPj7
         d5+w==
X-Forwarded-Encrypted: i=1; AJvYcCWtbGjzGCyCHvsanNCfOFMIILq28NDpRi7Ow49YvYe1PDBeIGaXdzzBhnTOt2QsHQ4+e+I=@vger.kernel.org, AJvYcCXJzfO3twvqaUMkkYCHRuFkfEROLId1W9k3n5KcLVOwDeQxr4foZy82rWFPOKNMbdePNQge0cMOmQ0kHrxTCKtw@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdnsQdk9UlEMuhgB06RLabv1W++Dw7rYhlEC8Uqf4C0610T9a
	T+JjHX9ibfLRHLLUxa9USZc2cjzTGKnulXxk3VgHldfeKuYF130MfSA/gMZ9j8fT+wJZ9jHmiKk
	yUWYZyb9uuoGo6sENhlsccYM7O5bcjA==
X-Google-Smtp-Source: AGHT+IHNHl3rFdyFtSldFqYfEtrEBl0hLwkqIDHChTzjccWVvNiiSyp2i5tBrcwqjUjynPSVhMssvwflM3bkcHxXNKo=
X-Received: by 2002:a17:90a:ef0b:b0:2d8:b91d:d284 with SMTP id
 98e67ed59e1d1-2dad50106a0mr3897209a91.16.1725643930554; Fri, 06 Sep 2024
 10:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4Bzbjt5xbxLXbY9UkbuCwN3Gzu8v-QuREoa6Uj8FrxvRAQQ@mail.gmail.com>
 <20240906065507.2598-1-chenyuan_fl@163.com>
In-Reply-To: <20240906065507.2598-1-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 10:31:58 -0700
Message-ID: <CAEf4BzYwfc7tCqzn2LmODDpJs9V7XyMD=2+bv2BTmqVH_D=9zA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add valid flag to bpf_cookie selftest's res
To: Yuan Chen <chenyuan_fl@163.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:55=E2=80=AFPM Yuan Chen <chenyuan_fl@163.com> wro=
te:
>
> What you said is reasonable=EF=BC=8Cbut it would confuse the test personn=
el, as there is
> no clear reminders. Is it possible to modify it to without SKIP=EF=BC=8Cw=
ill give exact
> reminders when it is failed?
>

You'll get a test failure, I don't think we can provide a guess as to
why any given check failed in selftests for every selftest's
ASSERT_xxx() call. So I'd just leave it as is, I'm not sure what
problem we are trying to solve here, tbh.

