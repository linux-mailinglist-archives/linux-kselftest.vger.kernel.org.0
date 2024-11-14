Return-Path: <linux-kselftest+bounces-22015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D999C8526
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5195A281C02
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C49D1F81A4;
	Thu, 14 Nov 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtUCf4CU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA21C303E;
	Thu, 14 Nov 2024 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574003; cv=none; b=YoXEo/ZRSRy2IdD6fxpbydby4Jm+Mzbv5ZvUaIRu6l2o72U4x1PnbZx6X32IJkc290F5kCuFMVOMjHslwbDUpT4mNVUqlq08WivbKF5IkuNTG6oZlPZ8jT/obV1Ji4hNSeM8cT4fimN5oGC+vIc9ad05laRSlu6MXF1wZ9b+/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574003; c=relaxed/simple;
	bh=01gRTn9fiNLg1hmzyThgU+LHjR43FRnaYWfPSkS8JQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4i+XmO9LORbPxVVeyCVbHUKCZ7RwcL7PcE9VpUEq5KdtlbJAQpmw0BqfbLqQgt2egVEKGyD4GNHA+np+x0SeCyPK5iqcqJQvH8fUK9EjuSx8YA7100ks/h8vMkLdJlo91/XpXWzd67dyfa3hWg5x//Vvq/8qGfcJ8uXTPtRbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtUCf4CU; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea9739647bso235722a12.0;
        Thu, 14 Nov 2024 00:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731574001; x=1732178801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnhYZjIX+OB3WvtAgUJqUgdzGomZn2VvERIAOaUixdo=;
        b=XtUCf4CUWUO98EOLxSA1q/X9XD8k4q8ZUPh78xMQU3WX+kbIGoAS017aYygGL9A1XR
         zaCruz4LeV2IPd/2xFaLtajshCOJQGrQhPHzkQ9G6fvn8zF+yiZmy4PEKAyGobEpic/3
         BilnEQMWkL+fekWIZAQIymrWDmslWWLyBRzKBF9Md57YTWHVFrwRSqJ09VucIdMwt10n
         7oARtFCDKIGskuXC6AKoL112bhry16GI4p9tbbdqduVQBZhbsMYj6yk3NN+y4MgT8Qw5
         2WjO7BXgDXHdl4ljHs5LUFEucY5Q9fQ3GnhmzazyZpbEGt55AjCMeyFsn4vAtox31anJ
         RDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574001; x=1732178801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnhYZjIX+OB3WvtAgUJqUgdzGomZn2VvERIAOaUixdo=;
        b=b63YAwi1J9cfHsXx9Y7cNdHQ2CuV3pfkVFBh4IsKS2/YfUaPhel+Q2Aux6WRlDPDsq
         G2BTSNU+pHUId35NIYEEzKXlOg0P9Uw+dVfcxa+GBsT2A4sKkK8/6LMhZ3PBIrPzsouX
         YxK+gzzWGiQqVx+nQ9i8l4sRZLziUCTz8kDqgnYx7YfwiYtn1pJg+plLAYIuYTzdD/d5
         IHJ2fP48nbzy56NNlYN+hTfaTbI48nAtJ8c4MZK28fOf3BlyeTN1cSfhv8Q2Eq+q5jsa
         F9hfbtEmU0yzZzTE1PEabSBSGq/jYMN1m46h4eZ8BG36uNpO1IeOOWFGK+AccrtwHfmj
         zYqg==
X-Forwarded-Encrypted: i=1; AJvYcCW829JRAeFhgjuUmgIDnIF+UNIy2g8FnLIYEz6Tzzs46PY6n/xnKHq45+2jpixOWd+2LcEISPoVBcv/QiOXTANR@vger.kernel.org, AJvYcCWKaTLgJXizC/XhVxFRa3l16RCS7rqy+9lA1cHqqsG5w7zAKyHap167AnQunpYoK7ClYHlQPlaurHHCo1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuv7XTRtPy2O7W+qhxAcg4aBeoBOrepWJyU+izM0Zuo+uhMkr
	RF1QYfVZjEqLvw/E8ytfVAQ/LEcmlXcZi6QdCOYW1CkC7BiPmD9fm1DZKf58QDI=
