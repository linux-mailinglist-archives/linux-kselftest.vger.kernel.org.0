Return-Path: <linux-kselftest+bounces-29833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BE6A71F81
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 20:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64ACB7A25EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 19:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD931F4736;
	Wed, 26 Mar 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JESayp4m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891A18DB19;
	Wed, 26 Mar 2025 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018510; cv=none; b=Hs8EmIAhM8uABx+TzGHOoQcXSKwXtLyDIsuQsNWc0/bcBOdv6Ac6HyB3wiPWAB5fw8uPaUXdbR37PRpxK/yhRUbKG95vgOVXrtaNORQDHLh0DRLzx7vP63BY66iQkcqVVVr39xvSVL5J9OQh2My3xzSFPrlUW9oioft58A+leZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018510; c=relaxed/simple;
	bh=R3+jDwZHFgHkfpJeIfAi9iO05q2wjb/j47dvj3X/kVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdRwcbOYQ+rEV5Azm+4vJIwR3LrTrXGY1D0tzV2BZJxHscDHcSZgBn/xgW91nxzEgfmQlKaRwHY7iK7Zw7OChB9gBT4HuHKE4H/0I5ruXb1HjKTBR4kvUPHsC69RN8UdaeBfnTrn4jowJL2BFpj9AOrKRxE3ITofGUt3YXVXgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JESayp4m; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso298620a91.3;
        Wed, 26 Mar 2025 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743018508; x=1743623308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hHm2axbpU3V3JFuuZFYjsCtM/7SwK7Lx7a+IQpShHrM=;
        b=JESayp4mA4YkbXAkFG3cTTcTpFct+09BdkZNOHRVHf81qZ6UxP/tIYpMNfOMYzFTcE
         7z5aQzryHntxwf1AReE7cDRSvRXjUryJLd9hC2b4Ouueo1YeBWAMy3OrJK2QrOFaQXC0
         GRow6fCY/tVXLka8eSqYq4P15ElFbEbGTRUjv8RkWN+6pyA5bZmu4/tV5CHp/8S8WfAm
         zEktVXvmb32lDLmknacb5ybz8rdn7/WXkaYCFIjapH+5HH/aUJxdNGUnd4n0ENfBrXRJ
         6RLzYMSA8R9HEXc+4hEqv1dWN3UMeTQEevuAiVVTCapATulpVbQawbybkLWMPRdLjZoS
         T69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743018508; x=1743623308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHm2axbpU3V3JFuuZFYjsCtM/7SwK7Lx7a+IQpShHrM=;
        b=bU11EAilO+MH7QzDfaOp28TQsw2XYHowIdNH8KFWEv0Z3/dGM2yEgIhGRpxQmpcVOQ
         VeaMuZDJAorcJCMhLbmn/LXau6jbfgfGgaqFnQxQ3f57/ln0VvLMDwUvBhMI3CEOphWS
         h62j8YEKK0uMWcDXMHaIzhZCr+HE3M9O1SJxmO4fIzuk3eNc3NQPZKPZXEZwOAlNlbFc
         wPBjkumDxYD0LQr2yRsYyLRiOKj1dJL2gKp9n1avcdMT6RdaAaIssBZUBvyKn765yEdu
         lL4oCOogNlmYKPk9JvfGliMEDQwgGn181A2uTcpTVZUCdZxaJZO8tkqz00smMxZ09MFR
         yOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUweWlxPuiox3di5mRjFg+F738m57CoVR+G5PTguGZnZ9NJUKSCVp7SpCYQ9zEQpnWdKT06koFEaBJDeRA=@vger.kernel.org, AJvYcCV+fEuk6+EJfKZywEgUQFAmIQGd3FFqpq5ETwS0tbuqVrTa0kgvnpZyMHUkTgFd+DgIyYAakZllhKHAxtG0B4Vf@vger.kernel.org, AJvYcCXJECGmakaG2UYzdEUjbqf6Yvijaljo1NW4X/a2fJ1+u8ef2N8gNZqyRD6hmlIX92+LiZAgMd3W@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBde2Aishcajd5drVndvhCLRCWuV0zJof36TApzTxlu9mo3P1
	YLUeEh69eE0LqgRyeVRCvG68TAwkEAPoMLCL8tBzFLF9371K5ZmeEK6N79c7Ivhrp+0/SfMdQ1r
	+pU+f43IWdqy8qrWyKFL/eU/Qe1o=
X-Gm-Gg: ASbGnctw6w0iGRqTw3JBJlQ/8hdL0ej/+uxJBG3HVVt/5E/Xa7okIBNLWrmDn80EgPH
	R7HqXgidA/NkGZ1NTrzzfVzjKWrz54eeQ8zMkViDZSuzfZsliDR944Gyw1kavLkNB/VC+1hR41p
	h2wd9kXNXoCqSkNRIQx+G5S4kBcA==
X-Google-Smtp-Source: AGHT+IGwBzhsBM/JtZ7k8EPOnm8VzW08zNVDCOOQIQOum2m1qGzqdwTQHZdQh6N2B1XfiAODZnDoTqlxbd0tJvyDTvU=
X-Received: by 2002:a17:90a:fc48:b0:301:6343:1626 with SMTP id
 98e67ed59e1d1-303a7c5b67fmr1373695a91.1.1743018508012; Wed, 26 Mar 2025
 12:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com> <20250325061525.01d34952@kernel.org>
In-Reply-To: <20250325061525.01d34952@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 26 Mar 2025 19:48:16 +0000
X-Gm-Features: AQ5f1JqsOQUxjRbopti60kfef-_DXcXCMs3YF27faB8PqD1fpjLrlPmcae9aEhk
Message-ID: <CAJwJo6YoGz1aPv5nkJJKa05mxF-Zhc+B4U6kRw95KSduLCApaw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] selftests/net: Mixed select()+polling
 mode for TCP-AO tests
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 13:15, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 19 Mar 2025 03:13:33 +0000 Dmitry Safonov via B4 Relay wrote:
> > Should fix flaky tcp-ao/connect-deny-ipv6 test.
> > Begging pardon for the delay since the report and for sending it this
> > late in the release cycle.
>
> Better late than never, thanks a lot! :)

Thank you, Jakub!

I also noticed that recently, self-connect-ipv6 became slightly flaky:
https://netdev.bots.linux.dev/flakes.html?br-cnt=75&tn-needle=tcp-ao

Seems unrelated to select()+poll selftests changes, but rather to
timings in the kernel:
# # 1249[lib/proc.c:213]    Snmp6            Ip6OutNoRoutes: 0 => 1

It seems that the test relied on kernel adding a link-local route with
a loopback interface, but probably adding the interface got faster.
Seems like a trivial two-line fix by manually adding the link-local
route in userspace. Though, can't reproduce that flake locally on
thousands of runs.

Should I send the potential fix now for -net or wait until the merge
window closes and send for -net-next?

Thanks,
             Dmitry

