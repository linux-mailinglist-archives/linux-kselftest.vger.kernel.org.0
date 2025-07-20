Return-Path: <linux-kselftest+bounces-37685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE722B0B6EE
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 18:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4748F3A2839
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F50B1DC9BB;
	Sun, 20 Jul 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpVDtJXI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01AE1ACED5;
	Sun, 20 Jul 2025 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029183; cv=none; b=rfWAZOqKC48ZJ4TMHaHJJBEHoi/gm1k1e691v3heBB2wXIcAfWqAcci+oLMgszzPilRUmyW0DIDrnldF7gjDyU3irIvCwVFdtYNTd8hB6tXA35p5yrXERqR0CdRX82iCZ2TRbVAeBPedbvl+NSAPAAFJHMpk3l3za+y7wajCe9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029183; c=relaxed/simple;
	bh=qUJk48jtUKEAw/MslwK7j0CvoduppN0NcJm4wds+mh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cS8Yl0YjDlRAG6Jb/0EIA8dnocLvc9gRO4Mp5w7n/o4t6X9FABe4zbVxbVEXbA0jTk8E7RGuiWwbo7wZB6Us2Ki1qzHWQ+68wJ7uHiXII3/hrpaFZGQ5QYQMOCU/oSp+YBSdykteRWcCwSpcWZWzOjJ39eC6gUFauMxqGoqwWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpVDtJXI; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3dda399db09so45131135ab.3;
        Sun, 20 Jul 2025 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753029181; x=1753633981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+56cb37M9xr882rSl73dpaeL2aKKNDupS6npCA0l6U=;
        b=WpVDtJXITHzEOg4YPrpdSt3JWXPC+lKN/4xnd39SKYTRonXeB4ZaJr3oo+AkFsHPXJ
         de2QrILgo5rGRsZ7bGp2II46ZajAkS6+25jIYc91dw/EpYI0yeFiyhBRfntBan4LVpRW
         CkCiUSDpcz1lpYuAmgJ31gnAM805TvZJo89p4DyNP4CMkivUxhchyFsK29Yrtk2224r+
         lHZQgtOWBymsD6cgJTcA1EBYDVjSQGA10Vv0JOZjZYcRUtX7mZKive10w3OuIB2t/Pbc
         Z6MsXrPMmq0ze/K+rXuUQsu3dIH+xofNwy6J+F0542r8UexQItz2IbAz6tUHH3aCTAOH
         HRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753029181; x=1753633981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+56cb37M9xr882rSl73dpaeL2aKKNDupS6npCA0l6U=;
        b=ftiUwnvCk1xW3/AW4HTJ4EHTFnD+LUbCgSfUyGcqQc+j0wdtOfm3U5ynvCMXzH8NwH
         1sSOHepC6cON2s8U5KPpI+nx0bJOdezcIOPLTHqwKD9eYanXOt2WK2oEctEgQ526+w+v
         uSkHcgcWNHVliUSq4jtHDwjv1cxg513UcB7bpV+2OA6Xs3wxSduY8MsfwUaZ7Y90ctDQ
         imkF9rBqpktwUId2KWCJTg1O8/qrjRiG0XX2hAbVbedIOl32WWcTaf99eYA1uHe4uixy
         BTuZ+KrT7onefN0S9Kl6zxSevoRcXPOXuSscOZ6vNvk46XXYtJ61sObcUyiQhz8U0qka
         fiUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHy8Z7HO1NsSRXaWpQnSbPhe/VlYJz6JD/pQbbj8919nIRmbZbCf3bnEXBESC7dxdm6k/OK0tQgpoqdS8=@vger.kernel.org, AJvYcCUN0ykuYR3sa9fz3YF9TnIW1CrQOyq0ElUZyU4EnQZU9M5dRLmerOA3tqHFj9IsbYrTORwhXulW/Lza50z0xR/x@vger.kernel.org, AJvYcCUhXZLnELeuYtfwWIsMLQkovlHJ19kXgaRB65Cn1jER9ymemAVq9w2d9DiYIFnAQCG9G41BDCTI@vger.kernel.org
