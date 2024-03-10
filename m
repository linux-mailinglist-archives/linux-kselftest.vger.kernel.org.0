Return-Path: <linux-kselftest+bounces-6162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7502877600
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 10:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E23B281861
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E21EA71;
	Sun, 10 Mar 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbq6Iqvv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82B1DFE3;
	Sun, 10 Mar 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710063978; cv=none; b=X0jvqMmwvVYBNSMLwVd1gJ9IhSaNO7NBYAIFvnNB8T3ZHiylzldKeFbsjAVYwlJ7rU3giyYL/pVhZRO+0GeyDMIliTqY6y6qwdiQoZGtcS5QjkJ+pSdkU67I7dktLitEkeQnkA0tQSYqiPcxD3nZc59TduffG+O69FyYPbcv4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710063978; c=relaxed/simple;
	bh=/GhFON8Do320G8z8VQvYlu3fYyOfCpj9BoRB30wb9pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRxFGN5Lf7G8sd1VOjqhlAIcn1l543lKSGOOVlbjdciHuK6cG7P86pghLrVUzkYupURMhmQtdULPyThMWQ+JvUbIsv0ZJRVSBDlWpMAgO033RXpfhs32a4RZchh2ZRVnEC8v6rP8VIGFYapmAWUDZw6LRwYqDSs0uwG5+1nHtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbq6Iqvv; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-21f70f72fb5so2008383fac.1;
        Sun, 10 Mar 2024 01:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710063976; x=1710668776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rbg4nHfKFdyabGyYSoVhh0nolAtG4N9mQBhWKhXVkcg=;
        b=gbq6IqvvNeaYZt6yXc1uxx0IeCC7k0MrCjicD6ard83YLcskgiSDYkRlCiSzUkNgz2
         KDemMJcM55c7p+xP3IXdTMFD5jKFo0YpZTiKVxt0Tb+Z7+/V5e8B5IISWD45EF8/nukt
         XClHyAwylswzyug0b7b3ZFJH80RANRH2scGXsgamZibBuju7vm0w4ykeFoDXjxpqKumX
         8ijaHZxg7+ul/J4ggotgM0M4hdNz+Q3MSWTHkqjbVjvDr3UaTv02vp9i+juUE86X04lQ
         Ctpuzk3rC+hcyzAH1XKSwShP6IGecwjwbvhdC1hWKe/dN+5q2VMa0o3jdtf8oYZlEG8L
         9xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710063976; x=1710668776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbg4nHfKFdyabGyYSoVhh0nolAtG4N9mQBhWKhXVkcg=;
        b=pzQHtqibO7G7jui87oUrk5qopAWqegRFS7WuODSypmlTkSDX9boP4a4qa5ueq6Ru26
         pApQWST1hf8rN4SExIvcMgHR5XzFn1hLpT3RNqW2fw421N3lsAzkmksZsvOJ47+o/Tvp
         BYqj44t/eazPGCSWeJMePgOLk0K3YDBa08jo72nSUjbTtCw2gY7PTkPmEUJ4rHSB2sRF
         PM9emwVpvi8VVtg00zYEq1XGxS1wCmu3YkjzcOvggtHLu+yPQpvewBQ39ORC/0rAoVzw
         GcvRP3vQVtxNpE+oVIlVLOdcis3D4rXjcDz2RKvR8Zc+qrphrkTcQKCCV7GcrdJI3z6M
         sT6g==
X-Forwarded-Encrypted: i=1; AJvYcCVqSvx63aJJXHIBKJNmHm815YOn8d08TM2qpmxNUT2yUhHivPGcuX5mj+M6i6TxJtq2vEjHmBjC8LJYdT9tYxYXpkAFyAK+Z1o1IZDPb+JMJ47Ceq45eZC9OHhTeKbpczpho9UqbBDH1ZoBckLEZe/5NUiUB0qNKyhYrDbwoKa2nEqJ
X-Gm-Message-State: AOJu0Yx31v59ENBBtBR9VNsdo0L+65b4Oy8kdozlXkn+FLTIvGvUs+OT
	qu9Bh7zV0K1bvc4aFpU5rd3P0GpjsU2CWJmBr3+k+JKtN0OULhIE7+Tb1A8QF7M8hsmcRKOdU1g
	85SDstx9nFVK8EKtHdpJmmA0eLP8=
