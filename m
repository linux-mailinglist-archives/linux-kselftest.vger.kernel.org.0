Return-Path: <linux-kselftest+bounces-25176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BDAA1C474
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BCE3A64C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8811143AA9;
	Sat, 25 Jan 2025 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH9dUvCq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC39FC0E;
	Sat, 25 Jan 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737824572; cv=none; b=uR3jums7pz97su/N5cUIwW0BDOrwMUVIKimSnlRTddYugcaOMqgmYZci8Gi8ec270I5jWrYcMNc+yM4bY5mGBkaKQ7cy1QDZ9Uh9oSLlyL2EAlYG05H0Lb3Z1Fhf4mYuiT37l72IijpSynGvrSvtSR4HprVo4xCcI63Wt3dAOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737824572; c=relaxed/simple;
	bh=Pp7KSdjULskzK5KQkgWkomGbCk14GG0pEqZBEHCoqMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itduE4MtAOQ3LHHIdrmZAyimcsPFUN0TtXv4zXmnsd5Z7BUcyjR0k5k+NYkxu/Kng+CUg0+pJ4EAPvWGIfZmiQfnRZC6qL41F7Wcwp4IoA54u05J2a1OJoGy11Vq8fKIqt98w+MfcnnCcC10GZTcrE/ZeVNKBQGH1t5nDhMiD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH9dUvCq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1671763f8f.0;
        Sat, 25 Jan 2025 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737824569; x=1738429369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RZVgz8nbQmiwsniXjxhl356RdkjqAn6ljuZhQUnXzQ=;
        b=SH9dUvCqDTY9g+hCeHTjKlW2+k1+OViS8dCmgKGoG8ba3OGxLG2kj2IXKdpWtxX08G
         bcLGfyVODgpj3MLIPV7hxwBXaZv4feCTDyD7kliHHQeFLylDg5xkb++ANYU9pJVFP7E+
         uwOvIfihFL5s+lyQwblyynWxZlvCtXY2HuJervjwUBkG/1c7VTIOGtF5VZk5wwj5jk6k
         ndJfXH4bxjv2i8cstrWtRz9SOsqujQcAWpFy5cLWZhcZFoh2TGh0N6G++tamut/+SvRR
         ExDZcCWspj9S26M+KIwEJIblaOsWXDprI91M7ykyXsypwsm/rmRyXuNkixmrp/ht7C4S
         Gxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737824569; x=1738429369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RZVgz8nbQmiwsniXjxhl356RdkjqAn6ljuZhQUnXzQ=;
        b=g+ediZ7E4whweb9UNaXMYPZpw9913BQbC8HKYuowSO9236tRz+x1P6ZulF1dhJ30rh
         g58lQ2rKLR3gOE3D8Gjsc/TTrv7ZgRJqoULweyookFo0oRhtamOsOT8Z4IXAvmUlnNfO
         Mde4WogtGPW24aqdejL4rMmbAjmoHbokCwN6+rdQE2kVxIdoWWX11zt7WoA9K5UToTcH
         EomVWAugiE+9x3ix+R/+vuMSF+9Ulchbe/HU32p6n93L5KpAuJC9JG7MmgTcw0v355PF
         Rwo7L/qyrycWqxOWNw8pr1+UcQjHeVlh/lnvG7M4fgWaWBTxGh9vDlPs6Na/oGS1a2XU
         9wKw==
X-Forwarded-Encrypted: i=1; AJvYcCW0nok4ZKK5vV+zsfBcTSePuiRPiShBWDQrnK7rytAdzmZoIPmKFxO1Og0fNMKFlfY/w8nf7F3/QyQzGBA=@vger.kernel.org, AJvYcCXOlTJsaaYOQPrEmNVyM9FCyj9wASGj8RS2js+Mh9uldgm6l2qA4VT1imeWOtxsjBY3xs5WiXzsk363oxxws9hz@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYJGdF4H5bYnsGvmp2Zsc4cWc9AGNuavatI5j77yj+82dRQK7
	5WCddyaxi/uSMp2nz4dYxlXrWymtwFDET1/xPTBEyg3aUU9UneY37u/y+QllUXYPBT+7Nr2obM2
	AqtOYOdCjPsJqx+mfZID1zCvXhmg=
X-Gm-Gg: ASbGncviBna8yHysd9SyfXyPpraiZY+sv+6TGRSACfYYSgT4pQmOGLG5M4iC3D5qYED
	VyC+0Z1T7nxRyAiacQm9U3ovMVsaRziEk3IO2JU0BemIcySk9t6rgRxMlwNf1HDLK5ivX6canYi
	Px5XsV1b4/ekiuiGNW2g==
X-Google-Smtp-Source: AGHT+IFncBJk7Rm/NTVJ8KcaUzE1Kc71FdfNcxzVi9SmxE2bUKhorgEBuuNPZbkm5JAH+cSj+WeTDj4XWDGYVEU7FQ0=
X-Received: by 2002:a05:6000:1863:b0:385:f560:7911 with SMTP id
 ffacd0b85a97d-38bf5655589mr33489476f8f.10.1737824568696; Sat, 25 Jan 2025
 09:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70fb07e980196ced9fc3e5e4dbeededce2e36fdc.1737816475.git.skb99@linux.ibm.com>
 <e9240414068ee83456d01d2bc71735705df8b36f.1737816475.git.skb99@linux.ibm.com>
In-Reply-To: <e9240414068ee83456d01d2bc71735705df8b36f.1737816475.git.skb99@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 25 Jan 2025 09:02:37 -0800
X-Gm-Features: AWEUYZkHtsKSXYRdj-2hXgfJAERsZFGAibTSS5mlXgbpYqdu_HEOAVErvq6YKpI
Message-ID: <CAADnVQJWs7Dq3E8shXNwG3tOsmRJ5YYjMboGjzeueg+uMKo+rw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: Select NUMA node of current CPU to
 create map
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 7:25=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On powerpc, a CPU does not necessarily originate from NUMA node 0.
> This contrasts with architectures like x86, where CPU 0 is not
> hot-pluggable, making NUMA node 0 a consistently valid node.
> This discrepancy can lead to failures when creating a map on NUMA
> node 0, which is initialized by default, if no CPUs are allocated
> from NUMA node 0.
>
> This patch fixes the issue by setting NUMA node for map creation
> to NUMA node of the current CPU.
>
> Fixes: 96eabe7a40aa ("bpf: Allow selecting numa node during map creation"=
)
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/Makefile                      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 0a016cd71..c7a996f53 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -47,7 +47,7 @@ CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                  =
                 \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
>           -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)
>  LDFLAGS +=3D $(SAN_LDFLAGS)
> -LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
> +LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread -lnuma
>
>  PCAP_CFLAGS    :=3D $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null &=
& echo "-DTRAFFIC_MONITOR=3D1")
>  PCAP_LIBS      :=3D $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
> diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/=
tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> index cc184e442..d241d22b8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> @@ -4,6 +4,7 @@
>  #include <sys/syscall.h>
>  #include <limits.h>
>  #include <test_progs.h>
> +#include <numa.h>
>  #include "bloom_filter_map.skel.h"
>
>  static void test_fail_cases(void)
> @@ -69,6 +70,7 @@ static void test_success_cases(void)
>
>         /* Create a map */
>         opts.map_flags =3D BPF_F_ZERO_SEED | BPF_F_NUMA_NODE;
> +       opts.numa_node =3D numa_node_of_cpu(sched_getcpu()); // Get the N=
UMA node of the current CPU

let's not introduce new library deps.
Will NUMA_NO_NODE work ?

Note c++ comments are not allowed.

pw-bot: cr

