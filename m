Return-Path: <linux-kselftest+bounces-22240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1928C9D2182
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 09:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD21D282856
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1096196C7C;
	Tue, 19 Nov 2024 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdd1dbvb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABCD1A28C;
	Tue, 19 Nov 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004599; cv=none; b=AwNlLxXsXL6AAmyZrwZ8auPeE8CPCffB0EGGYDv9vWDW7IdSYvXLgk8IUN+FYoxi9ByprREtbEapTeikKnjrIGIEicxuTFyxJXurqAgKqNjlwJcHCFsqGfJHSzKyRpT2K8d8oVFLbiEfgEv+5nGcSrndVo1pxx88YWWwp6VmnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004599; c=relaxed/simple;
	bh=N/n/9VQwKxWlOdS9qxgmUQkfy4uKNtrkw5TJvWo/e2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s66OLIdUVm3O85/AQk/PmpV/ab/4/HaQLqO0oIXVy5RHCPkT2cQShiWDoxtBEz+tTX9L0ibPmq7U7XRPqVNLd/q/qEOU0g2h5069wpYRB5+3Xo/63rXUsQ61Btp+XPCmw/rFl1g9MQLrZiantJ16//6L2cTDaV/FG3RTvAULV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdd1dbvb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2035451b3a.2;
        Tue, 19 Nov 2024 00:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732004597; x=1732609397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3y11cVWLnbMeLUtsLIN+/hTQ1x168DrE/MVNBKdLI7U=;
        b=fdd1dbvbijfX8hUHS/v6rPE9ySyfXzzae81GiaSVhIOZVpPYWBxye79hsZw46E5z2D
         WscvPER0DroNVCvgSvttDCX5PGL1RF+nrNpRRw1eCIP7EQC2GyJYS+/zJ4jUJ2fPeZi/
         TMSgtygbtQfP0vJPEP47GOeP/ZVJJFf3t5fEla1nwl/AJVls8254CYxpsxluUJhfJdOO
         kpgLi77YLYiKvJE74Qw4ErCEBD4CjrQe2sDesFpBAosOk1Zs+8FLfBPw5ChLB1v9BHEy
         TxPF2xI0a5vMsxSwIR1jfTKtrvMp7P+/L/e8rqVk2flNEwyL2JieU5RyarwCdfel1Gw/
         ME2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732004597; x=1732609397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y11cVWLnbMeLUtsLIN+/hTQ1x168DrE/MVNBKdLI7U=;
        b=r/+YW/4b1l/KBh/06iOAhTnksF36YvNG+nvkt3Ws3J5SDa3gNFs6DhpKpSfJAcbOlX
         L87XBE32UOndVDnCaYp09MoamVAq8e/M5RppwboBPSLVrwfXzbjxQ8ffZQLTvqGAhl/K
         wPwAa11StpYFqOtV0tWj78fzeA9NcSByIFzywWf5tECsb/wCyb4pItrZzbjgNA8mYqsm
         ObjIDi+OFRq4NL3cFFeNbRtB/Brg9QIfthl7VXVxnVqByso4KVmrTR6J9st3E1mzHO77
         Iv/ePGS0Bp/81J2Q3NWycvoPcOD2BEP+CTs5DF1KsUVdq8Th0vO1jV8mdc0PUcjZKh4+
         J/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWG+ZXyvCpXsFJKf4krQVc47BZb5MstjQG7IbgY1TsP0KKhsccW9sOrHyYHj6mNZ7VCK3XN/FJPrKxes7w=@vger.kernel.org, AJvYcCWv9XmHp2uTbYNRpxUCl+tOSz9Dbc9xOj25oRo+V96N5C+VwsVwalkFF7F0WGmqcsey68hv5UrWIaSz9jli/lTj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52ZL17y33Ltwhk0L0GqG+yo+quut+RFmC/5Hv/hXXqVwCDGKy
	vrwBpvdj24qdvDf6QUtsnn+JofMeiu8JUn7IkVN/NZ6IFjywTsbY
X-Google-Smtp-Source: AGHT+IHUzfXK4t/vY90yoGZGr9Ob6wWwgcqt4R3WqvOLtnjNgbBrO2rhbG8JW9p6ym2zjueK1suoLw==
X-Received: by 2002:a05:6a00:21cf:b0:71e:6eb:786e with SMTP id d2e1a72fcca58-72476bb87b0mr23612285b3a.13.1732004597303;
        Tue, 19 Nov 2024 00:23:17 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711ce30sm7459121b3a.54.2024.11.19.00.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 00:23:16 -0800 (PST)
