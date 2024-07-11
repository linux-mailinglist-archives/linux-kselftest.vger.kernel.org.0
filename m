Return-Path: <linux-kselftest+bounces-13591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0821992EB8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 17:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76E028117D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16716A94B;
	Thu, 11 Jul 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvjjQqIM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734EE23CE
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711186; cv=none; b=beBIutXmDCoWXU1h6j1brurOn6DVCW3hJX4yt6sRO28mBqExJtUztF2rE3YLZzO0kQsFufC3hCpAD8cYFlJNCgkOjpznzUE5ekNu1oa1x+nSpzGRPooTGqp2YgQTIGttXSqWYcT0uLIaMDvhvnhcIFVby98U9v2X0jLAakASqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711186; c=relaxed/simple;
	bh=2+bb+QpkBtNT8cHJOi+ZnFpY17WUiJVy/iDMJg10GLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmAyLA16T7Hnl0uVlIOssIRL4fsV1sMX7V+F44x+F+2FZi8shICou3Gj5uDoovx4b+TN80kaGBTqcTiQk9mSadSdNN/lXeovyBmwb7Cv1UVOHJrVl6TD4BHZIpspXoHSYOoCvksUzFMajR7v11j4GGX64bGQAy1374IVGWTg3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvjjQqIM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so13702a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720711183; x=1721315983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+bb+QpkBtNT8cHJOi+ZnFpY17WUiJVy/iDMJg10GLg=;
        b=hvjjQqIM97atANHLuYnpBmgnOsg/biOrQ1LurrY+jpDWksUQUJIO1r9iquhz/oFtN9
         9IGnvcWIJ2pksP3eDd67yUaa5chlexaqpsK9/KRAaJBXldEJBhDNzegj64nwE8/NMxC3
         iPiRJEG0a+5mi2Ppn/DIkTvmeJ9mKtgUhmkSs6zb4nzM+WYB3CCkvvPPEw+0H3QhILV0
         CrJPpS8v8tIgyMpexkgd38CvoBCefT0eHEG3E4WQMKlAVm7fHW6zsiNSx16Yeax/3Zb0
         eF1w4jV20I0v2+W2eeWjO715VEukdG++klVdRrsuZ6Olk/dANMF+/1sdBvH8g5MTcYxb
         AorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720711183; x=1721315983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+bb+QpkBtNT8cHJOi+ZnFpY17WUiJVy/iDMJg10GLg=;
        b=v3WX9EyQlYK53Z95twXaMsLvVW68etZ9U4rpXAIJq3bjASVfBwOtdmpQ0gR6XM6hRr
         LUSTNpfaowzg2WqXTqQWwDcC1ZBlDlLkctrCTP4Y2mAClTfMzl2vzJcGEs2SJ++lmG6q
         JBKh2GYmCu72mAZtKiFODw3lXdalPD7yXWJvu+60aFNQgzAi6+ajbsGpr4Yokur7TqRo
         cA+teaW+YdModNkcwhGj1Wdtx5W9Jd09mIwxaFGfssAguI5TdeghPWwYu0d5iAwnV5Fl
         Sz02iFyO7y43V7tpcbBITMW9mVdQ/VKTEVFA4vseBdjbkw94XvRYkh2EMKWLGrUd56nj
         9Kog==
X-Forwarded-Encrypted: i=1; AJvYcCUn3hVkWxlXn3xr0afeXKQ0Wu6uqOvYHBfRPDle8eHwjjxOfeKeMB8aZxf+rhKfhPkbVnHJsua5lAhgjMZfqpmFEVjEbWZ65MZapg+ra7pt
X-Gm-Message-State: AOJu0Yx6C3KnCrC47OrG8EEIIMSahDRff9JZzWvygPb3/moOgNbmtVtp
	RqQf6jhbtgTnNn+Ls26WnyS+FDbI/dXVtB0IV6Kn3BKFWivtF/wdRhEt3HzxHi9RNgqK8RcopEA
	62c8rWyBPZKclCWA/5JtrhP7ouYkNWzpOoQ9D
X-Google-Smtp-Source: AGHT+IFUZHGB/MYTQ+AEtXTIG2MUpAJou7TV7BlhO3k/D26+Cr+yw9GU5imU9h/cKuxSPpspQWgJZ2uy19SIpgHSl2c=
X-Received: by 2002:a50:cd8c:0:b0:58b:93:b623 with SMTP id 4fb4d7f45d1cf-5984e8f5e6fmr182082a12.5.1720711182527;
 Thu, 11 Jul 2024 08:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 11 Jul 2024 09:19:30 -0600
Message-ID: <CAMkAt6qtViYTx_xfxt=4VQ6TQG=53X-ZdEZ84s8UrZm3p-4brA@mail.gmail.com>
Subject: Re: [RFC 2/5] selftests: KVM: Decouple SEV ioctls from asserts
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, pbonzini@redhat.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:06=E2=80=AFPM Pratik R. Sampat
<pratikrajesh.sampat@amd.com> wrote:
>
> This commit separates the SEV, SEV-ES, SEV-SNP ioctl calls from its
> positive test asserts. This is done so that negative tests can be
> introduced and both kinds of testing can be performed independently
> using the same base helpers of the ioctl.
>
> This commit also adds additional parameters such as flags to improve
> testing coverage for the ioctls.
>
> Cleanups performed with no functional change intended.
>
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>

Tested-by: Peter Gonda <pgonda@google.com>

