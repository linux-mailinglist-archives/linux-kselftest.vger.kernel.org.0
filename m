Return-Path: <linux-kselftest+bounces-3207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5C831D14
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9DFBB21368
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4CB2942C;
	Thu, 18 Jan 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoyPFNDR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E128DDC;
	Thu, 18 Jan 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593506; cv=none; b=oR/7M1DhTuuYs8pe846+PswmzoIm6hWH9T2j9VfHyBkSQfLvzb0K2iM+C4VFJ6s+ULBF57u3HXX3Xr1UEHQVfPTzu9Wy+SMRJp/DDN1QGP1g/6gi/0Dk7MZHrIks5BunLBrlXJiiz7bOxRuCa76x483waKKeXLDOnxBRImT0y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593506; c=relaxed/simple;
	bh=Jo+hkOmUmMw3vLM/5mQ6/zrhSbHQlyxqBki+RQtFmfM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version; b=WCE5wkCMdEkHb7sd0iHnCyA3YqEFOeEhGDELWNx6F7d1fkCc3cIWrsWBp63XMWDgHfCLRZYEgEbnxkhY4b0PAhoe8NB1zsNi27yqnK/22xPkE8VYz6akNUeYWZ5oGLUoCIzXW1w7BvPk14mA6tBwz3kYtgKGWWoj4U3+tw3MHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoyPFNDR; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so38673331fa.0;
        Thu, 18 Jan 2024 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705593502; x=1706198302; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTWmzonaHYGbmFv6lrM04rWTzlEX/WK2GByvrP1Gi5A=;
        b=AoyPFNDRsF4Gj9S+P1qUQmLrsJeRfEZeqrgGNAbDHiToBmnMrbmshpFy7rnIQj+sEH
         Gd67J2leLF3NuXKgxKCcHsXMcXlUYdDVz/wkFZHylHtwpUqns0+kNG9+W5kF8ImXRMuJ
         +iYcgazXNUCm9sI/TfkKBSElZkigXIXrLvM50ObVlBCMp9U55saBfAT/Ap+jomRPY9OX
         IJX4J/TRgsgsreFHbn8NyNcu/DgL6rImgw7f8GB5nZNFxEcsa+k+NLRLe1LlBo4ZC6pg
         gCd0Gavp8exMDHgHs4vaifCjfcBjpPFVJzxNLsxf/udcC4jlIlIs/CTflHqZi+o/mQnl
         Jvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593502; x=1706198302;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTWmzonaHYGbmFv6lrM04rWTzlEX/WK2GByvrP1Gi5A=;
        b=AJ0P6IClj9ivzZhtAMP5oiz2Mvb8o+kZxpz0sPiOpWUjtyeM/hWbzLnMiuq735WQnQ
         Jm7JHt4vwFYP4sPob7HC9xfCozLPmnk9SDZL3mDZ3qxuoqTPY9AWzAp54jz1Wbgpe1z/
         bn9CNNQfejLJc/R+RC6PV7P6MJUVHVLpYuG6eT9rSHZWsuYmHWxQawS9gM20UjvvrPny
         3pcjRlAu9bkBnZ79DBbcwm6nJwaMD56hRtV/DhI/5CfCPEZA/hJmJx8iHdiQ8Km7097N
         vStjgwiO07xbPnSw1IgSLFcFjHEYSafYjPv6b+E54jD+uxK/gCFVQe8pgTtWDCyBU8Ps
         eysQ==
X-Gm-Message-State: AOJu0Yy3P0xaHVaDh5vojIHkZVacZIo+/eVgiLkQx3vf7+Of0xaUzVwu
	A5mtLfr8l9uP8LmJoJkVl3dTSl6rJ4YO20H+nItLY33Fw6Mod8+b
