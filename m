Return-Path: <linux-kselftest+bounces-12370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E94049115BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E091F23505
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4379949;
	Thu, 20 Jun 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX0M65za"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F24D8BA;
	Thu, 20 Jun 2024 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922521; cv=none; b=U5GZmIZpEtP65MxcK1mMSYhl4huENbz9akYaaWGJqdV6RpKh22SaexCL3rxjE6Fij4kS1KH5bvAi7rNtq+avzJ1mAwxprrfulMt+Gz7UeUArtTK2WQrPyLvsXU/dAe7nKdCLiIsVifX46NY44X7Hpfi5pmNaAx97eEnRf6ILHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922521; c=relaxed/simple;
	bh=2A9w9NaASWpOU5F4q8eg8NT5Ftsxn24ioOP4HhMCghw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBTxXOnvHR5DbB6L/LzNzILjE1FCOogROCUcmgqSudzeFC2NfURBIdMwZR1MGLDkw8RGRvjQMkadB+uds8PtsrJvGWj/X6oC/J47iKeRXrsMv7TxTkR886uGv7aUYNpggg++V0M+SuX/PDzqFHAgQEGenQDrlIIn4l8ujC45+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CX0M65za; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e5fd488d9fso996289a12.3;
        Thu, 20 Jun 2024 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718922519; x=1719527319; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2A9w9NaASWpOU5F4q8eg8NT5Ftsxn24ioOP4HhMCghw=;
        b=CX0M65zaNn1WGKd9+CWmI7YYHpB7HmSw2eMG9oSI8ZHVYBysbbsvYXSz4zb6teeFO3
         JevjYnqkZrdMxnm+xqfLwSz9t/eh8J8UHbVwSJewPUxXqIZg+3hNhk6BxqiJdJ365X3L
         1ET8pc236qguDSGJUBVe7/9NXyBMspR5gXlvs4brZ0lOiLV0+c1yUeNHU+z0G4aPkQCs
         +gH2bKaHX8rfYkdjSOTxb7o9eUR7PSUEa/cxhymm/z9Pz2r32550C4V7mUG1qy+r9cJG
         /j6fADjapSqT2gaOoV5PStT+Mtje4I9wHV0uIuZzfLO116gxZtO8ghOJ7tNExc74zQvS
         gZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718922519; x=1719527319;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2A9w9NaASWpOU5F4q8eg8NT5Ftsxn24ioOP4HhMCghw=;
        b=DTIF2VXJiIBNwkcTeY4aSKP+c+72gecAhW+Or7n7lrw31+BThmKgZHqwbjrGeE605w
         xm6fLicEclssM0XtOj6kj3/6g/hH4IV8pbAjBcxW+Hwjhkb21EdJ3z7PTrxLg2sL0CsW
         ZduVSOzXsTrBogXjLZ1yrE8IyodaYtFPHMYQyd4n13Wha0ezkvj/AzD277PpGQDfmucS
         Zrc/o5GnESIVlzyoof5Xn6/WczgBqB0K4Kkuv+/7vGvvS6N598apj9SJur+ffH+ti63y
         Q6984VnxBSe21Roi4+A2lDhyyYf2GFEUzNzZLxIP0H+246/Pj5b+yTNoidno/dFxcJUT
         fZtA==
X-Forwarded-Encrypted: i=1; AJvYcCVwUBn2MAvsjB4Hsldh3HAsSOlc3PlfBdnQjZAzXXLOcjB9aClp+2LxkjKyBs5i0w+VmFKskiGh8aWc34ZnFYJXCFRDKDMe2jJ2Vn7rOsCsj9T2ZuLOAjAgcq8KGEps8sLm8TgM
X-Gm-Message-State: AOJu0YysB/5Cfaau7adiRDq74eXZIKTvku/SELjJKPxajDRzQddeWFo5
	WUYv0/aUPHr3jCVWkOrwt7xrKpA5NEppbFOa+jf1mSvvT/pOVrW5
X-Google-Smtp-Source: AGHT+IHo7J8aLvZJvr5O57Na+ubGW5I7qg2yxQy24mNKORXByCIVFDsLkpOJhZUnBM7i6QzZebpy9A==
X-Received: by 2002:a17:90a:fc83:b0:2c2:1d7a:1e10 with SMTP id 98e67ed59e1d1-2c7b5afc174mr6760358a91.15.1718922518995;
        Thu, 20 Jun 2024 15:28:38 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9c6esm2222357a91.42.2024.06.20.15.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:28:38 -0700 (PDT)
Message-ID: <18b6f2010041295f91577b368856738fc679d889.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] selftests/bpf: Use connect_to_addr in
 connect_to_fd_opt
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Thu, 20 Jun 2024 15:28:32 -0700
In-Reply-To: <111461ffad4eb29083d4b73c3d15fc619914e041.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
	 <111461ffad4eb29083d4b73c3d15fc619914e041.1718765123.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 10:51 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> This patch moves "post_socket_cb" and "noconnect" into connect_to_addr(),
> then connect_to_fd_opts() can be implemented by getsockname() and
> connect_to_addr(). This change makes connect_to_* interfaces more unified=
.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

