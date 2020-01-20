Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE52142BA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2020 14:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgATNHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jan 2020 08:07:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28368 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729014AbgATNG4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jan 2020 08:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wv79wcIjCv8Dm7OR7RClFHC2xXjynjMMPfQf2Tr2Fo8=;
        b=Gy3XNz49siJZrfrCjBz40UV+XYzECF7inSjTdR/x4k7kLb0yPpU9YviG4B15R6EkAn+7Ha
        wDQ1zfnk1gjy15UxgYV+TMDATb2cwSKaXlZMyRHS4f6oeZ7O4rjCqK8iXbcUhfU28vHIgh
        eifA32UeQRJrq9g4lFyqpLhN9fgeIcU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-mvqZ1x_INkSzA7zJ1EDqpQ-1; Mon, 20 Jan 2020 08:06:53 -0500
X-MC-Unique: mvqZ1x_INkSzA7zJ1EDqpQ-1
Received: by mail-lf1-f69.google.com with SMTP id n24so6228488lfe.6
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 05:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wv79wcIjCv8Dm7OR7RClFHC2xXjynjMMPfQf2Tr2Fo8=;
        b=OgAdAFTercppf+gKSgCT/dn6ZI9jQwiVsmjwX10ULodabCLl8RuOL/uLGMZ6bnKEoK
         outpyCzuy/J+bQlWaqxARITwasNcRI3SlnZEFhB+YIp7eQq6ch4npRW2tic8g36hwCHq
         cU0kejnNlL33StiMiaDRuolN+2roL4HG7U/spwxlKnAubZIpGem7OVrwQflouYlXFf/V
         TTPY07qXqOxFfi5myc0NMDHaO4SpAcBpGk8JJbrVMO4ngaeeBS9GxQ8cM5ueuyK4vNWi
         P2DV1nx54x6ZPvMkETAnPQ/XMTQvsofzMzYKOPKj6QpZJWOGSQ1jhHPB9AFm35O+ejtn
         hn+A==
X-Gm-Message-State: APjAAAXfe/ZiqIJQGhXQlxBZC7HFEYhoTzMzGlBnF+RamQubvAwYm1g1
        6A4lJfvHb5jEQeT/yzAdnFuijXFSKKRFQYmxbmxQmqwePh6ET8frIzLiY0ezStz+rJ+EtLvK+3S
        ctspFslyIo3RgQkX8JyQF8+vkgDmq
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr13302622lfo.36.1579525611273;
        Mon, 20 Jan 2020 05:06:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3lKSp6vmnKXhkS7MBxMDIrE3fxl7aYt5XVhZML05NVA21j6Pcbn6AOVN/304CbTXP0B4Ogg==
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr13302607lfo.36.1579525610900;
        Mon, 20 Jan 2020 05:06:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h24sm16817656ljl.80.2020.01.20.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:06:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ED27B1804D6; Mon, 20 Jan 2020 14:06:46 +0100 (CET)
