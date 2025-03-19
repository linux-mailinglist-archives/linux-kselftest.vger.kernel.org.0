Return-Path: <linux-kselftest+bounces-29415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868F9A683A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 04:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC222423EF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F624DFF6;
	Wed, 19 Mar 2025 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af5wL5mc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB77524F;
	Wed, 19 Mar 2025 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354455; cv=none; b=aoOoebfdUBGyc6RL4s+y8MUFwgmRrihG427kz7aQVLPr7GeCXq4Q5dyKL8hpE+9uQ++c8YLBU6IbCfuvM3pqDv4h2KKK6s4MY7ubV5isDkMCNuoqKcrqmDQoPDw8fsuIFcT+ScBVCDVcBWFRcrO3rhSfI3cqfZtQSsh+ezaGd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354455; c=relaxed/simple;
	bh=m7XoXLiYEaSOr01iSlnFMg3cftGutAJsuPUFCyqTAHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lF47pCSIxlQSYcczi8jQI+auMufQDr3rG9eb+nE9mh8zUNXKlf7ccyAvqm0AmUibQ8Ybc2Mg2gNWRO704ALVUBYhjExf5aB4nKwjWUqiGOI5nvP+STzfCgBb8FgBXbQoapzBap1Agmgocjxw9qtB+wcQ2lMIpkYK6oOXfni266U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af5wL5mc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso3711829a91.2;
        Tue, 18 Mar 2025 20:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742354453; x=1742959253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AU+AUlTwRi7J4/S9qJRKbHn4jNyx75v876BLDl3Zuu8=;
        b=Af5wL5mcnuWOPvZzFxvE5e6AUkbMQBxOWtbdm11fVzpg8UPqaqmUyaGmIzzpMNnCf4
         HNc3w66HGLN+ChqF7ifSMm5QXFIuG3QGOZ/cU9rv02be1FqZbqFa218UHseWf6BqUUzt
         mC0iceSh0wL/ZFYabCIiSK+sz2b1URD4ClS3HaSpVunX8CIPyU28/nrEOwncs3h9SLW3
         WYE5RT5FHyJSimrClv1ZapBVdQzzyWEq8vu+bit9fEYZIeIQciGIy7bRbXgJj5xyEXIZ
         BXR24JjF6LE5c1md4+KFbYcRLQx2sTcyBpNGUhlvoceEhKMwirKOGrLw8jpmwzxp/g5C
         4m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742354453; x=1742959253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AU+AUlTwRi7J4/S9qJRKbHn4jNyx75v876BLDl3Zuu8=;
        b=pMLnBjNNz5CjEUjUx9Mefk/ziDhjcjzGQ8L0Cm7/8nZRJNDuz5/MyW/g8oNCMIK3L8
         j6tRMJycBxTyy5T6UWkzZT4McD968f6VxUNidODdHVmGkxktVb3SbOJZS43nbRGTR+QB
         0uKsB1cc43qk62k1niwFfUEKH0LqxVkCkFgS7njt6a6z6aOQdBknAeEjox3inlUxpRZw
         bygl2zUjO+R1y4cveIfOMq1TtFjmjG0bM2XTfNeVraAPTji1whp3Cv6r+1eIYGE9/QhO
         45KW4jV5RLiqpeDrwQsIHu3EwzdGHngXtqAUn/Y8CX5yQWa70Dirzd3FBcyPaw2DKiBn
         0dmA==
X-Forwarded-Encrypted: i=1; AJvYcCUdbufAg9QzcR7Tpz2tl5RKDBuXmGA8LkyEmOKJaC9AjgPHS7rxbfAqKbXhWzw6jZvLiTJjL58sNYRs6x58G+Xj@vger.kernel.org, AJvYcCVSSVm2+EKALnsEEh5/IZ8xnZqHoQEuShX8ODRVdqKJ3SWyNRl324yK4i7kky/7w4oqI2skVdT/L6vkRY0=@vger.kernel.org, AJvYcCVimoIYqq9Js1ATKL87bjdqRP2B1l1n8XFMviPt68E1WUbpeh+cKZ6F9R/OnHsb4QfIr/REGY4b@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JQzzKQiL0uBRELs6ejQ0L7fBedi8lgxuL8oKrlpaeu+xyOu4
	Rerxx0+9Ct3kmO7GYArQzY4eOhBcUyjtHc1lTLWQ0VeW2LYRiexkuEkegGJxaoin/VpJvqd6ZN2
	5F5Uf1NZ8w+32bQIAGX5gZRCujeRAtoVd
X-Gm-Gg: ASbGncvA/Hdb9uk3QnkcLnXC04roOyNoC0lj60TU2E/wUbO6zsLEtsyGNCZx5tVhejC
	i4AaABKJAZdV5ofeYxqXIny+Lti7htAGR5PTPdmUu4Q8rGA9Xi1miOgf6DEmexXmA4jH2MT5vuU
	PE1lLw9ISsqj/1M+ZnHA1Cr+99eQ==
X-Google-Smtp-Source: AGHT+IGRMY/e9S9Sj6Mh2u+3AhxWEy8LPGpQParPDviONrLGBwTV8SAZ1Qg0v+jjl46EA2uiowqvuitD/sriMimJ2Bw=
X-Received: by 2002:a17:90b:4d08:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-301be1e72d1mr1323358a91.26.1742354452855; Tue, 18 Mar 2025
 20:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 19 Mar 2025 03:20:41 +0000
X-Gm-Features: AQ5f1JrYKg2Eku5gr4vuNZgjG4v5bYxdfh4YutKAgEfjqGCmIwmOs9_wemfHjJ4
Message-ID: <CAJwJo6bkdeGh0j1ABfrMQ3dRD7frEsNnJERWP8-jJs8dSYFwYA@mail.gmail.com>
Subject: Re: [PATCH net 0/7] selftests/net: Mixed select()+polling mode for
 TCP-AO tests
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Mar 2025 at 09:11, Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> Should fix flaky tcp-ao/connect-deny-ipv6 test.
> Begging pardon for the delay since the report and for sending it this
> late in the release cycle.
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

I think patchwork can't detect v2 to be the same series, so doing it
manually here:
pw-bot: changes-requested

Just in case, v2 link:
https://lore.kernel.org/netdev/20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com/

Thanks,
             Dmitry

