Return-Path: <linux-kselftest+bounces-8856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB6E8B234C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 15:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36CB1F21A6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B39149C67;
	Thu, 25 Apr 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inzWYlpf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B214F78;
	Thu, 25 Apr 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053563; cv=none; b=qssTDMTbA4LUlYANQR9hsZtjEd9DExCbVsVnqOeZdLm7AidWA4WTIfweG3R9yzOfy6dd6/CD0ZgVo7opLLQhR2GZEg8e2u7jAWypyUfOdab0ka+hbjDEo6ctQMEzxhdSq8z6Afoavp6ygmHg9+wD7S7FyfipGrgq4wCKWECpjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053563; c=relaxed/simple;
	bh=7XPwbTtYNJ82q4u31jANKwtM62X1Kmb7YAJriAR2NHU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DsMxYDRAOYAzlaPwfFg90HFroZrvT46BbwiW6ZoOJe2JJBV3sLCGRh3rnrHnyJL+2O97p+e36tp0tk+yr5BRMRrsuQISOegdQLYo5h2xFQBk7Z6KeRSBi5jWtmG69kqMhu9s7PdY5axKh0yWf55qwV9nacYBCjtPLki8dQN4VEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inzWYlpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ED3C113CC;
	Thu, 25 Apr 2024 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053562;
	bh=7XPwbTtYNJ82q4u31jANKwtM62X1Kmb7YAJriAR2NHU=;
	h=From:Subject:Date:To:Cc:From;
	b=inzWYlpfOB57pGRJsSDZhct7V+z/IFItBEWjlEQo8OMb3Qqh+1dqhcRGgXJmcDt+B
	 KWXV9NVzg1qptn5NOSFZqPraPbnlnC6sr9YvMPMzVZJjJi4Vm732e/I4Pi3ZIkpob+
	 4ioA/BAv3uBVx7IriErznyPDi2Mqys0sceuYETW77Meomwv4B2l5lz/2mhMkXGHL3w
	 vhm1VhJx1dmZGcuolOyvzcWT8pASJyDIXiXyDoXPcrb0EtdU0YtnMATvRwdjJnxYbk
	 nXzHX2b2w05z/NAS0hehhuV3xpJp7VMKsDxMm2Y/JVIeR9TNPKcAutg3VgJ3qnykOZ
	 eXVzNEbBP0fsw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/3] bpf_wq followup series
Date: Thu, 25 Apr 2024 15:59:11 +0200
Message-Id: <20240425-bpf-next-v1-0-1d8330e6c643@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK9hKmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyNT3aSCNN281IoSXSNDQxNjUwNTC/NUYyWg8oKi1LTMCrBR0bG1tQA
 ogEMaWgAAAA==
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714053558; l=732;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=7XPwbTtYNJ82q4u31jANKwtM62X1Kmb7YAJriAR2NHU=;
 b=2dcgMFCdGfR+ou2s/eZmMomjgv0RQMXcR4yRwQxvRZ3cGBFTzuTW6Ed5J5tF3ebaKcceEcQTy
 Gtdu7UCLFq5C0fl43+MGRfwVKou9PU8D3URz09dqvOOZ3JXN1/IHgew
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Few patches that should have been there from day 1.

Anyway, they are coming now.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (3):
      bpf: do not walk twice the map on free
      bpf: do not walk twice the hash map on free
      selftests/bpf: drop an unused local variable

 kernel/bpf/arraymap.c                       | 15 ++++++++-------
 kernel/bpf/hashtab.c                        | 16 +++++-----------
 tools/testing/selftests/bpf/prog_tests/wq.c |  2 --
 3 files changed, 13 insertions(+), 20 deletions(-)
---
base-commit: 52578f7f53ff8fe3a8f6f3bc8b5956615c07a16e
change-id: 20240425-bpf-next-2114350587e3

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


