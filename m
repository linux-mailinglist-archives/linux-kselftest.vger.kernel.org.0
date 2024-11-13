Return-Path: <linux-kselftest+bounces-21968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7339C7D14
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 21:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694DA281FCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 20:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A3206959;
	Wed, 13 Nov 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHEP4c6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC91E1A28;
	Wed, 13 Nov 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530596; cv=none; b=RDwPR9FGPmdBVuoss5+N485ifotQq4LVYnfG95w/7ybhSEvWs91Olni40+4nr5UrJ4RbpYT6LhfCThvNFHaKX9SC0Ig2TLiB25V6X+APmifVBSWw2osLzqi94GQu1YJd9O8A1QaUJthJeeG/RKkqh3ufcyfTWOePD7EU6ZdESXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530596; c=relaxed/simple;
	bh=AOQ2jbS1ZSc+Cpr0lF6N+AW1KdL1s3yUDRvTrdexgBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMjjNagmPpKqd0o7j9/lkP34iBgDxdWZVFZJFbAUfGo+B+wYo6x6aylTr3lZmPprJInxWCtIFYCrm64ZFUViXvMbGr74dB1aCoT4ygpLzkLh72jxFNmKG5LTXkUo4IbRf211+lgAtMmCknqigfxfaNWsMoBEQPhu8pL1djSzgEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHEP4c6o; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99eb8b607aso1052226966b.2;
        Wed, 13 Nov 2024 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731530592; x=1732135392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWRTy2TAqS6HDwvEJ0i1ksInHh1LTRWyLe+vRR5/JRo=;
        b=kHEP4c6oySeZQ8Jdz9wYrxAPhmI7ydCTpVTqF8tULTe52cdc4p1iMvb3IThKeHvoo0
         L9HXB6bt9lESAv+zvICdkz7o65XrKU1CSYFFfBVOsUiEAkYuFpbkwPTmVRplv0zh0/cG
         +CyrfZG9K3L/v9Z/URTZkjz3r7PgPCVyAJQLmImMp7znXQpTHZzS/xpb3bVRNrSjGxon
         IqHLQKw85Y7aGTeE5srhVi6zB7AHBvqXh78T+MG78zjH261KHTfFQuFhArkrEDNsa+UJ
         hIWGAR2dXQvFB2nL1ybByfITi3VYTkwFZxExiktpoMIRG0BIT+EHpIUMWWPvZJMVj9C5
         +iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731530592; x=1732135392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWRTy2TAqS6HDwvEJ0i1ksInHh1LTRWyLe+vRR5/JRo=;
        b=uZQUlrU4XKN1K3A7oKX8d80wXoSNaB7oAPe105cYw2GEGXGZ3WOfGBqUAfD3s2D85Z
         cDM/SzErZIPQ886U86CUPWpNDcgLqf55IhLzls1581oxUySzVtlHhn0GQK/VCJlAZAyq
         L4JVbNnA0wclUIvddaVz8zER0bhVj1gcAK8mnylKUM7mp3h2byO4GfzZUhLyCfS5vnC8
         cV9Y/baJ4nbrcVDi3v6lxkJCSZQVXbm/gDgPAMGneuagVgoWlqu6xtAzF6Yz8sM37AEX
         aDv/am7MfpYz0Z2x7J9FH/wZUNgnmi0YTQzJ14kzTB7NbJMwcawxdNp/KxhCVVon3jqZ
         Zk3w==
X-Forwarded-Encrypted: i=1; AJvYcCUPSlTojvvuFM6nhGmC3zpylqZ8Ln4Jbi+aQEirdynrMlBjyBuVMs/2eTIvwTfhLWg8OcSLbA7BYE0u/9c=@vger.kernel.org, AJvYcCX7cSlNppyARdL+DKXoPgFXG2GP5kJVezZDaBoaIuDAYCBKS2NOkTYFZht078Tmv+XWIcEKgoVb9Uw1/q+U/IDK@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDkm7hYalnb1vADX+f0j1MLwzZuxyuzSMDE+y3/wMu3Di4Pwt
	521dVWHlp/J8Bygoo6CC3yt5vteijFZUOje+8L5eX6jOsHdg6iOaAfSJHjkObfdTH4Dwu7OY3O4
	IBN0XIbrM6/e3vqLwOwK0Np1nXgTSALzTt4w=
