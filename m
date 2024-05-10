Return-Path: <linux-kselftest+bounces-9988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D15B8C1DE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 08:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF1A2822F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 06:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009F1527BE;
	Fri, 10 May 2024 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfjL2PUF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E7128816;
	Fri, 10 May 2024 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715321378; cv=none; b=PQj8c9QAO7ddCHXc53EDJFLel48/kLhpIyCJdmwOKE7ElH84WrWnRM4rMn1s2RincI9UGiONqOrCv0J4ixom2EbYrASv8RQU8WZp57jZ4o3R0GMfk3QtQOc7g0AuFPB1CWjAzzQfq7GA1NfdCYMkjXPHvopaU5mcLrBVO8ML0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715321378; c=relaxed/simple;
	bh=X2n280+mXsA89/FtAepb7uflU5AriFITfm3j9x0rLRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV06sc7TVxLEYXr3d0LmDy2iYe2cwXHov2jIU5xIROuZdzDf34zz93Oqmp1wtaC/KUlN4/cFvCADjBqIFnuTEITs0ZiUZ0cr+jR/kBmhyCxsT1pTH3uCDwfzGyClhkcKHT/dLlrlDAN02xytLYXyOMReM7qZh0IMxeUoZSl4yQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfjL2PUF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so18605541fa.3;
        Thu, 09 May 2024 23:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715321375; x=1715926175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6Yn4wNa98dW6VI6SqDEcxq/HOv22hewhypus1USGwM=;
        b=AfjL2PUFnQCNAlskM0oZfyRDlS61vmJz5NT9KdRnXsiA0ek/wNBwExIDUjw/ARERLN
         ut1SOMmkBA27IxrSxbpaOPFrdpEfSTHeSl43VS3OvYr6iAhNtZLCjgFFuVmyhEpbjav7
         6+4VeiuK5wEMSr9ter25Xk4+/Fk/zpNsUOV7dWy/CDbg2ewcqKS7zUvNLrzCU3kiAcFQ
         4fz0n7yhGcNOrxp53RbKPwnFcWzItkWh5OBg0WmeLVhUTbaNqcHN5hsOhf1Ds+MotuNu
         Nw1rcGsEYE56a3Nc3NWd35H6BMWqwRE/sM5Kxj9+KJuaLU+oA9E7mWR89xvN5nKQuPIm
         S34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715321375; x=1715926175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6Yn4wNa98dW6VI6SqDEcxq/HOv22hewhypus1USGwM=;
        b=mpC6dEUH+v1Z/S7+1TUl7nx/cSBqL7k/0Ggclrbrug62S+WznqoclRQlm3AKm9hnI5
         GjOsAFg9mBM+PfyA07qFEsuUXrnv0vMEXGS/J9NGpFVI7WMcXu62zejxmVmsfPKbANTr
         IxUgD5OLfrXx9js8Vh2mxtlSXQEQd/wnDjwR8t7PRqW9U5AeTVgPk1HjrBpyHa9Nz+Xu
         uQZvRxe9ygmDkO/qQ8lFN0M7/MHJi79ytENQbPnaT8uK0xhix/r3CZfxte31LVmNTzwP
         cSGXZQiHEW7GW8VNvJ0zQyr3PsBybgsBsrM9+9HGQEgY351cAqMf2JwbutORSihwRI2w
         7tNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0/SDhD2ofGc/N1wqC4uLXh7Ue1pVFkl2COgALWFb/CR3ap9hhgedP1eefl53RCbklt35IKeUT9QS0hk3Q+CCD9kqsDmxzgR5idtlt4UGx1pOBjQe1IVfGAB/4f7YA6BG1KfLvmVjH
X-Gm-Message-State: AOJu0YzY+0MrWowchW2tAdjer9gG/E3HVW5YBPCY4VORV32jwck0dkuQ
	IwT6G9/V+qamQx32qkppCaxjFb3gV2JsSqLHEXB9GpkzpZS688PMAB+gGCmUwr4cfnTD7m1Zwu1
	pLNOMm00EJYgCmb0Z0Q4SMI+X4M4=
X-Google-Smtp-Source: AGHT+IGtZRZ5lZkbKfGtptUShvonm0UqQ0HKCNe+xz6gkIbRPLcwR7OXEkKd/JP0v+EBQUYbRwjzB+EU7UPlVd25o2Y=
X-Received: by 2002:a2e:81d6:0:b0:2e4:45a6:cdcf with SMTP id
 38308e7fff4ca-2e5205ec95bmr9748531fa.43.1715321374588; Thu, 09 May 2024
 23:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509161952.3940476-1-kuba@kernel.org>
In-Reply-To: <20240509161952.3940476-1-kuba@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 10 May 2024 15:09:23 +0900
Message-ID: <CAMArcTVfJZH+u1XT4pTxiLftX=ndRoQceaSLg1SvDOr85R1D3Q@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: move amt to socat for better compatibility
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for this work!

> The test seems to expect that nc will exit after the first
> received message. This is not the case with Ncat 7.94.
> There are multiple versions of nc out there, switch
> to socat for better compatibility.
>
> Tell socat to exit after 128 bytes and pad the message.
>
> Since the test sets -e make sure we don't set exit code
> (|| true) and print the pass / fail rather then silently
> moving over the test and just setting non-zero exit code
> with no output indicating what failed.
>
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: ap420073@gmail.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/amt.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests=
/net/amt.sh
> index 75528788cb95..5175a42cbe8a 100755
> --- a/tools/testing/selftests/net/amt.sh
> +++ b/tools/testing/selftests/net/amt.sh
> @@ -210,8 +210,8 @@ check_features()
>
>  test_ipv4_forward()
>  {
> -       RESULT4=3D$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4=
000)
> -       if [ "$RESULT4" =3D=3D "172.17.0.2" ]; then
> +       RESULT4=3D$(ip netns exec "${LISTENER}" timeout 15 socat - UDP4-L=
ISTEN:4000,readbytes=3D128 || true)
> +       if echo "$RESULT4" | grep -q "172.17.0.2"; then
>                 printf "TEST: %-60s  [ OK ]\n" "IPv4 amt multicast forwar=
ding"
>                 exit 0
>         else
> @@ -222,8 +222,8 @@ test_ipv4_forward()
>
>  test_ipv6_forward()
>  {
> -       RESULT6=3D$(ip netns exec "${LISTENER}" nc -w 1 -l -u ff0e::5:6 6=
000)
> -       if [ "$RESULT6" =3D=3D "2001:db8:3::2" ]; then
> +       RESULT6=3D$(ip netns exec "${LISTENER}" timeout 15 socat - UDP6-L=
ISTEN:6000,readbytes=3D128 || true)
> +       if echo "$RESULT6" | grep -q "2001:db8:3::2"; then
>                 printf "TEST: %-60s  [ OK ]\n" "IPv6 amt multicast forwar=
ding"
>                 exit 0
>         else
> @@ -236,14 +236,14 @@ send_mcast4()
>  {
>         sleep 2
>         ip netns exec "${SOURCE}" bash -c \
> -               'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
> +               'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000=
' &
>  }
>
>  send_mcast6()
>  {
>         sleep 2
>         ip netns exec "${SOURCE}" bash -c \
> -               'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
> +               'printf "%s %128s" 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6=
000' &
>  }
>
>  check_features
> --
> 2.45.0
>

Tested-by: Taehee Yoo <ap420073@gmail.com>