Subject: [PATCH bpf-next v5 06/11] bpftool: Use consistent include paths for
 libbpf
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Mon, 20 Jan 2020 14:06:46 +0100
Message-ID: <157952560684.1683545.4765181397974997027.stgit@toke.dk>
In-Reply-To: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
References: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Fix bpftool to include libbpf header files with the bpf/ prefix, to be
consistent with external users of the library. Also ensure that all
includes of exported libbpf header files (those that are exported on 'make
install' of the library) use bracketed includes instead of quoted.

To make sure no new files are introduced that doesn't include the bpf/
prefix in its include, remove tools/lib/bpf from the include path entirely,
and use tools/lib instead.

Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken from selftests dir")
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/bpftool/Documentation/bpftool-gen.rst |    2 +-
 tools/bpf/bpftool/Makefile                      |    2 +-
 tools/bpf/bpftool/btf.c                         |    8 ++++----
 tools/bpf/bpftool/btf_dumper.c                  |    2 +-
 tools/bpf/bpftool/cgroup.c                      |    2 +-
 tools/bpf/bpftool/common.c                      |    4 ++--
 tools/bpf/bpftool/feature.c                     |    4 ++--
 tools/bpf/bpftool/gen.c                         |   10 +++++-----
 tools/bpf/bpftool/jit_disasm.c                  |    2 +-
 tools/bpf/bpftool/main.c                        |    4 ++--
 tools/bpf/bpftool/map.c                         |    4 ++--
 tools/bpf/bpftool/map_perf_ring.c               |    4 ++--
 tools/bpf/bpftool/net.c                         |    8 ++++----
 tools/bpf/bpftool/netlink_dumper.c              |    4 ++--
 tools/bpf/bpftool/perf.c                        |    2 +-
 tools/bpf/bpftool/prog.c                        |    6 +++---
 tools/bpf/bpftool/xlated_dumper.c               |    2 +-
 17 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index 86a87da97d0b..94d91322895a 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -196,7 +196,7 @@ and global variables.
   #define __EXAMPLE_SKEL_H__
 
   #include <stdlib.h>
-  #include <libbpf.h>
+  #include <bpf/libbpf.h>
 
   struct example {
   	struct bpf_object_skeleton *skeleton;
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 39bc6f0f4f0b..c4e810335810 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -45,7 +45,7 @@ CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
 	-I$(srctree)/kernel/bpf/ \
 	-I$(srctree)/tools/include \
 	-I$(srctree)/tools/include/uapi \
-	-I$(srctree)/tools/lib/bpf \
+	-I$(srctree)/tools/lib \
 	-I$(srctree)/tools/perf
 CFLAGS += -DBPFTOOL_VERSION='"$(BPFTOOL_VERSION)"'
 ifneq ($(EXTRA_CFLAGS),)
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 60c75be0666d..4ba90d81b6a1 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -8,15 +8,15 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-#include <bpf.h>
-#include <libbpf.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
 #include <linux/btf.h>
 #include <linux/hashtable.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
 
-#include "btf.h"
 #include "json_writer.h"
 #include "main.h"
 
@@ -532,7 +532,7 @@ static int do_dump(int argc, char **argv)
 		if (IS_ERR(btf)) {
 			err = PTR_ERR(btf);
 			btf = NULL;
-			p_err("failed to load BTF from %s: %s", 
+			p_err("failed to load BTF from %s: %s",
 			      *argv, strerror(err));
 			goto done;
 		}
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index d66131f69689..eb4a142016a0 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -8,8 +8,8 @@
 #include <linux/bitops.h>
 #include <linux/btf.h>
 #include <linux/err.h>
+#include <bpf/btf.h>
 
-#include "btf.h"
 #include "json_writer.h"
 #include "main.h"
 
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 2f017caa678d..62c6a1d7cd18 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -14,7 +14,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 #include "main.h"
 
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 88264abaa738..b75b8ec5469c 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -20,8 +20,8 @@
 #include <sys/stat.h>
 #include <sys/vfs.h>
 
-#include <bpf.h>
-#include <libbpf.h> /* libbpf_num_possible_cpus */
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
 
 #include "main.h"
 
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 94735d968c34..446ba891f1e2 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -12,8 +12,8 @@
 #include <linux/filter.h>
 #include <linux/limits.h>
 
-#include <bpf.h>
-#include <libbpf.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 #include <zlib.h>
 
 #include "main.h"
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 7ce09a9a6999..f8113b3646f5 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -12,15 +12,15 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-#include <bpf.h>
-#include <libbpf.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <unistd.h>
+#include <bpf/btf.h>
 
-#include "btf.h"
-#include "libbpf_internal.h"
+#include "bpf/libbpf_internal.h"
 #include "json_writer.h"
 #include "main.h"
 
@@ -333,7 +333,7 @@ static int do_skeleton(int argc, char **argv)
 		#define %2$s						    \n\
 									    \n\
 		#include <stdlib.h>					    \n\
-		#include <libbpf.h>					    \n\
+		#include <bpf/libbpf.h>					    \n\
 									    \n\
 		struct %1$s {						    \n\
 			struct bpf_object_skeleton *skeleton;		    \n\
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index bfed711258ce..f7f5885aa3ba 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -24,7 +24,7 @@
 #include <dis-asm.h>
 #include <sys/stat.h>
 #include <limits.h>
-#include <libbpf.h>
+#include <bpf/libbpf.h>
 
 #include "json_writer.h"
 #include "main.h"
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 1fe91c558508..6d41bbfc6459 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -9,8 +9,8 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include <bpf.h>
-#include <libbpf.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 
 #include "main.h"
 
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 86f8ab0b7e63..e6c85680b34d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -15,9 +15,9 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
-#include <bpf.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
 
-#include "btf.h"
 #include "json_writer.h"
 #include "main.h"
 
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index 4c5531d1a450..d9b29c17fbb8 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -6,7 +6,7 @@
  */
 #include <errno.h>
 #include <fcntl.h>
-#include <libbpf.h>
+#include <bpf/libbpf.h>
 #include <poll.h>
 #include <signal.h>
 #include <stdbool.h>
@@ -21,7 +21,7 @@
 #include <sys/mman.h>
 #include <sys/syscall.h>
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 #include <perf-sys.h>
 
 #include "main.h"
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index d93bee298e54..c5e3895b7c8b 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -7,7 +7,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <libbpf.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 #include <net/if.h>
 #include <linux/if.h>
 #include <linux/rtnetlink.h>
@@ -16,9 +17,8 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
-#include <bpf.h>
-#include <nlattr.h>
-#include "libbpf_internal.h"
+#include "bpf/nlattr.h"
+#include "bpf/libbpf_internal.h"
 #include "main.h"
 #include "netlink_dumper.h"
 
diff --git a/tools/bpf/bpftool/netlink_dumper.c b/tools/bpf/bpftool/netlink_dumper.c
index 550a0f537eed..5f65140b003b 100644
--- a/tools/bpf/bpftool/netlink_dumper.c
+++ b/tools/bpf/bpftool/netlink_dumper.c
@@ -3,11 +3,11 @@
 
 #include <stdlib.h>
 #include <string.h>
-#include <libbpf.h>
+#include <bpf/libbpf.h>
 #include <linux/rtnetlink.h>
 #include <linux/tc_act/tc_bpf.h>
 
-#include <nlattr.h>
+#include "bpf/nlattr.h"
 #include "main.h"
 #include "netlink_dumper.h"
 
diff --git a/tools/bpf/bpftool/perf.c b/tools/bpf/bpftool/perf.c
index b2046f33e23f..3341aa14acda 100644
--- a/tools/bpf/bpftool/perf.c
+++ b/tools/bpf/bpftool/perf.c
@@ -13,7 +13,7 @@
 #include <unistd.h>
 #include <ftw.h>
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 #include "main.h"
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 47a61ac42dc0..a3521deca869 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -17,9 +17,9 @@
 #include <linux/err.h>
 #include <linux/sizes.h>
 
-#include <bpf.h>
-#include <btf.h>
-#include <libbpf.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
 
 #include "cfg.h"
 #include "main.h"
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 5b91ee65a080..8608cd68cdd0 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -7,7 +7,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/types.h>
-#include <libbpf.h>
+#include <bpf/libbpf.h>
 
 #include "disasm.h"
 #include "json_writer.h"

