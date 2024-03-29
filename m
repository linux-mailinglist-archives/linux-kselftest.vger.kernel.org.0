Return-Path: <linux-kselftest+bounces-6925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3AA893330
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF75F1F26627
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55EE15443A;
	Sun, 31 Mar 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbnA9wdW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B93153BF7;
	Sun, 31 Mar 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902515; cv=fail; b=JNl7AdB4ENY9jc15QWkD9cFTO9FoA3jT4UTrXvQ74hG4sKGe2ORX59wk7vJ5KNk0TyVMOnYUgvTiNwcJTn6ATPWhXuFiShdwSQs4rR+0FmiYAxAI+3/C8Dw/t4pQ2VkLkyFQys8ALKVdab88cnytdIYlPT2QXIWCl3lrhtAZ/XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902515; c=relaxed/simple;
	bh=6YY9yX8gHbETL0b18AEyl8ofX2YBfKSZVv6AZC2NyZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjAEnOtOW2Cd6Qk9ltOZpcHtUKZ16QIcoIuadPx75l39/he3S1ERxE5bZyvYHqX6qr2EX44W8WfD81mJzkU1id/TuGlxgg3ZAkrNT8dMFAxcDtiDRR3JZ0bYe5K2lKLNdi7nlQuLAcjIu/ydfozuR08WzI8oyX4JBqBXetDsCwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbnA9wdW reason="signature verification failed"; arc=none smtp.client-ip=209.85.218.47; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CCC42208E2;
	Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWsPn6Yx9PPm; Sun, 31 Mar 2024 18:28:30 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 11F52208D2;
	Sun, 31 Mar 2024 18:28:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 11F52208D2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 0229B800058;
	Sun, 31 Mar 2024 18:28:30 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:29 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:34 +0000
X-sender: <netdev+bounces-83473-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAq5Lp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAdAAAAjIoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 17039
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83473-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1146620883
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750193; cv=none; b=LCJbqHT+BnRlc2TliWVOCilRovqmJ4jHSON/5dHQmB7ueJd8laXbr6Y8jpfuXUyyTmweZOdmofoE0Kjvzz4XDCe8BAndmpoXmcJb5xl/V0CfbqhB3z7TfmRapKCauIb+Z+g2ASAyvs0L4I+PnmmBQrHwJ4BH0ZsG3EvL35uPWbs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750193; c=relaxed/simple;
	bh=APnv61COTtDCJ6Qzg4G3KuYC9o9q8lUsfZq/wAf5jvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDlB9+5JRfuPUrxB12sAMGMmCsb+HQ5P0xn7RB8tFw6SfxwUPMjDyKVSbqi0Q+VzL7/BcZR0Oe9wdLl4NksBsmRx/TV4jB1S7jsMg2G0BfF2lx4C40IOJEIfTx4OsuhJLM8zL5Gfg7Dhyip+rajRMPG5wd91KnJAGw+i8A1ETGc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbnA9wdW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711750190; x=1712354990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxkK35lFdR1p3nAj6ONZyvQKPyBvTq4KRhMXv8rS1mY=;
        b=YbnA9wdW1nfAEUHgGc53U84Wh64a1VYLxb+9KShGa6m1lJVYtRXz6zRv2EUlMlo4bg
         7NlnQf+xDZaRKTZwBXfPdpcecrtY4qHI+tQ7UGfAKszgTocNMff27YduCBNMYXlPmwb7
         9mRouYZCu4c9DqByPtaL50NvRBgoOzqxwD5bl3hfFFuEGFnrWkA+kKaAtwypyS+XNqEC
         F/uSEt6VHCTNZR6ZquwespsQeUqkid0U4zfnZ23wmHBbYN9ITT8pq7yKJZRIyAG8npvB
         xQ2iR9CAO9nd8jqL+J2vqgCr/UYl1T3SxTJhtUh/7cFSVu06DBAoLpdswuo3Z8dFL8LE
         UzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711750190; x=1712354990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxkK35lFdR1p3nAj6ONZyvQKPyBvTq4KRhMXv8rS1mY=;
        b=HV4paS84sSWCanoPcVZEwJkRGhWRub4SVQ9oGMFTalLzRgOrhonXovuSjrgB/qNI17
         pl3e4fBPKLTp2+sfD1tzQcAKglV4Hc6q2nzXDMX8vMsOe/RySjGhFCFsUCpPvCSIuyNS
         1JWO3azo+CNUnMFsoCLxGLfer+yAVuYa7ZRouKfaOCidgrllBcdT6subvj04/cgf4+uH
         wzTwxyO0IyQfGoAEsRoavfQzf6Mt3gdBht7r0gbITeseCljvY9TjNsODVcaMqzDmhb7N
         4CxJK3bvymVU4NFBEDOL3o1ul8qU7P1GPZDODr9dtXlo83hfPSKEnTkShKskf/PU7a6A
         ctdg==
