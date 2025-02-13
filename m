Return-Path: <linux-kselftest+bounces-26543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5A0A33F69
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4568B3A4609
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533027453;
	Thu, 13 Feb 2025 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3IoHqDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D033FE;
	Thu, 13 Feb 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450806; cv=none; b=Nva/K0MEwfF5otgQyKHdzjS6aA2qWI3g91kiFC8y4KsLmm6Xqv8IbCw33l9jFU+JwSrak3tuO7tOlVuMx7ugCIxRJCFahp3CxyyuBjFq/VCp0SFmfoMf1KP56gLw7Jhfq67mrasWj7gi0NipIbOefPcpE3Uqf1ju0Vuya+utAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450806; c=relaxed/simple;
	bh=3w4eyl62/6vuKUAXXZB0G33wghT6GzKuZEu+/ovFzQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYJQYJJ2GEa/rc7irkKkUKa+7ilWZpJ9nolo4RZ4Eq4xlXLUYhpV/vBFjig2n4BMpkeTar6DUR8+KBo5Nn4SJQq6o+e+IpucleQTW/Ae7Z+6as33/5pUCAHRnpCHlT29K/qRqF1zOGQX906IWiGemL5Z/VFttNGdPwgjklMM48U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3IoHqDQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c665ef4cso10780925ad.3;
        Thu, 13 Feb 2025 04:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739450804; x=1740055604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w4eyl62/6vuKUAXXZB0G33wghT6GzKuZEu+/ovFzQM=;
        b=h3IoHqDQTa/ea9i4BujCI73R4gBwGGmj+0kCghWCW4cZxb9VO5o8tnmkPrevSzHFyd
         nJvhKVpNka8j+sFoUSlFjQPPGI8oNEZ5p2INz6FFruSTOsS+CYyxexw64oym498vjx2/
         Q61NCF8peRsJSPQMym1TAW2Z9NrBGGktEOGoukP/SUjWZljeUVrLeeTxnn07VwJCKV7K
         +YGHRThyyzeBPrCaQ+YK0zIBQArCp2nQmif4Gyp/OUpwZwx3c4hbfxQ/38rpHrVpqNO7
         /cMZ44ev0aIlNavLmiEbTPJAM89GbW+7u26S6ACy289aOhCRQWJA2jfB5WosobOTa7nX
         +Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450804; x=1740055604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w4eyl62/6vuKUAXXZB0G33wghT6GzKuZEu+/ovFzQM=;
        b=UUsrASTP5FvA37etKU/5w3xSct3dlKrC5/yZSXHRRhQm/8DWfVnJH8/eU0V3XC2Cq6
         bICoM04v4rT4rVO22kTa6h8odTyFI/+KeblXgtf2yz8q1Ox1G6TCnsDuHCpbf6cvP5f0
         6MtkdRuZ/PbaD8kaBtylwCC4Xdrfl3Nz5AYRyg4sPX0JGp8DdZUUTM8v7iTnoXocaBA3
         tzJwAIvRNfpXgQGJKVW9R+ytfgsJGTlESYPKghZSt8ANfuK/PkTwooQsoF8hMKLzosri
         MdGQxllaqvDeEiw1e1lEmh9sgyshaCxHNeQuBVXlDF47lXa4b9Jgf5Lg/mShhhYqQyBF
         k72w==
X-Forwarded-Encrypted: i=1; AJvYcCXZVuTBvYf0Ww1JMvWFz7lUmwH24FDcBLRFNr3eJduLRLrrlSK8ibgB0fkDb/Iaj74Ky0LfHRzLsacn2uzhDI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BKESgi8vrwqdimGUhbh7O6cuc/xCD+xUxck9hXfXsthWDaKn
	7+wNnFjx4sCvQn2V3kICEXLzxTVM4FODKwRzxBipVE+K0or9zDEuJyBjRhpQxOhgr8kLh/Wmc1/
	KMXKyGN3rVR2z4kFcqmgUp6zxsLo=
X-Gm-Gg: ASbGncurt3YHzfNvzLv1Ss0HN8UqksEoBtgXol1Hn0oVPl5g/ofHa9fcXCUaxZOUAAN
	CwvWDc95Gh9PNEeSWEIY5IxDjQ5empyA/NCpKaZlsnHKe0D4Pwo00DOn69oshGWb/aLfdSyH4Vn
	VkArOcTveP5R1Lelqziaxb0nNsFvirkSc=
X-Google-Smtp-Source: AGHT+IGo4Dtxm93cuOlhSc3E1FmPN8FqKY12aSYo8sYDDf6BK9+hgUS1SPClKHM6PQW4trUpjYmL5DGlG/70ge52IKQ=
X-Received: by 2002:a17:90b:1b45:b0:2fa:15ab:4df1 with SMTP id
 98e67ed59e1d1-2fbf8c4fa79mr9152962a91.8.1739450804309; Thu, 13 Feb 2025
 04:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210192216.37756-1-annaemesenyiri@gmail.com> <72634e76-7bb2-48d5-ab21-9d5e86adee9c@redhat.com>
In-Reply-To: <72634e76-7bb2-48d5-ab21-9d5e86adee9c@redhat.com>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Thu, 13 Feb 2025 13:46:33 +0100
X-Gm-Features: AWEUYZkXOPPOVIcRCAgC1-fIkyiyRh0dMjA8zTSwO3mZTEBWzMT6yY44fN_Nb1g
Message-ID: <CAKm6_Rv4LCpy6KaV84gOi7wW7OKdasbx2zqfFwFG26=L6rkhgA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] selftests: net: Add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, idosch@idosch.org, horms@kernel.org, 
	davem@davemloft.net, shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> ezt =C3=ADrta (id=C5=91pont: 2025. febr. 11=
., K, 12:19):
>
> On 2/10/25 8:22 PM, Anna Emese Nyiri wrote:
> > Introduce tests to verify the correct functionality of the SO_RCVMARK a=
nd
> > SO_RCVPRIORITY socket options.
> >
> > Key changes include:
> >
> > - so_rcv_listener.c: Implements a receiver application to test the corr=
ect
> > behavior of the SO_RCVMARK and SO_RCVPRIORITY options.
> > - test_so_rcv.sh: Provides a shell script to automate testing for these=
 options.
> > - Makefile: Integrates test_so_rcv.sh into the kernel selftests.
> >
> > v2:
> >
> > - Add the C part to TEST_GEN_PROGS and .gitignore.
> > - Modify buffer space and add IPv6 testing option
> > in so_rcv_listener.c.
> > - Add IPv6 testing, remove unnecessary comment,
> > add kselftest exit codes, run both binaries in a namespace,
> > and add sleep in test_so_rcv.sh.
> > The sleep was added to ensure that the listener process has
> > enough time to start before the sender attempts to connect.
> > - Rebased on net-next.
> >
> > v1:
> >
> > https://lore.kernel.org/netdev/20250129143601.16035-2-annaemesenyiri@gm=
ail.com/
>
> Unfortunately the added self-test does not run successfully in the CI:

I think the test is not running because it is added to TEST_GEN_PROGS.
However, after reconsidering, I'm not sure it should be there, since
this test does not run on its own but is executed by the
test_so_rcv.sh shell script.
Wouldn't it be more appropriate to add so_rcv_listener to
TEST_GEN_FILES instead?

> https://netdev-3.bots.linux.dev/vmksft-net/results/987742/117-so-rcv-list=
ener/stdout

> Please have a look at:
>
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-=
style
>
> to test the change locally in a CI-like way.
>
> Cheers,
>
> Paolo
>