X-Gm-Message-State: AOJu0YzxucvoUXxdqJlUyxDzZ+yzGMaAuhjcesfRYppVwcSEYkG5za6m
	GqioBEEj1+Mw2V+RmURHFsCCu0hZK2O6Ij01SuJGqjCECzk0tn4hnbKQ7VtaVclwoGX0kbdNT1z
	OwUjOHclnEhKJ2k3QffgYNx+VXwXfAa4=
X-Gm-Gg: ASbGncupDUiQxGDmglHEK7SmUB5lL3qXHkexKK1Y23+SPjVe3n9HHk3B6c0TlRtvnrW
	tA/zPgfbmji5dqk3B7vcJzcdeF7siA2qd5WTfA7DWyRhOQXkcj64Dp7ikbEy8b/zrwYpjlZ6MX7
	mXV5cq7EWPwflWD/DaKl6PUTwDRhdwPTkP9aErdM57iIwVH57oV4d6yJfl8j2CXSH6MF3zd5DMV
	++JmG4AgbnHRTugQBUu
X-Google-Smtp-Source: AGHT+IH7R74bM/DR3bE8CnVCBdDKl45iZr8XjYjDMkWtgicO4pmWVyjMjPluvkR5XbdGjT4cBag+2yTJ/P0b4kFRjFI=
X-Received: by 2002:a05:6e02:349e:b0:3e2:9e1b:2e4 with SMTP id
 e9e14a558f8ab-3e29e1b04f6mr81167245ab.15.1753029180522; Sun, 20 Jul 2025
 09:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f354a1afd60f29bbbf02bd60cb52ecfc0b6bd17.1752848172.git.shuali@redhat.com>
In-Reply-To: <1f354a1afd60f29bbbf02bd60cb52ecfc0b6bd17.1752848172.git.shuali@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 20 Jul 2025 12:32:49 -0400
X-Gm-Features: Ac12FXzGN6Nx5Iu-9nw959TpqbsEu1X3tFnDxpAqE8LqO30VJDATUwKgw4dcyy4
Message-ID: <CADvbK_f8Uz82t96jXWFB-72A1_+qJGysfAhFKA1aWssiwdO+ww@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: tc: Add generic erspan_opts matching
 support for tc-flower
