Return-Path: <linux-kselftest+bounces-7598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54718A009A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 21:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6050E28632F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA57181326;
	Wed, 10 Apr 2024 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdXy5fwM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC55B181304;
	Wed, 10 Apr 2024 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777481; cv=none; b=sPR/m7zhlm7CsG5XLXftj46yPB2Jhd2lXSoJr7OjfWLteoff5gorMoHPNHFgsLNO+KKh0gGPmhPZ3SEeEOhQcNHgwVwkBOBNOwQNHu5IOV1GR+wQmSzuz5kbUm3g0ENHQsP2ZbiZQCr2NtYOIYIbIKQxxiVSsOlzLg34aVvLEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777481; c=relaxed/simple;
	bh=6eTM4VhuvsbQDeuHbmODMEl94GKSafraflDKlk7n/uA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=h2Y1Nz/pccOjg/WjjlWOFsA/YKLU38jz9hzzPLaxZnyk6ZrqAqbyo4/bo3OblKeeBFYi3FGwbY6wclrMMV2WZV9jo1nMNriFBz1208wgUj7pY9RViUdV9TtT6CwRIQBWXeOqff9Qwoxmq/9L5il7vXnw0tsuw7f4iusoNDuKyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdXy5fwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A468C433C7;
	Wed, 10 Apr 2024 19:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712777480;
	bh=6eTM4VhuvsbQDeuHbmODMEl94GKSafraflDKlk7n/uA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NdXy5fwM+jtpqevCmddiKZLa5yybOo5x9HWwxeR/MqYO53Efrlny2lRqVrVUYCSsT
	 GX1CEhVDJU8tffKJ98vOVxrstRm/Dml59u2xMwABxL7eeTq9uQo3xEekIjFHVRaEz5
	 5Wn1jzukHs6ovFG1bWE3ttXFtXcEY6dD/MXf71wwaraSGfC4Ro+4CiIfX0BrMzvlhK
	 yCPPczxi38O67YqwVFw9Uart+LfCkcE4eB7OULeESyZCOwXXearkwbnANY7yHKDFrA
	 NQXmfCRLT6rQVb0SwHhVnWU3tqwKHp46MykV/xzmsWVFkX7Iv4/NZ5HdKRmMJnpFLI
	 qDIFsETpgipNA==
Date: Wed, 10 Apr 2024 21:31:13 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Message-ID: <b8c14751-37a9-4a3d-b9af-a5c697d34781@kernel.org>
In-Reply-To: <20240410113452.56f156f4@kernel.org>
References: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org> <20240410113452.56f156f4@kernel.org>
Subject: Re: [PATCH net-next v2 0/2] mptcp: add last time fields in
 mptcp_info
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <b8c14751-37a9-4a3d-b9af-a5c697d34781@kernel.org>

Hi Jakub,

Thank you for your email!

10 Apr 2024 20:34:54 Jakub Kicinski <kuba@kernel.org>:

> On Wed, 10 Apr 2024 11:48:23 +0200 Matthieu Baerts (NGI0) wrote:
>> These patches from Geliang add support for the "last time" field in
>> MPTCP Info, and verify that the counters look valid.
>>
>> Patch 1 adds these counters: last_data_sent, last_data_recv and
>> last_ack_recv. They are available in the MPTCP Info, so exposed via
>> getsockopt(MPTCP_INFO) and the Netlink Diag interface.
>>
>> Patch 2 adds a test in diag.sh MPTCP selftest, to check that the
>> counters have moved by at least 250ms, after having waited twice that
>> time.
>
> Hi Mat, is this causing skips in selftests by any chance?
>
> # 07 ....chk last_data_sent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [SKIP] Feature probably not supp=
orted
> # 08 ....chk last_data_recv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [SKIP] Feature probably not supp=
orted
> # 09 ....chk last_ack_recv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [SKIP] Feature probably no=
t supported

Yes it does, I should have added a note about that, sorry: that's because
SS needs to be patched as well to display the new counters.

https://patchwork.kernel.org/project/mptcp/patch/fd9e850f1e00691204f1dfebc6=
3c01c6a4318c10.1711705327.git.geliang@kernel.org/

This patch will be sent when the kernel one will be accepted.

Is it an issue? The modification of the selftests can be applied later
if you prefer.

Earlier today, I was looking at changing NIPA not to mark the whole
selftest as "SKIP" but I saw it was not a bug: a check is there to
mark everything as skipped if one subtest is marked as skipped
from what I understood. So I guess we don't want to change that :)

> I'll "hide it" from patchwork for now..
> --
> pw-bot: defer

Thank you! Do you prefer if I resend only patch 1/2 for now?

Cheers,
Matt

