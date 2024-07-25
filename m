Return-Path: <linux-kselftest+bounces-14220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE90393C016
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54F6282F6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DED1990BE;
	Thu, 25 Jul 2024 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo5aYEqd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C8198E80;
	Thu, 25 Jul 2024 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903970; cv=none; b=g+Baa8fL7+eEkBcnj1HciRh5O3nhl8n03qAN53ro1HkohgFP9d1K54pnqkOLjlc8LfVkQ9PYjF8g4omeoWwWO4V7OD8KNAIDuuE2t/sMfBkzhJ+6VKP9Bz1H6AHIQ0TcrouJvAPLVTQ+s/ATTOgaHFkGNojpPs3JseOCl+NnSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903970; c=relaxed/simple;
	bh=39nKO2W4H+sgYTYoUr8Abgv9UryPtz4B2rZa5OoJ8Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdztwnyXU3Xf1V6kf1zRf8Rm9ibh2XucB9If3txfNtwinzEnv7xhDhzMgJigL9KYIJ03IyDPQPmFAY2NQ7s2nG02+Ni9zHCzsi+Yw0vCvslnpIfOWBdkUwN1bw7dtedcuz7K9zqbho6JGF7miJsEsWByGeYnlR4MvD8pPljXCWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uo5aYEqd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso4429115ad.2;
        Thu, 25 Jul 2024 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903968; x=1722508768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL0sjHyHqIUzlhJaqk3CKYqlb9x5c6RFGvSzNLbJ438=;
        b=Uo5aYEqdu91tGiWYe/pturskjKsSRYnw9ZS2bKsS8HwXjj6wOgCCvKI0s9Dgmf0CDE
         s+ErM4C6+MYdIwvbpWmdkgOW+gTb4PCIDuUpYft7cXTLhLWZu0cb/lvBM1cSdWy9H5hg
         9rzbo6/vFEluuzMgVeS1xiKq+0ZjR2XwyKkICzwVMfKj4qc+VIQu9Z+GaOze3N0roumL
         5BrpZ1EKspeuwtB5j0oCyY8BvlE7x9NGqXkMGbvZIIjG6KEPN1eXfV6qyAkwqz0YzwiZ
         uYqDk7NvtiKhAkLadpeUt1QvaW6Uz8RZD0V2OAdMNQ/q5o71EzkZdDqJiLSxgiO/SRsB
         mQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903968; x=1722508768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL0sjHyHqIUzlhJaqk3CKYqlb9x5c6RFGvSzNLbJ438=;
        b=orKApl5Y/QteUOoAV2Y0c08HgsGD6RCkc2ZlBRuTEVHjICJu1uNKCF40LEm/HDTfyJ
         F0Ugrl9v9LY1IIkzvAlnzPjR5uUoi8TfomWEjv1iBN46cSREc9oe7EkPENruoPegTvyD
         7SnZub3K0cp+thlacrje7MnhGnF5+JDDgMIy5oie2l3E81p7Opno8ncSVFQgePvojw9G
         rAxGtRw2/FlXhtopHfLs9wP2/oWbsmwSnihK3BowiESm/9TwRDqa1IwvNksxD7sIb8Vn
         HS/vrVus40i7N/XkBmivp8pVbzQIBoUVQya4QkYssXRXJ8OYMUeNbkdB6EDHj2pEA+8B
         1HAA==
X-Forwarded-Encrypted: i=1; AJvYcCX98N3Bg6ua7ADTwLVC6hSMCI8WbsuwljV67H9uXQKegBhdjp6AS86M17uujWPg9UBx6RDLemnnSkTneAb5yIsg80nRuFVg9ajmGtL/5VuXqtKKsdRLk8WXoiNHJvsXOmgU1jTvNR3U
X-Gm-Message-State: AOJu0YxJg9aay9AulHgpIVRCYUisKrGNe/Cvh3ihOBkLd0SasC7v2fh0
	p/lILbh6ZdrXmOk+bWv4yuy39Ee0ZvGE6id4qSeTo8fz5Qdo4Ou4cakKuONx
