Return-Path: <linux-kselftest+bounces-35266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D969ADE916
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EEE1749B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A98285CAC;
	Wed, 18 Jun 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fj7dwJft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9328505F
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242838; cv=none; b=jYF6PeyE55qUHkna7MohcLwH7C9HUqiZSZOVIufbHhPsTuUQL351yQbsP1BdQIkzMMdRg1A+6yHmoZE5mc5KWlFIHa/L0lIl5bdKMAVnG+bOsPfofkmBr13s0YVJnQnNDQQl5tMGTKL6Y9fKuDzN8V3vHetuzvTv8WcqHYqv2OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242838; c=relaxed/simple;
	bh=8AtEpxHS6rvy3BPLx4KHxLnHdb252IDjwNW05a9fofA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkljOlD/d8aQesUGMdT1ohFdPwRmkYmPm0BSiMeMNZvIyK9fmMs30IoingEJeWszX1YTVWKN7po640Y9d/hqUMdyliTkfd0MktJkbFqjkg7R/sY1vsNel6M7c9SWWMwczJpGu5Lcqx8smysSkU8GB+d5iSzhTRmpMmIskXS3av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fj7dwJft; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3de247e4895so75ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750242835; x=1750847635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMasm5NLTeOa3LnvwNhHz6yuIvcaDzts0c15W8EV/BY=;
        b=fj7dwJftZnqQlzGvH1H9G2TZV+2Xi1OBAx3/jcl1HzYA5PVRg/w+5hnDj0FNatRbos
         3RvJeJq2H9F4eoP2QNTVbejiq+BwOlSTBs2n+8+L25V71uhj9dYQ9HYTBiwYHl2C3ObX
         E2WgkqgYpcB0CAKEOW6iZBJsYuLnoPaKbBTur6CJ61WPIYFGYsEnfz3TTVcwvhremhXq
         mE9mU3yYDJuu4qXyuL8topw0QaSBmIG+oqVCxOaLKGoruojIkXsaBXPAIafxCLjpIsM9
         /MsNtDMVbbzeHTwy9X8IuAAovUCXdwRFSW2IiUgnNiYV1kfK3WIbP9dkvlZwrvz9J0/g
         bGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750242835; x=1750847635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMasm5NLTeOa3LnvwNhHz6yuIvcaDzts0c15W8EV/BY=;
        b=RuyDHMAbdOD93wbEiCG/s9ugWuWXVwUgaa51R9MLjhvajeGDExQYEpy/64jAS02/GH
         ebJVL0o6Wayoi8+CyfvvXgaAic5ufVbwCyqAEd1EHRprS0TNQM6kt6Bmb9dDraJjHewM
         mUSeNkS7dcHe5tw0mr2S93Quns9fnFlgkSD6/6ZmxM7/+E1IiHtDk1EBBaURpMEU5WE9
         E0reOoXMkF44Z+hWdR36vBLuCoGo41C3SYtysTib206MWqONfTW82KFZE0wxaJ+6NO4O
         N4rYsppBVXEBiuIG/m7DCYxoOK9XXA7hv6doNtNG+pwWirlAt0+3lR5qzNkTfylviruX
         HAuw==
X-Forwarded-Encrypted: i=1; AJvYcCVTn/29vKlq3eU982pmDj7HaZxgc46X3pi3gh17PIA7Lg48ecVDSfW6lZvgE4P3RB1YACNPFDTDmByMErRyR6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwCx++Tcy7+h+/wrXQIgzx6qp+pDTNF7ut49pMr1oCwWk6hip8
	Sca6Ybt3s01BEca+IHsIfJOx3nSJCJfai69ekaUz21vhpwwo8cuyQaGn3KX0JdRzYX68A31SrWm
	qKUBFnBYYF7qwjkTaW+s55vVJELIcuV1s5nniY/ZN
X-Gm-Gg: ASbGncuo4khI7b4s3emA6BJ1xZxQkBbQeg2+i7YUOjNN5zwrMdHe+g8WQjTSqxuQW3p
	ApFc20biPrbSr9mGJmCkvO368Ako64tlvg7NptA+tl4xp3Zg270pfmckS9g8lR5wFeAeDSkMBqC
	BEefJ4SnNBB5I9DV8na0jWBwbogwzKY+d7plXP51nSkuUCJSW2/XGE+lANv0tWir/1K1zyrK1rn
	A==
