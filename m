Return-Path: <linux-kselftest+bounces-43403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919BBEB380
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AD804EB113
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085AF32E14C;
	Fri, 17 Oct 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRl2jWvR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A63B31282A
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725661; cv=none; b=SHHEaRWr4XuGVsnzu3cJp5RRuH8jMH6OQa07T5RdGwrjnuFsDb3q8itL+u17vv+ir6K6gowcS6ECoY6sSzghO94pRP9y/b3Hdz53CsPRxpxRSYSDv7+1yQsnwTOMyzANajlmaVXAm/AJbjPMZGQdBo4D0aeLHqX0YNZMDH8SKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725661; c=relaxed/simple;
	bh=apyeGrhT2B4cjSomRBMirnJK1iCiphU7E8kwZ4eFRPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJ2hDTPF/R6UUQZj76Vwnks5G3Wr1PKOyA40uFEE2yKhRl7T4xx+ypCEClAVoOhoF+qz8378cXk3n83HdPeka7tCEgZI42u0uHLzx+bcxxUUeX/ipVSpoHCN5yXLqW1crRB4g966O7zN6skq1zooC2SolX+IaOR3WcxdpTBw57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRl2jWvR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-427084a641aso559939f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760725658; x=1761330458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNOsTI510GPBzBmWLlky+fzOisjB58DBhaGG4R2nBM8=;
        b=lRl2jWvRw+n/iLhCD3xpKuP83ZE3tpzetVsSBAj0bBXyQezXVf3unacJZRJ0WQnmSA
         XgpciaMSHuvupkgV+rXJiKWyQRYNUOppzy/wKOKooClafXZxfeLhbNKLjhZT0ihWp+tI
         ueZBdU4waox/w5i9wVV9+rm77LqtZLquUy3vhUcO0+MfGWX9Cm406yvju6wtKW2S9RHm
         WWvSK1GmecZ1eTnrKTSCpGfCbrmHM1hejSylO2gZ/x7Ec02RYt1lh4nJViYKmVKuGsrg
         amGoHeV9E8508I62WGhJCwSOvmIWbK4HCynxoEVJ14RP4/HzaOAqt4uQOj5ZNXdiWCOr
         7p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725658; x=1761330458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNOsTI510GPBzBmWLlky+fzOisjB58DBhaGG4R2nBM8=;
        b=bJZpGysxyxACk4Ib1wg4+t/SW9Q7hJLlfuD5XiS3yua0nmyWWMsTtFDprh3mNvPqfI
         tFwuybUIzJ4FGM8c/ICDL8vW94qmjMIHNrPl3lbPUSuQh1Lb8wjKOeYmmEwF6ZrhQCoC
         kbeIlJFs5uPtN7oJjoZjWj/k2UIQFivKCra+Y5YQTmRwTyXVqkYH18cJ3Vd3WzF+OaSE
         Yo2Va3gqL7s4o8ns/tauFNXWMUWW/7OnQXMJ9x05kbd3PZVkrtZ2Uu8eKE8Ai78uzwqh
         nSDkKYY3DFrh4ZMAKbme5GaA9C1Svn1EJfbagBjVuJ5FXKFhYOiqIIMvaiS1n1KKQuJK
         bcFw==
X-Forwarded-Encrypted: i=1; AJvYcCWR3R6a6MOzmKxtTPu9kDhoCwtGmlUvK2ukg7ZpacjPOIsikuvujjcFccqHLu1vC5MBOyO+33VGwkM57VfCmZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtOzW+sBgUNu3LUux3donKecDQM/m2LgPnDbS6fPerL5oxG0X
	Od36UbPp9t95Xf0F9liRbA/3eb8OI0E1oRb4uSJ9FdYI16BDn59cRUSyNPivoFmRlxtBPOEjE2I
	xng8gcuS88Tczjd8RODV2nK6MyDCgyhQ=
X-Gm-Gg: ASbGncvD27JunqUJDlPB87ktre3ADe3yh+kA/28ugb0cEReMDd2wuw50414OVeY7yj7
	EDaSW8IO9faA52fKEHuSkPGESftKGfU2RxbN5d3ANFHCHeoVMWwRpXdPK1t5PmNLQoCkbAJuWfd
	13uNKPQJ7H1HAn2WSaXAL1M2xawUMJiLW8a6jUlSGnxs0TyOcupVDnLLbLjxkwVLdPXayymgO3X
	xLBE5aR1XxZGA5j0hVXvE8SPMgT35fGO+8bK+5lgRWXV3/KVA4ss8o2Vl74nezVgxTiVNHeUK0a
	AllwAa7PaAvlg0lfrAs/4he009CK
X-Google-Smtp-Source: AGHT+IHrzD3MV8piW/3R5bZbNm50DZwa+/IsxY+cp8lTiOj949EZXhc7lXjq+S0IuHDeamFjuoLV5tVj/VL0xY2uTU4=
X-Received: by 2002:a05:6000:2387:b0:3e9:b7a5:5dc9 with SMTP id
 ffacd0b85a97d-42704d6d12fmr3503910f8f.23.1760725658228; Fri, 17 Oct 2025
 11:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
In-Reply-To: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Oct 2025 11:27:26 -0700
X-Gm-Features: AS18NWCyoIqaofAQbkOXYwS9xLsYBlc0BUliOKOZEhJe6-LQzeQc4XxtZWuyB4E
Message-ID: <CAADnVQLLBrawW6N4BcPvhYD2Cg_qaxSZDRU53Jq31QxR3mPDkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
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

On Thu, Oct 16, 2025 at 12:45=E2=80=AFAM Bastien Curutchet (eBPF Foundation=
)
<bastien.curutchet@bootlin.com> wrote:
>
> Hi all,
>
> Now that the merge window is over, here's a respin of the previous
> iteration rebased on the latest bpf-next_base. The bug triggering the
> XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF failure when CONFIG_DEBUG_VM is
> enabled hasn't been fixed yet so I've moved the test to the flaky
> table.
>
> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> are defined in xksxceiver.c. Since this script is used to test real
> hardware, the goal here is to leave it as it is, and only integrate the
> tests that run on veth peers into the test_progs framework.
>
> Some tests are flaky so they can't be integrated in the CI as they are.
> I think that fixing their flakyness would require a significant amount of
> work. So, as first step, I've excluded them from the list of tests
> migrated to the CI (cf PATCH 14). If these tests get fixed at some
> point, integrating them into the CI will be straightforward.
>
> PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> tests available to test_progs.
> PATCH 2 to 7 fix small issues in the current test
> PATCH 8 to 13 handle all errors to release resources instead of calling
> exit() when any error occurs.
> PATCH 14 isolates some flaky tests
> PATCH 15 integrate the non-flaky tests to the test_progs framework

Looks good, but why does it take so long to run?

time ./test_progs -t xsk
Summary: 2/66 PASSED, 0 SKIPPED, 0 FAILED

real    0m29.031s
user    0m4.414s
sys     0m20.893s

That's a big addition to overall test_progs time.
Could you reduce it to a couple seconds?