X-Forwarded-Encrypted: i=1; AJvYcCUxCb2yVB96UPGFat916RkR6BKGPcZ0iP0npWk9OpCkwwp+UCD7fSseu5tI7r/0VUYhBH8n2kz+QkVNw4Llrbzub824xFFbmrySHBRjsYWYQuP9oAfLzOEK+pr6xmPyzEAIYs7Flgpo
X-Gm-Message-State: AOJu0YzQbhSfiZOfcUs7tycQVkWQrGrJlq45lJZu2eHMBrD+O/b0iyXq
	k0m6EJteHXeVLajkGDsjZODAH3y4el37WNOJ/P7GbEfR/3+S1a6dIlZ4Oe23SDvnoLANuf80zEv
	cAZrRSCyaNO1mxT11fOIw/GHo1cs=
X-Google-Smtp-Source: AGHT+IFfzXXrKpD+5hfmBnKPRig47WB3T+3H62/QXWsDLkxNELXWlzbFASuowBFdLRBLkfyZgVl4l9PoMRXM8aQbJSw=
X-Received: by 2002:a17:907:9915:b0:a47:61d:7d38 with SMTP id
 ka21-20020a170907991500b00a47061d7d38mr2741292ejc.0.1711750189737; Fri, 29
 Mar 2024 15:09:49 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com> <20240329191907.1808635-2-jrife@google.com>
In-Reply-To: <20240329191907.1808635-2-jrife@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:09:31 -0700
Message-ID: <CAEf4BzarqE+t35r-+3r5AYHVcw9qaraaG+h0CTjn-b-9vX4dYg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/8] selftests/bpf: Introduce sock_addr_testmod
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 12:20=E2=80=AFPM Jordan Rife <jrife@google.com> wro=
te:
>
> sock_addr_testmod provides a mechanism for the sock_addr_kern prog_test
> to drive socket operations in kernel space. On init, one of the
> following socket operations is performed based on the module parameters:
> kernel_bind(), kernel_connect(), or sock_sendmsg()/kernel_sendmsg() and
> results are exposed through debugfs.
>
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  11 +-
>  .../bpf/sock_addr_testmod/.gitignore          |   6 +
>  .../selftests/bpf/sock_addr_testmod/Makefile  |  20 ++
>  .../bpf/sock_addr_testmod/sock_addr_testmod.c | 256 ++++++++++++++++++
>  4 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/.gitign=
ore
>  create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/Makefil=
e
>  create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/sock_ad=
dr_testmod.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 3b9eb40d63436..b5d02ff724957 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -132,7 +132,7 @@ TEST_GEN_PROGS_EXTENDED =3D test_sock_addr test_skb_c=
group_id_user \
>         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_=
user \
>         test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod=
.ko \
>         xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metada=
ta \
> -       xdp_features bpf_test_no_cfi.ko
> +       xdp_features bpf_test_no_cfi.ko sock_addr_testmod.ko
>

Do we need yet another kernel module? Can this be done as part of
existing bpf_testmod module?

>  TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mul=
ti
>
> @@ -160,6 +160,7 @@ override define CLEAN
>         $(Q)$(RM) -r $(TEST_GEN_FILES)
>         $(Q)$(RM) -r $(EXTRA_CLEAN)
>         $(Q)$(MAKE) -C bpf_testmod clean
> +       $(Q)$(MAKE) -C sock_addr_testmod clean
>         $(Q)$(MAKE) docs-clean
>  endef
>

[...]

X-sender: <netdev+bounces-83473-steffen.klassert=3Dcunet.com@vger.kernel.or=
g>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAq5Lp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAeAAAAjIoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 17063
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 23:10:06 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 23:10:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C708A20883
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:10:06 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D.749 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, FREEMAIL_FORGED_FROMDOMAIN=3D001,
	FREEMAIL_FROM=3D001, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_NONE=3D.0001,
	SPF_HELO_NONE=3D001, SPF_PASS=3D.001]
	autolearn=3Davailable autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dail.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXMB-mO3iNad for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 23:10:03 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=147=
