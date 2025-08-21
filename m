Return-Path: <linux-kselftest+bounces-39467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA00B2F2ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 10:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49CB7AEFE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2E02ED868;
	Thu, 21 Aug 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZ6ZQ8CL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F62ED147
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766434; cv=none; b=QrA80gGYGjU1Y0CC9dUS/dhZo5nqaOsCYkVy6dLt/A9SELT7QUI5mc/arjVt4Y4PUl66tPSiMlqG4cFNNm9WZy4sc0lxaOog5/1zKyvSSZ6/3B/R/Uie9Pd4twqKx62kZeQRutrWdzuHmmwi2v1ZR42iUkZhAQN5svQQbcFzYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766434; c=relaxed/simple;
	bh=aBhzP6d3YQDrwI7ND5rpwO6HjIyfUepP/sZomCKrjm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFdPYOvXhLQc97JAXVnNe10l6++eT851erEQiTAFEwdWyAdWiS9FLfkZ6R9z8wOMC7delmGBaCaagAE1kNUn7lX2ty8HkY+OvIQVt0zwozv2eo71RmMEGrA1mDQ9YoLSz1lC/3lafdJYcjNuxND9amAaC0B/ug/h1d246XZpaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZ6ZQ8CL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e87031323aso85647185a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 01:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755766430; x=1756371230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBhzP6d3YQDrwI7ND5rpwO6HjIyfUepP/sZomCKrjm8=;
        b=gZ6ZQ8CLB54J23MX/pt7FqW269gE8bsMDwn21mPtLT1bevECMXpZpl21m1w6brOzBu
         oD6kz2uLAhFXuUSa1JYnGDvF9Zlm3WtzvlcetMDIrjNtJ0N8w6WeE4ioy+2F2bq4Mwg8
         FsI+nj+q/zSl48nemYBRa4/Z8uUOB7/vrRKfzt5bkWvrb04M0tqPX1r4prY/Iss0AMs+
         6T5MhmhMbywueAOuCjOS4vHAwZDOcrkq2nm2esudyoTgS0uBf2DfYxynGv6Dw7XH8VG2
         CVzWYtowqIDYUI+LP/UQOdn6KpiezjhugF9HtEkJ3YEULL2oQ0eXqKeg08ILMfKcLP/U
         rXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766430; x=1756371230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBhzP6d3YQDrwI7ND5rpwO6HjIyfUepP/sZomCKrjm8=;
        b=d+tXS4+Bs8Ui6rxXuXd+Rq9OFNNY+4l0/6szCkXYdISo9zl3G2WeQDmSaOnPUQBT8v
         jaiz+Np2GlSoubgfjunbKSiL+h9aoGBUH32Y2OERMyTgQnW3KN7pUKeuVcgMyYtVkW6N
         Zk6bexavosKYFLI9sw04Av8EqGU/WZVGyPkMWTXz19+t4WyC2N1l6/rd73bfNL0DlDei
         t3PKwDG6ZD2Nqr9olCOXpj2tRbE1qICKBehfPdy09mTbpR6dod/iRMzjPsAVlWgU7/Ns
         RpoIJiYQ9Tmi1dn3RoWoQecvEMkKFPUc5CSIZPQUz76gncpu2VCZWV6FaTEU21pYEPre
         Nx6g==
X-Forwarded-Encrypted: i=1; AJvYcCXOyLE+k3VRmHqxR4P8onBBrZt8vICoY8bQj07UfqMR/6/Wzx2jC0/gvXFce80/GrDe1Q3wo6X4DuShSZBRsL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylZaJsSHIXd+z00MFsvy833zLEy5yTgVC/8kdsxCmvIcIM8W/u
	cTAd5zSkNGUJBJCMddzEDuVq+g0I+6SEPogy3KfTB+nvP/73CjLWgJkpb34fjOhD60Zm6gCULUw
	noteaLtQUR6pVMORcFNYjMKRUCQhaKWxbxNX9N4Yx
X-Gm-Gg: ASbGncvUGYHgghlDh5IQI0HT+XKdD/a5CdAeJ8O6uDsYtWD85mY08hyeyCWAFKHaCaA
	xkYLICcL9bf2lajIKK0L5O6HN8aN7ZJUeyu8fLHyueelezpfTailCe0rQCHXh0Dfz3S1hzm4T1/
	JCnOgUNu7cxQiXj7bj7c78qgUyGVTFEDhBu45gbphdy8w1b992vWkJpmiHRn9qukoNKi/EDt1AY
	Il24+BN0ug9DQFzKHj75nuJqw==
X-Google-Smtp-Source: AGHT+IFv/PtcOPUQj2eIhfJGxSY/JvZ2K28lWNXCVsP0qeHLxlQhiCXLQmPIYrOD4LLNF/m/ke6DWecfHMX5teVadAA=
X-Received: by 2002:a05:622a:1115:b0:4b0:6836:6efa with SMTP id
 d75a77b69052e-4b29fa33f1cmr12068061cf.17.1755766430147; Thu, 21 Aug 2025
 01:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-5-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-5-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 01:53:39 -0700
X-Gm-Features: Ac12FXyHsFmM4Y6s9A4jizpJZU8-dSIL1pxwxTNu7e_RRTYEAUIKywp1b0fLC34
Message-ID: <CANn89iJn24y7pfqOL9unDK2WX9wjVwTRXjsY0ABdHtxQzexS_Q@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 04/14] tcp: ecn functions in separated
 include file
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:39=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> The following patches will modify ECN helpers and add AccECN herlpers,
> and this patch moves the existing ones into a separated include file.
>
> No functional changes.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

