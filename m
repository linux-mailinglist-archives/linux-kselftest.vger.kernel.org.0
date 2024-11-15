Return-Path: <linux-kselftest+bounces-22121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B69CF66E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 21:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786CA286E61
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315241D63C6;
	Fri, 15 Nov 2024 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHfXbI5H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B831DA23;
	Fri, 15 Nov 2024 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704382; cv=none; b=anyCVCIxsLea0yEt4LZkU3zhtYqUmO0PoiBk6+yT8yqsyR3PDYMesC9VGjjCcOmFTFFkz6N0N+sHpmPWb5hWe6CHp6ZQY/+ftO00Oi4B0d1iDBRP3GHRo/tWtxkoLPlQk+LVbcHZKOd8X/+Hjh8DLKeTgWzRrQo+BauAYJRaoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704382; c=relaxed/simple;
	bh=gzTtMk1ML+JI0EwvRjkOCOAvIT+mG6ZE5JdrNjk2SMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sH1/Vi4wX1u5qNuTRNZ14945xmHlGaq0GNSWj4pFpC7OVkL1w9zGtFON42UBh7OJOHSHUYzQDJo6fDy4b/rYIqeZyGzj6BxED4eEhIIL/Kz2j/7FVRwxGwnaBGXivePwJyPbs8nA3MuiA7ZjCNE5OTpldNX16Chshln9e4KzTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHfXbI5H; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so5676166b.1;
        Fri, 15 Nov 2024 12:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731704378; x=1732309178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35Rh2Z7j4Xk8doE9J6Yu6lTzfUmpkTnJhhzbKF7lAFo=;
        b=VHfXbI5HYXdYbfnrzroobL3zVeXjf/BXLVhwEnbeIX7iqytMaX7qywVJxzYFnlnWP8
         TbizJweppcYqjQ3qcIZ62kWJnYhUyOeohQLwPHaI6Jyt7evNQ3ZuycdzhXuESHbAKplE
         uA0EZD9/sWXnESuk+mRqHAVZ6InbDX79eIxMkzaCd+VRB44PW/X9edE0qqIddQixxcch
         /jtHvaST3Hvun1cMFRcqHl+PSVJ3qsy0BwnUDcqZ/oMbOZ8b0TfjuwTVIlImZEgByEFB
         pcUne4bz4lM6pt7869kzs30mAPqWaUiD2UBQMvapDlnPUNvMp5BBDVFaa1GmEGmRWM1H
         rygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731704378; x=1732309178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35Rh2Z7j4Xk8doE9J6Yu6lTzfUmpkTnJhhzbKF7lAFo=;
        b=FPJ8CbdDmvvr+FMz8l93y8pmLa0ovIEoIXD/ilQuYNqc7HLjQzYxQPgNgzvNEtC6Lc
         sUe1gOtCodt8lW+Lv5+Q05KfOHr7oPKa3VL5AA2fsz0mXBOJOGoRcuZh8IqiXRUnp56N
         NIb7ry9OUOqPKxD6SLPEsSPvlfaTt+Bx9wAHbsDL60cu3vWULabKFJCSoz6ECGYBGQry
         X658WqskHXKJW7/drPOW/V8MNZBN0mfF0mdDP37lKc22hr+NejqjoGEhmdW3PN3kmVRV
         HRIfv77XkQcoQ6N5MC2X9bmACcsRDBlIW496aZYgPYIsJOwh7hrZc2F3fMx+JGoARTzH
         lzDA==
X-Forwarded-Encrypted: i=1; AJvYcCU0z+10kpvRHdeswvI2s6G3wxihfWiVR/WL70EH8R7M8F3GVxK2zWVY8FoVyByFbusx5StTVnaeuNtB54o8hCsO@vger.kernel.org, AJvYcCX/5LIM1BttfQ5SQsXB/mEE931Z4TVGmBVFz8MU4wybwOHOe25FwkSOc/BsZVTVZUnkz++iqFHKFzYUHLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSlRGKIU/8TcTyyI8wN91YSRlQu0xvSOQGsA/o3Lo/uQHkiPpf
	ZBEZwppGzH6pZwDLt95h3yGy8oc7fjZfE7kxDarygPVsYG6QfoudiIC02N+OiLa/HO2R8nhHvp0
	XpJZPvj36seW3ljDXEED3NX7sCWI=