X-Google-Smtp-Source: AGHT+IFUn0kte+qO4e1bwA89IY61wmWpdTt8zSSKdMIWffb7S2xtlYoRgW/IyLqPu3AZHr+Gd6Rdhrj8xjt2/opYI9k=
X-Received: by 2002:a05:6e02:1fcc:b0:3dd:c6d6:85ef with SMTP id
 e9e14a558f8ab-3de2e65fec3mr61995ab.2.1750242834499; Wed, 18 Jun 2025 03:33:54
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618103204.3458380-1-yuyanghuang@google.com>
In-Reply-To: <20250618103204.3458380-1-yuyanghuang@google.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 18 Jun 2025 19:33:18 +0900
X-Gm-Features: Ac12FXwsiARm_Bq9k6H7Tpcmasnme1vYzSaQJxx2EPhqDxzJLIxovjT9qe_4KFQ
Message-ID: <CADXeF1FvJZpVhLO1nHpVBgZoOzZ=6zOnRtkN9m8GsCoyJxMjXw@mail.gmail.com>
Subject: Re: [PATCH net-next, v3] selftest: Add selftest for multicast address notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, please ignore this patch. Accidentally send the old patch again.....


On Wed, Jun 18, 2025 at 7:32=E2=80=AFPM Yuyang Huang <yuyanghuang@google.co=
m> wrote:
>
> This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
> and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
> removing a dummy interface and then confirming that the system
> correctly receives join and removal notifications for the 224.0.0.1
> and ff02::1 multicast addresses.
>
> The test relies on the iproute2 version to be 6.13+.
>
> Tested by the following command:
> $ vng -v --user root --cpus 16 -- \
> make -C tools/testing/selftests TARGETS=3Dnet
> TEST_PROGS=3Drtnetlink_notification.sh \
> TEST_GEN_PROGS=3D"" run_tests
>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
>
> Changelog since v2:
> - Move the test cases to a separate file.
>
> Changelog since v1:
> - Skip the test if the iproute2 is too old.
>
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/rtnetlink_notification.sh   | 159 ++++++++++++++++++
>  2 files changed, 160 insertions(+)
>  create mode 100755 tools/testing/selftests/net/rtnetlink_notification.sh
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 70a38f485d4d..ad258b25bc9d 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -40,6 +40,7 @@ TEST_PROGS +=3D netns-name.sh
>  TEST_PROGS +=3D link_netns.py
>  TEST_PROGS +=3D nl_netdev.py
>  TEST_PROGS +=3D rtnetlink.py
> +TEST_PROGS +=3D rtnetlink_notification.sh
>  TEST_PROGS +=3D srv6_end_dt46_l3vpn_test.sh
>  TEST_PROGS +=3D srv6_end_dt4_l3vpn_test.sh
>  TEST_PROGS +=3D srv6_end_dt6_l3vpn_test.sh
> diff --git a/tools/testing/selftests/net/rtnetlink_notification.sh b/tool=
s/testing/selftests/net/rtnetlink_notification.sh
> new file mode 100755
> index 000000000000..a2c1afed5023
> --- /dev/null
> +++ b/tools/testing/selftests/net/rtnetlink_notification.sh
> @@ -0,0 +1,159 @@
> +#!/bin/bash
> +#
> +# This test is for checking rtnetlink notification callpaths, and get as=
 much
