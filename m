Return-Path: <linux-kselftest+bounces-37226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE78B037BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48CB3A34D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562F122F767;
	Mon, 14 Jul 2025 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtP1AAUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F6197A76;
	Mon, 14 Jul 2025 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477560; cv=none; b=WicgNWAXlQstuuYcUy2hVt8ePs/KM0/dQcMt2ZYgqW2gVGsqQ6R1TSTGhd3sbosPoFVw80i0R+s8w7iBgVFE1eK7m9AEUwifJqINO9/Np6rAbOqunbUt38PwvJpukMjGMz4JHNdyIyZhpunldnvACnvpGcDXj4q13OOZez6Z9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477560; c=relaxed/simple;
	bh=l3SbGZ/j/MQ0MLkePGLUv2ynDTKLvLbNxDu5EfZaO6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO/A2FYJzE+nY2nygaGKWr+cTlz0bHCVPck0F42kZkH6d+UWHPPjBCT3hNYus7FrHsLk862TSHzsAcb/bLuniC06TkIobkdxl5xzLmJMCiJyfra3FVSdYgFIB9xXvpccYFq6ThCh50YpWICnbsSC6ZY1d0N9WknJXDMrYXe9sTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtP1AAUU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23694cec0feso35031215ad.2;
        Mon, 14 Jul 2025 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752477557; x=1753082357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+GB75tN/aH5Mff3Qa2xIMswmA0ct5MAX3rb2rtsCaZY=;
        b=TtP1AAUUqLpEAuHPZR7W7J4qDfjskDPXxlDeCYt+KudEyRpEcPKAWgISfs8ee/r4aC
         Xz3bYAqFjFBBnw0ukQwgB6KbQnOUrCBRLb1dcLG6r3eCTle7PoDbISeJLyKJz58Ne1O9
         q/vX7ghHpk1yR2lPDVFsrYIosn3EKpEUa3ZMxVJAsmQo9kOGxUgHHHOIJWqCkhd0SarE
         rGVsadqUhwdHLRpr7/ATjiO2KSqBuXFQmryJxUBNeVvh2BCCX0FFtKiSze3NjGPFXZlA
         6guoX8a95kkz1Nhl2fXlgY6c/Ju2v7HKoK373yzdc2YG4jou7s7cV4wf4WZALB+PHqXA
         RJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477557; x=1753082357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GB75tN/aH5Mff3Qa2xIMswmA0ct5MAX3rb2rtsCaZY=;
        b=RlQP+x129/y0lwPheyi1P33YYoFCvsQ4QZOGOBUcuxB2UxM42nVuuqRCmdnTaepjsV
         q/zQXvXVSWOCHnnuzT1TOrvPIThbdJfHOSwYqCvrVIgvQOCNEHMIZOuZv2ohcSU0ev9N
         lujNJSBsuFoVnXdH21XrSFfHMmmDerR7P9KviY1405wl12lYwdJ+/ZccRpy38UyeTvM6
         F0G8z0ZjjSbwBcSAcQUlcuvL3RfrYlZ9o8KljnA8oCDrzy83Ln2shG8KBzF+qnI8GrrZ
         ND9Yzc9ifm2PnZxmwWBFQQbYEKqEzKzfG4Llq0OaONX1eFsEE458opAZQY+OQQggt+7m
         IOpA==
X-Forwarded-Encrypted: i=1; AJvYcCUfcZPEBBqMihkKT5AJPa7s5910tnlpY+jXQtrAuMVjOTGfykVjXhmT3Kkw30NVpWGMAbRJgy5T@vger.kernel.org, AJvYcCUkM94ukm2cdoYjmOyrQtlU4LHaWzzyxCSfZr8XHYmdlfVbm33MjpJFc+EineBqbX8L+j/sJdmThhj/8mfEpi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMKbjBToaaApAb/7NR8VREdjuUDdtB8EbaaOdN6lQYoLfYR3C
	7u7/FSp8LszjaJrQ2Bl7jDDJHtxb9UIiI3qehxVVEp+a3GtiGA/hp5XO
X-Gm-Gg: ASbGncuaHoqx7z4Pf0bftGrJKFISBi7sWNutXMUP1az3m1u/f0ujhSnBVI9hZtAp+qi
	fozW4dSEUzTV0kSXHTQ95TsrDW1qkZU8fr+EosYzKD7upFmdkv4LFQtfdXeKoW7iVx7UfIgK8CB
	tV+rhT8lyQdNsmLr9egRHPQMfC0WHQZMPFawiEr/09DAgH6ang3oJbvkNiaHTTrCSQC0lQNstW1
	VMEhl4vS5U8JcEwDwkMGUjPkXP/z2DuVNHshte8Bgu8WTA4gxp9kZ69eLWS0zsKwPc5OgjpUAbU
	habKOT/54xCy6BpJGzCEtcaN63pwBLOC+9e2AceBkH9JIGjRv7ywVXFXr50NGL9uSM5Fw3PAuy7
	QEGgTiRZZgkO1IAMgQSnBBATl1cI=