X-Google-Smtp-Source: AGHT+IHE7bQEixh43pnqUrgfsA4EdNzypvVOpSy8Z39EpybK+orYgYK9g9iH/pYyoM6GdSWHLNlgdg==
X-Received: by 2002:a05:6a21:205:b0:1db:f7dc:f10c with SMTP id adf61e73a8af0-1dc22b150f4mr18532111637.28.1731574000995;
        Thu, 14 Nov 2024 00:46:40 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06e0654esm703365a91.0.2024.11.14.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 00:46:40 -0800 (PST)
Date: Thu, 14 Nov 2024 08:46:33 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Message-ID: <ZzW46QZf5rzj4tMp@fedora>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
 <20241113125152.752778-3-liuhangbin@gmail.com>
 <CAH5Ym4iVP0XYrb1=7QhDqhEO54vpSJGFGHaBnuM1qpua1p5-tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5Ym4iVP0XYrb1=7QhDqhEO54vpSJGFGHaBnuM1qpua1p5-tg@mail.gmail.com>

Hi Sam,

On Wed, Nov 13, 2024 at 12:43:00PM -0800, Sam Edwards wrote:
> > +# If the mngtmpaddr or tempaddr missing, return 0 and stop waiting
> > +check_tempaddr_exists()
> > +{
> > +       local start=${1-"1"}
> > +       addr_list=$(ip -j -n $testns addr show dev ${devdummy})
> > +       for i in $(seq $start 4); do
> > +               if ! echo ${addr_list} | \
> > +                    jq -r '.[].addr_info[] | select(.mngtmpaddr == true) | .local' | \
> > +                    grep -q "200${i}"; then
> > +                       check_err $? "No mngtmpaddr 200${i}:db8::1"
> > +                       return 0
> > +               fi
> > +
> > +               if ! echo ${addr_list} | \
> > +                    jq -r '.[].addr_info[] | select(.temporary == true) | .local' | \
> > +                    grep -q "200${i}"; then
> > +                       check_err $? "No tempaddr for 200${i}:db8::1"
> > +                       return 0
> > +               fi
> > +       done
> > +       return 1
> > +}
> 
> The variant of this function that I implemented is a lot less "fixed"
> and gathers all IPv6 prefixes (by /64) into one of 3 sets:
> 1. mngtmpaddr
> 2. temporary, not deprecated
> 3. temporary (whether deprecated or not)
> 
> It then ensures that set 3 is a subset of set 1, and set 1 is a subset
> of set 2. (And if it's easy: it should also ensure that no 'temporary'
> has a *_lft in excess of its parent's.)

I'm not totally get your explanation here. e.g. with preferred_lft 10,
valid_lft 30. I got the following result.

# ip addr show dummy0
3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 2e:f7:df:87:44:64 brd ff:ff:ff:ff:ff:ff
    inet6 2001::743:ec1e:5c19:404f/64 scope global temporary dynamic
       valid_lft 25sec preferred_lft 5sec
    inet6 2001::938f:432:f32d:602f/64 scope global temporary dynamic
       valid_lft 19sec preferred_lft 0sec
    inet6 2001::5b65:c0a3:cd8c:edf8/64 scope global temporary deprecated dynamic
       valid_lft 3sec preferred_lft 0sec
    inet6 2001::8a7e:6e8d:83f1:9ea0/64 scope global temporary deprecated dynamic
       valid_lft 0sec preferred_lft 0sec
    inet6 2001::1/64 scope global mngtmpaddr
       valid_lft forever preferred_lft forever

So there are 1 mngtmpaddr, 2 temporary address (not deprecated). 4 total
temporary address. Based on your rule. It should be set 1 is a subset of
set 2. Set 2 is a subset of 3.

And how do we ensure that no 'temporary' has a *_lft in excess of its parent's.

> Doing it this way allows the test case to create, modify, and delete
> mngtmpaddrs according to the needs of the test, and the check()
> function only ensures that the rules are being obeyed, it doesn't make
> assumptions about the expected state of the addresses.

I'm not sure if this is totally enough. What if there are 3 mngtmpaddrs
and 4 temporary address. But actually 1 mngtmpaddrs doesn't have temporary
address. Maybe check() needs to check only 1 prefix each time.
 
> > +
> > +kci_test_mngtmpaddr()
> > +{
> > +       local ret=0
> > +
> > +       setup_ns testns
> > +       if [ $? -ne 0 ]; then
> > +               end_test "SKIP mngtmpaddr tests: cannot add net namespace $testns"
> > +               return $ksft_skip
> > +       fi
> > +
> > +       # 1. Create a dummy Ethernet interface
> > +       run_cmd ip -n $testns link add ${devdummy} type dummy
> > +       run_cmd ip -n $testns link set ${devdummy} up
> > +       run_cmd ip netns exec $testns sysctl -w net.ipv6.conf.${devdummy}.use_tempaddr=1
> 
> Test should also set .temp_prefered_lft and .temp_valid_lft here.
> 
> I also set .max_desync_factor=0 because this is a dummy interface that
> doesn't have any latency, which allows the prefer lifetime to be
> pretty short. (See below.)

Thanks, I will fix the test.
> 
> > +       # 2. Create several (3-4) mngtmpaddr addresses on that interface.
> > +       # with temp_*_lft configured to be pretty short (10 and 35 seconds
> > +       # for prefer/valid respectively)
> > +       for i in $(seq 1 4); do
> > +               run_cmd ip -n $testns addr add 200${i}:db8::1/64 dev ${devdummy} mngtmpaddr
> 
> I don't really like using 200X:db8::1 as the test addresses.
> 2001:db8::/32 is the IANA designated prefix for examples/documentation
> (and, by extension, unit tests) so we should really try to remain
> inside that.
> 
> Personally, I tend to use 2001:db8:7e57:X::/64 ("test" in leetspeak)
> just to minimize the chances of conflicting with something else in the
> system. Though, with the test happening in its own netns, *that* level
> of caution may not be necessary.
> 
> Still, 2001:db8::/32 is what IPv6 folks expect, so I'd want to stay in there.

OK, I will use 2001:db8::/32 for testing.

> 
> > +               tempaddr=$(ip -j -n $testns addr show dev ${devdummy} | \
> > +                          jq -r '.[].addr_info[] | select(.temporary == true) | .local' | \
> > +                          grep 200${i})
> > +               #3. Confirm that temporary addresses are created immediately.
> 
> This could simply be a call to the above genericized check() function.
> 
> > +               if [ -z $tempaddr ]; then
> > +                       check_err 1 "no tempaddr created for 200${i}:db8::1"
> > +               else
> > +                       run_cmd ip -n $testns addr change $tempaddr dev ${devdummy} \
> > +                               preferred_lft 10 valid_lft 35
> 
> While Linux is (apparently) happy to let userspace modify the
> tempaddr's remaining lifetime like this, I don't think this is a
> common or recommended practice. Rather, the test should be letting
> Linux manage the tempaddr lifetimes and rotate the addresses itself.

OK

> 
> > +               fi
> > +       done
> 
> Here is a good place to create an address that *isn't* mngtmpaddr,
> confirm there is no temporary (via call to check() function), then add
> the `mngtmpaddr` flag after the fact.

OK, I will
> 
> > +
> > +       #4. Confirm that a preferred temporary address exists for each mngtmpaddr
> > +       #   address at all times, polling once per second for at least 5 minutes.
> > +       slowwait 300 check_tempaddr_exists
> 
> So I previously said "wait 5 minutes" but I later saw in the
> documentation for the selftest suite that maintainers really don't
> like it when a test takes more than ~45 seconds to run. We might want
> to drop this wait to 30 by default and accelerate the timetable on
> prefer/valid lifetimes to something like 10/25.

Yes, 5m is too long for a single test.

> > +
> > +       end_test "PASS: mngtmpaddr add/remove correctly"
> > +       ip netns del "$testns"
> 
> Do we need to make sure the netns gets cleaned up via `trap ... EXIT`
> so that it doesn't leak if the user interrupts the test? Or does the
> greater test fixture take care of that for us?

No, rtnetlink.sh doesn't have a trap function. I plan to add the trap
function separately.

Thanks
Hangbin

