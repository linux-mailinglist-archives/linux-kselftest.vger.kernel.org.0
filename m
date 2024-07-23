Return-Path: <linux-kselftest+bounces-14034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27BD9397FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 03:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39D0282C6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E0133987;
	Tue, 23 Jul 2024 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCqFJzfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190313049E;
	Tue, 23 Jul 2024 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698639; cv=none; b=hxpqMIwYGAtHvhz8fNr/bB5znWSXHNsrQhQG7ApN/XBD+PSXxp+bILv3EZDUmPPHoIcKjHASseDxDs1ciBiKIGNi95ahuxuKLRDqFLBsw30oTaIpflNFQPwkKbz1tQ83G+ODmu7GyoPJ1BdEhMs6sZnp/UGibQveDlN0Mv7BTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698639; c=relaxed/simple;
	bh=BFAWZqYTQHHPDsjLjsAGNazC0szRW+48ZZi5RqyzzbI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9JpJ8V1K08nC1Y5cI6YTnLM0kI/JpSlxojxqUXSmFp0wvrd/XKxm4d69cev+I16Sbjuo3o88sIQ/27l/bru2OoQqUyLMDv5hZbO6YK0H48o8kZffD06nkhvxOgsoAYyfUIvYQfEZ12qABhR2kL12R1EEF6WkWxu8xvEsMS4Ibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCqFJzfl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc611a0f8cso28399465ad.2;
        Mon, 22 Jul 2024 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721698637; x=1722303437; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BFAWZqYTQHHPDsjLjsAGNazC0szRW+48ZZi5RqyzzbI=;
        b=PCqFJzflvBX4Ydy3knd4nROYTC+jRgoZ4E+95nNJ85HLnK2fVejmtXXl6oft4HcUdN
         GoThSZu31Fa14nbD91SJPPQqTRK2C0Ihhep64OSYZ4sQ7HzN/WCGB5ptJ8s7TTb+czVF
         XOCALaGY/BtUM3i4Sdv4wJd9B2fWHZLetIJ7EGMqWDgC0Z3oVRuRR6R5UnrOaYTzZRFA
         vYyE3DZyTRAOZvul3yJi25cVrCWqfHKjQrLUf5DBWS50d8dmy74lWkTYEufkI8FIfuWR
         eA4M4UoY+P2EaVODOQoQ2RUw7icmlQa1GVry187G/m7jnvAJO6a3FwXV53xNHhstwwG3
         PaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721698637; x=1722303437;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFAWZqYTQHHPDsjLjsAGNazC0szRW+48ZZi5RqyzzbI=;
        b=SmSrlmrtkwv8xmW1GlAf/V7HXCm8ODodZvyJAayvWl9btARbfHLGzpdDb4mCW1Os8G
         ELKduxAcfl70m519ROVXXpRArKOagkeIfK3aEcARW/k+PZj+UjGoGKalln8kt3R8NUi9
         yOtmFuUhoT/EHch6TGJ3gYgsTgumHc9q71l7dWePCwIk3enweMolTBqeIIVFSk5AWknN
         Fa/TT2FVMdJjYcfNvmfLfBCWNlYimQ6Lwpb6CIlE1nhjiKX27YowLBrq6igDuLg3LpNn
         oOFIOSfM2jfvazRpAvvEDnntuQ5otllzzN1FXSUJrP5fVp0PB2QIIKXlEw1YK7OktL/O
         Wr+A==
X-Forwarded-Encrypted: i=1; AJvYcCWjbSKD7Zb+/A6vORDRu+OA36a7XTvJ8NzTdtxAkKWgoGBML7E571MCa4NJowIodzzxRrJZ1+jAwa7N8bXwHQiPhv30hSX+rsg7QN9Li2UL
X-Gm-Message-State: AOJu0YwEipf0fNRCeJkUXlAdTXaTo/CxaF5rg/M0Sc9QEuSezwUjF07A
	w/jccb5TkvAPuSPiIbBcwK8fHoH0xulalh/4ILwqTHYsfuHQXx/s
X-Google-Smtp-Source: AGHT+IGRyBwDKWC+d0KjaNpGvg8RNDUOSlIs1c5Og7imMPjE2MYbilgzAOgp4bOXfi7Fcn/msht33A==
X-Received: by 2002:a17:902:db10:b0:1fb:5574:7554 with SMTP id d9443c01a7336-1fd745c1cbdmr59154945ad.28.1721698637118;
        Mon, 22 Jul 2024 18:37:17 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f433e87sm61870515ad.195.2024.07.22.18.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 18:37:16 -0700 (PDT)
Message-ID: <00c938b06c8b3df26a10f93b4bdb113048525c9b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix wrong binary in Makefile
 log output
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Date: Mon, 22 Jul 2024 18:37:11 -0700
In-Reply-To: <Zp8I3aN/bZnka4I+@kodidev-ubuntu>
References: 
	<CAEf4BzarKiUZqNcq1E+6SaeG8oP5+SfSLLoTNKF3_+7MS6CtyQ@mail.gmail.com>
	 <20240719232159.2147210-1-tony.ambardar@gmail.com>
	 <CAEf4BzZ-caZKO_kEqhh930_x3UGVXQ3NJJaG5BZq9NJhaP2xng@mail.gmail.com>
	 <ZptJ1dsnKbjTZ6iH@kodidev-ubuntu> <Zp8I3aN/bZnka4I+@kodidev-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 18:35 -0700, Tony Ambardar wrote:
[...]

> Hi Andrii,
>=20
> I sent out a v2 based on your suggestions but omitted Eduard's Acked-by:
> by mistake. Should I resubmit or is that something you can update?

That's fine, don't bother.

[...]


