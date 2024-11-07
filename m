Return-Path: <linux-kselftest+bounces-21619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D824C9C08EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 15:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD8F1F23C25
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F6212622;
	Thu,  7 Nov 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4CBsTDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B1168BD;
	Thu,  7 Nov 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989975; cv=none; b=UdlsMG7vX+9ONPatAUcromAR5Lg3/KlaMfUrIR40eBSkK2C98KZgrHoEj2Btz2iXYyqPDpxe86+0xxI5KJqqyb0a8y78QKOU2OiowNioWayEwTr+bSytHvJ/3KSHNF3+m8rV3gje2EUn+hzzrEgytLHlHBnLOqei7de5yEpAG54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989975; c=relaxed/simple;
	bh=DvkB/sbaZRLhctzLM3g42ELdV1YVsM1roN6Nkn42Otk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CT2J3HmfQfN9boOX03eMFhez5H5Q9AEcFZH1WFhgAO9fpi2GG6ZQCZz2ElZfYcJlIXrtKfDdHJVuAOCpzOVB4j6XLpoBkvbKOzMDnqLWJTrqrWwnA6LZgRnfqU3qEznA6MfzpYW7f3rZpkE7UlICoiFydtJDRmD/ppWFqybwiLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4CBsTDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741A2C4CED0;
	Thu,  7 Nov 2024 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730989974;
	bh=DvkB/sbaZRLhctzLM3g42ELdV1YVsM1roN6Nkn42Otk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U4CBsTDQ4hYvaI45hMbB3EXSH3dlqUr6xzbauezqLMIv2EjJw2wUIbhj3OxDDleYr
	 hANQijAsuTpmNiWH6OgW5jL6xMn1sIIGSxnLpBEdkY3dxzZvNjNBomWPqWFTI+wm1y
	 lVGfbDt9mGsg/gRd3glbvUvFxYiUMWbzPkLZ98Tc6j2IN4qi/FogRRbMFtsetjQkKY
	 O5RDoiGnWCWbbvfoalTOWLG0oknV/MXE6lMXKBxa6HVXd6bibkTplyCbzJA2xcRea3
	 jTwCbtezdRkCxiwGbT7KjQFWBfVgX4Le4KMAXouiFJnWo3cGFGmW71fFNmauzMoT7/
	 m/voWpidyFxnQ==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso6243596d6.1;
        Thu, 07 Nov 2024 06:32:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2WwE8TvqjMEkBE2KymHyxhnjHg2IqdFXpXLPiuzeCntvs0tCe12k6PHiJvOXvlIJzU3o=@vger.kernel.org, AJvYcCUbAL/fGfNNpfLzNpuJMnvgDXSIQzYSJjhBKV8pg3dBapGNQY3wBYXcT74EXUfQi5JpDpWRuACCaP28omPxWWX2@vger.kernel.org, AJvYcCV+JFfC6b67m61OVK63G0o8unn/H4NctW+q7wNqrpzAdrKeduC1qax6LOyktIGkEvjpCQenrL4FrCqhubN1@vger.kernel.org, AJvYcCVjwANMpRBTJ03sB6q471BtfyENGcHhJRTUhRm1RGN5O2dE3wN23pOFhtJ2vB2mlNN11+JsAZ04@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQ+fkWgJZQmEoiRjzyDIGayE1v104RltmjHDACzH6xn8OE5bp
	XpAEdcptU44iPPOBdnTFCG4bGQ3Iuxe0B3YonjyeuNDjVQPel50/eOmRM+RhQIQ/FFHT4Bu+c/o
	p57gHUSqN1aL4sUSMh0eaWeqIGHU=
X-Google-Smtp-Source: AGHT+IHUCLtFQ8IuQTRLh1fcgLhAN5eLbq9UIfP6whxl0V14vWJHVvz6l3hhBZU79uygYdnjqGmoYxDIzrGp2K4+w/k=
X-Received: by 2002:a05:6214:4198:b0:6cb:ef22:6274 with SMTP id
 6a1803df08f44-6d39cf9cdcemr1411926d6.3.1730989973620; Thu, 07 Nov 2024
 06:32:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927131355.350918-1-bjorn@kernel.org> <172835823300.66789.3704854116445399222.git-patchwork-notify@kernel.org>
 <87bjyvpa6h.fsf@all.your.base.are.belong.to.us> <CAEf4BzZbq9OwSGi4pdb5_q8YkErfFiQFKYXg3g1rjpdejafx+Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZbq9OwSGi4pdb5_q8YkErfFiQFKYXg3g1rjpdejafx+Q@mail.gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Thu, 7 Nov 2024 15:32:42 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNjiuhOyw2r9+e=CRMXrq_NjP5Sq4oT1tc_vhTZ_HkY7zQ@mail.gmail.com>
Message-ID: <CAJ+HfNjiuhOyw2r9+e=CRMXrq_NjP5Sq4oT1tc_vhTZ_HkY7zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add missing per-arch include path
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	bjorn@rivosinc.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	charlie@rivosinc.com, Andreas Schwab <schwab@suse.de>, Anand Moon <linux.amoon@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 at 23:04, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
> I'm sorry, but unfortunately it's too late now to move those patches
> as it's now been more than a month since they landed. For the future,
> please let us know ASAP if you think patches were misrouted. I think
> we are stuck with the need to do a stable backport for these, sorry.

Yeah, realize that it's really late. Thanks for getting back, and
noted for the future.

Cheers,
Bj=C3=B6rn

