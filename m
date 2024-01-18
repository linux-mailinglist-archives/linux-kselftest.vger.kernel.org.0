Return-Path: <linux-kselftest+bounces-3196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9BF8318CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 12:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2140B240D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F92420A;
	Thu, 18 Jan 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NrJHvlrD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE5241EC
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579120; cv=none; b=ObhHnHuh4WbNyXnqEVaxiDjbzn4mxUAxwgSSxvUlEOBQ2+Lw/glUd9BOUN9cY/z4ScqysfAr4NPWTUUk88UHfXZw8u1oIkxP/L91PTI0ZNFZUqvG4LnsJnDwama+lGRfJNF90nRxbd3rZWZtlIyiJ9T4lZZPj85eHukUIauV0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579120; c=relaxed/simple;
	bh=xkJ/aT8DcytnAx528iPQf8ADCV+RYzAgF7dXLAfMrQI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kovdb/ZnhRQJstRYXZ2StKtsAHngMPNc2QmhivV3yQxcX9b7JsfYjSg8kEbRCFL5OfSNrZzWzgQx2p21swaC7AjmLy7n8/FvbgAgE2qxJsMCX0Sb1Nz64MHmH2IfsiEXzr+9Xl8ehymme+muGS8Z8l3XgG9TmfAdzDv3ZVnmLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NrJHvlrD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cdb50d8982so55365521fa.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705579117; x=1706183917; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbxklWEU0PAbbLTe5qIkTTS+M5iIqLF4yMpPTyG9JCg=;
        b=NrJHvlrDySicu/pLhLZaMMYhVxPBU6/JPKVVEA4Xy06VAOW1NhazxHdyq7UDjN3+Sc
         b6xJZfVKVZ1V2nyuKFNqVUI6VxSt7HaBHVSEjGthCM8e9SgDgLSnUk2ESX4+b++RAKVk
         Dajd99RfdSCgm4g6bT4/TWDUjvRPg2LgJ8cDWuLW4hm9HeyTD8OEVOFfFpJy1Hjcm9ht
         A/Wzo3Shu0m5GxN+3Zo94Wbo466ORQtP1VpUcjQglvotG3bJdY0kx5t5bJy8t2GA4H/c
         X6oAibYDn2QKit7NQ/tK0LOHwUYZmnADtC7s0CL4Y6QDFIlDVpt3ymZ37FUrGrnd65va
         QymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705579117; x=1706183917;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbxklWEU0PAbbLTe5qIkTTS+M5iIqLF4yMpPTyG9JCg=;
        b=V8QXXAAioPWCojNGR+SfxdOmZv//i5iB7AFhtyoR3dyXsNyIc1vgtemElR7+WVCa8X
         IdlQ63yESpbZynS0rl4RNP5Xc0uA1P6DtzRJmRwdw339jzyHEr4neRiYZ7bAZxzXU35j
         BsoJtlRs9RUR539CZbsgYBJu+mI272ggdLHRLe9cHmDMTIKYjFbwrMgrTtsE4Omkagpo
         983jghtoCgnBljnMOWV9f+vGe9ImiCb9aO7PUK51nk7fj0iD4VgAwHxJKxOtSQArh+Vy
         oPTgt0PxR9g3xpe5K3VpiQmAqIYiWAbAkw39fj/l2piAZ/6L+/NGEmDBbxGxFjggYqbP
         bmCQ==
X-Gm-Message-State: AOJu0YzW9iGafWPGIERnf9qWGQZtcnlkmLayoS1Eo3gBR78s7pIdBX+x
	bwMoxPe9A+lFv2DrY0n6LDV14BNQfOsteC8JLFFSA5ibxu9J/HpU+eeRtvxtfCk=
X-Google-Smtp-Source: AGHT+IEOHpHHY71HrjZVYQgpPAhNYjF5EWGSC5MhCm06TAFJoW2ZFRHEQhynuEybJSPmW5M318pweA==
X-Received: by 2002:a2e:b90c:0:b0:2cd:56c6:b54f with SMTP id b12-20020a2eb90c000000b002cd56c6b54fmr367252ljb.98.1705579116813;
        Thu, 18 Jan 2024 03:58:36 -0800 (PST)
Received: from u94a (2001-b011-fa04-1220-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:1220:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903004d00b001d45fd7d444sm1249064pla.175.2024.01.18.03.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:58:36 -0800 (PST)
Date: Thu, 18 Jan 2024 19:58:31 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Subject: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
Message-ID: <f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Compilation of lsm_cgroup.c will fail if the vmlinux.h comes from a
kernel that does _not_ have CONFIG_PACKET=y. The reason is that the
definition of struct sockaddr_ll is not present in vmlinux.h and the
compiler will complain that is has an incomplete type.

    CLNG-BPF [test_maps] lsm_cgroup.bpf.o
  progs/lsm_cgroup.c:105:21: error: variable has incomplete type 'struct sockaddr_ll'
    105 |         struct sockaddr_ll sa = {};
        |                            ^
  progs/lsm_cgroup.c:105:9: note: forward declaration of 'struct sockaddr_ll'
    105 |         struct sockaddr_ll sa = {};
        |                ^
  1 error generated.

While including linux/if_packet.h somehow made the compilation works for
me, IIUC this isn't a proper solution because vmlinux.h and kernel
headers should not be used at the same time (and would lead to
redefinition error when the kernel is built with CONFIG_PACKET=y, e.g.
on BPF CI).

What would be the suggested way to work around this?

Thanks,
Shung-Hsi

---
 tools/testing/selftests/bpf/progs/lsm_cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
index 02c11d16b692..5394ec7ae1d8 100644
--- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -2,6 +2,7 @@
 
 #include "vmlinux.h"
 #include "bpf_tracing_net.h"
+#include <linux/if_packet.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>

