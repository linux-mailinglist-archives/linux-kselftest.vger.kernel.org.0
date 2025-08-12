Return-Path: <linux-kselftest+bounces-38801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CCDB23426
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 20:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A2A622CAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD727FB12;
	Tue, 12 Aug 2025 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8/MIK+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319022EF652
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023546; cv=none; b=TiKkKNrdj9BzMaHNutIh/6CQh8cpr1YWbvDy+I+xgobS/cQ/qFVptZsquGtFxh+SwkV2crzPJ5Ye4dI7/+k+eOs5E7oTFQsMp9r6pAieHmRKgpokzhg+o0YBQeSFfmdHGxBFhltNimqhXqv+5Tmgjl8ExJsFLTa6eLwoRsi/gsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023546; c=relaxed/simple;
	bh=FZPHtgVyhX0m7jHHaFrr2FnifaR0Btl+pceIi79EiEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOuH7mzkLZVj4nF+FQD4UrPr24MEgx8fwK9DP34oJK3GKggXrodVVQdUPSrLG8ZDstfyRAbD5jbrVZktvQm89O5lsZ/Qf95u0N3vOieiZ8WUVZgWpXdml771bgS5EeyI7Ob7A3HPWc2tFjoJCaqumdgnKEhOfzfpDmax4LleN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8/MIK+z; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so2025e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755023543; x=1755628343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZPHtgVyhX0m7jHHaFrr2FnifaR0Btl+pceIi79EiEs=;
        b=R8/MIK+zOYicOriW/NHtucuUHhB8u2kLHlMZ3+KG4IDThxGMxN3L7HDW6VJcVsTfTJ
         7kumg9tKrStthMcXaIngNLs2gJqMQ/arzjUzefs2yBN2Z05j0Qq+IDjngYNku0rezqqg
         fItVVBFIDJ2AiPEDAoXQBJT1vMGAp/KI/8FJWfCJOR6cY6mN00AI56U6B/S4LGhjKokv
         fuQ1JmYC8BYzVzjanba3qxmlm06jcEnAtmTQEf+71ASFIOgxOWko31F5uHVhAro2WgfS
         2AFeYWUVhDR0RbWm2cKovIsHSe+xE/Ye04GK1PX8OY0o2ot9dTO1kH26JcsthISNESPe
         djfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755023543; x=1755628343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZPHtgVyhX0m7jHHaFrr2FnifaR0Btl+pceIi79EiEs=;
        b=pEGRyGLQTI3UzJ9UIZ3Sdsergg3NTY1j+yjOnU3xirIEqX/vat/vdIJ9xvFNVj4JmH
         Dl6yHhtklA7SxJszIDqBTXAHS/TEL1vvSQsAekdZhsBDEUSrcksJ7+rmjGWCe1o4M8B4
         L9c0O0y+VNo90UJfaqPZAfYup48/2lNWpb68VBxat9EfVcidI5DIxHdDZ6paGpz3lXG9
         48CvDFtY/Ti2QLE4hDEddG9qaJX5KxUlrekYoi/Fo6ofcYHl0Cs6NUL5K0eh0BPbXqbt
         XXwiJvJ1mz7H36otu1Ao+xKXkjVroIUt4QNTpqUvGH286qAwy/woUfLbmXJNwEWTyBuM
         nukQ==
X-Forwarded-Encrypted: i=1; AJvYcCUebfsSLkRxSOlyJm+z9zZbMh8P1tHZtYZFpW7WKMtZMwOo/x7DTU0u+/y9HcbrJSzkU/+QybHWK9aWtgWeGn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKaiCfV2XtCm4+IqE0QhfRTr3i7cQCTX2HEmMhZLzIcpYaMiB
	PaRZ8iZFEJCb6p4Zym9HLhp/RIMmsD4+GLUn98tTys7pjrgKao4Q7S3v+kQ8HEsl4457mNQTAtT
	Nh5otAQ1iSJ+U4edKhOgJDacmTWMIAqaOB6rY0RZ1
X-Gm-Gg: ASbGncvnriEsVT3TscAhikyfzPyI1q9B13X8qDqK3xS/KVD8n/i6hRijlBVQB5FhdyI
	Y9S2gK9TkAKAFSxbSZ305taukpIMsqQDexoMSkdM0d5bQUDuilWXL82J6IwNV334zZlbDtRFO8h
	cwphyYQ5sFYQWRfo233IEN9H9R43+tOPkURjq6NjLeJuZNVxrYeLWfGAWrHLFX2dFyVJOfAODPP
	tz5aTdJ9yWfpxwu5zkyEGqStUpT/0GYPOtkOQ==
X-Google-Smtp-Source: AGHT+IG8FaZ3ThAX6AeXsoA+NmzLH2hPy9bEMgldfmA2/376ZbHPWQiP/tjkthb7U8eOjAbKl6B+IO3Qu/uFgEhabfs=
X-Received: by 2002:a05:6512:ad1:b0:55b:af2d:393b with SMTP id
 2adb3069b0e04-55ce07374e3mr20418e87.4.1755023543040; Tue, 12 Aug 2025
 11:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-6-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-6-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 11:32:09 -0700
X-Gm-Features: Ac12FXzfrsii7ur7xgN44tM2MW892PzoXxuy4ivcSLCGpW-vYAI4foQcDUESiTk
Message-ID: <CAHS8izP-EMxFFSF1f_8ceP2_1vt-Jrn0tnp-Bc4OKRgX3Uz_3A@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] selftests: drv-net: devmem: flip the
 direction of Tx tests
To: Jakub Kicinski <kuba@kernel.org>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The Device Under Test should always be the local system.
> While the Rx test gets this right the Tx test is sending
> from remote to local. So Tx of DMABUF memory happens on remote.
>
> These tests never run in NIPA since we don't have a compatible
> device so we haven't caught this.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Changes look reasonable, and to my eye the rx and tx commands are just
switched with no changes. I would have liked to test this first but
I'm not sure I'll get the chance today. So:

Reviewed-by: Mina Almasry <almasrymina@google.com>

and I guess when I have a chance to test I'll either give Tested-by or
a fix on top.

--=20
Thanks,
Mina

