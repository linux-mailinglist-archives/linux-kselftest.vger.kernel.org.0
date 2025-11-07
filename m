Return-Path: <linux-kselftest+bounces-45093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A3C40394
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 14:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B53024F2426
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9231A053;
	Fri,  7 Nov 2025 13:55:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A6319857
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523742; cv=none; b=WWY5g1kgQP9GGNwvgWMheBEgpPqNczIe14yAp2kCEz7+qyvjDlHjyD2km2VreIwcXolWhA/UWnHr6Jt9d2fKa8JygpDbtE9LNrkM6kCgUhwkgI9RKPCtMjwPrQ+Jq93rr5YJisfFwKj1i4PD67aOgs0z4vycRPdAiR91jokxyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523742; c=relaxed/simple;
	bh=Hxb/gWTOsdtHlXVI0iFMLTENSvzBdCoasJxqnUiXeIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2JuLVwo8Zchj/ZwMmibsNxzvddv+EASkMvquYeceyqp1+hyYEe9rrZ+5y735klj7h4llSKE9y8H9wl1vchxXAYnSY1sBkYGMqcygS4/zfZvDm6lMpHFS3hvbGKOkW7P/kJRl3TSB5BNFF1wJ1Pj+OItenrXueaPcKUDLQh9zC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso1579320a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 05:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523739; x=1763128539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZE6WJJFFBiJVTyI5OvLy2/eZGTZ4IdwtaNd7dO/eBE=;
        b=PnZYJbnDcmhbCxPY5o2CPA14Ym/+4Rxc04sPFBHWiJbNF4EQ+wiwzjHe165YyNTMyn
         ipO+MxWv6Sjw6dcEFLX+mD/HavPkX2PCFuYoJqanPHHtTh7bvLTKzkWl7rSJQnQX0zpw
         RLgP2qb6SThdbXIlPNgFeYAoxSled8gSLEwto6nKs7rYhmyFkxP2RwYLOX34fvIKwugm
         rvbATMZ8x/4CDxOnHB52SO876th7oA4Q95EoF82vCfBRDSIydF/pzOFlqQR7YeumWXZD
         4JdMFLGfr7PuWjYmIZhFWxBsGurMtMnsu2EHVHoOAWPR+leZ+UIK8TZoXq0n6yNCdtgY
         Wjkw==
X-Forwarded-Encrypted: i=1; AJvYcCXXw3ZZPBqsfgrWxGqTPBoUzjTMjJpcJs0z1nNgj98ifz+9oO9Ue8ACibi6cP+fdVgzDB0zQBQrZcCr+QX5gpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTS8HZEhz2tYLl84ouOLX+CbzmZT2fTciopDSXOhlWkn5hDS+3
	PUnMNrDOFLhfALtoWbXTfdAZ004HorFYtGXAyqu/33pJYU8f6be+Bku3
X-Gm-Gg: ASbGncseUo5NLvBkVApRhpeFENVrdtBi9kmBlx1Tk9wCBHJojkPw4RL23DRBYowDDqN
	0eph3yeqCG4cVahP5APqx36Agbskye+vkTYir6/F7naWZ2pdJkEEcFZ6ZSaIU66ei97WJNVEn3z
	YwqXuIW2aOVqCccusHbW1NjNSKYsY6LpvuTowDk9SkFcI9N+W6tpsbz6za14xUXyr/pgy8r9rNs
	q5y4VieVFsRvvht6yjNW3BsiasMkLBHxS+zDrFX6ih15p3K34LzyPCfTCV6YPtjuty089dNzu7D
	8a00TJRyHZscdKDirKs+KsI33z4kdMZkixxX27Z0NWO2sN9GmYj6MhP24QO5mS8Si4o+4Ytd3Dw
	FwKBXkunlZL5aUDBA4xhqVl4W9Rkw8B5Ro+mEfOMWfLhQAl4ZHwfiGN/7uALYBbtoilUjOGeGlC
	i6
X-Google-Smtp-Source: AGHT+IHlTScJC+oO2U1HIWORq+rSxPXReipszaWTgQ3KvvBT9dPCs3MWAerxSZPOSFFxVPN9CHWH7A==
X-Received: by 2002:a05:6402:3550:b0:640:c918:e3b with SMTP id 4fb4d7f45d1cf-6413f0f5f4cmr3131005a12.26.1762523739041;
        Fri, 07 Nov 2025 05:55:39 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6412a27d68dsm3303524a12.9.2025.11.07.05.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:55:38 -0800 (PST)
Date: Fri, 7 Nov 2025 05:55:36 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v9 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <f44ccmfiiq47ecug5jyfxsi2imsytzhg25szr5yotpdry2b32h@5hxqifqyvsjz>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
 <20251106-netconsole_torture-v9-4-f73cd147c13c@debian.org>
 <aQ3ExWwuiiN0xyBE@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ3ExWwuiiN0xyBE@horms.kernel.org>

Hello Simon,

On Fri, Nov 07, 2025 at 10:07:01AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 07:56:50AM -0800, Breno Leitao wrote:
> >  function create_dynamic_target() {
> >  	local FORMAT=${1:-"extended"}
> >  	local NCPATH=${2:-"$NETCONS_PATH"}
> > -	_create_dynamic_target "${FORMAT}" "${NCPATH}"
> > +	create_and_enable_dynamic_target "${FORMAT}" "${NCPATH}"
> 
> Sorry for not noticing this when I looked over v8.
> It's not that important and I don't think it should block progress.
> 
> create_and_enable_dynamic_target() seems to only be used here.
> If so, perhaps the 'enabled' line could simply be added to
> create_dynamic_target() instead of creating adding
> create_and_enable_dynamic_target().

This is a good catch. I _think_ it is worth fixing, in fact.

I will send a v10 with this additional change.

	diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
	index 09553ecd50e39..3f891bd68d03c 100644
	--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
	+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
	@@ -147,15 +147,12 @@ function _create_dynamic_target() {
		fi
	}

	-function create_and_enable_dynamic_target() {
	-       _create_dynamic_target "${FORMAT}" "${NCPATH}"
	-       echo 1 > "${NCPATH}"/enabled
	-}
	-
	function create_dynamic_target() {
		local FORMAT=${1:-"extended"}
		local NCPATH=${2:-"$NETCONS_PATH"}
	-       create_and_enable_dynamic_target "${FORMAT}" "${NCPATH}"
	+
	+       _create_dynamic_target "${FORMAT}" "${NCPATH}"
	+       echo 1 > "${NCPATH}"/enabled

		# This will make sure that the kernel was able to
		# load the netconsole driver configuration. The console message


Thanks for the review!
--breno

