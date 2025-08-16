Return-Path: <linux-kselftest+bounces-39150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89714B28E61
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7930716A575
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C402E9738;
	Sat, 16 Aug 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8+R3qDT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158A2E717D;
	Sat, 16 Aug 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353556; cv=none; b=UmNEoO0dhT4TBAKI29LBXaJctp++gbR72jMLUfCNEn2w5wzQYKX/kEDgcUO+gQh/t7xhZQQZmWMStvJ7+lQiTRHo8uALLkYT1avOi1tV2gu4ki0by7ZQJB/RmQWN6xGMgfQozfnA6douyRFQyVf9n4kitwTMOXU48VES7SHxSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353556; c=relaxed/simple;
	bh=feoSPjnrOdX0//SvROhIkB9I3UqFW46Ajumc7uAoMRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLNO61OtEPwe+vWeDo1gd8HrxsURX2oa8LB8wluWEdjM63wZOzFuZduuszHmJIYlzrF76GdYPJQxHrLqznN+8zkvH+IxzR5tpQ73Z5+RD0Z70MDkICi5WWRDO2mxJE8djuB5DaUz9PpBllyHLQp6UfchF/6jixx3A4i/hlp8PG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8+R3qDT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-618b62dba21so1614555a12.2;
        Sat, 16 Aug 2025 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755353553; x=1755958353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=feoSPjnrOdX0//SvROhIkB9I3UqFW46Ajumc7uAoMRI=;
        b=m8+R3qDT/hxRKHbt2Q4BYAEixpm4Y553NfmkNrcax/iXQ0I4h/fzXIyuL8vBsAG28v
         N++hQfqQr4zOO8s8Hl5852PEn3rNdjhVq6Y9D/IHvckl3HDfNGN+XaGKGrZDZp2qkIE2
         rxxL+fksT+Khs3ne2rJa8iiNzzxYMWXpjgqw7zfP6jioAX0Qjfr0uRfo/3gOIPaW0zlu
         4LE2tX//yDuUbL151WHQAxYvdk81TNQVuROpl92bSEBrGd8KMLlEKMxrOHbb9ug1x+HQ
         etijIZ0tu4KoRNjcMfSPBA+X2QQ2ZeKHO0hhuhE1jpTKi6s1Gzhu1QX1UoP3pVDuaXSe
         uKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755353553; x=1755958353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feoSPjnrOdX0//SvROhIkB9I3UqFW46Ajumc7uAoMRI=;
        b=XoG/x2JejmwOKwNM4RTOuMc0wAjO4/i4SL9ODs4QW33lgxggzyOdSx+v8f3P0jPghq
         Js782oJIRKgexy+ypf4RZ4EABiQB/4S6IWbD+4asbFb7tQzzY+xMmEnEjUbcJjUnqajm
         g3MAppMqcD/WFkD2UB6/C/kJKVoR1ZYXwBfxE3kX0D3Bqigv688H1OnTK9T1Ym46VKwf
         QeCRTkuQCeUeqYV225nND13HLBco8lDDL36hoOp6vL0Fj8QaH7+oCm2vTkHF6eLvSQhB
         mDpRQrw1YPsorFoTCPTXnYFfhizExFA+N7+UI2RaukzEPh9hP2sEPTJlg/n/tQD8OuHK
         iBeA==
X-Forwarded-Encrypted: i=1; AJvYcCVdK9LxHq7l/BAOo7+8a6Q2t8lARLh6pQY+D5DCwUo107Lwg8DGahQo0moioFMubxHUi7bAYkLHX4/W8opREgGP@vger.kernel.org, AJvYcCXhlE1foEeuzcivW7+JZiZ5zgHN96LcCd1EMs1AJZqZSqfdPt4UIhU2JGibHIA5FB0qz2vI0jk4BymbGLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4AXlGwDKn+y+Kye12/hNAx9d1U9clZSwA+rcnH5/jTqHIiwS6
	ICNfh1hhD3EomA22KK0S6JIHD/b6odfV33MBEgArelmB9YoBCLBsdcudczjbL8j0UGuV84N905t
	IgwMZHMpSMII4uxxEgYbkhY/AELMWqA==
X-Gm-Gg: ASbGnctwCwQAjxVY8IeTVowlvFpIodLVaLCkf83UYrCItduF31d2HCFkp9BCSLrHbfg
	b913ef85l09R/otnOdeaZSbaCrkjWDQhdpFCHAVLahjBcpd4UsZ4P3J+kGoQMF6LwOXaPkM8nFT
	ZKajaUDckpE+ytt60BVO5AWeic+wQFkpKUtO6sA7uWWRKwHDX7AuUkAdcec1xCNE5wKd4BzhsEO
	yeLNeA=
X-Google-Smtp-Source: AGHT+IF39sA2/AVBMFINcOLAmtFs2hW/T/K1I1gQxZpjqQbWUrpFsMrEH1JB5BTTlUPFahsCPdZqX+kgleQP4aRgk+c=
X-Received: by 2002:a05:6402:35c3:b0:606:ebd9:c58b with SMTP id
 4fb4d7f45d1cf-619b6f65d97mr2325294a12.1.1755353553120; Sat, 16 Aug 2025
 07:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250702152057.4067-1-ujwal.kundur@gmail.com>
 <aGf_W_ZgIf63dmAz@x1.local> <CALkFLLJua-LeS+S5GpiXORA-3wNSR0DTzbh2bvU=Vg-Uzd2VFA@mail.gmail.com>
 <CALkFLLLoXfTNtigbcyD4RdJfY+b5Rh5-5Zta1QM9dBQxZd19cQ@mail.gmail.com> <DC19N1YGQP7J.1MH8WV5KHUHFF@google.com>
In-Reply-To: <DC19N1YGQP7J.1MH8WV5KHUHFF@google.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Sat, 16 Aug 2025 19:42:20 +0530
X-Gm-Features: Ac12FXyvzVN6lhXuryFknwNkw_NPGtcXZDTU-i8PRTDQZLOHQyctkouzXjWB6_Y
Message-ID: <CALkFLLKmjj=Gt8g2Y-2u28HEkoXXF5cFG=v1cV2MEDHjZ=0OgA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Brendan Jackman <jackmanb@google.com>
Cc: Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hey sorry I've been on a nice long holiday but I can take a look at this
> soon. Just need to get out from under my other review snowdrift first!

Thanks! I'll have to rebase on mm-new again after the 6.17-rc1
changes. Will push a V7 out soon, this time without threading the
patch as suggested :)

