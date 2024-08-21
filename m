Return-Path: <linux-kselftest+bounces-15810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF749592F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 04:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7DDB23B56
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 02:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999B14C588;
	Wed, 21 Aug 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXN8qx7d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA042B9B3;
	Wed, 21 Aug 2024 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208103; cv=none; b=ja41dDgW29yaIXKSs5on5fCs9CSd3N53vp6LHg2LoCsK5zIMpkXBhXGNSEu3wOVZqYx1EnRhH+J4iRUPR6hucHuSh4aWJszfDgbcs0ag6yUf8aZprbilBmUibcrqoTSLOULyXhfE8Wlg0aDk8p3Yv36Q5DynPdEut0GdZPTdy2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208103; c=relaxed/simple;
	bh=Fm75PL9EjmbWl2YAjD9O5BKNbElsVbmfWrYqQxL3UL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr5w4FQrXkaaSypLVoMmxpkfcWUV7hmhqnehLgyd9eohmsyG+6ILb9LY40joUm03pMhojcKLxlxkFCdOxzhecJhFAYTmoxK/nkTacYUN155KmCnTJfWdmR6BsnFVV5fRA62By4rrl5hEUhyhicMjhpB1ZoYghYhi30dOAcvRHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXN8qx7d; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so752172b3a.3;
        Tue, 20 Aug 2024 19:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724208101; x=1724812901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+CcK4onmz3Ym2jFPKhCXT1QW3YMtaxDAwzngzEDZ2JM=;
        b=EXN8qx7dQ0nzq+Bh/0ovAI4IRUnGihzVTuG9P9XNe0jdBS9jFFPmI5qQT/sTO+dUB1
         vpvP05XxVbz5Zles0koMLpEHoLyU8l63+ypMG1XNEbvEdFa4M1K5JcifRcnbBgNsm1O5
         ++uMvzBTnrI2GmpEcKmev56UJ6PTSCWqYxp2ClmInBNKAlgU7g3CzEuk6y7xpfCnnq6K
         KjZViQ7FoF90maArwk6G8iN41pObQtGsTiZlyHs2BgxdSAaufIBlnOAfW5VXPKTecxgq
         d3DgGz1m++tc1dftIE6fWppmJF8PZt01lK9YQNetjSW23oPT0qJKMDAe+2Y9BIHnoML7
         CALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724208101; x=1724812901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CcK4onmz3Ym2jFPKhCXT1QW3YMtaxDAwzngzEDZ2JM=;
        b=G78Fws4fllWIRdktbjkBFXBzzlBCS6h2HxYEOkg6EUkUYpkyKcrIsLBDQxvY78OFsJ
         L7aisR6V2wopjvpW8IqhhRrUhmXG5FFUiQHGJylK23Gbcs4aIp78Z5euPvjdok1AxFZF
         fWSsX8YMXxeLvtags3kTgPld1lM0tXNY4EsLtnyHKeXZZkkZX05K5nwc+q2APK+qjFts
         kYtt00oeNeaRUSUw8u6jZpEwiGVhP54reuXOAXEmgi7jYBws2LsnXqs1b3dJcDRYNA7y
         oa6eySoCU7jJLiqW6rKhPHat1hQecidAOwamCtuHOQGJl4oTaJoqeYk6YGKTpRlQF2ym
         GUgw==
X-Forwarded-Encrypted: i=1; AJvYcCUcHcMgwOZzzbdQZLQmM56KTtvJkdG+bGQWhFArNkV2NPJYezwXdYgs+Kv4dJ7+IL1PAtLPzGWt@vger.kernel.org, AJvYcCUxJbqKwD4NIRLGT4BOdlb7tCeTLZ5Si0rAHQshJ19HaqQmUUdoKfqHM9eC9VhnjJku+rdxnhrJQFX5yWiT+zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZIl1t/w+kuUar6/kRkosrW8wyz38ErPZU/xLWNOjLmZGWt+q
	tNAE/FEcC4J+KbBLgt1ZIyrUZPc+eFK6jgh9xfAU7HO2P5eO1MCn
X-Google-Smtp-Source: AGHT+IE8tObT0gYzk7mwyUFkdDc69vCuRGcFyKErNdokR4UtN3ZWAl6g7lHQJlBOH+d5lADNggBhcQ==
X-Received: by 2002:a05:6a20:2d23:b0:1c3:a63a:cf04 with SMTP id adf61e73a8af0-1cada05535cmr1257301637.20.1724208101111;
        Tue, 20 Aug 2024 19:41:41 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20246816eb4sm36526295ad.87.2024.08.20.19.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 19:41:40 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:41:35 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, idosch@idosch.org,
	Ido Schimmel <idosch@nvidia.com>, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftests: net: add helper for checking if
 nettest is available
Message-ID: <ZsVT3yuLAhfw91XE@Laptop-X1>
References: <20240821012227.1398769-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821012227.1398769-1-kuba@kernel.org>

On Tue, Aug 20, 2024 at 06:22:27PM -0700, Jakub Kicinski wrote:
> A few tests check if nettest exists in the $PATH before adding
> $PWD to $PATH and re-checking. They don't discard stderr on
> the first check (and nettest is built as part of selftests,
> so it's pretty normal for it to not be available in system $PATH).
> This leads to output noise:
> 
>   which: no nettest in (/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
> 
> Add a common helper for the check which does silence stderr.
> 
> There is another small functional change hiding here, because pmtu.sh
> and fib_rule_tests.sh used to return from the test case rather than
> completely exit. Building nettest is not hard, there should be no need
> to maintain the ability to selectively skip cases in its absence.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

