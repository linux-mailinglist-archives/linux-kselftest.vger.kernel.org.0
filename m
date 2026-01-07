Return-Path: <linux-kselftest+bounces-48444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3411D006B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 00:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CF4D301A1C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA02E5B2A;
	Wed,  7 Jan 2026 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcAsKVGq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681CF22A1E1
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767829901; cv=none; b=ugaVw/vbSdM5fkgk5s9DEqr0TxBk+gl12ClYZYp673FsciyI46wJO59Nm/vUgFGBJj5aTvuZrrql3CEsQE+G99rvoXra9YUkSNlWAYS5zO5WzJmwNnO3HV/ek76xZ7nyxrKkOmV01un3TRw0zFis/XGoPwhk808nbVGIMcjE7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767829901; c=relaxed/simple;
	bh=zO4H4umt4L3BRFDuQvlC1XdVHY/+64DL9QCeaA2EH8I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jn1CeHN98Z1bck6s4xvSHAsq3lbkQxe9DArGKnqCFqNjg5UVm7j9goJM5T259dxjg5+AI1fVC9ffEZj+JUloFVYXKWDqG8T6EvcfsYmA6Ovm/rxLqR4GV+Xv5VHab3etxlwqRV/AK+z/4vzGVcGJ3iprsTK2AqiO8IH25MH/778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcAsKVGq; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6446d7a8eadso2353974d50.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 15:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767829899; x=1768434699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW9hLedm7MESDpf5Fo3MzueU9wwSLuxJSmWhhBRYPJE=;
        b=IcAsKVGqYF8EANHFpjwGrHz1+6V6kdt9y9bNu6R+QBzkBYIgKL4V6mX5LMlw7uWduE
         bPjzicpjybvDDZgo+pzbJRvKggbceugecG7OazKJO2XhK811LuKTOxK+/8rkWG7aQXL4
         fPwnmYU+Vu2mWD6FHyjW9Y4CJ6vFvYL0gRSEgYS7RZ0pCpBaQofOlIm/LB1R1hjOVOUQ
         LRNYqlUy4ETLrOKIEfzXu9YQ30sO2aG9UmVnHSSRXuGVMD/3ffnrFWSqO84aQd7aUSLm
         URUaxYIz8YLTW9wBJLsehBjhd5T3HywubO4ezDHbaZ9EqAFA3wgYf1iLh8+xKM/BOb+P
         ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767829899; x=1768434699;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qW9hLedm7MESDpf5Fo3MzueU9wwSLuxJSmWhhBRYPJE=;
        b=hIj1aWOIdbUbdpUtN2K0VgI34xOG4nMHBZl0tAanLePm2Y6rbEDYzwA4MQ8uic5LnH
         liCQkSQqJklA2MHs05fGqA0jJUeVCcWqc8IWsYqfNlpJsDpYCc0Ac533ThQLD/VmW5Js
         p3Q7OjL0c3ZjBG+r+tdbLERysJqs6hSAwUutBNRRv0hEkEgzczCrM00OK4xJI540+JFs
         q3Zv/SL7tuypSvcDISNNwmUgC37kFtfjvGqtVGHMr1SMGX/i0fy5aAJv97GbvG2cXtZE
         Ky79ld1Nryb4b/CGZhLoycDj0DI0R5VtkcrJTtZ8G77kgSLX5mjr2GEgy89zMEwElMXY
         RmuA==
X-Forwarded-Encrypted: i=1; AJvYcCW+4eSBhzgVsprLEd8oUhm2ZYy8TyvIEdMQauNFS1dmp8UjTXiR7W3x3dqy3lt4u++uyMeD3TOWiyZByIqNkSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0jgSo1h+lyM1HBDMKSzw1VjjEkSMBF0HLCYqyjVsQiAfocsP
	n2GLhk3JAGLa8INIPJc/8+yKGmT2WFsAVAIhx0jwSqVSrYE12lBedoRa
X-Gm-Gg: AY/fxX58Hcz9g/zTLOkrPyg24ymziEaqGds/fn/+rQtTBXyXzi2Rwe2XBtQBTR1/71D
	C/QuiFSDu/hIemUyeiKnyoXlVIzRwYIP0jtMfO2OdVjXsYuqsg2CZZNNw0P81nh9cigRXKyqqn/
	KwirQ7J8P7a7LIPC1D/zxYWnSFyxIE9leUAYuTi8G2aFpQ3at6exodHcwlET6+8mpJI5N/gzXc6
	UugRwgl3yCR9QjHgWc8N35GW6xRAHobsXFjZKarjUn8qJbP7zQ4QCP9CNk+bxCvfS4itDhVG+I6
	4A0k8ydunu32J1L+gOkhYsksWQndPTCEIN1GhdqB9dSiUzVKVhE4zwAIOCkEHJ6PqNznqAJqb8f
	HKDCkTN1V2K65y31z0eThM6+i7dXp68zZ1oP1C9Z7vKr54SDmaWKe4xg7/KKBLyMCM8MB5UWPNQ
	rvcd9ok4/hUD9mZYusP1hj7G8wl82KI8soaKrTbwQv9wSNzG5J2GlAkE2ooOI=
X-Google-Smtp-Source: AGHT+IGHEhH3PA8r4SVCH2s2vrFtBLO+6iLES9vczOLNghdBZckvlVIWh5dwq2VKoBR/jDv62AGdLA==
X-Received: by 2002:a05:690e:1404:b0:63f:2b0c:2d61 with SMTP id 956f58d0204a3-64716c390aamr3631420d50.60.1767829899393;
        Wed, 07 Jan 2026 15:51:39 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d8b2623sm2643462d50.20.2026.01.07.15.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 15:51:38 -0800 (PST)
Date: Wed, 07 Jan 2026 18:51:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 willemb@google.com, 
 anubhavsinggh@google.com, 
 mohsin.bashr@gmail.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.191adb8734bbb@gmail.com>
In-Reply-To: <20260107232557.2147760-1-kuba@kernel.org>
References: <20260107232557.2147760-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: gro: increase the rcvbuf
 size
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
> The gro.py test (testing software GRO) is slightly flaky when
> running against fbnic. We see one flake per roughly 20 runs in NIPA,
> mostly in ipip.large, and always including some EAGAIN:
> 
>   # Shouldn't coalesce if exceed IP max pkt size: Test succeeded
>   # Expected {65475 899 }, Total 2 packets
>   # Received {65475 899 }, Total 2 packets.
>   # Expected {64576 900 900 }, Total 3 packets
>   # Received {64576 /home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/gro: could not receive: Resource temporarily unavailable
> 
> The test sends 2 large frames (64k + change). Looks like the default
> packet socket rcvbuf (~200kB) may not be large enough to hold them.
> Bump the rcvbuf to 1MB.
> 
> Add a debug print showing socket statistics to make debugging this
> issue easier in the future. Without the rcvbuf increase we see:
> 
>   # Shouldn't coalesce if exceed IP max pkt size: Test succeeded
>   # Expected {65475 899 }, Total 2 packets
>   # Received {65475 899 }, Total 2 packets.
>   # Expected {64576 900 900 }, Total 3 packets
>   # Received {64576 Socket stats: packets=7, drops=3
>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   # /home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/gro: could not receive: Resource temporarily unavailable
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