X-Google-Smtp-Source: AGHT+IGND3SUtjJ+29g6S46shTc540N7XnQU/eZabXpLTqPPQL7vApYdErbNBguCJDkCUdw23+W8H2a7tqQUNcn87gE=
X-Received: by 2002:a05:6870:d38c:b0:220:c899:5be1 with SMTP id
 k12-20020a056870d38c00b00220c8995be1mr4801215oag.12.1710063975795; Sun, 10
 Mar 2024 01:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229140000.175274-1-alessandro.carminati@gmail.com> <fe323c90-bda3-4837-8daa-372073014446@linux.dev>
In-Reply-To: <fe323c90-bda3-4837-8daa-372073014446@linux.dev>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Sun, 10 Mar 2024 10:45:39 +0100
Message-ID: <CAPp5cGR2gFtMh3jWHuFHXdHvLdq85j5qcMPh4EoiOv+JA_HYTw@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/selftests/bpf/test_tc_tunnel.sh: Prevent
 client connect before server bind
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Martin,
Thanks for the review.

Il giorno ven 8 mar 2024 alle ore 02:03 Martin KaFai Lau
<martin.lau@linux.dev> ha scritto:
>
> On 2/29/24 6:00 AM, Alessandro Carminati (Red Hat) wrote:
> > In some systems, the netcat server can incur in delay to start listening.
> > When this happens, the test can randomly fail in various points.
> > This is an example error message:
> >     # ip gre none gso
> >     # encap 192.168.1.1 to 192.168.1.2, type gre, mac none len 2000
> >     # test basic connectivity
> >     # Ncat: Connection refused.
>
> This explained what is the issue. Please also explain how the patch solves it.
>
The issue, as stated, depends on a race condition between the netcat client
and server. The test author addressed this problem using a sleep, which I
removed in this patch. To easily solve the issue, one could simply increase
the sleep duration. However, this patch opts to tackle the problem by
querying the /proc directory and verifying TCP binds at the specified port
before letting the client connect.
> >
> > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> > ---
> >   tools/testing/selftests/bpf/test_tc_tunnel.sh | 19 ++++++++++++++++++-
> >   1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> > index 910044f08908..01c0f4b1a8c2 100755
> > --- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
> > +++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> > @@ -72,7 +72,6 @@ cleanup() {
> >   server_listen() {
> >       ip netns exec "${ns2}" nc "${netcat_opt}" -l "${port}" > "${outfile}" &
> >       server_pid=$!
> > -     sleep 0.2
> >   }
> >
> >   client_connect() {
> > @@ -93,6 +92,22 @@ verify_data() {
> >       fi
> >   }
> >
> > +wait_for_port() {
> > +     local digits=8
> > +     local port2check=$(printf ":%04X" $1)
> > +     local prot=$([ "$2" == "-6" ] && echo 6 && digits=32)
> > +
> > +     for i in $(seq 20); do
> > +             if ip netns exec "${ns2}" cat /proc/net/tcp${prot} | \
> > +                     sed -r 's/^[ \t]+[0-9]+: ([0-9A-F]{'${digits}'}:[0-9A-F]{4}) .*$/\1/' | \
> > +                     grep -q "${port2check}"; then
>
> The idea is to check if there is socket listening on port 8888?
>
> May be something simpler like "ss -OHtl src :$1" instead?
Indeed, the aim is to ensure that the server is bound before the
client attempts to
connect by checking if socket is listening, and yes using 'ss' would be shorter.
However, I chose not to use 'ss' or 'netstat' to avoid adding new dependencies,
considering they are already many.
Nonetheless, 'ss' is preferred, I have no objections.
>
> --
> pw-bot: cr
>
> The check-and-wait fix in this patch is fine to get your test environment going.
>
> Eventually, it will be good to see the test_tc_tunnel.sh test moved to
> test_progs. The test_tc_tunnel.sh is not run by bpf CI and issue like this got
> unnoticed. Some other "*.sh" tests have already been moved to test_progs.
>
>
Regards
Alessandro