.75.48.161; helo=3D.mirrors.kernel.org; envelope-from=3Dtdev+bounces-83473-=
steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klassert@sec=
unet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 01965208AC
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 01965208AC
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388D4B21E8B
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703213D240;
	Fri, 29 Mar 2024 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3DbnA9wdW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218=
.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D439FD6;
	Fri, 29 Mar 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
.85.218.47
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711750193; cv=3Dne; b=3DJbqHT+BnRlc2TliWVOCilRovqmJ4jHSON/5dHQmB7ueJd8l=
aXbr6Y8jpfuXUyyTmweZOdmofoE0Kjvzz4XDCe8BAndmpoXmcJb5xl/V0CfbqhB3z7TfmRapKCa=
uIb+Z+g2ASAyvs0L4I+PnmmBQrHwJ4BH0ZsG3EvL35uPWbsARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711750193; c=3Dlaxed/simple;
	bh=3Dnv61COTtDCJ6Qzg4G3KuYC9o9q8lUsfZq/wAf5jvc=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDlB9+5JRfuPUrxB12sAMGMmCsb+HQ5P0xn7RB8tFw6SfxwUPMj=
DyKVSbqi0Q+VzL7/BcZR0Oe9wdLl4NksBsmRx/TV4jB1S7jsMg2G0BfF2lx4C40IOJEIfTx4Osu=
hJLM8zL5Gfg7Dhyip+rajRMPG5wd91KnJAGw+i8A1ETGcARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dai=
l.com; spf=3Dss smtp.mailfrom=3Dail.com; dkim=3Dss (2048-bit key) header.d=
=3Dail.com header.i=3Dmail.com header.b=3DnA9wdW; arc=3Dne smtp.client-ip 9=
.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46cd9e7fca=
so305127866b.1;
        Fri, 29 Mar 2024 15:09:51 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dail.com; s 230601; t=1711750190; x=1712354990; darn=3Der.kernel=
.org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DkK35lFdR1p3nAj6ONZyvQKPyBvTq4KRhMXv8rS1mY=3D=0A=
        b=3DnA9wdW1nfAEUHgGc53U84Wh64a1VYLxb+9KShGa6m1lJVYtRXz6zRv2EUlMlo4b=
g
         7NlnQf+xDZaRKTZwBXfPdpcecrtY4qHI+tQ7UGfAKszgTocNMff27YduCBNMYXlPmw=
b7
         9mRouYZCu4c9DqByPtaL50NvRBgoOzqxwD5bl3hfFFuEGFnrWkA+kKaAtwypyS+XNq=
EC
         F/uSEt6VHCTNZR6ZquwespsQeUqkid0U4zfnZ23wmHBbYN9ITT8pq7yKJZRIyAG8np=
vB
         xQ2iR9CAO9nd8jqL+J2vqgCr/UYl1T3SxTJhtUh/7cFSVu06DBAoLpdswuo3Z8dFL8=
LE
         UzBQ=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711750190; x=1712354990;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DkK35lFdR1p3nAj6ONZyvQKPyBvTq4KRhMXv8rS1mY=3D=0A=
        b=3D4paS84sSWCanoPcVZEwJkRGhWRub4SVQ9oGMFTalLzRgOrhonXovuSjrgB/qNI1=
7
         pl3e4fBPKLTp2+sfD1tzQcAKglV4Hc6q2nzXDMX8vMsOe/RySjGhFCFsUCpPvCSIuy=
NS
         1JWO3azo+CNUnMFsoCLxGLfer+yAVuYa7ZRouKfaOCidgrllBcdT6subvj04/cgf4+=
uH
         wzTwxyO0IyQfGoAEsRoavfQzf6Mt3gdBht7r0gbITeseCljvY9TjNsODVcaMqzDmhb=
7N
         4CxJK3bvymVU4NFBEDOL3o1ul8qU7P1GPZDODr9dtXlo83hfPSKEnTkShKskf/PU7a=
6A
         ctdg=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCUxCb2yVB96UPGFat916RkR6BKGPcZ0iP0npWk9OpC=
kwwp+UCD7fSseu5tI7r/0VUYhBH8n2kz+QkVNw4Llrbzub824xFFbmrySHBRjsYWYQuP9oAfLzO=
EK+pr6xmPyzEAIYs7Flgpo
X-Gm-Message-State: AOJu0YzQbhSfiZOfcUs7tycQVkWQrGrJlq45lJZu2eHMBrD+O/b0iyX=
q
	k0m6EJteHXeVLajkGDsjZODAH3y4el37WNOJ/P7GbEfR/3+S1a6dIlZ4Oe23SDvnoLANuf80zE=