X-Google-Smtp-Source: AGHT+IGxsF62FibAGf/CLh35o5AQWmdZcqHzYyf7Oy8geBoraJslW9lZauYIMznkGyx3VbuhmmnrUw==
X-Received: by 2002:a2e:b043:0:b0:2cd:45d9:a940 with SMTP id d3-20020a2eb043000000b002cd45d9a940mr356296ljl.131.1705593502396;
        Thu, 18 Jan 2024 07:58:22 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d4a89000000b00337d8b76b36sm285313wrq.68.2024.01.18.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:58:21 -0800 (PST)
Message-ID: <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>
Subject: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko
	 <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	 <jolsa@kernel.org>
Date: Thu, 18 Jan 2024 17:58:20 +0200
In-Reply-To: <f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
References: 
	<f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 19:58 +0800, Shung-Hsi Yu wrote:
> Hi,
>=20
> Compilation of lsm_cgroup.c will fail if the vmlinux.h comes from a
> kernel that does _not_ have CONFIG_PACKET=3Dy. The reason is that the
> definition of struct sockaddr_ll is not present in vmlinux.h and the
> compiler will complain that is has an incomplete type.
>=20
>     CLNG-BPF [test_maps] lsm_cgroup.bpf.o
>   progs/lsm_cgroup.c:105:21: error: variable has incomplete type 'struct =
sockaddr_ll'
>     105 |         struct sockaddr_ll sa =3D {};
>         |                            ^
>   progs/lsm_cgroup.c:105:9: note: forward declaration of 'struct sockaddr=
_ll'
>     105 |         struct sockaddr_ll sa =3D {};
>         |                ^
>   1 error generated.
>=20
> While including linux/if_packet.h somehow made the compilation works for
> me, IIUC this isn't a proper solution because vmlinux.h and kernel
> headers should not be used at the same time (and would lead to
> redefinition error when the kernel is built with CONFIG_PACKET=3Dy, e.g.
> on BPF CI).
>=20
> What would be the suggested way to work around this?
>=20
> Thanks,
> Shung-Hsi

Hi Shung-Hsi,

One option is to use CO-RE, e.g. as at the bottom of this email
(not sure if people would agree with me).
But that would not produce usable test anyways,
as load would fail with unresolved CO-RE relocation.

But what is your final goal?
As far as I understand, selftests are supposed to be built and run
using specific configuration, here is how config for x86 CI is prepared:

./scripts/kconfig/merge_config.sh \
         ./tools/testing/selftests/bpf/config \
         ./tools/testing/selftests/bpf/config.vm \
         ./tools/testing/selftests/bpf/config.x86_64

(root is kernel source).
I'm not sure if other configurations are supposed to be supported.

Thanks,
Eduard

---

diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing=
/selftests/bpf/progs/lsm_cgroup.c
index 02c11d16b692..8381e5a202c8 100644
--- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -2,6 +2,7 @@
=20
 #include "vmlinux.h"
 #include "bpf_tracing_net.h"
+#include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
=20
@@ -98,11 +99,15 @@ int BPF_PROG(socket_post_create2, struct socket *sock, =
int family,
        return real_create(sock, family, protocol);
 }
=20
+struct sockaddr_ll___local {
+       __be16 sll_protocol;
+} __attribute__((preserve_access_index));
+
 static __always_inline int real_bind(struct socket *sock,
                                     struct sockaddr *address,
                                     int addrlen)
 {
-       struct sockaddr_ll sa =3D {};
+       __u16 sll_protocol =3D 0;
=20
        if (sock->sk->__sk_common.skc_family !=3D AF_PACKET)
                return 1;
@@ -110,8 +115,10 @@ static __always_inline int real_bind(struct socket *so=
ck,
        if (sock->sk->sk_kern_sock)
                return 1;
=20
-       bpf_probe_read_kernel(&sa, sizeof(sa), address);
-       if (sa.sll_protocol)
+       bpf_probe_read_kernel(
+               &sll_protocol, sizeof(sll_protocol),
+               (__u8*)address + bpf_core_field_offset(struct sockaddr_ll__=
_local, sll_protocol));
+       if (sll_protocol)
                return 0; /* EPERM */
=20
        /* Can access cgroup local storage. */

