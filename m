Return-Path: <linux-kselftest+bounces-45364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2BC4F9BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 20:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF5818C376B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D913271F5;
	Tue, 11 Nov 2025 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQu0sUR7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB83271E0
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889235; cv=none; b=EeIwwrnGVJjcOmOOvpOmIrJnuQakxnojTHU8DykG5I3Nf685FwTD8sL5n23g9us+dHyWMTa0pTILW+k1XkQzKwNkMbSl9EeVwhx2HzJEKY18NXcxUlziZhLPspDf7piwwzoE7tUyTd9rpzmGBiOvV1BbF5M862+qgMUPzSmz2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889235; c=relaxed/simple;
	bh=T4q4eI/PjUjqDPpGU0Tf2NYnENnLstWCYa50yyn4bPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2v1SdbeCRPnIAPqODcCtg3SqGsedLfQ5ykggviesk5r1K+D8fbgAK4H0K3Q+HcitPiHxLpgHpCnSl1Vg6P+IENv8V7y9Jy8JlgqMcMvcxZ1rp09wUiC1zLnVMyR3sZzm56uuVCDRRRBo3cYrwl84G6zyrlqQGIj1TZZrsemgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQu0sUR7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-594476f218fso34849e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762889231; x=1763494031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4q4eI/PjUjqDPpGU0Tf2NYnENnLstWCYa50yyn4bPo=;
        b=nQu0sUR7DB7tDzowR5qZobA4FUDiRlSpO6wWrJ6ejebQBijIGVgMizvWluGbRYGHrI
         MmpeIczgC/b9cTkdMIGSud/jVbR5GCP8rm/tsVg5eGBvOPLYD5kCr4F17bkv4PsHxc4E
         LIAotl/MOOd9P5dPuSxOpUGTIPl49BCyvxtwP4WnvB3wHKbxJrK2ObYjyNfkKn7pSGW7
         7VzU781J9WU/MYo6jEzuR+W6p88/KcfcXEO/y09pPmbHuh7Yg53jk05HcVW6YZdNocE6
         a2VKZkaCz/xB8LEI15xi9Kqmy1haib4TfKy4aYVXuhbN2VEWOuJI2mAEE8wVACSaSkWB
         RCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889231; x=1763494031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T4q4eI/PjUjqDPpGU0Tf2NYnENnLstWCYa50yyn4bPo=;
        b=fp5Pn+Zwq7F2b+7gNrwV/xEmY4jlVNljsjHQB+pXwE4BFkWuHZ2LqB8J8RAN1dzYSM
         JSF7kaKubytEEj+2kVRUBJle4ECsgUEXPq8dxFyRrd5wTlYzlvPNgEyOzX7uzFkqvSJL
         08gqTQcoC2Huz8+bl8IstBHlvWEVR9hd9+jKC3H7wWIm/GmoOYOiQpQ77DIAdiRDnur4
         QL3iRJI1b0e8lZmm/wkNZ3GNNcsKgBPIQRVTmReThcMHvK0zuA9vibryyl4joKR/9BFp
         aLmhZu3HigefqbS/js+3ECtPmO3v4HOFxshoq8rkgFJLxXV/9LA716Urc8AADgAf5MnL
         g5bw==
X-Forwarded-Encrypted: i=1; AJvYcCXvfX/4EeQ5soKZzvSdU6fQXq42YveN+UAA76avDExu4G3JP/yUTIRryR1+MefTMngR63v1Vv+1hn0ou+ac0rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhNqpY3l/gP/Dv4sPISRLpakUzGlHkNmMpBmNjgTokozQs9Pfg
	rgo1YI32tdb+ljx0KrfWQLLUj4CIHtxQBU42Yv6B5eOMWdMj4dFT5/ZzgwNqJp87sqV4zQb9+eK
	Alo+WuJk4KW7tY2L+EBiyJPZxZGKKHif5J9g6q+yN
X-Gm-Gg: ASbGncu0fP/GyKWbr8Svt3+DLQLAx7JdEDcPAHkK5yUbnrkvwT0Ys+EquVA22YEY83u
	AE3HTZAPjK/Ug5FjEts5ae5RRepGtsaQ2lhfkG3I708B6QLqIuAOptirX20NNPE0GBBDlqF4wqs
	PIpYp0gCb1v7ULVqvNBTV+ewuW3GTRwMbc1FEoHRKlzaw7PyaqRoDP4qQPDAQN2RMNL9UzmC2Hw
	9g2FpXoRGDv/jqdAKm/MCJAHv0Cw9sedVenVMF6q1Tze13T7qKBfrFsa+YGLYJhmHWX5272j6qA
	0VA1+w==
X-Google-Smtp-Source: AGHT+IFsoUNsZKjerOV56G4XYKfZyWvAntKSJGGhk3vCYo0YWbEwNmd5TjSqbsr3l2nPJ1TiKUWXTC0bT2qotuyukbQ=
X-Received: by 2002:a05:6512:230a:b0:594:750e:1f53 with SMTP id
 2adb3069b0e04-59576e13618mr100574e87.25.1762889231088; Tue, 11 Nov 2025
 11:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
In-Reply-To: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 11 Nov 2025 11:26:43 -0800
X-Gm-Features: AWmQ_bn4dxVx1lBNbH8PWoRfGDh1pL7JrgTYZHIYTl7d2EJCVBbNB8Ju5ASDoi4
Message-ID: <CALzav=cmkiFUjENpYk3TT7czAeoh8jzp4WX_+diERu7JhyGCpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:48=E2=80=AFAM Alex Mastro <amastro@fb.com> wrote=
:
>
> Changes in v3:
> - Update capability chain cycle detection
> - Clarify the iova=3Dvaddr commit message
> - Link to v2: https://lore.kernel.org/r/20251111-iova-ranges-v2-0-0fa267f=
f9b78@fb.com

All tests are still passing on v3 for me.