v
	cAZrRSCyaNO1mxT11fOIw/GHo1csX-Google-Smtp-Source: AGHT+IFfzXXrKpD+5hfmBnKP=
Rig47WB3T+3H62/QXWsDLkxNELXWlzbFASuowBFdLRBLkfyZgVl4l9PoMRXM8aQbJSwX-Receiv=
ed: by 2002:a17:907:9915:b0:a47:61d:7d38 with SMTP id
 ka21-20020a170907991500b00a47061d7d38mr2741292ejc.0.1711750189737; Fri, 29
 Mar 2024 15:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com> <20240329191907.180=
8635-2-jrife@google.com>
In-Reply-To: <20240329191907.1808635-2-jrife@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:09:31 -0700
Message-ID: <CAEf4BzarqE+t35r-+3r5AYHVcw9qaraaG+h0CTjn-b-9vX4dYg@mail.gmail=
.com>
Subject: Re: [PATCH v1 bpf-next 1/8] selftests/bpf: Introduce sock_addr_tes=
tmod
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,=20
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,=20
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org=
>,=20
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.c=
om>, Song Liu <song@kernel.org>,=20
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gm=
ail.com>,=20
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Lu=
o <haoluo@google.com>,=20
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan =
<shuah@kernel.org>,=20
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,=
=20
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gm=
ail.com>
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: netdev+bounces-83473-steffen.klassert=3Dcunet.com@vger.kernel.=
org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 22:10:06.8387
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 8c3a2a32-c495-4698-1768-08dc=
503cfdf0
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-dres=
den-01.secunet.de:TOTAL-HUB=3D433|SMR=3D345(SMRDE=3D035|SMRC=3D310(SMRCL=3D=
102|X-SMRCR=3D310))|CAT=3D086(CATOS=3D012
 (CATSM=3D012(CATSM-Malware
 Agent=3D012))|CATRESL=3D040(CATRESLP2R=3D018)|CATORES=3D032
 (CATRS=3D031(CATRS-Index Routing Agent=3D030)));2024-03-29T22:10:07.273Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 10947
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-02.secunet.de:TOTA=
L-FE=3D007|SMR=3D006(SMRPI=3D004(SMRPI-FrontendProxyAgent=3D004))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAXUFAAAPAAADH4sIAAAAAAAEAK1VW28T=
RxSetb2+BScB2v
 JQVToPPCRKfIljgoIKBYFBbQnQhIdKbbXay6y9tb3jzq6JI/Wh/6j/
 qT+gv6HfmbUdGwdIJVaj3ZlzvnM/c/bf7dcxPdfRPp24mtrH+9RutT
 vkpnTQftBu/fPX329O6AelAzem0yiU9O3vGp/HPaV6Q9nw1egRnWuV
 yge16iMsSpQ/cNwg0E4qk3SkAhpr9S4KZEIujaTfd+MoGVGoNKV9uQ
 QfSB0ztmcEWVWqKNDRuwwkU1Jjqd00UnFCUUyMl0NKxq4vG4QoojhK
 90nFklTIullFqIZDdR7Fvat0JIQDHBnJgDw3wVvFxil4PRlKGrvaHc
 lU6oSDmxl0vCgOdnb350dfxbH0U6YgJBNOIuNglPR2dpszzIJAbhyw
 Ki2TyTBFRrQkOR0rtp32tZr0+hRIb9ILk8Ysn2dRL5ZBXYVh3bt48I
 lSsEC9XucPsqeGSZNzifCbiRyGvE+a3jhsnrgDGUYIcfH8SXRwQHuZ
 aKPRMLC1WjYbvSiFQ0qvitIR7S0kV02t67g0Dsl2i/b2PmF0jdLwId
 q+B6Nrj1HVIdafEDdbTwbo6eM22iOR2lR+Zw/FOkCih5LPO/VdI+Vr
 6aam+JIOWq2jTuejOfxYcj6PvnmiPo+2K7I4a7EgCkO0Dbwnt3mttv
 GuBWPduCxySofesfQ6reDosHN41Gh494JWOwzvtzvH9+7Popm17jU9
 YDSq/T8cefyY6geH7f37tJd9QHjbPXvrvOi+ct6cvn5x5nR/ftt99a
 z7jB4S63AWGZsdB57j93BJx04UOBN0E/1qSjN7QkwaJ4iSBONAaWeo
 3CATXGVktNQfO35f8rS4iH2lBpG8QqWBDiPtO1z3doaYBmMeaIbnj8
 ekJ/EfCUyA5cnY7xNCX9R4oFY1TpPB1JcYqkaPo2UQabjljDCPIkOC
 P5jC0wsCJkpS/AmY2j93MArdwE3dTGF9rhDMEK05wUxbWHZi5fhhBO
 umUNeDrv86MvlatVZ9puhcUiwxJy8wxd1YYU7r+T8gm9ff0VOX5zfm
 uicp4B+Bm/AQx9QPa1U5jUyPLKdnLskmkKNFPzz//mX3jPYe0jDyJh
 pDW42QKjdoJIqWz5TgvtfNlZggaZ7M8ji7V6bljlr7mFP8MS2nkFWN
 vyGmTxjBw6cvu09eLRfo7s5Pu3d3Tk92qa5xWHVp9yNIdO/pE8fouw
 J28uTHLoBPV6L3h9KNlyv0Hnb9X76QuEp7oPykfonAT0+Gs/r9gun+
 G2+EyIl8Xth5S9zAEoWcKBSEnbPyZSHKolIUpYIo2pbYFkXsgbRFrW
 CJm8IGrCTKwFgiVxHVvChggbVpWLwsUeFNGSZsI14VG9hjY4sSNtCc
 Z4twoAQNCwD2wBt6wRC3ipbYYE/KRdZfKhlYgR2GD9U5ET7gXYYU3m
 axYI3d5rjWYtmGFcAy58vWlznOxmYWxTzASsW6YwkBUxlsJXardpVI
 eXlvWUiLyFtfGyU5tmhVmCIKVWsrI5bFNvtm2UUhTHIuvVrxRGxeA4
 aK1K4DW3ESR5OlmYeLnJjirlJu4FgTWzVr0+jfXANsv0+xtgoCqm0O
 1spd7k2H3EHviQLwZbHxXvNkrOKsVW6BclvY0JlxbxsYHy3xzVyJ4T
 LyC8MFBW+TDTQzY9BgIOa5nbhJcmIbFBxvmWAz1g2zx8J+y/RnWXy1
 oGdEviOmP7n6H2Tll5OcExVQTCx21qJwrGjaNRNZes+0bcxgm1lmTI
 yVKnu7kYFLbLq8dNfsIlNK9odznl1qW9xEmbKVE3a2WbJya51rsz/F
 ZRZ6Bu+Fn8s6M9Zy+KvcIlhVLlDV/g9jNl8E8wwAAAECzgI8P3htbC
 B2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxUYXNr
 U2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPF
 Rhc2tzPg0KICAgIDxUYXNrIFN0YXJ0SW5kZXg9IjE2OTkiPg0KICAg
 ICAgPFRhc2tTdHJpbmc+RG8gd2UgbmVlZCB5ZXQgYW5vdGhlciBrZX
 JuZWwgbW9kdWxlPzwvVGFza1N0cmluZz4NCiAgICAgIDxBc3NpZ25l
 ZXM+DQogICAgICAgIDxFbWFpbFVzZXIgSWQ9ImpyaWZlQGdvb2dsZS
 5jb20iPkpvcmRhbiBSaWZlPC9FbWFpbFVzZXI+DQogICAgICA8L0Fz
 c2lnbmVlcz4NCiAgICA8L1Rhc2s+DQogIDwvVGFza3M+DQo8L1Rhc2
 tTZXQ+AQrWATw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0
 Zi0xNiI/Pg0KPEVtYWlsU2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMD
 wvVmVyc2lvbj4NCiAgPEVtYWlscz4NCiAgICA8RW1haWwgU3RhcnRJ
 bmRleD0iNDYiPg0KICAgICAgPEVtYWlsU3RyaW5nPmpyaWZlQGdvb2
 dsZS5jb208L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogIDwv
 RW1haWxzPg0KPC9FbWFpbFNldD4BC9UBPD94bWwgdmVyc2lvbj0iMS
 4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8VXJsU2V0Pg0KICA8VmVy
 c2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPFVybHM+DQogICAgPF
 VybCBTdGFydEluZGV4PSIxODE5IiBUeXBlPSJVcmwiPg0KICAgICAg
 PFVybFN0cmluZz5saWJ1cmFuZG9tX3JlYWQuc288L1VybFN0cmluZz
 4NCiAgICA8L1VybD4NCiAgPC9VcmxzPg0KPC9VcmxTZXQ+AQzLBjw/
 eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPE
 NvbnRhY3RTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9u
 Pg0KICA8Q29udGFjdHM+DQogICAgPENvbnRhY3QgU3RhcnRJbmRleD
 0iMzMiPg0KICAgICAgPFBlcnNvbiBTdGFydEluZGV4PSIzMyI+DQog
 ICAgICAgIDxQZXJzb25TdHJpbmc+Sm9yZGFuIFJpZmU8L1BlcnNvbl
 N0cmluZz4NCiAgICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz4N
 CiAgICAgICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjQ2Ij4NCiAgICAgIC
 AgICA8RW1haWxTdHJpbmc+anJpZmVAZ29vZ2xlLmNvbTwvRW1haWxT
 dHJpbmc+DQogICAgICAgIDwvRW1haWw+DQogICAgICA8L0VtYWlscz
 4NCiAgICAgIDxDb250YWN0U3RyaW5nPkpvcmRhbiBSaWZlICZsdDtq
 cmlmZUBnb29nbGUuY29tPC9Db250YWN0U3RyaW5nPg0KICAgIDwvQ2
 9udGFjdD4NCiAgICA8Q29udGFjdCBTdGFydEluZGV4PSI0MjgiPg0K
 ICAgICAgPFBlcnNvbiBTdGFydEluZGV4PSI0MjgiPg0KICAgICAgIC
 A8UGVyc29uU3RyaW5nPkpvcmRhbiBSaWZlPC9QZXJzb25TdHJpbmc+
 DQogICAgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAgIC
 AgIDxFbWFpbCBTdGFydEluZGV4PSI0NDEiPg0KICAgICAgICAgIDxF
 bWFpbFN0cmluZz5qcmlmZUBnb29nbGUuY29tPC9FbWFpbFN0cmluZz
 4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW1haWxzPg0KICAg
 ICAgPENvbnRhY3RTdHJpbmc+Sm9yZGFuIFJpZmUgJmx0O2pyaWZlQG
 dvb2dsZS5jb208L0NvbnRhY3RTdHJpbmc+DQogICAgPC9Db250YWN0
 Pg0KICA8L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0PgEOzwFSZXRyaW
 V2ZXJPcGVyYXRvciwxMCwwO1JldHJpZXZlck9wZXJhdG9yLDExLDE7
 UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDA7UG9zdERvY1BhcnNlck
 9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09w
 ZXJhdG9yLDEwLDE7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZX
 JhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVjZXIsMjAsMTgX-MS-Exchange-Forest-=
