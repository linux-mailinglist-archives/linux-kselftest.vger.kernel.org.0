Return-Path: <linux-kselftest+bounces-27802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BDDA48A87
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A196B3B6273
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4536C225A24;
	Thu, 27 Feb 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS0eXn72"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD2270054;
	Thu, 27 Feb 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691880; cv=none; b=VgAEY4DRdrOKko9zZX4LXpuYm/mWuj1s57uldCJlB7pDXMoLlA/08PzRWZfFci3kFQ5w9OjPAbNm20IZ8GntcQpX33gra1NQbD8MPcwjOklYsbv2WAbj54q9sw32A97hfHu8gvo/lALwoa+dIkWzbTPpq+bdKZZcCZs63u0hQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691880; c=relaxed/simple;
	bh=smiZ/apE+Yk4FJShZg1ezck42LbWkq1NsSbpbC9kjT8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QGbE3Rj2XKb/Tr6VVvwYGT0gosdgTCD3KN3Yw0gCe+lzHLg7c0FCbmvLtZIMCd9No0JvL2nz8qyN1MoBYfWBTuyhYeK4lHIGH825IfizT4jTlsIt13O1UgLq8EGsKe8ZVqH7utTTWjOqZe9aG8YXSJlsGT7OgJnHJSohPeM8gRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS0eXn72; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0ba89dda9so149485285a.0;
        Thu, 27 Feb 2025 13:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740691877; x=1741296677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTXWCzxJGjQRhBeTvZrkv4Em3taHo2homJvU6LLXryU=;
        b=SS0eXn72sQXv/ixeIcFg6qHAzZbF65r6liCtlj7GJDv/8QdgnV+mUeXSz3MxHB9v8I
         VyFoVdoPLFxmKRMFu53MBjlmeYuLp8xp1MrM4u2heb7vTfw4ZKtPrAorIQDoaKhKz0Lz
         WwmIkOD0Qplk4aPrsPfsTgMip3dj5r4QPjfv2YsFL9vhS/Cn88nnjj9+/YG++F8yMoeg
         WFXUhUW3GzEgIqto8e6IbbZUuEuqRA41MM+KF8MPuaOm/iI0CsR+sfJKvGeeLHrT0kOe
         Wgr/k/tPmyQvb7tp3Ww/1XVHNNF0DTfCM15fRgtOPL37Cqut19yyrCQJAWTfbt7HN42d
         Qo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691877; x=1741296677;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tTXWCzxJGjQRhBeTvZrkv4Em3taHo2homJvU6LLXryU=;
        b=in0zLSr6nX0aDShqWl1FRBm90gVzztye/Ao6dJgLIYycrgz0J4kGP0nI6DV62GLWeR
         1CVOJi4pUNhcPTeike9jaj5jxsDBizhm6cJQhTaBu0Z5XccfVFh/5L3cnKe2BHpU/5tS
         PiAuRCMNA/kSIFERlhah/gYg9ZzABgLyAfSzVPRodP8ZcSM0N3I8ofBVAj4upT/4XkYM
         q0o1vnBdrshvJOEkc0fQVLsNCrefpPi/kEkTrl7NsHTk/u9xFONX0Ux9Eq2d+8IrcfKh
         jZm7Eyp7eANbnv92E6kl2wclULlZkFxaiZTVR6sg+k5hUNGN0YdJ9PQ5/8GZVe7fdAH+
         ooGA==
X-Forwarded-Encrypted: i=1; AJvYcCWQlHLHzX1WvMB3pNs416sWSUqWURJkjLvyr2fiZdTa0Avgpaveb2ZMc6l85zNqoUlSFKRigNJWyWdB7jHKaBsg@vger.kernel.org, AJvYcCWwVOB5D3v/Kzkf0LrDRoiPjQODserr7H2hIfFXJF6JfDefui+7I+hUjIwlBcD4UFhWPLyJqQIAU94DygU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH838BT0HyvNZ1N96NOrGSe9ZjOKaGX1QsJwWlq/0QTKHVTogx
	/7f1g68O+8jCQgXIM49UlIKsFuv8hv+3Z2kvafIzQSZ5zEIT60R3
X-Gm-Gg: ASbGncuEE4sR0U9xY4l+YDr9qvBswujR9g+RvHFoWAdie+fZ/XRQpRCoeZwK8wGJlMu
	K2bmmmY7lGCYLoJOf5kROtGhNj48u0ZLGpPmlKshbgLmN49k48i94XAGYu/mTZwXtlKKhPVZmra
	ezI8vHtl4IgNm5A3fQXaAZHl2TdTFIZK2DKLUot4u/Tu3g6IHXl0qoWk6iqr1lktHnuHoJNkNbT
	d/gq9nK0U8pFBaQjKnFCviExjvTKQBWhfXFyZSG12tCQ5zmlLmup8pFiKJoH2LhhiJHxGq4W9Q5
	NykM+HOOpRWrUddPYoPXS7pDmv540k6gEiMeWTyc7afWQ872i72GvGVoCScwAuSCJ2/vd0WAzBr
	iBPU=
X-Google-Smtp-Source: AGHT+IFZOAzjE9lqgxr501qXM+xsj+WuPGXphtv657s2teoMDxnxZ+El3z4MqsQHqMslYAysMTD1Ag==
X-Received: by 2002:a05:620a:394c:b0:7c0:ca33:6a97 with SMTP id af79cd13be357-7c39c4b7608mr121147085a.18.1740691877481;
        Thu, 27 Feb 2025 13:31:17 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378dab64asm153205585a.100.2025.02.27.13.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:31:17 -0800 (PST)
Date: Thu, 27 Feb 2025 16:31:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kevin Krakauer <krakauer@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org
Message-ID: <67c0d9a492e9d_3a9f1829469@willemb.c.googlers.com.notmuch>
In-Reply-To: <Z8DYMBlzcK5sFG-M@google.com>
References: <20250226192725.621969-1-krakauer@google.com>
 <20250226192725.621969-2-krakauer@google.com>
 <67c090bf9db73_37f929294ec@willemb.c.googlers.com.notmuch>
 <Z8DYMBlzcK5sFG-M@google.com>
Subject: Re: [PATCH v2 1/3] selftests/net: have `gro.sh -t` return a correct
 exit code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kevin Krakauer wrote:
> On Thu, Feb 27, 2025 at 11:20:15AM -0500, Willem de Bruijn wrote:
> > > ---
> > >  tools/testing/selftests/net/gro.sh | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> > > index 02c21ff4ca81..aabd6e5480b8 100755
> > > --- a/tools/testing/selftests/net/gro.sh
> > > +++ b/tools/testing/selftests/net/gro.sh
> > > @@ -100,5 +100,6 @@ trap cleanup EXIT
> > >  if [[ "${test}" == "all" ]]; then
> > >    run_all_tests
> > >  else
> > > -  run_test "${proto}" "${test}"
> > > +  exit_code=$(run_test "${proto}" "${test}")
> > > +  exit $exit_code
> > >  fi;
> > 
> > This is due to run_test ending with echo ${exit_code}, which itself
> > always succeeds. Rather than the actual exit_code of the process it
> > ran, right?
> > 
> > It looks a bit odd, but this is always how run_all_tests uses
> > run_test.
> 
> Yep. I could change this to use exit codes and $? if that's desirable,
> but IME using echo to return is fairly common.

Thanks. No need to change it.