X-Google-Smtp-Source: AGHT+IFH67cpPzWsUpIulz6XYUG4t3o7TgMT8Idzertujn5MI7KcHSYzEKjMZt49MxR1+kFV8jml9jruSdFklV4V2kg=
X-Received: by 2002:a17:907:72c3:b0:a9e:df65:372b with SMTP id
 a640c23a62f3a-a9ef001fdb7mr2001271766b.52.1731530591946; Wed, 13 Nov 2024
 12:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113125152.752778-1-liuhangbin@gmail.com> <20241113125152.752778-3-liuhangbin@gmail.com>
In-Reply-To: <20241113125152.752778-3-liuhangbin@gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 13 Nov 2024 12:43:00 -0800
Message-ID: <CAH5Ym4iVP0XYrb1=7QhDqhEO54vpSJGFGHaBnuM1qpua1p5-tg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:52=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> Add a test to check the temporary address could be added/removed
> correctly when mngtempaddr is set or removed/unmanaged.
>
> Suggested-by: Sam Edwards <cfsworks@gmail.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---

Hi Hangbin,

Ahh, you beat me to it! I was starting to work on a test case of my
own but this looks much better organized. :)

I have some comments in cases where our approaches differ:

>  tools/testing/selftests/net/rtnetlink.sh | 89 ++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/sel=
ftests/net/rtnetlink.sh
> index bdf6f10d0558..f25a363d55bd 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -29,6 +29,7 @@ ALL_TESTS=3D"
>         kci_test_bridge_parent_id
>         kci_test_address_proto
>         kci_test_enslave_bonding
> +       kci_test_mngtmpaddr
>  "
>
>  devdummy=3D"test-dummy0"
> @@ -44,6 +45,7 @@ check_err()
>         if [ $ret -eq 0 ]; then
>                 ret=3D$1
>         fi
> +       [ -n "$2" ] && echo "$2"
>  }
>
>  # same but inverted -- used when command must fail for test to pass
> @@ -1267,6 +1269,93 @@ kci_test_enslave_bonding()
>         ip netns del "$testns"
>  }
>
> +# If the mngtmpaddr or tempaddr missing, return 0 and stop waiting
> +check_tempaddr_exists()
> +{
> +       local start=3D${1-"1"}
> +       addr_list=3D$(ip -j -n $testns addr show dev ${devdummy})
> +       for i in $(seq $start 4); do
> +               if ! echo ${addr_list} | \
> +                    jq -r '.[].addr_info[] | select(.mngtmpaddr =3D=3D t=
rue) | .local' | \
> +                    grep -q "200${i}"; then
> +                       check_err $? "No mngtmpaddr 200${i}:db8::1"
> +                       return 0
> +               fi
> +
> +               if ! echo ${addr_list} | \
> +                    jq -r '.[].addr_info[] | select(.temporary =3D=3D tr=
ue) | .local' | \
> +                    grep -q "200${i}"; then
> +                       check_err $? "No tempaddr for 200${i}:db8::1"
> +                       return 0
> +               fi
> +       done
> +       return 1
> +}

The variant of this function that I implemented is a lot less "fixed"
and gathers all IPv6 prefixes (by /64) into one of 3 sets:
1. mngtmpaddr
2. temporary, not deprecated
3. temporary (whether deprecated or not)

