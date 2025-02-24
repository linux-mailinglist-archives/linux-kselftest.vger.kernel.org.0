Return-Path: <linux-kselftest+bounces-27382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB1EA42E2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB89D189794F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D39245006;
	Mon, 24 Feb 2025 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="vyO/2lLD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A33B2A0;
	Mon, 24 Feb 2025 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429754; cv=none; b=CDbvO+ib9o/cR9CI3BUAJHP5bhMtIQ9NcSCnCQ/3JKBpQYLx6JF7Col23KeL2/72kb44iVzp30Iv6oosunyopRqx44dbM6Z/ZNE9SnR9+dUUZa4YmQBXq45hN8nWQKX30jBfNesoVXfa+tY2ZGe6wxWhvXFofkt7YY/L936EgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429754; c=relaxed/simple;
	bh=P3uH/MKKcNXnGpzdKpedBh7JKhDkXbq0wE/jAfs3Ftw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OAhuN+j/cI8KhpriZuhVgSFfj+U2LrGByPUp8zqGaKFBZZeHs7FMhp3xvdpWmeMLHS5k8KUC9Xma7xciyoycPkQqmZVw+vxrx8H5KPxXPYNagzWX0wfDVmxpmwi8XllAKTUdD6OLFN48g9EEN9siffdWpDFIVuz5OLgOdZjed54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=vyO/2lLD; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Z1swK6N5Qz8sf8;
	Mon, 24 Feb 2025 21:36:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1740429410; bh=F/S958YOMlhVQ7k/sBYXzKtRPZtkLW00iEhxye/aYjI=;
	h=From:To:Subject:Date:From:To:CC:Subject;
	b=vyO/2lLDV7YmJ95EcxyIQzm6VxPPn+6u23J5ahuZwtvnglNTInOQM9BX0nmExTOEj
	 1kRgCFC4b9fVU3KOGjAoNQFYcvp8GE2WCbj5MRC3qZRiZStBU9cyDS5E9gnalGmKut
	 4YHRU/43AzjwQfRmjfVxuiZNR3d70jgvtNdeyOn8oHlSDkREjyNtooY/olmmy28N34
	 u2Nt3OfpjeuaNlSbwTdHcmv4sI6kYEXQbh7reD5jxA8/bwuHozaqgQKlIQ4p0Un2Tv
	 NxpQ/gv/FctztFtW+Oli9gOZVnJsQwSLXszWQbt0U3O2wu6KRjgGXpaQLKULESlfgq
	 tfMlyxhsDO8IQ==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:362e:e00:55a6:11d5:2473:17a9
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:362e:e00:55a6:11d5:2473:17a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19DNN372IgUoIrOkF5n39zT+AvlBGfTs7U=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Z1swG4xPzz8slb;
	Mon, 24 Feb 2025 21:36:46 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Henriette Herzog <henriette.herzog@rub.de>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/9] bpf: Mitigate Spectre v1 using speculation barriers
Date: Mon, 24 Feb 2025 21:36:10 +0100
Message-ID: <20250224203619.594724-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This improves the expressiveness of unprivileged BPF by inserting
speculation barriers instead of rejcting the programs.

The approach was presented at LPC'24:
  https://lpc.events/event/18/contributions/1954/ ("Mitigating
  Spectre-PHT using Speculation Barriers in Linux eBPF")
and RAID'24:
  https://arxiv.org/pdf/2405.00078 ("VeriFence: Lightweight and Precise
  Spectre Defenses for Untrusted Linux Kernel Extensions")

Goal of this RFC is to get feedback on the approach and the structuring
into commits.

TODOs to be fixed for final version:
* actually emit arm64 barrier
* fix unexpected_load_success from test_progs for "bpf: Fall back to nospec for sanitization-failures"
* use bpf-next as base commit

Luis Gerhorst (9):
  bpf/arm64: Unset bypass_spec_v4() instead of ignoring BPF_NOSPEC
  bpf: Refactor do_check() if/else into do_check_insn()
  bpf: Return EFAULT on misconfigurations
  bpf: Return EFAULT on internal errors
  bpf: Fall back to nospec if v1 verification fails
  bpf: Allow nospec-protected var-offset stack access
  bpf: Refactor push_stack to return error code
  bpf: Fall back to nospec for sanitization-failures
  bpf: Cut speculative path verification short

 arch/arm64/net/bpf_jit_comp.c                 |  10 +-
 include/linux/bpf.h                           |  14 +-
 include/linux/bpf_verifier.h                  |   3 +-
 kernel/bpf/core.c                             |  17 +-
 kernel/bpf/verifier.c                         | 832 ++++++++++--------
 .../selftests/bpf/progs/verifier_and.c        |   3 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  30 +-
 .../selftests/bpf/progs/verifier_movsx.c      |   6 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |   3 +-
 .../bpf/progs/verifier_value_ptr_arith.c      |  11 +-
 10 files changed, 520 insertions(+), 409 deletions(-)


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1