X-Google-Smtp-Source: AGHT+IHOuWQPI4ziMbe1Qd8cyoyl2rI6CGk7S+SEEfxlimmcwkOKjax3YOSjrNCYy9tu0W+ThQHmyw==
X-Received: by 2002:a17:902:dace:b0:1fb:1cc3:646d with SMTP id d9443c01a7336-1fed9284dbcmr14989155ad.29.1721903968280;
        Thu, 25 Jul 2024 03:39:28 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f78491sm10991075ad.244.2024.07.25.03.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:39:28 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
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
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v1 5/8] selftests/bpf: Fix order-of-include compile errors in lwt_reroute.c
Date: Thu, 25 Jul 2024 03:35:57 -0700
Message-Id: <b57266bcc9f47ffda1fc5e55933afbf2c1ce1d58.1721903630.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721903630.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Fix redefinition errors seen compiling lwt_reroute.c for mips64el/musl-libc
by adjusting the order of includes in lwt_helpers.h. The ordering required
is:
<net/if.h>  -->  <arpa/inet.h> (from "test_progs.h")  -->  <linux/icmp.h>.

Because of the complexity and large number of includes, ordering appears to
be fragile however. Previously, with "test_progs.h" at the end of this
sequence, compiling with GCC 12.3 for mips64el/musl-libc yields errors:

In file included from .../include/arpa/inet.h:9,
                 from ./test_progs.h:18,
                 from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:11,
                 from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
.../include/netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
   23 | struct in6_addr {
      |        ^~~~~~~~
In file included from .../include/linux/icmp.h:24,
                 from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:9:
.../include/linux/in6.h:33:8: note: originally defined here
   33 | struct in6_addr {
      |        ^~~~~~~~
.../include/netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in6'
   34 | struct sockaddr_in6 {
      |        ^~~~~~~~~~~~
.../include/linux/in6.h:50:8: note: originally defined here
   50 | struct sockaddr_in6 {
      |        ^~~~~~~~~~~~
.../include/netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
   42 | struct ipv6_mreq {
      |        ^~~~~~~~~
.../include/linux/in6.h:60:8: note: originally defined here
   60 | struct ipv6_mreq {
      |        ^~~~~~~~~

Similarly, with "test_progs.h" at the beginning of this sequence, compiling
with GCC 12.3 for x86_64 using glibc would fail like this:

In file included from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:8,
                 from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
/usr/include/linux/if.h:83:9: error: redeclaration of enumerator ‘IFF_UP’
   83 |         IFF_UP                          = 1<<0,  /* sysfs */
      |         ^~~~~~
/usr/include/net/if.h:44:5: note: previous definition of ‘IFF_UP’ with type ‘enum <anonymous>’
   44 |     IFF_UP = 0x1,               /* Interface is up.  */
      |     ^~~~~~
/usr/include/linux/if.h:84:9: error: redeclaration of enumerator ‘IFF_BROADCAST’
   84 |         IFF_BROADCAST                   = 1<<1,  /* __volatile__ */
      |         ^~~~~~~~~~~~~
/usr/include/net/if.h:46:5: note: previous definition of ‘IFF_BROADCAST’ with type ‘enum <anonymous>’
   46 |     IFF_BROADCAST = 0x2,        /* Broadcast address valid.  */
      |     ^~~~~~~~~~~~~

...

In file included from /usr/include/linux/icmp.h:23,
                 from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:10,
                 from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
/usr/include/linux/if.h:194:8: error: redefinition of ‘struct ifmap’
  194 | struct ifmap {
      |        ^~~~~
In file included from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:8,
                 from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
/usr/include/net/if.h:111:8: note: originally defined here
  111 | struct ifmap
      |        ^~~~~
In file included from /usr/include/linux/icmp.h:23,
                 from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:10,
                 from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
/usr/include/linux/if.h:232:8: error: redefinition of ‘struct ifreq’
  232 | struct ifreq {
      |        ^~~~~
In file included from tools/testing/selftests/bpf/prog_tests/lwt_helpers.h:8,
                 from tools/testing/selftests/bpf/prog_tests/lwt_reroute.c:52:
/usr/include/net/if.h:126:8: note: originally defined here
  126 | struct ifreq
      |        ^~~~~

Fixes: 43a7c3ef8a15 ("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/lwt_helpers.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
index fb1eb8c67361..8e5e28af03c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
@@ -6,10 +6,9 @@
 #include <time.h>
 #include <net/if.h>
 #include <linux/if_tun.h>
+#include "test_progs.h" /* between <net/if.h> and <linux/icmp.h> or errors */
 #include <linux/icmp.h>
 
-#include "test_progs.h"
-
 #define log_err(MSG, ...) \
 	fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
 		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
-- 
2.34.1


