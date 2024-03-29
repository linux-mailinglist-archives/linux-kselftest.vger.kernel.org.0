Return-Path: <linux-kselftest+bounces-6929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E812893482
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 19:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3191F245DE
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7301D15E7FA;
	Sun, 31 Mar 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbnA9wdW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E315E7F9;
	Sun, 31 Mar 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903423; cv=pass; b=A8wcXvaG/ybr9SekC2yzjaRmUPARlWJrLwWwt9LdWCp+w+VE0M7Q56ReFEaaA0D+hPusr+W61bqDxOHncHFj8V+gPZVfzYQS2UjNY6RfedXE7A6xI1URe9iUxIxUr23L3zbxQZUNkyAa6zc9LCPTH0x4OuC+C4zw6ckMb2JHOpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903423; c=relaxed/simple;
	bh=APnv61COTtDCJ6Qzg4G3KuYC9o9q8lUsfZq/wAf5jvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKytI6PGM9p9ohs37tApMlFJVsEvxFwrvXr25n6DHDNnw/CcbI13gfQs2Rb/w+LjApGzLYC2QEDFlITh8hSTlDqn6V7gRffW4J90JYc/bTBfXbTY5Ly8seq5hftFz+iBTIdknkPpbnT96RuNH1aX/PaCrsPbaLAv98v0zXCSZ7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbnA9wdW; arc=none smtp.client-ip=209.85.218.47; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3CF32208CD;
	Sun, 31 Mar 2024 18:43:40 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a5PXzK8LfX1M; Sun, 31 Mar 2024 18:43:39 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9CFEA208C7;
	Sun, 31 Mar 2024 18:43:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9CFEA208C7
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 8F324800060;
	Sun, 31 Mar 2024 18:43:39 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:39 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <netdev+bounces-83473-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAk0imlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 11472
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


