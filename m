Return-Path: <linux-kselftest+bounces-41520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F4B58324
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 19:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9F64C5A1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC4E293C44;
	Mon, 15 Sep 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az9n0gr7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77C2C2354
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956422; cv=none; b=HBQzC646PXI2ZjCUE5Y2ed2sy2rZMTXeuKoxWbLZwGeT7VV+vY6mgMWVkAN1EOxZ/1oHFBJ47taDOicPWMDUeWKOVo2mRlAo1TZwGNGoL9HD3mazvKbfw4E9fpJLKRp432v9RhwChTmi62TXFt62QQq4T4f1tE9iW3ompZ+yeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956422; c=relaxed/simple;
	bh=/CUKX5C/JOUX9o03xfQXMW/qD91kFk00c9sQWHjtdcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pbs9knwBLZgipL5/y4weoKp2nIOZ2lhmInhUytvI2pOfIk7XGJfrO3lQpX2R1olQVCUjNZelk+TjC4iX0dgDIIn52LuF8th/e2jC7VVdkt4dRGH2Se2Po7QJM/+6mMcg4xzW+kID1BQr2ZdHIk7eppo30BLCGeCxIBEAF4iO+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az9n0gr7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so1414600f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757956419; x=1758561219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CUKX5C/JOUX9o03xfQXMW/qD91kFk00c9sQWHjtdcI=;
        b=Az9n0gr72l0D2XdW/5AjTY15fcvm0cldNI00TesnxXCwQuBW0uinaMvt0tXdo49jSK
         X+P5GvHfQuI/ob3r0slFNVI664pHFKMJTKezCOTWku/1w1KT3HzPGuGHeD1gVPyqOEe0
         EmOACodwUf06fYrut9hrJui3nIGqdVoTbFQYu55heLmCoXm+CEYef1UjLCCHbFirn7Wp
         2xHvQ4sh0qYVpwP29cZzzMAKL15fQ2l1YrnfKPCaB7TxMlfuoAFKgg2veJhawpMdI5JF
         qTjrcnZmn8fR3XvXzHuf/Y/8vUJm8B1IhwoXLzuNM8Mq6f9GCCSrWWYyGzbvuGwX5zdJ
         +F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956419; x=1758561219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CUKX5C/JOUX9o03xfQXMW/qD91kFk00c9sQWHjtdcI=;
        b=nbdxHGQ46nDx8SyGFXg1zYdpKrLuVQ60E1DawqOV+biA2BjPd9gpq3uSaLYAvHR/8x
         61k8wVD4q/V23zLB6he9WaQGAlDirNJF/cqW3vUh62A1j6bDt/+lbRLkQ+0gtaBAXCo1
         DaRIVvssZb67uLkRRpZsIjZ0k3mkY2UiO9vgx6ZVB7jkHB4FZO47FE+Jxn3xZxkWBlcJ
         jpw1/4PpCj+y+6TdXVH7TCPOYbqoQpMKZ9w20qA8ITTL/o7qyz2TN9SoEnpkQVbcYlSa
         mHwGH6+dRp/8e+DSleE6be3lY5sYKteBgxNPfHPEYDkSlPAIUP1gYPQQEbXaSPX+MkFx
         w1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOygTVtu1XM2ylsLwqN+/or+z6k2W27e65JV9BxEoHQFpG67+aO+bcywIQ26YbIGTu2/635ZJodWa3HyDanxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5khbh3wIuiVQ1PssXeP1zroGkt/ztO2XDcKdZdjB0MPiPxmX7
	J0uXlHDoNPfm2npNH7fX61DLu1uzkxBbtAC/nlAtU4ZROIpjaUnAxx+2vUz17Tkt28V+NjK1mO9
	yjgxrUGQfw9ZqZAnBmpAPi9gZPjRHLgc=
X-Gm-Gg: ASbGncukYtFyBGeH0NJxu47Pd2+SGHaqG7BvnPYTAEiQ/1ZUYd1mSm2/AQeaDu/9xJr
	gIEM6xCTCtuU/838QAEEBnK0WezHWkxiKbkTe8vluxYvVyxBcLCdqpqyx8dCIkxa72iTZma91l3
	XWaFxrul6HoCO9n9iKvK8mkCOrQlhva3/O41NcrUyFf4sVMcv49GA6t+GIkl+X3ti+Szz99R9U1
	yMps2mgfImUQEXMrqXR1Ao=
X-Google-Smtp-Source: AGHT+IFQp6tKSn0h8An2pvTCG8CcE6ze9qvxAkcXYS50TGAKAo3NTyQJ4AabHE3UlQlaIVm6zqWqil99iG9syQhTs44=
X-Received: by 2002:a05:6000:2283:b0:3e7:6196:fdf2 with SMTP id
 ffacd0b85a97d-3e765a0981amr9879648f8f.47.1757956418497; Mon, 15 Sep 2025
 10:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com> <aLmfXuSwtQgwrCRC@boxer>
In-Reply-To: <aLmfXuSwtQgwrCRC@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Sep 2025 10:13:24 -0700
X-Gm-Features: AS18NWBMiMS6XvzTlqJcTup9x50Fctx117wBc5Bi97DEiXSlmnUcLqRrkzlqQoo
Message-ID: <CAADnVQKSHuFgd9KbAv_dUTiS2de=crjDtNLAp5tt7DhBQgZWEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/14] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Alexis Lothore <alexis.lothore@bootlin.com>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 7:17=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Sep 04, 2025 at 12:10:15PM +0200, Bastien Curutchet (eBPF Foundat=
ion) wrote:
> > Hi all,
> >
> > This is a second version of a series I sent some time ago, it continues
> > the work of migrating the script tests into prog_tests.
> >
> > The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> > are defined in xksxceiver.c. Since this script is used to test real
> > hardware, the goal here is to leave it as it is, and only integrate the
> > tests that run on veth peers into the test_progs framework.
> >
> > Some tests are flaky so they can't be integrated in the CI as they are.
> > I think that fixing their flakyness would require a significant amount =
of
> > work. So, as first step, I've excluded them from the list of tests
> > migrated to the CI (see PATCH 13). If these tests get fixed at some
> > point, integrating them into the CI will be straightforward.
> >
> > PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> > tests available to test_progs.
> > PATCH 2 to 5 fix small issues in the current test
> > PATCH 7 to 12 handle all errors to release resources instead of calling
> > exit() when any error occurs.
> > PATCH 13 isolates some flaky tests
> > PATCH 14 integrate the non-flaky tests to the test_progs framework
> >
> > Maciej, I've fixed the bug you found in the initial series. I've
> > looked for any hardware able to run test_xsk.sh in my office, but I
> > couldn't find one ... So here again, only the veth part has been tested=
,
> > sorry about that.
>
> Hi Bastien,
>
> just a heads up, I won't be able to review this until 15 sept. If anyone
> else would pick this up earlier then good, otherwise please stay patient
> :)

Maciej,
Sep 15 is today... just bumping it in your todo list :)
Pls take a look.

