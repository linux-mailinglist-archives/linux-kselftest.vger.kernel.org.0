Return-Path: <linux-kselftest+bounces-39270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 138CAB2B67B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 03:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3877ABF9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE00228640F;
	Tue, 19 Aug 2025 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Psp07Gcg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1527B500;
	Tue, 19 Aug 2025 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568259; cv=none; b=KZzRvCWkE8WY1ndKEJ7aiWgtF2OZyHEgldYZ1DmEmM0Fv782FTYkhvkE1RhbfBpru0u9R/MHtt/hsJuq+QEMuybrOTbcClKBJiexOrMSv0zDChYl8JEfH9e9pdzv1KLHLZzMJjM0SmkWwLhpLwFZf/0Tt2y6vI5viuyryFAyysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568259; c=relaxed/simple;
	bh=8YI/vhRAyY1BACNcDfxid6+yLfuGnYNNUvXA//GkKow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf/718TK1oAQhSyoQ0mQe1n/sZCdRYbwbainanqo+2TRiLcHk2/f0WKbSxgtWsQbv5d/Cmrqt6ZOhekpVg3uc6AbWz9DrBISs81Q552GE7aQhcHU56fod3ps26FEmVVtDAwXyBT0DQR/CEfs5E6LDzXaOiaNk+t0GSBfRAYV3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Psp07Gcg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2e614b84so4511140b3a.0;
        Mon, 18 Aug 2025 18:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755568257; x=1756173057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kGdHVKoHsgwhDb4EIcQAt0pL/4Uny3lwxFy9guJbrs=;
        b=Psp07Gcg2QsSew3vMSJRh1Tvk5pAyWUKIYB+3EEfvlOrU1wo1rZ3gixNeFdZg85D7q
         c6/RJKkylzcvMkKZrlqeZ+czJegOh+yBdH51N1Qj+wb+CASNA0IGi1dJ37cS4FAg+KlJ
         3IaZl/i5NgbzOuzL9CF/tnRzoxZ+U0qyBAmv2WwlFgrR+su22L7SO0P1vA9+bJ3JZE3W
         ZV0WO4syDEZVouUTNVlELcEv++lki/rzqFbB1V42Uv6TSft/UUpozsZ8/JZKT3cpi2Ir
         VtIH2/bLRRLmVDMnIakEzrByGMSIDmt4Nym7EShhAmDsmxaqHgoEW+GZrxrRuvG5GTN5
         b+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755568257; x=1756173057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kGdHVKoHsgwhDb4EIcQAt0pL/4Uny3lwxFy9guJbrs=;
        b=Qd4IMB9T1wt4K7PLpiQh/T5nynrgNeoFUo0VeO8Tk6AGlo4jMNEU2Q1vyGc2kBh2OT
         2b0ZVWmyLwCv7n2Y+MEGDya10fCaPkBpXO70+TrYELE7jbAY/dMqmVwscGviUvFdgT2k
         81K0b6MMJcWEb5dvpuef1oQBT/F2vqJGRaPxva66Djo19QRW0KrbKI0zA0s06ZGgH5Dw
         P5wOkJ1CbhEPU+mBzqzdGW/M2Fv9ycH5+CxDHm/00U7MEnq4sPYUtwIaaKt4zMHK4qR4
         7vaABmHjMfVQFar8gqTI2RYw2hIDTw4nE0o30NuNi4qNTuCT2RaketSlHLiEMiDX4kd4
         QL4w==
X-Forwarded-Encrypted: i=1; AJvYcCXMg27CEJcmRjx8I1RHHiviPTLHsmUraOkuF3whmvoRJsn0A611wxzm8tR6xrTUjkqf8vI0OFdOKIl7E/Po1Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+opCDIz9b+lGmkjAEeSYS/j1TyisKwnTmxAwYAUG/oj2qTj0
	ClASRP4sHm43lYHZrDEmG8PYVFc1dHbHeLFCOEss8KEU8CnlZTWomjro
X-Gm-Gg: ASbGncv9dqk1S/t8S1KS3KSluBW83XEzRKv+ZHOU/fyC4p22rsMDFRMMc331f4pVTF6
	RFvMQ7BDqahJadYHsvvGLgOPdf3TnWBy7BFpar2WfZtmn6E8+o5sfuuCkxsFSLdzZzq+Tl9O/jq
	tDk3ubK2xR9U8rtHPSdfx2FoVg5ageeLLY0MDlENg83eABBBnp/FqcvgTLqCCqo5UjIW9vp7QyF
	0FGrl3Za1vJoh2R8AWrbK9753vDE3bEKZVIkO5WdAO/DYS5+vQKwGboJyG/zGc/KK0qrjqIWW7W
	+lZtZmIeAIuw21LEnQJdZ4+gEm1KwT0HHZGPNp6TJbJNG/Oruq7YJVoOxhq/ayNjg13OkbPloRD
	OIVx3RzNqEfYpKWanZHl0979kwGY=
X-Google-Smtp-Source: AGHT+IE2ghkvBT/YA8iBPGrHEog2EF5t7Zz1GJV2BZ5XDsMCeN7HPfCbatTE7JS9OmJRpnBsg5rxYw==
X-Received: by 2002:a05:6a00:3d0b:b0:748:fb7c:bbe0 with SMTP id d2e1a72fcca58-76e81148983mr1112139b3a.24.1755568257394;
        Mon, 18 Aug 2025 18:50:57 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d52a700sm865255b3a.83.2025.08.18.18.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:50:56 -0700 (PDT)
Date: Tue, 19 Aug 2025 01:50:51 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: fix addrlft test flakiness on
 power-saving systems
Message-ID: <aKPYe8t7kR_u7DZ7@fedora>
References: <20250715043459.110523-1-liuhangbin@gmail.com>
 <20250818183012.35f47956@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818183012.35f47956@kernel.org>

On Mon, Aug 18, 2025 at 06:30:12PM -0700, Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 04:34:59 +0000 Hangbin Liu wrote:
> > Jakub reported that the rtnetlink test for the preferred lifetime of an
> > address has become quite flaky. The issue started appearing around the 6.16
> > merge window in May, and the test fails with:
> > 
> >     FAIL: preferred_lft addresses remaining
> > 
> > The flakiness might be related to power-saving behavior, as address
> > expiration is handled by a "power-efficient" workqueue.
> > 
> > To address this, use slowwait to check more frequently whether the address
> > still exists. This reduces the likelihood of the system entering a low-power
> > state during the test, improving reliability.
> 
> It flaked again, after long time of being fine..
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/259361/15-rtnetlink-sh/stdout

Hmm, I think we need to know what's the current preferred_lft and valid_lft
on failed test. Would you please add a debug line so we can get the info
after failed?

        slowwait 5 check_addr_not_exist "$devdummy" "10.23.11."
        if [ $? -eq 1 ]; then
+               ip addr show dev "$devdummy"
                check_err 1
                end_test "FAIL: preferred_lft addresses remaining"
                return

Thanks
Hangbin

