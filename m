Return-Path: <linux-kselftest+bounces-15742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212C957BDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 05:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310731F2315A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E233A1BA;
	Tue, 20 Aug 2024 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB6Kxem6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76FF2D627;
	Tue, 20 Aug 2024 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123936; cv=none; b=gsVHstHbJqD6knjGqnr4ZRfRFyA7oiqCbbGCzZZvvYoroV+5Sff2LTCTRLAfaeRNcThDnOXiYUjVi+JhwtLBfmyonOuCH4ujcTGS3LqKFr4TGxqR4RlWA0UBlpm3o3E9NZ8B/dAdjondRHQPA8jfVg5y6SiOZuWERETwUQigsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123936; c=relaxed/simple;
	bh=Ikp8QHUlGZoFRoqxKC8atllBCgCFtLH80Zna8JP54co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMgNK+ssInM7jHaYBbhVaNNvq8p6TtnbIDcyN/6xc+eBkLrxoKYCGOhQ5YG7rQo3kSHRSCKyQ/NTlGQp/RS8bxkW3Ezezmbcg5538CDyZevzl7IG2K0hKU2mz9mJGuE8Ty1Bl4XJdyV6fMe8ialchjjqwanZsD2glr5U03eb4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB6Kxem6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7126d62667bso2949816b3a.3;
        Mon, 19 Aug 2024 20:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724123934; x=1724728734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfsT65hlvXfFbOFYU/Lw5WoFD/4WxaMOTOIKCSFSVUQ=;
        b=cB6Kxem6HDcxUmKJE/4mUaX8phIL6i6VodG82KXPc8XUzM2VupX16Nn9H+WOE9deYN
         nHIIr82naPKqqgRth5cbSwj9OwZH3m+KFF6Q3YjtI8fIGhQ9mT6GJhcqg4C6oGsJcDVZ
         KRcDO2+8sTqUL9reKHGhGj0gGAZYy0a6nelLGl494nWELrR10U0nM2uIQ2tGlqtJffAv
         vNJB7C2tpwV5aZki6PAyUGJfsCMyUrhG0YSVE0ICp1XsYFkfQ1X8cDCs1CWLTaej55L6
         aw8KFdAw3RIqfsbndfdwr947gydDh//BWu77wf9QF62K1ixbThN745Bi9MJfFyV6bdzt
         B9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724123934; x=1724728734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfsT65hlvXfFbOFYU/Lw5WoFD/4WxaMOTOIKCSFSVUQ=;
        b=wkJ6/pVKoQR/NryIfPhp4zRZSZ1tamKk8HsIDwoZ1RZFrwL5e6dmTvI8oiwOnQK2iz
         3MxOD8whsObCuDqC9GrCRf7webvH7HJTjyE4HYxCCgrPtPkZX0nDWhgvnNuCjNpqRGWe
         HJRae7UE1fUxyCmi9vNPjdkqbCt5Q66kker3utYoVF6ZcYKznUgAmPoaeVpXvQNlr/RJ
         WBICIWPG16cDK6qAG+BHffNgqvDTqH0TmkrjRIlpO/knGPRddBvBIUGhVNVzc8bG8DI2
         lo/PnR6LMb60wfrbjBcnYu/SWqmSq0VctkqUsrjNsIDaaXpxONnHsJd7WD97cnMUxZph
         r+4g==
X-Forwarded-Encrypted: i=1; AJvYcCXRII8oiqOshZyKXuvFemePRAWnsRkg7/Z1RjP+kzl+u0Qt3dB/rvADU75QugRqcoNvRABcrvyNuoGF/qrXYVNc5ibNduyf41+IKyp/epsRWS2PBocrT/j2uyhxXzyavmSXfUk+8RbE
X-Gm-Message-State: AOJu0YwJg8KlSFX4m+5MRrMi6gRlb2NTknwUW232LloO9llWWMlGurtl
	7rx+ojkRbWLbkUjw4YVc8bWYlvW0LCewYdpZ0/3yjJGAbbhH2eVXk8xpDi1xAy2v3A==
X-Google-Smtp-Source: AGHT+IFmMu0Cx/ptoT4ytm3gGO3H29Yb+5vLyFa/dIE5iXrUeHoXU3JXMYvYHZ+kP5OLXOU2auHAQA==
X-Received: by 2002:a05:6a00:3cc9:b0:70e:98e2:fdb5 with SMTP id d2e1a72fcca58-713c5224896mr11687381b3a.29.1724123933914;
        Mon, 19 Aug 2024 20:18:53 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef65acsm7267100b3a.117.2024.08.19.20.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 20:18:53 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:18:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCH net-next v2] selftests: net: add helper for checking if
 nettest is available
Message-ID: <ZsQLFwkNa-JnymGg@Laptop-X1>
References: <20240820004217.1087392-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820004217.1087392-1-kuba@kernel.org>

On Mon, Aug 19, 2024 at 05:42:17PM -0700, Jakub Kicinski wrote:
> diff --git a/tools/testing/selftests/net/settings b/tools/testing/selftests/net/settings
> index ed8418e8217a..a38764182822 100644
> --- a/tools/testing/selftests/net/settings
> +++ b/tools/testing/selftests/net/settings
> @@ -1 +1,2 @@
>  timeout=3600
> +profile=1

Excuse me, what's profile used here? I can't find the definition in
Documentation/dev-tools/kselftest.rst.

Thanks
Hangbin

