Return-Path: <linux-kselftest+bounces-23495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA69F6419
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 11:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE4D7A38E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86381B4227;
	Wed, 18 Dec 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WKf4BDVf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C11ACEC5;
	Wed, 18 Dec 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519268; cv=none; b=G6HBXUoMo7Zb6TZEwBarhAtw+qnr1ovhHlCifj+MD4HM4bWyiKL5MMxkGkrlOhLSg9C3IFnoRAaj56qbx+42SQnOZfO0Chju0WjBmA8+rED7FJFCgUht+XgIONWeEJxHVOtcX1kH8Fv50wS/IN/w+eqGGOI+caUJzr9j/1XfBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519268; c=relaxed/simple;
	bh=9cD/qRaX+N/PM5TkKF7XPWCDKrNFi+a4Ia2jzBM4qLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJJPxZYlB7Qq+6BVoUeogjQifVmxkPuq+ojdxN80zU2VOpy/Lfo4BTXWcWVOWfUztGfzr/xaRdN3cJnzRRKQtMLWVpZhctK6PuJ/qlDBBXzgU1OzQO5XZ9thsKtz/uExncZ8YAJme9WwBB/iN+Drq8AaFzyBroRgo1+lR9SCVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WKf4BDVf; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=mqEOq
	80EgXPg5j44EKuiTiSK93GjhC/NcrgmRSuMMy4=; b=WKf4BDVfpGMzyec56NMMV
	LtuxLsXDr7JhwrBTwLu5zFGJEYYsR0ON2L0PqNi9IFWPRifiMWl/X5ZiB1Ij5oRh
	HdJl+MYbTQ4flkEUnOYtva1biIgFS0B3rapxxhiiQYBmdOvend7yiVGJVN/8db9p
	tDGq+fbMs0lTvqoCNaRHxg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wB396t5qWJnjyoDAA--.461S2;
	Wed, 18 Dec 2024 18:52:50 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf-next v1] selftests/bpf: avoid generating untracked files when running bpf selftests
Date: Wed, 18 Dec 2024 18:52:20 +0800
Message-ID: <20241218105220.855128-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB396t5qWJnjyoDAA--.461S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw17Cry7Xw13AryDAFWfAFb_yoW5JFy7p3
	yrJw1jkrZaqFWUt3Z7ZrW3ur1rJr4DZFW0va1UZryDZwn8JFykWF4IyFy5Za43urZYqrZI
	v3yIgF9xAFW8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_dgA7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDxa5p2dinVv9AwAAs6

Currently, when we run the BPF selftests with the following command:

'make -C tools/testing/selftests TARGETS=bpf SKIP_TARGETS=""'

The command generates untracked files and directories:
'''
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	tools/testing/selftests/bpfFEATURE-DUMP.selftests
	tools/testing/selftests/bpffeature/
'''

The core reason is our Makefile(tools/testing/selftests/bpf/Makefile)
was written like this:
'''
OUTPUT := $(OUTPUT)/
$(eval include ../../../build/Makefile.feature)
OUTPUT := $(patsubst %/,%,$(OUTPUT))
'''

This way of assigning values to OUTPUT will never be effective for the
variable OUTPUT provided via the command argument and sub makefile called
like this(tools/testing/selftests/Makefile):
'''
all:
    ...
	$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET
'''

As stated in the GNU make documentation:
'''
An argument that contains '=' specifies the value of a variable: 'v=x'
sets the value of the variable v to x. If you specify a value in this way,
all ordinary assignments of the same variable in the makefile are ignored;
we say they have been overridden by the command line argument.
'''

According to GNU make, we use override Directive to fix this issue:
'''
If you want to set the variable in the makefile even though it was set
with a command argument, you can use an override directive, which is a
line that looks like this:
override variable := value

Link: https://www.gnu.org/software/make/manual/make.html#Override-Directive
Fixes: dc3a8804d790 ("selftests/bpf: Adapt OUTPUT appending logic to lower versions of Make")

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9e870e519c30..eb4d21651aa7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -202,9 +202,9 @@ ifeq ($(shell expr $(MAKE_VERSION) \>= 4.4), 1)
 $(let OUTPUT,$(OUTPUT)/,\
 	$(eval include ../../../build/Makefile.feature))
 else
-OUTPUT := $(OUTPUT)/
+override OUTPUT := $(OUTPUT)/
 $(eval include ../../../build/Makefile.feature)
-OUTPUT := $(patsubst %/,%,$(OUTPUT))
+override OUTPUT := $(patsubst %/,%,$(OUTPUT))
 endif
 endif
 

base-commit: a7c205120d339b6ad2557fe3f33fdf20394f1a0f
-- 
2.43.5


