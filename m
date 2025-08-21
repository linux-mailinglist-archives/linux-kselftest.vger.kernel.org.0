Return-Path: <linux-kselftest+bounces-39469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E3B2F314
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 10:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7201C5A58C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AC82EE268;
	Thu, 21 Aug 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnkRw+I5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C62EE263;
	Thu, 21 Aug 2025 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766742; cv=none; b=mXlzfalBlInDkmnkd6u+1PhHrTs4X/hlqCqI9yjHdJ5i9oahisVj6QDT0FI6XPEdRkZngjafDc+3FcNTi0dBd22nWj9adBwqaSpRwqDL5Hm1ustq8YQDUn4Kr3VAPDgCZR/km+9o2A5y/4RIsxM/3RK9cmLPybAzzWf+PnpbIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766742; c=relaxed/simple;
	bh=p62M6eX2iuYBqZDezqNWyP8v3/JrtHtVwp2a0puBwbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmqWb6gsovnmNU/rE4ecEYGHKVetXjHD3n1BhYkFks6U5TAuHWHh/z2H8kJaXcrPv61d4rO9Xi38z7GsSdljOYgQuT21sK1vCoq1ZTS8g6ejRhFvKcfIKC9YrI951rPVhRNofvpvFvZGev1yvj25hreSFaWxdxDX5+2kIawWrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnkRw+I5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244581caca6so6133275ad.2;
        Thu, 21 Aug 2025 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755766740; x=1756371540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEm9mEjlF/ZAqt+0IE6+oZVFwgVkKRkNrtybX+6TA9M=;
        b=SnkRw+I5Mc9CSziFzI2hAGJu1/JoFfYti9ZzODCMQg0EDFebYZ6U3YpEZDY+FixN4y
         jhumdEOAcy56pfIP4Yb1pjdr80GvgJJD2a0Axpu6+8yu5r7rY5B7LJ2BS8lD55Btf1i6
         t3zVb92kGyF3ffKAJxW92RIWRu+aGUz1MQsFhv2Lk0jKQ8AnJCZk8WfaYBQWNANkdFnT
         YKHuRaSIOkvV8TDV0jOYQlmaZtnub2qpmb8gEKsQg5QX5eqBGLWahj4+33+kkHWECToz
         kX1U5yV1ib1w3RMLU4GRkzotN+8N/WWsnLhVz2f9D2JwaqSLEYz7wavsQwN7U2EDLeuC
         ZorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766740; x=1756371540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEm9mEjlF/ZAqt+0IE6+oZVFwgVkKRkNrtybX+6TA9M=;
        b=pNRFiz1OlZtOdCAnHK2LIZE3fu8nrJVcT0HCl7K9rEZN/sTTukNoE2Vlp7SbPe7MXJ
         UEfrXps745+h0sZI/Hp6gBiOO73cN3dhhlxbs9JlnipSvzwfSlhR716y8mRrRGuXYYR+
         KB/hiJOZcQqTrpOEirvkGqIS0OYNKYpf3xxFeHhkzF9iP1vBDYS1h/6cDdW/0RQ5oKfl
         +/BMRlFyRMRlkuTRUKuH1gsMTAHyJQt9bsO2rd/O0WyISeBSUQCNj3FE/vf3pF3OLLrW
         OrIrICq+nOdHRJEYbhXlaRCwvOr8N7ogTok4Wqo6lLJG1mc+oyPC4BduaIdCLn/Eo/xH
         CkMw==
X-Forwarded-Encrypted: i=1; AJvYcCV3rOatphadRgy7Wl3edlIipCLCybVLmloQ3dqh5z9nR/GAtLAgqF6UDVFiMdkJTxkMvWgnSamy@vger.kernel.org, AJvYcCWwbbt+IbiRbaHzNJmiFHCc15frm3c5JRUfssdfriutyIqqSE26zf8V1Z+0/c0nM9LdQ43z6cwuGaUM8MuiJD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQ+pKzNI+0D1N55QnrPTYl+0Bore9kLrJwU6cd0z+mPM/0DSv
	NKEDNas1D64UP+xyxtQ1FciKK/o4aC/Ik+zlw2V7uiINTfORWoqoLZn5
