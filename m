Return-Path: <linux-kselftest+bounces-7461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C270189D0EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1AA1F25720
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC86A8AE;
	Tue,  9 Apr 2024 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/j0IdO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700FA6A00B;
	Tue,  9 Apr 2024 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632619; cv=none; b=N4Lf8Ko+s/0cNByDFN0KMLc3WOixo0gQ6xWZYyLuyOpLBFo7IHDD2RDG7bKfTZqSfzuPBxI1yra1LBRWFe1etRYs6njjVnClq+EO1CzzeYkM18w7XIzG+an0e8g5+s4N3GYsvydag8WUMx9sM3HiygqdrU+BPNKWMLWN83AC/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632619; c=relaxed/simple;
	bh=b9pGv5qifj9nfMAOHGw9amG7xO4utK1lJIFTulXjYR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI18OO/KNbKiT83Dlr1UD3fxiNYKEyCUifaLOkoZSBqMOdSOCq+xfEsHPshPqNVSHOeSTRdrNPtV9fZjcGu5B15nAPS0qAlCtuLcgL7y+IPSYZkJPUNVTCiffToRL09TZE43rJU9KQ1c4PwWbvOe2cKZhlaf/ZpXEZ4hgtWSzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/j0IdO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87878C433C7;
	Tue,  9 Apr 2024 03:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712632619;
	bh=b9pGv5qifj9nfMAOHGw9amG7xO4utK1lJIFTulXjYR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/j0IdO/MgWcKlOVjOtRrHSkxhyhpNlRdEQIx5hfU7KmQJ90W4N7671FSPEExwPB8
	 BSzyrHCbtU75+iZBZkZ94WJBdN4QSRXShUoCYJDX3Xvao+p0bE282J5gj6oxUERnXv
	 PUY+qJ2DgLKRjs1hqzKkDOzMzflO9w8tAlb3va+tLu5cX7y32td2fzQ80EME/wPPon
	 bcDgXf9fcUlcnczlEnBgkA0zlRGaPuoOIsNduI6nBJOe5cmBLgs+fm8QjznhDRJo+G
	 9EinsbGRQVq0J3VTrefwwSl4m0ZEAo/aaPoBCKxBqRelII4OGy1CxetxVef9W18tCc
	 vDJlLV11tWLIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	mykolal@fb.com,
	eddyz87@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] selftests: net: declare section names for bpf_offload
Date: Mon,  8 Apr 2024 20:15:48 -0700
Message-ID: <20240409031549.3531084-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409031549.3531084-1-kuba@kernel.org>
References: <20240409031549.3531084-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-ancient ip (iproute2-5.15.0, libbpf 0.7.0) refuses to load
the sample with maps because we don't generate BTF:

   libbpf: BTF is required, but is missing or corrupted.
   ERROR: opening BPF object file failed

Enable BTF by adding -g to clang flags. With that done
neither of the programs load:

  libbpf: prog 'func': error relocating .BTF.ext function info: -22
  libbpf: prog 'func': failed to relocate calls: -22
  libbpf: failed to load object 'ksft-net-drv/net/sample_ret0.bpf.o'

Andrii explains that this is because we don't specify
section names for the code. Add the section names, too.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/Makefile              | 3 ++-
 tools/testing/selftests/net/bpf_offload.py        | 2 +-
 tools/testing/selftests/net/sample_map_ret0.bpf.c | 2 +-
 tools/testing/selftests/net/sample_ret0.bpf.c     | 3 +++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index e8bfa715aa49..a3c781cb8367 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -149,7 +149,8 @@ BPF_PROG_OBJS := $(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o \
 	$(OUTPUT)/sample_map_ret0.bpf.o $(OUTPUT)/sample_ret0.bpf.o
 
 $(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
-	$(CLANG) -O2 --target=bpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) -o $@
+	$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
+	-c $< -o $@
 
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   $(APIDIR)/linux/bpf.h					       \
diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index 174dba1a48d3..76b53ac2c8c6 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -237,7 +237,7 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
 def ethtool(dev, opt, args, fail=True):
     return cmd("ethtool %s %s %s" % (opt, dev["ifname"], args), fail=fail)
 
-def bpf_obj(name, sec=".text", path=bpf_test_dir,):
+def bpf_obj(name, sec="xdp", path=bpf_test_dir,):
     return "obj %s sec %s" % (os.path.join(path, name), sec)
 
 def bpf_pinned(name):
diff --git a/tools/testing/selftests/net/sample_map_ret0.bpf.c b/tools/testing/selftests/net/sample_map_ret0.bpf.c
index 495990d355ef..43ca92594926 100644
--- a/tools/testing/selftests/net/sample_map_ret0.bpf.c
+++ b/tools/testing/selftests/net/sample_map_ret0.bpf.c
@@ -17,7 +17,7 @@ struct {
 } array SEC(".maps");
 
 /* Sample program which should always load for testing control paths. */
-SEC(".text") int func()
+SEC("xdp") int func()
 {
 	__u64 key64 = 0;
 	__u32 key = 0;
diff --git a/tools/testing/selftests/net/sample_ret0.bpf.c b/tools/testing/selftests/net/sample_ret0.bpf.c
index fec99750d6ea..1df5ca98bb65 100644
--- a/tools/testing/selftests/net/sample_ret0.bpf.c
+++ b/tools/testing/selftests/net/sample_ret0.bpf.c
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
 
+#define SEC(name) __attribute__((section(name), used))
+
 /* Sample program which should always load for testing control paths. */
+SEC("xdp")
 int func()
 {
 	return 0;
-- 
2.44.0


