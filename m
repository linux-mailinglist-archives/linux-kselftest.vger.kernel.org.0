Return-Path: <linux-kselftest+bounces-16577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F4962FE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 20:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9472B287D44
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C72A1A76A6;
	Wed, 28 Aug 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7c8modD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A983CDA
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869606; cv=none; b=HEC/vFi3POBxBkjacI9l23iI15Jt0UYdsaYwlW4/gKXgK1CDzdlbIgpswWAqzSMa6Tzwt5i2KLDI9o5sYtKzZGsZLFdkwCXX1dVcDdkNIyi0BXPrnMi32/bEpBobggTvZcp64GkZyrBQ1KrzvFo3hq+kA6cnH14EBnhDTMoK0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869606; c=relaxed/simple;
	bh=V1yGd8hQm7NWVW6rAxedgpvVY+o6CFEVgoXoCDOtahU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdrEZSlcKq8e14r0GTWQGePSN/luT1kG2C9kFcJk1f20WutZS1ribtqU0P1oxzdASH1q5lsyFH+MQHnj9bXlJtws2Muh8r7RChhIfk+vOF5QOrOQzcEDFQagSIBsdlJT+DGir2mLgCTfYFCJdVPdmohHoTFwEMFfrLeCht78Kxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7c8modD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45029af1408so28871cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724869603; x=1725474403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGauUs807uM1K0iECRfVWPVDoOsyliQyNmPh/dx1pSQ=;
        b=m7c8modDDDv+/xZ+CzJKMSQLNOGPNg7bPw5+OKvNDXrkh1Hytt5mvFa6GqzvH5nzzK
         OiK8Lu5iutDguCiXyRPbV0AV/hhNp8MK8uuU3zIo4X6F2Mw6jM7PSpgHrSWtTQ3bOjhF
         qUQt2/IMQHkZrkhk9M7Juct8vm8qK0ONrCZgqc/46A7wmNdZK2WRnI4NxJskooWV3CGd
         aGRnG9N3AN+f15W1bJqHUlgDiaB+1iriNLGSIGuK1rZPnCX9yQoSREta++QQHxE4Abz3
         eLOs0a0jldBvoANYBK4XlRQqqteda3cyUIPC4pJaMSNzKMKTpnG0nMLzB/Esl25B1cex
         xKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869603; x=1725474403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGauUs807uM1K0iECRfVWPVDoOsyliQyNmPh/dx1pSQ=;
        b=v8uihIOKINxEZJk4exQLQsBQmtBsAIIpmjziOtOt73q9wVUZZpftBmuELvm7VT52FQ
         dQs6/SF78iFAzlNY1wwjkqz5t7iz1tGjD37WuNRTPukPFnwc3j8nZts73kK6+KTRV56T
         UL2FfiS61TQXvj+9KGM0i1KqZh1HmHdA+dGnD+GLNIXSLpTKIJ8nM/qnEX1dqgA4+P1z
         DSc93+5W+vNmLIlaVxCphYa/Cii3zINkeuIQ+cVMYfmOdDhWZSNfpcRWGQqmwJk/KNFJ
         qU3Z1PBrlLseWP3BPOp8fgcp0CY/iXk1gHIucgJQzNwsJ42Pphvxsn4TnZ89WXLdPnJ6
         rG4A==
X-Forwarded-Encrypted: i=1; AJvYcCXEV40snh4FVFn2pHD3r0O/uiZZOXy+69hglpyY+54qkij8NaHw/3sVqUdnsC7leqSNUj/zI+elU/ICJEaldmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjwnMXxBCuhhExfhf0ADJRS2gPYudkRWPvW5cdc216gV76aVC
	xTtJmsS0yScus2nsn4nanchFQRoh8TrsTjouBeCchsoOqiS+e/yLvslPrYzt+ufigvCbOWdbqqI
	VV+FatVGpCLiWs2KSHgvuwKcgnF9GPCNtg3wwCgSF3rso1skKXvYpkbU=
X-Google-Smtp-Source: AGHT+IG1TeY5E4BcEtA875R+5U8RYeS/0Hm0fPSD6WCVJR/n+o4wbQiOLznm4XffFD4tv3sduCpPncRs0rrTfRSTMLc=
X-Received: by 2002:a05:622a:468a:b0:456:7cc9:be15 with SMTP id
 d75a77b69052e-45680141c74mr189061cf.29.1724869603023; Wed, 28 Aug 2024
 11:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 28 Aug 2024 11:26:28 -0700
Message-ID: <CAHS8izNyJgr=rFM8H_v=A3yfqdoDJysOtKA0CuZHRfgZ11ec4g@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with ksft
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, ncardwell@google.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, fw@strlen.de, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:34=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Lay the groundwork to import into kselftests the over 150 packetdrill
> TCP/IP conformance tests on github.com/google/packetdrill.
>
> Florian recently added support for packetdrill tests in nf_conntrack,
> in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
> conntrack tests").
>
> This patch takes a slightly different implementation and reuses the
> ksft python library for its KTAP, ksft, NetNS and other such tooling.
>
> It also anticipates the large number of testcases, by creating a
> separate kselftest for each feature (directory). It does this by
> copying the template script packetdrill_ksft.py for each directory,
> and putting those in TEST_CUSTOM_PROGS so that kselftests runs each.
>
> To demonstrate the code with minimal patch size, initially import only
> two features/directories from github. One with a single script, and
> one with two. This was the only reason to pick tcp/inq and tcp/md5.
>
> Any future imports of packetdrill tests should require no additional
> coding. Just add the tcp/$FEATURE directory with *.pkt files.
>
> Implementation notes:
> - restore alphabetical order when adding the new directory to
>   tools/testing/selftests/Makefile
> - copied *.pkt files and support verbatim from the github project,
>   except for
>     - update common/defaults.sh path (there are two paths on github)
>     - add SPDX headers
>     - remove one author statement
>     - Acknowledgment: drop an e (checkpatch)
>
> Tested:
>         make -C tools/testing/selftests/ \
>           TARGETS=3Dnet/packetdrill \
>           install INSTALL_PATH=3D$KSFT_INSTALL_PATH
>
>         # in virtme-ng
>         sudo ./run_kselftest.sh -c net/packetdrill
>         sudo ./run_kselftest.sh -t net/packetdrill:tcp_inq.py

I did not know about run_kselftest.sh. From a quick look, it seems to
require selftests to be installed to run them. I think nipa relies on
something slightly different, it does something like this, AFAIU this
runs an individual kselftest without requiring it to be installed
first (which is nice):

make -C tools/testing/selftests TARGETS=3D"net"
TEST_PROGS=3D"rxtimestamp.sh" TEST_GEN_PROGS=3D"" run_tests

It may be worth it to check if these added tests can be ran in a similar wa=
y.

This may also solve your issue with 'intermediate output' being
printed after every test. AFAIU if the tests can be ran individually
using a command like this, then you don't need intermediate output,
maybe.