X-Google-Smtp-Source: AGHT+IGC0Ep+noZ03XssDwwvH9cbtNmkJj/VB574ndOGvFgcvaCDv2F8qbzWv6QVNPjuUpg9aWDeVlUD0PmG1jKxoZ8=
X-Received: by 2002:a17:907:31c2:b0:a99:4e35:9a25 with SMTP id
 a640c23a62f3a-aa483525e93mr321833466b.44.1731704378259; Fri, 15 Nov 2024
 12:59:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113125152.752778-1-liuhangbin@gmail.com> <20241113125152.752778-3-liuhangbin@gmail.com>
 <CAH5Ym4iVP0XYrb1=7QhDqhEO54vpSJGFGHaBnuM1qpua1p5-tg@mail.gmail.com> <ZzW46QZf5rzj4tMp@fedora>
In-Reply-To: <ZzW46QZf5rzj4tMp@fedora>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 15 Nov 2024 12:59:27 -0800
Message-ID: <CAH5Ym4jGZou27-bwGqxHAf2AHWXpT0=wOa0XNNuqtG9OOhi8EQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 12:46=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com>=
 wrote:
>
> Hi Sam,
>
> On Wed, Nov 13, 2024 at 12:43:00PM -0800, Sam Edwards wrote:
> > > +# If the mngtmpaddr or tempaddr missing, return 0 and stop waiting
> > > +check_tempaddr_exists()
> > > +{
> > > +       local start=3D${1-"1"}
> > > +       addr_list=3D$(ip -j -n $testns addr show dev ${devdummy})
> > > +       for i in $(seq $start 4); do
> > > +               if ! echo ${addr_list} | \
> > > +                    jq -r '.[].addr_info[] | select(.mngtmpaddr =3D=
=3D true) | .local' | \
> > > +                    grep -q "200${i}"; then
> > > +                       check_err $? "No mngtmpaddr 200${i}:db8::1"
> > > +                       return 0
> > > +               fi
> > > +
> > > +               if ! echo ${addr_list} | \
> > > +                    jq -r '.[].addr_info[] | select(.temporary =3D=
=3D true) | .local' | \
> > > +                    grep -q "200${i}"; then
> > > +                       check_err $? "No tempaddr for 200${i}:db8::1"
> > > +                       return 0
> > > +               fi
> > > +       done
> > > +       return 1
> > > +}
> >
> > The variant of this function that I implemented is a lot less "fixed"
> > and gathers all IPv6 prefixes (by /64) into one of 3 sets:
> > 1. mngtmpaddr
> > 2. temporary, not deprecated
> > 3. temporary (whether deprecated or not)
> >
> > It then ensures that set 3 is a subset of set 1, and set 1 is a subset
> > of set 2. (And if it's easy: it should also ensure that no 'temporary'
> > has a *_lft in excess of its parent's.)
>
> I'm not totally get your explanation here. e.g. with preferred_lft 10,
> valid_lft 30. I got the following result.
>
> # ip addr show dummy0
> 3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default=
 qlen 1000
>     link/ether 2e:f7:df:87:44:64 brd ff:ff:ff:ff:ff:ff
>     inet6 2001::743:ec1e:5c19:404f/64 scope global temporary dynamic
>        valid_lft 25sec preferred_lft 5sec
>     inet6 2001::938f:432:f32d:602f/64 scope global temporary dynamic
>        valid_lft 19sec preferred_lft 0sec
>     inet6 2001::5b65:c0a3:cd8c:edf8/64 scope global temporary deprecated =
dynamic
>        valid_lft 3sec preferred_lft 0sec
>     inet6 2001::8a7e:6e8d:83f1:9ea0/64 scope global temporary deprecated =
dynamic
>        valid_lft 0sec preferred_lft 0sec
>     inet6 2001::1/64 scope global mngtmpaddr
>        valid_lft forever preferred_lft forever
>
> So there are 1 mngtmpaddr, 2 temporary address (not deprecated). 4 total
> temporary address. Based on your rule. It should be set 1 is a subset of
> set 2. Set 2 is a subset of 3.
>
> And how do we ensure that no 'temporary' has a *_lft in excess of its par=
ent's.
>
> > Doing it this way allows the test case to create, modify, and delete
> > mngtmpaddrs according to the needs of the test, and the check()
> > function only ensures that the rules are being obeyed, it doesn't make
> > assumptions about the expected state of the addresses.
>
> I'm not sure if this is totally enough. What if there are 3 mngtmpaddrs
> and 4 temporary address. But actually 1 mngtmpaddrs doesn't have temporar=
y
> address. Maybe check() needs to check only 1 prefix each time.

Hi Hangbin,

My apologies, I should have shared my version of the check function
before. Here it is:

```bash
# Called to validate the addresses on $IFNAME:
#
# 1. Every `temporary` address must have a matching `mngtmpaddr`
# 2. Every `mngtmpaddr` address must have some un`deprecated` `temporary`
#
# Fails the whole test script if a problem is detected, else returns silent=
ly.
validate()
{
    mng_prefixes=3D()
    undep_prefixes=3D()
    temp_addrs=3D()

    while read -r line; do
        line_array=3D($line)
        address=3D"${line_array[1]}"
        prefix=3D"$(echo "$address" | cut -d: -f1-4)::/64"
        if echo "$line" | grep -q mngtmpaddr; then
            mng_prefixes+=3D("$prefix")
        elif echo "$line" | grep -q temporary; then
            temp_addrs+=3D("$address")
            if echo "$line" | grep -qv deprecated; then
                undep_prefixes+=3D("$prefix")
            fi
        fi
    done < <(ip -6 addr show dev $IFNAME | grep '^\s*inet6')

    # 1. All temporary addresses (temp and dep) must have a matching mngtmp=
addr
    for address in ${temp_addrs[@]}; do
        prefix=3D"$(echo "$address" | cut -d: -f1-4)::/64"
        if [[ ! " ${mng_prefixes[*]} " =3D~ " $prefix " ]]; then
            echo "FAIL: Temporary $address with no matching mngtmpaddr!";
            exit 1
        fi
    done

    # 2. All mngtmpaddr addresses must have a temporary address (not dep)
    for prefix in ${mng_prefixes[@]}; do
        if [[ ! " ${undep_prefixes[*]} " =3D~ " $prefix " ]]; then
            echo "FAIL: No undeprecated temporary in $prefix!";
            exit 1
        fi
    done
}
```

Of course this is using awful text parsing and not JSON output. But
the idea is that it groups addresses by their /64 prefix, to confirm
that every /64 containing a mngtmpaddrs address also contains an
undeprecated temporary, and that every /64 containing a temporary
(deprecated or not) contains a mngtmpaddrs.

This can be extended for the lifetime checking: when we build the set
of mngtmpaddrs /64s, we also note the valid/preferred_life_time values
for each mngtmpaddr. Then later when we confirm rule 1 (all temporary
addresses must have a matching mngtmpaddr) we also confirm that each
temporary does not outlive the mngtmpaddr in the same /64.

Happy Friday,
Sam

>
> > > +
> > > +kci_test_mngtmpaddr()
> > > +{
> > > +       local ret=3D0
> > > +
> > > +       setup_ns testns
> > > +       if [ $? -ne 0 ]; then
> > > +               end_test "SKIP mngtmpaddr tests: cannot add net names=
pace $testns"
> > > +               return $ksft_skip
> > > +       fi
> > > +
> > > +       # 1. Create a dummy Ethernet interface
> > > +       run_cmd ip -n $testns link add ${devdummy} type dummy
> > > +       run_cmd ip -n $testns link set ${devdummy} up
> > > +       run_cmd ip netns exec $testns sysctl -w net.ipv6.conf.${devdu=
mmy}.use_tempaddr=3D1
> >
> > Test should also set .temp_prefered_lft and .temp_valid_lft here.
> >
> > I also set .max_desync_factor=3D0 because this is a dummy interface tha=
t
> > doesn't have any latency, which allows the prefer lifetime to be
> > pretty short. (See below.)
>
> Thanks, I will fix the test.
> >
> > > +       # 2. Create several (3-4) mngtmpaddr addresses on that interf=
ace.
> > > +       # with temp_*_lft configured to be pretty short (10 and 35 se=
conds
> > > +       # for prefer/valid respectively)
> > > +       for i in $(seq 1 4); do
> > > +               run_cmd ip -n $testns addr add 200${i}:db8::1/64 dev =
${devdummy} mngtmpaddr
> >
> > I don't really like using 200X:db8::1 as the test addresses.
> > 2001:db8::/32 is the IANA designated prefix for examples/documentation
> > (and, by extension, unit tests) so we should really try to remain
> > inside that.
> >
> > Personally, I tend to use 2001:db8:7e57:X::/64 ("test" in leetspeak)
> > just to minimize the chances of conflicting with something else in the
> > system. Though, with the test happening in its own netns, *that* level
> > of caution may not be necessary.
> >
> > Still, 2001:db8::/32 is what IPv6 folks expect, so I'd want to stay in =
there.
>
> OK, I will use 2001:db8::/32 for testing.
>
> >
> > > +               tempaddr=3D$(ip -j -n $testns addr show dev ${devdumm=
y} | \
> > > +                          jq -r '.[].addr_info[] | select(.temporary=
 =3D=3D true) | .local' | \
> > > +                          grep 200${i})
> > > +               #3. Confirm that temporary addresses are created imme=
diately.
> >
> > This could simply be a call to the above genericized check() function.
> >
> > > +               if [ -z $tempaddr ]; then
> > > +                       check_err 1 "no tempaddr created for 200${i}:=
db8::1"
> > > +               else
> > > +                       run_cmd ip -n $testns addr change $tempaddr d=
ev ${devdummy} \
> > > +                               preferred_lft 10 valid_lft 35
> >
> > While Linux is (apparently) happy to let userspace modify the
> > tempaddr's remaining lifetime like this, I don't think this is a
> > common or recommended practice. Rather, the test should be letting
> > Linux manage the tempaddr lifetimes and rotate the addresses itself.
>
> OK
>
> >
> > > +               fi
> > > +       done
> >
> > Here is a good place to create an address that *isn't* mngtmpaddr,
> > confirm there is no temporary (via call to check() function), then add
> > the `mngtmpaddr` flag after the fact.
>
> OK, I will
> >
> > > +
> > > +       #4. Confirm that a preferred temporary address exists for eac=
h mngtmpaddr
> > > +       #   address at all times, polling once per second for at leas=
t 5 minutes.
> > > +       slowwait 300 check_tempaddr_exists
> >
> > So I previously said "wait 5 minutes" but I later saw in the
> > documentation for the selftest suite that maintainers really don't
> > like it when a test takes more than ~45 seconds to run. We might want
> > to drop this wait to 30 by default and accelerate the timetable on
> > prefer/valid lifetimes to something like 10/25.
>
> Yes, 5m is too long for a single test.
>
> > > +
> > > +       end_test "PASS: mngtmpaddr add/remove correctly"
> > > +       ip netns del "$testns"
> >
> > Do we need to make sure the netns gets cleaned up via `trap ... EXIT`
> > so that it doesn't leak if the user interrupts the test? Or does the
> > greater test fixture take care of that for us?
>
> No, rtnetlink.sh doesn't have a trap function. I plan to add the trap
> function separately.
>
> Thanks
> Hangbin