> +# coverage as possible.
> +#
> +# set -e
> +
> +ALL_TESTS=3D"
> +       kci_test_mcast_addr_notification
> +"
> +
> +VERBOSE=3D0
> +PAUSE=3Dno
> +PAUSE_ON_FAIL=3Dno
> +
> +source lib.sh
> +
> +# set global exit status, but never reset nonzero one.
> +check_err()
> +{
> +       if [ $ret -eq 0 ]; then
> +               ret=3D$1
> +       fi
> +       [ -n "$2" ] && echo "$2"
> +}
> +
> +run_cmd_common()
> +{
> +       local cmd=3D"$*"
> +       local out
> +       if [ "$VERBOSE" =3D "1" ]; then
> +               echo "COMMAND: ${cmd}"
> +       fi
> +       out=3D$($cmd 2>&1)
> +       rc=3D$?
> +       if [ "$VERBOSE" =3D "1" -a -n "$out" ]; then
> +               echo "    $out"
> +       fi
> +       return $rc
> +}
> +
> +run_cmd() {
> +       run_cmd_common "$@"
> +       rc=3D$?
> +       check_err $rc
> +       return $rc
> +}
> +
> +end_test()
> +{
> +       echo "$*"
> +       [ "${VERBOSE}" =3D "1" ] && echo
> +
> +       if [[ $ret -ne 0 ]] && [[ "${PAUSE_ON_FAIL}" =3D "yes" ]]; then
> +               echo "Hit enter to continue"
> +               read a
> +       fi;
> +
> +       if [ "${PAUSE}" =3D "yes" ]; then
> +               echo "Hit enter to continue"
> +               read a
> +       fi
> +
> +}
> +
> +kci_test_mcast_addr_notification()
> +{
> +       local tmpfile
> +       local monitor_pid
> +       local match_result
> +
> +       tmpfile=3D$(mktemp)
> +
> +       ip monitor maddr > $tmpfile &
> +       monitor_pid=3D$!
> +       sleep 1
> +       if [ ! -e "/proc/$monitor_pid" ]; then
> +               end_test "SKIP: mcast addr notification: iproute2 too old=
"
> +               rm $tmpfile
> +               return $ksft_skip
> +       fi
> +
> +       run_cmd ip link add name test-dummy1 type dummy
> +       run_cmd ip link set test-dummy1 up
> +       run_cmd ip link del dev test-dummy1
> +       sleep 1
> +
> +       match_result=3D$(grep -cE "test-dummy1.*(224.0.0.1|ff02::1)" $tmp=
file)
> +
> +       kill $monitor_pid
> +       rm $tmpfile
> +       # There should be 4 line matches as follows.
> +       # 13: test-dummy1    inet6 mcast ff02::1 scope global
> +       # 13: test-dummy1    inet mcast 224.0.0.1 scope global
> +       # Deleted 13: test-dummy1    inet mcast 224.0.0.1 scope global
> +       # Deleted 13: test-dummy1    inet6 mcast ff02::1 scope global
> +       if [ $match_result -ne 4 ];then
> +               end_test "FAIL: mcast addr notification"
> +               return 1
> +       fi
> +       end_test "PASS: mcast addr notification"
> +}
> +
> +kci_test_rtnl()
> +{
> +       local current_test
> +       local ret=3D0
> +
> +       for current_test in ${TESTS:-$ALL_TESTS}; do
> +               $current_test
> +               check_err $?
> +       done
> +
> +       return $ret
> +}
> +
> +usage()
> +{
> +       cat <<EOF
> +usage: ${0##*/} OPTS
> +
> +        -t <test>   Test(s) to run (default: all)
> +                    (options: $(echo $ALL_TESTS))
> +        -v          Verbose mode (show commands and output)
> +        -P          Pause after every test
> +        -p          Pause after every failing test before cleanup (for d=
ebugging)
> +EOF
> +}
> +
> +#check for needed privileges
> +if [ "$(id -u)" -ne 0 ];then
> +       end_test "SKIP: Need root privileges"
> +       exit $ksft_skip
> +fi
> +
> +for x in ip;do
> +       $x -Version 2>/dev/null >/dev/null
> +       if [ $? -ne 0 ];then
> +               end_test "SKIP: Could not run test without the $x tool"
> +               exit $ksft_skip
> +       fi
> +done
> +
> +while getopts t:hvpP o; do
> +       case $o in
> +               t) TESTS=3D$OPTARG;;
> +               v) VERBOSE=3D1;;
> +               p) PAUSE_ON_FAIL=3Dyes;;
> +               P) PAUSE=3Dyes;;
> +               h) usage; exit 0;;
> +               *) usage; exit 1;;
> +       esac
> +done
> +
> +[ $PAUSE =3D "yes" ] && PAUSE_ON_FAIL=3D"no"
> +
> +kci_test_rtnl
> +
> +exit $?
> --
> 2.50.0.rc1.591.g9c95f17f64-goog
>