To: shuali@redhat.com
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:16=E2=80=AFAM <shuali@redhat.com> wrote:
>
> From: Li Shuang <shuali@redhat.com>
>
> Add test cases to tc_flower.sh to validate generic matching on ERSPAN
> options. Both ERSPAN Type II and Type III are covered.
>
> Also add check_tc_erspan_support() to verify whether tc supports
> erspan_opts.
>
> Signed-off-by: Li Shuang <shuali@redhat.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 14 +++++
>  .../selftests/net/forwarding/tc_flower.sh     | 52 ++++++++++++++++++-
>  2 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testin=
g/selftests/net/forwarding/lib.sh
> index 9308b2f77fed..890b3374dacd 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -142,6 +142,20 @@ check_tc_version()
>         fi
>  }
>
> +check_tc_erspan_support()
> +{
> +       local dev=3D$1; shift
> +
> +       tc filter add dev $dev ingress pref 1 handle 1 flower \
> +               erspan_opts 1:0:0:0 &> /dev/null
> +       if [[ $? -ne 0 ]]; then
> +               echo "SKIP: iproute2 too old; tc is missing erspan suppor=
t"
> +               return $ksft_skip
> +       fi
> +       tc filter del dev $dev ingress pref 1 handle 1 flower \
> +               erspan_opts 1:0:0:0 &> /dev/null
> +}
> +
>  # Old versions of tc don't understand "mpls_uc"
>  check_tc_mpls_support()
>  {
> diff --git a/tools/testing/selftests/net/forwarding/tc_flower.sh b/tools/=
testing/selftests/net/forwarding/tc_flower.sh
> index b1daad19b01e..b58909a93112 100755
> --- a/tools/testing/selftests/net/forwarding/tc_flower.sh
> +++ b/tools/testing/selftests/net/forwarding/tc_flower.sh
> @@ -6,7 +6,7 @@ ALL_TESTS=3D"match_dst_mac_test match_src_mac_test match_=
dst_ip_test \
>         match_ip_tos_test match_indev_test match_ip_ttl_test
>         match_mpls_label_test \
>         match_mpls_tc_test match_mpls_bos_test match_mpls_ttl_test \
> -       match_mpls_lse_test"
> +       match_mpls_lse_test match_erspan_opts_test"
>  NUM_NETIFS=3D2
>  source tc_common.sh
>  source lib.sh
> @@ -676,6 +676,56 @@ match_mpls_lse_test()
>         log_test "mpls lse match ($tcflags)"
>  }
>
> +match_erspan_opts_test()
> +{
> +       RET=3D0
> +
> +       check_tc_erspan_support $h2 || return 0
> +
> +       # h1 erspan setup
> +       tunnel_create erspan1 erspan 192.0.2.1 192.0.2.2 dev $h1 seq key =
1001 \
> +               tos C ttl 64 erspan_ver 1 erspan 6789 # ERSPAN Type II
> +       tunnel_create erspan2 erspan 192.0.2.1 192.0.2.2 dev $h1 seq key =
1002 \
> +               tos C ttl 64 erspan_ver 2 erspan_dir egress erspan_hwid 6=
3 \
> +               # ERSPAN Type III
> +       ip link set dev erspan1 master v$h1
> +       ip link set dev erspan2 master v$h1
> +       # h2 erspan setup
> +       ip link add ep-ex type erspan ttl 64 external # To collect tunnel=
 info
> +       ip link set ep-ex up
> +       ip link set dev ep-ex master v$h2
> +       tc qdisc add dev ep-ex clsact
> +
> +       # ERSPAN Type II [decap direction]
> +       tc filter add dev ep-ex ingress protocol ip  handle 101 flower \
> +               $tcflags enc_src_ip 192.0.2.1 enc_dst_ip 192.0.2.2 \
> +               enc_key_id 1001 erspan_opts 1:6789:0:0 \
> +               action drop
> +       # ERSPAN Type III [decap direction]
> +       tc filter add dev ep-ex ingress protocol ip  handle 102 flower \
> +               $tcflags enc_src_ip 192.0.2.1 enc_dst_ip 192.0.2.2 \
> +               enc_key_id 1002 erspan_opts 2:0:1:63 action drop
> +
> +       ep1mac=3D$(mac_get erspan1)
> +       $MZ erspan1 -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q
> +       tc_check_packets "dev ep-ex ingress" 101 1
> +       check_err $? "ERSPAN Type II"
> +
> +       ep2mac=3D$(mac_get erspan2)
> +       $MZ erspan2 -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q
> +       tc_check_packets "dev ep-ex ingress" 102 1
> +       check_err $? "ERSPAN Type III"
> +
> +       # h2 erspan cleanup
> +       tc qdisc del dev ep-ex clsact
> +       tunnel_destroy ep-ex
> +       # h1 erspan cleanup
> +       tunnel_destroy erspan2 # ERSPAN Type III
> +       tunnel_destroy erspan1 # ERSPAN Type II
> +
> +       log_test "erspan_opts match ($tcflags)"
> +}
> +
>  setup_prepare()
>  {
>         h1=3D${NETIFS[p1]}
> --
> 2.50.1
>
Reviewed-by: Xin Long <lucien.xin@gmail.com>

It would be great to also add test cases for matching VXLAN and
GENEVE options in tc flower in the future.

Thanks.

