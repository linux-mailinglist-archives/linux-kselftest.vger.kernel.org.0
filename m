Return-Path: <linux-kselftest+bounces-13552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E9892E14C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 09:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA47CB22C7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17EA14AD3F;
	Thu, 11 Jul 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkbbtiK9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E24CB23;
	Thu, 11 Jul 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684374; cv=none; b=iX+CIALKWM/+p4mnyQNSrulxPLs/FZCusYEyphcsnsjZJSkRL68++qtqHkIHzG9X9lzqaFvyunPAPMsMnbK7YD8aYY/NapzloQUSI+Li5KWuVH47fP5DmGpU3/s5VjoxApJ41xQEbU0ZAzVUusF/YS+JgAGNL/ovDAO2GJaq6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684374; c=relaxed/simple;
	bh=f9imbZGe1kYOiYqxOmqeAz7GGYqKuczZdX9oVcjGdfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFO+SGZZ2y9RH5IV78I8rRnxdx9PkbpPlHSTroOD1FvaxZ1fhIMPxpZO9A0cJ1d3lF94h6QqIrBYYF+v6TIJPqOPUIH0Sm3CfRU+k/9X7I+G5CtE5zgKOlPNYaVBho5pIPEVnVV+bHfLnkf9gqGehtvNuKdBGs4QsDQpSmJcegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkbbtiK9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fbe6f83957so179495ad.3;
        Thu, 11 Jul 2024 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720684372; x=1721289172; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G/pM0ii4AWvEMx6IP5NLtIJfJq7Kju3DzysYHDFpTPc=;
        b=IkbbtiK9xwfZuiKlZA4TDmk6WgUsTKSDEqVRG4iU0QrgeLcxhlusndRGX40jOqZZn0
         ZnjPo1T7eTlgl0cS6Kv1B0AEubZWQTGTbMTePpbgqslQkiImmSGP+/SHFIlXyXqU4eSO
         m6dp4KGG5e8FV//0Is7xGFmu/8qt3JSFozmV0lWtPjBjLGymazTCCdqBWdF/z7Qi/BJZ
         YuYu7d3QDIeFvEOCxgOGkn/1CVRwwgyQ1HQpOhkgMWrJ+CTCsZg1Vntedx2s8g2eCLrj
         CSfJfBg3cOZkW3kJ8c57tK5o/iB/kv33iTbg1Izq9bwrrtq2yHqoru3ZgK0pBPtCjNZD
         4lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720684372; x=1721289172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/pM0ii4AWvEMx6IP5NLtIJfJq7Kju3DzysYHDFpTPc=;
        b=xFe0lGa1eymLrNgbVz2L/DrlGEf/aTUemoX7jakQieH22t+v/zoVIhIqexvFL0a7ay
         6d8JBJdWrI1ZIYuhOK9jjXPg7EB8ip9pvuRrCx/dnD6QxhkJHQTsxTxrJymU9UUbaARp
         1JEsyWa8BCjKiVzwty7jYj7Vwo2AkhA18Cu7b8qj+dsPqh2T00DEPH5lt/e/V7QHJeua
         7gx9yNhoFf2vKFJaGy9ZMKSaTwzVvlglvXMw3d4rn1yOXsPo8/KgiC0Mh/pW9rujq4+K
         I8ZgNUiQmEXLlp7QBvr02gjiw+g0WVNhDE8d6E1NIeZ2Eej77K9ZxGmvXgdVLF7StfmI
         P32g==
X-Forwarded-Encrypted: i=1; AJvYcCWsz/petR6SFv/QAMoiaLerKupwsr60Z17i2Kt0RcIYIrJtd0QzOfM53iIluNpbcgo8i+hImVaNHfSd0P1/ydYR2k0ps0oV7dXwUjPcKDhuCAuE9J8ruu9FmCgFX5eWneW2TKeaW9MB8swm7bLS
X-Gm-Message-State: AOJu0Yw4xH4GvyCpb2x8l6tiHrAJ1G49ofePcw4tusaQzNPcFeJyeXnF
	sQwZSkz4eNx/uW/onwX3wf0bbM1MrJg6RMw9LtcSDIJsCsIetoVV
X-Google-Smtp-Source: AGHT+IElW/nCcl8RCV4Ba/dfDLe5nzp2Uz/ltjEraHHU7Gv873MDF76ORgZLEg2C2aWnuV74liEVOw==
X-Received: by 2002:a17:902:ce86:b0:1fb:451a:449b with SMTP id d9443c01a7336-1fbb6efa3d2mr68794345ad.60.1720684372448;
        Thu, 11 Jul 2024 00:52:52 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac132esm44486745ad.210.2024.07.11.00.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:52:52 -0700 (PDT)
Message-ID: <36fade92f6ed872d62c9fadecc88fd3b764a6423.camel@gmail.com>
Subject: Re: [PATCH] bpf, selftests: fix a resource leak in main()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>, ast@kernel.org, daniel@iogearbox.net, 
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev,  john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com,  jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 11 Jul 2024 00:52:47 -0700
In-Reply-To: <20240711074437.2283810-1-make24@iscas.ac.cn>
References: <20240711074437.2283810-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-11 at 15:44 +0800, Ma Ke wrote:
> The requested resources should be closed before return in main(), otherwi=
se
> resource leak will occur. Add a check of cgroup_fd and close().

Note: it is better to group related patches to a patch-set.

>=20
> Fixes: 4939b2847d26 ("bpf, selftests: Use single cgroup helpers for both =
test_sockmap/progs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  tools/testing/selftests/bpf/test_dev_cgroup.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c b/tools/testin=
g/selftests/bpf/test_dev_cgroup.c
> index adeaf63cb6fa..e97fc061fab2 100644
> --- a/tools/testing/selftests/bpf/test_dev_cgroup.c
> +++ b/tools/testing/selftests/bpf/test_dev_cgroup.c
> @@ -81,5 +81,7 @@ int main(int argc, char **argv)
>  	cleanup_cgroup_environment();
> =20
>  out:
> +	if (cgroup_fd >=3D 0)
> +		close(cgroup_fd);

This is a standalone program, and Linux closes file descriptors on process =
exit,
why do you think it's necessary to close the fd here?

>  	return error;
>  }