It then ensures that set 3 is a subset of set 1, and set 1 is a subset
of set 2. (And if it's easy: it should also ensure that no 'temporary'
has a *_lft in excess of its parent's.)

Doing it this way allows the test case to create, modify, and delete
mngtmpaddrs according to the needs of the test, and the check()
function only ensures that the rules are being obeyed, it doesn't make
assumptions about the expected state of the addresses.

> +
> +kci_test_mngtmpaddr()
> +{
> +       local ret=3D0
> +
> +       setup_ns testns
> +       if [ $? -ne 0 ]; then
> +               end_test "SKIP mngtmpaddr tests: cannot add net namespace=
 $testns"
> +               return $ksft_skip
> +       fi
> +
> +       # 1. Create a dummy Ethernet interface
> +       run_cmd ip -n $testns link add ${devdummy} type dummy
> +       run_cmd ip -n $testns link set ${devdummy} up
> +       run_cmd ip netns exec $testns sysctl -w net.ipv6.conf.${devdummy}=
.use_tempaddr=3D1

Test should also set .temp_prefered_lft and .temp_valid_lft here.

I also set .max_desync_factor=3D0 because this is a dummy interface that
doesn't have any latency, which allows the prefer lifetime to be
pretty short. (See below.)

> +       # 2. Create several (3-4) mngtmpaddr addresses on that interface.
> +       # with temp_*_lft configured to be pretty short (10 and 35 second=
s
> +       # for prefer/valid respectively)
> +       for i in $(seq 1 4); do
> +               run_cmd ip -n $testns addr add 200${i}:db8::1/64 dev ${de=
vdummy} mngtmpaddr

I don't really like using 200X:db8::1 as the test addresses.
2001:db8::/32 is the IANA designated prefix for examples/documentation
(and, by extension, unit tests) so we should really try to remain
inside that.

Personally, I tend to use 2001:db8:7e57:X::/64 ("test" in leetspeak)
just to minimize the chances of conflicting with something else in the
system. Though, with the test happening in its own netns, *that* level
of caution may not be necessary.

Still, 2001:db8::/32 is what IPv6 folks expect, so I'd want to stay in ther=
e.

> +               tempaddr=3D$(ip -j -n $testns addr show dev ${devdummy} |=
 \
> +                          jq -r '.[].addr_info[] | select(.temporary =3D=
=3D true) | .local' | \
> +                          grep 200${i})
> +               #3. Confirm that temporary addresses are created immediat=
ely.

This could simply be a call to the above genericized check() function.

> +               if [ -z $tempaddr ]; then
> +                       check_err 1 "no tempaddr created for 200${i}:db8:=
:1"
> +               else
> +                       run_cmd ip -n $testns addr change $tempaddr dev $=
{devdummy} \
> +                               preferred_lft 10 valid_lft 35

While Linux is (apparently) happy to let userspace modify the
tempaddr's remaining lifetime like this, I don't think this is a
common or recommended practice. Rather, the test should be letting
Linux manage the tempaddr lifetimes and rotate the addresses itself.

> +               fi
> +       done

Here is a good place to create an address that *isn't* mngtmpaddr,
confirm there is no temporary (via call to check() function), then add
the `mngtmpaddr` flag after the fact.

> +
> +       #4. Confirm that a preferred temporary address exists for each mn=
gtmpaddr
> +       #   address at all times, polling once per second for at least 5 =
minutes.
> +       slowwait 300 check_tempaddr_exists

So I previously said "wait 5 minutes" but I later saw in the
documentation for the selftest suite that maintainers really don't
like it when a test takes more than ~45 seconds to run. We might want
to drop this wait to 30 by default and accelerate the timetable on
prefer/valid lifetimes to something like 10/25.

> +
> +       #5. Delete each mngtmpaddr address, one at a time (alternating be=
tween
> +       #   deleting and merely un-mngtmpaddr-ing), and confirm that the =
other
> +       #   mngtmpaddr addresses still have preferred temporaries.
> +       for i in $(seq 1 4); do
> +               if (( $i % 2 =3D=3D 1 )); then
> +                       run_cmd ip -n $testns addr del 200${i}:db8::1/64 =
dev ${devdummy}
> +               else
> +                       run_cmd ip -n $testns addr change 200${i}:db8::1/=
64 dev ${devdummy}
> +               fi
> +               # the temp addr should be deleted
> +               if ip -j -n $testns addr show dev ${devdummy} | \
> +                  jq -r '.[].addr_info[] | select(.temporary =3D=3D true=
) | .local' | \
> +                  grep -q "200${i}"; then
> +                       check_err 1 "tempaddr not deleted for 200${i}:db8=
::1"
> +               fi
> +               # Check other addresses are still exist
> +               check_tempaddr_exists $((i + 1))

Ditto, the whole bottom half of this loop can be a call to a
genericized check function.

> +       done
> +
> +       if [ $ret -ne 0 ]; then
> +               end_test "FAIL: mngtmpaddr add/remove incorrect"
> +               ip netns del "$testns"
> +               return 1
> +       fi
> +
> +       end_test "PASS: mngtmpaddr add/remove correctly"
> +       ip netns del "$testns"

Do we need to make sure the netns gets cleaned up via `trap ... EXIT`
so that it doesn't leak if the user interrupts the test? Or does the
greater test fixture take care of that for us?

Happy Wednesday,
Sam

> +}
> +
>  kci_test_rtnl()
>  {
>         local current_test
> --
> 2.46.0
>