IndexAgent: 1 3239
X-MS-Exchange-Forest-EmailMessageHash: EDEB6E63
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 12:20=E2=80=AFPM Jordan Rife <jrife@google.com> wro=
te:
>
> sock_addr_testmod provides a mechanism for the sock_addr_kern prog_test
> to drive socket operations in kernel space. On init, one of the
> following socket operations is performed based on the module parameters:
> kernel_bind(), kernel_connect(), or sock_sendmsg()/kernel_sendmsg() and
> results are exposed through debugfs.
>
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  11 +-
>  .../bpf/sock_addr_testmod/.gitignore          |   6 +
>  .../selftests/bpf/sock_addr_testmod/Makefile  |  20 ++
>  .../bpf/sock_addr_testmod/sock_addr_testmod.c | 256 ++++++++++++++++++
>  4 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/.gitign=
ore
>  create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/Makefil=
e
>  create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/sock_ad=
dr_testmod.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 3b9eb40d63436..b5d02ff724957 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -132,7 +132,7 @@ TEST_GEN_PROGS_EXTENDED =3D test_sock_addr test_skb_c=
group_id_user \
>         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_=
user \
>         test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod=
.ko \
>         xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metada=
ta \
> -       xdp_features bpf_test_no_cfi.ko
> +       xdp_features bpf_test_no_cfi.ko sock_addr_testmod.ko
>

Do we need yet another kernel module? Can this be done as part of
existing bpf_testmod module?

>  TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mul=
ti
>
> @@ -160,6 +160,7 @@ override define CLEAN
>         $(Q)$(RM) -r $(TEST_GEN_FILES)
>         $(Q)$(RM) -r $(EXTRA_CLEAN)
>         $(Q)$(MAKE) -C bpf_testmod clean
> +       $(Q)$(MAKE) -C sock_addr_testmod clean
>         $(Q)$(MAKE) docs-clean
>  endef
>

[...]


