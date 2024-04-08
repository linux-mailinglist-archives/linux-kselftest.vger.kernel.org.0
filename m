Return-Path: <linux-kselftest+bounces-7434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB589CD52
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 23:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C7B228C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 21:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6B147C72;
	Mon,  8 Apr 2024 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZGQ+rU8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750437482;
	Mon,  8 Apr 2024 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611066; cv=none; b=hh6dZG2a47UoSDYM7KiLrAP/Pqo1mnyp80OEfX6rIrcuhq5HXNJwMlEv2bvlkAWJTFJoEQ5lkInH5N+bGKzMr98b7b26lWgFnZupF/ZxxyCwJb6EkOsoYFxrDJBriXjy1JPyGvRBhYatCrXZuppqdLoiSbMYO2Ejf+N/lahFXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611066; c=relaxed/simple;
	bh=nccc6s/QyxPnhkMngljVQwgwV5GBYeJoErKU2w5fY5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RprXRQD30AzMj7i6/dUbljHAsrP2wYfV0fQebJdWnotSUL8j1WHffuvwMzTWYgZFkoBnQfkBX+8vCB4FkMnGymX2hCxW0ue7hrnXbWlLXXeqHbTHyo7oA9ZXSc/Yd5xnpOykR1NO8z6lWDjXKxO2L9d5+P3Yq0YWT1JgxfgM6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZGQ+rU8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2b3e114fso4598301a12.2;
        Mon, 08 Apr 2024 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712611063; x=1713215863; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nccc6s/QyxPnhkMngljVQwgwV5GBYeJoErKU2w5fY5Y=;
        b=cZGQ+rU8gUpkMDcEslNTS4zqSB31mSN+8UxH7trxE47KyMJ9NMMnPuVRS5PL3mgbWV
         1sNBocXozq9K8MTT9Ls370hmX9b985JlbuKogUdk+iSdKPHXQK0bvTGEAbn4HEkbjfut
         oMC73oWuxlEy1nw85/WcitUvclAQN++5OSa6J4oupHlfBmV8W/ebEJkkSVcOvYLKtHJn
         Pa6BY+ctg2yiK9DYrrZBH4HRooRI0QhG1YisbEKBijOJAggR+YXKBmLBvPLd6/MGcitp
         xiCjKvy4iP6O2kvoW0Kmz2BvgkJ2sK4VvaEYgIVAiaVTsraPNAx/xkdtz8Ou3/3xNk3v
         6njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712611063; x=1713215863;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nccc6s/QyxPnhkMngljVQwgwV5GBYeJoErKU2w5fY5Y=;
        b=dHzMcFvgqt/HH1MxUQJzbZDcf6SjVgqpHeZA/EsXdePnX1ugan3J0w1udRXUTaZ4CE
         5n7F2aI0LYBUm52aafsb/afbMkIwqDyvMRbN7ZDp5ZpgeCetC4Y6O2tGht0NCZUx7dN7
         DyxKauHtp+PsWKN+MnZRjOdG7MImdGtpcN39t7wLMnkvvm76SXYFQjW8m8QukN99YgaW
         bsEiFfI5v9VFY+MN/ALdbwR/KgG30f/hSqiD1VjpaQ+BaW8c4kC/kduEtes3Zn45Ad4k
         8GM1pyFAtpQ9ZSD+C66Ghem6UZCU7cKLGl4ubiT0Yz33+/Yd9EtiiulwqPAoa0Y0ikq4
         czYg==
X-Forwarded-Encrypted: i=1; AJvYcCVBDUyNqOvfW1mpJ70+Vk9dCwB34Ph7Qd/CDzmpk9JU43G/Sgj/thzzzL4cG5XrVLaHVZfy/4HqPlXpDN0eNtLQ3l7Owz2sS30q/ifEHJl7EWmWCfMbeQAOLP40bo0hpZiqKCQ+9YnGYQFCH5JSN4ZP0uhAQ4Z42q7/dLID1pz71MGt
X-Gm-Message-State: AOJu0Yy68tz2DfQZrd/qm4q3LMY51Wa0Q8mE2TcntsKnViI/pocTd0Zv
	BmPcoJeWXR3UvmcCopey51cwewfPMoGvcqt6VKxPteebdUzfRSN1
X-Google-Smtp-Source: AGHT+IFGcXZQpUVnkBg6IX3TYcnATbe7YapUuNx2sNZb2AlCGn04W/UKHOiLipHNyxj3R/sNKBYc7A==
X-Received: by 2002:a17:906:5296:b0:a51:b23c:13f8 with SMTP id c22-20020a170906529600b00a51b23c13f8mr4969629ejm.1.1712611062465;
        Mon, 08 Apr 2024 14:17:42 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id q14-20020a170906a08e00b00a4e8353be19sm4874556ejy.224.2024.04.08.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:17:41 -0700 (PDT)
Message-ID: <371c84608bd10736de6b1a8abee3fd1d43664a9a.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 1/6] bpf/helpers: introduce sleepable
 bpf_timers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Tue, 09 Apr 2024 00:17:38 +0300
In-Reply-To: <CAO-hwJ+0erX3iJcOh9KBG3f01UiYvGk_Gx+-zyFc4Vb5LCcHxA@mail.gmail.com>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
	 <20240408-hid-bpf-sleepable-v6-1-0499ddd91b94@kernel.org>
	 <65c249a6af45bfa5fe0f6c2331dcc1771a6f0b05.camel@gmail.com>
	 <CAO-hwJ+0erX3iJcOh9KBG3f01UiYvGk_Gx+-zyFc4Vb5LCcHxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 19:20 +0200, Benjamin Tissoires wrote:

[...]

> That was my initial assumption too, but Alexei told me it was fine.
> And I think he is correct because kfree_rcu doesn't need the rcu_head
> to be initialized.
>=20
> So in the end, we initialize the memory as a work_struct, and when
> that work kicks in, we reuse that exact same memory as the rcu_head.
> This is fine because that work will never be reused.

Oh, I get it, thank you for explanation.

Thanks,
Eduard

