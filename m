Return-Path: <linux-kselftest+bounces-41577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E26B58FE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A11B7A4B3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D835D1E7C08;
	Tue, 16 Sep 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJOBkA7O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC3260565
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009725; cv=none; b=U16m69a8Dt1PELH4913J/4uvTBNXk4UykUR5r3LmtfitoNLtlufXiXqDofLLFVWSgGDFblrsMjbWM0m7aurSbZeGMUpZvb2mT7ahZ3vPsoU/tzsPRIhUg/RQPGuoeK3YkAF8YTFUE2ikqx9UoDvrX4aE50txZIQNykk8tIQ1USA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009725; c=relaxed/simple;
	bh=/c+uS3z55K9YBs0B0LxjJ58GG1y6M6O9X37r9lKSK9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMOOGX/VJpO86hVAgyewBQM7nNeRCAkQmoHfEOu1Gs/3p4z5U78+qOF8EmlbQazRnWn00GK/cftIPYlEY+f5FCRRGTpSquIhe0mosvX7lNFLIgucT5qv/rPSj+WRt6dLF89SgB26WK8Y50UkAWjh4UJdL6oHKeJ7gVSNczs8NRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJOBkA7O; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso4399446a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009724; x=1758614524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJuKOn+I6/s0kndL2t+dNQy82N/2q2vB7ldGvEkpcpY=;
        b=KJOBkA7Oa2QeHqNxohLIOsqc+v3p53Em9irQA8SX8L0kIwT5OcdlQbKkYU7rFl1+Qd
         OqjDHKVF11FC4+JFygQNzYTChQtzUvCzv53DnhO7TQcYnhDqBBDvxcqZecuOK9Po7lDS
         rujpVZQGXw+gfgfmsQLHGAA0PAApUI017DC+XEXzyq3HTQejwXGwLyPThyB3/kJZD5PS
         pt/zhqZTE93bibqYauPa43/eh4GVdnParhCpXG0iuO0W/6LdiA000E7UPUxb+fmvmZEV
         ERoboHtWoffqs1xuLrgpy8GxVqgk4jKa8Rir/CHpo4nU9hk4Ai9wz6+uutk8h/bsSQhM
         jApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009724; x=1758614524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJuKOn+I6/s0kndL2t+dNQy82N/2q2vB7ldGvEkpcpY=;
        b=RU3e60Lyc+MjBr7lXHTdA1qPuWW+4/s3dTwlHPQ3gi22rCITdNdgzaet5oHGSgJ8MI
         qwm/vepASgmpQ+EJgrtiENH96goNWeb6HPIk5Um6LBnqXgqf3pr4ZMJsRi5WwNoi6ddI
         2HBf3/YpvzHfbWzp6X8qrWUB1c+0nuvbJvET/lkPS4QEOD+nkEz1SCIPQZleye67IW2R
         EyLw5RvssH5LeQkvm9HSrrf2ugQ9O3W39ij7MbCo7DbtILcxY8YJoL6ZSkRi6Aq4r3XM
         6cdaP4v90jSG6AdTcru/jNdXMO+rSm/B0Tvxf86wldU9YxurMy5Vl+bmL/xDz5A34+Ub
         HmLA==
X-Forwarded-Encrypted: i=1; AJvYcCX+f2B+L9fOSEBfuqPOxAA9XXe6kiI8iynsPnbUQ9nmWZ/QZ2i6sBDuFe6/D+2Kl1dTcQgCmY2jqsVZUPovsog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtMEKBarBouEv8ADF7Jv/mdqiHt3tvlGHQWTci3J0EwodyzJj
	Va7bOBgoLAYhWSjES9w20imDeiVHsGgVBfSd3qU/TW3I04KciPfEj+sgUqu1J2lkCBI=
X-Gm-Gg: ASbGnctY19dcuyuKchkho/fLSXQpscp2+lTZqTAcv4nL2vPHIvaPAHG1zusdQd711+z
	R4+R1utVq+I8aENWt8R3gLBVQz7aqKMInqgZj8OYz/xG9ssBRZdQKZbyiTy2WKdeGBmyHMMTjNx
	Z7DBK1ugGuTgyR/wfmzxODRxfwHk2g1wvLdcfhjlPUQ7JeOeUKt3c02a2qx0Na+jOE1saI+V3rB
	fwn3XM60ERVd610GP9cl+NTL0kJHxwGqNClx9RthX7SzP5dLanpTvmCKouvUj/JuPbcSZRuL9jB
	DPF8Az4UWNPusCq7xk/1D0mFhu9BQk7JhkuWNOsQN9pY7o1mt3CAKtwWwd7X0lY9TohwEaOH7+8
	NGqPr4wGnRNcn43iPR6iL43csWKenSoMjfOXP+A==
X-Google-Smtp-Source: AGHT+IFGJgIQjV2oZ020VBsoaPCjwBwY1Kduxv4+TX9KlBn57PgRnR3curv0ncKvPfaRwSENG5MGgg==
X-Received: by 2002:a17:90b:38c3:b0:32e:37af:b012 with SMTP id 98e67ed59e1d1-32e37afb746mr9417837a91.0.1758009723634;
        Tue, 16 Sep 2025 01:02:03 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b346dasm15661934b3a.68.2025.09.16.01.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:02:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:01:56 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net 2/2] selftests: bonding: add vlan over bond testing
Message-ID: <aMkZdJqkg8sPThzn@fedora>
References: <20250910031946.400430-1-liuhangbin@gmail.com>
 <20250910031946.400430-2-liuhangbin@gmail.com>
 <a3721ff5-9e64-4a9a-a207-d53af7f8a10a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3721ff5-9e64-4a9a-a207-d53af7f8a10a@redhat.com>

On Tue, Sep 16, 2025 at 09:05:36AM +0200, Paolo Abeni wrote:
> On 9/10/25 5:19 AM, Hangbin Liu wrote:
> > Add a vlan over bond testing to make sure arp/ns target works.
> > Also change all the configs to mudules.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> Does not apply cleanly anymore on top of
> 71379e1c95af2c57567fcac24184c94cb7de4cd6,
> 
> Please rebase and resent, thanks!

Re-posted, thanks for the reminding.

Hangbin