Date: Tue, 19 Nov 2024 08:23:10 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Message-ID: <ZzxK7hZSF7nPfuOj@fedora>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
 <20241113125152.752778-3-liuhangbin@gmail.com>
 <CAH5Ym4iVP0XYrb1=7QhDqhEO54vpSJGFGHaBnuM1qpua1p5-tg@mail.gmail.com>
 <ZzW46QZf5rzj4tMp@fedora>
 <CAH5Ym4jGZou27-bwGqxHAf2AHWXpT0=wOa0XNNuqtG9OOhi8EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5Ym4jGZou27-bwGqxHAf2AHWXpT0=wOa0XNNuqtG9OOhi8EQ@mail.gmail.com>

On Fri, Nov 15, 2024 at 12:59:27PM -0800, Sam Edwards wrote:
> Hi Hangbin,
> 
> My apologies, I should have shared my version of the check function
> before. Here it is:
> 
> ```bash
> # Called to validate the addresses on $IFNAME:
> #
> # 1. Every `temporary` address must have a matching `mngtmpaddr`
> # 2. Every `mngtmpaddr` address must have some un`deprecated` `temporary`

Thanks, this is much clear.

> #
> # Fails the whole test script if a problem is detected, else returns silently.
> validate()
> {
>     mng_prefixes=()
>     undep_prefixes=()
>     temp_addrs=()
> 
>     while read -r line; do
>         line_array=($line)
>         address="${line_array[1]}"
>         prefix="$(echo "$address" | cut -d: -f1-4)::/64"
>         if echo "$line" | grep -q mngtmpaddr; then
>             mng_prefixes+=("$prefix")
>         elif echo "$line" | grep -q temporary; then
>             temp_addrs+=("$address")
>             if echo "$line" | grep -qv deprecated; then
>                 undep_prefixes+=("$prefix")
>             fi
>         fi
>     done < <(ip -6 addr show dev $IFNAME | grep '^\s*inet6')
> 
>     # 1. All temporary addresses (temp and dep) must have a matching mngtmpaddr
>     for address in ${temp_addrs[@]}; do
>         prefix="$(echo "$address" | cut -d: -f1-4)::/64"
>         if [[ ! " ${mng_prefixes[*]} " =~ " $prefix " ]]; then
>             echo "FAIL: Temporary $address with no matching mngtmpaddr!";
>             exit 1
>         fi
>     done
> 
>     # 2. All mngtmpaddr addresses must have a temporary address (not dep)
>     for prefix in ${mng_prefixes[@]}; do
>         if [[ ! " ${undep_prefixes[*]} " =~ " $prefix " ]]; then
>             echo "FAIL: No undeprecated temporary in $prefix!";
>             exit 1
>         fi
>     done
> }
> ```
> 
> Of course this is using awful text parsing and not JSON output. But
> the idea is that it groups addresses by their /64 prefix, to confirm
> that every /64 containing a mngtmpaddrs address also contains an
> undeprecated temporary, and that every /64 containing a temporary
> (deprecated or not) contains a mngtmpaddrs.

And I will modify and use your checking version.

> 
> This can be extended for the lifetime checking: when we build the set
> of mngtmpaddrs /64s, we also note the valid/preferred_life_time values
> for each mngtmpaddr. Then later when we confirm rule 1 (all temporary
> addresses must have a matching mngtmpaddr) we also confirm that each
> temporary does not outlive the mngtmpaddr in the same /64.

Since we add all mngtmpaddrs manually, which valid/preferred_life_time
will be forever. So we only need to check the temporary addresses'
valid/preferred_life_time, right? And on the other hand, the preferred_lft
maybe 0 in my example.

    inet6 2001::743:ec1e:5c19:404f/64 scope global temporary dynamic
       valid_lft 25sec preferred_lft 5sec
    inet6 2001::938f:432:f32d:602f/64 scope global temporary dynamic
       valid_lft 19sec preferred_lft 0sec

It looks we only need to check the valid_lft. Am I miss anything?

Thanks
Hangbin

