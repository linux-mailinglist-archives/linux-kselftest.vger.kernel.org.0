Return-Path: <linux-kselftest+bounces-34585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE5AD38EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E587B0FB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE4E29B8F7;
	Tue, 10 Jun 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPUNiSMy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F972868A1;
	Tue, 10 Jun 2025 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561618; cv=none; b=rRtqarP2wUYxG/8QQZePtMirs+zx5o+wVmYDgVY81oGlvjvp5BxqrSDkPUFWXY3pei1jZ8dZoQu9PR9pfnDbAD+EatUW0Ft4q4MdadDxWBn9xR0+VEUuEffrMWrN4XbPcd6JqyMyiX2ZyETibyisdLkjn93GmVTN8Oj+kMIggU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561618; c=relaxed/simple;
	bh=NDG3to1h/dHgEC5NgX0Bf30mA1YLoGE7wcVoWw4A96I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JTvLYlUMtykfJbyjl4pzXE8B6y6HoZoZLiM+ra3d46PdFPd3lZ9NIkpYGPKvoOBDdLOShZM8gbXRSRkOf0QX77HV6znpT0q2+pQ9KIrbMs6Wue3dn3LQIzirFY+015xq8Js8bN8xmQyWUkgz0iw7W0WEQRXKbHgd32Jh4H4aK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPUNiSMy; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e302191a3so40585147b3.2;
        Tue, 10 Jun 2025 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749561615; x=1750166415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD88rQIyV3h3CmZ8/ABCZSH1RqmsvZjffauYeExjzK4=;
        b=jPUNiSMyj69gsKACxLnxQIdqgmn8/QJSnl+ksP0u7c8A3bYStr9CVJhaPH/rVnh89j
         d3gRMac/ftr4MKkeczCkBjPkQzpjYJD5wl1KWXF2mC+wf29powq18kdSzVq8cebCWFq6
         nurIhKTX5B894M9cgOnf1RlBUV1iOvYO4J0EdCXmUelQ0CCRHTcRLPWDyzFc5s99BJ2q
         wjf1o9kqQ9jR1AZwQHkuow2VN2b54mie2OWIbjKKVeLzXH+wfVAROISKrw3bM4jRKIrO
         osoYmCVHifMG/eE0mYekGdOQQw8/OqQZdGSw0rYUAa4TwNp5eIT1R6GyF8Res14C33Fb
         OtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561615; x=1750166415;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CD88rQIyV3h3CmZ8/ABCZSH1RqmsvZjffauYeExjzK4=;
        b=wRlRzEjA2c8goakYo1b1/wiEKgZp2ksXD5SPhUK8HBEOYwT8NEGsvjmL5Ffc77dR5l
         ioukI7hCGHas95eyKeGyCU/3+thp2TN5UVK0VVFH+18KDZhqkzqP6t0JVzNJ5zgoT/CA
         1tAMhlL0gBySo1aUnuFSJcdKpz9ADJrVPo5dxFyjAuJMZW05gwch8ilWE8riW1PLyURv
         xa/VpukCyPms34dMEKH+yEXavw83+Raou25WhD4IDzw63q7Fkef8xcB2YlXqP2KOhZDv
         fdsIveNJpsyfZidtK89hxYorzUm869IS2Z0/jAP5palrB40PSNRsU0Zk8jDm5NQFNq31
         A1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWNsBTVa8F/N1IB7Hnn2YCXosNRFguoKiPKuCvk+QvI+ARBfMgjfkv3l4tcb2G5eg8SoO8dYbYUF035LobMg4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDDsSt5u301LmBdAq/B8kSr5hfHoyu5XVMTGwPRnA4WElbh8rh
	8vW0QvKXga90sF+fjsU3IAetOS6n9TF01teKcy4jmtYrbK7uJIyBdc6u
X-Gm-Gg: ASbGncuunGQIMWCi9gCC6YHRLzW27tqbZiQCXmTUs4ncuwla4l6boJcd9SbXjtgLihH
	lwt6R2IREODmvAfIuP6Gq6lM1KdFjeMOfrhxK+pAPNhOKfSVqoiw9dztL067vXCavAdEogrL44H
	XZkmILAl5A8nWcV+IeXRfOfiDeQEjtehIREWojrZd8aU7+CQZYfFBBNIRVqheuvk79qG9lAkow9
	WenZHjEKL0qaIEZx0PIDhFi1250FIXiTgWvpPAwM+I9/Eu7nn5xSqgpr9YWvRI8+vagHjcxPl3L
	r1HShGVrmrXGlGav7TWsyKZJKBt8/XQ9YlhDK1IkTcKAABo3UUlmUqTjH6VZG9KrlQarcRGr/oZ
	WtDmNjCNCmdrkp1MWj8f0u9HbxOj6LwHptIDz24Av9g==
X-Google-Smtp-Source: AGHT+IFfHkXwXh1zOmlASHN1RCRSg3pirvfuxvO3sg479kqDBycEdmLwhHWSLp9d0SsgpdEg449QnQ==
X-Received: by 2002:a05:690c:6d0d:b0:70c:b221:adee with SMTP id 00721157ae682-710f76c1cd3mr247748087b3.1.1749561615168;
        Tue, 10 Jun 2025 06:20:15 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-710f99e8104sm16359917b3.69.2025.06.10.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:20:14 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:20:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 matttbe@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6848310e32564_3cd66f294d7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250610000001.1970934-1-kuba@kernel.org>
References: <20250610000001.1970934-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: more xfail changes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Most of the packetdrill tests have not flaked once last week.
> Add the few which did to the XFAIL list.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks. I made a note of reviewing these flakes at some point.

