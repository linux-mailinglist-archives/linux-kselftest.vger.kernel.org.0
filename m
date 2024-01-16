Return-Path: <linux-kselftest+bounces-3079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2567882F13D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 16:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADB7B222BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C51BF4B;
	Tue, 16 Jan 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmDOzdnV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4E1BC4C;
	Tue, 16 Jan 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6816d974e11so3405726d6.3;
        Tue, 16 Jan 2024 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705418268; x=1706023068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddq4m87un9OqUXFfz8sZzFeQcDnSpkfQD6eBRyJxaSs=;
        b=RmDOzdnVDK2OfuIVAqWEam+OR+CxPx0Sr1ehcKbF5C88lb22WLxRAFx6Vk0cMnmLfm
         f75zcHwL3PbfuYUmVjWclf0L9XbatNumAc2VYRDsgs4X4zIET6+hoIsovEkJ5QJuuwl3
         c8AL66opYHsWF68ZPlxyEdPloYRA/Fr/IpHto7hAFUJgYmtP0kiUMo98su+zBXYgo5Qp
         0MldqJi452jnYCiIBHgmLzKCSRf9V0SUPfg4mGer+3tH4Vc25jZCkX889wzabNv1jxc8
         cvzJwmI92gyY6Ty4mPtX+AEndTNb3VsGxUTlvf3/yTG213HkNuNwAG8z0bvauiLKtzP5
         SHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418268; x=1706023068;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ddq4m87un9OqUXFfz8sZzFeQcDnSpkfQD6eBRyJxaSs=;
        b=KjvJ8F7BUMZq+JB5UssWxX1Tv64dQkrGc4ejE1eLYU9qVQOztPMVw3jThrtOz6JXKr
         Esime7X7G7qbIOkgu6CDqM3sSADJUsl3hyMVKYmzMyKL6p+2nQ24M/gYATr16/4S5ctn
         +4RPvhAQNnVHpkpKwA9IvLAULMPor5EKI4oZ5XUlGgvLVlm/TPmELuULNn97nYCqbhgD
         EBc6WRBc53ZyvCZARisgcPpCRqZAyuYRQOHJyvDLzG0PtnRnP70NVhQHPapgDsIdBrZ9
         w5i8M1FDjOf9c+3mZ8j2W67q2vQ8GE2QZK5m9qrUcYOrCd/trBftaUbzeSm/KUwU+ifF
         WmeQ==
X-Gm-Message-State: AOJu0YwohIQ1zWePWjqy15ANRz3yZ+8boGBL1fbZF2B1uj77PbmM4NDJ
	DIRvgABKlkUdmpA7k+M1p1w=
X-Google-Smtp-Source: AGHT+IGx54hrwqMThsUsriq0tTUi+uM9larqqu8+gqjzyPFi+Gir6HuW8/XHp+ig70F5+Nw0jli8Dg==
X-Received: by 2002:a05:6214:224b:b0:681:55:ab with SMTP id c11-20020a056214224b00b00681005500abmr9373417qvc.81.1705418268525;
        Tue, 16 Jan 2024 07:17:48 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id mn4-20020a0562145ec400b006815d010435sm1906885qvb.5.2024.01.16.07.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:17:48 -0800 (PST)
Date: Tue, 16 Jan 2024 10:17:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <j-t.hinz@alumni.tu-berlin.de>, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <j-t.hinz@alumni.tu-berlin.de>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Deepa Dinamani <deepa.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <65a69e1be51ef_380df0294d9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240115134110.11624-1-j-t.hinz@alumni.tu-berlin.de>
References: <20240115134110.11624-1-j-t.hinz@alumni.tu-berlin.de>
Subject: Re: [PATCH bpf-next] bpf: Allow setting SO_TIMESTAMPING* with
 bpf_setsockopt()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

J=C3=B6rn-Thorben Hinz wrote:
> A BPF application, e.g., a TCP congestion control, might benefit from o=
r
> even require precise (=3Dhardware) packet timestamps. These timestamps =
are
> already available through __sk_buff.hwtstamp and
> bpf_sock_ops.skb_hwtstamp, but could not be requested: BPF programs wer=
e
> not allowed to set SO_TIMESTAMPING* on sockets.
> =

> Enable BPF programs to actively request the generation of timestamps
> from a stream socket. The also required ioctl(SIOCSHWTSTAMP) on the
> network device must still be done separately, in user space.
> =

> This patch had previously been submitted in a two-part series (first
> link below). The second patch has been independently applied in commit
> 7f6ca95d16b9 ("net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)")=

> (second link below).
> =

> On the earlier submission, there was the open question whether to only
> allow, thus enforce, SO_TIMESTAMPING_NEW in this patch:
> =

> For a BPF program, this won't make a difference: A timestamp, when
> accessed through the fields mentioned above, is directly read from
> skb_shared_info.hwtstamps, independent of the places where NEW/OLD is
> relevant. See bpf_convert_ctx_access() besides others.
> =

> I am unsure, though, when it comes to the interconnection of user space=

> and BPF "space", when both are interested in the timestamps. I think it=

> would cause an unsolvable conflict when user space is bound to use
> SO_TIMESTAMPING_OLD with a BPF program only allowed to set
> SO_TIMESTAMPING_NEW *on the same socket*? Please correct me if I'm
> mistaken.

The difference between OLD and NEW only affects the system calls. It
is not reflected in how the data is stored in the skb, or how BPF can
read the data. A process setting SO_TIMESTAMPING_OLD will still allow
BPF to read data using SO_TIMESTAMPING_NEW.

But, he one place where I see a conflict is in setting sock_flag
SOCK_TSTAMP_NEW. That affects what getsockopt returns and which cmsg
is written:

                if (sock_flag(sk, SOCK_TSTAMP_NEW))
                        put_cmsg_scm_timestamping64(msg, tss);
                else
                        put_cmsg_scm_timestamping(msg, tss);

So a process could issue setsockopt SO_TIMESTAMPING_OLD followed by
a BPF program that issues setsockopt SO_TIMESTAMPING_NEW and this
would flip SOCK_TSTAMP_NEW.

Just allowing BPF to set SO_TIMESTAMPING_OLD does not fix it, as it
just adds the inverse case.

A related problem is how does the BPF program know which of the two
variants to set. The BPF program is usually compiled and loaded
independently of the running process.

Perhaps one option is to fail the setsockop if it would flip
sock_flag SOCK_TSTAMP_NEW. But only if called from BPF, as else it
changes existing ABI.

Then a BPF program can attempt to set SO_TIMESTAMPING NEW, be
prepared to handle a particular errno, and retry with
SO_TIMESTAMPING_OLD.



 =

> Link: https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailb=
ox.tu-berlin.de/
> Link: https://lore.kernel.org/all/20231221231901.67003-1-jthinz@mailbox=
.tu-berlin.de/
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: J=C3=B6rn-Thorben Hinz <j-t.hinz@alumni.tu-berlin.de>