X-Google-Smtp-Source: AGHT+IFWnjqIafBviNgLggV7eobd2UzuQqy0HKWmSKx97DX4vB/lYBZPe+G0mjPvVKu9uNmVOtXzsw==
X-Received: by 2002:a17:903:2986:b0:235:6e1:3edf with SMTP id d9443c01a7336-23dede7d926mr204902585ad.34.1752477556979;
        Mon, 14 Jul 2025 00:19:16 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847d5sm92203115ad.45.2025.07.14.00.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 00:19:16 -0700 (PDT)
Date: Mon, 14 Jul 2025 07:19:09 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: try double sleep to give WQ a
 chance
Message-ID: <aHSvbVcc0DKMGcYT@fedora>
References: <20250710145312.3361964-1-kuba@kernel.org>
 <aHBza5P50wcKjG_h@fedora>
 <20250711071729.14d727f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711071729.14d727f6@kernel.org>

On Fri, Jul 11, 2025 at 07:17:29AM -0700, Jakub Kicinski wrote:
> On Fri, 11 Jul 2025 02:14:03 +0000 Hangbin Liu wrote:
> > >  	sleep 5
> > > +	# Schedule out for a bit, address GC runs from the power efficient WQ
> > > +	# if the long sleep above has put the whole system into sleep state
> > > +	# the WQ may have not had a chance to run.
> > > +	sleep 0.1
> > > +  
> > 
> > How about use slowwait to check if the address still exists.
> 
> Weirdly if we read the addresses twice they disappear, I haven't looked
> into the code for the why, but seemed like using slowwait could
> potentially mask the addresses sticking around when nobody runs 
> the Netlink handlers for a while? Dunno..

Not sure if I understand correctly. Do you mean the addresses will keep there
if we use slowwait?

Thanks
Hangbin

> 
> I queued this debug patch a couple of months ago:
> 
>  	sleep 5
> -	run_cmd_grep_fail "10.23.11." ip addr show dev "$devdummy"
> +	ip addr show dev "$devdummy" > /tmp/a
> +	run_cmd_grep_fail "10.23.11." cat /tmp/a
>  	if [ $? -eq 0 ]; then
> -		check_err 1
> -		end_test "FAIL: preferred_lft addresses remaining"
> +	    check_err 1
> +	    cat /tmp/a
> +	    echo "==="
> +		ip addr show dev "$devdummy"
> +		end_test "FAIL: preferred_lft addresses remaining ($lft)"
>  		return
>  	fi
> 
> And when it flakes the output looks like this:
> 
> # 7.23 [+7.00] 297: test-dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
> # 7.23 [+0.00]     link/ether 9e:a6:c4:c2:1b:16 brd ff:ff:ff:ff:ff:ff
> # 7.23 [+0.00]     inet 10.23.11.81/32 scope global deprecated dynamic test-dummy0
> # 7.23 [+0.00]        valid_lft 0sec preferred_lft 0sec
> # 7.23 [+0.00]     inet 10.23.11.84/32 scope global deprecated dynamic test-dummy0
> # 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
> # 7.24 [+0.00]     inet 10.23.11.93/32 scope global deprecated dynamic test-dummy0
> # 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
> # 7.24 [+0.00]     inet 10.23.11.94/32 scope global deprecated dynamic test-dummy0
> # 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
> # 7.24 [+0.00]     inet 10.23.11.97/32 scope global deprecated dynamic test-dummy0
> # 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
> # 7.24 [+0.00]     inet 10.23.11.99/32 scope global deprecated dynamic test-dummy0
> # 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
> # 7.24 [+0.00]     inet6 fe80::9ca6:c4ff:fec2:1b16/64 scope link proto kernel_ll 
> # 7.24 [+0.00]        valid_lft forever preferred_lft forever
> # 7.24 [+0.00] ===
> # 7.25 [+0.00] 297: test-dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
> # 7.25 [+0.00]     link/ether 9e:a6:c4:c2:1b:16 brd ff:ff:ff:ff:ff:ff
> # 7.25 [+0.00]     inet6 fe80::9ca6:c4ff:fec2:1b16/64 scope link proto kernel_ll 
> # 7.25 [+0.00]        valid_lft forever preferred_lft forever
> # 7.25 [+0.00] FAIL: preferred_lft addresses remaining (1)

