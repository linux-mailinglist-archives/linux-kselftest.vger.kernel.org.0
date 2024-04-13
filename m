Return-Path: <linux-kselftest+bounces-7907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5208A3CA8
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 13:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50206B216C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED23FB1B;
	Sat, 13 Apr 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPkbalI0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87183839A;
	Sat, 13 Apr 2024 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713008658; cv=none; b=plQTZX+mZoqRE+xsxvBKvpQ3dHO44th1kPNntX4yn/8/uxvGQIwuDO+qyUsx4dnry4v8++sMbyy5PnCGWtwrfr70g0f3Iz2WBXIhK2trYwsZyea+HaoQf4s0hzcBTyoJH2jdZHpnCxiQSIPsrRx2a/0lDzznVfZJKfT6RYhc198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713008658; c=relaxed/simple;
	bh=KnBXY5UF6YCzLXbhbJg6nmCpVhH7JaR+37AGQF+vy74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0EcklGe0f3FUpQa0jR086bIrqKzVsF8CwdmqfryVE7vbf5qiErkT5G5D5kUCM7wMT+XJX2fHhAfNoEgiYL4M69JsDdWaFgctJBvAvy3bEAcXgPZwQX3zvfZL+ZNy3bRitmvPVdvHlfckMNb1bJFh3ArAgTxcATBG9nOqzd2GL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPkbalI0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56fffb1d14bso2238468a12.1;
        Sat, 13 Apr 2024 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713008654; x=1713613454; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KnBXY5UF6YCzLXbhbJg6nmCpVhH7JaR+37AGQF+vy74=;
        b=WPkbalI03vkZzvYdbr1qDa0aa7q2ITj4lXALVSJ5nGwknE0WwswGsY7rCyYUV07xZe
         +I5aeLdst6wWx/VVf/K0vpXUrpxbftmp2y/qV7PUUtKzTb3TLhkwe7zH4BBdSfRitQ25
         tMBArMH4mOYSIVofe7YubY1xNTnDoVqbfmQd4cKW8CWxaxE1ASq7E4dKMeS9iXmdLcVb
         Z9WKvcBn2eo1zc5xTtLtKXrDew26PzUfnxH9KulmlLWDEPyGtH7r/CInUmTr4enpYBMu
         6iwvrKsiUJdt5jNUI+Zx4+ySqNWgDXAJ+TsC3iUGLQZPp0/mqu5c1O6OMcvumxHl+yxQ
         RXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713008654; x=1713613454;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnBXY5UF6YCzLXbhbJg6nmCpVhH7JaR+37AGQF+vy74=;
        b=PSjC2EPIhSPoc7bkdCZvjQqYkuM1ZkObVgxoAx7rHfVCTUEHObVpHyxe9WY8EVQmrs
         2eKv0/OwCQeanjjRRLTtnZ19kkfsQ9Ygdb/qh8Ow5ER4IV4TxHZxXJhMZARl81yXu42G
         OfBVIsTGcOjyNv628atqXJo24cM5hTVO8Yr+Zte/OTY19z3BmxuKb4YJpM3pu3EZUFSk
         4Az6nNYOAz1Venmm2jSAMZbpWf67EZ51jaknykjsvaUQcJJ0aTHUxsx6o9e5zXYzHgQY
         meoxsn05Li4cmjZGMktRR/RFqyBQU5/43B6ODqpy5GS1mXB8jVxQ0/XAZ91GowhaOiey
         zycg==
X-Forwarded-Encrypted: i=1; AJvYcCUwgCyKyNjyDt2xqrKYZUTgRiYkFjKa1GMg9B5KBatLfy1bV+phKJY2yqsx7PUNFxfqscPQreDFGGLrIYUy+e6a+eSoNy568uA5mh3mtvZ/W7YeBFO9V84RYzDf9pE5A9rjODEyGufHCHzTBWeh5SqiwkX0h5Ri9/A6Go+FpSs8YDOK30UD4y6DWnUQ09fc458OC0jxYnBpOtVhiOBq0MDohqwN
X-Gm-Message-State: AOJu0Yz64cwcSgL03OzcAr6hBkGxJvra0HkCwemaHiuH49LlVvicLouj
	nwwMhKo9eDh9PE81eskmXGlag8o+LOj9IYuWvag2aIJK3ivA+7mm
X-Google-Smtp-Source: AGHT+IECMiHcf/+B/M0rCnj0C9WtMuHWj1fqjvS7fDAhsrEnWpxrFdy5FYVmH4hWp20oU69B2Ib3iw==
X-Received: by 2002:a50:d78c:0:b0:570:392:aa1a with SMTP id w12-20020a50d78c000000b005700392aa1amr2449745edi.7.1713008653910;
        Sat, 13 Apr 2024 04:44:13 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id t11-20020a056402240b00b0057010f76bf7sm529238eda.63.2024.04.13.04.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 04:44:12 -0700 (PDT)
Message-ID: <d9f79f367e3a5cdff691e586383e9ad6a831d53d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 03/11] bpf, lsm: Check bpf lsm hook return
 values in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski
 <mattbobrowski@google.com>, Brendan Jackman <jackmanb@chromium.org>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek
 <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, John Johansen
 <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Sat, 13 Apr 2024 14:44:09 +0300
In-Reply-To: <20240411122752.2873562-4-xukuohai@huaweicloud.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
	 <20240411122752.2873562-4-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 20:27 +0800, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>=20
> A bpf prog returning positive number attached to file_alloc_security hook
> will make kernel panic.
>=20
> The reason is that the positive number returned by bpf prog is not a
> valid errno, and could not be filtered out with IS_ERR which is used by
> the file system to check errors. As a result, the file system uses this
> positive number as file pointer, causing panic.
>=20
> Considering that hook file_alloc_security never returned positive number
> before bpf lsm was introduced, and other bpf lsm hooks may have the same
> problem, this patch adds lsm return value check in bpf verifier to ensure
> no unpredicted values will be returned by lsm bpf prog.
>=20
> Fixes: 520b7aa00d8c ("bpf: lsm: Initialize the BPF LSM hooks")
> Reported-by: Xin Liu <liuxin350@huawei.com>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>



