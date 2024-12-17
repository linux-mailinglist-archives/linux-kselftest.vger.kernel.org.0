Return-Path: <linux-kselftest+bounces-23442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 638669F4125
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 04:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04FF188C8F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF05213DBB6;
	Tue, 17 Dec 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Ue6n58qX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB3042AAB;
	Tue, 17 Dec 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734405031; cv=none; b=ffHkK/ShUMh836/ennzptKNyesbGCZAXE6OtIcVwxY5vp6Lu2qYdwUPowmyBMOAonfT6MapLMDA0f4cQQ9LCX8P91t9lY83waVEIIzups/wRORSzPqBWq71wMnj4BAHNmlLQH6URDg9YjukjC7Ndg72lDbr9JSyowgRwQTRbe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734405031; c=relaxed/simple;
	bh=M4nC/QuF7h8r8657KRYYOxmcMhWAjFJiZd1ArhA1aNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpKTXsOja/bes+Kn5MlSIcECwZo7XrnrVeKkQOwZZg2GKC4xzzUBbnnEUf69mj77yJWcqP2QvbXUEshk5dGiMtzP7rU/QP1Eg0k8fvkh9NICgn7PyMMtNDpKCnu39LYxk0sgaW3UleHzmZnzqMLpLmY7HBbHVQMPs48QcG3LoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Ue6n58qX; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734405030; x=1765941030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M4nC/QuF7h8r8657KRYYOxmcMhWAjFJiZd1ArhA1aNI=;
  b=Ue6n58qXVJu9Yn8g3c+jia4Tf5Wz+ta2ELIlUb6hAmc/AJQJybGK8MKE
   F/R1fplNYHidAF/wp/EwgL0UVEzVcjw2P/GnnBy3LukoCfHPn3+vqTMgV
   AKh2wGRvirmekF0tdKw2uCRlJ2toz5pytwHFi56MaMfxh62xLv9gi44HO
   JmjHPotB0oqV+j2u0NnLqlBLPa8pbbvCYVxTODjIqCvRyLawYv7g7abuk
   pjmMgqAbYq+2vrfZN+QPiQ1dXqd7Bx9egPd0zvk512qoFgecoiR0uC2Nq
   XjrJDXb+XgU6C3cSLvYksFLUs++MHuDpneRAYu0FR6ohj8YKbkl5tJJWg
   A==;
X-CSE-ConnectionGUID: wlRq4/dxSdGRKTHWWzsyYw==
X-CSE-MsgGUID: dIORant4RV2MitdDOdmglA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="183982002"
X-IronPort-AV: E=Sophos;i="6.12,240,1728918000"; 
   d="scan'208";a="183982002"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 12:10:20 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 482D8D5011;
	Tue, 17 Dec 2024 12:10:18 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 17ED4D5098;
	Tue, 17 Dec 2024 12:10:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E97FE8DE;
	Tue, 17 Dec 2024 12:10:17 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8AC841A000B;
	Tue, 17 Dec 2024 11:10:16 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC] Makefile: Export absolute srctree path for out-of-tree builds
Date: Tue, 17 Dec 2024 11:10:52 +0800
Message-ID: <20241217031052.69744-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28864.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28864.004
X-TMASE-Result: 10--0.633800-10.000000
X-TMASE-MatchedRID: QxNw5Kr7aBeh8NIgadoMHh1kSRHxj+Z5ohrMq0nEhQczyScpZuj/nizy
	bVqWyY2N+SSaqR6S8TQlLmeOTKV2xRlcucGIY/14v8fLAX0P50DNKdtHc3A3XDnP3k+syM8k+jV
	zof0NuiPPQfWquCqW3SLebaXr2O4UlFKRvEp4lzj4c540RssCiaVjgXyvS9c/dE7HIe9l0mw9dx
	qDxQNRxSL637QCIVpiV1uoDPGLPAgfE8yM4pjsDwtuKBGekqUpnH7sbImOEBSlrvbCC0mrLDMDm
	LGIOPRcJ6wy91uaDgtO/9J3JLbpTrF5ko+nSlUw0nnrlhi+scYjuLsNpywqtfar0z1Io/d1yvIH
	coJBdxKbDRBqS2n66yzP5xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Fixes an issue where out-of-tree kselftest builds fail when building
the BPF and bpftools components. The failure occurs because the top-level
Makefile passes a relative srctree path ('..') to its sub-Makefiles, which
leads to errors in locating necessary files.

For example, the following error is encountered:

```
$ make V=1 O=$build/ TARGETS=hid kselftest-all
...
make -C ../tools/testing/selftests all
make[4]: Entering directory '/path/to/linux/tools/testing/selftests/hid'
make  -C /path/to/linux/tools/testing/selftests/../../../tools/lib/bpf OUTPUT=/path/to/linux/O/kselftest/hid/tools/build/libbpf/ \
            EXTRA_CFLAGS='-g -O0'                                      \
            DESTDIR=/path/to/linux/O/kselftest/hid/tools prefix= all install_headers
make[5]: Entering directory '/path/to/linux/tools/lib/bpf'
...
make[5]: Entering directory '/path/to/linux/tools/bpf/bpftool'
Makefile:127: ../tools/build/Makefile.feature: No such file or directory
make[5]: *** No rule to make target '../tools/build/Makefile.feature'.  Stop.
```

To resolve this, the srctree is exported as an absolute path (abs_srctree)
when performing an out-of-tree build. This ensures that all sub-Makefiles
have the correct path to the source tree, preventing directory resolution
errors.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Request for Additional Testing

We welcome all contributors and CI systems to test this change thoroughly.
In theory, this change should not affect in-tree builds. However, to ensure
stability and compatibility, we encourage testing across different
configurations.

What has been tested?
- out-of-tree kernel build
- out-of-tree kselftest-all
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e5b8a8832c0c..36e65806bb5e 100644
--- a/Makefile
+++ b/Makefile
@@ -275,7 +275,8 @@ else ifeq ($(srcroot)/,$(dir $(CURDIR)))
     srcroot := ..
 endif
 
-export srctree := $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
+srctree := $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
+export srctree := $(if $(building_out_of_srctree),$(abs_srctree),$(srctree))
 
 ifdef building_out_of_srctree
 export VPATH := $(srcroot)
-- 
2.44.0


