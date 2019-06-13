Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F0C44FE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2019 01:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFMXRV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 19:17:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37578 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFMXRV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 19:17:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id 20so372440pgr.4
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2019 16:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CbjQfCCZwiSsYH4YiMUo/AKyv6rSmzSkQV067FGZEME=;
        b=DZrBSJdrvWPc/Y/e/dn9oz+sWV2pwbNiU3XcW6SB8lhZQB5EyD/kWau5sv67w00nd+
         ZLDPoUMMNI87xh39oPLSNJb5yvnDfY8rifqHlej7mRggdsVtY7HjLdj5X0KxheMtOISo
         qMjrTkLBhb4EJFkX9bTqccoPFOt+83sM/KxYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CbjQfCCZwiSsYH4YiMUo/AKyv6rSmzSkQV067FGZEME=;
        b=eWSHnLnTHtBqe9hk7ACO86IoXejBCIO4CsTuzycAmGCB23XErH4eoBztM9NEjuRUyN
         qH0MkRTUq5CxH4bF44tlMsj4WoV3evFXF0YQKi+9tA+hAbc0FN/7Z0aDsleh5QHi/6eB
         SMjSLICl2u/mBGw9jfXoxlCpsV1HWPIdvbLjc3FQqGUykHxtg2QNIgeR3I5lIstuN8a0
         asO7o8VJeZau4IF1vBerKCzZnr73jxzdQXcipdoThMUmBJt98zb7pcUoEk2EMPc64yIY
         t1Qc1GQsw1KOB1pC/+GY/bBv73PKfle/f7hTet4//WrW3m6z4QCBRyslF3gtFTRhK7a2
         9WYQ==
X-Gm-Message-State: APjAAAVHZvpiSIzzXOWaY6GKqdu1CbdvxZYOj5gz6ukmkY2B9AHjFvO/
        qogi89VIjMWQiFte7QUXyD9EWiff+Bk=
X-Google-Smtp-Source: APXvYqxcWU2EXfT8Cp45fldnGEUzcDKojfFhGQbZQ+q0cQB8HtayFQNW/2oDwAPvehUKFi6m5msE3A==
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr8084484pjw.17.1560467839151;
        Thu, 13 Jun 2019 16:17:19 -0700 (PDT)
Received: from jltm109.jaalam.net (vancouver-a.appneta.com. [209.139.228.33])
        by smtp.gmail.com with ESMTPSA id r15sm732562pfc.162.2019.06.13.16.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 16:17:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH net-next v2 1/3] net/udpgso_bench_tx: options to exercise
 TX CMSG
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-KcA5NZ2_tp3zaxW5sbf75a17DLX+VR9hyZo7MTcYAxiw@mail.gmail.com>
Date:   Thu, 13 Jun 2019 16:17:16 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <361B0BB3-0351-4F97-9BAD-9E37DCCFAE2F@appneta.com>
References: <20190528184708.16516-1-fklassen@appneta.com>
 <20190528184708.16516-2-fklassen@appneta.com>
 <CAF=yD-KcA5NZ2_tp3zaxW5sbf75a17DLX+VR9hyZo7MTcYAxiw@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On May 28, 2019, at 2:35 PM, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>> -static void flush_zerocopy(int fd)
>> +static void flush_cmsg(struct cmsghdr *cmsg)
>> {
>> -       struct msghdr msg =3D {0};        /* flush */
>> +       switch (cmsg->cmsg_level) {
>> +       case SOL_SOCKET:
>> +               if (cmsg->cmsg_type =3D=3D SO_TIMESTAMPING) {
>> +                       int i;
>> +
>> +                       i =3D (cfg_tx_ts =3D=3D =
SOF_TIMESTAMPING_TX_HARDWARE) ? 2 : 0;
>> +                       struct scm_timestamping *tss;
>=20
> Please don't mix declarations and code

Fixing this as well as other declarations for v3.

>> +
>> +                       tss =3D (struct scm_timestamping =
*)CMSG_DATA(cmsg);
>> +                       if (tss->ts[i].tv_sec =3D=3D 0)
>> +                               stat_tx_ts_errors++;
>> +               } else {
>> +                       error(1, 0,
>> +                             "unknown SOL_SOCKET cmsg type=3D%u =
level=3D%u\n",
>> +                             cmsg->cmsg_type, cmsg->cmsg_level);
>=20
> Technically, no need to repeat cmsg_level


Will fix all 3 similar messages

>> +               }
>> +               break;
>> +       case SOL_IP:
>> +       case SOL_IPV6:
>> +               switch (cmsg->cmsg_type) {
>> +               case IP_RECVERR:
>> +               case IPV6_RECVERR:
>> +               {
>> +                       struct sock_extended_err *err;
>> +
>> +                       err =3D (struct sock_extended_err =
*)CMSG_DATA(cmsg);
>> +                       switch (err->ee_origin) {
>> +                       case SO_EE_ORIGIN_TIMESTAMPING:
>> +                               // Got a TX timestamp from error =
queue
>> +                               stat_tx_ts++;
>> +                               break;
>> +                       case SO_EE_ORIGIN_ICMP:
>> +                       case SO_EE_ORIGIN_ICMP6:
>> +                               if (cfg_verbose)
>> +                                       fprintf(stderr,
>> +                                               "received ICMP error: =
type=3D%u, code=3D%u\n",
>> +                                               err->ee_type, =
err->ee_code);
>> +                               break;
>> +                       case SO_EE_ORIGIN_ZEROCOPY:
>> +                       {
>> +                               __u32 lo =3D err->ee_info;
>> +                               __u32 hi =3D err->ee_data;
>> +
>> +                               if (hi =3D=3D lo - 1) {
>> +                                       // TX was aborted
>=20
> where does this come from?

This check can be removed. In sock_zerocopy_callback() this
check was intended to cover the condition where len =3D=3D 0,
however it appears that it is impossible.

	/* if !len, there was only 1 call, and it was aborted
	 * so do not queue a completion notification
	 */

	if (!uarg->len || sock_flag(sk, SOCK_DEAD))
		goto release;

	len =3D uarg->len;
	lo =3D uarg->id;
	hi =3D uarg->id + len - 1;


>=20
>> +                                       stat_zcopy_errors++;
>> +                                       if (cfg_verbose)
>> +                                               fprintf(stderr,
>> +                                                       "Zerocopy TX =
aborted: lo=3D%u hi=3D%u\n",
>> +                                                       lo, hi);
>> +                               } else if (hi =3D=3D lo) {
>=20
> technically, no need to special case
>=20

Removed

>> +                                       // single ID acknowledged
>> +                                       stat_zcopies++;
>> +                               } else {
>> +                                       // range of IDs acknowledged
>> +                                       stat_zcopies +=3D hi - lo + =
1;
>> +                               }
>> +                               break;
>=20
>> +static void set_tx_timestamping(int fd)
>> +{
>> +       int val =3D SOF_TIMESTAMPING_OPT_CMSG | =
SOF_TIMESTAMPING_OPT_ID;
>=20
> Could consider adding SOF_TIMESTAMPING_OPT_TSONLY to not have to deal
> with a data buffer on recv from errqueue.

Will add and modify code appropriately for v3.

