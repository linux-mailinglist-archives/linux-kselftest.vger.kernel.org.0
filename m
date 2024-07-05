Return-Path: <linux-kselftest+bounces-13236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B9928A05
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 15:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E1A1C229F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2420314D71F;
	Fri,  5 Jul 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTk2eIKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE914D2B9;
	Fri,  5 Jul 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187104; cv=none; b=tTmSOjmMXFO75ad3MjQQ+3MlwpWQGS+rzHxNOMitJAALz7Sa7884WBzPwmcn/fkj5d5i+yaMJSk6TmWqcou41UEffJwumTIVCLtiarMjK72bzC7hUhZi/tUrDoZtumHIp9IkjMYUwh8t7+0eke20dE222MBK5WWKhTseLWav1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187104; c=relaxed/simple;
	bh=dj7rdOwJS+hJMpfZBEWUiZKio+Vg/2kZ/nZQVgLmBG4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X7TGHjtZgOU9CYvMugnoVy2aFwJKyB/RH3CozF75+8772olA2uR8aMJrJ+BB1vtg8YZta3+wTbPbjeOv34q6vuatUvtunBldmeTzjeN/ii9GcVaki5nrTm+BAaarjD85iIfu7tz10x7nd5C+JMKtPVIsvbcd5iHEPtGvhUz2fgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTk2eIKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EFAC116B1;
	Fri,  5 Jul 2024 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720187103;
	bh=dj7rdOwJS+hJMpfZBEWUiZKio+Vg/2kZ/nZQVgLmBG4=;
	h=From:Subject:Date:To:Cc:From;
	b=rTk2eIKr/j5uI2EmS8Eq/BJ7qaqj42JXClKTXk0nln3xz5mwVlKftgz7pGWMFYagJ
	 xYJ0W7122fogvb+CHu9h1t/pmmaK2UGdAfP52+9CXQjLv62IghLWQJk5/8CgLZ0QrB
	 dXcXl79d3fpZnZljOQq/4enEPdDo5G+jTUmcsUQRTLCmcanT9M9mStylQm5OEcFv9I
	 ULHU1+s89dLY/KRVSErGiu8/ruxmj/4C7aqv0DkprSsMjPZqmNRsc6FmXFjS030haR
	 7ZhcxTynmkNSICgiq2JDQM1m23wvgNtGcns+ze+0dK3A2FL6NpKC9mmPGWtIsggGan
	 FyEkEA1+9uN7w==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH bpf-next 0/2] Small API fix for bpf_wq
Date: Fri, 05 Jul 2024 15:44:51 +0200
Message-Id: <20240705-fix-wq-v1-0-91b4d82cd825@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANP4h2YC/x2MywqAIBAAf0X23IJpD+pXokPaWnux0igh+vek4
 zDDPBApMEXoxQOBLo68+QxlIcCuk18Iec4MSqpKtrJGxwnvA51sOts6oxurIcd7oGz+0QBmd+g
 pnTC+7wcfW4XOYgAAAA==
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720187099; l=1146;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=dj7rdOwJS+hJMpfZBEWUiZKio+Vg/2kZ/nZQVgLmBG4=;
 b=kV3YYj0mX88v/JTTKvTmm8P/+oFkmG1jXJlwjPlaZ7k/3BbAo0ww9wmDzvLeWGHDKuc9M2Sac
 i2ypTdCS4PMCOTkcCMZzHLB//jefnRcUBN1EOBj11OLxhkmqk155vpa
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

I realized this while having a map containing both a struct bpf_timer and
a struct bpf_wq: the third argument provided to the bpf_wq callback is
not the struct bpf_wq pointer itself, but the pointer to the value in
the map.

Which means that the users need to double cast the provided "value" as
this is not a struct bpf_wq *.

This is a change of API, but there doesn't seem to be much users of bpf_wq
right now, so we should be able to go with this right now.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (2):
      bpf: helpers: fix bpf_wq_set_callback_impl signature
      selftests/bpf: amend for wrong bpf_wq_set_callback_impl signature

 kernel/bpf/helpers.c                            | 2 +-
 tools/testing/selftests/bpf/bpf_experimental.h  | 2 +-
 tools/testing/selftests/bpf/progs/wq.c          | 8 ++++----
 tools/testing/selftests/bpf/progs/wq_failures.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: fd8db07705c55a995c42b1e71afc42faad675b0b
change-id: 20240705-fix-wq-f069c7fb36c3

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