X-Gm-Gg: ASbGncsSOA5w6/sgrG6XgdYpuiO831wmFAMhAo1MVnOuYo6A9RjaZjBGj58XZ3ob4SO
	gAutnUAho6ZAeIJbWCqT+CgIdbjN9BBFcTZOlgi8z3QoHcLYk2rsenfh5raSyqDuSpzf1g0BJSe
	Li0rVv6KxBpxl5SFdBRW8Jq5b3qEv4c4nkhUlb/g9wzHStL4Naxx6wxQWwzkcvL0tg4XbBzz/vp
	AGzk8ygcVGWY+wyNP0AwrJ5b/tAa+318dhu7bJMivncbgZrngAyRiyob+MNL+D+JeTU2b74cGL1
	mK138jDmwsU0q21DExpmyIsCAmPsXMiCNg28KKjQfaTi4Lob0ekC00X63tGwpt/mPDVJSelq4OK
	+I2Y255a91WILxY+WqJnZHQfoPNmT1KlT9YVaGg==
X-Google-Smtp-Source: AGHT+IEuRkmxaAmThc7HNmy8O8AUR11/28szLpXKHJnRoYviVNaEU4iTN+tgtGE/bL591pYe6jGzRg==
X-Received: by 2002:a17:903:2406:b0:235:f078:4746 with SMTP id d9443c01a7336-245fedb0faemr20873415ad.42.1755766739755;
        Thu, 21 Aug 2025 01:58:59 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed50352esm48683365ad.128.2025.08.21.01.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:58:59 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:58:53 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Alessandro <alessandro@0x65c.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: rtnetlink: add checks for ifconfig and
 iproute2
Message-ID: <aKbfzeS1QrP0dE4N@fedora>
References: <20250821074552.682731-1-alessandro@0x65c.net>
 <20250821074552.682731-2-alessandro@0x65c.net>
 <aKbX_CzxSi7T9Bcp@fedora>
 <CAKiXHKcLsEWbEz1EkzE942PbsMEpfj=wO7uYDb+Nxy8nGCEx1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKiXHKcLsEWbEz1EkzE942PbsMEpfj=wO7uYDb+Nxy8nGCEx1Q@mail.gmail.com>

On Thu, Aug 21, 2025 at 10:45:19AM +0200, Alessandro wrote:
> On Thu, 21 Aug 2025 at 10:25, Hangbin Liu <liuhangbin@gmail.com> wrote:
> >
> > On Thu, Aug 21, 2025 at 09:43:11AM +0200, Alessandro Ratti wrote:
> > > On systems where `ifconfig` is not available (e.g., modern Debian), the
> > > `kci_test_promote_secondaries` test fails. Wrap the call in a check.
> > >
> > > Additionally, `do_test_address_proto` fails on iproute2 versions that
> > > lack support for `proto` in `ip address` commands. Add a minimal feature
> > > check and skip the test with a proper message if unsupported.
> > >
> > > These changes allow the tests to run and report SKIP instead of FAIL on
> > > platforms with older tools.
> > >
> > > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> > > ---
> > >  tools/testing/selftests/net/rtnetlink.sh | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> > > index d6c00efeb664..9bff620ef595 100755
> > > --- a/tools/testing/selftests/net/rtnetlink.sh
> > > +++ b/tools/testing/selftests/net/rtnetlink.sh
> > > @@ -330,7 +330,9 @@ kci_test_promote_secondaries()
> > >       for i in $(seq 2 254);do
> > >               IP="10.23.11.$i"
> > >               ip -f inet addr add $IP/16 brd + dev "$devdummy"
> > > -             ifconfig "$devdummy" $IP netmask 255.255.0.0
> > > +             if command -v ifconfig >/dev/null 2>&1; then
> > > +                     ifconfig "$devdummy" $IP netmask 255.255.0.0
> > > +             fi
> >
> > Maybe just skip the promote_secondaries test if ifconfig is not available?
> >
> 
> Thank you for your review and comment.
> 
> My takeaway here is that the test works because the IP addresses are set on the
> $devdummy by the previous ip(8) command, and ifconfig seems a bit redundant.

No, please check the git log to see why we use ifconfig here.

Thanks
Hangbin

> 
> Also, considering we are testing netlink, I was baffled to see ifconfig there
> that, if I'm not mistaken, uses ioctl(); but I might be missing
> something obvious
> here, considering I'm looking at these tests for the first time, so bear with
> me :)
> 
> If it's better to skip the test altogether when ifconfig is missing, I'll
> submit another patch to do so.
> 
> Thank you
> 
> Best regards,
> Alessandro

