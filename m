Return-Path: <linux-kselftest+bounces-9590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD228BE416
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19B628802D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB5415E5C9;
	Tue,  7 May 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt91sz+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B6156F20;
	Tue,  7 May 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087984; cv=none; b=EfFZ5ey0fJQfJdJdC/Mlf23g5IKXEKi7/GVcvhFwye4DwulGC+cDEcM6gBI/KYrvxD2smR+zBtaH585ktpx2iI1+vlir5K0ZIyVBAIF8OA2ePNfhXwwV4vwWLKsn2zlfVgHIlHc3tE5rwtrFQ3YJXcHoA5/oxCEsIibOc2WB7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087984; c=relaxed/simple;
	bh=DK4iCjKnlJIlBF//vWCP9Yz0CmFsZevISnqiSy4zwTM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hyfLWy1ZxC3rjflEdbCiQmdeIy0EI1+XFzS3cvM/IpYnHIuwlr7y9z8Cj0qTSWQq2yKHRcpvj+bqok+ANu2Ui3lqz5Snzn5/VycQzNSyscZOUOc9tJM3Vz4Zr5wKkqH+4u+h9W0WUcIVBlZUupgKfhYUN8Zz8qjfSwPleL+umKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt91sz+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77F2C3277B;
	Tue,  7 May 2024 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715087984;
	bh=DK4iCjKnlJIlBF//vWCP9Yz0CmFsZevISnqiSy4zwTM=;
	h=From:Subject:Date:To:Cc:From;
	b=Xt91sz+MEtOWUpUcXzZoAVJjbvP5A1ACBhupLQBom6K+RH/hYzre/xF+iV1T//tpe
	 kRHMTP+iysCWO8L61/jMXTA9kGMQYzeh/RVMOp2AbxjE6tJfradlRildSjqJqfTdbh
	 7zRu5xrwjvkVktMNi2V6xv9jBpN5lVOyZTVmmMIbamRt+UNu/FYG6k2tz29QZKmS22
	 3WNemPgJJg244IUvI2PEDzp4jMvdltEmlyWBOy/YMpdzsQX7TQFPqguRn64m4UNkFh
	 GpP3XMmuIVETMGoYGMOTjCqau4+wOeHGrdnECRVbi+nigQdnOStQHQDJ3sy/nw9GhC
	 9N8MBFPYGExCw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH RFC bpf-next 0/8] Implement generic bpf_async cb
Date: Tue, 07 May 2024 15:19:28 +0200
Message-Id: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGAqOmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwNz3aSCtPjE4sq8ZN2kFKNUM1MLE3NTI1MloPqCotS0zAqwWdFKQW7
 OCkClunmpFSVKsbW1ADi2WUppAAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715087980; l=1307;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=DK4iCjKnlJIlBF//vWCP9Yz0CmFsZevISnqiSy4zwTM=;
 b=CvZpiEBMRmreHKZJ6rv4jg12NxQ7OFhyxAiR8Zarf1Z2dN1DwAEqsVeq1ZCBo37HDZucGsKoS
 v9/YQsP+1l+B3MM8eHQE7vGqKb2pnRoG3h9+Cs2nAkmUa8sM+14dcoZ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is a RFC, following[0].

It works, still needs some care but this is mainly to see if this will
have a chance to get upsrteamed or if I should rely on struct_ops
instead.

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (8):
      bpf: ignore sleepable prog parameter for kfuncs
      bpf: add kfunc_meta parameter to push_callback_call()
      bpf: implement __async and __s_async kfunc suffixes
      bpf: typedef a type for the bpf_wq callbacks
      selftests/bpf: rely on wq_callback_fn_t
      bpf: remove one special case of is_bpf_wq_set_callback_impl_kfunc
      bpf: implement __aux kfunc argument suffix to fetch prog_aux
      bpf: rely on __aux suffix for bpf_wq_set_callback_impl

 kernel/bpf/helpers.c                            |  10 +-
 kernel/bpf/verifier.c                           | 333 +++++++++++++++++++-----
 tools/testing/selftests/bpf/bpf_experimental.h  |   3 +-
 tools/testing/selftests/bpf/progs/wq.c          |  10 +-
 tools/testing/selftests/bpf/progs/wq_failures.c |   4 +-
 5 files changed, 280 insertions(+), 80 deletions(-)
---
base-commit: 05cbc217aafbc631a6c2fab4accf95850cb48358
change-id: 20240507-bpf_async-bd2e65847525

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


